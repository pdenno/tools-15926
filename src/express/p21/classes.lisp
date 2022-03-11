(in-package :P21P)

;;; Copyright (c) 2002 Logicon, Inc.
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------

(defmacro define-object (name supertypes &body slots)
  `(progn
    ;; bookkeeping forms go here
    (defclass ,name (,@supertypes %%object)
      (,@(loop for slot in slots
	       collect `(,slot :accessor ,slot
			 :initarg ,(pod:kintern (cl:string slot))
			 :initform nil))))))

(defmacro define-mixin (name superclasses &body slots)
  `(progn
     ;; bookkeeping forms go here
     (defclass ,name (,@superclasses)
       (,@(loop for slot in slots
		collect `(,slot :accessor ,slot
			  :initarg ,(pod:kintern (cl:string slot))
			  :initform nil))))))

(defclass %%object () ())

(define-object p21-data ()
  header
  datasec)

;;; POD These methods,  convert-data and convert-instance belong in expo? The only reason
;;; they are here is that Craig didn't want to make get-programmatic class a method???
(defmethod expo::convert-data ((src p21-data) (dataset expo::express-dataset) &key)
  "Produce an entity instance from a p21-data object (which contains dataset content)."
  (with-slots (header datasec) src
    ;; handle known header entities
    (loop for ent in header
	  for rec = (first (records ent))
	  do (case (entity rec)
	       (file_description
		(setf (expo::file-description dataset)
		      (first (first (parameters rec)))))
	       (file_name
		(setf (expo::filename dataset)
		      (first (parameters rec))))
	       (file_schema
		(let* ((schema-name (first (first (parameters rec))))
		       (schema (expo:find-schema schema-name)))
		  (unless schema
		    (expo:alert-message "The Part 21 file references a FILE_SCHEMA~%~
					 '~A'~%but no such schema is loaded." schema-name)
		    (expo::abort? expo::*expresso*))
		  (setf (expo::schema expo::*expresso*) schema)
		  (setf (expo::file-schema dataset) schema-name)))
	       ;; ignore unknown entities
	       ))
    ;; process DATASEC entities
    (loop for ent in datasec
	  do (expo:convert-data ent dataset))
    dataset))

;;; ------------------------------
(define-object p21-instance ()
  name
  scope
  records)

(defmethod print-object ((obj p21-instance) stream)
  (with-slots (name) obj
    (print-unreadable-object (obj stream :type t)
      (cl:format stream "~@[~D~]" name))))

(defmethod expo:convert-data ((src p21-instance) (dataset expo::abstract-dataset) &key suppress-store)
  "Produce an entity instance from a p21-instance object (which records what the intended content)."
  (with-slots (name) src
    (let* ((class (get-programmatic-class src)) ; pod make it a method? then move everything to expo???
	   (vals (get-data-values src))
	   (nvals (get-data-nvalues src))
	   (mslots (mofi::mapped-slots class)) ; 2013 was expo:mapped-slots
	   initargs instance)
      (unless (eql (length mslots) nvals)
	(with-slots (expo::errors-at-creation) expo::*expresso* (incf expo::errors-at-creation))
	(warn "~%Instance #~D has the wrong number of values: found ~D, expected ~D"
		name nvals (length mslots)))
      (labels ((next-value ()
		 (cond ((null (first vals)) (pop vals))
		       ((cl:and (symbolp (first vals)) (not (keywordp (first vals))))
			;;(break "convert-data.next-value:~%vals=~S~%name=~S" vals (first vals))
			(pop vals)
			(next-value))
		       (t (pop vals)))))
	;; Steps:
	;; 1. get internal class (get-programmatic-class ???)
	;; 2. build up initargs
	(setf initargs
	      (loop for eslot in mslots
		    for value = (next-value)
		    for es-type = (expo::slot-definition-range eslot)
		    for iargs = (slot-definition-initargs eslot)
		    for initarg = (if (symbolp iargs) iargs (first iargs))
		    for val? = (let ((expo:*recorded-type* nil)) (expo::convert-value es-type value))
		    for val = (expo::fix-selects val?)
		    ;;do (break "convert-data: now what? (~S ~S)" initarg val)
		    append `(,initarg ,val)))
	;; 3. make instance (apply #'make-instance class initargs)
	;;(break "convert-data:~%~S" `(cl:make-instance ,class ,@initargs))
	(setf instance (apply #'make-instance class initargs))
	)
      ;; 4. store instance in dataset
      (unless suppress-store
	(expo::store-instance instance name :dataset dataset))
      instance)))

(defun get-data-nvalues (instance)
  (loop for rec in (records instance)
	sum (length (parameters rec))))

(defun get-data-values (instance)
  (loop for rec in (records instance)
	append `(,(intern (entity rec)) ; PODsampson was euintern
		 ,@(copy-list (parameters rec)))))

(defun get-programmatic-class (instance)
  (flet ((entity-names (inst)
	   (loop for rec in (records inst) ; PODsampson was euintern
		 collect (intern (string-upcase (entity rec)) (mofi:lisp-package (expo:schema expo:*expresso*))))))
    (let* ((class-names (entity-names instance))
	   (p-class (expo::find-programmatic-class class-names)))
      (cl:if (> (length (records instance)) 1)
	(when (and (not (= (cl:length class-names)
			   (cl:length (expo:express-class-list p-class)))))
	  (error "The externally mapped enitty #~D did not list all supertypes."
		 (name instance)))
	(unless (expo::entity-type-prints-internal-p p-class) ; 2013 added entity-type- to fname.
;	  (break "Internally mapped entity #~D should be mapped externally." (name instance))
	  (error "The internally mapped entity #~D appears as though it should have been mapped externally."
		 (name instance))))
      p-class)))

;;; ------------------------------
(define-object p21-record ()
  entity
  parameters)

(defmethod print-object ((obj p21-record) stream)
  (with-slots (entity) obj
    (print-unreadable-object (obj stream :type t)
      (princ entity stream))))

;;; ------------------------------
(define-object p21-entity-ref ()
  entity-name)

(defmethod print-object ((obj p21-entity-ref) stream)
  (with-slots (entity-name) obj
    (if-debugging (:any 1)
       (cl:format stream "#~D" entity-name)           
       (print-unreadable-object (obj stream :type t)
         (cl:format stream "#~D" entity-name)))))

(defmethod expo::convert-value ((type expo::express-entity-type-mo) (value p21-entity-ref) &key)
  (with-slots (entity-name) value
    (expo::make-p21-entity-ref :-value entity-name)))

;;; ------------------------------
(define-object p21-typed-parameter ()
  param-type
  param-value)

;;; ------------------------------
(define-object p21-scope ()
  instances
  exports)
