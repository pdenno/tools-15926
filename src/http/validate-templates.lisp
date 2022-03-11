
;;; Purpose: Provide pages for template validation. 

(in-package :phttp)


;;;========================================================
;;; Template and template list display
;;;========================================================
(defun url-template (temp)
  "Provide a URL to the report page for the template, TEMP."
  (with-slots (tlog:name) temp
    (format nil "<a href='~A/validate/tpage?name=~A&model=~A'>~A</a>" 
	    (app-url-prefix (find-http-app (safe-app-name)))
	    tlog:name (mofi:model-name (mofi:%of-model temp)) tlog:name)))

(defun url-template-instance (tempi)
  "Provide a URL to the report page for the template instance, TEMP."
  (let ((id (mofi:%obj-id tempi)))
    (format nil "<a href='~A/validate/ipage?name=~A&model=~A'>&lt;~A id=~A&gt</a>" 
	    (app-url-prefix (find-http-app (safe-app-name)))
	    id
	    (mofi:model-name (mofi:%of-model tempi)) 
	    (class-name (class-of tempi))
	    (mofi:%debug-id tempi))))

;;; /cre/validate
(defun validate-home-dsp ()
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate))
    (htm
     (:h1 "Templates")
     (:ul 
      (:li (:a :href "/cre/validate/emerson" "Emerson templates"))
      (:li (:a :href "/cre/validate/results/mmt" "MMT templates"))))))

;;; /cre/validate/results/mmt
(defun validate-show-mmt-list-dsp ()
  "Display the validation home page, listing templates and problems."
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate :mmt))
    (when-bind (mut (mofi:find-model :mmt-templates))
      (when-bind (temps (mofi:templates mut)))
      (htm
       (:h1 "MMT Templates")
       (with-slots ((doc mofi::documentation)) mut
	 (str (format nil "The model shown has the following documentation string:<br/>~S" doc)))
       "<p/>Templates in the following list may be annotated with a '--- (some number)' "
       "indicating the number of errors detected in processing the template."
       (:ul
	(str (show-template-list-internal (mofi:templates mut))))))))

;;; /cre/validate/results/mmt
(defun validate-show-user-list-dsp ()
  "Display the validation home page, listing templates and problems."
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate :upload))
    (with-vo (mut) 
       (with-slots ((sfile mofi:source-file) (errs mofi:general-errors) (eps mofi:endpoints)
		    (temps mofi:templates) (insts mofi:instances)) mut
	 (htm
	  (:h1 (str (format nil "Results for file ~A.~A" 
			    (pathname-name sfile) 
			    (pathname-type sfile))))
	  (:h2 "Summary")
	  "Template definitions: " (str (format nil "~A" (length (mofi:templates mut))))
	  (:br) "Template instances: " (str (format nil "~A" (hash-table-count (mofi:instances mut))))
	  (:br) "Total errors: " 
	  (str (format nil "~A"
		       (+ (length errs) 
			  (loop for tt in temps sum (length (tlog:conditions tt)))
			  (loop for ii being the hash-value of insts 
			       when (typep ii 'mofi:mm-root-supertype) ; not dm POD might merge these
			       sum (length (mofi:%conditions ii))))))
	  (:br) "Referenced endpoints: " 
	  (str (if eps (format nil "<ul>~{<li>~A</li>~}</ul>" eps) " none"))
	  (str (errors-by-type-report))
	  (if mut
	      (let ((temps (mofi:templates mut))
		    (insts (mofi:instances mut)))
		(unless (or temps insts)
		  (htm "An error occurred in reading the file (no templates nor instances found)."))
		(when temps
		  (htm
		   (:h2 "Template Definitions")
		   (str (show-template-list-internal temps))))
		(unless (zerop (hash-table-count insts))
		  (htm
		   (:h2 "Instance Data")
		    (str (show-instance-list-internal 
			  (sort (ht2list insts) #'< :key #'mofi:%debug-id))))))
	      (htm "An error occurred in reading the file.")))))))

(defun all-conditions ()
  "Return all conditions found in the MUT."
  (with-vo (mut)
    (append
     (slot-value mut 'mofi:general-errors)
     (mapappend #'(lambda (x) (tlog:conditions x)) (mofi:templates mut))
     (loop for i being the hash-value of (mofi:instances mut) 
	for val = (mofi:%conditions i)
	when (listp val) append val))))

(defun errors-by-type-report ()
  "Generate a hunk of html for each type of warning.
   CONDITIONS - the conditions vector from the mut of the vo-object.
   COUNT-CONDITIONS - a small hash table for those conditions that are only counted.
   Calls mofi:validation-details to do most of the work."
  (let ((conditions (all-conditions))
	(cond-classes 
	 (mapappend 
	  #'(lambda (x) (closer-mop:class-direct-subclasses (find-class x)))
	  '(tlog:template-warning tlog:instance-warning  tlog:template-error 
	    tlog:instance-error tlog:tlogic-parse-error))))
    (flet ((select-sort (pred)
	     (sort (remove-if-not #'(lambda (x) (and x (funcall pred x))) cond-classes
				  :key #'(lambda (x) (get :id-num (class-name x))))
		   #'< :key #'(lambda (x) (or (get :id-num (class-name x)) 0)))))
      (macrolet ((write-it (title pred)
		   `(progn
		      (format out "<strong>~A</strong>" ,title)
		      (format out "<ul>")
		      (loop for c in (select-sort ,pred)
			 for class-name = (class-name c)
			 do (format out "~%<li><a href='~A'>~A</a>: ~A</li>" 
				    (url-explanation class-name)
				    (documentation c 'type)
				    (count-if #'(lambda (c) (typep c class-name)) conditions)))
		      (format out "</ul>"))))
	(with-output-to-string (out)
	  (format out "<h2>Summary of Warnings</h2>")
	  (write-it "Template Instances:" #'(lambda (x) (< x 100)))
	  (write-it "Template Definitions:" #'(lambda (x) (and (> x 100) (< x 1000))))
	  (write-it "Template Axioms:" #'(lambda (x) (> x 1000))))))))

(defun url-explanation (condition-class-name)
  (format nil "/cre/validate/explanation?concept=~A" condition-class-name))

;;; /cre/explanation
(defun mof-explain-dsp ()
  (app-page-wrapper :cre (:view "Error Explanation" :menu-pos '(:root :validate))
    (if-bind (concept (intern (safe-get-parameter "concept") :tlogic)) ; POD Intern in tlogic is OK for now...
     (if-bind (text (get :explanation concept))
      (htm
       (:h1 (str (format nil "Explanation of error <em>~A</em>" (get :title concept))))
       (str text)
       (:h2 "Objects exhibiting this error:")
       (htm
	(with-vo (mut) 
	  (str
	   (with-output-to-string (out)
	     (let ((exhibiting
		    (append
		     (loop for obj being the hash-value of (mofi:instances mut)
			when (find-if #'(lambda (x) (typep x concept)) (mofi:%conditions obj)) collect obj)
		     (loop for obj in (mofi:templates mut)
			when (find-if #'(lambda (x) (typep x concept)) (mofi:%conditions obj)) collect obj))))
	       (if (null exhibiting)
		   (format out "<br/>None.")
		   (progn
		     (format out "<ul>")
		     (loop for ex in exhibiting do
			  (format out "<li>~A</li>" 
				  (typecase ex
				    (mofi:mm-root-supertype (url-template-instance ex))
					(tlog:template (url-template ex)))))
			 (format out "</ul>")))))))))
      (str (format nil "No explanation provided for concept ~A." concept)))
     (str "No concept provided for explanation."))))

(defun show-template-list-internal (temps)
  "Return a list of the template name and number of conditions found."
  (with-output-to-string (s)
    (format s "<ul>")
    (loop for tt in temps do
	 (with-slots (tlog:conditions) tt
	   (if (null tlog:conditions) 
	       (format s "<li>~A</li>" (url-template tt))
	       (format s "<li>~A ---  (~A)</li>" (url-template tt) (length tlog:conditions)))))
    (format s "</ul>")))

(defun show-instance-list-internal (insts)
  "Return a list of the template instances name and number of conditions found."
  (with-output-to-string (s)
    (format s "<ul>")
    (let ((part2 (mofi:find-model :part2)))
      (loop for inst in insts do
	   (unless (eql part2 (mofi:of-model (class-of inst)))
	     (with-slots ((errs mofi:|conditions|)) inst
	       (if (null errs)
		   (format s "<li>~A</li>" (url-template-instance inst))
		   (format s "<li>~A --- (~A)</li>" 
			   (url-template-instance inst) 
			   (length errs)))))))
    (format s "</ul>")))

;;; /cre/validate/emerson
(defun validate-em-dsp ()
  "Display the validation home page, listing templates and problems."
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate :em))
    (when-bind (model (mofi:find-model :em-templates))
      (when-bind (temps (mofi:templates model))
	(htm
	 (:h1 "Templates")
	 (with-slots ((doc mofi::documentation)) model
	   (str (format nil "The model shown has the following documentation string:<br/>~S" doc)))
	 "<p/>Templates in the following list may be annotated with a '--- (some number)' "
	 "indicating the number of errors detected in processing the template."
	 (:ul
	  (str (with-output-to-string (s)
		 (loop for tt in temps do
		      (with-slots (tlog:conditions) tt
			(if (null tlog:conditions) 
			    (format s "<li>~A</li>" (url-template tt))
			    (format s "<li>~A ---  (~A)</li>" (url-template tt) (length tlog:conditions)))))))))))))


;;; /cre/validate/tpage
(defun template-show-page-dsp ()
  "Display a page describing a single template."
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate))
    (when-bind (name (safe-get-parameter "name"))
      (when-bind (model-name (safe-get-parameter "model"))
	(when-bind (model (or (mofi:find-model (kintern model-name) :error-p nil)
			      (mofi:find-model model-name :error-p nil :session-too t)))
	  (when-bind (temp (find name (mofi:templates model)
				 :test #'string= :key #'tlogic:name))
	    (with-slots (tlog:parent-template tlog:comment tlog:conditions) temp
	      (htm
	       (:h1 (str (format nil "Template ~A" name)))
	       (:h2 "Description")
	       (cond ((eql model (mofi:find-model :mmt-templates))
		      (htm "See " 
			   (:a :href 
			       "http://15926.org/15926_template_specs.php" 
			       "15926.org")))
		     ((or (null tlog:comment) (string= "" tlog:comment)) (str "None provided"))
		     (t (str tlog:comment)))
	       (:br)(:br)
	       (:strong "Parent Template: ")
	       (str (if tlog:parent-template (url-template tlog:parent-template) "none"))
	       (:p)
	       (:table :border 1 :cellpadding 2 :cellspacing 0
		       (htm
			(:tr 
			 (:td :align "center" :bgcolor "#FFF159" "Role Number")
			 (:td :align "center" :bgcolor "#FFF159" "Role Name")
			 (:td :align "center" :bgcolor "#FFF159" "Role Object Type")
			 (:td :align "center" :bgcolor "#FFF159" "Remarks & Examples")
			 (str (with-output-to-string (str)
				(loop for r in (tlog:roles temp) do
				     (with-slots ((i tlog:index) (n tlog:name) 
						  (y tlog:type) (c tlog:comment)) r
				       (format str "<tr><td align='center'>~A</td><td>~A</td><td>~A</td><td>~A</td></tr>" 
					       i 
					       n 
					       (cond ((typep y 'class) 
						      (mofb:url-class-browser 
						       y 
						       :force-text (tlog:p2name2p7name 
								    (if (expo:ientity-mo-p y)
									(tlog:type-symbol y)
									(class-name y)))))
						     ((typep y 'puri:uri)
						      (url-rds-page y))
						     (t  y))
					       (or c "")))))))))
	       (unless (null tlog:conditions)
		 (htm (:h2 "Validation Conditions")
		      (:ul
		       (str (with-output-to-string (s)
			      (loop for c in tlog:conditions do
				   (format s "<li>~A</li>" c)))))))
	       (htm (:h2 "Specification"))
	       (str (if-bind (logic (tlog:logic temp))
			     (with-output-to-string (str) (tlog:stringify logic str))
			     (tlog:logic-text temp)))))))))))
  
(defun name-for-tpage (obj)
"Return a text string naming OBJ."
  (if (typep obj 'class) 
      (dash-to-camel (string-downcase (string (class-name obj))))
      (format nil "~A" obj)))

;;; /cre/validate/ipage
(defun instance-show-page-dsp ()
  "Display a page describing a single template."
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate))
    (when-bind (name (safe-get-parameter "name"))
      (when-bind (model-name (safe-get-parameter "model"))
	(when-bind (model (or (mofi:find-model (kintern model-name) :error-p nil)
			      (mofi:find-model model-name :error-p nil :session-too t)))
	  (when-bind (inst (gethash (format nil "#~A" name) (mofi:instances model)))
	    (let* ((class (class-of inst))
		   (slots (mofi:mapped-slots class)))
	      (htm
	       (:h1 (str (format nil "Instance &lt;~A id=~A&gt;" 
				 (class-name class) (mofi:%debug-id inst))))
	       (:h3 "Properties")
	       (str
		 (with-output-to-string (out)
		   (format out "rdf:ID: ~A<br/>" (mofi:%obj-id inst))
		   (loop for s in slots 
			 for name = (hcl:slot-definition-name s) do
			(format out "~A : ~A<br/>" 
				(string name)
				(if-bind (val (slot-value inst name)) val "[not specified]"))))))
	      (with-slots ((errs mofi:|conditions|)) inst
		(when errs
		  (htm
		   (:h3 "Errors")
		   (str
		    (with-output-to-string (out)
		      (format out "<ol>")
		      (loop for e in errs do (format out "<li>~A</li>" e))
		      (format out "</ol>")))))))))))))


;;;========================================================
;;; Input form and validation call
;;;========================================================
(defun template-validator-dsp ()
  "Upload an XMI 2.1 file (uncompressed) of UML or SysML. Perform validation. Report results."
  (app-page-wrapper :cre (:view "NIST ISO 15925 Part 7/8 Validator" 
			  :menu-pos '(:root :validate)
			  :force-new-session nil) ; POD turned off for profile use
   (:h1 "NIST ISO 15925 Part 7/8 Validator")
   "The NIST Part 7/8 Validator is an experimental tool to assess the well-formedness
    of ISO 15926-7 templates and template-based information. The tool accepts template 
    specifications and template instances in ISO 15926-8 OWL format
    and provides a report of structural and type-consistency issues against the templates. "
;   (:p)
;   "Effective use of the tool requires that the template definitions specify the biconditional logical
;    expansion of the signature. This is primarily what is checked. An example of such 
;    a file can be found " (:a :href "/cre/static/example-templates.xml" "here")"."
    (:p)
    "You can allow the validator to accept 'legacy xml namespaces'"
     " which are " (:a :href "/cre/explain-legacy-xml" "namespaces used in ealy drafts") " of Part 8."
    (:h3 "Enter below a file to upload and process:")
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 0 :bgcolor "#FDFDD8"
	     (:tr (:td "Part 8 file: ") 
                  (:td (:input :type :file :name "uml-file")))
	     (:tr (:td "<input type='radio' name='legacy-y/n' value='no-leg'> Typical usage")
		  (:td "<input type='radio' name='legacy-y/n' value='leg' CHECKED> Allow legacy XML namespaces"))
	     (:tr (:td :colspan 3 :align "center" 
		       (:input :type :submit :value "Upload and Process")))))
    (when-bind (post-map-data (safe-post-parameter "uml-file"))
      (dbind (in-path in-file &rest ignore) post-map-data 
	(declare (ignore ignore))
	(let (allow-legacy-p)
	  (when (string= (safe-post-parameter "legacy-y/n") "leg") (setf allow-legacy-p t))
	  ;; strip directory info sent by Windows browsers
	  (when (search "Windows" (user-agent) :test #'char-equal)
	    (setq in-file (cl-ppcre:regex-replace ".*\\\\" in-file "")))
	  (catch 'xml-parse-error
	    (template-validator-handle-file in-path in-file allow-legacy-p)
	    (redirect "/cre/validate/results/user")))))))

(defun template-validator-handle-file (in-path in-file allow-legacy-p)
  "Move the file from IN-PATH, (where the server placed it) to a place managed by us.
   Pass the file to the validator."
  ;(log-message :info "NIST Validator called from remote IP address ~A" (header-in "remote-ip-addr"))
  (validator-clear-for-new-run)
  (let ((new-path (make-pathname :name (pathname-name in-file) 
				 :type (pathname-type in-file)
				 :defaults *uploaded-files-dir*)))
    (rename-file in-path (ensure-directories-exist new-path))
    (when allow-legacy-p
      (let ((newer-path (make-pathname :name (format nil "~A-nolegacy" (pathname-name new-path))
				       :defaults new-path)))
      (tlogic:translate-legacy-ns new-path newer-path)
      (rename-file newer-path new-path)))
    (with-vo (filename mut session-models)
      (setf session-models nil)
      (setf filename (format nil "~A.~A" (pathname-name in-file) (pathname-type in-file)))
      ;; POD You can comment out results-handler-bind if (tbnl settings notwithstanding) 
      ;; you are not getting error at listener.
      (unless (eql :xml (usr-bin-file new-path))
	(error "The file supplied appears not to be XML format."))
      (setf mut (make-instance 'mofi:user-template-population
			       :source-file new-path
			       :name "user-templates"))
      (mofi:load-model mut)
      (push mut session-models))))

(defun explain-legacy-xml-dsp ()
  (app-page-wrapper :cre (:view "NIST Template Validator" 
			  :menu-pos '(:root :validate))
    (htm 
     (:h2 "Use of 'Legacy XML Namespaces")
     "Some draft version of Part 8 (prior to the  2011-10-15 Technical Specification) used:"
	 (:ul
	  (:li "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template#")
	  (:li "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#"))
	 "instead of (respectively):"
	 (:ul
	  (:li "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tpl#")
	  (:li "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tm#"))
	 "When you select to validate with 'legacy XML namespaces,' the validator translates
          the use of the former namespaces to the latter ones.")))

(defun validator-clear-for-new-run ()
  "Clear view objects and other memory related to past work."
  (with-vo (pod-utils::view-objects mut) 
    (setf mut nil)
    (clrhash pod-utils::view-objects)))

#|
;;;/cre/validate/rds/class?endpoint=jord&class=RDS418769
(defun validate-show-rds-class-dsp ()
  (app-page-wrapper :cre (:view "Template Validation" :menu-pos '(:root :validate))
    (when-bind (ep (safe-get-parameter "endpoint"))
      (when-bind (rds-num (safe-get-parameter "class"))
	(cond ((eql :jord (kintern ep)))
	      (let ((result 
		     (tlogic:sparql-query 
		      :jord
		      (format nil "SELECT ?sc WHERE {http://jord-dev.org/rdl/hasSubclass#~A RDL:hasSubclass ?sc .}"
			      str))))
		;; UNFINISHED
		))))))
|#





     
