
;;; Author: Peter Denno
;;; Purpose: Display Price's OWL upper ontology of ISO 15926-2 as ODM OWL etc. objects.

(in-package :phttp)

(defparameter *about-ht* (make-hash-table :test :eq))
(defvar *def* nil "Used in with-instance")

(defmacro with-instance ((type &rest init-args) &body body)
  "A macro that creates an object and provides with-slots to use it." 
  (let ((slot-names (mapcar #'clos:slot-definition-name (clos:class-slots (find-class type)))))
    `(let* ((*def* (make-instance ',type ,@init-args)))
       (declare (special *def*))
       (with-slots ,slot-names *def*
	 (declare (ignorable ,@slot-names))
	 ,@body
	 *def*))))

(defmemo model-classes-sorted (model)
    "Returns a sequence of the model MODEL classes sorted."
    (typecase model
      (expo:express-schema
       (sort (ht2list (expo:entity-types model)) #'string< :key #'class-name))
      (mofi:abstract-model
       (sort (coerce (mofi:types model) 'list) #'string< :key #'class-name))))


;;; POD Consider using xpath some here. (It doesn't keep position very well, however). 
(defun load-15926-ontology ()
  "Read the West/Price OWL ontology of 15926-2 (aka Epistle Core Model)."
  (let ((doc (xml-utils:xml-document-parser #P"cre:data;ecm-nov-19-2004.owl")))
    (when-bind (oelem (xml-find-child 'owl:|Ontology| doc))
      (let ((mofi:*population* (make-instance 'mofi:privileged-population
					      :model-n+1 (mofi:find-model :odm)
					      :name :ECM :force :ECM))
	    (onto nil))
	(declare (special mofi:*population*))
	(with-instance (|ODM-OWLBase|:|OWLOntology|)
	  (setf onto *def*)
	  (when-bind (comment (xml-find-child 'rdfs:|comment| oelem))
	    (setf |ODM-RDFBase|:|RDFScomment|
		  (with-instance (|ODM-RDFBase|::|PlainLiteral|)
		    (setf |ODM-RDFBase|:|lexicalForm| (car (xml-utils:xml-children comment))))))
	  (loop for c in (xml-find-children 'owl:|Class| (xml-utils:xml-root doc)) do
	       (with-instance (|ODM-OWLBase|:|OWLClass|)
		 (setf |ODM-OWLBase|:|ontology| onto)
		 (when-bind (about (xml-get-attr c 'rdf:|about|))
		   (setf (mofi:%debug-id *def*) about))
		 ;; subClassOf
		 (when-bind (super-ref (xml-find-child 'rdfs:|subClassOf| c))
		   (when-bind (superclass (xml-find-child 'owl:|Class| super-ref))
		     (when-bind (super-about (xml-get-attr superclass 'rdf:|about|))
		       (setf ODM-RDFS:|RDFSsubClassOf| (list super-about)))))
		 ;; comment
		 (when-bind (comment-elem (xml-find-child 'rdfs:|comment| c))
		   (setf |ODM-RDFBase|:|RDFScomment| (car (xml-utils:xml-children comment-elem)))))))))))

(defun upper-ontology-dsp ()
  "Display the West/Price 15926-2 upper ontology."
  (app-page-wrapper :cre (:view "OWL Upper Ontology of 15926-2" 
				:menu-pos '(:root :browse :uo))
    (:h1 "OWL Upper Ontology of ISO 15926-2")))

(defun model-list-dsp ()
  "Display a list of models; this is just links to the LHS menu items."
  (app-page-wrapper :cre (:view "Browse Models" 
				:menu-pos '(:root :browse))
    (:h1 "Model Inventory")
    (:ul 
     (:li (:a :href "/cre/part2" "ISO15926-2"))
     (:li (:a :href "/cre/odm-tree" "ODM"))
     (:li (:a :href "/cre/mexico" "EXPRESS Metamodel"))
     (:li (:a :href "/cre/uo"     "OWL Ontology of ISO-15926-2")))))
	   

(defun mexico-dsp ()
  "Display the classes of the EXPRESS metamodel (MEXICO)."
  (app-page-wrapper :cre (:view "Browse EXPRESS Metamodel" 
				:menu-pos '(:root :browse :mexico))
    (:h1 "EXPRESS Metamodel")
    (str (format nil "~{~A<br/>~}"
		 (mapcar #'mofb:url-class-browser 
			 (model-classes-sorted (mofi:find-model :mexico)))))))

(defun part2-dsp ()
  "Display the classes of ISO-15926-2"
  (app-page-wrapper :cre (:view "Browse ISO15926-2 EXPRESS" 
				:menu-pos '(:root :browse :part2))
    (:h1 "ISO-15926-2 Entity Types")
    (str (format nil "~{~A<br/>~}"
		 (mapcar #'mofb:url-class-browser 
			 (model-classes-sorted (expo:find-schema "lifecycle_integration_schema")))))))

;;;==========================================================
;;; General stuff for using mof-browser, (not OWL UO-related)
;;;==========================================================
;;;/cre/odm-tree
(defun odm-tree-dsp ()
  "Display JS package structure and (at bottom of page) lists of classes."
  (flet ((string-of-classes (class-list)
	   (loop for c across class-list with result = "" do
	      (strcat* result (mofb:url-class-browser c) "<br/>")
	      finally (return result))))
    (app-page-wrapper :cre (:view "ODM Browser" :js-tree t
				  :menu-pos '(:root :browse :odm))
      (:h1 "Ontology Definition Metamodel (ODM) Browser")
      (str
       (build-package-hierarchy (find "org.omg.odm" (mofi:packages (mofi:find-model :odm))
				      :key #'mofi:name :test #'string=))))))

(defun build-package-hierarchy (pack)
  "Generate JS for package hierarchy. Not called for leaves"
  (let ((name (mofi:name pack)))
    (with-html-output (*standard-output*)
	(:div :class "trigger" 
	      :onclick (str (format nil "showBranch(\"branch-~A\");swapFolder(\"folder-~A\")"  name name))
	      (:img :src "/se-interop/image/down-arrow.png" :border "0" :id (str (format nil "folder-~A" name)))
	      (str (strcat " " (string name))))
	(:span :class "branch" :id (str (format nil "branch-~A" name))
	       ;; Individual non-package objects (mofb links)
	       (loop for c in (sort
			       (remove-if #'(lambda (x) (typep x 'mofi:mm-package-mo))
					  (mofi::owned-element pack))
			       #'string< :key #'(lambda (x) (string (class-name x)))) do
		    (htm (str (mofb:url-class-browser c)) (:br)))
	       ;; package objects branches
	       (loop for p in (remove-if-not #'(lambda (x) (typep x 'mofi:mm-package-mo))
					     (mofi::owned-element pack))
		  do (build-package-hierarchy p))))))





