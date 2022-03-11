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
;;; Date: 12/10/95
;;;
;;; Purpose: Defines express types. These are used, for example,
;;;          as type-descriptors of express-aggregates (value
;;;          bearing things that are greated by reading p21 data,
;;;          for example.
;;;
;;; Maybe these should probably be called type descriptors? That is
;;; what they are.
;;;
;;; Consider however that entity-typ (defined in express-metaobjects)
;;; is one of these.

(in-package :expresso)

;;; ---- Single instance metaclass is used for some simple express types.

(defclass single-instance (standard-class)
  ((instance :accessor instance :initform nil)))

(defmethod make-instance ((class single-instance) &rest initargs)
  (declare (ignore initargs))
  (let ((instance (instance class)))
    (cond (instance instance)
	  (t (setf (instance class)
		   (call-next-method))
	     (instance class)))))

(eval-when (load eval)
  (finalize-inheritance (find-class 'single-instance)))
	  

;;; POD for now data-type conflicts with a symbol in the parser.
;;; POD Consider making a few of these single instance, even when
;;;     that is an over-simplification.
(defclass data-typ ()  
  ())
  
(defclass simple-typ (data-typ)
  ())

(defclass named-typ (data-typ)
  ((name :accessor name :initarg :name)))

(defclass aggregation-typ (data-typ)
  ((l-bound :accessor l-bound :initarg :l-bound :initform nil)
   (u-bound :accessor u-bound :initarg :u-bound :initform nil)
   (base-type :accessor base-type :initarg :base-type)))

(defmethod initialize-instance :after ((type aggregation-typ)
				       &rest initargs)
  (declare (ignore initargs))
  ())

(defclass constructed-typ (data-typ)
 ((extensible :accessor extensible :initarg :extensible :initform nil)
  (extension :accessor extension :initarg :extension :initform nil)))

(defclass generalized-typ (data-typ)
  ((parameter-type :accessor parameter-type :initarg :parameter-type)))

;;----Simple Type
(defclass binary-typ (simple-typ)
  ((width   :accessor width   :initarg :width)
   (fixed-p :accessor fixed-p :initarg :fixed-p)))

(defclass boolean-typ (simple-typ)
  ()
  #+Allegro
  (:metaclass single-instance))


(defclass logical-typ (simple-typ)
  ()
  #+Allegro
  (:metaclass single-instance))

(defclass number-typ (simple-typ)
  ()
  #+Allegro
  (:metaclass single-instance))

;;; POD specialization of number but no precision?
(defclass real-typ (number-typ) 
  ((precision :accessor precision :initarg :precision :initform nil)))

(defclass integer-typ (real-typ)
  ()
  #+Allegro
  (:metaclass single-instance))

(defclass string-typ (simple-typ)
  ((width :accessor width :initarg :width :initform nil)
   (fixed-p :accessor fixed-p :initarg :fixed-p :initform nil)))

;;----Named Type

; Defined in express-metaobjects as
;(defclass express-entity-type-mo (named-type)
;  ())

(defclass defined-typ (named-typ)
  ())

;;----Aggregation Type
(defclass array-typ (aggregation-typ)
  ((optional :accessor optional :initarg :optional :initform nil)
   (unique :accessor unique :initarg :unique :initform nil)))

(defclass bag-typ (aggregation-typ)
  ())

(defclass list-typ (aggregation-typ)
  ((unique :accessor unique :initarg :unique :initform nil)))

(defclass set-typ (aggregation-typ)
  ())

;;----Generalized Type
(defclass generic-typ (generalized-typ)
  ((type-label :accessor type-label :initarg :type-label)))

(defclass aggregate-typ (generalized-typ)
  ((type-label :accessor type-label :initarg :type-label)))

(defclass generalized-array-typ (aggregate-typ array-typ)
  ())

(defclass generalized-bag-typ (aggregate-typ bag-typ)
  ())

(defclass generalized-list-typ (aggregate-typ list-typ)
  ())

(defclass generalized-set-typ (aggregate-typ set-typ)
  ())

;;----Constructed Type
(defclass enum-typ (constructed-typ)
  ((enumeration-list :accessor enumeration-list :initarg :enumeration-list :initform nil)))

(defclass select-typ (constructed-typ)
  ((select-list :accessor select-list :initarg :select-list :initform nil)
   (sextend :accessor sextend :initarg :sextend :initform nil) ; pod unused.
   (generic-entity-p :accessor generic-entity-p :initarg :generic-entity-p :initform nil)))

;;; Correct the problem of simple types in the select list. They come through
;;; as symbols of type <schema-name>.string etc. 
(defmethod shared-initialize :after ((stype select-typ) slot-names &rest initargs)
  (declare (ignorable slot-names initargs))
  (with-slots (select-list) stype
    (setf select-list 
          (append
           (remove-if (complement #'find-class) select-list) ; PODsampson find-eu-class
           (mapcar #'(lambda (x) 
                       (let ((base-name x))
                         (cond ((string= base-name "STRING")  (make-instance 'string-typ))
                               ((string= base-name "INTEGER") (make-instance 'integer-typ))
                               ((string= base-name "REAL")    (make-instance 'real-typ))
                               ((string= base-name "NUMBER")  (make-instance 'number-typ))
                               ((string= base-name "BINARY")  (make-instance 'binary-typ)))))
                   (remove-if #'find-class select-list)))))) ; PODsampson find-eu-class

;;;==================================================
;;; PRINT-OBJECTs for -typ
;;;==================================================
;(defmacro strcat (&rest strings)
;  `(concatenate 'string ,@strings))

(defmethod p11-string ((type express-effective-slot-definition) accum (encoding (eql :text)) &key)
  (with-slots (optional express-type) type
    (format nil "~A~:[~;OPTIONAL ~]~A" accum optional
	    (p11-string express-type "" :text))))

(defmethod p11-string ((type express-direct-slot-definition) accum (encoding (eql :text)) &key)
  (with-slots (optional express-type) type
    (format nil "~A~:[~;OPTIONAL ~]~A" accum optional
	    (p11-string express-type "" :text))))

#+express-x
(defmethod p11-string ((type view-effective-slot-definition) accum (encoding (eql :text)) &key)
  (with-slots (express-type) type
    (p11-string express-type accum :text)))

(defmethod p11-string ((type express-defined-type-mo) accum (encoding (eql :text)) &key)
  (format nil "~A~(~A~)" accum (class-name type))) ; PODsampson class-name was short-name

(defmethod p11-string ((type express-entity-type-mo) accum (encoding (eql :text)) &key)
  (format nil "~A~(~A~)" accum (class-name type))) ; PODsampson class-name was short-name

#+express-x
(defmethod p11-string ((type view-mo) accum (encoding (eql :text)) &key)
  (format nil "~A~A (a view)" accum (class-name type)))

(defmethod p11-string ((type forward-referenced-class) accum (encoding (eql :text)) &key)
  (format nil "~A~(~A~)" accum (class-name type))) ; PODsampson s-s-qualifier

(defmethod p11-string ((type t) accum (encoding (eql :text)) &key)
  (format nil "~A*expressify* " accum))

(defmethod p11-string ((type array-typ) accum (encoding (eql :text)) &key)
  (declare (special *data-creator-printing*))
  (with-slots (l-bound u-bound optional unique base-type) type
    (if (not *data-creator-printing*)
	(call-next-method)
      (format nil "~AARRAY [~A:~A] OF~:[~; OPTIONAL~]~:[~; UNIQUE~] ~A"
	      accum l-bound u-bound optional unique
	      (p11-string base-type "" :text)))))

(defmethod p11-string  ((type set-typ) accum (encoding (eql :text)) &key)
  (declare (special *data-creator-printing*))
  (with-slots (l-bound u-bound base-type) type
    (format nil "~ASET~:[~2*~; [~A:~A]~] OF ~A" accum
	    (or l-bound u-bound) (or l-bound "?") (or u-bound "?")
	    (p11-string base-type "" :text))))

(defmethod p11-string  ((type list-typ) accum (encoding (eql :text)) &key)
  (with-slots (l-bound u-bound unique base-type) type
    (format nil "~ALIST~:[~2*~; [~A:~A]~] OF~:[~; UNIQUE~] ~A"
	    accum (or l-bound u-bound) (or l-bound "?") (or u-bound "?")
	    unique (p11-string base-type "" :text))))

(defmethod p11-string  ((type bag-typ) accum (encoding (eql :text)) &key)
  (with-slots (l-bound u-bound base-type) type
    (format nil "~ABAG~:[~2*~; [~A:~A]~] OF ~A" accum (or l-bound u-bound)
	    (or l-bound "?") (or u-bound "?")
	    (p11-string base-type "" :text))))

(defmethod p11-string  ((type named-typ) accum (encoding (eql :text)) &key)
  (format nil "~A~A" accum (name type)))

(defmethod p11-string  ((type simple-typ) accum (encoding (eql :text)) &key)
  (format nil "~A~A" accum
	  (typecase type
	    (number-typ  "NUMBER")
	    (logical-typ "LOGICAL")
	    (boolean-typ "BOOLEAN"))))

(defmethod p11-string ((type integer-typ) accum (encoding (eql :text)) &key)
  (format nil "~AINTEGER" accum))

(defmethod p11-string ((type real-typ) accum (encoding (eql :text)) &key)
  (with-slots (precision) type
    (format nil "~AREAL~@[ [~A]~]" accum precision)))

(defmethod p11-string ((type string-typ) accum (encoding (eql :text)) &key)
  (with-slots (width fixed-p) type
    (format nil "~ASTRING~@[ [~A]~]~:[~; FIXED~]" accum width fixed-p)))

(defmethod p11-string ((type binary-typ) accum (encoding (eql :text)) &key)
  (with-slots (width fixed-p) type
    (format nil "~ABINARY~@[ [~A]~]~:[~; FIXED~]" accum width fixed-p)))


;;;=========================================================
;;; instance-of is given a type descriptor. It returns
;;; a list of some elements of that type.
;;;=========================================================
(defmethod instances-of :around ((type t) dataset)
  (unless (and (null dataset)
               (typep type 'express-entity-type-mo))
    (remove-duplicates
     (remove-duplicates
      (remove-duplicates
       (remove-if #'null (call-next-method))
       :test #'(lambda (x y) (and (stringp x) (stringp y) (string= x y))))
      :test #'(lambda (x y) (and (numberp x) (numberp y) (= x y)))))))

(defmethod instances-of ((type simple-typ) dataset)
  (declare (ignore dataset))
  nil)

(defmethod instances-of ((type binary-typ) dataset)
  (declare (ignore dataset))
  '("\"0000\""))

(defmethod instances-of ((type boolean-typ) dataset)
  (declare (ignore dataset type))
  (list (make-p21-boolean-ref :-value ".T." :-keyword :t)
        (make-p21-boolean-ref :-value ".F." :-keyword :f)))

(defmethod instances-of ((type integer-typ) dataset)
  (declare (ignore dataset type))
  '(0))

;;; POD p21-logical-ref and p21-boolean-ref are really poorly conceived, the name, everything!
(defmethod instances-of ((type logical-typ) dataset)
  (declare (ignore dataset type))
  (list (make-p21-logical-ref :-value ".T." :-keyword :t)
        (make-p21-logical-ref :-value ".F." :-keyword :f)
        (make-p21-logical-ref :-value ".U." :-keyword :u)))

(defmethod instances-of ((type number-typ) dataset)
  (declare (ignore dataset type))
  '(1.0))

(defmethod instances-of ((type real-typ) dataset)
  (declare (ignore dataset type))
  '(1.0))

(defmethod instances-of ((type string-typ) dataset)
  (declare (ignore dataset type))
  '("''"))

(defmethod instances-of ((type enum-typ) dataset)
  (declare (ignore dataset type))
  '(".ENUM."))

(defmethod instances-of ((type aggregation-typ) dataset)
  (instances-of (slot-value type 'base-type) dataset))

(defmethod instances-of ((type express-entity-type-mo) dataset)
  (append
   (ht2list (extent type dataset))
   (mapappend
    #'(lambda (x) (ht2list (extent x dataset)))
    (remove-if (complement #'(lambda (x) (typep (class-of x) 'express-entity-type-mo)))
	       (class-direct-superclasses type)))))

;;; POD Someday you may have subtypes of views, and will want to repeat what is above for these.
#+pod7
(defmethod instances-of ((type view-mo) dataset)
  (ht2list (extent type dataset)))

(defmethod instances-of ((type forward-referenced-class) dataset)
  (instances-of (find-class (class-name type)) dataset)) ;PODsampson find-eu-class

(defmethod instances-of ((type express-defined-type-mo) dataset)
  (let ((ints (instances-of (type-descriptor type) dataset)))
    (loop for i in ints 
          if (or (typep i 'number) 
                 (typep i 'string) 
                 (typep i 'p21-boolean-ref) 
                 (typep i 'p21-logical-ref))
          collect (make-instance 'defined-value :value i :record-of-types (class-name type))
          else collect i)))

(defmethod instances-of ((type select-typ) dataset)
 (mapappend #'(lambda (x) (instances-of x dataset)) (select-list type)))

(defmethod instances-of ((type symbol) dataset)
  (when-bind (class (find-class type)) ; ;PODsampson find-eu-class
    (instances-of class dataset)))

;;; Collects all the underlying types of a type from its (potentially many) select types. 
;;; Collects the select type too. Doesn't go after subtypes of entity types.
(defun collect-underlying-types (type)
  (remove type ; PODsampson added
	  (remove-if #'null (flatten (collect-underlying-types-aux type nil)))))

(defmethod collect-underlying-types-aux ((type symbol) accum)
  (when-bind (class (find-class type)) ; ;PODsampson find-eu-class
    (collect-underlying-types-aux class accum)))
  
(defmethod collect-underlying-types-aux ((type simple-typ) accum)
  (cons type accum))

(defmethod collect-underlying-types-aux ((type enum-typ) accum)
  (append (list type) accum))

(defmethod collect-underlying-types-aux ((type aggregation-typ) accum)
  (collect-underlying-types-aux (base-type type) accum))

(defmethod collect-underlying-types-aux ((type express-defined-type-mo) accum)
  (collect-underlying-types-aux (type-descriptor type) accum))

(defmethod collect-underlying-types-aux ((type express-entity-type-mo) accum)
  (cons type accum))

#+pod7
(defmethod collect-underlying-types-aux ((type view-mo) accum)
  accum)

(defmethod collect-underlying-types-aux ((type forward-referenced-class) accum)
  (let ((real-class (find-class (class-name type)))) ;PODsampson find-eu-class
    (cond ((typep real-class 'forward-referenced-class)
           (express-error bad-entity "Infinite loop searching for type ~a" type))
          (t (collect-underlying-types-aux real-class accum)))))

(defmethod collect-underlying-types-aux ((type select-typ) accum)
  (append
   (list type)
   (mapappend #'(lambda (x) 
		  (collect-underlying-types-aux x nil)) (select-list type))
   accum))

#| POD don't remove yet. Might be the right algorithm for use elsewhere.
(defun wrap-with-select-keywords (values type)
  (let ((select-keywords 
         (remove-if #'(lambda (x) (typep x 'simple-typ))
                    (mapappend
                     #'select-list
                     (remove-if (complement  #'(lambda (x) (typep x 'select-typ)))
                                (cons type (collect-underlying-types type)))))))
    (cond (select-keywords
           (let* ((instances (remove-if (complement #'(lambda (x) (typep x 'entity-root-supertype)))
                                        values))
                  (others (set-difference values instances)))
             (cond (others
                    (append
                     instances
                     (loop for other in others append
                           (loop for keyword in select-keywords
                                 collect (format nil "~a(~a)" (strip-schema-qualifier keyword) other)))))
                   (t instances))))
          (t values))))
|#


(defun base-types (typ)
  "Return a list of keywords describing the type of possible base types :entity, :integer etc."
  (remove-duplicates
   (base-types-aux typ)))

;;; POD modified 2009-06-12 to capture non-entity types.
(defmethod base-types-aux ((typ select-typ) &optional accum)
  (append accum (mapappend #'base-types-aux (collect-underlying-types typ))))

(defmethod base-types-aux ((type express-entity-type-mo) &optional accum)
  (cons :entity accum))

(defmethod base-types-aux ((type forward-referenced-class) &optional accum)
  (cons :entity accum))

;;; Defined type
(defmethod base-types-aux ((type express-defined-type-mo) &optional accum)
  (append 
   accum
   (base-types-aux (type-descriptor type) nil)))

(defmethod base-types-aux ((typ binary-typ) &optional accum)
  (cons :binary accum))

(defmethod base-types-aux ((typ boolean-typ) &optional accum)
  (cons :boolean accum))

(defmethod base-types-aux ((typ integer-typ) &optional accum)
  (cons :integer accum))

(defmethod base-types-aux ((typ logical-typ) &optional accum)
  (cons :logical accum))

(defmethod base-types-aux ((typ number-typ) &optional accum)
  (cons :number accum))

(defmethod base-types-aux ((typ real-typ) &optional accum)
  (cons :real accum))

(defmethod base-types-aux ((typ string-typ) &optional accum)
  (cons :string accum))

(defmethod base-types-aux ((typ enum-typ) &optional accum)
  (cons :enumeration accum))

(defmethod base-types-aux ((type aggregation-typ) &optional accum)
  (cons :aggregate accum))

(defun express-typep (val typ)
  "The argument typ is a typ (a base type, never a select-typ.)"
  (when (or (eql val :?) (eql val :*)) (return-from express-typep t))
  (when (typep val 'defined-value) 
    (setf val (value val)))
  (typecase val
    (express-array 
     ;; POD If called from check-type-in-attribute, will be passing base-type typ (a mistake)
     ;; but I let it through if the typ corresponds here. (test against ap209 and fv5.stp).
     (let ((td (type-descriptor val)))
       (loop for ix from (l-bound td) to (u-bound td) do
             (when (null (express-typep (express-aref val ix) typ))
               (return-from express-typep nil)))
       (return-from express-typep t)))
    (express-aggregate 
     (loop for elem in val do 
           (when (null (express-typep elem typ))
             (return-from express-typep nil)))
       (return-from express-typep t)))
  (typecase typ
    (string-typ (stringp val))
    (number-typ (numberp val))
    (integer-typ (unless (numberp val)))
    (enum-typ 
     (let ((enum-list  (enumeration-list typ)))
       (typecase val
         (p21-enumeration-ref (find (p21-enumeration-ref--keyword val) enum-list))
         (otherwise (find val enum-list)))))
    (real-typ (typep val 'float))
    (express-entity-type-mo 
     (cond ((not (typep val 'entity-root-supertype))
            nil)
           (t
            (find (class-name typ) (express-class-list (class-of val))))))
    (boolean-typ 
     (and (typep val 'p21-boolean-ref)
          (setf val (p21-boolean-ref--keyword val))
          (or (eql val :t) (eql val :f))))
    (logical-typ 
     (and (typep val 'p21-logical-ref)
          (setf val (p21-logical-ref--keyword val))
          (or (eql val :t) (eql val :f) (eql val :u))))
    ;; Bogus?
    (binary-typ (stringp val))))

(defmacro express-assert (type val)
  "Like ocl-assert."
  `(unless (express-typep ,val ,type)
    (error "~%~A is not of type ~A" ,val ,type)))
  



