
;;; Purpose: Pages displayed only at NIST, on the local server, for use with the 
;;;          mapping tools and other 'pre-production' stuff.

(in-package :developers)

(defun devl-restore-defaults-dsp ()
  "Reset the models shown to those you get at system start."
    (with-vo (session-models models) (setf session-models models))
    (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) "/developers")))

(defun url-remove-model (m)
  "URL for developer pages removal of a model." 
  (format nil "<a href='~A/developers/remove-model?model=~A'>Remove</a>"
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (mofb:encode-for-url m)))

;;; /scm/tools/developers
(defun developers-dsp ()
  "Toplevel. Displays the 'developer page'."
  (app-page-wrapper :cre (:view "Developers' Pages"
				:menu-pos '(:root :tools))
    (:h1 "Developers' Pages")
    "From the menu items here you can load files containing models and populations conforming 
     to a loaded model, and you can map populations from one model to another using a QVT mapping
     (which is itself loaded using 'Load Populations / QVT' since such files are themselves a 
     population conforming to a model, the QVT metamodel)."
    (:h3 "Available models and populations: ")
    (:a :href (strcat (app-url-prefix (find-http-app (safe-app-name)))
		      "/developers/restore-defaults") "Restore Defaults")
    (:ul (str 
	  (with-vo (session-models)
	    (apply #'concatenate
		   'string
		   (mapcar 
		    #'(lambda (m) (format nil "<li>~A - ~A</li>" 
 					  (mofb:url-mof-model m)
					  (url-remove-model m)))
		    session-models)))))))

;;; http://syseng.nist.gov/se-interop/developers/remove-mode?model=whatever
(defun devl-remove-model-dsp ()
  (when-bind (model (mofb:decode-for-url (safe-get-parameter "model")))
    (with-vo (session-models)
      (setf session-models (remove model session-models))
      (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) "/developers")))))

(defmacro add-model/pop-mac (action &rest more-args)
  "Messy stuff used in loading models and populations."
  `(when-bind (post-map-data (safe-post-parameter "file"))
    (when-bind (model-name (safe-post-parameter "model-name"))
      (unless (session-value 'session-vo)
	(start-session)
	(setf (session-value 'session-vo)
	      (setf *spare-session-vo*
		    (make-instance 
		     (session-vo-class)
		     :models (session-models *spare-session-vo*)
		     :tbnl-session tbnl:*session*))))
      (dbind (in-path in-file &rest ignore) post-map-data 
	(declare (ignore ignore))
	;; strip directory info sent by Windows browsers
	(when (search "Windows" (user-agent) :test #'char-equal)
	  (setq in-file (cl-ppcre:regex-replace ".*\\\\" in-file "")))
	(let ((new-path (make-pathname :name (pathname-name in-file) 
				       :type (pathname-type in-file)
				       :defaults tbnl:*tmp-directory*)))
	  ;; Everything comes in as <tbnl:*tmp-directory>/hunchentoot-<n> I rename it.
	  (rename-file in-path (ensure-directories-exist new-path))
	  (,action model-name new-path ,@more-args))
	;; I'm using *results*, not vo.mut, which on early errors won't be set.
	(if (zerop (fill-pointer (mofi::conditions *results*)))
	    ;; MIWG sent this elsewhere. Is this OK? 
	    (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) "/developers")) 
	    (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) "/developers/parse-errors")))))))

#+nil
(defun devl-js-post-dsp ()
  (setf *zippy* *request*)
  (when-bind (post-data (safe-post-parameter "firstName")) ;; I've been using :name JS example uses :id
    (app-page-wrapper :cre (:view "Developers' Pages"
				  :menu-pos '(:root :tools))
      (:h1 "Result")
      (str post-data))))


;;; http://syseng.nist.gov/se-interop/developers/load-models
(defun devl-load-models-dsp ()
  (app-page-wrapper :cre (:view "Developers' Pages"
				:menu-pos '(:root :miwg :tools :sysml :load-models))
    (:h1 "Load Models")
    (:p) "From this page you can load XMI containing CMOF::Class or UML::Class objects 
          and associated properties and constraints. This tool will establish class definitions
          on which you can subsequently define populations. Note that the implementation of this 
          capability is still a rough prototype, owing mostly to the difficulty of accommodating 
          the various ways Classes et al might be XMI-encoded in CMOF and UML."
    (:h3 "Available models and populations: ")
    (:ul (str 
	  (with-vo (session-models)
	    (apply #'concatenate
		   'string
		   (mapcar 
		    #'(lambda (m) (format nil "<li>~A</li>" (mofb:url-mof-model m)))
		    session-models)))))
    (:p) "Upload a model (unzipped XMI)."
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 10
		   :bgcolor "#FDFDD8"
		   (:tr (:td "Model Name: ") 
			(:td (:input :type "text" :name "model-name")) 
			(:td (:input :type :radio :name "cmof-p" :value "UML" :checked) "UML" (:br)
			     (:input :type :radio :name "cmof-p" :value "CMOF") "CMOF"))
		   (:tr (:td "File: ")
			(:td (:input :type :file :name "file")))
		   (:tr (:td :colspan 2 :align "center" (:input :type :submit :value "Upload Model")))))
    (let ((cmof-p (string= "CMOF" (safe-post-parameter "cmof-p"))))
      (add-model/pop-mac developer-handle-model-file cmof-p))))


(defun developer-handle-model-file (model-name file-path cmof-p)
  "Move the file from IN-PATH, (where the server placed it) to a place managed by us.
   Call process-uml/qvt-file2model with the file."
  #+cre.exe(log-message :info "developer-handle-file called from IP address ~A" (header-in "remote-ip-addr"))
  (mofi:results-handler-bind (developer-handle-model-file)
    (case (usr-bin-file file-path)
      (:xml ;;This is for model.
       (let ((classes-path (make-pathname :name model-name
					  :type "lisp"
					  :defaults tbnl:*tmp-directory*)))
	 ;; Write the model...
	 (if cmof-p
	     (mofi:process-cmof :model model-name file-path :classes-path classes-path)
	     (mofi:process-uml model-name file-path :classes-path classes-path))
	 (with-vo (session-models)
	   (let ((user-model (mofi:ensure-model model-name :force t  :model-class 'mofi:compiled-model 
						:classes-path classes-path)))
	     (setf session-models
		   (remove (mofi:model-name user-model) session-models 
			   :test #'string= :key #'mofi:model-name))
	     (push user-model session-models)))))
      (t (error "The file supplied does not look like XML nor QVT."))))
    (values))

;;; http://syseng.nist.gov/se-interop/developers/load-populations
(defun devl-load-pops-dsp ()
  (app-page-wrapper :cre (:view "Developers' Pages"
				:menu-pos '(:root :tools :load-pops))
    (:h1 "Load Populations")
    (:p) "From this page you can load XMI or QVT relational syntax containing a population
          conforming to a loaded model."
    (:ul (str 
	  (with-vo (session-models)
	    (apply #'concatenate
		   'string
		   (mapcar 
		    #'(lambda (m) (format nil "<li>~A</li>" (mofb:url-mof-model m)))
		    session-models)))))
    (:p) "Upload a population (unzipped XMI or QVT). <strong>Note:</strong> If the population
          defines a QVT mapping, the Name provided below must match one specified in the QVT 'Transformation'
          language element." ; POD Fix this!
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 10
		   :bgcolor "#FDFDD8"
		   (:tr (:td "Name: ") 
			(:td (:input :type "text" :name "model-name")) ; macro wants "model-name"
			(:td "Of Model:")
			(:td (:select :name "model-n+1" 
				      (str (with-vo (session-models)
					     (apply #'concatenate
						    'string
						    (mapcar
						     #'(lambda (m) (format nil "<option>~A</option>" 
									   (string (mofi:model-name m))))
						     (remove-if 
						      #'(lambda (x) (typep x 'mofi:population))
						      (remove (mofi:find-model :OCL)
							      (remove (mofi:find-model :mof :error-p nil)
								      session-models))))))))))
		   (:tr (:td "File: ")
			(:td (:input :type :file :name "file"))) ; macro wants "file"
		   (:tr (:td :colspan 4 :align "center" (:input :type :submit :value "Upload Population")))))
    (when-bind (model-n+1 (mofi:find-model (safe-post-parameter "model-n+1") :error-p nil))
      (add-model/pop-mac developer-handle-pop-file model-n+1))))

#+qvt
(defun developer-handle-pop-file (model-name file-path model-n+1)
  "Call qvt-file2model or xmi2model-instance with the file (FILE-PATH) creating
   a population of MODEL-N+1."
  (declare (ignore model-name)) ; POD Investigate
  #+cre.exe(log-message :info "developer-handle-file called from IP address ~A" (header-in "remote-ip-addr"))
  (setf *results* (make-instance 'processing-results))
  (mofi:results-handler-bind (developer-handle-pop-file)
    (with-vo (session-models mut)
      (when-bind (population
		  (cond ((eql (mofi:find-model "QVT") model-n+1)
			 (qvt:qvt-file2model :source-file file-path))
			(t (mofi:xmi2model-instance :file file-path :model-n+1 model-n+1))))
	(setf session-models
	      (remove (mofi:model-name population) session-models 
		      :test #'string= :key #'mofi:model-name))
	(push population session-models)
	(setf mut population))))
  (values))

#+qvt
(defun devl-parse-errors-dsp ()
  "Reports errors from parsing, then allows you to go back to the developers page."
  (app-page-wrapper :cre (:view "Developers' Pages"
				:menu-pos '(:root :tools))
    (:h1 "Exceptional conditions while processing")
    (htm 
     (:ul
      (loop for c across (mofi::conditions *results*) do
	   (htm (:li 
		 (typecase c
		   ((or qvt:qvt-parse-error ocl:ocl-parse-error)
		    (fmt "~A" c))
		   (pod-utils:parse-token-error
		    (with-slots (pod::tag pod::tags pod::expected pod::actual pod::line-number) c
			(fmt "~A (line ~A) : expected '~A' read '~A'" 
			     pod::tag pod::line-number pod::expected pod::actual)
			(when pod::tags (fmt "<br/><br/><strong/>Parse stack:</strong><br/> ~{~A<br/>~}" 
					     pod::tags))))
		   (otherwise
		    (fmt "~A" (cl-who:escape-string (format nil  "~A" c))))))))))))
      
;;; http://syseng.nist.gov/se-interop/developers/browse-model?model=MOSScm
#+moss?
(defun mof-browser-dsp ()
  "Toplevel. Displays the list of classes in a model."
  (when-bind (model-arg (safe-get-parameter "model"))
    (when-bind (model (mofb:decode-for-url model-arg))
      (let ((name (string (mofi:model-name model))))
	(app-page-wrapper :cre (:view (format nil "SCM: Model ~A" name) ; pod nice was fmt
				      :menu-pos '(:root :tools)
				      :leaf (safe-leaf (elip name)))
	  (if (typep model 'mofi:population)
	      (htm ; object browser
	       (:h1 (fmt "Object Browser - ~A" (mofi:model-name model)))
	       (str (format nil "Suggested starting places on population ~A:<p/>" 
			    (mofi:model-name model)))
	       (str 
		(cond ((member (mofi:model-name (mofi:model-n+1 model))
			       '(:deljit :desadv :invoic :x12-204 :iftmin :iftmcs
				 :x12-309 :iftman :iftsta))
		       (if-bind (msg (loop for obj across (mofi:members model)
					   when (typep obj 'edi:|MessageContainer|)
					   do (return obj)))
				(mofb:url-object-browser msg)
				"No objects found"))
		      #+mmm
		      ((and (typep model 'mofi:population)
			    (eql (mofi:model-n+1 model) (mofi:find-model :mmm)))
		       (loop for show in 
			     (cons
			      (find (find-class 'mmm:|RepositorySet|) (mofi:members model) :key #'class-of)
			      (loop for obj across (mofi:members model)
				    when (typep obj 'mmm:|Configuration|) collect obj))
			     with result = "" do 
			     (strcat* result (mofb:url-object-browser show) "<br/>")
			     finally (return result)))
		      (t
		       (loop for obj across (mofi:members model)
			     with result = "" do
			     (strcat* result (mofb:url-object-browser obj) "<br/>")
			     finally (return result))))))
	      (htm ; class browser
		(:h1 (fmt "Type Browser - ~A" (mofi:model-name model)))
		(str (format nil "Classes, data types, primitives and enumerations of the model ~A:<p/>" 
			     (mofi:model-name model)))
		(htm
		 ;(push (equiv-classes (mofi:types model) :key #'mofi:model-package) *zippy*)
		 (loop for package in (equiv-classes (mofi:types model) :key #'mofi:model-package) do
		       (htm (:h3 (str (if-bind (name (mofi:model-package (car package)))
					       (format nil "Package ~{~A~^::~}"	(mklist name))
					       (format nil "Model ~A" (mofi:model-name model)))))
			    (str
			     (loop for class in (sort package #'string< :key #'class-name)
				   with result = "" do
				   (strcat* result (mofb:url-class-browser class) "<br/>")
				   finally (return result)))))))))))))

;;;======================================
;;; Running QVT
;;;======================================
#+qvt
(defun qvt-map-dsp ()
  "Toplevel. Displays the 'developer page' for mapping models."
  (app-page-wrapper :cre (:view "Developers' Pages"
				:menu-pos '(:root :tools :qvt))
    (:h1 "QVT Mapping")
    "From here you can select source and target models for mapping, and name the output model, 
     and do the mapping -- resulting in another 'available model.'
     <p/>Note that in order to map from a QVT mapping specification file, the models named by it must appear
     in the 'Available models' list. If the pull-down list for 'Source Model' or 'Target Model'
     doesn't list a model you expect it to contain, you probably didn't name a model correctly
     (either in loading it, or in the 'transformation' language element of the QVT 
     mapping specification file)."
    (:h4 "Available models:")
    (with-vo (session-models)
      (let* ((qvt-specs (remove-if-not #'(lambda (m) (typep m 'qvt::qvt-population)) session-models))
	     (qvt-spec-names (mapcar #'(lambda (m) (mofi:model-name m)) qvt-specs))
	     (source-model-names (mapcar #'(lambda (m) (mofi:model-name (qvt::source-model m))) qvt-specs))
	     (target-model-names (mapcar #'(lambda (m) (mofi:model-name (qvt::target-model m))) qvt-specs))
	     (pop-models (remove-if-not #'(lambda (m) (and (typep m 'mofi:population)
							   (not (typep m 'qvt::qvt-population))))
					session-models))
	     (pop-model-names (mapcar #'mofi:model-name pop-models)))
	(htm
	 (:ul (str 
	       (apply #'concatenate
		      'string
		      (mapcar #'(lambda (m) 
				  (format nil "<li>~A</li>" (mofb:url-mof-model m)))
			      session-models))))
	 (:form :method :post :enctype "multipart/form-data"
		(:table :border 0 :cellpadding 10 :cellspacing 0
			:bgcolor "#FDFDD8"
		(:tr (:td :colspan 4  :align "center"
			  "Mapping Specification:" 
			  (str (drop-down-box "mapping-spec" qvt-spec-names))))
		(:tr (:td "Source Model:")
		     (:td (str (drop-down-box "source-model" source-model-names)))
		     (:td "Source Population:")
		     (:td (str (drop-down-box "source-pop" pop-model-names))))
		(:tr (:td "Target Model:")
		     (:td (str (drop-down-box "target-model" target-model-names)))
		     (:td "Target Population Name: ")
		     (:td (:input :type "text" :name "target-pop-name")))
		(:tr (:td :colspan 4 :align "center"
			  (:input :type :submit :value "Execute Mapping Engine")))))
	 (let ((mofi:*models* session-models))
	   (flet ((getm (param-name)
		    (mofi:find-model (safe-post-parameter param-name) :error-p nil)))
	     (when-bind (qvt-spec (getm "mapping-spec"))
	       (when-bind (source-model (getm "source-model"))
		 (when-bind (source-pop (getm "source-pop"))
		   (when-bind (target-model (getm "target-model"))
		     (when-bind (target-pop-name (safe-post-parameter "target-pop-name"))
		       (process-users-qvt qvt-spec source-model source-pop target-model target-pop-name)
		       (if (zerop (fill-pointer (mofi::conditions *results*)))
			   (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) "/developers/qvt"))
			   (redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) 
					     "/developers/parse-errors")))))))))))))))

#+qvt		       
(defun process-users-qvt (qvt-spec source-model source-pop target-model target-pop-name)
  "Run a QVT mapping. Doing this includes creating the source trie-db population and
   creating a trie-db for the target population."
  (setf *results* (make-instance 'processing-results))
  (mofi:results-handler-bind (process-users-qvt)
    (with-vo (session-models)
      (let* ((mofi:*models* session-models)
	     (mofi:*population* (mofi:ensure-model 
				 target-pop-name :force t
				 :model-class 'mofi:population
				 :model-n+1 target-model))
	     ;; 2010-06-19 nicknameS
	     (source-db-name (intern (car (mofi:nicknames source-model))
				     (mofi:lisp-package source-model)))
	     (target-db-name (intern (car (mofi:nicknames target-model))
				     (mofi:lisp-package target-model))))
	;(setf mofi::*debug-population* mofi:*population*)
	(tr::ensure-trie-db source-db-name)
	(tr::ensure-trie-db target-db-name)
	(with-trie-db (source-db-name)
	  (let ((*package* (mofi:lisp-package source-model)))
	    (loop for inst across (mofi:members source-pop) do 
		  (qvt::instance2tries inst))))
	(clrhash qvt::*proxy-obj-ht*) 
	;; Run the mapping!
	(qvt:qvt-go (intern (mofi:model-name qvt-spec)
			    (mofi:lisp-package qvt-spec)))
	;; POD Need a loop like in the validator?
	(mofi:pp-propagate-derived-unions)
	(mofi:pp-propagate-opposites)
	(setf session-models
	      (remove target-pop-name session-models
		      :test #'string= :key #'mofi:model-name))
	(push mofi:*population* session-models)
	;(setf *zippy* (list source-db-name target-db-name))
	;; Clean up. (POD need to make FOL sentences somewhere here
      ))))


#+nil
(defun tryme ()
  "Run a QVT mapping."
  (with-vo (session-models)
    (let* ((mofi:*models* session-models)
	   (mofi:*population* (mofi:ensure-model 
			       "tryme" :force t
			       :model-class 'mofi:population
			       :model-n+1 (mofi:find-model "MOSScm"))))
      (clrhash qvt::*proxy-obj-ht*) ; POD7 Make this per-thread!!!
      (with-debugging (:qvt 5)
	(qvt:qvt-go '|deljit2cm|::|deljit2cm|))
      mofi:*population*)))
	     
;;;======================================
;;; Utilities
;;;======================================
(defun drop-down-box (name options)
  "Return html for a dropdown box with NAME name an OPTIONS."
  (let ((stream (make-string-output-stream)))
    (with-html-output (stream)
      (:select :name name
	(htm
	 (str (apply #'concatenate
		     'string
		     (mapcar #'(lambda (txt) 
				 (format nil "<option value='~A'>~A</option>"
					 txt txt))
			     options)))))
      (get-output-stream-string stream))))








