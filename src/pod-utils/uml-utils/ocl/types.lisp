
;;; Purpose : Defines basic ocl types, operations and expressions described 
;;;           in chapter 11 of the spec.
;;; Date : 2006-09-09 (Beijing). 

;;; TODO:
;;;   - ocl-is-kind-of, ocl-is-type-of need work.
;;;   - There may be more opportunities to apply value/type-compatible-p.
;;;   - might be more to do with MSG.
;;;   - Study whether should rather be returning self in some methods that 
;;;     I implemented as returning new objects.
;;;   - combine some implementations (sequence and ordered set) (bag and set)
;;;     of some methods are identical (worthwhile ???) This is definitely the case
;;;     where collection expressions (section 11.9.2) is concerned. 
;;;   - OclInvalid ought to be something other than a keyword (which are ocl enum values)

(in-package :ocl)

(setf (slot-value (mofi:find-model :ocl) 'mofi:types ) 
      (make-array 200 :adjustable t :fill-pointer 0))

;;; =====================================================================
;;; Type here masquerade as mm-type-mo classes in two ways:
;;;   Primitive types use Ocl-type-proxy.
;;;   Collection types use a class object. 
;;;   Both are pushed (search for vector-push) on the ocl model .types vector 
;;;   and respond to some mofi:mm-type-mo methods in reasonable ways. 
;;; =====================================================================
(defclass ocl-metaclass (standard-class)
  ())

(defmethod validate-superclass ((class ocl-metaclass) 
                                (superclass standard-class))
  t)

;2011-04-26(defmethod mofi:enum-p ((obj ocl-metaclass)) nil)
(defmethod mofi:abstract-p ((obj ocl-metaclass)) nil)
(defmethod mofi:primitive-type-p ((obj ocl-metaclass)) t)
;2011-04-26(defmethod mofi:datatype-p ((obj ocl-metaclass)) nil)
(defmethod mofi:mapped-slots ((obj ocl-metaclass)) nil)

(defclass -typ () ()) ;; Descriptor for OclAny. These serve the purpose of TypeSpec.

;;; POD Investigate use of standard-class+sei.exe added 2010-06-20 !!!!!!!!!!!!!!!!!
(defclass |Ocl-type-proxy| (-typ standard-class)
   ((|proxy-name| :reader %proxy-name :initarg :proxy-name)))

#+sbcl
(defmethod validate-superclass ((class |Ocl-type-proxy|) (superclass standard-class))
  t)

;;; Ocl-type-proxy is a class define with def-mm-class in ocl-mm.lisp 
;;; (loaded with load-model). It is a class that is attached to the 
;;; mof:mof-type-proxy property of the symbol naming the type, to describe 
;;; the type where a mof object might be needed (this gets around defining 
;;; primitives as instance of classes, the way silly OO people do). 
;;; POD This class is doing both mm-root-supertype stuff and MOF stuff. Is that reasonable?
(defmethod class-name ((obj |Ocl-type-proxy|))
  (%proxy-name obj))

(defmethod print-object ((obj |Ocl-type-proxy|) stream)
  (with-slots (|proxy-name|) obj
    (format stream "{OCL ~A}" |proxy-name|)))

;;; These methods are to make this fake thing look like an M2 class too.
(defmethod mofi:enum-values ((obj |Ocl-type-proxy|)) nil)
(defmethod mofi:abstract-p ((obj |Ocl-type-proxy|)) nil)
(defmethod mofi:primitive-type-p ((obj |Ocl-type-proxy|)) t)
(defmethod mofi:mapped-slots ((obj |Ocl-type-proxy|)) nil)
;;; 2008-06-18
(defmethod class-direct-subclasses ((obj |Ocl-type-proxy|)) nil)
(defmethod mofi:%of-model ((obj |Ocl-type-proxy|)) (mofi:find-model :ocl))
;;; POD What is this ???
#+nil
(defmethod mofi:of-model ((obj |Ocl-type-proxy|))
  (mofi:find-model :ocl :models mofi:*essential-models*))

;;; 2010-06-15 progn --> unless: I'm trying to avoid duplicates types.
(defmacro deftype-ocl (name satisfies)
  (with-gensyms (obj)
  `(unless (find-class ',name nil)
    (deftype ,name () ',satisfies)
    (setf (get ',name 'mofi:mof-type-proxy) t) ; so mofi:mapped-slots doesn't process.
    (let ((,obj (make-instance '|Ocl-type-proxy| :proxy-name ',name)))
      (setf (get ',name 'mofi:mof-type-proxy) ,obj)
      (vector-push ,obj (mofi:types (mofi:find-model :ocl)))
      (setf (find-class ',name) ,obj)))))

;;; listp because we don't compile to a meta-model, but directly to lisp.
(deftype-ocl |OclExpression| (satisfies listp))

;;; This is used in the parser. Not sure it should qualify as |Variable|, but here goes.
(defstruct var-decl
  (-name)
  (-type)
  (-init))

(deftype-ocl |Variable| (satisfies var-decl-p))

(defun ocl-type-p (val)
  (typep val 'mofi:mm-root-supertype))

(deftype-ocl |Type| (satisfies ocl-type-p))

;;; ============= -typ objects (type descriptors) and utilities, such as in expresso.

(defclass primitive-typ (-typ) ())
(defclass boolean-typ (primitive-typ) ())
(defclass string-typ (primitive-typ) ())
(defclass unlimited-integer-typ (primitive-typ) ())
(defclass number-typ (primitive-typ) ())

;(defclass any-typ (primitive-typ) ()) ; 2014 added!

(defclass real-typ (number-typ) ())
(defclass integer-typ (real-typ) ())

(defclass object-typ (-typ)
  ((class-name :initarg :class-name :reader class-name)))

;;; The attributes of these should NEVER be modified (multiple references...)
;;; I use a memoized function to return -typ objects for Model collections.
(defclass collection-typ (-typ) ; POD do collections have identity beyond their elements?
  ((l-bound  :initarg :l-bound :initform 0) ; pod never used?
   (u-bound  :initarg :u-bound :initform :unspecified) ; pod never used?
   (ordered-p :initarg :ordered-p :reader ordered-p :initform nil)
   (unique-p :initarg :unique-p :reader unique-p :initform nil)
   (base-type :initarg :base-type :reader base-type :initform (find-class 'ocl:|OclAny|))))

(defclass tuple-typ (-typ)
  ((role-typs :initarg :role-typs :initform nil)
   (role-names :initarg :role-names :initform nil)))

;;; Having these around will only make defining MSG more difficult.
;(defclass bag-typ (collection-typ)
;  ())

;(defclass set-typ (collection-typ)
;  ((unique-p :initform t))

;(defclass ordered-set-typ (set-typ)
;  ((ordered-p :initform t))

;(defclass sequence-typ (collection-typ)
;  ((ordered-p :initform t)))

(defmethod ordered-set-typ-p ((typ -typ))
  (and (typep typ 'collection-typ)
       (with-slots (unique-p ordered-p) typ
		   (and unique-p ordered-p))))

(defmethod set-typ-p ((typ -typ))
  (and (typep typ 'collection-typ)
       (slot-value typ 'unique-p)))

(defmethod sequence-typ-p ((typ -typ))
  (and (typep typ 'collection-typ)
       (slot-value typ 'ordered-p)))

(defmethod bag-typ-p ((typ -typ))
  (and (typep typ 'collection-typ)
       (with-slots (unique-p ordered-p) typ
	    (and (not unique-p) (not ordered-p)))))

(defun appropriate-collection-type (-typ)
  "Return the symbol naming the appropriate concrete collection type 
   for -TYP, a type descriptor."
  (cond ((null -typ) nil)
	((ordered-set-typ-p -typ) '|OrderedSet|)
	((set-typ-p -typ) '|Set|)
	((sequence-typ-p -typ) '|Sequence|)
	((typep -typ 'collection-typ) '|Bag|)
	(t nil)))

;;; For diagnostics...
#+nil
(defmethod value/type-compatible-p :around (val typespec)
  (let ((result (call-next-method)))
    (unless result
      (setf *zippy* (list val typespec)))
    result))

#| TYPE             VALUES
   OclInvalid      invalid
   OclVoid         null, invalid
   Boolean         true, false

Section 8.2 of 2012-01-01: 
VoidType is the metaclass of the OclVoid type that conforms to all types except the OclInvalid type. 
The only instance of VoidType is OclVoid, which is further defined in the standard library. 
Furthermore OclVoid has exactly one instance called null - corresponding to the UML NullLiteral 
literal specification - and representing the absence of value. Note that in contrast with invalid, 
null is a valid value and as such can be owned by collections.

[ The text above seems to contradict the table (Table 7.1).]

|#

;;; POD probably more work required here. 
;;; POD look into OclVoid and OclInvalid too.
(defmethod value/type-compatible-p (val (typespec -typ))
  "Returns t if the value is compatible with the type. Used to check whether VAL can
   be an element of the collection with underyling type TYPESPEC."
  (cond ((stringp val) (typep typespec 'string-typ))
	((numberp val)
	 (not (and (typep typespec 'number-typ)
		   (and (typep typespec 'integer-typ)
			(not (zerop (rem val 1)))))))
	(t t))) ; pod too permissive

(defmethod value/type-compatible-p (val (typespec symbol))
  "Returns t if the value is compatible with the type. Used to check whether VAL can
   be an element of the collection with underyling type TYPESPEC."
  (and val (typep val typespec))) ; nil is the 'unbound-slot-value' of this implementation.

;;; POD 2008-08-19 added without much thought! -- see where I introduce OclAny in msg
(defmethod value/type-compatible-p (val (typespec |Ocl-type-proxy|))
  "Returns t if the value is compatible with the type. Used to check whether VAL can
   be an element of the collection with underyling type TYPESPEC."
  (eql '|OclAny| (%proxy-name typespec)))

;;; msg = most-specific-generalization
(defmethod msg ((t1 -typ) (t2 -typ))
  "Returns a new -typ object that is the Most Specific Generalization of 
  the argument types T1 and T2."
  (if (typep t2 'primitive-typ)
      (msg t2 t1)
    (make-instance '-typ)))

;(defmethod msg ((t1 any-typ) t2) ; 2014 added
;  (make-instance '-typ))

(defmethod msg ((t1 boolean-typ) t2)
  (if (typep t2 'boolean-typ)
      (make-instance 'boolean-typ)
    (make-instance '-typ)))

(defmethod msg ((t1 string-typ) t2)
  (if (typep t2 'string-typ)
      (make-instance 'string-typ)
    (make-instance '-typ)))

(defmethod msg ((t1 integer-typ) t2)
  (typecase t2
    (integer-typ (make-instance 'integer-typ))
    (real-typ (make-instance 'real-typ))
    (number-typ (make-instance 'number-typ))
    (otherwise (make-instance '-typ))))

(defmethod msg ((t1 real-typ) t2)
  (typecase t2
    (real-typ (make-instance 'real-typ))
    (number-typ (make-instance 'number-typ))
    (otherwise (make-instance '-typ))))

(defmethod msg ((t1 number-typ) t2)
  (typecase t2
    (number-typ (make-instance 'number-typ))
    (otherwise (make-instance '-typ))))

;;; POD 2008-08-19 added without much thought!
(defmethod msg ((t1 t) (t2 t)) t1)


(defmethod msg ((t1 collection-typ) (t2 -typ))
  (cond ((typep t2 'collection-typ)
	 (make-instance 'collection-typ 
			:ordered-p (and (ordered-p t1) (ordered-p t2))
			:unique-p (and (unique-p t1) (unique-p t2))
			:base-type (msg (base-type t1) (base-type t2))))
	(t (make-instance '-typ))))

(defmethod msg ((t1 mofi:mm-type-mo) (t2 mofi:mm-type-mo))
  (if (member t1 (closer-mop:class-precedence-list t2)) t1 t2))

(defmacro ocl-assert (&rest type-decls)
  "TYPE-DECLS are of form (type val1..valN). Raises an error if
   the values are not of that type."
`(progn
   ,@(loop for type-decl in type-decls append
	   (dbind (type &rest vars) type-decl
	       (loop for v in vars collect 
		     `(unless (typep ,v ',type) 
			(error 'ocl-type-error :value ,v :type ',type)))))))

;;;=============== 11.5.4 Boolean =========================
;;; This is the first time I tried this approach. Who knows...
(defmacro ocl-or (form1 form2)
  "Type checking OR expression. A binary expression."
  (with-gensyms (val)
    `(let ((,val ,form1))
       (ocl-assert (|Boolean| ,val))
       (if (eql ,val :true) 
	   :true
	 (let ((,val ,form2))
	   (ocl-assert (|Boolean| ,val))
	   (if (eql ,val :true) 
	       :true
	     :false))))))

(defmacro ocl-xor (form1 form2)
  "Type checking XOR expression. A binary expression."
  (with-gensyms (val1 val2)
    `(let ((,val1 ,form1)
	   (,val2 ,form2))
       (ocl-assert (|Boolean| ,val1 ,val2))
       (if (or (and (eql ,val1 :true) (eql ,val2 :false))
	       (and (eql ,val2 :true) (eql ,val1 :false)))
	   :true
	 :false))))

(defmacro ocl-and (form1 form2)
  "Type checking AND expression. A binary expression."
  (with-gensyms (val)
    `(let ((,val ,form1))
       (ocl-assert (|Boolean| ,val))
       (if (eql ,val :true) 
	 (let ((,val ,form2))
	   (ocl-assert (|Boolean| ,val))
	   (if (eql ,val :true)
	       :true
	     :false))
	 :false))))

(defmacro ocl-not (form)
  "Type checking NOT expression. A unary expression."
  (with-gensyms (val)
    `(let ((,val ,form))
       (ocl-assert (|Boolean| ,val))
       (if (eql ,val :true) :false :true))))

(defmacro ocl-implies (form1 form2)
  "Type checking logical implication. A binary expression."
  (with-gensyms (val1 val2)
    `(let ((,val1 ,form1))
       (ocl-assert (|Boolean| ,val1))
       (if (eql :true ,val1) 
	   (let ((,val2 ,form2))
	     (ocl-assert (|Boolean| ,val2))
	     ,val2)
	   :true))))

;;; This one is a control structure, not part of 11.5.4 (The boolean clause which includes and,or,implies).
(defmacro ocl-if (test then else)
  "Type checking IF expression."
  (with-gensyms (test-val)
    `(let ((,test-val ,test))
       (ocl-assert (|Boolean| ,test-val))
       (if (eql :true ,test-val) ,then ,else))))

;;;======= 11.2 OclAny, OclVoid, OclInvalid OclMessage ====================

;;; 11.2.1 All types in the UML model and the primitive types in the OCL standard library 
;;; comply with the type OclAny. Conceptually, OclAny behaves as a supertype for all 
;;; the types except for the OCL pre-defined collection types. Features of OclAny are
;;; available on each object in all OCL expressions. OclAny is itself an instance of 
;;; the metatype AnyType.
;;;
;;; All classes in a UML model inherit all operations defined on OclAny. 
;;; To avoid name conflicts between properties in the model and the properties 
;;; inherited from OclAny, all names on the properties of OclAny start with 'ocl.'

;;; How do I make (typep :true '|OclAny|) work? Maybe this ought to be
;;; OclAny-obj, and I define an OclAny deftype where it checks for 
;;; numberp, stringp,  Boolean. ...That makes behavior of typep OK, but there 
;;; is still the problem of associating Boolean, String, and Number with methods
;;; defined on |OclAny|. I'll just write those as on T and do an assert... See
;;; where that leads. 
(defclass ocl-any-obj ()
  ()
  (:metaclass ocl-metaclass))

(declaim (inline ocl-any-p))
(defun ocl-any-p (val) 
  (or (null val) ; nil is the null value. null.oclIsTypeOf(OclVoid) returns :true
      (typep val 'ocl-any-obj) 
      (keywordp val) ; enumerations, but currently 2007-03-13, not UnlimitedNatural '*
      (and (symbolp val) (string= "*" (string val))) ; POD Less than ideal!
      (typep val 'mofi:mm-root-supertype)
      (typep val 'mofi:mm-type-mo)))

(deftype-ocl |OclAny| 
    (or number
	string
	|Boolean|
	(satisfies ocl-any-p)))
(vector-push (find-class '|OclAny|) (mofi:types (mofi:find-model :ocl)))

;;; 11.2.3: The type OclVoid is a type that conforms to all other types. 
;;; It has one single instance called null which corresponds with the
;;; UML NullLiteral value specification. Any property call applied on null results 
;;; in OclInvalid, except for the operation oclIsUndefined(). 
;;; OclVoid is itself an instance of the metatype VoidType.
(declaim (inline ocl-void-p))
(defun ocl-void-p (val)  (null val)) ; 2012-02-13 It appears that I'm OK to use literal 'null' as nil.

(deftype-ocl |OclVoid|
  (satisfies ocl-void-p))
(vector-push (find-class '|OclVoid|) (mofi:types (mofi:find-model :ocl)))

;;; 11.2.4 The type OclInvalid is a type that conforms to all other types. 
;;; (POD Doesn't that mean that it would produce meaningful results for things
;;; like operations on collections?)
;;; It has one single instance called invalid. Any property call applied
;;; on invalid results in OclInvalid, except for the operations oclIsUndefined() 
;;; and oclIsInvalid(). OclInvalid is itself an instance of the metatype InvalidType.
(declaim (inline ocl-invalid-p))
(defun ocl-invalid-p (val)  (eql val :ocl-invalid)) ; nyi

(deftype-ocl |OclInvalid|
    (satisfies ocl-invalid-p))
(vector-push (find-class '|OclInvalid|) (mofi:types (mofi:find-model :ocl)))

(defmethod ocl-= ((self T #|OclAny|#) object2)
  "= method -- True if self is the same object as OBJECT2. Infix operator."
  #-sbcl(ocl-assert (|OclAny| self object2))
  (if (equal self object2) :true :false))

(defmethod ocl-<> ((self T #|OclAny|#) object2)
  "<> method -- True if self is a different object than OBJECT2. Infix operator."
  #-sbcl(ocl-assert (|OclAny| self object2))
  (if (and (numberp self) (numberp object2))
      (if (< self object2) :false :true)
    (if (equal self object2) :false :true))) ; 2009-03-19 was eql

(defmethod ocl-< ((self number #|OclAny|#) object2)
  "< method -- True if self is less than OBJECT2. Infix operator."
  (assert (numberp object2))
  (if (< self object2) :true :false))

;;; 2009-03-19 added TEST SYMBOL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
(defmethod ocl-< ((self symbol) (object2 number))
  "< method -- True if self is less than OBJECT2. Infix operator."
  (if (eql '* self) :false :true))

;;; 2009-03-19 added
(defmethod ocl-< ((self number) (object2 symbol))
  "< method -- True if self is less than OBJECT2. Infix operator."
  (if (eql '* object2) :true :false))

(defmethod ocl-<= ((self T #|OclAny|#) object2)
  "< method -- True if self is less-than or equal OBJECT2. Infix operator."
  (if (or (eq :true (ocl-< self object2)) (eq :true (ocl-= self object2))) :true :false))

(defmethod ocl-> ((self number #|OclAny|#) object2)
  "> method -- True if self is greater than OBJECT2. Infix operator."
  (assert (numberp object2))
  (if (> self object2) :true :false))

;;; 2009-03-19 added
(defmethod ocl-> ((self symbol) (object2 number))
  "> method -- True if self is greater than OBJECT2. Infix operator."
  (if (eql '* self) :true :false))

(defmethod ocl->= ((self T #|OclAny|#) object2)
  "> method -- True if self is greater than or equal to OBJECT2. Infix operator."
  (if (or (eql :true (ocl-> self object2)) (eql :true (ocl-= self object2))) :true :false))

(defmethod ocl-+ ((self number) (object2 number))
  "+ infix operator defined for numbers and strings."
  (+ self object2))

(defmethod ocl-+ ((self string) (object2 string))
  "+ infix operator defined for numbers and strings."
  (strcat self object2))

(defmethod ocl-- ((self number) (object2 number))
  "- infix operator defined for numbers."
  (- self object2))

(defmethod ocl-* ((self number) (object2 number))
  "* infix operator defined for numbers."
  (* self object2))

(defmethod ocl-/ ((self number) (object2 number))
  "/ infix operator defined for numbers."
  (/ self object2))

(defmethod ocl-is-new ((self T #|OclAny|#))
  "|oclIsNew| method -- can only be used in a postcondition. Evaluates to true if the 
   self is created during performing the operation. I.e. it didn't exist at precondition time."
  #-sbcl(ocl-assert (|OclAny| self))
  (error "NYI"))

(defmethod ocl-is-undefined ((self T #|OclAny|#))
  "|oclIsUndefined| method -- evaluates to true if SELF is equal to OclInvalid 
   or equal to null."
  #-sbcl(ocl-assert (|OclAny| self))
  (if (null self) :true ; unset attributes are oclIsUndefined.
    (ocl-if (ocl-or (ocl-is-type-of self '|OclVoid|)
		    (ocl-is-type-of self '|OclInvalid|))
	    :true :false)))

;;; POD an ocl-is-defined would be useful!

(defmethod ocl-is-invalid ((self T #|OclAny|#))
  "|oclIsInvalid| method -- evaluates to true if SELF is equal to OclInvalid.
   N.B. POD that's what the text says. What the ocl under it says is:
   post: result = self.oclIsTypeOf( OclInvalid)"
  #-sbcl(ocl-assert (|OclAny| self))
  (ocl-is-type-of self '|OclInvalid|))

;;; POD This one needs more thought. How do these relate to MM types defined in uml.lisp?
;;; Note that it says that this is defined just to formalize the signatures. So why don't
;;; I just use symbols, and check that the symbols name types (?)
(defclass |OclType| (ocl-any-obj)
  ((type-name :initarg :type-name :reader type-name))
  (:metaclass ocl-metaclass))

;;; 2014-09-05 This is the metaclass of types defined by OCL. I don't believe it belongs on .types.
;(vector-push (find-class '|OclType|) (mofi:types (mofi:find-model :ocl)))

;;; 7.5.3 Because the multiplicity of the role manager is one, self.manager is an object of type Person. 
;;; Such a single object can be used as a Set as well. It then behaves as if it is a Set containing 
;;; the single object. The usage as a set is done through the arrow followed by a property of Set. 
;;; This is shown in the following example:
;;; context Company inv:
;;; self.manager->size() = 1
(defmethod ocl-size ((self T))
  "Return 1 if has a value, 0 otherwise. (Other methods for String and Collection)."
  (if (null self) 0 1))

;;; POD 7 need one for mm-type-mo
(defmethod ocl-as-type ((self T) (typespec -typ))
 "|OclAsType| method -- Evaluates to SELF, where SELF is of the type 
  identified by TYPESPEC. post: (result = self) and result.oclIsTypeOf( typeName )
  POD: Wanna give me some idea how this is to be done!?! 
  I suppose this can only be useful for Collections."
 #-sbcl(ocl-assert (|OclAny| self)) 
 (cond ((ordered-set-typ-p typespec) (ocl-as-ordered-set self))
       ((sequence-typ-p typespec) (ocl-as-sequence self))
       ((set-typ-p typespec) (ocl-as-set self)) 
       ((bag-typ-p typespec) (ocl-as-bag self))
       ;; 2007-02-10, I can't see where ocl has UnlimitedNatural, though uml certainly does.
       ((and (eql (find-class '|UnlimitedNatural|) typespec) 
	     (typep self 'FIXNUM)) self)
       (t (error 'ocl-spec-unclear 
		 :text "The OCL specification does not provide sufficient guidance to enable implementation of this call to oclAsType. Sorry."))))

;;; Added 2010-06-20. Still don't know what this is about, but see pg 203 of OCL-06-05-01
;;; 2011-04-20: Now I've added real action: change-class on a copy!
;;; 2012-11-01: OCL 2.3.1 Clause 7.5.6 Pretty clear now that self must be a subtype of typespec, otherwise return ocl:invalid.
;;; 2014-03-26: Problem: this is introducing new instances when used in a slot derivation. 
;;;     Signature: ownedType.1() : Type;
;;;     Description: Derivation for Package::/ownedType
;;;     Expression: result = (packagedElement->select(oclIsKindOf(Type))->collect(oclAsType(Type))->asSet())
;;; 
;;;     ocl-12-01-02 Clause 7.5.6: "This operation results in the same object..."
;;;     "...Casting provides visibility, at parse time, of features not defined in the context of an expression’s static type. 
;;;     It does not coerce objects to instances of another type, nor can it provide access to hidden or overridden features of a type."
;;;     [For the record, I'm not "coercing objects to instances of another type," I'm not touching the original objects, but I'm using
;;;     an trick to get what I need.]
;;; I'm going to leave the implementation as is, and perform a correction on derived slots.
(defmethod ocl-as-type ((self T) (typespec mofi:mm-type-mo))
  (cond ((eql (class-of self) typespec) self)
	((and mofi:*inside-derivation-p* (typep self typespec)) ; See 2014-03-26 notes. Not a perfect solution!
	 self)
	((typep self typespec) ; Clause 7.5.6 must be a subtype
	 (let ((save-id (- (mofi:%debug-id self))) ; for debug tracking
	       (obj (change-class (copy-object self) typespec)))
	   (setf (mofi:%debug-id obj) save-id)
	   obj))
	(t :ocl-invalid)))

(defmethod copy-object ((obj mofi:mm-root-supertype))
  "Make a shallow copy of OBJ."
  (let* ((mofi::*suppress-install* t)
	 (class (class-of obj))
	 (new-obj (make-instance class)))
    (declare (special mofi::*suppress-install*))
    (loop for slot-name in (mapcar #'slot-definition-name (mapped-slots class))
	do (setf (slot-value new-obj slot-name) (slot-value obj slot-name)))
    new-obj))


;;; 2012-03-16 : 06-05-01 comment is correct. oclIsTypeOf True only if
;;; SELF is directly typespec. oclIsKindOf allows SELF to be a subtype of TYPESPEC
(defmethod ocl-is-type-of ((self T) (typespec symbol))
 "Method oclIsTypeOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF is of the type identified by TYPESPEC.
  In ocl-06-05-01 returns FALSE if SELF is a subtype of TYPESPEC."
 #-sbcl(ocl-assert (|OclAny| self))
 (if (or (and (null self) 
	      (eql (find-class '|OclVoid|) typespec)) 
	 (and (eql self :ocl-invalid)
	      (eql (find-class '|OclInvalid|) typespec))
	 (eql (class-name (class-of self)) typespec))
     :true
   :false))

(defmethod ocl-is-type-of ((self T) (typespec -typ))
 "Method oclIsTypeOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF is of the type identified by TYPESPEC.
  In ocl-06-05-01 returns FALSE if SELF is a subtype of TYPESPEC."
 #-sbcl(ocl-assert (|OclAny| self))
 (typecase typespec
   (object-typ (if (eql (class-of self) (find-class (class-name typespec))) :true :false))
   (otherwise (if (value/type-compatible-p self typespec) :true :false))))

#+nil ; pod 7 no longer used
(defmethod ocl-is-kind-of ((self T) (typespec symbol))
 "Method oclIsKindOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF conforms to the type identified by TYPESPEC.
  In ocl-06-05-01 returns TRUE if SELF is a subtype of TYPESPEC."
 (ocl-assert (|OclAny| self))
 (if (typep self typespec) :true :false))

;;; This one was written when the comment above the previous (about it possibly 
;;; being not-used) was written. 
;;; pod7 I don't think I want this anymore.
#+nil
(defmethod ocl-is-kind-of ((self T) (typespec standard-class))
 "Method oclIsKindOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF conforms to the type identified by TYPESPEC.
  In ocl-06-05-01 returns TRUE if SELF is a subtype of TYPESPEC."
 (ocl-assert (|OclAny| self))
  (if (typep self typespec) :true :false))

;;; POD 7 ...use this instead.
(defmethod ocl-is-kind-of ((self mofi:mm-root-supertype) (typespec mofi:mm-type-mo))
 "Method oclIsKindOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF conforms to the type identified by TYPESPEC.
  In ocl-06-05-01 returns TRUE if SELF is a subtype of TYPESPEC."
 #-sbcl(ocl-assert (|OclAny| self))
 (if (member typespec 
	     (closer-mop:class-precedence-list (class-of self)))
     :true :false))


;;; 2013-12-29: This became necessary with better href-lookup???
(defmethod ocl-is-kind-of ((self mofi:mm-type-mo) (typespec mofi:mm-type-mo))
  :false)

;;; POD Needs work!
(defmethod ocl-is-kind-of ((self T) (typespec -typ))
 "Method oclIsKindOf(typespec : OclType) : Boolean
  Evaluates to true if the SELF conforms to the type identified by TYPESPEC.
  In ocl-06-05-01 returns TRUE if SELF is a subtype of TYPESPEC."
 #-sbcl(ocl-assert (|OclAny| self))
 (typecase typespec
   (object-typ (if (typep self (class-name typespec)) :true :false))
   (otherwise (if (value/type-compatible-p self typespec) :true :false))))

;;; POD I'm making this one up, because it is used in L3! (and needs work!).
;;; POD not in the OCL-06-05-01 spec either!
(defmethod ocl-type ((self T))
  "oclType implementation. The method oclType is apocryphal!"
  (class-of self))

(defmethod ocl-is-in-state ((self T))
 #-sbcl(ocl-assert (|OclAny| self))
 (error "NYI"))

;;; Coded 2009-01-25 ... quickly!
(defmethod ocl-all-instances ((self mofi:mm-type-mo))
  (with-vo (mut)
    (if mut
	(make-instance '|Set|
		       :typ-d (make-instance 'collection-typ 
					     :l-bound 0 :u-bound -1
					     :unique-p t 
					     :base-type self)
		       :value (loop for m across (members mut)
				 when (typep m self) collect m))
       (error "MUT not bound in ocl-all-instances."))))

;;; Actually a template type, see 11.2.2, NYI
(defclass |OclMessage| (ocl-any-obj)
  ()
  (:metaclass ocl-metaclass))

(vector-push (find-class '|OclMessage|) (mofi:types (mofi:find-model :ocl)))

(defmethod ocl-has-returned ((self |OclMessage|))
 (error "NYI"))

(defmethod ocl-result ((self |OclMessage|))
 (error "NYI"))

(defmethod ocl-is-signal-sent ((self |OclMessage|))
 (error "NYI"))

(defmethod ocl-is-operation-call ((self |OclMessage|))
 (error "NYI"))

;;;============= 11.5.2 Integer =============================
(defmethod ocl-div ((self number) (i number))
  "The number of times that i fits completely within self.
      pre : i <> 0
      post: if self / i >= 0 
             then result = (self / i).floor()
             else result = -((-self/i).floor())
            endif"
  (when (zerop i) (error "i must be non-zero."))
  (if (>= self 0)
      (floor (/ self i))
      (- (floor (/ (- self) i)))))

;;;============= 11.5.3 String =============================
(defmethod ocl-size ((self string))
  (length self))

(declaim (inline ocl-concat ocl-substring))
(defun ocl-concat (self str2)
  (ocl-assert (string self str2))
  (strcat self str2))

(defun ocl-substring (self lower upper)
  (ocl-assert (string self)
	      (integer lower upper))
  (subseq self (1- lower) upper))

(defmethod ocl-to-integer ((self string))
  (parse-integer self))

(defmethod ocl-to-real ((self string))
  (read-from-string self))

;;;========== 11.6 Collection-related ====================
(defclass |Collection| (ocl-any-obj) ; hard to say given 11.2.1!
  ((typ-d :initarg :typ-d :reader typ-d :initform nil) ; type-descriptor
   (value :initarg :value :accessor value :initform nil)
   (mofi::|debug-id| :accessor mofi::%debug-id :initform nil))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|Collection|) (mofi:types (mofi:find-model :ocl)))


(declaim (inline collection-p))
(defun collection-p (x)
  (typep x '|Collection|))

#|
;;; pod7 FIX THIS (and add for Set etc?)
(deftype-ocl |Collection| (satisfies collection-p))
|#

(defmethod initialize-instance :after ((obj |Collection|) &key)
  (setf (mofi::%debug-id obj) (incf mofi:*mm-debug-id*)))

(defmethod print-object ((obj |Collection|) stream)
  (format stream "<~A of ~A ~A, id=~A>"
	  (class-name (class-of obj))
	  (length (value obj))
	  (if-bind (typ-d (typ-d obj))
		   (base-type typ-d)
		   "an unspecified type")
	  (mofi::%debug-id obj)))

;;; Added 2012-03-14
(defmethod copy-object ((obj |Collection|))
  "Make a shallow copy of OBJ."
  (make-instance (class-of obj)
		 :typ-d (typ-d obj)
		 :value (mapcar #'copy-object (value obj))))

;;; Added 2012-03-14, guessing it is a literal
(defmethod copy-object ((obj t)) obj)

;;; POD NYI
;;; For reuse of some method implementations, we define these generalized types:
;(defclass ordered-collection (|Collection|) ())
;(defclass bag-or-set (|Collection|) ())

;;; I have no evidence that lower and upper etc will ever by used.
(defclass |Set| (|Collection|)
  ((typ-d :initform (make-instance 'collection-typ :unique-p t)))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|Set|) (mofi:types (mofi:find-model :ocl)))

(defclass |OrderedSet| (|Set|) ; The index of first elem is 1, BTW.
  ((typ-d :initform (make-instance 'collection-typ :unique-p t :ordered-p t)))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|OrderedSet|) (mofi:types (mofi:find-model :ocl)))

(defclass |Sequence| (|Collection|) 
  ((typ-d :initform (make-instance 'collection-typ :ordered-p t)))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|Sequence|) (mofi:types (mofi:find-model :ocl)))

(defclass |Bag| (|Collection|)
  ((typ-d :initform (make-instance 'collection-typ)))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|Bag|) (mofi:types (mofi:find-model :ocl)))

(defmethod ocl-size ((self |Collection|))
  "size: the number of elements in the Collection SELF"
  (length (value self)))

(defmethod ocl-includes ((self |Collection|) obj)
  "includes : true if OBJ is an element of SELF, false otherwise."
  (if (member obj (value self) :test #'equal) :true :false))

(defmethod ocl-excludes ((self |Collection|) obj)
  "excludes : true if OBJ is not an element of SELF, false if it is."
  (ocl-not (ocl-includes self obj)))

(defmethod ocl-count ((self |Collection|) obj)
  "count : the number of times OBJ occurs in SELF."
  (count obj (value self) :test #'equal))

(defmethod ocl-includes-all ((self |Collection|) (c2 |Collection|))
  "includesAll : does SELF include the collection C2?"
  (loop for o in (value c2) with self-val = (value self)
	unless (member o self-val :test #'equal) return :false
	finally (return :true)))

(defmethod ocl-excludes-all ((self |Collection|) (c2 |Collection|))
  "excludesAll : does SELF contain none of the elements of C2?"
  (loop for o in (value c2) with self-val = (value self)
	when (member o self-val :test #'equal) return :false
	finally (return :true)))

(defmethod ocl-is-empty ((self |Collection|))
  "isEmpty : is SELF the empty collection?"
  (if (null (value self)) :true :false))

(defmethod ocl-is-empty ((self t))
  "isEmpty : is SELF the empty collection?"
  (if (null self) :true :false))

(defmethod ocl-not-empty ((self |Collection|))
  "notEmpty : is SELF not the empty collection?"
  (if (null (value self)) :false :true))

(defmethod ocl-not-empty ((self t))
  "notEmpty : is SELF not the empty collection?"
  (if (null self) :false :true))

(defmethod ocl-sum ((self |Collection|))
  "sum: the addition of all the elements of SELF. 
   Elements must be of a type supporting the + operation."
  (unless (or (typep (base-type (typ-d self)) 'number-typ)
	      (every #'numberp (value self))) ; POD really should be AND but...
    (error 'ocl-invalid-operation-for-value 
	   :operation '|Collection.sum|
	   :value (value self)))
  (loop for v in (value self) sum v))

;;; Tuple doesn't have to be exported, UML doesn't have one. 
(defclass |Tuple| (ocl-any-obj) ; hard to say given 11.2.1!
  ((typ-d :initarg :typ-d :reader typ-d :initform nil) ; type-descriptor
   (value :initarg :value :reader value :initform nil))
  (:metaclass ocl-metaclass))
(vector-push (find-class '|Tuple|) (mofi:types (mofi:find-model :ocl)))

;;; POD Might want more than a list for tuple, but ya never know...
(defmethod ocl-product ((self |Collection|) (c2 |Collection|))
 "product: the Cartesian product of SELF and C2"
  (make-instance '|Set|
		 :typ-d (make-instance 'tuple-typ
				       :role-typs (list (typ-d self) (typ-d c2))
				       :role-names :nil) ; pod what can you do?
		 :value
		 (loop for v1 in (value self) with vals2 = (value c2) 
		       collect (loop for v2 in vals2 collect 
				     (make-instance '|Tuple| :value (list v1 v2))))))

;;;=================== 11.7.2 Set =====================================
(defmethod ocl-union ((self |Set|) (s |Set|))
  "union: the union of SELF and s"
  (make-instance '|Set|
      :typ-d (msg (typ-d self) (typ-d s))
      :value (remove-if #'null (remove-duplicates (append (value self) (value s)) :test #'equal))))

(defmethod ocl-union ((self |Set|) (s |Bag|))
  "union: the union of SELF and S"
  (make-instance '|Bag|
      :typ-d (msg (typ-d self) (typ-d s))
      :value (append (value self) (value s))))

(defmethod ocl-= ((self |Set|) (s |Set|))
  "=: evaluates to true if SELF and S contain the same elements."
  (ocl-and
   (if (= (length (value self)) (length (value s))) :true :false)
   (loop for o in (value s) with self-val = (value self)
	 unless (member o self-val :test #'equal) return :false
	 finally (return :true))))

(defmethod ocl-intersection ((self |Set|) (s |Set|))
  "intersection: the intersection of SELF and s
   (i.e. the set of all elements that are in both SELF and s)"
  (make-instance '|Set|
		 :typ-d (typ-d self) ; POD not sure of this.
		 :value
		 (loop for v in (value self) with s-val = (value s)
		       when (member v s-val :test #'equal) collect v)))

(defmethod ocl-intersection ((self |Set|) (b |Bag|))
  "intersection: the intersection of SELF and s
   (i.e. the set of all elements that are in both SELF and s)"
  (ocl-intersection self (ocl-as-set b)))

(defmethod ocl-- ((self |Set|) (s |Set|))
  "-: the elements of SELF that are not in S."
  (make-instance '|Set|
		 :typ-d (typ-d self) ; POD not sure of this.
		 :value (loop for v in (value self) with s-val = (value s)
			      unless (member v s-val :test #'equal) collect v)))

(defmethod ocl-including ((self |Set|) obj)
  "including: the set containing all elements of SELF plus OBJ."
  (unless (value/type-compatible-p obj (base-type (typ-d self)))
    (error 'ocl-type-not-compatible :value obj :type (typ-d self)))
  (if (member obj (value self) :test #'equal)
      self
    (make-instance '|Set|
		   :typ-d (typ-d self)
		   :value (cons obj (value self)))))

(defmethod ocl-excluding ((self |Set|) obj)
  "excluding: the set containing all elements of SELF excluding OBJ."
  (unless (value/type-compatible-p obj (typ-d self))
    (error 'ocl-type-not-compatible :value obj :type (typ-d self)))
  (make-instance '|Set|
		 :typ-d (typ-d self) 
		 :value (remove obj (value self))))

(defmethod ocl-symmetric-difference ((self |Set|) (s |Set|))
  "symmetricDifference : the sets containing all the elements that are in SELF or S, but not in both."
  (make-instance '|Set|
		 :typ-d (typ-d self) ; POD not sure of this.
		 :value (append
			 (loop for v in (value self) with s-val = (value s)
			       unless (member v s-val :test #'equal) collect v)
			 (loop for v in (value s) with s-val = (value self)
			       unless (member v s-val :test #'equal) collect v))))

(defmethod ocl-count ((self |Set|) obj)
  "count: the number of occurrences of OBJ in SELF."
  (unless (value/type-compatible-p obj (typ-d self))
    (error 'ocl-type-not-compatible :value obj :type (typ-d self)))
  (if (member obj (value self) :test #'equal) 1 0))

#| It looks like they only want one step of flatten...
(defmethod ocl-flatten ((self |Set|))
  "Not completed, because apparently not what they wanted."
  (labels ((flatten (input &optional accumulator))
	   (cond ((null input) accumulator)
		 ((atom input) (cons input accumulator))
		 (t (flatten (if (typep (first input) '|Collection|) 
				 (value (first input))
			       (first input))
			     (flatten (rest input) accumulator)))))
    (flatten self)))
|#

;;; POD need -typ objects, as we have in expresso.
(defmethod ocl-flatten ((self |Set|))
  "flatten : If the element type is not a collection type this result in the same self. 
   If the element type is a collection type, the result is the set containing 
   all the elements of all the elements of self."
  (make-instance '|Set|
		 :typ-d (if (typep (base-type (typ-d self)) 'collection-typ)
			    (base-type (typ-d self))
			  (typ-d self))
		 :value (loop for v in (value self)
			      if (collection-p v) append (value v)
			      else collect v)))

;;; POD not sure if should deep copy, or even if I should just return the object.
(defmethod ocl-as-set ((self |Set|))
  "asSet : A Set identical to self. This operation exists for convenience reasons."
  self)

(defmethod ocl-as-ordered-set ((self |Set|))
  "asOrderedSet : An OrderedSet that contains all the elements from self, in undefined order."
  (make-instance '|OrderedSet| 
		 :typ-d (typ-d self)
		 :value (copy-seq (value self))))

(defmethod ocl-as-sequence ((self |Set|))
  "asSequence : An sequence that contains all the elements from self, in undefined order."
  (make-instance '|Sequence| 
		 :typ-d (typ-d self)
		 :value (copy-seq (value self))))

(defmethod ocl-as-bag ((self |Set|))
  "asBag : An sequence that contains all the elements from self, in undefined order."
  (make-instance '|Bag| 
		 :typ-d (typ-d self)
		 :value (copy-seq (value self))))

;;;=================== 11.7.3 OrderedSet ===============================
;;; OCL 2.3.1 append takes any object. 
(defmethod ocl-append ((self |OrderedSet|) obj)
  "append : The set of elements, consisting of all elements of self, followed by obj."
  (make-instance '|OrderedSet|
		 :typ-d (if (collection-p obj) (msg (typ-d self) (typ-d obj)) (typ-d self))
		 :value (append 
			 (value self) 
			 (if (collection-p obj) (value obj) (list obj)))))

;;; OCL 2.3.1 prepend takes any object. 
(defmethod ocl-prepend ((self |OrderedSet|) obj)
  "prepend : The set of elements, consisting of all elements of self, followed by object."
  (make-instance '|OrderedSet|
		 :typ-d (if (collection-p obj) (msg (typ-d self) (typ-d obj)) (typ-d self))
		 :value (append
			 (if (collection-p obj) (value obj) (list obj))
			 (value self))))

(defmethod ocl-insert-at ((self |OrderedSet|) (index integer) object)
  "insertAt : the set consisting of SELF with OBJECT inserted at position INDEX
     post: result->size = self->size() + 1
     post: result->at(index) = object
     post: Sequence{1..(index - 1)}->forAll(i : Integer | self->at(i) = result->at(i))
     post: Sequence{(index + 1)..self->size()}->forAll(i : Integer | self->at(i) = result->at(i + 1))"
  (unless (value/type-compatible-p object (typ-d self))
    (error 'ocl-type-not-compatible :value object :type (typ-d self)))
  (with-slots (value) self
   (when (or (> index (length value)) (<= index 0))
    (error 'ocl-index-out-of-range :index index :ordered-value value))
   (make-instance '|OrderedSet|
		  :typ-d (typ-d self)
		  :value (append (subseq value 0 (1- index))
				 (cons object (subseq value (1- index)))))))

(defmethod ocl-sub-ordered-set ((self |OrderedSet|) (lower integer) (upper integer))
  "subOrderedSet: the sub-set of SELF starting at number LOWER, up to and including element number UPPER"
  (with-slots (value) self
   (when (< lower 0) (error 'ocl-index-out-of-range :index lower :ordered-value value))
   (when (> upper (length value)) (error 'ocl-index-out-of-range :index upper :ordered-value value))
   (make-instance '|OrderedSet|
		  :typ-d (typ-d self)
		  :value (copy-seq (subseq value (1- lower) upper)))))

(defmethod ocl-at ((self |OrderedSet|) (i integer))
  "at: the i-th element of self"
  (with-slots (value) self
    (unless (and (>= i 1) (>= i (length value)))
      (error 'ocl-index-out-of-range :index i :ordered-value value))
    (nth (1- i) value)))

(defmethod ocl-index-of ((self |OrderedSet|) obj)
  "indexOf: the index of object OBJ in the OrderedSet SELF"
  (with-slots (value) self
    (if-bind (pos (position obj value :test #'equal))
     (1+ pos)
     :ocl-invalid)))
;     (make-instance '|OclInvalid|)

(defmethod ocl-first ((self |OrderedSet|))
  "first: the first element in SELF"
  (or (car (value self)) :ocl-invalid)) ;(make-instance '|OclInvalid|))) ; POD my idea.

(defmethod ocl-last ((self |OrderedSet|))
  "last: the last element in SELF"
  (with-slots (value) self
    (if value
	(last1 value)
	:ocl-invalid)))
;      (make-instance '|OclInvalid|)))) ; POD my idea.

;;;=================== 11.7.4 Bag ===============================
(defmethod ocl-= ((self |Bag|) (b |Bag|))
  "=: true if SELF and B contain the same elements, the same number of times."
  (loop for v in (remove-duplicates (append (value self) (value b)) :test #'equal)
	with self-val = (value self) with b-val = (value b)
	unless (= (count v self-val :test #'equal)
		  (count v b-val :test #'equal)) return :false
	finally (return :true)))

;;; POD same as method on Set!
(defmethod ocl-union ((self |Bag|) (s |Bag|))
  "union: the union of SELF and S"
  (make-instance '|Bag|
      :typ-d (msg (typ-d self) (typ-d s))
      :value (append (value self) (value s))))

(defmethod ocl-union ((self |Bag|) (s |Set|))
  "union: the union of SELF and S"
  (make-instance '|Bag|
      :typ-d (msg (typ-d self) (typ-d s))
      :value (append (value self) (value s))))

(defmethod ocl-intersection ((self |Bag|) (b |Bag|))
  "intersection: the intersection of self and bag
    post: result->forAll(elem | result->count(elem) = self->count(elem).min(bag->count(elem)))
    post: self->forAll(elem | result->count(elem) = self->count(elem).min(bag->count(elem)))
    post: bag->forAll(elem | result->count(elem) = self->count(elem).min(bag->count(elem)))"
  (make-instance '|Bag|
		 :typ-d (msg (typ-d self) (typ-d b))
		 :value (loop for v in (intersection (value self) (value b) :test #'equal) 
			      with self-val = (value self) with b-val = (value b) 
			      append
			      (loop for i from 1 to (min (count v self-val :test #'equal) 
							 (count v b-val :test #'equal))
				    collect v))))

(defmethod ocl-intersection ((self |Bag|) (s |Set|))
  "intersection: the intersection of self and set
    post: result->forAll(elem|result->count(elem) = self->count(elem).min(set->count(elem)))
    post: self ->forAll(elem|result->count(elem) = self->count(elem).min(set->count(elem)))
    post: set ->forAll(elem|result->count(elem) = self->count(elem).min(set->count(elem)))"
  (make-instance '|Set|
		 :typ-d (typ-d self)
		 :value (loop for v in (value s) with self-val = (value self)
			      when (member v self-val :test #'equal) collect v)))

(defmethod ocl-including ((self |Bag|) val)
  "including: the bag containing all elements of SELF plus VAL
    post: result->forAll(elem | if elem = object 
                                           then result->count(elem) = self->count(elem) + 1
                                           else result->count(elem) = self->count(elem) endif)
    post: self->forAll(elem | if elem = object 
                                         then result->count(elem) = self->count(elem) + 1
                                         else result->count(elem) = self->count(elem) endif)"
  (unless (value/type-compatible-p val (typ-d self))
    (error 'ocl-type-not-compatible :value val :type (typ-d self)))
  (make-instance '|Bag|
		 :typ-d (typ-d self)
		 :value (cons val (value self))))

(defmethod ocl-excluding ((self |Bag|) val)
  "excluding: the bag containing all elements of self apart from all occurrences of object
     post: result->forAll(elem | if elem = object 
                                     then result->count(elem) = 0
                                     else result->count(elem) = self->count(elem) endif)
     post: self->forAll(elem | if elem = object 
                                     then result->count(elem) = 0
                                     else result->count(elem) = self->count(elem) endif)"
  (unless (value/type-compatible-p val (typ-d self))
    (error 'ocl-type-not-compatible :value val :type (typ-d self)))
  (make-instance '|Bag|
		 :typ-d (typ-d self)
		 :value (remove val (value self) :test #'equal)))

(defmethod ocl-count ((self |Bag|) val)
  "count: the number of occurrences of OBJ in SELF"
  (unless (value/type-compatible-p val (typ-d self))
    (error 'ocl-type-not-compatible :value val :type (typ-d self)))
  (count val (value self) :test #'equal))

(defmethod ocl-flatten ((self |Bag|))
  "flatten: If the element type is not a collection type this result in the same self. 
   If the element type is a collection type, the result is the bag containing 
   all the elements of all the elements of self."
  (make-instance '|Bag|
		 :typ-d (if (typep (base-type (typ-d self)) 'collection-typ)
			    (base-type (typ-d self))
			  (typ-d self))
		 :value (loop for v in (value self)
			      if (collection-p v) append (value v)
			      else collect v)))

(defmethod ocl-as-bag ((self |Bag|))
  "asBag: a Bag identical to SELF. This operation exists for convenience reasons."
  self)

(defmethod ocl-as-sequence ((self |Bag|))
  "asSequence: an sequence that contains all the elements from SELF, in undefined order"
  (make-instance '|Sequence| 
		 :typ-d (typ-d self)
		 :value (copy-seq (value self))))

(defmethod ocl-as-set ((self |Bag|))
  "asSet: the Set containing all the elements from SELF, with duplicates removed."
  (make-instance '|Set| ; POD 2016-10-25 I make a type typ-d. Probably should do this elsewhere!
		 :typ-d (make-instance 'collection-typ :unique-p t :base-type (base-type (typ-d self)))
		 :value (remove-duplicates (value self) :test #'equal)))

(defmethod ocl-as-ordered-set ((self |Bag|))
  "asOrderedSet: the OrderedSet containing all the elements from SELF, with duplicates removed."
  (make-instance '|OrderedSet|
		 :typ-d (typ-d self)
		 :value (remove-duplicates (value self) :test #'equal)))

;;;=================== 11.7.4 Sequence ===============================
(defmethod ocl-count ((self |Sequence|) object)
  "count: the number of occurrences of OBJ in SELF"
  (unless (value/type-compatible-p object (typ-d self))
    (error 'ocl-type-not-compatible :value object :type (typ-d self)))
  (count object (value self) :test #'equal))

(defmethod ocl-= ((self |Sequence|) (s |Sequence|))
  "=: true if SELF contains the same elements as S in the same order"
  (if 
      (and (= (length (value self)) (length (value s)))
	   (loop for v in (value self) 
		 for s-v in (value s)
		 unless (equal v s-v) return nil
		 finally (return t)))
      :true
    :false))

(defmethod  ocl-union ((self |Sequence|) (s |Sequence|))
  "union: the sequence consisting of all elements in SELF, followed by all elements in S"
  (make-instance '|Sequence|
		 :typ-d (msg (typ-d self) (typ-d s))
		 :value (append (value self) (value s))))

(defmethod  ocl-flatten ((self |Sequence|))
  "flatten: if the element type is not a collection type this result in the same SELF. 
   If the element type is a collection type, the result is the sequence containing 
   all the elements of all the elements of self. The order of the elements is partial."
  (make-instance '|Sequence|
		 :typ-d (if (typep (base-type (typ-d self)) 'collection-typ)
			    (base-type (typ-d self))
			  (typ-d self))
		 :value (loop for v in (value self)
			      if (collection-p v) append (value v)
			      else collect v)))

;;; POD Note that second arg of OrderedSet.append() is an Collection!
(defmethod ocl-append ((self |Sequence|) obj)
  "append: the sequence of elements, consisting of all elements of SELF, followed by OBJECT"
  (unless (value/type-compatible-p obj (typ-d self))
    (error 'ocl-type-not-compatible :value obj :type (typ-d self)))
  (make-instance '|Sequence|
		 :typ-d (typ-d self)
		 :value (append 
			 (value self) 
			 (if (collection-p obj) (value obj) (list obj)))))

;;; OCL 2.3.1 prepend takes any object. This one was OK, except that
;;; append should happen on ocl:value if a collection
(defmethod ocl-prepend ((self |Sequence|) obj)
  "prepend: the sequence consisting of OBJECT, followed by all elements in SELF."
  (unless (value/type-compatible-p obj (typ-d self))
    (error 'ocl-type-not-compatible :value obj :type (typ-d self)))
  (make-instance '|Sequence|
		 :typ-d (typ-d self)
		 :value (append 
			 (if (collection-p obj) (value obj) (list obj))
			 (value self))))

(defmethod ocl-insert-at ((self |Sequence|) (index integer) object)
  "insertAt: the sequence consisting of SELF with OBJECT inserted at position INDEX
     post: result->size = self->size() + 1
     post: result->at(index) = object
     post: Sequence{1..(index - 1)}->forAll(i : Integer | self->at(i) = result->at(i))
     post: Sequence{(index + 1)..self->size()}->forAll(i : Integer | self->at(i) = result->at(i + 1))"
  (unless (value/type-compatible-p object (typ-d self))
    (error 'ocl-type-not-compatible :value object :type (typ-d self)))
  (with-slots (value) self
   (when (or (> index (length value)) (<= index 0))
    (error 'ocl-index-out-of-range :index index :ordered-value value))
  (make-instance '|Sequence|
		 :typ-d (typ-d self)
		 :value (append (subseq value 0 (1- index))
				 (cons object (subseq value (1- index)))))))

(defmethod ocl-subsequence ((self |Sequence|) (lower integer) (upper integer))
  "sequence: the sub-sequence of SELF starting at number LOWER, up to and including element number UPPER"
  (with-slots (value) self
   (when (< lower 0) (error 'ocl-index-out-of-range :index lower :ordered-value value))
   (when (> upper (length value)) (error 'ocl-index-out-of-range :index upper :ordered-value value))
   (make-instance '|Sequence|
		  :typ-d (typ-d self)
		  :value (copy-seq (subseq value (1- lower) upper)))))

(defmethod ocl-subseq-collection ((self |Collection|) (lower integer) (upper integer))
  "I wrote this one for convenience." ; POD Tell OCL guys.
  (etypecase self
    (|Sequence| (ocl-subsequence self lower upper))
    (|OrderedSet| (ocl-sub-ordered-set self lower upper))))

(defmethod ocl-at ((self |Sequence|) (i integer))
  "The Ith element of sequence."
  (with-slots (value) self
    (unless (and (>= i 1) (>= i (length value)))
       (error 'ocl-index-out-of-range :index i :ordered-value value))
     (nth (1- i) value)))

(defmethod ocl-index-of ((self |Sequence|) obj)
  "indexOf: the index of object OBJ in the sequence SELF"
  (with-slots (value) self
    (if-bind (pos (position obj value :test #'equal))
     (1+ pos)
     :ocl-invalid))) ;(make-instance '|OclInvalid|)))) ; POD my idea.

(defmethod ocl-first ((self |Sequence|))
  "first: the first element in SELF"
  (or (car (value self)) :ocl-invalid)) ;(make-instance '|OclInvalid|))) ; POD my idea.

(defmethod ocl-last ((self |Sequence|))
  "last: the last element in SELF"
  (with-slots (value) self
    (if value
	(last1 value)
	:ocl-invalid))) ;(make-instance '|OclInvalid|)))) ; POD my idea.

(defmethod ocl-as-bag ((self |Sequence|))
  "asBag: the Sequence SELF as a bag"
  (make-instance '|Bag| 
		 :typ-d (typ-d self)
		 :value (copy-seq (value self))))

(defmethod ocl-as-sequence ((self |Sequence|))
  "asSequence: the Sequence identical to the object itself. This operation exists for convenience reasons.
     post: result = self"
  self)

(defmethod ocl-as-set ((self |Sequence|))
  "The Set containing all the elements from self, with duplicated removed."
  (make-instance '|Set| 
		 :typ-d (typ-d self)
		 :value (remove-duplicates (value self) :test #'equal)))

;;; 2012-02-20: Treat -> as collection. See uml25 Classifier.parents()
;;; POD But should I do this on -> instead of all the methods ???
(defmethod ocl-as-set ((self T))
  "The Set containing all the elements from self, with duplicated removed."
  (make-instance '|Set| 
		 :typ-d (make-instance 'collection-typ :unique-p t)
		 :value (list self)))

(defmethod ocl-as-ordered-set ((self T))
  "The Set containing all the elements from self, with duplicated removed."
  (make-instance '|Set| 
		 :typ-d (make-instance 'collection-typ :unique-p t :ordered-p t)
		 :value (list self)))

;;; Ditto
(defmethod ocl-as-sequence ((self T))
  "The Set containing all the elements from self, with duplicated removed."
  (make-instance '|Sequence| 
		 :typ-d (make-instance 'collection-typ :ordered-p t)
		 :value (list self)))
;;; Ditto
(defmethod ocl-as-bag ((self T))
  "The Set containing all the elements from self, with duplicated removed."
  (make-instance '|Bag| 
		 :typ-d (make-instance 'collection-typ)
		 :value (list self)))





(defmethod ocl-as-ordered-set ((self |Sequence|))
 "asOrderedSet: an OrderedSet that contains all the elements from SELF, 
  in the same order, with duplicates removed.
     post: result->forAll(elem | self ->includes(elem))
     post: self ->forAll(elem | result->includes(elem))
     post: self ->forAll(elem | result->count(elem) = 1)
     post: self ->forAll(elem1, elem2 | self->indexOf(elem1) < self->indexOf(elem2)
           implies result->indexOf(elem1) < result->indexOf(elem2))"
 (make-instance '|OrderedSet|
		:typ-d (typ-d self)
		:value (loop for v in (value self) 
			     unless (member v result :test #'equal)
			     collect v into result
			     finally (return result))))

;;;=================== 11.8 Iterator Expression ===============================

;;; Note, because of use of Boolean (:true :false) I can't use the corresponding
;;; lisp functions directly here. I think I'm OK with closures. (don't need macros?)

(defun ocl-exists (collection predicate)
  "exists: results in true if PREDICATE evaluates to true for at least one element 
   in the source COLLECTION."
  (loop for v in (value collection)
	when (eql :true (funcall predicate v)) return :true
	finally (return :false)))

(defun ocl-for-all (collection predicate)
  "forAll: results in true if the PREDICATE evaluates to true for each element in 
   the source collection; otherwise, result is false."
  (if (eql :ocl-invalid collection)
      :ocl-invalid
      (loop for v in (value collection)
	 when (eql :false (funcall predicate v)) return :false
	 finally (return :true))))

(defun ocl-is-unique (collection predicate)
  "isUnique: results in true if body evaluates to a different value for each 
   element in the source collection; otherwise, result is false."
  (let ((result (mapcar predicate (value collection))))
    (if (= (length result) (length (remove-duplicates result))) ; POD cheezy implementation.
	:true 
      :false)))

; POD investigate this! The predicate doesn't return true with ->any() (is that legal? see opposite.1)
(defun ocl-any (collection predicate)
  "any: returns any element in the source collection for which body evaluates to true. 
   If there is more than one element for which body is true, one of them is returned. 
   There must be at least one element fulfilling body, otherwise the result of 
   this IteratorExp is null."
  (or 
   (loop for v in (value collection)
	 unless (eql :false (funcall predicate v)) return v)
   nil)) ; (make-instance '|OclVoid|)))

(defun ocl-one (collection predicate)
  "one: results in true if there is exactly one element in the source collection for which 
   body is true."
  (let ((result (remove :false (mapcar predicate (value collection)))))
    (if (and (eql :true (car result))
	     (null (cdr result)))
	:true
      :false)))

;;; POD I'm beginning to think that they want a real flatten.
(defun ocl-collect (collection predicate)
  "collect: the collection of elements which results from applying body to every member 
   of the source set. The result is flattened. Notice that this is based on collectNested, 
   which can be of different type depending on the type of source. collectNested is defined
   individually for each subclass of CollectionType."
  (ocl-flatten (ocl-collect-nested collection predicate)))

;;; OCL 2.3.1
;;; parents->closure(children)
;;; computes the set of parents.children, parents.children.children, etc.
;;;
;;; aClassifier.generalization()->closure(general.generalization).general()->including(aClassifier)
;;; computes the set comprising aClassifier and all its generalizations. The closure recurses over 
;;; the Generalizations to compute the transitive set of all Generalizations. The generalized classifier 
;;; is collected from each of these before including the originating aClassifier in the result.
;;;
;;; Perhaps that should be:
;;; aClassifier.generalization->closure(general.generalization).general->including(aClassifier)
;;;
;;; As with all other iterators, self remains unchanged throughout the recursion, and 
;;; an implicit source attempts to resolve features against iterators.
(defun ocl-closure (source predicate)
  (flet ((pred-child-list (x) 
	   (let ((children (funcall predicate x)))
	     (if (collection-p children) (value children) (list children)))))
    (setf source (if (collection-p source) (value source) (list source)))
    (let ((result
	   (mapappend
	    #'(lambda (x)
		(let (sub-result)
		  (depth-first-search x #'fail #'pred-child-list :do #'(lambda (n) (push-last n sub-result)))
		  sub-result))
	    source)))
      (make-instance '|Set| 
		     :typ-d (make-instance 'collection-typ :unique-p t)
		     :value (remove-duplicates result))))) ;; I had (append source result) I don't think I want it.

#|
;;; "self.general()->closure(generalization->collect(general))->including(self)"  <---- POD's. Works.
(defun mofi::tryme (self)
  (ocl-including (ocl::ocl-closure (uml23::general self)
				  #'(lambda (x)
				      (ocl-collect (uml23:%generalization x)
						   #'(lambda
							 (y)
						       (uml23::%general y)))))
		self))

;;; Theirs: "self.generalization()->closure(general.generalization).general()->including(self)" 
;;; Something like theirs (no such function generalization())
;;; "self.generalization->closure(general.generalization).general()->including(self)" -- calls general on a collection
(defun mofi::tryme2 (self)
  (ocl-including (uml23:general 
		  (ocl-closure (uml23:%generalization self)
			       #'(lambda (x)
				   (uml23:%generalization (uml23:%general x)))))
		 self))
|#

;;;============================= 11.9.2 Set =============================
(defmethod ocl-select ((s |Set|) expr)
  "select: the subset of set S for which EXPR is true"
  (make-instance '|Set|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :true (funcall expr v))
			      collect v)))

(defmethod ocl-reject ((s |Set|) expr)
  "reject: the subset of set S for which EXPR is false"
  (make-instance '|Set|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :false (funcall expr v))
			      collect v)))

(defmethod ocl-collect-nested ((s |Set|) predicate)
  "collectNested: the Bag of elements which results from applying body to every member of the source set"
  (make-instance '|Bag|
		 :typ-d (make-instance 'collection-typ :unique-p nil)
		 :value (loop for v in (value s)
			      collect (funcall predicate v))))

;;; POD Of course, this is going to need some work on the predicate...
(defmethod ocl-sorted-by ((s |Set|) predicate)
  "sortedBy: results in the OrderedSet containing all elements of the source collection. 
   The element for which body has the lowest value comes first, and so on. 
   The type of the body expression must have the < operation defined. 
   The < operation must return a Boolean value and must be transitive 
   i.e. if a < b and b < c then a < c. 
  sortedBy may have at most one iterator variable."
  (make-instance '|OrderedSet|
		 :typ-d (typ-d s)
		 :value (sort (value s) predicate)))

;;;============================= 11.9.3 Bag =============================
(defmethod ocl-select ((s |Bag|) expr)
  "select: the subset of set S for which EXPR is true"
  (make-instance '|Bag|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :true (funcall expr v))
			      collect v)))

(defmethod ocl-reject ((s |Bag|) expr)
  "reject: the subset of set S for which EXPR is true"
  (make-instance '|Bag|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :false (funcall expr v))
			      collect v)))

(defmethod ocl-collect-nested ((s |Bag|) predicate)
  "collectNested: the Bag of elements which results from applying body to every 
   member of the source set."
  (make-instance '|Bag|
		 :typ-d (make-instance 'collection-typ :unique-p nil)
		 :value (loop for v in (value s)
			      collect (funcall predicate v))))

;;; POD Of course, this is going to need some work on the predicate...
(defmethod ocl-sorted-by ((s |Bag|) predicate)
  "Results in the OrderedSet containing all elements of the source collection. 
   The element for which body has the lowest value comes first, and so on. 
   The type of the body expression must have the < operation defined. 
   The < operation must return a Boolean value and must be transitive 
   i.e. if a < b and b < c then a < c. 
  sortedBy may have at most one iterator variable."
  (make-instance '|Sequence|
		 :typ-d (typ-d s)
		 :value (sort (value s) predicate)))

;;;============================= 11.9.4 Sequence =============================
(defmethod ocl-select ((s |Sequence|) expr)
  "select: the subset of set S for which EXPR is true"
  (make-instance '|Sequence|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :true (funcall expr v))
			      collect v)))

(defmethod ocl-reject ((s |Sequence|) expr)
  "reject: the subset of set S for which EXPR is true"
  (make-instance '|Sequence|
		 :typ-d (typ-d s)
		 :value (loop for v in (value s)
			      when (eql :false (funcall expr v))
			      collect v)))

(defmethod ocl-collect-nested ((s |Sequence|) predicate)
  "collectNested: the Bag of elements which results from applying body to 
   every member of the source set"
  (make-instance '|Sequence|
		 :typ-d (make-instance 'collection-typ :unique-p nil)
		 :value (loop for v in (value s)
			      collect (funcall predicate v))))

(defmethod ocl-sorted-by ((s |Sequence|) predicate)
  "sortedBy : results in the OrderedSet containing all elements of the source collection. 
   The element for which body has the lowest value comes first, and so on. 
   The type of the body expression must have the < operation defined. 
   The < operation must return a Boolean value and must be transitive 
   i.e. if a < b and b < c then a < c. 
  sortedBy may have at most one iterator variable."
  (make-instance '|Sequence|
		 :typ-d (typ-d s)
		 :value (sort (value s) predicate)))


;;;============================= 2007-06-29 OrderedSet =============================
;;; 2007-06-29, new method. 
(defmethod ocl-collect-nested ((s |OrderedSet|) predicate)
  "collectNested: the Bag of elements which results from applying body to 
   every member of the source set"
  (make-instance '|Sequence|
		 :typ-d (make-instance 'collection-typ :unique-p nil)
		 :value (loop for v in (value s)
			      collect (funcall predicate v))))


;;; self.allNamespaces()->iterate( ns : Namespace; result: String = self.name | 
;;;                                     ns.name->union(self.separator())->union(result))
#|
(let ((collection (all-namespaces self)))
  (loop for ns in (value collection) with result = (%name self)
	do (setf result (ocl-union (ocl-union (%name ns) (separator self)) result))
	finally return result))
|#

;;; POD Written 2006-10-11, on not much documentation, 7.6.5
(defmacro ocl-iterate (s iter-var accum-var accum-init expression)
  "iterate: "
  (with-gensyms (collection)
   `(let ((,collection ,s))
      (ocl-assert (|Collection| ,collection))
	(loop for ,iter-var in (value ,collection) with ,accum-var = ,accum-init
	      do (setf ,accum-var ,expression)
	      finally (return ,accum-var)))))

;;; Parser must ensure that this with a property, not things like .isEmpty()
(defun ocl-nav/collect (func col?)
  "Handle #\. shorthand for collections as collect: if COL? is a collection, 
   call ocl-collection on it. Otherwise this is ordinary navigation; funcall for it."
  (cond ;((null col?) (make-instance '|Bag|)) ; assume shorthand, since can't navigate.
        ((null col?) nil) ; 2016-10-26
        ((collection-p col?) (ocl-collect col? func)) ; infamous shorthand
	((eql :ocl-invalid col?) :ocl-invalid)
	(t (funcall func col?))))                     ; regular navigation to col?

(declaim (inline ocl-ensure-collection)) ; just used in generated code, so inlining probably useless.
(defun ocl-ensure-collection (arg)
  "If ARG is not a collection, return a Bag with ARG as its only value."
  (cond ((collection-p arg) arg)
	((eql arg :ocl-invalid) :ocl-invalid)
	(t (make-instance '|Bag| :value (if arg (list arg) nil)))))
