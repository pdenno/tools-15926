;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EXPRESSO; Base: 10 -*-

;;; Copyright (c) 2001 Logicon, Inc.
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

;;; Peter Denno
;;; Date: 3/19/99
;;;
;;; Purpose: Classes and methods to implement schema management.
;;;

(in-package :expresso)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Data set management.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defclass abstract-schema ()
  ((name :accessor name :initarg :name)
   ;; name interned in express-user package is interned-name
   (interned-name :accessor interned-name :initarg :interned-name :initform nil)
   (short-name :accessor short-name :initform nil)
   (schema-pathname :initarg :schema-pathname :accessor schema-pathname :initform nil 
		    :initarg :classes-path) ; used in mofi:ensure-model
   (direction :reader direction :initform nil) ; Set by an express-x file, others return nil.
   (schema-mm :accessor schema-mm :initform nil :initarg :schema-mm)))

(defclass express-schema (abstract-schema)
  ((entity-type-names :accessor entity-type-names :initform nil)
   (programmatic-type-names :accessor programmatic-type-names :initform nil)
   (lisp-package :reader lisp-package :initform :lisp-package)
   (function-names :accessor function-names :initform nil)
   (constant-names :accessor constant-names :initform nil)
   (type-names :accessor type-names :initform nil)
   (entity-types :accessor entity-types :initform (make-hash-table))
   (defined-types :accessor defined-types :initform (make-hash-table))
   (accessors :accessor accessors :initform (make-hash-table))
   (global-rules :accessor global-rules :initform (make-hash-table :size 100))
   (version :accessor version :initform nil)))

	 
	 

;;;=================== End MOFI Compatibility Stuff ============ 

;;; 2012
(defmethod mofi:model-name ((obj express-schema)) (name obj))
(defmemo mofi-types (schema) 
    (with-slots (entity-type-names) schema
      (make-array (length entity-type-names)
		  :initial-contents (mapcar #'find-class entity-type-names))))

(defmethod mofi:types ((obj express-schema)) (mofi-types obj))
(defmethod mofi:nicknames ((obj express-schema)) (list (name obj)))
(defun of-model (arg) (slot-value arg 'mofi:of-model))
;;; Man, is this cheap!
(defun model-name (arg) (declare (ignore arg))  "Part2")


;;;================ Pre-2012 ==============================================

;;; hmmm... In 2012 I commented out the method below, mofi:load-model

;;; POD an express-schema is not even and mofi:abstract-model, but
;;; the idea is to get it that way someday. 
;;; mofi:find-model works with express-schema
#+nil 
(defmethod mofi:load-model ((m express-schema) &key)
  (unless (find-package (name m))
    (make-package (name m) :use '(:expo :pod-utils :cl)))
  (clear-schema m)
  (setf mofi:*essential-models* 
	(remove (name m) mofi:*essential-models* :key #'mofi:model-name))
  (with-slots (schema-pathname) m
    (load-project-file 
     (make-instance 'expo::lisp-compiled-express-file 
		    :path schema-pathname
		    ;:compiled-from "ap233-arm-lf-20090502v1.exp"
		    ;:short-name "ap233.lisp"
		    )))
  (push (expo:find-schema (name m)) mofi:*essential-models*)
  (loop for class being the hash-value of (entity-types m)
     do (mofi::class-finalize-slots class)))

;;;=================== End MOFI Compatibility Stuff ============ 

(defclass express-2-schema (express-schema)
  ;; These are used in ensure-model, but not yet in schema.
  ((ignore-slot :initarg :force 
		:initarg :verbose
		:initarg :documentation
		:initarg :package-use-list
		:initarg :model-n+1)))



(defclass map-schema (abstract-schema)
  ((views :initform nil :accessor views)
   (view-infos :initform nil :accessor view-infos)
   (maps :initform (make-hash-table) :accessor maps)
   (map-infos :initform (make-hash-table) :accessor map-infos)
   (target-schema-name :initform nil :accessor target-schema-name)
   (source-schema-name :initform nil :accessor source-schema-name)))

(defun remove-stale-datasets (schema)
  (with-accessors ((datasets datasets)) *expresso*
    (loop for dataset in datasets
          when (and (typep dataset 'express-dataset)
                    (slot-boundp dataset 'file-schema)
                    (string-equal (file-schema dataset) (name schema)))
          do (info-message "~2% Removing dataset \"~a\". It is invalid after (un)loading its schema."
                           (name dataset))
          (remove-dataset dataset *expresso*))))

(defmethod add-schema (schema (frame Expresso))
  (remove-stale-datasets schema)
  (with-accessors ((schemas schemas)) frame
    (setf schemas (remove (name schema) schemas :key #'name :test #'string=))
    (push schema schemas))
  schema)

(defmethod remove-schema :around ((schema abstract-schema) (frame t) &key)
  (remove-stale-datasets schema)
  (with-accessors ((schemas schemas) (datasets datasets)) *expresso*
    (when (eql (schema *expresso*) schema)
      (setf (schema *expresso*) (find schema schemas :test #'(lambda (x y) (not (eql x y))))))
    (setf schemas (remove schema schemas))
    (call-next-method)))

(defmethod remove-schema ((schema express-schema) (frame t) &key)
  (remove-schema-alias (name schema))
  (clear-schema schema))

(defmethod remove-schema ((schema map-schema) (frame t) &key)
  nil)

(defmethod remove-schema ((schema t) (frame t) &key)
  "In case removed while there was no schema."
  nil)

(defmethod clear-schema ((schema express-schema))
  (clear-memoize 'expo::using_representations) ; PODsampson was eu::
  (clear-instantiated-types schema)
  (with-slots (entity-types 
               entity-type-names
	       programmatic-type-names
               defined-types
               global-rules
               accessors) schema
    (clrhash entity-types)
    #+LispWorks (clrhash accessors)
    (clrhash defined-types)
    (clrhash global-rules)
    (setf entity-type-names nil)
    (loop for s in programmatic-type-names do (setf (find-class s) nil))
    (setf programmatic-type-names nil))
  schema)

(defmethod clear-schema ((schema map-schema))
  ())

(defmethod clear-schema ((schema null))
  nil)

(defmethod clear-bindings ((schema map-schema))
  (with-slots (views maps) schema
    ;; seems like views and maps are hash-tables
    (when views
      (loop for view being the hash-values of views
	    do (clear-bindings view)))
    (when maps
      (loop for map being the hash-values of maps
	    do (clear-bindings map)))))

;;;---- Express-schema subclass -----
(defmethod initialize-instance :after ((schema abstract-schema) &key name)
  (setf (short-name schema) (name2initials name))
  (setf (interned-name schema) (kintern name)))

(defmethod print-object ((schema express-schema) stream)
  (with-slots (name) schema
    (print-unreadable-object (schema stream :type t :identity nil)
      (princ name stream))))

(defmethod print-object ((schema map-schema) stream)
  (with-slots (name) schema
    (print-unreadable-object (schema stream :type t :identity nil)
      (princ name stream))))

(defun find-schema (name &key (key #'name) (test #'string-equal) 
                         (schemas (schemas *expresso*)) type error)
  (let ((schemas (if type 
                     (remove-if (complement #'(lambda (x) (typep x type))) schemas)
                   schemas)))
    (or
     (find name schemas :key key :test test)
     (let ((alias (alias-find name *expresso* :key #'name :test #'string-equal :error nil)))
       (when alias (for-schema alias)))
     (when error (error 'no-loaded-schema :name name)))))

;; Schema-Alias methods
(defmethod alias-add (alias (frame Expresso))
  (with-accessors ((schema-aliases schema-aliases)) frame
    (setf schema-aliases (remove alias schema-aliases))
    (push alias schema-aliases))
  alias)

(defmethod alias-remove (name (frame Expresso) &key (key #'identity) (test #'eql))
  (with-accessors ((schema-aliases schema-aliases)) frame
    (setf schema-aliases (remove name schema-aliases :key key :test test))))

(defmethod alias-find (name (frame Expresso) &key (key #'identity) (test #'eql) error)
  (with-accessors ((schema-aliases schema-aliases)) frame
    (let ((alias (find name schema-aliases :key key :test test)))
      (or alias (when error (error 'unknown-schema-alias :name name))))))

(defun ensure-schema (type &key name schema-pathname interned-name schema-mm lisp-package)
  "Create new or return existing with the argument name.
   Args: name - a string.
         type - a symbol in this package, either express-schema or map-schema."
  (when-bind (found-schema (find-schema name))
    (when (or (and (or (eql type 'express-schema) 
		       (eql type 'express-2-schema))
		   (typep found-schema 'map-schema))
              (and (eql type 'map-schema) (typep found-schema 'express-schema)))
      (error 'duplicate-schema-names :schema-name name)))
  (let ((schema 
         (or (and name (find-schema name :type type))
             (make-instance type :name name))))
    ;; ensure-schema can update these three attributes:
    (when schema-pathname (setf (slot-value schema 'schema-pathname) schema-pathname))
    (when lisp-package
      (setf (slot-value schema 'lisp-package)
	    (or (find-package (kintern lisp-package))
		(make-package (kintern lisp-package) :use '(:cl :pod-utils :expo)))))
    (when interned-name (setf (slot-value schema 'interned-name) (kintern interned-name)))
    (when schema-mm (setf (slot-value schema 'schema-mm) schema-mm))
    ;; POD 2004 maps hash-table is becoming terribly screwed up on subsequent executions!
    (when (eql type 'map-schema)
      (setf (maps schema) (make-hash-table))
      (setf (map-infos schema) (make-hash-table)))
    (add-schema schema *expresso*)
    ;; 2007 Did I really want short-name to be an alias?
    (when-bind (short-name (schema-name-strip-object-reference name))
      (ensure-schema-alias :name short-name :schema-name name))
    schema))

;;;==========================================================================
;;; Schema alias management
;;;==========================================================================
(defclass schema-alias ()
  ((name :accessor name :initarg :name)	; a string
   (schema-name :accessor schema-name :initarg :schema-name) ; a string
   (interned-alias-name :reader interned-alias-name)
   (interned-schema-name :reader interned-schema-name)
   (for-schema :reader for-schema)        ; points to the schema
   (direction :accessor direction :initarg :direction)))      ; :target or :source

;; short-name is an accessor on abstract-schema here we'll just
;; redirect to that function
(defmethod short-name ((schema schema-alias))
  (with-slots (for-schema) schema
    (short-name for-schema)))

(defun add-alias (alias)
  (alias-add alias *expresso*))

(defun remove-alias (name &key (key #'identity) (test #'eql))
  (alias-remove name *expresso* :key key :test test))

(defun find-alias (name &key (key #'identity) (test #'eql))
  (alias-find name *expresso* :key key :test test))

(defmethod initialize-instance :after ((alias schema-alias) &key schema-name direction)
  (let ((schema (find-schema schema-name)))
    (unless schema
      (alert-message "A schema named ~a~%~
		      is referenced but no such schema is known.~%~
		      Load the schema." schema-name)
      (abort? *expresso*))
    ;; POD I don't know how cool it is to modify another object in an initialize-instance...
    (setf (slot-value schema 'direction) direction)
    (setf (slot-value alias 'for-schema) schema)
    (setf (slot-value alias 'interned-schema-name) (kintern schema-name)) ; PODsampson both were euintern.
    (setf (slot-value alias 'interned-alias-name)  (kintern (name alias)))
    (add-alias alias)))

(defun ensure-schema-alias (&key name schema-name direction)
  (let ((alias
         (or (find name (get-special schema-aliases) :key #'name :test #'string-equal)
             (make-instance 'schema-alias 
                            :name name
                            :schema-name schema-name
                            :direction direction))))
    (when name (setf (name alias) name))
    (when schema-name (setf (schema-name alias) schema-name))
    (add-alias alias)
    (update-schema-aliases)
    alias))
  
(defmethod print-object ((alias schema-alias) stream)
  (with-slots (name schema-name) alias
    (print-unreadable-object (alias stream :type t)
      (format stream "~A for ~A" name schema-name))))

(defun remove-schema-alias (schema-name)
  "Sets the schema-alias special variable.
   ARG: A string that names a schema and is the schema-name of a schema-alias."
  (remove-alias schema-name :key #'schema-name :test #'string-equal))

(defun update-schema-aliases ()
  "Update the for-schema slot of all aliases."
  (loop for schema in (schemas *expresso*)
        do (loop for alias in (get-special schema-aliases)
                 when (string-equal (name schema) (schema-name alias))
		 do (setf (slot-value alias 'for-schema) schema))))

(defun schema-load-namespace (names)
  (let ((schema (schema *expresso*)))
    (setf (function-names schema) (cdr (assoc :functions names)))
    (setf (constant-names schema) (cdr (assoc :constants names)))
    (setf (type-names schema) (cdr (assoc :types names)))))
                              


