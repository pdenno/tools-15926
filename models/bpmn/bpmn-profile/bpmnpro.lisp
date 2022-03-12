;;; Automatically created by pop-gen at 2012-01-28 09:07:28.
;;; Source file is cleanup-10i.xml

(in-package :BPMNPRO)




;;; =========================================================
;;; ====================== AdHocSubProcess
;;; =========================================================
(def-mm-stereotype |AdHocSubProcess| (:BPMNPRO) (|SubProcess|) (UML241:|StructuredActivityNode|) 
 "An Ad-Hoc Sub-Process is a specialized type of Sub-Process that is a group
  of Activities that have no required sequence relationships. A set of activities
  can be defined for the Process, but the sequence and number of performances
  for the Activities is determined by the performers of the Activities."
  ((|cancelRemainingInstances| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "This attribute is used only if ordering is parallel. It determines whether
      running instances are cancelled when the completionCondition becomes true.")
   (|completionCondition| :range |BPMNExpression| :multiplicity (1 1)
    :documentation
     "This Expression defines the conditions when the Process will end. When
      the Expression is evaluated to True, the Process will be terminated.")
   (|ordering| :range |AdHocOrdering| :multiplicity (1 1) :default :parallel)))


;;; =========================================================
;;; ====================== Assignment
;;; =========================================================
(def-mm-stereotype |Assignment| (:BPMNPRO) NIL (UML241:|Dependency|) 
 "The Assignment class is used to specify a simple mapping of data elements
  using a specified expression language. The default expression language
  for all expressions is specified in the Definitions element, using the
  expressionLanguage attribute. It can also be overridden on each individual
  Assignment using the same attribute."
  ((|language| :range |String| :multiplicity (1 1)
    :documentation
     "When included, this will override the Expression language specified in
      the Definitions.")))


;;; =========================================================
;;; ====================== Auditing
;;; =========================================================
(def-mm-stereotype |Auditing| (:BPMNPRO) (|BaseElement|) (UML241:|Class|) 
 "The Auditing element and its model associations allow defining attributes
  related to auditing. It leverages the BPMN extensibility mechanism. This
  element is used by FlowElements and Process. The actual definition of auditing
  attributes is out of scope of this specification. BPMN 2.0 implementations
  may define their own set of attributes and their intended semantics."
  ())


;;; =========================================================
;;; ====================== BPMNActivity
;;; =========================================================
(def-mm-stereotype |BPMNActivity| (:BPMNPRO) (|FlowNode| |InteractionNode|) (UML241:|Action|) 
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
  ((|/loopCharacteristics| :range UML241:|StructuredActivityNode| :multiplicity (1 1))
   (|activityClass| :range UML241:|Class| :multiplicity (0 1) :is-composite-p T)
   (|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T :is-derived-p T)
   (|boundaryEventsRefs| :range |BoundaryEvent| :multiplicity (0 -1) :is-derived-p T)
   (|completionQuantity| :range |Integer| :multiplicity (1 1) :default 1
    :documentation
     "The default value is 1. The value MUST NOT be less than 1. This attribute
      defines the number of tokens that must be generated from the Activity.
      This number of tokens will be sent done any outgoing Sequence Flow (assuming
      any Sequence Flow Conditions are satisfied). Note that any value for the
      attribute that is greater than 1 is an advanced type of modeling and should
      be used with caution.")
   (|container| :range UML241:|RedefinableElement| :multiplicity (1 1) :is-derived-p T)
   (|dataInputAssociations| :range |DataInputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|dataOutputAssociations| :range |DataOutputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|default| :range |SequenceFlow| :multiplicity (0 1) :is-derived-p T)
   (|isForCompensation| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A flag that identifies whether this activity is intended for the purposes
      of compensation. If false, then this activity executes as a result of normal
      execution flow. If true, this activity is only activated when a Compensation
      Event is detected and initiated under Compensation Event visibility scope.")
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T :is-derived-p T)
   (|properties| :range |BPMNProperty| :multiplicity (0 -1) :is-derived-p T)
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-derived-p T)
   (|startQuantity| :range |Integer| :multiplicity (1 1) :default 1
    :documentation
     "The default value is 1. The value MUST NOT be less than 1. This attribute
      defines the number of tokens that must arrive before the Activity can begin.
      Note that any value for the attribute that is greater than 1 is an advanced
      type of modeling and should be used with caution.")))


;;; =========================================================
;;; ====================== BPMNArtifact
;;; =========================================================
(def-mm-stereotype |BPMNArtifact| (:BPMNPRO) (|BaseElement|) NIL 
 ""
  ())


;;; =========================================================
;;; ====================== BPMNAssociation
;;; =========================================================
(def-mm-stereotype |BPMNAssociation| (:BPMNPRO) (#|pod|BaseElement||# |BPMNArtifact|) (UML241:|Dependency|) 
 "An Association is used to associate information and Artifacts with Flow
  Objects. Text and graphical non-Flow Objects can be associated with the
  Flow Objects and Flow. An Association is also used to show the Activity
  used for compensation. An Association is used to connect user-defined text
  (an Annotation) with a Flow Object"
  ((|associationDirection| :range |AssociationDirection| :multiplicity (1 1) :default :none
    :documentation
     "associationDirection is an attribute that defines whether or not the Association
      shows any directionality with an arrowhead. The default is None (no arrowhead).
      A value of One means that the arrowhead SHALL be at the Target Object.
      A value of Both means that there SHALL be an arrowhead at both ends of
      the Association line.")))


;;; =========================================================
;;; ====================== BPMNCollaboration
;;; =========================================================
(def-mm-stereotype |BPMNCollaboration| (:BPMNPRO) (|RootElement|) (UML241:|Collaboration|) 
 "Collaborations is a collection of Participants shown as Pools, their interactions
  as shown by Message Flow, and may include Processes within the Pools and/or
  Choreographies between the Pools."
  ((|artifacts| :range |BPMNArtifact| :multiplicity (0 -1) :is-composite-p T)
   (|conversations| :range |ConversationNode| :multiplicity (0 -1) :is-composite-p T)
   (|correlationKeys| :range |CorrelationKey| :multiplicity (0 -1) :is-composite-p T)
   (|isClosed| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A Boolean value specifying whether Message Flow not modeled in the Collaboration
      can occur when the Collaboration is carried out. If the value is true,
      they MAY NOT occur. If the value is false, they MAY occur.")
   (|messageFlowAssociations| :range |MessageFlowAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|messageFlows| :range |MessageFlow| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "This provides the list of Message Flow that are used in the InteractionSpecification")
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|participants| :range |Participant| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :documentation
     "This provides the list of Participants that are used in the InteractionSpecification")))


;;; =========================================================
;;; ====================== BPMNDocumentation
;;; =========================================================
(def-mm-stereotype |BPMNDocumentation| (:BPMNPRO) (|BaseElement|) (UML241:|Comment|) 
 ""
  ((|textFormat| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BPMNEvent
;;; =========================================================
(def-mm-stereotype |BPMNEvent| (:BPMNPRO) (|FlowNode| |InteractionNode|) (UML241:|ActivityNode|) 
 ""
  ((|eventClass| :range UML241:|Class| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== BPMNExpression
;;; =========================================================
(def-mm-stereotype |BPMNExpression| (:BPMNPRO) (|BaseElement|) (UML241:|OpaqueExpression|) 
 "The Expression class is used to specify an Expression using natural-language
  text. These Expressions are not executable and are considered underspecified.
  The definition of an Expression can be done in two ways: it can be contained
  where it is used, or it can be defined at the Process level and then referenced
  where it is used."
  ())


;;; =========================================================
;;; ====================== BPMNExtension
;;; =========================================================
(def-mm-stereotype |BPMNExtension| (:BPMNPRO) NIL (UML241:|Stereotype|) 
 ""
  ((|mustUnderstand| :range |Boolean| :multiplicity (0 1) :default :false)))


;;; =========================================================
;;; ====================== BPMNInterface
;;; =========================================================
(def-mm-stereotype |BPMNInterface| (:BPMNPRO) (|RootElement|) (UML241:|Interface|) 
 "An Interface defines a set of operations that are implemented by Services."
  ((|callableElements| :range |CallableElement| :multiplicity (0 -1) :is-derived-p T)
   (|implementationRef| :range UML241:|Element| :multiplicity (0 1))
   (|operations| :range |BPMNOperation| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== BPMNMessage
;;; =========================================================
(def-mm-stereotype |BPMNMessage| (:BPMNPRO) (|ItemDefinition|) (UML241:|Class|) 
 "A Message is used to depict the content of a communication between two
  Participants represented as Pools. In a Collaboration, the communication
  itself is represented by a Message Flow. In a Choreography, the communication
  is represented by a Choreography Task. The StructureDefinition is used
  to specify the Message structure."
  ((|itemRef| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T
    :documentation
     "An ItemDefinition is used to define the  payload  of the Message.")))


;;; =========================================================
;;; ====================== BPMNOperation
;;; =========================================================
(def-mm-stereotype |BPMNOperation| (:BPMNPRO) (|BaseElement|) (UML241:|Operation|) 
 "An Operation defines Messages that are consumed and, optionally, produced
  when the Operation is called. It can also define zero or more errors that
  are returned when operation fails."
  ((|errorRefs| :range |Error| :multiplicity (1 -1) :is-derived-p T)
   (|implementationRef| :range UML241:|Element| :multiplicity (0 1))
   (|inMessageRef| :range |BPMNMessage| :multiplicity (1 1) :is-derived-p T
    :documentation
     "This attribute specifies the input Message of the Operation. An Operation
      has exactly one input Message.")
   (|outMessageRef| :range |BPMNMessage| :multiplicity (0 1) :is-derived-p T
    :documentation
     "This attribute specifies the output Message of the Operation. An Operation
      has at most one input Message.")))


;;; =========================================================
;;; ====================== BPMNProcess
;;; =========================================================
(def-mm-stereotype |BPMNProcess| (:BPMNPRO) (#|pod|BaseElement||# |CallableElement| |FlowElementsContainer|) (UML241:|Activity|) 
 "A Process describes a sequence or flow of Activities in an enterprise with
  the objective of carrying work. In BPMN a Process is depicted as a graph
  of Flow Elements, which are a set of Activities, Events, Gateways and Sequence
  Flow that define finite execution semantics. Processes may be defined at
  any level from enterprise-wide Processes to Processes performed by a single
  person. Low-level Processes may be grouped together to achieve a common
  business goal. Note that BPMN uses the term Process specifically to mean
  a set of flow elements. It uses the terms Collaboration and Choreography
  when modeling the interaction between Processes. A Process is a CallableElement,
  allowing it to be referenced and reused by other Processes via the Call
  Activity construct. In this capacity, a Process may reference a set of
  Interfaces that define its external behavior. A Process is a reusable element
  and can be imported and used within other Definitions. BPMN processes can
  have properties, which would be UML properties on UML::Activities. A difference
  is BPMN Data Associations can flow values in/out of process properties,
  whereas UML Object Flows can't (nor to UML Activity Variables or Parameters).
  It would be a stretch to extend Object Flow to these, so I think all we
  can do it say BPMN process properties must be UML parameters if they are
  to be accessible to the caller. BPMN properties aren't the same as UML
  pins."
  ((|artifacts| :range |BPMNArtifact| :multiplicity (0 -1) :is-composite-p T)
   (|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|correlationSubscriptions| :range |CorrelationSubscription| :multiplicity (0 -1) :is-composite-p T)
   (|definitionalCollaborationRef| :range |BPMNCollaboration| :multiplicity (0 1)
    :documentation
     "For Processes that interact with other Participants, a definitional Collaboration
      can be referenced by the Process. The definitional Collaboration specifies
      the Participants the Process interacts with, and more specifically, which
      individual service, Send or Receive Task, or Message Event, is connected
      to which Participant through Message Flows. The definitional Collaboration
      need not be displayed. Additionally, the definitional Collaboration can
      be used to include Conversation information within a Process.")
   (|flowElements| :range UML241:|RedefinableElement| :multiplicity (1 1) :is-derived-p T)
   (|isClosed| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A Boolean value specifying whether interactions, such as sending and receiving
      Messages and Events, not modeled in the Process can occur when the Process
      is executed or performed. If the value is true, they MAY NOT occur. If
      the value is false, they MAY occur.")
   (|isExecutable| :range |Boolean| :multiplicity (0 1))
   (|laneSets| :range |LaneSet| :multiplicity (0 -1) :is-derived-p T)
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)
   (|processType| :range |ProcessType| :multiplicity (1 1) :default :none
    :documentation
     "The processType attribute Provides additional information about the level
      of abstraction modeled by this Process. A public Process shows only those
      flow elements that are relevant to external consumers. Internal details
      are not modeled. These Processes are publicly visible and can be used within
      a Collaboration. Note that the public processType was named abstract in
      BPMN 1.2. The BPMN 1.2 processType private has been divided into two (2)
      types: - An executable Process is a private Process that has been modeled
      for the purpose of being executed. Of course, during the development cycle
      of the Process, there will be stages where the Process does not have enough
      detail to be  executable.  - A non-executable Process is a private Process
      that has been modeled for the purpose of documenting Process behavior at
      a modeler-defined level of detail. Thus, information required for execution,
      such as formal condition expressions are typically not included in a non-executable
      Process. By default, the processType is  none , meaning undefined.")
   (|properties| :range |BPMNProperty| :multiplicity (0 -1) :is-derived-p T)
   (|supports| :range |BPMNProcess| :multiplicity (0 -1) :is-derived-p T
    :documentation
     "Modelers can declare that they intend all executions or performances of
      one Process to also be valid for another Process. This means they expect
      all the executions or performances of the first Processes to also follow
      the steps laid out in the second Process.")))


;;; =========================================================
;;; ====================== BPMNProperty
;;; =========================================================
(def-mm-stereotype |BPMNProperty| (:BPMNPRO) (|ItemAwareElement|) (UML241:|Property|) 
 "Properties, like Data Objects, are item-aware elements. But, unlike Data
  Objects, they are not visible within a Process diagram. Certain flow elements
  may contain properties, in particular only Processes, Activities and Events
  may contain Properties The Property class is a DataElement element that
  acts as a container for data associated with flow elements. Property elements
  must be contained within a FlowElement. Property elements are NOT visible
  in a Process diagram."
  ())


;;; =========================================================
;;; ====================== BPMNSignal
;;; =========================================================
(def-mm-stereotype |BPMNSignal| (:BPMNPRO) (|ItemDefinition|) (UML241:|Class|) 
 ""
  ())


;;; =========================================================
;;; ====================== BaseElement
;;; =========================================================
(def-mm-stereotype |BaseElement| (:BPMNPRO) NIL (UML241:|Element|) 
 "BaseElement is the abstract super class for most BPMN elements. It provides
  the attributes id and documentation, which other elements will inherit."
  ((|extensionValues| :range |ExtensionAttributeValue| :multiplicity (0 -1) :is-composite-p T)
   (|id| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== BoundaryEvent
;;; =========================================================
(def-mm-stereotype |BoundaryEvent| (:BPMNPRO) (|CatchEvent|) (UML241:|AcceptEventAction|) 
 ""
  ((|attachedToRef| :range |BPMNActivity| :multiplicity (1 1) :is-derived-p T)
   (|cancelActivity| :range |Boolean| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BusinessRuleTask
;;; =========================================================
(def-mm-stereotype |BusinessRuleTask| (:BPMNPRO) (|Task|) (UML241:|OpaqueAction|) 
 "A Business Rule Task provides a mechanism for the Process to provide input
  to a Business Rules Engine and to get the output of calculations that the
  Business Rules Engine might provide. The InputOutputSpecification of the
  Task will allow the Process to send data to and receive data from the Business
  Rules Engine."
  ((|implementation| :range |String| :multiplicity (1 1) :is-derived-p T :default :##unspecified)))


;;; =========================================================
;;; ====================== CallActivity
;;; =========================================================
(def-mm-stereotype |CallActivity| (:BPMNPRO) (|BPMNActivity|) (UML241:|CallBehaviorAction|) 
 "A Call Activity identifies a point in the Process where a global Process
  or a Global Task is used. The Call Activity acts as a  wrapper  for the
  invocation of a global Process or Global Task within the execution. The
  activation of a call Activity results in the transfer of control to the
  called global Process or Global Task. The BPMN 2.0 Call Activity corresponds
  to the Reusable Sub-Process of BPMN 1.2. A BPMN 2.0 Sub-Process corresponds
  to the Embedded Sub-Process of BPMN 1.2. The properties of BPMN Activities
  override the properties of the CallableElement they invoke, presumably
  matched by name."
  ((|calledElement| :range |CallableElement| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== CallConversation
;;; =========================================================
(def-mm-stereotype |CallConversation| (:BPMNPRO) (|ConversationNode|) (UML241:|CollaborationUse|) 
 "A Call Conversation identifies a place in the Conversation where a global
  Conversation or a GlobalCommunication is used."
  ((| collaborationUse| :range UML241:|CollaborationUse| :multiplicity (1 1))
   (|calledCollaborationRef| :range |BPMNCollaboration| :multiplicity (0 1) :is-derived-p T)
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== CallableElement
;;; =========================================================
(def-mm-stereotype |CallableElement| (:BPMNPRO) (|RootElement|) (UML241:|Behavior|) 
 ""
  ((|ioSpecification| :range |InputOutputSpecification| :multiplicity (0 1))
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T :is-derived-p T)
   (|supportedInterfacesRefs| :range |BPMNInterface| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== CancelEventDefinition
;;; =========================================================
(def-mm-stereotype |CancelEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 "Cancel Events are only used in the context of modeling Transaction Sub-Processes."
  ())


;;; =========================================================
;;; ====================== CatchEvent
;;; =========================================================
(def-mm-stereotype |CatchEvent| (:BPMNPRO) (#|pod|BaseElement||# |BPMNEvent|) (UML241:|AcceptEventAction| UML241:|InitialNode|) 
 ""
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|eventDefinitions| :range |EventDefinition| :multiplicity (0 -1) :is-composite-p T)
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)
   (|outputSet| :range |OutputSet| :multiplicity (0 1) :is-composite-p T)
   (|parallelMultiple| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== Category
;;; =========================================================
(def-mm-stereotype |Category| (:BPMNPRO) (|RootElement|) (UML241:|Enumeration|) 
 ""
  ())


;;; =========================================================
;;; ====================== CategoryValue
;;; =========================================================
(def-mm-stereotype |CategoryValue| (:BPMNPRO) (|BaseElement|) (UML241:|EnumerationLiteral|) 
 ""
  ((|categorizedFlowElements| :range |FlowElement| :multiplicity (0 -1) :is-derived-p T
    :opposite (|FlowElement| | categoryValueRef|))))


;;; =========================================================
;;; ====================== CompensateEventDefinition
;;; =========================================================
(def-mm-stereotype |CompensateEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 "Compensation Events are used in the context of triggering or handling compensation."
  ((|activityRef| :range |BPMNActivity| :multiplicity (0 1)
    :documentation
     "For a Start Event: This Event  catches  the compensation for an Event Sub-Process.
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
      level). This  throws  the compensation. For an Intermediate Event attached
      to the boundary of an Activity: This Event  catches  the compensation.
      No further information is required. The Activity the Event is attached
      to will provide the Id necessary to match the Compensation Event with the
      Event that threw the compensation, or the compensation will have been a
      broadcast.")
   (|waitForCompletion| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a throw Compensation Event, this flag determines whether the throw
      Intermediate Event waits for the triggered compensation to complete (the
      default), or just triggers the compensation and immediately continues")))


;;; =========================================================
;;; ====================== CompensationEndEvent
;;; =========================================================
(def-mm-stereotype |CompensationEndEvent| (:BPMNPRO) (|EndEvent|) (UML241:|ActivityFinalNode| UML241:|FlowFinalNode|) 
 ""
  ((|eventDefinitionRefs| :range |CompensateEventDefinition| :multiplicity (0 -1))
   (|eventDefinitions| :range |CompensateEventDefinition| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== ComplexBehaviorDefinition
;;; =========================================================
(def-mm-stereotype |ComplexBehaviorDefinition| (:BPMNPRO) (|BaseElement|) (UML241:|ExpansionRegion|) 
 ""
  ())


;;; =========================================================
;;; ====================== ComplexGateway
;;; =========================================================
(def-mm-stereotype |ComplexGateway| (:BPMNPRO) (#|pod|BaseElement||# |NonExclusiveGateway|) NIL 
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
  ((|activationCondition| :range |BPMNExpression| :multiplicity (0 1) :is-derived-p T)
   (|default| :range |SequenceFlow| :multiplicity (0 1) :is-derived-p T
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")))


;;; =========================================================
;;; ====================== ConditionalEventDefinition
;;; =========================================================
(def-mm-stereotype |ConditionalEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|ChangeEvent|) 
 ""
  ((|condition| :range |BPMNExpression| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Conversation
;;; =========================================================
(def-mm-stereotype |Conversation| (:BPMNPRO) (|ConversationNode|) (UML241:|InformationFlow|) 
 "A Communication is an atomic element for a Conversation diagram. It represents
  a set of Message Flow grouped together based on a single CorrelationKey.
  A Communication will involve two (2) or more Participants."
  ())


;;; =========================================================
;;; ====================== ConversationLink
;;; =========================================================
(def-mm-stereotype |ConversationLink| (:BPMNPRO) (|BaseElement|) (UML241:|Element|) 
 ""
  ((| targetRef| :range |InteractionNode| :multiplicity (1 1)
    :opposite (|InteractionNode| |incomingConversationLinks|))))


;;; =========================================================
;;; ====================== ConversationNode
;;; =========================================================
(def-mm-stereotype |ConversationNode| (:BPMNPRO) (|InteractionNode|) (UML241:|InformationFlow|) 
 ""
  ((|correlationKeys| :range |CorrelationKey| :multiplicity (0 -1) :is-composite-p T)
   (|messageFlowRefs| :range |MessageFlow| :multiplicity (0 -1))
   (|participantRefs| :range |Participant| :multiplicity (2 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== CorrelationKey
;;; =========================================================
(def-mm-stereotype |CorrelationKey| (:BPMNPRO) (|BaseElement|) (UML241:|Class|) 
 ""
  ())


;;; =========================================================
;;; ====================== CorrelationProperty
;;; =========================================================
(def-mm-stereotype |CorrelationProperty| (:BPMNPRO) (|BaseElement|) (UML241:|Property|) 
 ""
  ())


;;; =========================================================
;;; ====================== CorrelationPropertyBinding
;;; =========================================================
(def-mm-stereotype |CorrelationPropertyBinding| (:BPMNPRO) (|BaseElement|) (UML241:|Property|) 
 ""
  ((|dataPath| :range |FormalExpression| :multiplicity (1 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== CorrelationPropertyRetrievalExpresson
;;; =========================================================
(def-mm-stereotype |CorrelationPropertyRetrievalExpresson| (:BPMNPRO) (|BaseElement|) (UML241:|Property|) 
 ""
  ((|messagePath| :range |FormalExpression| :multiplicity (1 1) :is-composite-p T)
   (|messageRef| :range |BPMNMessage| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CorrelationSubscription
;;; =========================================================
(def-mm-stereotype |CorrelationSubscription| (:BPMNPRO) (|BaseElement|) (UML241:|Class|) 
 ""
  ())


;;; =========================================================
;;; ====================== DataAssociation
;;; =========================================================
(def-mm-stereotype |DataAssociation| (:BPMNPRO) (|BaseElement|) (UML241:|ObjectFlow|) 
 "The DataAssociation class is a BaseElement contained by an Activity or
  Event, used to model how data is pushed into or pulled from item-aware
  elements. DataAssociation elements have one or more sources and a target;
  the source of the association is copied into the target. The ItemDefinition
  from the souceRef and targetRef must have the same ItemDefinition or the
  DataAssociation MUST have a transformation Expression that transforms the
  source ItemDefinition into the target ItemDefinition. DataAssociation based
  on ObjectFlow does not mean UML:Actions own ObjectFlows the way BPMN:Activities
  own them DataAssociations. The source / target of DataAssociation on the
  UML::Action end will be a UML::Pin. BPMN's model is similar to UML pins,
  because the InputOutputSpecification of a CallableElement must be a direct
  copy of the one on the callable element, including the IO sets and Data
  IOs. BPMN doesn't notate the pins or support queuing on them, of course."
  ((|assignment| :range |Assignment| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "Specifies one or more data elements Assignments. By using an Assignment,
      single data structure elements can be assigned from the source structure
      to the target structure.")
   (|transformation| :range |FormalExpression| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== DataInput
;;; =========================================================
(def-mm-stereotype |DataInput| (:BPMNPRO) (|ItemAwareElement|) (UML241:|InputPin| UML241:|Parameter|) 
 "A DataInput is a declaration that a particular kind of data will be used
  as input of the InputOutputSpecification. There may be multiple data inputs
  associated with an InputOutputSpecification. The DataInput is an item-aware
  element. DataInput elements may appear in a Process diagram to show the
  inputs to the Process as whole, which are passed along as the inputs of
  Activities by DataAssociations."
  ((|inputSetRefs| :range |InputSet| :multiplicity (0 -1) :is-ordered-p T :is-derived-p T
    :opposite (|InputSet| |dataInputRefs|))
   (|inputSetWithOptional| :range |InputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|InputSet| |optionalInputRefs|))
   (|inputSetWithWhileExecuting| :range |InputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|InputSet| |whileExecutingInputRefs|))
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)
   (|itemSubjectRef| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== DataInputAssociation
;;; =========================================================
(def-mm-stereotype |DataInputAssociation| (:BPMNPRO) (|DataAssociation|) NIL 
 "The DataInputAssociation can be used to associate a item-aware element
  with a DataInput contained in an Activity. The source of such a DataAssociation
  can be every item-aware element visible to the current scope, e.g. a Data
  Object, a Property or an Expression."
  ())


;;; =========================================================
;;; ====================== DataObject
;;; =========================================================
(def-mm-stereotype |DataObject| (:BPMNPRO) (|ItemAwareElement| |FlowElement|) (UML241:|DataStoreNode|) 
 "The DataObject class is an item-aware element. Data Object elements must
  be contained within Process or Sub-Process elements. Data Object elements
  are visible in a Process diagram."
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Defines if the Data Object represents a collection of elements. This is
      a projection of the same attribute of the referenced ItemDefinition.")
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== DataObjectRef
;;; =========================================================
(def-mm-stereotype |DataObjectRef| (:BPMNPRO) (|ItemAwareElement| |FlowElement|) (UML241:|Class| UML241:|DataStoreNode|) 
 ""
  ((|dataObjectRef| :range |DataObject| :multiplicity (1 1))
   (|dataState| :range UML241:|State| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== DataOutput
;;; =========================================================
(def-mm-stereotype |DataOutput| (:BPMNPRO) (|ItemAwareElement|) (UML241:|OutputPin| UML241:|Parameter|) 
 ""
  ((|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)
   (|itemSubjectRef| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T)
   (|outputSetRefs| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |dataOutputRefs|))
   (|outputSetWithOptional| :range |OutputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|OutputSet| |optionalOutputRefs|))
   (|outputSetWithWhileExecuting| :range |OutputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|OutputSet| |whileExecutingOutputRefs|))))


;;; =========================================================
;;; ====================== DataOutputAssociation
;;; =========================================================
(def-mm-stereotype |DataOutputAssociation| (:BPMNPRO) (|DataAssociation|) NIL 
 "The DataOutputAssociation can be used to associate a DataOutput contained
  within an ACTIVITY with any item-aware element visible to the scope the
  association will be executed in. The target of such a DataAssociation can
  be every item-aware element visible to the current scope, e.g. a Data Object,
  a Property or an Expression."
  ())


;;; =========================================================
;;; ====================== DataState
;;; =========================================================
(def-mm-stereotype |DataState| (:BPMNPRO) (|BaseElement|) (UML241:|State|) 
 ""
  ())


;;; =========================================================
;;; ====================== DataStore
;;; =========================================================
(def-mm-stereotype |DataStore| (:BPMNPRO) (|ItemAwareElement| #|pod|BaseElement||#) (UML241:|CentralBufferNode|) 
 "A DataStore provides a mechanism for Activities to retrieve or update stored
  information that will persist beyond the scope of the Process. The same
  DataStore can be visualized, through a Data Store Reference, in one (1)
  or more places in the Process. The Data Store Reference is an ItemAwareElement
  and can thus be used as the source or target for a Data Association. When
  data flows into or out of a Data Store Reference, it is effectively flowing
  into or out of the DataStore that is being referenced."
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|capacity| :range |Integer| :multiplicity (0 1)
    :documentation
     "Defines the capacity of the Data Store. This is not needed if the isUnlimited
      attribute is set to true.")
   (|isUnlimited| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isUnlimited is set to true, then the capacity of a Data Store is set
      as unlimited and will override any value of the capacity attribute.")
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Deferred
;;; =========================================================
(def-mm-stereotype |Deferred| (:BPMNPRO) NIL (UML241:|EnumerationLiteral|) 
 ""
  ())


;;; =========================================================
;;; ====================== Definitions
;;; =========================================================
(def-mm-stereotype |Definitions| (:BPMNPRO) (|BaseElement|) (UML241:|Package|) 
 "The Definitions class is the outermost containing object for all BPMN elements.
  It defines the scope of visibility and the namespace for all contained
  elements. The interchange of BPMN files will always be through one or more
  Definitions."
  ((|exporter| :range |String| :multiplicity (0 1)
    :documentation
     "This attribute identifies the tool that is exporting the bpmn model file.")
   (|exporterVersion| :range |String| :multiplicity (0 1)
    :documentation
     "This attribute identifies the version of the tool that is exporting the
      bpmn model file.")
   (|expressionLanguage| :range |String| :multiplicity (0 1)
    :documentation
     "This attribute identifies the formal Expression language used in Expressions
      within the elements of this Definition. The Default is  http://www.w3.org/1999/XPath
      . This value MAY be overridden on each individual formal Expression. The
      language MUST be specified in a URI format.")
   (|targetNamespace| :range |String| :multiplicity (1 1)
    :documentation
     "This attribute identifies the namespace associated with the Definition
      and follows the convention established by XML Schema.")
   (|typeLanguage| :range |String| :multiplicity (0 1)
    :documentation
     "This attribute identifies the type system used by the elements of this
      Definition. Defaults to http://www.w3.org/2001/XMLSchema. This value can
      be overridden on each individual ItemDefinition. The language MUST be specified
      in a URI format.")))


;;; =========================================================
;;; ====================== EndEvent
;;; =========================================================
(def-mm-stereotype |EndEvent| (:BPMNPRO) (|ThrowEvent|) (UML241:|FinalNode|) 
 "As the name implies, the End Event indicates where a Process will end.
  In terms of Sequence Flow, the End Event ends the flow of the Process,
  and thus, will not have any outgoing Sequence Flow   no Sequence Flow can
  connect from an End Event."
  ())


;;; =========================================================
;;; ====================== Error
;;; =========================================================
(def-mm-stereotype |Error| (:BPMNPRO) (|ItemDefinition|) (UML241:|Class|) 
 "An Error represents the content of an Error Event or the Fault of a failed
  Operation. An Error is generated when there is a critical problem in the
  processing of an Activity or when the execution of an Operation failed."
  ((|errorCode| :range |String| :multiplicity (0 1)
    :documentation
     "For an End Event: If the result is an Error, then the errorCode MUST be
      supplied (if the processType attribute of the Process is set to executable)
      This  throws  the Error. For an Intermediate Event within normal flow:
      If the trigger is an Error, then the errorCode MUST be entered (if the
      processType attribute of the Process is set to executable). This  throws
       the Error. For an Intermediate Event attached to the boundary of an Activity:
      If the trigger is an Error, then the errorCode MAY be entered. This Event
       catches  the Error. If there is no errorCode, then any error SHALL trigger
      the Event. If there is an errorCode, then only an Error that matches the
      errorCode SHALL trigger the Event.")
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ErrorEventDefinition
;;; =========================================================
(def-mm-stereotype |ErrorEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 ""
  ((|errorRef| :range |Error| :multiplicity (0 1)
    :documentation
     "If the Trigger is an Error, then an Error payload MAY be provided.")))


;;; =========================================================
;;; ====================== Escalation
;;; =========================================================
(def-mm-stereotype |Escalation| (:BPMNPRO) (|ItemDefinition|) (UML241:|Class|) 
 ""
  ((|escalationCode| :range |String| :multiplicity (0 1)
    :documentation
     "For an End Event: If the Result is an Escalation, then the escalationCode
      MUST be supplied (if the processType attribute of the Process is set to
      executable). This  throws  the Escalation. For an Intermediate Event within
      normal flow: If the trigger is an Escalation, then the escalationCode MUST
      be entered (if the processType attribute of the Process is set to executable).
      This  throws  the Escalation. For an Intermediate Event attached to the
      boundary of an Activity: If the trigger is an Escalation, then the escalationCode
      MAY be entered. This Event  catches  the Escalation. If there is no escalationCode,
      then any Escalation SHALL trigger the Event. If there is an escalationCode,
      then only an Escalation that matches the escalationCode SHALL trigger the
      Event.")
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== EscalationEventDefinition
;;; =========================================================
(def-mm-stereotype |EscalationEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 ""
  ((|escalationRef| :range |Escalation| :multiplicity (0 1)
    :documentation
     "If the Trigger is an Escalation, then an Escalation payload MAY be provided.")))


;;; =========================================================
;;; ====================== EventBasedGateway
;;; =========================================================
(def-mm-stereotype |EventBasedGateway| (:BPMNPRO) (|Gateway|) (UML241:|ForkNode|) 
 "The Event-Based Gateway represents a branching point in the Process where
  the alternative paths that follow the Gateway are based on Events that
  occur, rather than the evaluation of Expressions using Process data (as
  with an Exclusive or Inclusive Gateway). A specific Event, usually the
  receipt of a Message, determines the path that will be taken. Basically,
  the decision is made by another Participant, based on data that is not
  visible to Process, thus, requiring the use of the Event-Based Gateway.
  For example, if a company is waiting for a response from a customer they
  will perform one set of Activities if the customer responds  Yes  and another
  set of Activities if the customer responds  No.  The customer s response
  determines which path is taken. The identity of the Message determines
  which path is taken. That is, the  Yes  Message and the  No  Message are
  different Messages i.e., they are not the same Message with different values
  within a property of the Message. The receipt of the Message can be modeled
  with an Intermediate Event with a Message Trigger or a Receive Task. In
  addition to Messages, other Triggers for Intermediate Events can be used,
  such as Timers."
  ((|eventGatewayType| :range |EventGatewayType| :multiplicity (1 1) :default :exclusive
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
(def-mm-stereotype |EventDefinition| (:BPMNPRO) (|RootElement|) (UML241:|Event|) 
 "Event Definitions refers to the Triggers of Catch Events (Start and receive
  Intermediate Events) and the Results of Throw Events (End Events and send
  Intermediate Events). The types of Event Definitions are: CancelEventDefinition,
  CompensationEventDefinition, ConditionalEventDefinition, ErrorEventDefinition,
  EscalationEventDefinition, MessageEventDefinition, LinkEventDefinition,
  SignalEventDefinition, TerminateEventDefinition, and TimerEventDefinition.
  A None Event is determined by an Event that does not specify an Event Definition.
  A Multiple Event is determined by an Event that specifies more than one
  Event Definition. The different types of Events (Start, End, and Intermediate)
  utilize a subset of the available types of Event Definitions."
  ())


;;; =========================================================
;;; ====================== ExclusiveGateway
;;; =========================================================
(def-mm-stereotype |ExclusiveGateway| (:BPMNPRO) (|Gateway|) (UML241:|DecisionNode| UML241:|MergeNode|) 
 "A diverging Exclusive Gateway (Decision) is used to create alternative
  paths within a Process flow. This is basically the  diversion point in
  the road  for a Process. For a given instance of the Process, only one
  of the paths can be taken. A Decision can be thought of as a question that
  is asked at a particular point in the Process. The question has a defined
  set of alternative answers. Each question is associated with a condition
  expression that is associated with a Gateway s outgoing Sequence Flow."
  ((|default| :range |SequenceFlow| :multiplicity (0 1) :is-derived-p T
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")))


;;; =========================================================
;;; ====================== ExtensionAttributeDefinition
;;; =========================================================
(def-mm-stereotype |ExtensionAttributeDefinition| (:BPMNPRO) NIL (UML241:|Property|) 
 ""
  ())


;;; =========================================================
;;; ====================== ExtensionAttributeValue
;;; =========================================================
(def-mm-stereotype |ExtensionAttributeValue| (:BPMNPRO) NIL (UML241:|Slot|) 
 ""
  ((|valueRef| :range UML241:|Element| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ExtensionDefinition
;;; =========================================================
(def-mm-stereotype |ExtensionDefinition| (:BPMNPRO) NIL (UML241:|Stereotype|) 
 ""
  ())


;;; =========================================================
;;; ====================== FlowElement
;;; =========================================================
(def-mm-stereotype |FlowElement| (:BPMNPRO) (|BaseElement|) (UML241:|Element|) 
 ""
  ((| categoryValueRef| :range |CategoryValue| :multiplicity (0 -1)
    :opposite (|CategoryValue| |categorizedFlowElements|))
   (|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== FlowElementsContainer
;;; =========================================================
(def-mm-stereotype |FlowElementsContainer| (:BPMNPRO) (|BaseElement|) (UML241:|Element|) 
 ""
  ())


;;; =========================================================
;;; ====================== FlowNode
;;; =========================================================
(def-mm-stereotype |FlowNode| (:BPMNPRO) (|FlowElement|) (UML241:|ActivityNode|) 
 ""
  ())


;;; =========================================================
;;; ====================== FormalExpression
;;; =========================================================
(def-mm-stereotype |FormalExpression| (:BPMNPRO) (#|pod|BaseElement||# |BPMNExpression|) NIL 
 "The FormalExpression class is used to specify an executable expression
  using a specified expression language. A natural-language description of
  the expression can also be specified, in addition to the formal specification."
  ((|evaluatesToTypeRef| :range |ItemDefinition| :multiplicity (1 1) :is-derived-p T
    :documentation
     "The type of object that this Expression returns when evaluated. For example,
      conditional Expressions evaluate to a boolean.")))


;;; =========================================================
;;; ====================== Gateway
;;; =========================================================
(def-mm-stereotype |Gateway| (:BPMNPRO) NIL (UML241:|ControlNode|) 
 ""
  ())


;;; =========================================================
;;; ====================== GlobalBusinessRuleTask
;;; =========================================================
(def-mm-stereotype |GlobalBusinessRuleTask| (:BPMNPRO) (|GlobalTask|) (UML241:|OpaqueBehavior|) 
 "A Business Rule Task provides a mechanism for the Process to provide input
  to a Business Rules Engine and to get the output of calculations that the
  Business Rules Engine might provide. The InputOutputSpecification of the
  Task will allow the Process to send data to and receive data from the Business
  Rules Engine."
  ((|implementation| :range |String| :multiplicity (0 -1) :is-ordered-p T :is-derived-p T :default :unspecified)))


;;; =========================================================
;;; ====================== GlobalConversation
;;; =========================================================
(def-mm-stereotype |GlobalConversation| (:BPMNPRO) (|BPMNCollaboration|) NIL 
 "A GlobalCommunication is a reusable, atomic Communication definition that
  can be called from within any Conversation by a Call Conversation."
  ())


;;; =========================================================
;;; ====================== GlobalManualTask
;;; =========================================================
(def-mm-stereotype |GlobalManualTask| (:BPMNPRO) (|GlobalTask|) (UML241:|OpaqueBehavior|) 
 "A Manual Task is a Task that is expected to be performed without the aid
  of any business process execution engine or any application. A Manual Task
  is not managed by any business process engine. It can be considered as
  an unmanaged Task, unmanaged in the sense of that the business process
  engine doesn t track the start and completion of such a Task. An example
  of this could be a paper based instruction for a telephone technician to
  install a telephone at a customer location."
  ())


;;; =========================================================
;;; ====================== GlobalScriptTask
;;; =========================================================
(def-mm-stereotype |GlobalScriptTask| (:BPMNPRO) (|GlobalTask|) (UML241:|OpaqueBehavior|) 
 "A Script Task is executed by a business process engine. The modeler or
  implementer defines a script in a language that the engine can interpret.
  When the Task is ready to start, the engine will execute the script. When
  the script is completed, the Task will also be completed."
  ((|script| :range |String| :multiplicity (1 1) :is-derived-p T)
   (|scriptFormat| :range |String| :multiplicity (0 -1) :is-ordered-p T :is-derived-p T)))


;;; =========================================================
;;; ====================== GlobalTask
;;; =========================================================
(def-mm-stereotype |GlobalTask| (:BPMNPRO) (#|pod|BaseElement||# |CallableElement|) (UML241:|OpaqueBehavior|) 
 "A Global Task is a reusable, atomic Task definition that can be called
  from within any Process by a Call Activity. There are different types of
  Tasks identified within BPMN to separate the types of inherent behavior
  that Tasks might represent. This is true for both Global Tasks and standard
  Tasks, where the list of Task types is the same for both."
  ())


;;; =========================================================
;;; ====================== GlobalUserTask
;;; =========================================================
(def-mm-stereotype |GlobalUserTask| (:BPMNPRO) (|GlobalTask|) (UML241:|OpaqueBehavior|) 
 "A User Task is a typical  workflow  Task where a human performer performs
  the Task with the assistance of a software application and is scheduled
  through a task list manager of some sort. BPMN adopters may specify task
  rendering attributes by using the BPMN Extension mechanism.."
  ((|implementation| :range |String| :multiplicity (1 1) :is-ordered-p T :is-derived-p T :default :unspecified)
   (|renderings| :range UML241:|Image| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Group
;;; =========================================================
(def-mm-stereotype |Group| (:BPMNPRO) (|BPMNArtifact|) (UML241:|ActivityPartition|) 
 "The Group object is an Artifact that provides a visual mechanism to group
  elements of a diagram informally. The grouping is tied to the Category
  supporting element (which is an attribute of all BPMN elements). That is,
  a Group is a visual depiction of a single Category. The graphical elements
  within the Group will be assigned the Category of the Group. (Note -- Categories
  can be highlighted through other mechanisms, such as color, as defined
  by a modeler or a modeling tool)."
  ((| categoryValueRef| :range |CategoryValue| :multiplicity (0 -1))
   (|categoryValue| :range |String| :multiplicity (0 1)
    :documentation
     "The categoryRef attribute specifies the Category that the Group represents.
      The name of the Category provides the label for the Group. The graphical
      elements within the boundaries of the Group will be assigned the Category.")))


;;; =========================================================
;;; ====================== HumanPerformer
;;; =========================================================
(def-mm-stereotype |HumanPerformer| (:BPMNPRO) (|Performer|) (UML241:|Property|) 
 "People can be assigned to Activities in various roles (called  generic
  human roles  in WS-HumanTask). BPMN 1.2 traditionally only has the Performer
  role. In addition to supporting the Performer role, BPMN 2.0 defines a
  specific HumanPerformer element allowing specifying more specific human
  roles as specialization of HumanPerformer, such as PotentialOwner."
  ())


;;; =========================================================
;;; ====================== ImplicitThrowEvent
;;; =========================================================
(def-mm-stereotype |ImplicitThrowEvent| (:BPMNPRO) (|ThrowEvent|) (UML241:|ActivityFinalNode| UML241:|CallOperationAction| UML241:|SendObjectAction|) 
 ""
  ())


;;; =========================================================
;;; ====================== Import
;;; =========================================================
(def-mm-stereotype |Import| (:BPMNPRO) NIL (UML241:|PackageImport|) 
 ""
  ((|importType| :range |String| :multiplicity (0 1))
   (|namespace| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== InclusiveGateway
;;; =========================================================
(def-mm-stereotype |InclusiveGateway| (:BPMNPRO) (|NonExclusiveGateway|) NIL 
 "A diverging Inclusive Gateway (Inclusive Decision) can be used to create
  alternative but also parallel paths within a Process flow. Unlike the Exclusive
  Gateway, all condition expressions are evaluated. The true evaluation of
  one condition expression does not exclude the evaluation of other condition
  expressions. All Sequence Flow with a true evaluation will be traversed
  by a Token. Since each path is considered to be independent, all combinations
  of the paths may be taken, from zero to all. However, it should be designed
  so that at least one path is taken."
  ((|default| :range |SequenceFlow| :multiplicity (0 1) :is-derived-p T
    :documentation
     "The Sequence Flow that will receive a Token when none of the conditionExpressions
      on other outgoing Sequence Flow evaluate to true. The default Sequence
      Flow should not have a conditionExpression. Any such Expression SHALL be
      ignored.")))


;;; =========================================================
;;; ====================== InputOutputSpecification
;;; =========================================================
(def-mm-stereotype |InputOutputSpecification| (:BPMNPRO) (|BaseElement|) (UML241:|Action| UML241:|Behavior| UML241:|InputPin|) 
 ""
  ((|dataInputs| :range |DataInput| :multiplicity (0 -1) :is-derived-p T)
   (|dataOutputs| :range |DataOutput| :multiplicity (0 -1) :is-derived-p T)
   (|inputSets| :range |InputSet| :multiplicity (1 -1) :is-derived-p T)
   (|outputSets| :range |OutputSet| :multiplicity (1 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== InputSet
;;; =========================================================
(def-mm-stereotype |InputSet| (:BPMNPRO) (|BaseElement|) (UML241:|ParameterSet|) 
 ""
  ((|dataInputRefs| :range |DataInput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataInput| |inputSetRefs|))
   (|optionalInputRefs| :range |DataInput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataInput| |inputSetWithOptional|))
   (|whileExecutingInputRefs| :range |DataInput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataInput| |inputSetWithWhileExecuting|))))


;;; =========================================================
;;; ====================== InteractionNode
;;; =========================================================
(def-mm-stereotype |InteractionNode| (:BPMNPRO) (|BaseElement|) NIL 
 ""
  ((|incomingConversationLinks| :range |ConversationLink| :multiplicity (0 -1) :is-derived-p T
    :opposite (|ConversationLink| | targetRef|))))


;;; =========================================================
;;; ====================== IntermediateCatchEvent
;;; =========================================================
(def-mm-stereotype |IntermediateCatchEvent| (:BPMNPRO) (|CatchEvent|) (UML241:|AcceptEventAction|) 
 ""
  ())


;;; =========================================================
;;; ====================== IntermediateThrowEvent
;;; =========================================================
(def-mm-stereotype |IntermediateThrowEvent| (:BPMNPRO) (|ThrowEvent|) (UML241:|SendObjectAction|) 
 ""
  ())


;;; =========================================================
;;; ====================== ItemAwareElement
;;; =========================================================
(def-mm-stereotype |ItemAwareElement| (:BPMNPRO) (|BaseElement|) (UML241:|Class| UML241:|TypedElement|) 
 ""
  ((|dataState| :range |DataState| :multiplicity (0 -1))))


;;; =========================================================
;;; ====================== ItemDefinition
;;; =========================================================
(def-mm-stereotype |ItemDefinition| (:BPMNPRO) (|RootElement|) (UML241:|Class|) 
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
  that in every mention of structure definition there is a  reference  to
  the element. This is why this class inherits from RootElement. An ItemDefinition
  element can specify an import reference where the proper definition of
  the structure is defined. In cases where the data structure represents
  a collection, the multiplicity can be projected into the attribute isCollection.
  If this attribute is set to  true , but the actual type is not a collection
  type, the model is considered as invalid. BPMN compliant tools might support
  an automatic check for these inconsistencies and report this as an error.
  The default value for this element is  false . The itemKind attribute specifies
  the nature of an item which can be a physical or an information item."
  ((|isCollection| :range UML241:|Element| :multiplicity (1 1) :default :false
    :documentation
     "Setting this flag to true indicates that the actual data type is a collection.")
   (|itemKind| :range |ItemKind| :multiplicity (1 1) :default :information
    :documentation
     "This defines the nature of the Item. Possible values are Physical or Information.
      The default value is Information.")
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Lane
;;; =========================================================
(def-mm-stereotype |Lane| (:BPMNPRO) (|BaseElement|) (UML241:|ActivityPartition|) 
 ""
  ((|childLaneSet| :range |Lane| :multiplicity (0 1) :is-derived-p T)
   (|flowNodeRefs| :range UML241:|ActivityNode| :multiplicity (1 1) :is-derived-p T)
   (|laneSet| :range |Lane| :multiplicity (1 1) :is-derived-p T)
   (|partitionElementRef| :range UML241:|Element| :multiplicity (0 1) :is-composite-p T :is-derived-p T)))


;;; =========================================================
;;; ====================== LaneSet
;;; =========================================================
(def-mm-stereotype |LaneSet| (:BPMNPRO) (|BaseElement|) (UML241:|ActivityPartition|) 
 ""
  ((|flowElementsContainer| :range UML241:|Element| :multiplicity (0 1) :is-derived-p T)
   (|lanes| :range |Lane| :multiplicity (0 -1) :is-derived-p T)
   (|parentLane| :range |Lane| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== LinkEventDefinition
;;; =========================================================
(def-mm-stereotype |LinkEventDefinition| (:BPMNPRO) NIL NIL 
 "A Link Event is a mechanism for connecting two sections of a Process. Link
  Events can be used to create looping situations or to avoid long Sequence
  Flow lines. The use of Link Events is limited to a single Process level
  (i.e., they cannot link a parent Process with a Sub-Process). Paired Link
  Events can also be used as  Off-Page Connectors  for printing a Process
  across multiple pages. They can also be used as generic  Go To  objects
  within the Process level. There can be multiple source Link Events, but
  there can only be one target Link Event."
  ((|source| :range |LinkEventDefinition| :multiplicity (0 -1)
    :opposite (|LinkEventDefinition| |target|))
   (|target| :range |LinkEventDefinition| :multiplicity (0 1)
    :opposite (|LinkEventDefinition| |source|))))


;;; =========================================================
;;; ====================== LoopCharacteristics
;;; =========================================================
(def-mm-stereotype |LoopCharacteristics| (:BPMNPRO) (|BaseElement|) (UML241:|StructuredActivityNode|) 
 ""
  ())


;;; =========================================================
;;; ====================== ManualTask
;;; =========================================================
(def-mm-stereotype |ManualTask| (:BPMNPRO) (|Task|) (UML241:|OpaqueAction|) 
 "A Manual Task is a Task that is expected to be performed without the aid
  of any business process execution engine or any application. A Manual Task
  is not managed by any business process engine. It can be considered as
  an unmanaged Task, unmanaged in the sense of that the business process
  engine doesn t track the start and completion of such a Task. An example
  of this could be a paper based instruction for a telephone technician to
  install a telephone at a customer location."
  ())


;;; =========================================================
;;; ====================== MessageEventDefinition
;;; =========================================================
(def-mm-stereotype |MessageEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 ""
  ((|messageRef| :range |BPMNMessage| :multiplicity (0 1)
    :documentation
     "The Message MUST be supplied (if the processType attribute of the Process
      is set to executable).")
   (|operationRef| :range |BPMNOperation| :multiplicity (0 1)
    :documentation
     "This attribute specifies the operation that is used by the Message Event.
      It MUST be specified for executable Processes.")))


;;; =========================================================
;;; ====================== MessageFlow
;;; =========================================================
(def-mm-stereotype |MessageFlow| (:BPMNPRO) (|BaseElement|) (#|podUML241::| InformationFlow||# UML241:|InformationFlow|) 
 "A Message Flow is used to show the flow of Messages between two Participants
  that are prepared to send and receive them. A Message Flow MUST connect
  two separate Pools. They connect either to the Pool boundary or to Flow
  Objects within the Pool boundary. BPMN Message Flows based on UML Information
  Flows. Extended with nested path for tasks in same process called multiple
  times in same process, or same processes in multiple processes."
  ((|messageRef| :range |BPMNMessage| :multiplicity (0 1) :is-derived-p T)
   (|sourceRef| :range UML241:|Element| :multiplicity (1 1) :is-derived-p T)
   (|targetRef| :range UML241:|Element| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== MessageFlowAssociation
;;; =========================================================
(def-mm-stereotype |MessageFlowAssociation| (:BPMNPRO) (|BaseElement|) (UML241:|Dependency|) 
 "<p> These elements are used to do mapping between two elements
  that both contain Message Flow. The </p> <p> MessageFlowAssociation provides
  the mechanism to match up the Message Flow. </p> <p> A MessageFlowAssociation
  is used when an (outer) diagram with Message Flow contains an (inner) </p>
  <p> diagram that also has Message Flow. There are three (3) usages of MessageFlowAssociation.
  It is </p> <p> used when: </p> <ul> <li> A Collaboration references a Choreography
  for inclusion between the Collaboration s Pools (Participants). The Message
  Flow of the Choreography (the inner diagram) need to be mapped to the Message
  Flow of the Collaboration (the outer diagram). </li> <li> A Collaboration
  references a Conversation that contains Message Flow. The Message Flow
  of the Conversation may serve as a partial requirement for the Collaboration.
  Thus, the Message Flow of the Conversation (the inner diagram) need to
  be mapped to the Message Flow of the Collaboration (the outer diagram).
  </li> <li> A Choreography references a Conversation that contains Message
  Flow. The Message Flow of the Conversation may serve as a partial requirement
  for the Choreography. Thus, the Message Flow of the Conversation (the inner
  diagram) need to be mapped to the Message Flow of the Choreography (the
  outer diagram). </li> </ul> <p>   </p>"
  ())


;;; =========================================================
;;; ====================== Monitoring
;;; =========================================================
(def-mm-stereotype |Monitoring| (:BPMNPRO) (|BaseElement|) (UML241:|Class|) 
 ""
  ())


;;; =========================================================
;;; ====================== MultiInstanceLoopCharacteristics
;;; =========================================================
(def-mm-stereotype |MultiInstanceLoopCharacteristics| (:BPMNPRO) (|LoopCharacteristics|) (UML241:|ExpansionRegion|) 
 "The MultiInstanceLoopCharacteristics class allows for creation of a desired
  number of Activity instances. The instances may execute in parallel or
  may be sequential. Either an expression is used to specify or calculate
  the desired number of instances or a data driven setup can be used. In
  that case a data input can be specified, which is able to handle a collection
  of data. The number of items in the collection determines the number of
  Activity instances. This data input can be produced by a data input association.
  The modeler can also configure this loop to control the Tokens produced."
  ((|behavior| :range |MultiInstanceBehavior| :multiplicity (1 1) :default :all
    :documentation
     "The attribute behavior acts as a shortcut for specifying when events shall
      be thrown from an Activity instance that is about to complete. It can assume
      values of none, one, all, and complex, resulting in the following behavior:
      - none: the EventDefinition which is associated through the noneEvent association
      will be thrown for each instance completing; - one: the EventDefinition
      referenced through the oneEvent association will be thrown upon the first
      instance completing; - all: no Event is ever thrown; a token is produced
      after completion of all instances - complex: the complexBehaviorDefinitions
      are consulted to determine if and which Events to throw. For the behaviors
      of none and one, a default SignalEventDefinition will be thrown which automatically
      carries the current runtime attributes of the MI Activity. Any thrown Events
      can be caught by boundary Events on the Multi-Instance Activity.")
   (|completionCondition| :range |BPMNExpression| :multiplicity (0 1)
    :documentation
     "This attribute defines a Boolean Expression that when evaluated to true,
      cancels the remaining Activity instances and produces a token.")
   (|inputDataItem| :range |DataInput| :multiplicity (0 1) :is-composite-p T :is-derived-p T)
   (|isSequential| :range |Boolean| :multiplicity (1 1) :is-derived-p T
    :documentation
     "This attribute is a flag that controls whether the Activity instances will
      execute sequentially or in parallel.")
   (|loopCardinality| :range |BPMNExpression| :multiplicity (0 1)
    :documentation
     "A numeric Expression that controls the number of Activity instances that
      will be created. This Expression MUST evaluate to an integer. This may
      be underspecified, meaning that the modeler may simply document the condition.
      In such a case the loop cannot be formally executed. In order to initialize
      a valid multi-instance, either the loopCardinality Expression or the loopDataInput
      MUST be specified.")
   (|loopDataInputRef| :range |ItemAwareElement| :multiplicity (0 1) :is-derived-p T)
   (|loopDataOutputRef| :range |ItemAwareElement| :multiplicity (0 1) :is-derived-p T)
   (|noneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1) :is-derived-p T)
   (|oneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1) :is-derived-p T)
   (|outputDataItem| :range |DataOutput| :multiplicity (0 1) :is-composite-p T :is-derived-p T)))


;;; =========================================================
;;; ====================== NonExclusiveGateway
;;; =========================================================
(def-mm-stereotype |NonExclusiveGateway| (:BPMNPRO) (|Gateway|) (UML241:|ForkNode| UML241:|JoinNode|) 
 ""
  ())


;;; =========================================================
;;; ====================== OutputSet
;;; =========================================================
(def-mm-stereotype |OutputSet| (:BPMNPRO) (|BaseElement|) (UML241:|ParameterSet|) 
 ""
  ((|dataOutputRefs| :range |DataOutput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataOutput| |outputSetRefs|))
   (|optionalOutputRefs| :range |DataOutput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataOutput| |outputSetWithOptional|))
   (|whileExecutingOutputRefs| :range |DataOutput| :multiplicity (0 -1) :is-derived-p T
    :opposite (|DataOutput| |outputSetWithWhileExecuting|))))


;;; =========================================================
;;; ====================== ParallelGateway
;;; =========================================================
(def-mm-stereotype |ParallelGateway| (:BPMNPRO) (|NonExclusiveGateway|) NIL 
 "A Parallel Gateway is used to synchronize (combine) parallel flows and
  to create parallel flows."
  ())


;;; =========================================================
;;; ====================== Participant
;;; =========================================================
(def-mm-stereotype |Participant| (:BPMNPRO) (#|pod|BaseElement||# |InteractionNode|) (UML241:|Property|) 
 "A Participant represents a specific PartnerEntity (e.g., a company) and/or
  a more general PartnerRole (e.g., a buyer, seller, or manufacturer) that
  Participants in a Collaboration. A Participant is often responsible for
  the execution of the Process enclosed in a Pool; however, a Pool may be
  defined without a Process. When Participants are defined they are contained
  within an InteractionSpecification, which includes the sub-types of Collaboration,
  a Choreography, a Conversation, a Global Communication, or a GlobalChoreographyTask."
  ((|interfaceRefs| :range |BPMNInterface| :multiplicity (0 -1) :is-derived-p T)
   (|multiplicityMaximum| :range |UnlimitedNatural| :multiplicity (1 1) :is-derived-p T)
   (|multiplicityMinimum| :range |Integer| :multiplicity (1 1) :is-derived-p T)
   (|partnerEntityRef| :range |PartnerEntity| :multiplicity (0 -1) :is-derived-p T)
   (|partnerRoleRef| :range |PartnerRole| :multiplicity (0 -1) :is-derived-p T)
   (|processRef| :range |BPMNProcess| :multiplicity (0 1) :is-derived-p T)
   (|realization| :range UML241:|Realization| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ParticipantAssociation
;;; =========================================================
(def-mm-stereotype |ParticipantAssociation| (:BPMNPRO) (|BaseElement|) (UML241:|Dependency|) 
 "These elements are used to do mapping between two elements that both contain
  Participants. There are situations where the Participants in different
  diagrams may be defined differently because they were developed independently,
  but represent the same thing. The ParticipantAssociation provides the mechanism
  to match up the Participants. A ParticipantAssociation is used when an
  (outer) diagram with Participants contains an (inner) diagram that also
  has Participants. There are three (3) usages of ParticipantAssociation.
  It is used when: - A Collaboration references a Choreography for inclusion
  between the Collaboration s Pools (Participants). The Participants of the
  Choreography (the inner diagram) need to be mapped to the Participants
  of the Collaboration (the outer diagram). - A Collaboration references
  a Process (within one of its Pools) and that Process contains a Call Activity
  that references another Process that has a definitional Collaboration.
  The Participants of the definitional Collaboration for the called Process
  (the inner diagram) need to be mapped to the Participants of the Collaboration
  (the outer diagram). Note that the outer Collaboration may be a definitional
  Collaboration for the referenced Process. - A Choreography contains a Call
  Choreography Activity that references another Choreography. The Participants
  of the called Choreography (the inner diagram) need to be mapped to the
  Participants of the calling Choreography (the outer diagram)."
  ((|innerParticipantRef| :range |Participant| :multiplicity (1 1) :is-derived-p T)
   (|outerParticipantRef| :range |Participant| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ParticipantMultiplicity
;;; =========================================================
(def-mm-stereotype |ParticipantMultiplicity| (:BPMNPRO) (|BaseElement|) (UML241:|MultiplicityElement|) 
 ""
  ())


;;; =========================================================
;;; ====================== PartnerEntity
;;; =========================================================
#| pod
(def-mm-stereotype |PartnerEntity| (:BPMNPRO) (|BaseElement| |RootElement|) (UML241:|Dependency| UML241:|InstanceSpecification|) 
 "An PartnerEntity is one of the possible types of Participant."
  ((|participantRef| :range |Participant| :multiplicity (0 -1) :is-derived-p T)))
|#

;;; =========================================================
;;; ====================== PartnerRole
;;; =========================================================
#| pod
(def-mm-stereotype |PartnerRole| (:BPMNPRO) (|BaseElement| |RootElement|) (UML241:|Class| UML241:|Dependency|) 
 "A PartnerRole is one of the possible types of Participant."
  ((|participantRef| :range |Participant| :multiplicity (0 -1) :is-derived-p T)))
|#


;;; =========================================================
;;; ====================== Performer
;;; =========================================================
(def-mm-stereotype |Performer| (:BPMNPRO) (|ResourceRole|) (UML241:|Property|) 
 "The Performer class defines the resource that will perform or will be responsible
  for an Activity. The performer can be specified in the form of a specific
  individual, a group, an organization role or position, or an organization."
  ())


;;; =========================================================
;;; ====================== PotentialOwner
;;; =========================================================
(def-mm-stereotype |PotentialOwner| (:BPMNPRO) (|HumanPerformer|) (UML241:|Property|) 
 ""
  ())


;;; =========================================================
;;; ====================== ReceiveTask
;;; =========================================================
(def-mm-stereotype |ReceiveTask| (:BPMNPRO) (|Task|) (UML241:|AcceptEventAction|) 
 "A Receive Task is a simple Task that is designed to wait for a Message
  to arrive from an external Participant (relative to the Process). Once
  the Message has been received, the Task is completed."
  ((|implementation| :range |String| :multiplicity (1 1) :default :webservice
    :documentation
     "This attribute specifies the technology that will be used to send and receive
      the Messages. A Web service is the default technology.")
   (|instantiate| :range UML241:|Element| :multiplicity (1 1) :default :false
    :documentation
     "Receive Tasks can be defined as the instantiation mechanism for the Process
      with the Instantiate attribute. This attribute MAY be set to true if the
      Task is the first activity after the Start Event or a starting Task if
      there is no Start Event (i.e., there are no incoming Sequence Flow). Multiple
      Tasks MAY have this attribute set to True.")
   (|messageRef| :range |BPMNMessage| :multiplicity (0 1)
    :documentation
     "A Message for the messageRef attribute MAY be entered. This indicates that
      the Message will be received by the Task. The Message in this context is
      equivalent to an in-only message pattern (Web service). One or more corresponding
      incoming Message Flow MAY be shown on the diagram. However, the display
      of the Message Flow is not required. The Message is applied to all incoming
      Message Flow, but can arrive for only one of the incoming Message Flow
      for a single instance of the Task.")
   (|operationRef| :range |BPMNOperation| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== Rendering
;;; =========================================================
(def-mm-stereotype |Rendering| (:BPMNPRO) (|BaseElement|) (UML241:|Image| UML241:|ReadExtentAction|) 
 ""
  ())


;;; =========================================================
;;; ====================== Resolved
;;; =========================================================
(def-mm-stereotype |Resolved| (:BPMNPRO) NIL (UML241:|EnumerationLiteral|) 
 ""
  ())


;;; =========================================================
;;; ====================== Resource
;;; =========================================================
(def-mm-stereotype |Resource| (:BPMNPRO) (|ItemDefinition|) NIL 
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
  ((|resourceParameters| :range |ResourceParameter| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ResourceAssignmentExpression
;;; =========================================================
(def-mm-stereotype |ResourceAssignmentExpression| (:BPMNPRO) (|BPMNExpression|) (UML241:|OpaqueExpression|) 
 ""
  ((|expression| :range |ResourceAssignmentExpression| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ResourceParameter
;;; =========================================================
(def-mm-stereotype |ResourceParameter| (:BPMNPRO) (|BaseElement|) (UML241:|Property|) 
 "Resource can define a set of parameters to define a query to resolve the
  actual resources (e.g. user ids). The ResourceParameter element inherits
  the attributes and model associations of BaseElement through its relationship
  to RootElement, and adds additional model associations: type: Element -
  specifies the type of the query parameter isRequired: Boolean - specifies,
  if a parameter is optional or mandatory."
  ((|isRequired| :range |Boolean| :multiplicity (1 1) :is-derived-p T)
   (|type| :range |ItemDefinition| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ResourceParameterBinding
;;; =========================================================
(def-mm-stereotype |ResourceParameterBinding| (:BPMNPRO) (|BaseElement|) (UML241:|Slot|) 
 "BPMN ResourceParameterBinding expressions translate to value(specification)s
  of the slots in the instance specification."
  ((|expression| :range |BPMNExpression| :multiplicity (1 1) :is-derived-p T)
   (|parameterRef| :range |ResourceParameter| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ResourceRole
;;; =========================================================
(def-mm-stereotype |ResourceRole| (:BPMNPRO) (|BaseElement|) (UML241:|Dependency| UML241:|Property|) 
 "The ActivityResource element inherits the attributes and model associations
  of BaseElement. It also defines the additional model associations."
  ((|process| :range |BPMNProcess| :multiplicity (0 1) :is-derived-p T)
   (|resourceAssignmentExpression| :range |ResourceAssignmentExpression| :multiplicity (0 1) :is-composite-p T)
   (|resourceParameterBindings| :range |ResourceParameterBinding| :multiplicity (0 -1) :is-derived-p T)
   (|resourceRef| :range |Resource| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== RootElement
;;; =========================================================
(def-mm-stereotype |RootElement| (:BPMNPRO) (|BaseElement|) (UML241:|PackageableElement|) 
 ""
  ())


;;; =========================================================
;;; ====================== ScriptTask
;;; =========================================================
(def-mm-stereotype |ScriptTask| (:BPMNPRO) (|Task|) (UML241:|OpaqueAction|) 
 "A Script Task is executed by a business process engine. The modeler or
  implementer defines a script in a language that the engine can interpret.
  When the Task is ready to start, the engine will execute the script. When
  the script is completed, the Task will also be completed."
  ((|script| :range |String| :multiplicity (0 1) :is-ordered-p T :is-derived-p T)
   (|scriptFormat| :range |String| :multiplicity (0 1) :is-ordered-p T :is-derived-p T)))


;;; =========================================================
;;; ====================== SendTask
;;; =========================================================
(def-mm-stereotype |SendTask| (:BPMNPRO) (|Task|) (UML241:|CallOperationAction|) 
 "A Send Task is a simple Task that is designed to send a Message to an external
  Participant (relative to the Process). Once the Message has been sent,
  the Task is completed."
  ((|implementation| :range |String| :multiplicity (1 1) :default :webservice)
   (|messageRef| :range |BPMNMessage| :multiplicity (0 1)
    :documentation
     "A Message for the messageRef attribute MAY be entered. This indicates that
      the Message will be sent by the Task. The Message in this context is equivalent
      to an out-only message pattern (Web service). One or more corresponding
      outgoing Message Flow MAY be shown on the diagram. However, the display
      of the Message Flow is not required. The Message is applied to all outgoing
      Message Flow and the Message will be sent down all outgoing Message Flow
      at the completion of a single instance of the Task.")
   (|operationRef| :range |BPMNOperation| :multiplicity (0 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== SequenceFlow
;;; =========================================================
(def-mm-stereotype |SequenceFlow| (:BPMNPRO) (#||BaseElement||# |FlowElement|) (UML241:|ControlFlow|) 
 "A Sequence Flow is used to show the order of Flow Elements in a Process.
  Each Sequence Flow has only one source and only one target. The source
  and target must be from the set of the following Flow Elements: Events
  (Start, Intermediate, and End), Activities (Task and Sub-Process), and
  Gateways. A Sequence Flow can optionally define a condition expression,
  indicating that the  transfer of control  will only be available if the
  expression evaluates to true. This expression is typically used when the
  source of the Sequence Flow is a Gateway or an Activity. A Sequence Flow
  that has an Exclusive, Inclusive, or Complex Gateway or an Activity as
  its source can also be defined with as default. Such Sequence Flow will
  have a marker to show that it is a default flow. The default Sequence Flow
  is taken (a token is passed) only if all the other outgoing Sequence Flow
  from the Activity or Gateway are not valid (i.e., their condition Expressions
  are false)."
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|conditionExpression| :range |BPMNExpression| :multiplicity (1 1) :is-derived-p T)
   (|isImmediate| :range |Boolean| :multiplicity (1 1)
    :documentation
     "An optional Boolean value specifying whether Activities or Choreography
      Activities not in the model containing the Sequence Flow can occur between
      the elements connected by the Sequence Flow. If the value is true, they
      MAY NOT occur. If the value is false, they MAY occur. Also see the isClosed
      attribute on Process, Choreography, and Collaboration. When the attribute
      has no value, the default semantics depends on the kind of model containing
      Sequence Flow: For a public Processes and Choreographies no value has the
      same semantics as if the value were false. For an executable and non-executable
      (internal) Processes no value has the same semantics as if the value were
      true. For executable Processes, the attribute MUST NOT be false.")
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)
   (|sourceRef| :range UML241:|ActivityNode| :multiplicity (1 1) :is-derived-p T)
   (|targetRef| :range UML241:|ActivityNode| :multiplicity (1 1) :is-derived-p T)))


;;; =========================================================
;;; ====================== ServiceTask
;;; =========================================================
(def-mm-stereotype |ServiceTask| (:BPMNPRO) (|Task|) (UML241:|CallOperationAction|) 
 "A Service Task is a Task that uses some sort of service, which could be
  a Web service or an automated application."
  ((|implementation| :range |String| :multiplicity (1 1) :default :webservice
    :documentation
     "This attribute specifies the technology that will be used to send and receive
      the Messages. A Web service is the default technology.")
   (|operationRef| :range |BPMNOperation| :multiplicity (0 1) :is-derived-p T
    :documentation
     "This attribute specifies the operation that is invoked by the Service Task.")))


;;; =========================================================
;;; ====================== SignalEventDefinition
;;; =========================================================
(def-mm-stereotype |SignalEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 ""
  ((|signalRef| :range |BPMNSignal| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== StandardLoopCharacteristics
;;; =========================================================
(def-mm-stereotype |StandardLoopCharacteristics| (:BPMNPRO) (|LoopCharacteristics|) (UML241:|LoopNode|) 
 "The StandardLoopCharacteristics class defines looping behavior based on
  a boolean condition. The Activity will loop as long as the boolean condition
  is true. The condition is evaluated for every loop iteration, and may be
  evaluated at the beginning or at the end of the iteration. In addition,
  a numeric cap can be optionally specified. The number of iterations may
  not exceed this cap."
  ((|loopCondition| :range |BPMNExpression| :multiplicity (0 1) :is-derived-p T
    :documentation
     "A Boolean expression that controls the loop. The Activity will only loop
      as long as this condition is true. The looping behavior may be underspecified,
      meaning that the modeler may simply document the condition, in which case
      the loop cannot be formally executed.")
   (|loopMaximum| :range |Integer| :multiplicity (0 1)
    :documentation
     "Serves as a cap on the number of iterations.")
   (|testBefore| :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "Flag that controls whether the loop condition is evaluated at the beginning
      (testBefore = true) or at the end (testBefore = false) of the loop iteration.")))


;;; =========================================================
;;; ====================== StartEvent
;;; =========================================================
(def-mm-stereotype |StartEvent| (:BPMNPRO) (|CatchEvent|) (UML241:|AcceptEventAction| UML241:|InitialNode|) 
 "As the name implies, the Start Event indicates where a particular Process
  will start. In terms of Sequence Flow, the Start Event starts the flow
  of the Process, and thus, will not have any incoming Sequence Flow   no
  Sequence Flow can connect to a Start Event."
  ((|isInterrupting| :range |Boolean| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== SubConversation
;;; =========================================================
(def-mm-stereotype |SubConversation| (:BPMNPRO) (|ConversationNode|) (UML241:|InformationFlow|) 
 "<p> A Sub-Conversation is a ConversationNode that is a hierarchical
  division within the parent Conversation. A Sub-Conversation is a graphical
  object within a Conversation, but it also can be  opened up  to show the
  lower-level Conversation, which consist of Message Flow, Communications,
  and/or other Sub-Conversations. The Sub-Conversation shares the Participants
  of its parent Conversation. </p>"
  ((|conversationNodes| :range |ConversationNode| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== SubProcess
;;; =========================================================
(def-mm-stereotype |SubProcess| (:BPMNPRO) (|BPMNActivity| |FlowElementsContainer|) (UML241:|StructuredActivityNode|) 
 "A Sub-Process is an Activity whose internal details have been modeled using
  Activities, Gateways, Events, and Sequence Flow. A Sub-Process is a graphical
  object within a Process, but it also can be  opened up  to show a lower-level
  Process. Sub-Processes define a contextual scope that can be used for attribute
  visibility, transactional scope, for the handling of exceptions, of Events,
  or for compensation. There are different types of Sub-Processes."
  ((|artifacts| :range |BPMNArtifact| :multiplicity (0 -1) :is-composite-p T)
   (|laneSets| :range |LaneSet| :multiplicity (0 -1) :is-composite-p T)
   (|triggeredByEvent| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "A flag that identifies whether this Sub-Process is an Event Sub-Process.
      If false, then this Sub-Process is a normal Sub-Process. If true, the this
      Sub-Process is an Event Sub-Process and is subject to additional constraints.")))


;;; =========================================================
;;; ====================== TBD
;;; =========================================================
(def-mm-stereotype TBD (:BPMNPRO) NIL (UML241:|Comment|) 
 ""
  ())


;;; =========================================================
;;; ====================== Task
;;; =========================================================
(def-mm-stereotype |Task| (:BPMNPRO) (|BPMNActivity|) NIL 
 "A Task is an atomic Activity within a Process flow. A Task is used when
  the work in the Process cannot be broken down to a finer level of detail.
  Generally, an end-user and/or applications are used to perform the Task
  when it is executed. There are different types of Tasks identified within
  BPMN to separate the types of inherent behavior that Tasks might represent.
  The list of Task types may be extended along with any corresponding indicators.
  A Task which is not further specified is called Abstract Task."
  ((|ioSpecification| :range |InputOutputSpecification| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== TerminateEventDefinition
;;; =========================================================
(def-mm-stereotype |TerminateEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|CallEvent|) 
 ""
  ())


;;; =========================================================
;;; ====================== TextAnnotation
;;; =========================================================
(def-mm-stereotype |TextAnnotation| (:BPMNPRO) (|BPMNArtifact|) (UML241:|Comment|) 
 "Text Annotations are a mechanism for a modeler to provide additional information
  for the reader of a BPMN Diagram."
  ((|textFormat| :range |String| :multiplicity (1 1)
    :documentation
     "This attribute identifies the format of the text. It MUST follow the mimetype
      format. The default is \"text/plain.\"")))


;;; =========================================================
;;; ====================== ThrowEvent
;;; =========================================================
(def-mm-stereotype |ThrowEvent| (:BPMNPRO) (#||BaseElement||# |BPMNEvent|) (UML241:|CallOperationAction| UML241:|FlowFinalNode|) 
 "Events that throw a Result. All End Events and some Intermediate Events
  are throwing Events that may eventually be caught by another Event. Typically
  the Trigger carries information out of the scope where the throw Event
  occurred into the scope of the catching Events. The throwing of a trigger
  may be either implicit as defined by this standard or an extension to it
  or explicit by a throw Event."
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|eventDefinitions| :range |EventDefinition| :multiplicity (0 -1) :is-composite-p T)
   (|inputSet| :range |DataInput| :multiplicity (0 1) :is-composite-p T)
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== TimerEventDefinition
;;; =========================================================
(def-mm-stereotype |TimerEventDefinition| (:BPMNPRO) (|EventDefinition|) (UML241:|ChangeEvent|) 
 ""
  ((|timeCycle| :range |BPMNExpression| :multiplicity (0 1) :is-composite-p T
    :documentation
     "If the Trigger is a Timer, then a timeCycle MAY be entered. If a timeCycle
      is not entered, then a timeDate MUST be entered.")
   (|timeDate| :range |BPMNExpression| :multiplicity (0 1) :is-composite-p T
    :documentation
     "If the Trigger is a Timer, then a timeDate MAY be entered. If a timeDate
      is not entered, then a timeCycle MUST be entered.")
   (|timeDuration| :range |BPMNExpression| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Transaction
;;; =========================================================
(def-mm-stereotype |Transaction| (:BPMNPRO) (|SubProcess|) NIL 
 "A Transaction is a specialized type of Sub-Process which will have a special
  behavior that is controlled through a transaction protocol (such as WS-Transaction)."
  ((|method| :range |String| :multiplicity (1 1) :default :compensate
    :documentation
     "TransactionMethod is an attribute that defines the technique that will
      be used to undo a Transaction that has been cancelled. The default is compensate,
      but the attribute MAY be set to store or IMAGE.")))


;;; =========================================================
;;; ====================== Unresolved
;;; =========================================================
(def-mm-stereotype |Unresolved| (:BPMNPRO) NIL (UML241:|EnumerationLiteral|) 
 ""
  ())


;;; =========================================================
;;; ====================== UserTask
;;; =========================================================
(def-mm-stereotype |UserTask| (:BPMNPRO) (|Task|) (UML241:|OpaqueAction|) 
 "A User Task is a typical  workflow  Task where a human performer performs
  the Task with the assistance of a software application and is scheduled
  through a task list manager of some sort. BPMN adopters may specify task
  rendering attributes by using the BPMN Extension mechanism."
  ((|implementation| :range |String| :multiplicity (0 -1) :is-ordered-p T :is-derived-p T :default :unspecified)
   (|renderings| :range UML241:|Image| :multiplicity (0 -1) :is-derived-p T)))


;;; =========================================================
;;; ====================== diagrams
;;; =========================================================
(def-mm-stereotype |diagrams| (:BPMNPRO) NIL (UML241:|Element|) 
 ""
  ())


;;; =========================================================
;;; ====================== metaconstraint
;;; =========================================================
(def-mm-stereotype |metaconstraint| (:BPMNPRO) NIL (UML241:|Dependency|) 
 "The metaProperty stereotype is applied to dependencies between stereotypes
  to visually model constraints on the stereotypes' underlying UML metatypes.
  The umlRole Tag relates to a role on an existing meta-level association
  between metatypes (for example ownedAttribute on the association between
  Class and Property). This allows us to model the equivalent of redefines/subsets
  which has been used in the M3, for example, without creating unnecessary
  and unwanted associations between the stereotypes (as subset and redefine
  can only be used through inheritance and we're using extends). It has nothing
  to do with creating aggregation between stereotypes (i.e. tagged values).
  Tagged values are shown as associations in the profile."
  ((|umlRole| :range |String| :multiplicity (1 1)
    :documentation
     "UML Role (property) of the source of the Dependency that is to be typed
      by the target of the Dependency.")))


;;; =========================================================
;;; ====================== metarelationship
;;; =========================================================
(def-mm-stereotype |metarelationship| (:BPMNPRO) NIL (UML241:|Dependency|) 
 ""
  ((|metaclass| :range UML241:|Class| :multiplicity (1 1))))

(def-mm-package "bpmnpro" nil :bpmnpro
  (|AdHocSubProcess|
   |Assignment|
   |Auditing|
   |BPMNActivity|
   |BPMNArtifact|
   |BPMNAssociation|
   |BPMNCollaboration|
   |BPMNDocumentation|
   |BPMNEvent|
   |BPMNExpression|
   |BPMNExtension|
   |BPMNInterface|
   |BPMNMessage|
   |BPMNOperation|
   |BPMNProcess|
   |BPMNProperty|
   |BPMNSignal|
   |BaseElement|
   |BoundaryEvent|
   |BusinessRuleTask|
   |CallActivity|
   |CallConversation|
   |CallableElement|
   |CancelEventDefinition|
   |CatchEvent|
   |Category|
   |CategoryValue|
   |CompensateEventDefinition|
   |CompensationEndEvent|
   |ComplexBehaviorDefinition|
   |ComplexGateway|
   |ConditionalEventDefinition|
   |Conversation|
   |ConversationLink|
   |ConversationNode|
   |CorrelationKey|
   |CorrelationProperty|
   |CorrelationPropertyBinding|
   |CorrelationPropertyRetrievalExpresson|
   |CorrelationSubscription|
   |DataAssociation|
   |DataInput|
   |DataInputAssociation|
   |DataObject|
   |DataObjectRef|
   |DataOutput|
   |DataOutputAssociation|
   |DataState|
   |DataStore|
   |Deferred|
   |Definitions|
   |EndEvent|
   |Error|
   |ErrorEventDefinition|
   |Escalation|
   |EscalationEventDefinition|
   |EventBasedGateway|
   |EventDefinition|
   |ExclusiveGateway|
   |ExtensionAttributeDefinition|
   |ExtensionAttributeValue|
   |ExtensionDefinition|
   |FlowElement|
   |FlowElementsContainer|
   |FlowNode|
   |FormalExpression|
   |Gateway|
   |GlobalBusinessRuleTask|
   |GlobalConversation|
   |GlobalManualTask|
   |GlobalScriptTask|
   |GlobalTask|
   |GlobalUserTask|
   |Group|
   |HumanPerformer|
   |ImplicitThrowEvent|
   |Import|
   |InclusiveGateway|
   |InputOutputSpecification|
   |InputSet|
   |InteractionNode|
   |IntermediateCatchEvent|
   |IntermediateThrowEvent|
   |ItemAwareElement|
   |ItemDefinition|
   |Lane|
   |LaneSet|
   |LinkEventDefinition|
   |LoopCharacteristics|
   |ManualTask|
   |MessageEventDefinition|
   |MessageFlow|
   |MessageFlowAssociation|
   |Monitoring|
   |MultiInstanceLoopCharacteristics|
   |NonExclusiveGateway|
   |OutputSet|
   |ParallelGateway|
   |Participant|
   |ParticipantAssociation|
   |ParticipantMultiplicity|
   |Performer|
   |PotentialOwner|
   |ReceiveTask|
   |Rendering|
   |Resolved|
   |Resource|
   |ResourceAssignmentExpression|
   |ResourceParameter|
   |ResourceParameterBinding|
   |ResourceRole|
   |RootElement|
   |ScriptTask|
   |SendTask|
   |SequenceFlow|
   |ServiceTask|
   |SignalEventDefinition|
   |StandardLoopCharacteristics|
   |StartEvent|
   |SubConversation|
   |SubProcess|
   |Task|
   |TerminateEventDefinition|
   |TextAnnotation|
   |ThrowEvent|
   |TimerEventDefinition|
   |Transaction|
   |Unresolved|
   |UserTask|
   |diagrams|
   |metaconstraint| 
   |metarelationship|))

(in-package :mofi)

(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(BPMNPRO::|BPMNActivity|
          BPMNPRO:|BPMNArtifact|
          BPMNPRO:|BPMNEvent|
          BPMNPRO:|BaseElement|
          BPMNPRO::|CallableElement|
          BPMNPRO::|CatchEvent|
          BPMNPRO::|ConversationNode|
          BPMNPRO::|DataAssociation|
          BPMNPRO::|EventDefinition|
          BPMNPRO:|FlowElement|
          BPMNPRO:|FlowElementsContainer|
          BPMNPRO:|FlowNode|
          BPMNPRO:|Gateway|
          BPMNPRO:|InteractionNode|
          BPMNPRO::|ItemAwareElement|
          BPMNPRO:|LoopCharacteristics|
          BPMNPRO:|NonExclusiveGateway|
          BPMNPRO:|RootElement|
          BPMNPRO::|ThrowEvent|))
     (setf mofi:ns-uri "http://schema.nist.gov/validator/bpmnpro/")
     (setf mofi:ns-prefix "bpmnpro"))

