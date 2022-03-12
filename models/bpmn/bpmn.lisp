;;; Automatically created by pop-gen at 2012-01-18 13:58:36.
;;; Source file is bpmn20.cmof

(in-package :BPMN)



(def-mm-enum |AdHocOrdering| :BPMN NIL 
   (|Parallel| |Sequential|)
   "")



(def-mm-enum |AssociationDirection| :BPMN NIL 
   (|None| |One| |Both|)
   "")



(def-mm-enum |ChoreographyLoopType| :BPMN NIL 
   (|None| |Standard| |MultiInstanceSequential| |MultiInstanceParallel|)
   "")



(def-mm-enum |EventBasedGatewayType| :BPMN NIL 
   (|Parallel| |Exclusive|)
   "")



(def-mm-enum |GatewayDirection| :BPMN NIL 
   (|Unspecified| |Converging| |Diverging| |Mixed|)
   "")



(def-mm-enum |ItemKind| :BPMN NIL 
   (|Physical| |Information|)
   "")



(def-mm-enum |MultiInstanceBehavior| :BPMN NIL 
   (|None| |One| |All| |Complex|)
   "")



(def-mm-enum |ProcessType| :BPMN NIL 
   (|None| |Public| |Private|)
   "")



(def-mm-enum |RelationshipDirection| :BPMN NIL 
   (|None| |Forward| |Backward| |Both|)
   "")



;;; =========================================================
;;; ====================== Activity
;;; =========================================================
(def-mm-class |Activity| :BPMN (|FlowNode|)
 ""
  ((|boundaryEventRefs| :range |BoundaryEvent| :multiplicity (0 -1)
    :opposite (|BoundaryEvent| |attachedToRef|))
   (|completionQuantity| :range |Integer| :multiplicity (1 1) :default 1)
   (|dataInputAssociations| :range |DataInputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|dataOutputAssociations| :range |DataOutputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|default| :range |SequenceFlow| :multiplicity (0 1))
   (|ioSpecification| :range |InputOutputSpecification| :multiplicity (0 1) :is-composite-p T)
   (|isForCompensation| :range |Boolean| :multiplicity (1 1) :default :false)
   (|loopCharacteristics| :range |LoopCharacteristics| :multiplicity (0 1) :is-composite-p T)
   (|properties| :range |Property| :multiplicity (0 -1) :is-composite-p T)
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T)
   (|startQuantity| :range |Integer| :multiplicity (1 1) :default 1)))


;;; =========================================================
;;; ====================== AdHocSubProcess
;;; =========================================================
(def-mm-class |AdHocSubProcess| :BPMN (|SubProcess|)
 ""
  ((|cancelRemainingInstances| :range |Boolean| :multiplicity (1 1) :default :true)
   (|completionCondition| :range |Expression| :multiplicity (1 1) :is-composite-p T)
   (|ordering| :range |AdHocOrdering| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Artifact
;;; =========================================================
(def-mm-class |Artifact| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== Assignment
;;; =========================================================
(def-mm-class |Assignment| :BPMN (|BaseElement|)
 ""
  ((|from| :range |Expression| :multiplicity (1 1) :is-composite-p T)
   (|to| :range |Expression| :multiplicity (1 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-mm-class |Association| :BPMN (|Artifact|)
 ""
  ((|associationDirection| :range |AssociationDirection| :multiplicity (1 1))
   (|sourceRef| :range |BaseElement| :multiplicity (1 1))
   (|targetRef| :range |BaseElement| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Auditing
;;; =========================================================
(def-mm-class |Auditing| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== BaseElement
;;; =========================================================
(def-mm-class |BaseElement| :BPMN NIL
 ""
  ((|documentation| :range |Documentation| :multiplicity (0 -1) :is-composite-p T)
   (|extensionDefinitions| :range |ExtensionDefinition| :multiplicity (0 -1))
   (|extensionValues| :range |ExtensionAttributeValue| :multiplicity (0 -1) :is-composite-p T)
   (|id| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== BoundaryEvent
;;; =========================================================
(def-mm-class |BoundaryEvent| :BPMN (|CatchEvent|)
 ""
  ((|attachedToRef| :range |Activity| :multiplicity (1 1)
    :opposite (|Activity| |boundaryEventRefs|))
   (|cancelActivity| :range |Boolean| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== BusinessRuleTask
;;; =========================================================
(def-mm-class |BusinessRuleTask| :BPMN (|Task|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CallActivity
;;; =========================================================
(def-mm-class |CallActivity| :BPMN (|Activity|)
 ""
  ((|calledElementRef| :range |CallableElement| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== CallChoreography
;;; =========================================================
(def-mm-class |CallChoreography| :BPMN (|ChoreographyActivity|)
 ""
  ((|calledChoreographyRef| :range |Choreography| :multiplicity (0 1))
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== CallConversation
;;; =========================================================
(def-mm-class |CallConversation| :BPMN (|ConversationNode|)
 ""
  ((|calledCollaborationRef| :range |Collaboration| :multiplicity (0 1))
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== CallableElement
;;; =========================================================
(def-mm-class |CallableElement| :BPMN (|RootElement|)
 ""
  ((|ioBinding| :range |InputOutputBinding| :multiplicity (0 -1) :is-composite-p T)
   (|ioSpecification| :range |InputOutputSpecification| :multiplicity (0 1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))
   (|supportedInterfaceRefs| :range |Interface| :multiplicity (0 -1))))


;;; =========================================================
;;; ====================== CancelEventDefinition
;;; =========================================================
(def-mm-class |CancelEventDefinition| :BPMN (|EventDefinition|)
 ""
  ())


;;; =========================================================
;;; ====================== CatchEvent
;;; =========================================================
(def-mm-class |CatchEvent| :BPMN (|Event|)
 ""
  ((|dataOutputAssociation| :range |DataOutputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|dataOutputs| :range |DataOutput| :multiplicity (0 -1) :is-composite-p T)
   (|eventDefinitionRefs| :range |EventDefinition| :multiplicity (0 -1))
   (|eventDefinitions| :range |EventDefinition| :multiplicity (0 -1) :is-composite-p T)
   (|outputSet| :range |OutputSet| :multiplicity (0 1) :is-composite-p T)
   (|parallelMultiple| :range |Boolean| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Category
;;; =========================================================
(def-mm-class |Category| :BPMN (|RootElement|)
 ""
  ((|categoryValue| :range |CategoryValue| :multiplicity (0 -1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CategoryValue
;;; =========================================================
(def-mm-class |CategoryValue| :BPMN (|BaseElement|)
 ""
  ((|categorizedFlowElements| :range |FlowElement| :multiplicity (0 -1) :is-derived-p T
    :opposite (|FlowElement| |categoryValueRef|))
   (|value| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Choreography
;;; =========================================================
(def-mm-class |Choreography| :BPMN (|FlowElementsContainer| |Collaboration|)
 ""
  ())


;;; =========================================================
;;; ====================== ChoreographyActivity
;;; =========================================================
(def-mm-class |ChoreographyActivity| :BPMN (|FlowNode|)
 ""
  ((|correlationKeys| :range |CorrelationKey| :multiplicity (0 -1) :is-composite-p T)
   (|initiatingParticipantRef| :range |Participant| :multiplicity (1 1))
   (|loopType| :range |ChoreographyLoopType| :multiplicity (1 1) :default :none)
   (|participantRefs| :range |Participant| :multiplicity (2 -1))))


;;; =========================================================
;;; ====================== ChoreographyTask
;;; =========================================================
(def-mm-class |ChoreographyTask| :BPMN (|ChoreographyActivity|)
 ""
  ((|messageFlowRef| :range |MessageFlow| :multiplicity (1 2))))


;;; =========================================================
;;; ====================== Collaboration
;;; =========================================================
(def-mm-class |Collaboration| :BPMN (|RootElement|)
 ""
  ((|artifacts| :range |Artifact| :multiplicity (0 -1) :is-composite-p T)
   (|choreographyRef| :range |Choreography| :multiplicity (0 -1))
   (|conversationAssociations| :range |ConversationAssociation| :multiplicity (1 1) :is-composite-p T)
   (|conversationLinks| :range |ConversationLink| :multiplicity (0 -1) :is-composite-p T)
   (|conversations| :range |ConversationNode| :multiplicity (0 -1) :is-composite-p T)
   (|correlationKeys| :range |CorrelationKey| :multiplicity (0 -1) :is-composite-p T)
   (|isClosed| :range |Boolean| :multiplicity (1 1))
   (|messageFlowAssociations| :range |MessageFlowAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|messageFlows| :range |MessageFlow| :multiplicity (0 -1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))
   (|participantAssociations| :range |ParticipantAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|participants| :range |Participant| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== CompensateEventDefinition
;;; =========================================================
(def-mm-class |CompensateEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|activityRef| :range |Activity| :multiplicity (0 1))
   (|waitForCompletion| :range |Boolean| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ComplexBehaviorDefinition
;;; =========================================================
(def-mm-class |ComplexBehaviorDefinition| :BPMN (|BaseElement|)
 ""
  ((|condition| :range |FormalExpression| :multiplicity (1 1) :is-composite-p T)
   (|event| :range |ImplicitThrowEvent| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== ComplexGateway
;;; =========================================================
(def-mm-class |ComplexGateway| :BPMN (|Gateway|)
 ""
  ((|activationCondition| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|default| :range |SequenceFlow| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ConditionalEventDefinition
;;; =========================================================
(def-mm-class |ConditionalEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|condition| :range |Expression| :multiplicity (1 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Conversation
;;; =========================================================
(def-mm-class |Conversation| :BPMN (|ConversationNode|)
 ""
  ())


;;; =========================================================
;;; ====================== ConversationAssociation
;;; =========================================================
(def-mm-class |ConversationAssociation| :BPMN (|BaseElement|)
 ""
  ((|innerConversationNodeRef| :range |ConversationNode| :multiplicity (1 1))
   (|outerConversationNodeRef| :range |ConversationNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ConversationLink
;;; =========================================================
(def-mm-class |ConversationLink| :BPMN (|BaseElement|)
 ""
  ((|name| :range |String| :multiplicity (0 1))
   (|sourceRef| :range |InteractionNode| :multiplicity (1 1)
    :opposite (|InteractionNode| |outgoingConversationLinks|))
   (|targetRef| :range |InteractionNode| :multiplicity (1 1)
    :opposite (|InteractionNode| |incomingConversationLinks|))))


;;; =========================================================
;;; ====================== ConversationNode
;;; =========================================================
(def-mm-class |ConversationNode| :BPMN (|InteractionNode| |BaseElement|)
 ""
  ((|correlationKeys| :range |CorrelationKey| :multiplicity (0 -1) :is-composite-p T)
   (|messageFlowRefs| :range |MessageFlow| :multiplicity (0 -1))
   (|name| :range |String| :multiplicity (1 1))
   (|participantRefs| :range |Participant| :multiplicity (2 -1))))


;;; =========================================================
;;; ====================== CorrelationKey
;;; =========================================================
(def-mm-class |CorrelationKey| :BPMN (|BaseElement|)
 ""
  ((|correlationPropertyRef| :range |CorrelationProperty| :multiplicity (0 -1))
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CorrelationProperty
;;; =========================================================
(def-mm-class |CorrelationProperty| :BPMN (|RootElement|)
 ""
  ((|correlationPropertyRetrievalExpression| :range |CorrelationPropertyRetrievalExpression| :multiplicity (1 -1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))
   (|type| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== CorrelationPropertyBinding
;;; =========================================================
(def-mm-class |CorrelationPropertyBinding| :BPMN (|BaseElement|)
 ""
  ((|correlationPropertyRef| :range |CorrelationProperty| :multiplicity (1 1))
   (|dataPath| :range |FormalExpression| :multiplicity (1 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== CorrelationPropertyRetrievalExpression
;;; =========================================================
(def-mm-class |CorrelationPropertyRetrievalExpression| :BPMN (|BaseElement|)
 ""
  ((|messagePath| :range |FormalExpression| :multiplicity (1 1) :is-composite-p T)
   (|messageRef| :range |Message| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== CorrelationSubscription
;;; =========================================================
(def-mm-class |CorrelationSubscription| :BPMN (|BaseElement|)
 ""
  ((|correlationKeyRef| :range |CorrelationKey| :multiplicity (1 1))
   (|correlationPropertyBinding| :range |CorrelationPropertyBinding| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== DataAssociation
;;; =========================================================
(def-mm-class |DataAssociation| :BPMN (|BaseElement|)
 ""
  ((|assignment| :range |Assignment| :multiplicity (0 -1) :is-composite-p T)
   (|sourceRef| :range |ItemAwareElement| :multiplicity (0 -1))
   (|targetRef| :range |ItemAwareElement| :multiplicity (1 1))
   (|transformation| :range |FormalExpression| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== DataInput
;;; =========================================================
(def-mm-class |DataInput| :BPMN (|ItemAwareElement|)
 ""
  ((|inputSetRefs| :range |InputSet| :multiplicity (1 -1) :is-derived-p T
    :opposite (|InputSet| |dataInputRefs|))
   (|inputSetWithOptional| :range |InputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|InputSet| |optionalInputRefs|))
   (|inputSetWithWhileExecuting| :range |InputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|InputSet| |whileExecutingInputRefs|))
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)
   (|name| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== DataInputAssociation
;;; =========================================================
(def-mm-class |DataInputAssociation| :BPMN (|DataAssociation|)
 ""
  ())


;;; =========================================================
;;; ====================== DataObject
;;; =========================================================
(def-mm-class |DataObject| :BPMN (|FlowElement| |ItemAwareElement|)
 ""
  ((|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== DataObjectReference
;;; =========================================================
(def-mm-class |DataObjectReference| :BPMN (|ItemAwareElement| |FlowElement|)
 ""
  ((|dataObjectRef| :range |DataObject| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== DataOutput
;;; =========================================================
(def-mm-class |DataOutput| :BPMN (|ItemAwareElement|)
 ""
  ((|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)
   (|name| :range |String| :multiplicity (0 1))
   (|outputSetRefs| :range |OutputSet| :multiplicity (1 -1) :is-derived-p T
    :opposite (|OutputSet| |dataOutputRefs|))
   (|outputSetWithOptional| :range |OutputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|OutputSet| |optionalOutputRefs|))
   (|outputSetWithWhileExecuting| :range |OutputSet| :multiplicity (0 -1) :is-derived-p T
    :opposite (|OutputSet| |whileExecutingOutputRefs|))))


;;; =========================================================
;;; ====================== DataOutputAssociation
;;; =========================================================
(def-mm-class |DataOutputAssociation| :BPMN (|DataAssociation|)
 ""
  ())


;;; =========================================================
;;; ====================== DataState
;;; =========================================================
(def-mm-class |DataState| :BPMN (|BaseElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== DataStore
;;; =========================================================
(def-mm-class |DataStore| :BPMN (|RootElement| |ItemAwareElement|)
 ""
  ((|capacity| :range |Integer| :multiplicity (1 1))
   (|isUnlimited| :range |Boolean| :multiplicity (1 1) :default :true)
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== DataStoreReference
;;; =========================================================
(def-mm-class |DataStoreReference| :BPMN (|ItemAwareElement| |FlowElement|)
 ""
  ((|dataStoreRef| :range |DataStore| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Definitions
;;; =========================================================
(def-mm-class |Definitions| :BPMN (|BaseElement|)
 ""
  ((|diagrams| :range CMOF:|Element| :multiplicity (0 -1) :is-composite-p T)
   (|exporter| :range |String| :multiplicity (1 1))
   (|exporterVersion| :range |String| :multiplicity (1 1))
   (|expressionLanguage| :range |String| :multiplicity (1 1) :default "http://www.w3.org/1999/xpath")
   (|extensions| :range |Extension| :multiplicity (0 -1) :is-composite-p T)
   (|imports| :range |Import| :multiplicity (0 -1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))
   (|relationships| :range |Relationship| :multiplicity (0 -1) :is-composite-p T)
   (|rootElements| :range |RootElement| :multiplicity (0 -1) :is-composite-p T)
   (|targetNamespace| :range |String| :multiplicity (1 1))
   (|typeLanguage| :range |String| :multiplicity (1 1) :default "http://www.w3.org/2001/xmlschema")))


;;; =========================================================
;;; ====================== Documentation
;;; =========================================================
(def-mm-class |Documentation| :BPMN (|BaseElement|)
 ""
  ((|text| :range |String| :multiplicity (1 1))
   (|textFormat| :range |String| :multiplicity (1 1) :default :text/plain)))


;;; =========================================================
;;; ====================== EndEvent
;;; =========================================================
(def-mm-class |EndEvent| :BPMN (|ThrowEvent|)
 ""
  ())


;;; =========================================================
;;; ====================== EndPoint
;;; =========================================================
(def-mm-class |EndPoint| :BPMN (|RootElement|)
 ""
  ())


;;; =========================================================
;;; ====================== Error
;;; =========================================================
(def-mm-class |Error| :BPMN (|RootElement|)
 ""
  ((|errorCode| :range |String| :multiplicity (1 1))
   (|name| :range |String| :multiplicity (1 1))
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ErrorEventDefinition
;;; =========================================================
(def-mm-class |ErrorEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|errorRef| :range |Error| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Escalation
;;; =========================================================
(def-mm-class |Escalation| :BPMN NIL
 ""
  ((|escalationCode| :range |String| :multiplicity (1 1))
   (|name| :range |String| :multiplicity (1 1))
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== EscalationEventDefinition
;;; =========================================================
(def-mm-class |EscalationEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|escalationRef| :range |Escalation| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Event
;;; =========================================================
(def-mm-class |Event| :BPMN (|FlowNode| |InteractionNode|)
 ""
  ((|properties| :range |Property| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== EventBasedGateway
;;; =========================================================
(def-mm-class |EventBasedGateway| :BPMN (|Gateway|)
 ""
  ((|eventGatewayType| :range |EventBasedGatewayType| :multiplicity (1 1))
   (|instantiate| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== EventDefinition
;;; =========================================================
(def-mm-class |EventDefinition| :BPMN (|RootElement|)
 ""
  ())


;;; =========================================================
;;; ====================== ExclusiveGateway
;;; =========================================================
(def-mm-class |ExclusiveGateway| :BPMN (|Gateway|)
 ""
  ((|default| :range |SequenceFlow| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Expression
;;; =========================================================
(def-mm-class |Expression| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== Extension
;;; =========================================================
(def-mm-class |Extension| :BPMN NIL
 ""
  ((|definition| :range |ExtensionDefinition| :multiplicity (1 1) :is-composite-p T)
   (|mustUnderstand| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== ExtensionAttributeDefinition
;;; =========================================================
(def-mm-class |ExtensionAttributeDefinition| :BPMN NIL
 ""
  ((|extensionDefinition| :range |ExtensionDefinition| :multiplicity (1 1)
    :opposite (|ExtensionDefinition| |extensionAttributeDefinitions|))
   (|isReference| :range |Boolean| :multiplicity (1 1) :default :false)
   (|name| :range |String| :multiplicity (1 1))
   (|type| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ExtensionAttributeValue
;;; =========================================================
(def-mm-class |ExtensionAttributeValue| :BPMN NIL
 ""
  ((|extensionAttributeDefinition| :range |ExtensionAttributeDefinition| :multiplicity (1 1))
   (|value| :range CMOF:|Element| :multiplicity (0 1) :is-composite-p T)
   (|valueRef| :range CMOF:|Element| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ExtensionDefinition
;;; =========================================================
(def-mm-class |ExtensionDefinition| :BPMN NIL
 ""
  ((|extensionAttributeDefinitions| :range |ExtensionAttributeDefinition| :multiplicity (0 -1) :is-composite-p T
    :opposite (|ExtensionAttributeDefinition| |extensionDefinition|))
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== FlowElement
;;; =========================================================
(def-mm-class |FlowElement| :BPMN (|BaseElement|)
 ""
  ((|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|categoryValueRef| :range |CategoryValue| :multiplicity (0 -1)
    :opposite (|CategoryValue| |categorizedFlowElements|))
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== FlowElementsContainer
;;; =========================================================
(def-mm-class |FlowElementsContainer| :BPMN (|BaseElement|)
 ""
  ((|flowElements| :range |FlowElement| :multiplicity (0 -1) :is-composite-p T)
   (|laneSets| :range |LaneSet| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== FlowNode
;;; =========================================================
(def-mm-class |FlowNode| :BPMN (|FlowElement|)
 ""
  ((|incoming| :range |SequenceFlow| :multiplicity (0 -1)
    :opposite (|SequenceFlow| |targetRef|))
   (|lanes| :range |Lane| :multiplicity (0 -1) :is-derived-p T
    :opposite (|Lane| |flowNodeRefs|))
   (|outgoing| :range |SequenceFlow| :multiplicity (0 -1) :is-ordered-p T
    :opposite (|SequenceFlow| |sourceRef|))))


;;; =========================================================
;;; ====================== FormalExpression
;;; =========================================================
(def-mm-class |FormalExpression| :BPMN (|Expression|)
 ""
  ((|body| :range CMOF:|Element| :multiplicity (1 1))
   (|evaluatesToTypeRef| :range |ItemDefinition| :multiplicity (1 1))
   (|language| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Gateway
;;; =========================================================
(def-mm-class |Gateway| :BPMN (|FlowNode|)
 ""
  ((|gatewayDirection| :range |GatewayDirection| :multiplicity (1 1) :default :unspecified)))


;;; =========================================================
;;; ====================== GlobalBusinessRuleTask
;;; =========================================================
(def-mm-class |GlobalBusinessRuleTask| :BPMN (|GlobalTask|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== GlobalChoreographyTask
;;; =========================================================
(def-mm-class |GlobalChoreographyTask| :BPMN (|Choreography|)
 ""
  ((|initiatingParticipantRef| :range |Participant| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== GlobalConversation
;;; =========================================================
(def-mm-class |GlobalConversation| :BPMN (|Collaboration|)
 ""
  ())


;;; =========================================================
;;; ====================== GlobalManualTask
;;; =========================================================
(def-mm-class |GlobalManualTask| :BPMN (|GlobalTask|)
 ""
  ())


;;; =========================================================
;;; ====================== GlobalScriptTask
;;; =========================================================
(def-mm-class |GlobalScriptTask| :BPMN (|GlobalTask|)
 ""
  ((|script| :range |String| :multiplicity (1 1))
   (|scriptLanguage| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== GlobalTask
;;; =========================================================
(def-mm-class |GlobalTask| :BPMN (|CallableElement|)
 ""
  ((|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== GlobalUserTask
;;; =========================================================
(def-mm-class |GlobalUserTask| :BPMN (|GlobalTask|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))
   (|renderings| :range |Rendering| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Group
;;; =========================================================
(def-mm-class |Group| :BPMN (|Artifact|)
 ""
  ((|categoryValueRef| :range |CategoryValue| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== HumanPerformer
;;; =========================================================
(def-mm-class |HumanPerformer| :BPMN (|Performer|)
 ""
  ())


;;; =========================================================
;;; ====================== ImplicitThrowEvent
;;; =========================================================
(def-mm-class |ImplicitThrowEvent| :BPMN (|ThrowEvent|)
 ""
  ())


;;; =========================================================
;;; ====================== Import
;;; =========================================================
(def-mm-class |Import| :BPMN NIL
 ""
  ((|importType| :range |String| :multiplicity (1 1))
   (|location| :range |String| :multiplicity (1 1))
   (|namespace| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== InclusiveGateway
;;; =========================================================
(def-mm-class |InclusiveGateway| :BPMN (|Gateway|)
 ""
  ((|default| :range |SequenceFlow| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== InputOutputBinding
;;; =========================================================
(def-mm-class |InputOutputBinding| :BPMN NIL
 ""
  ((|inputDataRef| :range |InputSet| :multiplicity (1 1))
   (|operationRef| :range |Operation| :multiplicity (1 1))
   (|outputDataRef| :range |OutputSet| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== InputOutputSpecification
;;; =========================================================
(def-mm-class |InputOutputSpecification| :BPMN (|BaseElement|)
 ""
  ((|dataInputs| :range |DataInput| :multiplicity (0 -1) :is-composite-p T)
   (|dataOutputs| :range |DataOutput| :multiplicity (0 -1) :is-composite-p T)
   (|inputSets| :range |InputSet| :multiplicity (1 -1) :is-composite-p T)
   (|outputSets| :range |OutputSet| :multiplicity (1 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== InputSet
;;; =========================================================
(def-mm-class |InputSet| :BPMN (|BaseElement|)
 ""
  ((|dataInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetRefs|))
   (|name| :range |String| :multiplicity (1 1))
   (|optionalInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetWithOptional|))
   (|outputSetRefs| :range |OutputSet| :multiplicity (0 -1)
    :opposite (|OutputSet| |inputSetRefs|))
   (|whileExecutingInputRefs| :range |DataInput| :multiplicity (0 -1)
    :opposite (|DataInput| |inputSetWithWhileExecuting|))))


;;; =========================================================
;;; ====================== InteractionNode
;;; =========================================================
(def-mm-class |InteractionNode| :BPMN NIL
 ""
  ((|incomingConversationLinks| :range |ConversationLink| :multiplicity (0 -1) :is-derived-p T
    :opposite (|ConversationLink| |targetRef|))
   (|outgoingConversationLinks| :range |ConversationLink| :multiplicity (0 -1) :is-derived-p T
    :opposite (|ConversationLink| |sourceRef|))))


;;; =========================================================
;;; ====================== Interface
;;; =========================================================
(def-mm-class |Interface| :BPMN (|RootElement|)
 ""
  ((|implementationRef| :range CMOF:|Element| :multiplicity (0 1))
   (|name| :range |String| :multiplicity (1 1))
   (|operations| :range |Operation| :multiplicity (1 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== IntermediateCatchEvent
;;; =========================================================
(def-mm-class |IntermediateCatchEvent| :BPMN (|CatchEvent|)
 ""
  ())


;;; =========================================================
;;; ====================== IntermediateThrowEvent
;;; =========================================================
(def-mm-class |IntermediateThrowEvent| :BPMN (|ThrowEvent|)
 ""
  ())


;;; =========================================================
;;; ====================== ItemAwareElement
;;; =========================================================
(def-mm-class |ItemAwareElement| :BPMN (|BaseElement|)
 ""
  ((|dataState| :range |DataState| :multiplicity (0 1) :is-composite-p T)
   (|itemSubjectRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ItemDefinition
;;; =========================================================
(def-mm-class |ItemDefinition| :BPMN (|RootElement|)
 ""
  ((|import| :range |Import| :multiplicity (0 1))
   (|isCollection| :range |Boolean| :multiplicity (1 1) :default :false)
   (|itemKind| :range |ItemKind| :multiplicity (1 1))
   (|structureRef| :range CMOF:|Element| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Lane
;;; =========================================================
(def-mm-class |Lane| :BPMN (|BaseElement|)
 ""
  ((|childLaneSet| :range |LaneSet| :multiplicity (0 1) :is-composite-p T)
   (|flowNodeRefs| :range |FlowNode| :multiplicity (0 -1)
    :opposite (|FlowNode| |lanes|))
   (|name| :range |String| :multiplicity (1 1))
   (|partitionElement| :range |BaseElement| :multiplicity (0 1) :is-composite-p T)
   (|partitionElementRef| :range |BaseElement| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== LaneSet
;;; =========================================================
(def-mm-class |LaneSet| :BPMN (|BaseElement|)
 ""
  ((|lanes| :range |Lane| :multiplicity (0 -1) :is-composite-p T)
   (|name| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== LinkEventDefinition
;;; =========================================================
(def-mm-class |LinkEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|source| :range |LinkEventDefinition| :multiplicity (0 -1)
    :opposite (|LinkEventDefinition| |target|))
   (|target| :range |LinkEventDefinition| :multiplicity (0 1)
    :opposite (|LinkEventDefinition| |source|))))


;;; =========================================================
;;; ====================== LoopCharacteristics
;;; =========================================================
(def-mm-class |LoopCharacteristics| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== ManualTask
;;; =========================================================
(def-mm-class |ManualTask| :BPMN (|Task|)
 ""
  ())


;;; =========================================================
;;; ====================== Message
;;; =========================================================
(def-mm-class |Message| :BPMN (|RootElement|)
 ""
  ((|itemRef| :range |ItemDefinition| :multiplicity (0 1))
   (|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageEventDefinition
;;; =========================================================
(def-mm-class |MessageEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|messageRef| :range |Message| :multiplicity (0 1))
   (|operationRef| :range |Operation| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== MessageFlow
;;; =========================================================
(def-mm-class |MessageFlow| :BPMN (|BaseElement|)
 ""
  ((|messageRef| :range |Message| :multiplicity (0 1))
   (|name| :range |String| :multiplicity (1 1))
   (|sourceRef| :range |InteractionNode| :multiplicity (1 1))
   (|targetRef| :range |InteractionNode| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== MessageFlowAssociation
;;; =========================================================
(def-mm-class |MessageFlowAssociation| :BPMN (|BaseElement|)
 ""
  ((|innerMessageFlowRef| :range |MessageFlow| :multiplicity (1 1))
   (|outerMessageFlowRef| :range |MessageFlow| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Monitoring
;;; =========================================================
(def-mm-class |Monitoring| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== MultiInstanceLoopCharacteristics
;;; =========================================================
(def-mm-class |MultiInstanceLoopCharacteristics| :BPMN (|LoopCharacteristics|)
 ""
  ((|behavior| :range |MultiInstanceBehavior| :multiplicity (1 1) :default :all)
   (|completionCondition| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|complexBehaviorDefinition| :range |ComplexBehaviorDefinition| :multiplicity (0 -1) :is-composite-p T)
   (|inputDataItem| :range |DataInput| :multiplicity (0 1) :is-composite-p T)
   (|isSequential| :range |Boolean| :multiplicity (1 1) :default :false)
   (|loopCardinality| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|loopDataInputRef| :range |ItemAwareElement| :multiplicity (0 1))
   (|loopDataOutputRef| :range |ItemAwareElement| :multiplicity (0 1))
   (|noneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1))
   (|oneBehaviorEventRef| :range |EventDefinition| :multiplicity (0 1))
   (|outputDataItem| :range |DataOutput| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Operation
;;; =========================================================
(def-mm-class |Operation| :BPMN (|BaseElement|)
 ""
  ((|errorRefs| :range |Error| :multiplicity (0 -1))
   (|implementationRef| :range CMOF:|Element| :multiplicity (0 1))
   (|inMessageRef| :range |Message| :multiplicity (1 1))
   (|name| :range |String| :multiplicity (1 1))
   (|outMessageRef| :range |Message| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== OutputSet
;;; =========================================================
(def-mm-class |OutputSet| :BPMN (|BaseElement|)
 ""
  ((|dataOutputRefs| :range |DataOutput| :multiplicity (0 -1)
    :opposite (|DataOutput| |outputSetRefs|))
   (|inputSetRefs| :range |InputSet| :multiplicity (0 -1)
    :opposite (|InputSet| |outputSetRefs|))
   (|name| :range |String| :multiplicity (1 1))
   (|optionalOutputRefs| :range |DataOutput| :multiplicity (0 -1)
    :opposite (|DataOutput| |outputSetWithOptional|))
   (|whileExecutingOutputRefs| :range |DataOutput| :multiplicity (0 -1)
    :opposite (|DataOutput| |outputSetWithWhileExecuting|))))


;;; =========================================================
;;; ====================== ParallelGateway
;;; =========================================================
(def-mm-class |ParallelGateway| :BPMN (|Gateway|)
 ""
  ())


;;; =========================================================
;;; ====================== Participant
;;; =========================================================
(def-mm-class |Participant| :BPMN (|InteractionNode| |BaseElement|)
 ""
  ((|endPointRefs| :range |EndPoint| :multiplicity (0 -1))
   (|interfaceRefs| :range |Interface| :multiplicity (0 -1))
   (|name| :range |String| :multiplicity (1 1))
   (|participantMultiplicity| :range |ParticipantMultiplicity| :multiplicity (0 1) :is-composite-p T)
   (|processRef| :range |Process| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ParticipantAssociation
;;; =========================================================
(def-mm-class |ParticipantAssociation| :BPMN (|BaseElement|)
 ""
  ((|innerParticipantRef| :range |Participant| :multiplicity (1 1))
   (|outerParticipantRef| :range |Participant| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ParticipantMultiplicity
;;; =========================================================
(def-mm-class |ParticipantMultiplicity| :BPMN NIL
 ""
  ((|maximum| :range |Integer| :multiplicity (0 1) :default 1)
   (|minimum| :range |Integer| :multiplicity (1 1) :default 0)))


;;; =========================================================
;;; ====================== PartnerEntity
;;; =========================================================
(def-mm-class |PartnerEntity| :BPMN (|RootElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|participantRef| :range |Participant| :multiplicity (0 -1))))


;;; =========================================================
;;; ====================== PartnerRole
;;; =========================================================
(def-mm-class |PartnerRole| :BPMN (|RootElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|participantRef| :range |Participant| :multiplicity (0 -1))))


;;; =========================================================
;;; ====================== Performer
;;; =========================================================
(def-mm-class |Performer| :BPMN (|ResourceRole|)
 ""
  ())


;;; =========================================================
;;; ====================== PotentialOwner
;;; =========================================================
(def-mm-class |PotentialOwner| :BPMN (|HumanPerformer|)
 ""
  ())


;;; =========================================================
;;; ====================== Process
;;; =========================================================
(def-mm-class |Process| :BPMN (|FlowElementsContainer| |CallableElement|)
 ""
  ((|artifacts| :range |Artifact| :multiplicity (0 -1) :is-composite-p T)
   (|auditing| :range |Auditing| :multiplicity (0 1) :is-composite-p T)
   (|correlationSubscriptions| :range |CorrelationSubscription| :multiplicity (0 -1) :is-composite-p T)
   (|definitionalCollaborationRef| :range |Collaboration| :multiplicity (0 1))
   (|isClosed| :range |Boolean| :multiplicity (1 1))
   (|isExecutable| :range |Boolean| :multiplicity (1 1))
   (|monitoring| :range |Monitoring| :multiplicity (0 1) :is-composite-p T)
   (|processType| :range |ProcessType| :multiplicity (1 1))
   (|properties| :range |Property| :multiplicity (0 -1) :is-composite-p T)
   (|resources| :range |ResourceRole| :multiplicity (0 -1) :is-composite-p T)
   (|supports| :range |Process| :multiplicity (0 -1))))


;;; =========================================================
;;; ====================== Property
;;; =========================================================
(def-mm-class |Property| :BPMN (|ItemAwareElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ReceiveTask
;;; =========================================================
(def-mm-class |ReceiveTask| :BPMN (|Task|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))
   (|instantiate| :range |Boolean| :multiplicity (1 1) :default :false)
   (|messageRef| :range |Message| :multiplicity (0 1))
   (|operationRef| :range |Operation| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Relationship
;;; =========================================================
(def-mm-class |Relationship| :BPMN (|BaseElement|)
 ""
  ((|direction| :range |RelationshipDirection| :multiplicity (1 1))
   (|sources| :range CMOF:|Element| :multiplicity (1 -1))
   (|targets| :range CMOF:|Element| :multiplicity (1 -1))
   (|type| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== Rendering
;;; =========================================================
(def-mm-class |Rendering| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== Resource
;;; =========================================================
(def-mm-class |Resource| :BPMN (|RootElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|resourceParameters| :range |ResourceParameter| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== ResourceAssignmentExpression
;;; =========================================================
(def-mm-class |ResourceAssignmentExpression| :BPMN NIL
 ""
  ((|expression| :range |Expression| :multiplicity (1 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== ResourceParameter
;;; =========================================================
(def-mm-class |ResourceParameter| :BPMN (|BaseElement|)
 ""
  ((|isRequired| :range |Boolean| :multiplicity (1 1))
   (|name| :range |String| :multiplicity (1 1))
   (|type| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== ResourceParameterBinding
;;; =========================================================
(def-mm-class |ResourceParameterBinding| :BPMN NIL
 ""
  ((|expression| :range |Expression| :multiplicity (1 1) :is-composite-p T)
   (|parameterRef| :range |ResourceParameter| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== ResourceRole
;;; =========================================================
(def-mm-class |ResourceRole| :BPMN (|BaseElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|resourceAssignmentExpression| :range |ResourceAssignmentExpression| :multiplicity (0 1) :is-composite-p T)
   (|resourceParameterBindings| :range |ResourceParameterBinding| :multiplicity (0 -1) :is-composite-p T)
   (|resourceRef| :range |Resource| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== RootElement
;;; =========================================================
(def-mm-class |RootElement| :BPMN (|BaseElement|)
 ""
  ())


;;; =========================================================
;;; ====================== ScriptTask
;;; =========================================================
(def-mm-class |ScriptTask| :BPMN (|Task|)
 ""
  ((|script| :range |String| :multiplicity (1 1))
   (|scriptFormat| :range |String| :multiplicity (1 1))))


;;; =========================================================
;;; ====================== SendTask
;;; =========================================================
(def-mm-class |SendTask| :BPMN (|Task|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))
   (|messageRef| :range |Message| :multiplicity (0 1))
   (|operationRef| :range |Operation| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== SequenceFlow
;;; =========================================================
(def-mm-class |SequenceFlow| :BPMN (|FlowElement|)
 ""
  ((|conditionExpression| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|isImmediate| :range |Boolean| :multiplicity (0 1))
   (|sourceRef| :range |FlowNode| :multiplicity (1 1)
    :opposite (|FlowNode| |outgoing|))
   (|targetRef| :range |FlowNode| :multiplicity (1 1)
    :opposite (|FlowNode| |incoming|))))


;;; =========================================================
;;; ====================== ServiceTask
;;; =========================================================
(def-mm-class |ServiceTask| :BPMN (|Task|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))
   (|operationRef| :range |Operation| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== Signal
;;; =========================================================
(def-mm-class |Signal| :BPMN (|RootElement|)
 ""
  ((|name| :range |String| :multiplicity (1 1))
   (|structureRef| :range |ItemDefinition| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== SignalEventDefinition
;;; =========================================================
(def-mm-class |SignalEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|signalRef| :range |Signal| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== StandardLoopCharacteristics
;;; =========================================================
(def-mm-class |StandardLoopCharacteristics| :BPMN (|LoopCharacteristics|)
 ""
  ((|loopCondition| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|loopMaximum| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|testBefore| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== StartEvent
;;; =========================================================
(def-mm-class |StartEvent| :BPMN (|CatchEvent|)
 ""
  ((|isInterrupting| :range |Boolean| :multiplicity (1 1) :default :true)))


;;; =========================================================
;;; ====================== SubChoreography
;;; =========================================================
(def-mm-class |SubChoreography| :BPMN (|ChoreographyActivity| |FlowElementsContainer|)
 ""
  ((|artifacts| :range |Artifact| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== SubConversation
;;; =========================================================
(def-mm-class |SubConversation| :BPMN (|ConversationNode|)
 ""
  ((|conversationNodes| :range |ConversationNode| :multiplicity (0 -1) :is-composite-p T)))


;;; =========================================================
;;; ====================== SubProcess
;;; =========================================================
(def-mm-class |SubProcess| :BPMN (|Activity| |FlowElementsContainer|)
 ""
  ((|artifacts| :range |Artifact| :multiplicity (0 -1) :is-composite-p T)
   (|triggeredByEvent| :range |Boolean| :multiplicity (1 1) :default :false)))


;;; =========================================================
;;; ====================== Task
;;; =========================================================
(def-mm-class |Task| :BPMN (|Activity| |InteractionNode|)
 ""
  ())


;;; =========================================================
;;; ====================== TerminateEventDefinition
;;; =========================================================
(def-mm-class |TerminateEventDefinition| :BPMN (|EventDefinition|)
 ""
  ())


;;; =========================================================
;;; ====================== TextAnnotation
;;; =========================================================
(def-mm-class |TextAnnotation| :BPMN (|Artifact|)
 ""
  ((|text| :range |String| :multiplicity (1 1))
   (|textFormat| :range |String| :multiplicity (1 1) :default :text/plain)))


;;; =========================================================
;;; ====================== ThrowEvent
;;; =========================================================
(def-mm-class |ThrowEvent| :BPMN (|Event|)
 ""
  ((|dataInputAssociation| :range |DataInputAssociation| :multiplicity (0 -1) :is-composite-p T)
   (|dataInputs| :range |DataInput| :multiplicity (0 -1) :is-composite-p T)
   (|eventDefinitionRefs| :range |EventDefinition| :multiplicity (0 -1))
   (|eventDefinitions| :range |EventDefinition| :multiplicity (0 -1) :is-composite-p T)
   (|inputSet| :range |InputSet| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== TimerEventDefinition
;;; =========================================================
(def-mm-class |TimerEventDefinition| :BPMN (|EventDefinition|)
 ""
  ((|timeCycle| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|timeDate| :range |Expression| :multiplicity (0 1) :is-composite-p T)
   (|timeDuration| :range |Expression| :multiplicity (0 1) :is-composite-p T)))


;;; =========================================================
;;; ====================== Transaction
;;; =========================================================
(def-mm-class |Transaction| :BPMN (|SubProcess|)
 ""
  ((|method| :range |String| :multiplicity (1 1))
   (|protocol| :range |String| :multiplicity (0 1))))


;;; =========================================================
;;; ====================== UserTask
;;; =========================================================
(def-mm-class |UserTask| :BPMN (|Task|)
 ""
  ((|implementation| :range |String| :multiplicity (1 1))
   (|renderings| :range |Rendering| :multiplicity (0 -1) :is-composite-p T)))


(def-mm-package BPMN NIL :BPMN 
   (|Interface|
    |Operation|
    |EndPoint|
    |Auditing|
    |GlobalTask|
    |Monitoring|
    |Performer|
    |Process|
    |ProcessType|
    |LaneSet|
    |Lane|
    |GlobalManualTask|
    |ManualTask|
    |UserTask|
    |Rendering|
    |HumanPerformer|
    |PotentialOwner|
    |GlobalUserTask|
    |Gateway|
    |GatewayDirection|
    |EventBasedGateway|
    |ComplexGateway|
    |ExclusiveGateway|
    |InclusiveGateway|
    |ParallelGateway|
    |EventBasedGatewayType|
    |RootElement|
    |Relationship|
    |BaseElement|
    |Extension|
    |ExtensionDefinition|
    |ExtensionAttributeDefinition|
    |ExtensionAttributeValue|
    |RelationshipDirection|
    |Documentation|
    |Event|
    |IntermediateCatchEvent|
    |IntermediateThrowEvent|
    |EndEvent|
    |StartEvent|
    |ThrowEvent|
    |CatchEvent|
    |BoundaryEvent|
    |EventDefinition|
    |CancelEventDefinition|
    |ErrorEventDefinition|
    |TerminateEventDefinition|
    |EscalationEventDefinition|
    |Escalation|
    |CompensateEventDefinition|
    |TimerEventDefinition|
    |LinkEventDefinition|
    |MessageEventDefinition|
    |ConditionalEventDefinition|
    |SignalEventDefinition|
    |Signal|
    |ImplicitThrowEvent|
    |DataState|
    |ItemAwareElement|
    |DataAssociation|
    |DataInput|
    |DataOutput|
    |InputSet|
    |OutputSet|
    |Property|
    |DataInputAssociation|
    |DataOutputAssociation|
    |InputOutputSpecification|
    |DataObject|
    |InputOutputBinding|
    |Assignment|
    |DataStore|
    |DataStoreReference|
    |DataObjectReference|
    |ConversationLink|
    |ConversationAssociation|
    |CallConversation|
    |Conversation|
    |SubConversation|
    |ConversationNode|
    |GlobalConversation|
    |PartnerEntity|
    |PartnerRole|
    |CorrelationProperty|
    |ItemKind|
    |Error|
    |CorrelationKey|
    |Expression|
    |FormalExpression|
    |Message|
    |ItemDefinition|
    |FlowElement|
    |SequenceFlow|
    |FlowElementsContainer|
    |CallableElement|
    |FlowNode|
    |CorrelationPropertyRetrievalExpression|
    |CorrelationPropertyBinding|
    |Resource|
    |ResourceParameter|
    |CorrelationSubscription|
    |MessageFlow|
    |MessageFlowAssociation|
    |InteractionNode|
    |Participant|
    |ParticipantAssociation|
    |ParticipantMultiplicity|
    |Collaboration|
    |ChoreographyActivity|
    |CallChoreography|
    |SubChoreography|
    |ChoreographyTask|
    |ChoreographyLoopType|
    |Choreography|
    |GlobalChoreographyTask|
    |TextAnnotation|
    |Group|
    |Association|
    |Category|
    |Artifact|
    |AssociationDirection|
    |CategoryValue|
    |Activity|
    |ServiceTask|
    |SubProcess|
    |LoopCharacteristics|
    |MultiInstanceBehavior|
    |MultiInstanceLoopCharacteristics|
    |StandardLoopCharacteristics|
    |CallActivity|
    |Task|
    |SendTask|
    |ReceiveTask|
    |ScriptTask|
    |BusinessRuleTask|
    |AdHocSubProcess|
    |AdHocOrdering|
    |Transaction|
    |GlobalScriptTask|
    |GlobalBusinessRuleTask|
    |ComplexBehaviorDefinition|
    |ResourceRole|
    |ResourceParameterBinding|
    |ResourceAssignmentExpression|
    |Import|
    |Definitions|))

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(BPMN::|Activity|
          BPMN::|Artifact|
          BPMN::|BaseElement|
          BPMN::|CallableElement|
          BPMN::|CatchEvent|
          BPMN::|ChoreographyActivity|
          BPMN::|ConversationNode|
          BPMN::|Event|
          BPMN::|EventDefinition|
          BPMN::|FlowElement|
          BPMN::|FlowElementsContainer|
          BPMN::|FlowNode|
          BPMN::|Gateway|
          BPMN::|InteractionNode|
          BPMN::|LoopCharacteristics|
          BPMN::|RootElement|
          BPMN::|ThrowEvent|))
     (setf mofi:ns-uri "http://www.omg.org/spec/BPMN/20100524/MODEL-XMI")
     (setf mofi:ns-prefix "bpmn"))