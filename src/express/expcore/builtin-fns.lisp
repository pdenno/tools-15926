
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
;;; Date: 8/7/96
;;; Purpose:  Defines express built-in functions

(in-package :expo)

;;; A structure to represent a reference to another entity.
;;; Slots: -value an integer that points into the entity hash table.
;;; POD Will the idea be to lazily replace these?
(defstruct (p21-entity-ref
	    (:print-function
	     (lambda (struct stream k)
	       (declare (ignore k))
	       (format stream "#~a" (p21-entity-ref--value struct)))))
  -value)

;;; A structure to represent a reference to an express enumeration value.
;;; Slots: -value - the string value, like ".RED."
;;;        -keyword - the string coerced to a keyword.
(defstruct (p21-enumeration-ref
	    (:print-function
	     (lambda (struct stream k)
	       (declare (ignore k))
	       (format stream "~a" (p21-enumeration-ref--value struct)))))
  -value
  -keyword)

(defstruct p21-boolean-logical-select 
	   -value
	   -keyword)

(defstruct (p21-boolean-ref  (:include p21-boolean-logical-select)
	    (:print-function
	     (lambda (struct stream k)
	       (declare (ignore k))
	       (format stream "~a" (p21-boolean-ref--value struct)))))
  )

	    
(defstruct (p21-logical-ref (:include p21-boolean-logical-select)
	    (:print-function
	     (lambda (struct stream k)
	       (declare (ignore k))
	       (format stream "~a" (p21-logical-ref--value struct)))))
  )


;;; A structure to represent a binary value.
;;; Slots: -p21-encoding how it should print as a binary.
;;;        -value base 10 value.
(defstruct (p21-binary-ref
	    (:print-function
	     (lambda (struct stream k)
	       (declare (ignore k))
	       (format stream "~a" (p21-binary-ref--p21-encoding struct)))))
  -p21-encoding
  -value)

;;; Built-in Constants

;; we may want to find a better way to setup this constant
(defconstant CONST_E 2.71828182)

(declaim (inline express-simple-type-p))
(defun express-simple-type-p (val)
  (when (typep val 'defined-value) (setf val (value val)))
  (or (stringp val)
      (find (type-of val) '(single-float fixnum :? symbol))
      (keywordp val)))

;;; See LRM 12.11 
(defun type-compatible-p (arg1 arg2)
  (type-compatible-p-method arg1 arg2))

(eval-when (:execute :load-toplevel)
  (memoize 'type-compatible-p))

(defmethod type-compatible-p-method ((arg1 t) (arg2 t))
  "Purpose: Implements type compatibility (LRM 12.11)"
  (eql arg1 arg2))

;;; Express-Entity-Type-Mo is the class object
(defmethod type-compatible-p-method ((arg1 instantiable-express-entity-type-mo) 
				     (arg2 instantiable-express-entity-type-mo))
  (eql arg1 arg2))

(defmethod type-compatible-p-method ((arg1 forward-referenced-class) 
			             (arg2 forward-referenced-class))
  (type-compatible-p-method
   (find-class (class-name arg1))
   (find-class (class-name arg2))))


;;; Entity-Root-Supertype is an instance.
(defmethod type-compatible-p-method ((arg1 entity-root-supertype) (arg2 entity-root-supertype))
  (let* ((c1 (class-of arg1))
	 (c2 (class-of arg2)))
    (or (equal c1 c2)
	(null (set-difference 
	       (class-direct-superclasses c1)
	       (class-direct-superclasses c2)))
	(null (set-difference 
	       (class-direct-superclasses c2)
	       (class-direct-superclasses c1))))))

(defmethod type-compatible-p-method ((arg1 express-defined-type-mo) (arg2 express-defined-type-mo))
  (type-compatible-p ;; Note, we go back to hash it.  
   (type-descriptor arg1)
   (type-descriptor arg2)))

(defmethod type-compatible-p-method ((arg1 express-defined-type-mo) arg2)
  (type-compatible-p-method
   (type-descriptor arg1)
   arg2))

;;; Express-Defined-Type-Mo is the metaobject.
(defmethod type-compatible-p-method (arg1 (arg2 express-defined-type-mo))
  (type-compatible-p-method
   arg1
   (type-descriptor arg2)))

(defmethod type-compatible-p-method ((arg1 select-typ) (arg2 select-typ))
  (let ((sl1 (select-list arg1))
	(sl2 (select-list arg2)))
    (or (not (set-difference sl1 sl2))
	(not (set-difference sl2 sl1)))))

;;; Works even where single-instance-metaclass doesn't.
(defmethod type-compatible-p-method ((arg1 simple-typ) (arg2 simple-typ))
    (eql (class-name (class-of arg1))
	 (class-name (class-of arg2))))

(defmethod type-compatible-p-method ((arg1 number-typ) (arg2 number-typ))
  t)


(defmethod type-compatible-p-method ((arg1 express-array) (arg2 express-array))
  (let ((td1 (type-descriptor arg1))
	(td2 (type-descriptor arg2)))
    (and
     (eql (l-bound td1) (l-bound td2))
     (eql (u-bound td1) (u-bound td2))
     (type-compatible-p-method
      (base-type td1)
      (base-type td2)))))


(defmethod type-compatible-p-method ((arg1 express-list) (arg2 express-list))
  (type-compatible-p-method
   (base-type (type-descriptor arg1))
   (base-type (type-descriptor arg2))))

(defmethod type-compatible-p-method ((arg1 express-aggregate) (arg2 express-aggregate))
  (and
   (not (typep arg1 'express-array))
   (not (typep arg2 'express-array))
   (not (typep arg1 'express-list))
   (not (typep arg2 'express-list))
   (type-compatible-p-method
    (base-type (type-descriptor arg1))
    (base-type (type-descriptor arg1)))))

;;; Base type might be a TD itself (nested agg), thus need this.
(defmethod type-compatible-p-method ((arg1 aggregation-typ) (arg2 aggregation-typ))
  (type-compatible-p-method
   (base-type arg1)
   (base-type arg2)))



;;;6/29/98 From AP202 (IS):
;;;  ENTITY text_style_with_box_characteristics
;;;    SUBTYPE OF (text_style);
;;;      characteristics : SET [1:4] OF box_characteristic_select;
;;;    WHERE
;;;      wr1: SIZEOF(QUERY ( c1 <* SELF.characteristics 
;;;                           | (SIZEOF(QUERY ( c2 <* (SELF.characteristics - c1) 
;;;.... 
;;;This brings up the point that you can't use the defined type inferred from a 'select value'
;;;in doing type-compatibility checking. (You can't produce an error on it). 
;;;Given
;;;   characteristics = (BOX_HEIGHT(0.5),BOX_WIDTH(0.5),BOX_SLANT_ANGLE(0.0),BOX_ROTATE_ANGLE(0.0))
;;;(SELF.characteristics - c1) is valid because c1 is of type box_characteristic_select.
;;;It is wrong to infer that c1 is of type BOX_HEIGHT etc. 
;;;I DID NOT CHANGE TYPE-COMPATIBLE-P TODAY, I JUST THOUGHT ABOUT IT. 

(defmethod type-compatible-p-method :around ((arg1 t) (arg2 t))
  (cond ((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (type-compatible-p-method (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (type-compatible-p-method (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (type-compatible-p-method arg1 (value arg2)))
	(t (call-next-method))))

;(declaim (inline <>))
(defun <> (&rest args)
  (not (apply #'= args)))

;(declaim (inline bi-nvl))
(defun bi-nvl (arg default)
  (when (typep arg 'defined-value) (setq arg (value arg)))
  (if (indeterminate-p arg)
      default
    arg))

;(declaim (inline xor))
(defun xor (arg1 arg2)
  (when (typep arg1 'defined-value) (setq arg1 (value arg1)))
  (when (typep arg2 'defined-value) (setq arg2 (value arg2)))
  (and (or arg1 arg2)
       (not (and arg1 arg2))))

;(declaim (inline bi-exists))
(defun bi-exists (arg)
  (when (typep arg 'defined-value) (setq arg (value arg)))
  (not (indeterminate-p arg)))

;;; POD Who knows what is really intended.
(defun express-subseq (array index-1 index-2)
  "Return an express-bag containing the values in the argument
   express-array starting at index-1 and ending at index-2"
  (unless (<= index-1 index-2)
    (express-error index1-greater-than-index2 :index1 index-1 :index2 index-2))
  (make-instance 'express-bag
		  :type-descriptor (type-descriptor array)
		  :value (loop for i from index-1 to index-2
			       collect (express-aref array i))))

;;; POD 6/29/98 IN does not appear to suffer from the error (flaw?) I found in set difference. 
(defmethod in-internal (member (agg express-array))
 (with-type-descriptor (l-bound u-bound) agg
    (or ;; POD modified 4/1/98 express-equal --> express-instance-equal
     (loop for i from l-bound to u-bound
	   when (express-instance-equal member (express-aref agg i)) return t
	   finally (return nil))
     (loop for i from l-bound to u-bound
	   when (indeterminate-p (express-aref agg i))
	   do (return-from in-internal :?)))))

(defmethod in-internal (member (agg express-aggregate))
  (or ;; POD modified 4/1/98 express-equal --> express-instance-equal
   (find member (value agg) :test #'express-instance-equal)
   (when (find :? (value agg)) :?)))

;;; This one might only get used by express-mult (intersection)
(defmethod in-internal (member (agg list))
  (or ;; POD modified 4/1/98 express-equal --> express-instance-equal
   (find member agg :test #'express-instance-equal)
   (when (find :? agg) :?)))

(defmethod in-internal (arg1 arg2)
  (express-error incompatible-args :function 'in :args (list arg1 arg2)))

;;; pod should be named bi-in or express-in ....
(defun in (member agg)
  "Implement the Express Membership operator (LRM 12.2.3)"
  (when (typep member 'defined-value) (setf member (value member)))
  (cond ((indeterminate-p member) :?)
	((indeterminate-p agg) :?)
	(t (in-internal member agg))))

;;; POD This will change if you put a reference to the 
;;;     type descriptor in the array instead of duplicating.
;(declaim (inline bi-sizeof))
(defun bi-sizeof (agg)
  (cond ((indeterminate-p agg) :?)
        ((typep agg 'express-array)
	 (with-type-descriptor (l-bound u-bound) agg
  	  (1+ (- u-bound l-bound))))
	((listp agg) (length agg))
	(t (length (value agg)))))

(defun qualified-name-of-class (class-name)
  "If the symbol names a entity-root-supertype or express-defined-type-mo return
   the name string qualified by the schema name 'schema.name'"
  (when-bind (class (find-class (intern (string-upcase (string class-name))
					(mofi:lisp-package (schema *expresso*)))))
    (when (or (typep class 'express-entity-type-mo)
	      (typep class 'express-defined-type-mo))
      (format nil "~A.~A" (schema class) class-name))))

(defmethod typeof-internal ((v express-array))   '("ARRAY"))
(defmethod typeof-internal ((v express-bag))     '("BAG"))
(defmethod typeof-internal ((v express-list))    '("LIST"))
(defmethod typeof-internal ((v express-set))     '("SET"))
(defmethod typeof-internal ((v p21-binary-ref))  '("BINARY"))
(defmethod typeof-internal ((v p21-boolean-ref)) '("BOOLEAN"))
(defmethod typeof-internal ((v (eql :t)))        '("BOOLEAN"))
(defmethod typeof-internal ((v (eql :f)))        '("BOOLEAN"))
(defmethod typeof-internal ((v p21-logical-ref)) '("LOGICAL"))
(defmethod typeof-internal ((v (eql :?)))        '("LOGICAL" "BOOLEAN"))
(defmethod typeof-internal ((v integer))         '("INTEGER" "REAL" "NUMBER"))
(defmethod typeof-internal ((v real))            '("REAL" "NUMBER"))
(defmethod typeof-internal ((v number))          '("NUMBER"))
(defmethod typeof-internal ((v string))          '("STRING"))

(defmethod typeof-internal ((v entity-root-supertype))
  (let* ((class (class-of v))
	 (names (or (express-class-list class)
		    (p21-precedence-order (class-name class))))
	 (select-classes (mapappend #'selects-using names)))
    (append
     (mapcar #'qualified-name-of-class names) ; This isn't a multi-schema fn.
     (mapcar #'(lambda (class) (qualified-name-of-class (class-name class)))
	     select-classes)
     (mapappend #'typeof-internal select-classes))))

(defmethod typeof-internal ((v express-defined-type-mo))
  ;; Only select types...
  ;; POD never used??? Stuff setting accum does this?
  (when (typep (type-descriptor v) 'select-typ)
    (mapcar #'(lambda (class) (qualified-name-of-class (class-name class)))
	    (selects-using (class-name v)))))

;(defmethod bi-typeof ((v defined-value))
;  (let (result)
;    (setf result (mapcar #'qualified-name-of-class
;			 (append (record-of-types v)
;				 (mapcar #'class-name
;					 (mapappend #'selects-using (record-of-types v))))))
;    (append result
;	    (bi-typeof

(defun bi-typeof (v)
  "Implement the Express TYPEOF builtin (LRM 15.25)."
  (let* ((accum (when (typep v 'defined-value)
		  (mapcar #'qualified-name-of-class 
			  (append
			   (record-of-types v)
			   (mapcar #'class-name (mapappend #'selects-using (record-of-types v)))))))
	 (v (if (typep v 'defined-value) (value v) v))
	 (result (if (indeterminate-p v) nil (append accum (typeof-internal v))))
	 (len (length result)))
    (make-instance 'express-set :value result
      :type-descriptor (make-instance 'set-typ :l-bound len :u-bound len
				      :base-type (make-instance 'string-typ)))))
  
;;;--------------------------------------------------------------
;;; =  value equality, for entities, this looks at the attributes. 
(defmethod express-equal ((arg1 number) (arg2 number))
  (= arg1 arg2))

;;; The next four are to handle p21-boolean-logical-selects
(defmethod express-equal ((arg1 symbol) (arg2 t))
  (and arg1 arg2))

(defmethod express-equal ((arg1 t) (arg2 symbol))
  (and arg1 arg2))

(defmethod express-equal ((arg1 p21-boolean-logical-select) (arg2 t))
  (with-slots (-keyword) arg1
    (cond ((eql -keyword :t) arg2)
	  ((eql -keyword :f) (not arg2))
	  (t (eql -keyword arg2)))))

(defmethod express-equal ((arg1 t) (arg2 p21-boolean-logical-select))
  (with-slots (-keyword) arg2
    (cond ((eql -keyword :t) arg1)
	  ((eql -keyword :f) (not arg1))
	  (t (eql -keyword arg1)))))

(defmethod express-equal ((arg1 string) (arg2 string))
  (string= arg1 arg2))

;;; Used for enumerations
(defmethod express-equal ((arg1 symbol) (arg2 symbol))
  (eql arg1 arg2))

(defmethod express-equal ((arg1 p21-boolean-ref) (arg2 p21-boolean-ref))
  (eql 
   (p21-boolean-ref--keyword arg1)
   (p21-boolean-ref--keyword arg2)))

(defmethod express-equal ((arg1 express-array) (arg2 express-array))
  (unless (type-compatible-p arg1 arg2)
    (express-error incompatible-args :function "Array-Equal" :args (list arg1 arg2)))
  (with-type-descriptor (l-bound u-bound) arg2
    (loop for i from l-bound to u-bound
	  unless (express-equal
		  (express-aref arg1 i)
		  (express-aref arg2 i))
	  return nil
	  finally (return t))))

(defmethod express-equal ((arg1 express-list) (arg2 express-list))
  (unless (type-compatible-p arg1 arg2)
    (express-error incompatible-args :funciton "List-Equal" :lists (list arg1 arg2)))
  (equal (value arg1) (value arg2)))

(defmethod express-equal ((arg1 express-aggregate) (arg2 express-aggregate))
  (unless (type-compatible-p arg1 arg2)
    (express-error incompatible-args :function "Aggregate-Equal" :aggregates (list arg1 arg2)))
  (and (= (bi-sizeof arg1) (bi-sizeof arg2))
       (null (set-difference (value arg1) (value arg2)
			     :test #'express-equal))
       (null (set-difference (value arg1) (value arg2)
			     :test #'express-equal))))

;;; POD I don't support the weird self-referential sense of equality yet.
(defmethod express-equal ((arg1 entity-root-supertype) (arg2 entity-root-supertype))
  "Implement Entity value comparison (=) (LRM 12.2.1.7)
   Essentially, attributes must be = (lisp equal)."
  (if (eql arg1 arg2) t
    (let* ((class1 (class-of arg1))
	   (class2 (class-of arg2))
	   (all-slots (class-slots class1))
	   valued-slots)
      (setf valued-slots (loop for slot in all-slots
			       unless (slot-definition-derived slot)
			       collect slot))
      (setf valued-slots (loop for slot in valued-slots
			       unless (slot-definition-inverse slot)
			       collect (slot-definition-name slot)))
      (and
       (eql class1 class2)
       (loop for name in valued-slots
	     as val1 = (slot-value arg1 name)
	     as val2 = (slot-value arg2 name)
	     always (express-equal val1 val2))))))

#+pod7
(defmethod express-equal ((arg1 vi-root-supertype) (arg2 vi-root-supertype))
  "This gets called while creating set-typ of view instances. I don't think
   it will get any other use."
  (eql arg1 arg2))
   
(defmethod express-equal ((arg1 p21-enumeration-ref) (arg2 symbol))
  (eql (p21-enumeration-ref--keyword arg1) arg2))

(defmethod express-equal ((arg1 symbol) (arg2 p21-enumeration-ref))
  (eql arg1 (p21-enumeration-ref--keyword arg2)))

;;; 2005-01-12 POD The spec doesn't support the checking of type that
;;; this was doing. See examples in clause 12.11. However, it would
;;; support checking for compatible types. The spec's guidance on compatible
;;; types might still be enforced by the called function. 
(defmethod express-equal ((arg1 defined-value) (arg2 defined-value))
  ;(and (equal (record-of-types arg1) (record-of-types arg2))
       (express-equal (value arg1) (value arg2)))

;;; 2005-01-12 These two used to return nil in all cases. 
;;; The spec does not support this interpretation. See examples in clause 12.11
(defmethod express-equal ((arg1 defined-value) arg2)
  (express-equal (value arg1) arg2))

(defmethod express-equal (arg1 (arg2 defined-value))
  (express-equal arg1 (value arg2)))

(defmethod express-equal :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :u)
        ;; POD 6/29/98 See comments above type-compatible-p-method :around ((arg1 t) (arg2 t))
        ;; regarding what can and can't be done in type-compatible-p runtime checking.
        ;; It seems to differ from what I can infer about value equality. 
;	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
;         (and
;          (equal (record-of-types arg1) (record-of-types arg2))
;          (express-equal (value arg1) (value arg2))))
;	((typep arg1 'defined-value)
;         ;; 6/29/98
;	 ;;(express-equal (value arg1) arg2)
;         nil)
;	((typep arg2 'defined-value)
;         ;; 6/29/98
;         ;;(express-equal arg1 (value arg2))
;         nil)
	(t (call-next-method))))

(defmethod express-equal (arg1 arg2)
  (express-error incompatible-args :function "= operator" :args (list arg1 arg2)))

(defun express-equal-no-question (x y)
  "This is express-equal unless either arg is :? then it is nil.
   This is useful in aggregate difference operations, for example."
  (cond ((or (indeterminate-p x) (indeterminate-p y )) nil)
	(t (express-equal x y))))


;;;--------------------------------------------------------------
;;; <> <> <> <> <>
(defmethod express-not-equal (arg1 arg2)
  (let ((result (express-equal arg1 arg2)))
    (if (indeterminate-p result)
	:?
      (not result))))


;;;--------------------------------------------------------------
;;; ** ** ** **
(defun express-expt (arg1 arg2)
  (expt arg1 arg2))


;;;--------------------------------------------------------------
;;; + + + + 
(defmethod express-plus ((arg1 number) (arg2 number))
  (+ arg1 arg2))

(defmethod express-plus ((arg1 express-aggregate) arg2)
  (plus-result-type
   (append (value arg1) (list arg2))
   arg1 arg2))

(defmethod express-plus (arg1 (arg2 express-aggregate))
  (plus-result-type
   (append (list arg1) (value arg2))
   arg1 arg2))

(defmethod express-plus ((arg1 express-aggregate) (arg2 express-aggregate))
  (plus-result-type
   (append (value arg1) (value arg2))
   arg1 arg2))

(defmethod express-plus ((arg1 string) (arg2 string))
  (concatenate 'string arg1 arg2))

(defmethod express-plus :around (arg1 arg2)
  (when (or (typep arg1 'express-array)
	    (typep arg1 'express-array))
    (express-error incompatible-args :function "+ operator" :args (list arg1 arg2)))
  (cond ((or (indeterminate-p arg1)  (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-plus (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-plus (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-plus arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-plus (arg1 arg2)
  (express-error incompatible-args :function "Plus" :args (list arg1 arg2)))

(defun plus-result-type (val arg1 arg2)
  "Implements Table 17 in LRM 12.6.3. The LRM doesn't say what bounds
   should be on the resulting aggregate. I set them both to the length."
  (let ((result-type nil)
	(td-type nil)
	td)
    (cond ((or (typep arg1 'express-array) (typep arg2 'express-array))
	   (express-error incompatible-args :function "Express Union" :args (list arg1 arg2)))
	  ((typep arg1 'express-aggregate) (setf td (type-descriptor arg1)))
	  ((typep arg2 'express-aggregate) (setf td (type-descriptor arg2)))
	  (t (express-error incompatible-args :function "Express Union" :args (list arg1 arg2))))
    ;; We remove duplicates from the set here only to get td's bounds correct.
    (etypecase td
      (bag-typ  (setq result-type 'express-bag td-type 'bag-typ))
      (set-typ  (setq result-type 'express-set td-type 'set-typ)
		(setq val (remove-duplicates val :test #'express-equal)))
      (list-typ (setq result-type 'express-list td-type 'list-typ)))
    (let ((len (length val)))
      (make-instance result-type
		     :value val
		     :type-descriptor
		     (make-instance td-type
                                    :base-type t ;; POD better than unbound!!!
				    :l-bound len :u-bound len)))))

;;;--------------------------------------------------------------
;;; - - - -

(defmethod express-minus ((arg1 number) (arg2 number))
  (- arg1 arg2))

;;; Note that the first arg MUST be an aggregate.
(defmethod express-minus ((arg1 express-set) arg2)
  (let* ((arg2 ; Arrays checked for in :around
          (if (typep arg2 'express-aggregate)
              (value arg2)
            (list arg2)))
         (val (loop for item in (value arg1)
		    unless (member item arg2 :test #'express-equal)
		    collect item))
         (len (length val)))
    ;; POD 6/29/98 previously bounds where [1:?] 
    (make-instance 'express-set
		   :value val
		   :type-descriptor (make-instance 'set-typ
						   :l-bound len
						   :u-bound len))))

(defmethod express-minus ((arg1 express-bag) arg2)
  ;; This method copies the value of ARG1 and removes items with
  ;; DELETE in an effort to reduce consing.
  (let ((arg2 ; Arrays checked for in :around
          (if (typep arg2 'express-aggregate)
              (value arg2)
            (list arg2)))
         (val (copy-list (value arg1)))
	 len)
    (loop for item in arg2
	  do (setf val (delete item val :test #'express-equal)))
    (setf len (length val))
    ;; POD 6/29/98 previously bounds where [1:?] and type was set-typ
    (make-instance 'express-bag
		   :value val 
		   :type-descriptor (make-instance 'bag-typ 
						   :l-bound len
						   :u-bound len))))

(defmethod express-minus :around (arg1 arg2)
  (when (typep arg2 'express-array)
    (express-error op-got-array :op #\-))
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-minus (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-minus (value arg1) arg2))
        ;; POD 6/29/98 This is part of the fix for AP202 (see notes above type-compatible-p)
	((and (typep arg2 'defined-value) 
              (not (typep arg1 'express-aggregate)))
	 (express-minus arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-minus (arg1 arg2)
  (express-error incompatible-types :function "Minus" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; - - - -
(defmethod express-unary-minus ((arg1 number))
  (- arg1))

(defmethod express-unary-minus :around (arg1)
  (cond ((indeterminate-p arg1) :?)
	((typep arg1 'defined-value) (express-unary-minus (value arg1)))
	(t (call-next-method))))

(defmethod express-unary-minus (arg1)
  (express-error incompatible-args :function "Unary Minus" :args (list arg1)))

;;;--------------------------------------------------------------
;;; * * * *
(defmethod express-mult ((arg1 number) (arg2 number))
  (* arg1 arg2))

(defmethod express-mult ((arg1 express-aggregate) (arg2 express-aggregate))
  (when (or (typep arg1 'express-array) (typep arg2 'express-array))
    (express-error op-got-array :op #\*))
  ;; POD Note that this trys to get around not prepending schema names.
  (flet ((prepending-schema-name (agg)
	   (let ((sample (express-aref agg 1)))
	     (and (stringp sample) (position #\. sample)))))
    (when (prepending-schema-name arg2) (rotatef arg1 arg2))
    (let ((value
	   (loop for member in (value arg1)
		 for lis = (value arg2) ; pod with lis = ???
		 when (in member lis)
		 collect member)))
      (cond ((or (typep (type-descriptor arg1) 'set-typ)
		 (typep (type-descriptor arg2) 'set-typ))
	     (make-instance 'express-set
			    :value value
			    :type-descriptor (make-instance 'set-typ
							    :base-type t))) ;; pod
	    (t
	     (make-instance 'express-set
			    :value value
			    :type-descriptor (make-instance 'bag-typ
							    :base-type t)))))))

(defmethod express-mult :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-mult (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-mult (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-mult arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-mult (arg1 arg2)
  (express-error incompatible-args :function "EXPRESS * operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; / / / /
(defmethod express-divide ((arg1 number) (arg2 number))
  (/ arg1 arg2))

(defmethod express-divide :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-divide (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-divide (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-divide arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-divide (arg1 arg2)
  (express-error incompatible-args :function "EXPRESS / operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; div div div div
(defmethod express-div ((arg1 number) (arg2 number))
  (multiple-value-bind (quotient remainder)
      (floor arg1 arg2)
    (declare (ignore remainder))
    quotient))

(defmethod express-div :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-div (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-div (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-div arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-div (arg1 arg2)
  (express-error incompatible-args :function "EXPRESS DIV operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; mod mod mod mod
(defmethod express-mod ((arg1 number) (arg2 number))
  (mod arg1 arg2))

(defmethod express-mod :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :?)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-mod (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-mod (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-mod arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-mod (arg1 arg2)
  (express-error incompatible-args :function "EXPRESS MOD operator" :args (list arg1 arg2)))


;;;--------------------------------------------------------------
;;; < < < <
(defmethod express-< ((arg1 number) (arg2 number))
  (< arg1 arg2))

(defmethod express-< ((arg1 string) (arg2 string))
  (and (string< arg1 arg2) t))

(defmethod express-< :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :u)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-< (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-< (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-< arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-< (arg1 arg2)
  (express-error incompatible-args :function "< operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; <= <= <= <= <=
(defmethod express-<= ((arg1 number) (arg2 number))
  (<= arg1 arg2))

(defmethod express-<= ((arg1 string) (arg2 string))
  (and (string<= arg1 arg2) t))

;; Need to figure out how to properly handle the semantics of
;; enumeration values

(defmethod express-<= :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :u)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-<= (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-<= (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-<= arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-<= (arg1 arg2)
  (express-error incompatible-args :function "<= operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; > > > >
(defmethod express-> ((arg1 number) (arg2 number))
  (> arg1 arg2))

(defmethod express-> ((arg1 string) (arg2 string))
  (and (string> arg1 arg2) t))

(defmethod express-> :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :u)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express-> (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express-> (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express-> arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express-> (arg1 arg2)
  (express-error incompatible-args :function "> operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; >= >= >= >=
(defmethod express->= ((arg1 number) (arg2 number))
  (>= arg1 arg2))

(defmethod express->= ((arg1 string) (arg2 string))
  (and (string>= arg1 arg2) t))

;; Need to figure out how to properly handle the semantics of
;; enumeration values

(defmethod express->= :around (arg1 arg2)
  (cond ((or (indeterminate-p arg1) (indeterminate-p arg2))
	 :u)
	((and (typep arg1 'defined-value) (typep arg2 'defined-value))
	 (express->= (value arg1) (value arg2)))
	((typep arg1 'defined-value) 
	 (express->= (value arg1) arg2))
	((typep arg2 'defined-value) 
	 (express->= arg1 (value arg2)))
	(t (call-next-method))))

(defmethod express->= (arg1 arg2)
  (express-error incompatible-args :function ">= operator" :args (list arg1 arg2)))

;;;--------------------------------------------------------------
;;; :=:  (instance comparison) - for entity this means same obj id. 
;;; 
(defmethod express-instance-equal ((arg1 entity-root-supertype) (arg2 entity-root-supertype))
  "Entity instance value comparison. (LRM 12.2.2.2): Must be the same object."
  (eql arg1 arg2))

(defmethod express-instance-equal ((arg1 t) (arg2 t))
  "LRM 12.2.2: on numeric, logical, string, binaryan enumermation types
   :=: is equivalent to ="
  (express-equal arg1 arg2))

  
;;; LRM 12.2.2.1: Two aggregate value can be compared only if their data types are
;;;   compatible. I suppose this means it should error otherwise.
;;; This is actually a implementation of 12.2.2.1 Aggregate Instance Comparison.
(defmethod express-instance-equal ((arg1 express-aggregate) (arg2 express-aggregate))
  (flet
      ((bag-set-equality (arg1 arg2) 
	 ;; Each element in the set occurs only once IN the bag and the
	 ;; bag contains no elements that are not in the set.
	 (let ((bag (value arg1))
	       (set (value arg2)))
	   (and 
	    ;; Bag contains no elements that are not in the set.
	    (null (set-difference bag set :test #'express-equal))
	    ;; Each element in the set occurs only once In the bag.
	    (every #'(lambda (set-elem)
		       (= 1
			  (length
			   (loop for x in bag
			       when (express-equal x set-elem)
			       collect x))))
		   set)))))
  (unless (type-compatible-p arg1 arg2)
    (express-error incompatible-args :function ":=: operator" :args (list arg1 arg2)))
  (when (= (bi-sizeof arg1) (bi-sizeof arg2))
    (typecase arg1
      (express-array
       (loop for i from 1 to (bi-sizeof arg1)
	   for val1 = (express-aref arg1 i)
           for val2 = (express-aref arg2 i)
	   when 
	     (or (indeterminate-p val1) (indeterminate-p val2))
	     do (return-from express-instance-equal :u) ;; POD :unknown
	   unless			     
	     (express-instance-equal val1 val2)
	   do (return-from express-instance-equal nil))
       t)
      (express-list
       (loop for val1 in (value arg1)
	   for val2 in (value arg2)
           when		       
	     (or (indeterminate-p val1) (indeterminate-p val2))
	   do (return-from express-instance-equal :u) ;; POD :unknown
	   unless
	     (express-instance-equal val1 val2)
	   do (return-from express-instance-equal nil))
       t)
      (express-set
       (typecase arg1
	 (express-set
	  (let ((set1 (value arg1))
		(set2 (value arg2)))
	    (when (or (find :? set1)) (or (find :? set2))
		  (return-from express-instance-equal nil)) ;; POD :unknown
	    (not 
	     (set-difference (value arg1) (value arg2) :test #'express-equal))))
	 (express-bag
	  (bag-set-equality arg2 arg1))))
      (express-bag
       (let ((value1 (value arg1)) 
	     (value2 (value arg2)))
	 (typecase arg2
	   (express-bag 
	    (and (= (length value1) (length value2))
		 ;; Each element in a occurs the same number of times in b,
		 ;; and each element in b occurs the same time in a. I think
		 ;; it is enought to check one of these conditions and = length.
		 (loop for elem1 in value1
		     unless (=
			     (length 
			      (remove-if
			       (complement #'(lambda (x) (express-equal x elem1)))
			       value1))
			     (length
			      (remove-if
			       (complement #'(lambda (x) (express-equal x elem1)))
			       value2)))
		     return nil
		     finally (return t))))
	   (express-set
	    (bag-set-equality arg1 arg2)))))))))

  

;;;--------------------------------------------------------------
;;; :<>:

(defmethod express-instance-not-equal (arg1 arg2)
  (let ((val (express-instance-equal arg1 arg2)))
    (if (indeterminate-p val)
	:?
      (not val))))


;;;--------------------------------------------------------------
;;;   || 
;;; POD Expresso can't send this a partial complex entity type 
;;; (see example section 12.10). 
;;; POD this should do error checking on operands.
(defun express-complex-entity-construction (&rest instances)
  (let* ((classes (loop for inst in instances collect (class-of inst)))
	 (class (find-programmatic-class
		 (loop for clas in classes
		       append (express-class-list clas)) :allow-partial t))
	 (instance (make-instance class)))
    (loop for slot in (mofi:mapped-slots class) ; 2012 mofi:
	  as slot-name = (slot-definition-name slot)
	  as sinst = (loop for inst in instances
			   as clas = (class-of inst)
			   when (find (slot-definition-source slot) (express-class-list clas))
			   return inst)
	  when (slot-boundp sinst slot-name)
	  do (setf (slot-value instance slot-name)
		   (slot-value sinst slot-name)))
    instance))

(defun query (source expression)
  "Implements the QUERY function. 
   ARGS: source - an express aggregate
         expression - a lambda expression of one argument (a membership predicate)."
  (if (indeterminate-p source)
      :?
    (bi-query source expression)))

(defmethod bi-query :around ((source express-aggregate) expression)
  (let (lambda-args result)
    (when (get-option debug-query)
      (incf-option query-indent)
      (loop initially (dbg-message :query 1 "~%")
	    for i from 2 to (get-option query-indent)
	    do (dbg-message :query 1 "  |  "))
      (suppress-full-entity-print
       (dbg-message :query 1 "QUERY ~A <* "
		    (setf lambda-args
			  (first (function-args expression))))
       (write-entity source *message-stream* :p21 :dataset (dataset *expresso*))))
    ;; call the real method
    (setf result (call-next-method))
    (when (get-option debug-query)
      (loop initially (dbg-message :query 1 "~%")
	    for i from 2 to (get-option query-indent)
	    do (dbg-message :query 1 "  |  ")
	    finally (dbg-message :query 1 "~A returns " lambda-args)
	    (write-entity result *message-stream* :p21 :dataset (dataset *expresso*)))
      (decf-option query-indent))
    result))
			    
(defmethod bi-query ((source express-array) expression)
  (let ((copy (make-empty-copy source)))
    (with-type-descriptor (l-bound u-bound) source
      (loop for index from l-bound to u-bound
	    for variable = (express-aref source index)
	    for returns  = (funcall expression variable)
	    if (express-true returns)
	    do (setf (express-aref copy index) variable)
	    else do (setf (express-aref copy index) :?)))
    copy))

(defmethod bi-query ((source express-aggregate) expression)
  (let ((copy (make-empty-copy source)))
    (setf (value copy)
	  (loop for variable in (value source)
		for returns = (funcall expression variable)
		when (express-true returns)
		collect variable))
    copy))

(defun bi-usedin (&rest args)
  "USEDIN is an Express builtin that returns every entity instance that uses
   the specified entity instance in the argument specified role."
  (flet
      ((check-valid-role (role)
        (let ((len (length role)))
          (cond ((zerop len) role)
                ((= 2 (loop for ix from 0 to (1- len) when (char= (char role ix) #\.) count 1))
                 role)
                (t (express-error usedin-role-2-dots :role role)))))
       ;;-------------------
       (usedin-internal (instance user type-name attribute-name)
	 ;; Returns T if instance is found in the argument slot of user.
	 (let* ((slot (find-if #'(lambda (x) 
				   (and (eql (slot-definition-source x) type-name)
					(eql (slot-definition-simple-name x) attribute-name)))
			       (class-slots (class-of user))))
		(slot-type (and slot (slot-definition-range slot)))
		(slot-name (and slot (slot-definition-name slot))))
           (when slot
	     (when (typep slot-type 'forward-referenced-class)
	       (setq slot-type (find-class (class-name slot-type))))
	     (typecase slot-type
	       (express-entity-type-mo
		(eql instance (and (slot-boundp user slot-name) (slot-value user slot-name))))
	       (array-typ
		(express-array-find instance (and (slot-boundp user slot-name)
						  (slot-value user slot-name))))
	       (aggregation-typ
		(let ((lis (and (slot-boundp user slot-name)
				(slot-value user slot-name))))
		  (if (indeterminate-p lis)
		      :?
		    (find instance (value lis)))))
	       (express-defined-type-mo
		(unless (typep (type-descriptor slot-type) 'select-typ)
		  (express-error usedin-invalid-type ""))
		(eql instance (and (slot-boundp user slot-name)
				   (slot-value user slot-name))))
	       (otherwise (express-error usedin-invalid-type "")))))))
    ;; -------
    ;; (destructuring-bind (instance role) args ...)
    (let* ((instance (first args))
	   (instance (if (typep instance 'defined-value) (value instance) instance))
	   (role (check-valid-role (second args)))
	   (found
	    (cond ((indeterminate-p instance)
		   nil)
		  ((zerop (length role))
		   (where-used instance))
		  (t
		   (let* ((pos1 (position #\. role))
			  (pos2 (position #\. role :from-end t))
			  (type-name (intern (subseq role (1+ pos1) pos2)
					     (mofi:lisp-package (schema *expresso*))))
			  (attribute-name (intern (subseq role (1+ pos2))
						  (mofi:lisp-package (schema *expresso*)))))
		     ;; Must name an entity type.
		     (unless (and (typep (find-class type-name) 'express-entity-type-mo)
                                  (find-direct-slot type-name attribute-name t))
		       (express-error usedin-bad-entity-or-attribute
			      :entity type-name
			      :attribute (string attribute-name)))
		     ;; See LRM 15.20 to learn about fully qualified attribute (role) names.
		     ;; I do not think I am allowed to look up the type hierarchy for this attr.
		     (let* ((all (where-used instance))
			    (all ;; Remove if type isn't correct.
			         (remove-if
			          (complement #'(lambda (user) (find type-name (express-class-list (class-of user)))))
			          all)))
		       (remove-if ; The actual work, remove if user doesn't use in this slot.
		        (complement
			 #'(lambda (user)
			     (usedin-internal instance user type-name attribute-name)))
		        all))))))
           (len (length found)))
      (make-instance 'express-bag :value found
                     :type-descriptor
                     (make-instance 'bag-typ :l-bound len :u-bound len
                                    :base-type t)))))

;(declaim (inline used-in-slot-p))
(defun used-in-slot-p (item instance slot)
  "Returns true if the argument item is used in the argument slot of
   the argument instance."
  (when (typep item     'defined-value) (setf item (value item)))
  (when (typep instance 'defined-value) (setf instance (value instance)))
  (when (slot-boundp instance (slot-definition-name slot))
    (let ((slot-value (slot-value instance (slot-definition-name slot)))
	  (slot-type  (slot-definition-range slot)))
      (typecase slot-type
	(forward-referenced-class
	 (eql item slot-value))
	(express-entity-type-mo
	 (eql item slot-value))
	(express-defined-type-mo 
	 (eql item slot-value))
	(array-typ
	 (express-array-find item slot-value))
	(aggregation-typ
         (if (indeterminate-p slot-value) nil
	   (find item (value slot-value))))))))

;;; POD Another example of the 'stringy-ness' of the design.
(defun bi-rolesof (instance)
  (when (typep instance 'defined-value) (setf instance (value instance)))
  (let ((uses (where-used instance))
        (schema-name (schema instance)))
    (let* ((result 
	    (remove-duplicates ; Can't :key #'class-of, might be used in two places in different instances.
             (loop for use in uses append 
                   (loop for slot in (mofi:mapped-slots (class-of use)) ; 2012 mofi:
                         when (used-in-slot-p instance use slot)
                         collect (cons (slot-definition-source slot)
                                       (slot-definition-simple-name slot))))
             :test #'equal))
	   (len (length result)))
      (make-instance 'express-set
		     :type-descriptor
		     (make-instance 'set-typ
				    :l-bound len :u-bound len
				    :base-type (make-instance 'string-typ))
		     :value (mapcar #'(lambda (x)
					(format nil "~A.~A.~A" schema-name
						(car x)
						(cdr x)))
				    result)))))
		
(defun repeat (value repetitions)
  "I may regret this! Makes a list with <value> repeated <repetition> times."
  (loop repeat repetitions
	collect value))

(defmethod bi-hiindex ((agg express-aggregate))
  (length (value agg)))

(defmethod bi-hiindex ((agg express-array))
  (u-bound (type-descriptor agg)))

(defmethod bi-loindex ((agg express-array))
  (u-bound (type-descriptor agg)))

(defmethod bi-loindex ((agg express-aggregate))
  1)

(defmethod bi-hibound ((agg express-aggregate))
  (or (u-bound (type-descriptor agg)) :?))

(defmethod bi-hibound ((agg express-array))
  (u-bound (type-descriptor agg)))


(defmethod bi-lobound ((agg express-aggregate))
  (or (l-bound (type-descriptor agg)) :?))

(defmethod bi-lobound ((agg express-array))
  (l-bound (type-descriptor agg)))

(defmacro express-increment-controlled-loop (var arg-bound-1 arg-bound-2 arg-increment while &body body)
  (with-gensyms (bound-1 bound-2 increment)
    `(let ((,bound-1 ,arg-bound-1)
           (,bound-2 ,arg-bound-2)
           (,increment ,arg-increment))
       (when
           (cond ((not (and (numberp ,bound-1) (numberp ,bound-2))) nil)
                 ((zerop ,increment) nil)
                 ((and (plusp  ,increment) (> ,bound-1 ,bound-2)) nil)
                 ((and (minusp ,increment) (< ,bound-1 ,bound-2)) nil)
                 (t t))
         (loop for ,var from ,bound-1 to ,bound-2 by ,increment while ,while do ,@body)))))

(defmacro express-loop-finish ()
  "Lispworks has a problem seeing loop-finish in a form other than a loop." 
  `(loop-finish))

(defun coerce-express-type (value td)
  "Coerce the argument value to something of type td (a type-descriptor)."
  (cond ((not (typep value 'express-aggregate))
	 value)
	(t
	 (make-one td (value value)))))


(defmethod make-entity-instance ((types list) &rest initvals)
  "Called by express-x in the extent of current-schema
   Args: types         - a list of symbols (NOT schema qualified) representing the type
         schema-symbol - a symbol representing the schema."
  (declare (ignore initvals))
  (let* ((schema (schema *expresso*))
         (type-names (loop for type in types
                           collect (loop for entity being the hash-value of (entity-types schema)
                                         when (eql type (class-name entity)) ; PODsampson class-name was short-name
                                         return (class-name entity)
                                         finally (express-error no-entity-in-schema
							:entity type :schema (name schema))))))
  (make-instance (find-programmatic-class type-names :allow-partial t))))

(defmethod make-entity-instance ((type symbol) &rest values)
  "Called by lisp translated from the express. This implements the
   entity construction operator. Note that it doesn't assign to supertype attributes"
  (let* ((full-type (p21-precedence-order type))
         (instantiable-class (find-programmatic-class full-type :allow-partial t)))
    (loop for class in (mapcar #'find-class full-type) do
          (finalize-inheritance class))
    ;; POD 9/23/99 I add remove-if....
    (let ((initarg-value-pairs
           (loop for dslot in (remove-if #'slot-definition-derived
					 (class-direct-slots (find-class type)))
                 for eslot = (find-if #'(lambda (x) (and (eql (slot-definition-simple-name x)
                                                              (slot-definition-name dslot))
                                                         (eql (slot-definition-source x)
                                                              (slot-definition-source dslot))))
                                      (mofi:mapped-slots instantiable-class)) ; 2012 mofi:
                 for td = (slot-definition-range dslot)
                 for value in values
                 collect (first (slot-definition-initargs eslot))
                 collect (coerce-express-type value td))))
    (apply #'make-instance
           instantiable-class
           initarg-value-pairs))))


;;;------------------------------------------------------
;;; Conditionals and logicals to accomodate p21-*-ref 
;;; AND, OR are binary, cond is only IF THEN [ELSE] 
;;; POD Is it correct that there return :t :u and nil which are constants ???
(defun express-xor (arg1 arg2)
  (let ((a1 (if (typep arg1 'p21-boolean-logical-select)
		(p21-boolean-logical-select--keyword arg1)
	      arg1))
	(a2 (if (typep arg2 'p21-boolean-logical-select)
		(p21-boolean-logical-select--keyword arg2)
	      arg2)))
    (cond ((or (indeterminate-p a1) (indeterminate-p a2))
	   :u)
	  ((or (eql a1 :u) (eql a2 :u))
	   :u)
	  ((and a1 (not a2)) :t)
	  ((and a2 (not a1)) :t)
	  (t nil))))

(defun express-not (arg)
  (when  (typep arg 'p21-boolean-logical-select)
    (setf arg (p21-boolean-logical-select--keyword arg))
    (cond ((eql arg :?) :u)
          ((eql arg :u) :u)
	  ((eql arg :t) :f)
	  ((eql arg :f) :t)
	  (t (warn "NOT Expected logical operand.")))))

(defmacro express-when (condition &body body)
  "LRM 13.7 If...Then...Else Statement, (with no Else)"
  (with-gensyms (filet result)
    `(let ((,result ,condition))
       (flet ((,filet () ,@body))
	 (if (typep ,result 'p21-boolean-logical-select)
	     (when (eql :t (p21-boolean-logical-select--keyword ,result))
	       (funcall #',filet))
	   (when (eql ,result :t) (funcall #',filet)))))))

(defmacro express-if (condition (&body then) (&body else))
  "LRM 13.7 If...Then...Else Statement"
  (with-gensyms (result)
    `(let ((,result ,condition))
       (if (typep ,result 'p21-boolean-logical-select)
           (if (eql :t (p21-boolean-logical-select--keyword ,result))
               (progn ,@then)
             (progn ,@else))
         (if (eql ,result :t) (progn ,@then) (progn ,@else))))))

;;  +------------------------------------------------+
;;  |             Table 14 -- OR operator            |
;;  +----------------+----------------+--------------+
;;  | Operand1 Value | Operand2 Value | Result Value |
;;  +----------------+----------------+--------------+
;;  |      true      |      true      |     true     |
;;  |      true      |     unknown    |     true     |
;;  |      true      |      false     |     true     |
;;  |     unknown    |      true      |     true     |
;;  |     unknown    |     unknown    |    unknown   |
;;  |     unknown    |      false     |    unknown   |
;;  |      false     |      true      |     true     |
;;  |      false     |     unknown    |    unknown   |
;;  |      false     |      false     |     false    |
;;  +----------------+----------------+--------------+


;;; Section 12.4 (Logical Operators) says that if either argument evaluates to :?, 
;;; the result is :u. But what if it is a Boolean operation (not Logical). 
(defmacro express-or (arg1 arg2)
  "EXPRESS LRM doesn't state OR evaluates both args in all cases. Mine doesn't."
  (with-gensyms (a1 a2)
    `(let* ((,a1 ,arg1))
       (when (typep ,a1 'p21-boolean-logical-select)
	 (setf ,a1 (p21-boolean-logical-select--keyword ,a1)))
       (cond ((eql :t ,a1) :t)
	     ((member ,a1 '(:f :u :?))
	      (let ((,a2 ,arg2))
		(when (typep ,a2 'p21-boolean-logical-select)
		  (setf ,a2 (p21-boolean-logical-select--keyword ,a2)))
		(cond ((eql :t ,a2) :t)
		      ((eql :u ,a2) :u)
		      ((eql :? ,a2) :u)
		      ((eql :f ,a2) (if (eql :f ,a1) :f :u))
		      (t (warn "OR expects a logical operand.")))))
	     (t (warn "OR expects a logical operand."))))))

	       
;;  +------------------------------------------------+
;;  |            Table 13 -- AND operator            |
;;  +----------------+----------------+--------------+
;;  | Operand1 Value | Operand2 Value | Result Value |
;;  +----------------+----------------+--------------+
;;  |      true      |      true      |     true     |
;;  |      true      |     unknown    |    unknown   |
;;  |      true      |      false     |     false    |
;;  |     unknown    |      true      |    unknown   |
;;  |     unknown    |     unknown    |    unknown   |
;;  |     unknown    |      false     |     false    |
;;  |      false     |      true      |     false    |
;;  |      false     |     unknown    |     false    |
;;  |      false     |      false     |     false    |
;;  +----------------+----------------+--------------+

;;; POD 2009-06-13. WTF! I'm trying to determine whether to use (:t :f :u) or
;;; (:true :false :unknown) in instance creation and I cannot even fathom this code!
;;; It looks like I use (:t nil :u). I'm switching it!
(defmacro express-and (arg1 arg2)
  "Express LRM doesn't state whether both args are evaluated in all cases. 
   My implmentation does not evaluate arg2 if arg 1 is false."
  (with-gensyms (a1 a2)
    `(let* ((,a1 ,arg1))
       (when (typep ,a1 'p21-boolean-logical-select)
	 (setf ,a1 (p21-boolean-logical-select--keyword ,a1)))
       (cond ((eql :? ,a1) :u)
	     ((eql :u ,a1) :u)
	     ((eql :f ,a1) :f)
	     ((eql :t ,a1)
	      (let ((,a2 ,arg2))
		(when (typep ,a2 'p21-boolean-logical-select)
		  (setf ,a2 (p21-boolean-logical-select--keyword ,a2)))
		(cond ((eql :t ,a2) :t)
		      ((eql :f ,a2) :f)
		      ((eql :? ,a2) :u)
		      ((eql :u ,a2) :u)
		      (t (warn "AND expects a logical operand.")))))
	     (t (warn "AND expects a logical operand."))))))

(defun bi-length (arg)
  (when (typep arg 'defined-value) (setq arg (value arg)))
  (cond ((indeterminate-p arg) :?) ;; POD I am not sure about this.
        ((not (or (stringp arg) (listp arg)))
	 (express-error length-invalid-arg :arg (if (indeterminate-p arg) "$" arg)))
        (t (length arg))))

;;; LRM 12.2.5 (pg. 93) is a joke! It states that * means 
;;; "Match any number of characters." Which says to me the same thing as &
;;; "Match remainder of string". And it gets worse !!!!


;;; LRM 12.2.5  Table 11 -- Pattern matching characters
;;;
;;; Character     Meaning
;;;     @         Matches any letter [a-zA-Z]
;;;     ^         Matches any upper case letter [A-Z]
;;;     ?         Matches any character
;;;     &         Matches remainder of string
;;;     #         Matches any digit [0-9]
;;;     $         Matches a substring terminated by a space character or end-of-string
;;;     *         Matches any number of characters
;;;     \         Begins a pattern escape sequence
;;;     !         Negation character (used with the other characters)

;;; This overrides the one in the schema. Note that strictly speaking,
;;; the test on remove-duplicates should be express-equal. (Takes almost
;;; twice as long).
(defun builtin-bag_to_set (bag)
  (let* ((val (remove-duplicates (value bag) :test #'eql))
         (len (length val)))
    (make-instance 'express-set
                   :value val
                   :type-descriptor 
                   (make-instance 'set-typ
                                  :l-bound len
                                  :u-bound len
                                  :base-type (base-type 
                                              (type-descriptor bag))))))
  
;;;------------------------------------------------------
;;; Trig builtins etc.

;;; POD Add bounds checking to these.
(defmacro generate-trig-method (fun-name &optional lbound ubound)
  (declare (ignore lbound ubound))
  (let ((express-name (intern (concatenate 'string "BI-" (symbol-name fun-name)))))
    `(progn
       (defmethod ,express-name ((arg (eql :?))) :?)
       (defmethod ,express-name ((arg number)) (,fun-name arg))
       (defmethod ,express-name ((arg defined-value)) (,express-name (value arg))))))
	  
(generate-trig-method abs)
(generate-trig-method acos)
(generate-trig-method asin)
(generate-trig-method atan)
(generate-trig-method cos)
(generate-trig-method exp)
(generate-trig-method log)
(generate-trig-method sin)
(generate-trig-method tan)
(generate-trig-method sqrt)

;; EE extension
(defun bi-print (format-string &rest args)
  (apply #'info-message format-string args)
  t)

(defun bi-lformat (fmt-string &rest args)
  (apply #'format nil fmt-string args))

;;FUNCTION FORMAT(N:NUMBER; F:STRING):STRING;
;;
;;The format returns a formatted string representation of a number.
;;Parameters :
;;    a) N is a number (integer or real).
;;    b) F is a string containing formatting commands.
;;Result : A string representation of N formatted according to F. Rounding is
;;applied to the string representation if necessary.

;; Symbolic representation --------
;; [sign]width[.decimals]type
;; if width has a leading '0' (zero), then the number will be printed
;; with leading zeros
;; type:
;;   I - integer (decimals not specified; width > 1)
;;   F - fixed real (decimals default 2; width > 3)
;;   E - exp real (decimals must be specified; width > 6)

;; Picture representation ---------
;; 

;; Standard representation --------
;; integer --  7I
;; real ----- 10E
(defun bi-format (num fmt)
  "This implements the express FORMAT function."
  (when (position #\# fmt)
    (error "The Picture Rep is currently not supported for FORMAT."))
  (let ((start 0) signp pad width dot decimal type)
    (setf signp
	  (when (char= (char fmt 0) #\+)
	    (setf start 1)
	    t))
    (setf dot (position #\. fmt))
    (setf pad (if (char= (char fmt start) #\0) #\0 #\space))
    (setf width (parse-integer fmt :start start :end (or dot (1- (length fmt)))))
    (when dot
      (setf decimal (parse-integer fmt :start (1+ dot) :end (1- (length fmt)))))
    (setf type (char fmt (1- (length fmt))))
    (unless width
      (error "FORMAT symbolic representation requires a width specification"))
    (case type
      (#\I ;; ~mincol,padchar,commachar,comma-intervalD
       (format nil "~:[~v,vD~;~v,v@D~]" signp width pad num))
      (#\F ;; ~w,d,k,overflowchar,padcharF
       (format nil "~:[~v,v,,,vF~;~v,v,,,v@F~]" signp width (or decimal 0) pad num))
      (#\E ;; ~w,d,e,k,overflowchar,padchar,exponentcharE
       (format nil "~:[~v,v,,,,v,'EE~;~v,v,,,,v,'E@E~]" signp width (or decimal 0) pad num))
      (t (error "~C is not a valid FORMAT type specifier" type)))))

#|
(defmacro express-case (selector body)
  (with-gensyms (keyform)
    (let ((actions   (rest (assoc :actions body)))
          (otherwise (second (assoc :otherwise body))))
      `(let ((,keyform ,selector))
         (cond ,@(append
                  (loop for action in actions 
                        for keys = (first action)
                        for act  = (second action)
                        collect
                        (if (listp keys)
                            `((find ,keyform '(,@keys) :test #'equal) ,act)
                          `((equal ,keyform ,keys) ,act)))
                  (when otherwise `((t ,otherwise)))))))))
|#

#| pod7 express-x
(defmethod bi-backward-path-op ((target entity-root-supertype) attr entity-type-name path-cond)
  (let ((target (make-instance 'express-aggregate 
                               :value (list target)
                               :type-descriptor (make-instance 'generic-typ))))
    (bi-backward-path-op target attr entity-type-name path-cond)))

(defmethod bi-backward-path-op ((target-agg express-aggregate) accessor entity-type-name path-cond)
  "Implements the express-x <- operator. Rather than searching extents (time consuming?) 
   this uses where-used."
  (with-schema ((find-schema :source))
    (let ((result
            (loop for target in (unnest target-agg)
                  nconc (loop for user in (expo::where-used target)
                              when (and (typep user entity-type-name)
                                        (find target (unnest (funcall accessor user nil))) ; pod this isn't in.
                                        (or (not path-cond) (funcall path-cond user)))
                              collect user))))
      (make-instance 'express-aggregate
                     :value (delete-duplicates result)
                     :type-descriptor (make-instance 'generic-typ)))))

(defmethod bi-forward-path-op ((source entity-root-supertype) attr entity-type-name path-cond)
  (let ((target (make-instance 'express-aggregate 
                               :value (list source)
                               :type-descriptor (make-instance 'generic-typ))))
    (bi-forward-path-op target attr entity-type-name path-cond)))


(defmethod bi-forward-path-op ((source-agg express-aggregate) accessor entity-type-name path-cond)
  "Implements the express-x :: operator."
  (let ((result (loop for source in (unnest source-agg)
                      nconc (loop for candidate in (unnest (funcall (symbol-function accessor) source nil))
                                  when (and (or (not entity-type-name) (typep candidate entity-type-name))
                                            (or (not path-cond) (funcall path-cond candidate)))
                                  collect candidate))))
    (make-instance 'express-aggregate
                   :value (delete-duplicates result)
                   :type-descriptor (make-instance 'generic-typ))))
|#

(defun bi-shell-extent (type-string)
  (bi-extent (dataset *expresso*) type-string)) ; run in with-dataset

(defun bi-extent (x-eval type-string)
  (dbg-message :exx 5 "~%bi-extent: (~S ~S)" x-eval type-string)
  (let* ((schema (find-schema (subseq type-string 0 (position #\. type-string))))
	 (class-name (intern type-string (mofi:lisp-package (schema *expresso*))))
         (class (find-class class-name :schema schema)) ; was find-eu-class
         (value (ht2list (extent class x-eval))))
    (dbg-message :exx 5 "~%  class-name: ~S~%  class:      ~S~%  value:      ~S"
		 class-name class value)
    (make-instance 'express-bag :value value
                   :type-descriptor (make-instance 'bag-typ :l-bound  0 :u-bound (length value)
                                                   :base-type class))))

;; bi-value_in

;;;15.28 Value in - membership function
;;;FUNCTION VALUE IN ( C:AGGREGATE OF GENERIC:GEN; V:GENERIC:GEN ) : LOGICAL;
;;;
;;;The value in function returns a logical value depending on whether
;;;or not a particular value is a member of an aggregation.
;;;
;;;Parameters :
;;;
;;; a) C is an aggregation of any type.
;;; b) V is an expression which is assignment compatable with the base type of C.
;;;
;;;Result :
;;;
;;; a) If either V or C is indeterminate (?), unknown is returned.
;;; b) If any element of C has a value equal to the value of V, true is returned.
;;; c) If any element of C is indeterminate (?), unknown is returned.
;;; d) Otherwise false is returned.
;;;
;;;EXAMPLE 152 -- The following test ensures that there is at least
;;;               one point which is positioned at the origin.
;;;
;;; LOCAL points : SET OF point;
;;; END_LOCAL;
;;; ...
;;; IF VALUE_IN(points, point(0.0, 0.0, 0.0)) THEN ...

(defmethod bi-value_in ((agg (eql :?)) item) :u)
(defmethod bi-value_in (agg (item (eql :?))) :u)

(defmethod bi-value_in ((agg express-aggregate) item)
  (with-slots (value) agg
    (loop for val in value
	  if (eql val :?) return :u
	  else if (express-equal val item) return t
	  finally (return nil))))
	

;; bi-value_unique

;;;15.29 Value unique - uniqueness function
;;;FUNCTION VALUE UNIQUE ( V:AGGREGATE OF GENERIC) : LOGICAL;
;;;
;;;The value unique function returns a logical value depending on
;;;whether or not the elements of an aggregation are value unique.
;;;
;;;Parameters :
;;;
;;; V is an aggregation of any type.
;;;
;;;Result :
;;;
;;; a) If V is indeterminate (?), unknown is returned.
;;; b) If any any two elements of V are value equal, false is returned.
;;; c) If any element of V is indeterminate (?), unknown is returned.
;;; d) Otherwise true is returned.
;;;
;;;EXAMPLE 153 -- The following test ensures tht each point is a set
;;;is at a different position, (by definition they are distinct, i.e.,
;;;instance unique).
;;;
;;; IF VALUE_UNIQUE(points) THEN ...

(defmethod bi-value_unique ((agg (eql :?))) :u)

(defmethod bi-value_unique ((agg express-aggregate))
  (with-slots (value) agg
    (cl:if (find :? value) :u
      (loop for vals on value
	    as val = (first vals)
	    if (member val (rest vals) :test #'express-equal)
	    return nil
	    finally (return t)))))

(defmacro express-assign (obj val)
  "Replaces the setf that was used in express assignment statements."
  (with-gensyms (valu)
    `(let ((,valu ,val))
       (if (typep ,obj 'defined-value)
         (setf (value ,obj) ,valu)
         (setf ,obj ,valu)))))

;(declaim (inline translate-express-regexp))
(defun translate-express-regexp (exp)
  (macrolet ((concat
              (thing)
              (with-gensyms (arg)
                `(let ((,arg ,thing))
                   (setq result
                         (concatenate 'string
                                      result
                                      (if (stringp ,arg) ,arg  (string ,arg))))))))
    (flet ((safe-char  ;; escape emacs rexexp special chars not used in EXPRESS.
            (string index)
            (when (>= index (length string))
              (express-error
               simple-error
               "Ill-formed regular expression in LIKE. regexp = ~a" exp))
            (let ((char (char string index)))
             (cond ((find  char '(#\. #\[ #\] #\+))
                     (concatenate 'string "\\" (string char)))
                    (t char)))))
;;------
      (loop for i from 0 to (1- (length exp))
            for char = (safe-char exp i)
            with result = "" do
            (case char
              (#\@ (concat "[a-zA-Z]"))
              (#\^ (concat "[A-Z]"))
              (#\? (concat #\.))
              (#\& (concat ".*"))
              (#\# (concat "[0-9]"))
              (#\$ (concat "[^ ]*[ $]?"))
              (#\* (cond ((= i (1- (length exp))) ;; If at end of string...
                          (concat ".*"))
                         (t  ;; Match up to the next character...
                          (concat "[^")
                          (incf i)
                          (concat (safe-char exp i))
                          (concat "]*")
                          (concat (safe-char exp i)))))
              (#\\ (incf i)
                   (concat (safe-char exp i)))
              (#\! (concat "[^")
                   (incf i)
                   (concat (safe-char exp i))
                   (concat #\]))
              (t (concat char)))
            when (>= i (1- (length exp))) do (return result)
            finally (return result)))))

;;; LRM 12.2.5 (pg. 93) is a joke! It states that * means
;;; "Match any number of characters." Which says to me the same thing as &
;;; "Match remainder of string". And it gets worse !!!!
;;; POD Note that I can't use with-gensyms here  WHY???? Also checkout the EVAL ???
(defun express-like (string expression)
  "Implements the EXPRESS LIKE function."
  (cond ((or (eql string :?) (eql expression :?))
	 :?)
	((or (not (stringp string))
	     (not (stringp expression)))
	 (express-error bad-operand  "Bad operand to LIKE: ~A or ~A" string expression))
	(t
	 (error "POD NYI (with cl-ppcre)"))))
#|
	 (eval
	  `(let* ((string ,string)
		  (start 0)
		  (end (length ,string)))
	    ,@(regex-compile (translate-express-regexp expression))
	    (let ((result (second (svref *REGEX-GROUPS* 0))))
	      (when (numberp result)
		(= (length ,string)
		   result))))))))
|#
