
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

(declaim (inline select-p enumeration-p))
(defun select-p (arg)
  (and (typep arg '|SpecializedType|)
       (typep (%underlying-type arg) '|SelectType|)))

(defun enumeration-p (arg)
  (and (typep arg '|SpecializedType|)
       (typep (%underlying-type arg) '|EnumerationType|)))

;;;=======================================================================
;;; Object printing
;;;=======================================================================
;;; Sometimes names are not given (|SelectType| that is the underlying type
;;; of a |SpecializedType|). Thus this can be a pass-through.
(defmethod print-object ((obj |NamedElement|) stream)
  (if (and (%id obj) (slot-exists-p (%id obj) '|localName|))
    (format stream "|~A ~A|" (class-name (class-of obj)) (%local-name (%id obj)))
    (call-next-method)))

(defmethod print-object ((obj |SingleEntityType|) stream)
  (if-bind (id (%id obj))
    (format stream "|~A ~A|" (class-name (class-of obj)) (%local-name id))
    (call-next-method)))

(defmethod print-object ((obj |VariableRef|) stream)
  (if-bind (id (%id obj))
    (format stream "|~A ~A|" (class-name (class-of obj)) (%local-name id))
    (call-next-method)))

(defmethod print-object ((obj |ScopedId|) stream)
  (format stream "|ID ~A|" (%local-name obj)))

(defmethod print-object ((obj |BinaryOperator|) stream)
  (format stream "|BinaryOperator ~A|" (%local-name (%id obj))))

(defmethod print-object ((obj mofi:mm-root-supertype) stream)
  (if-bind (name (or (and (slot-exists-p obj '|local-name|) (%local-name obj))
		       (and (slot-exists-p obj '|name|) (%name obj))
		       (and (slot-exists-p obj '|id|) (%id obj))))
    (format stream "|~A ~A|" (string (class-name (class-of obj))) name)
    (format stream "|~A|" (string (class-name (class-of obj))))))

(defun mm-find-class (name &key (schema (p11p::schema-scope *scope*)) error-p)
  "Find a NamedType in the current population with name NAME."
  (let ((name (string name)))
    (or 
     (loop for c in (%schema-elements schema)
	   when (and (typep c '|NamedType|)
		     (string-equal name (%local-name (%id c))))
	   return c)
     (when error-p (error "No class named ~A." name)))))

#|
(defun mm-find-class (name &key (schema (p11p::schema-scope *scope*)) error-p)
  "Find a NamedType in the current population with name NAME."
  (let ((name (string name)))
    (or 
     (loop for c across (mofi:members (find-class '|NamedType|)) ; pod mistake!
	   when (and (string-equal name (%local-name (%id c)))
		     (eql (%defining-scope (%id c)) schema))
	   return c)
     (when error-p (error "No class named ~A." name)))))
|#

(defun mm-find-whatever (name &key scope-p)
  (loop for s in (%schema-elements (p11p::schema-scope *scope*))
	when (and (string-equal (%local-name (%id s)) (string name))
		  (or (not scope-p) (typep s '|Scope|)))
	return s))

(defun mm-class-precedence-list (name)
  "Like clos:class-precedence-list, but for mm NamedTypes -- and not ordered ;^).
   NAME can be a string, symbol or EntityType.
   String NAME just has to be string-equal (like all EXPRESS names). Result includes NAME class
   and may contain SpecializedTypes and EntityTypes."
  (let ((class (if (or (symbolp name) (stringp name)) (mm-find-class name :error-p t) name))
	accum)
    (labels ((mm-cs-aux (classes)
		(cond ((null classes) nil)
		      ((atom classes) 
		       (let ((new
			      (cond ((and (typep classes '|SpecializedType|)
					  (typep (%underlying-type classes) '|SelectType|))
				     (%select-list (%underlying-type classes)))
				    ((typep classes '|EntityType|) (%subtype-of classes))
				    (t nil)))) ; it's a primitive type, ignore it?
			 (setf accum (append accum new))
			 (mapcar #'mm-cs-aux new)))
		      (t (mm-cs-aux (car classes))
			 (mm-cs-aux (cdr classes))))))
      (mm-cs-aux class)
      (remove-duplicates (cons class accum)))))

#| pod7 moved to mexico.lisp
(eval-when (:compile-toplevel :load-toplevel :execute)
;;; All unresolved-operators are binary. 
(defclass unresolved-operator (mofi:mm-root-supertype)
  ((enum-symbol :reader enum-symbol :initarg :enum-symbol :source mofi:mm-root-supertype 
		:multiplicity (1 1) :RANGE |String| :initform nil))
  (:metaclass mofi::mm-type-mo))
  (setf (uml-package (find-class 'unresolved-operator)) '|Errors|)
)
|#


(defmethod print-object ((obj unresolved-operator) stream)
  (with-slots (|enum-symbol|) obj
     (format stream "|unresolved-operator ~A|" |enum-symbol|)))

(defmethod print-object ((obj unresolved-attribute-ref) stream)
  (format stream "|unresolved-attribute-ref ~A|" (%local-name obj)))


;;; Referenceables - not all NamedElements are referenceable (examples: subtype constraints, rules).
#| PODTT
(defmethod initialize-instance :after ((obj |NamedType|) &key)
  (when (or (typep obj '|EntityType|)
	    (typep obj '|SpecializedType|)) ; don't want SelectType, or EnumerationType
    ;; POD Not thread safe!
    (vector-push-extend obj (mofi:members (find-class '|NamedType|))))) ; pod mistake
|#

#| PODTT
(defmethod initialize-instance :after ((obj |Function|) &key)
  (unless (or (typep obj '|BinaryOperator|)
	      (typep obj '|UnaryOperator|))
    ;; POD Not thread safe!
    (vector-push-extend obj (mofi:members (find-class '|Function|)))))
|#

;;; See express/expcore/expresso.lisp for how these work.
;;; Collect instances of these for subsequent resolution in pp-resolve-referencers
(defmethod initialize-instance :after ((obj |GroupRef|) &key)
  (vector-push-extend obj (pp-group-refs (expo:pp-record expo:*expresso*))))

(defmethod initialize-instance :after ((obj |EnumItemRef|) &key)
  (vector-push-extend obj (pp-enum-item-refs (expo:pp-record expo:*expresso*))))

(defmethod initialize-instance :after ((obj |SelectType|) &key)
  (vector-push-extend obj (pp-select-types (expo:pp-record expo:*expresso*))))

;;; Collect instances of these for subsequent resolution in pp-resolve-operators
(defmethod initialize-instance :after ((obj |BinaryOperation|) &key)
  (vector-push-extend obj (pp-binary-operations (expo:pp-record expo:*expresso*))))

;;;===================================================================================
;;; Schema 'completion' stuff - resolve references an patch up shortcomings in what 
;;; was gathered during parsing. 
;;;===================================================================================
(defmethod pp-schema ((schema |Schema|) &key lisp-gen)
  "Toplevel function to post-process a schema. Order of execution is important!
   If target output is LISP-GEN = T, then post-processing is less intensive."
  ;; Resolve named elements (replace ScopedId with object)...
  ;; Finalize EntityTypes...
  (VARS lisp-gen)
  (loop for obj in (%schema-elements schema)
	when (typep obj '|EntityType|) do (pp-finalize-EntityType obj))
  ;; Resolve referencers (|GroupRef|, |EnumItemRef|, |SelectType|)...
  (pp-resolve-referencers) ; POD Can I eliminate this (done in parser2 ?)
  ;; Resolve redeclared and inverse attributes...
  (loop for obj in (%schema-elements schema) 
	when (typep obj '|EntityType|) do (pp-fix-EntityType.redeclarations obj))
  (loop for obj in (%schema-elements schema) ; must be done after fixing redeclarations.
	when (typep obj '|EntityType|) do
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
    (if-bind (ref (%refers-to obj))
      (cond ((typep ref '|SingleEntityType|)) ; in which case already resolved.
	    ((typep ref '|EntityType|) ; just not Single
	     (setf (%refers-to obj) (%declares ref)))
#| pod7
	    ((and p14p:*source-schema*
		  (setf class (mm-find-class ref :schema (schema-mm p14p::*source-schema*))))
	     (setf (%refers-to obj) (%declares class)))
	    ((and p14p:*target-schema*
		  (setf class  (mm-find-class ref :schema (schema-mm p14p::*target-schema*))))
	     (setf (%refers-to obj) (%declares class)))
|#
	    (t (error "Cannot find class ~A" ref)))
      (when-bind (id (%id obj))
	(setf (%refers-to obj)
	      (%declares (p11p::lookup-referenceable (%id obj))))))))

(defun pp-resolve-EnumItemRef (obj)
  "Determine obj.refers-to, which is an |EnumItemRef|."
  (flet ((find-it (item-name decl) ; find ITEM-NAME (a string) in the enum list.
	   (and (typep (%underlying-type decl) '|EnumerationType|)
		(find item-name (%values (%underlying-type decl)) 
		      :key #'(lambda (x) (%local-name (%id x))) :test #'string-equal))))
    (unless (%refers-to obj) ; in which case it was already visited...
      (let ((item-name (%local-name (%id obj))) enum-type enum-item)
	(if (%data-type obj) ; type was specified in parse...
	    (progn (setf enum-type (mm-find-class (%local-name (%id (%data-type obj))) :error-p t))
		     (setf enum-item (find-it item-name enum-type)))
	    ;; type was not specified in parse, search for it...
	    (let ((enums (loop for decl in (remove-if (complement #'enumeration-p) 
						      (%schema-elements (p11p::schema-scope *scope*)))
			       when (find-it item-name decl)
			       collect decl)))
	      (unless (single-p enums) (mm-warn "Line ~A: Ambiguous use of enumeration id ~A" 
						(mofi:%defined-at obj) item-name))
	      (setf enum-type (car enums))
	      (setf enum-item (find-it item-name (car enums)))))
	(unless enum-item (error "Enumeration type ~A does not have an item ~A" enum-type item-name))
	;; scope of id was nil (and it was a SchemaScopedId).
	(setf (%id obj) (p11p::make-scoped-id item-name :force-scope enum-type))
	(setf (%refers-to obj) enum-item)
	(setf (%data-type obj) enum-type))))
  (values))

(defun pp-resolve-SelectType-base (obj)
  "Earlier it was resolved from a ScopedId, but what is required is the underlying type of that."
  (when-bind (base (%base obj))
    (when (and (typep base '|SpecializedType|)
	       (select-p base))
      (setf (%base obj) (%underlying-type base)))))

(defvar *current-node* nil "diagnostics")

(defparameter *show-me-the-slots*  nil)

;;;(|Function| |BinaryOperator| |UnaryOperator| |ParameterType| |GeneralSETType| |ARRAYType| 
;;; |BAGType| |SETType| |AggregationType| |ConcreteType| |GenericType| |EntityType| |LISTType| 
;;; |NumericType| |NamedType| |SelectType| |DefinedType| |GeneralizedType| |LogicType| 
;;; |BooleanType| |Integer| |EnumerationType| |StringType| |SimpleType| |AGGREGATEType| 
;;; |BinaryType| |GeneralAggregationType| |GeneralARRAYType| |RealType| |AnonymousType| 
;;; |SpecializedType| |GeneralBAGType| |InstantiableType| |GeneralLISTType|)
(let ((+subtypes+ 
       (remove-duplicates
	(append (mm-subtypes-of '|NamedType| :self t)
		(mm-subtypes-of '|Function| :self t)
		(mm-subtypes-of '|ParameterType| :self t)))))
  (defun pp-replace-with-named-type (node)
    (setf *current-node* node)
    (dbind (object slot) node
      (when (and slot (member (mofi:slot-definition-range slot) +subtypes+))
	(let* ((slot-name (closer-mop:slot-definition-name slot))
	       (vals (slot-value object slot-name)))
	  (pushnew slot *show-me-the-slots*)
	  (when vals
	    (cond ((typep vals '|ScopedId|)
		   (let ((obj (p11p::lookup-referenceable vals)))
		     (setf (slot-value object slot-name) obj)
		     #|(setf (%identifies vals) obj)|# obj)) ;  POD 2006-07-31 OK?
		  ((listp vals)
		   (setf (slot-value object slot-name)
			 (loop for v in vals
			       if (typep v '|ScopedId|)
			       ;collect (setf (%identifies v) (lookup-referenceable v)) 
			       collect (p11p::lookup-referenceable v) ; POD 2006-07-31 OK?
			       else collect v)))))))))
)

(defmethod pp-fix-Attribute.id ((obj |EntityType|))
  (loop for attr in (remove-if (complement #'(lambda (x) (typep x 'unresolved-attribute)))
			       (%declares (%declares obj))) ; obj->SingleEntityType.declares
	for id = (%id attr)
	unless (eql (%defining-scope id) obj) do
	(mm-warn "Line ~A: Ill-formed attr id: ~A" (mofi:%defined-at obj) attr)
	(setf (%id attr) 
	      (or 
	       (gethash (cons (p11uintern (%local-name id)) obj) p11p::*scoped-ids*)
	       (error "ScopedId does not exist: ~A ~A" id obj)))))

;;; '\GROUP' always refers to the defining entity
;;; For example in Rule_software_definition
;;;    SELF\Product_view_definition.defined_version : Rule_version;
(defun pp-fix-EntityType.redeclarations (entity) ; ((entity |EntityType|))
  "Resolve unresolved-attribute objects in EntityType.redeclarations"
  ;; The defmemo keeps the following from being too wasteful. Also you can't 
  ;; call this multiply as it stands %where-found is an Entity second time in.
  (loop for super in (%subtype-of entity) do (pp-fix-EntityType.redeclarations super))
  (loop for r in (%redeclarations entity) 
	for unres = (%original-attribute r) ; unres is a unresolved-attribute
	when (typep unres 'unresolved-attribute) do 
	;; ...For example, here defining-entity refers to the 'group' which
	;; might not be the defining entity, yet that is where find-attr looks. 
	;; 2006-04-05 HUH? That comment makes no sense WRT the the "always" above.
	(setf (%original-attribute r)
	      (find-attr (%local-name (%id (%where-found unres)))
			 (%attribute-name unres) :source-upward t))))
		

(defmethod pp-fix-EntityType-inverses ((obj |EntityType|))
  (loop for iattr in (%attributes obj) ; unres may be an unresolved-attribute
	if (typep iattr '|InverseAttribute|) 
	when (typep (%explicit iattr) 'unresolved-attribute) do
	(let* ((unres (%explicit iattr))
	       (where-found (%where-found unres))
	       (attr-name (%local-name (%attribute-name unres))))
	  (setf (%explicit iattr) 
		(find-attr (%local-name (%id where-found)) attr-name :source-upward t)))))

(defmethod pp-finalize-EntityType ((obj |EntityType|))
  "Copy attributes from SingleEntityType objects into the EntityType OBJ."
  (setf (%attributes obj)
	(loop for class in (mm-class-precedence-list obj)
	      append (%declares (%declares class)))))

;;;=====================================================================
;;; Resolve attribute reference
;;;=====================================================================
(defun pp-resolve-attribute-refs ()
  "Replace an unresolved-attribute-ref with an AttributeRef. (BTW, the 
   thing unresolved is the refers-to slot. It needs to point to an Attribute.)
   The vector *u-a-r* gets populated by setf methods defined in emm.lisp"
  (loop for (object . slot-name) across *unresolved-attribute-refs*
	for vals = (slot-value object slot-name)
	when vals do
	(cond ((typep vals 'unresolved-attribute-ref)
	       (let ((new-val (resolve-attr vals)))
		 (setf (slot-value object slot-name) new-val)))
	      ((listp vals)
	       (setf (slot-value object slot-name)
		     (loop for v in vals
			   if (typep v 'unresolved-attribute-ref)
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
(defmethod resolve-attr ((exp unresolved-attribute-ref))
  "Resolve the argument to an entity attribute. Returns an AttributeRef."
  (setf *zippy* exp)
  (let ((*scope* (%%scope exp)))
    (if-bind (ent (mu-type-ref (%entity-instance exp))) ; find the EntityType this FullExpression refers to.
      (if-bind (attr (find-attr (%local-name (%id ent)) (%local-name exp) 
				:source-upward t :source-downward t :error-p nil))
	       (make-instance 
		'|AttributeRef| ; mk-instance here won't help.
		:id (%id attr) 
		:refers-to attr ; <=== THIS is the goal of all this work. 
		:entity-instance (pp-walk-expression (%entity-instance exp))) ; <=== THIS is the problem.
	       (error 'pprocess-error 
		      :line-number (mofi:%defined-at exp)
		      :text (format nil "Entity ~A does not have an attribute ~A." 
				    (%local-name (%id ent)) (%local-name exp))))
      (mm-warn "Could not determine entity type making attribute reference: ~A.~A" 
	       (%entity-instance exp) (%local-name exp)))))

;;; POD I'm confused regarding how the above can return an AttributeRef.
;;; If this did that, it would loop in pp-walk-expression.
(defmethod resolve-attr ((exp |AttributeRef|))
  (%entity-instance exp))

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
	 (when (typep (slot-value exp slot) 'unresolved-attribute-ref)
	   (setf (slot-value exp slot) (funcall do-func exp)))
	 (pp-walk-expression (slot-value exp slot) :do-func do-func)))
 exp)

;;;========================================
;;; Resolve operators
;;;========================================
(defun pp-resolve-operators ()
  "Transform an |unresolved-operator whatever| to a |BinaryOperator|."
  (loop for operation across (pp-binary-operations (expo:pp-record expo:*expresso*)) 
	when (typep (%operator operation) 'unresolved-operator) do
	(pp-resolve-operators-aux operation)))

(defun pp-resolve-operators-aux (operation)
  "Broken out from above for easier debugging."
  (let* ((generic-op (kintern (%enum-symbol (%operator operation))))
	 (l (expr-type (%left-operand operation)))
	 (r (expr-type (%right-operand operation)))
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
;    (when (and (typep l '|Literal|) (typep r '|Literal|)) ; POD -- something like this.
;      (format t "optimization opportunity: ~A ~A" l r))
    (setf op-symbol
	  (cond ((single-p types)
		 (operator-choose-single generic-op (car types)))
		((cdr types)
		 (when (intersection types '(:aggregate :set :bag :list))
		   (operator-choose-aggregate generic-op (first types) (second types))))))
    (unless op-symbol (alert-message "Line ~a: Cannot determine operator for ~A ~A" 
			       (mofi:%defined-at operation) generic-op types))
    (setf (%operator operation)
	  (make-instance 
	   '|BinaryOperator| 
	   :id (if op-symbol 
		   (p11p::make-scoped-id  op-symbol)
		   (make-instance 
		    '|ScopedId| 
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

(defmethod expr-type ((expr |Literal|))
  (typecase (%refers-to expr)
    (|LogicalValue| :logical)
    (|StringValue| :string)
    (t :number)))

(defmethod expr-type ((expr |AttributeRef|))
  (expr-type (%attribute-type (%refers-to expr)))) 

(defmethod expr-type ((expr |AggregateInitializer|))
  :aggregate)

(defmethod expr-type ((expr |FunctionCall|))
  (let ((fn (%invokes-function expr)))
    (typecase fn
      ((or |UnaryOperator| |BinaryOperator|)
       (case (kintern (second (split (%local-name (%id fn)) #\:)))
	 ((:stringappend :format) :string)
	 ((:sizeof :typeof :abs :acos :asin :atan :blength :cos :exp :hibound :hiindex :length 
		   :lobound :log :log2 :log10 :loindex :sin :sqrt :tan :value :value_in :value_unique) :number)
	 ((:typeof :rolesof) :set)
	 (:exists :boolean)
	 ((:odd :value_in :value_unique) :logical)
	 (otherwise 
	  (mm-warn "Line ~A: Don't know this function ~A" 
		   (mofi:%defined-at expr) (%invokes-function expr))
	  nil)))
      (|Function| ; PODsampson comments
       (cond ;((%actual-types (%result fn)) ; POD bogus! PODTT actual-types
	     ; (expr-type (%refers-to (%actual-types (%result fn)))))
	     ((%variable-type (%result fn)) ; PODTT
	      (expr-type (%variable-type (%result fn))))))))) ; PODTT

;;; A new method for 2006-04-28 !?!? RESOLVED effective method.
;;; But note that these appear to be needed even before April.
;;; 2006-05-05 I see an example running AP203 where calling resolve-op
;;; (on an unresolved-operator, of course) ends up here. 
(defmethod expr-type ((expr |BinaryOperation|))
  (unless (typep (%operator expr) 'unresolved-operator) ; just getting weirder...
    (let ((fn (kintern (second (split (%local-name (%id (%operator expr))) #\:)))))
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
  (when-bind (id (%id expr))
    (when (typep (%defining-scope id) '|Schema|)
      (expr-type (mm-find-class (p11uintern (%local-name id)))))))

(defmethod expr-type ((expr |SpecializedType|))
  (let ((types (underlying-types expr)))
    (cond ((every #'(lambda (x) (typep x '|NumericType|)) types) :number)
	  ((every #'(lambda (x) (typep x '|EntityType|)) types) :entity)
	  ((every #'(lambda (x) (typep x '|StringType|)) types) :string)
	  ((every #'(lambda (x) (typep x '|EnumerationType|)) types) :enum)
	  (t :any))))

(defmethod expr-type ((expr |AggregateIndex|))
  (expr-type (%base-value expr)))

(defmethod expr-type ((arg t)) 
  (typecase arg
    (|StringType| :string)
    (|EntityType| :entity)
    (|BooleanType| :boolean)
    (|LogicType| :logical)
    (ptypes:|Integer| :number) 
    (|EnumItemRef| :enum)
    (|GroupRef| :entity)
    (|RealType| :number)
    (|NumericType| :number)
    (|ARRAYType| :array)
    (|BAGType| :bag)
    (|LISTType| :list)
    (|SETType| :set)
    (|GeneralARRAYType| :array)
    (|GeneralBAGType| :bag)
    (|GeneralLISTType| :list)
    (|GeneralSETType| :set)
    (|BinaryType| :binary)
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
      (make-instance '|Attribute| 
		     :of-entity (%declares (mm-find-class "GENERIC_ENTITY"))
		     :id (p11p::make-scoped-id attr-name :scope (p11p::schema-scope *scope*))
		     :attribute-type (mm-find-class "GENERIC"))))
  (let* ((eclasses (if source-upward 
		       (mm-class-precedence-list type-name)
		     (list (mm-find-class type-name :schema schema :error-p t))))
	 ;; POD This next part is "cold hacked" 2007-10-01
	 (eclasses (if source-downward
		       (let ((type-obj (mm-find-class type-name :error-p t)))
			 (remove-duplicates 
			  (append eclasses
				  (loop for elem in (remove-if 
						     (complement #'(lambda (x) (typep x '|EntityType|)))
						     (%schema-elements schema))
				      when (member type-obj (mm-class-precedence-list elem))
				      collect elem))))
		       eclasses))
	 ;; POD Currently not warning on duplicate names.
	 (base-classes (remove-if #'(lambda (x) (not (typep x '|EntityType|)))
				  (mapappend #'underlying-types eclasses))))
    (loop for eclass in base-classes 
	  for ename = (%local-name (%id eclass)) do
	  (loop for attr in (%attributes eclass)
		when (and (not (typep attr 'unresolved-attribute)) ; 2006-03-14
			  (not (typep (%id (%of-entity attr)) 'unresolved-attribute)) ; 2006-03-14
			  (string-equal attr-name (%local-name (%id attr)))
			  (string-equal ename (%local-name (%id (%of-entity attr)))))
		do (return-from find-attr attr))
	  ;; POD 2006-01-20 - should I return the ExplicitAttribute or the Redeclaration?
	  (loop for redecl in (%redeclarations eclass)
		for add-name = (%alias redecl)
		when (or (and add-name
			      (not (typep add-name 'unresolved-attribute)) ; 2006-03-14
			      (not (typep (%id (%scope redecl)) 'unresolved-attribute)) ; 2006-03-14
			      (string-equal attr-name (%local-name add-name)))
			 (and (string-equal ename (%local-name (%id (%scope redecl))))
			      (string-equal attr-name (%local-name (%id (%original-attribute redecl))))))
		do (return-from find-attr (%original-attribute redecl)))
	  finally (when error-p (error "Entity ~A does not have attribute '~A'."  
				       type-name attr-name)))))

;;; POD better than remove-duplicates might be a type-equal function.
;;; (underlying-types (mm-find-whatever 'measure_value :scope-p t))
(defvar *utypes-collected* nil)
(defun underlying-types (obj)
  "Return all the types underlying the argument select."
  (unless (typep obj '|SpecializedType|) (return-from underlying-types (list obj)))
  (setf *utypes-collected* nil)
  (underlying-types-aux (%underlying-type obj))
  (remove-duplicates *utypes-collected*)) ; better wo

(defun underlying-types-aux (obj)
  (cond ((typep obj '|SpecializedType|)
	 (underlying-types-aux (%underlying-type obj)))
	((typep obj '|AggregationType|)
	 (underlying-types-aux (%member-type obj)))
	((not (typep obj '|SelectType|))
	 (push obj *utypes-collected*))
	((typep obj '|SelectType|)
	 (mapcar #'underlying-types-aux (%select-list obj)))))

;;;------------------------------------------------------------------------------------
;;; ---------- mu-X utility functions: navigate the MM objects to find or compose an X. 
;;;------------------------------------------------------------------------------------
;;; Identify the type (NamedType, SimpleType) to which the argument Expression refers.
;;; Typically this requires navigation of the expression "right to left" back to a 
;;; VariableRef etc., for which the type has been identified. 
;;; It returns a SingleEntityType when successful. 
(defgeneric mu-type-ref (arg &key &allow-other-keys))

(defmethod mu-type-ref ((arg |GroupRef|) &key) 
  (%refers-to arg))

(defmethod mu-type-ref ((arg |VariableRef|) &key selects)
  (or (when-bind (type (%data-type arg)) (mu-type-ref type)) ; POD Goal is to make this like ConstantRef. 
      (etypecase (%defining-scope (%id arg))
	(|QueryExpression| ; find the member type 
	 (let ((agg-val (%aggregate-operand (%defining-scope (%id arg))))) ; QUERY(var <* some_func() | ...)
	   (if (typep agg-val '|FunctionCall|) ; then DON'T go through mu-entity-ref. Get some_func member-type...
	       (if (string-equal "USEDIN" (%local-name (%id (%invokes-function agg-val)))) ;; ...UNLESS...
		   (when-bind (str (mu-string-literal (%actual-value (second (%actual-parameters agg-val)))))
		     (when-bind (entity/attr (cdr (split str #\.)))
		       (when-bind (attr (apply #'find-attr entity/attr))
			 (%of-entity attr))))
		   (if-bind (mtype (%member-type ; PODTT variable-type was result-type 
				    (%variable-type (%result (%invokes-function agg-val)))))
			    (%declares mtype) ; get some_func member-type
			    (mm-warn "Line ~A: Cannot resolve entity reference (1): ~A" (mofi:%defined-at arg) arg)))
	       (mu-type-ref agg-val :selects selects))))
	(|Function| ; look for a formal parameter or local variable with that name
	 (let ((func (%defining-scope (%id arg))))
	   (when-bind (param (find (%local-name (%id arg)) 
				   (append (%formal-parameters func) (%variables func))
				   :key #'(lambda (x) (%local-name (%id x)))
				   :test #'string-equal))
	     (typecase param ; note to edbark....
	       (|Parameter| (%formal-parameter-type param))
	       (|Variable| (%variable-type param)))))))))

#| pod7
(defmethod mu-type-ref ((arg |TargetVariable|) &key)
  (or (when-bind (type (%data-type arg)) (mu-type-ref type)) ; POD is any of the crap below this line necessary?
      (let ((map (%defining-scope (%id arg))))
	(if-bind (tvar (find (%id arg) (%targets map) :key #'%id))
		 (%variable-type tvar)
		 (error "Could not find declaration of target variable ~A in map ~A." 
			(%local-name (%id arg)) (%local-name (%id map)))))))
|#

(defmethod mu-type-ref ((arg |ConstantRef|) &key)
  (if (and (typep (%refers-to arg) '|Constant|)
	   (string-equal "SELF" (%local-name (%id (%refers-to arg)))))
      (mm-find-class (%local-name (%id arg)))
      (%data-type arg)))

#| pod7 express-x
(defmethod mu-type-ref ((arg |ParameterRef|) &key)
  (or (when-bind (param (%refers-to arg))
	(%formal-parameter-type param))
      (etypecase (%defining-scope (%id arg))
	(|MapSpec| ; POD is this crap still necessary?
	 ;(break "this crap is still necessary")
	 (let ((map (%defining-scope (%id arg))))
	   (loop for part in (%partitions map) with param = nil
		 when (setf param (find (%id arg) (%sources part) :key #'%id))
		 return (%formal-parameter-type param)
		 finally do
		 (error "Could not find declaration of source variable ~A in map ~A." 
			(%local-name (%id arg)) (%local-name (%id map)))))))
      (mm-warn "Cannot resolve type reference of Parameter ~A" arg)))
|#

(defmethod mu-type-ref ((arg |QueryExpression|) &key selects)
  (mu-type-ref (%aggregate-operand arg) :selects selects))

(defmethod mu-type-ref ((arg |ExtentRef|) &key)
  (if-bind (entity (p11p::lookup-referenceable (%id arg)))
   (%declares entity)
   (mm-warn "Could not resolve type reference of ExtentRef ~A" arg)))

(defmethod mu-type-ref ((arg |EntityType|) &key)
  (%declares arg))

(defmethod mu-type-ref ((arg |GenericType|) &key)
  arg)

(defmethod mu-type-ref ((arg |SingleEntityType|) &key)
  arg)

(defmethod mu-type-ref ((arg |AggregateIndex|) &key selects)
  (mu-type-ref (%base-value arg) :selects selects))

;;; NOTE: The toplevel call to mu-type-ref was probably an unresolved-entity-ref
;;; so this is the argument to that attr reference. We want to know the type of 
;;;  that attribute. We don't want to follow the link (read the function's doc line ;^)
(defmethod mu-type-ref ((arg unresolved-attribute-ref) &key selects)
  "Here we want to know what type the attr ref is POINTING TO. If it is an EntityType,
   then return that type, otherwise return nil. We do NOT want to follow the link."
  (if-bind (ent (%entity-instance arg))
    (when-bind (entity (mu-type-ref ent :selects selects))
      (when-bind (attr (find-attr (%local-name (%id entity)) (%local-name arg) :source-upward t))
	(mu-type-ref (%attribute-type attr) :selects selects)))
    ;; Don't call resolve-attr here! Give up!
    (mm-warn "Line ~A: Cannot resolve entity reference(3): ~A" (mofi:%defined-at arg) arg)))

(defmethod mu-type-ref ((arg |AttributeRef|) &key selects)
  "Here we want to know what type the attr ref is POINTING TO. If it is an EntityType,
   then return that type, otherwise return nil. We do NOT want to follow the link."
  (when-bind (entity (mu-type-ref (%entity-instance arg) :selects selects))
    ;; 2007-10-01 POD added both source-upward and source-downward
     (when-bind (attr (find-attr (%local-name (%id entity)) (%local-name (%id arg)) 
				  :source-upward t :source-downward t))
       (mu-type-ref (%attribute-type attr) :selects selects))))

(defmethod mu-type-ref ((arg |GeneralAggregationType|) &key selects)
  (mu-type-ref (%member-type arg) :selects selects))

(defmethod mu-type-ref ((arg |AggregationType|) &key selects)
  (mu-type-ref (%member-type arg) :selects selects))

(defmethod mu-type-ref ((arg |FunctionCall|) &key)
  (cond ((string-equal "USEDIN" (%local-name (%id (%invokes-function arg))))
	 (when-bind (str (mu-string-literal (%actual-value (second (%actual-parameters arg)))))
	    (when-bind (entity/attr (cdr (split str #\.)))
	       (when-bind (attr (apply #'find-attr entity/attr))
		  (%of-entity attr)))))
	(t (if-bind (r (%result (%invokes-function arg)))
  	     (%variable-type r) ; PODTT
	     (mm-warn "Line ~A: Cannot resolve entity reference(4): ~A" (mofi:%defined-at arg) arg)))))

(defmethod mu-type-ref ((arg |SpecializedType|) &key selects)
  (when (and selects (select-p arg))
    arg))
	     
(defmethod mu-type-ref ((arg t) &key)
  ;(break "mu-type-ref on T")
  (mm-warn "Line ~A: Cannot resolve type reference(5): ~A" (mofi:%defined-at arg) arg))

;;;--------------------------
;;; Try to find the string literal referenced by the argument.
(defgeneric mu-string-literal (arg))

(defmethod mu-string-literal ((arg |BinaryOperation|))
  (let ((s1 (mu-string-literal (%left-operand arg)))
	(s2 (mu-string-literal (%right-operand arg))))
    (when (and (stringp s1) (stringp s2))
      (strcat s1 s2))))

(defmethod mu-string-literal ((arg |Literal|))
  (when (typep (%refers-to arg) '|StringValue|)
    (%id arg)))

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
       (unless (typep object '|Schema|)
	 (loop for val in (mklist (slot-value object (closer-mop:slot-definition-name slot)))
	       with tops = (%schema-elements (p11p::schema-scope *scope*))
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
  (loop for obj in (%schema-elements schema) do
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
      (and (typep val '|ConstantRef|) (string= "?" (%local-name (%id val))))
      (and (or (numberp val) (stringp val)) 
	   (member type (types-allowing '|Literal|)))
      (case type
	(|Identifier| (stringp val))
	(|String| (string-const-p val)) ; PODTT
	(|ExpressText| (stringp val))
	(|OrderingKind| (member val '("unordered" "ordered" "indexed") :test #'equal))
	(|BinaryOperator| 
	 (and (typep val '|BinaryOperator|)
	      (member (%local-name (%id val))
		      (mofi:enum-values (find-class '|BinaryOperator|)) :test #'string-equal)))
	(|UnaryOperator| 
	 (and (typep val '|UnaryOperator|)
	      (member (%local-name (%id val))
		      (mofi:enum-values (find-class '|UnaryOperator|)) :test #'string-equal)))
	(|Boolean| (or (eql val :true) (eql val :false)))
	(|Keyword| (keywordp val))
	(ptypes:|Integer| (integerp val)) 
	(|Number| (numberp val))
	(|Real| (realp val))
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
	   

