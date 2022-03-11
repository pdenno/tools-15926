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
;;; Purpose:
;;; Define the metaobjects for express meta-information and behavior.
;;; These metaobjects support the Express object model. In particular, this
;;; code  specializes the CLOS object model in these ways:
;;;  (1) Defines express-entity-type-mo, a specialization of standard class. 
;;;      A make-instance method specifies the class name as a list of
;;;      describing a express complex entity type. If such a combination of
;;;      the base types, (those defined with ENTITY...END_ENTITY;), does not
;;;      exist, make-instance creates the class. 
;;;  (2) Specializes the slot processing to perform Express slot inheritence
;;;       behavior. 
;;;  (3) Adds features to slots for inverse, derived, optional, etc.
;;;  (4) Adds a few slots to the specialized class-object, express-entity to
;;;      record the evaluated-set, supertype-express and book-keeping.
;;;
;;; Some code derived from Kiczales et. al., "The Art of the Metaobject Protocol" 
;;;
(in-package :expresso)

(declaim (inline entity-mo-p ientity-mo-p))
(defun entity-mo-p (obj)
  "Returns T if OBJ is a express-entity-type-mo"
  (typep obj 'express-entity-type-mo))

(defun ientity-mo-p (obj)
  "Returns T if OBJ is an instantiable-express-entity-type-mo"
  (typep obj 'instantiable-express-entity-type-mo))




;;; POD This could be much more general (defining the method etc.)...
(defclass instance-tracking-mo (closer-mop:standard-class)
  ((instances :accessor instances :initform (make-hash-table))))

(defmethod validate-superclass ((class instance-tracking-mo)
				(superclass closer-mop:standard-class))
  t)

;;; Useful for things that apply to defined types, entity types, view types etc.
;;; Getting the class-name (despite collision names) is such a shared activity.
(defclass express-standard-class (closer-mop:standard-class)
   ;; Pointer to the model to which this class belongs.
  ((mofi:of-model :accessor mofi:of-model :initform nil)
   (mexico-obj :reader mexico-obj :initarg :mexico-obj :initform nil)))

(defmethod validate-superclass ((class express-standard-class)
				(superclass closer-mop:standard-class))
  t)

;;;(defmethod class-name :around ((type-mo express-standard-class))
;;;  (call-next-method))

  
;;;================================================================
;;; A class (not a metaobject) for Express constant definitions.
;;;================================================================
(defclass express-constant ()
  ((name :initarg :name)
   (value :initarg :value :reader value))
  (:metaclass instance-tracking-mo))

(defmethod initialize-instance :after ((constant express-constant) &key name)
  (setf (gethash name (instances (find-class 'express-constant)))
        constant))

(defmethod express-constant-value (constant-name) 
  "Does lazy evaluation of constant values. Necessary because they
   might not be known until run-time.
    Args: constant-name : a symbol naming the constant."
  (let ((constant (gethash constant-name (instances (find-class 'express-constant)))))
    (unless constant
      (error 'constant-non-existent :name constant-name))
    (let ((value (value constant)))
      (if (functionp (value constant))
          (setf (slot-value constant 'value) (funcall value))
        value))))

;;;================================================================
;;; The class metaobject class for Express DEFINED types.
;;;================================================================
(defclass express-defined-type-mo (express-standard-class)
  ((type-descriptor :accessor type-descriptor)
   (schema :initarg :schema :accessor schema) ;; POD not using initarg, but could.
   (where-test :accessor where-test :initform nil)))

(defMethod validate-superclass ((class express-defined-type-mo) 
                                (superclass standard-class))
  t)

;;; Shared because could be redefinition.
(defmethod shared-initialize :after ((class express-defined-type-mo) slot-names &key)
  (setf (gethash (class-name class) (defined-types (schema *expresso*))) class))

;;; PODsampson not used.
#+nil 
(defmethod shared-initialize :after ((class express-defined-type-mo) slot-names &key)
  (let* ((class-name (class-name class))
         (class-namestring (symbol-name class-name)))
    (setf (slot-value class 'short-name) 
          (euintern (subseq class-namestring (1+ (position #\. class-namestring)))))
    (setf (gethash class-name (defined-types (schema *expresso*))) class)))

;;;================================================================
;;; The class metaobject class for Express ENTITY types.
;;;================================================================
;;; It has direct slots, it does not have effective slots.
;(defclass express-entity (standard-class)
;  ()
;  )

(defclass express-entity-type-mo (express-standard-class)
   ((supertype-constraint :initform nil :accessor supertype-constraint)
    (supertype-expression :initform nil :accessor supertype-expression)
    (schema :initarg :schema :accessor schema :initform nil) 
    (mofi:abstract-p :initarg :abstract-p :initform nil :accessor mofi:abstract-p) 
    (subtype-of :initarg :subtype-of :accessor subtype-of :initform nil)
    (string-class-name :initarg :string-class-name :accessor string-class-name 
		       :initform "")
    (uniqueness :initform nil :accessor uniqueness)           ;; A list of lists (<label> <attr>...<attr>) 
    (properties :accessor properties :initform nil)))

(defmethod print-object ((class express-entity-type-mo) stream)
  (format stream "{~A ~A}"	    
	  (model-name (mofi:of-model class)) ; 2012 mofi:
          (class-name class)))

(defmethod validate-superclass ((class express-entity-type-mo)
				(superclass express-standard-class))
  t)

(defmethod shared-initialize  :after ((class express-entity-type-mo) slot-names &key)
  "This method runs on creation of each express class, (but not programmatic classes)."
  (declare (ignore slot-names))
  ;; Most of these really needed on class redefinition, thus shared-initialize.
  (setf (mofi:of-model class)
	(unless (eql 'entity-root-supertype (class-name class))
	  ;;2013-03-12(schema *expresso*)
	  mofi:*model*))
  (setf (mofi:abstract-p class) nil)
  (setf (supertype-constraint class) nil)
  (setf (subtype-of class) nil)
  (setf (uniqueness class) nil)
  (unless (eql (class-name class) 'entity-root-supertype)
    (setf (gethash (class-name class) (entity-types (schema *expresso*))) class))
  class)

;;;================================================================
;;; Instances of these are of a class which has superclasses of type of express-entity-type-mo.
;;; They are created by make-programmatic class. Entity instances of these types may exist.
;;; It has effective slots, its direct slots are meaningless.
;;;================================================================
(defclass instantiable-express-entity-type-mo (express-standard-class)
  ((express-class-list :initarg :express-class-list :reader express-class-list
		       :initform nil)
   (memorable-p :initarg :memorable-p :initform t :accessor memorable-p)
    ;; non-xmi-hidden slots in p21 order.
   (mofi:mapped-slots :reader mofi:mapped-slots :initform nil)))
   ;PODsampson(prints-internal-p :initform nil :reader prints-internal-p))
  ;; if true it is the name of the leaf.

(defmethod mofi:abstract-p ((class instantiable-express-entity-type-mo))
  nil)

;(defmethod print-object ((class instantiable-express-entity-type-mo) stream)
;  (if *print-escape*
;      (print-unreadable-object (class stream :type t)
;        (prin1 (class-name class) stream))
;    (prin1 (class-name class) stream)))

(defmethod print-object ((class instantiable-express-entity-type-mo) stream)
  (format stream "{~A ~A}"	    
	  (model-name (mofi:of-model class)) ; 2012 mofi:
          (class-name class)))

(defun clear-instantiated-types (schema)
  "As much as posible, remove knowledge of all instances of instantiable-express-entity-type-mo."
  (setf (class-direct-subclasses (find-class 'entity-root-supertype)) nil)
  (loop for simple-entity-type being the hash-value of (entity-types schema)
	do (setf (class-direct-subclasses simple-entity-type) nil)))

(defmethod validate-superclass ((class instantiable-express-entity-type-mo)
				(superclass express-entity-type-mo))
  t)


;;;=============================================================================
;;; Slot Metaobjects...
;;;=============================================================================
;;; All about slots: 
;;;   - e-e-t-mo classes have direct slots of type express-direct-slot-definition.
;;;   - e-e-t-mo effective slots are of no interest; they are never used.
;;;   - e-e-t-mo classes have slots with simple names (direct and effective).
;;;   - i-e-e-t-mo classes do not have direct slots (breaks LW inspector???)
;;;   - i-e-e-t-mo classes have effective slots with names <entity name>.<simple name>              
;;;   - compute slots calls compute-effective-slot-definition which makes these '.' names.
;;;
;;; ------- DIRECT-SLOT-DEFINITION -----------
;;; Define additional slots in the slot definition.
(defclass express-direct-slot-definition (standard-direct-slot-definition)
    ((derived :initarg :derived :initform nil :reader slot-definition-derived)   ;; Express info
     (inverse :initarg :inverse :initform nil :reader slot-definition-inverse)    ;; Express info
     (optional :initarg :optional :initform nil :reader slot-definition-optional)  ;; Express info
     ;; The simple entity type defining the slot.
     (source :initarg :source :reader slot-definition-source :initform nil)
     (range :initarg :range
		   :accessor slot-definition-range :initform nil)
     (renamed-as :initarg :renamed-as :initform nil :reader renamed-as)
     ;; 2009-06-14 I think the :initarg is never used. This is calculated.
     (redefined-by #|2009 :initarg :redefined-by|# :initform nil) ;; NEAREST slot redefining this one.
     (redefinition-of :initarg :redefinition-of :initform nil)
     (mofi:xmi-hidden :initarg :xmi-hidden :initform nil :reader mofi:slot-definition-xmi-hidden)))

;;; This is the generic function subclass used for accessors to entity attributes.
(defclass express-generic-function-mo (standard-generic-function)
  ((schema :initarg :schema :accessor schema))
  (:metaclass funcallable-standard-class)) 

(defun mak-meth-lambda (gf lambda)
  (closer-mop:make-method-lambda 
   gf 
   (closer-mop:class-prototype (find-class 'standard-method))
   lambda
   nil)) ;env

;;; Called on each slot whenever a express-entity-type-mo class is defined
;;; (not called on instantiated classes).
;;;
;;; Purpose(1):
;;;   As defined in the translated lisp, express-entity-type-mo objects do not
;;;   have accessors defined on them. This is because we really didn't
;;;   know all the names the accessor might go by (because Express
;;;   redefined attributes are named by <source>.<attr-name>). These
;;;   new direct-slots are created in compute-effective-slot-defintion.
;;;   By using an init-instance :after method we catch them all.
;;;   It is only necessary to do this on atomic express-entity-type-mo
;;;   direct slot definitions.
;;;
;;; Purpose(2):
;;;   Put the class-name of the class contributing this
;;;   slot into the source slot.
;;; ARGS: slot   - 
;;;       class  - the express-entity-type-mo class defining the dslot (nil in Lispworks).
;;;       name   - the [simple] name of the slot. 
(defmethod initialize-instance :after ((slot express-direct-slot-definition)
				       &rest initargs &key class name)
  (declare (ignore initargs))
    ;;------------------------
  (let* ((class-name 
	  #-LispWorks (class-name class) 
	  #+LispWorks (if class (class-name class) *current-class-name*)) ; lw 5.0 still necessary.
	 (hidden-p (mofi:slot-definition-xmi-hidden slot))
	 (schema (unless hidden-p (schema *expresso*))))
    #+LispWorks 
    (progn ;; In lispworks, a standard-class was already created, and not passed here.
      (unless (or *schema-loading* class hidden-p)
        (error 'invalid-class-name :name *current-class-name*))
      (setq class (safe-find-class class-name))) ; PODsampson was safe-find-eu-class
    ;PODsampson(setf (slot-definition-source slot) class-name)
    ;; Only performed on simple entity types. Note that I can't say check for class
    ;; express-entity-type-mo because (in the Lispworks case) it may not yet exist. 
    (unless (or (ientity-mo-p class) hidden-p)
      (flet ((?-reader-func (name gf)
	       (mak-meth-lambda 
		gf
		`(lambda (symbol gqualifier)
		   (declare (ignore gqualifier))
		   (let ()
		     (cond ((eql symbol :?) :?)
			   (t (error 'bad-accessor-call :accessor ',name :object symbol)))))))
            (reader-func (name gf) ;; This one is even called on derived slots. Name is a simple name.
	      (mak-meth-lambda 
	       gf
	       `(lambda (instance gqualifier)
		  (let* ((eslot (select-slot (class-of instance) ',name gqualifier))
			 (derived-fname (and eslot (slot-definition-derived eslot)))
			 (full-name (and eslot (slot-definition-name eslot))))
		    (cond ((null eslot) :?)
			  (derived-fname
			   (funcall derived-fname instance nil))
			  ;; If it is inverse and unbound, return :?
			  ((and (slot-definition-inverse eslot)
				(not (slot-boundp instance full-name)))
			   :?)
			  ((slot-boundp instance full-name)
			   (slot-value instance full-name))
			  (t :?))))))
	    (writer-func (name gf) ; name - a simple name
	      (mak-meth-lambda 
	       gf
	       `(lambda (new-value instance gqualifier)
		  (let* ((eslot (select-slot (class-of instance) ',name gqualifier))
			 (derived-fname (slot-definition-derived eslot)))
		    (if derived-fname
			(express-error setting-derived-attribute :attribute ',name :object instance)
			(setf (slot-value instance (slot-definition-name eslot)) new-value))))))
            (expo-add-method (gf method)
               #+CMU (loop for m in (similar-methods gf method) do (remove-method gf m))
               (add-method gf method)))
       (let* ((fn-name (string2accessor-name (or (renamed-as slot) name)))
              (reader-gf
                (ensure-generic-function
                 fn-name :lambda-list  '(object gqualifier)
                 :generic-function-class 'express-generic-function-mo))
              (writer-gf
                (ensure-generic-function
                 `(setf ,fn-name)
                 :lambda-list '(new-value object gqualifier)
                 :generic-function-class 'express-generic-function-mo)))
	 (unless hidden-p
	   (setf (schema reader-gf) (interned-name schema)))
         ;; See lispworks-fix-forward-methods
         #+LispWorks
	 (unless hidden-p
	   (setf (gethash reader-gf (accessors schema)) (list reader-gf writer-gf)))
	 ;; READER : this one will call for derived slots if necessary.
	 (expo-add-method
          reader-gf
	  ;; Maybe this should be a standard-reader-method, etc.
          (make-instance 'standard-method 
                         :lambda-list '(object gqualifier)
                         :qualifiers ()
                         :specializers (list class (find-class t))
                         :function (coerce (reader-func name reader-gf) 'function)))
	 ;; READER ON :?
	 (expo-add-method
          reader-gf
          ;; Maybe this should be a standard-reader-method, etc.
          (make-instance 'standard-method 
                         :lambda-list '(symbol gqualifier)
                         :qualifiers ()
                         :specializers (list (find-class 'symbol) (find-class t))
                         :function (coerce (?-reader-func name reader-gf) 'function)))
	 ;; WRITER : 
         (expo-add-method
          writer-gf
          (make-instance 'standard-method 
                         :lambda-list '(new-value object gqualifier)
                         :qualifiers ()
                         :specializers (list (find-class t) class (find-class t))
                         :function (coerce (writer-func name writer-gf)' function))))))))

(defun bad-slot-access-error (slot-name gqualifier)

  ;; The EXPRESS LRM says in 12.7.3 that referencing an attribute that
  ;; doesn't exist should return indeterminate (?) instead of
  ;; signalling an error.  We should probably arrange for the error to
  ;; be noted, but execution continue at some debug level.

    (if gqualifier
	(error 'entity-no-attribute
	       :entity (string gqualifier)
	       :attribute slot-name)
      (error 'entity-no-attribute-or-multiple :attribute slot-name)))

;;; POD This needs to execute as fast as possible. It conses....but it is memoized....but is uses &rest
(defun select-slot (&rest args)
  " Algorithm: (1) if gqualifier, use it to eliminate slots not on gqualifier path.
               (2) if just one candidate, use it.
               (3) if more than one and all on same path, least specific (or most specific derived if one exists).
               (4) if both gqualifier and *focus-partial-context* then in a recurrsive with no solution (error).
               (5) if *focus-partial-context* call with it as gqualifier.
               (6) error, no such slot exists.
    Args: class      - an instantiable-express-entity-type-mo.
          name       - the simple-name (symbol in eu) of the slot.
          gqualifier - the group qualifier (symbol in eu naming an entity type) of the slot or nil."
  (flet ((select-error (name class) (error 'entity-no-attribute :attribute name :entity class))
         (project-slots  ; return those eslots that are of type gqualifier or one of its subtypes in the instance.
          (eslots gqualifier class-list)
          (let ((types (intersection class-list (cons gqualifier (subtypes gqualifier)))))
            (remove-if #'(lambda (x) (not (find (slot-definition-source x) types))) eslots ))))
    ;;-------------
    (let* ((class (first args))
           (name  (second args))
           (gqualifier (third args))
           (eslots (class-slots class))
           (eslots (remove-if #'(lambda (x) (not (eql name (slot-definition-simple-name x)))) eslots))
           (eslots (if gqualifier (project-slots eslots gqualifier (express-class-list class)) eslots))
           (found nil))
      (declare (type symbol name)
               (type symbol gqualifier)
               (special *focus-partial-context*))
      (cond ((null (cdr eslots)) ; (2)
             (first eslots))
            ((setq found (same-path-p eslots)) ; (3)
             found)
            ((and gqualifier *focus-partial-context*) ; (4)
             (select-error name class))
            (*focus-partial-context*                  ; (5)
             (when-bind (focus? (first (intersection *focus-partial-context* (express-class-list class))))
               (select-slot class name focus?)))
            (t
             (select-error name class))))))

(eval-when (:execute :load-toplevel)
  (memoize 'select-slot :test #'equal :key #'identity))

(defun same-path-p (eslots)
  "Returns least specific argument eslot if there is a common root to the argument effective slots
   EXCEPT when the most specific is derived, then return that."
  (let* ((sources (mapcar #'slot-definition-source eslots))
         (leaves (relative-leaves (append sources (supporting-supertypes sources))))
         (roots (relative-roots sources))
         (leaf-eslot (find (first leaves) eslots :key #'slot-definition-source)))
    (cond ((cdr leaves)  ; should only be one leaf
           nil)
          ((slot-definition-derived leaf-eslot)
           leaf-eslot)
;          ((null (cdr roots)) ; POD should only be one root???
;           nil)
          (t
           (find (first roots) eslots :key #'slot-definition-source)))))

;;; POD I don't know if this is ever called. 
;;; It seems no-applicable-method gets called instead.
(defun bad-reader (object slot-name qualifier)
  (cond (*production*
         (if qualifier
             (express-error
              bad-entity
              "Could not access the attribute SELF\~a.~a of this entity."
              qualifier slot-name)
           (express-error
	    bad-entity
            "Could not access the attribute ~a of this entity."
            slot-name)))
        (t
	 (express-error no-slot-in-instance :instance object :slot slot-name)
	 )))

;;; The tie-in to the MOP slot definition is to define this method,
;;; which returns the specialization of standard-direct-slot-definition.   
(defmethod direct-slot-definition-class ((class express-entity-type-mo) &rest initargs)
  (declare (ignore initargs))
  (find-class 'express-direct-slot-definition))

(defclass express-effective-slot-definition 
  (standard-effective-slot-definition) 
  ((range :reader slot-definition-range :initform nil)
   (source :reader slot-definition-source)
     ;; effective source is an instantiable express entity type object. 
   (effective-source :initform nil :reader mofi:slot-definition-effective-source)
   (derived  :reader slot-definition-derived :initform nil)
   (inverse  :reader slot-definition-inverse :initform nil)
   (optional :reader slot-definition-optional :initform nil)
   (simple-name :accessor slot-definition-simple-name)
   (encode-as :reader slot-definition-encode-as :initform nil)
   (redefined-by :reader slot-definition-redefined-by :initform nil)
   (renamed-as :reader slot-definition-renamed-as :initform nil)
   (mofi:xmi-hidden :initarg :xmi-hidden :initform nil :reader mofi:slot-definition-xmi-hidden)))


(defmethod mofi:slot-direct-slot ((slot express-direct-slot-definition))
  slot)

(defmethod mofi:slot-direct-slot ((slot express-effective-slot-definition))
  (find (closer-mop:slot-definition-name slot)
	(closer-mop:class-direct-slots (slot-definition-source slot))
	:key #'closer-mop:slot-definition-name))

;;; 2012 copied from get-p21.lisp
(defmethod entity-type-prints-internal-p ((entity-class-object instantiable-express-entity-type-mo))
  (let ((leaves (relative-leaves (express-class-list entity-class-object))))
    (if (null (second leaves))
        (first leaves)
      nil)))

(defun effective-slots-in-p21-order (slots class)
  "Sort SLOTS of a programmatic class CLASS into p21 order."
  (let* ((internal-leaf (entity-type-prints-internal-p class))
         (class-order (if internal-leaf 
                           (p21-precedence-order internal-leaf)
                        (express-class-list class)))) ; e-c-l is alphabetical
    (flet ((compare-fn
            (slot-1 slot-2) ;; effective-slots
            (let ((pos-in-class-1 (position (slot-definition-source slot-1) class-order))
                  (pos-in-class-2 (position (slot-definition-source slot-2) class-order)))
              (cond ((< pos-in-class-1 pos-in-class-2)
                     t)
                    ((= pos-in-class-1 pos-in-class-2)
                     (let ((direct-slots (class-direct-slots 
                                          (find-class (elt class-order pos-in-class-1))))) 
                       (< (position (slot-definition-simple-name slot-1) direct-slots
                                    :key #'slot-definition-name)
                          (position (slot-definition-simple-name slot-2) direct-slots 
                                    :key #'slot-definition-name))))))))
      (let ((mapped-slots (remove-if #'mofi:slot-definition-xmi-hidden slots)))
        (append (sort mapped-slots #'compare-fn) 
		(set-difference slots mapped-slots))))))

;;; 2009-09-03 Apparently there was something like xmi-hidden 
;;; in this code for a slot called dataset. 
;(defmethod class-slots ((class instantiable-express-entity-type-mo))
;  (remove-if #'(lambda (x) (eql 'dataset (slot-definition-name x))) (call-next-method)))

;;; The tie-in to the MOP slot definition is to define this method,
;;; which returns the specialization of standard-effective-slot-definition.
(defmethod effective-slot-definition-class 
  ((class instantiable-express-entity-type-mo)
   #-(or LispWorks4.1 LispWorks4.2) &rest
   initargs)
  (declare (ignore initargs))
  (find-class 'express-effective-slot-definition))

;;;---- Handling redefined attributes and attributes of the
;;;---- same name inherited from different entities.
;;; Note: compute-slots will be called on each instantiated programmatic
;;;       class when the parent ENTITY is re-defined. This could be
;;;       expensive once very many subtypes are defined. 
;;; In CLOS, compute-slots is called by finalize inheritance, after the call to 
;;; compute-class-precedence-list
(defmethod closer-mop:compute-slots ((class instantiable-express-entity-type-mo))
  "Call compute-effective-slot-definition for each collection of dslots that are 
   keyed by (slot-name slot-source)."
  (effective-slots-in-p21-order 
   (mapcar #'(lambda (same-slots)
	       (compute-effective-slot-definition
		class 
		(slot-definition-name (car same-slots))
		same-slots))
	   (equiv-classes 
	    (mapappend #'class-direct-slots ; 2012 If I don't remove ERS this fails
		       ;(remove (find-class 'entity-root-supertype) ; 2013 !
			       (closer-mop:class-precedence-list class));)
	    :key (lambda (s) (list (slot-definition-name s)
				   (slot-definition-source s)))))
     class))

#| commented out today 2009-09-04
;;; Based on Kizales, AMOP, pg 81. 
;;; New for PODsampson  (may not be necessary).
(defmethod closer-mop:compute-class-precedence-list ((class instantiable-express-entity-type-mo))
  (call-next-method))
;  (let ((root (find-class 'entity-root-supertype)))
;    (append 
;     (remove root (remove-duplicates (mofi::depth-first-preorder-superclasses* class) :from-end t))
;     (list root (find-class 'standard-object) (find-class t)))))
|#


(declaim (inline compose-slot-name))
(defun compose-slot-name (entity-name slot-name)
  "Slot name for an effective-slot it is <entity-name>.<slot-name>."
  (intern (format nil "~A.~A" entity-name (string-upcase slot-name))
	  (lisp-package (schema *expresso*))))

;;; Args: class - an instantiable express class object. 
;;;       direct-slots - the complete list of slots having a common name.
;;; Value: A list of effective slots, one for each direct slot. The new slot's
;;;        name is <source>.<simple-name> 
;;;

;;; POD need a most-specific-type (like mof.lisp) to choose range (at least). 
(defmethod compute-effective-slot-definition ((class instantiable-express-entity-type-mo)
					      name-in direct-slots) ;; 2005-12-02
  "Create an effective-slot object, handling redefined range and renaming."
  (let* ((most (mofi::most-specific-type 
		(remove-duplicates 
		 (mapcar #'slot-definition-source direct-slots))
		:root 'entity-root-supertype))
	 (eslot (call-next-method))
	 (dslot (find most direct-slots :test 
		#'(lambda (m x) 
		    (let ((source (slot-definition-source x)))
		      (if (symbolp source)
			  (eql source m)
			(eql (class-name source) m)))))))
    (setf (slot-definition-simple-name eslot) name-in)
    (with-slots ((d-optional optional) (d-derived derived) (d-inverse inverse) 
		 (d-source source) (d-range range) (d-xmi mofi:xmi-hidden)) dslot
      (with-slots ((e-optional optional) (e-derived derived) (e-inverse inverse) 
		   (e-source source) (e-range range) (e-xmi mofi:xmi-hidden) effective-source) eslot
	(setf e-optional d-optional)
	(setf e-inverse d-inverse)
	(setf e-source d-source)
	(setf e-range d-range)
	(setf e-xmi d-xmi)
	(setf effective-source class)
	(unless (mofi:slot-definition-xmi-hidden eslot) ; 2012 mofi:
	  (setf (slot-definition-name eslot) (compose-slot-name d-source name-in))) ; 2012 mofi:
	(setf (slot-definition-initargs eslot) 
	      (list (kintern (format nil "~A.~A" d-source name-in)) (kintern name-in)))
	(when d-derived
	  (setf e-derived (intern (format nil "%~A-DERIVED" (symbol-name name-in)) 
				  (lisp-package (schema *expresso*)))))))
    eslot))

	   
;;; ==========================================================
;;; ================= Programmatic class facility ============
;;; ==========================================================
;;; Purpose: If the class exists, return it.
;;;          otherwise create the class and return it.
;;;          Based on Kiczales' function by the same name.
;;;
;;; Args: classes - an alphabetical list of class names, might not be alphabetically sorted,
;;;                 might not include all necessary supertypes.
;;; POD Should also check that there is a common supertype to everything in the list...

(defmethod find-programmatic-class ((unconditioned list) &key allow-partial (error-p t))
  (unless (every #'(lambda (x) ;; Everything must be a e-e-t-mo, duh.
                     (when-bind (class (find-class x nil)) ; 2013-03-07 added errorp (nil)
                       (entity-mo-p class)))
                 unconditioned)
    (if error-p
      (express-error
       bad-entity
       "~a ~%is not a valid collection of entity types for construction of an entity."
       unconditioned)
      (return-from find-programmatic-class nil)))
    (let* ((classes (sort (remove-duplicates 
			   (mapcar #'(lambda (x) (intern (string x) (lisp-package (schema *expresso*))))
				   (append unconditioned (supporting-supertypes unconditioned))))
			  #'string<)) 
	   ;; Don't drop the last '& ~{~A~^&~} or you may wipe out a simple entity type (when one class).
	   (class-name (intern (format nil "~{~A&~}" classes) (lisp-package (schema *expresso*)))))
      (or
       (find-class class-name nil)
       (let ((is-abstract
	      (loop for class in classes ; Check whether the list includes a subtype for every abstract type.
		 when (and (mofi:abstract-p (find-class class nil)) 
			   (not (intersection classes (subtypes class))))
		 return class
		 finally (return nil))))
	 (when (and is-abstract (not allow-partial))
	   (error 'abstract-entity :unsupported-type is-abstract
		  :possible-subtypes (subtypes is-abstract)))
	 (make-programmatic-class classes class-name :remember (if allow-partial (not is-abstract) t))))))

#| Not yet completed...
    (or (= 1 ; There must be exactly one unique supertype of all the types in the list OR...
           (length (reduce #'intersection 
                           (mapcar #'(lambda (x) (cons x (supporting-supertypes (list x)))) classes))))
        ;; ... there are multiple-inheriting types in the graph, and these "join points" connect all
        ;; of the topmost types. That is, the network is connected. To determine that it is, you need to ensure
        ;; that there is a path (through multiple-inheritance 'links') from each topmost to every other one.
        (let* ((supertypes (remove-if #'(lambda (x) (supporting-supertypes (list x))) classes))
               (join-points (remove-if #'(lambda (x) (< (length (subtype-of (find-eu-class x))) 2)) classes))
               (links 
                ;; < remove duplicates with intersection>
                (mapcar #'(lambda (jp) 
                            (mapappend #'(lambda (x) ; the collection of supertypes from this joint.
                                           (intersection supertypes (cons x (supporting-supertypes (list x)))))
                                       (subtype-of (find-eu-class jp))))
                        join-points)))
          (unless nil ; (connected-graph links)
            (error 'disjoint-types :types nil))
|#


;;; Argument are pairs representing navigation from one node to another.
;;; Navigation is bi-directional. Returns true if there is a path from any node
;;; to every other node.
(defun connected-graph (links)
  (declare (ignore links))
  t)

  
(defun make-programmatic-class (classes class-name &key (remember t))
  "Return an instantiable-express-entity-type-mo having a name that is a concatenation
   of all the argument superclasses names with '&' in between.
   Args: classes - a sorted (alphabetic) list of superclasses names, does not 
   include entity-root-supertype."
  (when (get-option validation-complex-type-check-opt)
    (unless (valid-complex-type-p classes)
      (express-error
       bad-entity
       "~a ~%is not a valid collection of entity types for construction of an entity."
       classes)))
  (pushnew class-name (programmatic-type-names (schema *expresso*)))
  (let ((class ; POD would ensure-class ala mof.lisp better? .. remove safe-find-class?
	 (make-instance 'instantiable-express-entity-type-mo	 
			:name class-name
			:express-class-list classes
			:memorable-p remember
			:direct-superclasses (append 
					      (mapcar #'find-class classes) 
					      (list (find-class 'entity-root-supertype)))
			:direct-slots nil)))
    (setf (find-class class-name) class)
    (finalize-inheritance class)
    (setf (mofi:of-model class) (mofi:of-model (find-class (first classes)))) ; 2012 mofi:
    (with-slots (mofi:mapped-slots) class
      (setf mofi:mapped-slots (remove-if #'mofi:slot-definition-xmi-hidden (class-slots class))))
    (class-finalize-slots class)
    class))


;;; Purpose: If a class by that name exists, return it,
;;;          otherwise return a forward-referenced-class.
;;;          Note that find-class will return a forward-referenced-class
;;;          when one exists. 
(defun safe-find-class (class-name)
  (let ((class (find-class class-name nil)))
    (if class
	class
      (let ((class (make-instance 
		    'forward-referenced-class
		    :name class-name)))
	#+LispWorks (setf (class-name class) class-name)
	class))))

#|
Unlike real application programs (that put semantics behind 
variables they read from a p21 file) this program doesn't necessarily know
the domain of a value type (express Simple Type) object by looking
at the value. Even having the entity type definition is sometimes not sufficient.
The need for Part 21 'keywords' which name the domain are one consequence of this fact.
Thus in this program we sometimes need to carry this information. 
It is my current theory, POD, 2004-06-04, that defined-values 
need only be used (taking the place of raw simple types) when:
  (1) a defined-type value is created programmatically (e.g. Express-x, express LOCAL)
  (2) an attribute value read from P21 data needed to use a 'P21 Keyword' 
     (or its equivalent in P28 etc.)
The second of these (implemented with select-value) has been a part of Expresso for many years. 
But select-value is now a subtype of the new type defined-value. (1) will get exercised all 
over the place in Express-x and also in Express functions that create local variables of defined types.
The make-one method for defined-value is new with this comment as is the replacement of 
setf with express-assign in assignment statements and express-x assignments (SELECT body).
At the same time, P21 generation (write-entity) gets a new method for defined-value 
subsuming the one for select-values and furthermore checking whether the use of KEYWORDS
really were necessary (as stipulated in Part 21) to disambiguate the value. 
It could be that the p21 (or equivalent) input mistakenly used them. 
|#
(defclass defined-value ()
  ((value :initform nil :accessor value :initarg :value)
   (record-of-types :initform nil :accessor record-of-types 
		    :initarg :record-of-types)))

(declaim (inline value-maybe-defined))
(defun value-maybe-defined (arg)
  "Wraps expressions where a value is expected but a 
   defined value object might be provided."
  (if (typep arg 'defined-value)
    (value arg)
    arg))

;; this will be replaced by the method above -- CTL
(defmethod print-object ((object defined-value) stream)
  (write-entity object stream :p21))

(defclass select-value (defined-value)
  ())


(defun subtypes (name)
  "Returns the SIMPLE, DIRECT subtype data types of entity or select types.
   Args name - the name of an entity or select data type."
  (let ((class (find-class name))) 
    (unless class
      (express-error
       bad-entity
       "There is no class named ~a." name))
    (typecase class
      (express-entity-type-mo
       (let ((class-names (set-difference (flatten (supertype-expression class))
                                          '(quote es-and es-andor es-oneof))))
         ;; Check that they are all defined.
         (loop for class-name in class-names
               unless (find-class class-name) do 
               (express-error
                bad-entity
                "One of the classes referenced in ~a does not exist: ~a" name class-name))
         class-names))
      ;; Better be a select type!
      (express-defined-type-mo
       (cond ((typep (type-descriptor class) 'select-typ)
	      ;; POD accumulator necessary?
	      (let* ((select-list (select-list (type-descriptor class)))
		     (result
		      (append (remove-if
			       (complement #'(lambda (x) (entity-mo-p (find-class x)))) 
			       select-list)
			      (mapappend #'subtypes select-list))))
		(remove-duplicates (append result (mapappend #'subtypes result)))))
	     (t  nil))))))


;;; Purpose: Return a list like step 2 of P21 Clause 11.2.5, that is
;;;          remove from the argument entity-root-supertypes those supertypes where one
;;;          or more of its subtypes are in the list.
;;;          NOTE (7/11/99) must send it all all supporting supertypes!
(defun relative-leaves (entity-types)
 "Args : entity-types - a list of entity type names.
  Returns a list of those args which have no subtypes in the argument list."
  (let ((orig (copy-list entity-types)))
    (remove-if #'(lambda (type)
		   (some #'(lambda (subtype) (find subtype orig))
			 (subtypes type)))
	       entity-types)))

;;; POD Modified 7/11/99: replaced subtype-of with all-subtypes.
(defun relative-roots (entity-types)
 "Args : entity-types - a list of entity type names.
  Returns a list of those args which have no supertypes in the argument list."
 (labels ((all-subtypes 
           (type &optional accum)
           "Args type - a express-entity-type-mo. "
           (let ((subtypes (mapcar #'find-class (subtype-of type)))) 
             (cond ((null subtypes) (remove-duplicates accum))
                   (t (remove-duplicates 
                       (append (mapappend #'(lambda (x) (all-subtypes x (cons x accum))) subtypes)
                               accum)))))))
   (loop for type in entity-types
         unless (intersection (mapcar #'class-name (all-subtypes (find-class type))) 
                              entity-types)
         collect type)))

(defun supporting-supertypes (class-names)
  "Return a list of all the types (symbols) from which the
   argument classes inherit, excluding the argument classes themselves.
  CLASS-NAMES - a list of entity data type names."
  (labels ((c-h-aux
	    (name &optional accum) ; POD what is the point of accum here? Never used!
	    (let ((class (find-class name nil)))
	      (if class
		(let ((supertypes (subtype-of class)))
		  (cond ((null supertypes) nil)
			(t 
			 (append accum
				 supertypes
				 (mapappend #'c-h-aux supertypes)))))
		(express-error bad-entity "There is no entity type named ~a." name)))))
    (set-difference
     (remove-duplicates
      (loop for name in class-names
	 append (c-h-aux name (list name))))
     class-names)))

;;; Diagnostic, but so useful that I am leaving it in for now.
#+debug
(defmethod print-object ((instance entity-root-supertype) stream)
  (write-entity instance stream :p21 
                :dataset (find-if #'(lambda (x) (typep x 'express-dataset))
                                  (get-special datasets))))

;;; Purpose: Return the argument class names sorted in the order
;;;          that they would be printed in the internal mapping.
;;;          This ordering is described in part21 11.2.5.1. The
;;;          gist of it, with respect to class ordering is:
;;;     (1) supertype entity appears before its subtype.
;;;     (2) when multiple supertypes exist, they should appear in
;;;         the same relative order as they do in the subtype-of expression.
;;;
;;;   Args: leaf - a entity class name (symbol)
(defun p21-precedence-order (leaf)
  (when leaf
    (p21-po-aux leaf (list :done))))

(defun p21-po-aux (current stack &optional (result nil))
  (let ((children
	 (when (not (eql current :done))
	   (subtype-of (find-class current))))) 
    (cond ((eql current :done)
	   (reverse result))
	  ((or (null children) ;; No children or visited children
	       (not (set-difference children result)))
	   (p21-po-aux (first stack) (rest stack) (pushnew current result)))
	  (t ;; Have unvisited children...
	   (p21-po-aux (first children)
		       (append (rest children) (cons current stack))
		       result)))))

(defmethod class-finalize-slots ((class express-entity-type-mo) &key)
  (class-finalize-slots-aux class))

(defmethod class-finalize-slots ((class instantiable-express-entity-type-mo) &key)
  (class-finalize-slots-aux class))

(defun class-finalize-slots-aux (class)
  (loop for slot-accessor in (list #'closer-mop:class-direct-slots #'closer-mop:class-slots) do
       (loop for slot in (funcall slot-accessor class)
	     for source = (slot-definition-source slot)
	     when (symbolp source) do
	      (if-bind (class (find-class source nil))
		       (setf (slot-value slot 'source) class)
		       (warn "Setting source, I don't know class ~A" source)))))



;;; Purpose: Diagnostic, get the values of express-defined slot-options.
;;; Args: class - a class name
;;; value: An alist: ((slot-name (<option> <value>)...) ...)
#+Debug
(defun slot-options (class-name)
   (let ((class (find-class class-name)))
      (cond ((and class (slot-boundp class 'acl::slots))
               (loop for slot in (class-slots class)
                  do (unless (slot-boundp class 'acl::name)
                        (error "slot-options: Slot not bound. No instances exist?")) 
                  collect
		  `(,(slot-definition-name slot)
		    (:derived ,(slot-definition-derived slot))
		    (:inverse ,(slot-definition-inverse slot))
		    (:optional ,(slot-definition-optional slot)))))
            (t
	     (error "slot-options: No class or no instances?: ~a" class-name)
	     ))))

;;; POD This is obsolete, but something like it may be useful.
#+Debug
(defun debug-read-accessor (object name gqualifier class-name)
  ;; slot is in the closure, we get it here. gqualifier might not be class-name
  (let ((slot (find-direct-slot class-name name)))
  (let ((new-slot nil))
    (cond ((slot-exists-p object name)
           (cond ((slot-value slot 'derived)
                  (funcall (derived-accessor-name name) object nil))
                 ;; If it is inverse and unbound, return :?
                 ((and (slot-value slot 'inverse)
                       (not (slot-boundp object name)))
                  :?)
                 (t
                  (slot-value object name))))
          (t ;; We need to know whether the 'most redefined' slot is DERIVED.
             (cond ((setq new-slot (find-slot-not-redefined object name))
                    (cond ((slot-value new-slot 'derived)
                           (funcall (derived-accessor-name
                                     (slot-definition-simple-name new-slot))
                                    object nil))
                          (t 
                           (let ((original-slot
                                  (or (find-slot-original object name gqualifier)
                                      (loop for qual in *focus-partial-context*
                                            for slot = (find-slot-original object name qual)
                                            when slot do (return slot)))))
                             (unless original-slot (bad-reader object name gqualifier))
                             (slot-value object (slot-definition-name original-slot))))))
                   (t ;; This only occurs if find-slot-not-redefined failed.
                      (bad-reader object name gqualifier))))))))


