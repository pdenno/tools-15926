;;; Automatically created by pop-gen at 2013-12-18 16:10:26.
;;; Source file is sysml-profile-20131201.xmi

(in-package :SYSML14)



(def-meta-enum |ControlValue| (:model :SYSML14 :superclasses NIL 
   :xmi-id "_SysML_-Libraries-ControlValues-ControlValue")
   (|disable| |enable|)
   "The ControlValue enumeration is a type for treating control values as data
    and for UML control pins. It can be used as the type of behavior and operation
    parameters, object nodes, and attributes, and so on. The possible runtime
    values are given as enumeration literals. Modelers can extend the enumeration
    with additional literals, such as suspend, resume, with their own semantics.")



(def-meta-enum |FeatureDirection| (:model :SYSML14 :superclasses NIL 
   :xmi-id "_SysML_-Ports%2526Flows-FeatureDirection")
   (|provided| |required| |providedRequired|)
   "")



(def-meta-enum |FlowDirection| (:model :SYSML14 :superclasses NIL 
   :xmi-id "_SysML_-Ports%2526Flows-FlowDirection")
   (|in| |out| |inout|)
   "FlowDirection is an enumeration type that defines literals used for specifying
    input and output directions. FlowDirection is used by flow properties to
    indicate if a property is an input or an output with respect to its owner.")



(def-meta-enum |VerdictKind| (:model :SYSML14 :superclasses NIL 
   :xmi-id "_SysML_-Requirements-VerdictKind")
   (|pass| |fail| |inconclusive| |error|)
   "Type of a return parameter of a TestCase must be VerdictKind, consistent
    with the UML Testing Profile.")



;;; =========================================================
;;; ====================== AcceptChangeStructuralFeatureEventAction
;;; =========================================================
(def-meta-stereotype |AcceptChangeStructuralFeatureEventAction| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|AcceptEventAction|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-AcceptChangeStructuralFeatureEventAction")
 ""
  ((|base_AcceptEventAction| :xmi-id "_SysML_-Ports%2526Flows-AcceptChangeStructuralFeatureEventAction-base_AcceptEventAction"
    :range UML25:|AcceptEventAction| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction"      
  :name |E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction|      
  :metatype :extension      
  :member-ends ((|AcceptChangeStructuralFeatureEventAction| "base_AcceptEventAction")
                ("_SysML_-Ports%2526Flows-E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction-extension_AcceptChangeStructuralFeatureEventAction" "extension_AcceptChangeStructuralFeatureEventAction"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction-extension_AcceptChangeStructuralFeatureEventAction" "extension_AcceptChangeStructuralFeatureEventAction")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction-extension_AcceptChangeStructuralFeatureEventAction" 
    :type |AcceptChangeStructuralFeatureEventAction| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_AcceptChangeStructuralFeatureEventAction_base_AcceptEventAction" 
    :name "extension_AcceptChangeStructuralFeatureEventAction" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== AdjunctProperty
;;; =========================================================
(def-meta-stereotype |AdjunctProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-AdjunctProperty")
 "The AdjunctProperty stereotype can be applied to properties to constrain
  their values to the values of connectors typed by association blocks, call
  actions, object nodes, variables, or parameters, interaction uses, and
  submachine states. The values of connectors typed by association blocks
  are the instances of the association block typing a connector in the block
  having the stereotyped property. The values of call actions are the executions
  of behaviors invoked by the behavior having the call action and the stereotyped
  property (see Subclause 11.3.1.1.1 for more about this use of the stereotype).
  The values of object nodes are the values of tokens in the object nodes
  of the behavior having the stereotyped property (see Subclause 11.3.1.4.1
  for more about this use of the stereotype). The values of variables are
  those assigned by executions of activities that have the stereotyped property.
  The values of parameters are those assigned by executions of behaviors
  that have the stereotyped property. The keyword   adjunct   before a property
  name indicates the property is stereotyped by AdjunctProperty."
  ((|base_Property| :xmi-id "_SysML_-Blocks-AdjunctProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))
   (|principal| :xmi-id "_SysML_-Blocks-AdjunctProperty-principal"
    :range UML25:|Element| :multiplicity (1 1)
    :documentation
     "Gives the element that determines the values of the property. Must be a
      connector, call action, object node, variable, or parameter.")))

(def-meta-assoc "_SysML_-Blocks-A_adjunctProperty_principal"      
  :name |A_adjunctProperty_principal|      
  :metatype :association      
  :member-ends ((|AdjunctProperty| "principal")
                ("_SysML_-Blocks-A_adjunctProperty_principal-adjunctProperty" "adjunctProperty"))      
  :owned-ends  (("_SysML_-Blocks-A_adjunctProperty_principal-adjunctProperty" "adjunctProperty")))

(def-meta-assoc-end "_SysML_-Blocks-A_adjunctProperty_principal-adjunctProperty" 
    :type |AdjunctProperty| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_adjunctProperty_principal" 
    :name "adjunctProperty" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-E_extension_AdjunctProperty_base_Property"      
  :name |E_extension_AdjunctProperty_base_Property|      
  :metatype :extension      
  :member-ends ((|AdjunctProperty| "base_Property")
                ("_SysML_-Blocks-E_extension_AdjunctProperty_base_Property-extension_AdjunctProperty" "extension_AdjunctProperty"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_AdjunctProperty_base_Property-extension_AdjunctProperty" "extension_AdjunctProperty")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_AdjunctProperty_base_Property-extension_AdjunctProperty" 
    :type |AdjunctProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_AdjunctProperty_base_Property" 
    :name "extension_AdjunctProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Allocate
;;; =========================================================
(def-meta-stereotype |Allocate| 
   (:model :SYSML14 :superclasses (|DirectedRelationshipPropertyPath|) :extends (UML25:|Abstraction|)
 :packages (|SysML| |Allocations|) 
 :xmi-id "_SysML_-Allocations-Allocate")
 "Allocate is a dependency based on UML::abstraction. It is a mechanism for
  associating elements of different types, or in different hierarchies, at
  an abstract level. Allocate is used for assessing user model consistency
  and directing future design activity. It is expected that an   allocate
    relationship between model elements is a precursor to a more concrete
  relationship between the elements, their properties, operations, attributes,
  or sub-classes."
  ((|base_Abstraction| :xmi-id "_SysML_-Allocations-Allocate-base_Abstraction"
    :range UML25:|Abstraction| :multiplicity (0 1) :redefined-property (|DirectedRelationshipPropertyPath| |base_DirectedRelationship|))))

(def-meta-operation "getAllocatedFrom" |Allocate| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "getAllocatedTo" |Allocate| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "_SysML_-Allocations-E_extension_Allocate_base_Abstraction"      
  :name |E_extension_Allocate_base_Abstraction|      
  :metatype :extension      
  :member-ends (("_SysML_-Allocations-E_extension_Allocate_base_Abstraction-extension_Allocate" "extension_Allocate")
                (|Allocate| "base_Abstraction"))      
  :owned-ends  (("_SysML_-Allocations-E_extension_Allocate_base_Abstraction-extension_Allocate" "extension_Allocate")))

(def-meta-assoc-end "_SysML_-Allocations-E_extension_Allocate_base_Abstraction-extension_Allocate" 
    :type |Allocate| 
    :multiplicity (1 1) 
    :association "_SysML_-Allocations-E_extension_Allocate_base_Abstraction" 
    :name "extension_Allocate" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== AllocateActivityPartition
;;; =========================================================
(def-meta-stereotype |AllocateActivityPartition| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|ActivityPartition|)
 :packages (|SysML| |Allocations|) 
 :xmi-id "_SysML_-Allocations-AllocateActivityPartition")
 "AllocateActivityPartition is used to depict an   allocate   relationship
  on an Activity diagram. The AllocateActivityPartition is a standard UML2::ActivityPartition,
  with modified constraints as stated in the paragraph below."
  ((|base_ActivityPartition| :xmi-id "_SysML_-Allocations-AllocateActivityPartition-base_ActivityPartition"
    :range UML25:|ActivityPartition| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Allocations-E_extension_AllocateActivityPartition_base_ActivityPartition"      
  :name |E_extension_AllocateActivityPartition_base_ActivityPartition|      
  :metatype :extension      
  :member-ends (("_SysML_-Allocations-E_extension_AllocateActivityPartition_base_ActivityPartition-extension_AllocateActivityPartition" "extension_AllocateActivityPartition")
                (|AllocateActivityPartition| "base_ActivityPartition"))      
  :owned-ends  (("_SysML_-Allocations-E_extension_AllocateActivityPartition_base_ActivityPartition-extension_AllocateActivityPartition" "extension_AllocateActivityPartition")))

(def-meta-assoc-end "_SysML_-Allocations-E_extension_AllocateActivityPartition_base_ActivityPartition-extension_AllocateActivityPartition" 
    :type |AllocateActivityPartition| 
    :multiplicity (1 1) 
    :association "_SysML_-Allocations-E_extension_AllocateActivityPartition_base_ActivityPartition" 
    :name "extension_AllocateActivityPartition" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Allocated
;;; =========================================================
(def-meta-stereotype |Allocated| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|NamedElement|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_-DeprecatedElements-Allocated")
 "allocated   is a stereotype that applies to any NamedElement that has at
  least one allocation relationship with another NamedElement.   allocated
    elements may be designated by either the /from or /to end of an   allocate
    dependency. The   allocated   stereotype provides a mechanism for a particular
  model element to conveniently retain and display the element at the opposite
  end of any   allocate   dependency. This stereotype provides for the properties
     allocatedFrom    and    allocatedTo,    which are derived from the 
   allocate   dependency."
  ((|allocatedFrom| :xmi-id "_SysML_-DeprecatedElements-Allocated-allocatedFrom"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Reverse of allocatedTo: the element types and names of the set of elements
      that are clients (from) of an   allocate   whose supplier is extended by
      this stereotype (instance). The same characteristics apply as to /allocatedTo.
      Each allocatedFrom property will be expressed as   elementType   ElementName.")
   (|allocatedTo| :xmi-id "_SysML_-DeprecatedElements-Allocated-allocatedTo"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "The element types and names of the set of elements that are suppliers (
        to    end of the concrete syntax) of an   allocate   whose client is
      extended by this stereotype (instance). This property is the union of all
      suppliers to which this instance is the client, i.e., there may be more
      than one /allocatedTo property per allocated model element. Each allocatedTo
      property will be expressed as   elementType   ElementName.")
   (|base_NamedElement| :xmi-id "_SysML_-DeprecatedElements-Allocated-base_NamedElement"
    :range UML25:|NamedElement| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-DeprecatedElements-E_extension_Allocated_base_NamedElement"      
  :name |E_extension_Allocated_base_NamedElement|      
  :metatype :extension      
  :member-ends (("_SysML_-DeprecatedElements-E_extension_Allocated_base_NamedElement-extension_" "extension_")
                (|Allocated| "base_NamedElement"))      
  :owned-ends  (("_SysML_-DeprecatedElements-E_extension_Allocated_base_NamedElement-extension_" "extension_")))

(def-meta-assoc-end "_SysML_-DeprecatedElements-E_extension_Allocated_base_NamedElement-extension_" 
    :type |Allocated| 
    :multiplicity (1 1) 
    :association "_SysML_-DeprecatedElements-E_extension_Allocated_base_NamedElement" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== BindingConnector
;;; =========================================================
(def-meta-stereotype |BindingConnector| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Connector|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-BindingConnector")
 "A Binding Connector is a connector which specifies that the properties
  at both ends of the connector have equal values. If the properties at the
  ends of a binding connector are typed by a DataType or ValueType, the connector
  specifies that the instances of the properties must hold equal values,
  recursively through any nested properties within the connected properties.
  If the properties at the ends of a binding connector are typed by a Block,
  the connector specifies that the instances of the properties must refer
  to the same block instance. As with any connector owned by a SysML Block,
  the ends of a binding connector may be nested within a multi-level path
  of properties accessible from the owning block. The NestedConnectorEnd
  stereotype is used to represent such nested ends just as for nested ends
  of other SysML connectors."
  ((|base_Connector| :xmi-id "_SysML_-Blocks-BindingConnector-base_Connector"
    :range UML25:|Connector| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Blocks-E_extension_BindingConnector_base_Connector"      
  :name |E_extension_BindingConnector_base_Connector|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_BindingConnector_base_Connector-extension_BindingConnector" "extension_BindingConnector")
                (|BindingConnector| "base_Connector"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_BindingConnector_base_Connector-extension_BindingConnector" "extension_BindingConnector")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_BindingConnector_base_Connector-extension_BindingConnector" 
    :type |BindingConnector| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_BindingConnector_base_Connector" 
    :name "extension_BindingConnector" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Block
;;; =========================================================
(def-meta-stereotype |Block| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Class|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-Block")
 "A Block is a modular unit that describes the structure of a system or element.
  It may include both structural and behavioral features, such as properties
  and operations, that represent the state of the system and behavior that
  the system may exhibit. Some of these properties may hold parts of a system,
  which can also be described by blocks. A block may include a structure
  of connectors between its properties to indicate how its parts or other
  properties relate to one another. SysML blocks provide a general-purpose
  capability to describe the architecture of a system. They provide the ability
  to represent a system hierarchy, in which a system at one level is composed
  of systems at a more basic level. They can describe not only the connectivity
  relationships between the systems at any level, but also quantitative values
  or other information about a system. SysML does not restrict the kind of
  system or system element that may be described by a block. Any reusable
  form of description that may be applied to a system or a set of system
  characteristics may be described by a block. Such reusable descriptions,
  for example, may be applied to purely conceptual aspects of a system design,
  such as relationships that hold between parts or properties of a system.
  Connectors owned by SysML blocks may be used to define relationships between
  parts or other properties of the same containing block. The type of a connector
  or its connected ends may specify the semantic interpretation of a specific
  connector."
  ((|base_Class| :xmi-id "_SysML_-Blocks-Block-base_Class"
    :range UML25:|Class| :multiplicity (0 1))
   (|isEncapsulated| :xmi-id "_SysML_-Blocks-Block-isEncapsulated"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "If true, then the block is treated as a black box; a part typed by this
      black box can only be connected via its ports or directly to its outer
      boundary. If false, or if a value is not present, then connections can
      be established to elements of its internal structure via deep-nested connector
      ends.")))

(def-meta-assoc "_SysML_-Blocks-E_extension_Block_base_Class"      
  :name |E_extension_Block_base_Class|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_Block_base_Class-extension_Block" "extension_Block")
                (|Block| "base_Class"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_Block_base_Class-extension_Block" "extension_Block")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_Block_base_Class-extension_Block" 
    :type |Block| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_Block_base_Class" 
    :name "extension_Block" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== BoundReference
;;; =========================================================
(def-meta-stereotype |BoundReference| 
   (:model :SYSML14 :superclasses (|EndPathMultiplicity|) :extends NIL
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-BoundReference")
 ""
  ((|bindingPath| :xmi-id "_SysML_-Blocks-BoundReference-bindingPath"
    :range UML25:|Property| :multiplicity (1 -1) :is-ordered-p T :is-derived-p T
    :documentation
     "Gives the propertyPath of the NestedConnectorEnd applied, if any, to the
      boundEnd, appended to the role of the boundEnd.")
   (|boundEnd| :xmi-id "_SysML_-Blocks-BoundReference-boundEnd"
    :range UML25:|ConnectorEnd| :multiplicity (1 1)
    :documentation
     "Gives a connector end of a binding connector opposite to the end linked
      to the stereotyped property, or linked to a property that generalizes the
      stereotyped one through redefinition.")))

;;; =========================================================
;;; ====================== ChangeStructuralFeatureEvent
;;; =========================================================
(def-meta-stereotype |ChangeStructuralFeatureEvent| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|ChangeEvent|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-ChangeStructuralFeatureEvent")
 ""
  ((|base_ChangeEvent| :xmi-id "_SysML_-Ports%2526Flows-ChangeStructuralFeatureEvent-base_ChangeEvent"
    :range UML25:|ChangeEvent| :multiplicity (0 1))
   (|structuralFeature| :xmi-id "_SysML_-Ports%2526Flows-ChangeStructuralFeatureEvent-structuralFeature"
    :range UML25:|StructuralFeature| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-Ports%2526Flows-A_changeStructuralFeatureEvent_structuralFeature"      
  :name |A_changeStructuralFeatureEvent_structuralFeature|      
  :metatype :association      
  :member-ends (("_SysML_-Ports%2526Flows-A_changeStructuralFeatureEvent_structuralFeature-changeStructuralFeatureEvent" "changeStructuralFeatureEvent")
                (|ChangeStructuralFeatureEvent| "structuralFeature"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-A_changeStructuralFeatureEvent_structuralFeature-changeStructuralFeatureEvent" "changeStructuralFeatureEvent")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-A_changeStructuralFeatureEvent_structuralFeature-changeStructuralFeatureEvent" 
    :type |ChangeStructuralFeatureEvent| 
    :multiplicity (0 -1) 
    :association "_SysML_-Ports%2526Flows-A_changeStructuralFeatureEvent_structuralFeature" 
    :name "changeStructuralFeatureEvent" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent"      
  :name |E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent|      
  :metatype :extension      
  :member-ends ((|ChangeStructuralFeatureEvent| "base_ChangeEvent")
                ("_SysML_-Ports%2526Flows-E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent-extension_ChangeStructuralFeatureEvent" "extension_ChangeStructuralFeatureEvent"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent-extension_ChangeStructuralFeatureEvent" "extension_ChangeStructuralFeatureEvent")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent-extension_ChangeStructuralFeatureEvent" 
    :type |ChangeStructuralFeatureEvent| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_ChangeStructuralFeatureEvent_base_ChangeEvent" 
    :name "extension_ChangeStructuralFeatureEvent" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ClassifierBehaviorProperty
;;; =========================================================
(def-meta-stereotype |ClassifierBehaviorProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-ClassifierBehaviorProperty")
 "The ClassifierBehaviorProperty stereotype can be applied to properties
  to constrain their values to be the executions of classifier behaviors.
  The value of properties with ClassifierBehaviorProperty applied are the
  executions of classifier behaviors invoked by instantiation of the block
  that owns the stereotyped property or one of its specializations."
  ((|base_Property| :xmi-id "_SysML_-Blocks-ClassifierBehaviorProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Blocks-E_extension_ClassifierBehaviorProperty_base_Property"      
  :name |E_extension_ClassifierBehaviorProperty_base_Property|      
  :metatype :extension      
  :member-ends ((|ClassifierBehaviorProperty| "base_Property")
                ("_SysML_-Blocks-E_extension_ClassifierBehaviorProperty_base_Property-extension_ClassifierBehaviorProperty" "extension_ClassifierBehaviorProperty"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_ClassifierBehaviorProperty_base_Property-extension_ClassifierBehaviorProperty" "extension_ClassifierBehaviorProperty")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_ClassifierBehaviorProperty_base_Property-extension_ClassifierBehaviorProperty" 
    :type |ClassifierBehaviorProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_ClassifierBehaviorProperty_base_Property" 
    :name "extension_ClassifierBehaviorProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Conform
;;; =========================================================
(def-meta-stereotype |Conform| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Generalization| UML25:|Dependency|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Conform")
 "A Conform relationship is a dependency between a view and a viewpoint.
  The view conforms to the specified rules and conventions detailed in the
  viewpoint. Conform is a specialization of the UML dependency, and as with
  other dependencies the arrow direction points from the (client/source)
  to the (supplier/target)."
  ((|base_Dependency| :xmi-id "_SysML_-ModelElements-Conform-base_Dependency"
    :range UML25:|Dependency| :multiplicity (0 1))
   (|base_Generalization| :xmi-id "_SysML_-ModelElements-Conform-base_Generalization"
    :range UML25:|Generalization| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-ModelElements-Deprecated-E_extension_Conform_base_Dependency"      
  :name |E_extension_Conform_base_Dependency|      
  :metatype :extension      
  :member-ends (("_SysML_-ModelElements-Deprecated-E_extension_Conform_base_Dependency-extension_Conform" "extension_Conform")
                (|Conform| "base_Dependency"))      
  :owned-ends  (("_SysML_-ModelElements-Deprecated-E_extension_Conform_base_Dependency-extension_Conform" "extension_Conform")))

(def-meta-assoc-end "_SysML_-ModelElements-Deprecated-E_extension_Conform_base_Dependency-extension_Conform" 
    :type |Conform| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-Deprecated-E_extension_Conform_base_Dependency" 
    :name "extension_Conform" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-ModelElements-E_extension_Conform_base_Generalization"      
  :name |E_extension_Conform_base_Generalization|      
  :metatype :extension      
  :member-ends ((|Conform| "base_Generalization")
                ("_SysML_-ModelElements-E_extension_Conform_base_Generalization-extension_Conform" "extension_Conform"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Conform_base_Generalization-extension_Conform" "extension_Conform")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Conform_base_Generalization-extension_Conform" 
    :type |Conform| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Conform_base_Generalization" 
    :name "extension_Conform" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ConnectorProperty
;;; =========================================================
(def-meta-stereotype |ConnectorProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-ConnectorProperty")
 "Connectors can be typed by association classes that are stereotyped by
  Block (association blocks). These connectors specify instances (links)
  of the association block that exist due to instantiation of the block owning
  or inheriting the connector. The value of a connector property on an instance
  of a block will be exactly those link objects that are instances of the
  association block typing the connector referred to by the connector property."
  ((|base_Property| :xmi-id "_SysML_-Blocks-ConnectorProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))
   (|connector| :xmi-id "_SysML_-Blocks-ConnectorProperty-connector"
    :range UML25:|Connector| :multiplicity (1 1)
    :documentation
     "A connector of the block owning the property on which the stereotype is
      applied.")))

(def-meta-assoc "_SysML_-Blocks-E_extension_ConnectorProperty_base_Property"      
  :name |E_extension_ConnectorProperty_base_Property|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_ConnectorProperty_base_Property-extension_ConnectorProperty" "extension_ConnectorProperty")
                (|ConnectorProperty| "base_Property"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_ConnectorProperty_base_Property-extension_ConnectorProperty" "extension_ConnectorProperty")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_ConnectorProperty_base_Property-extension_ConnectorProperty" 
    :type |ConnectorProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_ConnectorProperty_base_Property" 
    :name "extension_ConnectorProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ConstraintBlock
;;; =========================================================
(def-meta-stereotype |ConstraintBlock| 
   (:model :SYSML14 :superclasses (|Block|) :extends (UML25:|Class|)
 :packages (|SysML| |ConstraintBlocks|) 
 :xmi-id "_SysML_-ConstraintBlocks-ConstraintBlock")
 "A constraint block is a block that packages the statement of a constraint
  so it may be applied in a reusable way to constrain properties of other
  blocks. A constraint block typically defines one or more constraint parameters,
  which are bound to properties of other blocks in a surrounding context
  where the constraint is used. Binding connectors, as defined in Chapter
  8: Blocks, are used to bind each parameter of the constraint block to a
  property in the surrounding context. All properties of a constraint block
  are constraint parameters, with the exception of constraint properties
  that hold internally nested usages of other constraint blocks."
  ((|base_Class| :xmi-id "_SysML_-ConstraintBlocks-ConstraintBlock-base_Class"
    :range UML25:|Class| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-ConstraintBlocks-E_extension_ConstraintBlock_base_Class"      
  :name |E_extension_ConstraintBlock_base_Class|      
  :metatype :extension      
  :member-ends (("_SysML_-ConstraintBlocks-E_extension_ConstraintBlock_base_Class-extension_ConstraintBlock" "extension_ConstraintBlock")
                (|ConstraintBlock| "base_Class"))      
  :owned-ends  (("_SysML_-ConstraintBlocks-E_extension_ConstraintBlock_base_Class-extension_ConstraintBlock" "extension_ConstraintBlock")))

(def-meta-assoc-end "_SysML_-ConstraintBlocks-E_extension_ConstraintBlock_base_Class-extension_ConstraintBlock" 
    :type |ConstraintBlock| 
    :multiplicity (1 1) 
    :association "_SysML_-ConstraintBlocks-E_extension_ConstraintBlock_base_Class" 
    :name "extension_ConstraintBlock" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Continuous
;;; =========================================================
(def-meta-stereotype |Continuous| 
   (:model :SYSML14 :superclasses (|Rate|) :extends NIL
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Continuous")
 "Continuous rate is a special case of rate of flow (see Rate) where the
  increment of time between items approaches zero. It is intended to represent
  continuous flows that may correspond to water flowing through a pipe, a
  time continuous signal, or continuous energy flow. It is independent from
  UML streaming. A streaming parameter may or may not apply to continuous
  flow, and a continuous flow may or may not apply to streaming parameters."
  ())

;;; =========================================================
;;; ====================== ControlOperator
;;; =========================================================
(def-meta-stereotype |ControlOperator| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Operation| UML25:|Behavior|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-ControlOperator")
 "A control operator is a behavior that is intended to represent an arbitrarily
  complex logical operator that can be used to enable and disable other actions.
  When this stereotype is applied to behaviors, the behavior takes control
  values as inputs or provides them as outputs, that is, it treats control
  as data. When this stereotype is not applied, the behavior may not have
  a parameter typed by ControlValue. This stereotype also applies to operations
  with the same semantics."
  ((|base_Behavior| :xmi-id "_SysML_-Activities-ControlOperator-base_Behavior"
    :range UML25:|Behavior| :multiplicity (0 1))
   (|base_Operation| :xmi-id "_SysML_-Activities-ControlOperator-base_Operation"
    :range UML25:|Operation| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_ControlOperator_base_Behavior"      
  :name |E_extension_ControlOperator_base_Behavior|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_ControlOperator_base_Behavior-extension_ControlOperator" "extension_ControlOperator")
                (|ControlOperator| "base_Behavior"))      
  :owned-ends  (("_SysML_-Activities-E_extension_ControlOperator_base_Behavior-extension_ControlOperator" "extension_ControlOperator")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_ControlOperator_base_Behavior-extension_ControlOperator" 
    :type |ControlOperator| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_ControlOperator_base_Behavior" 
    :name "extension_ControlOperator" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Activities-E_extension_ControlOperator_base_Operation"      
  :name |E_extension_ControlOperator_base_Operation|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_ControlOperator_base_Operation-extension_ControlOperator" "extension_ControlOperator")
                (|ControlOperator| "base_Operation"))      
  :owned-ends  (("_SysML_-Activities-E_extension_ControlOperator_base_Operation-extension_ControlOperator" "extension_ControlOperator")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_ControlOperator_base_Operation-extension_ControlOperator" 
    :type |ControlOperator| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_ControlOperator_base_Operation" 
    :name "extension_ControlOperator" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Copy
;;; =========================================================
(def-meta-stereotype |Copy| 
   (:model :SYSML14 :superclasses (|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Copy")
 "A Copy relationship is a dependency between a supplier requirement and
  a client requirement that specifies that the text of the client requirement
  is a read-only copy of the text of the supplier requirement."
  ())

;;; =========================================================
;;; ====================== DeriveReqt
;;; =========================================================
(def-meta-stereotype |DeriveReqt| 
   (:model :SYSML14 :superclasses (|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-DeriveReqt")
 "A DeriveReqt relationship is a dependency between two requirements in which
  a client requirement can be derived from the supplier requirement. As with
  other dependencies, the arrow direction points from the derived (client)
  requirement to the (supplier) requirement from which it is derived."
  ())

;;; =========================================================
;;; ====================== DirectedFeature
;;; =========================================================
(def-meta-stereotype |DirectedFeature| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Feature|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-DirectedFeature")
 ""
  ((|base_Feature| :xmi-id "_SysML_-Ports%2526Flows-DirectedFeature-base_Feature"
    :range UML25:|Feature| :multiplicity (0 1))
   (|featureDirection| :xmi-id "_SysML_-Ports%2526Flows-DirectedFeature-featureDirection"
    :range |FeatureDirection| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_DirectedFeature_base_Feature"      
  :name |E_extension_DirectedFeature_base_Feature|      
  :metatype :extension      
  :member-ends ((|DirectedFeature| "base_Feature")
                ("_SysML_-Ports%2526Flows-E_extension_DirectedFeature_base_Feature-extension_DirectedFeature" "extension_DirectedFeature"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_DirectedFeature_base_Feature-extension_DirectedFeature" "extension_DirectedFeature")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_DirectedFeature_base_Feature-extension_DirectedFeature" 
    :type |DirectedFeature| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_DirectedFeature_base_Feature" 
    :name "extension_DirectedFeature" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== DirectedRelationshipPropertyPath
;;; =========================================================
(def-meta-stereotype |DirectedRelationshipPropertyPath| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|DirectedRelationship|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath")
 ""
  ((|base_DirectedRelationship| :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath-base_DirectedRelationship"
    :range UML25:|DirectedRelationship| :multiplicity (0 1))
   (|sourceContext| :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath-sourceContext"
    :range UML25:|Classifier| :multiplicity (0 1))
   (|sourcePropertyPath| :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath-sourcePropertyPath"
    :range UML25:|Property| :multiplicity (0 -1) :is-ordered-p T)
   (|targetContext| :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath-targetContext"
    :range UML25:|Classifier| :multiplicity (0 1))
   (|targetPropertyPath| :xmi-id "_SysML_-Blocks-DirectedRelationshipPropertyPath-targetPropertyPath"
    :range UML25:|Property| :multiplicity (0 -1) :is-ordered-p T)))

(def-meta-assoc "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourceContext"      
  :name |A_directedRelationshipPropertyPath_sourceContext|      
  :metatype :association      
  :member-ends ((|DirectedRelationshipPropertyPath| "sourceContext")
                ("_SysML_-Blocks-A_directedRelationshipPropertyPath_sourceContext-directedRelationshipPropertyPath" "directedRelationshipPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-A_directedRelationshipPropertyPath_sourceContext-directedRelationshipPropertyPath" "directedRelationshipPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourceContext-directedRelationshipPropertyPath" 
    :type |DirectedRelationshipPropertyPath| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourceContext" 
    :name "directedRelationshipPropertyPath" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourcePropertyPath"      
  :name |A_directedRelationshipPropertyPath_sourcePropertyPath|      
  :metatype :association      
  :member-ends ((|DirectedRelationshipPropertyPath| "sourcePropertyPath")
                ("_SysML_-Blocks-A_directedRelationshipPropertyPath_sourcePropertyPath-directedRelationshipPropertyPath" "directedRelationshipPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-A_directedRelationshipPropertyPath_sourcePropertyPath-directedRelationshipPropertyPath" "directedRelationshipPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourcePropertyPath-directedRelationshipPropertyPath" 
    :type |DirectedRelationshipPropertyPath| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_directedRelationshipPropertyPath_sourcePropertyPath" 
    :name "directedRelationshipPropertyPath" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetContext"      
  :name |A_directedRelationshipPropertyPath_targetContext|      
  :metatype :association      
  :member-ends ((|DirectedRelationshipPropertyPath| "targetContext")
                ("_SysML_-Blocks-A_directedRelationshipPropertyPath_targetContext-directedRelationshipPropertyPath" "directedRelationshipPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-A_directedRelationshipPropertyPath_targetContext-directedRelationshipPropertyPath" "directedRelationshipPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetContext-directedRelationshipPropertyPath" 
    :type |DirectedRelationshipPropertyPath| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetContext" 
    :name "directedRelationshipPropertyPath" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetPropertyPath"      
  :name |A_directedRelationshipPropertyPath_targetPropertyPath|      
  :metatype :association      
  :member-ends ((|DirectedRelationshipPropertyPath| "targetPropertyPath")
                ("_SysML_-Blocks-A_directedRelationshipPropertyPath_targetPropertyPath-directedRelationshipPropertyPath" "directedRelationshipPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-A_directedRelationshipPropertyPath_targetPropertyPath-directedRelationshipPropertyPath" "directedRelationshipPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetPropertyPath-directedRelationshipPropertyPath" 
    :type |DirectedRelationshipPropertyPath| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_directedRelationshipPropertyPath_targetPropertyPath" 
    :name "directedRelationshipPropertyPath" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship"      
  :name |E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship|      
  :metatype :extension      
  :member-ends ((|DirectedRelationshipPropertyPath| "base_DirectedRelationship")
                ("_SysML_-Blocks-E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship-extension_DirectedRelationshipPropertyPath" "extension_DirectedRelationshipPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship-extension_DirectedRelationshipPropertyPath" "extension_DirectedRelationshipPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship-extension_DirectedRelationshipPropertyPath" 
    :type |DirectedRelationshipPropertyPath| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_DirectedRelationshipPropertyPath_base_DirectedRelationship" 
    :name "extension_DirectedRelationshipPropertyPath" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Discrete
;;; =========================================================
(def-meta-stereotype |Discrete| 
   (:model :SYSML14 :superclasses (|Rate|) :extends NIL
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Discrete")
 "Discrete rate is a special case of rate of flow (see Rate) where the increment
  of time between items is non-zero."
  ())

;;; =========================================================
;;; ====================== DistributedProperty
;;; =========================================================
(def-meta-stereotype |DistributedProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-DistributedProperty")
 "DistributedProperty is a stereotype of Property used to apply a probability
  distribution to the values of the property. Specific distributions should
  be defined as subclasses of the DistributedProperty stereotype with the
  operands of the distributions represented by properties of those stereotype
  subclasses."
  ((|base_Property| :xmi-id "_SysML_-Blocks-DistributedProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Blocks-E_extension_DistributedProperty_base_Property"      
  :name |E_extension_DistributedProperty_base_Property|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_DistributedProperty_base_Property-extension_DistributedProperty" "extension_DistributedProperty")
                (|DistributedProperty| "base_Property"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_DistributedProperty_base_Property-extension_DistributedProperty" "extension_DistributedProperty")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_DistributedProperty_base_Property-extension_DistributedProperty" 
    :type |DistributedProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_DistributedProperty_base_Property" 
    :name "extension_DistributedProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ElementGroup
;;; =========================================================
(def-meta-stereotype |ElementGroup| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Comment|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-ElementGroup")
 ""
  ((|base_Comment| :xmi-id "_SysML_-ModelElements-ElementGroup-base_Comment"
    :range UML25:|Comment| :multiplicity (0 1))
   (|criterion| :xmi-id "_SysML_-ModelElements-ElementGroup-criterion.1"
    :range |String| :multiplicity (1 1) :is-derived-p T)
   (|member| :xmi-id "_SysML_-ModelElements-ElementGroup-member.1"
    :range UML25:|Element| :multiplicity (0 -1) :is-derived-p T)
   (|name| :xmi-id "_SysML_-ModelElements-ElementGroup-name"
    :range |String| :multiplicity (1 1))
   (|orderedMemeber| :xmi-id "_SysML_-ModelElements-ElementGroup-orderedMemeber"
    :range UML25:|Element| :multiplicity (0 -1) :is-ordered-p T
    :subsetted-properties ((|ElementGroup| |member|)))
   (|size| :xmi-id "_SysML_-ModelElements-ElementGroup-size.1"
    :range |Integer| :multiplicity (1 1) :is-derived-p T)))

(def-meta-operation "allGroups" |ElementGroup| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name '\e :parameter-type 'UML25:|Element|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ElementGroup|
                        :parameter-return-p T))
)

(def-meta-operation "criterion.1" |ElementGroup| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "member.1" |ElementGroup| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type 'UML25:|Element|
                        :parameter-return-p T))
)

(def-meta-operation "size.1" |ElementGroup| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-assoc "_SysML_-ModelElements-E_extension_ElementGroup_base_Comment"      
  :name |E_extension_ElementGroup_base_Comment|      
  :metatype :extension      
  :member-ends ((|ElementGroup| "base_Comment")
                ("_SysML_-ModelElements-E_extension_ElementGroup_base_Comment-extension_ElementGroup" "extension_ElementGroup"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_ElementGroup_base_Comment-extension_ElementGroup" "extension_ElementGroup")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_ElementGroup_base_Comment-extension_ElementGroup" 
    :type |ElementGroup| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_ElementGroup_base_Comment" 
    :name "extension_ElementGroup" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ElementPropertyPath
;;; =========================================================
(def-meta-stereotype |ElementPropertyPath| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Element|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-ElementPropertyPath")
 ""
  ((|base_Element| :xmi-id "_SysML_-Blocks-ElementPropertyPath-base_Element"
    :range UML25:|Element| :multiplicity (0 1))
   (|propertyPath| :xmi-id "_SysML_-Blocks-ElementPropertyPath-propertyPath"
    :range UML25:|Property| :multiplicity (1 -1) :is-ordered-p T
    :documentation
     "The propertyPath list of the NestedConnectorEnd stereotype must identify
      a path of containing properties that identify the connected property in
      the context of the block that owns the connector. The ordering of properties
      is from a property of the block that owns the connector, through a property
      of each intermediate block that types the preceding property, until a property
      is reached that contains a connector end property within its type. The
      connector end property is not included in the propertyPath list, but instead
      is held by the role property of the UML ConnectorEnd metaclass.")))

(def-meta-assoc "_SysML_-Blocks-A_elementPropertyPath_propertyPath"      
  :name |A_elementPropertyPath_propertyPath|      
  :metatype :association      
  :member-ends (("_SysML_-Blocks-A_elementPropertyPath_propertyPath-elementPropertyPath" "elementPropertyPath")
                (|ElementPropertyPath| "propertyPath"))      
  :owned-ends  (("_SysML_-Blocks-A_elementPropertyPath_propertyPath-elementPropertyPath" "elementPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-A_elementPropertyPath_propertyPath-elementPropertyPath" 
    :type |ElementPropertyPath| 
    :multiplicity (1 -1) 
    :association "_SysML_-Blocks-A_elementPropertyPath_propertyPath" 
    :name "elementPropertyPath" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-E_extension_ElementPropertyPath_base_Element"      
  :name |E_extension_ElementPropertyPath_base_Element|      
  :metatype :extension      
  :member-ends ((|ElementPropertyPath| "base_Element")
                ("_SysML_-Blocks-E_extension_ElementPropertyPath_base_Element-extension_ElementPropertyPath" "extension_ElementPropertyPath"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_ElementPropertyPath_base_Element-extension_ElementPropertyPath" "extension_ElementPropertyPath")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_ElementPropertyPath_base_Element-extension_ElementPropertyPath" 
    :type |ElementPropertyPath| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_ElementPropertyPath_base_Element" 
    :name "extension_ElementPropertyPath" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== EndPathMultiplicity
;;; =========================================================
(def-meta-stereotype |EndPathMultiplicity| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-EndPathMultiplicity")
 ""
  ((|base_Property| :xmi-id "_SysML_-Blocks-EndPathMultiplicity-base_Property"
    :range UML25:|Property| :multiplicity (0 1))
   (|lower| :xmi-id "_SysML_-Blocks-EndPathMultiplicity-lower"
    :range |Integer| :multiplicity (0 1) :default 0
    :documentation
     "Gives the minimum number of values of the property at the end of the related
      bindingPath, for each object reached by navigation along the bindingPath
      from an instance of the block owning the property to which EndPathMultiplicity
      is applied")
   (|upper| :xmi-id "_SysML_-Blocks-EndPathMultiplicity-upper"
    :range |UnlimitedNatural| :multiplicity (0 1) :default :*
    :documentation
     "Gives the maximum number of values of the property at the end of the related
      bindingPath, for each object reached by navigation along the bindingPath
      from an instance of the block owning the property to which EndPathMultiplicity
      is applied.")))

(def-meta-assoc "_SysML_-Blocks-E_extension_EndPathMultiplicity_base_Property"      
  :name |E_extension_EndPathMultiplicity_base_Property|      
  :metatype :extension      
  :member-ends ((|EndPathMultiplicity| "base_Property")
                ("_SysML_-Blocks-E_extension_EndPathMultiplicity_base_Property-extension_EndPathMultiplicity" "extension_EndPathMultiplicity"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_EndPathMultiplicity_base_Property-extension_EndPathMultiplicity" "extension_EndPathMultiplicity")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_EndPathMultiplicity_base_Property-extension_EndPathMultiplicity" 
    :type |EndPathMultiplicity| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_EndPathMultiplicity_base_Property" 
    :name "extension_EndPathMultiplicity" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Expose
;;; =========================================================
(def-meta-stereotype |Expose| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Dependency|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Expose")
 ""
  ((|base_Dependency| :xmi-id "_SysML_-ModelElements-Expose-base_Dependency"
    :range UML25:|Dependency| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-ModelElements-E_extension_Expose_base_Dependency"      
  :name |E_extension_Expose_base_Dependency|      
  :metatype :extension      
  :member-ends ((|Expose| "base_Dependency")
                ("_SysML_-ModelElements-E_extension_Expose_base_Dependency-extension_Expose" "extension_Expose"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Expose_base_Dependency-extension_Expose" "extension_Expose")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Expose_base_Dependency-extension_Expose" 
    :type |Expose| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Expose_base_Dependency" 
    :name "extension_Expose" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== FlowPort
;;; =========================================================
(def-meta-stereotype |FlowPort| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Port|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_-DeprecatedElements-FlowPort")
 "A FlowPort is an interaction point through which input and/or output of
  items such as data, material, or energy may flow. This enables the owning
  block to declare which items it may exchange with its environment and the
  interaction points through which the exchange is made. We distinguish between
  atomic flow port and a nonatomic flow port. Atomic flow ports relay items
  that are classified by a single Block, ValueType, DataType, or Signal classifier.
  A nonatomic flow port relays items of several types as specified by a FlowSpecification.
  Flow ports and associated flow specifications define    what can flow 
    between the block and its environment, whereas item flows specify   
  what does flow    in a specific usage context. Flow ports relay items to
  their owning block or to a connector that connects them with their owner
    s internal parts (internal connector)."
  ((|base_Port| :xmi-id "_SysML_-DeprecatedElements-FlowPort-base_Port"
    :range UML25:|Port| :multiplicity (1 1))
   (|direction| :xmi-id "_SysML_-DeprecatedElements-FlowPort-direction"
    :range |FlowDirection| :multiplicity (1 1) :default :inout
    :documentation
     "Indicates the direction in which an atomic flow port relays its items.
      If the direction is set to    in,    then the items are relayed from an
      external connector via the flow port into the flow port   s owner (or one
      of its parts). If the direction is set to    out,    then the items are
      relayed from the flow port   s owner, via the flow port, through an external
      connector attached to the flow port. If the direction is set to    inout,
         then items can flow both ways. By default, the value is inout.")
   (|isAtomic| :xmi-id "_SysML_-DeprecatedElements-FlowPort-isAtomic"
    :range |Boolean| :multiplicity (1 1) :is-derived-p T
    :documentation
     "This is a derived attribute (derived from the flow port   s type). For
      a flow port typed by a flow specification the value of this attribute is
      False, otherwise the value is True.")))

(def-meta-assoc "_SysML_-DeprecatedElements-E_extension_FlowPort_base_Port"      
  :name |E_extension_FlowPort_base_Port|      
  :metatype :extension      
  :member-ends (("_SysML_-DeprecatedElements-E_extension_FlowPort_base_Port-extension_" "extension_")
                (|FlowPort| "base_Port"))      
  :owned-ends  (("_SysML_-DeprecatedElements-E_extension_FlowPort_base_Port-extension_" "extension_")))

(def-meta-assoc-end "_SysML_-DeprecatedElements-E_extension_FlowPort_base_Port-extension_" 
    :type |FlowPort| 
    :multiplicity (1 1) 
    :association "_SysML_-DeprecatedElements-E_extension_FlowPort_base_Port" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== FlowProperty
;;; =========================================================
(def-meta-stereotype |FlowProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-FlowProperty")
 "A FlowProperty signifies a single flow element that can flow to/from a
  block. A flow property   s values are either received from or transmitted
  to an external block. Flow properties are defined directly on blocks or
  flow specifications that are those specifications which type the flow ports.
  Flow properties enable item flows across connectors connecting parts of
  the corresponding block types, either directly (in case of the property
  is defined on the block) or via flowPorts. For Block, Data Type, and Value
  Type properties, setting an    out    FlowProperty value of a block usage
  on one end of a connector will result in assigning the same value of an
     in    FlowProperty of a block usage at the other end of the connector,
  provided the flow properties are matched. Flow properties of type Signal
  imply sending and/or receiving of a signal usage. An    out    FlowProperty
  of type Signal means that the owning Block may broadcast the signal via
  connectors and an    in    FlowProperty means that the owning block is
  able to receive the Signal."
  ((|base_Property| :xmi-id "_SysML_-Ports%2526Flows-FlowProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))
   (|direction| :xmi-id "_SysML_-Ports%2526Flows-FlowProperty-direction"
    :range |FlowDirection| :multiplicity (1 1) :default :inout
    :documentation
     "Specifies if the property value is received from an external block (direction=
        in   ), transmitted to an external Block (direction=   out   ) or both
      (direction=   inout   ).")))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_FlowProperty_base_Property"      
  :name |E_extension_FlowProperty_base_Property|      
  :metatype :extension      
  :member-ends (("_SysML_-Ports%2526Flows-E_extension_FlowProperty_base_Property-extension_FlowProperty" "extension_FlowProperty")
                (|FlowProperty| "base_Property"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_FlowProperty_base_Property-extension_FlowProperty" "extension_FlowProperty")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_FlowProperty_base_Property-extension_FlowProperty" 
    :type |FlowProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_FlowProperty_base_Property" 
    :name "extension_FlowProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== FlowSpecification
;;; =========================================================
(def-meta-stereotype |FlowSpecification| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Interface|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_-DeprecatedElements-FlowSpecification")
 "A FlowSpecification specifies inputs and outputs as a set of flow properties.
  A flow specification is used by flow ports to specify what items can flow
  via the port."
  ((|base_Interface| :xmi-id "_SysML_-DeprecatedElements-FlowSpecification-base_Interface"
    :range UML25:|Interface| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-DeprecatedElements-E_extension_FlowSpecification_base_Interface"      
  :name |E_extension_FlowSpecification_base_Interface|      
  :metatype :extension      
  :member-ends (("_SysML_-DeprecatedElements-E_extension_FlowSpecification_base_Interface-extension_" "extension_")
                (|FlowSpecification| "base_Interface"))      
  :owned-ends  (("_SysML_-DeprecatedElements-E_extension_FlowSpecification_base_Interface-extension_" "extension_")))

(def-meta-assoc-end "_SysML_-DeprecatedElements-E_extension_FlowSpecification_base_Interface-extension_" 
    :type |FlowSpecification| 
    :multiplicity (1 1) 
    :association "_SysML_-DeprecatedElements-E_extension_FlowSpecification_base_Interface" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== FullPort
;;; =========================================================
(def-meta-stereotype |FullPort| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Port|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-FullPort")
 ""
  ((|base_Port| :xmi-id "_SysML_-Ports%2526Flows-FullPort-base_Port"
    :range UML25:|Port| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_FullPort_base_Port"      
  :name |E_extension_FullPort_base_Port|      
  :metatype :extension      
  :member-ends ((|FullPort| "base_Port")
                ("_SysML_-Ports%2526Flows-E_extension_FullPort_base_Port-extension_FullPort" "extension_FullPort"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_FullPort_base_Port-extension_FullPort" "extension_FullPort")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_FullPort_base_Port-extension_FullPort" 
    :type |FullPort| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_FullPort_base_Port" 
    :name "extension_FullPort" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== InterfaceBlock
;;; =========================================================
(def-meta-stereotype |InterfaceBlock| 
   (:model :SYSML14 :superclasses (|Block|) :extends NIL
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-InterfaceBlock")
 ""
  ())

;;; =========================================================
;;; ====================== InvocationOnNestedPortAction
;;; =========================================================
(def-meta-stereotype |InvocationOnNestedPortAction| 
   (:model :SYSML14 :superclasses (|ElementPropertyPath|) :extends (UML25:|InvocationAction|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-InvocationOnNestedPortAction")
 ""
  ((|base_InvocationAction| :xmi-id "_SysML_-Ports%2526Flows-InvocationOnNestedPortAction-base_InvocationAction"
    :range UML25:|InvocationAction| :multiplicity (0 1) :redefined-property (|ElementPropertyPath| |base_Element|))
   (|onNestedPort| :xmi-id "_SysML_-Ports%2526Flows-InvocationOnNestedPortAction-onNestedPort"
    :range UML25:|Port| :multiplicity (1 -1) :is-ordered-p T :redefined-property (|ElementPropertyPath| |propertyPath|))))

(def-meta-assoc "_SysML_-Ports%2526Flows-A_invocationOnNestedPortAction_onNestedPort"      
  :name |A_invocationOnNestedPortAction_onNestedPort|      
  :metatype :association      
  :member-ends (("_SysML_-Ports%2526Flows-A_invocationOnNestedPortAction_onNestedPort-invocationOnNestedPortAction" "invocationOnNestedPortAction")
                (|InvocationOnNestedPortAction| "onNestedPort"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-A_invocationOnNestedPortAction_onNestedPort-invocationOnNestedPortAction" "invocationOnNestedPortAction")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-A_invocationOnNestedPortAction_onNestedPort-invocationOnNestedPortAction" 
    :type |InvocationOnNestedPortAction| 
    :multiplicity (1 -1) 
    :association "_SysML_-Ports%2526Flows-A_invocationOnNestedPortAction_onNestedPort" 
    :name "invocationOnNestedPortAction" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction"      
  :name |E_extension_InvocationOnNestedPortAction_base_InvocationAction|      
  :metatype :extension      
  :member-ends ((|InvocationOnNestedPortAction| "base_InvocationAction")
                ("_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction-extension_InvocationOnNestedPortAction" "extension_InvocationOnNestedPortAction"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction-extension_InvocationOnNestedPortAction" "extension_InvocationOnNestedPortAction")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction-extension_InvocationOnNestedPortAction" 
    :type |InvocationOnNestedPortAction| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction" 
    :name "extension_InvocationOnNestedPortAction" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ItemFlow
;;; =========================================================
(def-meta-stereotype |ItemFlow| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|InformationFlow|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-ItemFlow")
 "An ItemFlow describes the flow of items across a connector or an association.
  It may constrain the item exchange between blocks, block usages, or flow
  ports as specified by their flow properties. For example, a pump connected
  to a tank: the pump has an    out    flow property of type Liquid and the
  tank has an    in    FlowProperty of type Liquid. To signify that only
  water flows between the pump and the tank, we can specify an ItemFlow of
  type Water on the connector."
  ((|base_InformationFlow| :xmi-id "_SysML_-Ports%2526Flows-ItemFlow-base_InformationFlow"
    :range UML25:|InformationFlow| :multiplicity (0 1))
   (|itemProperty| :xmi-id "_SysML_-Ports%2526Flows-ItemFlow-itemProperty"
    :range UML25:|Property| :multiplicity (0 1)
    :documentation
     "An optional property that relates the flowing item to the instances of
      the connector   s enclosing block. This property is applicable only for
      item flows assigned to connectors. The multiplicity is zero if the item
      flow is assigned to an Association.")))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_ItemFlow_base_InformationFlow"      
  :name |E_extension_ItemFlow_base_InformationFlow|      
  :metatype :extension      
  :member-ends (("_SysML_-Ports%2526Flows-E_extension_ItemFlow_base_InformationFlow-extension_ItemFlow" "extension_ItemFlow")
                (|ItemFlow| "base_InformationFlow"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_ItemFlow_base_InformationFlow-extension_ItemFlow" "extension_ItemFlow")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_ItemFlow_base_InformationFlow-extension_ItemFlow" 
    :type |ItemFlow| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_ItemFlow_base_InformationFlow" 
    :name "extension_ItemFlow" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== NestedConnectorEnd
;;; =========================================================
(def-meta-stereotype |NestedConnectorEnd| 
   (:model :SYSML14 :superclasses (|ElementPropertyPath|) :extends (UML25:|ConnectorEnd|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-NestedConnectorEnd")
 "The NestedConnectorEnd stereotype of UML ConnectorEnd extends a UML ConnectorEnd
  so that the connected property may be identified by a multi-level path
  of accessible properties from the block that owns the connector."
  ((|base_ConnectorEnd| :xmi-id "_SysML_-Blocks-NestedConnectorEnd-base_ConnectorEnd"
    :range UML25:|ConnectorEnd| :multiplicity (0 1) :redefined-property (|ElementPropertyPath| |base_Element|))))

(def-meta-assoc "_SysML_-Blocks-E_extension_NestedConnectorEnd_base_ConnectorEnd"      
  :name |E_extension_NestedConnectorEnd_base_ConnectorEnd|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_NestedConnectorEnd_base_ConnectorEnd-extension_NestedConnectorEnd" "extension_NestedConnectorEnd")
                (|NestedConnectorEnd| "base_ConnectorEnd"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_NestedConnectorEnd_base_ConnectorEnd-extension_NestedConnectorEnd" "extension_NestedConnectorEnd")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_NestedConnectorEnd_base_ConnectorEnd-extension_NestedConnectorEnd" 
    :type |NestedConnectorEnd| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_NestedConnectorEnd_base_ConnectorEnd" 
    :name "extension_NestedConnectorEnd" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== NoBuffer
;;; =========================================================
(def-meta-stereotype |NoBuffer| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|ObjectNode|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-NoBuffer")
 "When this stereotype is applied to object nodes, tokens arriving at the
  node are discarded if they are refused by outgoing edges, or refused by
  actions for object nodes that are input pins. This is typically used with
  fast or continuously flowing data values, to prevent buffer overrun, or
  to model transient values, such as electrical signals. For object nodes
  that are the target of continuous flows,   nobuffer   and   overwrite 
   have the same effect. The stereotype does not override UML token offering
  semantics; it just indicates what happens to the token when it is accepted.
  When the stereotype is not applied, the semantics are as in UML, specifically,
  tokens arriving at an object node that are refused by outgoing edges, or
  action for input pins, are held until they can leave the object node."
  ((|base_ObjectNode| :xmi-id "_SysML_-Activities-NoBuffer-base_ObjectNode"
    :range UML25:|ObjectNode| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_NoBuffer_base_ObjectNode"      
  :name |E_extension_NoBuffer_base_ObjectNode|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_NoBuffer_base_ObjectNode-extension_NoBuffer" "extension_NoBuffer")
                (|NoBuffer| "base_ObjectNode"))      
  :owned-ends  (("_SysML_-Activities-E_extension_NoBuffer_base_ObjectNode-extension_NoBuffer" "extension_NoBuffer")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_NoBuffer_base_ObjectNode-extension_NoBuffer" 
    :type |NoBuffer| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_NoBuffer_base_ObjectNode" 
    :name "extension_NoBuffer" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Optional
;;; =========================================================
(def-meta-stereotype |Optional| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Parameter|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Optional")
 "When the   optional   stereotype is applied to parameters, the lower multiplicity
  must be equal to zero. This means the parameter is not required to have
  a value for the activity or any behavior to begin or end execution. Otherwise,
  the lower multiplicity must be greater than zero, which is called    required."
  ((|base_Parameter| :xmi-id "_SysML_-Activities-Optional-base_Parameter"
    :range UML25:|Parameter| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_Optional_base_Parameter"      
  :name |E_extension_Optional_base_Parameter|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Optional_base_Parameter-extension_Optional" "extension_Optional")
                (|Optional| "base_Parameter"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Optional_base_Parameter-extension_Optional" "extension_Optional")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Optional_base_Parameter-extension_Optional" 
    :type |Optional| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Optional_base_Parameter" 
    :name "extension_Optional" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Overwrite
;;; =========================================================
(def-meta-stereotype |Overwrite| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|ObjectNode|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Overwrite")
 "When the   overwrite   stereotype is applied to object nodes, a token arriving
  at a full object node replaces the ones already there (a full object node
  has as many tokens as allowed by its upper bound). This is typically used
  on an input pin with an upper bound of 1 to ensure that stale data is overridden
  at an input pin. For upper bounds greater than one, the token replaced
  is the one that would be the last to be selected according to the ordering
  kind for the node. For FIFO ordering, this is the most recently added token,
  for LIFO it is the least recently added token. A null token removes all
  the tokens already there. The number of tokens replaced is equal to the
  weight of the incoming edge, which defaults to 1. For object nodes that
  are the target of continuous flows,   overwrite   and   nobuffer   have
  the same effect. The stereotype does not override UML token offering semantics,
  just indicates what happens to the token when it is accepted. When the
  stereotype is not applied, the semantics is as in UML, specifically, tokens
  arriving at object nodes do not replace ones that are already there."
  ((|base_ObjectNode| :xmi-id "_SysML_-Activities-Overwrite-base_ObjectNode"
    :range UML25:|ObjectNode| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_Overwrite_base_ObjectNode"      
  :name |E_extension_Overwrite_base_ObjectNode|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Overwrite_base_ObjectNode-extension_Overwrite" "extension_Overwrite")
                (|Overwrite| "base_ObjectNode"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Overwrite_base_ObjectNode-extension_Overwrite" "extension_Overwrite")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Overwrite_base_ObjectNode-extension_Overwrite" 
    :type |Overwrite| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Overwrite_base_ObjectNode" 
    :name "extension_Overwrite" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ParticipantProperty
;;; =========================================================
(def-meta-stereotype |ParticipantProperty| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Property|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-ParticipantProperty")
 "The Block stereotype extends Class, so it can be applied to any specialization
  of Class, including Association Classes. These are informally called  
   association blocks.    An association block can own properties and connectors,
  like any other block. Each instance of an association block can link together
  instances of the end classifiers of the association. To refer to linked
  objects and values of an instance of an association block, it is necessary
  for the modeler to specify which (participant) properties of the association
  block identify the instances being linked at which end of the association.
  The value of a participant property on an instance (link) of the association
  block is the value or object at the end of the link corresponding to this
  end of the association."
  ((|base_Property| :xmi-id "_SysML_-Blocks-ParticipantProperty-base_Property"
    :range UML25:|Property| :multiplicity (0 1))
   (|end| :xmi-id "_SysML_-Blocks-ParticipantProperty-end"
    :range UML25:|Property| :multiplicity (1 1)
    :documentation
     "A member end of the association block owning the property on which the
      stereotype is applied.")))

(def-meta-assoc "_SysML_-Blocks-E_extension_ParticipantProperty_base_Property"      
  :name |E_extension_ParticipantProperty_base_Property|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_ParticipantProperty_base_Property-extension_ParticipantProperty" "extension_ParticipantProperty")
                (|ParticipantProperty| "base_Property"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_ParticipantProperty_base_Property-extension_ParticipantProperty" "extension_ParticipantProperty")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_ParticipantProperty_base_Property-extension_ParticipantProperty" 
    :type |ParticipantProperty| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_ParticipantProperty_base_Property" 
    :name "extension_ParticipantProperty" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Probability
;;; =========================================================
(def-meta-stereotype |Probability| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|ParameterSet| UML25:|ActivityEdge|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Probability")
 "When the   probability   stereotype is applied to edges coming out of decision
  nodes and object nodes, it provides an expression for the probability that
  the edge will be traversed. These must be between zero and one inclusive,
  and add up to one for edges with same source at the time the probabilities
  are used. When the   probability   stereotype is applied to output parameter
  sets, it gives the probability the parameter set will be given values at
  runtime. These must be between zero and one inclusive, and add up to one
  for output parameter sets of the same behavior at the time the probabilities
  are used."
  ((|base_ActivityEdge| :xmi-id "_SysML_-Activities-Probability-base_ActivityEdge"
    :range UML25:|ActivityEdge| :multiplicity (0 1))
   (|base_ParameterSet| :xmi-id "_SysML_-Activities-Probability-base_ParameterSet"
    :range UML25:|ParameterSet| :multiplicity (0 1))
   (|probability| :xmi-id "_SysML_-Activities-Probability-probability"
    :range UML25:|ValueSpecification| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_Probability_base_ActivityEdge"      
  :name |E_extension_Probability_base_ActivityEdge|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Probability_base_ActivityEdge-extension_Probability" "extension_Probability")
                (|Probability| "base_ActivityEdge"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Probability_base_ActivityEdge-extension_Probability" "extension_Probability")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Probability_base_ActivityEdge-extension_Probability" 
    :type |Probability| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Probability_base_ActivityEdge" 
    :name "extension_Probability" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Activities-E_extension_Probability_base_ParameterSet"      
  :name |E_extension_Probability_base_ParameterSet|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Probability_base_ParameterSet-extension_Probability" "extension_Probability")
                (|Probability| "base_ParameterSet"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Probability_base_ParameterSet-extension_Probability" "extension_Probability")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Probability_base_ParameterSet-extension_Probability" 
    :type |Probability| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Probability_base_ParameterSet" 
    :name "extension_Probability" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Problem
;;; =========================================================
(def-meta-stereotype |Problem| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Comment|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Problem")
 "A Problem documents a deficiency, limitation, or failure of one or more
  model elements to satisfy a requirement or need, or other undesired outcome.
  It may be used to capture problems identified during analysis, design,
  verification, or manufacture and associate the problem with the relevant
  model elements. Problem is a stereotype of comment and may be attached
  to any other model element in the same manner as a comment."
  ((|base_Comment| :xmi-id "_SysML_-ModelElements-Problem-base_Comment"
    :range UML25:|Comment| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-ModelElements-E_extension_Problem_base_Comment"      
  :name |E_extension_Problem_base_Comment|      
  :metatype :extension      
  :member-ends (("_SysML_-ModelElements-E_extension_Problem_base_Comment-extension_Problem" "extension_Problem")
                (|Problem| "base_Comment"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Problem_base_Comment-extension_Problem" "extension_Problem")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Problem_base_Comment-extension_Problem" 
    :type |Problem| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Problem_base_Comment" 
    :name "extension_Problem" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== PropertySpecificType
;;; =========================================================
(def-meta-stereotype |PropertySpecificType| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Classifier|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-PropertySpecificType")
 "The PropertySpecificType stereotype should automatically be applied to
  the classifier which types a property with a propertyspecific type. This
  classifier can contain definitions of new or redefined features which extend
  the original classifier referenced by the property-specific type."
  ((|base_Classifier| :xmi-id "_SysML_-Blocks-PropertySpecificType-base_Classifier"
    :range UML25:|Classifier| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Blocks-E_extension_PropertySpecificType_base_Classifier"      
  :name |E_extension_PropertySpecificType_base_Classifier|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_PropertySpecificType_base_Classifier-extension_PropertySpecificType" "extension_PropertySpecificType")
                (|PropertySpecificType| "base_Classifier"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_PropertySpecificType_base_Classifier-extension_PropertySpecificType" "extension_PropertySpecificType")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_PropertySpecificType_base_Classifier-extension_PropertySpecificType" 
    :type |PropertySpecificType| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_PropertySpecificType_base_Classifier" 
    :name "extension_PropertySpecificType" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ProxyPort
;;; =========================================================
(def-meta-stereotype |ProxyPort| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Port|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-ProxyPort")
 ""
  ((|base_Port| :xmi-id "_SysML_-Ports%2526Flows-ProxyPort-base_Port"
    :range UML25:|Port| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_ProxyPort_base_Port"      
  :name |E_extension_ProxyPort_base_Port|      
  :metatype :extension      
  :member-ends ((|ProxyPort| "base_Port")
                ("_SysML_-Ports%2526Flows-E_extension_ProxyPort_base_Port-extension_ProxPort" "extension_ProxPort"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_ProxyPort_base_Port-extension_ProxPort" "extension_ProxPort")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_ProxyPort_base_Port-extension_ProxPort" 
    :type |ProxyPort| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_ProxyPort_base_Port" 
    :name "extension_ProxPort" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== QuantityKind
;;; =========================================================
(def-meta-class |QuantityKind| 
   (:model :SYSML14 :superclasses NIL 
    :packages (|SysML| |Libraries| |UnitAndQuantityKind|) 
    :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind")
 ""
  ((|definitionURI| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind-definitionURI"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|description| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind-description"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|name| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind-name"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|scale| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind-scale"
    :range |Scale| :multiplicity (0 1))
   (|symbol| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-QuantityKind-symbol"
    :range |String| :multiplicity (0 1) :is-composite-p T)))

(def-meta-assoc "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_quantityKind_scale"      
  :name |A_quantityKind_scale|      
  :metatype :association      
  :member-ends ((|QuantityKind| "scale")
                ("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_quantityKind_scale-quantityKind" "quantityKind"))      
  :owned-ends  (("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_quantityKind_scale-quantityKind" "quantityKind")))

(def-meta-assoc-end "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_quantityKind_scale-quantityKind" 
    :type |QuantityKind| 
    :multiplicity (1 1) 
    :association "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_quantityKind_scale" 
    :name "quantityKind" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Rate
;;; =========================================================
(def-meta-stereotype |Rate| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Parameter| UML25:|ObjectNode| UML25:|ActivityEdge|)
 :packages (|SysML| |Activities|) 
 :xmi-id "_SysML_-Activities-Rate")
 "When the   rate   stereotype is applied to an activity edge, it specifies
  the expected value of the number of objects and values that traverse the
  edge per time interval, that is, the expected value rate at which they
  leave the source node and arrive at the target node. It does not refer
  to the rate at which a value changes over time. When the stereotype is
  applied to a parameter, the parameter must be streaming, and the stereotype
  gives the number of objects or values that flow in or out of the parameter
  per time interval while the behavior or operation is executing. Streaming
  is a characteristic of UML behavior parameters that supports the input
  and output of items while a behavior is executing, rather than only when
  the behavior starts and stops. The flow may be continuous or discrete.
  The   rate   stereotype has a rate property of type InstanceSpecification.
  The values of this property must be instances of classifiers stereotyped
  by   valueType   or   distributionDefinition  . In particular, the denominator
  for units used in the rate property must be time units."
  ((|base_ActivityEdge| :xmi-id "_SysML_-Activities-Rate-base_ActivityEdge"
    :range UML25:|ActivityEdge| :multiplicity (0 1))
   (|base_ObjectNode| :xmi-id "_SysML_-Activities-Rate-base_ObjectNode"
    :range UML25:|ObjectNode| :multiplicity (0 1))
   (|base_Parameter| :xmi-id "_SysML_-Activities-Rate-base_Parameter"
    :range UML25:|Parameter| :multiplicity (0 1))
   (|rate| :xmi-id "_SysML_-Activities-Rate-rate"
    :range UML25:|InstanceSpecification| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-Activities-E_extension_Rate_base_ActivityEdge"      
  :name |E_extension_Rate_base_ActivityEdge|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Rate_base_ActivityEdge-extension_Rate" "extension_Rate")
                (|Rate| "base_ActivityEdge"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Rate_base_ActivityEdge-extension_Rate" "extension_Rate")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Rate_base_ActivityEdge-extension_Rate" 
    :type |Rate| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Rate_base_ActivityEdge" 
    :name "extension_Rate" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Activities-E_extension_Rate_base_ObjectNode"      
  :name |E_extension_Rate_base_ObjectNode|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Rate_base_ObjectNode-extension_Rate" "extension_Rate")
                (|Rate| "base_ObjectNode"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Rate_base_ObjectNode-extension_Rate" "extension_Rate")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Rate_base_ObjectNode-extension_Rate" 
    :type |Rate| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Rate_base_ObjectNode" 
    :name "extension_Rate" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Activities-E_extension_Rate_base_Parameter"      
  :name |E_extension_Rate_base_Parameter|      
  :metatype :extension      
  :member-ends (("_SysML_-Activities-E_extension_Rate_base_Parameter-extension_Rate" "extension_Rate")
                (|Rate| "base_Parameter"))      
  :owned-ends  (("_SysML_-Activities-E_extension_Rate_base_Parameter-extension_Rate" "extension_Rate")))

(def-meta-assoc-end "_SysML_-Activities-E_extension_Rate_base_Parameter-extension_Rate" 
    :type |Rate| 
    :multiplicity (1 1) 
    :association "_SysML_-Activities-E_extension_Rate_base_Parameter" 
    :name "extension_Rate" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Rationale
;;; =========================================================
(def-meta-stereotype |Rationale| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Comment|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Rationale")
 "A Rationale documents the justification for decisions and the requirements,
  design, and other decisions. A Rationale can be attached to any model element
  including relationships. It allows the user, for example, to specify a
  rationale that may reference more detailed documentation such as a trade
  study or analysis report. Rationale is a stereotype of comment and may
  be attached to any other model element in the same manner as a comment."
  ((|base_Comment| :xmi-id "_SysML_-ModelElements-Rationale-base_Comment"
    :range UML25:|Comment| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-ModelElements-E_extension_Rationale_base_Comment"      
  :name |E_extension_Rationale_base_Comment|      
  :metatype :extension      
  :member-ends (("_SysML_-ModelElements-E_extension_Rationale_base_Comment-extension_Rationale" "extension_Rationale")
                (|Rationale| "base_Comment"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Rationale_base_Comment-extension_Rationale" "extension_Rationale")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Rationale_base_Comment-extension_Rationale" 
    :type |Rationale| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Rationale_base_Comment" 
    :name "extension_Rationale" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Refine
;;; =========================================================
(def-meta-stereotype |Refine| 
   (:model :SYSML14 :superclasses (UML-PROFILE-20131001:|Refine| |DirectedRelationshipPropertyPath|) :extends (UML25:|Abstraction|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Refine")
 ""
  ((|base_Abstraction| :xmi-id "_SysML_-Requirements-Refine-base_Abstraction"
    :range UML25:|Abstraction| :multiplicity (0 1) :redefined-property (UML-PROFILE-20131001:|Refine| |base_Abstraction|))))

(def-meta-operation "getRefines" |Refine| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Requirement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "_SysML_-Requirements-E_extension_Refine_base_Abstraction"      
  :name |E_extension_Refine_base_Abstraction|      
  :metatype :extension      
  :member-ends ((|Refine| "base_Abstraction")
                ("_SysML_-Requirements-E_extension_Refine_base_Abstraction-extension_Refine" "extension_Refine"))      
  :owned-ends  (("_SysML_-Requirements-E_extension_Refine_base_Abstraction-extension_Refine" "extension_Refine")))

(def-meta-assoc-end "_SysML_-Requirements-E_extension_Refine_base_Abstraction-extension_Refine" 
    :type |Refine| 
    :multiplicity (1 1) 
    :association "_SysML_-Requirements-E_extension_Refine_base_Abstraction" 
    :name "extension_Refine" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Requirement
;;; =========================================================
(def-meta-stereotype |Requirement| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Class|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Requirement")
 "A requirement specifies a capability or condition that must (or should)
  be satisfied. A requirement may specify a function that a system must perform
  or a performance condition that a system must satisfy. Requirements are
  used to establish a contract between the customer (or other stakeholder)
  and those responsible for designing and implementing the system."
  ((|Derived| :xmi-id "_SysML_-Requirements-Requirement-Derived"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the client of a   deriveReqt   relationship
      for which this requirement is a supplier.")
   (|DerivedFrom| :xmi-id "_SysML_-Requirements-Requirement-DerivedFrom"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the supplier of a   deriveReqt 
       relationship for which this requirement is a client.")
   (|Id| :xmi-id "_SysML_-Requirements-Requirement-Id"
    :range |String| :multiplicity (1 1)
    :documentation
     "The unique id of the requirement.")
   (|Master| :xmi-id "_SysML_-Requirements-Requirement-Master"
    :range |Requirement| :multiplicity (1 1) :is-derived-p T
    :documentation
     "This is a derived property that lists the master requirement for this slave
      requirement. The master attribute is derived from the supplier of the Copy
      dependency that has this requirement as the slave.")
   (|RefinedBy| :xmi-id "_SysML_-Requirements-Requirement-RefinedBy"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all elements that are the client of a   refine   relationship
      for which this requirement is a supplier.")
   (|SatisfiedBy| :xmi-id "_SysML_-Requirements-Requirement-SatisfiedBy"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all elements that are the client of a   satisfy   relationship
      for which this requirement is a supplier.")
   (|Text| :xmi-id "_SysML_-Requirements-Requirement-Text"
    :range |String| :multiplicity (1 1)
    :documentation
     "The textual representation or a reference to the textual representation
      of the requirement.")
   (|TracedTo| :xmi-id "_SysML_-Requirements-Requirement-TracedTo"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all elements that are the client of a   trace   relationship
      for which this requirement is a supplier.")
   (|VerifiedBy| :xmi-id "_SysML_-Requirements-Requirement-VerifiedBy"
    :range UML25:|NamedElement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all elements that are the client of a   verify   relationship
      for which this requirement is a supplier.")
   (|base_Class| :xmi-id "_SysML_-Requirements-Requirement-base_Class"
    :range UML25:|Class| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Requirements-E_extension_Requirement_base_Class"      
  :name |E_extension_Requirement_base_Class|      
  :metatype :extension      
  :member-ends (("_SysML_-Requirements-E_extension_Requirement_base_Class-extension_Requirement" "extension_Requirement")
                (|Requirement| "base_Class"))      
  :owned-ends  (("_SysML_-Requirements-E_extension_Requirement_base_Class-extension_Requirement" "extension_Requirement")))

(def-meta-assoc-end "_SysML_-Requirements-E_extension_Requirement_base_Class-extension_Requirement" 
    :type |Requirement| 
    :multiplicity (1 1) 
    :association "_SysML_-Requirements-E_extension_Requirement_base_Class" 
    :name "extension_Requirement" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RequirementRelated
;;; =========================================================
(def-meta-stereotype |RequirementRelated| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|NamedElement|)
 :packages (|SysML| |DeprecatedElements|) 
 :xmi-id "_SysML_-DeprecatedElements-RequirementRelated")
 "This stereotype is used to add properties to those elements that are related
  to requirements via the various dependencies."
  ((|Refines| :xmi-id "_SysML_-DeprecatedElements-RequirementRelated-Refines"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the supplier of a   refine   relationship
      for which this element is a client.")
   (|Satisfies| :xmi-id "_SysML_-DeprecatedElements-RequirementRelated-Satisfies"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the supplier of a   satisfy   relationship
      for which this element is a client.")
   (|TracedFrom| :xmi-id "_SysML_-DeprecatedElements-RequirementRelated-TracedFrom"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the supplier of a   trace   relationship
      for which this element is a client.")
   (|Verifies| :xmi-id "_SysML_-DeprecatedElements-RequirementRelated-Verifies"
    :range |Requirement| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "Derived from all requirements that are the supplier of a   verify   relationship
      for which this element is a client.")
   (|base_NamedElement| :xmi-id "_SysML_-DeprecatedElements-RequirementRelated-base_NamedElement"
    :range UML25:|NamedElement| :multiplicity (1 1))))

(def-meta-assoc "_SysML_-DeprecatedElements-E_extension_RequirementRelated_base_NamedElement"      
  :name |E_extension_RequirementRelated_base_NamedElement|      
  :metatype :extension      
  :member-ends (("_SysML_-DeprecatedElements-E_extension_RequirementRelated_base_NamedElement-extension_" "extension_")
                (|RequirementRelated| "base_NamedElement"))      
  :owned-ends  (("_SysML_-DeprecatedElements-E_extension_RequirementRelated_base_NamedElement-extension_" "extension_")))

(def-meta-assoc-end "_SysML_-DeprecatedElements-E_extension_RequirementRelated_base_NamedElement-extension_" 
    :type |RequirementRelated| 
    :multiplicity (1 1) 
    :association "_SysML_-DeprecatedElements-E_extension_RequirementRelated_base_NamedElement" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Satisfy
;;; =========================================================
(def-meta-stereotype |Satisfy| 
   (:model :SYSML14 :superclasses (|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Satisfy")
 "A Satisfy relationship is a dependency between a requirement and a model
  element that fulfills the requirement. As with other dependencies, the
  arrow direction points from the satisfying (client) model element to the
  (supplier) requirement that is satisfied."
  ())

(def-meta-operation "getSatisfies" |Satisfy| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Requirement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== Scale
;;; =========================================================
(def-meta-class |Scale| 
   (:model :SYSML14 :superclasses NIL 
    :packages (|SysML| |Libraries| |UnitAndQuantityKind| |Deprecated|) 
    :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-Scale")
 ""
  ((|unit| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-Scale-unit"
    :range |Unit| :multiplicity (0 1))
   (|valueDefinition| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-Scale-valueDefinition"
    :range |ScaleValueDefinition| :multiplicity (0 -1) :is-ordered-p T)))

(def-meta-constraint "mustHaveQuantityKind" |Scale| 
   ""
   :operation-body
   "unit->isEmpty() or unit.quantityKind=self.quantityKind")

(def-meta-assoc "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_unit"      
  :name |A_scale_unit|      
  :metatype :association      
  :member-ends (("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_unit-scale" "scale")
                (|Scale| "unit"))      
  :owned-ends  (("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_unit-scale" "scale")))

(def-meta-assoc-end "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_unit-scale" 
    :type |Scale| 
    :multiplicity (0 -1) 
    :association "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_unit" 
    :name "scale" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_valueDefinition"      
  :name |A_scale_valueDefinition|      
  :metatype :association      
  :member-ends (("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_valueDefinition-scale" "scale")
                (|Scale| "valueDefinition"))      
  :owned-ends  (("_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_valueDefinition-scale" "scale")))

(def-meta-assoc-end "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_valueDefinition-scale" 
    :type |Scale| 
    :multiplicity (1 1) 
    :association "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-A_scale_valueDefinition" 
    :name "scale" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ScaleValueDefinition
;;; =========================================================
(def-meta-class |ScaleValueDefinition| 
   (:model :SYSML14 :superclasses NIL 
    :packages (|SysML| |Libraries| |UnitAndQuantityKind| |Deprecated|) 
    :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-ScaleValueDefinition")
 ""
  ((|description| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-ScaleValueDefinition-description"
    :range |String| :multiplicity (1 1) :is-composite-p T)
   (|value| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated-ScaleValueDefinition-value"
    :range UML25:|Element| :multiplicity (1 1) :is-composite-p T)))

;;; =========================================================
;;; ====================== Stakeholder
;;; =========================================================
(def-meta-stereotype |Stakeholder| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Classifier|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Stakeholder")
 ""
  ((|base_Classifier| :xmi-id "_SysML_-ModelElements-Stakeholder-base_Classifier"
    :range UML25:|Classifier| :multiplicity (0 1))
   (|concern| :xmi-id "_SysML_-ModelElements-Stakeholder-concern"
    :range UML25:|Comment| :multiplicity (0 -1))
   (|concernList| :xmi-id "_SysML_-ModelElements-Stakeholder-concernList"
    :range UML25:|Comment| :multiplicity (1 1) :is-derived-p T)))

(def-meta-assoc "_SysML_-ModelElements-E_extension_Stakeholder_base_Classifier"      
  :name |E_extension_Stakeholder_base_Classifier|      
  :metatype :extension      
  :member-ends ((|Stakeholder| "base_Classifier")
                ("_SysML_-ModelElements-E_extension_Stakeholder_base_Classifier-extension_Stakeholder" "extension_Stakeholder"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Stakeholder_base_Classifier-extension_Stakeholder" "extension_Stakeholder")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Stakeholder_base_Classifier-extension_Stakeholder" 
    :type |Stakeholder| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Stakeholder_base_Classifier" 
    :name "extension_Stakeholder" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== TestCase
;;; =========================================================
(def-meta-stereotype |TestCase| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Operation| UML25:|Behavior|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-TestCase")
 "A test case is a method for verifying a requirement is satisfied."
  ((|base_Behavior| :xmi-id "_SysML_-Requirements-TestCase-base_Behavior"
    :range UML25:|Behavior| :multiplicity (0 1))
   (|base_Operation| :xmi-id "_SysML_-Requirements-TestCase-base_Operation"
    :range UML25:|Operation| :multiplicity (0 1))))

(def-meta-assoc "_SysML_-Requirements-E_extension_TestCase_base_Behavior"      
  :name |E_extension_TestCase_base_Behavior|      
  :metatype :extension      
  :member-ends (("_SysML_-Requirements-E_extension_TestCase_base_Behavior-extension_TestCase" "extension_TestCase")
                (|TestCase| "base_Behavior"))      
  :owned-ends  (("_SysML_-Requirements-E_extension_TestCase_base_Behavior-extension_TestCase" "extension_TestCase")))

(def-meta-assoc-end "_SysML_-Requirements-E_extension_TestCase_base_Behavior-extension_TestCase" 
    :type |TestCase| 
    :multiplicity (1 1) 
    :association "_SysML_-Requirements-E_extension_TestCase_base_Behavior" 
    :name "extension_TestCase" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Requirements-E_extension_TestCase_base_Operation"      
  :name |E_extension_TestCase_base_Operation|      
  :metatype :extension      
  :member-ends (("_SysML_-Requirements-E_extension_TestCase_base_Operation-extension_TestCase" "extension_TestCase")
                (|TestCase| "base_Operation"))      
  :owned-ends  (("_SysML_-Requirements-E_extension_TestCase_base_Operation-extension_TestCase" "extension_TestCase")))

(def-meta-assoc-end "_SysML_-Requirements-E_extension_TestCase_base_Operation-extension_TestCase" 
    :type |TestCase| 
    :multiplicity (1 1) 
    :association "_SysML_-Requirements-E_extension_TestCase_base_Operation" 
    :name "extension_TestCase" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Trace
;;; =========================================================
(def-meta-stereotype |Trace| 
   (:model :SYSML14 :superclasses (UML-PROFILE-20131001:|Trace| |DirectedRelationshipPropertyPath|) :extends (UML25:|Abstraction|)
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Trace")
 ""
  ((|base_Abstraction| :xmi-id "_SysML_-Requirements-Trace-base_Abstraction"
    :range UML25:|Abstraction| :multiplicity (0 1) :redefined-property (UML-PROFILE-20131001:|Trace| |base_Abstraction|))))

(def-meta-operation "getTracedFrom" |Trace| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Requirement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "_SysML_-Requirements-E_extension_Trace_base_Abstraction"      
  :name |E_extension_Trace_base_Abstraction|      
  :metatype :extension      
  :member-ends ((|Trace| "base_Abstraction")
                ("_SysML_-Requirements-E_extension_Trace_base_Abstraction-extension_Trace" "extension_Trace"))      
  :owned-ends  (("_SysML_-Requirements-E_extension_Trace_base_Abstraction-extension_Trace" "extension_Trace")))

(def-meta-assoc-end "_SysML_-Requirements-E_extension_Trace_base_Abstraction-extension_Trace" 
    :type |Trace| 
    :multiplicity (1 1) 
    :association "_SysML_-Requirements-E_extension_Trace_base_Abstraction" 
    :name "extension_Trace" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== TriggerOnNestedPort
;;; =========================================================
(def-meta-stereotype |TriggerOnNestedPort| 
   (:model :SYSML14 :superclasses (|ElementPropertyPath|) :extends (UML25:|Trigger|)
 :packages (|SysML| |Ports&Flows|) 
 :xmi-id "_SysML_-Ports%2526Flows-TriggerOnNestedPort")
 ""
  ((|base_Trigger| :xmi-id "_SysML_-Ports%2526Flows-TriggerOnNestedPort-base_Trigger"
    :range UML25:|Trigger| :multiplicity (1 1) :redefined-property (|ElementPropertyPath| |base_Element|))
   (|onNestedPort| :xmi-id "_SysML_-Ports%2526Flows-TriggerOnNestedPort-onNestedPort"
    :range UML25:|Port| :multiplicity (1 -1) :is-ordered-p T :redefined-property (|ElementPropertyPath| |propertyPath|))))

(def-meta-assoc "_SysML_-Ports%2526Flows-A_triggerOnNestedPort_onNestedPort"      
  :name |A_triggerOnNestedPort_onNestedPort|      
  :metatype :association      
  :member-ends (("_SysML_-Ports%2526Flows-A_triggerOnNestedPort_onNestedPort-triggerOnNestedPort" "triggerOnNestedPort")
                (|TriggerOnNestedPort| "onNestedPort"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-A_triggerOnNestedPort_onNestedPort-triggerOnNestedPort" "triggerOnNestedPort")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-A_triggerOnNestedPort_onNestedPort-triggerOnNestedPort" 
    :type |TriggerOnNestedPort| 
    :multiplicity (1 -1) 
    :association "_SysML_-Ports%2526Flows-A_triggerOnNestedPort_onNestedPort" 
    :name "triggerOnNestedPort" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Ports%2526Flows-E_extension_TriggerOnNestedPort_base_Trigger"      
  :name |E_extension_TriggerOnNestedPort_base_Trigger|      
  :metatype :extension      
  :member-ends ((|TriggerOnNestedPort| "base_Trigger")
                ("_SysML_-Ports%2526Flows-E_extension_TriggerOnNestedPort_base_Trigger-extension_TriggerOnNestedPort" "extension_TriggerOnNestedPort"))      
  :owned-ends  (("_SysML_-Ports%2526Flows-E_extension_TriggerOnNestedPort_base_Trigger-extension_TriggerOnNestedPort" "extension_TriggerOnNestedPort")))

(def-meta-assoc-end "_SysML_-Ports%2526Flows-E_extension_TriggerOnNestedPort_base_Trigger-extension_TriggerOnNestedPort" 
    :type |TriggerOnNestedPort| 
    :multiplicity (1 1) 
    :association "_SysML_-Ports%2526Flows-E_extension_TriggerOnNestedPort_base_Trigger" 
    :name "extension_TriggerOnNestedPort" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Unit
;;; =========================================================
(def-meta-class |Unit| 
   (:model :SYSML14 :superclasses NIL 
    :packages (|SysML| |Libraries| |UnitAndQuantityKind|) 
    :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit")
 ""
  ((|definitionURI| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit-definitionURI"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|description| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit-description"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|name| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit-name"
    :range |String| :multiplicity (0 1) :is-composite-p T)
   (|quantityKind| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit-quantityKind"
    :range |QuantityKind| :multiplicity (0 -1))
   (|symbol| :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Unit-symbol"
    :range |String| :multiplicity (0 1) :is-composite-p T)))

(def-meta-assoc "_SysML_-Libraries-UnitAndQuantityKind-A_quantityKind_unit"      
  :name |A_quantityKind_unit|      
  :metatype :association      
  :member-ends ((|Unit| "quantityKind")
                ("_SysML_-Libraries-UnitAndQuantityKind-A_quantityKind_unit-unit" "unit"))      
  :owned-ends  (("_SysML_-Libraries-UnitAndQuantityKind-A_quantityKind_unit-unit" "unit")))

(def-meta-assoc-end "_SysML_-Libraries-UnitAndQuantityKind-A_quantityKind_unit-unit" 
    :type |Unit| 
    :multiplicity (0 -1) 
    :association "_SysML_-Libraries-UnitAndQuantityKind-A_quantityKind_unit" 
    :name "unit" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ValueType
;;; =========================================================
(def-meta-stereotype |ValueType| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|DataType|)
 :packages (|SysML| |Blocks|) 
 :xmi-id "_SysML_-Blocks-ValueType")
 "A ValueType defines types of values that may be used to express information
  about a system, but cannot be identified as the target of any reference.
  Since a value cannot be identified except by means of the value itself,
  each such value within a model is independent of any other, unless other
  forms of constraints are imposed. Value types may be used to type properties,
  operation parameters, or potentially other elements within SysML. SysML
  defines ValueType as a stereotype of UML DataType to establish a more neutral
  term for system values that may never be given a concrete data representation."
  ((|base_DataType| :xmi-id "_SysML_-Blocks-ValueType-base_DataType"
    :range UML25:|DataType| :multiplicity (0 1))
   (|quantityKind| :xmi-id "_SysML_-Blocks-ValueType-quantityKind"
    :range UML25:|InstanceSpecification| :multiplicity (0 1)
    :documentation
     "A kind of quantity that may be stated by means of defined units, as identified
      by an instance of the Dimension stereotype. A value type may optionally
      specify a dimension without any unit. Such a value has no concrete representation,
      but may be used to express a value in an abstract form independent of any
      specific units.")
   (|unit| :xmi-id "_SysML_-Blocks-ValueType-unit"
    :range UML25:|InstanceSpecification| :multiplicity (0 1)
    :documentation
     "A quantity in terms of which the magnitudes of other quantities that have
      the same dimension can be stated, as identified by an instance of the Unit
      stereotype.")))

(def-meta-assoc "_SysML_-Blocks-A_valueType_quantityKind"      
  :name |A_valueType_quantityKind|      
  :metatype :association      
  :member-ends (("_SysML_-Blocks-A_valueType_quantityKind-valueType" "valueType")
                (|ValueType| "quantityKind"))      
  :owned-ends  (("_SysML_-Blocks-A_valueType_quantityKind-valueType" "valueType")))

(def-meta-assoc-end "_SysML_-Blocks-A_valueType_quantityKind-valueType" 
    :type |ValueType| 
    :multiplicity (0 -1) 
    :association "_SysML_-Blocks-A_valueType_quantityKind" 
    :name "valueType" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-A_valueType_unit"      
  :name |A_valueType_unit|      
  :metatype :association      
  :member-ends (("_SysML_-Blocks-A_valueType_unit-valueType" "valueType")
                (|ValueType| "unit"))      
  :owned-ends  (("_SysML_-Blocks-A_valueType_unit-valueType" "valueType")))

(def-meta-assoc-end "_SysML_-Blocks-A_valueType_unit-valueType" 
    :type |ValueType| 
    :multiplicity (0 -1) 
    :association "_SysML_-Blocks-A_valueType_unit" 
    :name "valueType" 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-Blocks-E_extension_ValueType_base_DataType"      
  :name |E_extension_ValueType_base_DataType|      
  :metatype :extension      
  :member-ends (("_SysML_-Blocks-E_extension_ValueType_base_DataType-extension_ValueType" "extension_ValueType")
                (|ValueType| "base_DataType"))      
  :owned-ends  (("_SysML_-Blocks-E_extension_ValueType_base_DataType-extension_ValueType" "extension_ValueType")))

(def-meta-assoc-end "_SysML_-Blocks-E_extension_ValueType_base_DataType-extension_ValueType" 
    :type |ValueType| 
    :multiplicity (1 1) 
    :association "_SysML_-Blocks-E_extension_ValueType_base_DataType" 
    :name "extension_ValueType" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Verify
;;; =========================================================
(def-meta-stereotype |Verify| 
   (:model :SYSML14 :superclasses (|Trace|) :extends NIL
 :packages (|SysML| |Requirements|) 
 :xmi-id "_SysML_-Requirements-Verify")
 "A Verify relationship is a dependency between a requirement and a test
  case or other model element that can determine whether a system fulfills
  the requirement. As with other dependencies, the arrow direction points
  from the (client) element to the (supplier) requirement."
  ())

(def-meta-operation "getVerifies" |Verify| 
   ""
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Requirement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|ref| :parameter-type 'UML25:|NamedElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== View
;;; =========================================================
(def-meta-stereotype |View| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Package| UML25:|Class|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-View")
 "A View is a representation of a whole system or subsystem from the perspective
  of a single viewpoint. Views are allowed to import other elements including
  other packages and other views that conform to the viewpoint."
  ((|base_Class| :xmi-id "_SysML_-ModelElements-View-base_Class"
    :range UML25:|Class| :multiplicity (0 1))
   (|base_Package| :xmi-id "_SysML_-ModelElements-View-base_Package"
    :range UML25:|Package| :multiplicity (0 1))
   (|stakeholder| :xmi-id "_SysML_-ModelElements-View-stakeholder"
    :range |Stakeholder| :multiplicity (0 -1) :is-derived-p T)
   (|viewPoint| :xmi-id "_SysML_-ModelElements-View-viewPoint"
    :range |Viewpoint| :multiplicity (1 1) :is-derived-p T
    :documentation
     "The viewpoint for this View, derived from the supplier of the   conform
        dependency whose client is this View.")))

(def-meta-assoc "_SysML_-ModelElements-E_extension_View_base_Class"      
  :name |E_extension_View_base_Class|      
  :metatype :extension      
  :member-ends ((|View| "base_Class")
                ("_SysML_-ModelElements-E_extension_View_base_Class-extension_View" "extension_View"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_View_base_Class-extension_View" "extension_View")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_View_base_Class-extension_View" 
    :type |View| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_View_base_Class" 
    :name "extension_View" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-assoc "_SysML_-ModelElements-Deprecated-E_extension_View_base_Package"      
  :name |E_extension_View_base_Package|      
  :metatype :extension      
  :member-ends (("_SysML_-ModelElements-Deprecated-E_extension_View_base_Package-extension_View" "extension_View")
                (|View| "base_Package"))      
  :owned-ends  (("_SysML_-ModelElements-Deprecated-E_extension_View_base_Package-extension_View" "extension_View")))

(def-meta-assoc-end "_SysML_-ModelElements-Deprecated-E_extension_View_base_Package-extension_View" 
    :type |View| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-Deprecated-E_extension_View_base_Package" 
    :name "extension_View" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Viewpoint
;;; =========================================================
(def-meta-stereotype |Viewpoint| 
   (:model :SYSML14 :superclasses NIL :extends (UML25:|Class|)
 :packages (|SysML| |ModelElements|) 
 :xmi-id "_SysML_-ModelElements-Viewpoint")
 "A Viewpoint is a specification of the conventions and rules for constructing
  and using a view for the purpose of addressing a set of stakeholder concerns.
  The languages and methods for specifying a view may reference languages
  and methods in another viewpoint. They specify the elements expected to
  be represented in the view, and may be formally or informally defined.
  For example, the security viewpoint may require the security requirements,
  security functional and physical architecture, and security test cases."
  ((|base_Class| :xmi-id "_SysML_-ModelElements-Viewpoint-base_Class"
    :range UML25:|Class| :multiplicity (0 1))
   (|concern| :xmi-id "_SysML_-ModelElements-Viewpoint-concern"
    :range |String| :multiplicity (0 -1) :is-derived-p T)
   (|concernList| :xmi-id "_SysML_-ModelElements-Viewpoint-concernList"
    :range UML25:|Comment| :multiplicity (:* -1)
    :documentation
     "The interest of the stakeholders.")
   (|language| :xmi-id "_SysML_-ModelElements-Viewpoint-language"
    :range |String| :multiplicity (:* -1)
    :documentation
     "The languages used to construct the viewpoint.")
   (|method| :xmi-id "_SysML_-ModelElements-Viewpoint-method"
    :range UML25:|Behavior| :multiplicity (:* -1) :is-derived-p T
    :documentation
     "The methods used to construct the views for this viewpoint.")
   (|presentation| :xmi-id "_SysML_-ModelElements-Viewpoint-presentation"
    :range |String| :multiplicity (0 -1))
   (|purpose| :xmi-id "_SysML_-ModelElements-Viewpoint-purpose"
    :range |String| :multiplicity (1 1)
    :documentation
     "The purpose addresses the stakeholder concerns.")
   (|stakeholder| :xmi-id "_SysML_-ModelElements-Viewpoint-stakeholder"
    :range |Stakeholder| :multiplicity (:* -1)
    :documentation
     "Set of stakeholders.")))

(def-meta-assoc "_SysML_-ModelElements-E_extension_Viewpoint_base_Class"      
  :name |E_extension_Viewpoint_base_Class|      
  :metatype :extension      
  :member-ends (("_SysML_-ModelElements-E_extension_Viewpoint_base_Class-extension_Viewpoint" "extension_Viewpoint")
                (|Viewpoint| "base_Class"))      
  :owned-ends  (("_SysML_-ModelElements-E_extension_Viewpoint_base_Class-extension_Viewpoint" "extension_Viewpoint")))

(def-meta-assoc-end "_SysML_-ModelElements-E_extension_Viewpoint_base_Class-extension_Viewpoint" 
    :type |Viewpoint| 
    :multiplicity (1 1) 
    :association "_SysML_-ModelElements-E_extension_Viewpoint_base_Class" 
    :name "extension_Viewpoint" 
    :aggregation :COMPOSITE 
    :visibility :PUBLIC)

(def-meta-package |Activities| |SysML| :SYSML14 
   (|Overwrite|
    |ControlOperator|
    |Rate|
    |NoBuffer|
    |Discrete|
    |Continuous|
    |Probability|
    |Optional|) :xmi-id "_SysML_-Activities")

(def-meta-package |Allocations| |SysML| :SYSML14 
   (|AllocateActivityPartition|
    |Allocate|) :xmi-id "_SysML_-Allocations")

(def-meta-package |Blocks| |SysML| :SYSML14 
   (|ValueType|
    |DistributedProperty|
    |ConnectorProperty|
    |ParticipantProperty|
    |BindingConnector|
    |Block|
    |PropertySpecificType|
    |NestedConnectorEnd|
    |DirectedRelationshipPropertyPath|
    |ElementPropertyPath|
    |EndPathMultiplicity|
    |BoundReference|
    |AdjunctProperty|
    |ClassifierBehaviorProperty|) :xmi-id "_SysML_-Blocks")

(def-meta-package |ConstraintBlocks| |SysML| :SYSML14 
   (|ConstraintBlock|) :xmi-id "_SysML_-ConstraintBlocks")

(def-meta-package |ControlValues| |Libraries| :SYSML14 
   (|ControlValue|) :xmi-id "_SysML_-Libraries-ControlValues")

(def-meta-package |Deprecated| |ModelElements| :SYSML14 
   () :xmi-id "_SysML_-ModelElements-Deprecated")

(def-meta-package |Deprecated| |PrimitiveValueTypes| :SYSML14 
   () :xmi-id "_SysML_-Libraries-PrimitiveValueTypes-Deprecated")

(def-meta-package |Deprecated| |UnitAndQuantityKind| :SYSML14 
   (|ScaleValueDefinition|
    |Scale|) :xmi-id "_SysML_-Libraries-UnitAndQuantityKind-Deprecated")

(def-meta-package |DeprecatedElements| |SysML| :SYSML14 
   (|FlowPort|
    |FlowSpecification|
    |Allocated|
    |RequirementRelated|) :xmi-id "_SysML_-DeprecatedElements")

(def-meta-package |Libraries| |SysML| :SYSML14 
   (|PrimitiveValueTypes|
    |ControlValues|
    |UnitAndQuantityKind|) :xmi-id "_SysML_-Libraries")

(def-meta-package |ModelElements| |SysML| :SYSML14 
   (|Rationale|
    |View|
    |Conform|
    |Problem|
    |Viewpoint|
    |Stakeholder|
    |Expose|
    |ElementGroup|
    |Deprecated|) :xmi-id "_SysML_-ModelElements")

(def-meta-package |Ports&Flows| |SysML| :SYSML14 
   (|ItemFlow|
    |FlowProperty|
    |FlowDirection|
    |FullPort|
    |InterfaceBlock|
    |ProxyPort|
    |FeatureDirection|
    |AcceptChangeStructuralFeatureEventAction|
    |ChangeStructuralFeatureEvent|
    |DirectedFeature|
    |InvocationOnNestedPortAction|
    |TriggerOnNestedPort|) :xmi-id "_SysML_-Ports%2526Flows")

(def-meta-package |PrimitiveValueTypes| |Libraries| :SYSML14 
   (|Deprecated|) :xmi-id "_SysML_-Libraries-PrimitiveValueTypes")

(def-meta-package |Requirements| |SysML| :SYSML14 
   (|DeriveReqt|
    |Copy|
    |Satisfy|
    |TestCase|
    |Requirement|
    |Verify|
    |VerdictKind|
    |Trace|
    |Refine|) :xmi-id "_SysML_-Requirements")

(def-meta-package |StandardProfile-20131001| NIL :SYSML14 
   () :xmi-id NIL)

(def-meta-package |SysML| NIL :SYSML14 
   (|Blocks|
    |Ports&Flows|
    |Activities|
    |ModelElements|
    |ConstraintBlocks|
    |Allocations|
    |Requirements|
    |DeprecatedElements|
    |Libraries|) :xmi-id "+The-Model+")

(def-meta-package UML\ 2.5 NIL :SYSML14 
   () :xmi-id NIL)

(def-meta-package |UnitAndQuantityKind| |Libraries| :SYSML14 
   (|Unit|
    |QuantityKind|
    |Deprecated|) :xmi-id "_SysML_-Libraries-UnitAndQuantityKind")

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(SYSML14:|DirectedRelationshipPropertyPath|
          SYSML14:|ElementPropertyPath|))
     (setf mofi:ns-uri NIL)
     (setf mofi:ns-prefix "SysML"))
