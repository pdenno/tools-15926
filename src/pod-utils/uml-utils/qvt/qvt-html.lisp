
;;; Purpose: Pages displayed only at NIST, on the local server, for use with the 
;;;          mapping tools and other 'pre-production' stuff.

(in-package :qvt-html)

(defvar *zippy* nil)

(defvar mofi:*results* nil)

(defun qvt-restore-defaults-dsp ()
  "Clear all session models."
  (when-bind (redir (safe-get-parameter "redirect"))
    (with-vo (mofi:session-models) 
      (setf mofi:session-models nil))
    (tbnl:redirect redir)))

(defun available-models (&key html)
  "Return a string of html listing available models."
  (with-vo (session-models)
    (let ((models (append session-models 
			  (mapcar #'mofi:find-model 
				  #+sei '(:uml23 :bpmn :cmof :bpmnpro) 
				  #+cre '(:odm :mexico :uml241 :cmof)))))
      (if html
	  (with-output-to-string (s)
	    (format s "<h3>Available metamodels and models:</h3>")
	    (format s 
		    "<ul>~{<li>~A</li>~}</ul>"
		    (mapcar
		     #'(lambda (m) 
			 (format nil "~A.   ~A"
				 (mofb:url-mof-model m)
				 (if (member m mofi:*essential-models*) "" (mofb:url-remove-model m))))
		     models))
	    (format s "<a href=~A>Restore Defaults</a><br/>"
		    (format nil "~A~A?redirect=~A" 
			    (app-url-prefix (find-http-app (safe-app-name)))
			    "/qvt/restore-defaults"
			    (tbnl:script-name *request*))))
	  ;; else just the model objects
	  models))))

;;; /se-interop/qvt
(defun qvt-dsp (&key app)
  "Toplevel. Displays the 'QVT page'."
  (app-page-wrapper app (:view "QVT mapping" :menu-pos '(:root :qvt))
    (:h1 "Experimental QVT-r Implementation")
    "From the menu items on the left under 'QVT-r,' you can load files containing metamodels and model conforming 
     to a loaded metamodel and you can map from one model to another using a loaded QVT-r mapping.
     <br/><strong>Current Limitations:</strong> A model type may be used in a checkonly mode, 
     or an enforce mode, but not both. Thus some model types are sources of mapping and others targets."
    (:p) "The steps required for use are as follows:"
    (:ol 
     (:li "Load metamodels if you require metamodels beyond
           those listed below under 'Available metamodels and models.'
           <br/>(Use the menu item 'Load Metamodels' on the right.)")
     (:li "Load your QVT-r mapping specification file. In the transformation declaration of that file, 
           you specify metamodels as named under 'Available metamodels and models.' For example,
           if you are mapping from UML 2.3 to FUML 1.0, the transformation line might 
           appear as <strong>transformation umlToFuml (uml:UML23, fuml:FUML)</strong>.
           <br/>(Use the menu item 'Load QVT-r Maps' on the right.)")
     (:li "Load the model that will be the source of mapping.
           <br/>(Use the menu item 'Load Models' on the right.)")
     (:li "After specifying the source model, execute the mapping. 
           A new model, the result of mapping, will appear under 
           'Available Metamodels and Models'
           <br/>(Use the menu item 'Execute Mapping' on the right.)"))
    (str (available-models :html t))))

(defmacro nonsense-and-action (action &key (action-args nil) 
			       (redirect '(tbnl:redirect (tbnl:script-name *request*))))
  "Perform messy stuff used in uploading files, then run (ACTION ,@ACTION-ARGS)"
  `(when-bind (post-map-data (safe-post-parameter "file"))
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
	 (,action new-path ,@action-args)))
     ;; Reload the page
     ,redirect))

#+nil
(defun devl-js-post-dsp ()
  (when-bind (post-data (safe-post-parameter "firstName")) ;; I've been using :name JS example uses :id
    (app-page-wrapper :cre (:view "QVT Pages"
				  :menu-pos '(:root :tools))
      (:h1 "Result")
      (str post-data))))

;;; http://syseng.nist.gov/se-interop/developers/load-metamodels
(defun qvt-load-metamodels-dsp (&key app)
  (app-page-wrapper app (:view "QVT Pages - Load Metamodels"
				:menu-pos '(:root :qvt :load-metamodels))
    (:h1 "Load Metamodels")
    (:p) "From this page you can load XMI defining a metamodels in CMOF or UML.
          Loading a file here will establish metaobjects on which you can subsequently 
          load files defining instances ('model files'). If the source or target types of your 
          mapping will be one of the preloaded UML metamodels (see below 'Available metamodels and models')
          then you need not (should not) load it here."
    (str (available-models :html t))
    (:p) "Load a metamodel:"
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 10
		   :bgcolor "#FDFDD8"
		   (:tr (:td "Metamodel Name: ") 
			(:td (:input :type "text" :name "model-name")))
		   (:tr (:td "File: ")
			(:td (:input :type :file :name "file")))
		   (:tr (:td :colspan 2 :align "center" (:input :type :submit :value "Load Model")))))
      (nonsense-and-action qvt-handle-metamodel-file)))

;(qvt-handle-metamodel-file (pod:lpath :mylib "uml-utils/qvt/examples/uml2rdbms/simplerdbms.mdxml"))
;;; Not wrapping in   results-handler-bind -- don't care. 
(defun qvt-handle-metamodel-file (file-path)
  "Move the file from IN-PATH, (where the server placed it) to a place managed by us.
   Call process-uml/qvt-file2model with the file."
  #+cre.exe(log-message :info "qvt called from IP address ~A" (header-in "remote-ip-addr"))
  (case (usr-bin-file file-path)
    (:xml (with-vo (session-models user-id)
	    (let ((model-name (intern (format nil "~A-~A" (string-upcase user-id) (string (gensym)))
				      :keyword)))
	      (handler-bind ((simple-warning #'(lambda (c) (declare (ignore c)) (muffle-warning))))
		(with-debugging (:readers 0) 
		  (when-bind (pop (mofi:xmi2model-instance :file file-path :sort-names nil :clone-p nil))
		    (when-bind (classes-path 
				(mofi:pop-gen model-name 
					      :model pop 
					      :outfile (pod:lpath :tmp 
								  (make-pathname :name "tryme" ;(string model-name)
										 :type "lisp"))))
		      (when-bind (user-model (mofi:ensure-model model-name 
								:force t 
								:model-class 'mofi:compiled-model 
								:classes-path classes-path))
			(setf session-models
			      (remove (mofi:model-name user-model) session-models 
				      :test #'string= :key #'mofi:model-name))
			(push user-model session-models)))))))))
    (t (error "The file supplied does not look like XML nor QVT.")))
  (values))


;;; /se-interop/qvt/compile-maps
(defun qvt-compile-maps-dsp (&key app)
  (app-page-wrapper app (:view "QVT Pages - Compile QVT-r"
			       :menu-pos '(:root :qvt :load-maps))
    (:h1 "Compile a QVT-r File")
    (:p) "From this page you can compile QVT relational syntax relevant to a loaded metamodel. 
          <br/> (The metamodels should be loaded first, since the parser checks property navigation.)"
    (str (available-models :html t))
    (:p) "Compile a QVT-r File." 
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 10
		   :bgcolor "#FDFDD8"
		   (:tr (:td "QVT-r File: ")
			(:td (:input :type :file :name "file"))) ; macro wants "file"
		   (:tr (:td :colspan 4 :align "center" (:input :type :submit :value "Load QVT-r File")))))
    (let ((qvt-info (make-instance 'qvt-map-info)))
      (with-vo (qvt-map-info) (setf qvt-map-info qvt-info))
      (nonsense-and-action 
       qvt-handle-qvtr-file 
       :redirect (if (zerop (fill-pointer (mofi::conditions mofi:*results*)))
		     (app-redirect "/qvt/load-maps")
		     (app-redirect "/qvt/parse-errors"))))))

(defun qvt-handle-qvtr-file (file-path)
  "Call qvt-file2model or xmi2model-instance with the file (FILE-PATH) creating
   a population of MODEL-N+1."
  #+cre.exe(log-message :info "qvt-handle-file called from IP address ~A" (header-in "remote-ip-addr"))
    (setf mofi:*results* (make-instance 'processing-results))
;      (mofi:results-handler-bind (qvt-handle-qvtr-file)
      (with-vo (session-models mut)
	(when-bind (qvtr-pop (qvt:qvt-file2model :source-file file-path))
	  (setf session-models
		(remove (mofi:model-name qvtr-pop) session-models 
			:test #'string= :key #'mofi:model-name))
	  (push qvtr-pop session-models)
	  (setf mut qvtr-pop)));)
    (values))

(defun tryme ()
  (with-vo (qvt-map-info)
    (setf qvt-map-info (make-instance 'qvt-map-info))
    (qvt-handle-qvtr-file (pod:lpath :mylib "uml-utils/qvt/examples/uml2fuml/example.qvt"))))

(defun tryme2 ()
  (with-vo (qvt-map-info)
    (setf qvt-map-info (make-instance 'qvt-map-info))
    (qvt-handle-qvtr-file (pod:lpath :mylib "uml-utils/qvt/examples/bpmn/bpmn2uml.qvt"))))


;;; /se-interop/qvt/load-models 
(defun qvt-load-models-dsp (&key app)
  (app-page-wrapper app (:view "QVT Pages - Load Models"
			       :menu-pos '(:root :qvt :load-models))
    (:h1 "Load Models")
    (:p) "From this page you can load XMI files containing a model (a 'population')
          conforming to a loaded metamodel."
    (str (available-models :html t))
    (:p) "Load model XMI:"
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 10
		   :bgcolor "#FDFDD8"
		   (:tr (:td "File: ")
			(:td (:input :type :file :name "file"))) ; macro wants "file"
		   (:tr (:td :colspan 4 :align "center" (:input :type :submit :value "Load Model")))))
    (nonsense-and-action qvt-handle-model-file)))

(defun qvt-handle-model-file (file-path)
  "Call xmi2model-instance with the file (FILE-PATH) creating
   a population of MODEL-N+1 -- no validation."
  (declare (ignore model-name)) ; POD Investigate
  #+cre.exe(log-message :info "qvt-handle-file called from IP address ~A" (header-in "remote-ip-addr"))
  (setf mofi:*results* (make-instance 'processing-results))
  (handler-bind ((simple-warning #'(lambda (c) (declare (ignore c)) (muffle-warning))))
    (with-vo (session-models mut)
      (when-bind (model (mofi:xmi2model-instance :file file-path))
	(setf session-models
	      (remove (mofi:model-name model) session-models 
		      :test #'string= :key #'mofi:model-name))
	(push model session-models)
	(setf mut model))))
  (values))

;;; /se-interop/qvt/parse-errors
(defun qvt-parse-errors-dsp (&key app)
  "Reports errors from parsing, then allows you to go back to the qvt page."
  (app-page-wrapper app (:view "QVT Pages"
				:menu-pos '(:root :qvt))
    (:h1 "Exceptional conditions while processing")
    (htm 
     (:ul
      (loop for c across (mofi::conditions mofi:*results*) do
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

;;; /se-interop/qvt/map      
(defun qvt-execute-map-dsp (&key app)
  "Run mapping."
  (app-page-wrapper app (:view "Execute QVT-r Map" :menu-pos '(:root :qvt :map))
    (:h1 "Execute QVT-r Mapping")
    "From here you can run the mapping. In doing so, a new model will appear in 'Available Metamodels and Models.'"
    (str (available-models :html t))
    (with-vo (session-models qvt-map-info)
      (let* ((map-specs (remove-if-not #'(lambda (m) (typep m 'qvt::qvt-population)) session-models))
	     (map-spec-names (mapcar #'(lambda (m) (mofi:model-name m)) map-specs))
	     (pop-models (remove-if-not #'(lambda (m) (and (typep m 'mofi:population)
							   (not (typep m 'qvt::qvt-population))))
					session-models))
	     (pop-model-names (mapcar #'mofi:model-name pop-models)))
	(htm
	 (:form :method :post :enctype "multipart/form-data"
		(:table :border 0 :cellpadding 10 :cellspacing 0
			:bgcolor "#FDFDD8"
			(:tr (:td :colspan 4  :align "center"
				  "Mapping Specification:" 
				  (str (drop-down-box "map-model" map-spec-names))))
			(:tr (:td "Source Population:")
			     (:td (str (drop-down-box "source-pop" pop-model-names))))
			(:tr (:td :colspan 4 :align "center"
				  (:input :type :submit :value "Execute Mapping Engine")))))
	   (flet ((getm (param-name)
		    (mofi:find-model (safe-post-parameter param-name) :error-p nil)))
	     (when-bind (spop (getm "source-pop"))
	       (when-bind (map-model (getm "map-model"))
		 (with-slots (source-pop qvt-map-model) qvt-map-info
		   (setf source-pop spop)
		   (setf qvt-map-model map-model))
		 (run-qvt qvt-map-info)
		 (app-redirect "/qvt/map")))))))))

(defun run-qvt (qvt-map-info)
  "Run a QVT mapping. Doing this includes creating the source trie-db population and
   creating a trie-db for the target population."
  (setf mofi:*results* (make-instance 'processing-results))
  (with-slots ((map-spec qvt-map-model) 
	       (smeta source-meta) 
	       (tmeta target-meta)
	       (spop  source-pop)) qvt-map-info
      (mofi:results-handler-bind (run-qvt)
	(with-vo (session-models)
	  (let* ((mofi:*population* (mofi:ensure-model 
				     (mofi::unique-name "qvt-map")
				     :model-class 'mofi:population
				     :model-n+1 tmeta))
		 (source-db-name (intern (qvt::domain-nick smeta)
					 (mofi:lisp-package smeta)))
		 (target-db-name (intern (qvt::domain-nick tmeta)
					 (mofi:lisp-package tmeta))))
	    (declare (special mofi:*population*))
	    (tr::ensure-trie-db source-db-name)
	    (tr::ensure-trie-db target-db-name)
	    (with-trie-db (source-db-name)
	      (let ((*package* (mofi:lisp-package smeta)))
		(declare (special *package*))
		(loop for inst across (mofi:members spop) do 
		     (qvt::instance2tries inst))))
	    (clrhash qvt::*proxy-obj-ht*) 
	    ;; Run the mapping!
	    (qvt:qvt-go (intern (mofi:model-name map-spec)
				(mofi:lisp-package map-spec)))
	    ;; POD Need a loop like in the validator?
	    (mofi:pp-propagate-derived-unions)
	    (mofi:pp-propagate-opposites)
	    (setf session-models
		  (remove (mofi:model-name mofi:*population*) session-models
			  :test #'string= :key #'mofi:model-name))
	    (push mofi:*population* session-models)
	    mofi:*population*)))))
	
;;;======================================
;;; Utilities
;;;======================================
(defun drop-down-box (name options)
  "Return html for a dropdown box content with NAME name an OPTIONS."
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

