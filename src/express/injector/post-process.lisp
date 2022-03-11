
;;; Copyright (c) 2005 Peter Denno
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

;;; POD Doesn't this really belong in the P11 package? 
;;; (This whole directory could disappear). 

(in-package :injector)
(defvar *zippy* nil "diagnostics")
(defvar *mm-warnings* nil "Warnings regarding MM validation.")

;;; Added for 2012
(defun mm-warn (&rest args)
  (apply #'warn args))

(declaim (inline select-p enumeration-p))
(defun select-p (arg)
  (and (typep arg 'mex:|SpecializedType|)
       (typep (mex:%underlying-type arg) 'mex:|SelectType|)))

(defun enumeration-p (arg)
  (and (typep arg 'mex:|SpecializedType|)
       (typep (mex:%underlying-type arg) 'mex:|EnumerationType|)))

;;;=======================================================================
;;; Object printing
;;;=======================================================================
;;; Sometimes names are not given (|SelectType| that is the underlying type
;;; of a |SpecializedType|). Thus this can be a pass-through.
(defmethod print-object ((obj mex:|NamedElement|) stream)
  (if-bind (id (mex:%id obj))
	   (format stream "<~A ~A id=~A>" 
		   (class-name (class-of obj)) 
		   (mex:%local-name (mex:%id obj))
		   (mofi:%debug-id obj))
	   (format stream "<~A id=~A>" 
		   (class-name (class-of obj)) 
		   (mofi:%debug-id obj))))


(defmethod print-object ((obj mex:|Scope|) stream)
  (format stream "<~A id=~A>" 
	  (class-name (class-of obj)) 
	  (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:|ParameterType|) stream)
  (format stream "<~A id=~A>" 
	  (class-name (class-of obj)) 
	  (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:|DataType|) stream)
  (format stream "<~A id=~A>" 
	  (class-name (class-of obj)) 
	  (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:|Schema|) stream)
  (format stream "<Schema ~A id=~A>" (mex:%name obj) (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:|SingleEntityType|) stream)
  (if-bind (id (mex:%id obj))
    (if (typep id 'mex:|ScopedId|)
	(format stream "<~A ~A id=~A>" 
		(class-name (class-of obj)) 
		(mex:%local-name id)
		(mofi:%debug-id obj))
	(format stream "<SingleEntityType (unfinished) id=~A>" (mofi:%debug-id obj)))
    (call-next-method)))

(defmethod print-object ((obj mex:|VariableRef|) stream)
  (if-bind (id (mex:%id obj))
    (format stream "<~A ~A id=~A>" (class-name (class-of obj)) (mex:%local-name id) (mofi:%debug-id obj))
    (call-next-method)))

(defmethod print-object ((obj mex:|ScopedId|) stream)
  (format stream "<ID ~A id=~A>" (mex:%local-name obj) (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:|BinaryOperator|) stream)
  (format stream "<BinaryOperator ~A id=~A>" (mex:%local-name (mex:%id obj)) (mofi:%debug-id obj)))

(defmethod print-object ((obj mex:unresolved-attribute-ref) stream)
  (format stream "<unresolved-attribute-ref ~A id=~A>" (mex:%local-name obj) (mofi:%debug-id obj)))


;;; There are no CLOS classes at this point, so don't consider this a quirky replacement for find-class!
(defun mexico-find-class (name &key (schema (p11p::schema-scope *scope*)) error-p)
  "Find a NamedType in the current population with name NAME."
  (let ((name (string name)))
    (or 
     (loop for c in (mex:%schema-elements schema)
	   when (and (typep c 'mex:|NamedType|)
		     (string-equal name (mex:%local-name (mex:%id c))))
	   return c)
     (when error-p (error "No class named ~A." name)))))

(defun mm-class-precedence-list (name)
  "Like clos:class-precedence-list, but for mm NamedTypes -- and not ordered ;^).
   NAME can be a string, symbol or EntityType.
   String NAME just has to be string-equal (like all EXPRESS names). Result includes NAME class
   and may contain SpecializedTypes and EntityTypes."
  (let ((class (if (or (symbolp name) (stringp name)) (mexico-find-class name :error-p t) name))
	accum)
    (labels ((mm-cs-aux (classes)
		(cond ((null classes) nil)
		      ((atom classes) 
		       (let ((new
			      (cond ((and (typep classes 'mex::|SpecializedType|)
					  (typep (mex::%underlying-type classes) 'mex:|SelectType|))
				     (mex:%select-list (mex::%underlying-type classes)))
				    ((typep classes 'mex:|EntityType|) (mex:%subtype-of classes))
				    (t nil)))) ; it's a primitive type, ignore it?
			 (setf accum (append accum new))
			 (mapcar #'mm-cs-aux new)))
		      (t (mm-cs-aux (car classes))
			 (mm-cs-aux (cdr classes))))))
      (mm-cs-aux class)
      (remove-duplicates (cons class accum)))))


;;; See express/expcore/expresso.lisp for how these work.
;;; Collect instances of these for subsequent resolution in pp-resolve-referencers
(defmethod initialize-instance :after ((obj mex:|GroupRef|) &key)
  (vector-push-extend obj (pp-group-refs (expo:pp-record expo:*expresso*))))


(defmethod initialize-instance :after ((obj mex:|EnumItemRef|) &key)
  (vector-push-extend obj (pp-enum-item-refs (expo:pp-record expo:*expresso*))))

(defmethod initialize-instance :after ((obj mex:|SelectType|) &key)
  (vector-push-extend obj (pp-select-types (expo:pp-record expo:*expresso*))))

;;; Collect instances of these for subsequent resolution in pp-resolve-operators
(defmethod initialize-instance :after ((obj mex:|BinaryOperation|) &key)
  (vector-push-extend obj (pp-binary-operations (expo:pp-record expo:*expresso*))))


;;;===================================================================================
;;; Schema 'completion' stuff - resolve references an patch up shortcomings in what 
;;; was gathered during parsing. 
;;;===================================================================================
(defmethod pp-schema ((schema mex:|Schema|) &key lisp-gen)
  "Toplevel function to post-process a schema. Order of execution is important!
   If target output is LISP-GEN = T, then post-processing is less intensive."
  ;; Resolve named elements (replace ScopedId with object)...
  ;; Finalize EntityTypes...
  (loop for obj in (mex:%schema-elements schema)
	when (typep obj 'mex:|EntityType|) do (pp-finalize-EntityType obj))
  ;; Resolve referencers (|GroupRef|, |EnumItemRef|, |SelectType|)...
  (pp-resolve-referencers) ; POD Can I eliminate this (done in parser2 ?)
  ;; Resolve redeclared and inverse attributes...
  (loop for obj in (mex:%schema-elements schema)
	when (typep obj 'mex:|EntityType|) do (pp-fix-EntityType.redeclarations obj))
  (loop for obj in (mex:%schema-elements schema) ; must be done after fixing redeclarations.
	when (typep obj 'mex:|EntityType|) do
	(pp-fix-Attribute.id obj)
	(pp-fix-EntityType-inverses obj))
  ;; Resolve attribute references...
  (pp-resolve-attribute-refs)
  ;; Resolve operators...
  (unless lisp-gen (pp-resolve-operators))
  schema)


(defun pp-resolve-referencers ()
  "'referencers' are identifiers with schema scope. This replaces the ScopedId with
   the object it references. The pp-x slots of pp-record is a list of instances of type x.
   Instances are pushed into the vector by initialize-instance."
  (with-slots (pp-group-refs pp-enum-item-refs pp-select-types) (expo:pp-record expo:*expresso*)
    (loop for obj across pp-group-refs
	  do (pp-resolve-GroupRef.refers-to obj))
    (loop for obj  across pp-enum-item-refs
	  do (pp-resolve-EnumItemRef obj))
    (loop for obj across pp-select-types
	do (pp-resolve-SelectType-base obj))))

;;; POD This has been Kludged for express-x to look in the target and source schema
;;; whenever it can't find the result in *scope*.
(defun pp-resolve-GroupRef.refers-to (obj)
  (let (class)
    (declare (ignore class)) ; pod7 added
    (if-bind (ref (mex:%refers-to obj))
      (cond ((typep ref 'mex:|SingleEntityType|)) ; in which case already resolved.
	    ((typep ref 'mex:|EntityType|) ; just not Single
	     (setf (mex:%refers-to obj) (mex:%declares ref)))
	    (t (error "Cannot find class ~A" ref)))
      (when-bind (id (mex:%id obj))
	(setf (mex:%refers-to obj)
	      (mex:%declares (p11p::lookup-referenceable (mex:%id obj))))))))

(defun pp-resolve-EnumItemRef (obj)
  "Determine obj.refers-to, which is an |EnumItemRef|."
  (flet ((find-it (item-name decl) ; find ITEM-NAME (a string) in the enum list.
	   (and (typep (mex:%underlying-type decl) '|EnumerationType|)
		(find item-name (mex:%values (mex:%underlying-type decl)) 
		      :key #'(lambda (x) (mex:%local-name (mex:%id x))) :test #'string-equal))))
    (unless (mex:%refers-to obj) ; in which case it was already visited...
      (let ((item-name (mex:%local-name (mex:%id obj))) enum-type enum-item)
	(if (mex:%data-type obj) ; type was specified in parse...
	    (progn (setf enum-type (mexico-find-class (mex:%local-name (mex:%id (mex:%data-type obj)))
						  :error-p t))
		     (setf enum-item (find-it item-name enum-type)))
	    ;; type was not specified in parse, search for it...
	    (let ((enums (loop for decl in (remove-if (complement #'enumeration-p) 
						      (mex:%schema-elements (p11p::schema-scope *scope*)))
			       when (find-it item-name decl)
			       collect decl)))
	      (unless (single-p enums) (mm-warn "Line ~A: Ambiguous use of enumeration id ~A" 
						(mofi:%defined-at obj) item-name))
	      (setf enum-type (car enums))
	      (setf enum-item (find-it item-name (car enums)))))
	(unless enum-item (error "Enumeration type ~A does not have an item ~A" enum-type item-name))
	;; scope of id was nil (and it was a SchemaScopedId).
	(setf (mex:%id obj) (p11p::make-scoped-id item-name :force-scope enum-type))
	(setf (mex:%refers-to obj) enum-item)
	(setf (mex:%data-type obj) enum-type))))
  (values))

(defun pp-resolve-SelectType-base (obj)
  "Earlier it was resolved from a ScopedId, but what is required is the underlying type of that."
  (when-bind (base (mex:%base obj))
    (when (and (typep base '|SpecializedType|)
	       (select-p base))
      (setf (mex:%base obj) (mex:%underlying-type base)))))

(defvar *current-node* nil "diagnostics")

(defparameter *show-me-the-slots*  nil)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun mm-subtypes-of (in-class-name &key self)
    (append (when self (list in-class-name))
	    (remove-duplicates
	     (loop for class across (mofi:types (mofi:find-model :mexico))
		with the-superclass = (find-class in-class-name)
		when (and (member the-superclass (closer-mop:class-precedence-list class))
			  (not (eql in-class-name (class-name class))))
		collect (class-name class)))))
)

;;;(|Function| |BinaryOperator| |UnaryOperator| |ParameterType| |GeneralSETType| |ARRAYType| 
;;; |BAGType| |SETType| |AggregationType| |ConcreteType| |GenericType| |EntityType| |LISTType| 
;;; |NumericType| |NamedType| |SelectType| |DefinedType| |GeneralizedType| |LogicType| 
;;; |BooleanType| |Integer| |EnumerationType| |StringType| |SimpleType| |AGGREGATEType| 
;;; |BinaryType| |GeneralAggregationType| |GeneralARRAYType| |RealType| |AnonymousType| 
;;; |SpecializedType| |GeneralBAGType| |InstantiableType| |GeneralLISTType|)
(let ((+subtypes+ 
       (remove-duplicates
	(append (mm-subtypes-of 'mex:|NamedType| :self t)
		(mm-subtypes-of 'mex:|Function| :self t)
		(mm-subtypes-of 'mex:|ParameterType| :self t)))))
  (defun pp-replace-with-named-type (node)
    (setf *current-node* node)
    (dbind (object slot) node
      (when (and slot (member (mofi:slot-definition-range slot) +subtypes+))
	(let* ((slot-name (closer-mop:slot-definition-name slot))
	       (vals (slot-value object slot-name)))
	  (pushnew slot *show-me-the-slots*)
	  (when vals
	    (cond ((typep vals 'mex:|ScopedId|)
		   (let ((obj (p11p::lookup-referenceable vals)))
		     (setf (slot-value object slot-name) obj)
		     #|(setf (mex:%identifies vals) obj)|# obj)) ;  POD 2006-07-31 OK?
		  ((listp vals)
		   (setf (slot-value object slot-name)
			 (loop for v in vals
			       if (typep v 'mex:|ScopedId|)
			       ;collect (setf (mex:%identifies v) (lookup-referenceable v)) 
			       collect (p11p::lookup-referenceable v) ; POD 2006-07-31 OK?
			       else collect v)))))))))
)

(defmethod pp-fix-Attribute.id ((obj mex:|EntityType|))
  (loop for attr in (remove-if (complement #'(lambda (x) (typep x 'mex:unresolved-attribute)))
			       (mex:%declares (mex:%declares obj))) ; obj->SingleEntityType.declares
	for id = (mex:%id attr)
	unless (eql (mex:%defining-scope id) obj) do
	(mm-warn "Line ~A: Ill-formed attr id: ~A" (mofi:%defined-at obj) attr)
	(setf (mex:%id attr) 
	      (or 
	       (gethash (cons (p11uintern (mex:%local-name id)) obj) p11p::*scoped-ids*)
	       (error "ScopedId does not exist: ~A ~A" id obj)))))

;;; '\GROUP' always refers to the defining entity
;;; For example in Rule_software_definition
;;;    SELF\Product_view_definition.defined_version : Rule_version;
(defun pp-fix-EntityType.redeclarations (entity) ; ((entity |EntityType|))
  "Resolve unresolved-attribute objects in EntityType.redeclarations"
  ;; The defmemo keeps the following from being too wasteful. Also you can't 
  ;; call this multiply as it stands mex:%where-found is an Entity second time in.
  (loop for super in (mex:%subtype-of entity) do (pp-fix-EntityType.redeclarations super))
  (loop for r in (mex:%redeclarations entity) 
	for unres = (mex:%original-attribute r) ; unres is a unresolved-attribute
	when (typep unres 'mex:unresolved-attribute) do 
	;; ...For example, here defining-entity refers to the 'group' which
	;; might not be the defining entity, yet that is where find-attr looks. 
	;; 2006-04-05 HUH? That comment makes no sense WRT the the "always" above.
	(setf (mex:%original-attribute r)
	      (find-attr (mex:%local-name (mex:%id (mex:%where-found unres)))
			 (mex:%attribute-name unres) :source-upward t))))
		

(defmethod pp-fix-EntityType-inverses ((obj mex:|EntityType|))
  (loop for iattr in (mex:%attributes obj) ; unres may be an unresolved-attribute
	if (typep iattr 'mex:|InverseAttribute|) 
	when (typep (mex:%explicit iattr) 'mex:unresolved-attribute) do
	(let* ((unres (mex:%explicit iattr))
	       (where-found (mex:%where-found unres))
	       (attr-name (mex:%local-name (mex:%attribute-name unres))))
	  (setf (mex:%explicit iattr) 
		(find-attr (mex:%local-name (mex:%id where-found)) attr-name :source-upward t)))))

(defmethod pp-finalize-EntityType ((obj mex:|EntityType|))
  "Copy attributes from SingleEntityType objects into the EntityType OBJ."
  (setf (mex:%attributes obj)
	(loop for class in (mm-class-precedence-list obj)
	      append (mex:%declares (mex:%declares class)))))

;;;=====================================================================
;;; Resolve attribute reference
;;;=====================================================================
;;; POD 2012 This was set in xmi-gen.lisp, which isn't used anymore. 
(defparameter *unresolved-attribute-refs* (make-array 1000 :adjustable t :fill-pointer 0))

(defun pp-resolve-attribute-refs ()
  "Replace an unresolved-attribute-ref with an AttributeRef. (BTW, the 
   thing unresolved is the refers-to slot. It needs to point to an Attribute.)
   The vector *u-a-r* gets populated by setf methods defined in emm.lisp"
  (loop for (object . slot-name) across *unresolved-attribute-refs*
	for vals = (slot-value object slot-name)
	when vals do
	(cond ((typep vals 'mex:unresolved-attribute-ref)
	       (let ((new-val (resolve-attr vals)))
		 (setf (slot-value object slot-name) new-val)))
	      ((listp vals)
	       (setf (slot-value object slot-name)
		     (loop for v in vals
			   if (typep v 'mex:unresolved-attribute-ref)
			   collect (resolve-attr v)
			   else collect v))))))

#|Example of how things work, suppose you have a QUERY using x.dim in the body, where x is the QUERY variable.
 (1) qfactor-qifers called with primary VariableRef x and '(:attr #<unresolved-attribute-ref dim>),
     it sets the u-a-ref.entity-instance to VariableRef x.
 (2) So we have a primary = unresolved-attribute-ref with both the entity and attribute set, 
     but u-a-ref.local-name is the string "dim" and u-a-ref.entity-instance is a VariableRef, which 
     is a ScopedId (scoped to the QUERY expression). [2007 "which is a ScopedId" ???]
 (3) resolve-attr is called (this method). It calls mu-type-ref which gets the entity information
     which can then be used by find-attr to find the actual attribute. With the attribute and entity,
     you can make an AttributeRef where AttributeRef.entity-instance is a newly created GroupRef. 
     Note that what mu-type-ref is doing (walking backward over expression) to the
     VariableRef etc.
 (4) 2007-02-11 : Tracking of unresolved-attr-refs is difficult because this copies entity-instance
     information from the u-a-r to the new AttributeRef. Things getting fixed are on the old u-a-r.
     Therefore, I walk the Expression here, and call reolve-attr as needed
|#
(defmethod resolve-attr ((exp mex:unresolved-attribute-ref))
  "Resolve the argument to an entity attribute. Returns an AttributeRef."
  (setf *zippy* exp)
  (let ((*scope* (mex:%scope exp)))
    (if-bind (ent (mu-type-ref (mex:%entity-instance exp))) ; find the EntityType this FullExpression refers to.
      (if-bind (attr (find-attr (mex:%local-name (mex:%id ent)) (mex:%local-name exp) 
				:source-upward t :source-downward t :error-p nil))
	       (make-instance 
		'mex:|AttributeRef| ; mk-instance here won't help.
		:id (mex:%id attr) 
		:refers-to attr ; <=== THIS is the goal of all this work. 
		:entity-instance (pp-walk-expression (mex:%entity-instance exp))) ; <=== THIS is the problem.
	       (error 'pprocess-error 
		      :line-number (mofi:%defined-at exp)
		      :text (format nil "Entity ~A does not have an attribute ~A." 
				    (mex:%local-name (mex:%id ent)) (mex:%local-name exp))))
      (mm-warn "Could not determine entity type making attribute reference: ~A.~A" 
	       (mex:%entity-instance exp) (mex:%local-name exp)))))

;;; POD I'm confused regarding how the above can return an AttributeRef.
;;; If this did that, it would loop in pp-walk-expression.
(defmethod resolve-attr ((exp mex:|AttributeRef|))
  (mex:%entity-instance exp))

(defun identify-slots-for-attr-setf-tracking ()
  (let ((+can-be-exp+ (mm-subtypes-of '|Expression| :self t)))
    (sort 
     (remove-duplicates 
      (loop for class across (mofi:types (mofi:find-model :mexico))
	    for class-name = (class-name class) append
	    (loop for slot in (closer-mop:class-direct-slots class)
		  when (member (mofi:slot-definition-range slot) +can-be-exp+)
		  collect (cons class-name (closer-mop:slot-definition-name slot))))
      :test #'equal)
     #'string< :key #'car)))

;;; For usage above, this should NOT contain the list (u-a-r . entity-instance) because 
;;; resolve-attr takes care of calling pp-walk-expression on that. 
(defparameter *walk-slots* nil "Values of form (class . slot-name) indicating that the slot contains an Expression.")

;;; Note: This isn't really general purpose since it check for u-a-r.
(defun pp-walk-expression (exp &key (do-func #'resolve-attr))
 "Run DO-FUNC on every slot of EXP that is an Expression (because that's what *walk-slots* lists)
  Update the slot with the (updating the slot). Calls itself recursively on those slots. 
  Returns EXP."
 (when (null *walk-slots*) 
   (setf *walk-slots* (identify-slots-for-attr-setf-tracking)))
 (loop for (class . slot) in *walk-slots* do
       (when (typep exp class)
	 (when (typep (slot-value exp slot) 'mex:unresolved-attribute-ref)
	   (setf (slot-value exp slot) (funcall do-func exp)))
	 (pp-walk-expression (slot-value exp slot) :do-func do-func)))
 exp)

;;;========================================
;;; Resolve operators
;;;========================================
(defun pp-resolve-operators ()
  "Transform an |unresolved-operator whatever| to a |BinaryOperator|."
  (loop for operation across (pp-binary-operations (expo:pp-record expo:*expresso*)) 
	when (typep (mex:%operator operation) 'mex:unresolved-operator) do
	(pp-resolve-operators-aux operation)))

(defun pp-resolve-operators-aux (operation)
  "Broken out from above for easier debugging."
  (let* ((generic-op (kintern (mex:%enum-symbol (mex:%operator operation))))
	 (l (expr-type (mex:%left-operand operation)))
	 (r (expr-type (mex:%right-operand operation)))
	 (types (cond ((and (null l) (null r)) '(:fail))
		      ((and (eql l :any) (eql r :any)) '(:fail))
		      ((eql l :any) (list r)) ; pod - should warn
		      ((eql r :any) (list l)) ; pod - should warn
		      ((eql l r) (list l)) ; information loss (do we care?)
		      ((and (eql l :logical) (eql r :boolean)) '(:logical))
		      ((and (eql r :logical) (eql l :boolean)) '(:logical))
		      ((and l r) (list l r))
		      (t (list (or l r)))))
	 (op-symbol nil))
;    (when (and (typep l 'mex:|Literal|) (typep r 'mex:|Literal|)) ; POD -- something like this.
;      (format t "optimization opportunity: ~A ~A" l r))
    (setf op-symbol
	  (cond ((single-p types)
		 (operator-choose-single generic-op (car types)))
		((cdr types)
		 (when (intersection types '(:aggregate :set :bag :list))
		   (operator-choose-aggregate generic-op (first types) (second types))))))
    (unless op-symbol (alert-message "Line ~a: Cannot determine operator for ~A ~A" 
			       (mofi:%defined-at operation) generic-op types))
    (setf (mex:%operator operation)
	  (make-instance 
	   'mex:|BinaryOperator| 
	   :id (if op-symbol 
		   (p11p::make-scoped-id  op-symbol)
		   (make-instance 
		    'mex:|ScopedId| 
		    :local-name 
		    (string (choose-unresolved-operator generic-op))))))))

(defun choose-unresolved-operator (generic-op)
  "Return an unresolved-op string This is a fall-back when the operator cannot be determined. 
   Expresso uses overloading anyway."
  (case generic-op
    (:+ "unresolved-plus")
    (:- "unresolved-minus")
    (:* "unresolved-star")
    (:/ "unresolved-divide")
    (:= "unresolved-value-equal")
    (:> "unresolved-greater")
    (:< "unresolved-less")
    (:<> "unresolved-unequal")
    (:\:=\: "unresolved-instance-equal")
    (:\:<>\: "unresolved-instance-unequal")))

(defun operator-choose-single (generic-op arg)
  "Choose the exact operator for the generic-op and argument."
  (case arg
    (:number 
     (case generic-op (:+ "Add") (:- "Subtract") (:* "Multiply") (:/ "RealDivide") 
	   (:= "Equal") (:< "Less") (:> "Greater") (:<> "UnEqual") (:>= "GreaterEqual") 
	   (:<= "LessEqual")))
    (:string 
     (case generic-op (:+ "StringAppend") (:= "StringEqual") (:< "StringLess") 
	   (:> "StringGreater") (:>= "StringGreaterEqual") (:<= "StringLessEqual") 
	   (:<> "StringUnequal")))
    (:enum 
     (case generic-op (:= "EnumEqual") (:< "EnumLess") (:> "EnumGreater")
	   (:<> "EnumUnequal") (:>= "EnumGreaterEqual") (:<= "EnumLessEqual")))
    (:set 
     (case generic-op (:* "Intersection") (:+ "SetUnion") (:<= "Subset") (:>= "Superset")))
    (:entity 
     (case generic-op (:= "EntityValueEqual") (:<> "EntityValueUnequal")
	   (:\:=\: "EntityInstanceEqual") (:\:<>\: "EntityInstanceUnequal")))
    ((:boolean :logical)
     (case generic-op (:= "LogicalEqual") (:<> "LogicalUnequal") (:< "LogicalLess") 
	   (:> "LogicalGreater") (:>= "LogicalGreaterEqual")  (:<= "LogicalLessEqual")))
    (:array
     (case generic-op (:= "ArrayEqual") (:<> "ArrayUnequal")))))

#|
    =    "Equal" "StringEqual" "LogicalEqual" "ListEqual" "BagEqual" "EnumEqual" "ArrayEqual" "BinaryEqual" 
         "EntityValueEqual" 
    +    "Add" "BagAdd" "BagUnion" "ListAppend" "BinaryAppend" "SetAdd" "SetUnion" "StringAppend" 
          "ListAddFirst" "ListAddLast" 
    -    "Subtract"  "BagDifference" "BagRemove" 
    >    "Greater" "LogicalGreater" "StringGreater" "EnumGreater" "BinaryGreater" 
    <    "Less" "StringLess" "LogicalLess" "EnumLess"  "BinaryLess" 
    <>   "Unequal" "ArrayUnequal" "BagUnequal" "EnumUnequal" "ListUnequal" "EntityValueUnequal" "BinaryUnequal" 
         "LogicalUnequal"  "StringUnequal"
    >=   "GreaterEqual" "EnumGreaterEqual"  "LogicalGreaterEqual" "StringGreaterEqual" "BinaryGreaterEqual" 
    <=   "LessEqual" "EnumLessEqual" "LogicalLessEqual" "StringLessEqual" "BinaryLessEqual" "Subset" 
    :=:  "EntityInstanceEqual" "BagInstanceEqual" "ListInstanceEqual"
    :<>: "EntityInstanceUnequal" "BagInstanceUnequal" "ListInstanceUnequal" 
    /    "RealDivide"
    *    "Multiply" "Intersection"
   "Substitute" 
|#

(defun operator-choose-aggregate (generic-op one two)
  (when (eql one :aggregate) (rotatef one two))
  (case generic-op
    (:+ ; table 17, 12.6.4
     (case one 
       (:bag  (if (member two '(:bag :list :set :aggregate)) "BagUnion" "BagAdd"))
       (:set  (if (member two '(:bag :list :set :aggregate)) "SetUnion" "SetAdd"))
       (:list (if (eql two :list) "ListAppend" "ListAddLast"))
       (otherwise
	(case two (:bag "BagUnion") (:set "SetUnion") (:list "ListAddFirst")))))
    (:- ; table 18  12.6.4
     (case one 
       (:bag (if (member two '(:bag :set :aggregate)) "BagUnion" "BagAdd"))
       (:set (if (member two '(:bag :set :aggregate)) "SetUnion" "SetAdd"))))
    (:<= ; 12.6.5 Subset Operator
     (case one ; table 18  12.6.4
       (:bag (if (member two '(:bag :set :aggregate)) "Subset"))
       (:set (if (member two '(:bag :set :aggregate)) "Subset"))))
    (:>= ; 12.6.6 Superset Operator
     (case one ; table 18  12.6.4
       (:bag (if (member two '(:bag :set :aggregate)) "Superset"))
       (:set (if (member two '(:bag :set :aggregate)) "Superset"))))
    (:* "Intersection")
    (:\:=\:
     (case one 
       (:bag  (when (eql two :bag) "BagInstanceEqual"))
       (:list (when (eql two :list) "ListInstanceEqual"))))
    (:\:<>\:
     (case one 
       (:bag  (when (eql two :bag) "BagInstanceUnequal"))
       (:list (when (eql two :list) "ListInstanceUnequal"))))))

(defmethod expr-type ((exp number))
  :number)

(defmethod expr-type ((expr string))
  :string)

(defmethod expr-type ((expr mex:|Literal|))
  (typecase (mex:%refers-to expr)
    (mex:|LogicalValue| :logical)
    (mex:|StringValue| :string)
    (t :number)))

(defmethod expr-type ((expr mex:|AttributeRef|))
  (expr-type (mex:%attribute-type (mex:%refers-to expr)))) 

(defmethod expr-type ((expr mex:|AggregateInitializer|))
  :aggregate)

(defmethod expr-type ((expr mex:|FunctionCall|))
  (let ((fn (mex:%invokes-function expr)))
    (typecase fn
      ((or mex:|UnaryOperator| mex:|BinaryOperator|)
       (case (kintern (second (split (mex:%local-name (mex:%id fn)) #\:)))
	 ((:stringappend :format) :string)
	 ((:sizeof :typeof :abs :acos :asin :atan :blength :cos :exp :hibound :hiindex :length 
		   :lobound :log :log2 :log10 :loindex :sin :sqrt :tan :value :value_in :value_unique) :number)
	 ((:typeof :rolesof) :set)
	 (:exists :boolean)
	 ((:odd :value_in :value_unique) :logical)
	 (otherwise 
	  (mm-warn "Line ~A: Don't know this function ~A" 
		   (mofi:%defined-at expr) (mex:%invokes-function expr))
	  nil)))
      (|Function| ; PODsampson comments
       (cond ;((mex:%actual-types (mex:%result fn)) ; POD bogus! PODTT actual-types
	     ; (expr-type (mex:%refers-to (mex:%actual-types (mex:%result fn)))))
	     ((mex:%variable-type (mex:%result fn)) ; PODTT
	      (expr-type (mex:%variable-type (mex:%result fn))))))))) ; PODTT

;;; A new method for 2006-04-28 !?!? RESOLVED effective method.
;;; But note that these appear to be needed even before April.
;;; 2006-05-05 I see an example running AP203 where calling resolve-op
;;; (on an unresolved-operator, of course) ends up here. 
(defmethod expr-type ((expr mex:|BinaryOperation|))
  (unless (typep (mex:%operator expr) 'mex:unresolved-operator) ; just getting weirder...
    (let ((fn (kintern (second (split (mex:%local-name (mex:%id (mex:%operator expr))) #\:)))))
      (case fn
	((:stringappend :format) :string)
	(:add :number)
	(:greater :logical)
	(:intersection :set) ; POD ?
	(:unresolved-plus :add) ; POD HACK!
	(:unresolved-minus :subtract) ; POD HACK!
	(:unresolved-star :multiply) ; POD HACK!
	(otherwise 
	 (mm-warn "Line ~A: (2) Don't know this function ~A" 
		  (mofi:%defined-at expr) fn))))))

#+nil ; PODTT
(defmethod expr-type ((expr |Referencer|))
  (when-bind (id (mex:%id expr))
    (when (typep (mex:%defining-scope id) 'mex:|Schema|)
      (expr-type (find-class (p11uintern (mex:%local-name id)))))))

(defmethod expr-type ((expr mex:|SpecializedType|))
  (let ((types (underlying-types expr)))
    (cond ((every #'(lambda (x) (typep x 'mex:|NumericType|)) types) :number)
	  ((every #'(lambda (x) (typep x 'mex:|EntityType|)) types) :entity)
	  ((every #'(lambda (x) (typep x 'mex:|StringType|)) types) :string)
	  ((every #'(lambda (x) (typep x 'mex:|EnumerationType|)) types) :enum)
	  (t :any))))

(defmethod expr-type ((expr mex:|AggregateIndex|))
  (expr-type (mex:%base-value expr)))

(defmethod expr-type ((arg t)) 
  (typecase arg
    (mex:|StringType| :string)
    (mex:|EntityType| :entity)
    (mex:|BooleanType| :boolean)
    (mex:|LogicType| :logical)
    (ptypes:|Integer| :number) 
    (mex:|EnumItemRef| :enum)
    (mex:|GroupRef| :entity)
    (mex:|RealType| :number)
    (mex:|NumericType| :number)
    (mex:|ARRAYType| :array)
    (mex:|BAGType| :bag)
    (mex:|LISTType| :list)
    (mex:|SETType| :set)
    (mex:|GeneralARRAYType| :array)
    (mex:|GeneralBAGType| :bag)
    (mex:|GeneralLISTType| :list)
    (mex:|GeneralSETType| :set)
    (mex:|BinaryType| :binary)
    (otherwise 
     (mm-warn "Line ~A: I don't know this type: ~A" 
	      (mofi:%defined-at arg) arg))))
;     (setf *zippy* arg) (break "here"))))

;;;========================================================
;;; Utilities
;;;========================================================
;;; The idea of :source-upward is that the unresolved-attribute created in an
;;; INVERSE declaration does not necessarily reference the defining entity, (it
;;; might be defined in a supertype). -- Thus need :source-upward t for this. 
;;; This is in contrast to redeclared attributes, where \<group>
;;; always refers to the defining attribute (thus :source-upward nil for this).
(defparameter *zippy* nil)

(defun find-attr (type-name attr-name &key (schema (p11p::schema-scope *scope*)) source-upward source-downward (error-p t))
  "Return the Attribute object named ATTR-NAME (a string) defined in entity named TYPE-NAME (a string)"
  (when (member type-name '("GENERIC" "GENERIC_ENTITY") :test #'string-equal)
    ;; Make a bogus attribute. The reference could not be found. (This just to enable mm2lisp).
    (return-from find-attr
      (make-instance 'mex:|Attribute| 
		     :of-entity (mex:%declares (mexico-find-class "GENERIC_ENTITY"))
		     :id (p11p::make-scoped-id attr-name :scope (p11p::schema-scope *scope*))
		     :attribute-type (mexico-find-class "GENERIC"))))
  (let* ((eclasses (if source-upward 
		       (mm-class-precedence-list type-name)
		     (list (mexico-find-class type-name :error-p t))))
	 ;; POD This next part is "cold hacked" 2007-10-01
	 (eclasses (if source-downward
		       (let ((type-obj (mexico-find-class type-name :error-p t)))
			 (remove-duplicates 
			  (append eclasses
				  (loop for elem in (remove-if 
						     (complement #'(lambda (x) (typep x 'mex:|EntityType|)))
						     (mex:%schema-elements schema))
				      when (member type-obj (mm-class-precedence-list elem))
				      collect elem))))
		       eclasses))
	 ;; POD Currently not warning on duplicate names.
	 (base-classes (remove-if #'(lambda (x) (not (typep x 'mex:|EntityType|)))
				  (mapappend #'underlying-types eclasses))))
    (loop for eclass in base-classes 
	  for ename = (mex:%local-name (mex:%id eclass)) do
	  (loop for attr in (mex:%attributes eclass)
		when (and (not (typep attr 'mex:unresolved-attribute)) ; 2006-03-14
			  (not (typep (mex:%id (mex:%of-entity attr)) 'mex:unresolved-attribute)) ; 2006-03-14
			  (string-equal attr-name (mex:%local-name (mex:%id attr)))
			  (string-equal ename (mex:%local-name (mex:%id (mex:%of-entity attr)))))
		do (return-from find-attr attr))
	  ;; POD 2006-01-20 - should I return the ExplicitAttribute or the Redeclaration?
	  (loop for redecl in (mex:%redeclarations eclass)
		for add-name = (mex:%alias redecl)
		when (or (and add-name
			      (not (typep add-name 'mex:unresolved-attribute)) ; 2006-03-14
			      (not (typep (mex:%id (mex:%scope redecl)) 'mex:unresolved-attribute)) ; 2006-03-14
			      (string-equal attr-name (mex:%local-name add-name)))
			 (and (string-equal ename (mex:%local-name (mex:%id (mex:%scope redecl))))
			      (string-equal attr-name (mex:%local-name (mex:%id (mex:%original-attribute redecl))))))
		do (return-from find-attr (mex:%original-attribute redecl)))
	  finally (when error-p (error "Entity ~A does not have attribute '~A'."  
				       type-name attr-name)))))

;;; POD better than remove-duplicates might be a type-equal function.
;;; (underlying-types (mm-find-whatever 'measure_value :scope-p t))
(defvar *utypes-collected* nil)
(defun underlying-types (obj)
  "Return all the types underlying the argument select."
  (unless (typep obj 'mex:|SpecializedType|) (return-from underlying-types (list obj)))
  (setf *utypes-collected* nil)
  (underlying-types-aux (mex:%underlying-type obj))
  (remove-duplicates *utypes-collected*)) ; better wo

(defun underlying-types-aux (obj)
  (cond ((typep obj 'mex:|SpecializedType|)
	 (underlying-types-aux (mex:%underlying-type obj)))
	((typep obj 'mex:|AggregationType|)
	 (underlying-types-aux (mex:%member-type obj)))
	((not (typep obj 'mex:|SelectType|))
	 (push obj *utypes-collected*))
	((typep obj 'mex:|SelectType|)
	 (mapcar #'underlying-types-aux (mex:%select-list obj)))))

;;;------------------------------------------------------------------------------------
;;; ---------- mu-X utility functions: navigate the MM objects to find or compose an X. 
;;;------------------------------------------------------------------------------------
;;; Identify the type (NamedType, SimpleType) to which the argument Expression refers.
;;; Typically this requires navigation of the expression "right to left" back to a 
;;; VariableRef etc., for which the type has been identified. 
;;; It returns a SingleEntityType when successful. 
(defgeneric mu-type-ref (arg &key &allow-other-keys))

(defmethod mu-type-ref ((arg mex:|GroupRef|) &key) 
  (mex:%refers-to arg))

(defmethod mu-type-ref ((arg mex:|VariableRef|) &key selects)
  (or (when-bind (type (mex:%data-type arg)) (mu-type-ref type)) ; POD Goal is to make this like ConstantRef. 
      (etypecase (mex:%defining-scope (mex:%id arg))
	(mex:|QueryExpression| ; find the member type 
	 (let ((agg-val (mex:%aggregate-operand (mex:%defining-scope (mex:%id arg))))) ; QUERY(var <* some_func() | ...)
	   (if (typep agg-val 'mex:|FunctionCall|) ; then DON'T go through mu-entity-ref. Get some_func member-type...
	       (if (string-equal "USEDIN" (mex:%local-name (mex:%id (mex:%invokes-function agg-val)))) ;; ...UNLESS...
		   (when-bind (str (mu-string-literal (mex:%actual-value (second (mex:%actual-parameters agg-val)))))
		     (when-bind (entity/attr (cdr (split str #\.)))
		       (when-bind (attr (apply #'find-attr entity/attr))
			 (mex:%of-entity attr))))
		   (if-bind (mtype (mex:%member-type ; PODTT variable-type was result-type 
				    (mex:%variable-type (mex:%result (mex:%invokes-function agg-val)))))
			    (mex:%declares mtype) ; get some_func member-type
			    (mm-warn "Line ~A: Cannot resolve entity reference (1): ~A" (mofi:%defined-at arg) arg)))
	       (mu-type-ref agg-val :selects selects))))
	(mex:|Function| ; look for a formal parameter or local variable with that name
	 (let ((func (mex:%defining-scope (mex:%id arg))))
	   (when-bind (param (find (mex:%local-name (mex:%id arg)) 
				   (append (mex:%formal-parameters func) (mex:%variables func))
				   :key #'(lambda (x) (mex:%local-name (mex:%id x)))
				   :test #'string-equal))
	     (typecase param ; note to edbark....
	       (mex:|Parameter| (mex:%formal-parameter-type param))
	       (mex:|Variable| (mex:%variable-type param)))))))))

#| pod7
(defmethod mu-type-ref ((arg |TargetVariable|) &key)
  (or (when-bind (type (mex:%data-type arg)) (mu-type-ref type)) ; POD is any of the crap below this line necessary?
      (let ((map (mex:%defining-scope (mex:%id arg))))
	(if-bind (tvar (find (mex:%id arg) (mex:%targets map) :key #'mex:%id))
		 (mex:%variable-type tvar)
		 (error "Could not find declaration of target variable ~A in map ~A." 
			(mex:%local-name (mex:%id arg)) (mex:%local-name (mex:%id map)))))))
|#

(defmethod mu-type-ref ((arg mex:|ConstantRef|) &key)
  (if (and (typep (mex:%refers-to arg) 'mex:|Constant|)
	   (string-equal "SELF" (mex:%local-name (mex:%id (mex:%refers-to arg)))))
      (mexico-find-class (mex:%local-name (mex:%id arg)))
      (mex:%data-type arg)))

#| pod7 express-x
(defmethod mu-type-ref ((arg |ParameterRef|) &key)
  (or (when-bind (param (mex:%refers-to arg))
	(mex:%formal-parameter-type param))
      (etypecase (mex:%defining-scope (mex:%id arg))
	(mex:|MapSpec| ; POD is this crap still necessary?
	 ;(break "this crap is still necessary")
	 (let ((map (mex:%defining-scope (mex:%id arg))))
	   (loop for part in (mex:%partitions map) with param = nil
		 when (setf param (find (mex:%id arg) (mex:%sources part) :key #'mex:%id))
		 return (mex:%formal-parameter-type param)
		 finally do
		 (error "Could not find declaration of source variable ~A in map ~A." 
			(mex:%local-name (mex:%id arg)) (mex:%local-name (mex:%id map)))))))
      (mm-warn "Cannot resolve type reference of Parameter ~A" arg)))
|#

(defmethod mu-type-ref ((arg mex:|QueryExpression|) &key selects)
  (mu-type-ref (mex:%aggregate-operand arg) :selects selects))

(defmethod mu-type-ref ((arg mex:|ExtentRef|) &key)
  (if-bind (entity (p11p::lookup-referenceable (mex:%id arg)))
   (mex:%declares entity)
   (mm-warn "Could not resolve type reference of ExtentRef ~A" arg)))

(defmethod mu-type-ref ((arg mex:|EntityType|) &key)
  (mex:%declares arg))

(defmethod mu-type-ref ((arg mex:|GenericType|) &key)
  arg)

(defmethod mu-type-ref ((arg mex:|SingleEntityType|) &key)
  arg)

(defmethod mu-type-ref ((arg mex:|AggregateIndex|) &key selects)
  (mu-type-ref (mex:%base-value arg) :selects selects))

;;; NOTE: The toplevel call to mu-type-ref was probably an unresolved-entity-ref
;;; so this is the argument to that attr reference. We want to know the type of 
;;;  that attribute. We don't want to follow the link (read the function's doc line ;^)
(defmethod mu-type-ref ((arg mex:unresolved-attribute-ref) &key selects)
  "Here we want to know what type the attr ref is POINTING TO. If it is an EntityType,
   then return that type, otherwise return nil. We do NOT want to follow the link."
  (if-bind (ent (mex:%entity-instance arg))
    (when-bind (entity (mu-type-ref ent :selects selects))
      (when-bind (attr (find-attr (mex:%local-name (mex:%id entity)) (mex:%local-name arg) :source-upward t))
	(mu-type-ref (mex:%attribute-type attr) :selects selects)))
    ;; Don't call resolve-attr here! Give up!
    (mm-warn "Line ~A: Cannot resolve entity reference(3): ~A" (mofi:%defined-at arg) arg)))

(defmethod mu-type-ref ((arg mex:|AttributeRef|) &key selects)
  "Here we want to know what type the attr ref is POINTING TO. If it is an EntityType,
   then return that type, otherwise return nil. We do NOT want to follow the link."
  (when-bind (entity (mu-type-ref (mex:%entity-instance arg) :selects selects))
    ;; 2007-10-01 POD added both source-upward and source-downward
     (when-bind (attr (find-attr (mex:%local-name (mex:%id entity)) (mex:%local-name (mex:%id arg)) 
				  :source-upward t :source-downward t))
       (mu-type-ref (mex:%attribute-type attr) :selects selects))))

(defmethod mu-type-ref ((arg mex:|GeneralAggregationType|) &key selects)
  (mu-type-ref (mex:%member-type arg) :selects selects))

(defmethod mu-type-ref ((arg mex:|AggregationType|) &key selects)
  (mu-type-ref (mex:%member-type arg) :selects selects))

(defmethod mu-type-ref ((arg mex:|FunctionCall|) &key)
  (cond ((string-equal "USEDIN" (mex:%local-name (mex:%id (mex:%invokes-function arg))))
	 (when-bind (str (mu-string-literal (mex:%actual-value (second (mex:%actual-parameters arg)))))
	    (when-bind (entity/attr (cdr (split str #\.)))
	       (when-bind (attr (apply #'find-attr entity/attr))
		  (mex:%of-entity attr)))))
	(t (if-bind (r (mex:%result (mex:%invokes-function arg)))
  	     (mex:%variable-type r) ; PODTT
	     (mm-warn "Line ~A: Cannot resolve entity reference(4): ~A" (mofi:%defined-at arg) arg)))))

(defmethod mu-type-ref ((arg mex:|SpecializedType|) &key selects)
  (when (and selects (select-p arg))
    arg))
	     
(defmethod mu-type-ref ((arg t) &key)
  ;(break "mu-type-ref on T")
  (mm-warn "Line ~A: Cannot resolve type reference(5): ~A" (mofi:%defined-at arg) arg))

;;;--------------------------
;;; Try to find the string literal referenced by the argument.
(defgeneric mu-string-literal (arg))

(defmethod mu-string-literal ((arg mex:|BinaryOperation|))
  (let ((s1 (mu-string-literal (mex:%left-operand arg)))
	(s2 (mu-string-literal (mex:%right-operand arg))))
    (when (and (stringp s1) (stringp s2))
      (strcat s1 s2))))

(defmethod mu-string-literal ((arg mex:|Literal|))
  (when (typep (mex:%refers-to arg) 'mex:|StringValue|)
    (mex:%id arg)))

(defmethod mu-string-literal ((arg string))
  arg)

(defmethod mu-string-literal ((arg t))
   (mm-warn "Line ~A: Cannot resolve string literal: ~A" (mofi:%defined-at arg) arg))

;;;=======================================================================
;;; Schema validation stuff
;;;=======================================================================
(defparameter *bad-objs* (make-array  300 :fill-pointer 0 :adjustable t))
(defparameter *search-checked-p* (make-hash-table :test #'equal) "Navigate schema, but don't visit something twice.")

;;; POD See also uml-slots!
(defmemo xmi-slots (class)
  (remove-if #'mofi:slot-definition-xmi-hidden (closer-mop:class-slots class)))

(defun mm-slot-children (node)
  "NODE is a 2-element list comprised of an object and a slot in the class of that object.
   The children of NODE are node objects for each value in the slot X each slot 
   in the class of that object -- but filter out if this child has been seen before." 
  (unless (gethash node *search-checked-p*)
    (setf (gethash node *search-checked-p*) t)
    (dbind (object slot) node
       (unless (typep object 'mex:|Schema|)
	 (loop for val in (mklist (slot-value object (closer-mop:slot-definition-name slot)))
	       with tops = (mex:%schema-elements (p11p::schema-scope *scope*))
	       ;when (typep val 'unresolved-operator) do (break "unresolved!")
	       when (typep val 'mofi:mm-root-supertype)
	       append (loop for s in (xmi-slots (class-of val))
			    with child? = nil
			    unless (or (member val tops)
				       (gethash (setq child? (list val s)) *search-checked-p*))
			    collect child?))))))

(defun pp-validate-schema (schema)
  (clrhash *search-checked-p*)
  (setf (fill-pointer *bad-objs*) 0)
  (loop for obj in (mex:%schema-elements schema) do
	(loop for slot in (xmi-slots (class-of obj)) do
	      (depth-first-search (list obj slot)
				  #'(lambda (x) (declare (ignore x))  nil) ; goal-p
				  'mm-slot-children
				  :do 'pp-validate-object-slot))))

;(declaim (inline mm-listp mm-optionalp))
(defun mm-listp (slot)
  (let ((mcity (cadr (mofi:slot-definition-multiplicity slot))))
    (or (= mcity -1) (> mcity 1))))

(defun mm-optionalp (slot)
  (let ((multiplicity (mofi:slot-definition-multiplicity slot)))
    (<= (car multiplicity) 0)))

(defmemo types-allowing (type)
  (remove 'mofi:mm-root-supertype
     (cons type
	   (loop for class across (mofi:types (mofi:find-model :mexico))
		 for class-name = (class-name class)
		 when (member type (mm-subtypes-of class-name))
		 collect class-name))))

(defun mm-typep (val type)
  (or (eql val 'p11u::?) ; pod
      (and (typep val 'mex:|ConstantRef|) (string= "?" (mex:%local-name (mex:%id val))))
      (and (or (numberp val) (stringp val)) 
	   (member type (types-allowing 'mex:|Literal|)))
      (case type
	(mex:|Identifier| (stringp val))
	(ptypes:|String| (string-const-p val)) ; PODTT
	(mex:|ExpressText| (stringp val))
	(mex:|OrderingKind| (member val '("unordered" "ordered" "indexed") :test #'equal))
	(mex:|BinaryOperator| 
	 (and (typep val 'mex:|BinaryOperator|)
	      (member (mex:%local-name (mex:%id val))
		      (mofi:enum-values (find-class 'mex:|BinaryOperator|)))))
	(mex:|UnaryOperator| 
	 (and (typep val 'mex:|UnaryOperator|)
	      (member (mex:%local-name (mex:%id val))
		      (mofi:enum-values (find-class 'mex:|UnaryOperator|)))))
	(ptypes:|Boolean| (or (eql val :true) (eql val :false)))
	(mex:|Keyword| (keywordp val))
	(ptypes:|Integer| (integerp val)) 
;2012	(ptypes:|Number| (numberp val)) POD FIX THIS!
	(ptypes:|Real| (realp val))
	(otherwise (typep val type)))))

(defun pp-validate-object-slot (node)
    (dbind (object slot) node
     (let* ((slot-name (closer-mop:slot-definition-name slot))
	    (val (slot-value object slot-name)))
       (if (null val) 
	   t ; pod for now we don't bother with things not specified
;	   (when-bind (mcity (slot-definition-multiplicity slot))
;	     (when (and (numberp (car mcity)) (= 1 (car mcity)))
;	       (format t "~%~D: Object ~A, mandatory slot ~A.~A : Value not specified."
;		       (fill-pointer *bad-objs*) object (slot-definition-source slot) slot-name)
;	       (vector-push-extend node *bad-objs*)))
	 (progn ; else
	   (when (and (mm-listp slot) (atom val))
	     (format t "~%~D: Object ~A, slot ~A.~A fails to be an aggregate. (value is ~A)"
		     (fill-pointer *bad-objs*) object (mofi:slot-definition-source slot) slot-name val)
	     (vector-push-extend node *bad-objs*))
	   (when (atom val)
	     (unless (mm-typep val (mofi:slot-definition-range slot))
	       (format t "~%~D: Object ~A, slot ~A.~A value ~A is not a ~A"
		       (fill-pointer *bad-objs*) object (mofi:slot-definition-source slot) slot-name val
		       (mofi:slot-definition-range slot))
	       (vector-push-extend node *bad-objs*))))))))
	   

