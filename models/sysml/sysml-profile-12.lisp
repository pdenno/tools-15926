;;; Automatically created by pop-gen at 2013-12-30 15:43:41.
;;; Source file is sysml-profile.xmi

(in-package :SYSML12)



(def-meta-enum |FlowDirection| (:model :SYSML12 :superclasses NIL 
   :xmi-id "FlowDirection")
   (|in| |out| |inout|)
   "")



(def-meta-enum |VerdictKind| (:model :SYSML12 :superclasses NIL 
   :xmi-id "VerdictKind")
   (|pass| |fail| |inconclusive| |error|)
   "")

;;; POD Added
(def-meta-enum |ControlValue| (:model :SYSML12 :superclasses NIL 
   :xmi-id "VerdictKind")
   (|disable| |enable|)
   "")


;;; =========================================================
;;; ====================== Allocate
;;; =========================================================
(def-meta-stereotype |Allocate| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Abstraction|)
 :packages (|SysML|) 
 :xmi-id "Allocate")
 ""
  ((|base_Abstraction| :xmi-id "Allocate-base_Abstraction"
    :range UML23:|Abstraction| :multiplicity (1 1))))

(def-meta-assoc "Abstraction_Allocate"      
  :name |Abstraction_Allocate|      
  :metatype :extension      
  :member-ends (("Abstraction_Allocate-extension_Allocate" "extension_Allocate")
                (|Allocate| "base_Abstraction"))      
  :owned-ends  (("Abstraction_Allocate-extension_Allocate" "extension_Allocate")))

(def-meta-assoc-end "Abstraction_Allocate-extension_Allocate" 
    :type |Allocate| 
    :multiplicity (0 1) 
    :association "Abstraction_Allocate" 
    :name "extension_Allocate" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== AllocateActivityPartition
;;; =========================================================
(def-meta-stereotype |AllocateActivityPartition| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|ActivityPartition|)
 :packages (|SysML|) 
 :xmi-id "AllocateActivityPartition")
 ""
  ((|base_ActivityPartition| :xmi-id "AllocateActivityPartition-base_ActivityPartition"
    :range UML23:|ActivityPartition| :multiplicity (1 1))))

(def-meta-assoc "ActivityPartition_AllocateActivityPartition"      
  :name |ActivityPartition_AllocateActivityPartition|      
  :metatype :extension      
  :member-ends (("ActivityPartition_AllocateActivityPartition-extension_AllocateActivityPartition" "extension_AllocateActivityPartition")
                (|AllocateActivityPartition| "base_ActivityPartition"))      
  :owned-ends  (("ActivityPartition_AllocateActivityPartition-extension_AllocateActivityPartition" "extension_AllocateActivityPartition")))

(def-meta-assoc-end "ActivityPartition_AllocateActivityPartition-extension_AllocateActivityPartition" 
    :type |AllocateActivityPartition| 
    :multiplicity (0 1) 
    :association "ActivityPartition_AllocateActivityPartition" 
    :name "extension_AllocateActivityPartition" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Allocated
;;; =========================================================
(def-meta-stereotype |Allocated| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|NamedElement|)
 :packages (|SysML|) 
 :xmi-id "Allocated")
 ""
  ((|AllocatedFrom| :xmi-id "Allocated-AllocatedFrom"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|AllocatedTo| :xmi-id "Allocated-AllocatedTo"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|base_NamedElement| :xmi-id "Allocated-base_NamedElement"
    :range UML23:|NamedElement| :multiplicity (1 1))))

(def-meta-assoc "NamedElement_Allocated"      
  :name |NamedElement_Allocated|      
  :metatype :extension      
  :member-ends (("NamedElement_Allocated-extension_Allocated" "extension_Allocated")
                (|Allocated| "base_NamedElement"))      
  :owned-ends  (("NamedElement_Allocated-extension_Allocated" "extension_Allocated")))

(def-meta-assoc-end "NamedElement_Allocated-extension_Allocated" 
    :type |Allocated| 
    :multiplicity (0 1) 
    :association "NamedElement_Allocated" 
    :name "extension_Allocated" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== BindingConnector
;;; =========================================================
(def-meta-stereotype |BindingConnector| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Connector|)
 :packages (|SysML|) 
 :xmi-id "BindingConnector")
 ""
  ((|base_Connector| :xmi-id "BindingConnector-base_Connector"
    :range UML23:|Connector| :multiplicity (1 1))))

(def-meta-assoc "Connector_BindingConnector"      
  :name |Connector_BindingConnector|      
  :metatype :extension      
  :member-ends (("Connector_BindingConnector-extension_BindingConnector" "extension_BindingConnector")
                (|BindingConnector| "base_Connector"))      
  :owned-ends  (("Connector_BindingConnector-extension_BindingConnector" "extension_BindingConnector")))

(def-meta-assoc-end "Connector_BindingConnector-extension_BindingConnector" 
    :type |BindingConnector| 
    :multiplicity (0 1) 
    :association "Connector_BindingConnector" 
    :name "extension_BindingConnector" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Block
;;; =========================================================
(def-meta-stereotype |Block| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Class|)
 :packages (|SysML|) 
 :xmi-id "Block")
 ""
  ((|base_Class| :xmi-id "Block-base_Class"
    :range UML23:|Class| :multiplicity (1 1))
   (|isEncapsulated| :xmi-id "Block-isEncapsulated"
    :range |Boolean| :multiplicity (1 1))))

(def-meta-assoc "Class_Block"      
  :name |Class_Block|      
  :metatype :extension      
  :member-ends (("Class_Block-extension_Block" "extension_Block")
                (|Block| "base_Class"))      
  :owned-ends  (("Class_Block-extension_Block" "extension_Block")))

(def-meta-assoc-end "Class_Block-extension_Block" 
    :type |Block| 
    :multiplicity (0 1) 
    :association "Class_Block" 
    :name "extension_Block" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Conform
;;; =========================================================
(def-meta-stereotype |Conform| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Dependency|)
 :packages (|SysML|) 
 :xmi-id "Conform")
 ""
  ((|base_Dependency| :xmi-id "Conform-base_Dependency"
    :range UML23:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "Dependency_Conform"      
  :name |Dependency_Conform|      
  :metatype :extension      
  :member-ends (("Dependency_Conform-extension_Conform" "extension_Conform")
                (|Conform| "base_Dependency"))      
  :owned-ends  (("Dependency_Conform-extension_Conform" "extension_Conform")))

(def-meta-assoc-end "Dependency_Conform-extension_Conform" 
    :type |Conform| 
    :multiplicity (0 1) 
    :association "Dependency_Conform" 
    :name "extension_Conform" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ConnectorProperty
;;; =========================================================
(def-meta-stereotype |ConnectorProperty| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Property|)
 :packages (|SysML|) 
 :xmi-id "ConnectorProperty")
 ""
  ((|base_Property| :xmi-id "ConnectorProperty-base_Property"
    :range UML23:|Property| :multiplicity (1 1))
   (|connector| :xmi-id "ConnectorProperty-connector"
    :range UML23:|Connector| :multiplicity (0 1))))

(def-meta-assoc "Property_ConnectorProperty"      
  :name |Property_ConnectorProperty|      
  :metatype :extension      
  :member-ends (("Property_ConnectorProperty-extension_ConnectorProperty" "extension_ConnectorProperty")
                (|ConnectorProperty| "base_Property"))      
  :owned-ends  (("Property_ConnectorProperty-extension_ConnectorProperty" "extension_ConnectorProperty")))

(def-meta-assoc-end "Property_ConnectorProperty-extension_ConnectorProperty" 
    :type |ConnectorProperty| 
    :multiplicity (0 1) 
    :association "Property_ConnectorProperty" 
    :name "extension_ConnectorProperty" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ConstraintBlock
;;; =========================================================
(def-meta-stereotype |ConstraintBlock| 
   (:model :SYSML12 :superclasses (|Block|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "ConstraintBlock")
 ""
  ())

;;; =========================================================
;;; ====================== ConstraintProperty
;;; =========================================================
(def-meta-stereotype |ConstraintProperty| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Property|)
 :packages (|SysML|) 
 :xmi-id "ConstraintProperty")
 ""
  ((|base_Property| :xmi-id "ConstraintProperty-base_Property"
    :range UML23:|Property| :multiplicity (1 1))))

(def-meta-assoc "Property_ConstraintProperty"      
  :name |Property_ConstraintProperty|      
  :metatype :extension      
  :member-ends (("Property_ConstraintProperty-extension_ConstraintProperty" "extension_ConstraintProperty")
                (|ConstraintProperty| "base_Property"))      
  :owned-ends  (("Property_ConstraintProperty-extension_ConstraintProperty" "extension_ConstraintProperty")))

(def-meta-assoc-end "Property_ConstraintProperty-extension_ConstraintProperty" 
    :type |ConstraintProperty| 
    :multiplicity (0 1) 
    :association "Property_ConstraintProperty" 
    :name "extension_ConstraintProperty" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Continuous
;;; =========================================================
(def-meta-stereotype |Continuous| 
   (:model :SYSML12 :superclasses (|Rate|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "Continuous")
 ""
  ())

;;; =========================================================
;;; ====================== ControlOperator
;;; =========================================================
(def-meta-stereotype |ControlOperator| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Operation| UML23:|Behavior|)
 :packages (|SysML|) 
 :xmi-id "ControlOperator")
 ""
  ((|base_Behavior| :xmi-id "ControlOperator-base_Behavior"
    :range UML23:|Behavior| :multiplicity (1 1))
   (|base_Operation| :xmi-id "ControlOperator-base_Operation"
    :range UML23:|Operation| :multiplicity (1 1))))

(def-meta-assoc "Behavior_ControlOperator"      
  :name |Behavior_ControlOperator|      
  :metatype :extension      
  :member-ends (("Behavior_ControlOperator-extension_ControlOperator" "extension_ControlOperator")
                (|ControlOperator| "base_Behavior"))      
  :owned-ends  (("Behavior_ControlOperator-extension_ControlOperator" "extension_ControlOperator")))

(def-meta-assoc-end "Behavior_ControlOperator-extension_ControlOperator" 
    :type |ControlOperator| 
    :multiplicity (0 1) 
    :association "Behavior_ControlOperator" 
    :name "extension_ControlOperator" 
    :aggregation :COMPOSITE)

(def-meta-assoc "Operation_ControlOperator"      
  :name |Operation_ControlOperator|      
  :metatype :extension      
  :member-ends (("Operation_ControlOperator-extension_ControlOperator" "extension_ControlOperator")
                (|ControlOperator| "base_Operation"))      
  :owned-ends  (("Operation_ControlOperator-extension_ControlOperator" "extension_ControlOperator")))

(def-meta-assoc-end "Operation_ControlOperator-extension_ControlOperator" 
    :type |ControlOperator| 
    :multiplicity (0 1) 
    :association "Operation_ControlOperator" 
    :name "extension_ControlOperator" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Copy
;;; =========================================================
(def-meta-stereotype |Copy| 
   (:model :SYSML12 :superclasses (|Trace|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "Copy")
 ""
  ())

;;; =========================================================
;;; ====================== DeriveReqt
;;; =========================================================
(def-meta-stereotype |DeriveReqt| 
   (:model :SYSML12 :superclasses (|Trace|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "DeriveReqt")
 ""
  ())

;;; =========================================================
;;; ====================== Discrete
;;; =========================================================
(def-meta-stereotype |Discrete| 
   (:model :SYSML12 :superclasses (|Rate|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "Discrete")
 ""
  ())

;;; =========================================================
;;; ====================== DistributedProperty
;;; =========================================================
(def-meta-stereotype |DistributedProperty| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Property|)
 :packages (|SysML|) 
 :xmi-id "DistributedProperty")
 ""
  ((|base_Property| :xmi-id "DistributedProperty-base_Property"
    :range UML23:|Property| :multiplicity (1 1))))

(def-meta-assoc "Property_DistributedProperty"      
  :name |Property_DistributedProperty|      
  :metatype :extension      
  :member-ends (("Property_DistributedProperty-extension_DistributedProperty" "extension_DistributedProperty")
                (|DistributedProperty| "base_Property"))      
  :owned-ends  (("Property_DistributedProperty-extension_DistributedProperty" "extension_DistributedProperty")))

(def-meta-assoc-end "Property_DistributedProperty-extension_DistributedProperty" 
    :type |DistributedProperty| 
    :multiplicity (0 1) 
    :association "Property_DistributedProperty" 
    :name "extension_DistributedProperty" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== FlowPort
;;; =========================================================
(def-meta-stereotype |FlowPort| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Port|)
 :packages (|SysML|) 
 :xmi-id "FlowPort")
 ""
  ((|base_Port| :xmi-id "FlowPort-base_Port"
    :range UML23:|Port| :multiplicity (1 1))
   (|direction| :xmi-id "FlowPort-direction"
    :range |FlowDirection| :multiplicity (1 1))
   (|isAtomic| :xmi-id "FlowPort-isAtomic"
    :range |Boolean| :multiplicity (1 1) :is-derived-p T)))

(def-meta-assoc "Port_FlowPort"      
  :name |Port_FlowPort|      
  :metatype :extension      
  :member-ends (("Port_FlowPort-extension_FlowPort" "extension_FlowPort")
                (|FlowPort| "base_Port"))      
  :owned-ends  (("Port_FlowPort-extension_FlowPort" "extension_FlowPort")))

(def-meta-assoc-end "Port_FlowPort-extension_FlowPort" 
    :type |FlowPort| 
    :multiplicity (0 1) 
    :association "Port_FlowPort" 
    :name "extension_FlowPort" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== FlowProperty
;;; =========================================================
(def-meta-stereotype |FlowProperty| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Property|)
 :packages (|SysML|) 
 :xmi-id "FlowProperty")
 ""
  ((|base_Property| :xmi-id "FlowProperty-base_Property"
    :range UML23:|Property| :multiplicity (1 1))
   (|direction| :xmi-id "FlowProperty-direction"
    :range |FlowDirection| :multiplicity (1 1))))

(def-meta-assoc "Property_FlowProperty"      
  :name |Property_FlowProperty|      
  :metatype :extension      
  :member-ends (("Property_FlowProperty-extension_FlowProperty" "extension_FlowProperty")
                (|FlowProperty| "base_Property"))      
  :owned-ends  (("Property_FlowProperty-extension_FlowProperty" "extension_FlowProperty")))

(def-meta-assoc-end "Property_FlowProperty-extension_FlowProperty" 
    :type |FlowProperty| 
    :multiplicity (0 1) 
    :association "Property_FlowProperty" 
    :name "extension_FlowProperty" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== FlowSpecification
;;; =========================================================
(def-meta-stereotype |FlowSpecification| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Interface|)
 :packages (|SysML|) 
 :xmi-id "FlowSpecification")
 ""
  ((|base_Interface| :xmi-id "FlowSpecification-base_Interface"
    :range UML23:|Interface| :multiplicity (1 1))))

(def-meta-assoc "Interface_FlowSpecification"      
  :name |Interface_FlowSpecification|      
  :metatype :extension      
  :member-ends (("Interface_FlowSpecification-extension_FlowSpecification" "extension_FlowSpecification")
                (|FlowSpecification| "base_Interface"))      
  :owned-ends  (("Interface_FlowSpecification-extension_FlowSpecification" "extension_FlowSpecification")))

(def-meta-assoc-end "Interface_FlowSpecification-extension_FlowSpecification" 
    :type |FlowSpecification| 
    :multiplicity (0 1) 
    :association "Interface_FlowSpecification" 
    :name "extension_FlowSpecification" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ItemFlow
;;; =========================================================
(def-meta-stereotype |ItemFlow| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|InformationFlow|)
 :packages (|SysML|) 
 :xmi-id "ItemFlow")
 ""
  ((|ItemProperty| :xmi-id "ItemFlow-ItemProperty"
    :range UML23:|Property| :multiplicity (0 1))
   (|base_InformationFlow| :xmi-id "ItemFlow-base_InformationFlow"
    :range UML23:|InformationFlow| :multiplicity (1 1))))

(def-meta-assoc "InformationFlow_ItemFlow"      
  :name |InformationFlow_ItemFlow|      
  :metatype :extension      
  :member-ends (("InformationFlow_ItemFlow-extension_ItemFlow" "extension_ItemFlow")
                (|ItemFlow| "base_InformationFlow"))      
  :owned-ends  (("InformationFlow_ItemFlow-extension_ItemFlow" "extension_ItemFlow")))

(def-meta-assoc-end "InformationFlow_ItemFlow-extension_ItemFlow" 
    :type |ItemFlow| 
    :multiplicity (0 1) 
    :association "InformationFlow_ItemFlow" 
    :name "extension_ItemFlow" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== NestedConnectorEnd
;;; =========================================================
(def-meta-stereotype |NestedConnectorEnd| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|ConnectorEnd|)
 :packages (|SysML|) 
 :xmi-id "NestedConnectorEnd")
 ""
  ((|base_ConnectorEnd| :xmi-id "NestedConnectorEnd-base_ConnectorEnd"
    :range UML23:|ConnectorEnd| :multiplicity (1 1))
   (|propertyPath| :xmi-id "NestedConnectorEnd-propertyPath"
    :range UML23:|Property| :multiplicity (1 -1))))

(def-meta-assoc "ConnectorEnd_NestedConnectorEnd"      
  :name |ConnectorEnd_NestedConnectorEnd|      
  :metatype :extension      
  :member-ends (("ConnectorEnd_NestedConnectorEnd-extension_NestedConnectorEnd" "extension_NestedConnectorEnd")
                (|NestedConnectorEnd| "base_ConnectorEnd"))      
  :owned-ends  (("ConnectorEnd_NestedConnectorEnd-extension_NestedConnectorEnd" "extension_NestedConnectorEnd")))

(def-meta-assoc-end "ConnectorEnd_NestedConnectorEnd-extension_NestedConnectorEnd" 
    :type |NestedConnectorEnd| 
    :multiplicity (0 1) 
    :association "ConnectorEnd_NestedConnectorEnd" 
    :name "extension_NestedConnectorEnd" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== NoBuffer
;;; =========================================================
(def-meta-stereotype |NoBuffer| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|ObjectNode|)
 :packages (|SysML|) 
 :xmi-id "NoBuffer")
 ""
  ((|base_ObjectNode| :xmi-id "NoBuffer-base_ObjectNode"
    :range UML23:|ObjectNode| :multiplicity (1 1))))

(def-meta-assoc "ObjectNode_NoBuffer"      
  :name |ObjectNode_NoBuffer|      
  :metatype :extension      
  :member-ends (("ObjectNode_NoBuffer-extension_NoBuffer" "extension_NoBuffer")
                (|NoBuffer| "base_ObjectNode"))      
  :owned-ends  (("ObjectNode_NoBuffer-extension_NoBuffer" "extension_NoBuffer")))

(def-meta-assoc-end "ObjectNode_NoBuffer-extension_NoBuffer" 
    :type |NoBuffer| 
    :multiplicity (0 1) 
    :association "ObjectNode_NoBuffer" 
    :name "extension_NoBuffer" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Optional
;;; =========================================================
(def-meta-stereotype |Optional| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Parameter|)
 :packages (|SysML|) 
 :xmi-id "Optional")
 ""
  ((|base_Parameter| :xmi-id "Optional-base_Parameter"
    :range UML23:|Parameter| :multiplicity (1 1))))

(def-meta-assoc "Parameter_Optional"      
  :name |Parameter_Optional|      
  :metatype :extension      
  :member-ends (("Parameter_Optional-extension_Optional" "extension_Optional")
                (|Optional| "base_Parameter"))      
  :owned-ends  (("Parameter_Optional-extension_Optional" "extension_Optional")))

(def-meta-assoc-end "Parameter_Optional-extension_Optional" 
    :type |Optional| 
    :multiplicity (0 1) 
    :association "Parameter_Optional" 
    :name "extension_Optional" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Overwrite
;;; =========================================================
(def-meta-stereotype |Overwrite| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|ObjectNode|)
 :packages (|SysML|) 
 :xmi-id "Overwrite")
 ""
  ((|base_ObjectNode| :xmi-id "Overwrite-base_ObjectNode"
    :range UML23:|ObjectNode| :multiplicity (1 1))))

(def-meta-assoc "ObjectNode_Overwrite"      
  :name |ObjectNode_Overwrite|      
  :metatype :extension      
  :member-ends (("ObjectNode_Overwrite-extension_Overwrite" "extension_Overwrite")
                (|Overwrite| "base_ObjectNode"))      
  :owned-ends  (("ObjectNode_Overwrite-extension_Overwrite" "extension_Overwrite")))

(def-meta-assoc-end "ObjectNode_Overwrite-extension_Overwrite" 
    :type |Overwrite| 
    :multiplicity (0 1) 
    :association "ObjectNode_Overwrite" 
    :name "extension_Overwrite" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ParticipantProperty
;;; =========================================================
(def-meta-stereotype |ParticipantProperty| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Property|)
 :packages (|SysML|) 
 :xmi-id "ParticipantProperty")
 ""
  ((|base_Property| :xmi-id "ParticipantProperty-base_Property"
    :range UML23:|Property| :multiplicity (1 1))
   (|end| :xmi-id "ParticipantProperty-end"
    :range UML23:|Property| :multiplicity (0 1))))

(def-meta-assoc "Property_ParticipantProperty"      
  :name |Property_ParticipantProperty|      
  :metatype :extension      
  :member-ends (("Property_ParticipantProperty-extension_ParticipantProperty" "extension_ParticipantProperty")
                (|ParticipantProperty| "base_Property"))      
  :owned-ends  (("Property_ParticipantProperty-extension_ParticipantProperty" "extension_ParticipantProperty")))

(def-meta-assoc-end "Property_ParticipantProperty-extension_ParticipantProperty" 
    :type |ParticipantProperty| 
    :multiplicity (0 1) 
    :association "Property_ParticipantProperty" 
    :name "extension_ParticipantProperty" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Probability
;;; =========================================================
(def-meta-stereotype |Probability| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|ParameterSet| UML23:|ActivityEdge|)
 :packages (|SysML|) 
 :xmi-id "Probability")
 ""
  ((|base_ActivityEdge| :xmi-id "Probability-base_ActivityEdge"
    :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ParameterSet| :xmi-id "Probability-base_ParameterSet"
    :range UML23:|ParameterSet| :multiplicity (1 1))
   (|probability| :xmi-id "Probability-probability"
    :range UML23:|ValueSpecification| :multiplicity (1 1))))

(def-meta-assoc "ActivityEdge_Probability"      
  :name |ActivityEdge_Probability|      
  :metatype :extension      
  :member-ends (("ActivityEdge_Probability-extension_Probability" "extension_Probability")
                (|Probability| "base_ActivityEdge"))      
  :owned-ends  (("ActivityEdge_Probability-extension_Probability" "extension_Probability")))

(def-meta-assoc-end "ActivityEdge_Probability-extension_Probability" 
    :type |Probability| 
    :multiplicity (0 1) 
    :association "ActivityEdge_Probability" 
    :name "extension_Probability" 
    :aggregation :COMPOSITE)

(def-meta-assoc "ParameterSet_Probability"      
  :name |ParameterSet_Probability|      
  :metatype :extension      
  :member-ends (("ParameterSet_Probability-extension_Probability" "extension_Probability")
                (|Probability| "base_ParameterSet"))      
  :owned-ends  (("ParameterSet_Probability-extension_Probability" "extension_Probability")))

(def-meta-assoc-end "ParameterSet_Probability-extension_Probability" 
    :type |Probability| 
    :multiplicity (0 1) 
    :association "ParameterSet_Probability" 
    :name "extension_Probability" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Problem
;;; =========================================================
(def-meta-stereotype |Problem| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Comment|)
 :packages (|SysML|) 
 :xmi-id "Problem")
 ""
  ((|base_Comment| :xmi-id "Problem-base_Comment"
    :range UML23:|Comment| :multiplicity (1 1))))

(def-meta-assoc "Comment_Problem"      
  :name |Comment_Problem|      
  :metatype :extension      
  :member-ends (("Comment_Problem-extension_Problem" "extension_Problem")
                (|Problem| "base_Comment"))      
  :owned-ends  (("Comment_Problem-extension_Problem" "extension_Problem")))

(def-meta-assoc-end "Comment_Problem-extension_Problem" 
    :type |Problem| 
    :multiplicity (0 1) 
    :association "Comment_Problem" 
    :name "extension_Problem" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== QuantityKind
;;; =========================================================
(def-meta-stereotype |QuantityKind| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|InstanceSpecification|)
 :packages (|SysML|) 
 :xmi-id "QuantityKind")
 ""
  ((|base_InstanceSpecification| :xmi-id "QuantityKind-base_InstanceSpecification"
    :range UML23:|InstanceSpecification| :multiplicity (1 1))
   (|definitionURI| :xmi-id "QuantityKind-definitionURI"
    :range |String| :multiplicity (0 1))
   (|description| :xmi-id "QuantityKind-description"
    :range |String| :multiplicity (0 1))
   (|symbol| :xmi-id "QuantityKind-symbol"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "InstanceSpecification_QuantityKind"      
  :name |InstanceSpecification_QuantityKind|      
  :metatype :extension      
  :member-ends (("InstanceSpecification_QuantityKind-extension_QuantityKind" "extension_QuantityKind")
                (|QuantityKind| "base_InstanceSpecification"))      
  :owned-ends  (("InstanceSpecification_QuantityKind-extension_QuantityKind" "extension_QuantityKind")))

(def-meta-assoc-end "InstanceSpecification_QuantityKind-extension_QuantityKind" 
    :type |QuantityKind| 
    :multiplicity (0 1) 
    :association "InstanceSpecification_QuantityKind" 
    :name "extension_QuantityKind" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Rate
;;; =========================================================
(def-meta-stereotype |Rate| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Parameter| UML23:|ActivityEdge|)
 :packages (|SysML|) 
 :xmi-id "Rate")
 ""
  ((|base_ActivityEdge| :xmi-id "Rate-base_ActivityEdge"
    :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_Parameter| :xmi-id "Rate-base_Parameter"
    :range UML23:|Parameter| :multiplicity (1 1))
   (|rate| :xmi-id "Rate-rate"
    :range UML23:|InstanceSpecification| :multiplicity (1 1))))

(def-meta-assoc "ActivityEdge_Rate"      
  :name |ActivityEdge_Rate|      
  :metatype :extension      
  :member-ends (("ActivityEdge_Rate-extension_Rate" "extension_Rate")
                (|Rate| "base_ActivityEdge"))      
  :owned-ends  (("ActivityEdge_Rate-extension_Rate" "extension_Rate")))

(def-meta-assoc-end "ActivityEdge_Rate-extension_Rate" 
    :type |Rate| 
    :multiplicity (0 1) 
    :association "ActivityEdge_Rate" 
    :name "extension_Rate" 
    :aggregation :COMPOSITE)

(def-meta-assoc "Parameter_Rate"      
  :name |Parameter_Rate|      
  :metatype :extension      
  :member-ends (("Parameter_Rate-extension_Rate" "extension_Rate")
                (|Rate| "base_Parameter"))      
  :owned-ends  (("Parameter_Rate-extension_Rate" "extension_Rate")))

(def-meta-assoc-end "Parameter_Rate-extension_Rate" 
    :type |Rate| 
    :multiplicity (0 1) 
    :association "Parameter_Rate" 
    :name "extension_Rate" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Rationale
;;; =========================================================
(def-meta-stereotype |Rationale| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Comment|)
 :packages (|SysML|) 
 :xmi-id "Rationale")
 ""
  ((|base_Comment| :xmi-id "Rationale-base_Comment"
    :range UML23:|Comment| :multiplicity (1 1))))

(def-meta-assoc "Comment_Rationale"      
  :name |Comment_Rationale|      
  :metatype :extension      
  :member-ends (("Comment_Rationale-extension_Rationale" "extension_Rationale")
                (|Rationale| "base_Comment"))      
  :owned-ends  (("Comment_Rationale-extension_Rationale" "extension_Rationale")))

(def-meta-assoc-end "Comment_Rationale-extension_Rationale" 
    :type |Rationale| 
    :multiplicity (0 1) 
    :association "Comment_Rationale" 
    :name "extension_Rationale" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Requirement
;;; =========================================================
(def-meta-stereotype |Requirement| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Class|)
 :packages (|SysML|) 
 :xmi-id "Requirement")
 ""
  ((|Derived| :xmi-id "Requirement-Derived"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|DerivedFrom| :xmi-id "Requirement-DerivedFrom"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|Id| :xmi-id "Requirement-Id"
    :range |String| :multiplicity (1 1))
   (|Master| :xmi-id "Requirement-Master"
    :range |Requirement| :multiplicity (1 1) :is-derived-p T)
   (|RefinedBy| :xmi-id "Requirement-RefinedBy"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|SatisfiedBy| :xmi-id "Requirement-SatisfiedBy"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|Text| :xmi-id "Requirement-Text"
    :range |String| :multiplicity (1 1))
   (|TracedTo| :xmi-id "Requirement-TracedTo"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|VerifiedBy| :xmi-id "Requirement-VerifiedBy"
    :range UML23:|NamedElement| :multiplicity (0 -1) :is-derived-p T)
   (|base_Class| :xmi-id "Requirement-base_Class"
    :range UML23:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Requirement"      
  :name |Class_Requirement|      
  :metatype :extension      
  :member-ends (("Class_Requirement-extension_Requirement" "extension_Requirement")
                (|Requirement| "base_Class"))      
  :owned-ends  (("Class_Requirement-extension_Requirement" "extension_Requirement")))

(def-meta-assoc-end "Class_Requirement-extension_Requirement" 
    :type |Requirement| 
    :multiplicity (0 1) 
    :association "Class_Requirement" 
    :name "extension_Requirement" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== RequirementRelated
;;; =========================================================
(def-meta-stereotype |RequirementRelated| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|NamedElement|)
 :packages (|SysML|) 
 :xmi-id "RequirementRelated")
 ""
  ((|Refines| :xmi-id "RequirementRelated-Refines"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|Satisfies| :xmi-id "RequirementRelated-Satisfies"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|TracedFrom| :xmi-id "RequirementRelated-TracedFrom"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|Verifies| :xmi-id "RequirementRelated-Verifies"
    :range |Requirement| :multiplicity (0 -1) :is-derived-p T)
   (|base_NamedElement| :xmi-id "RequirementRelated-base_NamedElement"
    :range UML23:|NamedElement| :multiplicity (1 1))))

(def-meta-assoc "NamedElement_RequirementRelated"      
  :name |NamedElement_RequirementRelated|      
  :metatype :extension      
  :member-ends (("NamedElement_RequirementRelated-extension_RequirementRelated" "extension_RequirementRelated")
                (|RequirementRelated| "base_NamedElement"))      
  :owned-ends  (("NamedElement_RequirementRelated-extension_RequirementRelated" "extension_RequirementRelated")))

(def-meta-assoc-end "NamedElement_RequirementRelated-extension_RequirementRelated" 
    :type |RequirementRelated| 
    :multiplicity (0 1) 
    :association "NamedElement_RequirementRelated" 
    :name "extension_RequirementRelated" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Satisfy
;;; =========================================================
(def-meta-stereotype |Satisfy| 
   (:model :SYSML12 :superclasses (|Trace|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "Satisfy")
 ""
  ())

;;; =========================================================
;;; ====================== TestCase
;;; =========================================================
(def-meta-stereotype |TestCase| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Operation| UML23:|Behavior|)
 :packages (|SysML|) 
 :xmi-id "TestCase")
 ""
  ((|base_Behavior| :xmi-id "TestCase-base_Behavior"
    :range UML23:|Behavior| :multiplicity (1 1))
   (|base_Operation| :xmi-id "TestCase-base_Operation"
    :range UML23:|Operation| :multiplicity (1 1))))

(def-meta-assoc "Behavior_TestCase"      
  :name |Behavior_TestCase|      
  :metatype :extension      
  :member-ends (("Behavior_TestCase-extension_TestCase" "extension_TestCase")
                (|TestCase| "base_Behavior"))      
  :owned-ends  (("Behavior_TestCase-extension_TestCase" "extension_TestCase")))

(def-meta-assoc-end "Behavior_TestCase-extension_TestCase" 
    :type |TestCase| 
    :multiplicity (0 1) 
    :association "Behavior_TestCase" 
    :name "extension_TestCase" 
    :aggregation :COMPOSITE)

(def-meta-assoc "Operation_TestCase"      
  :name |Operation_TestCase|      
  :metatype :extension      
  :member-ends (("Operation_TestCase-extension_TestCase" "extension_TestCase")
                (|TestCase| "base_Operation"))      
  :owned-ends  (("Operation_TestCase-extension_TestCase" "extension_TestCase")))

(def-meta-assoc-end "Operation_TestCase-extension_TestCase" 
    :type |TestCase| 
    :multiplicity (0 1) 
    :association "Operation_TestCase" 
    :name "extension_TestCase" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== TestContext
;;; =========================================================
(def-meta-stereotype |TestContext| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Class|)
 :packages (|SysML|) 
 :xmi-id "TestContext")
 ""
  ((|base_Class| :xmi-id "TestContext-base_Class"
    :range UML23:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_TestContext"      
  :name |Class_TestContext|      
  :metatype :extension      
  :member-ends (("Class_TestContext-extension_TestContext" "extension_TestContext")
                (|TestContext| "base_Class"))      
  :owned-ends  (("Class_TestContext-extension_TestContext" "extension_TestContext")))

(def-meta-assoc-end "Class_TestContext-extension_TestContext" 
    :type |TestContext| 
    :multiplicity (0 1) 
    :association "Class_TestContext" 
    :name "extension_TestContext" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Trace
;;; =========================================================
(def-meta-stereotype |Trace| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Abstraction|)
 :packages (|SysML|) 
 :xmi-id "Trace")
 ""
  ((|base_Abstraction| :xmi-id "Trace-base_Abstraction"
    :range UML23:|Abstraction| :multiplicity (1 1))))

(def-meta-assoc "Abstraction_Trace"      
  :name |Abstraction_Trace|      
  :metatype :extension      
  :member-ends (("Abstraction_Trace-extension_Trace" "extension_Trace")
                (|Trace| "base_Abstraction"))      
  :owned-ends  (("Abstraction_Trace-extension_Trace" "extension_Trace")))

(def-meta-assoc-end "Abstraction_Trace-extension_Trace" 
    :type |Trace| 
    :multiplicity (0 1) 
    :association "Abstraction_Trace" 
    :name "extension_Trace" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Unit
;;; =========================================================
(def-meta-stereotype |Unit| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|InstanceSpecification|)
 :packages (|SysML|) 
 :xmi-id "Unit")
 ""
  ((|base_InstanceSpecification| :xmi-id "Unit-base_InstanceSpecification"
    :range UML23:|InstanceSpecification| :multiplicity (1 1))
   (|definitionURI| :xmi-id "Unit-definitionURI"
    :range |String| :multiplicity (0 1))
   (|description| :xmi-id "Unit-description"
    :range |String| :multiplicity (0 1))
   (|quantityKind| :xmi-id "Unit-quantityKind"
    :range |QuantityKind| :multiplicity (0 1))
   (|symbol| :xmi-id "Unit-symbol"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "InstanceSpecification_Unit"      
  :name |InstanceSpecification_Unit|      
  :metatype :extension      
  :member-ends (("InstanceSpecification_Unit-extension_Unit" "extension_Unit")
                (|Unit| "base_InstanceSpecification"))      
  :owned-ends  (("InstanceSpecification_Unit-extension_Unit" "extension_Unit")))

(def-meta-assoc-end "InstanceSpecification_Unit-extension_Unit" 
    :type |Unit| 
    :multiplicity (0 1) 
    :association "InstanceSpecification_Unit" 
    :name "extension_Unit" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ValueType
;;; =========================================================
(def-meta-stereotype |ValueType| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|DataType|)
 :packages (|SysML|) 
 :xmi-id "ValueType")
 ""
  ((|base_DataType| :xmi-id "ValueType-base_DataType"
    :range UML23:|DataType| :multiplicity (1 1))
   (|quantityKind| :xmi-id "ValueType-quantityKind"
    :range |QuantityKind| :multiplicity (0 1))
   (|unit| :xmi-id "ValueType-unit"
    :range |Unit| :multiplicity (0 1))))

(def-meta-assoc "DataType_ValueType"      
  :name |DataType_ValueType|      
  :metatype :extension      
  :member-ends (("DataType_ValueType-extension_ValueType" "extension_ValueType")
                (|ValueType| "base_DataType"))      
  :owned-ends  (("DataType_ValueType-extension_ValueType" "extension_ValueType")))

(def-meta-assoc-end "DataType_ValueType-extension_ValueType" 
    :type |ValueType| 
    :multiplicity (0 1) 
    :association "DataType_ValueType" 
    :name "extension_ValueType" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Verify
;;; =========================================================
(def-meta-stereotype |Verify| 
   (:model :SYSML12 :superclasses (|Trace|) :extends NIL
 :packages (|SysML|) 
 :xmi-id "Verify")
 ""
  ())

;;; =========================================================
;;; ====================== View
;;; =========================================================
(def-meta-stereotype |View| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Package|)
 :packages (|SysML|) 
 :xmi-id "View")
 ""
  ((|base_Package| :xmi-id "View-base_Package"
    :range UML23:|Package| :multiplicity (1 1))
   (|viewpoint| :xmi-id "View-viewpoint"
    :range |Viewpoint| :multiplicity (1 1))))

(def-meta-assoc "Package_View"      
  :name |Package_View|      
  :metatype :extension      
  :member-ends (("Package_View-extension_View" "extension_View")
                (|View| "base_Package"))      
  :owned-ends  (("Package_View-extension_View" "extension_View")))

(def-meta-assoc-end "Package_View-extension_View" 
    :type |View| 
    :multiplicity (0 1) 
    :association "Package_View" 
    :name "extension_View" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Viewpoint
;;; =========================================================
(def-meta-stereotype |Viewpoint| 
   (:model :SYSML12 :superclasses NIL :extends (UML23:|Class|)
 :packages (|SysML|) 
 :xmi-id "Viewpoint")
 ""
  ((|base_Class| :xmi-id "Viewpoint-base_Class"
    :range UML23:|Class| :multiplicity (1 1))
   (|concerns| :xmi-id "Viewpoint-concerns"
    :range |String| :multiplicity (0 -1))
   (|languages| :xmi-id "Viewpoint-languages"
    :range |String| :multiplicity (0 -1))
   (|methods| :xmi-id "Viewpoint-methods"
    :range |String| :multiplicity (0 -1))
   (|purpose| :xmi-id "Viewpoint-purpose"
    :range |String| :multiplicity (1 1))
   (|stakeholders| :xmi-id "Viewpoint-stakeholders"
    :range |String| :multiplicity (0 -1))))

(def-meta-assoc "Class_Viewpoint"      
  :name |Class_Viewpoint|      
  :metatype :extension      
  :member-ends (("Class_Viewpoint-extension_Viewpoint" "extension_Viewpoint")
                (|Viewpoint| "base_Class"))      
  :owned-ends  (("Class_Viewpoint-extension_Viewpoint" "extension_Viewpoint")))

(def-meta-assoc-end "Class_Viewpoint-extension_Viewpoint" 
    :type |Viewpoint| 
    :multiplicity (0 1) 
    :association "Class_Viewpoint" 
    :name "extension_Viewpoint" 
    :aggregation :COMPOSITE)

(def-meta-package |SysML| NIL :SYSML12 
   (|Rate|
    |Continuous|
    |ControlOperator|
    |Discrete|
    |NoBuffer|
    |Optional|
    |Overwrite|
    |Probability|
    |Allocate|
    |AllocateActivityPartition|
    |Allocated|
    |Block|
    |DistributedProperty|
    |NestedConnectorEnd|
    |ValueType|
    |Unit|
    |QuantityKind|
    |FlowPort|
    |FlowDirection|
    |FlowSpecification|
    |FlowProperty|
    |ItemFlow|
    |ConstraintBlock|
    |ConstraintProperty|
    |View|
    |Viewpoint|
    |Conform|
    |Rationale|
    |Problem|
    |VerdictKind|
    |Trace|
    |Copy|
    |DeriveReqt|
    |Requirement|
    |RequirementRelated|
    |Satisfy|
    |TestCase|
    |TestContext|
    |Verify|
    |BindingConnector|
    |ParticipantProperty|
    |ConnectorProperty|) :xmi-id "+The-Model+")

(def-meta-package |UML4SysML| NIL :SYSML12 
   () :xmi-id NIL)

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '())
     (setf mofi:ns-uri "http://www.omg.org/spec/SysML/20100301/SysML-profile")
     (setf mofi:ns-prefix "sysml"))
