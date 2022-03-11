;;; Automatically created by pop-gen at 2010-10-17 12:03:51.

(in-package :cmof)



(def-mm-enum |ParameterDirectionKind| :CMOF NIL 
   (|in| |inout| |out| |return|)
   "Parameter direction kind is an enumeration type that defines literals used
    to specify direction of parameters.")



(def-mm-enum |VisibilityKind| :CMOF NIL 
   (|public| |private| |protected| |package|)
   "VisibilityKind is an enumeration type that defines literals to determine
    the visibility of elements in a model.")



;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-mm-class |Association| (:CMOF) (|Classifier| |Relationship|)
 "An association describes a set of tuples whose values refer to typed instances.
  An instance of an association is called a link.A link is a tuple with one
  value for each end of the association, where each value is an instance
  of the type of the end."
  ((|endType| :range |Type| :multiplicity (1 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "References the classifiers that are used as types of the ends of the association.")
   (|isDerived| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the association is derived from other model elements
      such as other associations or constraints.")
   (|memberEnd| :range |Property| :multiplicity (2 -1) :is-ordered-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Property| |association|)
    :documentation
     "Each end represents participation of instances of the classifier connected
      to the end in links of the association.")
   (|navigableOwnedEnd| :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|Association| |ownedEnd|))
    :documentation
     "The navigable ends that are owned by the association itself.")
   (|ownedEnd| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Association| |memberEnd|) (|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Property| |owningAssociation|)
    :documentation
     "The ends that are owned by the association itself.")))


(def-mm-constraint "association_ends" |Association|
   "Association ends of associations with more than two ends must be owned
    by the association."
    :operation-status :rewritten
    :editor-note "should be implies"
    :original-body
    "if memberEnd->size() > 2 then ownedEnd->includesAll(memberEnd)"
    :operation-body
   "memberEnd->size() > 2 implies ownedEnd->includesAll(memberEnd)")

(def-mm-constraint "binary_associations" |Association|
   "Only binary associations can be aggregations."
    :operation-status :ignored
    :editor-note "Association has no aggregation attribute."
    :original-body
    "self.memberEnd->exists(isComposite) implies self.memberEnd->size() = 2"
    :operation-body
   "true")

(def-mm-constraint "specialized_end_number" |Association| 
   "An association specializing another association has the same number of
    ends as the other association." 
   :operation-body
   "parents()->select(oclIsKindOf(Association)).oclAsType(Association)->forAll(p | p.memberEnd->size() = self.memberEnd->size())")

(def-mm-constraint "specialized_end_types" |Association|
   "When an association specializes another association, every end of the specific
    association corresponds to an end of the general association, and the specific
    end reaches the same type or a subtype of the more general end."
    :operation-status :ignored
    :editor-note "Needs further investigation: (1) POD my parser has a bug that reads 1.0 instead of 1 and then ..
                     (2) Why the empty sequence."
    :original-body
    "Sequence{1..self.memberEnd->size()}->  forAll(i | self.general->select(oclIsKindOf(Association)).oclAsType(Association)->   forAll(ga |self.memberEnd->at(i).type.conformsTo(ga.memberEnd->at(i).type)))"
    :operation-body
   "true")

(def-mm-operation "endType.1" |Association| 
   "endType is derived from the types of the member ends." 
   :operation-body
   "result = self.memberEnd->collect(e | e.type)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Type|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== BehavioralFeature
;;; =========================================================
(def-mm-class |BehavioralFeature| (:CMOF) (|Namespace| |Feature|)
 "A behavioral feature is a feature of a classifier that specifies an aspect
  of the behavior of its instances."
  ((|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the ordered set of formal parameters of this BehavioralFeature.")
   (|raisedException| :range |Type| :multiplicity (0 -1)
    :documentation
     "References the Types representing exceptions that may be raised during
      an invocation of this feature.")))


(def-mm-operation "isDistinguishableFrom" |BehavioralFeature| 
   "The query isDistinguishableFrom() determines whether two BehavioralFeatures
    may coexist in the same Namespace. It specifies that they have to have
    different signatures." 
   :editor-note "owendParameter, not parameter."
   :operation-status :rewritten
   :operation-body "result = if n.oclIsKindOf(BehavioralFeature)
then
  if ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()
  then Set{}->including(self)->including(n)->isUnique(bf | bf.ownedParameter->collect(type))
  else true
  endif
else true
endif"
   :original-body
   "result = if n.oclIsKindOf(BehavioralFeature) then   if ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()   then Set{}->include(self)->include(n)->isUnique( bf | bf.parameter->collect(type))   else true   endif else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p 'NIL)))

;;; =========================================================
;;; ====================== Class
;;; =========================================================
(def-mm-class |Class| (:CMOF) (|Classifier|)
 "A class describes a set of objects that share the same specifications of
  features, constraints, and semantics."
  ((|isAbstract| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True when a class is abstract.")
   (|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |class|)
    :documentation
     "The attributes (i.e. the properties) owned by the class.")
   (|ownedOperation| :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |class|)
    :documentation
     "The operations owned by the class.")
   (|superClass| :range |Class| :multiplicity (0 -1)
    :documentation
     "This gives the superclasses of a class.")))


(def-mm-operation "inherit" |Class|
   "The inherit operation is overridden to exclude redefined properties."
    :operation-status :rewritten
    :editor-note "reject not excluding"
    :original-body
    "result = inhs->excluding(inh | ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
    :operation-body
   "result = inhs->reject(inh | 
                     ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|NamedElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

;;; =========================================================
;;; ====================== Classifier
;;; =========================================================
(def-mm-class |Classifier| (:CMOF) (|Type| |Namespace|)
 "A classifier is a classification of instances - it describes a set of instances
  that have features in common. A classifier can specify a generalization
  hierarchy by referencing its general classifiers."
  ((|attribute| :range |Property| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Classifier| |feature|))
    :documentation
     "Refers to all of the Properties that are direct (i.e. not inherited or
      imported) attributes of the classifier.")
   (|feature| :range |Feature| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Feature| |featuringClassifier|)
    :documentation
     "Note that there may be members of the Classifier that are of the type Feature
      but are not included in this association, e.g. inherited features.")
   (|general| :range |Classifier| :multiplicity (0 -1)
    :documentation
     "References the general classifier in the Generalization relationship.")
   (|inheritedMember| :range |NamedElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "Specifies all elements inherited by this classifier from the general classifiers.")
   (|isFinalSpecialization| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier cannot be specialized by generalization. Note that
      this property is preserved through package merge operations; that is, the
      capability to specialize a Classifier (i.e., isFinalSpecialization =false)
      must be preserved in the resulting Classifier of a package merge operation
      where a Classifier with isFinalSpecialization =false is merged with a matching
      Classifier with isFinalSpecialization =true: the resulting Classifier will
      have isFinalSpecialization =false.")))


(def-mm-constraint "no_cycles_in_generalization" |Classifier| 
   "Generalization hierarchies must be directed and acyclical. A classifier
    can not be both a transitively general and transitively specific classifier
    of the same classifier." 
   :operation-body
   "not self.allParents()->includes(self)")

(def-mm-constraint "specialize_type" |Classifier| 
   "A classifier may only specialize classifiers of a valid type." 
   :operation-body
   "self.parents()->forAll(c | self.maySpecializeType(c))")

(def-mm-operation "allFeatures" |Classifier| 
   "The query allFeatures() gives all of the features in the namespace of the
    classifier. In general, through mechanisms such as inheritance, this will
    be a larger set than feature." 
   :operation-body
   "result = member->select(oclIsKindOf(Feature))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Feature|
                        :parameter-return-p 'T)))

(def-mm-operation "allParents" |Classifier|
   "The query allParents() gives all of the direct and indirect ancestors of
    a generalized Classifier."
    :operation-status :rewritten
    :editor-note "Missing close paren."
    :original-body
    "result = self.parents()->union(self.parents()->collect(p | p.allParents())"
    :operation-body
   "result = self.parents()->union(self.parents()->collect(p | p.allParents()))"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Classifier|
                        :parameter-return-p 'T)))

(def-mm-operation "conformsTo" |Classifier| 
   "The query conformsTo() gives true for a classifier that defines a type
    that conforms to another. This is used, for example, in the specification
    of signature conformance for operations." 
   :operation-body
   "result = (self=other) or (self.allParents()->includes(other))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Classifier|
                        :parameter-return-p 'NIL)))

(def-mm-operation "general" |Classifier| 
   "The general classifiers are the classifiers referenced by the generalization
    relationships." 
   :operation-body
   "result = self.parents()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Classifier|
                        :parameter-return-p 'T)))

(def-mm-operation "hasVisibilityOf" |Classifier|
   "The query hasVisibilityOf() determines whether a named element is visible
    in the classifier. By default all are visible. It is only called when the
    argument is something owned by a parent."
    :operation-status :ignored
    :editor-note "I rewrote inheritedMember to not use inheritableMembers and hasVisibilityOf.
                  These produce an non-progressing recursion (calling each other with no change in arguments)."
    :original-body
    "result = (n.visibility <> VisibilityKind::private)
self.allParents()->including(self)->collect(c | c.member)->includes(n)"
    :operation-body
   "Set {}"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "inherit" |Classifier| 
   "The inherit operation is overridden to exclude redefined properties." 
   :operation-body
   "result = inhs"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|NamedElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "inheritableMembers" |Classifier|
   "The query inheritableMembers() gives all of the members of a classifier
    that may be inherited in one of its descendants, subject to whatever visibility
    restrictions apply."
    :operation-status :original
    :editor-note "I rewrote inheritedMember to not use inheritableMembers and hasVisibilityOf.
                  These produce an non-progressing recursion (calling each other with no change in arguments)."
    :original-body
    "c.allParents()->includes(self)
result = member->select(m | c.hasVisibilityOf(m))"
    :operation-body
   "Set{}"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|NamedElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p 'NIL)))

(def-mm-operation "inheritedMember.1" |Classifier| 
   "The inheritedMember association is derived by inheriting the inheritable
    members of the parents." 
   :operation-body
   "result = self.inherit(self.parents()->collect(p|p.inheritableMembers(self))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|NamedElement|
                        :parameter-return-p 'T)))

(def-mm-operation "maySpecializeType" |Classifier|
   "The query maySpecializeType() determines whether this classifier may have
    a generalization relationship to classifiers of the specified type. By
    default a classifier may specialize classifiers of the same or a more general
    type. It is intended to be redefined by classifiers that have different
    specialization constraints."
    :operation-status :rewritten
    :editor-note "oclType() not oclType. No such operator in OCL AFAIK. But I have one for this purpose."
    :original-body
    "result = self.oclIsKindOf(c.oclType)"
    :operation-body
   "result = self.oclIsKindOf(c.oclType())"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p 'NIL)))

(def-mm-operation "parents" |Classifier|
   "The query parents() gives all of the immediate ancestors of a generalized
    Classifier."
    :operation-body
    "result = generalization.general"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Classifier|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== Comment
;;; =========================================================
(def-mm-class |Comment| (:CMOF) (|Element|)
 "A comment is a textual annotation that can be attached to a set of elements."
  ((|annotatedElement| :range |Element| :multiplicity (0 -1)
    :documentation
     "References the Element(s) being commented.")
   (|body| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a string that is the comment.")))


;;; =========================================================
;;; ====================== Constraint
;;; =========================================================
(def-mm-class |Constraint| (:CMOF) (|PackageableElement|)
 "A constraint is a condition or restriction expressed in natural language
  text or in a machine readable language for the purpose of declaring some
  of the semantics of an element."
  ((|constrainedElement| :range |Element| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The ordered set of Elements referenced by this Constraint.")
   (|context| :range |Namespace| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Namespace| |ownedRule|))
   (|specification| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied.")))


(def-mm-constraint "not_apply_to_self" |Constraint| 
   "A constraint cannot be applied to itself." 
   :operation-body
   "not constrainedElement->includes(self)")

(def-mm-constraint "value_specification_boolean" |Constraint|
   "The value specification for a constraint must evaluate to a Boolean value."
    :operation-status :rewritten
    :editor-note "No () on specification. oclIsKindOf not isOclKindOf. More generally,
        it looks like this intends to perform runtime evaluation of the OCL string in the specification
        property (which should more accurately be specification.body, anyway). There is no way to 
        describe this in OCL. Carried Over from UML 2.1.1"
    :original-body
    "self.specification().booleanValue().isOclKindOf(Boolean)"
    :operation-body
   "true")

;;; =========================================================
;;; ====================== DataType
;;; =========================================================
(def-mm-class |DataType| (:CMOF) (|Classifier|)
 "A data type is a type whose instances are identified only by their value.
  A data type may contain attributes to support the modeling of structured
  data types."
  ((|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |datatype|)
    :documentation
     "The Attributes owned by the DataType.")
   (|ownedOperation| :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |datatype|)
    :documentation
     "The Operations owned by the DataType.")))


(def-mm-operation "inherit" |DataType|
   "The inherit operation is overridden to exclude redefined properties."
    :operation-status :rewritten
    :editor-note "reject not excluding. The operation Classifier.inhertedMember, 
                  redefined to eliminate non-progressing recursion, does not use inherit. 
                  Something similar should occur here. But I haven't written it yet.
                  See Class.inherit, Classifier.inherit. Needs further study!"
    :original-body
    "result = inhs->excluding(inh | ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
    :operation-body
   "result = inhs->reject(inh | ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|NamedElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

;;; =========================================================
;;; ====================== DirectedRelationship
;;; =========================================================
(def-mm-class |DirectedRelationship| (:CMOF) (|Relationship|)
 "A directed relationship represents a relationship between a collection
  of source model elements and a collection of target model elements."
  ((|source| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the sources of the DirectedRelationship.")
   (|target| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the targets of the DirectedRelationship.")))


;;; =========================================================
;;; ====================== Element
;;; =========================================================
(def-mm-class |Element| (:CMOF) NIL
 "An element is a constituent of a model. As such, it has the capability
  of owning other elements."
  ((|ownedComment| :range |Comment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The Comments owned by this element.")
   (|ownedElement| :range |Element| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :opposite (|Element| |owner|)
    :documentation
     "The Elements owned by this element.")
   (|owner| :range |Element| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Element| |ownedElement|)
    :documentation
     "The Element that owns this element.")))


(def-mm-constraint "has_owner" |Element| 
   "Elements that must be owned must have an owner." 
   :operation-body
   "self.mustBeOwned() implies owner->notEmpty()")

(def-mm-constraint "not_own_self" |Element| 
   "An element may not directly or indirectly own itself." 
   :operation-body
   "not self.allOwnedElements()->includes(self)")

(def-mm-operation "allOwnedElements" |Element| 
   "The query allOwnedElements() gives all of the direct and indirect owned
    elements of an element." 
   :operation-body
   "result = ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Element|
                        :parameter-return-p 'T)))

(def-mm-operation "mustBeOwned" |Element| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner. Subclasses of Element that do not require an owner must override
    this operation." 
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== ElementImport
;;; =========================================================
(def-mm-class |ElementImport| (:CMOF) (|DirectedRelationship|)
 "An element import identifies an element in another package, and allows
  the element to be referenced using its name without a qualifier."
  ((|alias| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the name that should be added to the namespace of the importing
      package in lieu of the name of the imported packagable element. The aliased
      name must not clash with any other member name in the importing package.
      By default, no alias is used.")
   (|importedElement| :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the PackageableElement whose name is to be added to a Namespace.")
   (|importingNamespace| :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |elementImport|)
    :documentation
     "Specifies the Namespace that imports a PackageableElement from another
      Package.")
   (|visibility| :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElement within the
      importing Package. The default visibility is the same as that of the imported
      element. If the imported element does not have a visibility, it is possible
      to add visibility to the element import.")))


(def-mm-constraint "imported_element_is_public" |ElementImport| 
   "An importedElement has either public visibility or no visibility at all." 
   :operation-body
   "self.importedElement.visibility.notEmpty() implies self.importedElement.visibility = #public")

(def-mm-constraint "visibility_public_or_private" |ElementImport| 
   "The visibility of an ElementImport is either public or private." 
   :operation-body
   "self.visibility = #public or self.visibility = #private")

(def-mm-operation "getName" |ElementImport| 
   "The query getName() returns the name under which the imported PackageableElement
    will be known in the importing namespace." 
   :operation-body
   "result = if self.alias->notEmpty() then    self.alias else   self.importedElement.name endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|String|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== Enumeration
;;; =========================================================
(def-mm-class |Enumeration| (:CMOF) (|DataType|)
 "An enumeration is a data type whose values are enumerated in the model
  as enumeration literals."
  ((|ownedLiteral| :range |EnumerationLiteral| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|EnumerationLiteral| |enumeration|)
    :documentation
     "The ordered set of literals for this Enumeration.")))


;;; =========================================================
;;; ====================== EnumerationLiteral
;;; =========================================================
(def-mm-class |EnumerationLiteral| (:CMOF) (|NamedElement|)
 "An enumeration literal is a user-defined data value for an enumeration."
  ((|enumeration| :range |Enumeration| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Enumeration| |ownedLiteral|)
    :documentation
     "The Enumeration that this EnumerationLiteral is a member of.")))


;;; =========================================================
;;; ====================== Expression
;;; =========================================================
(def-mm-class |Expression| (:CMOF) (|ValueSpecification|)
 "An expression is a structured tree of symbols that denotes a (possibly
  empty) set of values when evaluated in a context."
  ((|operand| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies a sequence of operands.")))


;;; =========================================================
;;; ====================== Feature
;;; =========================================================
(def-mm-class |Feature| (:CMOF) (|RedefinableElement|)
 "A feature declares a behavioral or structural characteristic of instances
  of classifiers."
  ((|featuringClassifier| :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Classifier| |feature|)
    :documentation
     "The Classifiers that have this Feature as a feature.")))


;;; =========================================================
;;; ====================== MultiplicityElement
;;; =========================================================
(def-mm-class |MultiplicityElement| (:CMOF) (|Element|)
 "A multiplicity is a definition of an inclusive interval of non-negative
  integers beginning with a lower bound and ending with a (possibly infinite)
  upper bound. A multiplicity element embeds this information to specify
  the allowable cardinalities for an instantiation of this element."
  ((|isOrdered| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "For a multivalued multiplicity, this attribute specifies whether the values
      in an instantiation of this element are sequentially ordered.")
   (|isUnique| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a multivalued multiplicity, this attributes specifies whether the values
      in an instantiation of this element are unique.")
   (|lower| :range |Integer| :multiplicity (0 1) :default 1
    :documentation
     "Specifies the lower bound of the multiplicity interval.")
   (|upper| :range |UnlimitedNatural| :multiplicity (0 1) :default 1
    :documentation
     "Specifies the upper bound of the multiplicity interval.")))


(def-mm-constraint "lower_ge_0" |MultiplicityElement|
   "The lower bound must be a non-negative integer literal."
    :operation-status :rewritten
    :editor-note "Rewrite was probably pointless. Needs examination."
    :original-body
    "lowerBound()->notEmpty() implies lowerBound() >= 0"
    :operation-body
   "not lowerBound().oclIsUndefined() implies lowerBound() >= 0")

(def-mm-constraint "upper_ge_lower" |MultiplicityElement| 
   "The upper bound must be greater than or equal to the lower bound." 
   :operation-body
   "(upperBound()->notEmpty() and lowerBound()->notEmpty()) implies upperBound() >= lowerBound()")

(def-mm-operation "includesCardinality" |MultiplicityElement| 
   "The query includesCardinality() checks whether the specified cardinality
    is valid for this multiplicity." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = (lowerBound() <= C) and (upperBound() >= C)"
    :original-body
   "upperBound()->notEmpty() and lowerBound()->notEmpty()
result = (lowerBound() <= C) and (upperBound() >= C)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name 'C :parameter-type '|Integer|
                        :parameter-return-p 'NIL)))

(def-mm-operation "includesMultiplicity" |MultiplicityElement| 
   "The query includesMultiplicity() checks whether this multiplicity includes
    all the cardinalities allowed by the specified multiplicity." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = (self.lowerBound() <= M.lowerBound()) and (self.upperBound() >= M.upperBound())"
   :original-body
   "self.upperBound()->notEmpty() and self.lowerBound()->notEmpty() and M.upperBound()->notEmpty() and M.lowerBound()->notEmpty()
result = (self.lowerBound() <= M.lowerBound()) and (self.upperBound() >= M.upperBound())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name 'M :parameter-type '|MultiplicityElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "isMultivalued" |MultiplicityElement| 
   "The query isMultivalued() checks whether this multiplicity has an upper
    bound greater than one." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = upperBound() > 1"
   :original-body 
   "result = upperBound() > 1
upperBound()->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "lowerBound" |MultiplicityElement| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    integer." 
   :operation-body
   "result = if lower->notEmpty() then lower else 1 endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Integer|
                        :parameter-return-p 'T)))

(def-mm-operation "upperBound" |MultiplicityElement|
   "The query upperBound() returns the upper bound of the multiplicity for
    a bounded multiplicity as an unlimited natural."
    :operation-body
    "result = if upper->notEmpty() then upper else 1 endif"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== NamedElement
;;; =========================================================
(def-mm-class |NamedElement| (:CMOF) (|Element|)
 "A named element is an element in a model that may have a name."
  ((|name| :range |String| :multiplicity (0 1)
    :documentation
     "The name of the NamedElement.")
   (|namespace| :range |Namespace| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Namespace| |ownedMember|)
    :documentation
     "Specifies the namespace that owns the NamedElement.")
   (|qualifiedName| :range |String| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A name which allows the NamedElement to be identified within a hierarchy
      of nested Namespaces. It is constructed from the names of the containing
      namespaces starting at the root of the hierarchy and ending with the name
      of the NamedElement itself.")
   (|visibility| :range |VisibilityKind| :multiplicity (0 1)
    :documentation
     "Determines where the NamedElement appears within different Namespaces within
      the overall model, and its accessibility.")))


(def-mm-constraint "has_no_qualified_name" |NamedElement| 
   "If there is no name, or one of the containing namespaces has no name, there
    is no qualified name." 
   :operation-body
   "(self.name->isEmpty() or self.allNamespaces()->select(ns | ns.name->isEmpty())->notEmpty())   implies self.qualifiedName->isEmpty()")

(def-mm-constraint "has_qualified_name" |NamedElement|
   "When there is a name, and all of the containing namespaces have a name,
    the qualified name is constructed from the names of the containing namespaces."
    :operation-status :ignored
    :editor-note "qualifiedName is a derived attribute where the derivation is the same as this (and both wrong)."
    :original-body
    "(self.name->notEmpty() and self.allNamespaces()->select(ns | ns.name->isEmpty())->isEmpty()) implies   self.qualifiedName = self.allNamespaces()->iterate( ns : Namespace; result: String = self.name | ns.name->union(self.separator())->union(result))"
    :operation-body
   "true")

(def-mm-constraint "visibility_needs_ownership" |NamedElement|
   "If a NamedElement is not owned by a Namespace, it does not have a visibility."
    :operation-status :ignored
    :editor-note "visibility has default value #public, making this fail whenever namespace is
     not specified."
    :original-body
    "namespace->isEmpty() implies visibility->isEmpty()"
    :operation-body
   "true")

(def-mm-operation "allNamespaces" |NamedElement| 
   "The query allNamespaces() gives the sequence of namespaces in which the
    NamedElement is nested, working outwards." 
   :operation-body
   "result = if self.namespace->isEmpty() then Sequence{} else self.namespace.allNamespaces()->prepend(self.namespace) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Namespace|
                        :parameter-return-p 'T)))

(def-mm-operation "isDistinguishableFrom" |NamedElement| 
   "The query isDistinguishableFrom() determines whether two NamedElements
    may logically co-exist within a Namespace. By default, two named elements
    are distinguishable if (a) they have unrelated types or (b) they have related
    types but different names." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = if self.oclIsKindOf(n.oclType()) or n.oclIsKindOf(self.oclType())
then ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty()
else true
endif"
   :original-body
   "result = if self.oclIsKindOf(n.oclType) or n.oclIsKindOf(self.oclType) then ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty() else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p 'NIL)))

(def-mm-operation "qualifiedName.1" |NamedElement| 
   "When there is a name, and all of the containing namespaces have a name,
    the qualified name is constructed from the names of the containing namespaces." 
    :operation-status :rewritten
    :editor-note "Use OCL concat not union. Carried over from UML 2.1.1"
    :operation-body "result = if self.name->notEmpty() and 
                                 self.allNamespaces()->select(ns | ns.name->isEmpty())->isEmpty()
                              then 
                                  self.allNamespaces()->iterate( ns : Namespace; 
                                  result : String = self.name | ns.name.concat(self.separator()).concat(result))
                              else
                                 Set{}
                              endif" 
    :original-body
   "result = if self.name->notEmpty() and self.allNamespaces()->select(ns | ns.name->isEmpty())->isEmpty() then      self.allNamespaces()->iterate( ns : Namespace; result: String = self.name | ns.name->union(self.separator())->union(result)) else     Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|String|
                        :parameter-return-p 'T)))

(def-mm-operation "separator" |NamedElement| 
   "The query separator() gives the string that is used to separate names when
    constructing a qualified name." 
   :operation-body
   "result = '::'"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|String|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-mm-class |Namespace| (:CMOF) (|NamedElement|)
 "A namespace is an element in a model that contains a set of named elements
  that can be identified by name."
  ((|elementImport| :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ElementImport| |importingNamespace|)
    :documentation
     "References the ElementImports owned by the Namespace.")
   (|importedMember| :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "References the PackageableElements that are members of this Namespace as
      a result of either PackageImports or ElementImports.")
   (|member| :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "A collection of NamedElements identifiable within the Namespace, either
      by being owned or by being introduced by importing or inheritance.")
   (|ownedMember| :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|) (|Namespace| |member|))
    :opposite (|NamedElement| |namespace|)
    :documentation
     "A collection of NamedElements owned by the Namespace.")
   (|ownedRule| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Constraint| |context|))
   (|packageImport| :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageImport| |importingNamespace|)
    :documentation
     "References the PackageImports owned by the Namespace.")))


(def-mm-constraint "members_distinguishable" |Namespace| 
   "All the members of a Namespace are distinguishable within it." 
   :operation-body
   "membersAreDistinguishable()")

(def-mm-operation "excludeCollisions" |Namespace| 
   "The query excludeCollisions() excludes from a set of PackageableElements
    any that would not be distinguishable from each other in this namespace." 
   :operation-body
   "result = imps->reject(imp1 | imps.exists(imp2 | not imp1.isDistinguishableFrom(imp2, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|PackageableElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "getNamesOfMember" |Namespace|
   "The query getNamesOfMember() takes importing into account. It gives back
    the set of names that an element would have in an importing namespace,
    either because it is owned, or if not owned then imported individually,
    or if not individually then from a package."
    :operation-status :rewritten
    :editor-note "includes not include"
    :original-body
    "result = if self.ownedMember->includes(element) then Set{}->include(element.name) else let elementImports: ElementImport = self.elementImport->select(ei | ei.importedElement = element) in   if elementImports->notEmpty()   then elementImports->collect(el | el.getName())   else self.packageImport->select(pi | pi.importedPackage.visibleMembers()->includes(element))->collect(pi | pi.importedPackage.getNamesOfMember(element))   endif endif"
    :operation-body
   "result = if self.ownedMember ->includes(element)
then Set{}->includes(element.name)
else let elementImports: ElementImport = self.elementImport->select(ei | ei.importedElement = element) in
  if elementImports->notEmpty()
  then elementImports->collect(el | el.getName())
  else self.packageImport->select(pi | pi.importedPackage.visibleMembers()->includes(element))-> collect(pi | pi.importedPackage.getNamesOfMember(element))
  endif
endif"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|String|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|element| :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "importMembers" |Namespace|
   "The query importMembers() defines which of a set of PackageableElements
    are actually imported into the namespace. This excludes hidden ones, i.e.,
    those which have names that conflict with names of owned members, and also
    excludes elements which would have the same name when imported."
    :operation-status :ignored
    :editor-note "Needs examination."
    :original-body
    "result = self.excludeCollisions(imps)->select(imp | self.ownedMember->forAll(mem | mem.imp.isDistinguishableFrom(mem, self)))"
    :operation-body
   "Set{}"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|PackageableElement|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "importedMember.1" |Namespace| 
   "The importedMember property is derived from the ElementImports and the
    PackageImports. References the PackageableElements that are members of
    this Namespace as a result of either PackageImports or ElementImports." 
   :operation-body
   "result = self.importMembers(self.elementImport.importedElement.asSet()->union(self.packageImport.importedPackage->collect(p | p.visibleMembers())))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|PackageableElement|
                        :parameter-return-p 'T)))

(def-mm-operation "membersAreDistinguishable" |Namespace| 
   "The Boolean query membersAreDistinguishable() determines whether all of
    the namespace's members are distinguishable within it." 
   :operation-body
   "result = self.member->forAll( memb |  self.member->excluding(memb)->forAll(other |   memb.isDistinguishableFrom(other, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== OpaqueExpression
;;; =========================================================
(def-mm-class |OpaqueExpression| (:CMOF) (|ValueSpecification|)
 "An opaque expression is an uninterpreted textual statement that denotes
  a (possibly empty) set of values when evaluated in a context."
  ((|body| :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "The text of the expression, possibly in multiple languages.")
   (|language| :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Specifies the languages in which the expression is stated. The interpretation
      of the expression body depends on the languages. If the languages are unspecified,
      they might be implicit from the expression body or the context. Languages
      are matched to body strings by order.")))


(def-mm-constraint "language_body_size" |OpaqueExpression| 
   "If the language attribute is not empty, then the size of the body and language
    arrays must be the same." 
   :operation-body
   "language->notEmpty() implies (body->size() = language->size())")

;;; =========================================================
;;; ====================== Operation
;;; =========================================================
(def-mm-class |Operation| (:CMOF) (|BehavioralFeature|)
 "An operation is a behavioral feature of a classifier that specifies the
  name, type, parameters, and constraints for invoking an associated behavior."
  ((|bodyCondition| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)))
   (|class| :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Class| |ownedOperation|)
    :documentation
     "The class that owns the operation.")
   (|datatype| :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|DataType| |ownedOperation|)
    :documentation
     "The DataType that owns this Operation.")
   (|isOrdered| :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "This information is derived from the return result for this Operation.")
   (|isQuery| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether an execution of the BehavioralFeature leaves the state
      of the system unchanged (isQuery=true) or whether side effects may occur
      (isQuery=false).")
   (|isUnique| :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :true
    :documentation
     "This information is derived from the return result for this Operation.")
   (|lower| :range |Integer| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "This information is derived from the return result for this Operation.")
   (|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :opposite (|Parameter| |operation|)
    :documentation
     "Specifies the ordered set of formal parameters of this BehavioralFeature.")
   (|postcondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)))
   (|precondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)))
   (|raisedException| :range |Type| :multiplicity (0 -1)
    :documentation
     "References the Types representing exceptions that may be raised during
      an invocation of this operation.")
   (|redefinedOperation| :range |Operation| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References the Operations that are redefined by this Operation.")
   (|type| :range |Type| :multiplicity (0 1) :is-derived-p T
    :documentation
     "This information is derived from the return result for this Operation.")
   (|upper| :range |UnlimitedNatural| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "This information is derived from the return result for this Operation.")))


(def-mm-constraint "at_most_one_return" |Operation| 
   "An operation can have at most one return parameter; i.e., an owned parameter
    with the direction set to 'return'" 
   :operation-body
   "self.ownedParameter->select(par | par.direction = #return)->size() <= 1")

(def-mm-constraint "only_body_for_query" |Operation| 
   "A bodyCondition can only be specified for a query operation." 
   :operation-body
   "bodyCondition->notEmpty() implies isQuery")

(def-mm-operation "isConsistentWith" |Operation|
   "The query isConsistentWith() specifies, for any two Operations in a context
    in which redefinition is possible, whether redefinition would be consistent
    in the sense of maintaining type covariance. Other senses of consistency
    may be required, for example to determine consistency in the sense of contravariance.
    Users may define alternative queries under names different from 'isConsistentWith()',
    as for example, users may define a query named 'isContravariantWith()'."
    :operation-status :ignored
    :editor-note "Needs investigation"
    :original-body
    "redefinee.isRedefinitionContextValid(self)
result = (redefinee.oclIsKindOf(Operation) and let op: Operation = redefinee.oclAsType(Operation) in self.ownedParameter.size() = op.ownedParameter.size() and forAll(i | op.ownedParameter[i].type.conformsTo(self.ownedParameter[i].type)) )"
    :operation-body
   "true"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "isOrdered.1" |Operation| 
   "If this operation has a return parameter, isOrdered equals the value of
    isOrdered for that parameter. Otherwise isOrdered is false." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML."
   :operation-body "result = if returnResult()->notEmpty() then returnResult()->any().isOrdered else false endif"
   :original-body
   "result = if returnResult->size() = 1 then returnResult->any().isOrdered else false endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "isUnique.1" |Operation| 
   "If this operation has a return parameter, isUnique equals the value of
    isUnique for that parameter. Otherwise isUnique is true." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
   :operation-body "result = if returnResult()->notEmpty() then returnResult()->any().isUnique else true endif"
   :original-body
   "result = if returnResult->size() = 1 then returnResult->any().isUnique else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "lower.1" |Operation| 
   "If this operation has a return parameter, lower equals the value of lower
    for that parameter. Otherwise lower is not defined." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
   :operation-body "result = if returnResult()->notEmpty() then returnResult()->any().lower else Set{} endif"
   :original-body
   "result = if returnResult->size() = 1 then returnResult->any().lower else Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Integer|
                        :parameter-return-p 'T)))

(def-mm-operation "returnResult" |Operation| 
   "" 
   :operation-body
   "result = ownedParameter->select (par | par.direction = #return)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Parameter|
                        :parameter-return-p 'T)))

(def-mm-operation "type.1" |Operation| 
   "If this operation has a return parameter, type equals the value of type
    for that parameter. Otherwise type is not defined." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = if returnResult()->notEmpty() then returnResult()->any().type else Set{} endif"
   :original-body
   "result = if returnResult->size() = 1 then returnResult->any().type else Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Type|
                        :parameter-return-p 'T)))

(def-mm-operation "upper.1" |Operation| 
   "If this operation has a return parameter, upper equals the value of upper
    for that parameter. Otherwise upper is not defined." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :original-body "result = if returnResult()->notEmpty() then returnResult()->any().upper else Set{} endif"
   :operation-body
   "result = if returnResult()->size() = 1 then returnResult()->any().upper else Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== Package
;;; =========================================================
(def-mm-class |Package| (:CMOF) (|Namespace| |PackageableElement|)
 "A package is used to group elements, and provides a namespace for the grouped
  elements."
  ((URI :range |String| :multiplicity (0 1)
    :documentation
     "Provides an identifier for the package that can be used for many purposes.
      A URI is the universally unique identification of the package following
      the IETF URI specification, RFC 2396 http://www.ietf.org/rfc/rfc2396.txt
      and it must comply with those syntax rules.")
   (|nestedPackage| :range |Package| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Package| |nestingPackage|)
    :documentation
     "References the packaged elements that are Packages.")
   (|nestingPackage| :range |Package| :multiplicity (0 1)
    :opposite (|Package| |nestedPackage|)
    :documentation
     "References the Package that owns this Package.")
   (|ownedType| :range |Type| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Type| |package|)
    :documentation
     "References the packaged elements that are Types.")
   (|packageMerge| :range |PackageMerge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageMerge| |receivingPackage|)
    :documentation
     "References the PackageMerges that are owned by this Package.")
   (|packagedElement| :range |PackageableElement| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the packageable elements that are owned by this Package.")))


(def-mm-constraint "elements_public_or_private" |Package|
   "If an element that is owned by a package has visibility, it is public or
    private."
    :operation-status :ignored
    :editor-note "(1) ownedElement not ownedElements, visibility not visbility
                  (2) Element.ownedComment subsets Element.ownedElement, thus ownedElement includes
                  things of type Comment. Property visibility is defined on PackagableElement. 
                  Comment, TemplateBinding, TemplateSignature, ProfileApplication, and PackageMerge
                  are not of type PackageableElement (which supplies this property)."
    :original-body
    "self.ownedElements->forAll(e | e.visibility->notEmpty() implies e.visbility = #public or e.visibility = #private)"
    :operation-body
   "true")

(def-mm-operation "makesVisible" |Package| 
   "The query makesVisible() defines whether a Package makes an element visible
    outside itself. Elements with no visibility and elements with public visibility
    are made visible." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = (ownedMember->includes(el)) or
(elementImport->select(ei|ei.importedElement = #public)->collect(ei|ei.importedElement)->includes(el)) or
(packageImport->select(pi|pi.visibility = #public)->collect(pi|pi.importedPackage.member->includes(el))->notEmpty())"
   :original-body
   "result = (ownedMember->includes(el)) or    (elementImport->       select(ei|ei.visibility = #public)->          collect(ei|ei.importedElement)->includes(el)) or    (packageImport->       select(pi|pi.visibility = #public)->         collect(pi|            pi.importedPackage.member->includes(el))->notEmpty())
self.member->includes(el)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|el| :parameter-type '|NamedElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "mustBeOwned" |Package| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner." 
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "visibleMembers" |Package| 
   "The query visibleMembers() defines which members of a Package can be accessed
    outside it." 
   :operation-body
   "result = member->select( m | self.makesVisible(m))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|PackageableElement|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== PackageImport
;;; =========================================================
(def-mm-class |PackageImport| (:CMOF) (|DirectedRelationship|)
 "A package import is a relationship that allows the use of unqualified names
  to refer to package members from other namespaces."
  ((|importedPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the Package whose members are imported into a Namespace.")
   (|importingNamespace| :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |packageImport|)
    :documentation
     "Specifies the Namespace that imports the members from a Package.")
   (|visibility| :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElements within the
      importing Namespace, i.e., whether imported elements will in turn be visible
      to other packages that use that importingPackage as an importedPackage.
      If the PackageImport is public, the imported elements will be visible outside
      the package, while if it is private they will not.")))


(def-mm-constraint "public_or_private" |PackageImport| 
   "The visibility of a PackageImport is either public or private." 
   :operation-body
   "self.visibility = #public or self.visibility = #private")

;;; =========================================================
;;; ====================== PackageMerge
;;; =========================================================
(def-mm-class |PackageMerge| (:CMOF) (|DirectedRelationship|)
 "A package merge defines how the contents of one package are extended by
  the contents of another package."
  ((|mergedPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the Package that is to be merged with the receiving package
      of the PackageMerge.")
   (|receivingPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Package| |packageMerge|)
    :documentation
     "References the Package that is being extended with the contents of the
      merged package of the PackageMerge.")))


;;; =========================================================
;;; ====================== PackageableElement
;;; =========================================================
(def-mm-class |PackageableElement| (:CMOF) (|NamedElement|)
 "A packageable element indicates a named element that may be owned directly
  by a package."
  ())


;;; =========================================================
;;; ====================== Parameter
;;; =========================================================
(def-mm-class |Parameter| (:CMOF) (|MultiplicityElement| |TypedElement|)
 "A parameter is a specification of an argument used to pass information
  into or out of an invocation of a behavioral feature."
  ((|default| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a String that represents a value to be used when no argument
      is supplied for the Parameter.")
   (|direction| :range |ParameterDirectionKind| :multiplicity (1 1) :default :in
    :documentation
     "Indicates whether a parameter is being sent into or out of a behavioral
      element.")
   (|operation| :range |Operation| :multiplicity (0 1)
    :opposite (|Operation| |ownedParameter|)
    :documentation
     "References the Operation owning this parameter.")))


;;; =========================================================
;;; ====================== PrimitiveType
;;; =========================================================
(def-mm-class |PrimitiveType| (:CMOF) (|DataType|)
 "A primitive type defines a predefined data type, without any relevant substructure
  (i.e., it has no parts in the context of UML). A primitive datatype may
  have an algebra and operations defined outside of UML, for example, mathematically."
  ())


;;; =========================================================
;;; ====================== Property
;;; =========================================================
(def-mm-class |Property| (:CMOF) (|StructuralFeature|)
 "A property is a structural feature of a classifier that characterizes instances
  of the classifier. A property related by ownedAttribute to a classifier
  (other than an association) represents an attribute and might also represent
  an association end. It relates an instance of the class to a value or set
  of values of the type of the attribute. A property related by memberEnd
  or its specializations to an association represents an end of the association.
  The type of the property is the type of the end of the association."
  ((|association| :range |Association| :multiplicity (0 1)
    :opposite (|Association| |memberEnd|)
    :documentation
     "References the association of which this property is a member, if any.")
   (|class| :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Class| |ownedAttribute|)
    :documentation
     "References the Class that owns the Property.")
   (|datatype| :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|DataType| |ownedAttribute|)
    :documentation
     "The DataType that owns this Property.")
   (|default| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a String that represents a value to be used when no argument
      is supplied for the Property.")
   (|isComposite| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isComposite is true, the object containing the attribute is a container
      for the object or value contained in the attribute.")
   (|isDerived| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isDerived is true, the value of the attribute is derived from information
      elsewhere.")
   (|isDerivedUnion| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the property is derived as the union of all of the properties
      that are constrained to subset it.")
   (|isID| :range |Boolean| :multiplicity (0 1)
    :documentation
     "True indicates this property can be used to uniquely identify an instance
      of the containing Class.")
   (|isReadOnly| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isReadOnly is true, the attribute may not be written to after initialization.")
   (|opposite| :range |Property| :multiplicity (0 1) :is-derived-p T
    :documentation
     "In the case where the property is one navigable end of a binary association
      with both ends navigable, this gives the other end.")
   (|owningAssociation| :range |Association| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|Property| |association|))
    :opposite (|Association| |ownedEnd|)
    :documentation
     "References the owning association of this property, if any.")
   (|redefinedProperty| :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References the properties that are redefined by this property.")
   (|subsettedProperty| :range |Property| :multiplicity (0 -1)
    :documentation
     "References the properties of which this property is constrained to be a
      subset.")))


(def-mm-constraint "derived_union_is_derived" |Property| 
   "A derived union is derived." 
   :operation-body
   "isDerivedUnion implies isDerived")

(def-mm-constraint "multiplicity_of_composite" |Property| 
   "A multiplicity of a composite aggregation must not have an upper bound
    greater than 1." 
   :operation-body
   "isComposite implies (upperBound()->isEmpty() or upperBound() <= 1)")

(def-mm-constraint "redefined_property_inherited" |Property|
   "A redefined property must be inherited from a more general classifier containing
    the redefining property."
    :operation-status :rewritten
    :editor-note "Use implies, not if...MIWG: Replaced the body with TRUE, since it appears that redefinitionContext is a derived union with no subsetting properties. Carried over from UML 2.1.1"
    :original-body
    "if (redefinedProperty->notEmpty()) then   (redefinitionContext->notEmpty() and       redefinedProperty->forAll(rp|         ((redefinitionContext->collect(fc|           fc.allParents()))->asSet())->collect(c| c.allFeatures())->asSet()->includes(rp))"
    :operation-body
   "true")

(def-mm-constraint "subsetted_property_names" |Property| 
   "A property may not subset a property with the same name." 
   :operation-body
   "true")

(def-mm-constraint "subsetting_context_conforms" |Property|
   "Subsetting may only occur when the context of the subsetting property conforms
    to the context of the subsetted property."
    :operation-status :ignored
    :editor-note "subsettingContext commented out, thus this cannot be used."
    :original-body
    "self.subsettedProperty->notEmpty() implies   (self.subsettingContext()->notEmpty() and self.subsettingContext()->forAll (sc |     self.subsettedProperty->forAll(sp |       sp.subsettingContext()->exists(c | sc.conformsTo(c)))))"
    :operation-body
   "true")

(def-mm-constraint "subsetting_rules" |Property| 
   "A subsetting property may strengthen the type of the subsetted property,
    and its upper bound may be less." 
   :operation-body
   "self.subsettedProperty->forAll(sp |   self.type.conformsTo(sp.type) and     ((self.upperBound()->notEmpty() and sp.upperBound()->notEmpty()) implies       self.upperBound()<=sp.upperBound() ))")

(def-mm-operation "isAttribute" |Property|
   "The query isAttribute() is true if the Property is defined as an attribute
    of some classifier."
    :operation-status :rewritten
    :editor-note "allInstances() not allInstances"
    :original-body
    "result = Classifier->allInstances->exists(c | c.attribute->includes(p))"
    :operation-body
   "result = Classifier.allInstances()->exists(c | c.attribute->includes(p))"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|Property|
                        :parameter-return-p 'NIL)))

(def-mm-operation "isConsistentWith" |Property| 
   "The query isConsistentWith() specifies, for any two Properties in a context
    in which redefinition is possible, whether redefinition would be logically
    consistent. A redefining property is consistent with a redefined property
    if the type of the redefining property conforms to the type of the redefined
    property, and the multiplicity of the redefining property (if specified)
    is contained in the multiplicity of the redefined property." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
    :operation-body "result = redefinee.oclIsKindOf(Property) and 
  let prop : Property = redefinee.oclAsType(Property) in 
  (prop.type.conformsTo(self.type) and 
  ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and 
  ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and 
  (self.isDerived implies prop.isDerived) and
  (self.isComposite implies prop.isComposite))"
   :original-body
   "redefinee.isRedefinitionContextValid(self)
result = redefinee.oclIsKindOf(Property) and    let prop : Property = redefinee.oclAsType(Property) in    (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and    ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and    (self.isComposite implies prop.isComposite))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "isNavigable" |Property| 
   "The query isNavigable() indicates whether it is possible to navigate across
    the property." 
   :operation-body
   "result = not classifier->isEmpty() or association.owningAssociation.navigableOwnedEnd->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "opposite.1" |Property| 
   "If this property is owned by a class, associated with a binary association,
    and the other end of the association is also owned by a class, then opposite
    gives the other end." 
    :editor-note "excluding() not -.
                  Added additional 'AND association->notEmpty()' to cut off case where self.association is empty."
    :operation-status :rewritten
    :operation-body "result = if owningAssociation->isEmpty() 
                      and association->notEmpty()
                      and association.memberEnd->size() = 2
   then
           let otherEnd = (association.memberEnd->excluding(self))->any() in 
      if otherEnd.owningAssociation->isEmpty() then otherEnd else Set{} endif
    else Set {}
    endif"
   :original-body
   "result = if owningAssociation->isEmpty() and association.memberEnd->size() = 2   then     let otherEnd = (association.memberEnd - self)->any() in       if otherEnd.owningAssociation->isEmpty() then otherEnd else Set{} endif     else Set {}     endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Property|
                        :parameter-return-p 'T)))

(def-mm-operation "subsettingContext" |Property|
   "The query subsettingContext() gives the context for subsetting a property.
    It consists, in the case of an attribute, of the corresponding classifier,
    and in the case of an association end, all of the classifiers at the other
    ends."
    :operation-status :original
    :editor-note "classifier not defined."
    :original-body
    "result = if association->notEmpty() then association.endType-type  else if classifier->notEmpty then Set{classifier} else Set{} endif endif"
    :operation-body
   "Set{}"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Classifier|
                        :parameter-return-p 'T)))

;;; =========================================================
;;; ====================== RedefinableElement
;;; =========================================================
(def-mm-class |RedefinableElement| (:CMOF) (|NamedElement|)
 "A redefinable element is an element that, when defined in the context of
  a classifier, can be redefined more specifically or differently in the
  context of another classifier that specializes (directly or indirectly)
  the context classifier."
  ((|isLeaf| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether it is possible to further redefine a RedefinableElement.
      If the value is true, then it is not possible to further redefine the RedefinableElement.
      Note that this property is preserved through package merge operations;
      that is, the capability to redefine a RedefinableElement (i.e., isLeaf=false)
      must be preserved in the resulting RedefinableElement of a package merge
      operation where a RedefinableElement with isLeaf=false is merged with a
      matching RedefinableElement with isLeaf=true: the resulting RedefinableElement
      will have isLeaf=false. Default value is false.")
   (|redefinedElement| :range |RedefinableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "The redefinable element that is being redefined by this element.")
   (|redefinitionContext| :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "References the contexts that this element may be redefined from.")))


(def-mm-constraint "non_leaf_redefinition" |RedefinableElement| 
   "A redefinable element can only redefine non-leaf redefinable elements" 
   :operation-body
   "self.redefinedElement->forAll(not isLeaf)")

(def-mm-constraint "redefinition_consistent" |RedefinableElement| 
   "A redefining element must be consistent with each redefined element." 
   :operation-body
   "self.redefinedElement->forAll(re | re.isConsistentWith(self))")

(def-mm-constraint "redefinition_context_valid" |RedefinableElement| 
   "At least one of the redefinition contexts of the redefining element must
    be a specialization of at least one of the redefinition contexts for each
    redefined element." 
   :operation-body
   "self.redefinedElement->forAll(e | self.isRedefinitionContextValid(e))")

(def-mm-operation "isConsistentWith" |RedefinableElement| 
   "The query isConsistentWith() specifies, for any two RedefinableElements
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. By default, this is false; this operation must
    be overridden for subclasses of RedefinableElement to define the consistency
    conditions." 
   :operation-status :rewritten
   :editor-note "Borrowed from UML23."
   :operation-body "result = false"
   :original-body
   "redefinee.isRedefinitionContextValid(self)
result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p 'NIL)))

(def-mm-operation "isRedefinitionContextValid" |RedefinableElement|
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of this RedefinableElement are properly related to the redefinition
    contexts of the specified RedefinableElement to allow this element to redefine
    the other. By default at least one of the redefinition contexts of this
    element must be a specialization of at least one of the redefinition contexts
    of the specified element."
    :operation-status :ignored
    :editor-note "Use intersection/notEmpty, not includes. Removed extra close paren...MIWG: Replaced the body with TRUE, since it appears that redefinitionContext is a derived union with no subsetting properties. -- Carried over from UML 2.1.1"
    :original-body
    "result = redefinitionContext->exists(c | c.allParents()->includes(redefined.redefinitionContext)))"
    :operation-body
   "result = true"
    :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|RedefinableElement|
                        :parameter-return-p 'NIL)))

;;; =========================================================
;;; ====================== Relationship
;;; =========================================================
(def-mm-class |Relationship| (:CMOF) (|Element|)
 "Relationship is an abstract concept that specifies some kind of relationship
  between elements."
  ((|relatedElement| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "Specifies the elements related by the Relationship.")))


;;; =========================================================
;;; ====================== StructuralFeature
;;; =========================================================
(def-mm-class |StructuralFeature| (:CMOF) (|Feature| |TypedElement| |MultiplicityElement|)
 "A structural feature is a typed feature of a classifier that specifies
  the structure of instances of the classifier."
  ())


;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-mm-class |Type| (:CMOF) (|PackageableElement|)
 "A type is a named element that is used as the type for a typed element.
  A type can be contained in a package."
  ((|package| :range |Package| :multiplicity (0 1)
    :opposite (|Package| |ownedType|)
    :documentation
     "Specifies the owning package of this classifier, if any.")))


(def-mm-operation "conformsTo" |Type| 
   "The query conformsTo() gives true for a type that conforms to another.
    By default, two types do not conform to each other. This query is intended
    to be redefined for specific conformance situations." 
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Type|
                        :parameter-return-p 'NIL)))

;;; =========================================================
;;; ====================== TypedElement
;;; =========================================================
(def-mm-class |TypedElement| (:CMOF) (|NamedElement|)
 "A typed element is a kind of named element that represents an element with
  a type."
  ((|type| :range |Type| :multiplicity (0 1)
    :documentation
     "This information is derived from the return result for this Operation.")))


;;; =========================================================
;;; ====================== ValueSpecification
;;; =========================================================
(def-mm-class |ValueSpecification| (:CMOF) (|PackageableElement| |TypedElement|)
 "A value specification is the specification of a (possibly empty) set of
  instances, including both objects and data values."
  ())


(def-mm-operation "booleanValue" |ValueSpecification| 
   "The query booleanValue() gives a single Boolean value when one can be computed." 
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "integerValue" |ValueSpecification| 
   "The query integerValue() gives a single Integer value when one can be computed." 
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Integer|
                        :parameter-return-p 'T)))

(def-mm-operation "isComputable" |ValueSpecification| 
   "The query isComputable() determines whether a value specification can be
    computed in a model. This operation cannot be fully defined in OCL. A conforming
    implementation is expected to deliver true for this operation for all value
    specifications that it can compute, and to compute all of those for which
    the operation is true. A conforming implementation is expected to be able
    to compute the value of all literals." 
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "isNull" |ValueSpecification| 
   "The query isNull() returns true when it can be computed that the value
    is null." 
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|Boolean|
                        :parameter-return-p 'T)))

(def-mm-operation "stringValue" |ValueSpecification| 
   "The query stringValue() gives a single String value when one can be computed." 
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|String|
                        :parameter-return-p 'T)))

(def-mm-operation "unlimitedValue" |ValueSpecification| 
   "The query unlimitedValue() gives a single UnlimitedNatural value when one
    can be computed." 
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name 'NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p 'T)))

(def-mm-package "cmof" nil :cmof
   (|ParameterDirectionKind|
    |VisibilityKind|
    |Association|
    |BehavioralFeature|
    |Class|
    |Classifier|
    |Comment|
    |Constraint|
    |DataType|
    |DirectedRelationship|
    |Element|
    |ElementImport|
    |Enumeration|
    |EnumerationLiteral|
    |Expression|
    |Feature|
    |MultiplicityElement|
    |NamedElement|
    |Namespace|
    |OpaqueExpression|
    |Operation|
    |Package|
    |PackageImport|
    |PackageMerge|
    |PackageableElement|
    |Parameter|
    |PrimitiveType|
    |Property|
    |RedefinableElement|
    |Relationship|
    |StructuralFeature|
    |Type|
    |TypedElement|
    |ValueSpecification|))

(in-package :mofi)

(WITH-SLOTS (ABSTRACT-CLASSES) *MODEL*
  (SETF ABSTRACT-CLASSES
        '(CMOF::|BehavioralFeature|
          CMOF::|Classifier|
          CMOF::|DirectedRelationship|
          CMOF::|Element|
          CMOF::|Feature|
          CMOF::|MultiplicityElement|
          CMOF::|NamedElement|
          CMOF::|Namespace|
          CMOF::|PackageableElement|
          CMOF::|RedefinableElement|
          CMOF::|Relationship|
          CMOF::|StructuralFeature|
          CMOF::|Type|
          CMOF::|TypedElement|
          CMOF::|ValueSpecification|)))