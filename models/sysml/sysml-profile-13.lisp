;;; Automatically created by pop-gen at 2012-08-31 15:47:58.
;;; Source file is 2012-04-07-SysML.xmi

(in-package :SYSML13)



(def-meta-enum |ControlValue| (:model :SYSML13 :superclasses NIL 
   :xmi-id "_SysML_Libraries_PackageableElement-ControlValues_PackageableElement-ControlValue_PackageableElement")
   (|disable| |enable|)
   "")



(def-meta-enum |FeatureDirection| (:model :SYSML13 :superclasses NIL 
   :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-FeatureDirection_PackageableElement")
   (|provided| |required| |providedRequired|)
   "")



(def-meta-enum |FlowDirection| (:model :SYSML13 :superclasses NIL 
   :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-FlowDirection_PackageableElement")
   (|in| |out| |inout|)
   "")



(def-meta-enum |VerdictKind| (:model :SYSML13 :superclasses NIL 
   :xmi-id "_SysML_Requirements_PackageableElement-VerdictKind_PackageableElement")
   (|pass| |fail| |inconclusive| |error|)
   "")



;;; =========================================================
;;; ====================== AcceptChangeStructuralFeatureEventAction
;;; =========================================================
(def-meta-stereotype |AcceptChangeStructuralFeatureEventAction| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|AcceptEventAction|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-AcceptChangeStructuralFeatureEventAction_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Allocate
;;; =========================================================
(def-meta-stereotype |Allocate| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Abstraction|)
 :packages (|SysML| |Allocations|) 
 :xmi-id "_SysML_Allocations_PackageableElement-Allocate_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== AllocateActivityPartition
;;; =========================================================
(def-meta-stereotype |AllocateActivityPartition| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ActivityPartition|)
 :packages (|SysML| |Allocations|) 
 :xmi-id "_SysML_Allocations_PackageableElement-AllocateActivityPartition_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Allocated
;;; =========================================================
(def-meta-stereotype |Allocated| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|NamedElement|)
 :packages (|SysML| |Allocations|) 
 :xmi-id "_SysML_Allocations_PackageableElement-Allocated_PackageableElement")
 ""
  ((|allocatedFrom| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|allocatedTo| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== BindingConnector
;;; =========================================================
(def-meta-stereotype |BindingConnector| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Connector|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-BindingConnector_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Block
;;; =========================================================
(def-meta-stereotype |Block| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Class|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-Block_PackageableElement")
 ""
  ((|isEncapsulated| :range |Boolean| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ChangeStructuralFeatureEvent
;;; =========================================================
(def-meta-stereotype |ChangeStructuralFeatureEvent| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ChangeEvent|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-ChangeStructuralFeatureEvent_PackageableElement")
 ""
  ((|structuralFeature| :range UML241:|StructuralFeature| :multiplicity (1 1) :soft-opposite (UML241:|StructuralFeature| |changeStructuralFeatureEvent|))))


;;; =========================================================
;;; ====================== Conform
;;; =========================================================
(def-meta-stereotype |Conform| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_ModelElements_PackageableElement-Conform_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== ConnectorProperty
;;; =========================================================
(def-meta-stereotype |ConnectorProperty| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-ConnectorProperty_PackageableElement")
 ""
  ((|connector| :range UML241:|Connector| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ConstraintBlock
;;; =========================================================
(def-meta-stereotype |ConstraintBlock| 
   (:model :SYSML13 :superclasses (|Block|) :extends NIL
 :packages (|SysML| |ConstraintBlocks|) 
 :xmi-id "_SysML_ConstraintBlocks_PackageableElement-ConstraintBlock_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== ConstraintProperty
;;; =========================================================
(def-meta-stereotype |ConstraintProperty| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Property|)
 :packages (|SysML| |ConstraintBlocks|) 
 :xmi-id "_SysML_ConstraintBlocks_PackageableElement-ConstraintProperty_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Continuous
;;; =========================================================
(def-meta-stereotype |Continuous| 
   (:model :SYSML13 :superclasses (|Rate|) :extends NIL
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Continuous_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== ControlOperator
;;; =========================================================
(def-meta-stereotype |ControlOperator| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Operation| UML241:|Behavior|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-ControlOperator_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Copy
;;; =========================================================
(def-meta-stereotype |Copy| 
   (:model :SYSML13 :superclasses (UML-PROFILE-L2-20110701:|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-Copy_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== DeriveReqt
;;; =========================================================
(def-meta-stereotype |DeriveReqt| 
   (:model :SYSML13 :superclasses (UML-PROFILE-L2-20110701:|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-DeriveReqt_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== DirectedFeature
;;; =========================================================
(def-meta-stereotype |DirectedFeature| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Feature|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-DirectedFeature_PackageableElement")
 ""
  ((|featureDirection| :range |FeatureDirection| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Discrete
;;; =========================================================
(def-meta-stereotype |Discrete| 
   (:model :SYSML13 :superclasses (|Rate|) :extends NIL
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Discrete_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== DistributedProperty
;;; =========================================================
(def-meta-stereotype |DistributedProperty| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-DistributedProperty_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== FlowPort
;;; =========================================================
(def-meta-stereotype |FlowPort| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Port|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_DeprecatedElements_PackageableElement-FlowPort_PackageableElement")
 ""
  ((|direction| :range |FlowDirection| :multiplicity (1 1))
   (|isAtomic| :range |Boolean| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== FlowProperty
;;; =========================================================
(def-meta-stereotype |FlowProperty| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Property|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-FlowProperty_PackageableElement")
 ""
  ((|direction| :range |FlowDirection| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== FlowSpecification
;;; =========================================================
(def-meta-stereotype |FlowSpecification| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Interface|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_DeprecatedElements_PackageableElement-FlowSpecification_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== FullPort
;;; =========================================================
(def-meta-stereotype |FullPort| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Port|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-FullPort_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== InterfaceBlock
;;; =========================================================
(def-meta-stereotype |InterfaceBlock| 
   (:model :SYSML13 :superclasses (|Block|) :extends NIL
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-InterfaceBlock_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== InvocationOnNestedPortAction
;;; =========================================================
(def-meta-stereotype |InvocationOnNestedPortAction| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|InvocationAction|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-InvocationOnNestedPortAction_PackageableElement")
 ""
  ((|onNestedPort| :range UML241:|Port| :multiplicity (1 -1) :is-ordered-p T :soft-opposite (UML241:|Port| |invocationOnNestedPortAction|))))


;;; =========================================================
;;; ====================== ItemFlow
;;; =========================================================
(def-meta-stereotype |ItemFlow| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|InformationFlow|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-ItemFlow_PackageableElement")
 ""
  ((|itemProperty| :range UML241:|Property| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== NestedConnectorEnd
;;; =========================================================
(def-meta-stereotype |NestedConnectorEnd| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ConnectorEnd|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-NestedConnectorEnd_PackageableElement")
 ""
  ((|propertyPath| :range UML241:|Property| :multiplicity (1 -1) :is-ordered-p T)))


;;; =========================================================
;;; ====================== NoBuffer
;;; =========================================================
(def-meta-stereotype |NoBuffer| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ObjectNode|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-NoBuffer_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Optional
;;; =========================================================
(def-meta-stereotype |Optional| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Parameter|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Optional_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Overwrite
;;; =========================================================
(def-meta-stereotype |Overwrite| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ObjectNode|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Overwrite_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== ParticipantProperty
;;; =========================================================
(def-meta-stereotype |ParticipantProperty| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-ParticipantProperty_PackageableElement")
 ""
  ((|end| :range UML241:|Property| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Probability
;;; =========================================================
(def-meta-stereotype |Probability| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|ParameterSet| UML241:|ActivityEdge|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Probability_PackageableElement")
 ""
  ((|probability| :range UML241:|ValueSpecification| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Problem
;;; =========================================================
(def-meta-stereotype |Problem| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Comment|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_ModelElements_PackageableElement-Problem_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== PropertySpecificType
;;; =========================================================
(def-meta-stereotype |PropertySpecificType| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Classifier|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-PropertySpecificType_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== ProxyPort
;;; =========================================================
(def-meta-stereotype |ProxyPort| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Port|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-ProxyPort_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== QuantityKind
;;; =========================================================
(def-meta-stereotype |QuantityKind| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-QuantityKind_PackageableElement")
 ""
  ((|definitionURI| :range |String| :multiplicity (0 1))
   (|description| :range |String| :multiplicity (0 1))
   (|symbol| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Rate
;;; =========================================================
(def-meta-stereotype |Rate| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Parameter| UML241:|ActivityEdge|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_Activities_PackageableElement-Rate_PackageableElement")
 ""
  ((|rate| :range UML241:|InstanceSpecification| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Rationale
;;; =========================================================
(def-meta-stereotype |Rationale| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Comment|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_ModelElements_PackageableElement-Rationale_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== Requirement
;;; =========================================================
(def-meta-stereotype |Requirement| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Class|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-Requirement_PackageableElement")
 ""
  ((|derived| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|derivedFrom| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|id| :range |String| :multiplicity (1 1))
   (|master| :range |Requirement| :multiplicity (0 1) :is-derived-p T)
   (|refinedBy| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|satisfiedBy| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|text| :range |String| :multiplicity (1 1))
   (|tracedTo| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|verifiedBy| :range UML241:|NamedElement| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== RequirementRelated
;;; =========================================================
(def-meta-stereotype |RequirementRelated| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|NamedElement|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-RequirementRelated_PackageableElement")
 ""
  ((|refines| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|satisfies| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|tracedFrom| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|verifies| :range |Requirement| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Satisfy
;;; =========================================================
(def-meta-stereotype |Satisfy| 
   (:model :SYSML13 :superclasses (UML-PROFILE-L2-20110701:|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-Satisfy_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== TestCase
;;; =========================================================
(def-meta-stereotype |TestCase| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Operation| UML241:|Behavior|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-TestCase_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== TriggerOnNestedPort
;;; =========================================================
(def-meta-stereotype |TriggerOnNestedPort| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Trigger|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_Ports_u0026Flows_PackageableElement-TriggerOnNestedPort_PackageableElement")
 ""
  ((|onNestedPort| :range UML241:|Port| :multiplicity (1 -1) :is-ordered-p T :soft-opposite (UML241:|Port| |triggerOnNestedPort|))))


;;; =========================================================
;;; ====================== Unit
;;; =========================================================
(def-meta-stereotype |Unit| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-Unit_PackageableElement")
 ""
  ((|definitionURI| :range |String| :multiplicity (0 1))
   (|description| :range |String| :multiplicity (0 1))
   (|quantityKind| :range |QuantityKind| :multiplicity (0 1) :soft-opposite (|QuantityKind| |unit|))
   (|symbol| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ValueType
;;; =========================================================
(def-meta-stereotype |ValueType| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|DataType|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_Blocks_PackageableElement-ValueType_PackageableElement")
 ""
  ((|quantityKind| :range |QuantityKind| :multiplicity (0 1) :soft-opposite (|QuantityKind| |valueType|))
   (|unit| :range |Unit| :multiplicity (0 1) :soft-opposite (|Unit| |valueType|))))


;;; =========================================================
;;; ====================== Verify
;;; =========================================================
(def-meta-stereotype |Verify| 
   (:model :SYSML13 :superclasses (UML-PROFILE-L2-20110701:|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_Requirements_PackageableElement-Verify_PackageableElement")
 ""
  ())


;;; =========================================================
;;; ====================== View
;;; =========================================================
(def-meta-stereotype |View| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Package|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_ModelElements_PackageableElement-View_PackageableElement")
 ""
  ((|viewPoint| :range |Viewpoint| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Viewpoint
;;; =========================================================
(def-meta-stereotype |Viewpoint| 
   (:model :SYSML13 :superclasses NIL :extends (UML241:|Class|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_ModelElements_PackageableElement-Viewpoint_PackageableElement")
 ""
  ((|concerns| :range |String| :multiplicity (0 -1))
   (|languages| :range |String| :multiplicity (0 -1))
   (|methods| :range |String| :multiplicity (0 -1))
   (|purpose| :range |String| :multiplicity (1 1))
   (|stakeholders| :range |String| :multiplicity (0 -1))))


(def-meta-package |Activities| |SysML| :SYSML13 
   (|Probability|
    |Optional|
    |NoBuffer|
    |Rate|
    |ControlOperator|
    |Continuous|
    |Overwrite|
    |Discrete|) :xmi-id "_SysML_Activities_PackageableElement")

(def-meta-package |Allocations| |SysML| :SYSML13 
   (|AllocateActivityPartition|
    |Allocate|
    |Allocated|) :xmi-id "_SysML_Allocations_PackageableElement")

(def-meta-package |Blocks| |SysML| :SYSML13 
   (|DistributedProperty|
    |PropertySpecificType|
    |ParticipantProperty|
    |ValueType|
    |QuantityKind|
    |Block|
    |ConnectorProperty|
    |Unit|
    |NestedConnectorEnd|
    |BindingConnector|) :xmi-id "_SysML_Blocks_PackageableElement")

(def-meta-package |ConstraintBlocks| |SysML| :SYSML13 
   (|ConstraintBlock|
    |ConstraintProperty|) :xmi-id "_SysML_ConstraintBlocks_PackageableElement")

(def-meta-package |ControlValues| |Libraries| :SYSML13 
   (|ControlValue|) :xmi-id "_SysML_Libraries_PackageableElement-ControlValues_PackageableElement")

(def-meta-package |DeprecatedElements| |SysML| :SYSML13 
   (|FlowPort|
    |FlowSpecification|) :xmi-id "_SysML_DeprecatedElements_PackageableElement")

(def-meta-package |Libraries| |SysML| :SYSML13 
   (|PrimitiveValueTypes|
    |ControlValues|) :xmi-id "_SysML_Libraries_PackageableElement")

(def-meta-package |ModelElements| |SysML| :SYSML13 
   (|Viewpoint|
    |Rationale|
    |Conform|
    |View|
    |Problem|) :xmi-id "_SysML_ModelElements_PackageableElement")

(def-meta-package |Ports&Flows| |SysML| :SYSML13 
   (|FlowDirection|
    |FullPort|
    |ProxyPort|
    |FlowProperty|
    |ItemFlow|
    |InterfaceBlock|
    |InvocationOnNestedPortAction|
    |TriggerOnNestedPort|
    |AcceptChangeStructuralFeatureEventAction|
    |ChangeStructuralFeatureEvent|
    |DirectedFeature|
    |FeatureDirection|) :xmi-id "_SysML_Ports_u0026Flows_PackageableElement")

(def-meta-package |PrimitiveValueTypes| |Libraries| :SYSML13 
   () :xmi-id "_SysML_Libraries_PackageableElement-PrimitiveValueTypes_PackageableElement")

(def-meta-package |Requirements| |SysML| :SYSML13 
   (|Requirement|
    |Verify|
    |TestCase|
    |Satisfy|
    |VerdictKind|
    |RequirementRelated|
    |DeriveReqt|
    |Copy|) :xmi-id "_SysML_Requirements_PackageableElement")

(def-meta-package |StandardProfileL2| NIL :SYSML13 
   () :xmi-id NIL)

(def-meta-package |SysML| NIL :SYSML13 
   (|Ports&Flows|
    |DeprecatedElements|
    |Allocations|
    |Blocks|
    |ConstraintBlocks|
    |Requirements|
    |Activities|
    |ModelElements|
    |Libraries|) :xmi-id "_SysML__0")

(def-meta-package UML\ 2.4.1 NIL :SYSML13 
   () :xmi-id NIL)

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '())
     (setf mofi:ns-uri "http://www.omg.org/spec/SysML/20110919/SysML-profile")
     (setf mofi:ns-prefix "sysml"))