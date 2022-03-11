;;; Automatically created by pop-gen at 2010-12-28 14:04:56.

(in-package :BPMN-P)



(def-mm-enum |Activity_State| :BPMN-P NIL 
   (|none| |ready| |active| |cancelled| |aborting| |aborted| |completing| |completed|)
   "")



(def-mm-enum |AdHocOrdering| :BPMN-P NIL 
   (|parallel| |sequential|)
   "")



(def-mm-enum |AssociationDirection| :BPMN-P NIL 
   (|none| |one| |both|)
   "")



(def-mm-enum |BusinessRuleImplementation| :BPMN-P NIL 
   (|BusinessRuleWebService| |WebService| |Other| |Unspecified|)
   "")



(def-mm-enum |EventGatewayType| :BPMN-P NIL 
   (|Exclusive| |Parallel|)
   "")



(def-mm-enum |GatewayDirection| :BPMN-P NIL 
   (|Unspecified| |Converging| |Diverging| |Mixed|)
   "")



(def-mm-enum |Implementation| :BPMN-P NIL 
   (|Web Service| |Other| |Unspecified|)
   "")



(def-mm-enum |ItemKind| :BPMN-P NIL 
   (|Physical| |Information|)
   "")



(def-mm-enum |MultiInstanceBehavior| :BPMN-P NIL 
   (|None| |One| |All| |Complex|)
   "")



(def-mm-enum |ProcessState| :BPMN-P NIL 
   (|inactive| |ready| |withdrawn| |active| |terminated| |failed| |completing| |completed| |compensating| |compensated| |closed|)
   "")



(def-mm-enum |ProcessType| :BPMN-P NIL 
   (|none| |public| |non-executable| |executable|)
   "Private Business Processes are those internal to a specific organization.
    These Processes have been generally called workflow or BPM Processes. Another
    synonym typically used in the Web services area is the Orchestration of
    services. There are two (2) types of private Processes: executable and
    non-executable. - An executable Process is a Process that has been modeled
    for the purpose of being executed. Of course, during the development cycle
    of the Process, there will be stages where the Process does not have enough
    detail to be executable. - A non-executable Process is a private Process
    that has been modeled for the purpose of documenting Process behavior at
    a modeler-defined level of detail. Thus, information required for execution,
    such as formal condition expressions are typically not included in a non-executable
    Process. If a swimlanes-like notation is used (e.g., a Collaboration, see
    below) then a private Business Process will be contained within a single
    Pool. The Process flow is therefore contained within the Pool and cannot
    cross the boundaries of the Pool. The flow of Messages can cross the Pool
    boundary to show the interactions that exist between separate private Business
    Processes. A public Process represents the interactions between a private
    Business Process and another Process or Participant). Only those Activities
    that are used to communicate to the other Participant(s), plus the order
    of these Activities, are included in the public Process. All other internal
    Activities of the private Business Process are not shown in the public
    Process. Thus, the public Process shows to the outside world the Messages,
    and the order of these Messages, that are required to interact with that
    Business Process. Public Processes can be modeled separately or within
    a Collaboration to show the flow of Messages between the public Process
    Activities and other Participants. Note that the public type of Process
    was named abstract in BPMN 1.2.")



(def-mm-enum |TransactionMethod| :BPMN-P NIL 
   (|compensate| |store| |image|)
   "")



(def-mm-enum |UserTaskImplementation| :BPMN-P NIL 
   (|Unspecified| |Other| |WebService| |HumanTaskWebService|)
   "")



(def-mm-enum |cancelActivity_conditional| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |cancelActivity_escalation| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |cancelActivity_message| :BPMN-P NIL 
   (|true| |false|)
   "")



(def-mm-enum |cancelActivity_multiple| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |cancelActivity_parallelMultiple| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |cancelActivity_signal| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |cancelActivity_timer| :BPMN-P NIL 
   (|true| |false|)
   "")



(def-mm-enum |isCollection| :BPMN-P NIL 
   (|true| |false|)
   "")



(def-mm-enum |isInterrupting_conditional| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |isInterrupting_escalation| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |isInterrupting_message| :BPMN-P NIL 
   (|true| |false|)
   "")



(def-mm-enum |isInterrupting_multiple| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |isInterrupting_parallelMultiple| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |isInterrupting_signal| :BPMN-P NIL 
   (|false| |true|)
   "")



(def-mm-enum |isInterrupting_timer| :BPMN-P NIL 
   (|false| |true|)
   "")



;;; =========================================================
;;; ====================== AdHocSubProcess
;;; =========================================================
(def-mm-stereotype |AdHocSubProcess| (:BPMN-P) (|SubProcess|)
 "An Ad-Hoc Sub-Process is a specialized type of Sub-Process that is a group
  of Activities that have no required sequence relationships. A set of activities
  can be defined for the Process, but the sequence and number of performances
  for the Activities is determined by the performers of the Activities."
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|cancelRemainingInstances| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "This attribute is used only if ordering is parallel. It determines whether
      running instances are canceled when the completionCondition becomes true.")
   (|completionCondition| :range |String| :multiplicity (1 1)
    :documentation
     "This Expression defines the conditions when the Process will end. When
      the Expression is evaluated to true, the Process will be terminated.")
   (|ordering| :range |AdHocOrdering| :multiplicity (1 1) :default :parallel
    :documentation
     "This attribute defines if the Activities within the Process can be performed
      in parallel or MUST be performed sequentially. The default setting is parallel
      and the setting of sequential is a restriction on the performance that
      can be needed due to shared resources. When the setting is sequential,
      then only one Activity can be performed at a time. When the setting is
      parallel, then zero (0) to all the Activities of the Sub-Process can be
      performed in parallel.")))


(def-mm-constraint "AdHocSubProcess.cancelRemainingInstances" |AdHocSubProcess| 
   "" 
   :operation-body
   "cancelRemainingInstances attribute shall be used only if ordering = parallel")

;;; =========================================================
;;; ====================== Assignment
;;; =========================================================
(def-mm-stereotype |Assignment| (:BPMN-P) NIL
 "The Assignment class is used to specify a simple mapping of data elements
  using a specified expression language. The default expression language
  for all expressions is specified in the Definitions element, using the
  expressionLanguage attribute. It can also be overridden on each individual
  Assignment using the same attribute."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|from| :range UML23:|Element| :multiplicity (1 1))
   (|to| :range UML23:|Element| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-mm-stereotype |Association| (:BPMN-P) (|BPMNArtifact|)
 "An Association is used to associate information and Artifacts with Flow
  Objects. Text and graphical non-Flow Objects can be associated with the
  Flow Objects and Flow. An Association is also used to show the Activity
  used for compensation. An Association is used to connect user-defined text
  (an Annotation) with a Flow Object"
  ((|associationDirection| :range |AssociationDirection| :multiplicity (1 1)
    :documentation
     "associationDirection is an attribute that defines whether or not the Association
      shows any directionality with an arrowhead. The default is None (no arrowhead).
      A value of One means that the arrowhead SHALL be at the Target Object.
      A value of Both means that there SHALL be an arrowhead at both ends of
      the Association line.")
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


(def-mm-constraint "AssociationEnd" |Association| 
   "" 
   :operation-body
   "At least one of association ends (target or source) must be TextAnnotation.")

;;; =========================================================
;;; ====================== AttributeProperty
;;; =========================================================
(def-mm-stereotype |AttributeProperty| (:BPMN-P) (|BPMNProperty|)
 ""
  ((|base_Property| :range UML23:|Property| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Auditing
;;; =========================================================
(def-mm-stereotype |Auditing| (:BPMN-P) (|BaseElement|)
 "The Auditing element and its model associations allow defining attributes
  related to auditing. It leverages the BPMN extensibility mechanism. This
  element is used by FlowElements and Process. The actual definition of auditing
  attributes is out of scope of this specification. BPMN 2.0 implementations
  may define their own set of attributes and their intended semantics."
  ((|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BPMNActivity
;;; =========================================================
(def-mm-stereotype |BPMNActivity| (:BPMN-P) (|FlowNode|)
 "An Activity is work that is performed within a Business Process. An Activity
  can be atomic or non-atomic (compound). The types of Activities that are
  a part of a Process are: Task, Sub-Process, and Call Activity, which allows
  the inclusion of re-usable Tasks and Processes in the diagram. However,
  a Process is not a specific graphical object. Instead, it is a set of graphical
  objects. The following sections will focus on the graphical objects Sub-Process
  and Task. Activities represent points in a Process flow where work is performed.
  They are the executable elements of a BPMN Process. The Activity class
  is an abstract element, sub-classing from FlowElement. Concrete sub-classes
  of Activity specify additional semantics above and beyond that defined
  for the generic Activity."
  ((|base_Action| :range UML23:|Action| :multiplicity (1 1))
   (|boundaryEventRefs| :range |BoundaryEvent| :multiplicity (<Set of 0 {OCL OclAny}, id=308350> -1)
    :opposite (|BoundaryEvent| |attachedToRef|))
   (|completionQuantity| :range |Integer| :multiplicity (1 1) :default 1
    :documentation
     "The default value is 1. The value MUST NOT be less than 1. This attribute
      defines the number of tokens that must be generated from the Activity.
      This number of tokens will be sent done any outgoing Sequence Flow (assuming
      any Sequence Flow Conditions are satisfied). Note that any value for the
      attribute that is greater than 1 is an advanced type of modeling and should
      be used with caution.")
   (|dataInputs| :range |DataInput| :multiplicity (<Set of 0 {OCL OclAny}, id=308355> -1))
   (|dataOutputs| :range |DataOutput| :multiplicity (0 -1))
   (|default| :range |SequenceFlow| :multiplicity (0 1)
    :documentation
     "The Sequence Flow that will receive a token when none of the conditionExpressions
      on other outgoing Sequence Flows evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")
   (|inputSets| :range |InputSet| :multiplicity (0 -1) :is-composite-p T)
   (|isForCompensation| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A flag that identifies whether this activity is intended for the purposes
      of compensation. If false, then this activity executes as a result of normal
      execution flow. If true, this activity is only activated when a Compensation
      Event is detected and initiated under Compensation Event visibility scope.")
   (|outputSets| :range |OutputSet| :multiplicity (0 -1) :is-composite-p T)
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "Defines the resource that will perform or will be responsible for the activity.
      The resource, e.g. a performer, can be specified in the form of a specific
      individual, a group, an organization role or position, or an organization.")
   (|startQuantity| :range |Integer| :multiplicity (1 1) :default 1
    :documentation
     "The default value is 1. The value MUST NOT be less than 1. This attribute
      defines the number of tokens that must arrive before the Activity can begin.
      Note that any value for the attribute that is greater than 1 is an advanced
      type of modeling and should be used with caution.")
   (|state| :range |Activity_State| :multiplicity (1 1) :default :none)))


;;; =========================================================
;;; ====================== BPMNArtifact
;;; =========================================================
(def-mm-stereotype |BPMNArtifact| (:BPMN-P) (|BaseElement|)
 "BPMN provides modelers with the capability of showing additional information
  about a Process that is not directly related to the Sequence Flow or Message
  Flow of the Process. At this point, BPMN provides three (3) standard Artifacts:
  Associations, Groups, and a Text Annotations. Additional Artifacts may
  be added to the BPMN specification in later versions. A modeler or modeling
  tool may extend a BPMN diagram and add new types of Artifacts to a Diagram."
  ((|base_Comment| :range UML23:|Comment| :multiplicity (1 1))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


(def-mm-constraint "Artifact.messageFlow.source" |BPMNArtifact| 
   "" 
   :operation-body
   "An Artifact MUST NOT be a source for Message Flow")

(def-mm-constraint "Artifact.messageFlow.target" |BPMNArtifact| 
   "" 
   :operation-body
   "An Artifact MUST NOT be a target for Message Flow")

(def-mm-constraint "Artifact.sequenceFlow.source" |BPMNArtifact| 
   "" 
   :operation-body
   "An Artifact MUST NOT be a source for Sequence Flow")

(def-mm-constraint "Artifact.sequenceFlow.target" |BPMNArtifact| 
   "" 
   :operation-body
   "An Artifact MUST NOT be a target for Sequence Flow")

;;; =========================================================
;;; ====================== BPMNExpression
;;; =========================================================
(def-mm-stereotype |BPMNExpression| (:BPMN-P) (|BaseElement|)
 "The Expression class is used to specify an expression using natural-language
  text. These expressions are not executable. The natural language text is
  captured using the documentation attribute, inherited from BaseElement."
  ((|base_OpaqueExpression| :range UML23:|OpaqueExpression| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BPMNImport
;;; =========================================================
(def-mm-stereotype |BPMNImport| (:BPMN-P) NIL
 "The Import class is used when referencing external element, either BPMN
  elements contained in other BPMN Definitions or non-BPMN elements. Imports
  must be explicitly defined."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|definition| :range |Definitions| :multiplicity (1 1)
    :opposite (|Definitions| |imports|))
   (|importType| :range |String| :multiplicity (1 1)
    :documentation
     "Specifies the style of import associated with the element. For example,
      a value of http://www.w3.org/2001/XMLSchema indicates that the imported
      element is an XML schema. A value of http://www.omg.org/bpmn20 indicates
      that the imported element is a BPMN element.")
   (|location| :range |String| :multiplicity (0 1)
    :documentation
     "Identifies the location of the imported element.")
   (|namespace| :range |String| :multiplicity (1 1)
    :documentation
     "Identifies the namespace of the imported element.")))


;;; =========================================================
;;; ====================== BPMNInterface
;;; =========================================================
(def-mm-stereotype |BPMNInterface| (:BPMN-P) (|RootElement|)
 "An Interface defines a set of operations that are implemented by Services."
  ((|base_Interface| :range UML23:|Interface| :multiplicity (1 1))
   (|implementationRef| :range UML23:|Element| :multiplicity (0 1)
    :documentation
     "This attribute allows to reference a concrete artifact in the underlying
      implementation technology representing that interface, such as a WSDL porttype.")))


(def-mm-constraint "Interface.operations.multiplicity" |BPMNInterface| 
   "" 
   :operation-body
   "Interface may have from 1 to many operations.")

;;; =========================================================
;;; ====================== BPMNProcess
;;; =========================================================
(def-mm-stereotype |BPMNProcess| (:BPMN-P) (|CallableElement|)
 "A Process describes a sequence or flow of Activities in an enterprise with
  the objective of carrying work. In BPMN a Process is depicted as a graph
  of Flow Elements, which are a set of Activities, Events, Gateways and Sequence
  Flow that define finite execution semantics. Processes can be defined at
  any level from enterprise-wide Processes to Processes performed by a single
  person. Low-level Processes can be grouped together to achieve a common
  business goal. Note that BPMN uses the term Process specifically to mean
  a set of flow elements. It uses the terms Collaboration and Choreography
  when modeling the interaction between Processes. A Process is a CallableElement,
  allowing it to be referenced and reused by other Processes via the Call
  Activity construct. In this capacity, a Process may reference a set of
  Interfaces that define its external behavior. A Process is a reusable element
  and can be imported and used within other Definitions."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|correlationSubscriptions| :range |CorrelationSubscription| :multiplicity (<Set of 0 {OCL OclAny}, id=308423> -1) :is-composite-p T
    :documentation
     "Correlation Subscriptions are a feature of context-based correlation. Correlation
      Subscriptions are used to correlate incoming Messages against data in the
      Process context. A Process MAY contain several correlationSubscriptions.")
   (|defintitionalCollaborationRef| :range |Collaboration| :multiplicity (0 1)
    :documentation
     "For Processes that interact with other Participants, a definitional Collaboration
      can be referenced by the Process. The definitional Collaboration specifies
      the Participants the Process interacts with, and more specifically, which
      individual service, Send or Receive Task, or Message Event, is connected
      to which Participant through Message Flows. The definitional Collaboration
      need not be displayed. Additionally, the definitional Collaboration can
      be used to include Conversation information within a Process.")
   (|isClosed| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A Boolean value specifying whether interactions, such as sending and receiving
      Messages and Events, not modeled in the Process can occur when the Process
      is executed or performed. If the value is true, they MAY NOT occur. If
      the value is false, they MAY occur.")
   (|processType| :range |ProcessType| :multiplicity (1 1) :default :none
    :documentation
     "The processType attribute Provides additional information about the level
      of abstraction modeled by this Process. A public Process shows only those
      flow elements that are relevant to external consumers. Internal details
      are not modeled. These Processes are publicly visible and can be used within
      a Collaboration. Note that the public processType was named abstract in
      BPMN 1.2. A private Process is one that is internal to a specific organization.
      An executable Process is a private Process that has been modeled for the
      purpose of being executed according to the semantics. Of course, during
      the development cycle of the Process, there will be stages where the Process
      does not have enough detail to be executable. A non-executable Process
      is a private Process that has been modeled for the purpose of documenting
      Process behavior at a modeler-defined level of detail. Thus, information
      needed for execution, such as formal condition expressions are typically
      not included in a non-executable Process.")
   (|resources| :range |ResourceRole| :multiplicity (0 -1)
    :documentation
     "Defines the resource that will perform or will be responsible for the Process.
      The resource, e.g., a performer, can be specified in the form of a specific
      individual, a group, an organization role or position, or an organization.
      Note that the assigned resources of the Process does not determine the
      assigned resources of the Activities that are contained by the Process.")
   (|state| :range |ProcessState| :multiplicity (1 1) :default :inactive)
   (|supports| :range |BPMNProcess| :multiplicity (<Set of 0 {OCL OclAny}, id=308440> -1)
    :documentation
     "Modelers can declare that they intend all executions or performances of
      one Process to also be valid for another Process. This means they expect
      all the executions or performances of the first Processes to also follow
      the steps laid out in the second Process.")))


;;; =========================================================
;;; ====================== BPMNProperty
;;; =========================================================
(def-mm-stereotype |BPMNProperty| (:BPMN-P) (|ItemAwareElement|)
 "Properties, like Data Objects, are item-aware elements. But, unlike Data
  Objects, they are not visible within a Process diagram. Certain flow elements
  may contain properties, in particular only Processes, Activities and Events
  may contain Properties The Property class is a DataElement element that
  acts as a container for data associated with flow elements. Property elements
  must be contained within a FlowElement. Property elements are NOT visible
  in a Process diagram."
  ((|itemSubjectRef| :range |ItemDefinition| :multiplicity (0 1))))


(def-mm-constraint "BPMNProperty.apply" |BPMNProperty| 
   "" 
   :operation-body
   "may be applied only for: pin owned by CallActivity or Task Parameter owned by BPMNProcess  Variable owned by SubProcess")

(def-mm-constraint "Property.notation" |BPMNProperty| 
   "" 
   :operation-body
   "Property elements are NOT visible in a Process diagram. Figure")

;;; =========================================================
;;; ====================== BaseElement
;;; =========================================================
(def-mm-stereotype |BaseElement| (:BPMN-P) NIL
 "BaseElement is the abstract super class for most BPMN elements. It provides
  the attributes id and documentation, which other elements will inherit."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_ActivityPartition| :range UML23:|ActivityPartition| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))
   (|base_Comment| :range UML23:|Comment| :multiplicity (1 1))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))
   (|base_Package| :range UML23:|Package| :multiplicity (1 1))
   (|id| :range |String| :multiplicity (1 1)
    :documentation
     "This attribute is used to uniquely identify BPMN elements.")))


;;; =========================================================
;;; ====================== BoundaryEvent
;;; =========================================================
(def-mm-stereotype |BoundaryEvent| (:BPMN-P) (|CatchEvent|)
 ""
  ((|attachedToRef| :range |BPMNActivity| :multiplicity (1 1)
    :opposite (|BPMNActivity| |boundaryEventRefs|))
   (|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BusinessRuleTask
;;; =========================================================
(def-mm-stereotype |BusinessRuleTask| (:BPMN-P) (|Task|)
 "A Business Rule Task provides a mechanism for the Process to provide input
  to a Business Rules Engine and to get the output of calculations that the
  Business Rules Engine might provide. The InputOutputSpecification of the
  Task will allow the Process to send data to and receive data from the Business
  Rules Engine."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|implementation| :range |BusinessRuleImplementation| :multiplicity (1 1) :default :other
    :documentation
     "This attribute specifies the technology that will be used to implement
      the Business Rule Task.")))


;;; =========================================================
;;; ====================== CallActivity
;;; =========================================================
(def-mm-stereotype |CallActivity| (:BPMN-P) (|BPMNActivity|)
 "A Call Activity identifies a point in the Process where a global Process
  or a Global Task is used. The Call Activity acts as a wrapper for the invocation
  of a global Process or Global Task within the execution. The activation
  of a call Activity results in the transfer of control to the called global
  Process or Global Task. The BPMN 2.0 Call Activity corresponds to the Reusable
  Sub-Process of BPMN 1.2. A BPMN 2.0 Sub-Process corresponds to the Embedded
  Sub-Process of BPMN 1.2."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CallChoreography
;;; =========================================================
(def-mm-stereotype |CallChoreography| (:BPMN-P) (|ChoreographyActivity|)
 "A Call Choreography identifies a point in the Process where a global Choreography
  or a Global Choreography Task is used. The Call Choreography acts as a
  place holder for the inclusion of the Choreography element it is calling.
  This pre-defined called Choreography element becomes a part of the definition
  of the parent Choreography. A Call Choreography object shares the same
  shape as the Choreography Task and SubChoreography, which is a rectangle
  that has rounded corners, two (2) or more Participant Bands, and an Activity
  Name Band. However, the target of what the Choreography Activity calls
  will determine the details of its shape."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (<Set of 0 {OCL OclAny}, id=308504> -1) :is-composite-p T
    :documentation
     "Specifies how Participants in a nested Choreography or GlobalChoreographyTask
      match up with the Participants in the Choreography referenced by the Call
      Choreography.")))


;;; =========================================================
;;; ====================== CallConversation
;;; =========================================================
(def-mm-stereotype |CallConversation| (:BPMN-P) (|ConversationNode|)
 "A Call Conversation identifies a place in the Conversation where a global
  Conversation or a GlobalCommunication is used."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (<Set of 0 {OCL OclAny}, id=308515> -1) :is-composite-p T
    :documentation
     "This attribute provides a list of mappings from the Participants of a referenced
      GlobalCommunication or Conversation to the Participants of the parent Conversation.")))


;;; =========================================================
;;; ====================== CallableElement
;;; =========================================================
(def-mm-stereotype |CallableElement| (:BPMN-P) (|RootElement|)
 "CallableElement is the abstract super class of all Activities that have
  been defined outside of a Process or Choreography but which can be called
  (or reused) from within a Process or Choreography. It may reference Interfaces
  that define the service operations that it provides. Callable Elements
  are reusable elements, which can be imported and used in other Definitions."
  ((|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))
   (|supportedInterfacesRefs| :range UML23:|Interface| :multiplicity (0 -1)
    :documentation
     "The Interfaces describing the external behavior provided by this element.")))


;;; =========================================================
;;; ====================== CancelBoundaryEvent
;;; =========================================================
(def-mm-stereotype |CancelBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |CancelEventDefinition|)
 "This type of Intermediate Event is used within a Transaction Sub-Process.
  This type of Event MUST be attached to the boundary of a Sub-Process. It
  SHALL be triggered if a Cancel End Event is reached within the Transaction
  Sub-Process. It also SHALL be triggered if a Transaction Protocol Cancel
  message has been received while the Transaction is being performed."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CancelEndEvent
;;; =========================================================
(def-mm-stereotype |CancelEndEvent| (:BPMN-P) (|EndEvent| |CancelEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CancelEventDefinition
;;; =========================================================
(def-mm-stereotype |CancelEventDefinition| (:BPMN-P) (|EventDefinition|)
 "Cancel Events are only used in the context of modeling Transaction Sub-Processes."
  ())


;;; =========================================================
;;; ====================== CatchEvent
;;; =========================================================
(def-mm-stereotype |CatchEvent| (:BPMN-P) (|Event|)
 "Events that catch a Trigger. All Start Events and some Intermediate Events
  are catching Events"
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Choreography
;;; =========================================================
(def-mm-stereotype |Choreography| (:BPMN-P) (|Collaboration|)
 "A Choreography is a type of process, but differs in purpose and behavior
  from a standard BPMN Process. A standard Process, or an Orchestration Process,
  is more familiar to most process modelers and defines the flow of Activities
  of a specific PartnerEntity or organization. In contrast, Choreography
  formalizes the way business Participants coordinate their interactions.
  The focus is not on orchestrations of the work performed within these Participants,
  but rather on the exchange of information (Messages) between these Participants."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|isClosed| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A Boolean value specifying whether Choreography Activities not modeled
      in the Choreography can occur when the Choreography is carried out. If
      the value is true, they MAY NOT occur. If the value is false, they MAY
      occur.")))


;;; =========================================================
;;; ====================== ChoreographyActivity
;;; =========================================================
(def-mm-stereotype |ChoreographyActivity| (:BPMN-P) (|FlowNode|)
 "A Choreography Activity represents a point in a Choreography flow where
  an interaction occurs between two (2) or more Participants. The Choreography
  Activity class is an abstract element, sub-classing from FlowElement. When
  Choreography Activities are defined they are contained within a Choreography
  or a Choreography Sub-Process, which are FlowElementContainers (other FlowElementContainers
  are not allowed to contain Choreography Activities)."
  ((|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))
   (|initiatingParticipantRef| :range |Participant| :multiplicity (1 1)
    :documentation
     "One (1) of the Participants will be the one that initiates the Choreography
      Activity")
   (|participantRefs| :range |Participant| :multiplicity (2 -1) :is-ordered-p T
    :documentation
     "A Choreography Activity has two (2) or more Participants")))


;;; =========================================================
;;; ====================== ChoreographyDiagram
;;; =========================================================
(def-mm-stereotype |ChoreographyDiagram| (:BPMN-P) NIL
 "ChoreographyDiagram is a concrete DiagramDefinition that defines diagrams
  that reference a BPMN Choreography element as a context. A self-contained
  Choreography (no Pools or Orchestration) is a definition of the expected
  behavior, basically a procedural contract, between interacting Participants.
  While a normal Process exists within a Pool, a Choreography exists between
  Pools (or Participants). The Choreography looks similar to a private Business
  Process since it consists of a network of Activities, Events, and Gateways
  (see Figure 7-4). However, a Choreography is different in that the Activities
  are interactions that represent a set (1 or more) of Message exchanges,
  which involves two (2) or more Participants. In addition, unlike a normal
  Process, there is no central controller, responsible entity or observer
  of the Process."
  ((|base_Diagram| :range NIL :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ChoreographyTask
;;; =========================================================
(def-mm-stereotype |ChoreographyTask| (:BPMN-P) (|ChoreographyActivity|)
 "A Choreography Task is an atomic Activity in a Choreography Process. It
  represents an Interaction, which is a coherent set (1 or more) of Message
  exchanges between two (2) Participants. Using a Collaboration diagram to
  view these elements (see page 143 for more information on Collaboration),
  we would see the two (2) Pools representing the two (2) Participants of
  the Interaction (see Figure 12-7). The communication between the Participants
  is shown as a Message Flow. The interaction defined by a Choreography Task
  can be shown in an expanded format through a Collaboration diagram."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|messageFlow| :range |MessageFlow| :multiplicity (1 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Collaboration
;;; =========================================================
(def-mm-stereotype |Collaboration| (:BPMN-P) (|RootElement|)
 "Collaborations is a collection of Participants shown as Pools, their interactions
  as shown by Message Flow, and may include Processes within the Pools and/or
  Choreographies between the Pools."
  ((|artifacts| :range |BPMNArtifact| :multiplicity (0 -1) :is-composite-p T)
   (|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|choreographyRef| :range |Choreography| :multiplicity (0 -1)
    :documentation
     "The choreographyRef model association defines a Choreography that is shown
      between the Pools of the Collaboration. A Choreography specifies a business
      contract (or the order in which messages will be exchanged) between interacting
      Participants. The participantAssociations (see below) are used to map the
      Participants of the Choreography to the Participants of the Collaboration.
      The choreographyMessageFlowAssociations (see below) are used to map the
      Message Flow of the Choreography to the Message Flow of the Collaboration.")
   (|conversationAssociations| :range |ConversationAssociation| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "This attribute provides a list of mappings from the Conversations of a
      referenced Collaboration to the Conversations of another Collaboration.
      It is used when a Choreography is referenced by a Collaboration.")
   (|conversations| :range |ConversationNode| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "The conversations model aggregation relationship allows a Collaboration
      to contain Conversation elements, in order to group Message Flows of the
      Collaboration and associate correlation information, as is REQUIRED for
      the definitional Collaboration of a Process model. The Conversation elements
      will be visualized if the Collaboration is a Collaboration, but not for
      a Choreography.")
   (|correlationKeys| :range |CorrelationKey| :multiplicity (<Set of 0 {OCL OclAny}, id=308609> -1) :is-composite-p T
    :documentation
     "This association specifies CorrelationKeys used to associate Messages to
      a particular Collaboration.")
   (|isClosed| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A Boolean value specifying whether Message Flow not modeled in the Collaboration
      can occur when the Collaboration is carried out. If the value is true,
      they MAY NOT occur. If the value is false, they MAY occur.")
   (|messageFlow| :range |MessageFlow| :multiplicity (<Set of 0 {OCL OclAny}, id=308616> -1)
    :documentation
     "This attribute provides a list of mappings for the Message Flow of the
      Collaboration to Message Flow of a referenced model. This applies for two
      (2) situations: - When a Choreography is referenced by the Collaboration.
      - When a Conversation is referenced by the Collaboration.")
   (|messageFlowAssociations| :range |MessageFlowAssociation| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "This attribute provides a list of mappings for the Message Flows of the
      Collaboration to Message Flows of a referenced model. It is used in the
      following situation: When a Choreography is referenced by a Collaboration.
      This allows the \"wiring up\" of the Collaboration Message Flows to the appropriate
      Choreography Activities.")
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "This attribute provides a list of mappings from the Participants of a referenced.
      Collaboration to the Participants of another Collaboration. It is used
      in the following situations: * When a Choreography is referenced by the
      Collaboration. * When a definitional Collaboration for a Process is referenced
      through a Call Activity (and mapped to definitional Collaboration of the
      calling Process).")))


;;; =========================================================
;;; ====================== CollaborationDiagram
;;; =========================================================
(def-mm-stereotype |CollaborationDiagram| (:BPMN-P) NIL
 "CollaborationDiagram is a concrete DiagramDefinition that defines diagrams
  that reference a BPMN Collaboration element as a context. A Collaboration
  depicts the interactions between two or more business entities. A Collaboration
  contains two (2) or more Pools, representing the Participants in the Collaboration.
  The Message exchange between the Participants is shown by a Message Flow
  that connects two (2) Pools (or the objects within the Pools). The Messages
  associated with the Message Flow may also be shown. The Collaboration can
  be shown as two or more public Processes communicating with each other.
  With a public Process, the Activities for the Collaboration participants
  can be considered the \"touch-points\" between the participants. The corresponding
  internal (executable) Processes are likely to have much more Activity and
  detail than what is shown in the public Processes. Or a Pool may be empty,
  a \"black box.\" Choreographies may be shown \"in between\" the Pools as they
  bisect the Message Flow between the Pools. All combinations of Pools, Processes,
  and a Choreography are allowed in a Collaboration."
  ((|base_Diagram| :range NIL :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Communication
;;; =========================================================
(def-mm-stereotype |Communication| (:BPMN-P) (|ConversationNode|)
 "A Communication is an atomic element for a Conversation diagram. It represents
  a set of Message Flow grouped together based on a single CorrelationKey.
  A Communication will involve two (2) or more Participants."
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|messageFlowRefs| :range |MessageFlow| :multiplicity (<Set of 0 {OCL OclAny}, id=308638> -1))))


;;; =========================================================
;;; ====================== CompensationBoundaryEvent
;;; =========================================================
(def-mm-stereotype |CompensationBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |CompenstationEventDefinition|)
 "When attached to the boundary of an Activity, this Event is used to \"catch\"
  the Compensation Event, thus the Event marker MUST be unfilled (see figure
  on the right). The Event will be triggered by a thrown compensation targeting
  that Activity. When the Event is triggered, the Compensation Activity that
  is Associated to the Event will be performed."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CompensationEndEvent
;;; =========================================================
(def-mm-stereotype |CompensationEndEvent| (:BPMN-P) (|EndEvent| |CompenstationEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CompensationStartEvent
;;; =========================================================
(def-mm-stereotype |CompensationStartEvent| (:BPMN-P) (|StartEvent| |CompenstationEventDefinition|)
 "The Compensation Start Event is only allowed for triggering an in-line
  Compensation Event Sub-Process. This type of Event is triggered when compensation
  occurs."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CompensationThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |CompensationThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |CompenstationEventDefinition|)
 "In normal flow, this Intermediate Event indicates that compensation is
  necessary. Thus, it is used to \"throw\" the Compensation Event, and the
  Event marker MUST be filled (see figure on the right). If an Activity is
  identified, and it was successfully completed, then that Activity will
  be compensated. The activity must be visible from the Compensation Intermediate
  Event, i.e., one of the following must be true: - The Compensation Intermediate
  Event is contained in normal flow at the same level of Sub-Process. - The
  Compensation Intermediate Event is contained in a Compensation Event Sub-Process
  which is contained in the Sub-Process containing the Activity. If no Activity
  is identified, all successfully completed Activities visible from the Compensation
  Intermediate Event are compensated, in reverse order of their Sequence
  Flow. Visible means one of the following: - The Compensation Intermediate
  Event is contained in normal flow and at the same level of Sub-Process
  as the Activities. - The Compensation Intermediate Event is contained in
  a Compensation Event Sub-Process which is contained in the Sub-Process
  containing the Activities. To be compensated, an Activity MUST have a boundary
  Compensation Event, or contain a Compensation Event Sub-Process."
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CompenstationEventDefinition
;;; =========================================================
(def-mm-stereotype |CompenstationEventDefinition| (:BPMN-P) (|EventDefinition|)
 "Compensation Events are used in the context of triggering or handling compensation."
  ((|activityRef| :range |BPMNActivity| :multiplicity (0 1)
    :documentation
     "For a Start Event: This Event catches the compensation for an Event Sub-Process.
      No further information is required. The Event Sub-Process will provide
      the Id necessary to match the Compensation Event with the Event that threw
      the compensation, or the compensation will have been a broadcast. For an
      End Event: The Activity to be compensated MAY be supplied. If an Activity
      is not supplied, then the compensation is broadcast to all completed Activities
      in the current Sub-Process (if present), or the entire Process Instance
      (if at the global level). For an Intermediate Event within Normal Flow:
      The Activity to be compensated MAY be supplied. If an Activity is not supplied,
      then the compensation is broadcast to all completed Activities in the current
      Sub-Process (if present), or the entire Process Instance (if at the global
      level). This throws the compensation. For an Intermediate Event attached
      to the boundary of an Activity: This Event catches the compensation. No
      further information is required. The Activity the Event is attached to
      will provide the Id necessary to match the Compensation Event with the
      Event that threw the compensation, or the compensation will have been a
      broadcast.")
   (|waitForCompletion| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a throw Compensation Event, this flag determines whether the throw
      Intermediate Event waits for the triggered compensation to complete (the
      default), or just triggers the compensation and immediately continues")))


;;; =========================================================
;;; ====================== ComplexBehaviorDefinition
;;; =========================================================
(def-mm-stereotype |ComplexBehaviorDefinition| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|condition| :range |String| :multiplicity (1 1))
   (|event| :range |ImplicitThrowEvent| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ComplexGateway
;;; =========================================================
(def-mm-stereotype |ComplexGateway| (:BPMN-P) (|Gateway|)
 "The Complex Gateway can be used to model complex synchronization behavior.
  An Expression activationCondition is used to describe the precise behavior.
  For example, this Expression could specify that tokens on three out of
  five incoming Sequence Flow are needed to activate the Gateway. What tokens
  are produced by the Gateway is determined by conditions on the outgoing
  Sequence Flow as in the split behavior of the Inclusive Gateway. If token
  arrive later on the two remaining Sequence Flow, those tokens cause a reset
  of the Gateway and new token can be produced on the outgoing Sequence Flow.
  To determine whether it needs to wait for additional tokens before it can
  reset, the Gateway uses the synchronization semantics of the Inclusive
  Gateway."
  ((|activationCondition| :range |String| :multiplicity (0 1)
    :documentation
     "Determines which combination of incoming tokens will be synchronized for
      activation of the Gateway.")
   (|activationCount| :range |Integer| :multiplicity (1 1)
    :documentation
     "Refers at runtime to the number of tokens that are present on an incoming
      Sequence Flow of the Complex Gateway.")
   (|base_ForkNode| :range UML23:|ForkNode| :multiplicity (1 1))
   (|base_JoinNode| :range UML23:|JoinNode| :multiplicity (1 1))
   (|default| :range |SequenceFlow| :multiplicity (0 1)
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")
   (|waitingForStart| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Represents the internal state of the Complex Gateway. It is either waiting
      for start (=true) or waiting for reset (=false).")))


;;; =========================================================
;;; ====================== ConditionalBoundaryEvent
;;; =========================================================
(def-mm-stereotype |ConditionalBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |ConditionalEventDefinition|)
 "This type of event is triggered when a Condition becomes true. A Condition
  is a type of Expression. If a Conditional Event is attached to the boundary
  of an Activity, it will change the normal flow into an exception flow upon
  being triggered."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_conditional| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== ConditionalCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |ConditionalCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |ConditionalEventDefinition|)
 "This type of event is triggered when a Condition becomes true."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ConditionalEventDefinition
;;; =========================================================
(def-mm-stereotype |ConditionalEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|condition| :range |String| :multiplicity (1 1)
    :documentation
     "The Expression might be underspecified and provided in the form of natural
      language. For executable Processes (isExecutable = true), if the trigger
      is Conditional, then a FormalExpression MUST be entered.")))


;;; =========================================================
;;; ====================== ConditionalStartEvent
;;; =========================================================
(def-mm-stereotype |ConditionalStartEvent| (:BPMN-P) (|StartEvent| |ConditionalEventDefinition|)
 ""
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_conditional| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== ConversationAssociation
;;; =========================================================
(def-mm-stereotype |ConversationAssociation| (:BPMN-P) (|BaseElement|)
 "A ConversationAssociation is used within Collaborations and Choreographies
  to apply a reusable Conversation to Message Flow of those diagrams. A ConversationAssociation
  is used when a diagram references a Conversation to provide Message correlation
  information and/or to logically group Message Flow. There are two (2) usages
  of ConversationAssociation. It is used when: - A Collaboration references
  a reusable Conversation. The Message Flow of the Collaboration are grouped
  by the ConversationAssociation. A tool can use the correlationKey of the
  Conversation (also referenced) or allow the user to group the Message Flow
  of the Collaboration. - A Choreography references a reusable Conversation.
  The Message Flow of the Choreography are grouped by the ConversationAssociation.
  A tool can use the correlationKey of the Conversation (also referenced)
  or allow the user to group the Message Flow of the Choreography."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|messageFlowRefs| :range |MessageFlow| :multiplicity (0 -1)
    :opposite (|MessageFlow| POD-UNNAMED!)
    :documentation
     "The messageFlowRefs are used to identify the Message Flow within the Collaboration
      or Choreography that are to be grouped by the referenced Conversation.
      This grouping can be done automatically through the referenced CorrelationKey
      of the Conversation (matching the CorrelationKey to the Messages of the
      Message Flow) or done through user selection if a CorrelationKey has not
      been defined or referenced.")))


;;; =========================================================
;;; ====================== ConversationDiagram
;;; =========================================================
(def-mm-stereotype |ConversationDiagram| (:BPMN-P) NIL
 "ConversationDiagram is a concrete DiagramDefinition that defines diagrams
  that reference a BPMN Conversation element as a context. The Conversation
  diagram is similar to a Collaboration diagram. However, the Pools of a
  Conversation are not allowed to contain a Process and a Choreography is
  not allowed to be placed in between the Pools of a Conversation diagram.
  A Conversation is the logical relation of Message exchanges. The logical
  relation, in practice, often concerns a business object(s) of interest,
  e.g. \"Order,\" \"Shipment and Delivery,\" or \"Invoice.\""
  ((|base_Diagram| :range NIL :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ConversationLink
;;; =========================================================
(def-mm-stereotype |ConversationLink| (:BPMN-P) NIL
 ""
  ((|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ConversationNode
;;; =========================================================
(def-mm-stereotype |ConversationNode| (:BPMN-P) (|InteractionNode|)
 "ConversationNode is the abstract super class for all elements that can
  appear in a Conversation diagram, which are Communication, Sub-Conversation,
  and Call Conversation. ConversationNodes are linked to and from Participants
  using Communication Links."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))
   (|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|correlationKeys| :range |CorrelationKey| :multiplicity (<Set of 0 {OCL OclAny}, id=308757> -1) :is-composite-p T
    :documentation
     "This is a list of the Conversation Node s Correlation Keys, which are used
      to group Message Flows for the Conversation Node.")))


;;; =========================================================
;;; ====================== Correlation
;;; =========================================================
(def-mm-stereotype |Correlation| (:BPMN-P) NIL
 "The concept of Correlation facilitates the association of a Message to
  a Send Task or Receive Task involved in a Conversation, a mechanism BPMN
  refers to as instance routing. It is a particular useful concept where
  there is no infrastructure support for instance routing. Note that this
  association can be viewed at multiple levels, namely the Conversation,
  Choreography, and Process level. However, the actual correlation happens
  during runtime (e.g. at the Process level). Correlations describe a set
  of predicates on a Message (generally on the application payload) that
  need to be satisfied in order for that Message to be associated to a distinct
  Send Task or Receive Task. By the same token, each Send Task and each Receive
  Task participates in one or many Conversations. Furthermore, it identifies
  the Message it sends or receives and thereby establishes the relationship
  to one (or many) CorrelationKeys."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CorrelationKey
;;; =========================================================
(def-mm-stereotype |CorrelationKey| (:BPMN-P) (|BaseElement|)
 "A CorrelationKey represents a composite key out of one (1) or many CorrelationProperties
  which essentially specify extraction Expressions atop Messages. As a result,
  each CorrelationProperty acts as a partial key for the correlation. For
  each Message that is exchanged as part of a particular Conversation, the
  CorrelationProperties need to provide a CorrelationPropertyRetrievalExpression
  which references a FormalExpression to the Message payload. That is, for
  each Message (that is used in a Conversation) there is an Expression which
  extracts portions of the respective Message s payload."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|correlationPropertyRef| :range |CorrelationProperty| :multiplicity (0 -1)
    :documentation
     "The CorrelationProperties, representing the partial keys of this CorrelationKey.")))


;;; =========================================================
;;; ====================== CorrelationProperty
;;; =========================================================
(def-mm-stereotype |CorrelationProperty| (:BPMN-P) (|RootElement|)
 "Key-based correlation is a simple and efficient form of correlation, where
  one or more keys are used to identify a Conversation. Any incoming Message
  can be matched against the CorrelationKey by extracting the CorrelationProperties
  from the Message according to the corresponding CorrelationPropertyRetrievalExpression
  and comparing the resulting composite key with the CorrelationKey instance
  for this Conversation. The idea is to use a joint Conversation token which
  is used (passed to and received from) and outgoing and incoming Message.
  Messages are associated to a particular Conversation if the composite key
  extracted from their payload matches the CorrelationKey initialized for
  this Conversation."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|correlationPropertyRetievalExpression| :range |CorrelationPropertyRetrievalExpression| :multiplicity (1 -1) :is-composite-p T
    :documentation
     "The CorrelationPropertyRetrievalExpressions for this CorrelationProperty,
      representing the associations of FormalExpressions (extraction paths) to
      specific Messages occurring in this Conversation.")
   (|type| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the type of the CorrelationProperty.")))


;;; =========================================================
;;; ====================== CorrelationPropertyBinding
;;; =========================================================
(def-mm-stereotype |CorrelationPropertyBinding| (:BPMN-P) NIL
 "CorrelationPropertyBindings represent the partial keys of a CorrelationSubscription
  where each relates to a specific CorrelationProperty in the associated
  CorrelationKey."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|correlationPropertyRef| :range |CorrelationProperty| :multiplicity (1 1)
    :documentation
     "The specific CorrelationProperty, this CorrelationPropertyBinding refers
      to.")
   (|dataPathBody| :range UML23:|Element| :multiplicity (1 1)
    :documentation
     "The Data path defines the extraction rule from the Process context. The
      body of the Expression. Note that this attribute is not relevant when the
      XML Schema is used for interchange. Instead, the FormalExpression complex
      type supports mixed content. The body of the Expression would be specified
      as element content.")
   (|dataPathLanguage| :range |String| :multiplicity (1 1)
    :documentation
     "The Data path defines the extraction rule from the Process context. The
      language MUST be specified in a URI format.")))


;;; =========================================================
;;; ====================== CorrelationPropertyRetrievalExpression
;;; =========================================================
(def-mm-stereotype |CorrelationPropertyRetrievalExpression| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|mesagePathLanguage| :range |String| :multiplicity (1 1)
    :documentation
     "The Message path defines how to extract a CorrelationProperty from the
      Message payload. The language MUST be specified in a URI format.")
   (|messagePathBody| :range UML23:|Element| :multiplicity (1 1)
    :documentation
     "The Message path defines how to extract a CorrelationProperty from the
      Message payload. The body of the Expression. Note that this attribute is
      not relevant when the XML Schema is used for interchange. Instead, the
      FormalExpression complex type supports mixed content. The body of the Expression
      would be specified as element content.")
   (|messageRef| :range |Message| :multiplicity (1 1)
    :documentation
     "The specific Message the FormalExpression extracts the CorrelationProperty
      from.")))


;;; =========================================================
;;; ====================== CorrelationSubscription
;;; =========================================================
(def-mm-stereotype |CorrelationSubscription| (:BPMN-P) NIL
 "a Process MAY provide a CorrelationSubscription which acts as the Process-specific
  counterpart to a specific CorrelationKey. In this way, a Conversation MAY
  additionally refer to explicitly updateable Process context data to determine
  whether or not a Message needs to be received. At runtime, the CorrelationKey
  instance holds a composite key that is dynamically calculated from the
  Process context and automatically updated whenever the underlying Data
  Objects or Properties change."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|correlationKeyRef| :range |CorrelationKey| :multiplicity (1 1)
    :documentation
     "The CorrelationKey this CorrelationSubscription refers to.")
   (|correlationPropertyBinding| :range |CorrelationPropertyBinding| :multiplicity (<Set of 0 {OCL OclAny}, id=308823> -1) :is-composite-p T
    :documentation
     "The bindings to specific CorrelationProperties and FormalExpressions (extraction
      rules atop the Process context).")))


;;; =========================================================
;;; ====================== DataAssociation
;;; =========================================================
(def-mm-stereotype |DataAssociation| (:BPMN-P) (|BaseElement|)
 "The DataAssociation class is a BaseElement contained by an Activity or
  Event, used to model how data is pushed into or pulled from item-aware
  elements. DataAssociation elements have one or more sources and a target;
  the source of the association is copied into the target. The ItemDefinition
  from the sourceRef and targetRef must have the same ItemDefinition or the
  DataAssociation MUST have a transformation Expression that transforms the
  source ItemDefinition into the target ItemDefinition."
  ((|assignment| :range |Assignment| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "Specifies one or more data elements Assignments. By using an Assignment,
      single data structure elements can be assigned from the source structure
      to the target structure.")
   (|base_ObjectFlow| :range UML23:|ObjectFlow| :multiplicity (1 1))
   (|transformation| :range |String| :multiplicity (0 1) :is-composite-p T
    :documentation
     "Specifies an optional transformation Expression. The actual scope of accessible
      data for that Expression is defined by the source and target of the specific
      Data Association types.")))


;;; =========================================================
;;; ====================== DataInput
;;; =========================================================
(def-mm-stereotype |DataInput| (:BPMN-P) (|ItemAwareElement|)
 "A DataInput is a declaration that a particular kind of data will be used
  as input of the InputOutputSpecification. There may be multiple data inputs
  associated with an InputOutputSpecification. The DataInput is an item-aware
  element. DataInput elements may appear in a Process diagram to show the
  inputs to the Process as whole, which are passed along as the inputs of
  Activities by DataAssociations."
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))
   (|inputSetRefs| :range |InputSet| :multiplicity (1 -1) :is-derived-p T
    :opposite (|InputSet| |dataInputRefs|)
    :documentation
     "A DataInput is used in one (1) or more InputSets. This attribute is derived
      from the InputSets")
   (|inputSetWithWhileExecuting| :range |InputSet| :multiplicity (0 -1)
    :opposite (|InputSet| |whileExecutingInputRefs|)
    :documentation
     "Each InputSet that uses this DataInput can determine if the Activity can
      evaluate this DataInput while executing. This attribute lists those InputSets.")
   (|inputSetwithOptional| :range |InputSet| :multiplicity (0 -1)
    :opposite (|InputSet| |optionalInputRefs|)
    :documentation
     "Each InputSet that uses this DataInput can determine if the Activity can
      start executing with this DataInput state in unavailable . This attribute
      lists those InputSets.")
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Defines if the DataInput represents a collection of elements. It is needed
      when no itemDefinition is referenced. If an itemDefinition is referenced,
      then this attribute MUST have the same value as the isCollection attribute
      of the referenced itemDefinition. The default value for this attribute
      is false.")))


(def-mm-constraint "DataInput.Association" |DataInput| 
   "" 
   :operation-body
   "DataInput must not have incoming DataAssociations")

;;; =========================================================
;;; ====================== DataInputAssociation
;;; =========================================================
(def-mm-stereotype |DataInputAssociation| (:BPMN-P) (|DataAssociation|)
 "The DataInputAssociation can be used to associate an ItemAwareElement element
  with a DataInput contained in an Activity. The source of such a DataAssociation
  can be every ItemAwareElement accessible in the current scope, e.g., a
  Data Object, a Property or an Expression."
  ((|base_ObjectFlow| :range UML23:|ObjectFlow| :multiplicity (1 1))))


(def-mm-constraint "dataInputAssociation.source" |DataInputAssociation| 
   "" 
   :operation-body
   "The source of DataAssociation can be every item-aware element visible to the current scope, e.g. a Data Object, a Property or an Expression.")

(def-mm-constraint "dataInputAssociation.target" |DataInputAssociation| 
   "" 
   :operation-body
   "The target for DataInputAssociation shall be DataInput.")

;;; =========================================================
;;; ====================== DataObject
;;; =========================================================
(def-mm-stereotype |DataObject| (:BPMN-P) (|FlowElement| |ItemAwareElement|)
 "The DataObject class is an item-aware element. Data Object elements must
  be contained within Process or Sub-Process elements. Data Object elements
  are visually displayed on in a Process diagram."
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))
   (|isCollection| :range |isCollection| :multiplicity (1 1) :default :false
    :documentation
     "Defines if the Data Object represents a collection of elements. It is needed
      when no itemDefinition is referenced. If an itemDefinition is referenced,
      then this attribute MUST have the same value as the isCollection attribute
      of the referenced itemDefinition. The default value for this attribute
      is false.")))


;;; =========================================================
;;; ====================== DataOutput
;;; =========================================================
(def-mm-stereotype |DataOutput| (:BPMN-P) (|ItemAwareElement|)
 "A DataInput is a declaration that a particular kind of data will be used
  as input of the InputOutputSpecification. There may be multiple data inputs
  associated with an InputOutputSpecification. The DataInput is an item-aware
  element. DataInput elements may appear in a Process diagram to show the
  inputs to the Process as whole, which are passed along as the inputs of
  Activities by DataAssociations."
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Defines if the DataOutput represents a collection of elements. It is needed
      when no itemDefinition is referenced. If an itemDefinition is referenced,
      then this attribute MUST have the same value as the isCollection attribute
      of the referenced itemDefinition. The default value for this attribute
      is false.")
   (|outputSetRefs| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |dataOutputRefs|))
   (|outputSetWithOptional| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |optionalOutput|))
   (|outputSetWithWhileExecuting| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |whileExecutingOutput|))))


(def-mm-constraint "DataInput.Association" |DataOutput| 
   "" 
   :operation-body
   "DataInput must not have incoming DataAssociations")

;;; =========================================================
;;; ====================== DataOutputAssociation
;;; =========================================================
(def-mm-stereotype |DataOutputAssociation| (:BPMN-P) (|DataAssociation|)
 "The DataOutputAssociation can be used to associate a DataOutput contained
  within an ACTIVITY with any ItemAwareElement accessible in the scope the
  association will be executed in. The target of such a DataAssociation can
  be every ItemAwareElement accessible in the current scope, e.g, a Data
  Object, a Property or an Expression."
  ((|base_ObjectFlow| :range UML23:|ObjectFlow| :multiplicity (1 1))))


(def-mm-constraint "dataOutputAssociation.source" |DataOutputAssociation| 
   "" 
   :operation-body
   "The source of DataAssociation shall be DataOutput")

(def-mm-constraint "dataOutputAssociation.target" |DataOutputAssociation| 
   "" 
   :operation-body
   "The target of DataAssociation can be every item-aware element visible to the current scope, e.g. a Data Object, a Property or an Expression.")

;;; =========================================================
;;; ====================== DataStore
;;; =========================================================
(def-mm-stereotype |DataStore| (:BPMN-P) (|ItemAwareElement| |RootElement|)
 "A DataStore provides a mechanism for Activities to retrieve or update stored
  information that will persist beyond the scope of the Process. The same
  DataStore can be visualized, through a Data Store Reference, in one (1)
  or more places in the Process. The Data Store Reference is an ItemAwareElement
  and can thus be used as the source or target for a Data Association. When
  data flows into or out of a Data Store Reference, it is effectively flowing
  into or out of the DataStore that is being referenced."
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))
   (|capacity| :range |Integer| :multiplicity (0 1)
    :documentation
     "Defines the capacity of the Data Store. This is not needed if the isUnlimited
      attribute is set to true.")
   (|isUnlimited| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isUnlimited is set to true, then the capacity of a Data Store is set
      as unlimited and will override any value of the capacity attribute.")))


;;; =========================================================
;;; ====================== Definitions
;;; =========================================================
(def-mm-stereotype |Definitions| (:BPMN-P) (|BaseElement|)
 ""
  ((|base_Package| :range UML23:|Package| :multiplicity (1 1))
   (|exporter| :range |String| :multiplicity (1 1))
   (|exporterVersion| :range |String| :multiplicity (1 1))
   (|expressionLanguage| :range |String| :multiplicity (1 1))
   (|imports| :range |BPMNImport| :multiplicity (<Set of 0 {OCL OclAny}, id=308903> -1) :is-composite-p T
    :opposite (|BPMNImport| |definition|))
   (|relationships| :range |Relationship| :multiplicity (<Set of 0 {OCL OclAny}, id=308906> -1) :is-composite-p T
    :opposite (|Relationship| |definition|))
   (|targetNamespace| :range |String| :multiplicity (1 1))
   (|typeLanguage| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== EndEvent
;;; =========================================================
(def-mm-stereotype |EndEvent| (:BPMN-P) (|ThrowEvent|)
 "As the name implies, the End Event indicates where a Process will end.
  In terms of Sequence Flow, the End Event ends the flow of the Process,
  and thus, will not have any outgoing Sequence Flow no Sequence Flow can
  connect from an End Event."
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== EndPoint
;;; =========================================================
(def-mm-stereotype |EndPoint| (:BPMN-P) (|RootElement|)
 "The actual definition of the service address is out of scope of BPMN 2.0.
  The EndPoint element is an extension point and extends from RootElement.
  The EndPoint element may be extended with endpoint reference definitions
  introduced in other specifications (e.g. WS-Addressing). EndPoints can
  be specified for Participants."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Error
;;; =========================================================
(def-mm-stereotype |Error| (:BPMN-P) (|RootElement|)
 "An Error represents the content of an Error Event or the Fault of a failed
  Operation. An Error is generated when there is a critical problem in the
  processing of an Activity or when the execution of an Operation failed."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|errorCode| :range |String| :multiplicity (1 1)
    :documentation
     "For an End Event: If the Result is an Error, then the errorCode MUST be
      supplied (if the processType attribute of the Process is set to executable)
      This throws the error. For an Intermediate Event within Normal Flow: If
      the Trigger is an Error, then the errorCode MUST be entered (if the processType
      attribute of the Process is set to executable). This throws the Error.
      For an Intermediate Event attached to the boundary of an Activity: If the
      Trigger is an Error, then the errorCode MAY be entered. This Event catches
      the error. If there is no errorCode, then any error SHALL trigger the Event.
      If there is an errorCode, then only an error that matches the errorCode
      SHALL trigger the Event.")
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ErrorBoundaryEvent
;;; =========================================================
(def-mm-stereotype |ErrorBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |ErrorEventDefinition|)
 "An Intermediate Error Catch Event can only be attached to the boundary
  of an activity, i.e. it may not be used in Normal Flow. If used in this
  context, it reacts to (catches) a named error, or to any error if a name
  is not specified."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ErrorEndEvent
;;; =========================================================
(def-mm-stereotype |ErrorEndEvent| (:BPMN-P) (|EndEvent| |ErrorEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ErrorEventDefinition
;;; =========================================================
(def-mm-stereotype |ErrorEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|errorRef| :range |Error| :multiplicity (0 1)
    :documentation
     "If the Trigger is an Error, then an Error payload MAY be provided.")))


;;; =========================================================
;;; ====================== ErrorStartEvent
;;; =========================================================
(def-mm-stereotype |ErrorStartEvent| (:BPMN-P) (|StartEvent| |ErrorEventDefinition|)
 "The Error Start Event is only allowed for triggering an in-line Event Sub-Process."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1)
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== Escalation
;;; =========================================================
(def-mm-stereotype |Escalation| (:BPMN-P) (|RootElement|)
 "An Escalation identifies a business situation that a Process might need
  to react to."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|escalationCode| :range |String| :multiplicity (1 1)
    :documentation
     "For an End Event: If the Result is an Escalation, then the escalationCode
      MUST be supplied (if the processType attribute of the Process is set to
      executable). This throws the escalation. For an Intermediate Event within
      Normal Flow: If the Trigger is an Escalation, then the escalationCode MUST
      be entered (if the processType attribute of the Process is set to executable).
      This throws the escalation. For an Intermediate Event attached to the boundary
      of an Activity: If the Trigger is an Escalation, then the escalationCode
      MAY be entered. This Event catches the escalation. If there is no escalationCode,
      then any escalation SHALL trigger the Event. If there is an escalationCode,
      then only an escalation that matches the escalationCode SHALL trigger the
      Event.")
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== EscalationBoundaryEvent
;;; =========================================================
(def-mm-stereotype |EscalationBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |EscalationEventDefinition|)
 "This type of Event is used for handling a named Escalation. If attached
  to the boundary of an activity, the Intermediate Event catches an Escalation.
  In contrast to an Error, an Escalation by default is assumed to not abort
  the activity to which the boundary event is attached. However, a modeler
  may decide to override this setting by using the notation described in
  the following."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_escalation| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== EscalationEndEvent
;;; =========================================================
(def-mm-stereotype |EscalationEndEvent| (:BPMN-P) (|EndEvent| |EscalationEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== EscalationEventDefinition
;;; =========================================================
(def-mm-stereotype |EscalationEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|escalationCode| :range |String| :multiplicity (1 1)
    :documentation
     "For an End Event: If the Result is an Escalation, then the escalationCode
      MUST be supplied (if the processType attribute of the Process is set to
      executable). This throws the escalation. For an Intermediate Event within
      Normal Flow: If the Trigger is an Escalation, then the escalationCode MUST
      be entered (if the processType attribute of the Process is set to executable).
      This throws the escalation. For an Intermediate Event attached to the boundary
      of an Activity: If the Trigger is an Escalation, then the escalationCode
      MAY be entered. This Event catches the escalation. If there is no escalationCode,
      then any escalation SHALL trigger the Event. If there is an escalationCode,
      then only an escalation that matches the escalationCode SHALL trigger the
      Event.L trigger the Event.")
   (|escalationRef| :range |Escalation| :multiplicity (0 1))
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== EscalationStartEvent
;;; =========================================================
(def-mm-stereotype |EscalationStartEvent| (:BPMN-P) (|StartEvent| |EscalationEventDefinition|)
 "Escalation Event Sub-Processes implement measures to expedite the completion
  of a business activity, should it not satisfy a constraint specified on
  its execution (such as a time-based deadline). The Escalation Start Event
  is only allowed for triggering an in-line Event Sub-Process."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_escalation| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== EscalationThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |EscalationThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |EscalationEventDefinition|)
 "In Normal Flow, the Escalation Intermediate Event raises an Escalation."
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Event
;;; =========================================================
(def-mm-stereotype |Event| (:BPMN-P) (|FlowNode| |MessageFlowNode| |InteractionNode|)
 "An Event is something that happens during the course of a Process. These
  Events affect the flow of the Process and usually have a cause or an impact
  and in general require or allow for a reaction. The term event is general
  enough to cover many things in a Process. The start of an Activity, the
  end of an Activity, the change of state of a document, a Message that arrives,
  etc., all could be considered Events. Events allow for the description
  of event-driven Processes. In these Processes, There are three main types
  of Events: - Start Events, which indicate where a Process will start. -
  End Events, which indicate where a path of a Process will end. - Intermediate
  Events, which indicate where something happens somewhere between the start
  and end of a Process. Within these three types, Events come in two flavors:
  - Events that catch a Trigger. All Start Events and some Intermediate Events
  are catching Events. - Events that throw a Result. All End Events and some
  Intermediate Events are throwing Events that may eventually be caught by
  another Event. Typically the Trigger carries information out of the scope
  where the throw Event occurred into the scope of the catching Events. The
  throwing of a trigger may be either implicit as defined by this standard
  or an extension to it or explicit by a throw Event."
  ((|base_Action| :range UML23:|Action| :multiplicity (1 1))
   (|base_ControlNode| :range UML23:|ControlNode| :multiplicity (1 1))
   (|base_Event| :range UML23:|Event| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== EventBasedGateway
;;; =========================================================
(def-mm-stereotype |EventBasedGateway| (:BPMN-P) (|Gateway|)
 "The Event-Based Gateway represents a branching point in the Process where
  the alternative paths that follow the Gateway are based on Events that
  occur, rather than the evaluation of Expressions using Process data (as
  with an Exclusive or Inclusive Gateway). A specific Event, usually the
  receipt of a Message, determines the path that will be taken. Basically,
  the decision is made by another Participant, based on data that is not
  visible to Process, thus, requiring the use of the Event-Based Gateway.
  For example, if a company is waiting for a response from a customer they
  will perform one set of Activities if the customer responds Yes and another
  set of Activities if the customer responds No. The customer s response
  determines which path is taken. The identity of the Message determines
  which path is taken. That is, the Yes Message and the No Message are different
  Messages i.e., they are not the same Message with different values within
  a property of the Message. The receipt of the Message can be modeled with
  an Intermediate Event with a Message Trigger or a Receive Task. In addition
  to Messages, other Triggers for Intermediate Events can be used, such as
  Timers."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|base_ForkNode| :range UML23:|ForkNode| :multiplicity (1 1))
   (|eventGatewayType| :range |EventGatewayType| :multiplicity (1 1) :default :exclusive
    :documentation
     "The eventGatewayType determines the behavior of the Gateway when used to
      instantiate a Process (as described above). The attribute can only be set
      to Parallel when the instantiate attribute is set to true.")
   (|instantiate| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "When true, receipt of one of the events will instantiate the process instance.")))


;;; =========================================================
;;; ====================== EventDefinition
;;; =========================================================
(def-mm-stereotype |EventDefinition| (:BPMN-P) (|RootElement|)
 "Event Definitions refers to the Triggers of Catch Events (Start and receive
  Intermediate Events) and the Results of Throw Events (End Events and send
  Intermediate Events). The types of Event Definitions are: CancelEventDefinition,
  CompensationEventDefinition, ConditionalEventDefinition, ErrorEventDefinition,
  EscalationEventDefinition, MessageEventDefinition, LinkEventDefinition,
  SignalEventDefinition, TerminateEventDefinition, and TimerEventDefinition.
  A None Event is ;determined by an Event that does not specify an Event
  Definition. A Multiple Event is determined by an Event that specifies more
  than one Event Definition. The different types of Events (Start, End, and
  Intermediate) utilize a subset of the available types of Event Definitions."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_ActivityPartition| :range UML23:|ActivityPartition| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|base_Comment| :range UML23:|Comment| :multiplicity (1 1))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))
   (|base_Property| :range UML23:|Property| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ExclusiveGateway
;;; =========================================================
(def-mm-stereotype |ExclusiveGateway| (:BPMN-P) (|Gateway|)
 "A diverging Exclusive Gateway (Decision) is used to create alternative
  paths within a Process flow. This is basically the diversion point in the
  road for a Process. For a given instance of the Process, only one of the
  paths can be taken. A Decision can be thought of as a question that is
  asked at a particular point in the Process. The question has a defined
  set of alternative answers. Each question is associated with a condition
  expression that is associated with a Gateway s outgoing Sequence Flow."
  ((|base_DecisionNode| :range UML23:|DecisionNode| :multiplicity (1 1))
   (|default| :range |SequenceFlow| :multiplicity (0 1)
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")))


;;; =========================================================
;;; ====================== FlowElement
;;; =========================================================
(def-mm-stereotype |FlowElement| (:BPMN-P) (|BaseElement|)
 "FlowElement is the abstract super class for all elements that can appear
  in a Process flow, which are FlowNodes (which consist of Activities, Choreography
  Activities, Gateways, and Events), Data Objects, Data Associations, and
  Sequence Flow."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== FlowNode
;;; =========================================================
(def-mm-stereotype |FlowNode| (:BPMN-P) (|FlowElement|)
 "The FlowNode element is used to provide a single element as the source
  and target Sequence Flow associations instead of the individual associations
  of the elements that can connect to Sequence Flow. Only the Gateway, Activity,
  Choreography Activity, and Event elements can connect to Sequence Flow
  and thus, these elements are the only ones that are sub-classes of FlowNode."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== FormalExpression
;;; =========================================================
(def-mm-stereotype |FormalExpression| (:BPMN-P) (|BPMNExpression|)
 "The FormalExpression class is used to specify an executable expression
  using a specified expression language. A natural-language description of
  the expression can also be specified, in addition to the formal specification."
  ((|base_OpaqueExpression| :range UML23:|OpaqueExpression| :multiplicity (1 1))
   (|body| :range UML23:|Element| :multiplicity (1 1)
    :documentation
     "The body of the expression.")
   (|evaluatesToTypeRef| :range |ItemDefinition| :multiplicity (1 1)
    :documentation
     "The type of object that this Expression returns when evaluated. For example,
      conditional Expressions evaluate to a boolean.")
   (|language| :range |String| :multiplicity (0 1)
    :documentation
     "Overrides the expression language specified in the Definitions.")))


;;; =========================================================
;;; ====================== Gateway
;;; =========================================================
(def-mm-stereotype |Gateway| (:BPMN-P) (|FlowNode|)
 "Gateways are used to control how the Process flows (how Tokens flow) through
  Sequence Flow as they converge and diverge within a Process. If the flow
  does not need to be controlled, then a Gateway is not needed. The term
  gateway implies that there is a gating mechanism that either allows or
  disallows passage through the Gateway--that is, as tokens arrive at a Gateway,
  they can be merged together on input and/or split apart on output as the
  Gateway mechanisms are invoked. Gateways, like Activities, are capable
  of consuming or generating additional control tokens, effectively controlling
  the execution semantics of a given Process. The main difference is that
  Gateways do not represent work being done and they are considered to have
  zero effect on the operational measures of the Process being executed (cost,
  time, etc.). The Gateway controls the flow of both diverging and converging
  Sequence Flow. That is, a single Gateway could have multiple input and
  multiple output flows. Modelers and modeling tools may want to enforce
  a best practice of a Gateway only performing one of these functions. Thus,
  it would take two sequential Gateways to first converge and then to diverge
  the Sequence Flow."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|gatewayDirection| :range |GatewayDirection| :multiplicity (1 1) :default :unspecified
    :documentation
     "An attribute that adds constraints on how the gateway may be used. Unspecified:
      There are no constraints. The Gateway may have any number of incoming and
      outgoing Sequence Flow. Converging: This Gateway may have multiple incoming
      Sequence Flow but must have no more than one outgoing SequenceFlow Diverging:
      This Gateway may have multiple outgoing Sequence Flow but must have no
      more than one incoming Sequence Flow Mixed: This Gateway contains multiple
      outgoing and multiple incoming Sequence Flow")))


;;; =========================================================
;;; ====================== GlobalBusinessRuleTask
;;; =========================================================
(def-mm-stereotype |GlobalBusinessRuleTask| (:BPMN-P) (|GlobalTask|)
 "A Business Rule Task provides a mechanism for the Process to provide input
  to a Business Rules Engine and to get the output of calculations that the
  Business Rules Engine might provide. The InputOutputSpecification of the
  Task will allow the Process to send data to and receive data from the Business
  Rules Engine."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|implementation| :range |BusinessRuleImplementation| :multiplicity (1 1)
    :documentation
     "This attribute specifies the technology that will be used to implement
      the Business Rule Task.")))


;;; =========================================================
;;; ====================== GlobalChoreographyTask
;;; =========================================================
(def-mm-stereotype |GlobalChoreographyTask| (:BPMN-P) (|Choreography|)
 "A GlobalChoreographyTask is a reusable, atomic Choreography Task definition
  that can be called from within any Choreography by a Call Choreography
  Activity."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|initiatingParticipantRef| :range |Participant| :multiplicity (1 1)
    :opposite (|Participant| |globalChoreographyTask|))))


;;; =========================================================
;;; ====================== GlobalManualTask
;;; =========================================================
(def-mm-stereotype |GlobalManualTask| (:BPMN-P) (|GlobalTask|)
 "A Manual Task is a Task that is expected to be performed without the aid
  of any business process execution engine or any application. A Manual Task
  is not managed by any business process engine. It can be considered as
  an unmanaged Task, unmanaged in the sense of that the business process
  engine doesn t track the start and completion of such a Task. An example
  of this could be a paper based instruction for a telephone technician to
  install a telephone at a customer location."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== GlobalScriptTask
;;; =========================================================
(def-mm-stereotype |GlobalScriptTask| (:BPMN-P) (|GlobalTask|)
 "A Script Task is executed by a business process engine. The modeler or
  implementer defines a script in a language that the engine can interpret.
  When the Task is ready to start, the engine will execute the script. When
  the script is completed, the Task will also be completed."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|script| :range |String| :multiplicity (1 1)
    :documentation
     "The modeler MAY include a script that can be run when the Task is performed.
      If a script is not included, then the Task will act equivalent to a TaskType
      of None.")
   (|scriptFormat| :range |String| :multiplicity (1 1)
    :documentation
     "Defines the script language. The script language MUST be provided if a
      script is provided.")))


(def-mm-constraint "Global.ScriptTask.scriptFormat" |GlobalScriptTask| 
   "" 
   :operation-body
   "scriptFormat must be provided if a script is provided.")

;;; =========================================================
;;; ====================== GlobalTask
;;; =========================================================
(def-mm-stereotype |GlobalTask| (:BPMN-P) (|CallableElement|)
 "A Global Task is a reusable, atomic Task definition that can be called
  from within any Process by a Call Activity. There are different types of
  Tasks identified within BPMN to separate the types of inherent behavior
  that Tasks might represent. This is true for both Global Tasks and standard
  Tasks, where the list of Task types is the same for both."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|performers| :range |Performer| :multiplicity (0 1) :is-composite-p T
    :documentation
     "Defines the resource that will perform or will be responsible for the GlobalTask.
      In the case where the Call Activity that references this GlobalTask defines
      its own resources, they will override the ones defined here.")
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== GlobalUserTask
;;; =========================================================
(def-mm-stereotype |GlobalUserTask| (:BPMN-P) (|GlobalTask|)
 "A User Task is a typical workflow Task where a human performer performs
  the Task with the assistance of a software application and is scheduled
  through a task list manager of some sort."
  ((|base_Activity| :range UML23:|Activity| :multiplicity (1 1))
   (|implementation| :range |UserTaskImplementation| :multiplicity (1 1)
    :documentation
     "This attribute specifies the technology that will be used to implement
      the User Task.")
   (|renderings| :range |Rendering| :multiplicity (<Set of 0 {OCL OclAny}, id=309165> -1))))


;;; =========================================================
;;; ====================== HumanPerformer
;;; =========================================================
(def-mm-stereotype |HumanPerformer| (:BPMN-P) (|Performer|)
 "People can be assigned to Activities in various roles (called generic human
  roles in WS-HumanTask). BPMN 1.2 traditionally only has the Performer role.
  In addition to supporting the Performer role, BPMN 2.0 defines a specific
  HumanPerformer element allowing specifying more specific human roles as
  specialization of HumanPerformer, such as PotentialOwner."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ImplicitThrowEvent
;;; =========================================================
(def-mm-stereotype |ImplicitThrowEvent| (:BPMN-P) (|ThrowEvent|)
 ""
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== InclusiveGateway
;;; =========================================================
(def-mm-stereotype |InclusiveGateway| (:BPMN-P) (|Gateway|)
 "A diverging Inclusive Gateway (Inclusive Decision) can be used to create
  alternative but also parallel paths within a Process flow. Unlike the Exclusive
  Gateway, all condition expressions are evaluated. The true evaluation of
  one condition expression does not exclude the evaluation of other condition
  expressions. All Sequence Flow with a true evaluation will be traversed
  by a Token. Since each path is considered to be independent, all combinations
  of the paths may be taken, from zero to all. However, it should be designed
  so that at least one path is taken."
  ((|base_ForkNode| :range UML23:|ForkNode| :multiplicity (1 1))
   (|base_JoinNode| :range UML23:|JoinNode| :multiplicity (1 1))
   (|default| :range |SequenceFlow| :multiplicity (0 1)
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")))


;;; =========================================================
;;; ====================== InputOutputSpecification
;;; =========================================================
(def-mm-stereotype |InputOutputSpecification| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|dataInputs| :range |DataInput| :multiplicity (0 -1) :is-composite-p T)
   (|dataOutputs| :range |DataOutput| :multiplicity (0 -1) :is-composite-p T)
   (|inputSets| :range |InputSet| :multiplicity (1 -1) :is-composite-p T)
   (|outputSets| :range |OutputSet| :multiplicity (1 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== InputSet
;;; =========================================================
(def-mm-stereotype |InputSet| (:BPMN-P) NIL
 "An InputSet is a collection of DataInput elements that together define
  a valid set of data inputs for a InputOutputSpecification. An InputOutputSpecification
  must have at least one InputSet element. An InputSet may reference zero
  or more DataInput elements. A single DataInput may be associated with multiple
  InputSet elements, but it must always be referenced by at least one InputSet.
  An empty InputSet, one that references no DataInput elements, signifies
  that the Activity requires no data to start executing (this implies that
  either there are no data inputs or they are referenced by another input
  set)."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|dataInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetRefs|)
    :documentation
     "The DataInput elements that collectively make up this data requirement.")
   (|optionalInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetwithOptional|)
    :documentation
     "The DataInput elements that are a part of the InputSet that can be in the
      state of unavailable when the Activity starts executing. This association
      MUST NOT reference a DataInput that is not listed in the dataInputRefs.")
   (|outputSetRefs| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |inputSetRefs|))
   (|whileExecutingInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetWithWhileExecuting|)
    :documentation
     "The DataInput elements that are a part of the InputSet that can be evaluated
      while the Activity is executing. This association MUST NOT reference a
      DataInput that is not listed in the dataInputRefs.")))


;;; =========================================================
;;; ====================== InteractionNode
;;; =========================================================
(def-mm-stereotype |InteractionNode| (:BPMN-P) NIL
 ""
  ((|base_Action| :range UML23:|Action| :multiplicity (1 1))
   (|base_ControlNode| :range UML23:|ControlNode| :multiplicity (1 1))
   (|base_Event| :range UML23:|Event| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== IntermediateCatchEvent
;;; =========================================================
(def-mm-stereotype |IntermediateCatchEvent| (:BPMN-P) (|CatchEvent|)
 ""
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== IntermediateThrowEvent
;;; =========================================================
(def-mm-stereotype |IntermediateThrowEvent| (:BPMN-P) (|ThrowEvent|)
 ""
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ItemAwareElement
;;; =========================================================
(def-mm-stereotype |ItemAwareElement| (:BPMN-P) (|BaseElement|)
 ""
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ItemDefinition
;;; =========================================================
(def-mm-stereotype |ItemDefinition| (:BPMN-P) (|RootElement|)
 "BPMN elements, such as DataObjects and Messages, represent items that are
  manipulated, transferred, transformed or stored during Process flows. These
  items can be either physical items, such as the mechanical part of a vehicle,
  or information items such the catalog of the mechanical parts of a vehicle.
  An important characteristics of items in Process is their structure. BPMN
  does not require a particular format for this data structure, but it does
  designate XML Schema as its default. The structure attribute references
  the actual data structure. The default format of the data structure for
  all elements can be specified in the Definitions element using the typeLanguage
  attribute. For example, a typeLanguage value of http://www.w3.org/2001/XMLSchema
  indicates that the data structures using by elements within that Definitions
  are in the form of XML Schema types. If unspecified, the default is XML
  schema. An Import is used to further identify the location of the data
  structure (if applicable). For example, in the case of data structures
  contributed by an XML schema, an Import would be used to specify the file
  location of that schema. Structure definitions are always defined as separate
  entities, so they cannot be inlined in one of their usages. You will see
  that in every mention of structure definition there is a reference to the
  element. This is why this class inherits from RootElement. An ItemDefinition
  element can specify an import reference where the proper definition of
  the structure is defined. In cases where the data structure represents
  a collection, the multiplicity can be projected into the attribute isCollection.
  If this attribute is set to true , but the actual type is not a collection
  type, the model is considered as invalid. BPMN compliant tools might support
  an automatic check for these inconsistencies and report this as an error.
  The default value for this element is false . The itemKind attribute specifies
  the nature of an item which can be a physical or an information item."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|import| :range |BPMNImport| :multiplicity (0 1)
    :documentation
     "Identifies the location of the data structure and its format. If the importType
      attribute is left unspecified, the typeLanguage specified in the Definitions
      that contains this ItemDefinition is assumed.")
   (|isCollection| :range NIL :multiplicity (1 1) :default :false
    :documentation
     "Setting this flag to true indicates that the actual data type is a collection.")
   (|itemKind| :range |ItemKind| :multiplicity (1 1) :default :information
    :documentation
     "This defines the nature of the Item. Possible values are Physical or Information.
      The default value is Information.")
   (|structureRef| :range UML23:|Element| :multiplicity (0 1)
    :documentation
     "The concrete data structure to be used.")))


;;; =========================================================
;;; ====================== Lane
;;; =========================================================
(def-mm-stereotype |Lane| (:BPMN-P) (|BaseElement| NIL)
 "A Lane is a sub-partition within a Process (often within a Pool) and will
  extend the entire length of the Process level,, either vertically or horizontally.
  Text associated with the Lane (e.g., its name and/or that of any Process
  element attribute) can be placed inside the shape, in any direction or
  location, depending on the preference of the modeler or modeling tool vendor.
  Our examples place the name as a banner on the left side (for horizontal
  Pools) or at the top (for vertical Pools) on the other side of the line
  that separates the Pool name, however, this is not a requirement."
  ((|base_ActivityPartition| :range UML23:|ActivityPartition| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== LinkCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |LinkCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |LinkEventDefinition|)
 "The Link Intermediate Events are only valid in Normal Flow, i.e. they may
  not be used on the boundary of an Activity. A Link is a mechanism for connecting
  two sections of a Process. Link Events can be used to create looping situations
  or to avoid long Sequence Flow lines. Link Event uses are limited to a
  single Process level (i.e., they cannot link a parent Process with a Sub-Process).
  Paired Intermediate Events can also be used as Off-Page Connectors for
  printing a Process across multiple pages. They can also be used as generic
  Go To objects within the Process level. There can be multiple Source Link
  Events, but there can only be one Target Link Event."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== LinkEventDefinition
;;; =========================================================
(def-mm-stereotype |LinkEventDefinition| (:BPMN-P) (|EventDefinition|)
 "A Link Event is a mechanism for connecting two sections of a Process. Link
  Events can be used to create looping situations or to avoid long Sequence
  Flow lines. The use of Link Events is limited to a single Process level
  (i.e., they cannot link a parent Process with a Sub-Process).Paired Link
  Events can also be used as \"Off-Page Connectors\" for printing a Process
  across multiple pages. They can also be used as generic \"Go To\" objects
  within the Process level. There can be multiple source Link Events, but
  there can only be one target Link Event."
  ((|sources| :range |Event| :multiplicity (1 -1))
   (|targetLinkEvent| :range |Event| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== LinkThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |LinkThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |LinkEventDefinition|)
 "The Link Intermediate Events are only valid in Normal Flow, i.e. they may
  not be used on the boundary of an Activity. A Link is a mechanism for connecting
  two sections of a Process. Link Events can be used to create looping situations
  or to avoid long Sequence Flow lines. Link Event uses are limited to a
  single Process level (i.e., they cannot link a parent Process with a Sub-Process).
  Paired Intermediate Events can also be used as Off-Page Connectors for
  printing a Process across multiple pages. They can also be used as generic
  Go To objects within the Process level. There can be multiple Source Link
  Events, but there can only be one Target Link Event."
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ManualTask
;;; =========================================================
(def-mm-stereotype |ManualTask| (:BPMN-P) (|Task|)
 "A Manual Task is a Task that is expected to be performed without the aid
  of any business process execution engine or any application. A Manual Task
  is not managed by any business process engine. It can be considered as
  an unmanaged Task, unmanaged in the sense of that the business process
  engine doesn t track the start and completion of such a Task. An example
  of this could be a paper based instruction for a telephone technician to
  install a telephone at a customer location.n."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Message
;;; =========================================================
(def-mm-stereotype |Message| (:BPMN-P) (|RootElement|)
 "A Message is used to depict the content of a communication between two
  Participants represented as Pools. In a Collaboration, the communication
  itself is represented by a Message Flow. In a Choreography, the communication
  is represented by a Choreography Task. The StructureDefinition is used
  to specify the Message ;structure."
  ((|base_CentralBufferNode| :range UML23:|CentralBufferNode| :multiplicity (1 1))
   (|itemRef| :range |ItemDefinition| :multiplicity (0 1)
    :documentation
     "An ItemDefinition is used to define the payload of the Message.")))


;;; =========================================================
;;; ====================== MessageBoundaryEvent
;;; =========================================================
(def-mm-stereotype |MessageBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |MessageEventDefinition|)
 "A Message arrives from a participant and triggers the Event. If a Message
  Event is attached to the boundary of an Activity, it will change the Normal
  Flow into an Exception Flow upon being triggered."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_message| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== MessageCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |MessageCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |MessageEventDefinition|)
 ""
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageEndEvent
;;; =========================================================
(def-mm-stereotype |MessageEndEvent| (:BPMN-P) (|EndEvent| |MessageEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageEventDefinition
;;; =========================================================
(def-mm-stereotype |MessageEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|messageRef| :range |Message| :multiplicity (0 1)
    :documentation
     "The Message MUST be supplied (if the processType attribute of the Process
      is set to executable).")
   (|operationRef| :range UML23:|Operation| :multiplicity (0 1)
    :documentation
     "This attribute specifies the operation that is used by the Message Event.
      It MUST be specified for executable Processes.")))


;;; =========================================================
;;; ====================== MessageFlow
;;; =========================================================
(def-mm-stereotype |MessageFlow| (:BPMN-P) (|BaseElement|)
 "A Message Flow is used to show the flow of Messages between two Participants
  that are prepared to send and receive them. A Message Flow MUST connect
  two separate Pools. They connect either to the Pool boundary or to Flow
  Objects within the Pool boundary."
  ((POD-UNNAMED! :range |ConversationAssociation| :multiplicity (0 -1)
    :opposite (|ConversationAssociation| |messageFlowRefs|))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))
   (|messageRef| :range |Message| :multiplicity (0 1))))


(def-mm-constraint "MessageFlow.source.target" |MessageFlow| 
   "" 
   :operation-body
   "A Message Flow MUST connect two separate Pools. They connect either to the Pool boundary or to Flow Objects within the Pool boundary. They MUST NOT connect two objects within the same Pool.")

;;; =========================================================
;;; ====================== MessageFlowAssociation
;;; =========================================================
(def-mm-stereotype |MessageFlowAssociation| (:BPMN-P) (|BaseElement|)
 "<style> p {padding:0px; margin:0px;} </style>     <p> These elements
  are used to do mapping between two elements that both contain Message Flow.
  The </p> <p> MessageFlowAssociation provides the mechanism to match up
  the Message Flow. </p> <p> A MessageFlowAssociation is used when an (outer)
  diagram with Message Flow contains an (inner) </p> <p> diagram that also
  has Message Flows. It is </p> <p> used when: </p> <ul> <li> A Collaboration
  references a Choreography for inclusion between the Collaboration s Pools
  (Participants). The Message Flow of the Choreography (the inner diagram)
  need to be mapped to the Message Flow of the Collaboration (the outer diagram).
  </li> <li> A Collaboration references a Conversation that contains Message
  Flow. The Message Flow of the Conversation can serve as a partial requirement
  for the Collaboration. Thus, the Message Flow of the Conversation (the
  inner diagram) need to be mapped to the Message Flow of the Collaboration
  (the outer diagram). </li> <li> A Choreography references a Conversation
  that contains Message Flow. The Message Flow of the Conversation can serve
  as a partial requirement for the Choreography. Thus, the Message Flow of
  the Conversation (the inner diagram) need to be mapped to the Message Flow
  of the Choreography (the outer diagram). </li> </ul> <p>   </p>"
  ((|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageFlowNode
;;; =========================================================
(def-mm-stereotype |MessageFlowNode| (:BPMN-P) NIL
 "The MessageFlowNode element is used to provide a single element as the
  source and target Message Flow associations instead of the individual associations
  of the elements that can connect to Message Flow. Only the Pool/Participant,
  Activity, and Event elements can connect to Message Flow and thus, these
  elements are the only ones that are sub-classes of MessageFlowNode. The
  MessageFlowNode element does not have any attributes or model associations
  and does not inherit from any other BPMN element. Since Pools/Participants,
  Activities, and Events have their own attributes, model associations, and
  inheritances, additional attributes and model associations for the MessageFlowNode
  element are not necessary."
  ((|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageStartEvent
;;; =========================================================
(def-mm-stereotype |MessageStartEvent| (:BPMN-P) (|StartEvent| |MessageEventDefinition|)
 "A Message arrives from a Participant and triggers the start of the Process."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_message| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== MessageThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |MessageThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |MessageEventDefinition|)
 "A Message Intermediate Event can be used to either send a Message or receive
  a Message."
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Monitoring
;;; =========================================================
(def-mm-stereotype |Monitoring| (:BPMN-P) (|BaseElement|)
 ""
  ((|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MultiInstanceLoopCharacteristics
;;; =========================================================
(def-mm-stereotype |MultiInstanceLoopCharacteristics| (:BPMN-P) NIL
 "The MultiInstanceLoopCharacteristics class allows for creation of a desired
  number of Activity instances. The instances may execute in parallel or
  may be sequential. Either an expression is used to specify or calculate
  the desired number of instances or a data driven setup can be used. In
  that case a data input can be specified, which is able to handle a collection
  of data. The number of items in the collection determines the number of
  Activity instances. This data input can be produced by a data input association.
  The modeler can also configure this loop to control the Tokens produced."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))
   (|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|behavior| :range |MultiInstanceBehavior| :multiplicity (1 1) :default :all
    :documentation
     "The attribute behavior acts as a shortcut for specifying when events shall
      be thrown from an Activity instance that is about to complete. It can assume
      values of none, one, all, and complex, resulting in the following behavior:
      - None: the EventDefinition which is associated through the noneEvent association
      will be thrown for each instance completing; - One: the EventDefinition
      referenced through the oneEvent association will be thrown upon the first
      instance completing; - All: no Event is ever thrown; a token is produced
      after completion of all instances - Complex: the complexBehaviorDefinitions
      are consulted to determine if and which Events to throw. For the behaviors
      of none and one, a default SignalEventDefinition will be thrown which automatically
      carries the current runtime attributes of the MI Activity. Any thrown Events
      can be caught by boundary Events on the Multi-Instance Activity.")
   (|completionCondition| :range |String| :multiplicity (0 1)
    :documentation
     "This attribute defines a Boolean Expression that when evaluated to true,
      cancels the remaining Activity instances and produces a token.")
   (|complexBehaviorDefintion| :range |ComplexBehaviorDefinition| :multiplicity (0 -1)
    :documentation
     "Controls when and which Events are thrown in case behavior is set to complex.")
   (|inputDataItem| :range |BPMNProperty| :multiplicity (0 1)
    :documentation
     "A Data Input, representing for every Activity instance the single item
      of the collection stored in the loopDataInput. This Data Input can be the
      source of DataInputAssociation to a data input of the Activity s InputOutputSpecification.
      The type of this Data Input MUST the scalar of the type defined for the
      loopDataInput.")
   (|isSequential| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "This attribute is a flag that controls whether the Activity instances will
      execute sequentially or in parallel.")
   (|loopCardinality| :range |String| :multiplicity (0 1)
    :documentation
     "A numeric Expression that controls the number of Activity instances that
      will be created. This Expression MUST evaluate to an integer. This may
      be underspecified, meaning that the modeler may simply document the condition.
      In such a case the loop cannot be formally executed. In order to initialize
      a valid multi-instance, either the loopCardinality Expression or the loopDataInput
      MUST be specified.")
   (|loopCounter| :range |Integer| :multiplicity (1 1)
    :documentation
     "The LoopCounter attribute is used at runtime to count the number of loops
      and is automatically updated by the process engine.")
   (|loopDataInputRef| :range |DataInput| :multiplicity (0 1)
    :documentation
     "A reference to a DataInput which is part of the Activity s InputOutputSpecification.
      This DataInput is used to determine the number of Activity instances, one
      Activity instance per item in the collection of data stored in that DataInput
      element. In order to initialize a valid multi-instance, either the loopCardinality
      Expression or the loopDataInput MUST be specified.")
   (|loopDataOutputRef| :range |DataOutput| :multiplicity (0 1)
    :documentation
     "This ItemAwareElement specifies the collection of data, which will be produced
      by the multi-instance. For Tasks it is a reference to a Data Output which
      is part of the Activity s InputOutputSpecification. For Sub-Processes it
      is a reference to a collection-valued Data Object in the context that is
      visible to the Sub-Processes.")
   (|noneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1)
    :documentation
     "The EventDefinition which is thrown when the behavior is set to none and
      an internal Activity instance has completed")
   (|numberOfActiveInstances| :range |Integer| :multiplicity (1 1)
    :documentation
     "This attribute is provided for the outer instance of the Multi-Instance
      Activity only. This attribute contains the number of currently active inner
      instances for the Multi-Instance Activity. In case of a sequential Multi-Instance
      Activity, this value can t be greater than 1. For parallel Multi-Instance
      Activities, this value can t be greater than the value contained in numberOfInstances.")
   (|numberOfCompletedInstances| :range |Integer| :multiplicity (1 1)
    :documentation
     "This attribute is provided for the outer instance of the Multi-Instance
      Activity only. This attribute contains the number of already completed
      inner instances for the Multi-Instance Activity.")
   (|numberOfInstances| :range |Integer| :multiplicity (1 1))
   (|numberOfTerminatedInstances| :range |Integer| :multiplicity (1 1)
    :documentation
     "This attribute is provided for the outer instance of the Multi-Instance
      Activity only. This attribute contains the number of terminated inner instances
      for the Multi-Instance Activity. The sum of numberOfTerminatedInstances,
      numberOfCompletedInstances, and numberOfActiveInstances always sums up
      to numberOfInstances.")
   (|oneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1)
    :documentation
     "The EventDefinition which is thrown when behavior is set to one and the
      first internal Activity instance has completed.")
   (|outputDataItem| :range |BPMNProperty| :multiplicity (0 1)
    :documentation
     "A Data Output, representing for every Activity instance the single item
      of the collection stored in the loopDataOutput. This Data Output can be
      the target of DataOutputAssociation to a data output of the Activity s
      InputOutputSpecification. The type of this Data Output MUST the scalar
      of the type defined for the loopDataOutput.")))


(def-mm-constraint "MultiInstanceLoopCharacteristics.target" |MultiInstanceLoopCharacteristics| 
   "" 
   :operation-body
   "Stereotype may be applied only on CallActivity, Task, and SubProcess")

;;; =========================================================
;;; ====================== MultipleBoundaryEvent
;;; =========================================================
(def-mm-stereotype |MultipleBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |TimerEventDefinition| |MessageEventDefinition| |LinkEventDefinition| |SignalEventDefinition| |EscalationEventDefinition| |TerminateEventDefinition| |CancelEventDefinition| |CompenstationEventDefinition| |ConditionalEventDefinition| |ErrorEventDefinition|)
 "A Multiple Event indicates that there are multiple Triggers assigned to
  the Event. When attached to the boundary of an activity, the Event can
  only catch the Trigger. In this case, only one of the assigned Triggers
  is required and the Event marker will be unfilled Upon being triggered,
  the Event that occurred will change the Normal Flow into an Exception Flow.
  There is no specific EventDefinition subclass (see page 266) for Multiple
  Intermediate Events. If the Intermediate Event has more than one associated
  EventDefiniton, then the Event will be displayed with the Multiple Event
  marker."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_multiple| :multiplicity (1 1) :default :true
    :documentation
     "Denotes whether the activity should be canceled or not, i.e., whether the
      boundary catch event acts as an error or an escalation. If the activity
      is not canceled, multiple instances of that handler can run concurrently.")))


;;; =========================================================
;;; ====================== MultipleCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |MultipleCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |TimerEventDefinition| |TerminateEventDefinition| |EscalationEventDefinition| |SignalEventDefinition| |LinkEventDefinition| |MessageEventDefinition| |CancelEventDefinition| |CompenstationEventDefinition| |ConditionalEventDefinition| |ErrorEventDefinition|)
 "This means that there are multiple Triggers assigned to the Event. If used
  within normal flow, the Event can catch the Trigger or throw the Triggers.
  When attached to the boundary of an activity, the Event can only catch
  the Trigger."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MultipleEndEvent
;;; =========================================================
(def-mm-stereotype |MultipleEndEvent| (:BPMN-P) (|EndEvent| |MessageEventDefinition| |LinkEventDefinition| |SignalEventDefinition| |EscalationEventDefinition| |TimerEventDefinition| |TerminateEventDefinition| |ErrorEventDefinition| |ConditionalEventDefinition| |CompenstationEventDefinition| |CancelEventDefinition|)
 "This means that there are multiple consequences of ending the Process.
  All of them will occur (e.g., there might be multiple messages sent)."
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MultipleStartEvent
;;; =========================================================
(def-mm-stereotype |MultipleStartEvent| (:BPMN-P) (|StartEvent| |CancelEventDefinition| |MessageEventDefinition| |LinkEventDefinition| |TimerEventDefinition| |SignalEventDefinition| |EscalationEventDefinition| |TerminateEventDefinition| |CompenstationEventDefinition| |ConditionalEventDefinition| |ErrorEventDefinition|)
 "If the Start Event has more than one associated EventDefinition and the
  parallelMultiple attribute of the Start Event is true, then the Event MUST
  be displayed with the Parallel Multiple Event marker (an open plus sign)"
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_multiple| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== MultipleThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |MultipleThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |TimerEventDefinition| |TerminateEventDefinition| |EscalationEventDefinition| |SignalEventDefinition| |LinkEventDefinition| |MessageEventDefinition| |CancelEventDefinition| |CompenstationEventDefinition| |ConditionalEventDefinition| |ErrorEventDefinition|)
 "This means that there are multiple Triggers assigned to the Event. If used
  within normal flow, the Event can catch the Trigger or throw the Triggers.
  When attached to the boundary of an activity, the Event can only catch
  the Trigger.ch the Trigger."
  ((|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== NoneEndEvent
;;; =========================================================
(def-mm-stereotype |NoneEndEvent| (:BPMN-P) (|EndEvent|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== NoneIntermediateEvent
;;; =========================================================
(def-mm-stereotype |NoneIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent|)
 "The None Intermediate Event is only valid in Normal Flow, i.e. it may not
  be used on the boundary of an Activity. Although there is no specific trigger
  for this Event, it is defined as throw Event. It is used for modeling methodologies
  that use Events to indicate some change of state in the Process."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== NoneStartEvent
;;; =========================================================
(def-mm-stereotype |NoneStartEvent| (:BPMN-P) (|StartEvent|)
 "The None Start Event does not have a defined trigger. The None Start Event
  is used for all Sub-Processes, either embedded or called (reusable). Other
  types of Triggers are not used for a Sub-Process, since the flow of the
  Process"
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Operation
;;; =========================================================
(def-mm-stereotype |Operation| (:BPMN-P) (|BaseElement|)
 ""
  ((|base_Operation| :range UML23:|Operation| :multiplicity (1 1))
   (|errorRef| :range |Error| :multiplicity (0 -1)
    :documentation
     "This attribute specifies errors that the Operation may return. An Operation
      may refer to zero or more Error elements.")
   (|implementationRef| :range UML23:|Element| :multiplicity (0 1)
    :documentation
     "This attribute allows to reference a concrete artifact in the underlying
      implementation technology representing that operation, such as a WSDL operation.")
   (|inMessageRef| :range |Message| :multiplicity (1 1)
    :documentation
     "This attribute specifies the input Message of the Operation. An Operation
      has exactly one input Message.")
   (|outMessageRef| :range |Message| :multiplicity (0 1)
    :documentation
     "This attribute specifies the output Message of the Operation. An Operation
      has at most one input Message.")))


;;; =========================================================
;;; ====================== OutputSet
;;; =========================================================
(def-mm-stereotype |OutputSet| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|dataOutputRefs| :range |DataOutput| :multiplicity (<Set of 0 {OCL OclAny}, id=309501> -1)
    :opposite (|DataOutput| |outputSetRefs|))
   (|inputSetRefs| :range |InputSet| :multiplicity (0 -1)
    :opposite (|InputSet| |outputSetRefs|))
   (|optionalOutput| :range |DataOutput| :multiplicity (0 -1)
    :opposite (|DataOutput| |outputSetWithOptional|))
   (|whileExecutingOutput| :range |DataOutput| :multiplicity (0 -1)
    :opposite (|DataOutput| |outputSetWithWhileExecuting|))))


;;; =========================================================
;;; ====================== ParallelGateway
;;; =========================================================
(def-mm-stereotype |ParallelGateway| (:BPMN-P) (|Gateway|)
 "A Parallel Gateway is used to synchronize (combine) parallel flows and
  to create parallel flows."
  ((|base_ForkNode| :range UML23:|ForkNode| :multiplicity (1 1))
   (|base_JoinNode| :range UML23:|JoinNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ParallelMultipleBoundaryEvent
;;; =========================================================
(def-mm-stereotype |ParallelMultipleBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |MessageEventDefinition| |LinkEventDefinition| |SignalEventDefinition| |EscalationEventDefinition| |TimerEventDefinition| |TerminateEventDefinition| |ErrorEventDefinition| |ConditionalEventDefinition| |CompenstationEventDefinition| |CancelEventDefinition|)
 "This means that there are multiple triggers assigned to the Event. When
  attached to the boundary of an activity, the Event can only catch the trigger.
  Unlike the normal Multiple Intermediate Event, all of the assigned triggers
  are required for the Event to be triggered."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_parallelMultiple| :multiplicity (1 1) :default :true
    :documentation
     "Denotes whether the activity should be canceled or not, i.e., whether the
      boundary catch event acts as an error or an escalation. If the activity
      is not canceled, multiple instances of that handler can run concurrently.")))


;;; =========================================================
;;; ====================== ParallelMultipleCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |ParallelMultipleCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |MessageEventDefinition| |LinkEventDefinition| |SignalEventDefinition| |EscalationEventDefinition| |TimerEventDefinition| |CancelEventDefinition| |CompenstationEventDefinition| |ConditionalEventDefinition| |ErrorEventDefinition| |TerminateEventDefinition|)
 "This means that there are multiple triggers assigned to the Event. If used
  within normal flow, the Event can only catch the trigger. When attached
  to the boundary of an activity, the Event can only catch the trigger. Unlike
  the normal Multiple Intermediate Event, all of the assigned triggers are
  required for the Event to be triggered."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ParallelMultipleStartEvent
;;; =========================================================
(def-mm-stereotype |ParallelMultipleStartEvent| (:BPMN-P) (|StartEvent| |SignalEventDefinition| |CompenstationEventDefinition| |ErrorEventDefinition| |TerminateEventDefinition| |TimerEventDefinition| |LinkEventDefinition| |MessageEventDefinition| |ConditionalEventDefinition| |CancelEventDefinition| |EscalationEventDefinition|)
 ""
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_parallelMultiple| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).")))


;;; =========================================================
;;; ====================== Participant
;;; =========================================================
(def-mm-stereotype |Participant| (:BPMN-P) (|MessageFlowNode| |RootElement| |BaseElement|)
 "A Participant represents a specific PartnerEntity (e.g., a company) and/or
  a more general PartnerRole (e.g., a buyer, seller, or manufacturer) that
  Participants in a Collaboration. A Participant is often responsible for
  the execution of the Process enclosed in a Pool; however, a Pool may be
  defined without a Process. When Participants are defined they are contained
  within an InteractionSpecification, which includes the sub-types of Collaboration,
  a Choreography, a Conversation, a Global Communication, or a GlobalChoreographyTask."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|endpointRefs| :range |EndPoint| :multiplicity (0 -1)
    :documentation
     "This attribute is used to specify the address (or endpoint reference) of
      concrete services realizing the Participant.")
   (|globalChoreographyTask| :range |GlobalChoreographyTask| :multiplicity (<Set of 0 {OCL OclAny}, id=309550> -1)
    :opposite (|GlobalChoreographyTask| |initiatingParticipantRef|))
   (|interfaceRef| :range UML23:|Interface| :multiplicity (<Set of 0 {OCL OclAny}, id=309553> -1)
    :documentation
     "This association defines Interfaces that a Participant supports.")
   (|maximum| :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The maximum attribute defines maximum number of Participants that MAY be
      involved in the Collaboration. The value of maximum MUST be one (1) or
      greater, AND MUST be equal or greater than the minimum value.")
   (|minimum| :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The minimum attribute defines minimum number of Participants that MUST
      be involved in the Collaboration. If a value is specified in the maximum
      attribute, it MUST be greater or equal to this minimum value")
   (|numParticipants| :range |Integer| :multiplicity (0 1)
    :documentation
     "The current number of the multiplicity of the Participant for this Choreography
      or Collaboration Instance.")
   (|partnerEntityRef| :range |PartnerEntity| :multiplicity (0 1) :is-readonly-p T
    :opposite (|PartnerEntity| |participantRef|)
    :documentation
     "The partnerEntityRef attribute identifies a PartnerEntity that the Participant
      plays in the Collaboration. Both a PartnerRole and a PartnerEntity MAY
      be defined for the Participant.")
   (|partnerRoleRef| :range |PartnerRole| :multiplicity (0 1) :is-readonly-p T
    :opposite (|PartnerRole| |participantRef|)
    :documentation
     "The partnerRoleRef attribute identifies a PartnerRole that the Participant
      plays in the Collaboration. Both a PartnerRole and a PartnerEntity MAY
      be defined for the Participant.")
   (|processRef| :range |BPMNProcess| :multiplicity (0 1)
    :documentation
     "The processRef attribute identifies the Process that the Participant uses
      in the Collaboration. The Process will be displayed within the Participant
      s Pool.")))


;;; =========================================================
;;; ====================== ParticipantAssociation
;;; =========================================================
(def-mm-stereotype |ParticipantAssociation| (:BPMN-P) (|BaseElement|)
 "These elements are used to do mapping between two elements that both contain
  Participants. There are situations where the Participants in different
  diagrams can be defined differently because they were developed independently,
  but represent the same thing. The ParticipantAssociation provides the mechanism
  to match up the Participants. A ParticipantAssociation is used when an
  (outer) diagram with Participants contains an (inner) diagram that also
  has Participants. There are four (4) usages of ParticipantAssociation.
  It is used when: A Collaboration references a Choreography for inclusion
  between the Collaboration s Pools (Participants). The Participants of the
  Choreography (the inner diagram) need to be mapped to the Participants
  of the Collaboration (the outer diagram). A Call Conversation references
  a Collaboration or GlobalConversation. Thus, the Participants of the Collaboration
  or GlobalConversation (the inner diagram) need to be mapped to the Participants
  referenced by the Call Conversation (the outer element). Each Call Conversation
  contains its own set of ParticipantAssociations. A Call Choreography references
  a Choreography or GlobalChoreographyTask. Thus, the Participants of the
  Choreography or GlobalChoreographyTask (the inner diagram) need to be mapped
  to the Participants referenced by the Call Choreography (the outer element).
  Each Call Choreography contains its own set of ParticipantAssociations.
  A Call Activity within a Process that has a definitional Collaboration
  references another Process that also has a definitional Collaboration.
  The Participants of the definitional Collaboration of the called Process
  (the inner diagram) need to be mapped to the Participants of the definitional
  Collaboration of the calling Process (the outer diagram)."
  ((|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== PartnerEntity
;;; =========================================================
(def-mm-stereotype |PartnerEntity| (:BPMN-P) (|RootElement|)
 "An PartnerEntity is one of the possible types of Participant."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|participantRef| :range |Participant| :multiplicity (1 1)
    :opposite (|Participant| |partnerEntityRef|)
    :documentation
     "Specifies how the PartnerEntity participates in Collaborations and Choreographies.")))


;;; =========================================================
;;; ====================== PartnerRole
;;; =========================================================
(def-mm-stereotype |PartnerRole| (:BPMN-P) (|RootElement|)
 "A PartnerRole is one of the possible types of Participant."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|participantRef| :range |Participant| :multiplicity (0 -1)
    :opposite (|Participant| |partnerRoleRef|)
    :documentation
     "Specifies how the PartnerRole participates in Collaborations and Choreographies")))


;;; =========================================================
;;; ====================== Performer
;;; =========================================================
(def-mm-stereotype |Performer| (:BPMN-P) (|ResourceRole|)
 "The Performer class defines the resource that will perform or will be responsible
  for an Activity. The performer can be specified in the form of a specific
  individual, a group, an organization role or position, or an organization."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== PinProperty
;;; =========================================================
(def-mm-stereotype |PinProperty| (:BPMN-P) (|BPMNProperty|)
 ""
  ((|base_ValuePin| :range UML23:|ValuePin| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Pool
;;; =========================================================
(def-mm-stereotype |Pool| (:BPMN-P) (|MessageFlowNode|)
 "A Pool is the graphical representation of a Participant in a Collaboration.
  A Participant can be a specific PartnerEntity (e.g., a company) or can
  be a more general PartnerRole (e.g., a buyer, seller, or manufacturer).
  A Pool MAY or MAY NOT reference a Process. A Pool is NOT REQUIRED to contain
  a Process, i.e., it can be a black box."
  ((|base_ActivityPartition| :range UML23:|ActivityPartition| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== PotentialOwner
;;; =========================================================
(def-mm-stereotype |PotentialOwner| (:BPMN-P) (|HumanPerformer|)
 ""
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ProcessDiagram
;;; =========================================================
(def-mm-stereotype |ProcessDiagram| (:BPMN-P) NIL
 "ProcessDiagram is a concrete DiagramDefinition that defines diagrams that
  reference a BPMN Process element as a context. Diagram may own lanes. Processes
  (Orchestration), includes: o Private Non-executable (internal) Business
  Processes o Private Executable (internal) Business Processes o Public Processes"
  ((|base_Diagram| :range NIL :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ReceiveTask
;;; =========================================================
(def-mm-stereotype |ReceiveTask| (:BPMN-P) (|Task|)
 "A Receive Task is a simple Task that is designed to wait for a Message
  to arrive from an external Participant (relative to the Process). Once
  the Message has been received, the Task is completed."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|implementation| :range |Implementation| :multiplicity (1 1) :default :web service
    :documentation
     "This attribute specifies the technology that will be used to send and receive
      the Messages. Valid values are \"##unspecified\" for leaving the implementation
      technology open, \"##WebService\" for the Web service technology or a URI
      identifying any other technology or coordination protocol A Web service
      is the default technology")
   (|instantiate| :range NIL :multiplicity (1 1) :default :false
    :documentation
     "Receive Tasks can be defined as the instantiation mechanism for the Process
      with the instantiate attribute. This attribute MAY be set to true if the
      Task is the first Activity (i.e., there are no incoming Sequence Flows).
      Multiple Tasks MAY have this attribute set to true.")
   (|messageRef| :range |Message| :multiplicity (0 1)
    :documentation
     "A Message for the messageRef attribute MAY be entered. This indicates that
      the Message will be received by the Task. The Message in this context is
      equivalent to an in-only message pattern (Web service). One or more corresponding
      incoming Message Flow MAY be shown on the diagram. However, the display
      of the Message Flow is not required. The Message is applied to all incoming
      Message Flow, but can arrive for only one of the incoming Message Flow
      for a single instance of the Task.")
   (|operationRef| :range UML23:|Operation| :multiplicity (1 1)
    :documentation
     "This attribute specifies the operation through which the Receive Task receives
      the Message.")))


;;; =========================================================
;;; ====================== Relationship
;;; =========================================================
(def-mm-stereotype |Relationship| (:BPMN-P) (|BaseElement|)
 "It is the intention of this specification to cover the basic elements required
  for the construction of semantically rich and syntactically valid Process
  models to be used in the description of Processes, Choreographies and business
  operations in multiple levels of abstraction. As the specification indicates,
  extension capabilities enable the enrichment of the information described
  in BPMN and supporting models to be augmented to fulfill particularities
  of a given usage model. These extensions intention is to extend the semantics
  of a given BPMN Artifact to provide specialization of intent or meaning.
  Process models do not exist in isolation and generally participate in larger,
  more complex business and system development Processes. The intention of
  the following specification element is to enable BPMN Artifacts to be integrated
  in these development Processes via the specification of a non-intrusive
  identity/relationship model between BPMN Artifacts and elements expressed
  in any other addressable domain model. The identity/relationship model
  it is reduced to the creation of families of typed relationships that enable
  BPMN and non-BPMN Artifacts to be related in non intrusive manner. By simply
  defining relationship types that can be associated with elements in the
  BPMN Artifacts and arbitrary elements in a given addressable domain model,
  it enables the extension and integration of BPMN models into larger system/development
  Processes. It is that these extensions will enable, for example, the linkage
  of derivation or definition relationships between UML artifacts and BPMN
  Artifacts in novel ways. So, a UML use case could be related to a Process
  element in the BPMN specification without affecting the nature of the Artifacts
  themselves, but enabling different integration models that traverse specialized
  relationships. Simply, the model enables the external specification of
  augmentation relationships between BPMN Artifacts and arbitrary relationship
  classification models, these external models, via traversing relationships
  declared in the external definition allow for linkages between BPMN elements
  and other structured or non-structured metadata definitions."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))
   (|definition| :range |Definitions| :multiplicity (1 1)
    :opposite (|Definitions| |relationships|))))


;;; =========================================================
;;; ====================== Rendering
;;; =========================================================
(def-mm-stereotype |Rendering| (:BPMN-P) NIL
 "BPMN User Tasks need to be rendered on user interfaces like forms clients,
  portlets, etc. The Rendering element provides an extensible mechanism for
  specifying UI renderings for User Tasks (Task UI). The element is optional.
  One or more rendering methods may be provided in a Task definition. A User
  Task can be deployed on any compliant implementation, irrespective of the
  fact whether the implementation supports specified rendering methods or
  not. The Rendering element is the extension point for renderings. Things
  like language considerations are opaque for the Rendering element because
  the rendering applications typically provide MultiLanguage support. Where
  this is not the case, providers of certain rendering types may decide to
  extend the rendering type in order to provide language information for
  a given rendering. The content of the rendering element is not defined
  by this specification."
  ((|base_Pin| :range UML23:|Pin| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Resource
;;; =========================================================
(def-mm-stereotype |Resource| (:BPMN-P) (|RootElement|)
 "The Resource class is used to specify resources that can be referenced
  by Activities. These Resources can be Human Resources as well as any other
  resource assigned to Activities during Process execution time. The definition
  of a Resource is \"abstract\", because it only defines the Resource, without
  detailing how e.g. actual user IDs are associated at runtime. Multiple
  Activities can utilize the same Resource. Every Resource can define a set
  of ResourceParameters. These parameters can be used at runtime to define
  query e.g. into an Organizational Directory. Every Activity referencing
  a parameterized Resource can bind values available in the scope of the
  Activity to these parameters."
  ((|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ResourceAssignmentExpression
;;; =========================================================
(def-mm-stereotype |ResourceAssignmentExpression| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|expression| :range |String| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The element ResourceAssignmentExpression MUST contain an Expression which
      is used at runtime to assign resource(s) to a ResourceRole element.")))


;;; =========================================================
;;; ====================== ResourceParameter
;;; =========================================================
(def-mm-stereotype |ResourceParameter| (:BPMN-P) (|BaseElement| |RootElement|)
 "Resource can define a set of parameters to define a query to resolve the
  actual resources (e.g. user ids). The ResourceParameter element inherits
  the attributes and model associations of BaseElement through its relationship
  to RootElement, and adds additional model associations: type: Element -
  specifies the type of the query parameter isRequired: Boolean - specifies,
  if a parameter is optional or mandatory."
  ((|base_Property| :range UML23:|Property| :multiplicity (1 1))
   (|isRequired| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies, if a parameter is optional or mandatory.")))


;;; =========================================================
;;; ====================== ResourceParameterBinding
;;; =========================================================
(def-mm-stereotype |ResourceParameterBinding| (:BPMN-P) NIL
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|expression| :range |String| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The Expression that evaluates the value used to bind the ResourceParameter.")
   (|parameterRef| :range |ResourceParameter| :multiplicity (1 1)
    :documentation
     "Reference to the parameter defined by the Resource.")))


;;; =========================================================
;;; ====================== ResourceRole
;;; =========================================================
(def-mm-stereotype |ResourceRole| (:BPMN-P) (|BaseElement|)
 "The ResourceRole element inherits the attributes and model associations
  of BaseElement. It also defines the additional model associations."
  ((|ResourceAssignmentExpression| :range |ResourceAssignmentExpression| :multiplicity (0 1) :is-composite-p T
    :documentation
     "This defines the Expression used for the Resource assignment (see below).
      Should not be specified when a resourceRef is provided.")
   (|base_Actor| :range UML23:|Actor| :multiplicity (1 1))
   (|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|resourceParameterBindings| :range |ResourceParameterBinding| :multiplicity (<Set of 0 {OCL OclAny}, id=309717> -1) :is-composite-p T
    :documentation
     "This defines the Parameter bindings used for the Resource assignment. Is
      only applicable if a resourceRef is specified.")
   (|resourceRef| :range |Resource| :multiplicity (0 1)
    :documentation
     "The Resource that is associated with Activity. Should not be specified
      when resource AssignmentExpression is provided.")))


;;; =========================================================
;;; ====================== RootElement
;;; =========================================================
(def-mm-stereotype |RootElement| (:BPMN-P) (|BaseElement|)
 "RootElement is the abstract super class for all BPMN elements that are
  contained within Definitions. When contained within Definitions, these
  elements have their own defined life-cycle and are not deleted with the
  deletion of other elements. Examples of concrete RootElements include Collaboration,
  Process, and Choreography. Depending on their use, RootElements can be
  referenced by multiple other elements (i.e., they can be reused). Some
  RootElements may be contained within other elements instead of Definitions.
  This is done to avoid the maintenance overhead of an independent life-cycle.
  For example, an EventDefinition may be contained in a Process since it
  may be only required there. In this case the EventDefinition would be dependent
  on the tool life-cycle of the Process."
  ((|base_ActivityEdge| :range UML23:|ActivityEdge| :multiplicity (1 1))
   (|base_ActivityNode| :range UML23:|ActivityNode| :multiplicity (1 1))
   (|base_ActivityPartition| :range UML23:|ActivityPartition| :multiplicity (1 1))
   (|base_Classifier| :range UML23:|Classifier| :multiplicity (1 1))
   (|base_Comment| :range UML23:|Comment| :multiplicity (1 1))
   (|base_Dependency| :range UML23:|Dependency| :multiplicity (1 1))
   (|base_Property| :range UML23:|Property| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ScriptTask
;;; =========================================================
(def-mm-stereotype |ScriptTask| (:BPMN-P) (|Task|)
 "A Script Task is executed by a business process engine. The modeler or
  implementer defines a script in a language that the engine can interpret.
  When the Task is ready to start, the engine will execute the script. When
  the script is completed, the Task will also be completed."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|script| :range |String| :multiplicity (0 1)
    :documentation
     "The modeler MAY include a script that can be run when the Task is performed.
      If a script is not included, then the Task will act as the equivalent of
      an Abstract Task.")
   (|scriptFormat| :range |String| :multiplicity (0 1)
    :documentation
     "Defines the format of the script. This attribute value MUST be specified
      with a mime-type format. And it MUST be specified if a script is provided.")))


(def-mm-constraint "ScriptTask.scriptFormat" |ScriptTask| 
   "" 
   :operation-body
   "scriptFormat must be provided if a script is provided.")

;;; =========================================================
;;; ====================== SendTask
;;; =========================================================
(def-mm-stereotype |SendTask| (:BPMN-P) (|Task|)
 "A Send Task is a simple Task that is designed to send a Message to an external
  Participant (relative to the Process). Once the Message has been sent,
  the Task is completed."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|implementation| :range |Implementation| :multiplicity (1 1) :default :web service)
   (|messageRef| :range |Message| :multiplicity (0 1)
    :documentation
     "A Message for the messageRef attribute MAY be entered. This indicates that
      the Message will be sent by the Task. The Message in this context is equivalent
      to an out-only message pattern (Web service). One or more corresponding
      outgoing Message Flows MAY be shown on the diagram. However, the display
      of the Message Flows is NOT REQUIRED. The Message is applied to all outgoing
      Message Flows and the Message will be sent down all outgoing Message Flows
      at the completion of a single instance of the Task.")
   (|operationRef| :range UML23:|Operation| :multiplicity (1 1)
    :documentation
     "This attribute specifies the operation that is invoked by the Send Task.")))


;;; =========================================================
;;; ====================== SequenceFlow
;;; =========================================================
(def-mm-stereotype |SequenceFlow| (:BPMN-P) (|FlowElement|)
 "A Sequence Flow is used to show the order of Flow Elements in a Process.
  Each Sequence Flow has only one source and only one target. The source
  and target must be from the set of the following Flow Elements: Events
  (Start, Intermediate, and End), Activities (Task and Sub-Process), and
  Gateways. A Sequence Flow can optionally define a condition expression,
  indicating that the transfer of control will only be available if the expression
  evaluates to true. This expression is typically used when the source of
  the Sequence Flow is a Gateway or an Activity. A Sequence Flow that has
  an Exclusive, Inclusive, or Complex Gateway or an Activity as its source
  can also be defined with as default. Such Sequence Flow will have a marker
  to show that it is a default flow. The default Sequence Flow is taken (a
  token is passed) only if all the other outgoing Sequence Flow from the
  Activity or Gateway are not valid (i.e., their condition Expressions are
  false)."
  ((|base_ControlFlow| :range UML23:|ControlFlow| :multiplicity (1 1))
   (|isImmediate| :range |Boolean| :multiplicity (1 1)
    :documentation
     "An optional boolean value specifying whether Activities or Choreography
      Activities not in the model containing the Sequence Flow can occur between
      the elements connected by the Sequence Flow. If the value is true, they
      MAY NOT occur. If the value is false, they MAY occur. Also see the isClosed
      attribute on Process, Choreography, and Collaboration. When the attribute
      has no value, the default semantics depends on the kind of model containing
      Sequence Flows: - For non-executable Processes (public Processes and non-executable
      private Processes) and Choreographies no value has the same semantics as
      if the value were false. - For an executable Processes no value has the
      same semantics as if the value were true. - For executable Processes, the
      attribute MUST NOT be false.")))


;;; =========================================================
;;; ====================== ServiceTask
;;; =========================================================
(def-mm-stereotype |ServiceTask| (:BPMN-P) (|Task|)
 "A Service Task is a Task that uses some sort of service, which could be
  a Web service or an automated application."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|implementation| :range |Implementation| :multiplicity (1 1) :default :web service
    :documentation
     "This attribute specifies the technology that will be used to send and receive
      the Messages. Valid values are \"##unspecified\" for leaving the implementation
      technology open, \"##WebService\" for the Web service technology or a URI
      identifying any other technology or coordination protocol. A Web service
      is the default technology.")
   (|operationRef| :range UML23:|Operation| :multiplicity (0 1)
    :documentation
     "This attribute specifies the operation that is invoked by the Service Task.")))


(def-mm-constraint "ServiceTask.inputSet" |ServiceTask| 
   "" 
   :operation-body
   "The Service Task has exactly one InputSet")

(def-mm-constraint "ServiceTask.outputSet" |ServiceTask| 
   "" 
   :operation-body
   "The Service Task has at most one OutputSet")

;;; =========================================================
;;; ====================== SignalBoundaryEvent
;;; =========================================================
(def-mm-stereotype |SignalBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |SignalEventDefinition|)
 "The Signal Event can only receive a Signal when attached to the boundary
  of an activity. In this context, it will change the Normal Flow into an
  Exception Flow upon being triggered. The Signal Event differs from an Error
  Event in that the Signal defines a more general, non-error condition for
  interrupting activities (such as the successful completion of another activity)
  as well as having a larger scope than Error Events. When used to catch
  the signal, the Event marker will be unfilled."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_signal| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== SignalCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |SignalCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |SignalEventDefinition|)
 "This type of event is used for sending or receiving Signals. A Signal is
  for general communication within and across Process Levels, across Pools,
  and between Business Process Diagrams. A BPMN Signal is similar to a signal
  flare that shot into the sky for anyone who might be interested to notice
  and then react. Thus, there is a source of the Signal, but no specific
  intended target. This type of Intermediate Event can send or receive a
  Signal if the Event is part of a Normal Flow. The Event can only receive
  a Signal when attached to the boundary of an activity. The Signal Event
  differs from an Error Event in that the Signal defines a more general,
  non-error condition for interrupting activities (such as the successful
  completion of another activity) as well as having a larger scope than Error
  Events."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SignalEndEvent
;;; =========================================================
(def-mm-stereotype |SignalEndEvent| (:BPMN-P) (|EndEvent| |SignalEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SignalEventDefinition
;;; =========================================================
(def-mm-stereotype |SignalEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|signalRef| :range UML23:|Signal| :multiplicity (0 1)
    :documentation
     "If the Trigger is a Signal, then a Signal is provided")))


;;; =========================================================
;;; ====================== SignalStartEvent
;;; =========================================================
(def-mm-stereotype |SignalStartEvent| (:BPMN-P) (|StartEvent| |SignalEventDefinition|)
 ""
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_signal| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== SignalThrowIntermediateEvent
;;; =========================================================
(def-mm-stereotype |SignalThrowIntermediateEvent| (:BPMN-P) (|IntermediateThrowEvent| |SignalEventDefinition|)
 "This type of event is used for sending or receiving Signals. A Signal is
  for general communication within and across Process Levels, across Pools,
  and between Business Process Diagrams. A BPMN Signal is similar to a signal
  flare that shot into the sky for anyone who might be interested to notice
  and then react. Thus, there is a source of the Signal, but no specific
  intended target. This type of Intermediate Event can send or receive a
  Signal if the Event is part of a Normal Flow. The Event can only receive
  a Signal when attached to the boundary of an activity. The Signal Event
  differs from an Error Event in that the Signal defines a more general,
  non-error condition for interrupting activities (such as the successful
  completion of another activity) as well as having a larger scope than Error
  Events."
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|base_SendObjectAction| :range UML23:|SendObjectAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== StandardLoopCharacteristics
;;; =========================================================
(def-mm-stereotype |StandardLoopCharacteristics| (:BPMN-P) NIL
 "The StandardLoopCharacteristics class defines looping behavior based on
  a boolean condition. The Activity will loop as long as the boolean condition
  is true. The condition is evaluated for every loop iteration, and may be
  evaluated at the beginning or at the end of the iteration. In addition,
  a numeric cap can be optionally specified. The number of iterations may
  not exceed this cap."
  ((|base_CallBehaviorAction| :range UML23:|CallBehaviorAction| :multiplicity (1 1))
   (|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|loopCondition| :range |String| :multiplicity (0 1)
    :documentation
     "A Boolean expression that controls the loop. The Activity will only loop
      as long as this condition is true. The looping behavior may be underspecified,
      meaning that the modeler may simply document the condition, in which case
      the loop cannot be formally executed.")
   (|loopCounter| :range |Integer| :multiplicity (1 1)
    :documentation
     "The LoopCounter attribute is used at runtime to count the number of loops
      and is automatically updated by the process engine.")
   (|loopMaximum| :range |String| :multiplicity (0 1)
    :documentation
     "Serves as a cap on the number of iterations.")
   (|testBefore| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Flag that controls whether the loop condition is evaluated at the beginning
      (testBefore = true) or at the end (testBefore = false) of the loop iteration.")))


(def-mm-constraint "StandardLoopCharacteristics.target" |StandardLoopCharacteristics| 
   "" 
   :operation-body
   "Stereotype may be applied only on CallActivity, Task, and SubProcess")

;;; =========================================================
;;; ====================== StartEvent
;;; =========================================================
(def-mm-stereotype |StartEvent| (:BPMN-P) (|CatchEvent|)
 "As the name implies, the Start Event indicates where a particular Process
  will start. In terms of Sequence Flow, the Start Event starts the flow
  of the Process, and thus, will not have any incoming Sequence Flow no Sequence
  Flow can connect to a Start Event."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SubChoreography
;;; =========================================================
(def-mm-stereotype |SubChoreography| (:BPMN-P) (|ChoreographyActivity|)
 "A Choreography Sub-Process is a compound Activity in that it has detail
  that is defined as a flow of other Activities, in this case, a Choreography.
  Each Choreography Sub-Process involves two (2) or more Participants. The
  name of the Choreography Sub-Process and each of the Participants are all
  displayed in the different bands that make up the shape s graphical notation.
  There are two (2) more Participant Bands and one Sub-Process Name Band.
  The Choreography Sub-Process can be in a collapsed view that hides its
  details, or a Choreography Sub-Process can be expanded to show its details
  (a Choreography Process) within the Choreography Process in which it is
  contained (see Figure 12-19). In the collapsed form, the Sub-Process object
  uses a marker to distinguish it as a Choreography Sub-Process, rather than
  a Choreography Task."
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|referencedDiagram| :range NIL :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SubConversation
;;; =========================================================
(def-mm-stereotype |SubConversation| (:BPMN-P) (|ConversationNode|)
 "<p> A Sub-Conversation is a ConversationNode that is a hierarchical
  division within the parent Conversation. A Sub-Conversation is a graphical
  object within a Conversation, but it also can be opened; to show the lower-level
  Conversation, which consist of Message Flow, Communications, and/or other
  Sub-Conversations. The Sub-Conversation shares the Participants of its
  parent Conversation. </p>"
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SubProcess
;;; =========================================================
(def-mm-stereotype |SubProcess| (:BPMN-P) (|BPMNActivity|)
 "A Sub-Process is an Activity whose internal details have been modeled using
  Activities, Gateways, Events, and Sequence Flow. A Sub-Process is a graphical
  object within a Process, but it also can be opened up to show a lower-level
  Process. Sub-Processes define a contextual scope that can be used for attribute
  visibility, transactional scope, for the handling of exceptions, of Events,
  or for compensation. There are different types of Sub-Processes."
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|referencedDiagram| :range NIL :multiplicity (0 1))
   (|triggeredByEvent| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A flag that identifies whether this Sub-Process is an Event Sub-Process.
      If false, then this Sub-Process is a normal Sub-Process. If true, the this
      Sub-Process is an Event Sub-Process and is subject to additional constraints.")))


;;; =========================================================
;;; ====================== Task
;;; =========================================================
(def-mm-stereotype |Task| (:BPMN-P) (|BPMNActivity| |MessageFlowNode| |InteractionNode|)
 "A Task is an atomic Activity within a Process flow. A Task is used when
  the work in the Process cannot be broken down to a finer level of detail.
  Generally, an end-user and/or applications are used to perform the Task
  when it is executed. There are different types of Tasks identified within
  BPMN to separate the types of inherent behavior that Tasks might represent.
  The list of Task types may be extended along with any corresponding indicators.
  A Task which is not further specified is called Abstract Task."
  ((|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== TerminateEndEvent
;;; =========================================================
(def-mm-stereotype |TerminateEndEvent| (:BPMN-P) (|EndEvent| |TerminateEventDefinition|)
 ""
  ((|base_ActivityFinalNode| :range UML23:|ActivityFinalNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== TerminateEventDefinition
;;; =========================================================
(def-mm-stereotype |TerminateEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ())


;;; =========================================================
;;; ====================== TextAnnotation
;;; =========================================================
(def-mm-stereotype |TextAnnotation| (:BPMN-P) (|BPMNArtifact|)
 "Text Annotations are a mechanism for a modeler to provide additional information
  for the reader of a BPMN Diagram."
  ((|base_Comment| :range UML23:|Comment| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ThrowEvent
;;; =========================================================
(def-mm-stereotype |ThrowEvent| (:BPMN-P) (|Event|)
 "Events that throw a Result. All End Events and some Intermediate Events
  are throwing Events that may eventually be caught by another Event. Typically
  the Trigger carries information out of the scope where the throw Event
  occurred into the scope of the catching Events. The throwing of a trigger
  may be either implicit as defined by this standard or an extension to it
  or explicit by a throw Event."
  ((|dataInput| :range |DataInput| :multiplicity (0 1) :is-composite-p T)
   (|inputSet| :range |InputSet| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== TimerBoundaryEvent
;;; =========================================================
(def-mm-stereotype |TimerBoundaryEvent| (:BPMN-P) (|BoundaryEvent| |TimerEventDefinition|)
 "A specific time-date or a specific cycle (e.g., every Monday at 9 am) can
  be set that will trigger the Event. If a Timer Event is attached to the
  boundary of an Activity, it will change the Normal Flow into an Exception
  Flow upon being triggered."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))
   (|cancelActivity| :range |cancelActivity_timer| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== TimerCatchIntermediateEvent
;;; =========================================================
(def-mm-stereotype |TimerCatchIntermediateEvent| (:BPMN-P) (|IntermediateCatchEvent| |TimerEventDefinition|)
 "In Normal Flow the Timer Intermediate Event acts as a delay mechanism based
  on a specific time-date or a specific cycle (e.g., every Monday at 9 am)
  can be set that will trigger the Event."
  ((|base_AcceptEventAction| :range UML23:|AcceptEventAction| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== TimerEventDefinition
;;; =========================================================
(def-mm-stereotype |TimerEventDefinition| (:BPMN-P) (|EventDefinition|)
 ""
  ((|timeCycle| :range |String| :multiplicity (0 1)
    :documentation
     "If the trigger is a Timer, then a timeCycle MAY be entered. Timer attributes
      are mutually exclusive and if any of the other Timer attributes is set,
      timeCycle MUST NOT be set (if the isExecutable attribute of the Process
      is set to true). The return type of the attribute timeCycle MUST conform
      to the ISO-8601 format for recurring time interval representations.")
   (|timeDate| :range |String| :multiplicity (0 1)
    :documentation
     "If the trigger is a Timer, then a timeDate MAY be entered. Timer attributes
      are mutually exclusive and if any of the other Timer attributes is set,
      timeDate MUST NOT be set (if the isExecutable attribute of the Process
      is set to true). The return type of the attribute timeDate MUST conform
      to the ISO-8601 format for date and time representations.")
   (|timeDuration| :range |String| :multiplicity (0 1)
    :documentation
     "If the trigger is a Timer, then a timeDuration MAY be entered. Timer attributes
      are mutually exclusive and if any of the other Timer attributes is set,
      timeDuration MUST NOT be set (if the isExecutable attribute of the Process
      is set to true). The return type of the attribute timeDuration MUST conform
      to the ISO-8601 format for time interval representations.")))


;;; =========================================================
;;; ====================== TimerStartEvent
;;; =========================================================
(def-mm-stereotype |TimerStartEvent| (:BPMN-P) (|StartEvent| |TimerEventDefinition|)
 "A specific time-date or a specific cycle (e.g. every Monday at 9 am) can
  be set that will trigger the start of the Process."
  ((|base_InitialNode| :range UML23:|InitialNode| :multiplicity (1 1))
   (|isInterrupting| :range |isInterrupting_timer| :multiplicity (1 1) :default :true
    :documentation
     "This attribute only applies to Start Events of Event Sub-Processes; it
      is ignored for other Start Events. This attribute denotes whether the Sub-Process
      encompassing the Event Sub-Process should be canceled or not, If the encompassing
      Sub-Process is not canceled, multiple instances of the Event Sub-Process
      can run concurrently. This attribute cannot be applied to Error Events
      (where it s always true), or Compensation Events (where it doesn t apply).ly).")))


;;; =========================================================
;;; ====================== Transaction
;;; =========================================================
(def-mm-stereotype |Transaction| (:BPMN-P) (|SubProcess|)
 "A Transaction is a specialized type of Sub-Process which will have a special
  behavior that is controlled through a transaction protocol (such as WS-Transaction)."
  ((|base_StructuredActivityNode| :range UML23:|StructuredActivityNode| :multiplicity (1 1))
   (|method| :range |TransactionMethod| :multiplicity (1 1) :default :compensate
    :documentation
     "TransactionMethod is an attribute that defines the technique that will
      be used to undo a Transaction that has been canceled. The default is compensate,
      but the attribute MAY be set to store or IMAGE.")
   (|protocol| :range |String| :multiplicity (0 1)
    :documentation
     "The elements that make up the internal Sub-Process flow. This association
      is only applicable when the XSD Interchange is used. In the case of the
      XMI interchange, this association is inherited from the FlowElementsContainer
      class.")))


;;; =========================================================
;;; ====================== UserTask
;;; =========================================================
(def-mm-stereotype |UserTask| (:BPMN-P) (|Task|)
 "A User Task is a typical workflow Task where a human performer performs
  the Task with the assistance of a software application and is scheduled
  through a task list manager of some sort. sort."
  ((|actualOwner| :range |String| :multiplicity (1 1)
    :documentation
     "Returns the user who picked/claimed the User task and became the actual
      owner of it. The value is a literal representing the user s id, email address
      etc.")
   (|base_OpaqueAction| :range UML23:|OpaqueAction| :multiplicity (1 1))
   (|implementation| :range |UserTaskImplementation| :multiplicity (1 1) :default :other
    :documentation
     "This attribute specifies the technology that will be used to implement
      the Business Rule Task. Valid values are \"##unspecified\" for leaving the
      implementation technology open, \"##WebService\" for the Web service technology
      or a URI identifying any other technology or coordination protocol. The
      default technology for this task is unspecified.")
   (|renderings| :range |Rendering| :multiplicity (<Set of 0 {OCL OclAny}, id=309963> -1) :is-composite-p T)
   (|taskPriority| :range |Integer| :multiplicity (1 1)
    :documentation
     "Returns the priority of the User Task.")))


;;; =========================================================
;;; ====================== VariableProperty
;;; =========================================================
(def-mm-stereotype |VariableProperty| (:BPMN-P) (|BPMNProperty|)
 ""
  ((|base_Class| :range UML23:|Class| :multiplicity (1 1))
   (|base_Variable| :range UML23:|Variable| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== conditional_false
;;; =========================================================
(def-mm-stereotype |conditional_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== conditional_true
;;; =========================================================
(def-mm-stereotype |conditional_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== escalation_false
;;; =========================================================
(def-mm-stereotype |escalation_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== escalation_true
;;; =========================================================
(def-mm-stereotype |escalation_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== is_collection_false
;;; =========================================================
(def-mm-stereotype |is_collection_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== is_collection_true
;;; =========================================================
(def-mm-stereotype |is_collection_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== message_false
;;; =========================================================
(def-mm-stereotype |message_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== message_true
;;; =========================================================
(def-mm-stereotype |message_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== multiple_false
;;; =========================================================
(def-mm-stereotype |multiple_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== multiple_true
;;; =========================================================
(def-mm-stereotype |multiple_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== parrallelMultiple_false
;;; =========================================================
(def-mm-stereotype |parrallelMultiple_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== parrallelMultiple_true
;;; =========================================================
(def-mm-stereotype |parrallelMultiple_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== signal_false
;;; =========================================================
(def-mm-stereotype |signal_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== signal_true
;;; =========================================================
(def-mm-stereotype |signal_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_conditional_false
;;; =========================================================
(def-mm-stereotype |start_conditional_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_conditional_true
;;; =========================================================
(def-mm-stereotype |start_conditional_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_escalation_false
;;; =========================================================
(def-mm-stereotype |start_escalation_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_escalation_true
;;; =========================================================
(def-mm-stereotype |start_escalation_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_message_false
;;; =========================================================
(def-mm-stereotype |start_message_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_message_true
;;; =========================================================
(def-mm-stereotype |start_message_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_multiple_false
;;; =========================================================
(def-mm-stereotype |start_multiple_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_multiple_true
;;; =========================================================
(def-mm-stereotype |start_multiple_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_parallelMultiple_false
;;; =========================================================
(def-mm-stereotype |start_parallelMultiple_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_parallelMultiple_true
;;; =========================================================
(def-mm-stereotype |start_parallelMultiple_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_signal_false
;;; =========================================================
(def-mm-stereotype |start_signal_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_signal_true
;;; =========================================================
(def-mm-stereotype |start_signal_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_timer_false
;;; =========================================================
(def-mm-stereotype |start_timer_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== start_timer_true
;;; =========================================================
(def-mm-stereotype |start_timer_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== timer_false
;;; =========================================================
(def-mm-stereotype |timer_false| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== timer_true
;;; =========================================================
(def-mm-stereotype |timer_true| (:BPMN-P) NIL
 ""
  ((|base_EnumerationLiteral| :range UML23:|EnumerationLiteral| :multiplicity (1 1))))


(in-package :mofi)


(with-slots (mofi::abstract-classes) mofi:*model*
     (setf mofi::abstract-classes 
        `(BPMN-P::|BPMNActivity|
          BPMN-P::|BPMNArtifact|
          BPMN-P::|BPMNProperty|
          BPMN-P::|BaseElement|
          BPMN-P::|BoundaryEvent|
          BPMN-P::|CallableElement|
          BPMN-P::|CancelEventDefinition|
          BPMN-P::|CatchEvent|
          BPMN-P::|ChoreographyActivity|
          BPMN-P::|CompenstationEventDefinition|
          BPMN-P::|ConditionalEventDefinition|
          BPMN-P::|ConversationNode|
          BPMN-P::|EndEvent|
          BPMN-P::|ErrorEventDefinition|
          BPMN-P::|EscalationEventDefinition|
          BPMN-P::|Event|
          BPMN-P::|EventDefinition|
          BPMN-P::|FlowElement|
          BPMN-P::|FlowNode|
          BPMN-P::|Gateway|
          BPMN-P::|InteractionNode|
          BPMN-P::|IntermediateCatchEvent|
          BPMN-P::|IntermediateThrowEvent|
          BPMN-P::|LinkEventDefinition|
          BPMN-P::|MessageEventDefinition|
          BPMN-P::|MessageFlowNode|
          BPMN-P::|Relationship|
          BPMN-P::|RootElement|
          BPMN-P::|SignalEventDefinition|
          BPMN-P::|StartEvent|
          BPMN-P::|TerminateEventDefinition|
          BPMN-P::|ThrowEvent|
          BPMN-P::|TimerEventDefinition|)))