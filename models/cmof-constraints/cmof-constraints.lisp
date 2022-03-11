
;;; Original author: Nicolas.F.Rouquette@jpl.nasa.gov
;;; December 2010
;;; Lisp wrapping: Peter Denno
;;; October 2012

;;; This Complete OCL document is edited using an Eclipse XText-based OCL Editor in the UML-RTF project.
;;; The reference below corresponds to the Eclipse EMF-exported version of UML2.4 merged at L3.
;;; the uml.ecore file is not 100% accurate but it is adequate for defining the CMOF constraints for MOF2.4.

;;; I won't set the package. I'll need to compile this for every UML.

(def-meta-constraint "CMOF_14_3_1" |Association|
  "14.3 [1] The multiplicity of Association::memberEnd is limited to 2 rather than 2..* 
   (i.e., n-ary Associations are not supported); 
   unlike EMOF, CMOF associations can have navigable association-owned ends.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/association-does-not-have-two-member-ends" 
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "memberEnd->size() = 2 and ownedEnd->size() < 2")
	

(def-meta-constraint "CMOF_14_3_2" |Operation|
  "14.3 [2] The type of Operation::raisedException is limited to be Class rather than Type.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/operation-has-non-class-exception"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "raisedException->forAll(e | e.oclIsTypeOf(Class))")
	

(def-meta-constraint "CMOF_14_3_6" |NamedElement|
  "14.3 [6] Names are required for all NamedElements except for ValueSpecifications.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/named-element-has-no-name"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body " not oclIsKindOf(ValueSpecification) implies (name <> null and name->notEmpty())")

(def-meta-constraint "CMOF_14_3_7a" |NamedElement|
  "14.3 [7] CMOF does not support visibilities. All property visibilities must be explicitly set to 
   public where applicable, that is for all NamedElements, ElementImports and PackageImports. 
   Furthermore, no alias is allowed for any ElementImport.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/named-element-is-not-public"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "visibility = VisibilityKind::public")
	
(def-meta-constraint "CMOF_14_3_7b" |ElementImport|
  "see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/element-import-is-not-public
  see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/element-import-has-alias"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "visibility = VisibilityKind::public and alias->isEmpty()")
	
(def-meta-constraint "CMOF_14_3_7c" |PackageImport|
  "see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/package-import-is-not-public"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "visibility = VisibilityKind::public")
	

(def-meta-constraint "CMOF_14_3_8" |Enumeration|
  "14.3 [8] Enumerations may not have attributes or operations
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/enumeration-has-attributes
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/enumeration-has-operations"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "feature->isEmpty()")

(def-meta-operation "isWithinCMOFSubset" |Element|	
  ""
  ;; constraint-gf is used to identify where this belongs, though of course gf not used.
  :constraint-gf ocl:ocl-constraints-cmof 
  :operation-body "
	self.oclIsKindOf(Association) or
	self.oclIsKindOf(Class) or
	self.oclIsKindOf(Comment) or
	self.oclIsKindOf(Constraint) or
	self.oclIsKindOf(DataType) or
	self.oclIsKindOf(ElementImport) or
	self.oclIsKindOf(Enumeration) or
	self.oclIsKindOf(EnumerationLiteral) or
	self.oclIsKindOf(Generalization) or
	self.oclIsKindOf(InstanceValue) or
	self.oclIsKindOf(LiteralBoolean) or
	self.oclIsKindOf(LiteralInteger) or
	self.oclIsKindOf(LiteralNull) or
	self.oclIsKindOf(LiteralReal) or
	self.oclIsKindOf(LiteralString) or
	self.oclIsKindOf(LiteralUnlimitedNatural) or
	self.oclIsKindOf(OpaqueExpression) or
	self.oclIsKindOf(Operation) or
	self.oclIsKindOf(Package) or
	self.oclIsKindOf(PackageImport) or
	self.oclIsKindOf(PackageMerge) or
	self.oclIsKindOf(Parameter) or
	self.oclIsKindOf(PrimitiveType) or
	self.oclIsKindOf(Property)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)))

	
(def-meta-constraint "CMOF_14_3_9" |Package|
  "[9] A CMOF metamodel is restricted to use the concrete metaclasses from UML's Kernel"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-status :rewritten
  :editor-note "not investigated"
  :original-body "self->closure(ownedElement)->forAll(e | e.Element::isWithinCMOFSubset())"
  :operation-body "self->closure(ownedElement)->forAll(e | e.isWithinCMOFSubset())")

(def-meta-constraint "CMOF_14_3_10a" |Class|	
  "14.3 [10] The following properties must be empty
	Class::nestedClassifier
	Property::qualifier
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/class-has-nested-classifier"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "nestedClassifier->isEmpty()")

(def-meta-constraint "CMOF_14_3_10b" |Property|	
 "see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-qualifier"
 :constraint-gf ocl:ocl-constraints-cmof
 :operation-body "qualifier->isEmpty()")

(def-meta-constraint "CMOF_14_3_11" |Feature|	
  "14.3 [11] The value of Feature::isStatic must be false"
  :constraint-gf ocl:ocl-constraints-cmof
 :operation-body "not isStatic")

(def-meta-constraint "CMOF_14_3_12a" |Parameter|	
  "14.3 [12] A multi-valued Property or Parameter cannot have a default value. 
   The default value of a Property or Parameter typed by a PrimitiveType must be a kind of LiteralSpecification. 
   The default value of a Property or Parameter typed by an Enumeration must be a kind of InstanceValue. 
   A Property or Parameter typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-has-invalid-default-value
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-invalid-default-value"
  :constraint-gf ocl:ocl-constraints-cmof
   :operation-body "(upperBound() > 1 or type.oclIsKindOf(Class) implies defaultValue->isEmpty())")

(def-meta-constraint "CMOF_14_3_12b" |Parameter|	
  "14.3 [12] A multi-valued Property or Parameter cannot have a default value. 
   The default value of a Property or Parameter typed by a PrimitiveType must be a kind of LiteralSpecification. 
   The default value of a Property or Parameter typed by an Enumeration must be a kind of InstanceValue. 
   A Property or Parameter typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-has-invalid-default-value
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-invalid-default-value"
   :operation-body "defaultValue->notEmpty() implies 
 	(upperBound() <= 1 and
	 ((type.oclIsKindOf(PrimitiveType) and defaultValue.oclIsKindOf(LiteralSpecification)) or
	  (type.oclIsKindOf(Enumeration) and defaultValue.oclIsKindOf(InstanceValue))))")

(def-meta-constraint "CMOF_14_3_12c" |Property|	
  "14.3 [12] A multi-valued Property or Parameter cannot have a default value. 
   The default value of a Property or Parameter typed by a PrimitiveType must be a kind of LiteralSpecification. 
   The default value of a Property or Parameter typed by an Enumeration must be a kind of InstanceValue. 
   A Property or Parameter typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-has-invalid-default-value
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-invalid-default-value"
  :constraint-gf ocl:ocl-constraints-cmof
   :operation-body "(upperBound() > 1 or type.oclIsKindOf(Class) implies defaultValue->isEmpty())")

(def-meta-constraint "CMOF_14_3_12d" |Property|	
  "14.3 [12] A multi-valued Property or Parameter cannot have a default value. 
   The default value of a Property or Parameter typed by a PrimitiveType must be a kind of LiteralSpecification. 
   The default value of a Property or Parameter typed by an Enumeration must be a kind of InstanceValue. 
   A Property or Parameter typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-has-invalid-default-value
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-invalid-default-value"
  :constraint-gf ocl:ocl-constraints-cmof
   :operation-body "defaultValue->notEmpty() implies 
 	(upperBound() <= 1 and
	 ((type.oclIsKindOf(PrimitiveType) and defaultValue.oclIsKindOf(LiteralSpecification)) or
	  (type.oclIsKindOf(Enumeration) and defaultValue.oclIsKindOf(InstanceValue))))")

(def-meta-constraint "CMOF_14_3_13" |MultiplicityElement|		  
  "14.3 [13] The values of MultiplicityElement::lowerValue and upperValue must be of kind LiteralInteger 
   and LiteralUnlimitedNatural respectively
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/multiplicity-element-has-non-integer-lower-value
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/multiplicity-element-has-non-unlimited-natural-upper-value"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "lowerValue.oclIsKindOf(LiteralInteger) and upperValue.oclIsKindOf(LiteralUnlimitedNatural)")

(def-meta-constraint "CMOF_14_3_14" |Generalization|		  
  "14.3 [14] Generalization::isSubstitutable must be true "
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "isSubstitutable = true")

;;; POD Appears not to be used. So I'm commenting it out to be sure it doesn't interfere. (Its an operation.)
;(def-mm-operation "allAttributes" |Generalization|		  
;  ""
;  :operation-body "self->closure(general)->union(self)->attribute->asSet()"
;  :parameters
;  (list (make-instance 'ocl-parameter :parameter-name NIL ; POD not sure I ever did :p-type as collection!
;		       :parameter-type (make-instance 'ocl:set-typ :base-type '|Property|)
;		       :parameter-return-p T)))

(def-meta-constraint "CMOF_14_3_15" |Class|		  
  "14.3 [15] Only one member attribute of a Class may have isId=true. 
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/class-has-more-than-one-id"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "self->closure(general)->union(self)->attribute->asSet()->select(p:Property | p.isID)->size() < 2")

;;; Was commented out in Nicolas's too.
;(def-meta-constraint CMOF_14_3_15b |Class|		  
;  "14.3 [15] Only one member attribute of a Class may have isId=true. 
;   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/class-has-more-than-one-id"
;  :constraint-gf ocl:ocl-constraints-cmof
;  :operation-body "self.Classifier::allAttributes->select(p:Property | p.isID)->size() < 2")

(def-meta-constraint "CMOF_14_3_16" |Property|		  
  "14.3 [16] Property::aggregation must be either 'none' or 'composite'
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/property-has-shared-aggregation"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "aggregation = AggregationKind::composite or aggregation = AggregationKind::none")

(def-meta-constraint "CMOF_14_3_17" |BehavioralFeature|		  
  "14.3 [17] BehavioralFeature must be sequential
   https://sites.google.com/site/metamodelingantipatterns/catalog/mof/behavioral-feature-is-not-sequential"
  :operation-body "concurrency = CallConcurrencyKind::sequential")

(def-meta-constraint "CMOF_14_3_18" |Class|		  
   "14.3 [18] Class must not be active
    see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/class-is-active"
   :constraint-gf ocl:ocl-constraints-cmof
   :operation-body "not isActive")

(def-meta-constraint "CMOF_14_3_17a" |Operation|		  
  "14.3 [17] An Operation can have up to one Parameter whose direction is 'return'; 
   furthermore, an Operation cannot have any ParameterSet per 12.4 [8]."
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "ownedParameter->select(direction = ParameterDirectionKind::return)->size() < 2 and 
         ownedParameterSet->isEmpty()")

(def-meta-constraint "CMOF_14_3_18a" |Comment|		  
  "14.3 [18] Comments may only annotate instances of NamedElement"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "annotatedElement->forAll(e | e.oclIsKindOf(NamedElement))")

(def-meta-constraint "CMOF_14_3_19" |EnumerationLiteral|		  
  "14.3 [19] An EnumerationLiteral must not have a ValueSpecification
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/enumeration-literal-has-specification"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "specification->isEmpty()")

(def-meta-constraint "CMOF_14_3_20" |Parameter|		  
  "14.3 [20] An Operation Parameter must have no effect, exception or streaming characteristics
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-has-effect
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/parameter-is-exception"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "effect->isEmpty() and not (isException or isStream)")

(def-meta-constraint "CMOF_14_3_21" |TypedElement|		  
  "14.3 [21] A TypedElement cannot be typed by an Association
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-has-association-type"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "not type.oclIsKindOf(Association)")

(def-meta-constraint "CMOF_14_3_22" |TypedElement|		  
  "14.3 [22] A TypedElement other than a LiteralSpecification or an OpaqueExpression must have a Type
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-has-no-type"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "not (oclIsKindOf(LiteralSpecification) or oclIsKindOf(OpaqueExpression)) implies type->notEmpty()")

(def-meta-constraint "CMOF_14_3_23a" |Parameter|		  
  "14.3 [23] A TypedElement that is a kind of Parameter or Property typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-complex-with-default-value"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(Class) implies defaultValue->isEmpty()")

(def-meta-constraint "CMOF_14_3_23b" |Property|		  
  "14.3 [23] A TypedElement that is a kind of Parameter or Property typed by a Class cannot have a default value.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-complex-with-default-value"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(Class) implies defaultValue->isEmpty()")

(def-meta-constraint "CMOF_14_3_24" |Parameter|		  
  "14.3 [24] For a TypedElement that is a kind of Parameter or Property typed by an Enumeration, 
   the defaultValue, if any, must be a kind of InstanceValue.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-enumeration-with-non-instance-value-default"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(Enumeration) and defaultValue->notEmpty() implies defaultValue.oclIsKindOf(InstanceValue)")

(def-meta-constraint "CMOF_14_3_24b" |Property|		  
  "14.3 [24] For a TypedElement that is a kind of Parameter or Property typed by an Enumeration, 
   the defaultValue, if any, must be a kind of InstanceValue.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-enumeration-with-non-instance-value-default"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(Enumeration) and defaultValue->notEmpty() implies defaultValue.oclIsKindOf(InstanceValue)")

(def-meta-constraint "CMOF_14_3_25a" |Parameter|		  
  "14.3 [25] For a TypedElement that is a kind of Parameter or Property typed by an PrimitiveType,
   the defaultValue, if any, must be a kind of LiteralSpecification.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-primitive-with-non-literal-default"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(PrimitiveType) and defaultValue->notEmpty() 
         implies defaultValue.oclIsKindOf(LiteralSpecification)")

(def-meta-constraint "CMOF_14_3_25b" |Property|		  
  "14.3 [25] For a TypedElement that is a kind of Parameter or Property typed by an PrimitiveType,
   the defaultValue, if any, must be a kind of LiteralSpecification.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/typed-element-is-primitive-with-non-literal-default"
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(PrimitiveType) and defaultValue->notEmpty() 
         implies defaultValue.oclIsKindOf(LiteralSpecification)")

(def-meta-constraint "CMOF_14_3_26" |Property|		  
  "14.3 [26] A composite subsetting Property with mandatory multiplicity cannot subset 
   another composite Property with mandatory multiplicity."
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "isComposite and lowerBound() = 1 implies subsettedProperty->forAll(not (isComposite and lowerBound() = 1))")

(def-meta-constraint "CMOF_14_3_27" |Property|		  
  "14.3 [27] A Property typed by a kind of DataType must have aggregation = none."
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "type.oclIsKindOf(DataType) implies aggregation = AggregationKind::none")

(def-meta-constraint "CMOF_14_3_28" |DataType|		  
  "14.3 [28] A Property owned by a DataType can only be typed by a DataType."
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "ownedAttribute.type.oclIsKindOf(DataType)")

(def-meta-constraint "CMOF_14_3_29" |Association|		  
  "14.3 [29] Each Association memberEnd Property must be typed by a Class."
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "memberEnd.type.oclIsKindOf(Class)")

(def-meta-constraint "CMOF_14_3_30" |Constraint|		  
  "14.3 [30] A Constraint must constrain at least one element and must be specified via an OpaqueExpression.
   see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/constraint-specification-is-not-opaque-expression" 
  :constraint-gf ocl:ocl-constraints-cmof
  :operation-body "constrainedElement->notEmpty() and specification.oclIsKindOf(OpaqueExpression)")

(def-meta-constraint "CMOF_14_3_31" |OpaqueExpression|		  
  "14.3 [31] The body of an OpaqueExpression must not be empty.
  see also: https://sites.google.com/site/metamodelingantipatterns/catalog/mof/opaque-expression-has-no-or-empty-body"
  :constraint-gf ocl:ocl-constraints-cmof       
  :operation-body "body->notEmpty() and body <> ''")

