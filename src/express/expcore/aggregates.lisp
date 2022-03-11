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
;;; Date: 8/15/96
;;;
;;; Purpose: Functions to support aggregate implementation.
;;;

(in-package :expresso)

;;; The lisp array does not permit negative valued indexing.
(defclass express-aggregate ()
  ((value :initarg :value :accessor value :initform nil)
   (type-descriptor :initarg :type-descriptor
		    :accessor type-descriptor)))

(defmethod print-object ((agg express-aggregate) stream)
  (if-debugging (:any 1) 
      (write-entity agg stream :p21)
    (call-next-method)))

(defmethod value ((arg (eql :?)))
  :?)

(defmethod %agg-size ((agg express-aggregate))
  (with-slots (value) agg
    (length value)))

(defclass express-list (express-aggregate) ())
(defclass express-set  (express-aggregate) ())
(defclass express-bag  (express-aggregate) ())

(defclass express-array (express-aggregate)   
  ((offset :reader offset)
   (optional :initarg :optional :accessor optional)))


;;; Replace the argument value list with an array.
(defmethod initialize-instance :after ((array express-array) &key value)
;  (declare (ignore initargs))
  (with-type-descriptor (l-bound u-bound) array
      (let ((size (1+ (- u-bound l-bound))))
        ;; Express arrays are always one dimensional. I think the error
        ;; checked below can only occur with a fault elsewhere in the
        ;; program --- like in the data creator 10/07/97 
        ;; 10/07/97 changed when (> (length value) size) to =
        ;; 11/20/97 changed back to > (ap214 catches this everywhere).
 	(when (> (length value) size)
	  (express-error
	   bad-entity
	   "Initialization value of express array exceeds array size: ~a" value))
      (setf (value array) (make-array size :initial-contents value))
      ;; Lisp arrays begin at zero.
      (setf (slot-value array 'offset) (- l-bound)))))

;;; Automatically remove duplicates.
(defmethod initialize-instance :after ((set express-set) &key value)
  (let ((u-bound (u-bound (type-descriptor set))))
    (when (and u-bound (not (eql :? u-bound)) (> (length value) u-bound))
        (express-error
	   bad-entity
	   "Initialization value of express set exceeds set size: ~a ~%size: ~a" 
	   value u-bound)))
  (setf (value set)
	(remove-duplicates
	 (value set)
	 :test #'(lambda (x y)
		   (typecase x
		     (p21-entity-ref
		      (and (typep y 'p21-entity-ref)
			   (= (p21-entity-ref--value x)
			      (p21-entity-ref--value y))))
		     (select-value
		      (and (typep y 'select-value)
			   (equal (record-of-types x) (record-of-types y))
			   (express-equal (value x) (value y))))
		     (otherwise
		      (cond ((or (eql x :?) (eql y :?))
			     nil)
			    (t (express-equal x y)))))))))

(defmethod initialize-instance :after ((list express-list) &key value)
  (let ((u-bound (u-bound (type-descriptor list))))
    (when (and u-bound (not (eql :? u-bound)) (> (length value) u-bound))
     (express-error
      bad-entity
      "Initialization value of express list exceeds list size: ~a ~%size: ~a" 
      value u-bound))))

(defmethod initialize-instance :after ((bag express-bag) &key value)
  (let ((u-bound (u-bound (type-descriptor bag))))
    (when (and u-bound (not (eql :? u-bound)) (> (length value) u-bound))
     (express-error
      bad-entity
      "Initialization value of express bag exceeds bag size: ~a ~%size: ~a" 
      value u-bound))))

;;; -----------------

(defun express-array-find (item array &key (test #'eql) (key #'identity))
  "Return the argument item if found in the argument express-array."
  (with-type-descriptor (l-bound u-bound) array
    (loop for index from l-bound to u-bound
	  when (funcall test item (funcall key (express-aref array index)))
	  return item)))

;;; ----------------- get methods ----------------------------------


;;; Purpose: Works like lisp function aref but on express-array.
;;; Index of first element is 1.
(defmethod express-aref ((array express-array) &rest indecies)
  (cond ((not (rest indecies))
	 (with-type-descriptor (l-bound u-bound) array
	   ;; POD investigate these are bound on size not index RIGHT?
	   (cond ((not (<= l-bound (first indecies) u-bound))
		  :?)
		 (t
		  (aref (value array) (+ (first indecies) (offset array)))))))
	(t
	 (apply #'express-aref
	  (aref (value array) (+ (first indecies) (offset array)))
	  (rest indecies)))))

;;; First index of an aggregate is 1. POD show me where it says that?!?!?
;;; POD It sort of says that in Example 100 (pg 99). 
(defmethod express-aref ((agg express-aggregate) &rest index-list)
  (let* ((index (first index-list))
	 (val (value agg)))
    ;; POD investigate these are bound on size not index RIGHT?
    (cond ((> index (length val)) :?)
          ((minusp (1- index)) 
	   (express-error aggregate-index-negative :index (1- index) :aggregate agg))
          (t (elt val (1- index))))))

;;; POD Really wonder whether this one is legit!
(defmethod express-aref ((agg (eql :?)) &rest index-list)
  (declare (ignore index-list))
  :?)

(defmethod express-aref ((agg t) &rest index-list)
  (declare (ignore index-list))
  (express-error incompatible-args :function "Array element reference" :args (list agg index-list)))

;;; ----------------- set methods ----------------------------------

;;; POD: This should do type checking.
;;; POD: What should an assignment return?
(defmethod (setf express-aref) (value (array express-array) &rest indecies)
  (labels
      ((express-aref-internal
	   (array indecies)
	 (let ((ix (first indecies)))
	   (with-type-descriptor (l-bound u-bound) array
	      (unless (and (or (not l-bound) (eql l-bound :?) (<= l-bound ix))
			   (or (not u-bound) (eql u-bound :?) (>= u-bound ix)))
		(express-error index-out-of-bounds :aggregate array :index ix)))
	(cond ((not (rest indecies))
	       (setf (aref (value array) (+ ix (offset array)))
		     value))
	      (t
	       (express-aref-internal
		(aref (value array) (+ ix (offset array)))
		(rest indecies)))))))
    (express-aref-internal array indecies)))

;;; POD: really not sure about this one.
(defmethod (setf express-aref) (value (agg express-list) &rest index)
  (let ((lis (copy-seq (value agg)))
	(ix  (first index)))
    (with-type-descriptor (l-bound u-bound) agg
      (declare (ignore l-bound))
	(unless (or (not u-bound) (eql u-bound :?) (>= u-bound ix))
	  (express-error index-out-of-bounds :aggregate agg :index ix)))
    (let ((result
	   (cond ((null lis)
		  (setf (value agg) (list value)))
		 ((> ix (length lis))
		  (setf (value agg) (append (value agg) (list value))))
		 (t 
		  (setf (elt lis (1- ix)) value)
		  (setf (value agg) lis)))))
      result)))

;;; bag or set
(defmethod (setf express-aref) (value (agg express-aggregate) &rest index)
  (declare (ignore index))
  (setf (value agg) (append (value agg) (list value))))

;;; Purpose: Make an empty copy (values set to :?) of the argument
;;;          express aggregate object.
;;; POD: This (array method) makes :optional t as required by QUERY.
;;; POD: Is both this and make-one necessary?
(defmethod make-empty-copy ((agg express-array))
  "Create a copy of the argument aggregate and initialize
   in a manner consistent with the LRM 12.6.7 (query statement)"
  (flet (
;	 (copy-td (type)
;          (with-slots (optional unique l-bound u-bound base-type) type
;            (make-instance 'array-type :optional optional :unique unique
;                           :l-bound l-bound :u-bound u-bound
;                           :base-type base-type)))
	 )
    (let* (;;(td (copy-td (type-descriptor agg)))
	   (td (type-descriptor agg))
	   (l-bound (l-bound td))
	   (u-bound (u-bound td)))
      (setf (optional td) t)
      (make-instance 'express-array
	:type-descriptor td
	:value (make-array (1+ (- u-bound l-bound))
			   :initial-element :?)))))

;;; CTL - No method for express-aggregate
(defmethod make-empty-copy ((agg express-aggregate))
  (error "need method"))

;;; POD Consider how you modified this to reference the type-descriptor.
;;; Do they fit the sense of empty required by QUERY.
(defmethod make-empty-copy ((agg express-bag))
  (make-instance 'express-bag :value nil
    :type-descriptor (type-descriptor agg)))

(defmethod make-empty-copy ((agg express-set))
  (make-instance 'express-set :value nil
    :type-descriptor (type-descriptor agg)))

(defmethod make-empty-copy ((agg express-list))
  (make-instance 'express-list :value nil
    :type-descriptor (type-descriptor agg)))

(defmethod make-empty-copy ((thing (eql :?)))
  :?)

;;; Temporary debugging method
;(defmethod make-one (type &optional init-value)
;  (cl:break "make-one (~S ~S)" type init-value))

(defmethod make-one ((td aggregation-typ) &optional init-value)
  "Create an object of the type described by the type descriptor argument.
    Args: td - a type descriptor
          init-value - a value to which the new object should be initialized."
  (let ((init-value
	 (cond ((listp init-value) init-value)
	       ((typep init-value 'express-array)
		(error 'not-yet-implemented :string "make-one to array nyi")
		)
	       ((typep init-value 'express-aggregate)
		(value init-value)))))
    (etypecase td
      (set-typ  (make-instance 'express-set  :type-descriptor td
			       :value (remove-duplicates init-value)))
      (bag-typ  (make-instance 'express-bag  :type-descriptor td :value init-value))
      (list-typ (make-instance 'express-list :type-descriptor td :value init-value))
      (array-typ (make-instance 'express-array :type-descriptor td :value init-value)))))

;;; This one has nothing to do with aggregates. 
(defmethod make-one ((type symbol) &optional init-value)
  "Create an instance of the argument entity type. 
   Set its attributes to reasonable defaults. This function
   is used in the Express LOCAL binding."
  (declare (ignore init-value))
  (let ((object (make-instance (find-programmatic-class type))))
    (loop for slot in (class-slots (class-of object))
	  when (and (typep slot 'express-effective-slot-definition)
		    (not (slot-definition-derived slot))
		    (not (slot-definition-inverse slot)))
	  do (setf (slot-value object (slot-definition-name slot))
		   (make-one (slot-definition-range slot))))
    object))

;;; This one is used when an attribute has an entity for a value.
(defmethod make-one ((type express-entity-type-mo)
                     &optional init-value)
  (declare (ignore init-value))
  (make-one (class-name type)))

;;; POD modified 7/17/97 added or to allow useful init-value
(defmethod make-one ((td simple-typ) &optional init-value)
  (or init-value nil))

;;; POD modified 7/17/97 added or to allow useful init-value
(defmethod make-one ((td string-typ) &optional init-value)
  (or init-value ""))

(defmethod make-one ((td generic-typ) &optional init-value)
  (or init-value t))

;;; record-of-types is just an atom on defined-type
(defmethod make-one ((type express-defined-type-mo) &optional init-value)
  (declare (ignore init-value))
  (typecase (type-descriptor type)
    (select-typ ; Warning user, you are headed in the wrong direction!
     (make-one (type-descriptor type) init-value))
    (otherwise
     (make-instance 'defined-value :value init-value :record-of-types (class-name type)))))

(defmethod make-one ((td forward-referenced-class) &optional init-value)
  (make-one (find-class (class-name td)) init-value)) ; PODsampson find-eu-class

;;; POD 4/2/99 Out of the blue, this is now needed!!!
;;; POD 6/03/04 ...and what was provided 4/2/99 is probably not a solution!
;;; What should you get when the user ask for the assignment to a select type?
;;; If it is even valid express (???) it depends on what kind of value he is assigning. 
;;; I'll take a guess using the first underlying type that is appropriate for the value.
;;; I am not going to bother with nested defined types/p21 keywords.
(defun who-contains (type-name select)
  (flet ((obj2name (obj) (if (symbolp obj) obj (class-name (class-of obj))))
         (name2obj (name) (if (symbolp name) (find-class name) name))) ; PODsampson find-eu-class
    (loop for td in (select-list select) 
          when (member type-name (mapcar #'obj2name 
                                         (collect-underlying-types (name2obj td))))
          return (name2obj td))))

(defmethod make-one ((td select-typ) &optional init-value)
  (cond ((integerp init-value)
         (when-bind (ty (who-contains 'integer-typ td))
           (return-from make-one (make-one ty init-value))))
        ((numberp init-value)
         (when-bind (ty (or (who-contains 'real-typ td) 
                            (who-contains 'number-typ td)))
           (return-from make-one (make-one ty init-value))))
        ((stringp init-value)
         (when-bind (ty (who-contains 'string-typ td))
           (return-from make-one (make-one ty init-value)))))
  ;; If you get this far, you get what you deserve.
  (make-one (find-class (first (select-list td))) init-value)) ; PODsampson find-eu-class

(defun express-agg2lisp-list (agg)
  (if (listp agg)
      agg
    (value agg)))

;;; 2009-06-05 Added for the P28 parser.
(defmethod make-one ((td number-typ) &optional init-value)
  (if (stringp init-value)
      (read-from-string init-value)
      init-value))


