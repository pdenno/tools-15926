;;; Automatically created by pop-gen at 2013-12-14 20:17:57.
;;; Source file is NIL

(in-package :UML25)

;;; 2013-01-03 Added for bug reported by Ed Seidewitz. May want to do this for all metaobjects.
(mofi:shadow-and-warn "Variable" :UML25)


(def-meta-enum |AggregationKind| (:model :UML25 :superclasses NIL 
   :xmi-id "AggregationKind")
   (|none| |shared| |composite|)
   "AggregationKind is an Enumeration for specifying the kind of aggregation
    of a Property.")



(def-meta-enum |CallConcurrencyKind| (:model :UML25 :superclasses NIL 
   :xmi-id "CallConcurrencyKind")
   (|sequential| |guarded| |concurrent|)
   "CallConcurrencyKind is an Enumeration used to specify the semantics of
    concurrent calls to a BehavioralFeature.")



(def-meta-enum |ConnectorKind| (:model :UML25 :superclasses NIL 
   :xmi-id "ConnectorKind")
   (|assembly| |delegation|)
   "ConnectorKind is an enumeration that defines whether a Connector is an
    assembly or a delegation.")



(def-meta-enum |ExpansionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "ExpansionKind")
   (|parallel| |iterative| |stream|)
   "ExpansionKind is an enumeration type used to specify how an ExpansionRegion
    executes its contents.")



(def-meta-enum |InteractionOperatorKind| (:model :UML25 :superclasses NIL 
   :xmi-id "InteractionOperatorKind")
   (|seq| |alt| |opt| |break| |par| |strict| |loop| |critical| |neg| |assert| |ignore| |consider|)
   "InteractionOperatorKind is an enumeration designating the different kinds
    of operators of CombinedFragments. The InteractionOperand defines the type
    of operator of a CombinedFragment.")



(def-meta-enum |MessageKind| (:model :UML25 :superclasses NIL 
   :xmi-id "MessageKind")
   (|complete| |lost| |found| |unknown|)
   "This is an enumerated type that identifies the type of Message.")



(def-meta-enum |MessageSort| (:model :UML25 :superclasses NIL 
   :xmi-id "MessageSort")
   (|synchCall| |asynchCall| |asynchSignal| |createMessage| |deleteMessage| |reply|)
   "This is an enumerated type that identifies the type of communication action
    that was used to generate the Message.")



(def-meta-enum |ObjectNodeOrderingKind| (:model :UML25 :superclasses NIL 
   :xmi-id "ObjectNodeOrderingKind")
   (|unordered| |ordered| LIFO FIFO)
   "ObjectNodeOrderingKind is an enumeration indicating queuing order for offering
    the tokens held by an ObjectNode.")



(def-meta-enum |ParameterDirectionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "ParameterDirectionKind")
   (|in| |inout| |out| |return|)
   "ParameterDirectionKind is an Enumeration that defines literals used to
    specify direction of parameters.")



(def-meta-enum |ParameterEffectKind| (:model :UML25 :superclasses NIL 
   :xmi-id "ParameterEffectKind")
   (|create| |read| |update| |delete|)
   "ParameterEffectKind is an Enumeration that indicates the effect of a Behavior
    on values passed in or out of its parameters.")



(def-meta-enum |PseudostateKind| (:model :UML25 :superclasses NIL 
   :xmi-id "PseudostateKind")
   (|initial| |deepHistory| |shallowHistory| |join| |fork| |junction| |choice| |entryPoint| |exitPoint| |terminate|)
   "PseudostateKind is an Enumeration type that is used to differentiate various
    kinds of Pseudostates.")



(def-meta-enum |TransitionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "TransitionKind")
   (|internal| |local| |external|)
   "TransitionKind is an Enumeration type used to differentiate the various
    kinds of Transitions.")



(def-meta-enum |VisibilityKind| (:model :UML25 :superclasses NIL 
   :xmi-id "VisibilityKind")
   (|public| |private| |protected| |package|)
   "VisibilityKind is an enumeration type that defines literals to determine
    the visibility of Elements in a model.")



;;; =========================================================
;;; ====================== Abstraction
;;; =========================================================
(def-meta-class |Abstraction| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Abstraction")
 "An Abstraction is a Relationship that relates two Elements or sets of Elements
  that represent the same concept at different levels of abstraction or from
  different viewpoints."
  ((|mapping| :xmi-id "Abstraction-mapping" :range |OpaqueExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An OpaqueExpression that states the abstraction relationship between the
      supplier(s) and the client(s). In some cases, such as derivation, it is
      usually formal and unidirectional; in other cases, such as trace, it is
      usually informal and bidirectional. The mapping expression is optional
      and may be omitted if the precise relationship between the Elements is
      not specified.")))

(def-meta-assoc "A_mapping_abstraction"      
  :name |A_mapping_abstraction|      
  :metatype :association      
  :member-ends ((|Abstraction| "mapping")
                ("A_mapping_abstraction-abstraction" "abstraction"))      
  :owned-ends  (("A_mapping_abstraction-abstraction" "abstraction")))

(def-meta-assoc-end "A_mapping_abstraction-abstraction" 
    :type |Abstraction| 
    :multiplicity (0 1) 
    :association "A_mapping_abstraction" 
    :name "abstraction")

;;; =========================================================
;;; ====================== AcceptCallAction
;;; =========================================================
(def-meta-class |AcceptCallAction| 
   (:model :UML25 :superclasses (|AcceptEventAction|) 
    :packages (UML |Actions|) 
    :xmi-id "AcceptCallAction")
 "An AcceptCallAction is an AcceptEventAction that handles the receipt of
  a synchronous call request. In addition to the values from the Operation
  input parameters, the Action produces an output that is needed later to
  supply the information to the ReplyAction necessary to return control to
  the caller. An AcceptCallAction is for synchronous calls. If it is used
  to handle an asynchronous call, execution of the subsequent ReplyAction
  will complete immediately with no effect."
  ((|returnInformation| :xmi-id "AcceptCallAction-returnInformation" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "An OutputPin where a value is placed containing sufficient information
      to perform a subsequent ReplyAction and return control to the caller. The
      contents of this value are opaque. It can be passed and copied but it cannot
      be manipulated by the model.")))

(def-meta-assoc "A_returnInformation_acceptCallAction"      
  :name |A_returnInformation_acceptCallAction|      
  :metatype :association      
  :member-ends ((|AcceptCallAction| "returnInformation")
                ("A_returnInformation_acceptCallAction-acceptCallAction" "acceptCallAction"))      
  :owned-ends  (("A_returnInformation_acceptCallAction-acceptCallAction" "acceptCallAction")))

(def-meta-assoc-end "A_returnInformation_acceptCallAction-acceptCallAction" 
    :type |AcceptCallAction| 
    :multiplicity (0 1) 
    :association "A_returnInformation_acceptCallAction" 
    :name "acceptCallAction")

;;; =========================================================
;;; ====================== AcceptEventAction
;;; =========================================================
(def-meta-class |AcceptEventAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "AcceptEventAction")
 "An AcceptEventAction is an Action that waits for the occurrence of one
  or more specific Events."
  ((|isUnmarshall| :xmi-id "AcceptEventAction-isUnmarshall" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether there is a single OutputPin for a SignalEvent occurrence,
      or multiple OutputPins for attribute values of the instance of the Signal
      associated with a SignalEvent occurrence.")
   (|result| :xmi-id "AcceptEventAction-result" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "OutputPins holding the values received from an Event occurrence.")
   (|trigger| :xmi-id "AcceptEventAction-trigger" :range |Trigger| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The Triggers specifying the Events of which the AcceptEventAction waits
      for occurrences.")))

(def-meta-assoc "A_result_acceptEventAction"      
  :name |A_result_acceptEventAction|      
  :metatype :association      
  :member-ends ((|AcceptEventAction| "result")
                ("A_result_acceptEventAction-acceptEventAction" "acceptEventAction"))      
  :owned-ends  (("A_result_acceptEventAction-acceptEventAction" "acceptEventAction")))

(def-meta-assoc-end "A_result_acceptEventAction-acceptEventAction" 
    :type |AcceptEventAction| 
    :multiplicity (0 1) 
    :association "A_result_acceptEventAction" 
    :name "acceptEventAction")

(def-meta-assoc "A_trigger_acceptEventAction"      
  :name |A_trigger_acceptEventAction|      
  :metatype :association      
  :member-ends ((|AcceptEventAction| "trigger")
                ("A_trigger_acceptEventAction-acceptEventAction" "acceptEventAction"))      
  :owned-ends  (("A_trigger_acceptEventAction-acceptEventAction" "acceptEventAction")))

(def-meta-assoc-end "A_trigger_acceptEventAction-acceptEventAction" 
    :type |AcceptEventAction| 
    :multiplicity (0 1) 
    :association "A_trigger_acceptEventAction" 
    :name "acceptEventAction")

;;; =========================================================
;;; ====================== Action
;;; =========================================================
(def-meta-class |Action| 
   (:model :UML25 :superclasses (|ExecutableNode|) 
    :packages (UML |Actions|) 
    :xmi-id "Action")
 "An Action is the fundamental unit of executable functionality. The execution
  of an Action represents some transformation or processing in the modeled
  system. Actions provide the ExecutableNodes within Activities and may also
  be used within Interactions."
  ((|context| :xmi-id "Action-context" :range |Classifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The context Classifier of the Behavior that contains this Action, or the
      Behavior itself if it has no context.")
   (|input| :xmi-id "Action-input" :range |InputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ordered set of InputPins representing the inputs to the Action.")
   (|isLocallyReentrant| :xmi-id "Action-isLocallyReentrant" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Action can begin a new, concurrent execution, even if there
      is already another execution of the Action ongoing. If false, the Action
      cannot begin a new execution until any previous execution has completed.")
   (|localPostcondition| :xmi-id "Action-localPostcondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Constraint that must be satisfied when execution of the Action is completed.")
   (|localPrecondition| :xmi-id "Action-localPrecondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Constraint that must be satisfied when execution of the Action is started.")
   (|output| :xmi-id "Action-output" :range |OutputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ordered set of OutputPins representing outputs from the Action.")))

(def-meta-operation "allActions" |Action| 
   "Return this Action and all Actions contained directly or indirectly in
    it. By default only the Action itself is returned, but the operation is
    overridden for StructuredActivityNodes."
   :operation-body
   "result = (self->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Action|
                        :parameter-return-p T))
)

(def-meta-operation "allOwnedNodes" |Action| 
   "Returns all the ActivityNodes directly or indirectly owned by this Action.
    This includes at least all the Pins of the Action."
   :operation-body
   "result = (input.oclAsType(Pin)->asSet()->union(output->asSet()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ActivityNode|
                        :parameter-return-p T))
)

(def-meta-operation "containingBehavior" |Action| 
   ""
   :operation-body
   "result = (if inStructuredNode<>null then inStructuredNode.containingBehavior()   else if activity<>null then activity  else interaction   endif  endif  )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Behavior|
                        :parameter-return-p T))
)

(def-meta-operation "context.1" |Action| 
   "The derivation for the context property."
   :operation-body
   "result = (let behavior: Behavior = self.containingBehavior() in  if behavior=null then null  else if behavior._'context' = null then behavior  else behavior._'context'  endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-assoc "A_context_action"      
  :name |A_context_action|      
  :metatype :association      
  :member-ends ((|Action| "context")
                ("A_context_action-action" "action"))      
  :owned-ends  (("A_context_action-action" "action")))

(def-meta-assoc-end "A_context_action-action" 
    :type |Action| 
    :multiplicity (0 -1) 
    :association "A_context_action" 
    :name "action")

(def-meta-assoc "A_input_action"      
  :name |A_input_action|      
  :metatype :association      
  :member-ends ((|Action| "input")
                ("A_input_action-action" "action"))      
  :owned-ends  (("A_input_action-action" "action")))

(def-meta-assoc-end "A_input_action-action" 
    :type |Action| 
    :multiplicity (0 1) 
    :association "A_input_action" 
    :name "action")

(def-meta-assoc "A_localPostcondition_action"      
  :name |A_localPostcondition_action|      
  :metatype :association      
  :member-ends ((|Action| "localPostcondition")
                ("A_localPostcondition_action-action" "action"))      
  :owned-ends  (("A_localPostcondition_action-action" "action")))

(def-meta-assoc-end "A_localPostcondition_action-action" 
    :type |Action| 
    :multiplicity (0 1) 
    :association "A_localPostcondition_action" 
    :name "action")

(def-meta-assoc "A_localPrecondition_action"      
  :name |A_localPrecondition_action|      
  :metatype :association      
  :member-ends ((|Action| "localPrecondition")
                ("A_localPrecondition_action-action" "action"))      
  :owned-ends  (("A_localPrecondition_action-action" "action")))

(def-meta-assoc-end "A_localPrecondition_action-action" 
    :type |Action| 
    :multiplicity (0 1) 
    :association "A_localPrecondition_action" 
    :name "action")

(def-meta-assoc "A_output_action"      
  :name |A_output_action|      
  :metatype :association      
  :member-ends ((|Action| "output")
                ("A_output_action-action" "action"))      
  :owned-ends  (("A_output_action-action" "action")))

(def-meta-assoc-end "A_output_action-action" 
    :type |Action| 
    :multiplicity (0 1) 
    :association "A_output_action" 
    :name "action")

;;; =========================================================
;;; ====================== ActionExecutionSpecification
;;; =========================================================
(def-meta-class |ActionExecutionSpecification| 
   (:model :UML25 :superclasses (|ExecutionSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "ActionExecutionSpecification")
 "An ActionExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of an Action."
  ((|action| :xmi-id "ActionExecutionSpecification-action" :range |Action| :multiplicity (1 1)
    :documentation
     "Action whose execution is occurring.")))

(def-meta-assoc "A_action_actionExecutionSpecification"      
  :name |A_action_actionExecutionSpecification|      
  :metatype :association      
  :member-ends ((|ActionExecutionSpecification| "action")
                ("A_action_actionExecutionSpecification-actionExecutionSpecification" "actionExecutionSpecification"))      
  :owned-ends  (("A_action_actionExecutionSpecification-actionExecutionSpecification" "actionExecutionSpecification")))

(def-meta-assoc-end "A_action_actionExecutionSpecification-actionExecutionSpecification" 
    :type |ActionExecutionSpecification| 
    :multiplicity (0 -1) 
    :association "A_action_actionExecutionSpecification" 
    :name "actionExecutionSpecification")

;;; =========================================================
;;; ====================== ActionInputPin
;;; =========================================================
(def-meta-class |ActionInputPin| 
   (:model :UML25 :superclasses (|InputPin|) 
    :packages (UML |Actions|) 
    :xmi-id "ActionInputPin")
 "An ActionInputPin is a kind of InputPin that executes an Action to determine
  the values to input to another Action."
  ((|fromAction| :xmi-id "ActionInputPin-fromAction" :range |Action| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The Action used to provide the values of the ActionInputPin.")))

(def-meta-assoc "A_fromAction_actionInputPin"      
  :name |A_fromAction_actionInputPin|      
  :metatype :association      
  :member-ends ((|ActionInputPin| "fromAction")
                ("A_fromAction_actionInputPin-actionInputPin" "actionInputPin"))      
  :owned-ends  (("A_fromAction_actionInputPin-actionInputPin" "actionInputPin")))

(def-meta-assoc-end "A_fromAction_actionInputPin-actionInputPin" 
    :type |ActionInputPin| 
    :multiplicity (0 1) 
    :association "A_fromAction_actionInputPin" 
    :name "actionInputPin")

;;; =========================================================
;;; ====================== Activity
;;; =========================================================
(def-meta-class |Activity| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |Activities|) 
    :xmi-id "Activity")
 "An Activity is the specification of parameterized Behavior as the coordinated
  sequencing of subordinate units."
  ((|edge| :xmi-id "Activity-edge" :range |ActivityEdge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityEdge| |activity|)
    :documentation
     "ActivityEdges expressing flow between the nodes of the Activity.")
   (|group| :xmi-id "Activity-group" :range |ActivityGroup| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |inActivity|)
    :documentation
     "Top-level ActivityGroups in the Activity.")
   (|isReadOnly| :xmi-id "Activity-isReadOnly" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, this Activity must not make any changes to objects. The default
      is false (an Activity may make nonlocal changes). (This is an assertion,
      not an executable property. It may be used by an execution engine to optimize
      model execution. If the assertion is violated by the Activity, then the
      model is ill-formed.)")
   (|isSingleExecution| :xmi-id "Activity-isSingleExecution" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, all invocations of the Activity are handled by the same execution.")
   (|node| :xmi-id "Activity-node" :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityNode| |activity|)
    :documentation
     "ActivityNodes coordinated by the Activity.")
   (|partition| :xmi-id "Activity-partition" :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|Activity| |group|))
    :documentation
     "Top-level ActivityPartitions in the Activity.")
   (|structuredNode| :xmi-id "Activity-structuredNode" :range |StructuredActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Activity| |group|) (|Activity| |node|))
    :opposite (|StructuredActivityNode| |activity|)
    :documentation
     "Top-level StructuredActivityNodes in the Activity.")
   (|variable| :xmi-id "Activity-variable" :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |activityScope|)
    :documentation
     "Top-level Variables defined by the Activity.")))

(def-meta-assoc "A_edge_activity"      
  :name |A_edge_activity|      
  :metatype :association      
  :member-ends ((|Activity| "edge")
                (|ActivityEdge| "activity"))      
  :owned-ends  ())

(def-meta-assoc "A_group_inActivity"      
  :name |A_group_inActivity|      
  :metatype :association      
  :member-ends ((|Activity| "group")
                (|ActivityGroup| "inActivity"))      
  :owned-ends  ())

(def-meta-assoc "A_node_activity"      
  :name |A_node_activity|      
  :metatype :association      
  :member-ends ((|Activity| "node")
                (|ActivityNode| "activity"))      
  :owned-ends  ())

(def-meta-assoc "A_partition_activity"      
  :name |A_partition_activity|      
  :metatype :association      
  :member-ends ((|Activity| "partition")
                ("A_partition_activity-activity" "activity"))      
  :owned-ends  (("A_partition_activity-activity" "activity")))

(def-meta-assoc-end "A_partition_activity-activity" 
    :type |Activity| 
    :multiplicity (0 1) 
    :association "A_partition_activity" 
    :name "activity")

(def-meta-assoc "A_structuredNode_activity"      
  :name |A_structuredNode_activity|      
  :metatype :association      
  :member-ends ((|Activity| "structuredNode")
                (|StructuredActivityNode| "activity"))      
  :owned-ends  ())

(def-meta-assoc "A_variable_activityScope"      
  :name |A_variable_activityScope|      
  :metatype :association      
  :member-ends ((|Activity| "variable")
                (|Variable| "activityScope"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ActivityEdge
;;; =========================================================
(def-meta-class |ActivityEdge| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityEdge")
 "An ActivityEdge is an abstract class for directed connections between two
  ActivityNodes."
  ((|activity| :xmi-id "ActivityEdge-activity" :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |edge|)
    :documentation
     "The Activity containing the ActivityEdge, if it is directly owned by an
      Activity.")
   (|guard| :xmi-id "ActivityEdge-guard" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification that is evaluated to determine if a token can traverse
      the ActivityEdge. If an ActivityEdge has no guard, then there is no restriction
      on tokens traversing the edge.")
   (|inGroup| :xmi-id "ActivityEdge-inGroup" :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedEdge|)
    :documentation
     "ActivityGroups containing the ActivityEdge.")
   (|inPartition| :xmi-id "ActivityEdge-inPartition" :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityEdge| |inGroup|))
    :opposite (|ActivityPartition| |edge|)
    :documentation
     "ActivityPartitions containing the ActivityEdge.")
   (|inStructuredNode| :xmi-id "ActivityEdge-inStructuredNode" :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|ActivityEdge| |inGroup|) (|Element| |owner|))
    :opposite (|StructuredActivityNode| |edge|)
    :documentation
     "The StructuredActivityNode containing the ActivityEdge, if it is owned
      by a StructuredActivityNode.")
   (|interrupts| :xmi-id "ActivityEdge-interrupts" :range |InterruptibleActivityRegion| :multiplicity (0 1)
    :opposite (|InterruptibleActivityRegion| |interruptingEdge|)
    :documentation
     "The InterruptibleActivityRegion for which this ActivityEdge is an interruptingEdge.")
   (|redefinedEdge| :xmi-id "ActivityEdge-redefinedEdge" :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "ActivityEdges from a generalization of the Activity containing this ActivityEdge
      that are redefined by this ActivityEdge.")
   (|source| :xmi-id "ActivityEdge-source" :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |outgoing|)
    :documentation
     "The ActivityNode from which tokens are taken when they traverse the ActivityEdge.")
   (|target| :xmi-id "ActivityEdge-target" :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |incoming|)
    :documentation
     "The ActivityNode to which tokens are put when they traverse the ActivityEdge.")
   (|weight| :xmi-id "ActivityEdge-weight" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The minimum number of tokens that must traverse the ActivityEdge at the
      same time. If no weight is specified, this is equivalent to specifying
      a constant value of 1.")))

(def-meta-operation "isConsistentWith" |ActivityEdge| 
   ""
   :operation-body
   "result = (redefiningElement.oclIsKindOf(ActivityEdge))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_guard_activityEdge"      
  :name |A_guard_activityEdge|      
  :metatype :association      
  :member-ends ((|ActivityEdge| "guard")
                ("A_guard_activityEdge-activityEdge" "activityEdge"))      
  :owned-ends  (("A_guard_activityEdge-activityEdge" "activityEdge")))

(def-meta-assoc-end "A_guard_activityEdge-activityEdge" 
    :type |ActivityEdge| 
    :multiplicity (0 1) 
    :association "A_guard_activityEdge" 
    :name "activityEdge")

(def-meta-assoc "A_redefinedEdge_activityEdge"      
  :name |A_redefinedEdge_activityEdge|      
  :metatype :association      
  :member-ends ((|ActivityEdge| "redefinedEdge")
                ("A_redefinedEdge_activityEdge-activityEdge" "activityEdge"))      
  :owned-ends  (("A_redefinedEdge_activityEdge-activityEdge" "activityEdge")))

(def-meta-assoc-end "A_redefinedEdge_activityEdge-activityEdge" 
    :type |ActivityEdge| 
    :multiplicity (0 -1) 
    :association "A_redefinedEdge_activityEdge" 
    :name "activityEdge")

(def-meta-assoc "A_weight_activityEdge"      
  :name |A_weight_activityEdge|      
  :metatype :association      
  :member-ends ((|ActivityEdge| "weight")
                ("A_weight_activityEdge-activityEdge" "activityEdge"))      
  :owned-ends  (("A_weight_activityEdge-activityEdge" "activityEdge")))

(def-meta-assoc-end "A_weight_activityEdge-activityEdge" 
    :type |ActivityEdge| 
    :multiplicity (0 1) 
    :association "A_weight_activityEdge" 
    :name "activityEdge")

;;; =========================================================
;;; ====================== ActivityFinalNode
;;; =========================================================
(def-meta-class |ActivityFinalNode| 
   (:model :UML25 :superclasses (|FinalNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityFinalNode")
 "An ActivityFinalNode is a FinalNode that terminates the execution of its
  owning Activity or StructuredActivityNode."
  ())

;;; =========================================================
;;; ====================== ActivityGroup
;;; =========================================================
(def-meta-class |ActivityGroup| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityGroup")
 "ActivityGroup is an abstract class for defining sets of ActivityNodes and
  ActivityEdges in an Activity."
  ((|containedEdge| :xmi-id "ActivityGroup-containedEdge" :range |ActivityEdge| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityEdge| |inGroup|)
    :documentation
     "ActivityEdges immediately contained in the ActivityGroup.")
   (|containedNode| :xmi-id "ActivityGroup-containedNode" :range |ActivityNode| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityNode| |inGroup|)
    :documentation
     "ActivityNodes immediately contained in the ActivityGroup.")
   (|inActivity| :xmi-id "ActivityGroup-inActivity" :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |group|)
    :documentation
     "The Activity containing the ActivityGroup, if it is directly owned by an
      Activity.")
   (|subgroup| :xmi-id "ActivityGroup-subgroup" :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |superGroup|)
    :documentation
     "Other ActivityGroups immediately contained in this ActivityGroup.")
   (|superGroup| :xmi-id "ActivityGroup-superGroup" :range |ActivityGroup| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|ActivityGroup| |subgroup|)
    :documentation
     "The ActivityGroup immediately containing this ActivityGroup, if it is directly
      owned by another ActivityGroup.")))

(def-meta-operation "containingActivity" |ActivityGroup| 
   "The Activity that directly or indirectly contains this ActivityGroup."
   :operation-body
   "result = (if superGroup<>null then superGroup.containingActivity()  else inActivity  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Activity|
                        :parameter-return-p T))
)

(def-meta-assoc "A_containedEdge_inGroup"      
  :name |A_containedEdge_inGroup|      
  :metatype :association      
  :member-ends ((|ActivityGroup| "containedEdge")
                (|ActivityEdge| "inGroup"))      
  :owned-ends  ())

(def-meta-assoc "A_containedNode_inGroup"      
  :name |A_containedNode_inGroup|      
  :metatype :association      
  :member-ends ((|ActivityGroup| "containedNode")
                (|ActivityNode| "inGroup"))      
  :owned-ends  ())

(def-meta-assoc "A_subgroup_superGroup"      
  :name |A_subgroup_superGroup|      
  :metatype :association      
  :member-ends ((|ActivityGroup| "subgroup")
                (|ActivityGroup| "superGroup"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ActivityNode
;;; =========================================================
(def-meta-class |ActivityNode| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityNode")
 "ActivityNode is an abstract class for points in the flow of an Activity
  connected by ActivityEdges."
  ((|activity| :xmi-id "ActivityNode-activity" :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |node|)
    :documentation
     "The Activity containing the ActivityNode, if it is directly owned by an
      Activity.")
   (|inGroup| :xmi-id "ActivityNode-inGroup" :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedNode|)
    :documentation
     "ActivityGroups containing the ActivityNode.")
   (|inInterruptibleRegion| :xmi-id "ActivityNode-inInterruptibleRegion" :range |InterruptibleActivityRegion| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|InterruptibleActivityRegion| |node|)
    :documentation
     "InterruptibleActivityRegions containing the ActivityNode.")
   (|inPartition| :xmi-id "ActivityNode-inPartition" :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|ActivityPartition| |node|)
    :documentation
     "ActivityPartitions containing the ActivityNode.")
   (|inStructuredNode| :xmi-id "ActivityNode-inStructuredNode" :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|ActivityNode| |inGroup|) (|Element| |owner|))
    :opposite (|StructuredActivityNode| |node|)
    :documentation
     "The StructuredActivityNode containing the ActvityNode, if it is directly
      owned by a StructuredActivityNode.")
   (|incoming| :xmi-id "ActivityNode-incoming" :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |target|)
    :documentation
     "ActivityEdges that have the ActivityNode as their target.")
   (|outgoing| :xmi-id "ActivityNode-outgoing" :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |source|)
    :documentation
     "ActivityEdges that have the ActivityNode as their source.")
   (|redefinedNode| :xmi-id "ActivityNode-redefinedNode" :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "ActivityNodes from a generalization of the Activity containining this ActivityNode
      that are redefined by this ActivityNode.")))

(def-meta-operation "containingActivity" |ActivityNode| 
   "The Activity that directly or indirectly contains this ActivityNode."
   :operation-body
   "result = (if inStructuredNode<>null then inStructuredNode.containingActivity()  else activity  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Activity|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |ActivityNode| 
   ""
   :operation-body
   "result = (redefiningElement.oclIsKindOf(ActivityNode))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_inInterruptibleRegion_node"      
  :name |A_inInterruptibleRegion_node|      
  :metatype :association      
  :member-ends ((|ActivityNode| "inInterruptibleRegion")
                (|InterruptibleActivityRegion| "node"))      
  :owned-ends  ())

(def-meta-assoc "A_inPartition_node"      
  :name |A_inPartition_node|      
  :metatype :association      
  :member-ends ((|ActivityNode| "inPartition")
                (|ActivityPartition| "node"))      
  :owned-ends  ())

(def-meta-assoc "A_incoming_target_node"      
  :name |A_incoming_target_node|      
  :metatype :association      
  :member-ends ((|ActivityNode| "incoming")
                (|ActivityEdge| "target"))      
  :owned-ends  ())

(def-meta-assoc "A_outgoing_source_node"      
  :name |A_outgoing_source_node|      
  :metatype :association      
  :member-ends ((|ActivityNode| "outgoing")
                (|ActivityEdge| "source"))      
  :owned-ends  ())

(def-meta-assoc "A_redefinedNode_activityNode"      
  :name |A_redefinedNode_activityNode|      
  :metatype :association      
  :member-ends ((|ActivityNode| "redefinedNode")
                ("A_redefinedNode_activityNode-activityNode" "activityNode"))      
  :owned-ends  (("A_redefinedNode_activityNode-activityNode" "activityNode")))

(def-meta-assoc-end "A_redefinedNode_activityNode-activityNode" 
    :type |ActivityNode| 
    :multiplicity (0 -1) 
    :association "A_redefinedNode_activityNode" 
    :name "activityNode")

;;; =========================================================
;;; ====================== ActivityParameterNode
;;; =========================================================
(def-meta-class |ActivityParameterNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityParameterNode")
 "An ActivityParameterNode is an ObjectNode for accepting values from the
  input Parameters or providing values to the output Parameters of an Activity."
  ((|parameter| :xmi-id "ActivityParameterNode-parameter" :range |Parameter| :multiplicity (1 1)
    :documentation
     "The Parameter for which the ActivityParameterNode will be accepting or
      providing values.")))

(def-meta-assoc "A_parameter_activityParameterNode"      
  :name |A_parameter_activityParameterNode|      
  :metatype :association      
  :member-ends ((|ActivityParameterNode| "parameter")
                ("A_parameter_activityParameterNode-activityParameterNode" "activityParameterNode"))      
  :owned-ends  (("A_parameter_activityParameterNode-activityParameterNode" "activityParameterNode")))

(def-meta-assoc-end "A_parameter_activityParameterNode-activityParameterNode" 
    :type |ActivityParameterNode| 
    :multiplicity (0 -1) 
    :association "A_parameter_activityParameterNode" 
    :name "activityParameterNode")

;;; =========================================================
;;; ====================== ActivityPartition
;;; =========================================================
(def-meta-class |ActivityPartition| 
   (:model :UML25 :superclasses (|ActivityGroup|) 
    :packages (UML |Activities|) 
    :xmi-id "ActivityPartition")
 "An ActivityPartition is a kind of ActivityGroup for identifying ActivityNodes
  that have some characteristic in common."
  ((|edge| :xmi-id "ActivityPartition-edge" :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedEdge|))
    :opposite (|ActivityEdge| |inPartition|)
    :documentation
     "ActivityEdges immediately contained in the ActivityPartition.")
   (|isDimension| :xmi-id "ActivityPartition-isDimension" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the ActivityPartition groups other ActivityPartitions
      along a dimension.")
   (|isExternal| :xmi-id "ActivityPartition-isExternal" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the ActivityPartition represents an entity to which the
      partitioning structure does not apply.")
   (|node| :xmi-id "ActivityPartition-node" :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inPartition|)
    :documentation
     "ActivityNodes immediately contained in the ActivityPartition.")
   (|represents| :xmi-id "ActivityPartition-represents" :range |Element| :multiplicity (0 1)
    :documentation
     "An Element represented by the functionality modeled within the ActivityPartition.")
   (|subpartition| :xmi-id "ActivityPartition-subpartition" :range |ActivityPartition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |subgroup|))
    :opposite (|ActivityPartition| |superPartition|)
    :documentation
     "Other ActivityPartitions immediately contained in this ActivityPartition
      (as its subgroups).")
   (|superPartition| :xmi-id "ActivityPartition-superPartition" :range |ActivityPartition| :multiplicity (0 1)
    :subsetted-properties ((|ActivityGroup| |superGroup|))
    :opposite (|ActivityPartition| |subpartition|)
    :documentation
     "Other ActivityPartitions immediately containing this ActivityPartition
      (as its superGroups).")))

(def-meta-assoc "A_edge_inPartition"      
  :name |A_edge_inPartition|      
  :metatype :association      
  :member-ends ((|ActivityPartition| "edge")
                (|ActivityEdge| "inPartition"))      
  :owned-ends  ())

(def-meta-assoc "A_represents_activityPartition"      
  :name |A_represents_activityPartition|      
  :metatype :association      
  :member-ends ((|ActivityPartition| "represents")
                ("A_represents_activityPartition-activityPartition" "activityPartition"))      
  :owned-ends  (("A_represents_activityPartition-activityPartition" "activityPartition")))

(def-meta-assoc-end "A_represents_activityPartition-activityPartition" 
    :type |ActivityPartition| 
    :multiplicity (0 -1) 
    :association "A_represents_activityPartition" 
    :name "activityPartition")

(def-meta-assoc "A_subpartition_superPartition"      
  :name |A_subpartition_superPartition|      
  :metatype :association      
  :member-ends ((|ActivityPartition| "subpartition")
                (|ActivityPartition| "superPartition"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Actor
;;; =========================================================
(def-meta-class |Actor| 
   (:model :UML25 :superclasses (|BehavioredClassifier|) 
    :packages (UML |UseCases|) 
    :xmi-id "Actor")
 "An Actor specifies a role played by a user or any other system that interacts
  with the subject."
  ())

;;; =========================================================
;;; ====================== AddStructuralFeatureValueAction
;;; =========================================================
(def-meta-class |AddStructuralFeatureValueAction| 
   (:model :UML25 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "AddStructuralFeatureValueAction")
 "An AddStructuralFeatureValueAction is a WriteStructuralFeatureAction for
  adding values to a StructuralFeature."
  ((|insertAt| :xmi-id "AddStructuralFeatureValueAction-insertAt" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that gives the position at which to insert the value in an
      ordered StructuralFeature. The type of the insertAt InputPin is UnlimitedNatural,
      but the value cannot be zero. It is omitted for unordered StructuralFeatures.")
   (|isReplaceAll| :xmi-id "AddStructuralFeatureValueAction-isReplaceAll" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the StructuralFeature should be removed
      before adding the new value.")))

(def-meta-assoc "A_insertAt_addStructuralFeatureValueAction"      
  :name |A_insertAt_addStructuralFeatureValueAction|      
  :metatype :association      
  :member-ends ((|AddStructuralFeatureValueAction| "insertAt")
                ("A_insertAt_addStructuralFeatureValueAction-addStructuralFeatureValueAction" "addStructuralFeatureValueAction"))      
  :owned-ends  (("A_insertAt_addStructuralFeatureValueAction-addStructuralFeatureValueAction" "addStructuralFeatureValueAction")))

(def-meta-assoc-end "A_insertAt_addStructuralFeatureValueAction-addStructuralFeatureValueAction" 
    :type |AddStructuralFeatureValueAction| 
    :multiplicity (0 1) 
    :association "A_insertAt_addStructuralFeatureValueAction" 
    :name "addStructuralFeatureValueAction")

;;; =========================================================
;;; ====================== AddVariableValueAction
;;; =========================================================
(def-meta-class |AddVariableValueAction| 
   (:model :UML25 :superclasses (|WriteVariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "AddVariableValueAction")
 "An AddVariableValueAction is a WriteVariableAction for adding values to
  a Variable."
  ((|insertAt| :xmi-id "AddVariableValueAction-insertAt" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that gives the position at which to insert a new value or
      move an existing value in ordered Variables. The type of the insertAt InputPin
      is UnlimitedNatural, but the value cannot be zero. It is omitted for unordered
      Variables.")
   (|isReplaceAll| :xmi-id "AddVariableValueAction-isReplaceAll" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the Variable should be removed before
      adding the new value.")))

(def-meta-assoc "A_insertAt_addVariableValueAction"      
  :name |A_insertAt_addVariableValueAction|      
  :metatype :association      
  :member-ends ((|AddVariableValueAction| "insertAt")
                ("A_insertAt_addVariableValueAction-addVariableValueAction" "addVariableValueAction"))      
  :owned-ends  (("A_insertAt_addVariableValueAction-addVariableValueAction" "addVariableValueAction")))

(def-meta-assoc-end "A_insertAt_addVariableValueAction-addVariableValueAction" 
    :type |AddVariableValueAction| 
    :multiplicity (0 1) 
    :association "A_insertAt_addVariableValueAction" 
    :name "addVariableValueAction")

;;; =========================================================
;;; ====================== AnyReceiveEvent
;;; =========================================================
(def-meta-class |AnyReceiveEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "AnyReceiveEvent")
 "A trigger for an AnyReceiveEvent is triggered by the receipt of any message
  that is not explicitly handled by any related trigger."
  ())

;;; =========================================================
;;; ====================== Artifact
;;; =========================================================
(def-meta-class |Artifact| 
   (:model :UML25 :superclasses (|Classifier| |DeployedArtifact|) 
    :packages (UML |Deployments|) 
    :xmi-id "Artifact")
 "An artifact is the specification of a physical piece of information that
  is used or produced by a software development process, or by deployment
  and operation of a system. Examples of artifacts include model files, source
  files, scripts, and binary executable files, a table in a database system,
  a development deliverable, or a word-processing document, a mail message.
  An artifact is the source of a deployment to a node."
  ((|fileName| :xmi-id "Artifact-fileName" :range |String| :multiplicity (0 1)
    :documentation
     "A concrete name that is used to refer to the Artifact in a physical context.
      Example: file system name, universal resource locator.")
   (|manifestation| :xmi-id "Artifact-manifestation" :range |Manifestation| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :documentation
     "The set of model elements that are manifested in the Artifact. That is,
      these model elements are utilized in the construction (or generation) of
      the artifact.")
   (|nestedArtifact| :xmi-id "Artifact-nestedArtifact" :range |Artifact| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The Artifacts that are defined (nested) within the Artifact. The association
      is a specialization of the ownedMember association from Namespace to NamedElement.")
   (|ownedAttribute| :xmi-id "Artifact-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :documentation
     "The attributes or association ends defined for the Artifact. The association
      is a specialization of the ownedMember association.")
   (|ownedOperation| :xmi-id "Artifact-ownedOperation" :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "The Operations defined for the Artifact. The association is a specialization
      of the ownedMember association.")))

(def-meta-assoc "A_manifestation_artifact"      
  :name |A_manifestation_artifact|      
  :metatype :association      
  :member-ends ((|Artifact| "manifestation")
                ("A_manifestation_artifact-artifact" "artifact"))      
  :owned-ends  (("A_manifestation_artifact-artifact" "artifact")))

(def-meta-assoc-end "A_manifestation_artifact-artifact" 
    :type |Artifact| 
    :multiplicity (1 1) 
    :association "A_manifestation_artifact" 
    :name "artifact")

(def-meta-assoc "A_nestedArtifact_artifact"      
  :name |A_nestedArtifact_artifact|      
  :metatype :association      
  :member-ends ((|Artifact| "nestedArtifact")
                ("A_nestedArtifact_artifact-artifact" "artifact"))      
  :owned-ends  (("A_nestedArtifact_artifact-artifact" "artifact")))

(def-meta-assoc-end "A_nestedArtifact_artifact-artifact" 
    :type |Artifact| 
    :multiplicity (0 1) 
    :association "A_nestedArtifact_artifact" 
    :name "artifact")

(def-meta-assoc "A_ownedAttribute_artifact"      
  :name |A_ownedAttribute_artifact|      
  :metatype :association      
  :member-ends ((|Artifact| "ownedAttribute")
                ("A_ownedAttribute_artifact-artifact" "artifact"))      
  :owned-ends  (("A_ownedAttribute_artifact-artifact" "artifact")))

(def-meta-assoc-end "A_ownedAttribute_artifact-artifact" 
    :type |Artifact| 
    :multiplicity (0 1) 
    :association "A_ownedAttribute_artifact" 
    :name "artifact")

(def-meta-assoc "A_ownedOperation_artifact"      
  :name |A_ownedOperation_artifact|      
  :metatype :association      
  :member-ends ((|Artifact| "ownedOperation")
                ("A_ownedOperation_artifact-artifact" "artifact"))      
  :owned-ends  (("A_ownedOperation_artifact-artifact" "artifact")))

(def-meta-assoc-end "A_ownedOperation_artifact-artifact" 
    :type |Artifact| 
    :multiplicity (0 1) 
    :association "A_ownedOperation_artifact" 
    :name "artifact")

;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-meta-class |Association| 
   (:model :UML25 :superclasses (|Relationship| |Classifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Association")
 "A link is a tuple of values that refer to typed objects.  An Association
  classifies a set of links, each of which is an instance of the Association.
   Each value in the link refers to an instance of the type of the corresponding
  end of the Association."
  ((|endType| :xmi-id "Association-endType" :range |Type| :multiplicity (1 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "The Classifiers that are used as types of the ends of the Association.")
   (|isDerived| :xmi-id "Association-isDerived" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the Association is derived from other model elements
      such as other Associations.")
   (|memberEnd| :xmi-id "Association-memberEnd" :range |Property| :multiplicity (2 -1) :is-ordered-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Property| |association|)
    :documentation
     "Each end represents participation of instances of the Classifier connected
      to the end in links of the Association.")
   (|navigableOwnedEnd| :xmi-id "Association-navigableOwnedEnd" :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|Association| |ownedEnd|))
    :documentation
     "The navigable ends that are owned by the Association itself.")
   (|ownedEnd| :xmi-id "Association-ownedEnd" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Association| |memberEnd|) (|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Property| |owningAssociation|)
    :documentation
     "The ends that are owned by the Association itself.")))

(def-meta-operation "endType.1" |Association| 
   "endType is derived from the types of the member ends."
   :operation-body
   "result = (memberEnd->collect(type)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-assoc "A_endType_association"      
  :name |A_endType_association|      
  :metatype :association      
  :member-ends ((|Association| "endType")
                ("A_endType_association-association" "association"))      
  :owned-ends  (("A_endType_association-association" "association")))

(def-meta-assoc-end "A_endType_association-association" 
    :type |Association| 
    :multiplicity (0 -1) 
    :association "A_endType_association" 
    :name "association")

(def-meta-assoc "A_memberEnd_association"      
  :name |A_memberEnd_association|      
  :metatype :association      
  :member-ends ((|Association| "memberEnd")
                (|Property| "association"))      
  :owned-ends  ())

(def-meta-assoc "A_navigableOwnedEnd_association"      
  :name |A_navigableOwnedEnd_association|      
  :metatype :association      
  :member-ends ((|Association| "navigableOwnedEnd")
                ("A_navigableOwnedEnd_association-association" "association"))      
  :owned-ends  (("A_navigableOwnedEnd_association-association" "association")))

(def-meta-assoc-end "A_navigableOwnedEnd_association-association" 
    :type |Association| 
    :multiplicity (0 1) 
    :association "A_navigableOwnedEnd_association" 
    :name "association")

(def-meta-assoc "A_ownedEnd_owningAssociation"      
  :name |A_ownedEnd_owningAssociation|      
  :metatype :association      
  :member-ends ((|Association| "ownedEnd")
                (|Property| "owningAssociation"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== AssociationClass
;;; =========================================================
(def-meta-class |AssociationClass| 
   (:model :UML25 :superclasses (|Class| |Association|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "AssociationClass")
 "A model element that has both Association and Class properties. An AssociationClass
  can be seen as an Association that also has Class properties, or as a Class
  that also has Association properties. It not only connects a set of Classifiers
  but also defines a set of Features that belong to the Association itself
  and not to any of the associated Classifiers."
  ())

;;; =========================================================
;;; ====================== Behavior
;;; =========================================================
(def-meta-class |Behavior| 
   (:model :UML25 :superclasses (|Class|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "Behavior")
 "Behavior is a specification of how its context BehavioredClassifier changes
  state over time. This specification may be either a definition of possible
  behavior execution or emergent behavior, or a selective illustration of
  an interesting subset of possible executions. The latter form is typically
  used for capturing examples, such as a trace of a particular execution."
  ((|context| :xmi-id "Behavior-context" :range |BehavioredClassifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|))
    :documentation
     "The BehavioredClassifier that is the context for the execution of the Behavior.
      A Behavior that is directly owned as a nestedClassifier does not have a
      context. Otherwise, to determine the context of a Behavior, find the first
      BehavioredClassifier reached by following the chain of owner relationships
      from the Behavior, if any. If there is such a BehavioredClassifier, then
      it is the context, unless it is itself a Behavior with a non-empty context,
      in which case that is also the context for the original Behavior. For example,
      following this algorithm, the context of an entry Behavior in a StateMachine
      is the BehavioredClassifier that owns the StateMachine. The features of
      the context BehavioredClassifier as well as the Elements visible to the
      context Classifier are visible to the Behavior.")
   (|isReentrant| :xmi-id "Behavior-isReentrant" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether the Behavior can be invoked while it is still executing from
      a previous invocation.")
   (|ownedParameter| :xmi-id "Behavior-ownedParameter" :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References a list of Parameters to the Behavior which describes the order
      and type of arguments that can be given when the Behavior is invoked and
      of the values which will be returned when the Behavior completes its execution.")
   (|ownedParameterSet| :xmi-id "Behavior-ownedParameterSet" :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The ParameterSets owned by this Behavior.")
   (|postcondition| :xmi-id "Behavior-postcondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying what is fulfilled after the execution
      of the Behavior is completed, if its precondition was fulfilled before
      its invocation.")
   (|precondition| :xmi-id "Behavior-precondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying what must be fulfilled before
      the Behavior is invoked.")
   (|redefinedBehavior| :xmi-id "Behavior-redefinedBehavior" :range |Behavior| :multiplicity (0 -1)
    :subsetted-properties ((|Classifier| |redefinedClassifier|))
    :documentation
     "References the Behavior that this Behavior redefines. A subtype of Behavior
      may redefine any other subtype of Behavior. If the Behavior implements
      a BehavioralFeature, it replaces the redefined Behavior. If the Behavior
      is a classifierBehavior, it extends the redefined Behavior.")
   (|specification| :xmi-id "Behavior-specification" :range |BehavioralFeature| :multiplicity (0 1)
    :opposite (|BehavioralFeature| |method|)
    :documentation
     "Designates a BehavioralFeature that the Behavior implements. The BehavioralFeature
      must be owned by the BehavioredClassifier that owns the Behavior or be
      inherited by it. The Parameters of the BehavioralFeature and the implementing
      Behavior must match. A Behavior does not need to have a specification,
      in which case it either is the classifierBehavior of a BehavioredClassifier
      or it can only be invoked by another Behavior of the Classifier.")))

(def-meta-operation "behavioredClassifier" |Behavior| 
   "The first BehavioredClassifier reached by following the chain of owner
    relationships from the Behavior, if any."
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name '|from| :parameter-type '|Element|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|BehavioredClassifier|
                        :parameter-return-p T))
)

(def-meta-operation "context.1" |Behavior| 
   "A Behavior that is directly owned as a nestedClassifier does not have a
    context. Otherwise, to determine the context of a Behavior, find the first
    BehavioredClassifier reached by following the chain of owner relationships
    from the Behavior, if any. If there is such a BehavioredClassifier, then
    it is the context, unless it is itself a Behavior with a non-empty context,
    in which case that is also the context for the original Behavior."
   :operation-body
   "result = (if nestingClass <> null then      null  else      let b:BehavioredClassifier = self.behavioredClassifier(self.owner) in      if b.oclIsKindOf(Behavior) and b.oclAsType(Behavior)._'context' <> null then           b.oclAsType(Behavior)._'context'      else           b       endif  endif          )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|BehavioredClassifier|
                        :parameter-return-p T))
)

(def-meta-operation "inputParameters" |Behavior| 
   "The in and inout ownedParameters of the Behavior."
   :operation-body
   "result = (ownedParameter->select(direction=ParameterDirectionKind::_'in' or direction=ParameterDirectionKind::inout))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "outputParameters" |Behavior| 
   "The out, inout and return ownedParameters."
   :operation-body
   "result = (ownedParameter->select(direction=ParameterDirectionKind::out or direction=ParameterDirectionKind::inout or direction=ParameterDirectionKind::return))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_context_behavior"      
  :name |A_context_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "context")
                ("A_context_behavior-behavior" "behavior"))      
  :owned-ends  (("A_context_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_context_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 -1) 
    :association "A_context_behavior" 
    :name "behavior")

(def-meta-assoc "A_ownedParameterSet_behavior"      
  :name |A_ownedParameterSet_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "ownedParameterSet")
                ("A_ownedParameterSet_behavior-behavior" "behavior"))      
  :owned-ends  (("A_ownedParameterSet_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_ownedParameterSet_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 1) 
    :association "A_ownedParameterSet_behavior" 
    :name "behavior")

(def-meta-assoc "A_ownedParameter_behavior"      
  :name |A_ownedParameter_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "ownedParameter")
                ("A_ownedParameter_behavior-behavior" "behavior"))      
  :owned-ends  (("A_ownedParameter_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_ownedParameter_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 1) 
    :association "A_ownedParameter_behavior" 
    :name "behavior")

(def-meta-assoc "A_postcondition_behavior"      
  :name |A_postcondition_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "postcondition")
                ("A_postcondition_behavior-behavior" "behavior"))      
  :owned-ends  (("A_postcondition_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_postcondition_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 1) 
    :association "A_postcondition_behavior" 
    :name "behavior")

(def-meta-assoc "A_precondition_behavior"      
  :name |A_precondition_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "precondition")
                ("A_precondition_behavior-behavior" "behavior"))      
  :owned-ends  (("A_precondition_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_precondition_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 1) 
    :association "A_precondition_behavior" 
    :name "behavior")

(def-meta-assoc "A_redefinedBehavior_behavior"      
  :name |A_redefinedBehavior_behavior|      
  :metatype :association      
  :member-ends ((|Behavior| "redefinedBehavior")
                ("A_redefinedBehavior_behavior-behavior" "behavior"))      
  :owned-ends  (("A_redefinedBehavior_behavior-behavior" "behavior")))

(def-meta-assoc-end "A_redefinedBehavior_behavior-behavior" 
    :type |Behavior| 
    :multiplicity (0 -1) 
    :association "A_redefinedBehavior_behavior" 
    :name "behavior")

;;; =========================================================
;;; ====================== BehaviorExecutionSpecification
;;; =========================================================
(def-meta-class |BehaviorExecutionSpecification| 
   (:model :UML25 :superclasses (|ExecutionSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "BehaviorExecutionSpecification")
 "A BehaviorExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of a Behavior."
  ((|behavior| :xmi-id "BehaviorExecutionSpecification-behavior" :range |Behavior| :multiplicity (0 1)
    :documentation
     "Behavior whose execution is occurring.")))

(def-meta-assoc "A_behavior_behaviorExecutionSpecification"      
  :name |A_behavior_behaviorExecutionSpecification|      
  :metatype :association      
  :member-ends ((|BehaviorExecutionSpecification| "behavior")
                ("A_behavior_behaviorExecutionSpecification-behaviorExecutionSpecification" "behaviorExecutionSpecification"))      
  :owned-ends  (("A_behavior_behaviorExecutionSpecification-behaviorExecutionSpecification" "behaviorExecutionSpecification")))

(def-meta-assoc-end "A_behavior_behaviorExecutionSpecification-behaviorExecutionSpecification" 
    :type |BehaviorExecutionSpecification| 
    :multiplicity (0 -1) 
    :association "A_behavior_behaviorExecutionSpecification" 
    :name "behaviorExecutionSpecification")

;;; =========================================================
;;; ====================== BehavioralFeature
;;; =========================================================
(def-meta-class |BehavioralFeature| 
   (:model :UML25 :superclasses (|Feature| |Namespace|) 
    :packages (UML |Classification|) 
    :xmi-id "BehavioralFeature")
 "A BehavioralFeature is a feature of a Classifier that specifies an aspect
  of the behavior of its instances.  A BehavioralFeature is implemented (realized)
  by a Behavior. A BehavioralFeature specifies that a Classifier will respond
  to a designated request by invoking its implementing method."
  ((|concurrency| :xmi-id "BehavioralFeature-concurrency" :range |CallConcurrencyKind| :multiplicity (1 1) :default :sequential
    :documentation
     "Specifies the semantics of concurrent calls to the same passive instance
      (i.e., an instance originating from a Class with isActive being false).
      Active instances control access to their own BehavioralFeatures.")
   (|isAbstract| :xmi-id "BehavioralFeature-isAbstract" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, then the BehavioralFeature does not have an implementation, and
      one must be supplied by a more specific Classifier. If false, the BehavioralFeature
      must have an implementation in the Classifier or one must be inherited.")
   (|method| :xmi-id "BehavioralFeature-method" :range |Behavior| :multiplicity (0 -1)
    :opposite (|Behavior| |specification|)
    :documentation
     "A Behavior that implements the BehavioralFeature. There may be at most
      one Behavior for a particular pairing of a Classifier (as owner of the
      Behavior) and a BehavioralFeature (as specification of the Behavior).")
   (|ownedParameter| :xmi-id "BehavioralFeature-ownedParameter" :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The ordered set of formal Parameters of this BehavioralFeature.")
   (|ownedParameterSet| :xmi-id "BehavioralFeature-ownedParameterSet" :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The ParameterSets owned by this BehavioralFeature.")
   (|raisedException| :xmi-id "BehavioralFeature-raisedException" :range |Type| :multiplicity (0 -1)
    :documentation
     "The Types representing exceptions that may be raised during an invocation
      of this BehavioralFeature.")))

(def-meta-operation "inputParameters" |BehavioralFeature| 
   "The ownedParameters with direction in and inout."
   :operation-body
   "result = (ownedParameter->select(direction=ParameterDirectionKind::_'in' or direction=ParameterDirectionKind::inout))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "isDistinguishableFrom" |BehavioralFeature| 
   "The query isDistinguishableFrom() determines whether two BehavioralFeatures
    may coexist in the same Namespace. It specifies that they must have different
    signatures."
   :operation-body
   "result = ((n.oclIsKindOf(BehavioralFeature) and ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()) implies   Set{self}->including(n.oclAsType(BehavioralFeature))->isUnique(ownedParameter->collect(p|   Tuple { name=p.name, type=p.type,effect=p.effect,direction=p.direction,isException=p.isException,               isStream=p.isStream,isOrdered=p.isOrdered,isUnique=p.isUnique,lower=p.lower, upper=p.upper }))   )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-meta-operation "outputParameters" |BehavioralFeature| 
   "The ownedParameters with direction out, inout, or return."
   :operation-body
   "result = (ownedParameter->select(direction=ParameterDirectionKind::out or direction=ParameterDirectionKind::inout or direction=ParameterDirectionKind::return))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_method_specification"      
  :name |A_method_specification|      
  :metatype :association      
  :member-ends ((|BehavioralFeature| "method")
                (|Behavior| "specification"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedParameterSet_behavioralFeature"      
  :name |A_ownedParameterSet_behavioralFeature|      
  :metatype :association      
  :member-ends ((|BehavioralFeature| "ownedParameterSet")
                ("A_ownedParameterSet_behavioralFeature-behavioralFeature" "behavioralFeature"))      
  :owned-ends  (("A_ownedParameterSet_behavioralFeature-behavioralFeature" "behavioralFeature")))

(def-meta-assoc-end "A_ownedParameterSet_behavioralFeature-behavioralFeature" 
    :type |BehavioralFeature| 
    :multiplicity (0 1) 
    :association "A_ownedParameterSet_behavioralFeature" 
    :name "behavioralFeature")

(def-meta-assoc "A_ownedParameter_ownerFormalParam"      
  :name |A_ownedParameter_ownerFormalParam|      
  :metatype :association      
  :member-ends ((|BehavioralFeature| "ownedParameter")
                ("A_ownedParameter_ownerFormalParam-ownerFormalParam" "ownerFormalParam"))      
  :owned-ends  (("A_ownedParameter_ownerFormalParam-ownerFormalParam" "ownerFormalParam")))

(def-meta-assoc-end "A_ownedParameter_ownerFormalParam-ownerFormalParam" 
    :type |BehavioralFeature| 
    :multiplicity (0 1) 
    :association "A_ownedParameter_ownerFormalParam" 
    :name "ownerFormalParam")

(def-meta-assoc "A_raisedException_behavioralFeature"      
  :name |A_raisedException_behavioralFeature|      
  :metatype :association      
  :member-ends ((|BehavioralFeature| "raisedException")
                ("A_raisedException_behavioralFeature-behavioralFeature" "behavioralFeature"))      
  :owned-ends  (("A_raisedException_behavioralFeature-behavioralFeature" "behavioralFeature")))

(def-meta-assoc-end "A_raisedException_behavioralFeature-behavioralFeature" 
    :type |BehavioralFeature| 
    :multiplicity (0 -1) 
    :association "A_raisedException_behavioralFeature" 
    :name "behavioralFeature")

;;; =========================================================
;;; ====================== BehavioredClassifier
;;; =========================================================
(def-meta-class |BehavioredClassifier| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "BehavioredClassifier")
 "A BehavioredClassifier may have InterfaceRealizations, and owns a set of
  Behaviors one of which may specify the behavior of the BehavioredClassifier
  itself."
  ((|classifierBehavior| :xmi-id "BehavioredClassifier-classifierBehavior" :range |Behavior| :multiplicity (0 1)
    :subsetted-properties ((|BehavioredClassifier| |ownedBehavior|))
    :documentation
     "A Behavior that specifies the behavior of the BehavioredClassifier itself.")
   (|interfaceRealization| :xmi-id "BehavioredClassifier-interfaceRealization" :range |InterfaceRealization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|InterfaceRealization| |implementingClassifier|)
    :documentation
     "The set of InterfaceRealizations owned by the BehavioredClassifier. Interface
      realizations reference the Interfaces of which the BehavioredClassifier
      is an implementation.")
   (|ownedBehavior| :xmi-id "BehavioredClassifier-ownedBehavior" :range |Behavior| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Behaviors owned by a BehavioredClassifier.")))

(def-meta-assoc "A_classifierBehavior_behavioredClassifier"      
  :name |A_classifierBehavior_behavioredClassifier|      
  :metatype :association      
  :member-ends ((|BehavioredClassifier| "classifierBehavior")
                ("A_classifierBehavior_behavioredClassifier-behavioredClassifier" "behavioredClassifier"))      
  :owned-ends  (("A_classifierBehavior_behavioredClassifier-behavioredClassifier" "behavioredClassifier")))

(def-meta-assoc-end "A_classifierBehavior_behavioredClassifier-behavioredClassifier" 
    :type |BehavioredClassifier| 
    :multiplicity (0 1) 
    :association "A_classifierBehavior_behavioredClassifier" 
    :name "behavioredClassifier")

(def-meta-assoc "A_interfaceRealization_implementingClassifier"      
  :name |A_interfaceRealization_implementingClassifier|      
  :metatype :association      
  :member-ends ((|BehavioredClassifier| "interfaceRealization")
                (|InterfaceRealization| "implementingClassifier"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedBehavior_behavioredClassifier"      
  :name |A_ownedBehavior_behavioredClassifier|      
  :metatype :association      
  :member-ends ((|BehavioredClassifier| "ownedBehavior")
                ("A_ownedBehavior_behavioredClassifier-behavioredClassifier" "behavioredClassifier"))      
  :owned-ends  (("A_ownedBehavior_behavioredClassifier-behavioredClassifier" "behavioredClassifier")))

(def-meta-assoc-end "A_ownedBehavior_behavioredClassifier-behavioredClassifier" 
    :type |BehavioredClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedBehavior_behavioredClassifier" 
    :name "behavioredClassifier")

;;; =========================================================
;;; ====================== BroadcastSignalAction
;;; =========================================================
(def-meta-class |BroadcastSignalAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "BroadcastSignalAction")
 "A BroadcastSignalAction is an InvocationAction that transmits a Signal
  instance to all the potential target objects in the system. Values from
  the argument InputPins are used to provide values for the attributes of
  the Signal. The requestor continues execution immediately after the Signal
  instances are sent out and cannot receive reply values."
  ((|signal| :xmi-id "BroadcastSignalAction-signal" :range |Signal| :multiplicity (1 1)
    :documentation
     "The Signal whose instances are to be sent.")))

(def-meta-assoc "A_signal_broadcastSignalAction"      
  :name |A_signal_broadcastSignalAction|      
  :metatype :association      
  :member-ends ((|BroadcastSignalAction| "signal")
                ("A_signal_broadcastSignalAction-broadcastSignalAction" "broadcastSignalAction"))      
  :owned-ends  (("A_signal_broadcastSignalAction-broadcastSignalAction" "broadcastSignalAction")))

(def-meta-assoc-end "A_signal_broadcastSignalAction-broadcastSignalAction" 
    :type |BroadcastSignalAction| 
    :multiplicity (0 -1) 
    :association "A_signal_broadcastSignalAction" 
    :name "broadcastSignalAction")

;;; =========================================================
;;; ====================== CallAction
;;; =========================================================
(def-meta-class |CallAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "CallAction")
 "CallAction is an abstract class for Actions that invoke a Behavior with
  given argument values and (if the invocation is synchronous) receive reply
  values."
  ((|isSynchronous| :xmi-id "CallAction-isSynchronous" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, the call is synchronous and the caller waits for completion of
      the invoked Behavior. If false, the call is asynchronous and the caller
      proceeds immediately and cannot receive return values.")
   (|result| :xmi-id "CallAction-result" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPins on which the reply values from the invocation are placed
      (if the call is synchronous).")))

(def-meta-operation "inputParameters" |CallAction| 
   "Return the in and inout ownedParameters of the Behavior or Operation being
    called. (This operation is abstract and should be overridden by subclasses
    of CallAction.)"
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "outputParameters" |CallAction| 
   "Return the inout, out and return ownedParameters of the Behavior or Operation
    being called. (This operation is abstract and should be overridden by subclasses
    of CallAction.)"
   :operation-body
   ""
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_result_callAction"      
  :name |A_result_callAction|      
  :metatype :association      
  :member-ends ((|CallAction| "result")
                ("A_result_callAction-callAction" "callAction"))      
  :owned-ends  (("A_result_callAction-callAction" "callAction")))

(def-meta-assoc-end "A_result_callAction-callAction" 
    :type |CallAction| 
    :multiplicity (0 1) 
    :association "A_result_callAction" 
    :name "callAction")

;;; =========================================================
;;; ====================== CallBehaviorAction
;;; =========================================================
(def-meta-class |CallBehaviorAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "CallBehaviorAction")
 "A CallBehaviorAction is a CallAction that invokes a Behavior directly.
  The argument values of the CallBehaviorAction are passed on the input Parameters
  of the invoked Behavior. If the call is synchronous, the execution of the
  CallBehaviorAction waits until the execution of the invoked Behavior completes
  and the values of output Parameters of the Behavior are placed on the result
  OutputPins. If the call is asynchronous, the CallBehaviorAction completes
  immediately and no results values can be provided."
  ((|behavior| :xmi-id "CallBehaviorAction-behavior" :range |Behavior| :multiplicity (1 1)
    :documentation
     "The Behavior being invoked.")))

(def-meta-operation "inputParameters" |CallBehaviorAction| 
   "Return the in and inout ownedParameters of the Behavior being called."
   :operation-body
   "result = (behavior.inputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "outputParameters" |CallBehaviorAction| 
   "Return the inout, out and return ownedParameters of the Behavior being
    called."
   :operation-body
   "result = (behavior.outputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_behavior_callBehaviorAction"      
  :name |A_behavior_callBehaviorAction|      
  :metatype :association      
  :member-ends ((|CallBehaviorAction| "behavior")
                ("A_behavior_callBehaviorAction-callBehaviorAction" "callBehaviorAction"))      
  :owned-ends  (("A_behavior_callBehaviorAction-callBehaviorAction" "callBehaviorAction")))

(def-meta-assoc-end "A_behavior_callBehaviorAction-callBehaviorAction" 
    :type |CallBehaviorAction| 
    :multiplicity (0 -1) 
    :association "A_behavior_callBehaviorAction" 
    :name "callBehaviorAction")

;;; =========================================================
;;; ====================== CallEvent
;;; =========================================================
(def-meta-class |CallEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "CallEvent")
 "A CallEvent models the receipt by an object of a message invoking a call
  of an Operation."
  ((|operation| :xmi-id "CallEvent-operation" :range |Operation| :multiplicity (1 1)
    :documentation
     "Designates the Operation whose invocation raised the CalEvent.")))

(def-meta-assoc "A_operation_callEvent"      
  :name |A_operation_callEvent|      
  :metatype :association      
  :member-ends ((|CallEvent| "operation")
                ("A_operation_callEvent-callEvent" "callEvent"))      
  :owned-ends  (("A_operation_callEvent-callEvent" "callEvent")))

(def-meta-assoc-end "A_operation_callEvent-callEvent" 
    :type |CallEvent| 
    :multiplicity (0 -1) 
    :association "A_operation_callEvent" 
    :name "callEvent")

;;; =========================================================
;;; ====================== CallOperationAction
;;; =========================================================
(def-meta-class |CallOperationAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "CallOperationAction")
 "A CallOperationAction is a CallAction that transmits an Operation call
  request to the target object, where it may cause the invocation of associated
  Behavior. The argument values of the CallOperationAction are passed on
  the input Parameters of the Operation. If call is synchronous, the execution
  of the CallOperationAction waits until the execution of the invoked Operation
  completes and the values of output Parameters of the Operation are placed
  on the result OutputPins. If the call is asynchronous, the CallOperationAction
  completes immediately and no results values can be provided."
  ((|operation| :xmi-id "CallOperationAction-operation" :range |Operation| :multiplicity (1 1)
    :documentation
     "The Operation being invoked.")
   (|target| :xmi-id "CallOperationAction-target" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that provides the target object to which the Operation call
      request is sent.")))

(def-meta-operation "inputParameters" |CallOperationAction| 
   "Return the in and inout ownedParameters of the Operation being called."
   :operation-body
   "result = (operation.inputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "outputParameters" |CallOperationAction| 
   "Return the inout, out and return ownedParameters of the Operation being
    called."
   :operation-body
   "result = (operation.outputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_operation_callOperationAction"      
  :name |A_operation_callOperationAction|      
  :metatype :association      
  :member-ends ((|CallOperationAction| "operation")
                ("A_operation_callOperationAction-callOperationAction" "callOperationAction"))      
  :owned-ends  (("A_operation_callOperationAction-callOperationAction" "callOperationAction")))

(def-meta-assoc-end "A_operation_callOperationAction-callOperationAction" 
    :type |CallOperationAction| 
    :multiplicity (0 -1) 
    :association "A_operation_callOperationAction" 
    :name "callOperationAction")

(def-meta-assoc "A_target_callOperationAction"      
  :name |A_target_callOperationAction|      
  :metatype :association      
  :member-ends ((|CallOperationAction| "target")
                ("A_target_callOperationAction-callOperationAction" "callOperationAction"))      
  :owned-ends  (("A_target_callOperationAction-callOperationAction" "callOperationAction")))

(def-meta-assoc-end "A_target_callOperationAction-callOperationAction" 
    :type |CallOperationAction| 
    :multiplicity (0 1) 
    :association "A_target_callOperationAction" 
    :name "callOperationAction")

;;; =========================================================
;;; ====================== CentralBufferNode
;;; =========================================================
(def-meta-class |CentralBufferNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Activities|) 
    :xmi-id "CentralBufferNode")
 "A CentralBufferNode is an ObjectNode for managing flows from multiple sources
  and targets."
  ())

;;; =========================================================
;;; ====================== ChangeEvent
;;; =========================================================
(def-meta-class |ChangeEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "ChangeEvent")
 "A ChangeEvent models a change in the system configuration that makes a
  condition true."
  ((|changeExpression| :xmi-id "ChangeEvent-changeExpression" :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Boolean-valued ValueSpecification that will result in a ChangeEvent whenever
      its value changes from false to true.")))

(def-meta-assoc "A_changeExpression_changeEvent"      
  :name |A_changeExpression_changeEvent|      
  :metatype :association      
  :member-ends ((|ChangeEvent| "changeExpression")
                ("A_changeExpression_changeEvent-changeEvent" "changeEvent"))      
  :owned-ends  (("A_changeExpression_changeEvent-changeEvent" "changeEvent")))

(def-meta-assoc-end "A_changeExpression_changeEvent-changeEvent" 
    :type |ChangeEvent| 
    :multiplicity (0 1) 
    :association "A_changeExpression_changeEvent" 
    :name "changeEvent")

;;; =========================================================
;;; ====================== Class
;;; =========================================================
(def-meta-class |Class| 
   (:model :UML25 :superclasses (|BehavioredClassifier| |EncapsulatedClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Class")
 "A Class classifies a set of objects and specifies the features that characterize
  the structure and behavior of those objects.  A Class may have an internal
  structure and Ports."
  ((|extension| :xmi-id "Class-extension" :range |Extension| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Extension| |metaclass|)
    :documentation
     "This property is used when the Class is acting as a metaclass. It references
      the Extensions that specify additional properties of the metaclass. The
      property is derived from the Extensions whose memberEnds are typed by the
      Class.")
   (|isAbstract| :xmi-id "Class-isAbstract" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Class does not provide a complete declaration and cannot be
      instantiated. An abstract Class is typically used as a target of Associations
      or Generalizations." :redefined-property (|Classifier| |isAbstract|))
   (|isActive| :xmi-id "Class-isActive" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Determines whether an object specified by this Class is active or not.
      If true, then the owning Class is referred to as an active Class. If false,
      then such a Class is referred to as a passive Class.")
   (|nestedClassifier| :xmi-id "Class-nestedClassifier" :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The Classifiers owned by the Class that are not ownedBehaviors.")
   (|ownedAttribute| :xmi-id "Class-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |class|)
    :documentation
     "The attributes (i.e., the Properties) owned by the Class." :redefined-property (|StructuredClassifier| |ownedAttribute|))
   (|ownedOperation| :xmi-id "Class-ownedOperation" :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |class|)
    :documentation
     "The Operations owned by the Class.")
   (|ownedReception| :xmi-id "Class-ownedReception" :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "The Receptions owned by the Class.")
   (|superClass| :xmi-id "Class-superClass" :range |Class| :multiplicity (0 -1) :is-derived-p T
    :documentation
     "The superclasses of a Class, derived from its Generalizations." :redefined-property (|Classifier| |general|))))

(def-meta-operation "extension.1" |Class| 
   "Derivation for Class::/extension : Extension"
   :operation-body
   "result = (Extension.allInstances()->select(ext |     let endTypes : Sequence(Classifier) = ext.memberEnd->collect(type.oclAsType(Classifier)) in    endTypes->includes(self) or endTypes.allParents()->includes(self) ))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Extension|
                        :parameter-return-p T))
)

(def-meta-operation "superClass.1" |Class| 
   "Derivation for Class::/superClass : Class"
   :operation-body
   "result = (self.general()->select(oclIsKindOf(Class))->collect(oclAsType(Class))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Class|
                        :parameter-return-p T))
)

(def-meta-assoc "A_extension_metaclass"      
  :name |A_extension_metaclass|      
  :metatype :association      
  :member-ends ((|Class| "extension")
                (|Extension| "metaclass"))      
  :owned-ends  ())

(def-meta-assoc "A_nestedClassifier_nestingClass"      
  :name |A_nestedClassifier_nestingClass|      
  :metatype :association      
  :member-ends ((|Class| "nestedClassifier")
                ("A_nestedClassifier_nestingClass-nestingClass" "nestingClass"))      
  :owned-ends  (("A_nestedClassifier_nestingClass-nestingClass" "nestingClass")))

(def-meta-assoc-end "A_nestedClassifier_nestingClass-nestingClass" 
    :type |Class| 
    :multiplicity (0 1) 
    :association "A_nestedClassifier_nestingClass" 
    :name "nestingClass")

(def-meta-assoc "A_ownedAttribute_class"      
  :name |A_ownedAttribute_class|      
  :metatype :association      
  :member-ends ((|Class| "ownedAttribute")
                (|Property| "class"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedOperation_class"      
  :name |A_ownedOperation_class|      
  :metatype :association      
  :member-ends ((|Class| "ownedOperation")
                (|Operation| "class"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedReception_class"      
  :name |A_ownedReception_class|      
  :metatype :association      
  :member-ends ((|Class| "ownedReception")
                ("A_ownedReception_class-class" "class"))      
  :owned-ends  (("A_ownedReception_class-class" "class")))

(def-meta-assoc-end "A_ownedReception_class-class" 
    :type |Class| 
    :multiplicity (0 1) 
    :association "A_ownedReception_class" 
    :name "class")

(def-meta-assoc "A_superClass_class"      
  :name |A_superClass_class|      
  :metatype :association      
  :member-ends ((|Class| "superClass")
                ("A_superClass_class-class" "class"))      
  :owned-ends  (("A_superClass_class-class" "class")))

(def-meta-assoc-end "A_superClass_class-class" 
    :type |Class| 
    :multiplicity (0 -1) 
    :association "A_superClass_class" 
    :name "class")

;;; =========================================================
;;; ====================== Classifier
;;; =========================================================
(def-meta-class |Classifier| 
   (:model :UML25 :superclasses (|Namespace| |Type| |TemplateableElement| |RedefinableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "Classifier")
 "A Classifier represents a classification of instances according to their
  Features."
  ((|attribute| :xmi-id "Classifier-attribute" :range |Property| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Classifier| |feature|))
    :documentation
     "All of the Properties that are direct (i.e., not inherited or imported)
      attributes of the Classifier.")
   (|collaborationUse| :xmi-id "Classifier-collaborationUse" :range |CollaborationUse| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The CollaborationUses owned by the Classifier.")
   (|feature| :xmi-id "Classifier-feature" :range |Feature| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Feature| |featuringClassifier|)
    :documentation
     "Specifies each Feature directly defined in the classifier. Note that there
      may be members of the Classifier that are of the type Feature but are not
      included, e.g., inherited features.")
   (|general| :xmi-id "Classifier-general" :range |Classifier| :multiplicity (0 -1) :is-derived-p T
    :documentation
     "The generalizing Classifiers for this Classifier.")
   (|generalization| :xmi-id "Classifier-generalization" :range |Generalization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Generalization| |specific|)
    :documentation
     "The Generalization relationships for this Classifier. These Generalizations
      navigate to more general Classifiers in the generalization hierarchy.")
   (|inheritedMember| :xmi-id "Classifier-inheritedMember" :range |NamedElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "All elements inherited by this Classifier from its general Classifiers.")
   (|isAbstract| :xmi-id "Classifier-isAbstract" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier can only be instantiated by instantiating one of
      its specializations. An abstract Classifier is intended to be used by other
      Classifiers e.g., as the target of Associations or Generalizations.")
   (|isFinalSpecialization| :xmi-id "Classifier-isFinalSpecialization" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier cannot be specialized.")
   (|ownedTemplateSignature| :xmi-id "Classifier-ownedTemplateSignature" :range |RedefinableTemplateSignature| :multiplicity (0 1) :is-composite-p T
    :opposite (|RedefinableTemplateSignature| |classifier|)
    :documentation
     "The optional RedefinableTemplateSignature specifying the formal template
      parameters." :redefined-property (|TemplateableElement| |ownedTemplateSignature|))
   (|ownedUseCase| :xmi-id "Classifier-ownedUseCase" :range |UseCase| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The UseCases owned by this classifier.")
   (|powertypeExtent| :xmi-id "Classifier-powertypeExtent" :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |powertype|)
    :documentation
     "The GeneralizationSet of which this Classifier is a power type.")
   (|redefinedClassifier| :xmi-id "Classifier-redefinedClassifier" :range |Classifier| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The Classifiers redefined by this Classifier.")
   (|representation| :xmi-id "Classifier-representation" :range |CollaborationUse| :multiplicity (0 1)
    :subsetted-properties ((|Classifier| |collaborationUse|))
    :documentation
     "A CollaborationUse which indicates the Collaboration that represents this
      Classifier.")
   (|substitution| :xmi-id "Classifier-substitution" :range |Substitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|Substitution| |substitutingClassifier|)
    :documentation
     "The Substitutions owned by this Classifier.")
   (|templateParameter| :xmi-id "Classifier-templateParameter" :range |ClassifierTemplateParameter| :multiplicity (0 1)
    :opposite (|ClassifierTemplateParameter| |parameteredElement|)
    :documentation
     "TheClassifierTemplateParameter that exposes this element as a formal parameter." :redefined-property (|ParameterableElement| |templateParameter|))
   (|useCase| :xmi-id "Classifier-useCase" :range |UseCase| :multiplicity (0 -1)
    :opposite (|UseCase| |subject|)
    :documentation
     "The set of UseCases for which this Classifier is the subject.")))

(def-meta-operation "allAttributes" |Classifier| 
   "The query allAttributes gives an ordered set of all owned and inherited
    attributes of the Classifier. All owned attributes appear before any inherited
    attributes, and the attributes inherited from any more specific parent
    Classifier appear before those of any more general parent Classifier. However,
    if the Classifier has multiple immediate parents, then the relative ordering
    of the sets of attributes from those parents is not defined."
   :operation-body
   "result = (attribute->asSequence()->union(parents()->asSequence().allAttributes())->select(p | member->includes(p))->asOrderedSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-operation "allFeatures" |Classifier| 
   "The query allFeatures() gives all of the Features in the namespace of the
    Classifier. In general, through mechanisms such as inheritance, this will
    be a larger set than feature."
   :operation-body
   "result = (member->select(oclIsKindOf(Feature))->collect(oclAsType(Feature))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Feature|
                        :parameter-return-p T))
)

(def-meta-operation "allParents" |Classifier| 
   "The query allParents() gives all of the direct and indirect ancestors of
    a generalized Classifier."
   :operation-body
   "result = (parents()->union(parents()->collect(allParents())->asSet()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "allRealizedInterfaces" |Classifier| 
   "The Interfaces realized by this Classifier and all of its generalizations"
   :operation-body
   "result = (directlyRealizedInterfaces()->union(self.allParents()->collect(directlyRealizedInterfaces()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "allSlottableFeatures" |Classifier| 
   "All StructuralFeatures related to the Classifier that may have Slots, including
    direct attributes, inherited attributes, private attributes in generalizations,
    and memberEnds of Associations, but excluding redefined StructuralFeatures."
   :operation-body
   "result = (member->select(oclIsKindOf(StructuralFeature))->    collect(oclAsType(StructuralFeature))->     union(self.inherit(self.allParents()->collect(p | p.attribute)->asSet())->       collect(oclAsType(StructuralFeature)))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StructuralFeature|
                        :parameter-return-p T))
)

(def-meta-operation "allUsedInterfaces" |Classifier| 
   "The Interfaces used by this Classifier and all of its generalizations"
   :operation-body
   "result = (directlyUsedInterfaces()->union(self.allParents()->collect(directlyUsedInterfaces()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "conformsTo" |Classifier| 
   "The query conformsTo() gives true for a Classifier that defines a type
    that conforms to another. This is used, for example, in the specification
    of signature conformance for operations."
   :operation-body
   "result = (if other.oclIsKindOf(Classifier) then    let otherClassifier : Classifier = other.oclAsType(Classifier) in      self = otherClassifier or allParents()->includes(otherClassifier)  else    false  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Type|
                        :parameter-return-p NIL))
)

(def-meta-operation "directlyRealizedInterfaces" |Classifier| 
   "The Interfaces directly realized by this Classifier"
   :operation-body
   "result = ((clientDependency->    select(oclIsKindOf(Realization) and supplier->forAll(oclIsKindOf(Interface))))->        collect(supplier.oclAsType(Interface))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "directlyUsedInterfaces" |Classifier| 
   "The Interfaces directly used by this Classifier"
   :operation-body
   "result = ((supplierDependency->    select(oclIsKindOf(Usage) and client->forAll(oclIsKindOf(Interface))))->      collect(client.oclAsType(Interface))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "general.1" |Classifier| 
   "The general Classifiers are the ones referenced by the Generalization relationships."
   :operation-body
   "result = (parents())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "hasVisibilityOf" |Classifier| 
   "The query hasVisibilityOf() determines whether a NamedElement is visible
    in the classifier. Non-private members are visible. It is only called when
    the argument is something owned by a parent."
   :operation-body
   "result = (n.visibility <> VisibilityKind::private)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "inherit" |Classifier| 
   "The query inherit() defines how to inherit a set of elements passed as
    its argument.  It excludes redefined elements from the result."
   :operation-body
   "result = (inhs->reject(inh |    inh.oclIsKindOf(RedefinableElement) and    ownedMember->select(oclIsKindOf(RedefinableElement))->      select(redefinedElement->includes(inh.oclAsType(RedefinableElement)))         ->notEmpty()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "inheritableMembers" |Classifier| 
   "The query inheritableMembers() gives all of the members of a Classifier
    that may be inherited in one of its descendants, subject to whatever visibility
    restrictions apply."
   :operation-body
   "result = (member->select(m | c.hasVisibilityOf(m)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-meta-operation "inheritedMember.1" |Classifier| 
   "The inheritedMember association is derived by inheriting the inheritable
    members of the parents."
   :operation-body
   "result = (inherit(parents()->collect(inheritableMembers(self))->asSet()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T))
)

(def-meta-operation "isSubstitutableFor" |Classifier| 
   ""
   :operation-body
   "result = (substitution.contract->includes(contract))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name '|contract| :parameter-type '|Classifier|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isTemplate" |Classifier| 
   "The query isTemplate() returns whether this Classifier is actually a template."
   :operation-body
   "result = (ownedTemplateSignature <> null or general->exists(g | g.isTemplate()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "maySpecializeType" |Classifier| 
   "The query maySpecializeType() determines whether this classifier may have
    a generalization relationship to classifiers of the specified type. By
    default a classifier may specialize classifiers of the same or a more general
    type. It is intended to be redefined by classifiers that have different
    specialization constraints."
   :operation-body
   "result = (self.oclIsKindOf(c.oclType()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-meta-operation "parents" |Classifier| 
   "The query parents() gives all of the immediate ancestors of a generalized
    Classifier."
   :operation-body
   "result = (generalization.general->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-assoc "A_attribute_classifier"      
  :name |A_attribute_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "attribute")
                ("A_attribute_classifier-classifier" "classifier"))      
  :owned-ends  (("A_attribute_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_attribute_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 1) 
    :association "A_attribute_classifier" 
    :name "classifier")

(def-meta-assoc "A_classifier_templateParameter_parameteredElement"      
  :name |A_classifier_templateParameter_parameteredElement|      
  :metatype :association      
  :member-ends ((|Classifier| "templateParameter")
                (|ClassifierTemplateParameter| "parameteredElement"))      
  :owned-ends  ())

(def-meta-assoc "A_collaborationUse_classifier"      
  :name |A_collaborationUse_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "collaborationUse")
                ("A_collaborationUse_classifier-classifier" "classifier"))      
  :owned-ends  (("A_collaborationUse_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_collaborationUse_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 1) 
    :association "A_collaborationUse_classifier" 
    :name "classifier")

(def-meta-assoc "A_feature_featuringClassifier"      
  :name |A_feature_featuringClassifier|      
  :metatype :association      
  :member-ends ((|Classifier| "feature")
                (|Feature| "featuringClassifier"))      
  :owned-ends  ())

(def-meta-assoc "A_general_classifier"      
  :name |A_general_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "general")
                ("A_general_classifier-classifier" "classifier"))      
  :owned-ends  (("A_general_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_general_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 -1) 
    :association "A_general_classifier" 
    :name "classifier")

(def-meta-assoc "A_generalization_specific"      
  :name |A_generalization_specific|      
  :metatype :association      
  :member-ends ((|Classifier| "generalization")
                (|Generalization| "specific"))      
  :owned-ends  ())

(def-meta-assoc "A_inheritedMember_inheritingClassifier"      
  :name |A_inheritedMember_inheritingClassifier|      
  :metatype :association      
  :member-ends ((|Classifier| "inheritedMember")
                ("A_inheritedMember_inheritingClassifier-inheritingClassifier" "inheritingClassifier"))      
  :owned-ends  (("A_inheritedMember_inheritingClassifier-inheritingClassifier" "inheritingClassifier")))

(def-meta-assoc-end "A_inheritedMember_inheritingClassifier-inheritingClassifier" 
    :type |Classifier| 
    :multiplicity (0 -1) 
    :association "A_inheritedMember_inheritingClassifier" 
    :name "inheritingClassifier")

(def-meta-assoc "A_ownedTemplateSignature_classifier"      
  :name |A_ownedTemplateSignature_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "ownedTemplateSignature")
                (|RedefinableTemplateSignature| "classifier"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedUseCase_classifier"      
  :name |A_ownedUseCase_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "ownedUseCase")
                ("A_ownedUseCase_classifier-classifier" "classifier"))      
  :owned-ends  (("A_ownedUseCase_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_ownedUseCase_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 1) 
    :association "A_ownedUseCase_classifier" 
    :name "classifier")

(def-meta-assoc "A_powertypeExtent_powertype"      
  :name |A_powertypeExtent_powertype|      
  :metatype :association      
  :member-ends ((|Classifier| "powertypeExtent")
                (|GeneralizationSet| "powertype"))      
  :owned-ends  ())

(def-meta-assoc "A_redefinedClassifier_classifier"      
  :name |A_redefinedClassifier_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "redefinedClassifier")
                ("A_redefinedClassifier_classifier-classifier" "classifier"))      
  :owned-ends  (("A_redefinedClassifier_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_redefinedClassifier_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 -1) 
    :association "A_redefinedClassifier_classifier" 
    :name "classifier")

(def-meta-assoc "A_representation_classifier"      
  :name |A_representation_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "representation")
                ("A_representation_classifier-classifier" "classifier"))      
  :owned-ends  (("A_representation_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_representation_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 1) 
    :association "A_representation_classifier" 
    :name "classifier")

(def-meta-assoc "A_substitution_substitutingClassifier"      
  :name |A_substitution_substitutingClassifier|      
  :metatype :association      
  :member-ends ((|Classifier| "substitution")
                (|Substitution| "substitutingClassifier"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ClassifierTemplateParameter
;;; =========================================================
(def-meta-class |ClassifierTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |Classification|) 
    :xmi-id "ClassifierTemplateParameter")
 "A ClassifierTemplateParameter exposes a Classifier as a formal template
  parameter."
  ((|allowSubstitutable| :xmi-id "ClassifierTemplateParameter-allowSubstitutable" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Constrains the required relationship between an actual parameter and the
      parameteredElement for this formal parameter.")
   (|constrainingClassifier| :xmi-id "ClassifierTemplateParameter-constrainingClassifier" :range |Classifier| :multiplicity (0 -1)
    :documentation
     "The classifiers that constrain the argument that can be used for the parameter.
      If the allowSubstitutable attribute is true, then any Classifier that is
      compatible with this constraining Classifier can be substituted; otherwise,
      it must be either this Classifier or one of its specializations. If this
      property is empty, there are no constraints on the Classifier that can
      be used as an argument.")
   (|parameteredElement| :xmi-id "ClassifierTemplateParameter-parameteredElement" :range |Classifier| :multiplicity (1 1)
    :opposite (|Classifier| |templateParameter|)
    :documentation
     "The Classifier exposed by this ClassifierTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))

(def-meta-assoc "A_constrainingClassifier_classifierTemplateParameter"      
  :name |A_constrainingClassifier_classifierTemplateParameter|      
  :metatype :association      
  :member-ends ((|ClassifierTemplateParameter| "constrainingClassifier")
                ("A_constrainingClassifier_classifierTemplateParameter-classifierTemplateParameter" "classifierTemplateParameter"))      
  :owned-ends  (("A_constrainingClassifier_classifierTemplateParameter-classifierTemplateParameter" "classifierTemplateParameter")))

(def-meta-assoc-end "A_constrainingClassifier_classifierTemplateParameter-classifierTemplateParameter" 
    :type |ClassifierTemplateParameter| 
    :multiplicity (0 -1) 
    :association "A_constrainingClassifier_classifierTemplateParameter" 
    :name "classifierTemplateParameter")

;;; =========================================================
;;; ====================== Clause
;;; =========================================================
(def-meta-class |Clause| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "Clause")
 "A Clause is an Element that represents a single branch of a ConditionalNode,
  including a test and a body section. The body section is executed only
  if (but not necessarily if) the test section evaluates to true."
  ((|body| :xmi-id "Clause-body" :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "The set of ExecutableNodes that are executed if the test evaluates to true
      and the Clause is chosen over other Clauses within the ConditionalNode
      that also have tests that evaluate to true.")
   (|bodyOutput| :xmi-id "Clause-bodyOutput" :range |OutputPin| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The OutputPins on Actions within the body section whose values are moved
      to the result OutputPins of the containing ConditionalNode after execution
      of the body.")
   (|decider| :xmi-id "Clause-decider" :range |OutputPin| :multiplicity (1 1)
    :documentation
     "An OutputPin on an Action in the test section whose Boolean value determines
      the result of the test.")
   (|predecessorClause| :xmi-id "Clause-predecessorClause" :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |successorClause|)
    :documentation
     "A set of Clauses whose tests must all evaluate to false before this Clause
      can evaluate its test.")
   (|successorClause| :xmi-id "Clause-successorClause" :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |predecessorClause|)
    :documentation
     "A set of Clauses that may not evaluate their tests unless the test for
      this Clause evaluates to false.")
   (|test| :xmi-id "Clause-test" :range |ExecutableNode| :multiplicity (1 -1)
    :documentation
     "The set of ExecutableNodes that are executed in order to provide a test
      result for the Clause.")))

(def-meta-assoc "A_bodyOutput_clause"      
  :name |A_bodyOutput_clause|      
  :metatype :association      
  :member-ends ((|Clause| "bodyOutput")
                ("A_bodyOutput_clause-clause" "clause"))      
  :owned-ends  (("A_bodyOutput_clause-clause" "clause")))

(def-meta-assoc-end "A_bodyOutput_clause-clause" 
    :type |Clause| 
    :multiplicity (0 -1) 
    :association "A_bodyOutput_clause" 
    :name "clause")

(def-meta-assoc "A_body_clause"      
  :name |A_body_clause|      
  :metatype :association      
  :member-ends ((|Clause| "body")
                ("A_body_clause-clause" "clause"))      
  :owned-ends  (("A_body_clause-clause" "clause")))

(def-meta-assoc-end "A_body_clause-clause" 
    :type |Clause| 
    :multiplicity (0 1) 
    :association "A_body_clause" 
    :name "clause")

(def-meta-assoc "A_decider_clause"      
  :name |A_decider_clause|      
  :metatype :association      
  :member-ends ((|Clause| "decider")
                ("A_decider_clause-clause" "clause"))      
  :owned-ends  (("A_decider_clause-clause" "clause")))

(def-meta-assoc-end "A_decider_clause-clause" 
    :type |Clause| 
    :multiplicity (0 1) 
    :association "A_decider_clause" 
    :name "clause")

(def-meta-assoc "A_predecessorClause_successorClause"      
  :name |A_predecessorClause_successorClause|      
  :metatype :association      
  :member-ends ((|Clause| "predecessorClause")
                (|Clause| "successorClause"))      
  :owned-ends  ())

(def-meta-assoc "A_test_clause"      
  :name |A_test_clause|      
  :metatype :association      
  :member-ends ((|Clause| "test")
                ("A_test_clause-clause" "clause"))      
  :owned-ends  (("A_test_clause-clause" "clause")))

(def-meta-assoc-end "A_test_clause-clause" 
    :type |Clause| 
    :multiplicity (0 1) 
    :association "A_test_clause" 
    :name "clause")

;;; =========================================================
;;; ====================== ClearAssociationAction
;;; =========================================================
(def-meta-class |ClearAssociationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ClearAssociationAction")
 "A ClearAssociationAction is an Action that destroys all links of an Association
  in which a particular object participates."
  ((|association| :xmi-id "ClearAssociationAction-association" :range |Association| :multiplicity (1 1)
    :documentation
     "The Association to be cleared.")
   (|object| :xmi-id "ClearAssociationAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that gives the object whose participation in the Association
      is to be cleared.")))

(def-meta-assoc "A_association_clearAssociationAction"      
  :name |A_association_clearAssociationAction|      
  :metatype :association      
  :member-ends ((|ClearAssociationAction| "association")
                ("A_association_clearAssociationAction-clearAssociationAction" "clearAssociationAction"))      
  :owned-ends  (("A_association_clearAssociationAction-clearAssociationAction" "clearAssociationAction")))

(def-meta-assoc-end "A_association_clearAssociationAction-clearAssociationAction" 
    :type |ClearAssociationAction| 
    :multiplicity (0 1) 
    :association "A_association_clearAssociationAction" 
    :name "clearAssociationAction")

(def-meta-assoc "A_object_clearAssociationAction"      
  :name |A_object_clearAssociationAction|      
  :metatype :association      
  :member-ends ((|ClearAssociationAction| "object")
                ("A_object_clearAssociationAction-clearAssociationAction" "clearAssociationAction"))      
  :owned-ends  (("A_object_clearAssociationAction-clearAssociationAction" "clearAssociationAction")))

(def-meta-assoc-end "A_object_clearAssociationAction-clearAssociationAction" 
    :type |ClearAssociationAction| 
    :multiplicity (0 1) 
    :association "A_object_clearAssociationAction" 
    :name "clearAssociationAction")

;;; =========================================================
;;; ====================== ClearStructuralFeatureAction
;;; =========================================================
(def-meta-class |ClearStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "ClearStructuralFeatureAction")
 "A ClearStructuralFeatureAction is a StructuralFeatureAction that removes
  all values of a StructuralFeature."
  ((|result| :xmi-id "ClearStructuralFeatureAction-result" :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which is put the input object as modified by the ClearStructuralFeatureAction.")))

(def-meta-assoc "A_result_clearStructuralFeatureAction"      
  :name |A_result_clearStructuralFeatureAction|      
  :metatype :association      
  :member-ends ((|ClearStructuralFeatureAction| "result")
                ("A_result_clearStructuralFeatureAction-clearStructuralFeatureAction" "clearStructuralFeatureAction"))      
  :owned-ends  (("A_result_clearStructuralFeatureAction-clearStructuralFeatureAction" "clearStructuralFeatureAction")))

(def-meta-assoc-end "A_result_clearStructuralFeatureAction-clearStructuralFeatureAction" 
    :type |ClearStructuralFeatureAction| 
    :multiplicity (0 1) 
    :association "A_result_clearStructuralFeatureAction" 
    :name "clearStructuralFeatureAction")

;;; =========================================================
;;; ====================== ClearVariableAction
;;; =========================================================
(def-meta-class |ClearVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "ClearVariableAction")
 "A ClearVariableAction is a VariableAction that removes all values of a
  Variable."
  ())

;;; =========================================================
;;; ====================== Collaboration
;;; =========================================================
(def-meta-class |Collaboration| 
   (:model :UML25 :superclasses (|StructuredClassifier| |BehavioredClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Collaboration")
 "A Collaboration describes a structure of collaborating elements (roles),
  each performing a specialized function, which collectively accomplish some
  desired functionality."
  ((|collaborationRole| :xmi-id "Collaboration-collaborationRole" :range |ConnectableElement| :multiplicity (0 -1)
    :subsetted-properties ((|StructuredClassifier| |role|))
    :documentation
     "Represents the participants in the Collaboration.")))

(def-meta-assoc "A_collaborationRole_collaboration"      
  :name |A_collaborationRole_collaboration|      
  :metatype :association      
  :member-ends ((|Collaboration| "collaborationRole")
                ("A_collaborationRole_collaboration-collaboration" "collaboration"))      
  :owned-ends  (("A_collaborationRole_collaboration-collaboration" "collaboration")))

(def-meta-assoc-end "A_collaborationRole_collaboration-collaboration" 
    :type |Collaboration| 
    :multiplicity (0 -1) 
    :association "A_collaborationRole_collaboration" 
    :name "collaboration")

;;; =========================================================
;;; ====================== CollaborationUse
;;; =========================================================
(def-meta-class |CollaborationUse| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "CollaborationUse")
 "A CollaborationUse is used to specify the application of a pattern specified
  by a Collaboration to a specific situation."
  ((|roleBinding| :xmi-id "CollaborationUse-roleBinding" :range |Dependency| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A mapping between features of the Collaboration and features of the owning
      Classifier. This mapping indicates which ConnectableElement of the Classifier
      plays which role(s) in the Collaboration. A ConnectableElement may be bound
      to multiple roles in the same CollaborationUse (that is, it may play multiple
      roles).")
   (|type| :xmi-id "CollaborationUse-type" :range |Collaboration| :multiplicity (1 1)
    :documentation
     "The Collaboration which is used in this CollaborationUse. The Collaboration
      defines the cooperation between its roles which are mapped to ConnectableElements
      relating to the Classifier owning the CollaborationUse.")))

(def-meta-assoc "A_roleBinding_collaborationUse"      
  :name |A_roleBinding_collaborationUse|      
  :metatype :association      
  :member-ends ((|CollaborationUse| "roleBinding")
                ("A_roleBinding_collaborationUse-collaborationUse" "collaborationUse"))      
  :owned-ends  (("A_roleBinding_collaborationUse-collaborationUse" "collaborationUse")))

(def-meta-assoc-end "A_roleBinding_collaborationUse-collaborationUse" 
    :type |CollaborationUse| 
    :multiplicity (0 1) 
    :association "A_roleBinding_collaborationUse" 
    :name "collaborationUse")

(def-meta-assoc "A_type_collaborationUse"      
  :name |A_type_collaborationUse|      
  :metatype :association      
  :member-ends ((|CollaborationUse| "type")
                ("A_type_collaborationUse-collaborationUse" "collaborationUse"))      
  :owned-ends  (("A_type_collaborationUse-collaborationUse" "collaborationUse")))

(def-meta-assoc-end "A_type_collaborationUse-collaborationUse" 
    :type |CollaborationUse| 
    :multiplicity (0 -1) 
    :association "A_type_collaborationUse" 
    :name "collaborationUse")

;;; =========================================================
;;; ====================== CombinedFragment
;;; =========================================================
(def-meta-class |CombinedFragment| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "CombinedFragment")
 "A CombinedFragment defines an expression of InteractionFragments. A CombinedFragment
  is defined by an interaction operator and corresponding InteractionOperands.
  Through the use of CombinedFragments the user will be able to describe
  a number of traces in a compact and concise manner."
  ((|cfragmentGate| :xmi-id "CombinedFragment-cfragmentGate" :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies the gates that form the interface between this CombinedFragment
      and its surroundings")
   (|interactionOperator| :xmi-id "CombinedFragment-interactionOperator" :range |InteractionOperatorKind| :multiplicity (1 1) :default :seq
    :documentation
     "Specifies the operation which defines the semantics of this combination
      of InteractionFragments.")
   (|operand| :xmi-id "CombinedFragment-operand" :range |InteractionOperand| :multiplicity (1 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The set of operands of the combined fragment.")))

(def-meta-assoc "A_cfragmentGate_combinedFragment"      
  :name |A_cfragmentGate_combinedFragment|      
  :metatype :association      
  :member-ends ((|CombinedFragment| "cfragmentGate")
                ("A_cfragmentGate_combinedFragment-combinedFragment" "combinedFragment"))      
  :owned-ends  (("A_cfragmentGate_combinedFragment-combinedFragment" "combinedFragment")))

(def-meta-assoc-end "A_cfragmentGate_combinedFragment-combinedFragment" 
    :type |CombinedFragment| 
    :multiplicity (0 1) 
    :association "A_cfragmentGate_combinedFragment" 
    :name "combinedFragment")

(def-meta-assoc "A_operand_combinedFragment"      
  :name |A_operand_combinedFragment|      
  :metatype :association      
  :member-ends ((|CombinedFragment| "operand")
                ("A_operand_combinedFragment-combinedFragment" "combinedFragment"))      
  :owned-ends  (("A_operand_combinedFragment-combinedFragment" "combinedFragment")))

(def-meta-assoc-end "A_operand_combinedFragment-combinedFragment" 
    :type |CombinedFragment| 
    :multiplicity (0 1) 
    :association "A_operand_combinedFragment" 
    :name "combinedFragment")

;;; =========================================================
;;; ====================== Comment
;;; =========================================================
(def-meta-class |Comment| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Comment")
 "A Comment is a textual annotation that can be attached to a set of Elements."
  ((|annotatedElement| :xmi-id "Comment-annotatedElement" :range |Element| :multiplicity (0 -1)
    :documentation
     "References the Element(s) being commented.")
   (|body| :xmi-id "Comment-body" :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a string that is the comment.")))

(def-meta-assoc "A_annotatedElement_comment"      
  :name |A_annotatedElement_comment|      
  :metatype :association      
  :member-ends ((|Comment| "annotatedElement")
                ("A_annotatedElement_comment-comment" "comment"))      
  :owned-ends  (("A_annotatedElement_comment-comment" "comment")))

(def-meta-assoc-end "A_annotatedElement_comment-comment" 
    :type |Comment| 
    :multiplicity (0 -1) 
    :association "A_annotatedElement_comment" 
    :name "comment")

;;; =========================================================
;;; ====================== CommunicationPath
;;; =========================================================
(def-meta-class |CommunicationPath| 
   (:model :UML25 :superclasses (|Association|) 
    :packages (UML |Deployments|) 
    :xmi-id "CommunicationPath")
 "A communication path is an association between two deployment targets,
  through which they are able to exchange signals and messages."
  ())

;;; =========================================================
;;; ====================== Component
;;; =========================================================
(def-meta-class |Component| 
   (:model :UML25 :superclasses (|Class|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Component")
 "A Component represents a modular part of a system that encapsulates its
  contents and whose manifestation is replaceable within its environment."
  ((|isIndirectlyInstantiated| :xmi-id "Component-isIndirectlyInstantiated" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, the Component is defined at design-time, but at run-time (or execution-time)
      an object specified by the Component does not exist, that is, the Component
      is instantiated indirectly, through the instantiation of its realizing
      Classifiers or parts.")
   (|packagedElement| :xmi-id "Component-packagedElement" :range |PackageableElement| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The set of PackageableElements that a Component owns. In the namespace
      of a Component, all model elements that are involved in or related to its
      definition may be owned or imported explicitly. These may include e.g.,
      Classes, Interfaces, Components, Packages, UseCases, Dependencies (e.g.,
      mappings), and Artifacts.")
   (|provided| :xmi-id "Component-provided" :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The Interfaces that the Component exposes to its environment. These Interfaces
      may be Realized by the Component or any of its realizingClassifiers, or
      they may be the Interfaces that are provided by its public Ports.")
   (|realization| :xmi-id "Component-realization" :range |ComponentRealization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ComponentRealization| |abstraction|)
    :documentation
     "The set of Realizations owned by the Component. Realizations reference
      the Classifiers of which the Component is an abstraction; i.e., that realize
      its behavior.")
   (|required| :xmi-id "Component-required" :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The Interfaces that the Component requires from other Components in its
      environment in order to be able to offer its full set of provided functionality.
      These Interfaces may be used by the Component or any of its realizingClassifiers,
      or they may be the Interfaces that are required by its public Ports.")))

(def-meta-operation "provided.1" |Component| 
   "Derivation for Component::/provided"
   :operation-body
   "result = (let  ris : Set(Interface) = allRealizedInterfaces(),          realizingClassifiers : Set(Classifier) =  self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),          allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),          realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allRealizedInterfaces())),          ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),          providedByPorts : Set(Interface) = ports.provided->asSet()  in     ris->union(realizingClassifierInterfaces) ->union(providedByPorts)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "required.1" |Component| 
   "Derivation for Component::/required"
   :operation-body
   "result = (let  uis : Set(Interface) = allUsedInterfaces(),          realizingClassifiers : Set(Classifier) = self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),          allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),          realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allUsedInterfaces())),          ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),          usedByPorts : Set(Interface) = ports.required->asSet()  in     uis->union(realizingClassifierInterfaces)->union(usedByPorts)->asSet()  )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-assoc "A_packagedElement_component"      
  :name |A_packagedElement_component|      
  :metatype :association      
  :member-ends ((|Component| "packagedElement")
                ("A_packagedElement_component-component" "component"))      
  :owned-ends  (("A_packagedElement_component-component" "component")))

(def-meta-assoc-end "A_packagedElement_component-component" 
    :type |Component| 
    :multiplicity (0 1) 
    :association "A_packagedElement_component" 
    :name "component")

(def-meta-assoc "A_provided_component"      
  :name |A_provided_component|      
  :metatype :association      
  :member-ends ((|Component| "provided")
                ("A_provided_component-component" "component"))      
  :owned-ends  (("A_provided_component-component" "component")))

(def-meta-assoc-end "A_provided_component-component" 
    :type |Component| 
    :multiplicity (0 -1) 
    :association "A_provided_component" 
    :name "component")

(def-meta-assoc "A_realization_abstraction_component"      
  :name |A_realization_abstraction_component|      
  :metatype :association      
  :member-ends ((|Component| "realization")
                (|ComponentRealization| "abstraction"))      
  :owned-ends  ())

(def-meta-assoc "A_required_component"      
  :name |A_required_component|      
  :metatype :association      
  :member-ends ((|Component| "required")
                ("A_required_component-component" "component"))      
  :owned-ends  (("A_required_component-component" "component")))

(def-meta-assoc-end "A_required_component-component" 
    :type |Component| 
    :multiplicity (0 -1) 
    :association "A_required_component" 
    :name "component")

;;; =========================================================
;;; ====================== ComponentRealization
;;; =========================================================
(def-meta-class |ComponentRealization| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "ComponentRealization")
 "Realization is specialized to (optionally) define the Classifiers that
  realize the contract offered by a Component in terms of its provided and
  required Interfaces. The Component forms an abstraction from these various
  Classifiers."
  ((|abstraction| :xmi-id "ComponentRealization-abstraction" :range |Component| :multiplicity (0 1)
    :subsetted-properties ((|Dependency| |supplier|) (|Element| |owner|))
    :opposite (|Component| |realization|)
    :documentation
     "The Component that owns this ComponentRealization and which is implemented
      by its realizing Classifiers.")
   (|realizingClassifier| :xmi-id "ComponentRealization-realizingClassifier" :range |Classifier| :multiplicity (1 -1)
    :subsetted-properties ((|Dependency| |client|))
    :documentation
     "The Classifiers that are involved in the implementation of the Component
      that owns this Realization.")))

(def-meta-assoc "A_realizingClassifier_componentRealization"      
  :name |A_realizingClassifier_componentRealization|      
  :metatype :association      
  :member-ends ((|ComponentRealization| "realizingClassifier")
                ("A_realizingClassifier_componentRealization-componentRealization" "componentRealization"))      
  :owned-ends  (("A_realizingClassifier_componentRealization-componentRealization" "componentRealization")))

(def-meta-assoc-end "A_realizingClassifier_componentRealization-componentRealization" 
    :type |ComponentRealization| 
    :multiplicity (0 -1) 
    :association "A_realizingClassifier_componentRealization" 
    :name "componentRealization")

;;; =========================================================
;;; ====================== ConditionalNode
;;; =========================================================
(def-meta-class |ConditionalNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "ConditionalNode")
 "A ConditionalNode is a StructuredActivityNode that chooses one among some
  number of alternative collections of ExecutableNodes to execute."
  ((|clause| :xmi-id "ConditionalNode-clause" :range |Clause| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The set of Clauses composing the ConditionalNode.")
   (|isAssured| :xmi-id "ConditionalNode-isAssured" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that the test for at least one Clause of the
      ConditionalNode will succeed.")
   (|isDeterminate| :xmi-id "ConditionalNode-isDeterminate" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that the test for at most one Clause of the
      ConditionalNode will succeed.")
   (|result| :xmi-id "ConditionalNode-result" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "The OutputPins that onto which are moved values from the bodyOutputs of
      the Clause selected for execution." :redefined-property (|StructuredActivityNode| |structuredNodeOutput|))))

(def-meta-operation "allActions" |ConditionalNode| 
   "Return only this ConditionalNode. This prevents Actions within the ConditionalNode
    from having their OutputPins used as bodyOutputs or decider Pins in containing
    LoopNodes or ConditionalNodes."
   :operation-body
   "result = (self->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Action|
                        :parameter-return-p T))
)

(def-meta-assoc "A_clause_conditionalNode"      
  :name |A_clause_conditionalNode|      
  :metatype :association      
  :member-ends ((|ConditionalNode| "clause")
                ("A_clause_conditionalNode-conditionalNode" "conditionalNode"))      
  :owned-ends  (("A_clause_conditionalNode-conditionalNode" "conditionalNode")))

(def-meta-assoc-end "A_clause_conditionalNode-conditionalNode" 
    :type |ConditionalNode| 
    :multiplicity (1 1) 
    :association "A_clause_conditionalNode" 
    :name "conditionalNode")

(def-meta-assoc "A_result_conditionalNode"      
  :name |A_result_conditionalNode|      
  :metatype :association      
  :member-ends ((|ConditionalNode| "result")
                ("A_result_conditionalNode-conditionalNode" "conditionalNode"))      
  :owned-ends  (("A_result_conditionalNode-conditionalNode" "conditionalNode")))

(def-meta-assoc-end "A_result_conditionalNode-conditionalNode" 
    :type |ConditionalNode| 
    :multiplicity (0 1) 
    :association "A_result_conditionalNode" 
    :name "conditionalNode")

;;; =========================================================
;;; ====================== ConnectableElement
;;; =========================================================
(def-meta-class |ConnectableElement| 
   (:model :UML25 :superclasses (|TypedElement| |ParameterableElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "ConnectableElement")
 "ConnectableElement is an abstract metaclass representing a set of instances
  that play roles of a StructuredClassifier. ConnectableElements may be joined
  by attached Connectors and specify configurations of linked instances to
  be created within an instance of the containing StructuredClassifier."
  ((|end| :xmi-id "ConnectableElement-end" :range |ConnectorEnd| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|ConnectorEnd| |role|)
    :documentation
     "A set of ConnectorEnds that attach to this ConnectableElement.")
   (|templateParameter| :xmi-id "ConnectableElement-templateParameter" :range |ConnectableElementTemplateParameter| :multiplicity (0 1)
    :opposite (|ConnectableElementTemplateParameter| |parameteredElement|)
    :documentation
     "The ConnectableElementTemplateParameter for this ConnectableElement parameter." :redefined-property (|ParameterableElement| |templateParameter|))))

(def-meta-operation "end.1" |ConnectableElement| 
   "Derivation for ConnectableElement::/end : ConnectorEnd"
   :operation-body
   "result = (ConnectorEnd.allInstances()->select(role = self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorEnd|
                        :parameter-return-p T))
)

(def-meta-assoc "A_connectableElement_templateParameter_parameteredElement"      
  :name |A_connectableElement_templateParameter_parameteredElement|      
  :metatype :association      
  :member-ends ((|ConnectableElement| "templateParameter")
                (|ConnectableElementTemplateParameter| "parameteredElement"))      
  :owned-ends  ())

(def-meta-assoc "A_end_role"      
  :name |A_end_role|      
  :metatype :association      
  :member-ends ((|ConnectableElement| "end")
                (|ConnectorEnd| "role"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ConnectableElementTemplateParameter
;;; =========================================================
(def-meta-class |ConnectableElementTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "ConnectableElementTemplateParameter")
 "A ConnectableElementTemplateParameter exposes a ConnectableElement as a
  formal parameter for a template."
  ((|parameteredElement| :xmi-id "ConnectableElementTemplateParameter-parameteredElement" :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |templateParameter|)
    :documentation
     "The ConnectableElement for this ConnectableElementTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))

;;; =========================================================
;;; ====================== ConnectionPointReference
;;; =========================================================
(def-meta-class |ConnectionPointReference| 
   (:model :UML25 :superclasses (|Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "ConnectionPointReference")
 "A ConnectionPointReference represents a usage (as part of a submachine
  State) of an entry/exit point Pseudostate defined in the StateMachine referenced
  by the submachine State."
  ((|entry| :xmi-id "ConnectionPointReference-entry" :range |Pseudostate| :multiplicity (0 -1)
    :documentation
     "The entryPoint Pseudostates corresponding to this connection point.")
   (|exit| :xmi-id "ConnectionPointReference-exit" :range |Pseudostate| :multiplicity (0 -1)
    :documentation
     "The exitPoints kind Pseudostates corresponding to this connection point.")
   (|state| :xmi-id "ConnectionPointReference-state" :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |connection|)
    :documentation
     "The State in which the ConnectionPointReference is defined.")))

(def-meta-assoc "A_entry_connectionPointReference"      
  :name |A_entry_connectionPointReference|      
  :metatype :association      
  :member-ends ((|ConnectionPointReference| "entry")
                ("A_entry_connectionPointReference-connectionPointReference" "connectionPointReference"))      
  :owned-ends  (("A_entry_connectionPointReference-connectionPointReference" "connectionPointReference")))

(def-meta-assoc-end "A_entry_connectionPointReference-connectionPointReference" 
    :type |ConnectionPointReference| 
    :multiplicity (0 1) 
    :association "A_entry_connectionPointReference" 
    :name "connectionPointReference")

(def-meta-assoc "A_exit_connectionPointReference"      
  :name |A_exit_connectionPointReference|      
  :metatype :association      
  :member-ends ((|ConnectionPointReference| "exit")
                ("A_exit_connectionPointReference-connectionPointReference" "connectionPointReference"))      
  :owned-ends  (("A_exit_connectionPointReference-connectionPointReference" "connectionPointReference")))

(def-meta-assoc-end "A_exit_connectionPointReference-connectionPointReference" 
    :type |ConnectionPointReference| 
    :multiplicity (0 1) 
    :association "A_exit_connectionPointReference" 
    :name "connectionPointReference")

;;; =========================================================
;;; ====================== Connector
;;; =========================================================
(def-meta-class |Connector| 
   (:model :UML25 :superclasses (|Feature|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Connector")
 "A Connector specifies links that enables communication between two or more
  instances. In contrast to Associations, which specify links between any
  instance of the associated Classifiers, Connectors specify links between
  instances playing the connected parts only."
  ((|contract| :xmi-id "Connector-contract" :range |Behavior| :multiplicity (0 -1)
    :documentation
     "The set of Behaviors that specify the valid interaction patterns across
      the Connector.")
   (|end| :xmi-id "Connector-end" :range |ConnectorEnd| :multiplicity (2 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Connector has at least two ConnectorEnds, each representing the participation
      of instances of the Classifiers typing the ConnectableElements attached
      to the end. The set of ConnectorEnds is ordered.")
   (|kind| :xmi-id "Connector-kind" :range |ConnectorKind| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Indicates the kind of Connector. This is derived: a Connector with one
      or more ends connected to a Port which is not on a Part and which is not
      a behavior port is a delegation; otherwise it is an assembly.")
   (|redefinedConnector| :xmi-id "Connector-redefinedConnector" :range |Connector| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "A Connector may be redefined when its containing Classifier is specialized.
      The redefining Connector may have a type that specializes the type of the
      redefined Connector. The types of the ConnectorEnds of the redefining Connector
      may specialize the types of the ConnectorEnds of the redefined Connector.
      The properties of the ConnectorEnds of the redefining Connector may be
      replaced.")
   (|type| :xmi-id "Connector-type" :range |Association| :multiplicity (0 1)
    :documentation
     "An optional Association that classifies links corresponding to this Connector.")))

(def-meta-operation "kind.1" |Connector| 
   "Derivation for Connector::/kind : ConnectorKind"
   :operation-body
   "result = (if end->exists(    role.oclIsKindOf(Port)     and partWithPort->isEmpty()    and not role.oclAsType(Port).isBehavior)  then ConnectorKind::delegation   else ConnectorKind::assembly   endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorKind|
                        :parameter-return-p T))
)

(def-meta-assoc "A_contract_connector"      
  :name |A_contract_connector|      
  :metatype :association      
  :member-ends ((|Connector| "contract")
                ("A_contract_connector-connector" "connector"))      
  :owned-ends  (("A_contract_connector-connector" "connector")))

(def-meta-assoc-end "A_contract_connector-connector" 
    :type |Connector| 
    :multiplicity (0 -1) 
    :association "A_contract_connector" 
    :name "connector")

(def-meta-assoc "A_end_connector"      
  :name |A_end_connector|      
  :metatype :association      
  :member-ends ((|Connector| "end")
                ("A_end_connector-connector" "connector"))      
  :owned-ends  (("A_end_connector-connector" "connector")))

(def-meta-assoc-end "A_end_connector-connector" 
    :type |Connector| 
    :multiplicity (1 1) 
    :association "A_end_connector" 
    :name "connector")

(def-meta-assoc "A_redefinedConnector_connector"      
  :name |A_redefinedConnector_connector|      
  :metatype :association      
  :member-ends ((|Connector| "redefinedConnector")
                ("A_redefinedConnector_connector-connector" "connector"))      
  :owned-ends  (("A_redefinedConnector_connector-connector" "connector")))

(def-meta-assoc-end "A_redefinedConnector_connector-connector" 
    :type |Connector| 
    :multiplicity (0 -1) 
    :association "A_redefinedConnector_connector" 
    :name "connector")

(def-meta-assoc "A_type_connector"      
  :name |A_type_connector|      
  :metatype :association      
  :member-ends ((|Connector| "type")
                ("A_type_connector-connector" "connector"))      
  :owned-ends  (("A_type_connector-connector" "connector")))

(def-meta-assoc-end "A_type_connector-connector" 
    :type |Connector| 
    :multiplicity (0 -1) 
    :association "A_type_connector" 
    :name "connector")

;;; =========================================================
;;; ====================== ConnectorEnd
;;; =========================================================
(def-meta-class |ConnectorEnd| 
   (:model :UML25 :superclasses (|MultiplicityElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "ConnectorEnd")
 "A ConnectorEnd is an endpoint of a Connector, which attaches the Connector
  to a ConnectableElement."
  ((|definingEnd| :xmi-id "ConnectorEnd-definingEnd" :range |Property| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A derived property referencing the corresponding end on the Association
      which types the Connector owing this ConnectorEnd, if any. It is derived
      by selecting the end at the same place in the ordering of Association ends
      as this ConnectorEnd.")
   (|partWithPort| :xmi-id "ConnectorEnd-partWithPort" :range |Property| :multiplicity (0 1)
    :documentation
     "Indicates the role of the internal structure of a Classifier with the Port
      to which the ConnectorEnd is attached.")
   (|role| :xmi-id "ConnectorEnd-role" :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |end|)
    :documentation
     "The ConnectableElement attached at this ConnectorEnd. When an instance
      of the containing Classifier is created, a link may (depending on the multiplicities)
      be created to an instance of the Classifier that types this ConnectableElement.")))

(def-meta-operation "definingEnd.1" |ConnectorEnd| 
   "Derivation for ConnectorEnd::/definingEnd : Property"
   :operation-body
   "result = (if connector.type = null   then    null   else    let index : Integer = connector.end->indexOf(self) in      connector.type.memberEnd->at(index)  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-assoc "A_definingEnd_connectorEnd"      
  :name |A_definingEnd_connectorEnd|      
  :metatype :association      
  :member-ends ((|ConnectorEnd| "definingEnd")
                ("A_definingEnd_connectorEnd-connectorEnd" "connectorEnd"))      
  :owned-ends  (("A_definingEnd_connectorEnd-connectorEnd" "connectorEnd")))

(def-meta-assoc-end "A_definingEnd_connectorEnd-connectorEnd" 
    :type |ConnectorEnd| 
    :multiplicity (0 -1) 
    :association "A_definingEnd_connectorEnd" 
    :name "connectorEnd")

(def-meta-assoc "A_partWithPort_connectorEnd"      
  :name |A_partWithPort_connectorEnd|      
  :metatype :association      
  :member-ends ((|ConnectorEnd| "partWithPort")
                ("A_partWithPort_connectorEnd-connectorEnd" "connectorEnd"))      
  :owned-ends  (("A_partWithPort_connectorEnd-connectorEnd" "connectorEnd")))

(def-meta-assoc-end "A_partWithPort_connectorEnd-connectorEnd" 
    :type |ConnectorEnd| 
    :multiplicity (0 -1) 
    :association "A_partWithPort_connectorEnd" 
    :name "connectorEnd")

;;; =========================================================
;;; ====================== ConsiderIgnoreFragment
;;; =========================================================
(def-meta-class |ConsiderIgnoreFragment| 
   (:model :UML25 :superclasses (|CombinedFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "ConsiderIgnoreFragment")
 "A ConsiderIgnoreFragment is a kind of CombinedFragment that is used for
  the consider and ignore cases, which require lists of pertinent Messages
  to be specified."
  ((|message| :xmi-id "ConsiderIgnoreFragment-message" :range |NamedElement| :multiplicity (0 -1)
    :documentation
     "The set of messages that apply to this fragment.")))

(def-meta-assoc "A_message_considerIgnoreFragment"      
  :name |A_message_considerIgnoreFragment|      
  :metatype :association      
  :member-ends ((|ConsiderIgnoreFragment| "message")
                ("A_message_considerIgnoreFragment-considerIgnoreFragment" "considerIgnoreFragment"))      
  :owned-ends  (("A_message_considerIgnoreFragment-considerIgnoreFragment" "considerIgnoreFragment")))

(def-meta-assoc-end "A_message_considerIgnoreFragment-considerIgnoreFragment" 
    :type |ConsiderIgnoreFragment| 
    :multiplicity (0 -1) 
    :association "A_message_considerIgnoreFragment" 
    :name "considerIgnoreFragment")

;;; =========================================================
;;; ====================== Constraint
;;; =========================================================
(def-meta-class |Constraint| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Constraint")
 "A Constraint is a condition or restriction expressed in natural language
  text or in a machine readable language for the purpose of declaring some
  of the semantics of an Element or set of Elements."
  ((|constrainedElement| :xmi-id "Constraint-constrainedElement" :range |Element| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The ordered set of Elements referenced by this Constraint.")
   (|context| :xmi-id "Constraint-context" :range |Namespace| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Namespace| |ownedRule|)
    :documentation
     "Specifies the Namespace that owns the Constraint.")
   (|specification| :xmi-id "Constraint-specification" :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A condition that must be true when evaluated in order for the Constraint
      to be satisfied.")))

(def-meta-assoc "A_constrainedElement_constraint"      
  :name |A_constrainedElement_constraint|      
  :metatype :association      
  :member-ends ((|Constraint| "constrainedElement")
                ("A_constrainedElement_constraint-constraint" "constraint"))      
  :owned-ends  (("A_constrainedElement_constraint-constraint" "constraint")))

(def-meta-assoc-end "A_constrainedElement_constraint-constraint" 
    :type |Constraint| 
    :multiplicity (0 -1) 
    :association "A_constrainedElement_constraint" 
    :name "constraint")

(def-meta-assoc "A_specification_owningConstraint"      
  :name |A_specification_owningConstraint|      
  :metatype :association      
  :member-ends ((|Constraint| "specification")
                ("A_specification_owningConstraint-owningConstraint" "owningConstraint"))      
  :owned-ends  (("A_specification_owningConstraint-owningConstraint" "owningConstraint")))

(def-meta-assoc-end "A_specification_owningConstraint-owningConstraint" 
    :type |Constraint| 
    :multiplicity (0 1) 
    :association "A_specification_owningConstraint" 
    :name "owningConstraint")

;;; =========================================================
;;; ====================== Continuation
;;; =========================================================
(def-meta-class |Continuation| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "Continuation")
 "A Continuation is a syntactic way to define continuations of different
  branches of an alternative CombinedFragment. Continuations are intuitively
  similar to labels representing intermediate points in a flow of control."
  ((|setting| :xmi-id "Continuation-setting" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "True: when the Continuation is at the end of the enclosing InteractionFragment
      and False when it is in the beginning.")))

;;; =========================================================
;;; ====================== ControlFlow
;;; =========================================================
(def-meta-class |ControlFlow| 
   (:model :UML25 :superclasses (|ActivityEdge|) 
    :packages (UML |Activities|) 
    :xmi-id "ControlFlow")
 "A ControlFlow is an ActivityEdge traversed by control tokens or object
  tokens of control type, which are use to control the execution of ExecutableNodes."
  ())

;;; =========================================================
;;; ====================== ControlNode
;;; =========================================================
(def-meta-class |ControlNode| 
   (:model :UML25 :superclasses (|ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ControlNode")
 "A ControlNode is an abstract ActivityNode that coordinates flows in an
  Activity."
  ())

;;; =========================================================
;;; ====================== CreateLinkAction
;;; =========================================================
(def-meta-class |CreateLinkAction| 
   (:model :UML25 :superclasses (|WriteLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "CreateLinkAction")
 "A CreateLinkAction is a WriteLinkAction for creating links."
  ((|endData| :xmi-id "CreateLinkAction-endData" :range |LinkEndCreationData| :multiplicity (2 -1) :is-composite-p T
    :documentation
     "The LinkEndData that specifies the values to be placed on the Association
      ends for the new link." :redefined-property (|LinkAction| |endData|))))

(def-meta-assoc "A_endData_createLinkAction"      
  :name |A_endData_createLinkAction|      
  :metatype :association      
  :member-ends ((|CreateLinkAction| "endData")
                ("A_endData_createLinkAction-createLinkAction" "createLinkAction"))      
  :owned-ends  (("A_endData_createLinkAction-createLinkAction" "createLinkAction")))

(def-meta-assoc-end "A_endData_createLinkAction-createLinkAction" 
    :type |CreateLinkAction| 
    :multiplicity (1 1) 
    :association "A_endData_createLinkAction" 
    :name "createLinkAction")

;;; =========================================================
;;; ====================== CreateLinkObjectAction
;;; =========================================================
(def-meta-class |CreateLinkObjectAction| 
   (:model :UML25 :superclasses (|CreateLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "CreateLinkObjectAction")
 "A CreateLinkObjectAction is a CreateLinkAction for creating link objects
  (AssociationClasse instances)."
  ((|result| :xmi-id "CreateLinkObjectAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The output pin on which the newly created link object is placed.")))

(def-meta-assoc "A_result_createLinkObjectAction"      
  :name |A_result_createLinkObjectAction|      
  :metatype :association      
  :member-ends ((|CreateLinkObjectAction| "result")
                ("A_result_createLinkObjectAction-createLinkObjectAction" "createLinkObjectAction"))      
  :owned-ends  (("A_result_createLinkObjectAction-createLinkObjectAction" "createLinkObjectAction")))

(def-meta-assoc-end "A_result_createLinkObjectAction-createLinkObjectAction" 
    :type |CreateLinkObjectAction| 
    :multiplicity (0 1) 
    :association "A_result_createLinkObjectAction" 
    :name "createLinkObjectAction")

;;; =========================================================
;;; ====================== CreateObjectAction
;;; =========================================================
(def-meta-class |CreateObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "CreateObjectAction")
 "A CreateObjectAction is an Action that creates an instance of the specified
  Classifier."
  ((|classifier| :xmi-id "CreateObjectAction-classifier" :range |Classifier| :multiplicity (1 1)
    :documentation
     "The Classifier to be instantiated.")
   (|result| :xmi-id "CreateObjectAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the newly created object is placed.")))

(def-meta-assoc "A_classifier_createObjectAction"      
  :name |A_classifier_createObjectAction|      
  :metatype :association      
  :member-ends ((|CreateObjectAction| "classifier")
                ("A_classifier_createObjectAction-createObjectAction" "createObjectAction"))      
  :owned-ends  (("A_classifier_createObjectAction-createObjectAction" "createObjectAction")))

(def-meta-assoc-end "A_classifier_createObjectAction-createObjectAction" 
    :type |CreateObjectAction| 
    :multiplicity (0 -1) 
    :association "A_classifier_createObjectAction" 
    :name "createObjectAction")

(def-meta-assoc "A_result_createObjectAction"      
  :name |A_result_createObjectAction|      
  :metatype :association      
  :member-ends ((|CreateObjectAction| "result")
                ("A_result_createObjectAction-createObjectAction" "createObjectAction"))      
  :owned-ends  (("A_result_createObjectAction-createObjectAction" "createObjectAction")))

(def-meta-assoc-end "A_result_createObjectAction-createObjectAction" 
    :type |CreateObjectAction| 
    :multiplicity (0 1) 
    :association "A_result_createObjectAction" 
    :name "createObjectAction")

;;; =========================================================
;;; ====================== DataStoreNode
;;; =========================================================
(def-meta-class |DataStoreNode| 
   (:model :UML25 :superclasses (|CentralBufferNode|) 
    :packages (UML |Activities|) 
    :xmi-id "DataStoreNode")
 "A DataStoreNode is a CentralBufferNode for persistent data."
  ())

;;; =========================================================
;;; ====================== DataType
;;; =========================================================
(def-meta-class |DataType| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "DataType")
 "A DataType is a type whose instances are identified only by their value."
  ((|ownedAttribute| :xmi-id "DataType-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |datatype|)
    :documentation
     "The attributes owned by the DataType.")
   (|ownedOperation| :xmi-id "DataType-ownedOperation" :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |datatype|)
    :documentation
     "The Operations owned by the DataType.")))

(def-meta-assoc "A_ownedAttribute_datatype"      
  :name |A_ownedAttribute_datatype|      
  :metatype :association      
  :member-ends ((|DataType| "ownedAttribute")
                (|Property| "datatype"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedOperation_datatype"      
  :name |A_ownedOperation_datatype|      
  :metatype :association      
  :member-ends ((|DataType| "ownedOperation")
                (|Operation| "datatype"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== DecisionNode
;;; =========================================================
(def-meta-class |DecisionNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "DecisionNode")
 "A DecisionNode is a ControlNode that chooses between outgoing ActivityEdges
  for the routing of tokens."
  ((|decisionInput| :xmi-id "DecisionNode-decisionInput" :range |Behavior| :multiplicity (0 1)
    :documentation
     "A Behavior that is executed to provide an input to guard ValueSpecifications
      on ActivityEdges outgoing from the DecisionNode.")
   (|decisionInputFlow| :xmi-id "DecisionNode-decisionInputFlow" :range |ObjectFlow| :multiplicity (0 1)
    :documentation
     "An additional ActivityEdge incoming to the DecisionNode that provides a
      decision input value for the guards ValueSpecifications on ActivityEdges
      outgoing from the DecisionNode.")))

(def-meta-assoc "A_decisionInputFlow_decisionNode"      
  :name |A_decisionInputFlow_decisionNode|      
  :metatype :association      
  :member-ends ((|DecisionNode| "decisionInputFlow")
                ("A_decisionInputFlow_decisionNode-decisionNode" "decisionNode"))      
  :owned-ends  (("A_decisionInputFlow_decisionNode-decisionNode" "decisionNode")))

(def-meta-assoc-end "A_decisionInputFlow_decisionNode-decisionNode" 
    :type |DecisionNode| 
    :multiplicity (0 1) 
    :association "A_decisionInputFlow_decisionNode" 
    :name "decisionNode")

(def-meta-assoc "A_decisionInput_decisionNode"      
  :name |A_decisionInput_decisionNode|      
  :metatype :association      
  :member-ends ((|DecisionNode| "decisionInput")
                ("A_decisionInput_decisionNode-decisionNode" "decisionNode"))      
  :owned-ends  (("A_decisionInput_decisionNode-decisionNode" "decisionNode")))

(def-meta-assoc-end "A_decisionInput_decisionNode-decisionNode" 
    :type |DecisionNode| 
    :multiplicity (0 -1) 
    :association "A_decisionInput_decisionNode" 
    :name "decisionNode")

;;; =========================================================
;;; ====================== Dependency
;;; =========================================================
(def-meta-class |Dependency| 
   (:model :UML25 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Dependency")
 "A Dependency is a Relationship that signifies that a single model Element
  or a set of model Elements requires other model Elements for their specification
  or implementation. This means that the complete semantics of the client
  Element(s) are either semantically or structurally dependent on the definition
  of the supplier Element(s)."
  ((|client| :xmi-id "Dependency-client" :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|NamedElement| |clientDependency|)
    :documentation
     "The Element(s) dependent on the supplier Element(s). In some cases (such
      as a trace Abstraction) the assignment of direction (that is, the designation
      of the client Element) is at the discretion of the modeler and is a stipulation.")
   (|supplier| :xmi-id "Dependency-supplier" :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The Element(s) on which the client Element(s) depend in some respect. The
      modeler may stipulate a sense of Dependency direction suitable for their
      domain.")))

(def-meta-assoc "A_supplier_supplierDependency"      
  :name |A_supplier_supplierDependency|      
  :metatype :association      
  :member-ends ((|Dependency| "supplier")
                ("A_supplier_supplierDependency-supplierDependency" "supplierDependency"))      
  :owned-ends  (("A_supplier_supplierDependency-supplierDependency" "supplierDependency")))

(def-meta-assoc-end "A_supplier_supplierDependency-supplierDependency" 
    :type |Dependency| 
    :multiplicity (0 -1) 
    :association "A_supplier_supplierDependency" 
    :name "supplierDependency")

;;; =========================================================
;;; ====================== DeployedArtifact
;;; =========================================================
(def-meta-class |DeployedArtifact| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Deployments|) 
    :xmi-id "DeployedArtifact")
 "A deployed artifact is an artifact or artifact instance that has been deployed
  to a deployment target."
  ())

;;; =========================================================
;;; ====================== Deployment
;;; =========================================================
(def-meta-class |Deployment| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |Deployments|) 
    :xmi-id "Deployment")
 "A deployment is the allocation of an artifact or artifact instance to a
  deployment target. A component deployment is the deployment of one or more
  artifacts or artifact instances to a deployment target, optionally parameterized
  by a deployment specification. Examples are executables and configuration
  files."
  ((|configuration| :xmi-id "Deployment-configuration" :range |DeploymentSpecification| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|DeploymentSpecification| |deployment|)
    :documentation
     "The specification of properties that parameterize the deployment and execution
      of one or more Artifacts.")
   (|deployedArtifact| :xmi-id "Deployment-deployedArtifact" :range |DeployedArtifact| :multiplicity (0 -1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "The Artifacts that are deployed onto a Node. This association specializes
      the supplier association.")
   (|location| :xmi-id "Deployment-location" :range |DeploymentTarget| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|DeploymentTarget| |deployment|)
    :documentation
     "The DeployedTarget which is the target of a Deployment.")))

(def-meta-assoc "A_configuration_deployment"      
  :name |A_configuration_deployment|      
  :metatype :association      
  :member-ends ((|Deployment| "configuration")
                (|DeploymentSpecification| "deployment"))      
  :owned-ends  ())

(def-meta-assoc "A_deployedArtifact_deploymentForArtifact"      
  :name |A_deployedArtifact_deploymentForArtifact|      
  :metatype :association      
  :member-ends ((|Deployment| "deployedArtifact")
                ("A_deployedArtifact_deploymentForArtifact-deploymentForArtifact" "deploymentForArtifact"))      
  :owned-ends  (("A_deployedArtifact_deploymentForArtifact-deploymentForArtifact" "deploymentForArtifact")))

(def-meta-assoc-end "A_deployedArtifact_deploymentForArtifact-deploymentForArtifact" 
    :type |Deployment| 
    :multiplicity (0 -1) 
    :association "A_deployedArtifact_deploymentForArtifact" 
    :name "deploymentForArtifact")

;;; =========================================================
;;; ====================== DeploymentSpecification
;;; =========================================================
(def-meta-class |DeploymentSpecification| 
   (:model :UML25 :superclasses (|Artifact|) 
    :packages (UML |Deployments|) 
    :xmi-id "DeploymentSpecification")
 "A deployment specification specifies a set of properties that determine
  execution parameters of a component artifact that is deployed on a node.
  A deployment specification can be aimed at a specific type of container.
  An artifact that reifies or implements deployment specification properties
  is a deployment descriptor."
  ((|deployment| :xmi-id "DeploymentSpecification-deployment" :range |Deployment| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Deployment| |configuration|)
    :documentation
     "The deployment with which the DeploymentSpecification is associated.")
   (|deploymentLocation| :xmi-id "DeploymentSpecification-deploymentLocation" :range |String| :multiplicity (0 1)
    :documentation
     "The location where an Artifact is deployed onto a Node. This is typically
      a 'directory' or 'memory address.'")
   (|executionLocation| :xmi-id "DeploymentSpecification-executionLocation" :range |String| :multiplicity (0 1)
    :documentation
     "The location where a component Artifact executes. This may be a local or
      remote location.")))

;;; =========================================================
;;; ====================== DeploymentTarget
;;; =========================================================
(def-meta-class |DeploymentTarget| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Deployments|) 
    :xmi-id "DeploymentTarget")
 "A deployment target is the location for a deployed artifact."
  ((|deployedElement| :xmi-id "DeploymentTarget-deployedElement" :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The set of elements that are manifested in an Artifact that is involved
      in Deployment to a DeploymentTarget.")
   (|deployment| :xmi-id "DeploymentTarget-deployment" :range |Deployment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|Deployment| |location|)
    :documentation
     "The set of Deployments for a DeploymentTarget.")))

(def-meta-operation "deployedElement.1" |DeploymentTarget| 
   "Derivation for DeploymentTarget::/deployedElement"
   :operation-body
   "result = (deployment.deployedArtifact->select(oclIsKindOf(Artifact))->collect(oclAsType(Artifact).manifestation)->collect(utilizedElement)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

(def-meta-assoc "A_deployedElement_deploymentTarget"      
  :name |A_deployedElement_deploymentTarget|      
  :metatype :association      
  :member-ends ((|DeploymentTarget| "deployedElement")
                ("A_deployedElement_deploymentTarget-deploymentTarget" "deploymentTarget"))      
  :owned-ends  (("A_deployedElement_deploymentTarget-deploymentTarget" "deploymentTarget")))

(def-meta-assoc-end "A_deployedElement_deploymentTarget-deploymentTarget" 
    :type |DeploymentTarget| 
    :multiplicity (0 -1) 
    :association "A_deployedElement_deploymentTarget" 
    :name "deploymentTarget")

(def-meta-assoc "A_deployment_location"      
  :name |A_deployment_location|      
  :metatype :association      
  :member-ends ((|DeploymentTarget| "deployment")
                (|Deployment| "location"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== DestroyLinkAction
;;; =========================================================
(def-meta-class |DestroyLinkAction| 
   (:model :UML25 :superclasses (|WriteLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "DestroyLinkAction")
 "A DestroyLinkAction is a WriteLinkAction that destroys links (including
  link objects)."
  ((|endData| :xmi-id "DestroyLinkAction-endData" :range |LinkEndDestructionData| :multiplicity (2 -1) :is-composite-p T
    :documentation
     "The LinkEndData that the values of the Association ends for the links to
      be destroyed." :redefined-property (|LinkAction| |endData|))))

(def-meta-assoc "A_endData_destroyLinkAction"      
  :name |A_endData_destroyLinkAction|      
  :metatype :association      
  :member-ends ((|DestroyLinkAction| "endData")
                ("A_endData_destroyLinkAction-destroyLinkAction" "destroyLinkAction"))      
  :owned-ends  (("A_endData_destroyLinkAction-destroyLinkAction" "destroyLinkAction")))

(def-meta-assoc-end "A_endData_destroyLinkAction-destroyLinkAction" 
    :type |DestroyLinkAction| 
    :multiplicity (1 1) 
    :association "A_endData_destroyLinkAction" 
    :name "destroyLinkAction")

;;; =========================================================
;;; ====================== DestroyObjectAction
;;; =========================================================
(def-meta-class |DestroyObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "DestroyObjectAction")
 "A DestroyObjectAction is an Action that destroys objects."
  ((|isDestroyLinks| :xmi-id "DestroyObjectAction-isDestroyLinks" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether links in which the object participates are destroyed
      along with the object.")
   (|isDestroyOwnedObjects| :xmi-id "DestroyObjectAction-isDestroyOwnedObjects" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether objects owned by the object (via composition) are destroyed
      along with the object.")
   (|target| :xmi-id "DestroyObjectAction-target" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin providing the object to be destroyed.")))

(def-meta-assoc "A_target_destroyObjectAction"      
  :name |A_target_destroyObjectAction|      
  :metatype :association      
  :member-ends ((|DestroyObjectAction| "target")
                ("A_target_destroyObjectAction-destroyObjectAction" "destroyObjectAction"))      
  :owned-ends  (("A_target_destroyObjectAction-destroyObjectAction" "destroyObjectAction")))

(def-meta-assoc-end "A_target_destroyObjectAction-destroyObjectAction" 
    :type |DestroyObjectAction| 
    :multiplicity (0 1) 
    :association "A_target_destroyObjectAction" 
    :name "destroyObjectAction")

;;; =========================================================
;;; ====================== DestructionOccurrenceSpecification
;;; =========================================================
(def-meta-class |DestructionOccurrenceSpecification| 
   (:model :UML25 :superclasses (|MessageOccurrenceSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "DestructionOccurrenceSpecification")
 "A DestructionOccurenceSpecification models the destruction of an object."
  ())

;;; =========================================================
;;; ====================== Device
;;; =========================================================
(def-meta-class |Device| 
   (:model :UML25 :superclasses (|Node|) 
    :packages (UML |Deployments|) 
    :xmi-id "Device")
 "A device is a physical computational resource with processing capability
  upon which artifacts may be deployed for execution. Devices may be complex
  (i.e., they may consist of other devices)."
  ())

;;; =========================================================
;;; ====================== DirectedRelationship
;;; =========================================================
(def-meta-class |DirectedRelationship| 
   (:model :UML25 :superclasses (|Relationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "DirectedRelationship")
 "A DirectedRelationship represents a relationship between a collection of
  source model Elements and a collection of target model Elements."
  ((|source| :xmi-id "DirectedRelationship-source" :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the source Element(s) of the DirectedRelationship.")
   (|target| :xmi-id "DirectedRelationship-target" :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the target Element(s) of the DirectedRelationship.")))

(def-meta-assoc "A_source_directedRelationship"      
  :name |A_source_directedRelationship|      
  :metatype :association      
  :member-ends ((|DirectedRelationship| "source")
                ("A_source_directedRelationship-directedRelationship" "directedRelationship"))      
  :owned-ends  (("A_source_directedRelationship-directedRelationship" "directedRelationship")))

(def-meta-assoc-end "A_source_directedRelationship-directedRelationship" 
    :type |DirectedRelationship| 
    :multiplicity (0 -1) 
    :association "A_source_directedRelationship" 
    :name "directedRelationship")

(def-meta-assoc "A_target_directedRelationship"      
  :name |A_target_directedRelationship|      
  :metatype :association      
  :member-ends ((|DirectedRelationship| "target")
                ("A_target_directedRelationship-directedRelationship" "directedRelationship"))      
  :owned-ends  (("A_target_directedRelationship-directedRelationship" "directedRelationship")))

(def-meta-assoc-end "A_target_directedRelationship-directedRelationship" 
    :type |DirectedRelationship| 
    :multiplicity (0 -1) 
    :association "A_target_directedRelationship" 
    :name "directedRelationship")

;;; =========================================================
;;; ====================== Duration
;;; =========================================================
(def-meta-class |Duration| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "Duration")
 "A Duration is a ValueSpecification that specifies the temporal distance
  between two time instants."
  ((|expr| :xmi-id "Duration-expr" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification that evaluates to the value of the Duration.")
   (|observation| :xmi-id "Duration-observation" :range |Observation| :multiplicity (0 -1)
    :documentation
     "Refers to the Observations that are involved in the computation of the
      Duration value")))

(def-meta-assoc "A_expr_duration"      
  :name |A_expr_duration|      
  :metatype :association      
  :member-ends ((|Duration| "expr")
                ("A_expr_duration-duration" "duration"))      
  :owned-ends  (("A_expr_duration-duration" "duration")))

(def-meta-assoc-end "A_expr_duration-duration" 
    :type |Duration| 
    :multiplicity (0 1) 
    :association "A_expr_duration" 
    :name "duration")

(def-meta-assoc "A_observation_duration"      
  :name |A_observation_duration|      
  :metatype :association      
  :member-ends ((|Duration| "observation")
                ("A_observation_duration-duration" "duration"))      
  :owned-ends  (("A_observation_duration-duration" "duration")))

(def-meta-assoc-end "A_observation_duration-duration" 
    :type |Duration| 
    :multiplicity (0 1) 
    :association "A_observation_duration" 
    :name "duration")

;;; =========================================================
;;; ====================== DurationConstraint
;;; =========================================================
(def-meta-class |DurationConstraint| 
   (:model :UML25 :superclasses (|IntervalConstraint|) 
    :packages (UML |Values|) 
    :xmi-id "DurationConstraint")
 "A DurationConstraint is a Constraint that refers to a DurationInterval."
  ((|firstEvent| :xmi-id "DurationConstraint-firstEvent" :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to constrainedElement[i] (where i
      is 1 or 2). If firstEvent[i] is true, then the corresponding observation
      event is the first time instant the execution enters constrainedElement[i].
      If firstEvent[i] is false, then the corresponding observation event is
      the last time instant the execution is within constrainedElement[i].")
   (|specification| :xmi-id "DurationConstraint-specification" :range |DurationInterval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The DurationInterval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))

(def-meta-assoc "A_specification_durationConstraint"      
  :name |A_specification_durationConstraint|      
  :metatype :association      
  :member-ends ((|DurationConstraint| "specification")
                ("A_specification_durationConstraint-durationConstraint" "durationConstraint"))      
  :owned-ends  (("A_specification_durationConstraint-durationConstraint" "durationConstraint")))

(def-meta-assoc-end "A_specification_durationConstraint-durationConstraint" 
    :type |DurationConstraint| 
    :multiplicity (0 1) 
    :association "A_specification_durationConstraint" 
    :name "durationConstraint")

;;; =========================================================
;;; ====================== DurationInterval
;;; =========================================================
(def-meta-class |DurationInterval| 
   (:model :UML25 :superclasses (|Interval|) 
    :packages (UML |Values|) 
    :xmi-id "DurationInterval")
 "A DurationInterval defines the range between two Durations."
  ((|max| :xmi-id "DurationInterval-max" :range |Duration| :multiplicity (1 1)
    :documentation
     "Refers to the Duration denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :xmi-id "DurationInterval-min" :range |Duration| :multiplicity (1 1)
    :documentation
     "Refers to the Duration denoting the minimum value of the range." :redefined-property (|Interval| |min|))))

(def-meta-assoc "A_max_durationInterval"      
  :name |A_max_durationInterval|      
  :metatype :association      
  :member-ends ((|DurationInterval| "max")
                ("A_max_durationInterval-durationInterval" "durationInterval"))      
  :owned-ends  (("A_max_durationInterval-durationInterval" "durationInterval")))

(def-meta-assoc-end "A_max_durationInterval-durationInterval" 
    :type |DurationInterval| 
    :multiplicity (0 -1) 
    :association "A_max_durationInterval" 
    :name "durationInterval")

(def-meta-assoc "A_min_durationInterval"      
  :name |A_min_durationInterval|      
  :metatype :association      
  :member-ends ((|DurationInterval| "min")
                ("A_min_durationInterval-durationInterval" "durationInterval"))      
  :owned-ends  (("A_min_durationInterval-durationInterval" "durationInterval")))

(def-meta-assoc-end "A_min_durationInterval-durationInterval" 
    :type |DurationInterval| 
    :multiplicity (0 -1) 
    :association "A_min_durationInterval" 
    :name "durationInterval")

;;; =========================================================
;;; ====================== DurationObservation
;;; =========================================================
(def-meta-class |DurationObservation| 
   (:model :UML25 :superclasses (|Observation|) 
    :packages (UML |Values|) 
    :xmi-id "DurationObservation")
 "A DurationObservation is a reference to a duration during an execution.
  It points out the NamedElement(s) in the model to observe and whether the
  observations are when this NamedElement is entered or when it is exited."
  ((|event| :xmi-id "DurationObservation-event" :range |NamedElement| :multiplicity (1 2) :is-ordered-p T
    :documentation
     "The DurationObservation is determined as the duration between the entering
      or exiting of a single event Element during execution, or the entering/exiting
      of one event Element and the entering/exiting of a second.")
   (|firstEvent| :xmi-id "DurationObservation-firstEvent" :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to event[i] (where i is 1 or 2).
      If firstEvent[i] is true, then the corresponding observation event is the
      first time instant the execution enters event[i]. If firstEvent[i] is false,
      then the corresponding observation event is the time instant the execution
      exits event[i].")))

(def-meta-assoc "A_event_durationObservation"      
  :name |A_event_durationObservation|      
  :metatype :association      
  :member-ends ((|DurationObservation| "event")
                ("A_event_durationObservation-durationObservation" "durationObservation"))      
  :owned-ends  (("A_event_durationObservation-durationObservation" "durationObservation")))

(def-meta-assoc-end "A_event_durationObservation-durationObservation" 
    :type |DurationObservation| 
    :multiplicity (0 -1) 
    :association "A_event_durationObservation" 
    :name "durationObservation")

;;; =========================================================
;;; ====================== Element
;;; =========================================================
(def-meta-class |Element| 
   (:model :UML25 :superclasses NIL 
    :packages (UML |CommonStructure|) 
    :xmi-id "Element")
 "An Element is a constituent of a model. As such, it has the capability
  of owning other Elements."
  ((|ownedComment| :xmi-id "Element-ownedComment" :range |Comment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The Comments owned by this Element.")
   (|ownedElement| :xmi-id "Element-ownedElement" :range |Element| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :opposite (|Element| |owner|)
    :documentation
     "The Elements owned by this Element.")
   (|owner| :xmi-id "Element-owner" :range |Element| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Element| |ownedElement|)
    :documentation
     "The Element that owns this Element.")))

(def-meta-operation "allOwnedElements" |Element| 
   "The query allOwnedElements() gives all of the direct and indirect ownedElements
    of an Element."
   :operation-body
   "result = (ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Element|
                        :parameter-return-p T))
)

(def-meta-operation "mustBeOwned" |Element| 
   "The query mustBeOwned() indicates whether Elements of this type must have
    an owner. Subclasses of Element that do not require an owner must override
    this operation."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-assoc "A_ownedComment_owningElement"      
  :name |A_ownedComment_owningElement|      
  :metatype :association      
  :member-ends ((|Element| "ownedComment")
                ("A_ownedComment_owningElement-owningElement" "owningElement"))      
  :owned-ends  (("A_ownedComment_owningElement-owningElement" "owningElement")))

(def-meta-assoc-end "A_ownedComment_owningElement-owningElement" 
    :type |Element| 
    :multiplicity (0 1) 
    :association "A_ownedComment_owningElement" 
    :name "owningElement")

(def-meta-assoc "A_ownedElement_owner"      
  :name |A_ownedElement_owner|      
  :metatype :association      
  :member-ends ((|Element| "ownedElement")
                (|Element| "owner"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ElementImport
;;; =========================================================
(def-meta-class |ElementImport| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "ElementImport")
 "An ElementImport identifies a NamedElement in a Namespace other than the
  one that owns that NamedElement and allows the NamedElement to be referenced
  using an unqualified name in the Namespace owning the ElementImport."
  ((|alias| :xmi-id "ElementImport-alias" :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the name that should be added to the importing Namespace in lieu
      of the name of the imported PackagableElement. The alias must not clash
      with any other member in the importing Namespace. By default, no alias
      is used.")
   (|importedElement| :xmi-id "ElementImport-importedElement" :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the PackageableElement whose name is to be added to a Namespace.")
   (|importingNamespace| :xmi-id "ElementImport-importingNamespace" :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |elementImport|)
    :documentation
     "Specifies the Namespace that imports a PackageableElement from another
      Namespace.")
   (|visibility| :xmi-id "ElementImport-visibility" :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElement within the
      importingNamespace, i.e., whether the  importedElement will in turn be
      visible to other Namespaces. If the ElementImport is public, the importedElement
      will be visible outside the importingNamespace while, if the ElementImport
      is private, it will not.")))

(def-meta-operation "getName" |ElementImport| 
   "The query getName() returns the name under which the imported PackageableElement
    will be known in the importing namespace."
   :operation-body
   "result = (if alias->notEmpty() then   alias else   importedElement.name endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-assoc "A_importedElement_import"      
  :name |A_importedElement_import|      
  :metatype :association      
  :member-ends ((|ElementImport| "importedElement")
                ("A_importedElement_import-import" "import"))      
  :owned-ends  (("A_importedElement_import-import" "import")))

(def-meta-assoc-end "A_importedElement_import-import" 
    :type |ElementImport| 
    :multiplicity (0 -1) 
    :association "A_importedElement_import" 
    :name "import")

;;; =========================================================
;;; ====================== EncapsulatedClassifier
;;; =========================================================
(def-meta-class |EncapsulatedClassifier| 
   (:model :UML25 :superclasses (|StructuredClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "EncapsulatedClassifier")
 "An EncapsulatedClassifier may own Ports to specify typed interaction points."
  ((|ownedPort| :xmi-id "EncapsulatedClassifier-ownedPort" :range |Port| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|StructuredClassifier| |ownedAttribute|))
    :documentation
     "The Ports owned by the EncapsulatedClassifier.")))

(def-meta-operation "ownedPort.1" |EncapsulatedClassifier| 
   "Derivation for EncapsulatedClassifier::/ownedPort : Port"
   :operation-body
   "result = (ownedAttribute->select(oclIsKindOf(Port))->collect(oclAsType(Port))->asOrderedSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Port|
                        :parameter-return-p T))
)

(def-meta-assoc "A_ownedPort_encapsulatedClassifier"      
  :name |A_ownedPort_encapsulatedClassifier|      
  :metatype :association      
  :member-ends ((|EncapsulatedClassifier| "ownedPort")
                ("A_ownedPort_encapsulatedClassifier-encapsulatedClassifier" "encapsulatedClassifier"))      
  :owned-ends  (("A_ownedPort_encapsulatedClassifier-encapsulatedClassifier" "encapsulatedClassifier")))

(def-meta-assoc-end "A_ownedPort_encapsulatedClassifier-encapsulatedClassifier" 
    :type |EncapsulatedClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedPort_encapsulatedClassifier" 
    :name "encapsulatedClassifier")

;;; =========================================================
;;; ====================== Enumeration
;;; =========================================================
(def-meta-class |Enumeration| 
   (:model :UML25 :superclasses (|DataType|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "Enumeration")
 "An Enumeration is a DataType whose values are enumerated in the model as
  EnumerationLiterals."
  ((|ownedLiteral| :xmi-id "Enumeration-ownedLiteral" :range |EnumerationLiteral| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|EnumerationLiteral| |enumeration|)
    :documentation
     "The ordered set of literals owned by this Enumeration.")))

(def-meta-assoc "A_ownedLiteral_enumeration"      
  :name |A_ownedLiteral_enumeration|      
  :metatype :association      
  :member-ends ((|Enumeration| "ownedLiteral")
                (|EnumerationLiteral| "enumeration"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== EnumerationLiteral
;;; =========================================================
(def-meta-class |EnumerationLiteral| 
   (:model :UML25 :superclasses (|InstanceSpecification|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "EnumerationLiteral")
 "An EnumerationLiteral is a user-defined data value for an Enumeration."
  ((|classifier| :xmi-id "EnumerationLiteral-classifier" :range |Enumeration| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The classifier of this EnumerationLiteral derived to be equal to its Enumeration." :redefined-property (|InstanceSpecification| |classifier|))
   (|enumeration| :xmi-id "EnumerationLiteral-enumeration" :range |Enumeration| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Enumeration| |ownedLiteral|)
    :documentation
     "The Enumeration that this EnumerationLiteral is a member of.")))

(def-meta-operation "classifier.1" |EnumerationLiteral| 
   "Derivation of Enumeration::/classifier"
   :operation-body
   "result = (enumeration)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Enumeration|
                        :parameter-return-p T))
)

(def-meta-assoc "A_classifier_enumerationLiteral"      
  :name |A_classifier_enumerationLiteral|      
  :metatype :association      
  :member-ends ((|EnumerationLiteral| "classifier")
                ("A_classifier_enumerationLiteral-enumerationLiteral" "enumerationLiteral"))      
  :owned-ends  (("A_classifier_enumerationLiteral-enumerationLiteral" "enumerationLiteral")))

(def-meta-assoc-end "A_classifier_enumerationLiteral-enumerationLiteral" 
    :type |EnumerationLiteral| 
    :multiplicity (0 -1) 
    :association "A_classifier_enumerationLiteral" 
    :name "enumerationLiteral")

;;; =========================================================
;;; ====================== Event
;;; =========================================================
(def-meta-class |Event| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "Event")
 "An Event is the specification of some occurrence that may potentially trigger
  effects by an object."
  ())

;;; =========================================================
;;; ====================== ExceptionHandler
;;; =========================================================
(def-meta-class |ExceptionHandler| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Activities|) 
    :xmi-id "ExceptionHandler")
 "An ExceptionHandler is an Element that specifies a handlerBody ExecutableNode
  to execute in case the specified exception occurs during the execution
  of the protected ExecutableNode."
  ((|exceptionInput| :xmi-id "ExceptionHandler-exceptionInput" :range |ObjectNode| :multiplicity (1 1)
    :documentation
     "An ObjectNode within the handlerBody. When the ExceptionHandler catches
      an exception, the exception token is placed on this ObjectNode, causing
      the handlerBody to execute.")
   (|exceptionType| :xmi-id "ExceptionHandler-exceptionType" :range |Classifier| :multiplicity (1 -1)
    :documentation
     "The Classifiers whose instances the ExceptionHandler catches as exceptions.
      If an exception occurs whose type is any exceptionType, the ExceptionHandler
      catches the exception and executes the handlerBody.")
   (|handlerBody| :xmi-id "ExceptionHandler-handlerBody" :range |ExecutableNode| :multiplicity (1 1)
    :documentation
     "An ExecutableNode that is executed if the ExceptionHandler catches an exception.")
   (|protectedNode| :xmi-id "ExceptionHandler-protectedNode" :range |ExecutableNode| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|ExecutableNode| |handler|)
    :documentation
     "The ExecutableNode protected by the ExceptionHandler. If an exception propagates
      out of the protectedNode and has a type matching one of the exceptionTypes,
      then it is caught by this ExceptionHandler.")))

(def-meta-assoc "A_exceptionInput_exceptionHandler"      
  :name |A_exceptionInput_exceptionHandler|      
  :metatype :association      
  :member-ends ((|ExceptionHandler| "exceptionInput")
                ("A_exceptionInput_exceptionHandler-exceptionHandler" "exceptionHandler"))      
  :owned-ends  (("A_exceptionInput_exceptionHandler-exceptionHandler" "exceptionHandler")))

(def-meta-assoc-end "A_exceptionInput_exceptionHandler-exceptionHandler" 
    :type |ExceptionHandler| 
    :multiplicity (0 -1) 
    :association "A_exceptionInput_exceptionHandler" 
    :name "exceptionHandler")

(def-meta-assoc "A_exceptionType_exceptionHandler"      
  :name |A_exceptionType_exceptionHandler|      
  :metatype :association      
  :member-ends ((|ExceptionHandler| "exceptionType")
                ("A_exceptionType_exceptionHandler-exceptionHandler" "exceptionHandler"))      
  :owned-ends  (("A_exceptionType_exceptionHandler-exceptionHandler" "exceptionHandler")))

(def-meta-assoc-end "A_exceptionType_exceptionHandler-exceptionHandler" 
    :type |ExceptionHandler| 
    :multiplicity (0 -1) 
    :association "A_exceptionType_exceptionHandler" 
    :name "exceptionHandler")

(def-meta-assoc "A_handlerBody_exceptionHandler"      
  :name |A_handlerBody_exceptionHandler|      
  :metatype :association      
  :member-ends ((|ExceptionHandler| "handlerBody")
                ("A_handlerBody_exceptionHandler-exceptionHandler" "exceptionHandler"))      
  :owned-ends  (("A_handlerBody_exceptionHandler-exceptionHandler" "exceptionHandler")))

(def-meta-assoc-end "A_handlerBody_exceptionHandler-exceptionHandler" 
    :type |ExceptionHandler| 
    :multiplicity (0 -1) 
    :association "A_handlerBody_exceptionHandler" 
    :name "exceptionHandler")

;;; =========================================================
;;; ====================== ExecutableNode
;;; =========================================================
(def-meta-class |ExecutableNode| 
   (:model :UML25 :superclasses (|ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ExecutableNode")
 "An ExecutableNode is an abstract class for ActivityNodes whose execution
  may be controlled using ControlFlows and to which ExceptionHandlers may
  be attached."
  ((|handler| :xmi-id "ExecutableNode-handler" :range |ExceptionHandler| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ExceptionHandler| |protectedNode|)
    :documentation
     "A set of ExceptionHandlers that are examined if an exception propagates
      out of the ExceptionNode.")))

(def-meta-assoc "A_handler_protectedNode"      
  :name |A_handler_protectedNode|      
  :metatype :association      
  :member-ends ((|ExecutableNode| "handler")
                (|ExceptionHandler| "protectedNode"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ExecutionEnvironment
;;; =========================================================
(def-meta-class |ExecutionEnvironment| 
   (:model :UML25 :superclasses (|Node|) 
    :packages (UML |Deployments|) 
    :xmi-id "ExecutionEnvironment")
 "An execution environment is a node that offers an execution environment
  for specific types of components that are deployed on it in the form of
  executable artifacts."
  ())

;;; =========================================================
;;; ====================== ExecutionOccurrenceSpecification
;;; =========================================================
(def-meta-class |ExecutionOccurrenceSpecification| 
   (:model :UML25 :superclasses (|OccurrenceSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "ExecutionOccurrenceSpecification")
 "An ExecutionOccurrenceSpecification represents moments in time at which
  Actions or Behaviors start or finish."
  ((|execution| :xmi-id "ExecutionOccurrenceSpecification-execution" :range |ExecutionSpecification| :multiplicity (1 1)
    :documentation
     "References the execution specification describing the execution that is
      started or finished at this execution event.")))

(def-meta-assoc "A_execution_executionOccurrenceSpecification"      
  :name |A_execution_executionOccurrenceSpecification|      
  :metatype :association      
  :member-ends ((|ExecutionOccurrenceSpecification| "execution")
                ("A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification"))      
  :owned-ends  (("A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification")))

(def-meta-assoc-end "A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" 
    :type |ExecutionOccurrenceSpecification| 
    :multiplicity (0 2) 
    :association "A_execution_executionOccurrenceSpecification" 
    :name "executionOccurrenceSpecification")

;;; =========================================================
;;; ====================== ExecutionSpecification
;;; =========================================================
(def-meta-class |ExecutionSpecification| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "ExecutionSpecification")
 "An ExecutionSpecification is a specification of the execution of a unit
  of Behavior or Action within the Lifeline. The duration of an ExecutionSpecification
  is represented by two OccurrenceSpecifications, the start OccurrenceSpecification
  and the finish OccurrenceSpecification."
  ((|finish| :xmi-id "ExecutionSpecification-finish" :range |OccurrenceSpecification| :multiplicity (1 1)
    :documentation
     "References the OccurrenceSpecification that designates the finish of the
      Action or Behavior.")
   (|start| :xmi-id "ExecutionSpecification-start" :range |OccurrenceSpecification| :multiplicity (1 1)
    :documentation
     "References the OccurrenceSpecification that designates the start of the
      Action or Behavior.")))

(def-meta-assoc "A_finish_executionSpecification"      
  :name |A_finish_executionSpecification|      
  :metatype :association      
  :member-ends ((|ExecutionSpecification| "finish")
                ("A_finish_executionSpecification-executionSpecification" "executionSpecification"))      
  :owned-ends  (("A_finish_executionSpecification-executionSpecification" "executionSpecification")))

(def-meta-assoc-end "A_finish_executionSpecification-executionSpecification" 
    :type |ExecutionSpecification| 
    :multiplicity (0 -1) 
    :association "A_finish_executionSpecification" 
    :name "executionSpecification")

(def-meta-assoc "A_start_executionSpecification"      
  :name |A_start_executionSpecification|      
  :metatype :association      
  :member-ends ((|ExecutionSpecification| "start")
                ("A_start_executionSpecification-executionSpecification" "executionSpecification"))      
  :owned-ends  (("A_start_executionSpecification-executionSpecification" "executionSpecification")))

(def-meta-assoc-end "A_start_executionSpecification-executionSpecification" 
    :type |ExecutionSpecification| 
    :multiplicity (0 -1) 
    :association "A_start_executionSpecification" 
    :name "executionSpecification")

;;; =========================================================
;;; ====================== ExpansionNode
;;; =========================================================
(def-meta-class |ExpansionNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Actions|) 
    :xmi-id "ExpansionNode")
 "An ExpansionNode is an ObjectNode used to indicate a collection input or
  output for an ExpansionRegion. A collection input of an ExpansionRegion
  contains a collection that is broken into its individual elements inside
  the region, whose content is executed once per element. A collection output
  of an ExpansionRegion combines individual elements produced by the execution
  of the region into a collection for use outside the region."
  ((|regionAsInput| :xmi-id "ExpansionNode-regionAsInput" :range |ExpansionRegion| :multiplicity (0 1)
    :opposite (|ExpansionRegion| |inputElement|)
    :documentation
     "The ExpansionRegion for which the ExpansionNode is an input.")
   (|regionAsOutput| :xmi-id "ExpansionNode-regionAsOutput" :range |ExpansionRegion| :multiplicity (0 1)
    :opposite (|ExpansionRegion| |outputElement|)
    :documentation
     "The ExpansionRegion for which the ExpansionNode is an output.")))

;;; =========================================================
;;; ====================== ExpansionRegion
;;; =========================================================
(def-meta-class |ExpansionRegion| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "ExpansionRegion")
 "An ExpansionRegion is a StructuredActivityNode that executes its content
  multiple times corresponding to elements of input collection(s)."
  ((|inputElement| :xmi-id "ExpansionRegion-inputElement" :range |ExpansionNode| :multiplicity (1 -1)
    :opposite (|ExpansionNode| |regionAsInput|)
    :documentation
     "The ExpansionNodes that hold the input collections for the ExpansionRegion.")
   (|mode| :xmi-id "ExpansionRegion-mode" :range |ExpansionKind| :multiplicity (1 1) :default :iterative
    :documentation
     "The mode in which the ExpansionRegion executes its contents. If parallel,
      executions are concurrent. If iterative, executions are sequential. If
      stream, a stream of values flows into a single execution.")
   (|outputElement| :xmi-id "ExpansionRegion-outputElement" :range |ExpansionNode| :multiplicity (0 -1)
    :opposite (|ExpansionNode| |regionAsOutput|)
    :documentation
     "The ExpansionNodes that form the output collections of the ExpansionRegion.")))

(def-meta-assoc "A_inputElement_regionAsInput"      
  :name |A_inputElement_regionAsInput|      
  :metatype :association      
  :member-ends ((|ExpansionRegion| "inputElement")
                (|ExpansionNode| "regionAsInput"))      
  :owned-ends  ())

(def-meta-assoc "A_outputElement_regionAsOutput"      
  :name |A_outputElement_regionAsOutput|      
  :metatype :association      
  :member-ends ((|ExpansionRegion| "outputElement")
                (|ExpansionNode| "regionAsOutput"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Expression
;;; =========================================================
(def-meta-class |Expression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "Expression")
 "An Expression represents a node in an expression tree, which may be non-terminal
  or terminal. It defines a symbol, and has a possibly empty sequence of
  operands that are ValueSpecifications. It denotes a (possibly empty) set
  of values when evaluated in a context."
  ((|operand| :xmi-id "Expression-operand" :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies a sequence of operand ValueSpecifications.")
   (|symbol| :xmi-id "Expression-symbol" :range |String| :multiplicity (0 1)
    :documentation
     "The symbol associated with this node in the expression tree.")))

(def-meta-assoc "A_operand_expression"      
  :name |A_operand_expression|      
  :metatype :association      
  :member-ends ((|Expression| "operand")
                ("A_operand_expression-expression" "expression"))      
  :owned-ends  (("A_operand_expression-expression" "expression")))

(def-meta-assoc-end "A_operand_expression-expression" 
    :type |Expression| 
    :multiplicity (0 1) 
    :association "A_operand_expression" 
    :name "expression")

;;; =========================================================
;;; ====================== Extend
;;; =========================================================
(def-meta-class |Extend| 
   (:model :UML25 :superclasses (|NamedElement| |DirectedRelationship|) 
    :packages (UML |UseCases|) 
    :xmi-id "Extend")
 "A relationship from an extending UseCase to an extended UseCase that specifies
  how and when the behavior defined in the extending UseCase can be inserted
  into the behavior defined in the extended UseCase."
  ((|condition| :xmi-id "Extend-condition" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "References the condition that must hold when the first ExtensionPoint is
      reached for the extension to take place. If no constraint is associated
      with the Extend relationship, the extension is unconditional.")
   (|extendedCase| :xmi-id "Extend-extendedCase" :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The UseCase that is being extended.")
   (|extension| :xmi-id "Extend-extension" :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|NamedElement| |namespace|))
    :opposite (|UseCase| |extend|)
    :documentation
     "The UseCase that represents the extension and owns the Extend relationship.")
   (|extensionLocation| :xmi-id "Extend-extensionLocation" :range |ExtensionPoint| :multiplicity (1 -1) :is-ordered-p T
    :documentation
     "An ordered list of ExtensionPoints belonging to the extended UseCase, specifying
      where the respective behavioral fragments of the extending UseCase are
      to be inserted. The first fragment in the extending UseCase is associated
      with the first extension point in the list, the second fragment with the
      second point, and so on. Note that, in most practical cases, the extending
      UseCase has just a single behavior fragment, so that the list of ExtensionPoints
      is trivial.")))

(def-meta-assoc "A_condition_extend"      
  :name |A_condition_extend|      
  :metatype :association      
  :member-ends ((|Extend| "condition")
                ("A_condition_extend-extend" "extend"))      
  :owned-ends  (("A_condition_extend-extend" "extend")))

(def-meta-assoc-end "A_condition_extend-extend" 
    :type |Extend| 
    :multiplicity (0 1) 
    :association "A_condition_extend" 
    :name "extend")

(def-meta-assoc "A_extendedCase_extend"      
  :name |A_extendedCase_extend|      
  :metatype :association      
  :member-ends ((|Extend| "extendedCase")
                ("A_extendedCase_extend-extend" "extend"))      
  :owned-ends  (("A_extendedCase_extend-extend" "extend")))

(def-meta-assoc-end "A_extendedCase_extend-extend" 
    :type |Extend| 
    :multiplicity (0 -1) 
    :association "A_extendedCase_extend" 
    :name "extend")

(def-meta-assoc "A_extensionLocation_extension"      
  :name |A_extensionLocation_extension|      
  :metatype :association      
  :member-ends ((|Extend| "extensionLocation")
                ("A_extensionLocation_extension-extension" "extension"))      
  :owned-ends  (("A_extensionLocation_extension-extension" "extension")))

(def-meta-assoc-end "A_extensionLocation_extension-extension" 
    :type |Extend| 
    :multiplicity (0 -1) 
    :association "A_extensionLocation_extension" 
    :name "extension")

;;; =========================================================
;;; ====================== Extension
;;; =========================================================
(def-meta-class |Extension| 
   (:model :UML25 :superclasses (|Association|) 
    :packages (UML |Packages|) 
    :xmi-id "Extension")
 "An extension is used to indicate that the properties of a metaclass are
  extended through a stereotype, and gives the ability to flexibly add (and
  later remove) stereotypes to classes."
  ((|isRequired| :xmi-id "Extension-isRequired" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Indicates whether an instance of the extending stereotype must be created
      when an instance of the extended class is created. The attribute value
      is derived from the value of the lower property of the ExtensionEnd referenced
      by Extension::ownedEnd; a lower value of 1 means that isRequired is true,
      but otherwise it is false. Since the default value of ExtensionEnd::lower
      is 0, the default value of isRequired is false.")
   (|metaclass| :xmi-id "Extension-metaclass" :range |Class| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :opposite (|Class| |extension|)
    :documentation
     "References the Class that is extended through an Extension. The property
      is derived from the type of the memberEnd that is not the ownedEnd.")
   (|ownedEnd| :xmi-id "Extension-ownedEnd" :range |ExtensionEnd| :multiplicity (1 1) :is-composite-p T
    :documentation
     "References the end of the extension that is typed by a Stereotype." :redefined-property (|Association| |ownedEnd|))))

(def-meta-operation "isRequired.1" |Extension| 
   "The query isRequired() is true if the owned end has a multiplicity with
    the lower bound of 1."
   :operation-body
   "result = (ownedEnd.lowerBound() = 1)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "metaclass.1" |Extension| 
   "The query metaclass() returns the metaclass that is being extended (as
    opposed to the extending stereotype)."
   :operation-body
   "result = (metaclassEnd().type.oclAsType(Class))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Class|
                        :parameter-return-p T))
)

; POD
(def-meta-operation "metaclassEnd" |Extension| 
   "The query metaclassEnd() returns the Property that is typed by a metaclass
    (as opposed to a stereotype)."
   :operation-status :rewritten
   :editor-note "Rewritten to find the memberEnd that is a ExtensionEnd."
   :operation-body
   "memberEnd->select(type.oclIsKindOf(Stereotype))->any(true)" 
   :original-body
   "result = (memberEnd->reject(p | ownedEnd->includes(p.oclAsType(ExtensionEnd)))->any(true))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-assoc "A_ownedEnd_extension"      
  :name |A_ownedEnd_extension|      
  :metatype :association      
  :member-ends ((|Extension| "ownedEnd")
                ("A_ownedEnd_extension-extension" "extension"))      
  :owned-ends  (("A_ownedEnd_extension-extension" "extension")))

(def-meta-assoc-end "A_ownedEnd_extension-extension" 
    :type |Extension| 
    :multiplicity (1 1) 
    :association "A_ownedEnd_extension" 
    :name "extension")

;;; =========================================================
;;; ====================== ExtensionEnd
;;; =========================================================
(def-meta-class |ExtensionEnd| 
   (:model :UML25 :superclasses (|Property|) 
    :packages (UML |Packages|) 
    :xmi-id "ExtensionEnd")
 "An extension end is used to tie an extension to a stereotype when extending
  a metaclass. The default multiplicity of an extension end is 0..1."
  ((|lower| :xmi-id "ExtensionEnd-lower" :range |Integer| :multiplicity (0 1) :is-derived-p T
    :documentation
     "This redefinition changes the default multiplicity of association ends,
      since model elements are usually extended by 0 or 1 instance of the extension
      stereotype." :redefined-property (|MultiplicityElement| |lower|))
   (|type| :xmi-id "ExtensionEnd-type" :range |Stereotype| :multiplicity (1 1)
    :documentation
     "References the type of the ExtensionEnd. Note that this association restricts
      the possible types of an ExtensionEnd to only be Stereotypes." :redefined-property (|TypedElement| |type|))))

(def-meta-operation "lowerBound" |ExtensionEnd| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    Integer. This is a redefinition of the default lower bound, which normally,
    for MultiplicityElements, evaluates to 1 if empty."
   :operation-body
   "result = (if lowerValue=null then 0 else lowerValue.integerValue() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-assoc "A_type_extensionEnd"      
  :name |A_type_extensionEnd|      
  :metatype :association      
  :member-ends ((|ExtensionEnd| "type")
                ("A_type_extensionEnd-extensionEnd" "extensionEnd"))      
  :owned-ends  (("A_type_extensionEnd-extensionEnd" "extensionEnd")))

(def-meta-assoc-end "A_type_extensionEnd-extensionEnd" 
    :type |ExtensionEnd| 
    :multiplicity (0 -1) 
    :association "A_type_extensionEnd" 
    :name "extensionEnd")

;;; =========================================================
;;; ====================== ExtensionPoint
;;; =========================================================
(def-meta-class |ExtensionPoint| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |UseCases|) 
    :xmi-id "ExtensionPoint")
 "An ExtensionPoint identifies a point in the behavior of a UseCase where
  that behavior can be extended by the behavior of some other (extending)
  UseCase, as specified by an Extend relationship."
  ((|useCase| :xmi-id "ExtensionPoint-useCase" :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|UseCase| |extensionPoint|)
    :documentation
     "The UseCase that owns this ExtensionPoint.")))

;;; =========================================================
;;; ====================== Feature
;;; =========================================================
(def-meta-class |Feature| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "Feature")
 "A Feature declares a behavioral or structural characteristic of Classifiers."
  ((|featuringClassifier| :xmi-id "Feature-featuringClassifier" :range |Classifier| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Classifier| |feature|)
    :documentation
     "The Classifiers that have this Feature as a feature.")
   (|isStatic| :xmi-id "Feature-isStatic" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether this Feature characterizes individual instances classified
      by the Classifier (false) or the Classifier itself (true).")))

;;; =========================================================
;;; ====================== FinalNode
;;; =========================================================
(def-meta-class |FinalNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "FinalNode")
 "A FinalNode is an abstract ControlNode at which a flow in an Activity stops."
  ())

;;; =========================================================
;;; ====================== FinalState
;;; =========================================================
(def-meta-class |FinalState| 
   (:model :UML25 :superclasses (|State|) 
    :packages (UML |StateMachines|) 
    :xmi-id "FinalState")
 "A special kind of State, which, when entered, signifies that the enclosing
  Region has completed. If the enclosing Region is directly contained in
  a StateMachine and all other Regions in that StateMachine also are completed,
  then it means that the entire StateMachine behavior is completed."
  ())

;;; =========================================================
;;; ====================== FlowFinalNode
;;; =========================================================
(def-meta-class |FlowFinalNode| 
   (:model :UML25 :superclasses (|FinalNode|) 
    :packages (UML |Activities|) 
    :xmi-id "FlowFinalNode")
 "A FlowFinalNode is a FinalNode that terminates a flow by consuming the
  tokens offered to it."
  ())

;;; =========================================================
;;; ====================== ForkNode
;;; =========================================================
(def-meta-class |ForkNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ForkNode")
 "A ForkNode is a ControlNode that splits a flow into multiple concurrent
  flows."
  ())

;;; =========================================================
;;; ====================== FunctionBehavior
;;; =========================================================
(def-meta-class |FunctionBehavior| 
   (:model :UML25 :superclasses (|OpaqueBehavior|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "FunctionBehavior")
 "A FunctionBehavior is an OpaqueBehavior that does not access or modify
  any objects or other external data."
  ())

(def-meta-operation "hasAllDataTypeAttributes" |FunctionBehavior| 
   "The hasAllDataTypeAttributes query tests whether the types of the attributes
    of the given DataType are all DataTypes, and similarly for all those DataTypes."
   :operation-body
   "result = (d.ownedAttribute->forAll(a |      a.type.oclIsKindOf(DataType) and        hasAllDataTypeAttributes(a.type.oclAsType(DataType))))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\d :parameter-type '|DataType|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== Gate
;;; =========================================================
(def-meta-class |Gate| 
   (:model :UML25 :superclasses (|MessageEnd|) 
    :packages (UML |Interactions|) 
    :xmi-id "Gate")
 "A Gate is a MessageEnd which serves as a connection point for relating
  a Message which has a MessageEnd (sendEvent / receiveEvent) outside an
  InteractionFragment with another Message which has a MessageEnd (receiveEvent
  / sendEvent)  inside that InteractionFragment."
  ())

(def-meta-operation "getName" |Gate| 
   "This query returns the name of the gate, either the explicit name (.name)
    or the constructed name ('out_\" or 'in_' concatenated in front of .message.name)
    if the explicit name is not present."
   :operation-body
   "result = (if name->notEmpty() then name->asOrderedSet()->first()  else  if isActual() or isOutsideCF()     then if isSend()       then 'out_'.concat(self.message.name->asOrderedSet()->first())      else 'in_'.concat(self.message.name->asOrderedSet()->first())      endif    else if isSend()      then 'in_'.concat(self.message.name->asOrderedSet()->first())      else 'out_'.concat(self.message.name->asOrderedSet()->first())      endif    endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "getOperand" |Gate| 
   "If the Gate is an inside Combined Fragment Gate, this operation returns
    the InteractionOperand that the opposite end of this Gate is included within."
   :operation-body
   "result = (if isInsideCF() then    let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in      if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)      then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification)          in oppMOS.enclosingOperand->asOrderedSet()->first()      else let oppGate : Gate = oppEnd.oclAsType(Gate)          in oppGate.combinedFragment.enclosingOperand->asOrderedSet()->first()      endif    else null  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InteractionOperand|
                        :parameter-return-p T))
)

(def-meta-operation "isActual" |Gate| 
   "This query returns true value if this Gate is an actualGate of an InteractionUse."
   :operation-body
   "result = (interactionUse->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isDistinguishableFrom" |Gate| 
   "The query isDistinguishableFrom() specifies that two Gates may coexist
    in the same Namespace, without an explicit name property. The association
    end formalGate subsets ownedElement, and since the Gate name attribute
     is optional, it is allowed to have two formal gates without an explicit
    name, but having derived names which are distinct."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-meta-operation "isFormal" |Gate| 
   "This query returns true if this Gate is a formalGate of an Interaction."
   :operation-body
   "result = (interaction->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isInsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present) is inside of an InteractionOperator of the
    same CombinedFragment."
   :operation-body
   "result = (self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies  let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in  if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)  then let oppMOS : MessageOccurrenceSpecification  = oppEnd.oclAsType(MessageOccurrenceSpecification)  in combinedFragment = oppMOS.enclosingOperand.combinedFragment  else let oppGate : Gate = oppEnd.oclAsType(Gate)  in combinedFragment = oppGate.combinedFragment.enclosingOperand.combinedFragment  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isOutsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present)  is outside of the same CombinedFragment."
   :operation-body
   "result = (self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies  let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in  if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)   then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification)  in  self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =       oppMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(oppMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet())  else let oppGate : Gate = oppEnd.oclAsType(Gate)   in self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =       oppGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(oppGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet())  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "matches" |Gate| 
   "This query returns true if the name of this Gate matches the name of the
    in parameter Gate, and the messages for the two Gates correspond. The Message
    for one Gate (say A) corresponds to the Message for another Gate (say B)
    if (A and B have the same name value) and (if A is a sendEvent then B is
    a receiveEvent) and (if A is a receiveEvent then B is a sendEvent) and
    (A and B have the same messageSort value) and (A and B have the same signature
    value)."
   :operation-body
   "result = (self.getName() = gateToMatch.getName() and   self.message.messageSort = gateToMatch.message.messageSort and  self.message.name = gateToMatch.message.name and  self.message.sendEvent->includes(self) implies gateToMatch.message.receiveEvent->includes(gateToMatch)  and  self.message.receiveEvent->includes(self) implies gateToMatch.message.sendEvent->includes(gateToMatch) and  self.message.signature = gateToMatch.message.signature)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|gateToMatch| :parameter-type '|Gate|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== GeneralOrdering
;;; =========================================================
(def-meta-class |GeneralOrdering| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "GeneralOrdering")
 "A GeneralOrdering represents a binary relation between two OccurrenceSpecifications,
  to describe that one OccurrenceSpecification must occur before the other
  in a valid trace. This mechanism provides the ability to define partial
  orders of OccurrenceSpecifications that may otherwise not have a specified
  order."
  ((|after| :xmi-id "GeneralOrdering-after" :range |OccurrenceSpecification| :multiplicity (1 1)
    :opposite (|OccurrenceSpecification| |toBefore|)
    :documentation
     "The OccurrenceSpecification referenced comes after the OccurrenceSpecification
      referenced by before.")
   (|before| :xmi-id "GeneralOrdering-before" :range |OccurrenceSpecification| :multiplicity (1 1)
    :opposite (|OccurrenceSpecification| |toAfter|)
    :documentation
     "The OccurrenceSpecification referenced comes before the OccurrenceSpecification
      referenced by after.")))

(def-meta-assoc "A_before_toAfter"      
  :name |A_before_toAfter|      
  :metatype :association      
  :member-ends ((|GeneralOrdering| "before")
                (|OccurrenceSpecification| "toAfter"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Generalization
;;; =========================================================
(def-meta-class |Generalization| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Classification|) 
    :xmi-id "Generalization")
 "A Generalization is a taxonomic relationship between a more general Classifier
  and a more specific Classifier. Each instance of the specific Classifier
  is also an instance of the general Classifier. The specific Classifier
  inherits the features of the more general Classifier. A Generalization
  is owned by the specific Classifier."
  ((|general| :xmi-id "Generalization-general" :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The general classifier in the Generalization relationship.")
   (|generalizationSet| :xmi-id "Generalization-generalizationSet" :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |generalization|)
    :documentation
     "Represents a set of instances of Generalization.  A Generalization may
      appear in many GeneralizationSets.")
   (|isSubstitutable| :xmi-id "Generalization-isSubstitutable" :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "Indicates whether the specific Classifier can be used wherever the general
      Classifier can be used. If true, the execution traces of the specific Classifier
      shall be a superset of the execution traces of the general Classifier.
      If false, there is no such constraint on execution traces. If unset, the
      modeler has not stated whether there is such a constraint or not.")
   (|specific| :xmi-id "Generalization-specific" :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Classifier| |generalization|)
    :documentation
     "The specializing Classifier in the Generalization relationship.")))

(def-meta-assoc "A_general_generalization"      
  :name |A_general_generalization|      
  :metatype :association      
  :member-ends ((|Generalization| "general")
                ("A_general_generalization-generalization" "generalization"))      
  :owned-ends  (("A_general_generalization-generalization" "generalization")))

(def-meta-assoc-end "A_general_generalization-generalization" 
    :type |Generalization| 
    :multiplicity (0 -1) 
    :association "A_general_generalization" 
    :name "generalization")

(def-meta-assoc "A_generalizationSet_generalization"      
  :name |A_generalizationSet_generalization|      
  :metatype :association      
  :member-ends ((|Generalization| "generalizationSet")
                (|GeneralizationSet| "generalization"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== GeneralizationSet
;;; =========================================================
(def-meta-class |GeneralizationSet| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "GeneralizationSet")
 "A GeneralizationSet is a PackageableElement whose instances represent sets
  of Generalization relationships."
  ((|generalization| :xmi-id "GeneralizationSet-generalization" :range |Generalization| :multiplicity (0 -1)
    :opposite (|Generalization| |generalizationSet|)
    :documentation
     "Designates the instances of Generalization that are members of this GeneralizationSet.")
   (|isCovering| :xmi-id "GeneralizationSet-isCovering" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates (via the associated Generalizations) whether or not the set of
      specific Classifiers are covering for a particular general classifier.
      When isCovering is true, every instance of a particular general Classifier
      is also an instance of at least one of its specific Classifiers for the
      GeneralizationSet. When isCovering is false, there are one or more instances
      of the particular general Classifier that are not instances of at least
      one of its specific Classifiers defined for the GeneralizationSet.")
   (|isDisjoint| :xmi-id "GeneralizationSet-isDisjoint" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether or not the set of specific Classifiers in a Generalization
      relationship have instance in common. If isDisjoint is true, the specific
      Classifiers for a particular GeneralizationSet have no members in common;
      that is, their intersection is empty. If isDisjoint is false, the specific
      Classifiers in a particular GeneralizationSet have one or more members
      in common; that is, their intersection is not empty.")
   (|powertype| :xmi-id "GeneralizationSet-powertype" :range |Classifier| :multiplicity (0 1)
    :opposite (|Classifier| |powertypeExtent|)
    :documentation
     "Designates the Classifier that is defined as the power type for the associated
      GeneralizationSet, if there is one.")))

;;; =========================================================
;;; ====================== Image
;;; =========================================================
(def-meta-class |Image| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Packages|) 
    :xmi-id "Image")
 "Physical definition of a graphical image."
  ((|content| :xmi-id "Image-content" :range |String| :multiplicity (0 1)
    :documentation
     "This contains the serialization of the image according to the format. The
      value could represent a bitmap, image such as a GIF file, or drawing 'instructions'
      using a standard such as Scalable Vector Graphic (SVG) (which is XML based).")
   (|format| :xmi-id "Image-format" :range |String| :multiplicity (0 1)
    :documentation
     "This indicates the format of the content, which is how the string content
      should be interpreted. The following values are reserved: SVG, GIF, PNG,
      JPG, WMF, EMF, BMP. In addition the prefix 'MIME: ' is also reserved. This
      option can be used as an alternative to express the reserved values above,
      for example \"SVG\" could instead be expressed as \"MIME: image/svg+xml\".")
   (|location| :xmi-id "Image-location" :range |String| :multiplicity (0 1)
    :documentation
     "This contains a location that can be used by a tool to locate the image
      as an alternative to embedding it in the stereotype.")))

;;; =========================================================
;;; ====================== Include
;;; =========================================================
(def-meta-class |Include| 
   (:model :UML25 :superclasses (|DirectedRelationship| |NamedElement|) 
    :packages (UML |UseCases|) 
    :xmi-id "Include")
 "An Include relationship specifies that a UseCase contains the behavior
  defined in another UseCase."
  ((|addition| :xmi-id "Include-addition" :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The UseCase that is to be included.")
   (|includingCase| :xmi-id "Include-includingCase" :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|NamedElement| |namespace|))
    :opposite (|UseCase| |include|)
    :documentation
     "The UseCase which includes the addition and owns the Include relationship.")))

(def-meta-assoc "A_addition_include"      
  :name |A_addition_include|      
  :metatype :association      
  :member-ends ((|Include| "addition")
                ("A_addition_include-include" "include"))      
  :owned-ends  (("A_addition_include-include" "include")))

(def-meta-assoc-end "A_addition_include-include" 
    :type |Include| 
    :multiplicity (0 -1) 
    :association "A_addition_include" 
    :name "include")

;;; =========================================================
;;; ====================== InformationFlow
;;; =========================================================
(def-meta-class |InformationFlow| 
   (:model :UML25 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (UML |InformationFlows|) 
    :xmi-id "InformationFlow")
 "InformationFlows describe circulation of information through a system in
  a general manner. They do not specify the nature of the information, mechanisms
  by which it is conveyed, sequences of exchange or any control conditions.
  During more detailed modeling, representation and realization links may
  be added to specify which model elements implement an InformationFlow and
  to show how information is conveyed.  InformationFlows require some kind
  of    information channel    for unidirectional transmission of information
  items from sources to targets.   They specify the information channel 
   s realizations, if any, and identify the information that flows along
  them.   Information moving along the information channel may be represented
  by abstract InformationItems and by concrete Classifiers."
  ((|conveyed| :xmi-id "InformationFlow-conveyed" :range |Classifier| :multiplicity (1 -1)
    :documentation
     "Specifies the information items that may circulate on this information
      flow.")
   (|informationSource| :xmi-id "InformationFlow-informationSource" :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :documentation
     "Defines from which source the conveyed InformationItems are initiated.")
   (|informationTarget| :xmi-id "InformationFlow-informationTarget" :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Defines to which target the conveyed InformationItems are directed.")
   (|realization| :xmi-id "InformationFlow-realization" :range |Relationship| :multiplicity (0 -1)
    :documentation
     "Determines which Relationship will realize the specified flow.")
   (|realizingActivityEdge| :xmi-id "InformationFlow-realizingActivityEdge" :range |ActivityEdge| :multiplicity (0 -1)
    :documentation
     "Determines which ActivityEdges will realize the specified flow.")
   (|realizingConnector| :xmi-id "InformationFlow-realizingConnector" :range |Connector| :multiplicity (0 -1)
    :documentation
     "Determines which Connectors will realize the specified flow.")
   (|realizingMessage| :xmi-id "InformationFlow-realizingMessage" :range |Message| :multiplicity (0 -1)
    :documentation
     "Determines which Messages will realize the specified flow.")))

(def-meta-assoc "A_conveyed_conveyingFlow"      
  :name |A_conveyed_conveyingFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "conveyed")
                ("A_conveyed_conveyingFlow-conveyingFlow" "conveyingFlow"))      
  :owned-ends  (("A_conveyed_conveyingFlow-conveyingFlow" "conveyingFlow")))

(def-meta-assoc-end "A_conveyed_conveyingFlow-conveyingFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_conveyed_conveyingFlow" 
    :name "conveyingFlow")

(def-meta-assoc "A_informationSource_informationFlow"      
  :name |A_informationSource_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "informationSource")
                ("A_informationSource_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_informationSource_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_informationSource_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_informationSource_informationFlow" 
    :name "informationFlow")

(def-meta-assoc "A_informationTarget_informationFlow"      
  :name |A_informationTarget_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "informationTarget")
                ("A_informationTarget_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_informationTarget_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_informationTarget_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_informationTarget_informationFlow" 
    :name "informationFlow")

(def-meta-assoc "A_realization_abstraction_flow"      
  :name |A_realization_abstraction_flow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "realization")
                ("A_realization_abstraction_flow-abstraction" "abstraction"))      
  :owned-ends  (("A_realization_abstraction_flow-abstraction" "abstraction")))

(def-meta-assoc-end "A_realization_abstraction_flow-abstraction" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_realization_abstraction_flow" 
    :name "abstraction")

(def-meta-assoc "A_realizingActivityEdge_informationFlow"      
  :name |A_realizingActivityEdge_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "realizingActivityEdge")
                ("A_realizingActivityEdge_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_realizingActivityEdge_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_realizingActivityEdge_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_realizingActivityEdge_informationFlow" 
    :name "informationFlow")

(def-meta-assoc "A_realizingConnector_informationFlow"      
  :name |A_realizingConnector_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "realizingConnector")
                ("A_realizingConnector_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_realizingConnector_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_realizingConnector_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_realizingConnector_informationFlow" 
    :name "informationFlow")

(def-meta-assoc "A_realizingMessage_informationFlow"      
  :name |A_realizingMessage_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "realizingMessage")
                ("A_realizingMessage_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_realizingMessage_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_realizingMessage_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_realizingMessage_informationFlow" 
    :name "informationFlow")

;;; =========================================================
;;; ====================== InformationItem
;;; =========================================================
(def-meta-class |InformationItem| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |InformationFlows|) 
    :xmi-id "InformationItem")
 "InformationItems represent many kinds of information that can flow from
  sources to targets in very abstract ways.   They represent the kinds of
  information that may move within a system, but do not elaborate details
  of the transferred information.   Details of transferred information are
  the province of other Classifiers that may ultimately define InformationItems.
    Consequently, InformationItems cannot be instantiated and do not themselves
  have features, generalizations, or associations.  An important use of InformationItems
  is to represent information during early design stages, possibly before
  the detailed modeling decisions that will ultimately define them have been
  made. Another purpose of InformationItems is to abstract portions of complex
  models in less precise, but perhaps more general and communicable, ways."
  ((|represented| :xmi-id "InformationItem-represented" :range |Classifier| :multiplicity (0 -1)
    :documentation
     "Determines the classifiers that will specify the structure and nature of
      the information. An information item represents all its represented classifiers.")))

(def-meta-assoc "A_represented_representation"      
  :name |A_represented_representation|      
  :metatype :association      
  :member-ends ((|InformationItem| "represented")
                ("A_represented_representation-representation" "representation"))      
  :owned-ends  (("A_represented_representation-representation" "representation")))

(def-meta-assoc-end "A_represented_representation-representation" 
    :type |InformationItem| 
    :multiplicity (0 -1) 
    :association "A_represented_representation" 
    :name "representation")

;;; =========================================================
;;; ====================== InitialNode
;;; =========================================================
(def-meta-class |InitialNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "InitialNode")
 "An InitialNode is a ControlNode that offers a single control token when
  initially enabled."
  ())

;;; =========================================================
;;; ====================== InputPin
;;; =========================================================
(def-meta-class |InputPin| 
   (:model :UML25 :superclasses (|Pin|) 
    :packages (UML |Actions|) 
    :xmi-id "InputPin")
 "An InputPin is a Pin that holds input values to be consumed by an Action."
  ())

;;; =========================================================
;;; ====================== InstanceSpecification
;;; =========================================================
(def-meta-class |InstanceSpecification| 
   (:model :UML25 :superclasses (|DeploymentTarget| |PackageableElement| |DeployedArtifact|) 
    :packages (UML |Classification|) 
    :xmi-id "InstanceSpecification")
 "An InstanceSpecification is a model element that represents an instance
  in a modeled system. An InstanceSpecification can act as a DeploymentTarget
  in a Deployment relationship, in the case that it represents an instance
  of a Node. It can also act as a DeployedArtifact, if it represents an instance
  of an Artifact."
  ((|classifier| :xmi-id "InstanceSpecification-classifier" :range |Classifier| :multiplicity (0 -1)
    :documentation
     "The Classifier or Classifiers of the represented instance. If multiple
      Classifiers are specified, the instance is classified by all of them.")
   (|slot| :xmi-id "InstanceSpecification-slot" :range |Slot| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Slot| |owningInstance|)
    :documentation
     "A Slot giving the value or values of a StructuralFeature of the instance.
      An InstanceSpecification can have one Slot per StructuralFeature of its
      Classifiers, including inherited features. It is not necessary to model
      a Slot for every StructuralFeature, in which case the InstanceSpecification
      is a partial description.")
   (|specification| :xmi-id "InstanceSpecification-specification" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A specification of how to compute, derive, or construct the instance.")))

(def-meta-assoc "A_classifier_instanceSpecification"      
  :name |A_classifier_instanceSpecification|      
  :metatype :association      
  :member-ends ((|InstanceSpecification| "classifier")
                ("A_classifier_instanceSpecification-instanceSpecification" "instanceSpecification"))      
  :owned-ends  (("A_classifier_instanceSpecification-instanceSpecification" "instanceSpecification")))

(def-meta-assoc-end "A_classifier_instanceSpecification-instanceSpecification" 
    :type |InstanceSpecification| 
    :multiplicity (0 -1) 
    :association "A_classifier_instanceSpecification" 
    :name "instanceSpecification")

(def-meta-assoc "A_slot_owningInstance"      
  :name |A_slot_owningInstance|      
  :metatype :association      
  :member-ends ((|InstanceSpecification| "slot")
                (|Slot| "owningInstance"))      
  :owned-ends  ())

(def-meta-assoc "A_specification_owningInstanceSpec"      
  :name |A_specification_owningInstanceSpec|      
  :metatype :association      
  :member-ends ((|InstanceSpecification| "specification")
                ("A_specification_owningInstanceSpec-owningInstanceSpec" "owningInstanceSpec"))      
  :owned-ends  (("A_specification_owningInstanceSpec-owningInstanceSpec" "owningInstanceSpec")))

(def-meta-assoc-end "A_specification_owningInstanceSpec-owningInstanceSpec" 
    :type |InstanceSpecification| 
    :multiplicity (0 1) 
    :association "A_specification_owningInstanceSpec" 
    :name "owningInstanceSpec")

;;; =========================================================
;;; ====================== InstanceValue
;;; =========================================================
(def-meta-class |InstanceValue| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Classification|) 
    :xmi-id "InstanceValue")
 "An InstanceValue is a ValueSpecification that identifies an instance."
  ((|instance| :xmi-id "InstanceValue-instance" :range |InstanceSpecification| :multiplicity (1 1)
    :documentation
     "The InstanceSpecification that represents the specified value.")))

(def-meta-assoc "A_instance_instanceValue"      
  :name |A_instance_instanceValue|      
  :metatype :association      
  :member-ends ((|InstanceValue| "instance")
                ("A_instance_instanceValue-instanceValue" "instanceValue"))      
  :owned-ends  (("A_instance_instanceValue-instanceValue" "instanceValue")))

(def-meta-assoc-end "A_instance_instanceValue-instanceValue" 
    :type |InstanceValue| 
    :multiplicity (0 -1) 
    :association "A_instance_instanceValue" 
    :name "instanceValue")

;;; =========================================================
;;; ====================== Interaction
;;; =========================================================
(def-meta-class |Interaction| 
   (:model :UML25 :superclasses (|InteractionFragment| |Behavior|) 
    :packages (UML |Interactions|) 
    :xmi-id "Interaction")
 "An Interaction is a unit of Behavior that focuses on the observable exchange
  of information between connectable elements."
  ((|action| :xmi-id "Interaction-action" :range |Action| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Actions owned by the Interaction.")
   (|formalGate| :xmi-id "Interaction-formalGate" :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the gates that form the message interface between this Interaction
      and any InteractionUses which reference it.")
   (|fragment| :xmi-id "Interaction-fragment" :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingInteraction|)
    :documentation
     "The ordered set of fragments in the Interaction.")
   (|lifeline| :xmi-id "Interaction-lifeline" :range |Lifeline| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Lifeline| |interaction|)
    :documentation
     "Specifies the participants in this Interaction.")
   (|message| :xmi-id "Interaction-message" :range |Message| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Message| |interaction|)
    :documentation
     "The Messages contained in this Interaction.")))

(def-meta-assoc "A_action_interaction"      
  :name |A_action_interaction|      
  :metatype :association      
  :member-ends ((|Interaction| "action")
                ("A_action_interaction-interaction" "interaction"))      
  :owned-ends  (("A_action_interaction-interaction" "interaction")))

(def-meta-assoc-end "A_action_interaction-interaction" 
    :type |Interaction| 
    :multiplicity (0 1) 
    :association "A_action_interaction" 
    :name "interaction")

(def-meta-assoc "A_formalGate_interaction"      
  :name |A_formalGate_interaction|      
  :metatype :association      
  :member-ends ((|Interaction| "formalGate")
                ("A_formalGate_interaction-interaction" "interaction"))      
  :owned-ends  (("A_formalGate_interaction-interaction" "interaction")))

(def-meta-assoc-end "A_formalGate_interaction-interaction" 
    :type |Interaction| 
    :multiplicity (0 1) 
    :association "A_formalGate_interaction" 
    :name "interaction")

(def-meta-assoc "A_fragment_enclosingInteraction"      
  :name |A_fragment_enclosingInteraction|      
  :metatype :association      
  :member-ends ((|Interaction| "fragment")
                (|InteractionFragment| "enclosingInteraction"))      
  :owned-ends  ())

(def-meta-assoc "A_lifeline_interaction"      
  :name |A_lifeline_interaction|      
  :metatype :association      
  :member-ends ((|Interaction| "lifeline")
                (|Lifeline| "interaction"))      
  :owned-ends  ())

(def-meta-assoc "A_message_interaction"      
  :name |A_message_interaction|      
  :metatype :association      
  :member-ends ((|Interaction| "message")
                (|Message| "interaction"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== InteractionConstraint
;;; =========================================================
(def-meta-class |InteractionConstraint| 
   (:model :UML25 :superclasses (|Constraint|) 
    :packages (UML |Interactions|) 
    :xmi-id "InteractionConstraint")
 "An InteractionConstraint is a Boolean expression that guards an operand
  in a CombinedFragment."
  ((|maxint| :xmi-id "InteractionConstraint-maxint" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The maximum number of iterations of a loop")
   (|minint| :xmi-id "InteractionConstraint-minint" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The minimum number of iterations of a loop")))

(def-meta-assoc "A_maxint_interactionConstraint"      
  :name |A_maxint_interactionConstraint|      
  :metatype :association      
  :member-ends ((|InteractionConstraint| "maxint")
                ("A_maxint_interactionConstraint-interactionConstraint" "interactionConstraint"))      
  :owned-ends  (("A_maxint_interactionConstraint-interactionConstraint" "interactionConstraint")))

(def-meta-assoc-end "A_maxint_interactionConstraint-interactionConstraint" 
    :type |InteractionConstraint| 
    :multiplicity (0 1) 
    :association "A_maxint_interactionConstraint" 
    :name "interactionConstraint")

(def-meta-assoc "A_minint_interactionConstraint"      
  :name |A_minint_interactionConstraint|      
  :metatype :association      
  :member-ends ((|InteractionConstraint| "minint")
                ("A_minint_interactionConstraint-interactionConstraint" "interactionConstraint"))      
  :owned-ends  (("A_minint_interactionConstraint-interactionConstraint" "interactionConstraint")))

(def-meta-assoc-end "A_minint_interactionConstraint-interactionConstraint" 
    :type |InteractionConstraint| 
    :multiplicity (0 1) 
    :association "A_minint_interactionConstraint" 
    :name "interactionConstraint")

;;; =========================================================
;;; ====================== InteractionFragment
;;; =========================================================
(def-meta-class |InteractionFragment| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "InteractionFragment")
 "InteractionFragment is an abstract notion of the most general interaction
  unit. An InteractionFragment is a piece of an Interaction. Each InteractionFragment
  is conceptually like an Interaction by itself."
  ((|covered| :xmi-id "InteractionFragment-covered" :range |Lifeline| :multiplicity (0 -1)
    :opposite (|Lifeline| |coveredBy|)
    :documentation
     "References the Lifelines that the InteractionFragment involves.")
   (|enclosingInteraction| :xmi-id "InteractionFragment-enclosingInteraction" :range |Interaction| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |fragment|)
    :documentation
     "The Interaction enclosing this InteractionFragment.")
   (|enclosingOperand| :xmi-id "InteractionFragment-enclosingOperand" :range |InteractionOperand| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|InteractionOperand| |fragment|)
    :documentation
     "The operand enclosing this InteractionFragment (they may nest recursively).")
   (|generalOrdering| :xmi-id "InteractionFragment-generalOrdering" :range |GeneralOrdering| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The general ordering relationships contained in this fragment.")))

(def-meta-assoc "A_covered_coveredBy"      
  :name |A_covered_coveredBy|      
  :metatype :association      
  :member-ends ((|InteractionFragment| "covered")
                (|Lifeline| "coveredBy"))      
  :owned-ends  ())

(def-meta-assoc "A_generalOrdering_interactionFragment"      
  :name |A_generalOrdering_interactionFragment|      
  :metatype :association      
  :member-ends ((|InteractionFragment| "generalOrdering")
                ("A_generalOrdering_interactionFragment-interactionFragment" "interactionFragment"))      
  :owned-ends  (("A_generalOrdering_interactionFragment-interactionFragment" "interactionFragment")))

(def-meta-assoc-end "A_generalOrdering_interactionFragment-interactionFragment" 
    :type |InteractionFragment| 
    :multiplicity (0 1) 
    :association "A_generalOrdering_interactionFragment" 
    :name "interactionFragment")

;;; =========================================================
;;; ====================== InteractionOperand
;;; =========================================================
(def-meta-class |InteractionOperand| 
   (:model :UML25 :superclasses (|InteractionFragment| |Namespace|) 
    :packages (UML |Interactions|) 
    :xmi-id "InteractionOperand")
 "An InteractionOperand is contained in a CombinedFragment. An InteractionOperand
  represents one operand of the expression given by the enclosing CombinedFragment."
  ((|fragment| :xmi-id "InteractionOperand-fragment" :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingOperand|)
    :documentation
     "The fragments of the operand.")
   (|guard| :xmi-id "InteractionOperand-guard" :range |InteractionConstraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Constraint of the operand.")))

(def-meta-assoc "A_fragment_enclosingOperand"      
  :name |A_fragment_enclosingOperand|      
  :metatype :association      
  :member-ends ((|InteractionOperand| "fragment")
                (|InteractionFragment| "enclosingOperand"))      
  :owned-ends  ())

(def-meta-assoc "A_guard_interactionOperand"      
  :name |A_guard_interactionOperand|      
  :metatype :association      
  :member-ends ((|InteractionOperand| "guard")
                ("A_guard_interactionOperand-interactionOperand" "interactionOperand"))      
  :owned-ends  (("A_guard_interactionOperand-interactionOperand" "interactionOperand")))

(def-meta-assoc-end "A_guard_interactionOperand-interactionOperand" 
    :type |InteractionOperand| 
    :multiplicity (1 1) 
    :association "A_guard_interactionOperand" 
    :name "interactionOperand")

;;; =========================================================
;;; ====================== InteractionUse
;;; =========================================================
(def-meta-class |InteractionUse| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "InteractionUse")
 "An InteractionUse refers to an Interaction. The InteractionUse is a shorthand
  for copying the contents of the referenced Interaction where the InteractionUse
  is. To be accurate the copying must take into account substituting parameters
  with arguments and connect the formal Gates with the actual ones."
  ((|actualGate| :xmi-id "InteractionUse-actualGate" :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The actual gates of the InteractionUse.")
   (|argument| :xmi-id "InteractionUse-argument" :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The actual arguments of the Interaction.")
   (|refersTo| :xmi-id "InteractionUse-refersTo" :range |Interaction| :multiplicity (1 1)
    :documentation
     "Refers to the Interaction that defines its meaning.")
   (|returnValue| :xmi-id "InteractionUse-returnValue" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The value of the executed Interaction.")
   (|returnValueRecipient| :xmi-id "InteractionUse-returnValueRecipient" :range |Property| :multiplicity (0 1)
    :documentation
     "The recipient of the return value.")))

(def-meta-assoc "A_actualGate_interactionUse"      
  :name |A_actualGate_interactionUse|      
  :metatype :association      
  :member-ends ((|InteractionUse| "actualGate")
                ("A_actualGate_interactionUse-interactionUse" "interactionUse"))      
  :owned-ends  (("A_actualGate_interactionUse-interactionUse" "interactionUse")))

(def-meta-assoc-end "A_actualGate_interactionUse-interactionUse" 
    :type |InteractionUse| 
    :multiplicity (0 1) 
    :association "A_actualGate_interactionUse" 
    :name "interactionUse")

(def-meta-assoc "A_argument_interactionUse"      
  :name |A_argument_interactionUse|      
  :metatype :association      
  :member-ends ((|InteractionUse| "argument")
                ("A_argument_interactionUse-interactionUse" "interactionUse"))      
  :owned-ends  (("A_argument_interactionUse-interactionUse" "interactionUse")))

(def-meta-assoc-end "A_argument_interactionUse-interactionUse" 
    :type |InteractionUse| 
    :multiplicity (0 1) 
    :association "A_argument_interactionUse" 
    :name "interactionUse")

(def-meta-assoc "A_refersTo_interactionUse"      
  :name |A_refersTo_interactionUse|      
  :metatype :association      
  :member-ends ((|InteractionUse| "refersTo")
                ("A_refersTo_interactionUse-interactionUse" "interactionUse"))      
  :owned-ends  (("A_refersTo_interactionUse-interactionUse" "interactionUse")))

(def-meta-assoc-end "A_refersTo_interactionUse-interactionUse" 
    :type |InteractionUse| 
    :multiplicity (0 -1) 
    :association "A_refersTo_interactionUse" 
    :name "interactionUse")

(def-meta-assoc "A_returnValueRecipient_interactionUse"      
  :name |A_returnValueRecipient_interactionUse|      
  :metatype :association      
  :member-ends ((|InteractionUse| "returnValueRecipient")
                ("A_returnValueRecipient_interactionUse-interactionUse" "interactionUse"))      
  :owned-ends  (("A_returnValueRecipient_interactionUse-interactionUse" "interactionUse")))

(def-meta-assoc-end "A_returnValueRecipient_interactionUse-interactionUse" 
    :type |InteractionUse| 
    :multiplicity (0 -1) 
    :association "A_returnValueRecipient_interactionUse" 
    :name "interactionUse")

(def-meta-assoc "A_returnValue_interactionUse"      
  :name |A_returnValue_interactionUse|      
  :metatype :association      
  :member-ends ((|InteractionUse| "returnValue")
                ("A_returnValue_interactionUse-interactionUse" "interactionUse"))      
  :owned-ends  (("A_returnValue_interactionUse-interactionUse" "interactionUse")))

(def-meta-assoc-end "A_returnValue_interactionUse-interactionUse" 
    :type |InteractionUse| 
    :multiplicity (0 1) 
    :association "A_returnValue_interactionUse" 
    :name "interactionUse")

;;; =========================================================
;;; ====================== Interface
;;; =========================================================
(def-meta-class |Interface| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "Interface")
 "Interfaces declare coherent services that are implemented by BehavioredClassifiers
  that implement the Interfaces via InterfaceRealizations."
  ((|nestedClassifier| :xmi-id "Interface-nestedClassifier" :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References all the Classifiers that are defined (nested) within the Interface.")
   (|ownedAttribute| :xmi-id "Interface-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |interface|)
    :documentation
     "The attributes (i.e., the Properties) owned by the Interface.")
   (|ownedOperation| :xmi-id "Interface-ownedOperation" :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |interface|)
    :documentation
     "The Operations owned by the Interface.")
   (|ownedReception| :xmi-id "Interface-ownedReception" :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "Receptions that objects providing this Interface are willing to accept.")
   (|protocol| :xmi-id "Interface-protocol" :range |ProtocolStateMachine| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References a ProtocolStateMachine specifying the legal sequences of the
      invocation of the BehavioralFeatures described in the Interface.")
   (|redefinedInterface| :xmi-id "Interface-redefinedInterface" :range |Interface| :multiplicity (0 -1)
    :subsetted-properties ((|Classifier| |redefinedClassifier|))
    :documentation
     "References all the Interfaces redefined by this Interface.")))

(def-meta-assoc "A_nestedClassifier_interface"      
  :name |A_nestedClassifier_interface|      
  :metatype :association      
  :member-ends ((|Interface| "nestedClassifier")
                ("A_nestedClassifier_interface-interface" "interface"))      
  :owned-ends  (("A_nestedClassifier_interface-interface" "interface")))

(def-meta-assoc-end "A_nestedClassifier_interface-interface" 
    :type |Interface| 
    :multiplicity (0 1) 
    :association "A_nestedClassifier_interface" 
    :name "interface")

(def-meta-assoc "A_ownedAttribute_interface"      
  :name |A_ownedAttribute_interface|      
  :metatype :association      
  :member-ends ((|Interface| "ownedAttribute")
                (|Property| "interface"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedOperation_interface"      
  :name |A_ownedOperation_interface|      
  :metatype :association      
  :member-ends ((|Interface| "ownedOperation")
                (|Operation| "interface"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedReception_interface"      
  :name |A_ownedReception_interface|      
  :metatype :association      
  :member-ends ((|Interface| "ownedReception")
                ("A_ownedReception_interface-interface" "interface"))      
  :owned-ends  (("A_ownedReception_interface-interface" "interface")))

(def-meta-assoc-end "A_ownedReception_interface-interface" 
    :type |Interface| 
    :multiplicity (0 1) 
    :association "A_ownedReception_interface" 
    :name "interface")

(def-meta-assoc "A_protocol_interface"      
  :name |A_protocol_interface|      
  :metatype :association      
  :member-ends ((|Interface| "protocol")
                ("A_protocol_interface-interface" "interface"))      
  :owned-ends  (("A_protocol_interface-interface" "interface")))

(def-meta-assoc-end "A_protocol_interface-interface" 
    :type |Interface| 
    :multiplicity (0 1) 
    :association "A_protocol_interface" 
    :name "interface")

(def-meta-assoc "A_redefinedInterface_interface"      
  :name |A_redefinedInterface_interface|      
  :metatype :association      
  :member-ends ((|Interface| "redefinedInterface")
                ("A_redefinedInterface_interface-interface" "interface"))      
  :owned-ends  (("A_redefinedInterface_interface-interface" "interface")))

(def-meta-assoc-end "A_redefinedInterface_interface-interface" 
    :type |Interface| 
    :multiplicity (0 -1) 
    :association "A_redefinedInterface_interface" 
    :name "interface")

;;; =========================================================
;;; ====================== InterfaceRealization
;;; =========================================================
(def-meta-class |InterfaceRealization| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "InterfaceRealization")
 "An InterfaceRealization is a specialized realization relationship between
  a BehavioredClassifier and an Interface. This relationship signifies that
  the realizing BehavioredClassifier conforms to the contract specified by
  the Interface."
  ((|contract| :xmi-id "InterfaceRealization-contract" :range |Interface| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "References the Interface specifying the conformance contract.")
   (|implementingClassifier| :xmi-id "InterfaceRealization-implementingClassifier" :range |BehavioredClassifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|BehavioredClassifier| |interfaceRealization|)
    :documentation
     "References the BehavioredClassifier that owns this InterfaceRealization,
      i.e., the BehavioredClassifier that realizes the Interface to which it
      refers.")))

(def-meta-assoc "A_contract_interfaceRealization"      
  :name |A_contract_interfaceRealization|      
  :metatype :association      
  :member-ends ((|InterfaceRealization| "contract")
                ("A_contract_interfaceRealization-interfaceRealization" "interfaceRealization"))      
  :owned-ends  (("A_contract_interfaceRealization-interfaceRealization" "interfaceRealization")))

(def-meta-assoc-end "A_contract_interfaceRealization-interfaceRealization" 
    :type |InterfaceRealization| 
    :multiplicity (0 -1) 
    :association "A_contract_interfaceRealization" 
    :name "interfaceRealization")

;;; =========================================================
;;; ====================== InterruptibleActivityRegion
;;; =========================================================
(def-meta-class |InterruptibleActivityRegion| 
   (:model :UML25 :superclasses (|ActivityGroup|) 
    :packages (UML |Activities|) 
    :xmi-id "InterruptibleActivityRegion")
 "An InterruptibleActivityRegion is an ActivityGroup that supports the termination
  of tokens flowing in the portions of an activity within it."
  ((|interruptingEdge| :xmi-id "InterruptibleActivityRegion-interruptingEdge" :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |interrupts|)
    :documentation
     "The ActivityEdges leaving the InterruptibleActivityRegion on which a traversing
      token will result in the termination of other tokens flowing in the InterruptibleActivityRegion.")
   (|node| :xmi-id "InterruptibleActivityRegion-node" :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inInterruptibleRegion|)
    :documentation
     "ActivityNodes immediately contained in the InterruptibleActivityRegion.")))

(def-meta-assoc "A_interruptingEdge_interrupts"      
  :name |A_interruptingEdge_interrupts|      
  :metatype :association      
  :member-ends ((|InterruptibleActivityRegion| "interruptingEdge")
                (|ActivityEdge| "interrupts"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Interval
;;; =========================================================
(def-meta-class |Interval| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "Interval")
 "An Interval defines the range between two ValueSpecifications."
  ((|max| :xmi-id "Interval-max" :range |ValueSpecification| :multiplicity (1 1)
    :documentation
     "Refers to the ValueSpecification denoting the maximum value of the range.")
   (|min| :xmi-id "Interval-min" :range |ValueSpecification| :multiplicity (1 1)
    :documentation
     "Refers to the ValueSpecification denoting the minimum value of the range.")))

(def-meta-assoc "A_max_interval"      
  :name |A_max_interval|      
  :metatype :association      
  :member-ends ((|Interval| "max")
                ("A_max_interval-interval" "interval"))      
  :owned-ends  (("A_max_interval-interval" "interval")))

(def-meta-assoc-end "A_max_interval-interval" 
    :type |Interval| 
    :multiplicity (0 -1) 
    :association "A_max_interval" 
    :name "interval")

(def-meta-assoc "A_min_interval"      
  :name |A_min_interval|      
  :metatype :association      
  :member-ends ((|Interval| "min")
                ("A_min_interval-interval" "interval"))      
  :owned-ends  (("A_min_interval-interval" "interval")))

(def-meta-assoc-end "A_min_interval-interval" 
    :type |Interval| 
    :multiplicity (0 -1) 
    :association "A_min_interval" 
    :name "interval")

;;; =========================================================
;;; ====================== IntervalConstraint
;;; =========================================================
(def-meta-class |IntervalConstraint| 
   (:model :UML25 :superclasses (|Constraint|) 
    :packages (UML |Values|) 
    :xmi-id "IntervalConstraint")
 "An IntervalConstraint is a Constraint that is specified by an Interval."
  ((|specification| :xmi-id "IntervalConstraint-specification" :range |Interval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The Interval that specifies the condition of the IntervalConstraint." :redefined-property (|Constraint| |specification|))))

(def-meta-assoc "A_specification_intervalConstraint"      
  :name |A_specification_intervalConstraint|      
  :metatype :association      
  :member-ends ((|IntervalConstraint| "specification")
                ("A_specification_intervalConstraint-intervalConstraint" "intervalConstraint"))      
  :owned-ends  (("A_specification_intervalConstraint-intervalConstraint" "intervalConstraint")))

(def-meta-assoc-end "A_specification_intervalConstraint-intervalConstraint" 
    :type |IntervalConstraint| 
    :multiplicity (0 1) 
    :association "A_specification_intervalConstraint" 
    :name "intervalConstraint")

;;; =========================================================
;;; ====================== InvocationAction
;;; =========================================================
(def-meta-class |InvocationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "InvocationAction")
 "InvocationAction is an abstract class for the various actions that request
  Behavior invocation."
  ((|argument| :xmi-id "InvocationAction-argument" :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPins that provide the argument values passed in the invocation
      request.")
   (|onPort| :xmi-id "InvocationAction-onPort" :range |Port| :multiplicity (0 1)
    :documentation
     "For CallOperationActions, SendSignalActions, and SendObjectActions, an
      optional Port of the target object through which the invocation request
      is sent.")))

(def-meta-assoc "A_argument_invocationAction"      
  :name |A_argument_invocationAction|      
  :metatype :association      
  :member-ends ((|InvocationAction| "argument")
                ("A_argument_invocationAction-invocationAction" "invocationAction"))      
  :owned-ends  (("A_argument_invocationAction-invocationAction" "invocationAction")))

(def-meta-assoc-end "A_argument_invocationAction-invocationAction" 
    :type |InvocationAction| 
    :multiplicity (0 1) 
    :association "A_argument_invocationAction" 
    :name "invocationAction")

(def-meta-assoc "A_onPort_invocationAction"      
  :name |A_onPort_invocationAction|      
  :metatype :association      
  :member-ends ((|InvocationAction| "onPort")
                ("A_onPort_invocationAction-invocationAction" "invocationAction"))      
  :owned-ends  (("A_onPort_invocationAction-invocationAction" "invocationAction")))

(def-meta-assoc-end "A_onPort_invocationAction-invocationAction" 
    :type |InvocationAction| 
    :multiplicity (0 -1) 
    :association "A_onPort_invocationAction" 
    :name "invocationAction")

;;; =========================================================
;;; ====================== JoinNode
;;; =========================================================
(def-meta-class |JoinNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "JoinNode")
 "A JoinNode is a ControlNode that synchronizes multiple flows."
  ((|isCombineDuplicate| :xmi-id "JoinNode-isCombineDuplicate" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Indicates whether incoming tokens having objects with the same identity
      are combined into one by the JoinNode.")
   (|joinSpec| :xmi-id "JoinNode-joinSpec" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification giving the condition under which the JoinNode will
      offer a token on its outgoing ActivityEdge. If no joinSpec is specified,
      then the JoinNode will offer an outgoing token if tokens are offered on
      all of its incoming ActivityEdges (an \"and\" condition).")))

(def-meta-assoc "A_joinSpec_joinNode"      
  :name |A_joinSpec_joinNode|      
  :metatype :association      
  :member-ends ((|JoinNode| "joinSpec")
                ("A_joinSpec_joinNode-joinNode" "joinNode"))      
  :owned-ends  (("A_joinSpec_joinNode-joinNode" "joinNode")))

(def-meta-assoc-end "A_joinSpec_joinNode-joinNode" 
    :type |JoinNode| 
    :multiplicity (0 1) 
    :association "A_joinSpec_joinNode" 
    :name "joinNode")

;;; =========================================================
;;; ====================== Lifeline
;;; =========================================================
(def-meta-class |Lifeline| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "Lifeline")
 "A Lifeline represents an individual participant in the Interaction. While
  parts and structural features may have multiplicity greater than 1, Lifelines
  represent only one interacting entity."
  ((|coveredBy| :xmi-id "Lifeline-coveredBy" :range |InteractionFragment| :multiplicity (0 -1)
    :opposite (|InteractionFragment| |covered|)
    :documentation
     "References the InteractionFragments in which this Lifeline takes part.")
   (|decomposedAs| :xmi-id "Lifeline-decomposedAs" :range |PartDecomposition| :multiplicity (0 1)
    :documentation
     "References the Interaction that represents the decomposition.")
   (|interaction| :xmi-id "Lifeline-interaction" :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |lifeline|)
    :documentation
     "References the Interaction enclosing this Lifeline.")
   (|represents| :xmi-id "Lifeline-represents" :range |ConnectableElement| :multiplicity (0 1)
    :documentation
     "References the ConnectableElement within the classifier that contains the
      enclosing interaction.")
   (|selector| :xmi-id "Lifeline-selector" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "If the referenced ConnectableElement is multivalued, then this specifies
      the specific individual part within that set.")))

(def-meta-assoc "A_decomposedAs_lifeline"      
  :name |A_decomposedAs_lifeline|      
  :metatype :association      
  :member-ends ((|Lifeline| "decomposedAs")
                ("A_decomposedAs_lifeline-lifeline" "lifeline"))      
  :owned-ends  (("A_decomposedAs_lifeline-lifeline" "lifeline")))

(def-meta-assoc-end "A_decomposedAs_lifeline-lifeline" 
    :type |Lifeline| 
    :multiplicity (1 1) 
    :association "A_decomposedAs_lifeline" 
    :name "lifeline")

(def-meta-assoc "A_represents_lifeline"      
  :name |A_represents_lifeline|      
  :metatype :association      
  :member-ends ((|Lifeline| "represents")
                ("A_represents_lifeline-lifeline" "lifeline"))      
  :owned-ends  (("A_represents_lifeline-lifeline" "lifeline")))

(def-meta-assoc-end "A_represents_lifeline-lifeline" 
    :type |Lifeline| 
    :multiplicity (0 -1) 
    :association "A_represents_lifeline" 
    :name "lifeline")

(def-meta-assoc "A_selector_lifeline"      
  :name |A_selector_lifeline|      
  :metatype :association      
  :member-ends ((|Lifeline| "selector")
                ("A_selector_lifeline-lifeline" "lifeline"))      
  :owned-ends  (("A_selector_lifeline-lifeline" "lifeline")))

(def-meta-assoc-end "A_selector_lifeline-lifeline" 
    :type |Lifeline| 
    :multiplicity (0 1) 
    :association "A_selector_lifeline" 
    :name "lifeline")

;;; =========================================================
;;; ====================== LinkAction
;;; =========================================================
(def-meta-class |LinkAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "LinkAction")
 "LinkAction is an abstract class for all Actions that identify the links
  to be acted on using LinkEndData."
  ((|endData| :xmi-id "LinkAction-endData" :range |LinkEndData| :multiplicity (2 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The LinkEndData identifying the values on the ends of the links acting
      on by this LinkAction.")
   (|inputValue| :xmi-id "LinkAction-inputValue" :range |InputPin| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "InputPins used by the LinkEndData of the LinkAction.")))

(def-meta-operation "association" |LinkAction| 
   "Returns the Association acted on by this LinkAction."
   :operation-body
   "result = (endData->asSequence()->first().end.association)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Association|
                        :parameter-return-p T))
)

(def-meta-assoc "A_endData_linkAction"      
  :name |A_endData_linkAction|      
  :metatype :association      
  :member-ends ((|LinkAction| "endData")
                ("A_endData_linkAction-linkAction" "linkAction"))      
  :owned-ends  (("A_endData_linkAction-linkAction" "linkAction")))

(def-meta-assoc-end "A_endData_linkAction-linkAction" 
    :type |LinkAction| 
    :multiplicity (1 1) 
    :association "A_endData_linkAction" 
    :name "linkAction")

(def-meta-assoc "A_inputValue_linkAction"      
  :name |A_inputValue_linkAction|      
  :metatype :association      
  :member-ends ((|LinkAction| "inputValue")
                ("A_inputValue_linkAction-linkAction" "linkAction"))      
  :owned-ends  (("A_inputValue_linkAction-linkAction" "linkAction")))

(def-meta-assoc-end "A_inputValue_linkAction-linkAction" 
    :type |LinkAction| 
    :multiplicity (0 1) 
    :association "A_inputValue_linkAction" 
    :name "linkAction")

;;; =========================================================
;;; ====================== LinkEndCreationData
;;; =========================================================
(def-meta-class |LinkEndCreationData| 
   (:model :UML25 :superclasses (|LinkEndData|) 
    :packages (UML |Actions|) 
    :xmi-id "LinkEndCreationData")
 "LinkEndCreationData is LinkEndData used to provide values for one end of
  a link to be created by a CreateLinkAction."
  ((|insertAt| :xmi-id "LinkEndCreationData-insertAt" :range |InputPin| :multiplicity (0 1)
    :documentation
     "For ordered Association ends, the InputPin that provides the position where
      the new link should be inserted or where an existing link should be moved
      to. The type of the insertAt InputPin is UnlimitedNatural, but the input
      cannot be zero. It is omitted for Association ends that are not ordered.")
   (|isReplaceAll| :xmi-id "LinkEndCreationData-isReplaceAll" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the existing links emanating from the object on this
      end should be destroyed before creating a new link.")))

(def-meta-operation "allPins" |LinkEndCreationData| 
   "Adds the insertAt InputPin (if any) to the set of all Pins."
   :operation-body
   "result = (self.LinkEndData::allPins()->including(insertAt))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InputPin|
                        :parameter-return-p T))
)

(def-meta-assoc "A_insertAt_linkEndCreationData"      
  :name |A_insertAt_linkEndCreationData|      
  :metatype :association      
  :member-ends ((|LinkEndCreationData| "insertAt")
                ("A_insertAt_linkEndCreationData-linkEndCreationData" "linkEndCreationData"))      
  :owned-ends  (("A_insertAt_linkEndCreationData-linkEndCreationData" "linkEndCreationData")))

(def-meta-assoc-end "A_insertAt_linkEndCreationData-linkEndCreationData" 
    :type |LinkEndCreationData| 
    :multiplicity (0 1) 
    :association "A_insertAt_linkEndCreationData" 
    :name "linkEndCreationData")

;;; =========================================================
;;; ====================== LinkEndData
;;; =========================================================
(def-meta-class |LinkEndData| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "LinkEndData")
 "LinkEndData is an Element that identifies on end of a link to be read or
  written by a LinkAction. As a link (that is not a link object) cannot be
  passed as a runtime value to or from an Action, it is instead identified
  by its end objects and qualifier values, if any. A LinkEndData instance
  provides these values for a single Association end."
  ((|end| :xmi-id "LinkEndData-end" :range |Property| :multiplicity (1 1)
    :documentation
     "The Association  end  for  which  this  LinkEndData  specifies  values.")
   (|qualifier| :xmi-id "LinkEndData-qualifier" :range |QualifierValue| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A set of QualifierValues used to provide values for the qualifiers of the
      end.")
   (|value| :xmi-id "LinkEndData-value" :range |InputPin| :multiplicity (0 1)
    :documentation
     "The InputPin that provides the specified value for the given end. This
      InputPin is omitted if the LinkEndData specifies the \"open\" end for a ReadLinkAction.")))

(def-meta-operation "allPins" |LinkEndData| 
   "Returns all the InputPins referenced by this LinkEndData. By default this
    includes the value and qualifier InputPins, but subclasses may override
    the operation to add other InputPins."
   :operation-body
   "result = (value->asBag()->union(qualifier.value))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InputPin|
                        :parameter-return-p T))
)

(def-meta-assoc "A_end_linkEndData"      
  :name |A_end_linkEndData|      
  :metatype :association      
  :member-ends ((|LinkEndData| "end")
                ("A_end_linkEndData-linkEndData" "linkEndData"))      
  :owned-ends  (("A_end_linkEndData-linkEndData" "linkEndData")))

(def-meta-assoc-end "A_end_linkEndData-linkEndData" 
    :type |LinkEndData| 
    :multiplicity (0 -1) 
    :association "A_end_linkEndData" 
    :name "linkEndData")

(def-meta-assoc "A_qualifier_linkEndData"      
  :name |A_qualifier_linkEndData|      
  :metatype :association      
  :member-ends ((|LinkEndData| "qualifier")
                ("A_qualifier_linkEndData-linkEndData" "linkEndData"))      
  :owned-ends  (("A_qualifier_linkEndData-linkEndData" "linkEndData")))

(def-meta-assoc-end "A_qualifier_linkEndData-linkEndData" 
    :type |LinkEndData| 
    :multiplicity (1 1) 
    :association "A_qualifier_linkEndData" 
    :name "linkEndData")

(def-meta-assoc "A_value_linkEndData"      
  :name |A_value_linkEndData|      
  :metatype :association      
  :member-ends ((|LinkEndData| "value")
                ("A_value_linkEndData-linkEndData" "linkEndData"))      
  :owned-ends  (("A_value_linkEndData-linkEndData" "linkEndData")))

(def-meta-assoc-end "A_value_linkEndData-linkEndData" 
    :type |LinkEndData| 
    :multiplicity (0 1) 
    :association "A_value_linkEndData" 
    :name "linkEndData")

;;; =========================================================
;;; ====================== LinkEndDestructionData
;;; =========================================================
(def-meta-class |LinkEndDestructionData| 
   (:model :UML25 :superclasses (|LinkEndData|) 
    :packages (UML |Actions|) 
    :xmi-id "LinkEndDestructionData")
 "LinkEndDestructionData is LinkEndData used to provide values for one end
  of a link to be destroyed by a DestroyLinkAction."
  ((|destroyAt| :xmi-id "LinkEndDestructionData-destroyAt" :range |InputPin| :multiplicity (0 1)
    :documentation
     "The InputPin that provides the position of an existing link to be destroyed
      in an ordered, nonunique Association end. The type of the destroyAt InputPin
      is UnlimitedNatural, but the value cannot be zero or unlimited.")
   (|isDestroyDuplicates| :xmi-id "LinkEndDestructionData-isDestroyDuplicates" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to destroy duplicates of the value in nonunique Association
      ends.")))

(def-meta-operation "allPins" |LinkEndDestructionData| 
   "Adds the destroyAt InputPin (if any) to the set of all Pins."
   :operation-body
   "result = (self.LinkEndData::allPins()->including(destroyAt))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InputPin|
                        :parameter-return-p T))
)

(def-meta-assoc "A_destroyAt_linkEndDestructionData"      
  :name |A_destroyAt_linkEndDestructionData|      
  :metatype :association      
  :member-ends ((|LinkEndDestructionData| "destroyAt")
                ("A_destroyAt_linkEndDestructionData-linkEndDestructionData" "linkEndDestructionData"))      
  :owned-ends  (("A_destroyAt_linkEndDestructionData-linkEndDestructionData" "linkEndDestructionData")))

(def-meta-assoc-end "A_destroyAt_linkEndDestructionData-linkEndDestructionData" 
    :type |LinkEndDestructionData| 
    :multiplicity (0 1) 
    :association "A_destroyAt_linkEndDestructionData" 
    :name "linkEndDestructionData")

;;; =========================================================
;;; ====================== LiteralBoolean
;;; =========================================================
(def-meta-class |LiteralBoolean| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralBoolean")
 "A LiteralBoolean is a specification of a Boolean value."
  ((|value| :xmi-id "LiteralBoolean-value" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "The specified Boolean value.")))

(def-meta-operation "booleanValue" |LiteralBoolean| 
   "The query booleanValue() gives the value."
   :operation-body
   "result = (value)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralBoolean| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralInteger
;;; =========================================================
(def-meta-class |LiteralInteger| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralInteger")
 "A LiteralInteger is a specification of an Integer value."
  ((|value| :xmi-id "LiteralInteger-value" :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The specified Integer value.")))

(def-meta-operation "integerValue" |LiteralInteger| 
   "The query integerValue() gives the value."
   :operation-body
   "result = (value)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralInteger| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralNull
;;; =========================================================
(def-meta-class |LiteralNull| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralNull")
 "A LiteralNull specifies the lack of a value."
  ())

(def-meta-operation "isComputable" |LiteralNull| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |LiteralNull| 
   "The query isNull() returns true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralReal
;;; =========================================================
(def-meta-class |LiteralReal| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralReal")
 "A LiteralReal is a specification of a Real value."
  ((|value| :xmi-id "LiteralReal-value" :range |Real| :multiplicity (1 1)
    :documentation
     "The specified Real value.")))

(def-meta-operation "isComputable" |LiteralReal| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "realValue" |LiteralReal| 
   "The query realValue() gives the value."
   :operation-body
   "result = (value)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Real|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralSpecification
;;; =========================================================
(def-meta-class |LiteralSpecification| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralSpecification")
 "A LiteralSpecification identifies a literal constant being modeled."
  ())

;;; =========================================================
;;; ====================== LiteralString
;;; =========================================================
(def-meta-class |LiteralString| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralString")
 "A LiteralString is a specification of a String value."
  ((|value| :xmi-id "LiteralString-value" :range |String| :multiplicity (0 1)
    :documentation
     "The specified String value.")))

(def-meta-operation "isComputable" |LiteralString| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |LiteralString| 
   "The query stringValue() gives the value."
   :operation-body
   "result = (value)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralUnlimitedNatural
;;; =========================================================
(def-meta-class |LiteralUnlimitedNatural| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "LiteralUnlimitedNatural")
 "A LiteralUnlimitedNatural is a specification of an UnlimitedNatural number."
  ((|value| :xmi-id "LiteralUnlimitedNatural-value" :range |UnlimitedNatural| :multiplicity (1 1) :default 0
    :documentation
     "The specified UnlimitedNatural value.")))

(def-meta-operation "isComputable" |LiteralUnlimitedNatural| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |LiteralUnlimitedNatural| 
   "The query unlimitedValue() gives the value."
   :operation-body
   "result = (value)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LoopNode
;;; =========================================================
(def-meta-class |LoopNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "LoopNode")
 "A LoopNode is a StructuredActivityNode that represents an iterative loop
  with setup, test, and body sections."
  ((|bodyOutput| :xmi-id "LoopNode-bodyOutput" :range |OutputPin| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The OutputPins on Actions within the bodyPart, the values of which are
      moved to the loopVariable OutputPins after the completion of each execution
      of the bodyPart, before the next iteration of the loop begins or before
      the loop exits.")
   (|bodyPart| :xmi-id "LoopNode-bodyPart" :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "The set of ExecutableNodes that perform the repetitive computations of
      the loop. The bodyPart is executed as long as the test section produces
      a true value.")
   (|decider| :xmi-id "LoopNode-decider" :range |OutputPin| :multiplicity (1 1)
    :documentation
     "An OutputPin on an Action in the test section whose Boolean value determines
      whether to continue executing the loop bodyPart.")
   (|isTestedFirst| :xmi-id "LoopNode-isTestedFirst" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the test is performed before the first execution of the bodyPart.
      If false, the bodyPart is executed once before the test is performed.")
   (|loopVariable| :xmi-id "LoopNode-loopVariable" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A list of OutputPins that hold the values of the loop variables during
      an execution of the loop. When the test fails, the values are moved to
      the result OutputPins of the loop.")
   (|loopVariableInput| :xmi-id "LoopNode-loopVariableInput" :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "A list of InputPins whose values are moved into the loopVariable Pins before
      the first iteration of the loop." :redefined-property (|StructuredActivityNode| |structuredNodeInput|))
   (|result| :xmi-id "LoopNode-result" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "A list of OutputPins that receive the loopVariable values after the last
      iteration of the loop and constitute the output of the LoopNode." :redefined-property (|StructuredActivityNode| |structuredNodeOutput|))
   (|setupPart| :xmi-id "LoopNode-setupPart" :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "The set of ExecutableNodes executed before the first iteration of the loop,
      in order to initialize values or perform other setup computations.")
   (|test| :xmi-id "LoopNode-test" :range |ExecutableNode| :multiplicity (1 -1)
    :documentation
     "The set of ExecutableNodes executed in order to provide the test result
      for the loop.")))

(def-meta-operation "allActions" |LoopNode| 
   "Return only this LoopNode. This prevents Actions within the LoopNode from
    having their OutputPins used as bodyOutputs or decider Pins in containing
    LoopNodes or ConditionalNodes."
   :operation-body
   "result = (self->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Action|
                        :parameter-return-p T))
)

(def-meta-operation "sourceNodes" |LoopNode| 
   "Return the loopVariable OutputPins in addition to other source nodes for
    the LoopNode as a StructuredActivityNode."
   :operation-body
   "result = (self.StructuredActivityNode::sourceNodes()->union(loopVariable))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ActivityNode|
                        :parameter-return-p T))
)

(def-meta-assoc "A_bodyOutput_loopNode"      
  :name |A_bodyOutput_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "bodyOutput")
                ("A_bodyOutput_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_bodyOutput_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_bodyOutput_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 -1) 
    :association "A_bodyOutput_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_bodyPart_loopNode"      
  :name |A_bodyPart_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "bodyPart")
                ("A_bodyPart_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_bodyPart_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_bodyPart_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_bodyPart_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_decider_loopNode"      
  :name |A_decider_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "decider")
                ("A_decider_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_decider_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_decider_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_decider_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_loopVariableInput_loopNode"      
  :name |A_loopVariableInput_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "loopVariableInput")
                ("A_loopVariableInput_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_loopVariableInput_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_loopVariableInput_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_loopVariableInput_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_loopVariable_loopNode"      
  :name |A_loopVariable_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "loopVariable")
                ("A_loopVariable_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_loopVariable_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_loopVariable_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_loopVariable_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_result_loopNode"      
  :name |A_result_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "result")
                ("A_result_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_result_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_result_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_result_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_setupPart_loopNode"      
  :name |A_setupPart_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "setupPart")
                ("A_setupPart_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_setupPart_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_setupPart_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_setupPart_loopNode" 
    :name "loopNode")

(def-meta-assoc "A_test_loopNode"      
  :name |A_test_loopNode|      
  :metatype :association      
  :member-ends ((|LoopNode| "test")
                ("A_test_loopNode-loopNode" "loopNode"))      
  :owned-ends  (("A_test_loopNode-loopNode" "loopNode")))

(def-meta-assoc-end "A_test_loopNode-loopNode" 
    :type |LoopNode| 
    :multiplicity (0 1) 
    :association "A_test_loopNode" 
    :name "loopNode")

;;; =========================================================
;;; ====================== Manifestation
;;; =========================================================
(def-meta-class |Manifestation| 
   (:model :UML25 :superclasses (|Abstraction|) 
    :packages (UML |Deployments|) 
    :xmi-id "Manifestation")
 "A manifestation is the concrete physical rendering of one or more model
  elements by an artifact."
  ((|utilizedElement| :xmi-id "Manifestation-utilizedElement" :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "The model element that is utilized in the manifestation in an Artifact.")))

(def-meta-assoc "A_utilizedElement_manifestation"      
  :name |A_utilizedElement_manifestation|      
  :metatype :association      
  :member-ends ((|Manifestation| "utilizedElement")
                ("A_utilizedElement_manifestation-manifestation" "manifestation"))      
  :owned-ends  (("A_utilizedElement_manifestation-manifestation" "manifestation")))

(def-meta-assoc-end "A_utilizedElement_manifestation-manifestation" 
    :type |Manifestation| 
    :multiplicity (0 -1) 
    :association "A_utilizedElement_manifestation" 
    :name "manifestation")

;;; =========================================================
;;; ====================== MergeNode
;;; =========================================================
(def-meta-class |MergeNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "MergeNode")
 "A merge node is a control node that brings together multiple alternate
  flows. It is not used to synchronize concurrent flows but to accept one
  among several alternate flows."
  ())

;;; =========================================================
;;; ====================== Message
;;; =========================================================
(def-meta-class |Message| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "Message")
 "A Message defines a particular communication between Lifelines of an Interaction."
  ((|argument| :xmi-id "Message-argument" :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The arguments of the Message.")
   (|connector| :xmi-id "Message-connector" :range |Connector| :multiplicity (0 1)
    :documentation
     "The Connector on which this Message is sent.")
   (|interaction| :xmi-id "Message-interaction" :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |message|)
    :documentation
     "The enclosing Interaction owning the Message.")
   (|messageKind| :xmi-id "Message-messageKind" :range |MessageKind| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The derived kind of the Message (complete, lost, found, or unknown).")
   (|messageSort| :xmi-id "Message-messageSort" :range |MessageSort| :multiplicity (1 1) :default :synchcall
    :documentation
     "The sort of communication reflected by the Message.")
   (|receiveEvent| :xmi-id "Message-receiveEvent" :range |MessageEnd| :multiplicity (0 1)
    :documentation
     "References the Receiving of the Message.")
   (|sendEvent| :xmi-id "Message-sendEvent" :range |MessageEnd| :multiplicity (0 1)
    :documentation
     "References the Sending of the Message.")
   (|signature| :xmi-id "Message-signature" :range |NamedElement| :multiplicity (0 1)
    :documentation
     "The signature of the Message is the specification of its content. It refers
      either an Operation or a Signal.")))

(def-meta-operation "isDistinguishableFrom" |Message| 
   "The query isDistinguishableFrom() specifies that any two Messages may coexist
    in the same Namespace, regardless of their names."
   :operation-body
   "result = (true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-meta-operation "messageKind.1" |Message| 
   "This query returns the MessageKind value for this Message."
   :operation-body
   "result = (messageKind)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|MessageKind|
                        :parameter-return-p T))
)

(def-meta-assoc "A_argument_message"      
  :name |A_argument_message|      
  :metatype :association      
  :member-ends ((|Message| "argument")
                ("A_argument_message-message" "message"))      
  :owned-ends  (("A_argument_message-message" "message")))

(def-meta-assoc-end "A_argument_message-message" 
    :type |Message| 
    :multiplicity (0 1) 
    :association "A_argument_message" 
    :name "message")

(def-meta-assoc "A_connector_message"      
  :name |A_connector_message|      
  :metatype :association      
  :member-ends ((|Message| "connector")
                ("A_connector_message-message" "message"))      
  :owned-ends  (("A_connector_message-message" "message")))

(def-meta-assoc-end "A_connector_message-message" 
    :type |Message| 
    :multiplicity (0 -1) 
    :association "A_connector_message" 
    :name "message")

(def-meta-assoc "A_receiveEvent_endMessage"      
  :name |A_receiveEvent_endMessage|      
  :metatype :association      
  :member-ends ((|Message| "receiveEvent")
                ("A_receiveEvent_endMessage-endMessage" "endMessage"))      
  :owned-ends  (("A_receiveEvent_endMessage-endMessage" "endMessage")))

(def-meta-assoc-end "A_receiveEvent_endMessage-endMessage" 
    :type |Message| 
    :multiplicity (0 1) 
    :association "A_receiveEvent_endMessage" 
    :name "endMessage")

(def-meta-assoc "A_sendEvent_endMessage"      
  :name |A_sendEvent_endMessage|      
  :metatype :association      
  :member-ends ((|Message| "sendEvent")
                ("A_sendEvent_endMessage-endMessage" "endMessage"))      
  :owned-ends  (("A_sendEvent_endMessage-endMessage" "endMessage")))

(def-meta-assoc-end "A_sendEvent_endMessage-endMessage" 
    :type |Message| 
    :multiplicity (0 1) 
    :association "A_sendEvent_endMessage" 
    :name "endMessage")

(def-meta-assoc "A_signature_message"      
  :name |A_signature_message|      
  :metatype :association      
  :member-ends ((|Message| "signature")
                ("A_signature_message-message" "message"))      
  :owned-ends  (("A_signature_message-message" "message")))

(def-meta-assoc-end "A_signature_message-message" 
    :type |Message| 
    :multiplicity (0 -1) 
    :association "A_signature_message" 
    :name "message")

;;; =========================================================
;;; ====================== MessageEnd
;;; =========================================================
(def-meta-class |MessageEnd| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "MessageEnd")
 "MessageEnd is an abstract specialization of NamedElement that represents
  what can occur at the end of a Message."
  ((|message| :xmi-id "MessageEnd-message" :range |Message| :multiplicity (0 1)
    :documentation
     "References a Message.")))

(def-meta-operation "enclosingFragment" |MessageEnd| 
   "This query returns a set including the enclosing InteractionFragment this
    MessageEnd is enclosed within."
   :operation-body
   "result = (if self->select(oclIsKindOf(Gate))->notEmpty()   then -- it is a Gate  let endGate : Gate =     self->select(oclIsKindOf(Gate)).oclAsType(Gate)->asOrderedSet()->first()    in    if endGate.isOutsideCF()     then endGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(endGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet())    else if endGate.isInsideCF()       then endGate.combinedFragment.oclAsType(InteractionFragment)->asSet()      else if endGate.isFormal()         then endGate.interaction.oclAsType(InteractionFragment)->asSet()        else if endGate.isActual()           then endGate.interactionUse.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(endGate.interactionUse.enclosingOperand.oclAsType(InteractionFragment)->asSet())          else null          endif        endif      endif    endif  else -- it is a MessageOccurrenceSpecification  let endMOS : MessageOccurrenceSpecification  =     self->select(oclIsKindOf(MessageOccurrenceSpecification)).oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first()     in    if endMOS.enclosingInteraction->notEmpty()     then endMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()    else endMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet()    endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InteractionFragment|
                        :parameter-return-p T))
)

(def-meta-operation "isReceive" |MessageEnd| 
   "This query returns value true if this MessageEnd is a receiveEvent."
   :operation-body
   "result = (message.receiveEvent->asSet()->includes(self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isSend" |MessageEnd| 
   "This query returns value true if this MessageEnd is a sendEvent."
   :operation-body
   "result = (message.sendEvent->asSet()->includes(self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "oppositeEnd" |MessageEnd| 
   "This query returns a set including the MessageEnd (if exists) at the opposite
    end of the Message for this MessageEnd."
   :operation-body
   "result = (message->asSet().messageEnd->asSet()->excluding(self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|MessageEnd|
                        :parameter-return-p T))
)

(def-meta-assoc "A_message_messageEnd"      
  :name |A_message_messageEnd|      
  :metatype :association      
  :member-ends ((|MessageEnd| "message")
                ("A_message_messageEnd-messageEnd" "messageEnd"))      
  :owned-ends  (("A_message_messageEnd-messageEnd" "messageEnd")))

(def-meta-assoc-end "A_message_messageEnd-messageEnd" 
    :type |MessageEnd| 
    :multiplicity (0 2) 
    :association "A_message_messageEnd" 
    :name "messageEnd")

;;; =========================================================
;;; ====================== MessageEvent
;;; =========================================================
(def-meta-class |MessageEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "MessageEvent")
 "A MessageEvent specifies the receipt by an object of either an Operation
  call or a Signal instance."
  ())

;;; =========================================================
;;; ====================== MessageOccurrenceSpecification
;;; =========================================================
(def-meta-class |MessageOccurrenceSpecification| 
   (:model :UML25 :superclasses (|MessageEnd| |OccurrenceSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "MessageOccurrenceSpecification")
 "A MessageOccurrenceSpecification specifies the occurrence of Message events,
  such as sending and receiving of Signals or invoking or receiving of Operation
  calls. A MessageOccurrenceSpecification is a kind of MessageEnd. Messages
  are generated either by synchronous Operation calls or asynchronous Signal
  sends. They are received by the execution of corresponding AcceptEventActions."
  ())

;;; =========================================================
;;; ====================== Model
;;; =========================================================
(def-meta-class |Model| 
   (:model :UML25 :superclasses (|Package|) 
    :packages (UML |Packages|) 
    :xmi-id "Model")
 "A model captures a view of a physical system. It is an abstraction of the
  physical system, with a certain purpose. This purpose determines what is
  to be included in the model and what is irrelevant. Thus the model completely
  describes those aspects of the physical system that are relevant to the
  purpose of the model, at the appropriate level of detail."
  ((|viewpoint| :xmi-id "Model-viewpoint" :range |String| :multiplicity (0 1)
    :documentation
     "The name of the viewpoint that is expressed by a model (this name may refer
      to a profile definition).")))

;;; =========================================================
;;; ====================== MultiplicityElement
;;; =========================================================
(def-meta-class |MultiplicityElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "MultiplicityElement")
 "A multiplicity is a definition of an inclusive interval of non-negative
  integers beginning with a lower bound and ending with a (possibly infinite)
  upper bound. A MultiplicityElement embeds this information to specify the
  allowable cardinalities for an instantiation of the Element."
  ((|isOrdered| :xmi-id "MultiplicityElement-isOrdered" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "For a multivalued multiplicity, this attribute specifies whether the values
      in an instantiation of this MultiplicityElement are sequentially ordered.")
   (|isUnique| :xmi-id "MultiplicityElement-isUnique" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a multivalued multiplicity, this attributes specifies whether the values
      in an instantiation of this MultiplicityElement are unique.")
   (|lower| :xmi-id "MultiplicityElement-lower" :range |Integer| :multiplicity (1 1) :is-derived-p T
    :documentation
     "The lower bound of the multiplicity interval.")
   (|lowerValue| :xmi-id "MultiplicityElement-lowerValue" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The specification of the lower bound for this multiplicity.")
   (|upper| :xmi-id "MultiplicityElement-upper" :range |UnlimitedNatural| :multiplicity (1 1) :is-derived-p T
    :documentation
     "The upper bound of the multiplicity interval.")
   (|upperValue| :xmi-id "MultiplicityElement-upperValue" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The specification of the upper bound for this multiplicity.")))

(def-meta-operation "compatibleWith" |MultiplicityElement| 
   "The operation compatibleWith takes another multiplicity as input. It returns
    true if the other multiplicity is wider than, or the same as, self."
   :operation-body
   "result = ((other.lowerBound() <= self.lowerBound()) and ((other.upperBound() = *) or (self.upperBound() <= other.upperBound())))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|MultiplicityElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "includesMultiplicity" |MultiplicityElement| 
   "The query includesMultiplicity() checks whether this multiplicity includes
    all the cardinalities allowed by the specified multiplicity."
   :operation-body
   "result = ((self.lowerBound() <= M.lowerBound()) and (self.upperBound() >= M.upperBound()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name 'M :parameter-type '|MultiplicityElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "is" |MultiplicityElement| 
   "The operation is determines if the upper and lower bound of the ranges
    are the ones given."
   :operation-body
   "result = (lowerbound = self.lowerBound() and upperbound = self.upperBound())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|lowerbound| :parameter-type '|Integer|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|upperbound| :parameter-type '|UnlimitedNatural|
                        :parameter-return-p NIL))
)

(def-meta-operation "isMultivalued" |MultiplicityElement| 
   "The query isMultivalued() checks whether this multiplicity has an upper
    bound greater than one."
   :operation-body
   "result = (upperBound() > 1)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |MultiplicityElement| 
   "The derived lower attribute must equal the lowerBound."
   :operation-body
   "result = (lowerBound())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "lowerBound" |MultiplicityElement| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    integer, which is the integerValue of lowerValue, if this is given, and
    1 otherwise."
   :operation-body
   "result = (if (lowerValue=null or lowerValue.integerValue()=null) then 1 else lowerValue.integerValue() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |MultiplicityElement| 
   "The derived upper attribute must equal the upperBound."
   :operation-body
   "result = (upperBound())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-meta-operation "upperBound" |MultiplicityElement| 
   "The query upperBound() returns the upper bound of the multiplicity for
    a bounded multiplicity as an unlimited natural, which is the unlimitedNaturalValue
    of upperValue, if given, and 1, otherwise."
   :operation-body
   "result = (if (upperValue=null or upperValue.unlimitedValue()=null) then 1 else upperValue.unlimitedValue() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-meta-assoc "A_lowerValue_owningLower"      
  :name |A_lowerValue_owningLower|      
  :metatype :association      
  :member-ends ((|MultiplicityElement| "lowerValue")
                ("A_lowerValue_owningLower-owningLower" "owningLower"))      
  :owned-ends  (("A_lowerValue_owningLower-owningLower" "owningLower")))

(def-meta-assoc-end "A_lowerValue_owningLower-owningLower" 
    :type |MultiplicityElement| 
    :multiplicity (0 1) 
    :association "A_lowerValue_owningLower" 
    :name "owningLower")

(def-meta-assoc "A_upperValue_owningUpper"      
  :name |A_upperValue_owningUpper|      
  :metatype :association      
  :member-ends ((|MultiplicityElement| "upperValue")
                ("A_upperValue_owningUpper-owningUpper" "owningUpper"))      
  :owned-ends  (("A_upperValue_owningUpper-owningUpper" "owningUpper")))

(def-meta-assoc-end "A_upperValue_owningUpper-owningUpper" 
    :type |MultiplicityElement| 
    :multiplicity (0 1) 
    :association "A_upperValue_owningUpper" 
    :name "owningUpper")

;;; =========================================================
;;; ====================== NamedElement
;;; =========================================================
(def-meta-class |NamedElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "NamedElement")
 "A NamedElement is an Element in a model that may have a name. The name
  may be given directly and/or via the use of a StringExpression."
  ((|clientDependency| :xmi-id "NamedElement-clientDependency" :range |Dependency| :multiplicity (0 -1) :is-derived-p T
    :opposite (|Dependency| |client|)
    :documentation
     "Indicates the Dependencies that reference this NamedElement as a client.")
   (|name| :xmi-id "NamedElement-name" :range |String| :multiplicity (0 1)
    :documentation
     "The name of the NamedElement.")
   (|nameExpression| :xmi-id "NamedElement-nameExpression" :range |StringExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The StringExpression used to define the name of this NamedElement.")
   (|namespace| :xmi-id "NamedElement-namespace" :range |Namespace| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Namespace| |ownedMember|)
    :documentation
     "Specifies the Namespace that owns the NamedElement.")
   (|qualifiedName| :xmi-id "NamedElement-qualifiedName" :range |String| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A name that allows the NamedElement to be identified within a hierarchy
      of nested Namespaces. It is constructed from the names of the containing
      Namespaces starting at the root of the hierarchy and ending with the name
      of the NamedElement itself.")
   (|visibility| :xmi-id "NamedElement-visibility" :range |VisibilityKind| :multiplicity (0 1)
    :documentation
     "Determines whether and how the NamedElement is visible outside its owning
      Namespace.")))

(def-meta-operation "allNamespaces" |NamedElement| 
   "The query allNamespaces() gives the sequence of Namespaces in which the
    NamedElement is nested, working outwards."
   :operation-body
   "result = (if owner.oclIsKindOf(TemplateParameter) and   owner.oclAsType(TemplateParameter).signature.template.oclIsKindOf(Namespace) then     let enclosingNamespace : Namespace =       owner.oclAsType(TemplateParameter).signature.template.oclAsType(Namespace) in         enclosingNamespace.allNamespaces()->prepend(enclosingNamespace) else   if namespace->isEmpty()     then OrderedSet{}   else     namespace.allNamespaces()->prepend(namespace)   endif endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T))
)

(def-meta-operation "allOwningPackages" |NamedElement| 
   "The query allOwningPackages() returns the set of all the enclosing Namespaces
    of this NamedElement, working outwards, that are Packages, up to but not
    including the first such Namespace that is not a Package."
   :operation-body
   "result = (if namespace.oclIsKindOf(Package)  then    let owningPackage : Package = namespace.oclAsType(Package) in      owningPackage->union(owningPackage.allOwningPackages())  else    null  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-meta-operation "clientDependency.1" |NamedElement| 
   ""
   :operation-body
   "result = (Dependency.allInstances()->select(d | d.client->includes(self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Dependency|
                        :parameter-return-p T))
)

(def-meta-operation "isDistinguishableFrom" |NamedElement| 
   "The query isDistinguishableFrom() determines whether two NamedElements
    may logically co-exist within a Namespace. By default, two named elements
    are distinguishable if (a) they have types neither of which is a kind of
    the other or (b) they have different names."
   :operation-body
   "result = ((self.oclIsKindOf(n.oclType()) or n.oclIsKindOf(self.oclType())) implies     ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty() )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-meta-operation "qualifiedName.1" |NamedElement| 
   "When a NamedElement has a name, and all of its containing Namespaces have
    a name, the qualifiedName is constructed from the name of the NamedElement
    and the names of the containing Namespaces."
   :operation-body
   "result = (if self.name <> null and self.allNamespaces()->select( ns | ns.name=null )->isEmpty() then      self.allNamespaces()->iterate( ns : Namespace; agg: String = self.name | ns.name.concat(self.separator()).concat(agg)) else    null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "separator" |NamedElement| 
   "The query separator() gives the string that is used to separate names when
    constructing a qualifiedName."
   :operation-body
   "result = ('::')"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-assoc "A_clientDependency_client"      
  :name |A_clientDependency_client|      
  :metatype :association      
  :member-ends ((|NamedElement| "clientDependency")
                (|Dependency| "client"))      
  :owned-ends  ())

(def-meta-assoc "A_nameExpression_namedElement"      
  :name |A_nameExpression_namedElement|      
  :metatype :association      
  :member-ends ((|NamedElement| "nameExpression")
                ("A_nameExpression_namedElement-namedElement" "namedElement"))      
  :owned-ends  (("A_nameExpression_namedElement-namedElement" "namedElement")))

(def-meta-assoc-end "A_nameExpression_namedElement-namedElement" 
    :type |NamedElement| 
    :multiplicity (0 1) 
    :association "A_nameExpression_namedElement" 
    :name "namedElement")

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-meta-class |Namespace| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Namespace")
 "A Namespace is an Element in a model that owns and/or imports a set of
  NamedElements that can be identified by name."
  ((|elementImport| :xmi-id "Namespace-elementImport" :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ElementImport| |importingNamespace|)
    :documentation
     "References the ElementImports owned by the Namespace.")
   (|importedMember| :xmi-id "Namespace-importedMember" :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "References the PackageableElements that are members of this Namespace as
      a result of either PackageImports or ElementImports.")
   (|member| :xmi-id "Namespace-member" :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "A collection of NamedElements identifiable within the Namespace, either
      by being owned or by being introduced by importing or inheritance.")
   (|ownedMember| :xmi-id "Namespace-ownedMember" :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|) (|Namespace| |member|))
    :opposite (|NamedElement| |namespace|)
    :documentation
     "A collection of NamedElements owned by the Namespace.")
   (|ownedRule| :xmi-id "Namespace-ownedRule" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Constraint| |context|)
    :documentation
     "Specifies a set of Constraints owned by this Namespace.")
   (|packageImport| :xmi-id "Namespace-packageImport" :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageImport| |importingNamespace|)
    :documentation
     "References the PackageImports owned by the Namespace.")))

(def-meta-operation "excludeCollisions" |Namespace| 
   "The query excludeCollisions() excludes from a set of PackageableElements
    any that would not be distinguishable from each other in this Namespace."
   :operation-body
   "result = (imps->reject(imp1  | imps->exists(imp2 | not imp1.isDistinguishableFrom(imp2, self))))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "getNamesOfMember" |Namespace| 
   "The query getNamesOfMember() gives a set of all of the names that a member
    would have in a Namespace, taking importing into account. In general a
    member can have multiple names in a Namespace if it is imported more than
    once with different aliases."
   :operation-body
   "result = (if self.ownedMember ->includes(element) then Set{element.name} else let elementImports : Set(ElementImport) = self.elementImport->select(ei | ei.importedElement = element) in   if elementImports->notEmpty()   then      elementImports->collect(el | el.getName())->asSet()   else       self.packageImport->select(pi | pi.importedPackage.visibleMembers().oclAsType(NamedElement)->includes(element))-> collect(pi | pi.importedPackage.getNamesOfMember(element))->asSet()   endif endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|element| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "importMembers" |Namespace| 
   "The query importMembers() defines which of a set of PackageableElements
    are actually imported into the Namespace. This excludes hidden ones, i.e.,
    those which have names that conflict with names of ownedMembers, and it
    also excludes PackageableElements that would have the indistinguishable
    names when imported."
   :operation-body
   "result = (self.excludeCollisions(imps)->select(imp | self.ownedMember->forAll(mem | imp.isDistinguishableFrom(mem, self))))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "importedMember.1" |Namespace| 
   "The importedMember property is derived as the PackageableElements that
    are members of this Namespace as a result of either PackageImports or ElementImports."
   :operation-body
   "result = (self.importMembers(elementImport.importedElement->asSet()->union(packageImport.importedPackage->collect(p | p.visibleMembers()))->asSet()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

(def-meta-operation "membersAreDistinguishable" |Namespace| 
   "The Boolean query membersAreDistinguishable() determines whether all of
    the Namespace's members are distinguishable within it."
   :operation-body
   "result = (member->forAll( memb |    member->excluding(memb)->forAll(other |        memb.isDistinguishableFrom(other, self))))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-assoc "A_elementImport_importingNamespace"      
  :name |A_elementImport_importingNamespace|      
  :metatype :association      
  :member-ends ((|Namespace| "elementImport")
                (|ElementImport| "importingNamespace"))      
  :owned-ends  ())

(def-meta-assoc "A_importedMember_namespace"      
  :name |A_importedMember_namespace|      
  :metatype :association      
  :member-ends ((|Namespace| "importedMember")
                ("A_importedMember_namespace-namespace" "namespace"))      
  :owned-ends  (("A_importedMember_namespace-namespace" "namespace")))

(def-meta-assoc-end "A_importedMember_namespace-namespace" 
    :type |Namespace| 
    :multiplicity (0 -1) 
    :association "A_importedMember_namespace" 
    :name "namespace")

(def-meta-assoc "A_member_memberNamespace"      
  :name |A_member_memberNamespace|      
  :metatype :association      
  :member-ends ((|Namespace| "member")
                ("A_member_memberNamespace-memberNamespace" "memberNamespace"))      
  :owned-ends  (("A_member_memberNamespace-memberNamespace" "memberNamespace")))

(def-meta-assoc-end "A_member_memberNamespace-memberNamespace" 
    :type |Namespace| 
    :multiplicity (0 -1) 
    :association "A_member_memberNamespace" 
    :name "memberNamespace")

(def-meta-assoc "A_ownedMember_namespace"      
  :name |A_ownedMember_namespace|      
  :metatype :association      
  :member-ends ((|Namespace| "ownedMember")
                (|NamedElement| "namespace"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedRule_context"      
  :name |A_ownedRule_context|      
  :metatype :association      
  :member-ends ((|Namespace| "ownedRule")
                (|Constraint| "context"))      
  :owned-ends  ())

(def-meta-assoc "A_packageImport_importingNamespace"      
  :name |A_packageImport_importingNamespace|      
  :metatype :association      
  :member-ends ((|Namespace| "packageImport")
                (|PackageImport| "importingNamespace"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Node
;;; =========================================================
(def-meta-class |Node| 
   (:model :UML25 :superclasses (|Class| |DeploymentTarget|) 
    :packages (UML |Deployments|) 
    :xmi-id "Node")
 "A Node is computational resource upon which artifacts may be deployed for
  execution. Nodes can be interconnected through communication paths to define
  network structures."
  ((|nestedNode| :xmi-id "Node-nestedNode" :range |Node| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The Nodes that are defined (nested) within the Node.")))

(def-meta-assoc "A_nestedNode_node"      
  :name |A_nestedNode_node|      
  :metatype :association      
  :member-ends ((|Node| "nestedNode")
                ("A_nestedNode_node-node" "node"))      
  :owned-ends  (("A_nestedNode_node-node" "node")))

(def-meta-assoc-end "A_nestedNode_node-node" 
    :type |Node| 
    :multiplicity (0 1) 
    :association "A_nestedNode_node" 
    :name "node")

;;; =========================================================
;;; ====================== ObjectFlow
;;; =========================================================
(def-meta-class |ObjectFlow| 
   (:model :UML25 :superclasses (|ActivityEdge|) 
    :packages (UML |Activities|) 
    :xmi-id "ObjectFlow")
 "An ObjectFlow is an ActivityEdge that is traversed by object tokens that
  may hold values. Object flows also support multicast/receive, token selection
  from object nodes, and transformation of tokens."
  ((|isMulticast| :xmi-id "ObjectFlow-isMulticast" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the objects in the ObjectFlow are passed by multicasting.")
   (|isMultireceive| :xmi-id "ObjectFlow-isMultireceive" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the objects in the ObjectFlow are gathered from respondents
      to multicasting.")
   (|selection| :xmi-id "ObjectFlow-selection" :range |Behavior| :multiplicity (0 1)
    :documentation
     "A Behavior used to select tokens from a source ObjectNode.")
   (|transformation| :xmi-id "ObjectFlow-transformation" :range |Behavior| :multiplicity (0 1)
    :documentation
     "A Behavior used to change or replace object tokens flowing along the ObjectFlow.")))

(def-meta-assoc "A_selection_objectFlow"      
  :name |A_selection_objectFlow|      
  :metatype :association      
  :member-ends ((|ObjectFlow| "selection")
                ("A_selection_objectFlow-objectFlow" "objectFlow"))      
  :owned-ends  (("A_selection_objectFlow-objectFlow" "objectFlow")))

(def-meta-assoc-end "A_selection_objectFlow-objectFlow" 
    :type |ObjectFlow| 
    :multiplicity (0 -1) 
    :association "A_selection_objectFlow" 
    :name "objectFlow")

(def-meta-assoc "A_transformation_objectFlow"      
  :name |A_transformation_objectFlow|      
  :metatype :association      
  :member-ends ((|ObjectFlow| "transformation")
                ("A_transformation_objectFlow-objectFlow" "objectFlow"))      
  :owned-ends  (("A_transformation_objectFlow-objectFlow" "objectFlow")))

(def-meta-assoc-end "A_transformation_objectFlow-objectFlow" 
    :type |ObjectFlow| 
    :multiplicity (0 -1) 
    :association "A_transformation_objectFlow" 
    :name "objectFlow")

;;; =========================================================
;;; ====================== ObjectNode
;;; =========================================================
(def-meta-class |ObjectNode| 
   (:model :UML25 :superclasses (|TypedElement| |ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "ObjectNode")
 "An ObjectNode is an abstract ActivityNode that may hold tokens within the
  object flow in an Activity. ObjectNodes also support token selection, limitation
  on the number of tokens held, specification of the state required for tokens
  being held, and carrying control values."
  ((|inState| :xmi-id "ObjectNode-inState" :range |State| :multiplicity (0 -1)
    :documentation
     "The States required to be associated with the values held by tokens on
      this ObjectNode.")
   (|isControlType| :xmi-id "ObjectNode-isControlType" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the type of the ObjectNode is to be treated as representing
      control values that may traverse ControlFlows.")
   (|ordering| :xmi-id "ObjectNode-ordering" :range |ObjectNodeOrderingKind| :multiplicity (1 1) :default :fifo
    :documentation
     "Indicates how the tokens held by the ObjectNode are ordered for selection
      to traverse ActivityEdges outgoing from the ObjectNode.")
   (|selection| :xmi-id "ObjectNode-selection" :range |Behavior| :multiplicity (0 1)
    :documentation
     "A Behavior used to select tokens to be offered on outgoing ActivityEdges.")
   (|upperBound| :xmi-id "ObjectNode-upperBound" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The maximum number of tokens that may be held by this ObjectNode. Tokens
      cannot flow into the ObjectNode if the upperBound is reached. If no upperBound
      is specified, then there is no limit on how many tokens the ObjectNode
      can hold.")))

(def-meta-assoc "A_inState_objectNode"      
  :name |A_inState_objectNode|      
  :metatype :association      
  :member-ends ((|ObjectNode| "inState")
                ("A_inState_objectNode-objectNode" "objectNode"))      
  :owned-ends  (("A_inState_objectNode-objectNode" "objectNode")))

(def-meta-assoc-end "A_inState_objectNode-objectNode" 
    :type |ObjectNode| 
    :multiplicity (0 -1) 
    :association "A_inState_objectNode" 
    :name "objectNode")

(def-meta-assoc "A_selection_objectNode"      
  :name |A_selection_objectNode|      
  :metatype :association      
  :member-ends ((|ObjectNode| "selection")
                ("A_selection_objectNode-objectNode" "objectNode"))      
  :owned-ends  (("A_selection_objectNode-objectNode" "objectNode")))

(def-meta-assoc-end "A_selection_objectNode-objectNode" 
    :type |ObjectNode| 
    :multiplicity (0 -1) 
    :association "A_selection_objectNode" 
    :name "objectNode")

(def-meta-assoc "A_upperBound_objectNode"      
  :name |A_upperBound_objectNode|      
  :metatype :association      
  :member-ends ((|ObjectNode| "upperBound")
                ("A_upperBound_objectNode-objectNode" "objectNode"))      
  :owned-ends  (("A_upperBound_objectNode-objectNode" "objectNode")))

(def-meta-assoc-end "A_upperBound_objectNode-objectNode" 
    :type |ObjectNode| 
    :multiplicity (0 1) 
    :association "A_upperBound_objectNode" 
    :name "objectNode")

;;; =========================================================
;;; ====================== Observation
;;; =========================================================
(def-meta-class |Observation| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |Values|) 
    :xmi-id "Observation")
 "Observation specifies a value determined by observing an event or events
  that occur relative to other model Elements."
  ())

;;; =========================================================
;;; ====================== OccurrenceSpecification
;;; =========================================================
(def-meta-class |OccurrenceSpecification| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "OccurrenceSpecification")
 "An OccurrenceSpecification is the basic semantic unit of Interactions.
  The sequences of occurrences specified by them are the meanings of Interactions."
  ((|covered| :xmi-id "OccurrenceSpecification-covered" :range |Lifeline| :multiplicity (1 1)
    :documentation
     "References the Lifeline on which the OccurrenceSpecification appears." :redefined-property (|InteractionFragment| |covered|))
   (|toAfter| :xmi-id "OccurrenceSpecification-toAfter" :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |before|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur after this OccurrenceSpecification.")
   (|toBefore| :xmi-id "OccurrenceSpecification-toBefore" :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |after|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur before this OccurrenceSpecification.")))

(def-meta-assoc "A_covered_events"      
  :name |A_covered_events|      
  :metatype :association      
  :member-ends ((|OccurrenceSpecification| "covered")
                ("A_covered_events-events" "events"))      
  :owned-ends  (("A_covered_events-events" "events")))

(def-meta-assoc-end "A_covered_events-events" 
    :type |OccurrenceSpecification| 
    :multiplicity (0 -1) 
    :association "A_covered_events" 
    :name "events")

(def-meta-assoc "A_toBefore_after"      
  :name |A_toBefore_after|      
  :metatype :association      
  :member-ends ((|OccurrenceSpecification| "toBefore")
                (|GeneralOrdering| "after"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== OpaqueAction
;;; =========================================================
(def-meta-class |OpaqueAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "OpaqueAction")
 "An OpaqueAction is an Action whose functionality is not specified within
  UML."
  ((|body| :xmi-id "OpaqueAction-body" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Provides a textual specification of the functionality of the Action, in
      one or more languages other than UML.")
   (|inputValue| :xmi-id "OpaqueAction-inputValue" :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPins providing inputs to the OpaqueAction.")
   (|language| :xmi-id "OpaqueAction-language" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "If provided, a specification of the language used for each of the body
      Strings.")
   (|outputValue| :xmi-id "OpaqueAction-outputValue" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPins on which the OpaqueAction provides outputs.")))

(def-meta-assoc "A_inputValue_opaqueAction"      
  :name |A_inputValue_opaqueAction|      
  :metatype :association      
  :member-ends ((|OpaqueAction| "inputValue")
                ("A_inputValue_opaqueAction-opaqueAction" "opaqueAction"))      
  :owned-ends  (("A_inputValue_opaqueAction-opaqueAction" "opaqueAction")))

(def-meta-assoc-end "A_inputValue_opaqueAction-opaqueAction" 
    :type |OpaqueAction| 
    :multiplicity (0 1) 
    :association "A_inputValue_opaqueAction" 
    :name "opaqueAction")

(def-meta-assoc "A_outputValue_opaqueAction"      
  :name |A_outputValue_opaqueAction|      
  :metatype :association      
  :member-ends ((|OpaqueAction| "outputValue")
                ("A_outputValue_opaqueAction-opaqueAction" "opaqueAction"))      
  :owned-ends  (("A_outputValue_opaqueAction-opaqueAction" "opaqueAction")))

(def-meta-assoc-end "A_outputValue_opaqueAction-opaqueAction" 
    :type |OpaqueAction| 
    :multiplicity (0 1) 
    :association "A_outputValue_opaqueAction" 
    :name "opaqueAction")

;;; =========================================================
;;; ====================== OpaqueBehavior
;;; =========================================================
(def-meta-class |OpaqueBehavior| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "OpaqueBehavior")
 "An OpaqueBehavior is a Behavior whose specification is given in a textual
  language other than UML."
  ((|body| :xmi-id "OpaqueBehavior-body" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the behavior in one or more languages.")
   (|language| :xmi-id "OpaqueBehavior-language" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Languages the body strings use in the same order as the body strings.")))

;;; =========================================================
;;; ====================== OpaqueExpression
;;; =========================================================
(def-meta-class |OpaqueExpression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "OpaqueExpression")
 "An OpaqueExpression is a ValueSpecification that specifies the computation
  of a collection of values either in terms of a UML Behavior or based on
  a textual statement in a language other than UML"
  ((|behavior| :xmi-id "OpaqueExpression-behavior" :range |Behavior| :multiplicity (0 1)
    :documentation
     "Specifies the behavior of the OpaqueExpression as a UML Behavior.")
   (|body| :xmi-id "OpaqueExpression-body" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "A textual definition of the behavior of the OpaqueExpression, possibly
      in multiple languages.")
   (|language| :xmi-id "OpaqueExpression-language" :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the languages used to express the textual bodies of the OpaqueExpression.
       Languages are matched to body Strings by order. The interpretation of
      the body depends on the languages. If the languages are unspecified, they
      may be implicit from the expression body or the context.")
   (|result| :xmi-id "OpaqueExpression-result" :range |Parameter| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "If an OpaqueExpression is specified using a UML Behavior, then this refers
      to the single required return Parameter of that Behavior. When the Behavior
      completes execution, the values on this Parameter give the result of evaluating
      the OpaqueExpression.")))

(def-meta-operation "isIntegral" |OpaqueExpression| 
   "The query isIntegral() tells whether an expression is intended to produce
    an Integer."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNonNegative" |OpaqueExpression| 
   "The query isNonNegative() tells whether an integer expression has a non-negative
    value."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isPositive" |OpaqueExpression| 
   "The query isPositive() tells whether an integer expression has a positive
    value."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "result.1" |OpaqueExpression| 
   "Derivation for OpaqueExpression::/result"
   :operation-body
   "result = (if behavior = null then   null  else   behavior.ownedParameter->first()  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "value" |OpaqueExpression| 
   "The query value() gives an integer value for an expression intended to
    produce one."
   :operation-body
   "result = (0)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-assoc "A_behavior_opaqueExpression"      
  :name |A_behavior_opaqueExpression|      
  :metatype :association      
  :member-ends ((|OpaqueExpression| "behavior")
                ("A_behavior_opaqueExpression-opaqueExpression" "opaqueExpression"))      
  :owned-ends  (("A_behavior_opaqueExpression-opaqueExpression" "opaqueExpression")))

(def-meta-assoc-end "A_behavior_opaqueExpression-opaqueExpression" 
    :type |OpaqueExpression| 
    :multiplicity (0 -1) 
    :association "A_behavior_opaqueExpression" 
    :name "opaqueExpression")

(def-meta-assoc "A_result_opaqueExpression"      
  :name |A_result_opaqueExpression|      
  :metatype :association      
  :member-ends ((|OpaqueExpression| "result")
                ("A_result_opaqueExpression-opaqueExpression" "opaqueExpression"))      
  :owned-ends  (("A_result_opaqueExpression-opaqueExpression" "opaqueExpression")))

(def-meta-assoc-end "A_result_opaqueExpression-opaqueExpression" 
    :type |OpaqueExpression| 
    :multiplicity (0 -1) 
    :association "A_result_opaqueExpression" 
    :name "opaqueExpression")

;;; =========================================================
;;; ====================== Operation
;;; =========================================================
(def-meta-class |Operation| 
   (:model :UML25 :superclasses (|TemplateableElement| |ParameterableElement| |BehavioralFeature|) 
    :packages (UML |Classification|) 
    :xmi-id "Operation")
 "An Operation is a BehavioralFeature of a Classifier that specifies the
  name, type, parameters, and constraints for invoking an associated Behavior.
  An Operation may invoke both the execution of method behaviors as well
  as other behavioral responses. Operation specializes TemplateableElement
  in order to support specification of template operations and bound operations.
  Operation specializes ParameterableElement to specify that an operation
  can be exposed as a formal template parameter, and provided as an actual
  parameter in a binding of a template."
  ((|bodyCondition| :xmi-id "Operation-bodyCondition" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional Constraint on the result values of an invocation of this Operation.")
   (|class| :xmi-id "Operation-class" :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Class| |ownedOperation|)
    :documentation
     "The Class that owns this operation, if any.")
   (|datatype| :xmi-id "Operation-datatype" :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|DataType| |ownedOperation|)
    :documentation
     "The DataType that owns this Operation, if any.")
   (|interface| :xmi-id "Operation-interface" :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Interface| |ownedOperation|)
    :documentation
     "The Interface that owns this Operation, if any.")
   (|isOrdered| :xmi-id "Operation-isOrdered" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Specifies whether the return parameter is ordered or not, if present. 
      This information is derived from the return result for this Operation.")
   (|isQuery| :xmi-id "Operation-isQuery" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether an execution of the BehavioralFeature leaves the state
      of the system unchanged (isQuery=true) or whether side effects may occur
      (isQuery=false).")
   (|isUnique| :xmi-id "Operation-isUnique" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Specifies whether the return parameter is unique or not, if present. This
      information is derived from the return result for this Operation.")
   (|lower| :xmi-id "Operation-lower" :range |Integer| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Specifies the lower multiplicity of the return parameter, if present. This
      information is derived from the return result for this Operation.")
   (|ownedParameter| :xmi-id "Operation-ownedParameter" :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :opposite (|Parameter| |operation|)
    :documentation
     "The parameters owned by this Operation." :redefined-property (|BehavioralFeature| |ownedParameter|))
   (|postcondition| :xmi-id "Operation-postcondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying the state of the system when
      the Operation is completed.")
   (|precondition| :xmi-id "Operation-precondition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints on the state of the system when the Operation
      is invoked.")
   (|raisedException| :xmi-id "Operation-raisedException" :range |Type| :multiplicity (0 -1)
    :documentation
     "The Types representing exceptions that may be raised during an invocation
      of this operation." :redefined-property (|BehavioralFeature| |raisedException|))
   (|redefinedOperation| :xmi-id "Operation-redefinedOperation" :range |Operation| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The Operations that are redefined by this Operation.")
   (|templateParameter| :xmi-id "Operation-templateParameter" :range |OperationTemplateParameter| :multiplicity (0 1)
    :opposite (|OperationTemplateParameter| |parameteredElement|)
    :documentation
     "The OperationTemplateParameter that exposes this element as a formal parameter." :redefined-property (|ParameterableElement| |templateParameter|))
   (|type| :xmi-id "Operation-type" :range |Type| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The return type of the operation, if present. This information is derived
      from the return result for this Operation.")
   (|upper| :xmi-id "Operation-upper" :range |UnlimitedNatural| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The upper multiplicity of the return parameter, if present. This information
      is derived from the return result for this Operation.")))

(def-meta-operation "isConsistentWith" |Operation| 
   "The query isConsistentWith() specifies, for any two Operations in a context
    in which redefinition is possible, whether redefinition would be consistent.
    A redefining operation is consistent with a redefined operation if  it
    has the same number of owned parameters, and for each parameter the following
    holds:    - Direction, ordering and uniqueness are the same.  - The corresponding
    types are covariant, contravariant or invariant.  - The multiplicities
    are compatible, depending on the parameter direction."
   :operation-body
   "result = (redefiningElement.oclIsKindOf(Operation) and  let op : Operation = redefiningElement.oclAsType(Operation) in   self.ownedParameter->size() = op.ownedParameter->size() and   Sequence{1..self.ownedParameter->size()}->    forAll(i |        let redefiningParam : Parameter = op.ownedParameter->at(i),                 redefinedParam : Parameter = self.ownedParameter->at(i) in                   (redefiningParam.isUnique = redefinedParam.isUnique) and                   (redefiningParam.isOrdered = redefinedParam. isOrdered) and                   (redefiningParam.direction = redefinedParam.direction) and                   (redefiningParam.type.conformsTo(redefinedParam.type) or                       redefinedParam.type.conformsTo(redefiningParam.type)) and                   (redefiningParam.direction = ParameterDirectionKind::inout implies                           (redefinedParam.compatibleWith(redefiningParam) and                           redefiningParam.compatibleWith(redefinedParam))) and                   (redefiningParam.direction = ParameterDirectionKind::_'in' implies                           redefinedParam.compatibleWith(redefiningParam)) and                   ((redefiningParam.direction = ParameterDirectionKind::out or                        redefiningParam.direction = ParameterDirectionKind::return) implies                           redefiningParam.compatibleWith(redefinedParam))    ))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isOrdered.1" |Operation| 
   "If this operation has a return parameter, isOrdered equals the value of
    isOrdered for that parameter. Otherwise isOrdered is false."
   :operation-body
   "result = (if returnResult()->notEmpty() then returnResult()-> exists(isOrdered) else false endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isUnique.1" |Operation| 
   "If this operation has a return parameter, isUnique equals the value of
    isUnique for that parameter. Otherwise isUnique is true."
   :operation-body
   "result = (if returnResult()->notEmpty() then returnResult()->exists(isUnique) else true endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |Operation| 
   "If this operation has a return parameter, lower equals the value of lower
    for that parameter. Otherwise lower has no value."
   :operation-body
   "result = (if returnResult()->notEmpty() then returnResult()->any(true).lower else null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "returnResult" |Operation| 
   "The query returnResult() returns the set containing the return parameter
    of the Operation if one exists, otherwise, it returns an empty set"
   :operation-body
   "result = (ownedParameter->select (direction = ParameterDirectionKind::return))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "type.1" |Operation| 
   "If this operation has a return parameter, type equals the value of type
    for that parameter. Otherwise type has no value."
   :operation-body
   "result = (if returnResult()->notEmpty() then returnResult()->any(true).type else null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |Operation| 
   "If this operation has a return parameter, upper equals the value of upper
    for that parameter. Otherwise upper has no value."
   :operation-body
   "result = (if returnResult()->notEmpty() then returnResult()->any(true).upper else null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-meta-assoc "A_bodyCondition_bodyContext"      
  :name |A_bodyCondition_bodyContext|      
  :metatype :association      
  :member-ends ((|Operation| "bodyCondition")
                ("A_bodyCondition_bodyContext-bodyContext" "bodyContext"))      
  :owned-ends  (("A_bodyCondition_bodyContext-bodyContext" "bodyContext")))

(def-meta-assoc-end "A_bodyCondition_bodyContext-bodyContext" 
    :type |Operation| 
    :multiplicity (0 1) 
    :association "A_bodyCondition_bodyContext" 
    :name "bodyContext")

(def-meta-assoc "A_operation_templateParameter_parameteredElement"      
  :name |A_operation_templateParameter_parameteredElement|      
  :metatype :association      
  :member-ends ((|Operation| "templateParameter")
                (|OperationTemplateParameter| "parameteredElement"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedParameter_operation"      
  :name |A_ownedParameter_operation|      
  :metatype :association      
  :member-ends ((|Operation| "ownedParameter")
                (|Parameter| "operation"))      
  :owned-ends  ())

(def-meta-assoc "A_postcondition_postContext"      
  :name |A_postcondition_postContext|      
  :metatype :association      
  :member-ends ((|Operation| "postcondition")
                ("A_postcondition_postContext-postContext" "postContext"))      
  :owned-ends  (("A_postcondition_postContext-postContext" "postContext")))

(def-meta-assoc-end "A_postcondition_postContext-postContext" 
    :type |Operation| 
    :multiplicity (0 1) 
    :association "A_postcondition_postContext" 
    :name "postContext")

(def-meta-assoc "A_precondition_preContext"      
  :name |A_precondition_preContext|      
  :metatype :association      
  :member-ends ((|Operation| "precondition")
                ("A_precondition_preContext-preContext" "preContext"))      
  :owned-ends  (("A_precondition_preContext-preContext" "preContext")))

(def-meta-assoc-end "A_precondition_preContext-preContext" 
    :type |Operation| 
    :multiplicity (0 1) 
    :association "A_precondition_preContext" 
    :name "preContext")

(def-meta-assoc "A_raisedException_operation"      
  :name |A_raisedException_operation|      
  :metatype :association      
  :member-ends ((|Operation| "raisedException")
                ("A_raisedException_operation-operation" "operation"))      
  :owned-ends  (("A_raisedException_operation-operation" "operation")))

(def-meta-assoc-end "A_raisedException_operation-operation" 
    :type |Operation| 
    :multiplicity (0 -1) 
    :association "A_raisedException_operation" 
    :name "operation")

(def-meta-assoc "A_redefinedOperation_operation"      
  :name |A_redefinedOperation_operation|      
  :metatype :association      
  :member-ends ((|Operation| "redefinedOperation")
                ("A_redefinedOperation_operation-operation" "operation"))      
  :owned-ends  (("A_redefinedOperation_operation-operation" "operation")))

(def-meta-assoc-end "A_redefinedOperation_operation-operation" 
    :type |Operation| 
    :multiplicity (0 -1) 
    :association "A_redefinedOperation_operation" 
    :name "operation")

(def-meta-assoc "A_type_operation"      
  :name |A_type_operation|      
  :metatype :association      
  :member-ends ((|Operation| "type")
                ("A_type_operation-operation" "operation"))      
  :owned-ends  (("A_type_operation-operation" "operation")))

(def-meta-assoc-end "A_type_operation-operation" 
    :type |Operation| 
    :multiplicity (0 -1) 
    :association "A_type_operation" 
    :name "operation")

;;; =========================================================
;;; ====================== OperationTemplateParameter
;;; =========================================================
(def-meta-class |OperationTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |Classification|) 
    :xmi-id "OperationTemplateParameter")
 "An OperationTemplateParameter exposes an Operation as a formal parameter
  for a template."
  ((|parameteredElement| :xmi-id "OperationTemplateParameter-parameteredElement" :range |Operation| :multiplicity (1 1)
    :opposite (|Operation| |templateParameter|)
    :documentation
     "The Operation exposed by this OperationTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))

;;; =========================================================
;;; ====================== OutputPin
;;; =========================================================
(def-meta-class |OutputPin| 
   (:model :UML25 :superclasses (|Pin|) 
    :packages (UML |Actions|) 
    :xmi-id "OutputPin")
 "An OutputPin is a Pin that holds output values produced by an Action."
  ())

;;; =========================================================
;;; ====================== Package
;;; =========================================================
(def-meta-class |Package| 
   (:model :UML25 :superclasses (|PackageableElement| |TemplateableElement| |Namespace|) 
    :packages (UML |Packages|) 
    :xmi-id "Package")
 "A package can have one or more profile applications to indicate which profiles
  have been applied. Because a profile is a package, it is possible to apply
  a profile not only to packages, but also to profiles. Package specializes
  TemplateableElement and PackageableElement specializes ParameterableElement
  to specify that a package can be used as a template and a PackageableElement
  as a template parameter. A package is used to group elements, and provides
  a namespace for the grouped elements."
  ((URI :xmi-id "Package-URI" :range |String| :multiplicity (0 1)
    :documentation
     "Provides an identifier for the package that can be used for many purposes.
      A URI is the universally unique identification of the package following
      the IETF URI specification, RFC 2396 http://www.ietf.org/rfc/rfc2396.txt
      and it must comply with those syntax rules.")
   (|nestedPackage| :xmi-id "Package-nestedPackage" :range |Package| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Package| |nestingPackage|)
    :documentation
     "References the packaged elements that are Packages.")
   (|nestingPackage| :xmi-id "Package-nestingPackage" :range |Package| :multiplicity (0 1)
    :opposite (|Package| |nestedPackage|)
    :documentation
     "References the Package that owns this Package.")
   (|ownedStereotype| :xmi-id "Package-ownedStereotype" :range |Stereotype| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :documentation
     "References the Stereotypes that are owned by the Package.")
   (|ownedType| :xmi-id "Package-ownedType" :range |Type| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Type| |package|)
    :documentation
     "References the packaged elements that are Types.")
   (|packageMerge| :xmi-id "Package-packageMerge" :range |PackageMerge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageMerge| |receivingPackage|)
    :documentation
     "References the PackageMerges that are owned by this Package.")
   (|packagedElement| :xmi-id "Package-packagedElement" :range |PackageableElement| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the packageable elements that are owned by this Package.")
   (|profileApplication| :xmi-id "Package-profileApplication" :range |ProfileApplication| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ProfileApplication| |applyingPackage|)
    :documentation
     "References the ProfileApplications that indicate which profiles have been
      applied to the Package.")))

(def-meta-operation "allApplicableStereotypes" |Package| 
   "The query allApplicableStereotypes() returns all the directly or indirectly
    owned stereotypes, including stereotypes contained in sub-profiles."
   :operation-body
   "result = (let ownedPackages : Bag(Package) = ownedMember->select(oclIsKindOf(Package))->collect(oclAsType(Package)) in   ownedStereotype->union(ownedPackages.allApplicableStereotypes())->flatten()->asSet()  )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

;; POD
(def-meta-operation "containingProfile" |Package| 
   "The query containingProfile() returns the closest profile directly or indirectly
    containing this package (or this package itself, if it is a profile)."
   :operation-status :rewritten
   :editor-note "Call recursive on namespace (which may be a Profile) not on namepsace.oslAsType(Package). 
                 Requires change to the Profile method also."
   :operation-body    "if self.oclIsKindOf(Profile) 
                          then  self.oclAsType(Profile) 
                          else  self.namespace.containingProfile()  
                       endif"
   :original-body
   "result = (if self.oclIsKindOf(Profile) then  self.oclAsType(Profile)  else  self.namespace.oclAsType(Package).containingProfile()  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-meta-operation "makesVisible" |Package| 
   "The query makesVisible() defines whether a Package makes an element visible
    outside itself. Elements with no visibility and elements with public visibility
    are made visible."
   :operation-body
   "result = (ownedMember->includes(el) or (elementImport->select(ei|ei.importedElement = VisibilityKind::public)->collect(importedElement.oclAsType(NamedElement))->includes(el)) or (packageImport->select(visibility = VisibilityKind::public)->collect(importedPackage.member->includes(el))->notEmpty()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|el| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "mustBeOwned" |Package| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "nestedPackage.1" |Package| 
   "Derivation for Package::/nestedPackage"
   :operation-body
   "result = (packagedElement->select(oclIsKindOf(Package))->collect(oclAsType(Package))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-meta-operation "ownedStereotype.1" |Package| 
   "Derivation for Package::/ownedStereotype"
   :operation-body
   "result = (packagedElement->select(oclIsKindOf(Stereotype))->collect(oclAsType(Stereotype))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

(def-meta-operation "ownedType.1" |Package| 
   "Derivation for Package::/ownedType"
   :operation-body
   "result = (packagedElement->select(oclIsKindOf(Type))->collect(oclAsType(Type))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-operation "visibleMembers" |Package| 
   "The query visibleMembers() defines which members of a Package can be accessed
    outside it."
   :operation-body
   "result = (member->select( m | m.oclIsKindOf(PackageableElement) and self.makesVisible(m))->collect(oclAsType(PackageableElement))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

(def-meta-assoc "A_nestedPackage_nestingPackage"      
  :name |A_nestedPackage_nestingPackage|      
  :metatype :association      
  :member-ends ((|Package| "nestedPackage")
                (|Package| "nestingPackage"))      
  :owned-ends  ())

(def-meta-assoc "A_ownedStereotype_owningPackage"      
  :name |A_ownedStereotype_owningPackage|      
  :metatype :association      
  :member-ends ((|Package| "ownedStereotype")
                ("A_ownedStereotype_owningPackage-owningPackage" "owningPackage"))      
  :owned-ends  (("A_ownedStereotype_owningPackage-owningPackage" "owningPackage")))

(def-meta-assoc-end "A_ownedStereotype_owningPackage-owningPackage" 
    :type |Package| 
    :multiplicity (1 1) 
    :association "A_ownedStereotype_owningPackage" 
    :name "owningPackage")

(def-meta-assoc "A_ownedType_package"      
  :name |A_ownedType_package|      
  :metatype :association      
  :member-ends ((|Package| "ownedType")
                (|Type| "package"))      
  :owned-ends  ())

(def-meta-assoc "A_packageMerge_receivingPackage"      
  :name |A_packageMerge_receivingPackage|      
  :metatype :association      
  :member-ends ((|Package| "packageMerge")
                (|PackageMerge| "receivingPackage"))      
  :owned-ends  ())

(def-meta-assoc "A_packagedElement_owningPackage"      
  :name |A_packagedElement_owningPackage|      
  :metatype :association      
  :member-ends ((|Package| "packagedElement")
                ("A_packagedElement_owningPackage-owningPackage" "owningPackage"))      
  :owned-ends  (("A_packagedElement_owningPackage-owningPackage" "owningPackage")))

(def-meta-assoc-end "A_packagedElement_owningPackage-owningPackage" 
    :type |Package| 
    :multiplicity (0 1) 
    :association "A_packagedElement_owningPackage" 
    :name "owningPackage")

(def-meta-assoc "A_profileApplication_applyingPackage"      
  :name |A_profileApplication_applyingPackage|      
  :metatype :association      
  :member-ends ((|Package| "profileApplication")
                (|ProfileApplication| "applyingPackage"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== PackageImport
;;; =========================================================
(def-meta-class |PackageImport| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "PackageImport")
 "A PackageImport is a Relationship that imports all the non-private members
  of a Package into the Namespace owning the PackageImport, so that those
  Elements may be referred to by their unqualified names in the importingNamespace."
  ((|importedPackage| :xmi-id "PackageImport-importedPackage" :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the Package whose members are imported into a Namespace.")
   (|importingNamespace| :xmi-id "PackageImport-importingNamespace" :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |packageImport|)
    :documentation
     "Specifies the Namespace that imports the members from a Package.")
   (|visibility| :xmi-id "PackageImport-visibility" :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElements within the
      importingNamespace, i.e., whether imported Elements will in turn be visible
      to other Namespaces. If the PackageImport is public, the imported Elements
      will be visible outside the importingNamespace, while, if the PackageImport
      is private, they will not.")))

(def-meta-assoc "A_importedPackage_packageImport"      
  :name |A_importedPackage_packageImport|      
  :metatype :association      
  :member-ends ((|PackageImport| "importedPackage")
                ("A_importedPackage_packageImport-packageImport" "packageImport"))      
  :owned-ends  (("A_importedPackage_packageImport-packageImport" "packageImport")))

(def-meta-assoc-end "A_importedPackage_packageImport-packageImport" 
    :type |PackageImport| 
    :multiplicity (0 -1) 
    :association "A_importedPackage_packageImport" 
    :name "packageImport")

;;; =========================================================
;;; ====================== PackageMerge
;;; =========================================================
(def-meta-class |PackageMerge| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Packages|) 
    :xmi-id "PackageMerge")
 "A package merge defines how the contents of one package are extended by
  the contents of another package."
  ((|mergedPackage| :xmi-id "PackageMerge-mergedPackage" :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the Package that is to be merged with the receiving package
      of the PackageMerge.")
   (|receivingPackage| :xmi-id "PackageMerge-receivingPackage" :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Package| |packageMerge|)
    :documentation
     "References the Package that is being extended with the contents of the
      merged package of the PackageMerge.")))

(def-meta-assoc "A_mergedPackage_packageMerge"      
  :name |A_mergedPackage_packageMerge|      
  :metatype :association      
  :member-ends ((|PackageMerge| "mergedPackage")
                ("A_mergedPackage_packageMerge-packageMerge" "packageMerge"))      
  :owned-ends  (("A_mergedPackage_packageMerge-packageMerge" "packageMerge")))

(def-meta-assoc-end "A_mergedPackage_packageMerge-packageMerge" 
    :type |PackageMerge| 
    :multiplicity (0 -1) 
    :association "A_mergedPackage_packageMerge" 
    :name "packageMerge")

;;; =========================================================
;;; ====================== PackageableElement
;;; =========================================================
(def-meta-class |PackageableElement| 
   (:model :UML25 :superclasses (|ParameterableElement| |NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "PackageableElement")
 "A PackageableElement is a NamedElement that may be owned directly by a
  Package. A PackageableElement is also able to serve as the parameteredElement
  of a TemplateParameter."
  ((|visibility| :xmi-id "PackageableElement-visibility" :range |VisibilityKind| :multiplicity (0 1) :default :public
    :documentation
     "A PackageableElement must have a visibility specified if it is owned by
      a Namespace. The default visibility is public." :redefined-property (|NamedElement| |visibility|))))

;;; =========================================================
;;; ====================== Parameter
;;; =========================================================
(def-meta-class |Parameter| 
   (:model :UML25 :superclasses (|MultiplicityElement| |ConnectableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "Parameter")
 "A Parameter is a specification of an argument used to pass information
  into or out of an invocation of a BehavioralFeature.  Parameters can be
  treated as ConnectableElements within Collaborations."
  ((|default| :xmi-id "Parameter-default" :range |String| :multiplicity (0 1) :is-derived-p T
    :documentation
     "A String that represents a value to be used when no argument is supplied
      for the Parameter.")
   (|defaultValue| :xmi-id "Parameter-defaultValue" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies a ValueSpecification that represents a value to be used when
      no argument is supplied for the Parameter.")
   (|direction| :xmi-id "Parameter-direction" :range |ParameterDirectionKind| :multiplicity (1 1) :default :in
    :documentation
     "Indicates whether a parameter is being sent into or out of a behavioral
      element.")
   (|effect| :xmi-id "Parameter-effect" :range |ParameterEffectKind| :multiplicity (0 1)
    :documentation
     "Specifies the effect that executions of the owner of the Parameter have
      on objects passed in or out of the parameter.")
   (|isException| :xmi-id "Parameter-isException" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an output parameter may emit a value to the exclusion of
      the other outputs.")
   (|isStream| :xmi-id "Parameter-isStream" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an input parameter may accept values while its behavior is
      executing, or whether an output parameter may post values while the behavior
      is executing.")
   (|operation| :xmi-id "Parameter-operation" :range |Operation| :multiplicity (0 1)
    :opposite (|Operation| |ownedParameter|)
    :documentation
     "The Operation owning this parameter.")
   (|parameterSet| :xmi-id "Parameter-parameterSet" :range |ParameterSet| :multiplicity (0 -1)
    :opposite (|ParameterSet| |parameter|)
    :documentation
     "The ParameterSets containing the parameter. See ParameterSet.")))

(def-meta-operation "default.1" |Parameter| 
   "Derivation for Parameter::/default"
   :operation-body
   "result = (if self.type = String then defaultValue.stringValue() else null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-assoc "A_defaultValue_owningParameter"      
  :name |A_defaultValue_owningParameter|      
  :metatype :association      
  :member-ends ((|Parameter| "defaultValue")
                ("A_defaultValue_owningParameter-owningParameter" "owningParameter"))      
  :owned-ends  (("A_defaultValue_owningParameter-owningParameter" "owningParameter")))

(def-meta-assoc-end "A_defaultValue_owningParameter-owningParameter" 
    :type |Parameter| 
    :multiplicity (0 1) 
    :association "A_defaultValue_owningParameter" 
    :name "owningParameter")

(def-meta-assoc "A_parameterSet_parameter"      
  :name |A_parameterSet_parameter|      
  :metatype :association      
  :member-ends ((|Parameter| "parameterSet")
                (|ParameterSet| "parameter"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ParameterSet
;;; =========================================================
(def-meta-class |ParameterSet| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Classification|) 
    :xmi-id "ParameterSet")
 "A ParameterSet designates alternative sets of inputs or outputs that a
  Behavior may use."
  ((|condition| :xmi-id "ParameterSet-condition" :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A constraint that should be satisfied for the owner of the Parameters in
      an input ParameterSet to start execution using the values provided for
      those Parameters, or the owner of the Parameters in an output ParameterSet
      to end execution providing the values for those Parameters, if all preconditions
      and conditions on input ParameterSets were satisfied.")
   (|parameter| :xmi-id "ParameterSet-parameter" :range |Parameter| :multiplicity (1 -1)
    :opposite (|Parameter| |parameterSet|)
    :documentation
     "Parameters in the ParameterSet.")))

(def-meta-assoc "A_condition_parameterSet"      
  :name |A_condition_parameterSet|      
  :metatype :association      
  :member-ends ((|ParameterSet| "condition")
                ("A_condition_parameterSet-parameterSet" "parameterSet"))      
  :owned-ends  (("A_condition_parameterSet-parameterSet" "parameterSet")))

(def-meta-assoc-end "A_condition_parameterSet-parameterSet" 
    :type |ParameterSet| 
    :multiplicity (0 1) 
    :association "A_condition_parameterSet" 
    :name "parameterSet")

;;; =========================================================
;;; ====================== ParameterableElement
;;; =========================================================
(def-meta-class |ParameterableElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "ParameterableElement")
 "A ParameterableElement is an Element that can be exposed as a formal TemplateParameter
  for a template, or specified as an actual parameter in a binding of a template."
  ((|owningTemplateParameter| :xmi-id "ParameterableElement-owningTemplateParameter" :range |TemplateParameter| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|) (|ParameterableElement| |templateParameter|))
    :opposite (|TemplateParameter| |ownedParameteredElement|)
    :documentation
     "The formal TemplateParameter that owns this ParameterableElement.")
   (|templateParameter| :xmi-id "ParameterableElement-templateParameter" :range |TemplateParameter| :multiplicity (0 1)
    :opposite (|TemplateParameter| |parameteredElement|)
    :documentation
     "The TemplateParameter that exposes this ParameterableElement as a formal
      parameter.")))

(def-meta-operation "isCompatibleWith" |ParameterableElement| 
   "The query isCompatibleWith() determines if this ParameterableElement is
    compatible with the specified ParameterableElement. By default, this ParameterableElement
    is compatible with another ParameterableElement p if the kind of this ParameterableElement
    is the same as or a subtype of the kind of p. Subclasses of ParameterableElement
    should override this operation to specify different compatibility constraints."
   :operation-body
   "result = (self.oclIsKindOf(p.oclType()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isTemplateParameter" |ParameterableElement| 
   "The query isTemplateParameter() determines if this ParameterableElement
    is exposed as a formal TemplateParameter."
   :operation-body
   "result = (templateParameter->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== PartDecomposition
;;; =========================================================
(def-meta-class |PartDecomposition| 
   (:model :UML25 :superclasses (|InteractionUse|) 
    :packages (UML |Interactions|) 
    :xmi-id "PartDecomposition")
 "A PartDecomposition is a description of the internal Interactions of one
  Lifeline relative to an Interaction."
  ())

;;; =========================================================
;;; ====================== Pin
;;; =========================================================
(def-meta-class |Pin| 
   (:model :UML25 :superclasses (|ObjectNode| |MultiplicityElement|) 
    :packages (UML |Actions|) 
    :xmi-id "Pin")
 "A Pin is an ObjectNode and MultiplicityElement that provides input values
  to an Action or accepts output values from an Action."
  ((|isControl| :xmi-id "Pin-isControl" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the Pin provides data to the Action or just controls
      how the Action executes.")))

;;; =========================================================
;;; ====================== Port
;;; =========================================================
(def-meta-class |Port| 
   (:model :UML25 :superclasses (|Property|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "Port")
 "A Port is a property of an EncapsulatedClassifier that specifies a distinct
  interaction point between that EncapsulatedClassifier and its environment
  or between the (behavior of the) EncapsulatedClassifier and its internal
  parts. Ports are connected to Properties of the EncapsulatedClassifier
  by Connectors through which requests can be made to invoke BehavioralFeatures.
  A Port may specify the services an EncapsulatedClassifier provides (offers)
  to its environment as well as the services that an EncapsulatedClassifier
  expects (requires) of its environment.  A Port may have an associated ProtocolStateMachine."
  ((|isBehavior| :xmi-id "Port-isBehavior" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether requests arriving at this Port are sent to the classifier
      behavior of this EncapsulatedClassifier. Such a Port is referred to as
      a behavior Port. Any invocation of a BehavioralFeature targeted at a behavior
      Port will be handled by the instance of the owning EncapsulatedClassifier
      itself, rather than by any instances that it may contain.")
   (|isConjugated| :xmi-id "Port-isConjugated" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies the way that the provided and required Interfaces are derived
      from the Port   s Type.")
   (|isService| :xmi-id "Port-isService" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, indicates that this Port is used to provide the published functionality
      of an EncapsulatedClassifier.  If false, this Port is used to implement
      the EncapsulatedClassifier but is not part of the essential externally-visible
      functionality of the EncapsulatedClassifier and can, therefore, be altered
      or deleted along with the internal implementation of the EncapsulatedClassifier
      and other properties that are considered part of its implementation.")
   (|protocol| :xmi-id "Port-protocol" :range |ProtocolStateMachine| :multiplicity (0 1)
    :documentation
     "An optional ProtocolStateMachine which describes valid interactions at
      this interaction point.")
   (|provided| :xmi-id "Port-provided" :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The Interfaces specifying the set of Operations and Receptions that the
      EncapsulatedCclassifier offers to its environment via this Port, and which
      it will handle either directly or by forwarding it to a part of its internal
      structure. This association is derived according to the value of isConjugated.
      If isConjugated is false, provided is derived as the union of the sets
      of Interfaces realized by the type of the port and its supertypes, or directly
      from the type of the Port if the Port is typed by an Interface. If isConjugated
      is true, it is derived as the union of the sets of Interfaces used by the
      type of the Port and its supertypes.")
   (|redefinedPort| :xmi-id "Port-redefinedPort" :range |Port| :multiplicity (0 -1)
    :subsetted-properties ((|Property| |redefinedProperty|))
    :documentation
     "A Port may be redefined when its containing EncapsulatedClassifier is specialized.
      The redefining Port may have additional Interfaces to those that are associated
      with the redefined Port or it may replace an Interface by one of its subtypes.")
   (|required| :xmi-id "Port-required" :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The Interfaces specifying the set of Operations and Receptions that the
      EncapsulatedCassifier expects its environment to handle via this port.
      This association is derived according to the value of isConjugated. If
      isConjugated is false, required is derived as the union of the sets of
      Interfaces used by the type of the Port and its supertypes. If isConjugated
      is true, it is derived as the union of the sets of Interfaces realized
      by the type of the Port and its supertypes, or directly from the type of
      the Port if the Port is typed by an Interface.")))

(def-meta-operation "basicProvided" |Port| 
   "The union of the sets of Interfaces realized by the type of the Port and
    its supertypes, or directly the type of the Port if the Port is typed by
    an Interface."
   :operation-body
   "result = (if type.oclIsKindOf(Interface)   then type.oclAsType(Interface)->asSet()   else type.oclAsType(Classifier).allRealizedInterfaces()   endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "basicRequired" |Port| 
   "The union of the sets of Interfaces used by the type of the Port and its
    supertypes."
   :operation-body
   "result = ( type.oclAsType(Classifier).allUsedInterfaces() )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "provided.1" |Port| 
   "Derivation for Port::/provided"
   :operation-body
   "result = (if isConjugated then basicRequired() else basicProvided() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "required.1" |Port| 
   "Derivation for Port::/required"
   :operation-body
   "result = (if isConjugated then basicProvided() else basicRequired() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-assoc "A_protocol_port"      
  :name |A_protocol_port|      
  :metatype :association      
  :member-ends ((|Port| "protocol")
                ("A_protocol_port-port" "port"))      
  :owned-ends  (("A_protocol_port-port" "port")))

(def-meta-assoc-end "A_protocol_port-port" 
    :type |Port| 
    :multiplicity (0 -1) 
    :association "A_protocol_port" 
    :name "port")

(def-meta-assoc "A_provided_port"      
  :name |A_provided_port|      
  :metatype :association      
  :member-ends ((|Port| "provided")
                ("A_provided_port-port" "port"))      
  :owned-ends  (("A_provided_port-port" "port")))

(def-meta-assoc-end "A_provided_port-port" 
    :type |Port| 
    :multiplicity (0 -1) 
    :association "A_provided_port" 
    :name "port")

(def-meta-assoc "A_redefinedPort_port"      
  :name |A_redefinedPort_port|      
  :metatype :association      
  :member-ends ((|Port| "redefinedPort")
                ("A_redefinedPort_port-port" "port"))      
  :owned-ends  (("A_redefinedPort_port-port" "port")))

(def-meta-assoc-end "A_redefinedPort_port-port" 
    :type |Port| 
    :multiplicity (0 -1) 
    :association "A_redefinedPort_port" 
    :name "port")

(def-meta-assoc "A_required_port"      
  :name |A_required_port|      
  :metatype :association      
  :member-ends ((|Port| "required")
                ("A_required_port-port" "port"))      
  :owned-ends  (("A_required_port-port" "port")))

(def-meta-assoc-end "A_required_port-port" 
    :type |Port| 
    :multiplicity (0 -1) 
    :association "A_required_port" 
    :name "port")

;;; =========================================================
;;; ====================== PrimitiveType
;;; =========================================================
(def-meta-class |PrimitiveType| 
   (:model :UML25 :superclasses (|DataType|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "PrimitiveType")
 "A PrimitiveType defines a predefined DataType, without any substructure.
  A PrimitiveType may have an algebra and operations defined outside of UML,
  for example, mathematically."
  ())

;;; =========================================================
;;; ====================== Profile
;;; =========================================================
(def-meta-class |Profile| 
   (:model :UML25 :superclasses (|Package|) 
    :packages (UML |Packages|) 
    :xmi-id "Profile")
 "A profile defines limited extensions to a reference metamodel with the
  purpose of adapting the metamodel to a specific platform or domain."
  ((|metaclassReference| :xmi-id "Profile-metaclassReference" :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |elementImport|))
    :documentation
     "References a metaclass that may be extended.")
   (|metamodelReference| :xmi-id "Profile-metamodelReference" :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |packageImport|))
    :documentation
     "References a package containing (directly or indirectly) metaclasses that
      may be extended.")))

(def-meta-assoc "A_metaclassReference_profile"      
  :name |A_metaclassReference_profile|      
  :metatype :association      
  :member-ends ((|Profile| "metaclassReference")
                ("A_metaclassReference_profile-profile" "profile"))      
  :owned-ends  (("A_metaclassReference_profile-profile" "profile")))

(def-meta-assoc-end "A_metaclassReference_profile-profile" 
    :type |Profile| 
    :multiplicity (0 1) 
    :association "A_metaclassReference_profile" 
    :name "profile")

(def-meta-assoc "A_metamodelReference_profile"      
  :name |A_metamodelReference_profile|      
  :metatype :association      
  :member-ends ((|Profile| "metamodelReference")
                ("A_metamodelReference_profile-profile" "profile"))      
  :owned-ends  (("A_metamodelReference_profile-profile" "profile")))

(def-meta-assoc-end "A_metamodelReference_profile-profile" 
    :type |Profile| 
    :multiplicity (0 1) 
    :association "A_metamodelReference_profile" 
    :name "profile")

;;; =========================================================
;;; ====================== ProfileApplication
;;; =========================================================
(def-meta-class |ProfileApplication| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Packages|) 
    :xmi-id "ProfileApplication")
 "A profile application is used to show which profiles have been applied
  to a package."
  ((|appliedProfile| :xmi-id "ProfileApplication-appliedProfile" :range |Profile| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the Profiles that are applied to a Package through this ProfileApplication.")
   (|applyingPackage| :xmi-id "ProfileApplication-applyingPackage" :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Package| |profileApplication|)
    :documentation
     "The package that owns the profile application.")
   (|isStrict| :xmi-id "ProfileApplication-isStrict" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies that the Profile filtering rules for the metaclasses of the referenced
      metamodel shall be strictly applied.")))

(def-meta-assoc "A_appliedProfile_profileApplication"      
  :name |A_appliedProfile_profileApplication|      
  :metatype :association      
  :member-ends ((|ProfileApplication| "appliedProfile")
                ("A_appliedProfile_profileApplication-profileApplication" "profileApplication"))      
  :owned-ends  (("A_appliedProfile_profileApplication-profileApplication" "profileApplication")))

(def-meta-assoc-end "A_appliedProfile_profileApplication-profileApplication" 
    :type |ProfileApplication| 
    :multiplicity (0 -1) 
    :association "A_appliedProfile_profileApplication" 
    :name "profileApplication")

;;; =========================================================
;;; ====================== Property
;;; =========================================================
(def-meta-class |Property| 
   (:model :UML25 :superclasses (|ConnectableElement| |DeploymentTarget| |StructuralFeature|) 
    :packages (UML |Classification|) 
    :xmi-id "Property")
 "A Property is a StructuralFeature. A Property related by ownedAttribute
  to a Classifier (other than an association) represents an attribute and
  might also represent an association end. It relates an instance of the
  Classifier to a value or set of values of the type of the attribute. A
  Property related by memberEnd to an Association represents an end of the
  Association. The type of the Property is the type of the end of the Association.
  A Property has the capability of being a DeploymentTarget in a Deployment
  relationship. This enables modeling the deployment to hierarchical nodes
  that have Properties functioning as internal parts.  Property specializes
  ParameterableElement to specify that a Property can be exposed as a formal
  template parameter, and provided as an actual parameter in a binding of
  a template."
  ((|aggregation| :xmi-id "Property-aggregation" :range |AggregationKind| :multiplicity (1 1) :default :none
    :documentation
     "Specifies the kind of aggregation that applies to the Property.")
   (|association| :xmi-id "Property-association" :range |Association| :multiplicity (0 1)
    :opposite (|Association| |memberEnd|)
    :documentation
     "The Association of which this Property is a member, if any.")
   (|associationEnd| :xmi-id "Property-associationEnd" :range |Property| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Property| |qualifier|)
    :documentation
     "Designates the optional association end that owns a qualifier attribute.")
   (|class| :xmi-id "Property-class" :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Class| |ownedAttribute|)
    :documentation
     "The Class that owns this Property, if any.")
   (|datatype| :xmi-id "Property-datatype" :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|DataType| |ownedAttribute|)
    :documentation
     "The DataType that owns this Property, if any.")
   (|defaultValue| :xmi-id "Property-defaultValue" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification that is evaluated to give a default value for the
      Property when an instance of the owning Classifier is instantiated.")
   (|interface| :xmi-id "Property-interface" :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interface| |ownedAttribute|)
    :documentation
     "The Interface that owns this Property, if any.")
   (|isComposite| :xmi-id "Property-isComposite" :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "If isComposite is true, the object containing the attribute is a container
      for the object or value contained in the attribute. This is a derived value,
      indicating whether the aggregation of the Property is composite or not.")
   (|isDerived| :xmi-id "Property-isDerived" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the Property is derived, i.e., whether its value or values
      can be computed from other information.")
   (|isDerivedUnion| :xmi-id "Property-isDerivedUnion" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the property is derived as the union of all of the Properties
      that are constrained to subset it.")
   (|isID| :xmi-id "Property-isID" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True indicates this property can be used to uniquely identify an instance
      of the containing Class.")
   (|opposite| :xmi-id "Property-opposite" :range |Property| :multiplicity (0 1) :is-derived-p T
    :documentation
     "In the case where the Property is one end of a binary association this
      gives the other end.")
   (|owningAssociation| :xmi-id "Property-owningAssociation" :range |Association| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|Property| |association|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Association| |ownedEnd|)
    :documentation
     "The owning association of this property, if any.")
   (|qualifier| :xmi-id "Property-qualifier" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Property| |associationEnd|)
    :documentation
     "An optional list of ordered qualifier attributes for the end.")
   (|redefinedProperty| :xmi-id "Property-redefinedProperty" :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The properties that are redefined by this property, if any.")
   (|subsettedProperty| :xmi-id "Property-subsettedProperty" :range |Property| :multiplicity (0 -1)
    :documentation
     "The properties of which this Property is constrained to be a subset, if
      any.")))

(def-meta-operation "isAttribute" |Property| 
   "The query isAttribute() is true if the Property is defined as an attribute
    of some Classifier."
   :operation-body
   "result = (not classifier->isEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isCompatibleWith" |Property| 
   "The query isCompatibleWith() determines if this Property is compatible
    with the specified ParameterableElement. This Property is compatible with
    ParameterableElement p if the kind of this Property is thesame as or a
    subtype of the kind of p. Further, if p is a TypedElement, then the type
    of this Property must be conformant with the type of p."
   :operation-body
   "result = (self.oclIsKindOf(p.oclType()) and (p.oclIsKindOf(TypeElement) implies  self.type.conformsTo(p.oclAsType(TypedElement).type)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isComposite.1" |Property| 
   "The value of isComposite is true only if aggregation is composite."
   :operation-body
   "result = (aggregation = AggregationKind::composite)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Property| 
   "The query isConsistentWith() specifies, for any two Properties in a context
    in which redefinition is possible, whether redefinition would be logically
    consistent. A redefining Property is consistent with a redefined Property
    if the type of the redefining Property conforms to the type of the redefined
    Property, and the multiplicity of the redefining Property (if specified)
    is contained in the multiplicity of the redefined Property."
   :operation-body
   "result = (redefiningElement.oclIsKindOf(Property) and    let prop : Property = redefiningElement.oclAsType(Property) in    (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and    ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and    (self.isComposite implies prop.isComposite)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isNavigable" |Property| 
   "The query isNavigable() indicates whether it is possible to navigate across
    the property."
   :operation-body
   "result = (not classifier->isEmpty() or association.navigableOwnedEnd->includes(self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "opposite.1" |Property| 
   "If this property is a memberEnd of a binary association, then opposite
    gives the other end."
   :operation-body
   "result = (if association <> null and association.memberEnd->size() = 2 then     association.memberEnd->any(e | e <> self) else     null endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-operation "subsettingContext" |Property| 
   "The query subsettingContext() gives the context for subsetting a Property.
    It consists, in the case of an attribute, of the corresponding Classifier,
    and in the case of an association end, all of the Classifiers at the other
    ends."
   :operation-body
   "result = (if association <> null then association.memberEnd->excluding(self)->collect(type)->asSet() else    if classifier<>null   then classifier->asSet()   else Set{}    endif endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-assoc "A_defaultValue_owningProperty"      
  :name |A_defaultValue_owningProperty|      
  :metatype :association      
  :member-ends ((|Property| "defaultValue")
                ("A_defaultValue_owningProperty-owningProperty" "owningProperty"))      
  :owned-ends  (("A_defaultValue_owningProperty-owningProperty" "owningProperty")))

(def-meta-assoc-end "A_defaultValue_owningProperty-owningProperty" 
    :type |Property| 
    :multiplicity (0 1) 
    :association "A_defaultValue_owningProperty" 
    :name "owningProperty")

(def-meta-assoc "A_opposite_property"      
  :name |A_opposite_property|      
  :metatype :association      
  :member-ends ((|Property| "opposite")
                ("A_opposite_property-property" "property"))      
  :owned-ends  (("A_opposite_property-property" "property")))

(def-meta-assoc-end "A_opposite_property-property" 
    :type |Property| 
    :multiplicity (0 1) 
    :association "A_opposite_property" 
    :name "property")

(def-meta-assoc "A_qualifier_associationEnd"      
  :name |A_qualifier_associationEnd|      
  :metatype :association      
  :member-ends ((|Property| "qualifier")
                (|Property| "associationEnd"))      
  :owned-ends  ())

(def-meta-assoc "A_redefinedProperty_property"      
  :name |A_redefinedProperty_property|      
  :metatype :association      
  :member-ends ((|Property| "redefinedProperty")
                ("A_redefinedProperty_property-property" "property"))      
  :owned-ends  (("A_redefinedProperty_property-property" "property")))

(def-meta-assoc-end "A_redefinedProperty_property-property" 
    :type |Property| 
    :multiplicity (0 -1) 
    :association "A_redefinedProperty_property" 
    :name "property")

(def-meta-assoc "A_subsettedProperty_property"      
  :name |A_subsettedProperty_property|      
  :metatype :association      
  :member-ends ((|Property| "subsettedProperty")
                ("A_subsettedProperty_property-property" "property"))      
  :owned-ends  (("A_subsettedProperty_property-property" "property")))

(def-meta-assoc-end "A_subsettedProperty_property-property" 
    :type |Property| 
    :multiplicity (0 -1) 
    :association "A_subsettedProperty_property" 
    :name "property")

;;; =========================================================
;;; ====================== ProtocolConformance
;;; =========================================================
(def-meta-class |ProtocolConformance| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |StateMachines|) 
    :xmi-id "ProtocolConformance")
 "A ProtocolStateMachine can be redefined into a more specific ProtocolStateMachine
  or into behavioral StateMachine. ProtocolConformance declares that the
  specific ProtocolStateMachine specifies a protocol that conforms to the
  general ProtocolStateMachine or that the specific behavioral StateMachine
  abides by the protocol of the general ProtocolStateMachine."
  ((|generalMachine| :xmi-id "ProtocolConformance-generalMachine" :range |ProtocolStateMachine| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the ProtocolStateMachine to which the specific ProtocolStateMachine
      conforms.")
   (|specificMachine| :xmi-id "ProtocolConformance-specificMachine" :range |ProtocolStateMachine| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|ProtocolStateMachine| |conformance|)
    :documentation
     "Specifies the ProtocolStateMachine which conforms to the general ProtocolStateMachine.")))

(def-meta-assoc "A_generalMachine_protocolConformance"      
  :name |A_generalMachine_protocolConformance|      
  :metatype :association      
  :member-ends ((|ProtocolConformance| "generalMachine")
                ("A_generalMachine_protocolConformance-protocolConformance" "protocolConformance"))      
  :owned-ends  (("A_generalMachine_protocolConformance-protocolConformance" "protocolConformance")))

(def-meta-assoc-end "A_generalMachine_protocolConformance-protocolConformance" 
    :type |ProtocolConformance| 
    :multiplicity (0 -1) 
    :association "A_generalMachine_protocolConformance" 
    :name "protocolConformance")

;;; =========================================================
;;; ====================== ProtocolStateMachine
;;; =========================================================
(def-meta-class |ProtocolStateMachine| 
   (:model :UML25 :superclasses (|StateMachine|) 
    :packages (UML |StateMachines|) 
    :xmi-id "ProtocolStateMachine")
 "A ProtocolStateMachine is always defined in the context of a Classifier.
  It specifies which BehavioralFeatures of the Classifier can be called in
  which State and under which conditions, thus specifying the allowed invocation
  sequences on the Classifier's BehavioralFeatures. A ProtocolStateMachine
  specifies the possible and permitted Transitions on the instances of its
  context Classifier, together with the BehavioralFeatures that carry the
  Transitions. In this manner, an instance lifecycle can be specified for
  a Classifier, by defining the order in which the BehavioralFeatures can
  be activated and the States through which an instance progresses during
  its existence."
  ((|conformance| :xmi-id "ProtocolStateMachine-conformance" :range |ProtocolConformance| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ProtocolConformance| |specificMachine|)
    :documentation
     "Conformance between ProtocolStateMachine")))

(def-meta-assoc "A_conformance_specificMachine"      
  :name |A_conformance_specificMachine|      
  :metatype :association      
  :member-ends ((|ProtocolStateMachine| "conformance")
                (|ProtocolConformance| "specificMachine"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ProtocolTransition
;;; =========================================================
(def-meta-class |ProtocolTransition| 
   (:model :UML25 :superclasses (|Transition|) 
    :packages (UML |StateMachines|) 
    :xmi-id "ProtocolTransition")
 "A ProtocolTransition specifies a legal Transition for an Operation. Transitions
  of ProtocolStateMachines have the following information: a pre-condition
  (guard), a Trigger, and a post-condition. Every ProtocolTransition is associated
  with at most one BehavioralFeature belonging to the context Classifier
  of the ProtocolStateMachine."
  ((|postCondition| :xmi-id "ProtocolTransition-postCondition" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "Specifies the post condition of the Transition which is the Condition that
      should be obtained once the Transition is triggered. This post condition
      is part of the post condition of the Operation connected to the Transition.")
   (|preCondition| :xmi-id "ProtocolTransition-preCondition" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Transition| |guard|))
    :documentation
     "Specifies the precondition of the Transition. It specifies the Condition
      that should be verified before triggering the Transition. This guard condition
      added to the source State will be evaluated as part of the precondition
      of the Operation referred by the Transition if any.")
   (|referred| :xmi-id "ProtocolTransition-referred" :range |Operation| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "This association refers to the associated Operation. It is derived from
      the Operation of the CallEvent Trigger when applicable.")))

(def-meta-operation "referred.1" |ProtocolTransition| 
   "Derivation for ProtocolTransition::/referred"
   :operation-body
   "result = (trigger->collect(event)->select(oclIsKindOf(CallEvent))->collect(oclAsType(CallEvent).operation)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Operation|
                        :parameter-return-p T))
)

(def-meta-assoc "A_postCondition_owningTransition"      
  :name |A_postCondition_owningTransition|      
  :metatype :association      
  :member-ends ((|ProtocolTransition| "postCondition")
                ("A_postCondition_owningTransition-owningTransition" "owningTransition"))      
  :owned-ends  (("A_postCondition_owningTransition-owningTransition" "owningTransition")))

(def-meta-assoc-end "A_postCondition_owningTransition-owningTransition" 
    :type |ProtocolTransition| 
    :multiplicity (0 1) 
    :association "A_postCondition_owningTransition" 
    :name "owningTransition")

(def-meta-assoc "A_preCondition_protocolTransition"      
  :name |A_preCondition_protocolTransition|      
  :metatype :association      
  :member-ends ((|ProtocolTransition| "preCondition")
                ("A_preCondition_protocolTransition-protocolTransition" "protocolTransition"))      
  :owned-ends  (("A_preCondition_protocolTransition-protocolTransition" "protocolTransition")))

(def-meta-assoc-end "A_preCondition_protocolTransition-protocolTransition" 
    :type |ProtocolTransition| 
    :multiplicity (0 1) 
    :association "A_preCondition_protocolTransition" 
    :name "protocolTransition")

(def-meta-assoc "A_referred_protocolTransition"      
  :name |A_referred_protocolTransition|      
  :metatype :association      
  :member-ends ((|ProtocolTransition| "referred")
                ("A_referred_protocolTransition-protocolTransition" "protocolTransition"))      
  :owned-ends  (("A_referred_protocolTransition-protocolTransition" "protocolTransition")))

(def-meta-assoc-end "A_referred_protocolTransition-protocolTransition" 
    :type |ProtocolTransition| 
    :multiplicity (0 -1) 
    :association "A_referred_protocolTransition" 
    :name "protocolTransition")

;;; =========================================================
;;; ====================== Pseudostate
;;; =========================================================
(def-meta-class |Pseudostate| 
   (:model :UML25 :superclasses (|Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "Pseudostate")
 "A Pseudostate is an abstraction that encompasses different types of transient
  Vertices in the StateMachine graph. A StateMachine instance never comes
  to rest in a Pseudostate, instead, it will exit and enter the Pseudostate
  within a single run-to-completion step."
  ((|kind| :xmi-id "Pseudostate-kind" :range |PseudostateKind| :multiplicity (1 1) :default :initial
    :documentation
     "Determines the precise type of the Pseudostate and can be one of: entryPoint,
      exitPoint, initial, deepHistory, shallowHistory, join, fork, junction,
      terminate or choice.")
   (|state| :xmi-id "Pseudostate-state" :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |connectionPoint|)
    :documentation
     "The State that owns this Pseudostate and in which it appears.")
   (|stateMachine| :xmi-id "Pseudostate-stateMachine" :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |connectionPoint|)
    :documentation
     "The StateMachine in which this Pseudostate is defined. This only applies
      to Pseudostates of the kind entryPoint or exitPoint.")))

;;; =========================================================
;;; ====================== QualifierValue
;;; =========================================================
(def-meta-class |QualifierValue| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "QualifierValue")
 "A QualifierValue is an Element that is used as part of LinkEndData to provide
  the value for a single qualifier of the end given by the LinkEndData."
  ((|qualifier| :xmi-id "QualifierValue-qualifier" :range |Property| :multiplicity (1 1)
    :documentation
     "The qualifier Property for which the value is to be specified.")
   (|value| :xmi-id "QualifierValue-value" :range |InputPin| :multiplicity (1 1)
    :documentation
     "The InputPin from which the specified value for the qualifier is taken.")))

(def-meta-assoc "A_qualifier_qualifierValue"      
  :name |A_qualifier_qualifierValue|      
  :metatype :association      
  :member-ends ((|QualifierValue| "qualifier")
                ("A_qualifier_qualifierValue-qualifierValue" "qualifierValue"))      
  :owned-ends  (("A_qualifier_qualifierValue-qualifierValue" "qualifierValue")))

(def-meta-assoc-end "A_qualifier_qualifierValue-qualifierValue" 
    :type |QualifierValue| 
    :multiplicity (0 -1) 
    :association "A_qualifier_qualifierValue" 
    :name "qualifierValue")

(def-meta-assoc "A_value_qualifierValue"      
  :name |A_value_qualifierValue|      
  :metatype :association      
  :member-ends ((|QualifierValue| "value")
                ("A_value_qualifierValue-qualifierValue" "qualifierValue"))      
  :owned-ends  (("A_value_qualifierValue-qualifierValue" "qualifierValue")))

(def-meta-assoc-end "A_value_qualifierValue-qualifierValue" 
    :type |QualifierValue| 
    :multiplicity (0 1) 
    :association "A_value_qualifierValue" 
    :name "qualifierValue")

;;; =========================================================
;;; ====================== RaiseExceptionAction
;;; =========================================================
(def-meta-class |RaiseExceptionAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "RaiseExceptionAction")
 "A RaiseExceptionAction is an Action that causes an exception to occur.
  The input value becomes the exception object."
  ((|exception| :xmi-id "RaiseExceptionAction-exception" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An InputPin whose value becomes the exception object.")))

(def-meta-assoc "A_exception_raiseExceptionAction"      
  :name |A_exception_raiseExceptionAction|      
  :metatype :association      
  :member-ends ((|RaiseExceptionAction| "exception")
                ("A_exception_raiseExceptionAction-raiseExceptionAction" "raiseExceptionAction"))      
  :owned-ends  (("A_exception_raiseExceptionAction-raiseExceptionAction" "raiseExceptionAction")))

(def-meta-assoc-end "A_exception_raiseExceptionAction-raiseExceptionAction" 
    :type |RaiseExceptionAction| 
    :multiplicity (0 1) 
    :association "A_exception_raiseExceptionAction" 
    :name "raiseExceptionAction")

;;; =========================================================
;;; ====================== ReadExtentAction
;;; =========================================================
(def-meta-class |ReadExtentAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadExtentAction")
 "A ReadExtentAction is an Action that retrieves the current instances of
  a Classifier."
  ((|classifier| :xmi-id "ReadExtentAction-classifier" :range |Classifier| :multiplicity (1 1)
    :documentation
     "The Classifier whose instances are to be retrieved.")
   (|result| :xmi-id "ReadExtentAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the Classifier instances are placed.")))

(def-meta-assoc "A_classifier_readExtentAction"      
  :name |A_classifier_readExtentAction|      
  :metatype :association      
  :member-ends ((|ReadExtentAction| "classifier")
                ("A_classifier_readExtentAction-readExtentAction" "readExtentAction"))      
  :owned-ends  (("A_classifier_readExtentAction-readExtentAction" "readExtentAction")))

(def-meta-assoc-end "A_classifier_readExtentAction-readExtentAction" 
    :type |ReadExtentAction| 
    :multiplicity (0 1) 
    :association "A_classifier_readExtentAction" 
    :name "readExtentAction")

(def-meta-assoc "A_result_readExtentAction"      
  :name |A_result_readExtentAction|      
  :metatype :association      
  :member-ends ((|ReadExtentAction| "result")
                ("A_result_readExtentAction-readExtentAction" "readExtentAction"))      
  :owned-ends  (("A_result_readExtentAction-readExtentAction" "readExtentAction")))

(def-meta-assoc-end "A_result_readExtentAction-readExtentAction" 
    :type |ReadExtentAction| 
    :multiplicity (0 1) 
    :association "A_result_readExtentAction" 
    :name "readExtentAction")

;;; =========================================================
;;; ====================== ReadIsClassifiedObjectAction
;;; =========================================================
(def-meta-class |ReadIsClassifiedObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadIsClassifiedObjectAction")
 "A ReadIsClassifiedObjectAction is an Action that determines whether an
  object is classified by a given Classifier."
  ((|classifier| :xmi-id "ReadIsClassifiedObjectAction-classifier" :range |Classifier| :multiplicity (1 1)
    :documentation
     "The Classifier against which the classification of the input object is
      tested.")
   (|isDirect| :xmi-id "ReadIsClassifiedObjectAction-isDirect" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the input object must be directly classified by the given
      Classifier or whether it may also be an instance of a specialization of
      the given Classifier.")
   (|object| :xmi-id "ReadIsClassifiedObjectAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that holds the object whose classification is to be tested.")
   (|result| :xmi-id "ReadIsClassifiedObjectAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin that holds the Boolean result of the test.")))

(def-meta-assoc "A_classifier_readIsClassifiedObjectAction"      
  :name |A_classifier_readIsClassifiedObjectAction|      
  :metatype :association      
  :member-ends ((|ReadIsClassifiedObjectAction| "classifier")
                ("A_classifier_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction"))      
  :owned-ends  (("A_classifier_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction")))

(def-meta-assoc-end "A_classifier_readIsClassifiedObjectAction-readIsClassifiedObjectAction" 
    :type |ReadIsClassifiedObjectAction| 
    :multiplicity (0 -1) 
    :association "A_classifier_readIsClassifiedObjectAction" 
    :name "readIsClassifiedObjectAction")

(def-meta-assoc "A_object_readIsClassifiedObjectAction"      
  :name |A_object_readIsClassifiedObjectAction|      
  :metatype :association      
  :member-ends ((|ReadIsClassifiedObjectAction| "object")
                ("A_object_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction"))      
  :owned-ends  (("A_object_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction")))

(def-meta-assoc-end "A_object_readIsClassifiedObjectAction-readIsClassifiedObjectAction" 
    :type |ReadIsClassifiedObjectAction| 
    :multiplicity (0 1) 
    :association "A_object_readIsClassifiedObjectAction" 
    :name "readIsClassifiedObjectAction")

(def-meta-assoc "A_result_readIsClassifiedObjectAction"      
  :name |A_result_readIsClassifiedObjectAction|      
  :metatype :association      
  :member-ends ((|ReadIsClassifiedObjectAction| "result")
                ("A_result_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction"))      
  :owned-ends  (("A_result_readIsClassifiedObjectAction-readIsClassifiedObjectAction" "readIsClassifiedObjectAction")))

(def-meta-assoc-end "A_result_readIsClassifiedObjectAction-readIsClassifiedObjectAction" 
    :type |ReadIsClassifiedObjectAction| 
    :multiplicity (0 1) 
    :association "A_result_readIsClassifiedObjectAction" 
    :name "readIsClassifiedObjectAction")

;;; =========================================================
;;; ====================== ReadLinkAction
;;; =========================================================
(def-meta-class |ReadLinkAction| 
   (:model :UML25 :superclasses (|LinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadLinkAction")
 "A ReadLinkAction is a LinkAction that navigates across an Association to
  retrieve the objects on one end."
  ((|result| :xmi-id "ReadLinkAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the objects retrieved from the \"open\" end of those
      links whose values on other ends are given by the endData.")))

(def-meta-operation "openEnd" |ReadLinkAction| 
   "Returns the ends corresponding to endData with no value InputPin. (A well-formed
    ReadLinkAction is constrained to have only one of these.)"
   :operation-body
   "result = (endData->select(value=null).end->asOrderedSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-assoc "A_result_readLinkAction"      
  :name |A_result_readLinkAction|      
  :metatype :association      
  :member-ends ((|ReadLinkAction| "result")
                ("A_result_readLinkAction-readLinkAction" "readLinkAction"))      
  :owned-ends  (("A_result_readLinkAction-readLinkAction" "readLinkAction")))

(def-meta-assoc-end "A_result_readLinkAction-readLinkAction" 
    :type |ReadLinkAction| 
    :multiplicity (0 1) 
    :association "A_result_readLinkAction" 
    :name "readLinkAction")

;;; =========================================================
;;; ====================== ReadLinkObjectEndAction
;;; =========================================================
(def-meta-class |ReadLinkObjectEndAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadLinkObjectEndAction")
 "A ReadLinkObjectEndAction is an Action that retrieves an end object from
  a link object."
  ((|end| :xmi-id "ReadLinkObjectEndAction-end" :range |Property| :multiplicity (1 1)
    :documentation
     "The Association end to be read.")
   (|object| :xmi-id "ReadLinkObjectEndAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The input pin from which the link object is obtained.")
   (|result| :xmi-id "ReadLinkObjectEndAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin where the result value is placed.")))

(def-meta-assoc "A_end_readLinkObjectEndAction"      
  :name |A_end_readLinkObjectEndAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndAction| "end")
                ("A_end_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction"))      
  :owned-ends  (("A_end_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction")))

(def-meta-assoc-end "A_end_readLinkObjectEndAction-readLinkObjectEndAction" 
    :type |ReadLinkObjectEndAction| 
    :multiplicity (0 1) 
    :association "A_end_readLinkObjectEndAction" 
    :name "readLinkObjectEndAction")

(def-meta-assoc "A_object_readLinkObjectEndAction"      
  :name |A_object_readLinkObjectEndAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndAction| "object")
                ("A_object_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction"))      
  :owned-ends  (("A_object_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction")))

(def-meta-assoc-end "A_object_readLinkObjectEndAction-readLinkObjectEndAction" 
    :type |ReadLinkObjectEndAction| 
    :multiplicity (0 1) 
    :association "A_object_readLinkObjectEndAction" 
    :name "readLinkObjectEndAction")

(def-meta-assoc "A_result_readLinkObjectEndAction"      
  :name |A_result_readLinkObjectEndAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndAction| "result")
                ("A_result_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction"))      
  :owned-ends  (("A_result_readLinkObjectEndAction-readLinkObjectEndAction" "readLinkObjectEndAction")))

(def-meta-assoc-end "A_result_readLinkObjectEndAction-readLinkObjectEndAction" 
    :type |ReadLinkObjectEndAction| 
    :multiplicity (0 1) 
    :association "A_result_readLinkObjectEndAction" 
    :name "readLinkObjectEndAction")

;;; =========================================================
;;; ====================== ReadLinkObjectEndQualifierAction
;;; =========================================================
(def-meta-class |ReadLinkObjectEndQualifierAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadLinkObjectEndQualifierAction")
 "A ReadLinkObjectEndQualifierAction is an Action that retrieves a qualifier
  end value from a link object."
  ((|object| :xmi-id "ReadLinkObjectEndQualifierAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin from which the link object is obtained.")
   (|qualifier| :xmi-id "ReadLinkObjectEndQualifierAction-qualifier" :range |Property| :multiplicity (1 1)
    :documentation
     "The qualifier Property to be read.")
   (|result| :xmi-id "ReadLinkObjectEndQualifierAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin where the result value is placed.")))

(def-meta-assoc "A_object_readLinkObjectEndQualifierAction"      
  :name |A_object_readLinkObjectEndQualifierAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndQualifierAction| "object")
                ("A_object_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction"))      
  :owned-ends  (("A_object_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction")))

(def-meta-assoc-end "A_object_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" 
    :type |ReadLinkObjectEndQualifierAction| 
    :multiplicity (0 1) 
    :association "A_object_readLinkObjectEndQualifierAction" 
    :name "readLinkObjectEndQualifierAction")

(def-meta-assoc "A_qualifier_readLinkObjectEndQualifierAction"      
  :name |A_qualifier_readLinkObjectEndQualifierAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndQualifierAction| "qualifier")
                ("A_qualifier_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction"))      
  :owned-ends  (("A_qualifier_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction")))

(def-meta-assoc-end "A_qualifier_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" 
    :type |ReadLinkObjectEndQualifierAction| 
    :multiplicity (0 1) 
    :association "A_qualifier_readLinkObjectEndQualifierAction" 
    :name "readLinkObjectEndQualifierAction")

(def-meta-assoc "A_result_readLinkObjectEndQualifierAction"      
  :name |A_result_readLinkObjectEndQualifierAction|      
  :metatype :association      
  :member-ends ((|ReadLinkObjectEndQualifierAction| "result")
                ("A_result_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction"))      
  :owned-ends  (("A_result_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" "readLinkObjectEndQualifierAction")))

(def-meta-assoc-end "A_result_readLinkObjectEndQualifierAction-readLinkObjectEndQualifierAction" 
    :type |ReadLinkObjectEndQualifierAction| 
    :multiplicity (0 1) 
    :association "A_result_readLinkObjectEndQualifierAction" 
    :name "readLinkObjectEndQualifierAction")

;;; =========================================================
;;; ====================== ReadSelfAction
;;; =========================================================
(def-meta-class |ReadSelfAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadSelfAction")
 "A ReadSelfAction is an Action that retrieves the context object of the
  Behavior execution within which the ReadSelfAction execution is taking
  place."
  ((|result| :xmi-id "ReadSelfAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the context object is placed.")))

(def-meta-assoc "A_result_readSelfAction"      
  :name |A_result_readSelfAction|      
  :metatype :association      
  :member-ends ((|ReadSelfAction| "result")
                ("A_result_readSelfAction-readSelfAction" "readSelfAction"))      
  :owned-ends  (("A_result_readSelfAction-readSelfAction" "readSelfAction")))

(def-meta-assoc-end "A_result_readSelfAction-readSelfAction" 
    :type |ReadSelfAction| 
    :multiplicity (0 1) 
    :association "A_result_readSelfAction" 
    :name "readSelfAction")

;;; =========================================================
;;; ====================== ReadStructuralFeatureAction
;;; =========================================================
(def-meta-class |ReadStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadStructuralFeatureAction")
 "A ReadStructuralFeatureAction is a StructuralFeatureAction that retrieves
  the values of a StructuralFeature."
  ((|result| :xmi-id "ReadStructuralFeatureAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the result values are placed.")))

(def-meta-assoc "A_result_readStructuralFeatureAction"      
  :name |A_result_readStructuralFeatureAction|      
  :metatype :association      
  :member-ends ((|ReadStructuralFeatureAction| "result")
                ("A_result_readStructuralFeatureAction-readStructuralFeatureAction" "readStructuralFeatureAction"))      
  :owned-ends  (("A_result_readStructuralFeatureAction-readStructuralFeatureAction" "readStructuralFeatureAction")))

(def-meta-assoc-end "A_result_readStructuralFeatureAction-readStructuralFeatureAction" 
    :type |ReadStructuralFeatureAction| 
    :multiplicity (0 1) 
    :association "A_result_readStructuralFeatureAction" 
    :name "readStructuralFeatureAction")

;;; =========================================================
;;; ====================== ReadVariableAction
;;; =========================================================
(def-meta-class |ReadVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "ReadVariableAction")
 "A ReadVariableAction is a VariableAction that retrieves the values of a
  Variable."
  ((|result| :xmi-id "ReadVariableAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the result values are placed.")))

(def-meta-assoc "A_result_readVariableAction"      
  :name |A_result_readVariableAction|      
  :metatype :association      
  :member-ends ((|ReadVariableAction| "result")
                ("A_result_readVariableAction-readVariableAction" "readVariableAction"))      
  :owned-ends  (("A_result_readVariableAction-readVariableAction" "readVariableAction")))

(def-meta-assoc-end "A_result_readVariableAction-readVariableAction" 
    :type |ReadVariableAction| 
    :multiplicity (0 1) 
    :association "A_result_readVariableAction" 
    :name "readVariableAction")

;;; =========================================================
;;; ====================== Realization
;;; =========================================================
(def-meta-class |Realization| 
   (:model :UML25 :superclasses (|Abstraction|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Realization")
 "Realization is a specialized Abstraction relationship between two sets
  of model Elements, one representing a specification (the supplier) and
  the other represents an implementation of the latter (the client). Realization
  can be used to model stepwise refinement, optimizations, transformations,
  templates, model synthesis, framework composition, etc."
  ())

;;; =========================================================
;;; ====================== Reception
;;; =========================================================
(def-meta-class |Reception| 
   (:model :UML25 :superclasses (|BehavioralFeature|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "Reception")
 "A Reception is a declaration stating that a Classifier is prepared to react
  to the receipt of a Signal."
  ((|signal| :xmi-id "Reception-signal" :range |Signal| :multiplicity (1 1)
    :documentation
     "The Signal that this Reception handles.")))

(def-meta-assoc "A_signal_reception"      
  :name |A_signal_reception|      
  :metatype :association      
  :member-ends ((|Reception| "signal")
                ("A_signal_reception-reception" "reception"))      
  :owned-ends  (("A_signal_reception-reception" "reception")))

(def-meta-assoc-end "A_signal_reception-reception" 
    :type |Reception| 
    :multiplicity (0 -1) 
    :association "A_signal_reception" 
    :name "reception")

;;; =========================================================
;;; ====================== ReclassifyObjectAction
;;; =========================================================
(def-meta-class |ReclassifyObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReclassifyObjectAction")
 "A ReclassifyObjectAction is an Action that changes the Classifiers that
  classify an object."
  ((|isReplaceAll| :xmi-id "ReclassifyObjectAction-isReplaceAll" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing Classifiers should be removed before adding
      the new Classifiers.")
   (|newClassifier| :xmi-id "ReclassifyObjectAction-newClassifier" :range |Classifier| :multiplicity (0 -1)
    :documentation
     "A set of Classifiers to be added to the Classifiers of the given object.")
   (|object| :xmi-id "ReclassifyObjectAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that holds the object to be reclassified.")
   (|oldClassifier| :xmi-id "ReclassifyObjectAction-oldClassifier" :range |Classifier| :multiplicity (0 -1)
    :documentation
     "A set of Classifiers to be removed from the Classifiers of the given object.")))

(def-meta-assoc "A_newClassifier_reclassifyObjectAction"      
  :name |A_newClassifier_reclassifyObjectAction|      
  :metatype :association      
  :member-ends ((|ReclassifyObjectAction| "newClassifier")
                ("A_newClassifier_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction"))      
  :owned-ends  (("A_newClassifier_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction")))

(def-meta-assoc-end "A_newClassifier_reclassifyObjectAction-reclassifyObjectAction" 
    :type |ReclassifyObjectAction| 
    :multiplicity (0 -1) 
    :association "A_newClassifier_reclassifyObjectAction" 
    :name "reclassifyObjectAction")

(def-meta-assoc "A_object_reclassifyObjectAction"      
  :name |A_object_reclassifyObjectAction|      
  :metatype :association      
  :member-ends ((|ReclassifyObjectAction| "object")
                ("A_object_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction"))      
  :owned-ends  (("A_object_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction")))

(def-meta-assoc-end "A_object_reclassifyObjectAction-reclassifyObjectAction" 
    :type |ReclassifyObjectAction| 
    :multiplicity (0 1) 
    :association "A_object_reclassifyObjectAction" 
    :name "reclassifyObjectAction")

(def-meta-assoc "A_oldClassifier_reclassifyObjectAction"      
  :name |A_oldClassifier_reclassifyObjectAction|      
  :metatype :association      
  :member-ends ((|ReclassifyObjectAction| "oldClassifier")
                ("A_oldClassifier_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction"))      
  :owned-ends  (("A_oldClassifier_reclassifyObjectAction-reclassifyObjectAction" "reclassifyObjectAction")))

(def-meta-assoc-end "A_oldClassifier_reclassifyObjectAction-reclassifyObjectAction" 
    :type |ReclassifyObjectAction| 
    :multiplicity (0 -1) 
    :association "A_oldClassifier_reclassifyObjectAction" 
    :name "reclassifyObjectAction")

;;; =========================================================
;;; ====================== RedefinableElement
;;; =========================================================
(def-meta-class |RedefinableElement| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Classification|) 
    :xmi-id "RedefinableElement")
 "A RedefinableElement is an element that, when defined in the context of
  a Classifier, can be redefined more specifically or differently in the
  context of another Classifier that specializes (directly or indirectly)
  the context Classifier."
  ((|isLeaf| :xmi-id "RedefinableElement-isLeaf" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether it is possible to further redefine a RedefinableElement.
      If the value is true, then it is not possible to further redefine the RedefinableElement.")
   (|redefinedElement| :xmi-id "RedefinableElement-redefinedElement" :range |RedefinableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "The RedefinableElement that is being redefined by this element.")
   (|redefinitionContext| :xmi-id "RedefinableElement-redefinitionContext" :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "The contexts that this element may be redefined from.")))

(def-meta-operation "isConsistentWith" |RedefinableElement| 
   "The query isConsistentWith() specifies, for any two RedefinableElements
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. By default, this is false; this operation must
    be overridden for subclasses of RedefinableElement to define the consistency
    conditions."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isRedefinitionContextValid" |RedefinableElement| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of this RedefinableElement are properly related to the redefinition
    contexts of the specified RedefinableElement to allow this element to redefine
    the other. By default at least one of the redefinition contexts of this
    element must be a specialization of at least one of the redefinition contexts
    of the specified element."
   :operation-body
   "result = (redefinitionContext->exists(c | c.allParents()->includesAll(redefinedElement.redefinitionContext)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinedElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_redefinedElement_redefinableElement"      
  :name |A_redefinedElement_redefinableElement|      
  :metatype :association      
  :member-ends ((|RedefinableElement| "redefinedElement")
                ("A_redefinedElement_redefinableElement-redefinableElement" "redefinableElement"))      
  :owned-ends  (("A_redefinedElement_redefinableElement-redefinableElement" "redefinableElement")))

(def-meta-assoc-end "A_redefinedElement_redefinableElement-redefinableElement" 
    :type |RedefinableElement| 
    :multiplicity (0 -1) 
    :association "A_redefinedElement_redefinableElement" 
    :name "redefinableElement")

(def-meta-assoc "A_redefinitionContext_redefinableElement"      
  :name |A_redefinitionContext_redefinableElement|      
  :metatype :association      
  :member-ends ((|RedefinableElement| "redefinitionContext")
                ("A_redefinitionContext_redefinableElement-redefinableElement" "redefinableElement"))      
  :owned-ends  (("A_redefinitionContext_redefinableElement-redefinableElement" "redefinableElement")))

(def-meta-assoc-end "A_redefinitionContext_redefinableElement-redefinableElement" 
    :type |RedefinableElement| 
    :multiplicity (0 -1) 
    :association "A_redefinitionContext_redefinableElement" 
    :name "redefinableElement")

;;; =========================================================
;;; ====================== RedefinableTemplateSignature
;;; =========================================================
(def-meta-class |RedefinableTemplateSignature| 
   (:model :UML25 :superclasses (|RedefinableElement| |TemplateSignature|) 
    :packages (UML |Classification|) 
    :xmi-id "RedefinableTemplateSignature")
 "A RedefinableTemplateSignature supports the addition of formal template
  parameters in a specialization of a template classifier."
  ((|classifier| :xmi-id "RedefinableTemplateSignature-classifier" :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|))
    :opposite (|Classifier| |ownedTemplateSignature|)
    :documentation
     "The Classifier that owns this RedefinableTemplateSignature." :redefined-property (|TemplateSignature| |template|))
   (|extendedSignature| :xmi-id "RedefinableTemplateSignature-extendedSignature" :range |RedefinableTemplateSignature| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The signatures extended by this RedefinableTemplateSignature.")
   (|inheritedParameter| :xmi-id "RedefinableTemplateSignature-inheritedParameter" :range |TemplateParameter| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|TemplateSignature| |parameter|))
    :documentation
     "The formal template parameters of the extended signatures.")))

(def-meta-operation "inheritedParameter.1" |RedefinableTemplateSignature| 
   "Derivation for RedefinableTemplateSignature::/inheritedParameter"
   :operation-body
   "result = (if extendedSignature->isEmpty() then Set{} else extendedSignature.parameter->asSet() endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|TemplateParameter|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |RedefinableTemplateSignature| 
   "The query isConsistentWith() specifies, for any two RedefinableTemplateSignatures
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. A redefining template signature is always consistent
    with a redefined template signature, as redefinition only adds new formal
    parameters."
   :operation-body
   "result = (redefiningElement.oclIsKindOf(RedefinableTemplateSignature))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_extendedSignature_redefinableTemplateSignature"      
  :name |A_extendedSignature_redefinableTemplateSignature|      
  :metatype :association      
  :member-ends ((|RedefinableTemplateSignature| "extendedSignature")
                ("A_extendedSignature_redefinableTemplateSignature-redefinableTemplateSignature" "redefinableTemplateSignature"))      
  :owned-ends  (("A_extendedSignature_redefinableTemplateSignature-redefinableTemplateSignature" "redefinableTemplateSignature")))

(def-meta-assoc-end "A_extendedSignature_redefinableTemplateSignature-redefinableTemplateSignature" 
    :type |RedefinableTemplateSignature| 
    :multiplicity (0 -1) 
    :association "A_extendedSignature_redefinableTemplateSignature" 
    :name "redefinableTemplateSignature")

(def-meta-assoc "A_inheritedParameter_redefinableTemplateSignature"      
  :name |A_inheritedParameter_redefinableTemplateSignature|      
  :metatype :association      
  :member-ends ((|RedefinableTemplateSignature| "inheritedParameter")
                ("A_inheritedParameter_redefinableTemplateSignature-redefinableTemplateSignature" "redefinableTemplateSignature"))      
  :owned-ends  (("A_inheritedParameter_redefinableTemplateSignature-redefinableTemplateSignature" "redefinableTemplateSignature")))

(def-meta-assoc-end "A_inheritedParameter_redefinableTemplateSignature-redefinableTemplateSignature" 
    :type |RedefinableTemplateSignature| 
    :multiplicity (0 -1) 
    :association "A_inheritedParameter_redefinableTemplateSignature" 
    :name "redefinableTemplateSignature")

;;; =========================================================
;;; ====================== ReduceAction
;;; =========================================================
(def-meta-class |ReduceAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReduceAction")
 "A ReduceAction is an Action that reduces a collection to a single value
  by repeatedly combining the elements of the collection using a reducer
  Behavior."
  ((|collection| :xmi-id "ReduceAction-collection" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that provides the collection to be reduced.")
   (|isOrdered| :xmi-id "ReduceAction-isOrdered" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the order of the input collection should determine the
      order in which the reducer Behavior is applied to its elements.")
   (|reducer| :xmi-id "ReduceAction-reducer" :range |Behavior| :multiplicity (1 1)
    :documentation
     "A Behavior that is repreatedly applied to two elements of the input collection
      to produce a value that is of the same type as elements of the collection.")
   (|result| :xmi-id "ReduceAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The output pin on which the result value is placed.")))

(def-meta-assoc "A_collection_reduceAction"      
  :name |A_collection_reduceAction|      
  :metatype :association      
  :member-ends ((|ReduceAction| "collection")
                ("A_collection_reduceAction-reduceAction" "reduceAction"))      
  :owned-ends  (("A_collection_reduceAction-reduceAction" "reduceAction")))

(def-meta-assoc-end "A_collection_reduceAction-reduceAction" 
    :type |ReduceAction| 
    :multiplicity (0 1) 
    :association "A_collection_reduceAction" 
    :name "reduceAction")

(def-meta-assoc "A_reducer_reduceAction"      
  :name |A_reducer_reduceAction|      
  :metatype :association      
  :member-ends ((|ReduceAction| "reducer")
                ("A_reducer_reduceAction-reduceAction" "reduceAction"))      
  :owned-ends  (("A_reducer_reduceAction-reduceAction" "reduceAction")))

(def-meta-assoc-end "A_reducer_reduceAction-reduceAction" 
    :type |ReduceAction| 
    :multiplicity (0 -1) 
    :association "A_reducer_reduceAction" 
    :name "reduceAction")

(def-meta-assoc "A_result_reduceAction"      
  :name |A_result_reduceAction|      
  :metatype :association      
  :member-ends ((|ReduceAction| "result")
                ("A_result_reduceAction-reduceAction" "reduceAction"))      
  :owned-ends  (("A_result_reduceAction-reduceAction" "reduceAction")))

(def-meta-assoc-end "A_result_reduceAction-reduceAction" 
    :type |ReduceAction| 
    :multiplicity (0 1) 
    :association "A_result_reduceAction" 
    :name "reduceAction")

;;; =========================================================
;;; ====================== Region
;;; =========================================================
(def-meta-class |Region| 
   (:model :UML25 :superclasses (|Namespace| |RedefinableElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "Region")
 "A Region is a top-level part of a StateMachine or a composite State, that
  serves as a container for the Vertices and Transitions of the StateMachine.
  A StateMachine or composite State may contain multiple Regions representing
  behaviors that may occur in parallel."
  ((|extendedRegion| :xmi-id "Region-extendedRegion" :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The region of which this region is an extension.")
   (|redefinitionContext| :xmi-id "Region-redefinitionContext" :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the Classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|state| :xmi-id "Region-state" :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |region|)
    :documentation
     "The State that owns the Region. If a Region is owned by a State, then it
      cannot also be owned by a StateMachine.")
   (|stateMachine| :xmi-id "Region-stateMachine" :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |region|)
    :documentation
     "The StateMachine that owns the Region. If a Region is owned by a StateMachine,
      then it cannot also be owned by a State.")
   (|subvertex| :xmi-id "Region-subvertex" :range |Vertex| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Vertex| |container|)
    :documentation
     "The set of Vertices that are owned by this Region.")
   (|transition| :xmi-id "Region-transition" :range |Transition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Transition| |container|)
    :documentation
     "The set of Transitions owned by the Region.")))

(def-meta-operation "belongsToPSM" |Region| 
   "The operation belongsToPSM () checks if the Region belongs to a ProtocolStateMachine."
   :operation-body
   "result = (if  stateMachine <> null  then   stateMachine.oclIsKindOf(ProtocolStateMachine) else    state <> null  implies  state.container.belongsToPSM() endif )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "containingStateMachine" |Region| 
   "The operation containingStateMachine() returns the StateMachine in which
    this Region is defined."
   :operation-body
   "result = (if stateMachine = null  then   state.containingStateMachine() else   stateMachine endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Region| 
   "The query isConsistentWith() specifies that a redefining Region is consistent
    with a redefined Region provided that the redefining Region is an extension
    of the Redefined region, i.e., its Vertices and Transitions conform to
    one of the following: (1) they are equal to corresponding elements of the
    redefined Region or, (2) they consistently redefine a State or Transition
    of the redefined region, or (3) they add new States or Transitions."
   :operation-body
   "result = (-- the following is merely a default body; it is expected that the specific form of this constraint will be specified by profiles  true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isRedefinitionContextValid" |Region| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of a Region are properly related to the redefinition contexts
    of the specified Region to allow this element to redefine the other. The
    containing StateMachine or State of a redefining Region must Redefine the
    containing StateMachine or State of the redefined Region."
   :operation-body
   "result = (if redefinedElement.oclIsKindOf(Region) then    let redefinedRegion : Region = redefinedElement.oclAsType(Region) in      if stateMachine->isEmpty() then      -- the Region is owned by a State        (state.redefinedState->notEmpty() and state.redefinedState.region->includes(redefinedRegion))      else -- the region is owned by a StateMachine        (stateMachine.extendedStateMachine->notEmpty() and          stateMachine.extendedStateMachine->exists(sm : StateMachine |            sm.region->includes(redefinedRegion)))      endif  else    false  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinedElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "redefinitionContext.1" |Region| 
   "The redefinition context of a Region is the nearest containing StateMachine."
   :operation-body
   "result = (let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-assoc "A_extendedRegion_region"      
  :name |A_extendedRegion_region|      
  :metatype :association      
  :member-ends ((|Region| "extendedRegion")
                ("A_extendedRegion_region-region" "region"))      
  :owned-ends  (("A_extendedRegion_region-region" "region")))

(def-meta-assoc-end "A_extendedRegion_region-region" 
    :type |Region| 
    :multiplicity (0 -1) 
    :association "A_extendedRegion_region" 
    :name "region")

(def-meta-assoc "A_redefinitionContext_region"      
  :name |A_redefinitionContext_region|      
  :metatype :association      
  :member-ends ((|Region| "redefinitionContext")
                ("A_redefinitionContext_region-region" "region"))      
  :owned-ends  (("A_redefinitionContext_region-region" "region")))

(def-meta-assoc-end "A_redefinitionContext_region-region" 
    :type |Region| 
    :multiplicity (0 -1) 
    :association "A_redefinitionContext_region" 
    :name "region")

(def-meta-assoc "A_subvertex_container"      
  :name |A_subvertex_container|      
  :metatype :association      
  :member-ends ((|Region| "subvertex")
                (|Vertex| "container"))      
  :owned-ends  ())

(def-meta-assoc "A_transition_container"      
  :name |A_transition_container|      
  :metatype :association      
  :member-ends ((|Region| "transition")
                (|Transition| "container"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Relationship
;;; =========================================================
(def-meta-class |Relationship| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Relationship")
 "Relationship is an abstract concept that specifies some kind of relationship
  between Elements."
  ((|relatedElement| :xmi-id "Relationship-relatedElement" :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "Specifies the elements related by the Relationship.")))

(def-meta-assoc "A_relatedElement_relationship"      
  :name |A_relatedElement_relationship|      
  :metatype :association      
  :member-ends ((|Relationship| "relatedElement")
                ("A_relatedElement_relationship-relationship" "relationship"))      
  :owned-ends  (("A_relatedElement_relationship-relationship" "relationship")))

(def-meta-assoc-end "A_relatedElement_relationship-relationship" 
    :type |Relationship| 
    :multiplicity (0 -1) 
    :association "A_relatedElement_relationship" 
    :name "relationship")

;;; =========================================================
;;; ====================== RemoveStructuralFeatureValueAction
;;; =========================================================
(def-meta-class |RemoveStructuralFeatureValueAction| 
   (:model :UML25 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "RemoveStructuralFeatureValueAction")
 "A RemoveStructuralFeatureValueAction is a WriteStructuralFeatureAction
  that removes values from a StructuralFeature."
  ((|isRemoveDuplicates| :xmi-id "RemoveStructuralFeatureValueAction-isRemoveDuplicates" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique StructuralFeatures.")
   (|removeAt| :xmi-id "RemoveStructuralFeatureValueAction-removeAt" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An InputPin that provides the position of an existing value to remove in
      ordered, nonunique structural features. The type of the removeAt InputPin
      is UnlimitedNatural, but the value cannot be zero or unlimited.")))

(def-meta-assoc "A_removeAt_removeStructuralFeatureValueAction"      
  :name |A_removeAt_removeStructuralFeatureValueAction|      
  :metatype :association      
  :member-ends ((|RemoveStructuralFeatureValueAction| "removeAt")
                ("A_removeAt_removeStructuralFeatureValueAction-removeStructuralFeatureValueAction" "removeStructuralFeatureValueAction"))      
  :owned-ends  (("A_removeAt_removeStructuralFeatureValueAction-removeStructuralFeatureValueAction" "removeStructuralFeatureValueAction")))

(def-meta-assoc-end "A_removeAt_removeStructuralFeatureValueAction-removeStructuralFeatureValueAction" 
    :type |RemoveStructuralFeatureValueAction| 
    :multiplicity (0 1) 
    :association "A_removeAt_removeStructuralFeatureValueAction" 
    :name "removeStructuralFeatureValueAction")

;;; =========================================================
;;; ====================== RemoveVariableValueAction
;;; =========================================================
(def-meta-class |RemoveVariableValueAction| 
   (:model :UML25 :superclasses (|WriteVariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "RemoveVariableValueAction")
 "A RemoveVariableValueAction is a WriteVariableAction that removes values
  from a Variables."
  ((|isRemoveDuplicates| :xmi-id "RemoveVariableValueAction-isRemoveDuplicates" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique Variables.")
   (|removeAt| :xmi-id "RemoveVariableValueAction-removeAt" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An InputPin that provides the position of an existing value to remove in
      ordered, nonunique Variables. The type of the removeAt InputPin is UnlimitedNatural,
      but the value cannot be zero or unlimited.")))

(def-meta-assoc "A_removeAt_removeVariableValueAction"      
  :name |A_removeAt_removeVariableValueAction|      
  :metatype :association      
  :member-ends ((|RemoveVariableValueAction| "removeAt")
                ("A_removeAt_removeVariableValueAction-removeVariableValueAction" "removeVariableValueAction"))      
  :owned-ends  (("A_removeAt_removeVariableValueAction-removeVariableValueAction" "removeVariableValueAction")))

(def-meta-assoc-end "A_removeAt_removeVariableValueAction-removeVariableValueAction" 
    :type |RemoveVariableValueAction| 
    :multiplicity (0 1) 
    :association "A_removeAt_removeVariableValueAction" 
    :name "removeVariableValueAction")

;;; =========================================================
;;; ====================== ReplyAction
;;; =========================================================
(def-meta-class |ReplyAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ReplyAction")
 "A ReplyAction is an Action that accepts a set of reply values and a value
  containing return information produced by a previous AcceptCallAction.
  The ReplyAction returns the values to the caller of the previous call,
  completing execution of the call."
  ((|replyToCall| :xmi-id "ReplyAction-replyToCall" :range |Trigger| :multiplicity (1 1)
    :documentation
     "The Trigger specifying the Operation whose call is being replied to.")
   (|replyValue| :xmi-id "ReplyAction-replyValue" :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "A list of InputPins providing the values for the output (inout, out, and
      return) Parameters of the Operation. These values are returned to the caller.")
   (|returnInformation| :xmi-id "ReplyAction-returnInformation" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An InputPin that holds the return information value produced by an earlier
      AcceptCallAction.")))

(def-meta-assoc "A_replyToCall_replyAction"      
  :name |A_replyToCall_replyAction|      
  :metatype :association      
  :member-ends ((|ReplyAction| "replyToCall")
                ("A_replyToCall_replyAction-replyAction" "replyAction"))      
  :owned-ends  (("A_replyToCall_replyAction-replyAction" "replyAction")))

(def-meta-assoc-end "A_replyToCall_replyAction-replyAction" 
    :type |ReplyAction| 
    :multiplicity (0 1) 
    :association "A_replyToCall_replyAction" 
    :name "replyAction")

(def-meta-assoc "A_replyValue_replyAction"      
  :name |A_replyValue_replyAction|      
  :metatype :association      
  :member-ends ((|ReplyAction| "replyValue")
                ("A_replyValue_replyAction-replyAction" "replyAction"))      
  :owned-ends  (("A_replyValue_replyAction-replyAction" "replyAction")))

(def-meta-assoc-end "A_replyValue_replyAction-replyAction" 
    :type |ReplyAction| 
    :multiplicity (0 1) 
    :association "A_replyValue_replyAction" 
    :name "replyAction")

(def-meta-assoc "A_returnInformation_replyAction"      
  :name |A_returnInformation_replyAction|      
  :metatype :association      
  :member-ends ((|ReplyAction| "returnInformation")
                ("A_returnInformation_replyAction-replyAction" "replyAction"))      
  :owned-ends  (("A_returnInformation_replyAction-replyAction" "replyAction")))

(def-meta-assoc-end "A_returnInformation_replyAction-replyAction" 
    :type |ReplyAction| 
    :multiplicity (0 1) 
    :association "A_returnInformation_replyAction" 
    :name "replyAction")

;;; =========================================================
;;; ====================== SendObjectAction
;;; =========================================================
(def-meta-class |SendObjectAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "SendObjectAction")
 "A SendObjectAction is an InvocationAction that transmits an input object
  to the target object, which is handled as a request message by the target
  object. The requestor continues execution immediately after the object
  is sent out and cannot receive reply values."
  ((|request| :xmi-id "SendObjectAction-request" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The request object, which is transmitted to the target object. The object
      may be copied in transmission, so identity might not be preserved." :redefined-property (|InvocationAction| |argument|))
   (|target| :xmi-id "SendObjectAction-target" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The target object to which the object is sent.")))

(def-meta-assoc "A_request_sendObjectAction"      
  :name |A_request_sendObjectAction|      
  :metatype :association      
  :member-ends ((|SendObjectAction| "request")
                ("A_request_sendObjectAction-sendObjectAction" "sendObjectAction"))      
  :owned-ends  (("A_request_sendObjectAction-sendObjectAction" "sendObjectAction")))

(def-meta-assoc-end "A_request_sendObjectAction-sendObjectAction" 
    :type |SendObjectAction| 
    :multiplicity (0 1) 
    :association "A_request_sendObjectAction" 
    :name "sendObjectAction")

(def-meta-assoc "A_target_sendObjectAction"      
  :name |A_target_sendObjectAction|      
  :metatype :association      
  :member-ends ((|SendObjectAction| "target")
                ("A_target_sendObjectAction-sendObjectAction" "sendObjectAction"))      
  :owned-ends  (("A_target_sendObjectAction-sendObjectAction" "sendObjectAction")))

(def-meta-assoc-end "A_target_sendObjectAction-sendObjectAction" 
    :type |SendObjectAction| 
    :multiplicity (0 1) 
    :association "A_target_sendObjectAction" 
    :name "sendObjectAction")

;;; =========================================================
;;; ====================== SendSignalAction
;;; =========================================================
(def-meta-class |SendSignalAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "SendSignalAction")
 "A SendSignalAction is an InvocationAction that creates a Signal instance
  and transmits it to the target object. Values from the argument InputPins
  are used to provide values for the attributes of the Signal. The requestor
  continues execution immediately after the Signal instance is sent out and
  cannot receive reply values."
  ((|signal| :xmi-id "SendSignalAction-signal" :range |Signal| :multiplicity (1 1)
    :documentation
     "The Signal whose instance is transmitted to the target.")
   (|target| :xmi-id "SendSignalAction-target" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that provides the target object to which the Signal instance
      is sent.")))

(def-meta-assoc "A_signal_sendSignalAction"      
  :name |A_signal_sendSignalAction|      
  :metatype :association      
  :member-ends ((|SendSignalAction| "signal")
                ("A_signal_sendSignalAction-sendSignalAction" "sendSignalAction"))      
  :owned-ends  (("A_signal_sendSignalAction-sendSignalAction" "sendSignalAction")))

(def-meta-assoc-end "A_signal_sendSignalAction-sendSignalAction" 
    :type |SendSignalAction| 
    :multiplicity (0 -1) 
    :association "A_signal_sendSignalAction" 
    :name "sendSignalAction")

(def-meta-assoc "A_target_sendSignalAction"      
  :name |A_target_sendSignalAction|      
  :metatype :association      
  :member-ends ((|SendSignalAction| "target")
                ("A_target_sendSignalAction-sendSignalAction" "sendSignalAction"))      
  :owned-ends  (("A_target_sendSignalAction-sendSignalAction" "sendSignalAction")))

(def-meta-assoc-end "A_target_sendSignalAction-sendSignalAction" 
    :type |SendSignalAction| 
    :multiplicity (0 1) 
    :association "A_target_sendSignalAction" 
    :name "sendSignalAction")

;;; =========================================================
;;; ====================== SequenceNode
;;; =========================================================
(def-meta-class |SequenceNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "SequenceNode")
 "A SequenceNode is a StructuredActivityNode that executes a sequence of
  ExecutableNodes in order."
  ((|executableNode| :xmi-id "SequenceNode-executableNode" :range |ExecutableNode| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "The ordered set of ExecutableNodes to be sequenced." :redefined-property (|StructuredActivityNode| |node|))))

(def-meta-assoc "A_executableNode_sequenceNode"      
  :name |A_executableNode_sequenceNode|      
  :metatype :association      
  :member-ends ((|SequenceNode| "executableNode")
                ("A_executableNode_sequenceNode-sequenceNode" "sequenceNode"))      
  :owned-ends  (("A_executableNode_sequenceNode-sequenceNode" "sequenceNode")))

(def-meta-assoc-end "A_executableNode_sequenceNode-sequenceNode" 
    :type |SequenceNode| 
    :multiplicity (0 1) 
    :association "A_executableNode_sequenceNode" 
    :name "sequenceNode")

;;; =========================================================
;;; ====================== Signal
;;; =========================================================
(def-meta-class |Signal| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "Signal")
 "A Signal is a specification of a kind of communication between objects
  in which a reaction is asynchronously triggered in the receiver without
  a reply."
  ((|ownedAttribute| :xmi-id "Signal-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :documentation
     "The attributes owned by the Signal.")))

(def-meta-assoc "A_ownedAttribute_owningSignal"      
  :name |A_ownedAttribute_owningSignal|      
  :metatype :association      
  :member-ends ((|Signal| "ownedAttribute")
                ("A_ownedAttribute_owningSignal-owningSignal" "owningSignal"))      
  :owned-ends  (("A_ownedAttribute_owningSignal-owningSignal" "owningSignal")))

(def-meta-assoc-end "A_ownedAttribute_owningSignal-owningSignal" 
    :type |Signal| 
    :multiplicity (0 1) 
    :association "A_ownedAttribute_owningSignal" 
    :name "owningSignal")

;;; =========================================================
;;; ====================== SignalEvent
;;; =========================================================
(def-meta-class |SignalEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "SignalEvent")
 "A SignalEvent represents the receipt of an asynchronous Signal instance."
  ((|signal| :xmi-id "SignalEvent-signal" :range |Signal| :multiplicity (1 1)
    :documentation
     "The specific Signal that is associated with this SignalEvent.")))

(def-meta-assoc "A_signal_signalEvent"      
  :name |A_signal_signalEvent|      
  :metatype :association      
  :member-ends ((|SignalEvent| "signal")
                ("A_signal_signalEvent-signalEvent" "signalEvent"))      
  :owned-ends  (("A_signal_signalEvent-signalEvent" "signalEvent")))

(def-meta-assoc-end "A_signal_signalEvent-signalEvent" 
    :type |SignalEvent| 
    :multiplicity (0 -1) 
    :association "A_signal_signalEvent" 
    :name "signalEvent")

;;; =========================================================
;;; ====================== Slot
;;; =========================================================
(def-meta-class |Slot| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Classification|) 
    :xmi-id "Slot")
 "A Slot designates that an entity modeled by an InstanceSpecification has
  a value or values for a specific StructuralFeature."
  ((|definingFeature| :xmi-id "Slot-definingFeature" :range |StructuralFeature| :multiplicity (1 1)
    :documentation
     "The StructuralFeature that specifies the values that may be held by the
      Slot.")
   (|owningInstance| :xmi-id "Slot-owningInstance" :range |InstanceSpecification| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|InstanceSpecification| |slot|)
    :documentation
     "The InstanceSpecification that owns this Slot.")
   (|value| :xmi-id "Slot-value" :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The value or values held by the Slot.")))

(def-meta-assoc "A_definingFeature_slot"      
  :name |A_definingFeature_slot|      
  :metatype :association      
  :member-ends ((|Slot| "definingFeature")
                ("A_definingFeature_slot-slot" "slot"))      
  :owned-ends  (("A_definingFeature_slot-slot" "slot")))

(def-meta-assoc-end "A_definingFeature_slot-slot" 
    :type |Slot| 
    :multiplicity (0 -1) 
    :association "A_definingFeature_slot" 
    :name "slot")

(def-meta-assoc "A_value_owningSlot"      
  :name |A_value_owningSlot|      
  :metatype :association      
  :member-ends ((|Slot| "value")
                ("A_value_owningSlot-owningSlot" "owningSlot"))      
  :owned-ends  (("A_value_owningSlot-owningSlot" "owningSlot")))

(def-meta-assoc-end "A_value_owningSlot-owningSlot" 
    :type |Slot| 
    :multiplicity (0 1) 
    :association "A_value_owningSlot" 
    :name "owningSlot")

;;; =========================================================
;;; ====================== StartClassifierBehaviorAction
;;; =========================================================
(def-meta-class |StartClassifierBehaviorAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "StartClassifierBehaviorAction")
 "A StartClassifierBehaviorAction is an Action that starts the classifierBehavior
  of the input object."
  ((|object| :xmi-id "StartClassifierBehaviorAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that holds the object whose classifierBehavior is to be started.")))

(def-meta-assoc "A_object_startClassifierBehaviorAction"      
  :name |A_object_startClassifierBehaviorAction|      
  :metatype :association      
  :member-ends ((|StartClassifierBehaviorAction| "object")
                ("A_object_startClassifierBehaviorAction-startClassifierBehaviorAction" "startClassifierBehaviorAction"))      
  :owned-ends  (("A_object_startClassifierBehaviorAction-startClassifierBehaviorAction" "startClassifierBehaviorAction")))

(def-meta-assoc-end "A_object_startClassifierBehaviorAction-startClassifierBehaviorAction" 
    :type |StartClassifierBehaviorAction| 
    :multiplicity (0 1) 
    :association "A_object_startClassifierBehaviorAction" 
    :name "startClassifierBehaviorAction")

;;; =========================================================
;;; ====================== StartObjectBehaviorAction
;;; =========================================================
(def-meta-class |StartObjectBehaviorAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "StartObjectBehaviorAction")
 "A StartObjectBehaviorAction is an InvocationAction that starts the execution
  either of a directly instantiated Behavior or of the classifierBehavior
  of an object. Argument values may be supplied for the input Parameters
  of the Behavior. If the Behavior is invoked synchronously, then output
  values may be obtained for output Parameters."
  ((|object| :xmi-id "StartObjectBehaviorAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An InputPin that holds the object that is either a Behavior to be started
      or has a classifierBehavior to be started.")))

(def-meta-operation "behavior" |StartObjectBehaviorAction| 
   "If the type of the object InputPin is a Behavior, then that Behavior. Otherwise,
    if the type of the object InputPin is a BehavioredClassifier, then the
    classifierBehavior of that BehavioredClassifier."
   :operation-body
   "result = (if object.type.oclIsKindOf(Behavior) then    object.type.oclAsType(Behavior)  else if object.type.oclIsKindOf(BehavioredClassifier) then    object.type.oclAsType(BehavioredClassifier).classifierBehavior  else    null  endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Behavior|
                        :parameter-return-p T))
)

(def-meta-operation "inputParameters" |StartObjectBehaviorAction| 
   "Return the in and inout ownedParameters of the Behavior being called."
   :operation-body
   "result = (self.behavior().inputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "outputParameters" |StartObjectBehaviorAction| 
   "Return the inout, out and return ownedParameters of the Behavior being
    called."
   :operation-body
   "result = (self.behavior().outputParameters())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-assoc "A_object_startObjectBehaviorAction"      
  :name |A_object_startObjectBehaviorAction|      
  :metatype :association      
  :member-ends ((|StartObjectBehaviorAction| "object")
                ("A_object_startObjectBehaviorAction-startObjectBehaviorAction" "startObjectBehaviorAction"))      
  :owned-ends  (("A_object_startObjectBehaviorAction-startObjectBehaviorAction" "startObjectBehaviorAction")))

(def-meta-assoc-end "A_object_startObjectBehaviorAction-startObjectBehaviorAction" 
    :type |StartObjectBehaviorAction| 
    :multiplicity (0 1) 
    :association "A_object_startObjectBehaviorAction" 
    :name "startObjectBehaviorAction")

;;; =========================================================
;;; ====================== State
;;; =========================================================
(def-meta-class |State| 
   (:model :UML25 :superclasses (|RedefinableElement| |Namespace| |Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "State")
 "A State models a situation during which some (usually implicit) invariant
  condition holds."
  ((|connection| :xmi-id "State-connection" :range |ConnectionPointReference| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ConnectionPointReference| |state|)
    :documentation
     "The entry and exit connection points used in conjunction with this (submachine)
      State, i.e., as targets and sources, respectively, in the Region with the
      submachine State. A connection point reference references the corresponding
      definition of a connection point Pseudostate in the StateMachine referenced
      by the submachine State.")
   (|connectionPoint| :xmi-id "State-connectionPoint" :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Pseudostate| |state|)
    :documentation
     "The entry and exit Pseudostates of a composite State. These can only be
      entry or exit Pseudostates, and they must have different names. They can
      only be defined for composite States.")
   (|deferrableTrigger| :xmi-id "State-deferrableTrigger" :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A list of Triggers that are candidates to be retained by the StateMachine
      if they trigger no Transitions out of the State (not consumed). A deferred
      Trigger is retained until the StateMachine reaches a State configuration
      where it is no longer deferred.")
   (|doActivity| :xmi-id "State-doActivity" :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional Behavior that is executed while being in the State. The execution
      starts when this State is entered, and ceases either by itself when done,
      or when the State is exited, whichever comes first.")
   (|entry| :xmi-id "State-entry" :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional Behavior that is executed whenever this State is entered regardless
      of the Transition taken to reach the State. If defined, entry Behaviors
      are always executed to completion prior to any internal Behavior or Transitions
      performed within the State.")
   (|exit| :xmi-id "State-exit" :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional Behavior that is executed whenever this State is exited regardless
      of which Transition was taken out of the State. If defined, exit Behaviors
      are always executed to completion only after all internal and transition
      Behaviors have completed execution.")
   (|isComposite| :xmi-id "State-isComposite" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A state with isComposite=true is said to be a composite State. A composite
      State is a State that contains at least one Region.")
   (|isOrthogonal| :xmi-id "State-isOrthogonal" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A State with isOrthogonal=true is said to be an orthogonal composite State
      An orthogonal composite State contains two or more Regions.")
   (|isSimple| :xmi-id "State-isSimple" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A State with isSimple=true is said to be a simple State A simple State
      does not have any Regions and it does not refer to any submachine StateMachine.")
   (|isSubmachineState| :xmi-id "State-isSubmachineState" :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A State with isSubmachineState=true is said to be a submachine State Such
      a State refers to another StateMachine(submachine).")
   (|redefinedState| :xmi-id "State-redefinedState" :range |State| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The State of which this State is a redefinition.")
   (|redefinitionContext| :xmi-id "State-redefinitionContext" :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the Classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|region| :xmi-id "State-region" :range |Region| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |state|)
    :documentation
     "The Regions owned directly by the State.")
   (|stateInvariant| :xmi-id "State-stateInvariant" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "Specifies conditions that are always true when this State is the current
      State. In ProtocolStateMachines state invariants are additional conditions
      to the preconditions of the outgoing Transitions, and to the postcondition
      of the incoming Transitions.")
   (|submachine| :xmi-id "State-submachine" :range |StateMachine| :multiplicity (0 1)
    :opposite (|StateMachine| |submachineState|)
    :documentation
     "The StateMachine that is to be inserted in place of the (submachine) State.")))

(def-meta-operation "containingStateMachine" |State| 
   "The query containingStateMachine() returns the StateMachine that contains
    the State either directly or transitively."
   :operation-body
   "result = (container.containingStateMachine())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isComposite.1" |State| 
   "A composite State is a State with at least one Region."
   :operation-body
   "result = (region->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |State| 
   "The query isConsistentWith() specifies that a redefining State is consistent
    with a redefined State provided that the redefining State is an extension
    of the redefined State A simple State can be redefined (extended) to become
    a composite State (by adding one or more Regions) and a composite State
    can be redefined (extended) by adding Regions and by adding Vertices, States,
    and Transitions to inherited Regions. All States may add or replace entry,
    exit, and 'doActivity' Behaviors."
   :operation-body
   "result = (-- the following is merely a default body; it is expected that the specific form of this constraint will be specified by profiles  true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isOrthogonal.1" |State| 
   "An orthogonal State is a composite state with at least 2 regions."
   :operation-body
   "result = (region->size () > 1)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isRedefinitionContextValid" |State| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of a State are properly related to the redefinition contexts of
    the specified State to allow this element to redefine the other. This means
    that the containing Region of a redefining State must redefine the containing
    Region of the redefined State."
   :operation-body
   "result = (if redefinedElement.oclIsKindOf(State) then    let redefinedState : State = redefinedElement.oclAsType(State) in      container.redefinedElement.oclAsType(Region)->exists(r:Region |        r.subvertex->includes(redefinedState))  else    false  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinedElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isSimple.1" |State| 
   "A simple State is a State without any regions."
   :operation-body
   "result = ((region->isEmpty()) and not isSubmachineState())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isSubmachineState.1" |State| 
   "Only submachine State references another StateMachine."
   :operation-body
   "result = (submachine <> null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "redefinitionContext.1" |State| 
   "The redefinition context of a State is the nearest containing StateMachine."
   :operation-body
   "result = (let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-assoc "A_connectionPoint_state"      
  :name |A_connectionPoint_state|      
  :metatype :association      
  :member-ends ((|State| "connectionPoint")
                (|Pseudostate| "state"))      
  :owned-ends  ())

(def-meta-assoc "A_connection_state"      
  :name |A_connection_state|      
  :metatype :association      
  :member-ends ((|State| "connection")
                (|ConnectionPointReference| "state"))      
  :owned-ends  ())

(def-meta-assoc "A_deferrableTrigger_state"      
  :name |A_deferrableTrigger_state|      
  :metatype :association      
  :member-ends ((|State| "deferrableTrigger")
                ("A_deferrableTrigger_state-state" "state"))      
  :owned-ends  (("A_deferrableTrigger_state-state" "state")))

(def-meta-assoc-end "A_deferrableTrigger_state-state" 
    :type |State| 
    :multiplicity (0 1) 
    :association "A_deferrableTrigger_state" 
    :name "state")

(def-meta-assoc "A_doActivity_state"      
  :name |A_doActivity_state|      
  :metatype :association      
  :member-ends ((|State| "doActivity")
                ("A_doActivity_state-state" "state"))      
  :owned-ends  (("A_doActivity_state-state" "state")))

(def-meta-assoc-end "A_doActivity_state-state" 
    :type |State| 
    :multiplicity (0 1) 
    :association "A_doActivity_state" 
    :name "state")

(def-meta-assoc "A_entry_state"      
  :name |A_entry_state|      
  :metatype :association      
  :member-ends ((|State| "entry")
                ("A_entry_state-state" "state"))      
  :owned-ends  (("A_entry_state-state" "state")))

(def-meta-assoc-end "A_entry_state-state" 
    :type |State| 
    :multiplicity (0 1) 
    :association "A_entry_state" 
    :name "state")

(def-meta-assoc "A_exit_state"      
  :name |A_exit_state|      
  :metatype :association      
  :member-ends ((|State| "exit")
                ("A_exit_state-state" "state"))      
  :owned-ends  (("A_exit_state-state" "state")))

(def-meta-assoc-end "A_exit_state-state" 
    :type |State| 
    :multiplicity (0 1) 
    :association "A_exit_state" 
    :name "state")

(def-meta-assoc "A_redefinedState_state"      
  :name |A_redefinedState_state|      
  :metatype :association      
  :member-ends ((|State| "redefinedState")
                ("A_redefinedState_state-state" "state"))      
  :owned-ends  (("A_redefinedState_state-state" "state")))

(def-meta-assoc-end "A_redefinedState_state-state" 
    :type |State| 
    :multiplicity (0 -1) 
    :association "A_redefinedState_state" 
    :name "state")

(def-meta-assoc "A_redefinitionContext_state"      
  :name |A_redefinitionContext_state|      
  :metatype :association      
  :member-ends ((|State| "redefinitionContext")
                ("A_redefinitionContext_state-state" "state"))      
  :owned-ends  (("A_redefinitionContext_state-state" "state")))

(def-meta-assoc-end "A_redefinitionContext_state-state" 
    :type |State| 
    :multiplicity (0 -1) 
    :association "A_redefinitionContext_state" 
    :name "state")

(def-meta-assoc "A_region_state"      
  :name |A_region_state|      
  :metatype :association      
  :member-ends ((|State| "region")
                (|Region| "state"))      
  :owned-ends  ())

(def-meta-assoc "A_stateInvariant_owningState"      
  :name |A_stateInvariant_owningState|      
  :metatype :association      
  :member-ends ((|State| "stateInvariant")
                ("A_stateInvariant_owningState-owningState" "owningState"))      
  :owned-ends  (("A_stateInvariant_owningState-owningState" "owningState")))

(def-meta-assoc-end "A_stateInvariant_owningState-owningState" 
    :type |State| 
    :multiplicity (0 1) 
    :association "A_stateInvariant_owningState" 
    :name "owningState")

;;; =========================================================
;;; ====================== StateInvariant
;;; =========================================================
(def-meta-class |StateInvariant| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "StateInvariant")
 "A StateInvariant is a runtime constraint on the participants of the Interaction.
  It may be used to specify a variety of different kinds of Constraints,
  such as values of Attributes or Variables, internal or external States,
  and so on. A StateInvariant is an InteractionFragment and it is placed
  on a Lifeline."
  ((|covered| :xmi-id "StateInvariant-covered" :range |Lifeline| :multiplicity (1 1)
    :documentation
     "References the Lifeline on which the StateInvariant appears." :redefined-property (|InteractionFragment| |covered|))
   (|invariant| :xmi-id "StateInvariant-invariant" :range |Constraint| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Constraint that should hold at runtime for this StateInvariant.")))

(def-meta-assoc "A_covered_stateInvariant"      
  :name |A_covered_stateInvariant|      
  :metatype :association      
  :member-ends ((|StateInvariant| "covered")
                ("A_covered_stateInvariant-stateInvariant" "stateInvariant"))      
  :owned-ends  (("A_covered_stateInvariant-stateInvariant" "stateInvariant")))

(def-meta-assoc-end "A_covered_stateInvariant-stateInvariant" 
    :type |StateInvariant| 
    :multiplicity (0 -1) 
    :association "A_covered_stateInvariant" 
    :name "stateInvariant")

(def-meta-assoc "A_invariant_stateInvariant"      
  :name |A_invariant_stateInvariant|      
  :metatype :association      
  :member-ends ((|StateInvariant| "invariant")
                ("A_invariant_stateInvariant-stateInvariant" "stateInvariant"))      
  :owned-ends  (("A_invariant_stateInvariant-stateInvariant" "stateInvariant")))

(def-meta-assoc-end "A_invariant_stateInvariant-stateInvariant" 
    :type |StateInvariant| 
    :multiplicity (0 1) 
    :association "A_invariant_stateInvariant" 
    :name "stateInvariant")

;;; =========================================================
;;; ====================== StateMachine
;;; =========================================================
(def-meta-class |StateMachine| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |StateMachines|) 
    :xmi-id "StateMachine")
 "StateMachines can be used to express event-driven behaviors of parts of
  a system. Behavior is modeled as a traversal of a graph of Vertices interconnected
  by one or more joined Transition arcs that are triggered by the dispatching
  of successive Event occurrences. During this traversal, the StateMachine
  may execute a sequence of Behaviors associated with various elements of
  the StateMachine."
  ((|connectionPoint| :xmi-id "StateMachine-connectionPoint" :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Pseudostate| |stateMachine|)
    :documentation
     "The connection points defined for this StateMachine. They represent the
      interface of the StateMachine when used as part of submachine State")
   (|extendedStateMachine| :xmi-id "StateMachine-extendedStateMachine" :range |StateMachine| :multiplicity (0 -1)
    :documentation
     "The StateMachines of which this is an extension." :redefined-property (|Behavior| |redefinedBehavior|))
   (|region| :xmi-id "StateMachine-region" :range |Region| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |stateMachine|)
    :documentation
     "The Regions owned directly by the StateMachine.")
   (|submachineState| :xmi-id "StateMachine-submachineState" :range |State| :multiplicity (0 -1)
    :opposite (|State| |submachine|)
    :documentation
     "References the submachine(s) in case of a submachine State. Multiple machines
      are referenced in case of a concurrent State.")))

(def-meta-operation "LCA" |StateMachine| 
   "The operation LCA(s1,s2) returns the Region that is the least common ancestor
    of Vertices s1 and s2, based on the StateMachine containment hierarchy."
   :operation-body
   "result = (if ancestor(s1, s2) then       s2.container  else   if ancestor(s2, s1) then       s1.container    else        LCA(s1.container.state, s2.container.state)   endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Region|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|Vertex|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|Vertex|
                        :parameter-return-p NIL))
)

(def-meta-operation "LCAState" |StateMachine| 
   "This utility funciton is like the LCA, except that it returns the nearest
    composite State that contains both input Vertices."
   :operation-body
   "result = (if v2.oclIsTypeOf(State) and ancestor(v1, v2) then   v2.oclAsType(State)  else if v1.oclIsTypeOf(State) and ancestor(v2, v1) then   v1.oclAsType(State)  else if (v1.container.state->isEmpty() or v2.container.state->isEmpty()) then    null.oclAsType(State)  else LCAState(v1.container.state, v2.container.state)  endif endif endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|State|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|v1| :parameter-type '|Vertex|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|v2| :parameter-type '|Vertex|
                        :parameter-return-p NIL))
)

(def-meta-operation "ancestor" |StateMachine| 
   "The query ancestor(s1, s2) checks whether Vertex s2 is an ancestor of Vertex
    s1."
   :operation-body
   "result = (if (s2 = s1) then    true   else    if s1.container.stateMachine->notEmpty() then        true   else        if s2.container.stateMachine->notEmpty() then            false       else           ancestor(s1, s2.container.state)        endif    endif  endif  )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|Vertex|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|Vertex|
                        :parameter-return-p NIL))
)

(def-meta-operation "isConsistentWith" |StateMachine| 
   "The query isConsistentWith() specifies that a redefining StateMachine is
    consistent with a redefined StateMachine provided that the redefining StateMachine
    is an extension of the redefined StateMachine : Regions are inherited and
    Regions can be added, inherited Regions can be redefined. In case of multiple
    redefining StateMachine, extension implies that the redefining StateMachine
    gets orthogonal Regions for each of the redefined StateMachine."
   :operation-body
   "result = (-- the following is merely a default body; it is expected that the specific form of this constraint will be specified by profiles  true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isRedefinitionContextValid" |StateMachine| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    context of a StateMachine is properly related to the redefinition contexts
    of the specified StateMachine to allow this element to redefine the other.
    The context Classifier of a redefining StateMachine must redefine the context
    Classifier of the redefined StateMachine."
   :operation-body
   "result = (if redefinedElement.oclIsKindOf(StateMachine) then    let redefinedStateMachine : StateMachine = redefinedElement.oclAsType(StateMachine) in      self._'context'().oclAsType(BehavioredClassifier).redefinedClassifier->        includes(redefinedStateMachine._'context'())  else    false  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinedElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_connectionPoint_stateMachine"      
  :name |A_connectionPoint_stateMachine|      
  :metatype :association      
  :member-ends ((|StateMachine| "connectionPoint")
                (|Pseudostate| "stateMachine"))      
  :owned-ends  ())

(def-meta-assoc "A_extendedStateMachine_stateMachine"      
  :name |A_extendedStateMachine_stateMachine|      
  :metatype :association      
  :member-ends ((|StateMachine| "extendedStateMachine")
                ("A_extendedStateMachine_stateMachine-stateMachine" "stateMachine"))      
  :owned-ends  (("A_extendedStateMachine_stateMachine-stateMachine" "stateMachine")))

(def-meta-assoc-end "A_extendedStateMachine_stateMachine-stateMachine" 
    :type |StateMachine| 
    :multiplicity (0 -1) 
    :association "A_extendedStateMachine_stateMachine" 
    :name "stateMachine")

(def-meta-assoc "A_region_stateMachine"      
  :name |A_region_stateMachine|      
  :metatype :association      
  :member-ends ((|StateMachine| "region")
                (|Region| "stateMachine"))      
  :owned-ends  ())

(def-meta-assoc "A_submachineState_submachine"      
  :name |A_submachineState_submachine|      
  :metatype :association      
  :member-ends ((|StateMachine| "submachineState")
                (|State| "submachine"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Stereotype
;;; =========================================================
(def-meta-class |Stereotype| 
   (:model :UML25 :superclasses (|Class|) 
    :packages (UML |Packages|) 
    :xmi-id "Stereotype")
 "A stereotype defines how an existing metaclass may be extended, and enables
  the use of platform or domain specific terminology or notation in place
  of, or in addition to, the ones used for the extended metaclass."
  ((|icon| :xmi-id "Stereotype-icon" :range |Image| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Stereotype can change the graphical appearance of the extended model element
      by using attached icons. When this association is not null, it references
      the location of the icon content to be displayed within diagrams presenting
      the extended model elements.")
   (|profile| :xmi-id "Stereotype-profile" :range |Profile| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The profile that directly or indirectly contains this stereotype.")))

;POD 
(def-meta-operation "containingProfile" |Stereotype| 
   "The query containingProfile returns the closest profile directly or indirectly
    containing this stereotype."
   :operation-status :rewritten
   :editor-note "Rewritten to stop recursion if namespace is a Profile."
   :operation-body "if self.namespace.oclIsKindOf(Profile) 
                       then self.namespace 
                       else self.namespace.oclAsType(Package).containingProfile()
                    endif"
   :original-body "result = (self.namespace.oclAsType(Package).containingProfile())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-meta-operation "profile.1" |Stereotype| 
   "A stereotype must be contained, directly or indirectly, in a profile."
   :operation-body
   "result = (self.containingProfile())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-meta-assoc "A_icon_stereotype"      
  :name |A_icon_stereotype|      
  :metatype :association      
  :member-ends ((|Stereotype| "icon")
                ("A_icon_stereotype-stereotype" "stereotype"))      
  :owned-ends  (("A_icon_stereotype-stereotype" "stereotype")))

(def-meta-assoc-end "A_icon_stereotype-stereotype" 
    :type |Stereotype| 
    :multiplicity (0 1) 
    :association "A_icon_stereotype" 
    :name "stereotype")

(def-meta-assoc "A_profile_stereotype"      
  :name |A_profile_stereotype|      
  :metatype :association      
  :member-ends ((|Stereotype| "profile")
                ("A_profile_stereotype-stereotype" "stereotype"))      
  :owned-ends  (("A_profile_stereotype-stereotype" "stereotype")))

(def-meta-assoc-end "A_profile_stereotype-stereotype" 
    :type |Stereotype| 
    :multiplicity (0 -1) 
    :association "A_profile_stereotype" 
    :name "stereotype")

;;; =========================================================
;;; ====================== StringExpression
;;; =========================================================
(def-meta-class |StringExpression| 
   (:model :UML25 :superclasses (|TemplateableElement| |Expression|) 
    :packages (UML |Values|) 
    :xmi-id "StringExpression")
 "A StringExpression is an Expression that specifies a String value that
  is derived by concatenating a sequence of operands with String values or
  a sequence of subExpressions, some of which might be template parameters."
  ((|owningExpression| :xmi-id "StringExpression-owningExpression" :range |StringExpression| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|StringExpression| |subExpression|)
    :documentation
     "The StringExpression of which this StringExpression is a subExpression.")
   (|subExpression| :xmi-id "StringExpression-subExpression" :range |StringExpression| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|StringExpression| |owningExpression|)
    :documentation
     "The StringExpressions that constitute this StringExpression.")))

(def-meta-operation "stringValue" |StringExpression| 
   "The query stringValue() returns the String resulting from concatenating,
    in order, all the component String values of all the operands or subExpressions
    that are part of the StringExpression."
   :operation-body
   "result = (if subExpression->notEmpty() then subExpression->iterate(se; stringValue: String = '' | stringValue.concat(se.stringValue())) else operand->iterate(op; stringValue: String = '' | stringValue.concat(op.stringValue())) endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-assoc "A_subExpression_owningExpression"      
  :name |A_subExpression_owningExpression|      
  :metatype :association      
  :member-ends ((|StringExpression| "subExpression")
                (|StringExpression| "owningExpression"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== StructuralFeature
;;; =========================================================
(def-meta-class |StructuralFeature| 
   (:model :UML25 :superclasses (|MultiplicityElement| |TypedElement| |Feature|) 
    :packages (UML |Classification|) 
    :xmi-id "StructuralFeature")
 "A StructuralFeature is a typed feature of a Classifier that specifies the
  structure of instances of the Classifier."
  ((|isReadOnly| :xmi-id "StructuralFeature-isReadOnly" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isReadOnly is true, the StructuralFeature may not be written to after
      initialization.")))

;;; =========================================================
;;; ====================== StructuralFeatureAction
;;; =========================================================
(def-meta-class |StructuralFeatureAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "StructuralFeatureAction")
 "StructuralFeatureAction is an abstract class for all Actions that operate
  on StructuralFeatures."
  ((|object| :xmi-id "StructuralFeatureAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin from which the object whose StructuralFeature is to be read
      or written is obtained.")
   (|structuralFeature| :xmi-id "StructuralFeatureAction-structuralFeature" :range |StructuralFeature| :multiplicity (1 1)
    :documentation
     "The StructuralFeature to be read or written.")))

(def-meta-assoc "A_object_structuralFeatureAction"      
  :name |A_object_structuralFeatureAction|      
  :metatype :association      
  :member-ends ((|StructuralFeatureAction| "object")
                ("A_object_structuralFeatureAction-structuralFeatureAction" "structuralFeatureAction"))      
  :owned-ends  (("A_object_structuralFeatureAction-structuralFeatureAction" "structuralFeatureAction")))

(def-meta-assoc-end "A_object_structuralFeatureAction-structuralFeatureAction" 
    :type |StructuralFeatureAction| 
    :multiplicity (0 1) 
    :association "A_object_structuralFeatureAction" 
    :name "structuralFeatureAction")

(def-meta-assoc "A_structuralFeature_structuralFeatureAction"      
  :name |A_structuralFeature_structuralFeatureAction|      
  :metatype :association      
  :member-ends ((|StructuralFeatureAction| "structuralFeature")
                ("A_structuralFeature_structuralFeatureAction-structuralFeatureAction" "structuralFeatureAction"))      
  :owned-ends  (("A_structuralFeature_structuralFeatureAction-structuralFeatureAction" "structuralFeatureAction")))

(def-meta-assoc-end "A_structuralFeature_structuralFeatureAction-structuralFeatureAction" 
    :type |StructuralFeatureAction| 
    :multiplicity (0 -1) 
    :association "A_structuralFeature_structuralFeatureAction" 
    :name "structuralFeatureAction")

;;; =========================================================
;;; ====================== StructuredActivityNode
;;; =========================================================
(def-meta-class |StructuredActivityNode| 
   (:model :UML25 :superclasses (|Namespace| |ActivityGroup| |Action|) 
    :packages (UML |Actions|) 
    :xmi-id "StructuredActivityNode")
 "A StructuredActivityNode is an Action that is also an ActivityGroup and
  whose behavior is specified by the ActivityNodes and ActivityEdges it so
  contains. Unlike other kinds of ActivityGroup, a StructuredActivityNode
  owns the ActivityNodes and ActivityEdges it contains, and so a node or
  edge can only be directly contained in one StructuredActivityNode, though
  StructuredActivityNodes may be nested."
  ((|activity| :xmi-id "StructuredActivityNode-activity" :range |Activity| :multiplicity (0 1)
    :opposite (|Activity| |structuredNode|)
    :documentation
     "The Activity immediately containing the StructuredActivityNode, if it is
      not contained in another StructuredActivityNode." :redefined-property (|ActivityGroup| |inActivity|))
   (|edge| :xmi-id "StructuredActivityNode-edge" :range |ActivityEdge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |containedEdge|) (|Element| |ownedElement|))
    :opposite (|ActivityEdge| |inStructuredNode|)
    :documentation
     "The ActivityEdges immediately contained in the StructuredActivityNode.")
   (|mustIsolate| :xmi-id "StructuredActivityNode-mustIsolate" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, then any object used by an Action within the StructuredActivityNode
      cannot be accessed by any Action outside the node until the StructuredActivityNode
      as a whole completes. Any concurrent Actions that would result in accessing
      such objects are required to have their execution deferred until the completion
      of the StructuredActivityNode.")
   (|node| :xmi-id "StructuredActivityNode-node" :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |containedNode|) (|Element| |ownedElement|))
    :opposite (|ActivityNode| |inStructuredNode|)
    :documentation
     "The ActivityNodes immediately contained in the StructuredActivityNode.")
   (|structuredNodeInput| :xmi-id "StructuredActivityNode-structuredNodeInput" :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPins owned by the StructuredActivityNode.")
   (|structuredNodeOutput| :xmi-id "StructuredActivityNode-structuredNodeOutput" :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPins owned by the StructuredActivityNode.")
   (|variable| :xmi-id "StructuredActivityNode-variable" :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |scope|)
    :documentation
     "The Variables defined in the scope of the StructuredActivityNode.")))

(def-meta-operation "allActions" |StructuredActivityNode| 
   "Returns this StructuredActivityNode and all Actions contained in it."
   :operation-body
   "result = (node->select(oclIsKindOf(Action)).oclAsType(Action).allActions()->including(self)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Action|
                        :parameter-return-p T))
)

(def-meta-operation "allOwnedNodes" |StructuredActivityNode| 
   "Returns all the ActivityNodes contained directly or indirectly within this
    StructuredActivityNode, in addition to the Pins of the StructuredActivityNode."
   :operation-body
   "result = (self.Action::allOwnedNodes()->union(node)->union(node->select(oclIsKindOf(Action)).oclAsType(Action).allOwnedNodes())->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ActivityNode|
                        :parameter-return-p T))
)

(def-meta-operation "containingActivity" |StructuredActivityNode| 
   "The Activity that directly or indirectly contains this StructuredActivityNode
    (considered as an Action)."
   :operation-body
   "result = (self.Action::containingActivity())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Activity|
                        :parameter-return-p T))
)

(def-meta-operation "sourceNodes" |StructuredActivityNode| 
   "Return those ActivityNodes contained immediately within the StructuredActivityNode
    that may act as sources of edges owned by the StructuredActivityNode."
   :operation-body
   "result = (node->union(input.oclAsType(ActivityNode)->asSet())->    union(node->select(oclIsKindOf(Action)).oclAsType(Action).output)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ActivityNode|
                        :parameter-return-p T))
)

(def-meta-operation "targetNodes" |StructuredActivityNode| 
   "Return those ActivityNodes contained immediately within the StructuredActivityNode
    that may act as targets of edges owned by the StructuredActivityNode."
   :operation-body
   "result = (node->union(output.oclAsType(ActivityNode)->asSet())->    union(node->select(oclIsKindOf(Action)).oclAsType(Action).input)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ActivityNode|
                        :parameter-return-p T))
)

(def-meta-assoc "A_edge_inStructuredNode"      
  :name |A_edge_inStructuredNode|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "edge")
                (|ActivityEdge| "inStructuredNode"))      
  :owned-ends  ())

(def-meta-assoc "A_node_inStructuredNode"      
  :name |A_node_inStructuredNode|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "node")
                (|ActivityNode| "inStructuredNode"))      
  :owned-ends  ())

(def-meta-assoc "A_structuredNodeInput_structuredActivityNode"      
  :name |A_structuredNodeInput_structuredActivityNode|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "structuredNodeInput")
                ("A_structuredNodeInput_structuredActivityNode-structuredActivityNode" "structuredActivityNode"))      
  :owned-ends  (("A_structuredNodeInput_structuredActivityNode-structuredActivityNode" "structuredActivityNode")))

(def-meta-assoc-end "A_structuredNodeInput_structuredActivityNode-structuredActivityNode" 
    :type |StructuredActivityNode| 
    :multiplicity (0 1) 
    :association "A_structuredNodeInput_structuredActivityNode" 
    :name "structuredActivityNode")

(def-meta-assoc "A_structuredNodeOutput_structuredActivityNode"      
  :name |A_structuredNodeOutput_structuredActivityNode|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "structuredNodeOutput")
                ("A_structuredNodeOutput_structuredActivityNode-structuredActivityNode" "structuredActivityNode"))      
  :owned-ends  (("A_structuredNodeOutput_structuredActivityNode-structuredActivityNode" "structuredActivityNode")))

(def-meta-assoc-end "A_structuredNodeOutput_structuredActivityNode-structuredActivityNode" 
    :type |StructuredActivityNode| 
    :multiplicity (0 1) 
    :association "A_structuredNodeOutput_structuredActivityNode" 
    :name "structuredActivityNode")

(def-meta-assoc "A_variable_scope"      
  :name |A_variable_scope|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "variable")
                (|Variable| "scope"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== StructuredClassifier
;;; =========================================================
(def-meta-class |StructuredClassifier| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "StructuredClassifier")
 "StructuredClassifiers may contain an internal structure of connected elements
  each of which plays a role in the overall Behavior modeled by the StructuredClassifier."
  ((|ownedAttribute| :xmi-id "StructuredClassifier-ownedAttribute" :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|) (|StructuredClassifier| |role|))
    :documentation
     "The Properties owned by the StructuredClassifier.")
   (|ownedConnector| :xmi-id "StructuredClassifier-ownedConnector" :range |Connector| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "The connectors owned by the StructuredClassifier.")
   (|part| :xmi-id "StructuredClassifier-part" :range |Property| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "The Properties specifying instances that the StructuredClassifier owns
      by composition. This collection is derived, selecting those owned Properties
      where isComposite is true.")
   (|role| :xmi-id "StructuredClassifier-role" :range |ConnectableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "The roles that instances may play in this StructuredClassifier.")))

(def-meta-operation "allRoles" |StructuredClassifier| 
   "All features of type ConnectableElement, equivalent to all direct and inherited
    roles."
   :operation-body
   "result = (allFeatures()->select(oclIsKindOf(ConnectableElement))->collect(oclAsType(ConnectableElement))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectableElement|
                        :parameter-return-p T))
)

(def-meta-operation "part.1" |StructuredClassifier| 
   "Derivation for StructuredClassifier::/part"
   :operation-body
   "result = (ownedAttribute->select(isComposite))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-assoc "A_ownedAttribute_structuredClassifier"      
  :name |A_ownedAttribute_structuredClassifier|      
  :metatype :association      
  :member-ends ((|StructuredClassifier| "ownedAttribute")
                ("A_ownedAttribute_structuredClassifier-structuredClassifier" "structuredClassifier"))      
  :owned-ends  (("A_ownedAttribute_structuredClassifier-structuredClassifier" "structuredClassifier")))

(def-meta-assoc-end "A_ownedAttribute_structuredClassifier-structuredClassifier" 
    :type |StructuredClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedAttribute_structuredClassifier" 
    :name "structuredClassifier")

(def-meta-assoc "A_ownedConnector_structuredClassifier"      
  :name |A_ownedConnector_structuredClassifier|      
  :metatype :association      
  :member-ends ((|StructuredClassifier| "ownedConnector")
                ("A_ownedConnector_structuredClassifier-structuredClassifier" "structuredClassifier"))      
  :owned-ends  (("A_ownedConnector_structuredClassifier-structuredClassifier" "structuredClassifier")))

(def-meta-assoc-end "A_ownedConnector_structuredClassifier-structuredClassifier" 
    :type |StructuredClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedConnector_structuredClassifier" 
    :name "structuredClassifier")

(def-meta-assoc "A_part_structuredClassifier"      
  :name |A_part_structuredClassifier|      
  :metatype :association      
  :member-ends ((|StructuredClassifier| "part")
                ("A_part_structuredClassifier-structuredClassifier" "structuredClassifier"))      
  :owned-ends  (("A_part_structuredClassifier-structuredClassifier" "structuredClassifier")))

(def-meta-assoc-end "A_part_structuredClassifier-structuredClassifier" 
    :type |StructuredClassifier| 
    :multiplicity (0 1) 
    :association "A_part_structuredClassifier" 
    :name "structuredClassifier")

(def-meta-assoc "A_role_structuredClassifier"      
  :name |A_role_structuredClassifier|      
  :metatype :association      
  :member-ends ((|StructuredClassifier| "role")
                ("A_role_structuredClassifier-structuredClassifier" "structuredClassifier"))      
  :owned-ends  (("A_role_structuredClassifier-structuredClassifier" "structuredClassifier")))

(def-meta-assoc-end "A_role_structuredClassifier-structuredClassifier" 
    :type |StructuredClassifier| 
    :multiplicity (0 -1) 
    :association "A_role_structuredClassifier" 
    :name "structuredClassifier")

;;; =========================================================
;;; ====================== Substitution
;;; =========================================================
(def-meta-class |Substitution| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |Classification|) 
    :xmi-id "Substitution")
 "A substitution is a relationship between two classifiers signifying that
  the substituting classifier complies with the contract specified by the
  contract classifier. This implies that instances of the substituting classifier
  are runtime substitutable where instances of the contract classifier are
  expected."
  ((|contract| :xmi-id "Substitution-contract" :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "The contract with which the substituting classifier complies.")
   (|substitutingClassifier| :xmi-id "Substitution-substitutingClassifier" :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|Classifier| |substitution|)
    :documentation
     "Instances of the substituting classifier are runtime substitutable where
      instances of the contract classifier are expected.")))

(def-meta-assoc "A_contract_substitution"      
  :name |A_contract_substitution|      
  :metatype :association      
  :member-ends ((|Substitution| "contract")
                ("A_contract_substitution-substitution" "substitution"))      
  :owned-ends  (("A_contract_substitution-substitution" "substitution")))

(def-meta-assoc-end "A_contract_substitution-substitution" 
    :type |Substitution| 
    :multiplicity (0 -1) 
    :association "A_contract_substitution" 
    :name "substitution")

;;; =========================================================
;;; ====================== TemplateBinding
;;; =========================================================
(def-meta-class |TemplateBinding| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TemplateBinding")
 "A TemplateBinding is a DirectedRelationship between a TemplateableElement
  and a template. A TemplateBinding specifies the TemplateParameterSubstitutions
  of actual parameters for the formal parameters of the template."
  ((|boundElement| :xmi-id "TemplateBinding-boundElement" :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|TemplateableElement| |templateBinding|)
    :documentation
     "The TemplateableElement that is bound by this TemplateBinding.")
   (|parameterSubstitution| :xmi-id "TemplateBinding-parameterSubstitution" :range |TemplateParameterSubstitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateParameterSubstitution| |templateBinding|)
    :documentation
     "The TemplateParameterSubstitutions owned by this TemplateBinding.")
   (|signature| :xmi-id "TemplateBinding-signature" :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The TemplateSignature for the template that is the target of this TemplateBinding.")))

(def-meta-assoc "A_parameterSubstitution_templateBinding"      
  :name |A_parameterSubstitution_templateBinding|      
  :metatype :association      
  :member-ends ((|TemplateBinding| "parameterSubstitution")
                (|TemplateParameterSubstitution| "templateBinding"))      
  :owned-ends  ())

(def-meta-assoc "A_signature_templateBinding"      
  :name |A_signature_templateBinding|      
  :metatype :association      
  :member-ends ((|TemplateBinding| "signature")
                ("A_signature_templateBinding-templateBinding" "templateBinding"))      
  :owned-ends  (("A_signature_templateBinding-templateBinding" "templateBinding")))

(def-meta-assoc-end "A_signature_templateBinding-templateBinding" 
    :type |TemplateBinding| 
    :multiplicity (0 -1) 
    :association "A_signature_templateBinding" 
    :name "templateBinding")

;;; =========================================================
;;; ====================== TemplateParameter
;;; =========================================================
(def-meta-class |TemplateParameter| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TemplateParameter")
 "A TemplateParameter exposes a ParameterableElement as a formal parameter
  of a template."
  ((|default| :xmi-id "TemplateParameter-default" :range |ParameterableElement| :multiplicity (0 1)
    :documentation
     "The ParameterableElement that is the default for this formal TemplateParameter.")
   (|ownedDefault| :xmi-id "TemplateParameter-ownedDefault" :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |default|))
    :documentation
     "The ParameterableElement that is owned by this TemplateParameter for the
      purpose of providing a default.")
   (|ownedParameteredElement| :xmi-id "TemplateParameter-ownedParameteredElement" :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |parameteredElement|))
    :opposite (|ParameterableElement| |owningTemplateParameter|)
    :documentation
     "The ParameterableElement that is owned by this TemplateParameter for the
      purpose of exposing it as the parameteredElement.")
   (|parameteredElement| :xmi-id "TemplateParameter-parameteredElement" :range |ParameterableElement| :multiplicity (1 1)
    :opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The ParameterableElement exposed by this TemplateParameter.")
   (|signature| :xmi-id "TemplateParameter-signature" :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateSignature| |ownedParameter|)
    :documentation
     "The TemplateSignature that owns this TemplateParameter.")))

(def-meta-assoc "A_default_templateParameter"      
  :name |A_default_templateParameter|      
  :metatype :association      
  :member-ends ((|TemplateParameter| "default")
                ("A_default_templateParameter-templateParameter" "templateParameter"))      
  :owned-ends  (("A_default_templateParameter-templateParameter" "templateParameter")))

(def-meta-assoc-end "A_default_templateParameter-templateParameter" 
    :type |TemplateParameter| 
    :multiplicity (0 -1) 
    :association "A_default_templateParameter" 
    :name "templateParameter")

(def-meta-assoc "A_ownedDefault_templateParameter"      
  :name |A_ownedDefault_templateParameter|      
  :metatype :association      
  :member-ends ((|TemplateParameter| "ownedDefault")
                ("A_ownedDefault_templateParameter-templateParameter" "templateParameter"))      
  :owned-ends  (("A_ownedDefault_templateParameter-templateParameter" "templateParameter")))

(def-meta-assoc-end "A_ownedDefault_templateParameter-templateParameter" 
    :type |TemplateParameter| 
    :multiplicity (0 1) 
    :association "A_ownedDefault_templateParameter" 
    :name "templateParameter")

(def-meta-assoc "A_ownedParameteredElement_owningTemplateParameter"      
  :name |A_ownedParameteredElement_owningTemplateParameter|      
  :metatype :association      
  :member-ends ((|TemplateParameter| "ownedParameteredElement")
                (|ParameterableElement| "owningTemplateParameter"))      
  :owned-ends  ())

(def-meta-assoc "A_parameteredElement_templateParameter"      
  :name |A_parameteredElement_templateParameter|      
  :metatype :association      
  :member-ends ((|TemplateParameter| "parameteredElement")
                (|ParameterableElement| "templateParameter"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== TemplateParameterSubstitution
;;; =========================================================
(def-meta-class |TemplateParameterSubstitution| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TemplateParameterSubstitution")
 "A TemplateParameterSubstitution relates the actual parameter to a formal
  TemplateParameter as part of a template binding."
  ((|actual| :xmi-id "TemplateParameterSubstitution-actual" :range |ParameterableElement| :multiplicity (1 1)
    :documentation
     "The ParameterableElement that is the actual parameter for this TemplateParameterSubstitution.")
   (|formal| :xmi-id "TemplateParameterSubstitution-formal" :range |TemplateParameter| :multiplicity (1 1)
    :documentation
     "The formal TemplateParameter that is associated with this TemplateParameterSubstitution.")
   (|ownedActual| :xmi-id "TemplateParameterSubstitution-ownedActual" :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameterSubstitution| |actual|))
    :documentation
     "The ParameterableElement that is owned by this TemplateParameterSubstitution
      as its actual parameter.")
   (|templateBinding| :xmi-id "TemplateParameterSubstitution-templateBinding" :range |TemplateBinding| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateBinding| |parameterSubstitution|)
    :documentation
     "The TemplateBinding that owns this TemplateParameterSubstitution.")))

(def-meta-assoc "A_actual_templateParameterSubstitution"      
  :name |A_actual_templateParameterSubstitution|      
  :metatype :association      
  :member-ends ((|TemplateParameterSubstitution| "actual")
                ("A_actual_templateParameterSubstitution-templateParameterSubstitution" "templateParameterSubstitution"))      
  :owned-ends  (("A_actual_templateParameterSubstitution-templateParameterSubstitution" "templateParameterSubstitution")))

(def-meta-assoc-end "A_actual_templateParameterSubstitution-templateParameterSubstitution" 
    :type |TemplateParameterSubstitution| 
    :multiplicity (0 -1) 
    :association "A_actual_templateParameterSubstitution" 
    :name "templateParameterSubstitution")

(def-meta-assoc "A_formal_templateParameterSubstitution"      
  :name |A_formal_templateParameterSubstitution|      
  :metatype :association      
  :member-ends ((|TemplateParameterSubstitution| "formal")
                ("A_formal_templateParameterSubstitution-templateParameterSubstitution" "templateParameterSubstitution"))      
  :owned-ends  (("A_formal_templateParameterSubstitution-templateParameterSubstitution" "templateParameterSubstitution")))

(def-meta-assoc-end "A_formal_templateParameterSubstitution-templateParameterSubstitution" 
    :type |TemplateParameterSubstitution| 
    :multiplicity (0 -1) 
    :association "A_formal_templateParameterSubstitution" 
    :name "templateParameterSubstitution")

(def-meta-assoc "A_ownedActual_owningTemplateParameterSubstitution"      
  :name |A_ownedActual_owningTemplateParameterSubstitution|      
  :metatype :association      
  :member-ends ((|TemplateParameterSubstitution| "ownedActual")
                ("A_ownedActual_owningTemplateParameterSubstitution-owningTemplateParameterSubstitution" "owningTemplateParameterSubstitution"))      
  :owned-ends  (("A_ownedActual_owningTemplateParameterSubstitution-owningTemplateParameterSubstitution" "owningTemplateParameterSubstitution")))

(def-meta-assoc-end "A_ownedActual_owningTemplateParameterSubstitution-owningTemplateParameterSubstitution" 
    :type |TemplateParameterSubstitution| 
    :multiplicity (0 1) 
    :association "A_ownedActual_owningTemplateParameterSubstitution" 
    :name "owningTemplateParameterSubstitution")

;;; =========================================================
;;; ====================== TemplateSignature
;;; =========================================================
(def-meta-class |TemplateSignature| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TemplateSignature")
 "A Template Signature bundles the set of formal TemplateParameters for a
  template."
  ((|ownedParameter| :xmi-id "TemplateSignature-ownedParameter" :range |TemplateParameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateSignature| |parameter|))
    :opposite (|TemplateParameter| |signature|)
    :documentation
     "The formal parameters that are owned by this TemplateSignature.")
   (|parameter| :xmi-id "TemplateSignature-parameter" :range |TemplateParameter| :multiplicity (1 -1) :is-ordered-p T
    :documentation
     "The ordered set of all formal TemplateParameters for this TemplateSignature.")
   (|template| :xmi-id "TemplateSignature-template" :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateableElement| |ownedTemplateSignature|)
    :documentation
     "The TemplateableElement that owns this TemplateSignature.")))

(def-meta-assoc "A_ownedParameter_signature"      
  :name |A_ownedParameter_signature|      
  :metatype :association      
  :member-ends ((|TemplateSignature| "ownedParameter")
                (|TemplateParameter| "signature"))      
  :owned-ends  ())

(def-meta-assoc "A_parameter_templateSignature"      
  :name |A_parameter_templateSignature|      
  :metatype :association      
  :member-ends ((|TemplateSignature| "parameter")
                ("A_parameter_templateSignature-templateSignature" "templateSignature"))      
  :owned-ends  (("A_parameter_templateSignature-templateSignature" "templateSignature")))

(def-meta-assoc-end "A_parameter_templateSignature-templateSignature" 
    :type |TemplateSignature| 
    :multiplicity (0 -1) 
    :association "A_parameter_templateSignature" 
    :name "templateSignature")

;;; =========================================================
;;; ====================== TemplateableElement
;;; =========================================================
(def-meta-class |TemplateableElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TemplateableElement")
 "A TemplateableElement is an Element that can optionally be defined as a
  template and bound to other templates."
  ((|ownedTemplateSignature| :xmi-id "TemplateableElement-ownedTemplateSignature" :range |TemplateSignature| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateSignature| |template|)
    :documentation
     "The optional TemplateSignature specifying the formal TemplateParameters
      for this TemplateableElement. If a TemplateableElement has a TemplateSignature,
      then it is a template.")
   (|templateBinding| :xmi-id "TemplateableElement-templateBinding" :range |TemplateBinding| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateBinding| |boundElement|)
    :documentation
     "The optional TemplateBindings from this TemplateableElement to one or more
      templates.")))

(def-meta-operation "isTemplate" |TemplateableElement| 
   "The query isTemplate() returns whether this TemplateableElement is actually
    a template."
   :operation-body
   "result = (ownedTemplateSignature <> null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "parameterableElements" |TemplateableElement| 
   "The query parameterableElements() returns the set of ParameterableElements
    that may be used as the parameteredElements for a TemplateParameter of
    this TemplateableElement. By default, this set includes all the ownedElements.
    Subclasses may override this operation if they choose to restrict the set
    of ParameterableElements."
   :operation-body
   "result = (self.allOwnedElements()->select(oclIsKindOf(ParameterableElement)).oclAsType(ParameterableElement)->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ParameterableElement|
                        :parameter-return-p T))
)

(def-meta-assoc "A_ownedTemplateSignature_template"      
  :name |A_ownedTemplateSignature_template|      
  :metatype :association      
  :member-ends ((|TemplateableElement| "ownedTemplateSignature")
                (|TemplateSignature| "template"))      
  :owned-ends  ())

(def-meta-assoc "A_templateBinding_boundElement"      
  :name |A_templateBinding_boundElement|      
  :metatype :association      
  :member-ends ((|TemplateableElement| "templateBinding")
                (|TemplateBinding| "boundElement"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== TestIdentityAction
;;; =========================================================
(def-meta-class |TestIdentityAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "TestIdentityAction")
 "A TestIdentityAction is an Action that tests if two values are identical
  objects."
  ((|first| :xmi-id "TestIdentityAction-first" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin on which the first input object is placed.")
   (|result| :xmi-id "TestIdentityAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin whose Boolean value indicates whether the two input objects
      are identical.")
   (|second| :xmi-id "TestIdentityAction-second" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The OutputPin on which the second input object is placed.")))

(def-meta-assoc "A_first_testIdentityAction"      
  :name |A_first_testIdentityAction|      
  :metatype :association      
  :member-ends ((|TestIdentityAction| "first")
                ("A_first_testIdentityAction-testIdentityAction" "testIdentityAction"))      
  :owned-ends  (("A_first_testIdentityAction-testIdentityAction" "testIdentityAction")))

(def-meta-assoc-end "A_first_testIdentityAction-testIdentityAction" 
    :type |TestIdentityAction| 
    :multiplicity (0 1) 
    :association "A_first_testIdentityAction" 
    :name "testIdentityAction")

(def-meta-assoc "A_result_testIdentityAction"      
  :name |A_result_testIdentityAction|      
  :metatype :association      
  :member-ends ((|TestIdentityAction| "result")
                ("A_result_testIdentityAction-testIdentityAction" "testIdentityAction"))      
  :owned-ends  (("A_result_testIdentityAction-testIdentityAction" "testIdentityAction")))

(def-meta-assoc-end "A_result_testIdentityAction-testIdentityAction" 
    :type |TestIdentityAction| 
    :multiplicity (0 1) 
    :association "A_result_testIdentityAction" 
    :name "testIdentityAction")

(def-meta-assoc "A_second_testIdentityAction"      
  :name |A_second_testIdentityAction|      
  :metatype :association      
  :member-ends ((|TestIdentityAction| "second")
                ("A_second_testIdentityAction-testIdentityAction" "testIdentityAction"))      
  :owned-ends  (("A_second_testIdentityAction-testIdentityAction" "testIdentityAction")))

(def-meta-assoc-end "A_second_testIdentityAction-testIdentityAction" 
    :type |TestIdentityAction| 
    :multiplicity (0 1) 
    :association "A_second_testIdentityAction" 
    :name "testIdentityAction")

;;; =========================================================
;;; ====================== TimeConstraint
;;; =========================================================
(def-meta-class |TimeConstraint| 
   (:model :UML25 :superclasses (|IntervalConstraint|) 
    :packages (UML |Values|) 
    :xmi-id "TimeConstraint")
 "A TimeConstraint is a Constraint that refers to a TimeInterval."
  ((|firstEvent| :xmi-id "TimeConstraint-firstEvent" :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "The value of firstEvent is related to the constrainedElement. If firstEvent
      is true, then the corresponding observation event is the first time instant
      the execution enters the constrainedElement. If firstEvent is false, then
      the corresponding observation event is the last time instant the execution
      is within the constrainedElement.")
   (|specification| :xmi-id "TimeConstraint-specification" :range |TimeInterval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "TheTimeInterval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))

(def-meta-assoc "A_specification_timeConstraint"      
  :name |A_specification_timeConstraint|      
  :metatype :association      
  :member-ends ((|TimeConstraint| "specification")
                ("A_specification_timeConstraint-timeConstraint" "timeConstraint"))      
  :owned-ends  (("A_specification_timeConstraint-timeConstraint" "timeConstraint")))

(def-meta-assoc-end "A_specification_timeConstraint-timeConstraint" 
    :type |TimeConstraint| 
    :multiplicity (0 1) 
    :association "A_specification_timeConstraint" 
    :name "timeConstraint")

;;; =========================================================
;;; ====================== TimeEvent
;;; =========================================================
(def-meta-class |TimeEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "TimeEvent")
 "A TimeEvent is an Event that occurs at a specific point in time."
  ((|isRelative| :xmi-id "TimeEvent-isRelative" :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the TimeEvent is specified as an absolute or relative
      time.")
   (|when| :xmi-id "TimeEvent-when" :range |TimeExpression| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies the time of the TimeEvent.")))

(def-meta-assoc "A_when_timeEvent"      
  :name |A_when_timeEvent|      
  :metatype :association      
  :member-ends ((|TimeEvent| "when")
                ("A_when_timeEvent-timeEvent" "timeEvent"))      
  :owned-ends  (("A_when_timeEvent-timeEvent" "timeEvent")))

(def-meta-assoc-end "A_when_timeEvent-timeEvent" 
    :type |TimeEvent| 
    :multiplicity (0 1) 
    :association "A_when_timeEvent" 
    :name "timeEvent")

;;; =========================================================
;;; ====================== TimeExpression
;;; =========================================================
(def-meta-class |TimeExpression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "TimeExpression")
 "A TimeExpression is a ValueSpecification that represents a time value."
  ((|expr| :xmi-id "TimeExpression-expr" :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification that evaluates to the value of the TimeExpression.")
   (|observation| :xmi-id "TimeExpression-observation" :range |Observation| :multiplicity (0 -1)
    :documentation
     "Refers to the Observations that are involved in the computation of the
      TimeExpression value.")))

(def-meta-assoc "A_expr_timeExpression"      
  :name |A_expr_timeExpression|      
  :metatype :association      
  :member-ends ((|TimeExpression| "expr")
                ("A_expr_timeExpression-timeExpression" "timeExpression"))      
  :owned-ends  (("A_expr_timeExpression-timeExpression" "timeExpression")))

(def-meta-assoc-end "A_expr_timeExpression-timeExpression" 
    :type |TimeExpression| 
    :multiplicity (0 1) 
    :association "A_expr_timeExpression" 
    :name "timeExpression")

(def-meta-assoc "A_observation_timeExpression"      
  :name |A_observation_timeExpression|      
  :metatype :association      
  :member-ends ((|TimeExpression| "observation")
                ("A_observation_timeExpression-timeExpression" "timeExpression"))      
  :owned-ends  (("A_observation_timeExpression-timeExpression" "timeExpression")))

(def-meta-assoc-end "A_observation_timeExpression-timeExpression" 
    :type |TimeExpression| 
    :multiplicity (0 1) 
    :association "A_observation_timeExpression" 
    :name "timeExpression")

;;; =========================================================
;;; ====================== TimeInterval
;;; =========================================================
(def-meta-class |TimeInterval| 
   (:model :UML25 :superclasses (|Interval|) 
    :packages (UML |Values|) 
    :xmi-id "TimeInterval")
 "A TimeInterval defines the range between two TimeExpressions."
  ((|max| :xmi-id "TimeInterval-max" :range |TimeExpression| :multiplicity (1 1)
    :documentation
     "Refers to the TimeExpression denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :xmi-id "TimeInterval-min" :range |TimeExpression| :multiplicity (1 1)
    :documentation
     "Refers to the TimeExpression denoting the minimum value of the range." :redefined-property (|Interval| |min|))))

(def-meta-assoc "A_max_timeInterval"      
  :name |A_max_timeInterval|      
  :metatype :association      
  :member-ends ((|TimeInterval| "max")
                ("A_max_timeInterval-timeInterval" "timeInterval"))      
  :owned-ends  (("A_max_timeInterval-timeInterval" "timeInterval")))

(def-meta-assoc-end "A_max_timeInterval-timeInterval" 
    :type |TimeInterval| 
    :multiplicity (0 -1) 
    :association "A_max_timeInterval" 
    :name "timeInterval")

(def-meta-assoc "A_min_timeInterval"      
  :name |A_min_timeInterval|      
  :metatype :association      
  :member-ends ((|TimeInterval| "min")
                ("A_min_timeInterval-timeInterval" "timeInterval"))      
  :owned-ends  (("A_min_timeInterval-timeInterval" "timeInterval")))

(def-meta-assoc-end "A_min_timeInterval-timeInterval" 
    :type |TimeInterval| 
    :multiplicity (0 -1) 
    :association "A_min_timeInterval" 
    :name "timeInterval")

;;; =========================================================
;;; ====================== TimeObservation
;;; =========================================================
(def-meta-class |TimeObservation| 
   (:model :UML25 :superclasses (|Observation|) 
    :packages (UML |Values|) 
    :xmi-id "TimeObservation")
 "A TimeObservation is a reference to a time instant during an execution.
  It points out the NamedElement in the model to observe and whether the
  observation is when this NamedElement is entered or when it is exited."
  ((|event| :xmi-id "TimeObservation-event" :range |NamedElement| :multiplicity (1 1)
    :documentation
     "The TimeObservation is determined by the entering or exiting of the event
      Element during execution.")
   (|firstEvent| :xmi-id "TimeObservation-firstEvent" :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "The value of firstEvent is related to the event. If firstEvent is true,
      then the corresponding observation event is the first time instant the
      execution enters the event Element. If firstEvent is false, then the corresponding
      observation event is the time instant the execution exits the event Element.")))

(def-meta-assoc "A_event_timeObservation"      
  :name |A_event_timeObservation|      
  :metatype :association      
  :member-ends ((|TimeObservation| "event")
                ("A_event_timeObservation-timeObservation" "timeObservation"))      
  :owned-ends  (("A_event_timeObservation-timeObservation" "timeObservation")))

(def-meta-assoc-end "A_event_timeObservation-timeObservation" 
    :type |TimeObservation| 
    :multiplicity (0 -1) 
    :association "A_event_timeObservation" 
    :name "timeObservation")

;;; =========================================================
;;; ====================== Transition
;;; =========================================================
(def-meta-class |Transition| 
   (:model :UML25 :superclasses (|Namespace| |RedefinableElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "Transition")
 "A Transition represents an arc between exactly one source Vertex and exactly
  one Target vertex (the source and targets may be the same Vertex). It may
  form part of a compound transition, which takes the StateMachine from one
  steady State configuration to another, representing the full response of
  the StateMachine to an occurrence of an Event that triggered it."
  ((|container| :xmi-id "Transition-container" :range |Region| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |transition|)
    :documentation
     "Designates the Region that owns this Transition.")
   (|effect| :xmi-id "Transition-effect" :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies an optional behavior to be performed when the Transition fires.")
   (|guard| :xmi-id "Transition-guard" :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "A guard is a Constraint that provides a fine-grained control over the firing
      of the Transition. The guard is evaluated when an Event occurrence is dispatched
      by the StateMachine. If the guard is true at that time, the Transition
      may be enabled, otherwise, it is disabled. Guards should be pure expressions
      without side effects. Guard expressions with side effects are ill formed.")
   (|kind| :xmi-id "Transition-kind" :range |TransitionKind| :multiplicity (1 1) :default :external
    :documentation
     "Indicates the precise type of the Transition.")
   (|redefinedTransition| :xmi-id "Transition-redefinedTransition" :range |Transition| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The Transition that is redefined by this Transition.")
   (|redefinitionContext| :xmi-id "Transition-redefinitionContext" :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the Classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|source| :xmi-id "Transition-source" :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |outgoing|)
    :documentation
     "Designates the originating Vertex (State or Pseudostate) of the Transition.")
   (|target| :xmi-id "Transition-target" :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |incoming|)
    :documentation
     "Designates the target Vertex that is reached when the Transition is taken.")
   (|trigger| :xmi-id "Transition-trigger" :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies the Triggers that may fire the transition.")))

(def-meta-operation "containingStateMachine" |Transition| 
   "The query containingStateMachine() returns the StateMachine that contains
    the Transition either directly or transitively."
   :operation-body
   "result = (container.containingStateMachine())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Transition| 
   "The query isConsistentWith() specifies that a redefining Transition is
    consistent with a redefined Transition provided that the redefining Transition
    has the following relation to the redefined Transition: A redefining Transition
    redefines all properties of the corresponding redefined Transition except
    the source State and the Trigger."
   :operation-body
   "result = (-- the following is merely a default body; it is expected that the specific form of this constraint will be specified by profiles  true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefiningElement| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "redefinitionContext.1" |Transition| 
   "The redefinition context of a Transition is the nearest containing StateMachine."
   :operation-body
   "result = (let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-assoc "A_effect_transition"      
  :name |A_effect_transition|      
  :metatype :association      
  :member-ends ((|Transition| "effect")
                ("A_effect_transition-transition" "transition"))      
  :owned-ends  (("A_effect_transition-transition" "transition")))

(def-meta-assoc-end "A_effect_transition-transition" 
    :type |Transition| 
    :multiplicity (0 1) 
    :association "A_effect_transition" 
    :name "transition")

(def-meta-assoc "A_guard_transition"      
  :name |A_guard_transition|      
  :metatype :association      
  :member-ends ((|Transition| "guard")
                ("A_guard_transition-transition" "transition"))      
  :owned-ends  (("A_guard_transition-transition" "transition")))

(def-meta-assoc-end "A_guard_transition-transition" 
    :type |Transition| 
    :multiplicity (0 1) 
    :association "A_guard_transition" 
    :name "transition")

(def-meta-assoc "A_redefinedTransition_transition"      
  :name |A_redefinedTransition_transition|      
  :metatype :association      
  :member-ends ((|Transition| "redefinedTransition")
                ("A_redefinedTransition_transition-transition" "transition"))      
  :owned-ends  (("A_redefinedTransition_transition-transition" "transition")))

(def-meta-assoc-end "A_redefinedTransition_transition-transition" 
    :type |Transition| 
    :multiplicity (0 -1) 
    :association "A_redefinedTransition_transition" 
    :name "transition")

(def-meta-assoc "A_redefinitionContext_transition"      
  :name |A_redefinitionContext_transition|      
  :metatype :association      
  :member-ends ((|Transition| "redefinitionContext")
                ("A_redefinitionContext_transition-transition" "transition"))      
  :owned-ends  (("A_redefinitionContext_transition-transition" "transition")))

(def-meta-assoc-end "A_redefinitionContext_transition-transition" 
    :type |Transition| 
    :multiplicity (0 -1) 
    :association "A_redefinitionContext_transition" 
    :name "transition")

(def-meta-assoc "A_trigger_transition"      
  :name |A_trigger_transition|      
  :metatype :association      
  :member-ends ((|Transition| "trigger")
                ("A_trigger_transition-transition" "transition"))      
  :owned-ends  (("A_trigger_transition-transition" "transition")))

(def-meta-assoc-end "A_trigger_transition-transition" 
    :type |Transition| 
    :multiplicity (0 1) 
    :association "A_trigger_transition" 
    :name "transition")

;;; =========================================================
;;; ====================== Trigger
;;; =========================================================
(def-meta-class |Trigger| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "Trigger")
 "A Trigger specifies a specific point  at which an Event occurrence may
  trigger an effect in a Behavior. A Trigger may be qualified by the Port
  on which the Event occurred."
  ((|event| :xmi-id "Trigger-event" :range |Event| :multiplicity (1 1)
    :documentation
     "The Event that detected by the Trigger.")
   (|port| :xmi-id "Trigger-port" :range |Port| :multiplicity (0 -1)
    :documentation
     "A optional Port of through which the given effect is detected.")))

(def-meta-assoc "A_event_trigger"      
  :name |A_event_trigger|      
  :metatype :association      
  :member-ends ((|Trigger| "event")
                ("A_event_trigger-trigger" "trigger"))      
  :owned-ends  (("A_event_trigger-trigger" "trigger")))

(def-meta-assoc-end "A_event_trigger-trigger" 
    :type |Trigger| 
    :multiplicity (0 -1) 
    :association "A_event_trigger" 
    :name "trigger")

(def-meta-assoc "A_port_trigger"      
  :name |A_port_trigger|      
  :metatype :association      
  :member-ends ((|Trigger| "port")
                ("A_port_trigger-trigger" "trigger"))      
  :owned-ends  (("A_port_trigger-trigger" "trigger")))

(def-meta-assoc-end "A_port_trigger-trigger" 
    :type |Trigger| 
    :multiplicity (0 -1) 
    :association "A_port_trigger" 
    :name "trigger")

;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-meta-class |Type| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Type")
 "A Type constrains the values represented by a TypedElement."
  ((|package| :xmi-id "Type-package" :range |Package| :multiplicity (0 1)
    :opposite (|Package| |ownedType|)
    :documentation
     "Specifies the owning Package of this Type, if any.")))

(def-meta-operation "conformsTo" |Type| 
   "The query conformsTo() gives true for a Type that conforms to another.
    By default, two Types do not conform to each other. This query is intended
    to be redefined for specific conformance situations."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Type|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== TypedElement
;;; =========================================================
(def-meta-class |TypedElement| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "TypedElement")
 "A TypedElement is a NamedElement that may have a Type specified for it."
  ((|type| :xmi-id "TypedElement-type" :range |Type| :multiplicity (0 1)
    :documentation
     "The type of the TypedElement.")))

(def-meta-assoc "A_type_typedElement"      
  :name |A_type_typedElement|      
  :metatype :association      
  :member-ends ((|TypedElement| "type")
                ("A_type_typedElement-typedElement" "typedElement"))      
  :owned-ends  (("A_type_typedElement-typedElement" "typedElement")))

(def-meta-assoc-end "A_type_typedElement-typedElement" 
    :type |TypedElement| 
    :multiplicity (0 -1) 
    :association "A_type_typedElement" 
    :name "typedElement")

;;; =========================================================
;;; ====================== UnmarshallAction
;;; =========================================================
(def-meta-class |UnmarshallAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "UnmarshallAction")
 "An UnmarshallAction is an Action that retrieves the values of the StructuralFeatures
  of an object and places them on OutputPins."
  ((|object| :xmi-id "UnmarshallAction-object" :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that gives the object to be unmarshalled.")
   (|result| :xmi-id "UnmarshallAction-result" :range |OutputPin| :multiplicity (1 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPins on which are placed the values of the StructuralFeatures
      of the input object.")
   (|unmarshallType| :xmi-id "UnmarshallAction-unmarshallType" :range |Classifier| :multiplicity (1 1)
    :documentation
     "The type of the object to be unmarshalled.")))

(def-meta-assoc "A_object_unmarshallAction"      
  :name |A_object_unmarshallAction|      
  :metatype :association      
  :member-ends ((|UnmarshallAction| "object")
                ("A_object_unmarshallAction-unmarshallAction" "unmarshallAction"))      
  :owned-ends  (("A_object_unmarshallAction-unmarshallAction" "unmarshallAction")))

(def-meta-assoc-end "A_object_unmarshallAction-unmarshallAction" 
    :type |UnmarshallAction| 
    :multiplicity (0 1) 
    :association "A_object_unmarshallAction" 
    :name "unmarshallAction")

(def-meta-assoc "A_result_unmarshallAction"      
  :name |A_result_unmarshallAction|      
  :metatype :association      
  :member-ends ((|UnmarshallAction| "result")
                ("A_result_unmarshallAction-unmarshallAction" "unmarshallAction"))      
  :owned-ends  (("A_result_unmarshallAction-unmarshallAction" "unmarshallAction")))

(def-meta-assoc-end "A_result_unmarshallAction-unmarshallAction" 
    :type |UnmarshallAction| 
    :multiplicity (0 1) 
    :association "A_result_unmarshallAction" 
    :name "unmarshallAction")

(def-meta-assoc "A_unmarshallType_unmarshallAction"      
  :name |A_unmarshallType_unmarshallAction|      
  :metatype :association      
  :member-ends ((|UnmarshallAction| "unmarshallType")
                ("A_unmarshallType_unmarshallAction-unmarshallAction" "unmarshallAction"))      
  :owned-ends  (("A_unmarshallType_unmarshallAction-unmarshallAction" "unmarshallAction")))

(def-meta-assoc-end "A_unmarshallType_unmarshallAction-unmarshallAction" 
    :type |UnmarshallAction| 
    :multiplicity (0 -1) 
    :association "A_unmarshallType_unmarshallAction" 
    :name "unmarshallAction")

;;; =========================================================
;;; ====================== Usage
;;; =========================================================
(def-meta-class |Usage| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "Usage")
 "A Usage is a Dependency in which the client Element requires the supplier
  Element (or set of Elements) for its full implementation or operation."
  ())

;;; =========================================================
;;; ====================== UseCase
;;; =========================================================
(def-meta-class |UseCase| 
   (:model :UML25 :superclasses (|BehavioredClassifier|) 
    :packages (UML |UseCases|) 
    :xmi-id "UseCase")
 "A UseCase specifies a set of actions performed by its subjects, which yields
  an observable result that is of value for one or more Actors or other stakeholders
  of each subject."
  ((|extend| :xmi-id "UseCase-extend" :range |Extend| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Extend| |extension|)
    :documentation
     "The Extend relationships owned by this UseCase.")
   (|extensionPoint| :xmi-id "UseCase-extensionPoint" :range |ExtensionPoint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ExtensionPoint| |useCase|)
    :documentation
     "The ExtensionPoints owned by this UseCase.")
   (|include| :xmi-id "UseCase-include" :range |Include| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Include| |includingCase|)
    :documentation
     "The Include relationships owned by this UseCase.")
   (|subject| :xmi-id "UseCase-subject" :range |Classifier| :multiplicity (0 -1)
    :opposite (|Classifier| |useCase|)
    :documentation
     "The subjects to which this UseCase applies. Each subject or its parts realize
      all the UseCases that apply to it.")))

(def-meta-operation "allIncludedUseCases" |UseCase| 
   "The query allIncludedUseCases() returns the transitive closure of all UseCases
    (directly or indirectly) included by this UseCase."
   :operation-body
   "result = (self.include.addition->union(self.include.addition->collect(uc | uc.allIncludedUseCases()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UseCase|
                        :parameter-return-p T))
)

(def-meta-assoc "A_extend_extension"      
  :name |A_extend_extension|      
  :metatype :association      
  :member-ends ((|UseCase| "extend")
                (|Extend| "extension"))      
  :owned-ends  ())

(def-meta-assoc "A_extensionPoint_useCase"      
  :name |A_extensionPoint_useCase|      
  :metatype :association      
  :member-ends ((|UseCase| "extensionPoint")
                (|ExtensionPoint| "useCase"))      
  :owned-ends  ())

(def-meta-assoc "A_include_includingCase"      
  :name |A_include_includingCase|      
  :metatype :association      
  :member-ends ((|UseCase| "include")
                (|Include| "includingCase"))      
  :owned-ends  ())

(def-meta-assoc "A_subject_useCase"      
  :name |A_subject_useCase|      
  :metatype :association      
  :member-ends ((|UseCase| "subject")
                (|Classifier| "useCase"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ValuePin
;;; =========================================================
(def-meta-class |ValuePin| 
   (:model :UML25 :superclasses (|InputPin|) 
    :packages (UML |Actions|) 
    :xmi-id "ValuePin")
 "A ValuePin is an InputPin that provides a value by evaluating a ValueSpecification."
  ((|value| :xmi-id "ValuePin-value" :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ValueSpecification that is evaluated to obtain the value that the ValuePin
      will provide.")))

(def-meta-assoc "A_value_valuePin"      
  :name |A_value_valuePin|      
  :metatype :association      
  :member-ends ((|ValuePin| "value")
                ("A_value_valuePin-valuePin" "valuePin"))      
  :owned-ends  (("A_value_valuePin-valuePin" "valuePin")))

(def-meta-assoc-end "A_value_valuePin-valuePin" 
    :type |ValuePin| 
    :multiplicity (0 1) 
    :association "A_value_valuePin" 
    :name "valuePin")

;;; =========================================================
;;; ====================== ValueSpecification
;;; =========================================================
(def-meta-class |ValueSpecification| 
   (:model :UML25 :superclasses (|TypedElement| |PackageableElement|) 
    :packages (UML |Values|) 
    :xmi-id "ValueSpecification")
 "A ValueSpecification is the specification of a (possibly empty) set of
  values. A ValueSpecification is a ParameterableElement that may be exposed
  as a formal TemplateParameter and provided as the actual parameter in the
  binding of a template."
  ())

(def-meta-operation "booleanValue" |ValueSpecification| 
   "The query booleanValue() gives a single Boolean value when one can be computed."
   :operation-body
   "result = (null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "integerValue" |ValueSpecification| 
   "The query integerValue() gives a single Integer value when one can be computed."
   :operation-body
   "result = (null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isCompatibleWith" |ValueSpecification| 
   "The query isCompatibleWith() determines if this ValueSpecification is compatible
    with the specified ParameterableElement. This ValueSpecification is compatible
    with ParameterableElement p if the kind of this ValueSpecification is the
    same as or a subtype of the kind of p. Further, if p is a TypedElement,
    then the type of this ValueSpecification must be conformant with the type
    of p."
   :operation-body
   "result = (self.oclIsKindOf(p.oclType()) and (p.oclIsKindOf(TypedElement) implies   self.type.conformsTo(p.oclAsType(TypedElement).type)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isComputable" |ValueSpecification| 
   "The query isComputable() determines whether a value specification can be
    computed in a model. This operation cannot be fully defined in OCL. A conforming
    implementation is expected to deliver true for this operation for all ValueSpecifications
    that it can compute, and to compute all of those for which the operation
    is true. A conforming implementation is expected to be able to compute
    at least the value of all LiteralSpecifications."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |ValueSpecification| 
   "The query isNull() returns true when it can be computed that the value
    is null."
   :operation-body
   "result = (false)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "realValue" |ValueSpecification| 
   "The query realValue() gives a single Real value when one can be computed."
   :operation-body
   "result = (null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Real|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |ValueSpecification| 
   "The query stringValue() gives a single String value when one can be computed."
   :operation-body
   "result = (null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |ValueSpecification| 
   "The query unlimitedValue() gives a single UnlimitedNatural value when one
    can be computed."
   :operation-body
   "result = (null)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ValueSpecificationAction
;;; =========================================================
(def-meta-class |ValueSpecificationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "ValueSpecificationAction")
 "A ValueSpecificationAction is an Action that evaluates a ValueSpecification
  and provides a result."
  ((|result| :xmi-id "ValueSpecificationAction-result" :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which the result value is placed.")
   (|value| :xmi-id "ValueSpecificationAction-value" :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ValueSpecification to be evaluated.")))

(def-meta-assoc "A_result_valueSpecificationAction"      
  :name |A_result_valueSpecificationAction|      
  :metatype :association      
  :member-ends ((|ValueSpecificationAction| "result")
                ("A_result_valueSpecificationAction-valueSpecificationAction" "valueSpecificationAction"))      
  :owned-ends  (("A_result_valueSpecificationAction-valueSpecificationAction" "valueSpecificationAction")))

(def-meta-assoc-end "A_result_valueSpecificationAction-valueSpecificationAction" 
    :type |ValueSpecificationAction| 
    :multiplicity (0 1) 
    :association "A_result_valueSpecificationAction" 
    :name "valueSpecificationAction")

(def-meta-assoc "A_value_valueSpecificationAction"      
  :name |A_value_valueSpecificationAction|      
  :metatype :association      
  :member-ends ((|ValueSpecificationAction| "value")
                ("A_value_valueSpecificationAction-valueSpecificationAction" "valueSpecificationAction"))      
  :owned-ends  (("A_value_valueSpecificationAction-valueSpecificationAction" "valueSpecificationAction")))

(def-meta-assoc-end "A_value_valueSpecificationAction-valueSpecificationAction" 
    :type |ValueSpecificationAction| 
    :multiplicity (0 1) 
    :association "A_value_valueSpecificationAction" 
    :name "valueSpecificationAction")

;;; =========================================================
;;; ====================== Variable
;;; =========================================================
(def-meta-class |Variable| 
   (:model :UML25 :superclasses (|ConnectableElement| |MultiplicityElement|) 
    :packages (UML |Activities|) 
    :xmi-id "Variable")
 "A Variable is a ConnectableElement that may store values during the execution
  of an Activity. Reading and writing the values of a Variable provides an
  alternative means for passing data than the use of ObjectFlows. A Variable
  may be owned directly by an Activity, in which case it is accessible from
  anywhere within that activity, or it may be owned by a StructuredActivityNode,
  in which case it is only accessible within that node."
  ((|activityScope| :xmi-id "Variable-activityScope" :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Activity| |variable|)
    :documentation
     "An Activity that owns the Variable.")
   (|scope| :xmi-id "Variable-scope" :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StructuredActivityNode| |variable|)
    :documentation
     "A StructuredActivityNode that owns the Variable.")))

(def-meta-operation "isAccessibleBy" |Variable| 
   "A Variable is accessible by Actions within its scope (the Activity or StructuredActivityNode
    that owns it)."
   :operation-body
   "result = (if scope<>null then scope.allOwnedNodes()->includes(a)  else a.containingActivity()=activityScope  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\a :parameter-type '|Action|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== VariableAction
;;; =========================================================
(def-meta-class |VariableAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "VariableAction")
 "VariableAction is an abstract class for Actions that operate on a specified
  Variable."
  ((|variable| :xmi-id "VariableAction-variable" :range |Variable| :multiplicity (1 1)
    :documentation
     "The Variable to be read or written.")))

(def-meta-assoc "A_variable_variableAction"      
  :name |A_variable_variableAction|      
  :metatype :association      
  :member-ends ((|VariableAction| "variable")
                ("A_variable_variableAction-variableAction" "variableAction"))      
  :owned-ends  (("A_variable_variableAction-variableAction" "variableAction")))

(def-meta-assoc-end "A_variable_variableAction-variableAction" 
    :type |VariableAction| 
    :multiplicity (0 -1) 
    :association "A_variable_variableAction" 
    :name "variableAction")

;;; =========================================================
;;; ====================== Vertex
;;; =========================================================
(def-meta-class |Vertex| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "Vertex")
 "A Vertex is an abstraction of a node in a StateMachine graph. It can be
  the source or destination of any number of Transitions."
  ((|container| :xmi-id "Vertex-container" :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |subvertex|)
    :documentation
     "The Region that contains this Vertex.")
   (|incoming| :xmi-id "Vertex-incoming" :range |Transition| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Transition| |target|)
    :documentation
     "Specifies the Transitions entering this Vertex.")
   (|outgoing| :xmi-id "Vertex-outgoing" :range |Transition| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Transition| |source|)
    :documentation
     "Specifies the Transitions departing from this Vertex.")))

(def-meta-operation "containingStateMachine" |Vertex| 
   "The operation containingStateMachine() returns the StateMachine in which
    this Vertex is defined."
   :operation-body
   "result = (if container <> null then -- the container is a region    container.containingStateMachine() else     if (self.oclIsKindOf(Pseudostate)) and ((self.oclAsType(Pseudostate).kind = PseudostateKind::entryPoint) or (self.oclAsType(Pseudostate).kind = PseudostateKind::exitPoint)) then       self.oclAsType(Pseudostate).stateMachine    else        if (self.oclIsKindOf(ConnectionPointReference)) then           self.oclAsType(ConnectionPointReference).state.containingStateMachine() -- no other valid cases possible       else            null       endif    endif endif  )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "incoming.1" |Vertex| 
   "Derivation for Vertex::/incoming."
   :operation-body
   "result = (Transition.allInstances()->select(target=self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-meta-operation "isContainedInRegion" |Vertex| 
   "This utility query returns true if the Vertex is contained in the Region
    r (input argument)."
   :operation-body
   "result = (if (container = r) then   true  else   if (r.state->isEmpty()) then    false   else    container.state.isContainedInRegion(r)   endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\r :parameter-type '|Region|
                        :parameter-return-p NIL))
)

(def-meta-operation "isContainedInState" |Vertex| 
   "This utility operation returns true if the Vertex is contained in the State
    s (input argument)."
   :operation-body
   "result = (if not s.isComposite() or container->isEmpty() then   false  else   if container.state = s then     true   else    container.state.isContainedInState(s)   endif  endif)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\s :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-meta-operation "outgoing.1" |Vertex| 
   "Derivation for Vertex::/outgoing"
   :operation-body
   "result = (Transition.allInstances()->select(source=self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-meta-assoc "A_incoming_target_vertex"      
  :name |A_incoming_target_vertex|      
  :metatype :association      
  :member-ends ((|Vertex| "incoming")
                (|Transition| "target"))      
  :owned-ends  ())

(def-meta-assoc "A_outgoing_source_vertex"      
  :name |A_outgoing_source_vertex|      
  :metatype :association      
  :member-ends ((|Vertex| "outgoing")
                (|Transition| "source"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== WriteLinkAction
;;; =========================================================
(def-meta-class |WriteLinkAction| 
   (:model :UML25 :superclasses (|LinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "WriteLinkAction")
 "WriteLinkAction is an abstract class for LinkActions that create and destroy
  links."
  ())

;;; =========================================================
;;; ====================== WriteStructuralFeatureAction
;;; =========================================================
(def-meta-class |WriteStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "WriteStructuralFeatureAction")
 "WriteStructuralFeatureAction is an abstract class for StructuralFeatureActions
  that change StructuralFeature values."
  ((|result| :xmi-id "WriteStructuralFeatureAction-result" :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The OutputPin on which is put the input object as modified by the WriteStructuralFeatureAction.")
   (|value| :xmi-id "WriteStructuralFeatureAction-value" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that provides the value to be added or removed from the StructuralFeature.")))

(def-meta-assoc "A_result_writeStructuralFeatureAction"      
  :name |A_result_writeStructuralFeatureAction|      
  :metatype :association      
  :member-ends ((|WriteStructuralFeatureAction| "result")
                ("A_result_writeStructuralFeatureAction-writeStructuralFeatureAction" "writeStructuralFeatureAction"))      
  :owned-ends  (("A_result_writeStructuralFeatureAction-writeStructuralFeatureAction" "writeStructuralFeatureAction")))

(def-meta-assoc-end "A_result_writeStructuralFeatureAction-writeStructuralFeatureAction" 
    :type |WriteStructuralFeatureAction| 
    :multiplicity (0 1) 
    :association "A_result_writeStructuralFeatureAction" 
    :name "writeStructuralFeatureAction")

(def-meta-assoc "A_value_writeStructuralFeatureAction"      
  :name |A_value_writeStructuralFeatureAction|      
  :metatype :association      
  :member-ends ((|WriteStructuralFeatureAction| "value")
                ("A_value_writeStructuralFeatureAction-writeStructuralFeatureAction" "writeStructuralFeatureAction"))      
  :owned-ends  (("A_value_writeStructuralFeatureAction-writeStructuralFeatureAction" "writeStructuralFeatureAction")))

(def-meta-assoc-end "A_value_writeStructuralFeatureAction-writeStructuralFeatureAction" 
    :type |WriteStructuralFeatureAction| 
    :multiplicity (0 1) 
    :association "A_value_writeStructuralFeatureAction" 
    :name "writeStructuralFeatureAction")

;;; =========================================================
;;; ====================== WriteVariableAction
;;; =========================================================
(def-meta-class |WriteVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "WriteVariableAction")
 "WriteVariableAction is an abstract class for VariableActions that change
  Variable values."
  ((|value| :xmi-id "WriteVariableAction-value" :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The InputPin that gives the value to be added or removed from the Variable.")))

(def-meta-assoc "A_value_writeVariableAction"      
  :name |A_value_writeVariableAction|      
  :metatype :association      
  :member-ends ((|WriteVariableAction| "value")
                ("A_value_writeVariableAction-writeVariableAction" "writeVariableAction"))      
  :owned-ends  (("A_value_writeVariableAction-writeVariableAction" "writeVariableAction")))

(def-meta-assoc-end "A_value_writeVariableAction-writeVariableAction" 
    :type |WriteVariableAction| 
    :multiplicity (0 1) 
    :association "A_value_writeVariableAction" 
    :name "writeVariableAction")

(def-meta-package |Actions| UML :UML25 
   (|ValueSpecificationAction|
    |VariableAction|
    |WriteLinkAction|
    |WriteStructuralFeatureAction|
    |WriteVariableAction|
    |ExpansionKind|
    |AcceptCallAction|
    |AcceptEventAction|
    |Action|
    |ActionInputPin|
    |AddStructuralFeatureValueAction|
    |AddVariableValueAction|
    |BroadcastSignalAction|
    |CallAction|
    |CallBehaviorAction|
    |CallOperationAction|
    |Clause|
    |ClearAssociationAction|
    |ClearStructuralFeatureAction|
    |ClearVariableAction|
    |ConditionalNode|
    |CreateLinkAction|
    |CreateLinkObjectAction|
    |CreateObjectAction|
    |DestroyLinkAction|
    |DestroyObjectAction|
    |ExpansionNode|
    |ExpansionRegion|
    |InputPin|
    |InvocationAction|
    |LinkAction|
    |LinkEndCreationData|
    |LinkEndData|
    |LinkEndDestructionData|
    |LoopNode|
    |OpaqueAction|
    |OutputPin|
    |Pin|
    |QualifierValue|
    |RaiseExceptionAction|
    |ReadExtentAction|
    |ReadIsClassifiedObjectAction|
    |ReadLinkAction|
    |ReadLinkObjectEndAction|
    |ReadLinkObjectEndQualifierAction|
    |ReadSelfAction|
    |ReadStructuralFeatureAction|
    |ReadVariableAction|
    |ReclassifyObjectAction|
    |ReduceAction|
    |RemoveStructuralFeatureValueAction|
    |RemoveVariableValueAction|
    |ReplyAction|
    |SendObjectAction|
    |SendSignalAction|
    |SequenceNode|
    |StartClassifierBehaviorAction|
    |StartObjectBehaviorAction|
    |StructuralFeatureAction|
    |StructuredActivityNode|
    |TestIdentityAction|
    |UnmarshallAction|
    |ValuePin|) :xmi-id "Actions")

(def-meta-package |Activities| UML :UML25 
   (|Activity|
    |ActivityEdge|
    |ActivityFinalNode|
    |ActivityGroup|
    |ActivityNode|
    |ActivityParameterNode|
    |ActivityPartition|
    |CentralBufferNode|
    |ControlFlow|
    |ControlNode|
    |DataStoreNode|
    |DecisionNode|
    |ExceptionHandler|
    |ExecutableNode|
    |FinalNode|
    |FlowFinalNode|
    |ForkNode|
    |InitialNode|
    |InterruptibleActivityRegion|
    |JoinNode|
    |MergeNode|
    |ObjectFlow|
    |ObjectNode|
    |Variable|
    |ObjectNodeOrderingKind|) :xmi-id "Activities")

(def-meta-package |Classification| UML :UML25 
   (|Substitution|
    |BehavioralFeature|
    |Classifier|
    |ClassifierTemplateParameter|
    |Feature|
    |Generalization|
    |GeneralizationSet|
    |InstanceSpecification|
    |InstanceValue|
    |Operation|
    |OperationTemplateParameter|
    |Parameter|
    |ParameterSet|
    |Property|
    |RedefinableElement|
    |RedefinableTemplateSignature|
    |Slot|
    |StructuralFeature|
    |AggregationKind|
    |CallConcurrencyKind|
    |ParameterDirectionKind|
    |ParameterEffectKind|) :xmi-id "Classification")

(def-meta-package |CommonBehavior| UML :UML25 
   (|AnyReceiveEvent|
    |Behavior|
    |CallEvent|
    |ChangeEvent|
    |Event|
    |FunctionBehavior|
    |MessageEvent|
    |OpaqueBehavior|
    |SignalEvent|
    |TimeEvent|
    |Trigger|) :xmi-id "CommonBehavior")

(def-meta-package |CommonStructure| UML :UML25 
   (|Abstraction|
    |Comment|
    |Constraint|
    |Dependency|
    |DirectedRelationship|
    |Element|
    |ElementImport|
    |MultiplicityElement|
    |NamedElement|
    |Namespace|
    |PackageableElement|
    |PackageImport|
    |ParameterableElement|
    |Realization|
    |Relationship|
    |TemplateableElement|
    |TemplateBinding|
    |TemplateParameter|
    |TemplateParameterSubstitution|
    |TemplateSignature|
    |Type|
    |TypedElement|
    |Usage|
    |VisibilityKind|) :xmi-id "CommonStructure")

(def-meta-package |Deployments| UML :UML25 
   (|Artifact|
    |CommunicationPath|
    |DeployedArtifact|
    |Deployment|
    |DeploymentSpecification|
    |DeploymentTarget|
    |Device|
    |ExecutionEnvironment|
    |Manifestation|
    |Node|) :xmi-id "Deployments")

(def-meta-package |InformationFlows| UML :UML25 
   (|InformationFlow|
    |InformationItem|) :xmi-id "InformationFlows")

(def-meta-package |Interactions| UML :UML25 
   (|ActionExecutionSpecification|
    |BehaviorExecutionSpecification|
    |CombinedFragment|
    |ConsiderIgnoreFragment|
    |Continuation|
    |DestructionOccurrenceSpecification|
    |ExecutionOccurrenceSpecification|
    |ExecutionSpecification|
    |Gate|
    |GeneralOrdering|
    |Interaction|
    |InteractionConstraint|
    |InteractionFragment|
    |InteractionOperand|
    |InteractionUse|
    |Lifeline|
    |Message|
    |MessageEnd|
    |MessageOccurrenceSpecification|
    |OccurrenceSpecification|
    |PartDecomposition|
    |StateInvariant|
    |InteractionOperatorKind|
    |MessageKind|
    |MessageSort|) :xmi-id "Interactions")

(def-meta-package |Packages| UML :UML25 
   (|Extension|
    |ExtensionEnd|
    |Image|
    |Model|
    |Package|
    |PackageMerge|
    |Profile|
    |ProfileApplication|
    |Stereotype|) :xmi-id "Packages")

(def-meta-package |PrimitiveTypes.xmi| NIL :UML25 
   () :xmi-id NIL)

(def-meta-package |SimpleClassifiers| UML :UML25 
   (|BehavioredClassifier|
    |DataType|
    |Enumeration|
    |EnumerationLiteral|
    |Interface|
    |InterfaceRealization|
    |PrimitiveType|
    |Reception|
    |Signal|) :xmi-id "SimpleClassifiers")

(def-meta-package |StateMachines| UML :UML25 
   (|ConnectionPointReference|
    |FinalState|
    |ProtocolConformance|
    |ProtocolStateMachine|
    |ProtocolTransition|
    |Pseudostate|
    |Region|
    |State|
    |StateMachine|
    |Transition|
    |Vertex|
    |PseudostateKind|
    |TransitionKind|) :xmi-id "StateMachines")

(def-meta-package |StructuredClassifiers| UML :UML25 
   (|Association|
    |AssociationClass|
    |Class|
    |Collaboration|
    |CollaborationUse|
    |Component|
    |ComponentRealization|
    |ConnectableElement|
    |ConnectableElementTemplateParameter|
    |Connector|
    |ConnectorEnd|
    |EncapsulatedClassifier|
    |Port|
    |StructuredClassifier|
    |ConnectorKind|) :xmi-id "StructuredClassifiers")

(def-meta-package UML NIL :UML25 
   (|Activities|
    |Values|
    |UseCases|
    |StructuredClassifiers|
    |StateMachines|
    |SimpleClassifiers|
    |Packages|
    |Interactions|
    |InformationFlows|
    |Deployments|
    |CommonStructure|
    |CommonBehavior|
    |Classification|
    |Actions|) :xmi-id "+The-Model+")

(def-meta-package |UseCases| UML :UML25 
   (|Actor|
    |Extend|
    |ExtensionPoint|
    |Include|
    |UseCase|) :xmi-id "UseCases")

(def-meta-package |Values| UML :UML25 
   (|Duration|
    |DurationConstraint|
    |DurationInterval|
    |DurationObservation|
    |Expression|
    |Interval|
    |IntervalConstraint|
    |LiteralBoolean|
    |LiteralInteger|
    |LiteralNull|
    |LiteralReal|
    |LiteralSpecification|
    |LiteralString|
    |LiteralUnlimitedNatural|
    |Observation|
    |OpaqueExpression|
    |StringExpression|
    |TimeConstraint|
    |TimeExpression|
    |TimeInterval|
    |TimeObservation|
    |ValueSpecification|) :xmi-id "Values")

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(UML25:|Action|
          UML25:|ActivityEdge|
          UML25:|ActivityGroup|
          UML25:|ActivityNode|
          UML25:|Behavior|
          UML25:|BehavioralFeature|
          UML25:|BehavioredClassifier|
          UML25:|CallAction|
          UML25:|Classifier|
          UML25:|ConnectableElement|
          UML25:|ControlNode|
          UML25:|DeployedArtifact|
          UML25:|DeploymentTarget|
          UML25:|DirectedRelationship|
          UML25:|Element|
          UML25:|EncapsulatedClassifier|
          UML25:|Event|
          UML25:|ExecutableNode|
          UML25:|ExecutionSpecification|
          UML25:|Feature|
          UML25:|FinalNode|
          UML25:|InteractionFragment|
          UML25:|InvocationAction|
          UML25:|LinkAction|
          UML25:|LiteralSpecification|
          UML25:|MessageEnd|
          UML25:|MessageEvent|
          UML25:|MultiplicityElement|
          UML25:|NamedElement|
          UML25:|Namespace|
          UML25:|ObjectNode|
          UML25:|Observation|
          UML25:|PackageableElement|
          UML25:|ParameterableElement|
          UML25:|Pin|
          UML25:|RedefinableElement|
          UML25:|Relationship|
          UML25:|StructuralFeature|
          UML25:|StructuralFeatureAction|
          UML25:|StructuredClassifier|
          UML25:|TemplateableElement|
          UML25:|Type|
          UML25:|TypedElement|
          UML25:|ValueSpecification|
          UML25:|VariableAction|
          UML25:|Vertex|
          UML25:|WriteLinkAction|
          UML25:|WriteStructuralFeatureAction|
          UML25:|WriteVariableAction|))
     (setf mofi:ns-uri "http://www.omg.org/spec/UML/2.5")
     (setf mofi:ns-prefix "uml"))
