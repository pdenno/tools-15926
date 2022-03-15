
;;; Purpose: CRE-specific model types.

(in-package :mofi)

;;; POD instances probably should have been 'id2inst' and have mofi:members a vector...
(defclass template-population (abstract-model)
  ;; A list of templates
  ((templates :initarg :templates :initform nil :accessor templates)
   ;; template and DM instances, indexed by rdf:ID 
   (instances :initform (make-hash-table :test #'equal) :accessor instances)
   ;; maybe not useful
   (owl-classes :initform (make-hash-table :test #'equal) :reader owl-classes)
   ;; XQDM User doc
   (user-doc :initform nil :reader user-doc)
   ;; Error produced (POD Should go in processing results?)
   (general-errors :initform nil)
   ;; reference data SPARQL endpoints
   (endpoints :initform nil)))

(defclass privileged-template-population (template-population)
  ())

(defclass user-template-population (template-population)
   ;; Most errors are associated with the templates. These are associated
   ;; with the file.
  ())

(defmethod mofi:load-model ((m template-population) &key)
  (let ((*model* m))
    (with-slots (source-file model-name) m
      (if (eql model-name :em-templates)
	  (emerson:toplevel-read-emerson :model m)
	  (let ((newer-path (lpath :tmp (format nil "~A-~A.xml" (pathname-name source-file) (pod-utils:new-uuid)))))
 	    (tlogic:translate-legacy-ns source-file newer-path) ; POD maybe this belongs in owl-template/(read-owl)
	    (tlogic:read-owl :file newer-path :model m)))))
  m)
     
(defmethod print-object ((obj privileged-template-population) stream)
  (with-slots (model-name templates) obj
    (format stream "#<Template-pop ~A (~A templates)>" model-name (length templates))))

(defclass mexico-schema (abstract-model)
  (;; Types defined by this model.
   (types :reader types)))

;;; This one for MEXICO
(defmethod mofi:load-model ((m mexico-schema) &key)
  (with-slots (source-file types) m
    (setf expo:*expresso* (make-instance 'expo:mexico-expresso))
    (let* ((schema (expo:read-schema
		   (make-instance 'expo:express-file :version 2 :target-type :nothing 
				  :path source-file)))
	   (etypes nil #|(mexico:%schema-elements schema)|#))
      (declare (ignore schema))
      (setf types (make-array (length etypes) :initial-contents etypes)))))

;;; See some mofi compatibility stuff in express/expcore/schemas.lisp
(defclass expresso-lisp (abstract-model)
  (;; Types defined by this model.
   (types :reader types)))

(defun export-dm-names ()
  "Create additional symbols for part2 classes using the 'data model' camelcase names." 
  (loop for c across (mofi:types (mofi:find-model :part2))
        do (setf (find-class (intern (dash-to-camel (string-downcase (class-name c))) :part2)) c)))

;;; This one for MEXICO
(defmethod load-model ((m expresso-lisp) &key)
  (with-slots (source-file types) m
    (setf expo:*expresso* (make-instance 'expo:mexico-expresso))
    (let* ((schema (expo:load-schema
		    (make-instance 'expo::lisp-compiled-express-file :path source-file)))
	   (etypes (ht2list (expo::entity-types schema))))
      (setf types (make-array (length etypes) :initial-contents etypes)))
      ;; This is just to check that it works
    (loop for c across types do
	 (let ((iclass (expo::find-programmatic-class (list (class-name c)) :allow-partial t)))
	   (class-slots iclass))))
  (when (eql m (find-model :part2)) ; yes, totally bogus -- but will I ever use this again?
    (export-dm-names)))

;(push (expo:schema expo:*expresso*) mofi:*models*)

