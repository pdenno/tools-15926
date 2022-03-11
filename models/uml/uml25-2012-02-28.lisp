;;; Automatically created by pop-gen at 2012-02-28 11:00:47.
;;; Source file is uml25-2012-02-28.xmi

(in-package :UML25)



(def-mm-primitive |Boolean| :UML25 NIL)



(def-mm-primitive |Integer| :UML25 NIL)



(def-mm-primitive |Real| :UML25 NIL)



(def-mm-primitive |String| :UML25 NIL)



(def-mm-primitive |UnlimitedNatural| :UML25 NIL)



(def-mm-enum |AggregationKind| :UML25 NIL 
   (|none| |shared| |composite|)
   "AggregationKind is an Enumeration for specifying the kind of aggregation
    of a Property.")



(def-mm-enum |CallConcurrencyKind| :UML25 NIL 
   (|sequential| |guarded| |concurrent|)
   "CallConcurrencyKind is an Enumeration used to specify the semantics of
    concurrent calls to a BehavioralFeature.")



(def-mm-enum |ConnectorKind| :UML25 NIL 
   (|assembly| |delegation|)
   "ConnectorKind is an enumeration that defines whether a Connector is an
    assembly or a delegation.")



(def-mm-enum |ExpansionKind| :UML25 NIL 
   (|parallel| |iterative| |stream|)
   "ExpansionKind is an enumeration type used to specify how multiple executions
    of an expansion region interact.")



(def-mm-enum |InteractionOperatorKind| :UML25 NIL 
   (|seq| |alt| |opt| |break| |par| |strict| |loop| |critical| |neg| |assert| |ignore| |consider|)
   "InteractionOperatorKind is an enumeration designating the different kinds
    of operators of CombinedFragments. The InteractionOperand defines the type
    of operator of a CombinedFragment.")



(def-mm-enum |MessageKind| :UML25 NIL 
   (|complete| |lost| |found| |unknown|)
   "This is an enumerated type that identifies the type of Message.")



(def-mm-enum |MessageSort| :UML25 NIL 
   (|synchCall| |asynchCall| |asynchSignal| |createMessage| |deleteMessage| |reply|)
   "This is an enumerated type that identifies the type of communication action
    that was used to generate the Message.")



(def-mm-enum |ObjectNodeOrderingKind| :UML25 NIL 
   (|unordered| |ordered| LIFO FIFO)
   "ObjectNodeOrderingKind is an enumeration indicating queuing order within
    a node.")



(def-mm-enum |ParameterDirectionKind| :UML25 NIL 
   (|in| |inout| |out| |return|)
   "ParameterDirectionKind is an Enumeration that defines literals used to
    specify direction of parameters.")



(def-mm-enum |ParameterEffectKind| :UML25 NIL 
   (|create| |read| |update| |delete|)
   "ParameterEffectKind is an Enumeration that indicates the effect of a Behavior
    on values passed in or out of its parameters.")



(def-mm-enum |PseudostateKind| :UML25 NIL 
   (|initial| |deepHistory| |shallowHistory| |join| |fork| |junction| |choice| |entryPoint| |exitPoint| |terminate|)
   "PseudostateKind is an Enumeration type that is used to differentiate various
    kinds of Pseudostates.")



(def-mm-enum |TransitionKind| :UML25 NIL 
   (|internal| |local| |external|)
   "TransitionKind is an Enumeration type used to differentiate the various
    kinds of Transitions.")



(def-mm-enum |VisibilityKind| :UML25 NIL 
   (|public| |private| |protected| |package|)
   "VisibilityKind is an enumeration type that defines literals to determine
    the visibility of elements in a model.")



;;; =========================================================
;;; ====================== Abstraction
;;; =========================================================
(def-mm-class |Abstraction| :UML25 (|Dependency|)
 "An abstraction is a relationship that relates two elements or sets of elements
  that represent the same concept at different levels of abstraction or from
  different viewpoints."
  ((|mapping| :range |OpaqueExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|OpaqueExpression| |abstraction|)
    :documentation
     "An composition of an Expression that states the abstraction relationship
      between the supplier and the client. In some cases, such as Derivation,
      it is usually formal and unidirectional; in other cases, such as Trace,
      it is usually informal and bidirectional. The mapping expression is optional
      and may be omitted if the precise relationship between the elements is
      not specified.")))


;;; =========================================================
;;; ====================== AcceptCallAction
;;; =========================================================
(def-mm-class |AcceptCallAction| :UML25 (|AcceptEventAction|)
 "An accept call action is an accept event action representing the receipt
  of a synchronous call request. In addition to the normal operation parameters,
  the action produces an output that is needed later to supply the information
  to the reply action necessary to return control to the caller. This action
  is for synchronous calls. If it is used to handle an asynchronous call,
  execution of the subsequent reply action will complete immediately with
  no effects."
  ((|returnInformation| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |acceptCallAction|)
    :documentation
     "Pin where a value is placed containing sufficient information to perform
      a subsequent reply and return control to the caller. The contents of this
      value are opaque. It can be passed and copied but it cannot be manipulated
      by the model.")))


(def-mm-constraint "result_pins" |AcceptCallAction| 
   "The result pins must match the in and inout parameters of the operation
    specified by the trigger event in number, type, and order."
   :operation-body
   "true")

(def-mm-constraint "trigger_call_event" |AcceptCallAction| 
   "The trigger event must be a CallEvent."
   :operation-body
   "trigger.event->forAll(e | e.oclIsKindOf(CallEvent))")

(def-mm-constraint "unmarshall" |AcceptCallAction| 
   "isUnmrashall must be true for an AcceptCallAction."
   :operation-body
   "isUnmarshall = true")

;;; =========================================================
;;; ====================== AcceptEventAction
;;; =========================================================
(def-mm-class |AcceptEventAction| :UML25 (|Action|)
 "A accept event action is an action that waits for the occurrence of an
  event meeting specified conditions."
  ((|isUnmarshall| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether there is a single output pin for the event, or multiple
      output pins for attributes of the event.")
   (|result| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |acceptEventAction|)
    :documentation
     "Pins holding the received event objects or their attributes. Event objects
      may be copied in transmission, so identity might not be preserved.")
   (|trigger| :range |Trigger| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Trigger| |acceptEventAction|)
    :documentation
     "The type of events accepted by the action, as specified by triggers. For
      triggers with signal events, a signal of the specified type or any subtype
      of the specified signal type is accepted.")))


(def-mm-constraint "no_input_pins" |AcceptEventAction| 
   "AcceptEventActions may have no input pins."
   :operation-body
   "true")

(def-mm-constraint "no_output_pins" |AcceptEventAction| 
   "There are no output pins if the trigger events are only ChangeEvents, or
    if they are only CallEvents when this action is an instance of AcceptEventAction
    and not an instance of a descendant of AcceptEventAction (such as AcceptCallAction)."
   :operation-body
   "true")

(def-mm-constraint "trigger_events" |AcceptEventAction| 
   "If the trigger events are all TimeEvents, there is exactly one output pin."
   :operation-body
   "true")

(def-mm-constraint "unmarshall_signal_events" |AcceptEventAction| 
   "If isUnmarshall is true, there must be exactly one trigger for events of
    type SignalEvent. The number of result output pins must be the same as
    the number of attributes of the signal. The type and ordering of each result
    output pin must be the same as the corresponding attribute of the signal.
    The multiplicity of each result output pin must be compatible with the
    multiplicity of the corresponding attribute."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Action
;;; =========================================================
(def-mm-class |Action| :UML25 (|ExecutableNode|)
 "An action has pre- and post-conditions. An action is a named element that
  is the fundamental unit of executable functionality. The execution of an
  action represents some transformation or processing in the modeled system,
  be it a computer system or otherwise. An action represents a single step
  within an activity, that is, one that is not further decomposed within
  the activity."
  ((|context| :range |Classifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Classifier| |action|)
    :documentation
     "The classifier that owns the behavior of which this action is a part.")
   (|input| :range |InputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|InputPin| |action|)
    :documentation
     "The ordered set of input pins connected to the Action. These are among
      the total set of inputs.")
   (|isLocallyReentrant| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the action can begin a new, concurrent execution, even if there
      is already another execution of the action ongoing. If false, the action
      cannot begin a new execution until any previous execution has completed.")
   (|localPostcondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Constraint| |action|)
    :documentation
     "Constraint that must be satisfied when executed is completed.")
   (|localPrecondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Constraint| |action|)
    :documentation
     "Constraint that must be satisfied when execution is started.")
   (|output| :range |OutputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|OutputPin| |action|)
    :documentation
     "The ordered set of output pins connected to the Action. The action places
      its results onto pins in this set.")))


(def-mm-operation "context.1" |Action| 
   "Missing derivation for Action::/context : Classifier"
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ActionExecutionSpecification
;;; =========================================================
(def-mm-class |ActionExecutionSpecification| :UML25 (|ExecutionSpecification|)
 "An ActionExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of an Action."
  ((|action| :range |Action| :multiplicity (1 1) :soft-opposite (|Action| |actionExecutionSpecification|)
    :documentation
     "Action whose execution is occurring.")))


(def-mm-constraint "action_referenced" |ActionExecutionSpecification| 
   "The Action referenced by the ActionExecutionSpecification must be owned
    by the Interaction owning that ActionExecutionSpecification."
   :operation-body
   "(enclosingInteraction->notEmpty() or enclosingOperand.combinedFragment->notEmpty()) and let parentInteraction : Set(Interaction) = enclosingInteraction.oclAsType(Interaction)->asSet()->union( enclosingOperand.combinedFragment->closure(enclosingOperand.combinedFragment)-> collect(enclosingInteraction).oclAsType(Interaction)->asSet()) in (parentInteraction->size() = 1) and self.action.interaction->asSet() = parentInteraction")

;;; =========================================================
;;; ====================== ActionInputPin
;;; =========================================================
(def-mm-class |ActionInputPin| :UML25 (|InputPin|)
 "An action input pin is a kind of pin that executes an action to determine
  the values to input to another."
  ((|fromAction| :range |Action| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Action| |actionInputPin|)
    :documentation
     "The action used to provide values.")))


(def-mm-constraint "input_pin" |ActionInputPin| 
   "The fromAction of an action input pin must only have action input pins
    as input pins."
   :operation-body
   "true")

(def-mm-constraint "no_control_or_data_flow" |ActionInputPin| 
   "The fromAction of an action input pin cannot have control or data flows
    coming into or out of it or its pins."
   :operation-body
   "true")

(def-mm-constraint "one_output_pin" |ActionInputPin| 
   "The fromAction of an action input pin must have exactly one output pin."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Activity
;;; =========================================================
(def-mm-class |Activity| :UML25 (|Behavior|)
 "An activity is the specification of parameterized behavior as the coordinated
  sequencing of subordinate units whose individual elements are actions."
  ((|edge| :range |ActivityEdge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityEdge| |activity|)
    :documentation
     "Edges expressing flow between nodes of the activity.")
   (|group| :range |ActivityGroup| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |inActivity|)
    :documentation
     "Top-level groups in the activity.")
   (|isReadOnly| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, this activity must not make any changes to variables outside the
      activity or to objects. (This is an assertion, not an executable property.
      It may be used by an execution engine to optimize model execution. If the
      assertion is violated by the action, then the model is ill-formed.) The
      default is false (an activity may make nonlocal changes).")
   (|isSingleExecution| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, all invocations of the activity are handled by the same execution.")
   (|node| :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityNode| |activity|)
    :documentation
     "Nodes coordinated by the activity.")
   (|partition| :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|Activity| |group|)) :soft-opposite (|ActivityPartition| |activity|)
    :documentation
     "Top-level partitions in the activity.")
   (|structuredNode| :range |StructuredActivityNode| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T
    :subsetted-properties ((|Activity| |group|) (|Activity| |node|))
    :opposite (|StructuredActivityNode| |activity|)
    :documentation
     "Top-level structured nodes in the activity.")
   (|variable| :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |activityScope|)
    :documentation
     "Top-level variables in the activity.")))


(def-mm-constraint "activity_parameter_node" |Activity| 
   "The nodes of the activity must include one ActivityParameterNode for each
    parameter."
   :operation-body
   "true")

(def-mm-constraint "autonomous" |Activity| 
   "An activity cannot be autonomous and have a classifier or behavioral feature
    context at the same time."
   :operation-body
   "true")

(def-mm-constraint "no_supergroups" |Activity| 
   "The groups of an activity have no supergroups."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ActivityEdge
;;; =========================================================
(def-mm-class |ActivityEdge| :UML25 (|RedefinableElement|)
 "An activity edge is an abstract class for directed connections between
  two activity nodes. Activity edges can be contained in interruptible regions."
  ((|activity| :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |edge|)
    :documentation
     "Activity containing the edge.")
   (|guard| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |activityEdge|)
    :documentation
     "Specification evaluated at runtime to determine if the edge can be traversed.")
   (|inGroup| :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedEdge|)
    :documentation
     "Groups containing the edge.")
   (|inPartition| :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityEdge| |inGroup|))
    :opposite (|ActivityPartition| |edge|)
    :documentation
     "Partitions containing the edge.")
   (|inStructuredNode| :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|ActivityEdge| |inGroup|) (|Element| |owner|))
    :opposite (|StructuredActivityNode| |edge|)
    :documentation
     "Structured activity node containing the edge.")
   (|interrupts| :range |InterruptibleActivityRegion| :multiplicity (0 1)
    :opposite (|InterruptibleActivityRegion| |interruptingEdge|)
    :documentation
     "Region that the edge can interrupt.")
   (|redefinedEdge| :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|ActivityEdge| |activityEdge|)
    :documentation
     "Inherited edges replaced by this edge in a specialization of the activity.")
   (|source| :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |outgoing|)
    :documentation
     "Node from which tokens are taken when they traverse the edge.")
   (|target| :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |incoming|)
    :documentation
     "Node to which tokens are put when they traverse the edge.")
   (|weight| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |activityEdge|)
    :documentation
     "The minimum number of tokens that must traverse the edge at the same time.")))


(def-mm-constraint "owned" |ActivityEdge| 
   "Activity edges may be owned only by activities or groups."
   :operation-body
   "true")

(def-mm-constraint "source_and_target" |ActivityEdge| 
   "The source and target of an edge must be in the same activity as the edge."
   :operation-body
   "true")

(def-mm-constraint "structured_node" |ActivityEdge| 
   "Activity edges may be owned by at most one structured node."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ActivityFinalNode
;;; =========================================================
(def-mm-class |ActivityFinalNode| :UML25 (|FinalNode|)
 "An activity final node is a final node that stops all flows in an activity."
  ())


;;; =========================================================
;;; ====================== ActivityGroup
;;; =========================================================
(def-mm-class |ActivityGroup| :UML25 (|NamedElement|)
 "ActivityGroup is an abstract class for defining sets of nodes and edges
  in an activity."
  ((|containedEdge| :range |ActivityEdge| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityEdge| |inGroup|)
    :documentation
     "Edges immediately contained in the group.")
   (|containedNode| :range |ActivityNode| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityNode| |inGroup|)
    :documentation
     "Nodes immediately contained in the group.")
   (|inActivity| :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |group|)
    :documentation
     "Activity containing the group.")
   (|subgroup| :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |superGroup|)
    :documentation
     "Groups immediately contained in the group.")
   (|superGroup| :range |ActivityGroup| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|ActivityGroup| |subgroup|)
    :documentation
     "Group immediately containing the group.")))


(def-mm-constraint "group_owned" |ActivityGroup| 
   "Groups may only be owned by activities or groups."
   :operation-body
   "true")

(def-mm-constraint "nodes_and_edges" |ActivityGroup| 
   "All nodes and edges of the group must be in the same activity as the group."
   :operation-body
   "true")

(def-mm-constraint "not_contained" |ActivityGroup| 
   "No node or edge in a group may be contained by its subgroups or its containing
    groups, transitively."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ActivityNode
;;; =========================================================
(def-mm-class |ActivityNode| :UML25 (|RedefinableElement|)
 "ActivityNode is an abstract class for points in the flow of an activity
  connected by edges."
  ((|activity| :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |node|)
    :documentation
     "Activity containing the node.")
   (|inGroup| :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedNode|)
    :documentation
     "Groups containing the node.")
   (|inInterruptibleRegion| :range |InterruptibleActivityRegion| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|InterruptibleActivityRegion| |node|)
    :documentation
     "Interruptible regions containing the node.")
   (|inPartition| :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|ActivityPartition| |node|)
    :documentation
     "Partitions containing the node.")
   (|inStructuredNode| :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|ActivityNode| |inGroup|) (|Element| |owner|))
    :opposite (|StructuredActivityNode| |node|)
    :documentation
     "Structured activity node containing the node.")
   (|incoming| :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |target|)
    :documentation
     "Edges that have the node as target.")
   (|outgoing| :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |source|)
    :documentation
     "Edges that have the node as source.")
   (|redefinedNode| :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|ActivityNode| |activityNode|)
    :documentation
     "Inherited nodes replaced by this node in a specialization of the activity.")))


(def-mm-constraint "owned" |ActivityNode| 
   "Activity nodes can only be owned by activities or groups."
   :operation-body
   "true")

(def-mm-constraint "owned_structured_node" |ActivityNode| 
   "Activity nodes may be owned by at most one structured node."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ActivityParameterNode
;;; =========================================================
(def-mm-class |ActivityParameterNode| :UML25 (|ObjectNode|)
 "An activity parameter node is an object node for inputs and outputs to
  activities."
  ((|parameter| :range |Parameter| :multiplicity (1 1) :soft-opposite (|Parameter| |activityParameterNode|)
    :documentation
     "The parameter the object node will be accepting or providing values for.")))


(def-mm-constraint "has_parameters" |ActivityParameterNode| 
   "Activity parameter nodes must have parameters from the containing activity."
   :operation-body
   "true")

(def-mm-constraint "maximum_one_parameter_node" |ActivityParameterNode| 
   "A parameter with direction other than inout must have at most one activity
    parameter node in an activity."
   :operation-body
   "true")

(def-mm-constraint "maximum_two_parameter_nodes" |ActivityParameterNode| 
   "A parameter with direction inout must have at most two activity parameter
    nodes in an activity, one with incoming flows and one with outgoing flows."
   :operation-body
   "true")

(def-mm-constraint "no_edges" |ActivityParameterNode| 
   "An activity parameter node may have all incoming edges or all outgoing
    edges, but it must not have both incoming and outgoing edges."
   :operation-body
   "true")

(def-mm-constraint "no_incoming_edges" |ActivityParameterNode| 
   "Activity parameter object nodes with no incoming edges and one or more
    outgoing edges must have a parameter with in or inout direction."
   :operation-body
   "true")

(def-mm-constraint "no_outgoing_edges" |ActivityParameterNode| 
   "Activity parameter object nodes with no outgoing edges and one or more
    incoming edges must have a parameter with out, inout, or return direction."
   :operation-body
   "true")

(def-mm-constraint "same_type" |ActivityParameterNode| 
   "The type of an activity parameter node is the same as the type of its parameter."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ActivityPartition
;;; =========================================================
(def-mm-class |ActivityPartition| :UML25 (|ActivityGroup|)
 "An activity partition is a kind of activity group for identifying actions
  that have some characteristic in common."
  ((|edge| :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedEdge|))
    :opposite (|ActivityEdge| |inPartition|)
    :documentation
     "Edges immediately contained in the group.")
   (|isDimension| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the partition groups other partitions along a dimension.")
   (|isExternal| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the partition represents an entity to which the partitioning
      structure does not apply.")
   (|node| :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inPartition|)
    :documentation
     "Nodes immediately contained in the group.")
   (|represents| :range |Element| :multiplicity (0 1) :soft-opposite (|Element| |activityPartition|)
    :documentation
     "An element constraining behaviors invoked by nodes in the partition.")
   (|subpartition| :range |ActivityPartition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |subgroup|))
    :opposite (|ActivityPartition| |superPartition|)
    :documentation
     "Partitions immediately contained in the partition.")
   (|superPartition| :range |ActivityPartition| :multiplicity (0 1)
    :subsetted-properties ((|ActivityGroup| |superGroup|))
    :opposite (|ActivityPartition| |subpartition|)
    :documentation
     "Partition immediately containing the partition.")))


(def-mm-constraint "dimension_not_contained" |ActivityPartition| 
   "A partition with isDimension = true may not be contained by another partition."
   :operation-body
   "true")

(def-mm-constraint "represents_classifier" |ActivityPartition| 
   "If a non-external partition represents a classifier and is contained in
    another partition, then the containing partition must represent a classifier,
    and the classifier of the subpartition must be nested in the classifier
    represented by the containing partition, or be at the contained end of
    a strong composition association with the classifier represented by the
    containing partition."
   :operation-body
   "true")

(def-mm-constraint "represents_part" |ActivityPartition| 
   "If a partition represents a part, then all the non-external partitions
    in the same dimension and at the same level of nesting in that dimension
    must represent parts directly contained in the internal structure of the
    same classifier."
   :operation-body
   "true")

(def-mm-constraint "represents_part_and_is_contained" |ActivityPartition| 
   "If a partition represents a part and is contained by another partition,
    then the part must be of a classifier represented by the containing partition,
    or of a classifier that is the type of a part representing the containing
    partition."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Actor
;;; =========================================================
(def-mm-class |Actor| :UML25 (|BehavioredClassifier|)
 "An Actor specifies a role played by a user or any other system that interacts
  with the subject."
  ())


(def-mm-constraint "associations" |Actor| 
   "An Actor can only have Associations to UseCases, Components and Classes.
    Furthermore these Associations must be binary."
   :operation-body
   "self.attribute->forAll ( a |   (a.association->notEmpty()) implies   ((a.association.memberEnd->size() = 2) and   (a.opposite.class.oclIsKindOf(UseCase) or   (a.opposite.class.oclIsKindOf(Class) and not a.opposite.class.oclIsKindOf(Behavior))))) ")

(def-mm-constraint "must_have_name" |Actor| 
   "An Actor must have a name."
   :operation-body
   "name->notEmpty()")

;;; =========================================================
;;; ====================== AddStructuralFeatureValueAction
;;; =========================================================
(def-mm-class |AddStructuralFeatureValueAction| :UML25 (|WriteStructuralFeatureAction|)
 "An add structural feature value action is a write structural feature action
  for adding values to a structural feature."
  ((|insertAt| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |addStructuralFeatureValueAction|)
    :documentation
     "Gives the position at which to insert a new value or move an existing value
      in ordered structural features. The type of the pin is UnlimitedNatural,
      but the value cannot be zero. This pin is omitted for unordered structural
      features.")
   (|isReplaceAll| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the structural feature of the object
      should be removed before adding the new value.")))


(def-mm-constraint "required_value" |AddStructuralFeatureValueAction| 
   "A value input pin is required."
   :operation-body
   "self.value -> notEmpty()")

(def-mm-constraint "unlimited_natural_and_multiplicity" |AddStructuralFeatureValueAction| 
   "Actions adding a value to ordered structural features must have a single
    input pin for the insertion point with type UnlimitedNatural and multiplicity
    of 1..1, otherwise the action has no input pin for the insertion point."
   :operation-body
   " if not structuralFeature.isOrdered then insertAt = null else    let insertAtPin : InputPin= insertAt->asSequence()->first() in      insertAt <> null     and insertAtPin.type = UnlimitedNatural     and insertAtPin.is(1,1) endif ")

;;; =========================================================
;;; ====================== AddVariableValueAction
;;; =========================================================
(def-mm-class |AddVariableValueAction| :UML25 (|WriteVariableAction|)
 "An add variable value action is a write variable action for adding values
  to a variable."
  ((|insertAt| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |addVariableValueAction|)
    :documentation
     "Gives the position at which to insert a new value or move an existing value
      in ordered variables. The types is UnlimitedINatural, but the value cannot
      be zero. This pin is omitted for unordered variables.")
   (|isReplaceAll| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the variable should be removed before
      adding the new value.")))


(def-mm-constraint "required_value" |AddVariableValueAction| 
   "A value input pin is required."
   :operation-body
   "self.value <> null")

(def-mm-constraint "single_input_pin" |AddVariableValueAction| 
   "Actions adding values to ordered variables must have a single input pin
    for the insertion point with type UnlimtedNatural and multiplicity of 1..1,
    otherwise the action has no input pin for the insertion point."
   :operation-body
   "if not variable.isOrdered then insertAt = null else   let insertAtPin : InputPin = insertAt->asSequence()->first() in     insertAt <> null     and insertAtPin.type = UnlimitedNatural     and insertAtPin.is(1,1) endif ")

;;; =========================================================
;;; ====================== AnyReceiveEvent
;;; =========================================================
(def-mm-class |AnyReceiveEvent| :UML25 (|MessageEvent|)
 "A trigger for an AnyReceiveEvent is triggered by the receipt of any message
  that is not explicitly handled by any related trigger."
  ())


;;; =========================================================
;;; ====================== Artifact
;;; =========================================================
(def-mm-class |Artifact| :UML25 (|Classifier| |DeployedArtifact|)
 "An artifact is the specification of a physical piece of information that
  is used or produced by a software development process, or by deployment
  and operation of a system. Examples of artifacts include model files, source
  files, scripts, and binary executable files, a table in a database system,
  a development deliverable, or a word-processing document, a mail message.
  An artifact is the source of a deployment to a node."
  ((|fileName| :range |String| :multiplicity (0 1)
    :documentation
     "A concrete name that is used to refer to the Artifact in a physical context.
      Example: file system name, universal resource locator.")
   (|manifestation| :range |Manifestation| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|)) :soft-opposite (|Manifestation| |artifact|)
    :documentation
     "The set of model elements that are manifested in the Artifact. That is,
      these model elements are utilized in the construction (or generation) of
      the artifact.")
   (|nestedArtifact| :range |Artifact| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Artifact| |artifact|)
    :documentation
     "The Artifacts that are defined (nested) within the Artifact. The association
      is a specialization of the ownedMember association from Namespace to NamedElement.")
   (|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|)) :soft-opposite (|Property| |artifact|)
    :documentation
     "The attributes or association ends defined for the Artifact. The association
      is a specialization of the ownedMember association.")
   (|ownedOperation| :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|)) :soft-opposite (|Operation| |artifact|)
    :documentation
     "The Operations defined for the Artifact. The association is a specialization
      of the ownedMember association.")))


;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-mm-class |Association| :UML25 (|Relationship| |Classifier|)
 "A link is a tuple of values that refer to typed objects.  An Association
  classifies a set of links, each of which is an instance of the Association.
   Each value in the link refers to an instance of the type of the corresponding
  end of the Association."
  ((|endType| :range |Type| :multiplicity (1 -1) :is-readonly-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|)) :soft-opposite (|Type| |association|)
    :documentation
     "The Classifiers that are used as types of the ends of the Association.")
   (|isDerived| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the Association is derived from other model elements
      such as other Associations.")
   (|memberEnd| :range |Property| :multiplicity (2 -1) :is-ordered-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Property| |association|)
    :documentation
     "Each end represents participation of instances of the Classifier connected
      to the end in links of the Association.")
   (|navigableOwnedEnd| :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|Association| |ownedEnd|)) :soft-opposite (|Property| |association|)
    :documentation
     "The navigable ends that are owned by the Association itself.")
   (|ownedEnd| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Association| |memberEnd|) (|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Property| |owningAssociation|)
    :documentation
     "The ends that are owned by the Association itself.")))


(def-mm-constraint "association_ends" |Association| 
   "Ends of Associations with more than two ends must be owned by the Association
    itself."
   :operation-body
   "memberEnd->size() > 2 implies ownedEnd->includesAll(memberEnd)")

(def-mm-constraint "binary_associations" |Association| 
   "Only binary Associations can be aggregations."
   :operation-body
   "memberEnd->exists(aggregation <> AggregationKind::none) implies memberEnd->size() = 2")

;;; POD
(def-mm-constraint "specialized_end_number" |Association| 
   "An Association specializing another Association has the same number of
    ends as the other Association."
   :operation-status :rewritten
   :editor-note "Don't see the point of oclAsType, but mostly I'm getting around ensure -> !"
   :original-body
   "parents()->select(oclIsKindOf(Association)).oclAsType(Association)->forAll(p | p.memberEnd->size() = self.memberEnd->size())"
   :operation-body
   "parents()->select(oclIsKindOf(Association))->forAll(p | p.memberEnd->size() = self.memberEnd->size())")


(def-mm-constraint "specialized_end_types" |Association| 
   "When an Association specializes another Association, every end of the specific
    Association corresponds to an end of the general Association, and the specific
    end reaches the same type or a subtype of the corresponding general end."
   :operation-body
   "Sequence{1..memberEnd->size()}->  forAll(i | general->select(oclIsKindOf(Association)).oclAsType(Association)->   forAll(ga | self.memberEnd->at(i).type.conformsTo(ga.memberEnd->at(i).type)))")

(def-mm-operation "endType.1" |Association| 
   "endType is derived from the types of the member ends."
   :operation-body
   "memberEnd->collect(type)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== AssociationClass
;;; =========================================================
(def-mm-class |AssociationClass| :UML25 (|Class| |Association|)
 "A model element that has both Association and Class properties. An AssociationClass
  can be seen as an Association that also has Class properties, or as a Class
  that also has Association properties. It not only connects a set of Classifiers
  but also defines a set of Features that belong to the Association itself
  and not to any of the associated Classifiers."
  ())


(def-mm-constraint "cannot_be_defined" |AssociationClass| 
   "An AssociationClass cannot be defined between itself and something else."
   :operation-status :rewritten
   :editor-note "endType is a derived property, thus don't use operation syntax."
   :original-body
   "self.endType()->excludes(self) and self.endType()->collect(et|et.oclAsType(Classifier).allParents())->flatten()->excludes(self)"
   :operation-body
   "self.endType->excludes(self) and self.endType->collect(et|et.oclAsType(Classifier).allParents())->flatten()->excludes(self)")


(def-mm-constraint "disjoint_attributes_ends" |AssociationClass| 
   "The owned attributes and owned ends of an AssociationClass are disjoint"
   :operation-body
   "ownedAttribute->intersection(ownedEnd)->isEmpty()")

;;; =========================================================
;;; ====================== Behavior
;;; =========================================================
(def-mm-class |Behavior| :UML25 (|Class|)
 "Behavior is a specification of how its context classifier changes state
  over time. This specification may be either a definition of possible behavior
  execution or emergent behavior, or a selective illustration of an interesting
  subset of possible executions. The latter form is typically used for capturing
  examples, such as a trace of a particular execution. A behavior owns zero
  or more parameter sets."
  ((|context| :range |BehavioredClassifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|)) :soft-opposite (|BehavioredClassifier| |behavior|)
    :documentation
     "The classifier that is the context for the execution of the behavior. A
      Behavior that is directly owned as a nestedClassifier does not have a context.
      Otherwise, to determine the context of a Behavior, find the first BehavioredClassifier
      reached by following the chain of owner relationships from the Behavior,
      if any. If there is such a BehavioredClassifier, then it is the context,
      unless it is itself a Behavior with a non-empty context, in which case
      that is also the context for the original Behavior. For example, following
      this algorithm, the context of an entry action in a state machine is the
      classifier that owns the state machine. The features of the context classifier
      as well as the elements visible to the context classifier are visible to
      the behavior.")
   (|isReentrant| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether the behavior can be invoked while it is still executing from
      a previous invocation.")
   (|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Parameter| |behavior|)
    :documentation
     "References a list of parameters to the behavior which describes the order
      and type of arguments that can be given when the behavior is invoked and
      of the values which will be returned when the behavior completes its execution.")
   (|ownedParameterSet| :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|ParameterSet| |behavior|)
    :documentation
     "The ParameterSets owned by this Behavior.")
   (|postcondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |behavior|)
    :documentation
     "An optional set of Constraints specifying what is fulfilled after the execution
      of the behavior is completed, if its precondition was fulfilled before
      its invocation.")
   (|precondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |behavior|)
    :documentation
     "An optional set of Constraints specifying what must be fulfilled when the
      behavior is invoked.")
   (|redefinedBehavior| :range |Behavior| :multiplicity (0 -1)
    :subsetted-properties ((|Classifier| |redefinedClassifier|)) :soft-opposite (|Behavior| |behavior|)
    :documentation
     "References a behavior that this behavior redefines. A subtype of Behavior
      may redefine any other subtype of Behavior. If the behavior implements
      a behavioral feature, it replaces the redefined behavior. If the behavior
      is a classifier behavior, it extends the redefined behavior.")
   (|specification| :range |BehavioralFeature| :multiplicity (0 1)
    :opposite (|BehavioralFeature| |method|)
    :documentation
     "Designates a behavioral feature that the behavior implements. The behavioral
      feature must be owned by the classifier that owns the behavior or be inherited
      by it. The parameters of the behavioral feature and the implementing behavior
      must match. A behavior does not need to have a specification, in which
      case it either is the classifer behavior of a BehavioredClassifier or it
      can only be invoked by another behavior of the classifier.")))


(def-mm-constraint "feature_of_context_classifier" |Behavior| 
   "The implemented behavioral feature must be a feature (possibly inherited)
    of the context classifier of the behavior."
   :operation-body
   "true")

(def-mm-constraint "most_one_behaviour" |Behavior| 
   "There may be at most one behavior for a given pairing of classifier (as
    owner of the behavior) and behavioral feature (as specification of the
    behavior)."
   :operation-body
   "true")

(def-mm-constraint "must_realize" |Behavior| 
   "If the implemented behavioral feature has been redefined in the ancestors
    of the owner of the behavior, then the behavior must realize the latest
    redefining behavioral feature."
   :operation-body
   "true")

(def-mm-constraint "parameters_match" |Behavior| 
   "The parameters of the behavior must match the parameters of the implemented
    behavioral feature."
   :operation-body
   "true")

(def-mm-operation "context.1" |Behavior| 
   "Missing derivation for Behavior::/context : BehavioredClassifier"
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|BehavioredClassifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== BehaviorExecutionSpecification
;;; =========================================================
(def-mm-class |BehaviorExecutionSpecification| :UML25 (|ExecutionSpecification|)
 "A BehaviorExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of a Behavior."
  ((|behavior| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |behaviorExecutionSpecification|)
    :documentation
     "Behavior whose execution is occurring.")))


;;; =========================================================
;;; ====================== BehavioralFeature
;;; =========================================================
(def-mm-class |BehavioralFeature| :UML25 (|Feature| |Namespace|)
 "A BehavioralFeature is a feature of a Classifier that specifies an aspect
  of the behavior of its instances.  A BehavioralFeature is implemented (realized)
  by a Behavior. A BehavioralFeature specifies that a Classifier will respond
  to a designated request by invoking its implementing method."
  ((|concurrency| :range |CallConcurrencyKind| :multiplicity (1 1) :default :sequential
    :documentation
     "Specifies the semantics of concurrent calls to the same passive instance
      (i.e., an instance originating from a Class with isActive being false).
      Active instances control access to their own BehavioralFeatures.")
   (|isAbstract| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, then the BehavioralFeature does not have an implementation, and
      one must be supplied by a more specific Classifier. If false, theBehavioralFeature
      must have an implementation in the Classifier or one must be inherited.")
   (|method| :range |Behavior| :multiplicity (0 -1)
    :opposite (|Behavior| |specification|)
    :documentation
     "A Behavioral that implements the BehavioralFeature. There may be at most
      one Behavior for a particular pairing of a Classifier (as owner of the
      Behavior) and a BehavioralFeature (as specification of the Behavior).")
   (|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Parameter| |ownerFormalParam|)
    :documentation
     "The ordered set of formal Parameters of this BehavioralFeature.")
   (|ownedParameterSet| :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|ParameterSet| |behavioralFeature|)
    :documentation
     "The ParameterSets owned by this BehavioralFeature.")
   (|raisedException| :range |Type| :multiplicity (0 -1) :soft-opposite (|Type| |behavioralFeature|)
    :documentation
     "The Types representing exceptions that may be raised during an invocation
      of this BehavioralFeature.")))


(def-mm-operation "isDistinguishableFrom" |BehavioralFeature| 
   "The query isDistinguishableFrom() determines whether two BehavioralFeatures
    may coexist in the same Namespace. It specifies that they must have different
    signatures."
   :operation-body
   "(n.oclIsKindOf(BehavioralFeature) and ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()) implies    Set{}->including(self)->including(n.oclAsType(BehavioralFeature))->isUnique(ownedParameter->collect(type))   "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== BehavioredClassifier
;;; =========================================================
(def-mm-class |BehavioredClassifier| :UML25 (|Classifier|)
 "A BehavioredClassifier may have InterfaceRealizations, and owns a set of
  Behaviors one of which may specify the behavior of the BehavioredClassifier
  itself."
  ((|classifierBehavior| :range |Behavior| :multiplicity (0 1)
    :subsetted-properties ((|BehavioredClassifier| |ownedBehavior|)) :soft-opposite (|Behavior| |behavioredClassifier|)
    :documentation
     "A Behavior that specifies the behavior of the BehavioredClassifier itself.")
   (|interfaceRealization| :range |InterfaceRealization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|InterfaceRealization| |implementingClassifier|)
    :documentation
     "The set of InterfaceRealizations owned by the BehavioredClassifier. Interface
      realizations reference the Interfaces of which the BehavioredClassifier
      is an implementation.")
   (|ownedBehavior| :range |Behavior| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Behavior| |behavioredClassifier|)
    :documentation
     "Behaviors owned by a BehavioredClassifier.")))


(def-mm-constraint "class_behavior" |BehavioredClassifier| 
   "If a behavior is classifier behavior, it does not have a specification."
   :operation-body
   "classifierBehavior->notEmpty() implies classifierBehavior.specification->isEmpty()")

;;; =========================================================
;;; ====================== BroadcastSignalAction
;;; =========================================================
(def-mm-class |BroadcastSignalAction| :UML25 (|InvocationAction|)
 "A broadcast signal action is an action that transmits a signal instance
  to all the potential target objects in the system, which may cause the
  firing of a state machine transitions or the execution of associated activities
  of a target object. The argument values are available to the execution
  of associated behaviors. The requestor continues execution immediately
  after the signals are sent out. It does not wait for receipt. Any reply
  messages are ignored and are not transmitted to the requestor."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |broadcastSignalAction|)
    :documentation
     "The specification of signal object transmitted to the target objects.")))


(def-mm-constraint "number_and_order" |BroadcastSignalAction| 
   "The number and order of argument pins must be the same as the number and
    order of attributes in the signal."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity" |BroadcastSignalAction| 
   "The type, ordering, and multiplicity of an argument pin must be the same
    as the corresponding attribute of the signal."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== CallAction
;;; =========================================================
(def-mm-class |CallAction| :UML25 (|InvocationAction|)
 "CallAction is an abstract class for actions that invoke behavior and receive
  return values."
  ((|isSynchronous| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, the call is synchronous and the caller waits for completion of
      the invoked behavior. If false, the call is asynchronous and the caller
      proceeds immediately and does not expect a return values.")
   (|result| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |callAction|)
    :documentation
     "A list of output pins where the results of performing the invocation are
      placed.")))


(def-mm-constraint "number_and_order" |CallAction| 
   "The number and order of argument pins must be the same as the number and
    order of parameters of the invoked behavior or behavioral feature. Pins
    are matched to parameters by order."
   :operation-body
   "true")

(def-mm-constraint "synchronous_call" |CallAction| 
   "Only synchronous call actions can have result pins."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity" |CallAction| 
   "The type, ordering, and multiplicity of an argument pin must be the same
    as the corresponding parameter of the behavior or behavioral feature."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== CallBehaviorAction
;;; =========================================================
(def-mm-class |CallBehaviorAction| :UML25 (|CallAction|)
 "A call behavior action is a call action that invokes a behavior directly
  rather than invoking a behavioral feature that, in turn, results in the
  invocation of that behavior. The argument values of the action are available
  to the execution of the invoked behavior. For synchronous calls the execution
  of the call behavior action waits until the execution of the invoked behavior
  completes and a result is returned on its output pin. The action completes
  immediately without a result, if the call is asynchronous. In particular,
  the invoked behavior may be an activity."
  ((|behavior| :range |Behavior| :multiplicity (1 1) :soft-opposite (|Behavior| |callBehaviorAction|)
    :documentation
     "The invoked behavior. It must be capable of accepting and returning control.")))


(def-mm-constraint "argument_pin_equal_parameter" |CallBehaviorAction| 
   "The number of argument pins and the number of parameters of the behavior
    of type in and in-out must be equal."
   :operation-body
   "true")

(def-mm-constraint "result_pin_equal_parameter" |CallBehaviorAction| 
   "The number of result pins and the number of parameters of the behavior
    of type return, out, and in-out must be equal."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity" |CallBehaviorAction| 
   "The type, ordering, and multiplicity of an argument or result pin is derived
    from the corresponding parameter of the behavior."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== CallEvent
;;; =========================================================
(def-mm-class |CallEvent| :UML25 (|MessageEvent|)
 "A call event models the receipt by an object of a message invoking a call
  of an operation."
  ((|operation| :range |Operation| :multiplicity (1 1) :soft-opposite (|Operation| |callEvent|)
    :documentation
     "Designates the operation whose invocation raised the call event.")))


;;; =========================================================
;;; ====================== CallOperationAction
;;; =========================================================
(def-mm-class |CallOperationAction| :UML25 (|CallAction|)
 "A call operation action is an action that transmits an operation call request
  to the target object, where it may cause the invocation of associated behavior.
  The argument values of the action are available to the execution of the
  invoked behavior. If the action is marked synchronous, the execution of
  the call operation action waits until the execution of the invoked behavior
  completes and a reply transmission is returned to the caller; otherwise
  execution of the action is complete when the invocation of the operation
  is established and the execution of the invoked operation proceeds concurrently
  with the execution of the calling behavior. Any values returned as part
  of the reply transmission are put on the result output pins of the call
  operation action. Upon receipt of the reply transmission, execution of
  the call operation action is complete."
  ((|operation| :range |Operation| :multiplicity (1 1) :soft-opposite (|Operation| |callOperationAction|)
    :documentation
     "The operation to be invoked by the action execution.")
   (|target| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |callOperationAction|)
    :documentation
     "The target object to which the request is sent. The classifier of the target
      object is used to dynamically determine a behavior to invoke. This object
      constitutes the context of the execution of the operation.")))


(def-mm-constraint "argument_pin_equal_parameter" |CallOperationAction| 
   "The number of argument pins and the number of owned parameters of the operation
    of type in and in-out must be equal."
   :operation-body
   "true")

(def-mm-constraint "result_pin_equal_parameter" |CallOperationAction| 
   "The number of result pins and the number of owned parameters of the operation
    of type return, out, and in-out must be equal."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity" |CallOperationAction| 
   "The type, ordering, and multiplicity of an argument or result pin is derived
    from the corresponding owned parameter of the operation."
   :operation-body
   "true")

(def-mm-constraint "type_target_pin" |CallOperationAction| 
   "The type of the target pin must be the same as the type that owns the operation."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== CentralBufferNode
;;; =========================================================
(def-mm-class |CentralBufferNode| :UML25 (|ObjectNode|)
 "A central buffer node is an object node for managing flows from multiple
  sources and destinations."
  ())


;;; =========================================================
;;; ====================== ChangeEvent
;;; =========================================================
(def-mm-class |ChangeEvent| :UML25 (|Event|)
 "A change event models a change in the system configuration that makes a
  condition true."
  ((|changeExpression| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |changeEvent|)
    :documentation
     "A Boolean-valued expression that will result in a change event whenever
      its value changes from false to true.")))


;;; =========================================================
;;; ====================== Class
;;; =========================================================
(def-mm-class |Class| :UML25 (|BehavioredClassifier| |EncapsulatedClassifier|)
 "A Class classifies a set of objects and specifies the features that characterize
  the structure and behavior of those objects.  A Class may have an internal
  structure and Ports."
  ((|extension| :range |Extension| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Extension| |metaclass|)
    :documentation
     "This property is used when the Class is acting as a metaclass. It references
      the Extensions that specify additional properties of the metaclass. The
      property is derived from the Extensions whose memberEnds are typed by the
      Class.")
   (|isAbstract| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Class does not provide a complete declaration and cannot be
      instantiated. An abstract Class is typically used as a target of Associations
      or Generalizations." :redefined-property (|Classifier| |isAbstract|))
   (|isActive| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Determines whether an object specified by this Class is active or not.
      If true, then the owning Class is referred to as an active Class. If false,
      then such a Class is referred to as a passive Class.")
   (|nestedClassifier| :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Classifier| |nestingClass|)
    :documentation
     "The Classifiers that are nested within the Class.")
   (|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |class|)
    :documentation
     "The attributes (i.e. the Properties) owned by the Class." :redefined-property (|StructuredClassifier| |ownedAttribute|))
   (|ownedOperation| :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |class|)
    :documentation
     "The Operations owned by the Class.")
   (|ownedReception| :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|)) :soft-opposite (|Reception| |class|)
    :documentation
     "The Receptions owned by the Class.")
   (|superClass| :range |Class| :multiplicity (0 -1) :is-derived-p T :soft-opposite (|Class| |class|)
    :documentation
     "The superclasses of a Class, derived from its Generalizations." :redefined-property (|Classifier| |general|))))


(def-mm-constraint "passive_class" |Class| 
   "Only an active Class may own Receptions."
   :operation-body
   "not isActive implies ownedReception->isEmpty()")

(def-mm-operation "extension.1" |Class| 
   "Derivation for Class::/extension : Extension"
   :operation-body
   "Extension.allInstances()->select(ext |    let endTypes : Sequence(Classifier) = ext.memberEnd->collect(type.oclAsType(Classifier)) in   endTypes->includes(self) or endTypes.allParents()->includes(self) )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Extension|
                        :parameter-return-p T))
)

(def-mm-operation "inherit" |Class| 
   "The inherit operation is overridden to exclude redefined Properties."
   :operation-body
   "let excludedElements : Set(RedefinableElement) =   inhs->select(inh |      inh.oclIsKindOf(RedefinableElement) and          let redinh : RedefinableElement = inh.oclAsType(RedefinableElement) in            (self.ownedMember->select(oclIsKindOf(RedefinableElement)) ->collect(oclAsType(RedefinableElement).redefinedElement))->includes(redinh))->                collect(oclAsType(RedefinableElement))->asSet()   in    inhs -  excludedElements"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "superClass.1" |Class| 
   "Derivation for Class::/superClass : Class"
   :operation-body
   "self.general()->select(oclIsKindOf(Class))->collect(oclAsType(Class))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Class|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Classifier
;;; =========================================================
(def-mm-class |Classifier| :UML25 (|Namespace| |Type| |TemplateableElement| |RedefinableElement|)
 "A Classifier represents a classification of objects according to their
  Features. Classifiers are related by Generalizations."
  ((|attribute| :range |Property| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Classifier| |feature|)) :soft-opposite (|Property| |classifier|)
    :documentation
     "All of the Properties that are direct (i.e. not inherited or imported)
      attributes of the Classifier.")
   (|collaborationUse| :range |CollaborationUse| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|CollaborationUse| |classifier|)
    :documentation
     "The CollaborationUses owned by the Classifier.")
   (|feature| :range |Feature| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Feature| |featuringClassifier|)
    :documentation
     "Specifies each Feature directly defined in the classifier. Note that there
      may be members of the Classifier that are of the type Feature but are not
      included, e.g. inherited features.")
   (|general| :range |Classifier| :multiplicity (0 -1) :is-derived-p T :soft-opposite (|Classifier| |classifier|)
    :documentation
     "The generalizing Classifiers for this Classifier.")
   (|generalization| :range |Generalization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Generalization| |specific|)
    :documentation
     "The Generalization relationships for this Classifier. These Generalizations
      navigate to more general Classifiers in the generalization hierarchy.")
   (|inheritedMember| :range |NamedElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|)) :soft-opposite (|NamedElement| |inheritingClassifier|)
    :documentation
     "All elements inherited by this Classifier from its general Classifiers.")
   (|isAbstract| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier does not provide a complete declaration and cannot
      be instantiated. An abstract Classifier is intended to be used by other
      Classifiers e.g. as the target of Associations or Generalizations.")
   (|isFinalSpecialization| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier cannot be specialized.")
   (|ownedTemplateSignature| :range |RedefinableTemplateSignature| :multiplicity (0 1) :is-composite-p T
    :opposite (|RedefinableTemplateSignature| |classifier|)
    :documentation
     "The optional RedefinableTemplateSignature specifying the formal template
      parameters." :redefined-property (|TemplateableElement| |ownedTemplateSignature|))
   (|ownedUseCase| :range |UseCase| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|UseCase| |classifier|)
    :documentation
     "The UseCases owned by this classifier.")
   (|powertypeExtent| :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |powertype|)
    :documentation
     "The GeneralizationSet of which this Classifier is a power type.")
   (|redefinedClassifier| :range |Classifier| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Classifier| |classifier|)
    :documentation
     "The Classifiers redefined by this Classifier.")
   (|representation| :range |CollaborationUse| :multiplicity (0 1)
    :subsetted-properties ((|Classifier| |collaborationUse|)) :soft-opposite (|CollaborationUse| |classifier|)
    :documentation
     "A CollaborationUse which indicates the Collaboration that represents this
      Classifier.")
   (|substitution| :range |Substitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|Substitution| |substitutingClassifier|)
    :documentation
     "The Substitutions owned by this Classifier.")
   (|templateParameter| :range |ClassifierTemplateParameter| :multiplicity (0 1)
    :opposite (|ClassifierTemplateParameter| |parameteredElement|)
    :documentation
     "TheClassifierTemplateParameter that exposes this element as a formal parameter." :redefined-property (|ParameterableElement| |templateParameter|))
   (|useCase| :range |UseCase| :multiplicity (0 -1)
    :opposite (|UseCase| |subject|)
    :documentation
     "The set of UseCases for which this Classifier is the subject.")))


(def-mm-constraint "maps_to_generalization_set" |Classifier| 
   "The Classifier that maps to a GeneralizationSet may neither be a specific
    nor a general Classifier in any of the Generalization relationships defined
    for that GeneralizationSet. In other words, a power type may not be an
    instance of itself nor may its instances also be its subclasses."
   :operation-body
   "powertypeExtent->forAll( gs |    gs.generalization->forAll( gen |      not (gen.general = self) and not gen.general.allParents()->includes(self) and not (gen.specific = self) and not self.allParents()->includes(gen.specific)    ))")

;;; POD
;
;   "Generalization hierarchies must be directed and acyclical. A Classifier
;    can not be both a transitively general and transitively specific Classifier
;    of the same Classifier."
;   :operation-body
;   "not allParents()->includes(self)")

(def-mm-constraint "non_final_parents" |Classifier| 
   "The parents of a Classifier must be non-final."
   :operation-body
   "parents()->forAll(not isFinalSpecialization)")

(def-mm-constraint "specialize_type" |Classifier| 
   "A Classifier may only specialize Classifiers of a valid type."
   :operation-body
   "parents()->forAll(c | self.maySpecializeType(c))")

(def-mm-operation "allFeatures" |Classifier| 
   "The query allFeatures() gives all of the features in the namespace of the
    Classifier. In general, through mechanisms such as inheritance, this will
    be a larger set than feature."
   :operation-body
   "member->select(oclIsKindOf(Feature))->collect(oclAsType(Feature))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Feature|
                        :parameter-return-p T))
)

(def-mm-operation "allParents" |Classifier| 
   "The query allParents() gives all of the direct and indirect ancestors of
    a generalized Classifier."
   :operation-body
   "parents()->union(parents()->collect(allParents())->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-mm-operation "allRealizedInterfaces" |Classifier| 
   "The Interfaces realized by this Classifier and all of its generalizations"
   :operation-body
   "directlyRealizedInterfaces()->union(self.allParents()->collect(directlyRealizedInterfaces()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "allUsedInterfaces" |Classifier| 
   "The Interfaces used by this Classifier and all of its generalizations"
   :operation-body
   "directlyUsedInterfaces()->union(self.allParents()->collect(directlyUsedInterfaces()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "conformsTo" |Classifier| 
   "The query conformsTo() gives true for a Classifier that defines a type
    that conforms to another. This is used, for example, in the specification
    of signature conformance for operations."
   :operation-body
   "self = other or allParents()->includes(other)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-mm-operation "directlyRealizedInterfaces" |Classifier| 
   "The Interfaces directly realized by this Classifier"
   :operation-body
   "(clientDependency->   select(oclIsKindOf(Realization) and supplier->forAll(oclIsKindOf(Interface))))->       collect(supplier.oclAsType(Interface))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "directlyUsedInterfaces" |Classifier| 
   "The Interfaces directly used by this Classifier"
   :operation-body
   "(supplierDependency->   select(oclIsKindOf(Usage) and client->forAll(oclIsKindOf(Interface))))->     collect(client.oclAsType(Interface))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "general.1" |Classifier| 
   "The general Classifiers are the ones referenced by the Generalization relationships."
   :operation-body
   "parents()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-mm-operation "hasVisibilityOf" |Classifier| 
   "The query hasVisibilityOf() determines whether a NamedElement is visible
    in the classifier. By default all are visible. It is only called when the
    argument is something owned by a parent."
   :operation-body
   "n.visibility <> VisibilityKind::private"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "inherit" |Classifier| 
   "The query inherit() defines how to inherit a set of elements. Here the
    operation is defined to inherit them all. It is intended to be redefined
    in circumstances where inheritance is affected by redefinition."
   :operation-body
   "inhs"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "inheritableMembers" |Classifier| 
   "The query inheritableMembers() gives all of the members of a Classifier
    that may be inherited in one of its descendants, subject to whatever visibility
    restrictions apply."
   :operation-body
   "member->select(m | c.hasVisibilityOf(m))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-mm-operation "inheritedMember.1" |Classifier| 
   "The inheritedMember association is derived by inheriting the inheritable
    members of the parents."
   :operation-body
   "inherit(parents()->collect(inheritableMembers(self))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T))
)

(def-mm-operation "isTemplate" |Classifier| 
   "The query isTemplate() returns whether this Classifier is actually a template."
   :operation-body
   "ownedTemplateSignature <> null or general->exists(g | g.isTemplate())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "maySpecializeType" |Classifier| 
   "The query maySpecializeType() determines whether this classifier may have
    a generalization relationship to classifiers of the specified type. By
    default a classifier may specialize classifiers of the same or a more general
    type. It is intended to be redefined by classifiers that have different
    specialization constraints."
   :operation-body
   "self.oclIsKindOf(c.oclType())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\c :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-mm-operation "parents" |Classifier|  
   "The query parents() gives all of the immediate ancestors of a generalized
    Classifier."
   :operation-body
   "generalization.general->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)



;;; =========================================================
;;; ====================== ClassifierTemplateParameter
;;; =========================================================
(def-mm-class |ClassifierTemplateParameter| :UML25 (|TemplateParameter|)
 "A ClassifierTemplateParameter exposes a Classifier as a formal template
  parameter."
  ((|allowSubstitutable| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Constrains the required relationship between an actual parameter and the
      parameteredElement for this formal parameter.")
   (|constrainingClassifier| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |classifierTemplateParameter|)
    :documentation
     "The classifiers that constrain the argument that can be used for the parameter.
      If the allowSubstitutable attribute is true, then any Classifier that is
      compatible with this constraining Classifier can be substituted; otherwise,
      it must be either this Classifier or one of its specializations. If this
      property is empty, there are no constraints on the Classifier that can
      be used as an argument.")
   (|parameteredElement| :range |Classifier| :multiplicity (1 1)
    :opposite (|Classifier| |templateParameter|)
    :documentation
     "The Classifier exposed by this ClassifierTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))


(def-mm-constraint "has_constraining_classifier" |ClassifierTemplateParameter| 
   "If \"allowSubstitutable\" is true, then there must be a constrainingClassifier."
   :operation-body
   "allowSubstitutable implies constrainingClassifier->notEmpty()")

;;; =========================================================
;;; ====================== Clause
;;; =========================================================
(def-mm-class |Clause| :UML25 (|Element|)
 "A clause is an element that represents a single branch of a conditional
  construct, including a test and a body section. The body section is executed
  only if (but not necessarily if) the test section evaluates true."
  ((|body| :range |ExecutableNode| :multiplicity (0 -1) :soft-opposite (|ExecutableNode| |clause|)
    :documentation
     "A nested activity fragment that is executed if the test evaluates to true
      and the clause is chosen over any concurrent clauses that also evaluate
      to true.")
   (|bodyOutput| :range |OutputPin| :multiplicity (0 -1) :is-ordered-p T :soft-opposite (|OutputPin| |clause|)
    :documentation
     "A list of output pins within the body fragment whose values are moved to
      the result pins of the containing conditional node after execution of the
      clause body.")
   (|decider| :range |OutputPin| :multiplicity (1 1) :soft-opposite (|OutputPin| |clause|)
    :documentation
     "An output pin within the test fragment the value of which is examined after
      execution of the test to determine whether the body should be executed.")
   (|predecessorClause| :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |successorClause|)
    :documentation
     "A set of clauses whose tests must all evaluate false before the current
      clause can be tested.")
   (|successorClause| :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |predecessorClause|)
    :documentation
     "A set of clauses which may not be tested unless the current clause tests
      false.")
   (|test| :range |ExecutableNode| :multiplicity (1 -1) :soft-opposite (|ExecutableNode| |clause|)
    :documentation
     "A nested activity fragment with a designated output pin that specifies
      the result of the test.")))


(def-mm-constraint "body_output_pins" |Clause| 
   "The bodyOutput pins are output pins on actions in the body of the clause."
   :operation-body
   "true")

(def-mm-constraint "decider_output" |Clause| 
   "The decider output pin must be for the test body or a node contained by
    the test body as a structured node."
   :operation-body
   "true")

(def-mm-constraint "test_and_body" |Clause| 
   "The test and body parts must be disjoint."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ClearAssociationAction
;;; =========================================================
(def-mm-class |ClearAssociationAction| :UML25 (|Action|)
 "A clear association action is an action that destroys all links of an association
  in which a particular object participates."
  ((|association| :range |Association| :multiplicity (1 1) :soft-opposite (|Association| |clearAssociationAction|)
    :documentation
     "Association to be cleared.")
   (|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |clearAssociationAction|)
    :documentation
     "Gives the input pin from which is obtained the object whose participation
      in the association is to be cleared.")))


(def-mm-constraint "multiplicity" |ClearAssociationAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "self.object.is(1,1)")

(def-mm-constraint "same_type" |ClearAssociationAction| 
   "The type of the input pin must be the same as the type of at least one
    of the association ends of the association."
   :operation-body
   "self.association.memberEnd->exists(type = self.object.type)")

;;; =========================================================
;;; ====================== ClearStructuralFeatureAction
;;; =========================================================
(def-mm-class |ClearStructuralFeatureAction| :UML25 (|StructuralFeatureAction|)
 "A clear structural feature action is a structural feature action that removes
  all values of a structural feature."
  ((|result| :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |clearStructuralFeatureAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "multiplicity_of_result" |ClearStructuralFeatureAction| 
   "The multiplicity of the result output pin must be 1..1."
   :operation-body
   "result<>null implies result.is(1,1)")

(def-mm-constraint "type_of_result" |ClearStructuralFeatureAction| 
   "The type of the result output pin is the same as the type of the inherited
    object input pin."
   :operation-body
   "result<>null implies result.type = object.type")

;;; =========================================================
;;; ====================== ClearVariableAction
;;; =========================================================
(def-mm-class |ClearVariableAction| :UML25 (|VariableAction|)
 "A clear variable action is a variable action that removes all values of
  a variable."
  ())


;;; =========================================================
;;; ====================== Collaboration
;;; =========================================================
(def-mm-class |Collaboration| :UML25 (|StructuredClassifier| |BehavioredClassifier|)
 "A Collaboration describes a structure of collaborating elements (roles),
  each performing a specialized function, which collectively accomplish some
  desired functionality."
  ((|collaborationRole| :range |ConnectableElement| :multiplicity (0 -1)
    :subsetted-properties ((|StructuredClassifier| |role|)) :soft-opposite (|ConnectableElement| |collaboration|)
    :documentation
     "References ConnectableElements (possibly owned by other Classifiers) which
      represent roles that instances may play in this Collaboration.")))


;;; =========================================================
;;; ====================== CollaborationUse
;;; =========================================================
(def-mm-class |CollaborationUse| :UML25 (|NamedElement|)
 "A CollaborationUse is used to specify the application of a pattern specified
  by a Collaboration to a specific situation."
  ((|roleBinding| :range |Dependency| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Dependency| |collaborationUse|)
    :documentation
     "A mapping between features of the Collaboration and features of the owning
      Classifier. This mapping indicates which ConnectableElement of the Classifier
      plays which role(s) in the Collaboration. A ConnectableElement may be bound
      to multiple roles in the same CollaborationUse (that is, it may play multiple
      roles).")
   (|type| :range |Collaboration| :multiplicity (1 1) :soft-opposite (|Collaboration| |collaborationUse|)
    :documentation
     "The Collaboration which is used in this CollaborationUse. The Collaboration
      defines the cooperation between its roles which are mapped to ConnectableElements
      relating to the Classifier owning the CollaborationUse.")))


(def-mm-constraint "client_elements" |CollaborationUse| 
   "All the client elements of a roleBinding are in one Classifier and all
    supplier elements of a roleBinding are in one Collaboration."
   :operation-body
   "roleBinding->collect(client)->forAll(ne1, ne2 |   ne1.oclIsKindOf(ConnectableElement) and ne2.oclIsKindOf(ConnectableElement) and     let ce1 : ConnectableElement = ne1.oclAsType(ConnectableElement), ce2 : ConnectableElement = ne2.oclAsType(ConnectableElement) in       ce1.structuredClassifier = ce2.structuredClassifier) and   roleBinding->collect(supplier)->forAll(ne1, ne2 |   ne1.oclIsKindOf(ConnectableElement) and ne2.oclIsKindOf(ConnectableElement) and     let ce1 : ConnectableElement = ne1.oclAsType(ConnectableElement), ce2 : ConnectableElement = ne2.oclAsType(ConnectableElement) in       ce1.collaboration = ce2.collaboration)")

(def-mm-constraint "connectors" |CollaborationUse| 
   "Connectors in a Collaboration typing a CollaborationUse must have corresponding
    Connectors between elements bound in the context Classifier, and these
    corresponding Connectors must have the same or more general type than the
    Collaboration Connectors."
   :operation-body
   "type.ownedConnector->forAll(connector |   let rolesConnectedInCollab : Set(ConnectableElement) = connector.end.role->asSet(),         relevantBindings : Set(Dependency) = roleBinding->select(rb | rb.supplier->intersection(rolesConnectedInCollab)->notEmpty()),         boundRoles : Set(ConnectableElement) = relevantBindings->collect(client.oclAsType(ConnectableElement))->asSet(),         contextClassifier : StructuredClassifier = boundRoles->any(true).structuredClassifier->any(true) in           contextClassifier.ownedConnector->exists( correspondingConnector |                correspondingConnector.end.role->forAll( role | boundRoles->includes(role) )               and (connector.type->notEmpty() and correspondingConnector.type->notEmpty()) implies connector.type.conformsTo(correspondingConnector.type) ) )")

(def-mm-constraint "every_role" |CollaborationUse| 
   "Every collaborationRole in the Collaboration is bound within the CollaborationUse."
   :operation-body
   "type.collaborationRole->forAll(role | roleBinding->exists(rb | rb.supplier->includes(role)))")

;;; =========================================================
;;; ====================== CombinedFragment
;;; =========================================================
(def-mm-class |CombinedFragment| :UML25 (|InteractionFragment|)
 "A CombinedFragment defines an expression of InteractionFragments. A CombinedFragment
  is defined by an interaction operator and corresponding InteractionOperands.
  Through the use of CombinedFragments the user will be able to describe
  a number of traces in a compact and concise manner."
  ((|cfragmentGate| :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Gate| |combinedFragment|)
    :documentation
     "Specifies the gates that form the interface between this CombinedFragment
      and its surroundings")
   (|interactionOperator| :range |InteractionOperatorKind| :multiplicity (1 1) :default :seq
    :documentation
     "Specifies the operation which defines the semantics of this combination
      of InteractionFragments.")
   (|operand| :range |InteractionOperand| :multiplicity (1 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|InteractionOperand| |combinedFragment|)
    :documentation
     "The set of operands of the combined fragment.")))


(def-mm-constraint "break" |CombinedFragment| 
   "If the interactionOperator is break, the corresponding InteractionOperand
    must cover all Lifelines covered by the enclosing InteractionFragment."
   :operation-body
   "if interactionOperator=InteractionOperatorKind::break  then    enclosingInteraction.oclAsType(InteractionFragment)-> asSet()->union(enclosingOperand.oclAsType(InteractionFragment)->asSet()).covered->asSet() =  self.covered->asSet() else true  endif")

(def-mm-constraint "consider_and_ignore" |CombinedFragment| 
   "The interaction operators 'consider' and 'ignore' can only be used for
    the CombineIgnoreFragment subtype of CombinedFragment"
   :operation-body
   "((interactionOperator = InteractionOperatorKind::consider) or (interactionOperator =  InteractionOperatorKind::ignore)) implies oclIsKindOf(ConsiderIgnoreFragment)")

(def-mm-constraint "opt_loop_break_neg" |CombinedFragment| 
   "If the interactionOperator is opt, loop, break, assert or neg, there must
    be exactly one operand."
   :operation-body
   "(interactionOperator =  InteractionOperatorKind::opt or interactionOperator = InteractionOperatorKind::loop or interactionOperator = InteractionOperatorKind::break or interactionOperator = InteractionOperatorKind::assert or interactionOperator = InteractionOperatorKind::neg) implies operand->size()=1")

;;; =========================================================
;;; ====================== Comment
;;; =========================================================
(def-mm-class |Comment| :UML25 (|Element|)
 "A comment is a textual annotation that can be attached to a set of elements."
  ((|annotatedElement| :range |Element| :multiplicity (0 -1) :soft-opposite (|Element| |comment|)
    :documentation
     "References the Element(s) being commented.")
   (|body| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a string that is the comment.")))


;;; =========================================================
;;; ====================== CommunicationPath
;;; =========================================================
(def-mm-class |CommunicationPath| :UML25 (|Association|)
 "A communication path is an association between two deployment targets,
  through which they are able to exchange signals and messages."
  ())


(def-mm-constraint "association_ends" |CommunicationPath| 
   "The association ends of a CommunicationPath are typed by DeploymentTargets."
   :operation-body
   "endType->forAll (oclIsKindOf(DeploymentTarget))")

;;; =========================================================
;;; ====================== Component
;;; =========================================================
(def-mm-class |Component| :UML25 (|Class|)
 "A Component represents a modular part of a system that encapsulates its
  contents and whose manifestation is replaceable within its environment."
  ((|isIndirectlyInstantiated| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, the Component is defined at design-time, but at run-time (or execution-time)
      an object specified by the Component does not exist, that is, the Component
      is instantiated indirectly, through the instantiation of its realizing
      Classifiers or parts.")
   (|packagedElement| :range |PackageableElement| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|PackageableElement| |component|)
    :documentation
     "The set of PackageableElements that a Component owns. In the namespace
      of a Component, all model elements that are involved in or related to its
      definition may be owned or imported explicitly. These may include e.g.
      Classes, Interfaces, Components, Packages, UseCases, Dependencies (e.g.
      mappings), and Artifacts.")
   (|provided| :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Interface| |component|)
    :documentation
     "The Interfaces that the Component exposes to its environment. These Interfaces
      may be Realized by the Component or any of its realizingClassifiers, or
      they may be the Interfaces that are provided by its public Ports.")
   (|realization| :range |ComponentRealization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ComponentRealization| |abstraction|)
    :documentation
     "The set of Realizations owned by the Component. Realizations reference
      the Classifiers of which the Component is an abstraction; i.e., that realize
      its behavior.")
   (|required| :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Interface| |component|)
    :documentation
     "The Interfaces that the Component requires from other Components in its
      environment in order to be able to offer its full set of provided functionality.
      These Interfaces may be used by the Component or any of its realizingClassifiers,
      or they may be the Interfaces that are required by its public Ports.")))


(def-mm-constraint "no_nested_classifiers" |Component| 
   "A Component cannot nest Classifiers."
   :operation-body
   "nestedClassifier->isEmpty()")

(def-mm-constraint "no_packaged_elements" |Component| 
   "A Component nested in a Class cannot have any packaged elements."
   :operation-body
   "nestingClass <> null implies packagedElement->isEmpty()")

(def-mm-operation "provided.1" |Component| 
   "Derivation for Comppnent::/provided"
   :operation-body
   "let  ris : Set(Interface) = allRealizedInterfaces(),         realizingClassifiers : Set(Classifier) =  self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),         allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),         realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allRealizedInterfaces())),         ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),         providedByPorts : Set(Interface) = ports.provided->asSet() in     ris->union(realizingClassifierInterfaces) ->union(providedByPorts)->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "required.1" |Component| 
   "Derivation for Comppnent::/required"
   :operation-body
   "let  uis : Set(Interface) = allUsedInterfaces(),         realizingClassifiers : Set(Classifier) = self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),         allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),         realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allUsedInterfaces())),         ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),         usedByPorts : Set(Interface) = ports.required->asSet() in     uis->union(realizingClassifierInterfaces)->union(usedByPorts)->asSet() "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ComponentRealization
;;; =========================================================
(def-mm-class |ComponentRealization| :UML25 (|Realization|)
 "Realization is specialized to (optionally) define the Classifiers that
  realize the contract offered by a Component in terms of its provided and
  required Interfaces. The Component forms an abstraction from these various
  Classifiers."
  ((|abstraction| :range |Component| :multiplicity (0 1)
    :subsetted-properties ((|Dependency| |supplier|) (|Element| |owner|))
    :opposite (|Component| |realization|)
    :documentation
     "The Component that owns this ComponentRealization and which is implemented
      by its realizing Classifiers.")
   (|realizingClassifier| :range |Classifier| :multiplicity (1 -1)
    :subsetted-properties ((|Dependency| |client|)) :soft-opposite (|Classifier| |componentRealization|)
    :documentation
     "The Classifiers that are involved in the implementation of the Component
      that owns this Realization.")))


;;; =========================================================
;;; ====================== ConditionalNode
;;; =========================================================
(def-mm-class |ConditionalNode| :UML25 (|StructuredActivityNode|)
 "A conditional node is a structured activity node that represents an exclusive
  choice among some number of alternatives."
  ((|clause| :range |Clause| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Clause| |conditionalNode|)
    :documentation
     "Set of clauses composing the conditional.")
   (|isAssured| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that at least one test will succeed.")
   (|isDeterminate| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that at most one test will succeed.")
   (|result| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T :soft-opposite (|OutputPin| |conditionalNode|)
    :documentation
     "A list of output pins that constitute the data flow outputs of the conditional." :redefined-property (|StructuredActivityNode| |structuredNodeOutput|))))


(def-mm-constraint "clause_no_predecessor" |ConditionalNode| 
   "No two clauses within a ConditionalNode maybe predecessor clauses of each
    other, either directly or indirectly."
   :operation-body
   "true")

(def-mm-constraint "executable_nodes" |ConditionalNode| 
   "The union of the ExecutabledNodes in the test and body parts of all clauses
    must be the same as the subset of nodes contained in the ConditionalNode
    (considered as a StructuredActivityNode) that are ExecutableNodes."
   :operation-body
   "true")

(def-mm-constraint "matching_output_pins" |ConditionalNode| 
   "Each clause of a conditional node must have the same number of bodyOutput
    pins as the conditional node has result output pins, and each clause bodyOutput
    pin must be compatible with the corresponding result pin (by positional
    order) in type, multiplicity, ordering and uniqueness."
   :operation-body
   "true")

(def-mm-constraint "no_input_pins" |ConditionalNode| 
   "A conditional node has no input pins."
   :operation-body
   "true")

(def-mm-constraint "one_clause_with_executable_node" |ConditionalNode| 
   "No ExecutableNode may appear in the test or body part of more than one
    clause of a conditional node."
   :operation-body
   "true")

(def-mm-constraint "result_no_incoming" |ConditionalNode| 
   "The result output pins have no incoming edges."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ConnectableElement
;;; =========================================================
(def-mm-class |ConnectableElement| :UML25 (|TypedElement| |ParameterableElement|)
 "ConnectableElement is an abstract metaclass representing a set of instances
  that play roles of a StructuredClassifier. ConnectableElements may be joined
  by attached Connectors and specify configurations of linked instances to
  be created within an instance of the containing StructuredClassifier."
  ((|end| :range |ConnectorEnd| :multiplicity (0 -1) :is-readonly-p T :is-ordered-p T :is-derived-p T
    :opposite (|ConnectorEnd| |role|)
    :documentation
     "A set of ConnectorEnds that attach to this ConnectableElement.")
   (|templateParameter| :range |ConnectableElementTemplateParameter| :multiplicity (0 1)
    :opposite (|ConnectableElementTemplateParameter| |parameteredElement|)
    :documentation
     "The ConnectableElementTemplateParameter for this ConnectableElement parameter." :redefined-property (|ParameterableElement| |templateParameter|))))


(def-mm-operation "end.1" |ConnectableElement| 
   "Derivation for ConnectableElement::/end : ConnectorEnd"
   :operation-body
   "ConnectorEnd.allInstances()->select(role = self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorEnd|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ConnectableElementTemplateParameter
;;; =========================================================
(def-mm-class |ConnectableElementTemplateParameter| :UML25 (|TemplateParameter|)
 "A ConnectableElementTemplateParameter exposes a ConnectableElement as a
  formal parameter for a template."
  ((|parameteredElement| :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |templateParameter|)
    :documentation
     "The ConnectableElement for this ConnectableElementTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))


;;; =========================================================
;;; ====================== ConnectionPointReference
;;; =========================================================
(def-mm-class |ConnectionPointReference| :UML25 (|Vertex|)
 "A ConnectionPointReference represents a usage (as part of a submachine
  State) of an entry/exit point Pseudostate defined in the StateMachine referenced
  by the submachine State."
  ((|entry| :range |Pseudostate| :multiplicity (0 -1) :soft-opposite (|Pseudostate| |connectionPointReference|)
    :documentation
     "The entryPoint kind pseudo states corresponding to this connection point.")
   (|exit| :range |Pseudostate| :multiplicity (0 -1) :soft-opposite (|Pseudostate| |connectionPointReference|)
    :documentation
     "The exitPoints kind pseudo states corresponding to this connection point.")
   (|state| :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |connection|)
    :documentation
     "The State in which the connection point refreshens are defined.")))


(def-mm-constraint "entry_pseudostates" |ConnectionPointReference| 
   "The entry Pseudostates must be Pseudostates with kind entryPoint."
   :operation-body
   "entry->forAll(kind = PseudostateKind::entryPoint)")

(def-mm-constraint "exit_pseudostates" |ConnectionPointReference| 
   "The exit Pseudostates must be Pseudostates with kind exitPoint."
   :operation-body
   "exit->forAll(kind = PseudostateKind::exitPoint)")

;;; =========================================================
;;; ====================== Connector
;;; =========================================================
(def-mm-class |Connector| :UML25 (|Feature|)
 "A Connector specifies links that enables communication between two or more
  instances. In contrast to Associations, which specify links between any
  instance of the associated Classifiers, Connectors specify links between
  instances playing the connected parts only."
  ((|contract| :range |Behavior| :multiplicity (0 -1) :soft-opposite (|Behavior| |connector|)
    :documentation
     "The set of Behaviors that specify the valid interaction patterns across
      the Connector.")
   (|end| :range |ConnectorEnd| :multiplicity (2 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ConnectorEnd| |connector|)
    :documentation
     "A Connector has at least two ConnectorEnds, each representing the participation
      of instances of the Classifiers typing the ConnectableElements attached
      to the end. The set of ConnectorEnds is ordered.")
   (|kind| :range |ConnectorKind| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Indicates the kind of Connector. This is derived: a Connector with one
      or more ends connected to a Port which is not on a Part and which is not
      a behavior port is a delegation; otherwise it is an assembly.")
   (|redefinedConnector| :range |Connector| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Connector| |connector|)
    :documentation
     "A Connector may be redefined when its containing Classifier is specialized.
      The redefining Connector may have a type that specializes the type of the
      redefined Connector. The types of the ConnectorEnds of the redefining Connector
      may specialize the types of the ConnectorEnds of the redefined Connector.
      The properties of the ConnectorEnds of the redefining Connector may be
      replaced.")
   (|type| :range |Association| :multiplicity (0 1) :soft-opposite (|Association| |connector|)
    :documentation
     "An optional Association that classifies links corresponding to this Connector.")))


(def-mm-constraint "roles" |Connector| 
   "The ConnectableElements attached as roles to each ConnectorEnd owned by
    a Connector must be roles of the Classifier that owned the Connector, or
    they must be Ports of such roles."
   :operation-body
   "structuredClassifier <> null    and end->forAll( e |    structuredClassifier.role->includes(e.role)      or    e.role.oclIsKindOf(Port) and structuredClassifier.role->includes(e.partWithPort))")

(def-mm-constraint "types" |Connector| 
   "The types of the ConnectableElements that the ends of a Connector are attached
    to must conform to the types of the ends of the Association that types
    the Connector, if any."
   :operation-body
   "type<>null implies    let noOfEnds : Integer = end->size() in    (type.memberEnd->size() = noOfEnds) and Sequence{1..noOfEnds}->forAll(i | end->at(i).role.type.conformsTo(type.memberEnd->at(i).type))")

(def-mm-operation "kind.1" |Connector| 
   "Derivation for Connector::/kind : ConnectorKind"
   :operation-body
   "if end->exists(   role.oclIsKindOf(Port)    and partWithPort->isEmpty()   and not role.oclAsType(Port).isBehavior) then ConnectorKind::delegation  else ConnectorKind::assembly  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorKind|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ConnectorEnd
;;; =========================================================
(def-mm-class |ConnectorEnd| :UML25 (|MultiplicityElement|)
 "A ConnectorEnd is an endpoint of a Connector, which attaches the Connector
  to a ConnectableElement."
  ((|definingEnd| :range |Property| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Property| |connectorEnd|)
    :documentation
     "A derived property referencing the corresponding end on the Association
      which types the Connector owing this ConnectorEnd, if any. It is derived
      by selecting the end at the same place in the ordering of Association ends
      as this ConnectorEnd.")
   (|partWithPort| :range |Property| :multiplicity (0 1) :soft-opposite (|Property| |connectorEnd|)
    :documentation
     "Indicates the role of the internal structure of a Classifier with the Port
      to which the ConnectorEnd is attached.")
   (|role| :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |end|)
    :documentation
     "The ConnectableElement attached at this ConnectorEnd. When an instance
      of the containing Classifier is created, a link may (depending on the multiplicities)
      be created to an instance of the Classifier that types this ConnectableElement.")))


(def-mm-constraint "multiplicity" |ConnectorEnd| 
   "The multiplicity of the ConnectorEnd may not be more general than the multiplicity
    of the corresponding end of the Association typing the owning Connector,
    if any."
   :operation-body
   "self.compatibleWith(definingEnd)")

(def-mm-constraint "part_with_port_empty" |ConnectorEnd| 
   "If a ConnectorEnd is attached to a Port of the containing Classifier, partWithPort
    will be empty."
   :operation-body
   "(role.oclIsKindOf(Port) and role.owner = connector.owner) implies partWithPort->isEmpty()")

(def-mm-constraint "role_and_part_with_port" |ConnectorEnd| 
   "If a ConnectorEnd references a partWithPort, then the role must be a Port
    that is defined or inherited by the type of the partWithPort."
   :operation-body
   "partWithPort->notEmpty() implies    (role.oclIsKindOf(Port) and partWithPort.type.oclAsType(Namespace).member->includes(role))")

(def-mm-constraint "self_part_with_port" |ConnectorEnd| 
   "The Property held in self.partWithPort must not be a Port."
   :operation-body
   "partWithPort->notEmpty() implies not partWithPort.oclIsKindOf(Port)")

(def-mm-operation "definingEnd.1" |ConnectorEnd| 
   "Derivation for ConnectorEnd::/definingEnd : Property"
   :operation-body
   "if connector.type = null  then   null  else   let index : Integer = connector.end->indexOf(self) in     connector.type.memberEnd->at(index) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ConsiderIgnoreFragment
;;; =========================================================
(def-mm-class |ConsiderIgnoreFragment| :UML25 (|CombinedFragment|)
 "A ConsiderIgnoreFragment is a kind of CombinedFragment that is used for
  the consider and ignore cases, which require lists of pertinent Messages
  to be specified."
  ((|message| :range |NamedElement| :multiplicity (0 -1) :soft-opposite (|NamedElement| |considerIgnoreFragment|)
    :documentation
     "The set of messages that apply to this fragment")))


(def-mm-constraint "consider_or_ignore" |ConsiderIgnoreFragment| 
   "The interaction operator of a ConsiderIgnoreFragment must be either 'consider'
    or 'ignore'."
   :operation-body
   "(interactionOperator =  InteractionOperatorKind::consider) or (interactionOperator =  InteractionOperatorKind::ignore)")

(def-mm-constraint "type" |ConsiderIgnoreFragment| 
   "The NamedElements must be of a type of element that can be a signature
    for a message (i.e.., an Operation, or a Signal)."
   :operation-body
   "message->forAll(m | m.oclIsKindOf(Operation) or m.oclIsKindOf(Signal))")

;;; =========================================================
;;; ====================== Constraint
;;; =========================================================
(def-mm-class |Constraint| :UML25 (|PackageableElement|)
 "A constraint is a condition or restriction expressed in natural language
  text or in a machine readable language for the purpose of declaring some
  of the semantics of an element."
  ((|constrainedElement| :range |Element| :multiplicity (0 -1) :is-ordered-p T :soft-opposite (|Element| |constraint|)
    :documentation
     "The ordered set of Elements referenced by this Constraint.")
   (|context| :range |Namespace| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Namespace| |ownedRule|)
    :documentation
     "Specifies the namespace that owns the NamedElement.")
   (|specification| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningConstraint|)
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied.")))


(def-mm-constraint "boolean_value" |Constraint| 
   "The value specification for a constraint must evaluate to a Boolean value."
   :original-body
   "Cannot be expressed in OCL "
   :operation-body "true"
   :editor-note "See original."
   :operation-status :ignored)

(def-mm-constraint "no_side_effects" |Constraint| 
   "Evaluating the value specification for a constraint must not have side
    effects."
   :original-body
   "Cannot be expressed in OCL "
   :operation-body "true"
   :editor-note "See original."
   :operation-status :ignored)

(def-mm-constraint "not_apply_to_self" |Constraint| 
   "A constraint cannot be applied to itself."
   :operation-body
   "not constrainedElement->includes(self)")

;;; =========================================================
;;; ====================== Continuation
;;; =========================================================
(def-mm-class |Continuation| :UML25 (|InteractionFragment|)
 "A Continuation is a syntactic way to define continuations of different
  branches of an alternative CombinedFragment. Continuations are intuitively
  similar to labels representing intermediate points in a flow of control."
  ((|setting| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "True: when the Continuation is at the end of the enclosing InteractionFragment
      and False when it is in the beginning.")))


(def-mm-constraint "first_or_last_interaction_fragment" |Continuation| 
   "Continuations always occur as the very first InteractionFragment or the
    very last InteractionFragment of the enclosing InteractionOperand."
   :operation-body
   " enclosingOperand->notEmpty() and   let peerFragments : OrderedSet(InteractionFragment) =  enclosingOperand.fragment in     ( peerFragments->notEmpty() and     ((peerFragments->first() = self) or  (peerFragments->last() = self)))")

(def-mm-constraint "global" |Continuation| 
   "Continuations are always global in the enclosing InteractionFragment e.g.
    it always covers all Lifelines covered by the enclosing InteractionOperator."
   :operation-body
   "enclosingOperand->notEmpty() and   let operandLifelines : Set(Lifeline) =  enclosingOperand.covered in      (operandLifelines->notEmpty() and      operandLifelines->forAll(ol :Lifeline |self.covered->includes(ol)))")

(def-mm-constraint "same_name" |Continuation| 
   "Across all Interaction instances having the same context value, every Lifeline
    instance covered by a Continuation (self) must be common with one covered
    Lifeline instance of all other Continuation instances with the same name
    as self, and every Lifeline instance covered by a Continuation instance
    with the same name as self must be common with one covered Lifeline instance
    of self. Lifeline instances are common if they have the same selector and
    represents associationEnd values."
   :operation-body
   "enclosingOperand.combinedFragment->notEmpty() and let parentInteraction : Set(Interaction) =  enclosingOperand.combinedFragment->closure(enclosingOperand.combinedFragment)-> collect(enclosingInteraction).oclAsType(Interaction)->asSet() in  (parentInteraction->size() = 1)  and let peerInteractions : Set(Interaction) =  (parentInteraction->union(parentInteraction->collect(_'context')->collect(behavior)->  select(oclIsKindOf(Interaction)).oclAsType(Interaction)->asSet())->asSet()) in  (peerInteractions->notEmpty()) and    let combinedFragments1 : Set(CombinedFragment) = peerInteractions.fragment->  select(oclIsKindOf(CombinedFragment)).oclAsType(CombinedFragment)->asSet() in    combinedFragments1->notEmpty() and  combinedFragments1->closure(operand.fragment->    select(oclIsKindOf(CombinedFragment)).oclAsType(CombinedFragment))->asSet().operand.fragment->    select(oclIsKindOf(Continuation)).oclAsType(Continuation)->asSet()->    forAll(c : Continuation |  (c.name = self.name) implies    (c.covered->asSet()->forAll(cl : Lifeline | --  cl must be common to one lifeline covered by self   
self.covered->asSet()->   select(represents = cl.represents and selector = cl.selector)->asSet()->size()=1))    and  (self.covered->asSet()->forAll(cl : Lifeline | --  cl must be common to one lifeline covered by c  
c.covered->asSet()->   select(represents = cl.represents and selector = cl.selector)->asSet()->size()=1))   )")

;;; =========================================================
;;; ====================== ControlFlow
;;; =========================================================
(def-mm-class |ControlFlow| :UML25 (|ActivityEdge|)
 "A control flow is an edge that starts an activity node after the previous
  one is finished."
  ())


(def-mm-constraint "object_nodes" |ControlFlow| 
   "Control flows may not have object nodes at either end, except for object
    nodes with control type."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ControlNode
;;; =========================================================
(def-mm-class |ControlNode| :UML25 (|ActivityNode|)
 "A control node is an abstract activity node that coordinates flows in an
  activity."
  ())


;;; =========================================================
;;; ====================== CreateLinkAction
;;; =========================================================
(def-mm-class |CreateLinkAction| :UML25 (|WriteLinkAction|)
 "A create link action is a write link action for creating links."
  ((|endData| :range |LinkEndCreationData| :multiplicity (2 -1) :is-composite-p T :soft-opposite (|LinkEndCreationData| |createLinkAction|)
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))


(def-mm-constraint "association_not_abstract" |CreateLinkAction| 
   "The association cannot be an abstract classifier."
   :operation-body
   "not self.association().isAbstract")

;;; =========================================================
;;; ====================== CreateLinkObjectAction
;;; =========================================================
(def-mm-class |CreateLinkObjectAction| :UML25 (|CreateLinkAction|)
 "A create link object action creates a link object."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |createLinkObjectAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "association_class" |CreateLinkObjectAction| 
   "The association must be an association class."
   :operation-body
   "self.association().oclIsKindOf(Class)")

(def-mm-constraint "multiplicity" |CreateLinkObjectAction| 
   "The multiplicity of the output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "type_of_result" |CreateLinkObjectAction| 
   "The type of the result pin must be the same as the association of the action."
   :operation-body
   "result.type = association()")

;;; =========================================================
;;; ====================== CreateObjectAction
;;; =========================================================
(def-mm-class |CreateObjectAction| :UML25 (|Action|)
 "A create object action is an action that creates an object that conforms
  to a statically specified classifier and puts it on an output pin at runtime."
  ((|classifier| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |createObjectAction|)
    :documentation
     "Classifier to be instantiated.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |createObjectAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "classifier_not_abstract" |CreateObjectAction| 
   "The classifier cannot be abstract."
   :operation-body
   "not classifier.isAbstract ")

(def-mm-constraint "classifier_not_association_class" |CreateObjectAction| 
   "The classifier cannot be an association class"
   :operation-body
   "not classifier.oclIsKindOf(AssociationClass)")

(def-mm-constraint "multiplicity" |CreateObjectAction| 
   "The multiplicity of the output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "same_type" |CreateObjectAction| 
   "The type of the result pin must be the same as the classifier of the action."
   :operation-body
   "result.type = classifier")

;;; =========================================================
;;; ====================== DataStoreNode
;;; =========================================================
(def-mm-class |DataStoreNode| :UML25 (|CentralBufferNode|)
 "A data store node is a central buffer node for non-transient information."
  ())


;;; =========================================================
;;; ====================== DataType
;;; =========================================================
(def-mm-class |DataType| :UML25 (|Classifier|)
 "A DataType is a type whose instances are identified only by their value."
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
   :operation-body
   "inhs->reject(inh |      inh.oclIsKindOf(RedefinableElement) and ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh.oclAsType(RedefinableElement)))->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== DecisionNode
;;; =========================================================
(def-mm-class |DecisionNode| :UML25 (|ControlNode|)
 "A decision node is a control node that chooses between outgoing flows."
  ((|decisionInput| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |decisionNode|)
    :documentation
     "Provides input to guard specifications on edges outgoing from the decision
      node.")
   (|decisionInputFlow| :range |ObjectFlow| :multiplicity (0 1) :soft-opposite (|ObjectFlow| |decisionNode|)
    :documentation
     "An additional edge incoming to the decision node that provides a decision
      input value.")))


(def-mm-constraint "decision_input_flow_incoming" |DecisionNode| 
   "The decisionInputFlow of a decision node must be an incoming edge of the
    decision node."
   :operation-body
   "true")

(def-mm-constraint "edges" |DecisionNode| 
   "The edges coming into and out of a decision node, other than the decision
    input flow (if any), must be either all object flows or all control flows."
   :operation-body
   "true")

(def-mm-constraint "incoming_control_one_input_parameter" |DecisionNode| 
   "If the decision node has a decision input flow and an incoming control
    flow, then a decision input behavior has one input parameter whose type
    is the same as or a supertype of the type of object tokens offered on the
    decision input flow."
   :operation-body
   "true")

(def-mm-constraint "incoming_object_one_input_parameter" |DecisionNode| 
   "If the decision node has no decision input flow and an incoming object
    flow, then a decision input behavior has one input parameter whose type
    is the same as or a supertype of the type of object tokens offered on the
    incoming edge."
   :operation-body
   "true")

(def-mm-constraint "incoming_outgoing_edges" |DecisionNode| 
   "A decision node has one or two incoming edges and at least one outgoing
    edge."
   :operation-body
   "true")

(def-mm-constraint "parameters" |DecisionNode| 
   "A decision input behavior has no output parameters, no in-out parameters
    and one return parameter."
   :operation-body
   "true")

(def-mm-constraint "two_input_parameters" |DecisionNode| 
   "If the decision node has a decision input flow and an second incoming object
    flow, then a decision input behavior has two input parameters, the first
    of which has a type that is the same as or a supertype of the type of the
    type of object tokens offered on the nondecision input flow and the second
    of which has a type that is the same as or a supertype of the type of object
    tokens offered on the decision input flow."
   :operation-body
   "true")

(def-mm-constraint "zero_input_parameters" |DecisionNode| 
   "If the decision node has no decision input flow and an incoming control
    flow, then a decision input behavior has zero input parameters."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Dependency
;;; =========================================================
(def-mm-class |Dependency| :UML25 (|DirectedRelationship| |PackageableElement|)
 "A dependency is a relationship that signifies that a single or a set of
  model elements requires other model elements for their specification or
  implementation. This means that the complete semantics of the depending
  elements is either semantically or structurally dependent on the definition
  of the supplier element(s)."
  ((|client| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|NamedElement| |clientDependency|)
    :documentation
     "The element(s) dependent on the supplier element(s). In some cases (such
      as a Trace Abstraction) the assignment of direction (that is, the designation
      of the client element) is at the discretion of the modeler, and is a stipulation.")
   (|supplier| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|NamedElement| |supplierDependency|)
    :documentation
     "The element(s) independent of the client element(s), in the same respect
      and the same dependency relationship. In some directed dependency relationships
      (such as Refinement Abstractions), a common convention in the domain of
      class-based OO software is to put the more abstract element in this role.
      Despite this convention, users of UML may stipulate a sense of dependency
      suitable for their domain, which makes a more abstract element dependent
      on that which is more specific.")))


;;; =========================================================
;;; ====================== DeployedArtifact
;;; =========================================================
(def-mm-class |DeployedArtifact| :UML25 (|NamedElement|)
 "A deployed artifact is an artifact or artifact instance that has been deployed
  to a deployment target."
  ())


;;; =========================================================
;;; ====================== Deployment
;;; =========================================================
(def-mm-class |Deployment| :UML25 (|Dependency|)
 "A deployment is the allocation of an artifact or artifact instance to a
  deployment target. A component deployment is the deployment of one or more
  artifacts or artifact instances to a deployment target, optionally parameterized
  by a deployment specification. Examples are executables and configuration
  files."
  ((|configuration| :range |DeploymentSpecification| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|DeploymentSpecification| |deployment|)
    :documentation
     "The specification of properties that parameterize the deployment and execution
      of one or more Artifacts.")
   (|deployedArtifact| :range |DeployedArtifact| :multiplicity (0 -1)
    :subsetted-properties ((|Dependency| |supplier|)) :soft-opposite (|DeployedArtifact| |deploymentForArtifact|)
    :documentation
     "The Artifacts that are deployed onto a Node. This association specializes
      the supplier association.")
   (|location| :range |DeploymentTarget| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|DeploymentTarget| |deployment|)
    :documentation
     "The DeployedTarget which is the target of a Deployment.")))


;;; =========================================================
;;; ====================== DeploymentSpecification
;;; =========================================================
(def-mm-class |DeploymentSpecification| :UML25 (|Artifact|)
 "A deployment specification specifies a set of properties that determine
  execution parameters of a component artifact that is deployed on a node.
  A deployment specification can be aimed at a specific type of container.
  An artifact that reifies or implements deployment specification properties
  is a deployment descriptor."
  ((|deployment| :range |Deployment| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Deployment| |configuration|)
    :documentation
     "The deployment with which the DeploymentSpecification is associated.")
   (|deploymentLocation| :range |String| :multiplicity (0 1)
    :documentation
     "The location where an Artifact is deployed onto a Node. This is typically
      a 'directory' or 'memory address'.")
   (|executionLocation| :range |String| :multiplicity (0 1)
    :documentation
     "The location where a component Artifact executes. This may be a local or
      remote location.")))


(def-mm-constraint "deployed_elements" |DeploymentSpecification| 
   "The deployedElements of a DeploymentTarget that are involved in a Deployment
    that has an associated Deployment-Specification is a kind of Component
    (i.e. the configured components)."
   :operation-body
   "deployment->forAll (location.deployedElement->forAll (oclIsKindOf(Component)))")

(def-mm-constraint "deployment_target" |DeploymentSpecification| 
   "The DeploymentTarget of a DeploymentSpecification is a kind of ExecutionEnvironment."
   :operation-body
   "deployment->forAll (location.oclIsKindOf(ExecutionEnvironment))")

;;; =========================================================
;;; ====================== DeploymentTarget
;;; =========================================================
(def-mm-class |DeploymentTarget| :UML25 (|NamedElement|)
 "A deployment target is the location for a deployed artifact."
  ((|deployedElement| :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|PackageableElement| |deploymentTarget|)
    :documentation
     "The set of elements that are manifested in an Artifact that is involved
      in Deployment to a DeploymentTarget.")
   (|deployment| :range |Deployment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|Deployment| |location|)
    :documentation
     "The set of Deployments for a DeploymentTarget.")))


(def-mm-operation "deployedElement.1" |DeploymentTarget| 
   "Derivation for DeploymentTarget::/deployedElement"
   :operation-body
   "deployment.deployedArtifact->select(oclIsKindOf(Artifact))->collect(oclAsType(Artifact).manifestation)->collect(utilizedElement)->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== DestroyLinkAction
;;; =========================================================
(def-mm-class |DestroyLinkAction| :UML25 (|WriteLinkAction|)
 "A destroy link action is a write link action that destroys links and link
  objects."
  ((|endData| :range |LinkEndDestructionData| :multiplicity (2 -1) :is-composite-p T :soft-opposite (|LinkEndDestructionData| |destroyLinkAction|)
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))


;;; =========================================================
;;; ====================== DestroyObjectAction
;;; =========================================================
(def-mm-class |DestroyObjectAction| :UML25 (|Action|)
 "A destroy object action is an action that destroys objects."
  ((|isDestroyLinks| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether links in which the object participates are destroyed
      along with the object.")
   (|isDestroyOwnedObjects| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether objects owned by the object are destroyed along with
      the object.")
   (|target| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |destroyObjectAction|)
    :documentation
     "The input pin providing the object to be destroyed.")))


(def-mm-constraint "multiplicity" |DestroyObjectAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "target.is(1,1)")

(def-mm-constraint "no_type" |DestroyObjectAction| 
   "The input pin has no type."
   :operation-body
   "target.type= null")

;;; =========================================================
;;; ====================== DestructionOccurrenceSpecification
;;; =========================================================
(def-mm-class |DestructionOccurrenceSpecification| :UML25 (|MessageOccurrenceSpecification|)
 "A DestructionOccurenceSpecification models the destruction of an object."
  ())


(def-mm-constraint "no_occurrence_specifications_below" |DestructionOccurrenceSpecification| 
   "No other OccurrenceSpecifications on a given Lifeline in an InteractionOperand
    may appear below a DestructionOccurrenceSpecification."
   :operation-body
   "let o : InteractionOperand = enclosingOperand in o->notEmpty() and  let peerEvents : OrderedSet(OccurrenceSpecification) = covered.events->select(enclosingOperand = o) in peerEvents->last() = self")

;;; =========================================================
;;; ====================== Device
;;; =========================================================
(def-mm-class |Device| :UML25 (|Node|)
 "A device is a physical computational resource with processing capability
  upon which artifacts may be deployed for execution. Devices may be complex
  (i.e., they may consist of other devices)."
  ())


;;; =========================================================
;;; ====================== DirectedRelationship
;;; =========================================================
(def-mm-class |DirectedRelationship| :UML25 (|Relationship|)
 "A directed relationship represents a relationship between a collection
  of source model elements and a collection of target model elements."
  ((|source| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|)) :soft-opposite (|Element| |directedRelationship|)
    :documentation
     "Specifies the sources of the DirectedRelationship.")
   (|target| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|)) :soft-opposite (|Element| |directedRelationship|)
    :documentation
     "Specifies the targets of the DirectedRelationship.")))


;;; =========================================================
;;; ====================== Duration
;;; =========================================================
(def-mm-class |Duration| :UML25 (|ValueSpecification|)
 "Duration defines a value specification that specifies the temporal distance
  between two time instants."
  ((|expr| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |duration|)
    :documentation
     "The value of the Duration.")
   (|observation| :range |Observation| :multiplicity (0 -1) :soft-opposite (|Observation| |duration|)
    :documentation
     "Refers to the time and duration observations that are involved in expr.")))


;;; =========================================================
;;; ====================== DurationConstraint
;;; =========================================================
(def-mm-class |DurationConstraint| :UML25 (|IntervalConstraint|)
 "A duration constraint is a constraint that refers to a duration interval."
  ((|firstEvent| :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to constrainedElement[i] (where i
      is 1 or 2). If firstEvent[i] is true, then the corresponding observation
      event is the first time instant the execution enters constrainedElement[i].
      If firstEvent[i] is false, then the corresponding observation event is
      the last time instant the execution is within constrainedElement[i]. Default
      value is true applied when constrainedElement[i] refers an element that
      represents only one time instant.")
   (|specification| :range |DurationInterval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|DurationInterval| |durationConstraint|)
    :documentation
     "The interval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))


(def-mm-constraint "first_event_multiplicity" |DurationConstraint| 
   "The multiplicity of firstEvent must be 2 if the multiplicity of constrainedElement
    is 2. Otherwise the multiplicity of firstEvent is 0."
   :operation-body
   "if (constrainedElement->size() =2)   then (firstEvent->size() = 2) else (firstEvent->size() = 0)  endif")

;;; =========================================================
;;; ====================== DurationInterval
;;; =========================================================
(def-mm-class |DurationInterval| :UML25 (|Interval|)
 "A duration interval defines the range between two durations."
  ((|max| :range |Duration| :multiplicity (1 1) :soft-opposite (|Duration| |durationInterval|)
    :documentation
     "Refers to the Duration denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :range |Duration| :multiplicity (1 1) :soft-opposite (|Duration| |durationInterval|)
    :documentation
     "Refers to the Duration denoting the minimum value of the range." :redefined-property (|Interval| |min|))))


;;; =========================================================
;;; ====================== DurationObservation
;;; =========================================================
(def-mm-class |DurationObservation| :UML25 (|Observation|)
 "A duration observation is a reference to a duration during an execution.
  It points out the element(s) in the model to observe and whether the observations
  are when this model element is entered or when it is exited."
  ((|event| :range |NamedElement| :multiplicity (1 2) :soft-opposite (|NamedElement| |durationObservation|)
    :documentation
     "The observation is determined by the entering or exiting of the event element
      during execution.")
   (|firstEvent| :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to event[i] (where i is 1 or 2).
      If firstEvent[i] is true, then the corresponding observation event is the
      first time instant the execution enters event[i]. If firstEvent[i] is false,
      then the corresponding observation event is the time instant the execution
      exits event[i]. Default value is true applied when event[i] refers an element
      that represents only one time instant.")))


(def-mm-constraint "first_event_multiplicity" |DurationObservation| 
   "The multiplicity of firstEvent must be 2 if the multiplicity of event is
    2. Otherwise the multiplicity of firstEvent is 0."
   :operation-body
   "if (event->size() = 2)   then (firstEvent->size() = 2) else (firstEvent->size() = 0) endif")

;;; =========================================================
;;; ====================== Element
;;; =========================================================
(def-mm-class |Element| :UML25 NIL
 "An element is a constituent of a model. As such, it has the capability
  of owning other elements."
  ((|ownedComment| :range |Comment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Comment| |owningElement|)
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
   "mustBeOwned() implies owner->notEmpty()")

(def-mm-constraint "not_own_self" |Element| 
   "An element may not directly or indirectly own itself."
   :operation-body
   "not allOwnedElements()->includes(self)")

(def-mm-operation "allOwnedElements" |Element| 
   "The query allOwnedElements() gives all of the direct and indirect owned
    elements of an element."
   :operation-body
   "ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Element|
                        :parameter-return-p T))
)

(def-mm-operation "mustBeOwned" |Element| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner. Subclasses of Element that do not require an owner must override
    this operation."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ElementImport
;;; =========================================================
(def-mm-class |ElementImport| :UML25 (|DirectedRelationship|)
 "An element import identifies an element in another package, and allows
  the element to be referenced using its name without a qualifier."
  ((|alias| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the name that should be added to the namespace of the importing
      package in lieu of the name of the imported packagable element. The aliased
      name must not clash with any other member name in the importing package.
      By default, no alias is used.")
   (|importedElement| :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|PackageableElement| |import|)
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
   "importedElement.visibility <> null implies importedElement.visibility = VisibilityKind::public")

(def-mm-constraint "visibility_public_or_private" |ElementImport| 
   "The visibility of an ElementImport is either public or private."
   :operation-body
   "visibility = VisibilityKind::public or visibility = VisibilityKind::private")

(def-mm-operation "getName" |ElementImport| 
   "The query getName() returns the name under which the imported PackageableElement
    will be known in the importing namespace."
   :operation-body
   "if alias->notEmpty() then   alias else   importedElement.name endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== EncapsulatedClassifier
;;; =========================================================
(def-mm-class |EncapsulatedClassifier| :UML25 (|StructuredClassifier|)
 "An EncapsulatedClassifier may own Ports to specify typed interaction points."
  ((|ownedPort| :range |Port| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|StructuredClassifier| |ownedAttribute|)) :soft-opposite (|Port| |encapsulatedClassifier|)
    :documentation
     "The Ports owned by the EncapsulatedClassifier.")))


(def-mm-operation "ownedPort.1" |EncapsulatedClassifier| 
   "Derivation for EncapsulatedClassifier::/ownedPort : Port"
   :operation-body
   "ownedAttribute->select(oclIsKindOf(Port))->collect(oclAsType(Port))->asOrderedSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Port|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Enumeration
;;; =========================================================
(def-mm-class |Enumeration| :UML25 (|DataType|)
 "An Enumeration is a DataType whose values are enumerated in the model as
  EnumerationLiterals."
  ((|ownedLiteral| :range |EnumerationLiteral| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|EnumerationLiteral| |enumeration|)
    :documentation
     "The ordered set of literals owned by this Enumeration.")))


;;; =========================================================
;;; ====================== EnumerationLiteral
;;; =========================================================
(def-mm-class |EnumerationLiteral| :UML25 (|InstanceSpecification|)
 "An EnumerationLiteral is a user-defined data value for an Enumeration."
  ((|classifier| :range |Enumeration| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Enumeration| |enumerationLiteral|)
    :documentation
     "The classifier of this EnumerationLiteral derived to be equal to its Enumeration." :redefined-property (|InstanceSpecification| |classifier|))
   (|enumeration| :range |Enumeration| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Enumeration| |ownedLiteral|)
    :documentation
     "The Enumeration that this EnumerationLiteral is a member of.")))


(def-mm-operation "classifier.1" |EnumerationLiteral| 
   "Derivation of Enumeration::/classifier"
   :operation-body
   "enumeration"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Enumeration|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Event
;;; =========================================================
(def-mm-class |Event| :UML25 (|PackageableElement|)
 "An event is the specification of some occurrence that may potentially trigger
  effects by an object."
  ())


;;; =========================================================
;;; ====================== ExceptionHandler
;;; =========================================================
(def-mm-class |ExceptionHandler| :UML25 (|Element|)
 "An exception handler is an element that specifies a body to execute in
  case the specified exception occurs during the execution of the protected
  node."
  ((|exceptionInput| :range |ObjectNode| :multiplicity (1 1) :soft-opposite (|ObjectNode| |exceptionHandler|)
    :documentation
     "An object node within the handler body. When the handler catches an exception,
      the exception token is placed in this node, causing the body to execute.")
   (|exceptionType| :range |Classifier| :multiplicity (1 -1) :soft-opposite (|Classifier| |exceptionHandler|)
    :documentation
     "The kind of instances that the handler catches. If an exception occurs
      whose type is any of the classifiers in the set, the handler catches the
      exception and executes its body.")
   (|handlerBody| :range |ExecutableNode| :multiplicity (1 1) :soft-opposite (|ExecutableNode| |exceptionHandler|)
    :documentation
     "A node that is executed if the handler satisfies an uncaught exception.")
   (|protectedNode| :range |ExecutableNode| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|ExecutableNode| |handler|)
    :documentation
     "The node protected by the handler. The handler is examined if an exception
      propagates to the outside of the node.")))


(def-mm-constraint "edge_source_target" |ExceptionHandler| 
   "An edge that has a source in an exception handler structured node must
    have its target in the handler also, and vice versa."
   :operation-body
   "true")

(def-mm-constraint "exception_body" |ExceptionHandler| 
   "The exception handler and its input object node are not the source or target
    of any edge."
   :operation-body
   "true")

(def-mm-constraint "one_input" |ExceptionHandler| 
   "The handler body has one input, and that input is the same as the exception
    input."
   :operation-body
   "true")

(def-mm-constraint "result_pins" |ExceptionHandler| 
   "If the protected node is a StructuredActivityNode with output pins, then
    the exception handler body must also be a StructuredActivityNode with output
    pins that correspond in number and types to those of the protected node."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ExecutableNode
;;; =========================================================
(def-mm-class |ExecutableNode| :UML25 (|ActivityNode|)
 "An executable node is an abstract class for activity nodes that may be
  executed. It is used as an attachment point for exception handlers. An
  executable node is an abstract class for activity nodes that may be executed.
  It is used as an attachment point for exception handlers."
  ((|handler| :range |ExceptionHandler| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ExceptionHandler| |protectedNode|)
    :documentation
     "A set of exception handlers that are examined if an uncaught exception
      propagates to the outer level of the executable node.")))


;;; =========================================================
;;; ====================== ExecutionEnvironment
;;; =========================================================
(def-mm-class |ExecutionEnvironment| :UML25 (|Node|)
 "An execution environment is a node that offers an execution environment
  for specific types of components that are deployed on it in the form of
  executable artifacts."
  ())


;;; =========================================================
;;; ====================== ExecutionOccurrenceSpecification
;;; =========================================================
(def-mm-class |ExecutionOccurrenceSpecification| :UML25 (|OccurrenceSpecification|)
 "An ExecutionOccurrenceSpecification represents moments in time at which
  Actions or Behaviors start or finish."
  ((|execution| :range |ExecutionSpecification| :multiplicity (1 1) :soft-opposite (|ExecutionSpecification| |executionOccurrenceSpecification|)
    :documentation
     "References the execution specification describing the execution that is
      started or finished at this execution event.")))


;;; =========================================================
;;; ====================== ExecutionSpecification
;;; =========================================================
(def-mm-class |ExecutionSpecification| :UML25 (|InteractionFragment|)
 "An ExecutionSpecification is a specification of the execution of a unit
  of Behavior or Action within the Lifeline. The duration of an ExecutionSpecification
  is represented by two OccurrenceSpecifications, the start OccurrenceSpecification
  and the finish OccurrenceSpecification."
  ((|finish| :range |OccurrenceSpecification| :multiplicity (1 1) :soft-opposite (|OccurrenceSpecification| |executionSpecification|)
    :documentation
     "References the OccurrenceSpecification that designates the finish of the
      Action or Behavior.")
   (|start| :range |OccurrenceSpecification| :multiplicity (1 1) :soft-opposite (|OccurrenceSpecification| |executionSpecification|)
    :documentation
     "References the OccurrenceSpecification that designates the start of the
      Action or Behavior")))


(def-mm-constraint "same_lifeline" |ExecutionSpecification| 
   "The startEvent and the finishEvent must be on the same Lifeline."
   :operation-body
   "start.covered = finish.covered")

;;; =========================================================
;;; ====================== ExpansionNode
;;; =========================================================
(def-mm-class |ExpansionNode| :UML25 (|ObjectNode|)
 "An expansion node is an object node used to indicate a flow across the
  boundary of an expansion region. A flow into a region contains a collection
  that is broken into its individual elements inside the region, which is
  executed once per element. A flow out of a region combines individual elements
  into a collection for use outside the region."
  ((|regionAsInput| :range |ExpansionRegion| :multiplicity (0 1)
    :opposite (|ExpansionRegion| |inputElement|)
    :documentation
     "The expansion region for which the node is an input.")
   (|regionAsOutput| :range |ExpansionRegion| :multiplicity (0 1)
    :opposite (|ExpansionRegion| |outputElement|)
    :documentation
     "The expansion region for which the node is an output.")))


(def-mm-constraint "region_as_input_or_output" |ExpansionNode| 
   "One of regionAsInput or regionAsOutput must be non-empty, but not both."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ExpansionRegion
;;; =========================================================
(def-mm-class |ExpansionRegion| :UML25 (|StructuredActivityNode|)
 "An expansion region is a structured activity region that executes multiple
  times corresponding to elements of an input collection."
  ((|inputElement| :range |ExpansionNode| :multiplicity (1 -1)
    :opposite (|ExpansionNode| |regionAsInput|)
    :documentation
     "An object node that holds a separate element of the input collection during
      each of the multiple executions of the region.")
   (|mode| :range |ExpansionKind| :multiplicity (1 1) :default :iterative
    :documentation
     "The way in which the executions interact: parallel: all interactions are
      independent iterative: the interactions occur in order of the elements
      stream: a stream of values flows into a single execution")
   (|outputElement| :range |ExpansionNode| :multiplicity (0 -1)
    :opposite (|ExpansionNode| |regionAsOutput|)
    :documentation
     "An object node that accepts a separate element of the output collection
      during each of the multiple executions of the region. The values are formed
      into a collection that is available when the execution of the region is
      complete.")))


(def-mm-constraint "expansion_nodes" |ExpansionRegion| 
   "An ExpansionRegion must have one or more argument ExpansionNodes and zero
    or more result ExpansionNodes."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Expression
;;; =========================================================
(def-mm-class |Expression| :UML25 (|ValueSpecification|)
 "An expression represents a node in an expression tree, which may be non-terminal
  or terminal. It defines a symbol, and has a possibly empty sequence of
  operands which are value specifications. An expression is a structured
  tree of symbols that denotes a (possibly empty) set of values when evaluated
  in a context."
  ((|operand| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |expression|)
    :documentation
     "Specifies a sequence of operands.")
   (|symbol| :range |String| :multiplicity (0 1)
    :documentation
     "The symbol associated with the node in the expression tree.")))


;;; =========================================================
;;; ====================== Extend
;;; =========================================================
(def-mm-class |Extend| :UML25 (|NamedElement| |DirectedRelationship|)
 "A relationship from an extending UseCase to an extended UseCase that specifies
  how and when the behavior defined in the extending UseCase can be inserted
  into the behavior defined in the extended UseCase."
  ((|condition| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Constraint| |extend|)
    :documentation
     "References the condition that must hold when the first ExtensionPoint is
      reached for the extension to take place. If no constraint is associated
      with the Extend relationship, the extension is unconditional.")
   (|extendedCase| :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|UseCase| |extend|)
    :documentation
     "The UseCase that is being extended.")
   (|extension| :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|NamedElement| |namespace|))
    :opposite (|UseCase| |extend|)
    :documentation
     "The UseCase that represents the extension and owns the Extend relationship.")
   (|extensionLocation| :range |ExtensionPoint| :multiplicity (1 -1) :is-ordered-p T :soft-opposite (|ExtensionPoint| |extension|)
    :documentation
     "An ordered list of ExtensionPoints belonging to the extended UseCase, specifying
      where the respective behavioral fragments of the extending UseCase are
      to be inserted. The first fragment in the extending UseCase is associated
      with the first extension point in the list, the second fragment with the
      second point, and so on. Note that, in most practical cases, the extending
      UseCase has just a single behavior fragment, so that the list of ExtensionPoints
      is trivial.")))


(def-mm-constraint "extension_points" |Extend| 
   "The ExtensionPoints referenced by the Extend relationship must belong to
    the UseCase that is being extended."
   :operation-body
   "extensionLocation->forAll (xp | extendedCase.extensionPoint->includes(xp))")

;;; =========================================================
;;; ====================== Extension
;;; =========================================================
(def-mm-class |Extension| :UML25 (|Association|)
 "An extension is used to indicate that the properties of a metaclass are
  extended through a stereotype, and gives the ability to flexibly add (and
  later remove) stereotypes to classes."
  ((|isRequired| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "Indicates whether an instance of the extending stereotype must be created
      when an instance of the extended class is created. The attribute value
      is derived from the value of the lower property of the ExtensionEnd referenced
      by Extension::ownedEnd; a lower value of 1 means that isRequired is true,
      but otherwise it is false. Since the default value of ExtensionEnd::lower
      is 0, the default value of isRequired is false.")
   (|metaclass| :range |Class| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :opposite (|Class| |extension|)
    :documentation
     "References the Class that is extended through an Extension. The property
      is derived from the type of the memberEnd that is not the ownedEnd.")
   (|ownedEnd| :range |ExtensionEnd| :multiplicity (1 1) :is-composite-p T :soft-opposite (|ExtensionEnd| |extension|)
    :documentation
     "References the end of the extension that is typed by a Stereotype." :redefined-property (|Association| |ownedEnd|))))


(def-mm-constraint "is_binary" |Extension| 
   "An Extension is binary, i.e., it has only two memberEnds."
   :operation-body
   "memberEnd->size() = 2")

(def-mm-constraint "non_owned_end" |Extension| 
   "The non-owned end of an Extension is typed by a Class."
   :operation-body
   "metaclassEnd()->notEmpty() and metaclassEnd().type.oclIsKindOf(Class)")

(def-mm-operation "isRequired.1" |Extension| 
   "The query isRequired() is true if the owned end has a multiplicity with
    the lower bound of 1."
   :operation-body
   "ownedEnd.lowerBound() = 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "metaclass.1" |Extension| 
   "The query metaclass() returns the metaclass that is being extended (as
    opposed to the extending stereotype)."
   :operation-body
   "metaclassEnd().type.oclAsType(Class)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Class|
                        :parameter-return-p T))
)

(def-mm-operation "metaclassEnd" |Extension| 
   "The query metaclassEnd() returns the Property that is typed by a metaclass
    (as opposed to a stereotype)."
   :operation-body
   "memberEnd->reject(p | ownedEnd->includes(p.oclAsType(ExtensionEnd)))->any(true)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ExtensionEnd
;;; =========================================================
(def-mm-class |ExtensionEnd| :UML25 (|Property|)
 "An extension end is used to tie an extension to a stereotype when extending
  a metaclass. The default multiplicity of an extension end is 0..1."
  ((|lower| :range |Integer| :multiplicity (0 1) :is-derived-p T :default 0
    :documentation
     "This redefinition changes the default multiplicity of association ends,
      since model elements are usually extended by 0 or 1 instance of the extension
      stereotype." :redefined-property (|MultiplicityElement| |lower|))
   (|type| :range |Stereotype| :multiplicity (1 1) :soft-opposite (|Stereotype| |extensionEnd|)
    :documentation
     "References the type of the ExtensionEnd. Note that this association restricts
      the possible types of an ExtensionEnd to only be Stereotypes." :redefined-property (|TypedElement| |type|))))


(def-mm-constraint "aggregation" |ExtensionEnd| 
   "The aggregation of an ExtensionEnd is composite."
   :operation-body
   "self.aggregation = AggregationKind::composite")

(def-mm-constraint "multiplicity" |ExtensionEnd| 
   "The multiplicity of ExtensionEnd is 0..1 or 1."
   :operation-body
   "(lowerBound() = 0 or lowerBound() = 1) and upperBound() = 1")

(def-mm-operation "lowerBound" |ExtensionEnd| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    Integer. This is a redefinition of the default lower bound, which normally,
    for MultiplicityElements, evaluates to 1 if empty."
   :operation-body
   "if lowerValue=null then 0 else lowerValue.integerValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ExtensionPoint
;;; =========================================================
(def-mm-class |ExtensionPoint| :UML25 (|RedefinableElement|)
 "An ExtensionPoint identifies a point in the behavior of a UseCase where
  that behavior can be extended by the behavior of some other (extending)
  UseCase, as specified by an Extend relationship."
  ((|useCase| :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|UseCase| |extensionPoint|)
    :documentation
     "The UseCase that owns this ExtensionPoint.")))


(def-mm-constraint "must_have_name" |ExtensionPoint| 
   "An ExtensionPoint must have a name."
   :operation-body
   "name->notEmpty ()")

;;; =========================================================
;;; ====================== Feature
;;; =========================================================
(def-mm-class |Feature| :UML25 (|RedefinableElement|)
 "A Feature declares a behavioral or structural characteristic of Classifiers."
  ((|featuringClassifier| :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Classifier| |feature|)
    :documentation
     "The Classifiers that have this Feature as a feature.")
   (|isStatic| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether this Feature characterizes individual instances classified
      by the Classifier (false) or the Classifier itself (true).")))


;;; =========================================================
;;; ====================== FinalNode
;;; =========================================================
(def-mm-class |FinalNode| :UML25 (|ControlNode|)
 "A final node is an abstract control node at which a flow in an activity
  stops."
  ())


(def-mm-constraint "no_outgoing_edges" |FinalNode| 
   "A final node has no outgoing edges."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== FinalState
;;; =========================================================
(def-mm-class |FinalState| :UML25 (|State|)
 "A special kind of State, which, when entered, signifies that the enclosing
  Region has completed. If the enclosing Region is directly contained in
  a StateMachine and all other Regions in that StateMachine also are completed,
  then it means that the entire StateMachine behavior is completed."
  ())


(def-mm-constraint "cannot_reference_submachine" |FinalState| 
   "A final state cannot reference a submachine."
   :operation-body
   "submachine->isEmpty()")

(def-mm-constraint "no_entry_behavior" |FinalState| 
   "A final state has no entry behavior."
   :operation-body
   "entry->isEmpty()")

(def-mm-constraint "no_exit_behavior" |FinalState| 
   "A final state has no exit behavior."
   :operation-body
   "exit->isEmpty()")

(def-mm-constraint "no_outgoing_transitions" |FinalState| 
   "A final state cannot have any outgoing transitions."
   :operation-body
   "outgoing->size() = 0")

(def-mm-constraint "no_regions" |FinalState| 
   "A final state cannot have regions."
   :operation-body
   "region->size() = 0")

(def-mm-constraint "no_state_behavior" |FinalState| 
   "A final state has no state (doActivity) behavior."
   :operation-body
   "doActivity->isEmpty()")

;;; =========================================================
;;; ====================== FlowFinalNode
;;; =========================================================
(def-mm-class |FlowFinalNode| :UML25 (|FinalNode|)
 "A flow final node is a final node that terminates a flow."
  ())


;;; =========================================================
;;; ====================== ForkNode
;;; =========================================================
(def-mm-class |ForkNode| :UML25 (|ControlNode|)
 "A fork node is a control node that splits a flow into multiple concurrent
  flows."
  ())


(def-mm-constraint "edges" |ForkNode| 
   "The edges coming into and out of a fork node must be either all object
    flows or all control flows."
   :operation-body
   "true")

(def-mm-constraint "one_incoming_edge" |ForkNode| 
   "A fork node has one incoming edge."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== FunctionBehavior
;;; =========================================================
(def-mm-class |FunctionBehavior| :UML25 (|OpaqueBehavior|)
 "A function behavior is an opaque behavior that does not access or modify
  any objects or other external data."
  ())


(def-mm-constraint "one_output_parameter" |FunctionBehavior| 
   "A function behavior has at least one output parameter."
   :operation-body
   "self.ownedParameter->   select(p | p.direction = ParameterDirectionKind::out or p.direction= ParameterDirectionKind::inout or p.direction= ParameterDirectionKind::return)->size() >= 1")

(def-mm-constraint "types_of_parameters" |FunctionBehavior| 
   "The types of parameters are all data types, which may not nest anything
    but other datatypes."
   :operation-body
   "ownedParameter->forAll(p | p.type <> null and   p.type.oclIsTypeOf(DataType) and hasAllDataTypeAttributes(p.type.oclAsType(DataType)))")

(def-mm-operation "hasAllDataTypeAttributes" |FunctionBehavior| 
   ""
   :operation-body
   "d.ownedAttribute->forAll(a |     a.type.oclIsKindOf(DataType) and       hasAllDataTypeAttributes(a.type.oclAsType(DataType)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\d :parameter-type '|DataType|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== Gate
;;; =========================================================
(def-mm-class |Gate| :UML25 (|MessageEnd|)
 "A Gate is a MessageEnd which serves as a connection point for relating
  a Message which has a MessageEnd (sendEvent / receiveEvent) outside an
  InteractionFragment with another Message which has a MessageEnd (receiveEvent
  / sendEvent)  inside that InteractionFragment."
  ())


(def-mm-constraint "actual_gate_matched" |Gate| 
   "If this Gate is an actualGate it must have exactly one matching formalGate
    within the referred Interaction"
   :operation-body
   "interactionUse->notEmpty() implies interactionUse.refersTo.formalGate->select(matches(self))->size()=1  ")

(def-mm-constraint "inside_cf_matched" |Gate| 
   "If this Gate is inside a CombinedFragment, it must have exactly one matching
    Gate which is outside of that CombinedFragment."
   :operation-body
   "isInsideCF() implies combinedFragment.cfragmentGate->select(isOutsideCF() and matches(self))->size()=1    ")

(def-mm-constraint "outside_cf_matched" |Gate| 
   "If this Gate is outside an 'alt' CombinedFragment,  for every InteractionOperator
    inside that CombinedFragment there must be exactly one matching Gate inside
    the CombindedFragment with its opposing end enclosed by that InteractionOperator.
    If this Gate is outside CombinedFragment with operator other than 'alt',
      there must be exactly one matching Gate inside that CombindedFragment."
   :operation-body
   "isOutsideCF() implies  if self.combinedFragment.interactionOperator->asOrderedSet()->first() = InteractionOperatorKind::alt  then self.combinedFragment.operand->forAll(op : InteractionOperand |  self.combinedFragment.cfragmentGate->select(isInsideCF() and   oppositeEnd().enclosingFragment()->includes(self.combinedFragment) and matches(self))->size()=1)  else  self.combinedFragment.cfragmentGate->select(isInsideCF() and matches(self))->size()=1  endif                ")

(def-mm-operation "getName" |Gate| 
   "This query returns the name of the gate, either the explicit name (.name)
    or the constructed name ('out_' or 'in_' concatenated in front of .message.name)
    if the explicit name is not present."
   :operation-body
   "if name->notEmpty() then name->asOrderedSet()->first() else  if isActual() or isOutsideCF()    then if isSend()      then 'out_'.concat(self.message.name->asOrderedSet()->first())     else 'in_'.concat(self.message.name->asOrderedSet()->first())     endif   else if isSend()     then 'in_'.concat(self.message.name->asOrderedSet()->first())     else 'out_'.concat(self.message.name->asOrderedSet()->first())     endif   endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-mm-operation "isActual" |Gate| 
   "This query returns true value if this Gate is an actualGate of an InteractionUse"
   :operation-body
   "interactionUse->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isFormal" |Gate| 
   "This query returns true if this Gate is a formalGat of an Interaction."
   :operation-body
   "interaction->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isInsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present) is inside of an InteractionOperator of the
    same CombindedFragment."
   :operation-body
   "self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)  then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification)  in combinedFragment = oppMOS.enclosingOperand.combinedFragment else let oppGate : Gate = oppEnd.oclAsType(Gate)  in combinedFragment = oppGate.combinedFragment endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isOutsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present)  is outside of the same CombindedFragment."
   :operation-body
   "self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)  then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification) in  self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =      oppMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(oppMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet()) else let oppGate : Gate = oppEnd.oclAsType(Gate)  in self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =      oppGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(oppGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "matches" |Gate| 
   "This query returns true if the name of this Gate matches the name of the
    in parameter Gate, and the messages for the two Gates correspond. The Message
    for one Gate (say A) corresponds to the Message for another Gate (say B)
    if (A and B have the same name value) and (if A is a sendEvent then B is
    a receiveEvent) and (if A is a receiveEvent then B is a sendEvent) and
    (A and B have the same messageSort value) and (A and B have the same signature
    value)"
   :operation-body
   "self.getName() = gateToMatch.getName() and  self.message.messageSort = gateToMatch.message.messageSort and self.message.name = gateToMatch.message.name and self.message.sendEvent->includes(self) implies gateToMatch.message.receiveEvent->includes(gateToMatch)  and self.message.receiveEvent->includes(self) implies gateToMatch.message.sendEvent->includes(gateToMatch) and self.message.signature = gateToMatch.message.signature "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|gateToMatch| :parameter-type '|Gate|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== GeneralOrdering
;;; =========================================================
(def-mm-class |GeneralOrdering| :UML25 (|NamedElement|)
 "A GeneralOrdering represents a binary relation between two OccurrenceSpecifications,
  to describe that one OccurrenceSpecification must occur before the other
  in a valid trace. This mechanism provides the ability to define partial
  orders of OccurrenceSpecifications that may otherwise not have a specified
  order."
  ((|after| :range |OccurrenceSpecification| :multiplicity (1 1)
    :opposite (|OccurrenceSpecification| |toBefore|)
    :documentation
     "The OccurrenceSpecification referenced comes after the OccurrenceSpecification
      referenced by before.")
   (|before| :range |OccurrenceSpecification| :multiplicity (1 1)
    :opposite (|OccurrenceSpecification| |toAfter|)
    :documentation
     "The OccurrenceSpecification referenced comes before the OccurrenceSpecification
      referenced by after.")))


(def-mm-constraint "irreflexive_transitive_closure" |GeneralOrdering| 
   "An occurrence specification must not be ordered relative to itself through
    a series of general orderings. (In other words, the transitive closure
    of the general orderings is irreflexive.)"
   :operation-body
   "after->closure(toAfter.after)->excludes(before) ")

;;; =========================================================
;;; ====================== Generalization
;;; =========================================================
(def-mm-class |Generalization| :UML25 (|DirectedRelationship|)
 "A Generalization is a taxonomic relationship between a more general Classifier
  and a more specific Classifier. Each instance of the specific Classifier
  is also an instance of the general Classifier. The specific Classifier
  inherits the features of the more general Classifier. A Generalization
  is owned by the specific Classifier."
  ((|general| :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|Classifier| |generalization|)
    :documentation
     "The general classifier in the Generalization relationship.")
   (|generalizationSet| :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |generalization|)
    :documentation
     "Represents a set of instances of Generalization.  A Generalization may
      appear in many GeneralizationSets.")
   (|isSubstitutable| :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "Indicates whether the specific Classifier can be used wherever the general
      Classifier can be used. If true, the execution traces of the specific Classifier
      shall be a superset of the execution traces of the general Classifier.
      If false, there is no such constraint on execution traces. If unset, the
      modeler has not stated whether there is such a constraint or not.")
   (|specific| :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Classifier| |generalization|)
    :documentation
     "The specializing Classifier in the Generalization relationship.")))


;;; =========================================================
;;; ====================== GeneralizationSet
;;; =========================================================
(def-mm-class |GeneralizationSet| :UML25 (|PackageableElement|)
 "A GeneralizationSet is a PackageableEelement whose instances represent
  sets of Generalization relationships."
  ((|generalization| :range |Generalization| :multiplicity (0 -1)
    :opposite (|Generalization| |generalizationSet|)
    :documentation
     "Designates the instances of Generalization which are members of this GeneralizationSet.")
   (|isCovering| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates (via the associated Generalizations) whether or not the set of
      specific Classifiers are covering for a particular general classifier.
      When isCovering is true, every instance of a particular general Classifier
      is also an instance of at least one of its specific Classifiers for the
      GeneralizationSet. When isCovering is false, there are one or more instances
      of the particular general Classifier that are not instances of at least
      one of its specific Classifiers defined for the GeneralizationSet.")
   (|isDisjoint| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether or not the set of specific Classifiers in a Generalization
      relationship have instance in common. If isDisjoint is true, the specific
      Classifiers for a particular GeneralizationSet have no members in common;
      that is, their intersection is empty. If isDisjoint is false, the specific
      Classifiers in a particular GeneralizationSet have one or more members
      in common; that is, their intersection is not empty.")
   (|powertype| :range |Classifier| :multiplicity (0 1)
    :opposite (|Classifier| |powertypeExtent|)
    :documentation
     "Designates the Classifier that is defined as the power type for the associated
      GeneralizationSet, if there is one.")))


(def-mm-constraint "complete_and_disjoint" |GeneralizationSet| 
   "A complete and disjoint GeneralizationSet implies that the common general
    Classifier is abstract"
   :operation-body
   "isDisjoint and isCovering implies generalization->forAll(general.isAbstract)")

(def-mm-constraint "generalization_same_classifier" |GeneralizationSet| 
   "Every Generalization associated with a particular GeneralizationSet must
    have the same general Classifier."
   :operation-body
   "generalization->collect(general)->asSet()->size() <= 1")

(def-mm-constraint "maps_to_generalization_set" |GeneralizationSet| 
   "The Classifier that maps to a GeneralizationSet may neither be a specific
    nor a general Classifier in any of the Generalization relationships defined
    for that GeneralizationSet. In other words, a power type may not be an
    instance of itself nor may its instances be its subclasses."
   :operation-body
   "powertype <> null implies generalization->forAll( gen |      not (gen.general = powertype) and not gen.general.allParents()->includes(powertype) and not (gen.specific = powertype) and not powertype.allParents()->includes(gen.specific)   )")

;;; =========================================================
;;; ====================== Image
;;; =========================================================
(def-mm-class |Image| :UML25 (|Element|)
 "Physical definition of a graphical image."
  ((|content| :range |String| :multiplicity (0 1)
    :documentation
     "This contains the serialization of the image according to the format. The
      value could represent a bitmap, image such as a GIF file, or drawing 'instructions'
      using a standard such as Scalable Vector Graphic (SVG) (which is XML based).")
   (|format| :range |String| :multiplicity (0 1)
    :documentation
     "This indicates the format of the content - which is how the string content
      should be interpreted. The following values are reserved: SVG, GIF, PNG,
      JPG, WMF, EMF, BMP. In addition the prefix 'MIME: ' is also reserved. This
      option can be used as an alternative to express the reserved values above,
      for example \"SVG\" could instead be expressed as \"MIME: image/svg+xml\".")
   (|location| :range |String| :multiplicity (0 1)
    :documentation
     "This contains a location that can be used by a tool to locate the image
      as an alternative to embedding it in the stereotype.")))


;;; =========================================================
;;; ====================== Include
;;; =========================================================
(def-mm-class |Include| :UML25 (|DirectedRelationship| |NamedElement|)
 "An Include relationship specifies that a UseCase contains the behavior
  defined in another UseCase."
  ((|addition| :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|UseCase| |include|)
    :documentation
     "The UseCase that is to be included.")
   (|includingCase| :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|NamedElement| |namespace|))
    :opposite (|UseCase| |include|)
    :documentation
     "The UseCase which includes the addition and owns the Include relationship.")))


;;; =========================================================
;;; ====================== InformationFlow
;;; =========================================================
(def-mm-class |InformationFlow| :UML25 (|DirectedRelationship| |PackageableElement|)
 "InformationFlows describe circulation of information through a system in
  a general manner. They do not specify the nature of the information, mechanisms
  by which it is conveyed, sequences of exchange or any control conditions.
  During more detailed modeling, representation and realization links may
  be added to specify which model elements implement an InformationFlow and
  to show how information is conveyed.  InformationFlows require some kind
  of  information channel  for unidirectional transmission of information
  items from sources to targets.  They specify the information channel s
  realizations, if any, and identify the information that flows along them.
   Information moving along the information channel may be represented by
  abstract InformationItems and by concrete Classifiers."
  ((|conveyed| :range |Classifier| :multiplicity (1 -1) :soft-opposite (|Classifier| |conveyingFlow|)
    :documentation
     "Specifies the information items that may circulate on this information
      flow.")
   (|informationSource| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|)) :soft-opposite (|NamedElement| |informationFlow|)
    :documentation
     "Defines from which source the conveyed InformationItems are initiated.")
   (|informationTarget| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|NamedElement| |informationFlow|)
    :documentation
     "Defines to which target the conveyed InformationItems are directed.")
   (|realization| :range |Relationship| :multiplicity (0 -1) :soft-opposite (|Relationship| |abstraction|)
    :documentation
     "Determines which Relationship will realize the specified flow")
   (|realizingActivityEdge| :range |ActivityEdge| :multiplicity (0 -1) :soft-opposite (|ActivityEdge| |informationFlow|)
    :documentation
     "Determines which ActivityEdges will realize the specified flow.")
   (|realizingConnector| :range |Connector| :multiplicity (0 -1) :soft-opposite (|Connector| |informationFlow|)
    :documentation
     "Determines which Connectors will realize the specified flow.")
   (|realizingMessage| :range |Message| :multiplicity (0 -1) :soft-opposite (|Message| |informationFlow|)
    :documentation
     "Determines which Messages will realize the specified flow.")))


(def-mm-constraint "convey_classifiers" |InformationFlow| 
   "An information flow can only convey classifiers that are allowed to represent
    an information item."
   :operation-body
   "self.conveyed->forAll(oclIsKindOf(Class) or oclIsKindOf(Interface)   or oclIsKindOf(InformationItem) or oclIsKindOf(Signal) or oclIsKindOf(Component))")

(def-mm-constraint "must_conform" |InformationFlow| 
   "The sources and targets of the information flow must conform with the sources
    and targets or conversely the targets and sources of the realization relationships."
   :editor-note "See original body..."
   :original-body
   "Not implemented in OCL"
   :operation-body "true"
   :operation-status :ignored)

(def-mm-constraint "sources_and_targets_kind" |InformationFlow| 
   "The sources and targets of the information flow can only be one of the
    following kind: Actor, Node, UseCase, Artifact, Class, Component, Port,
    Property, Interface, Package, ActivityNode, ActivityPartition and InstanceSpecification
    except when its classifier is a relationship (i.e. it represents a link)."
   :operation-body
   "(self.informationSource->forAll(oclIsKindOf(Actor) or oclIsKindOf(Node) or   oclIsKindOf(UseCase) or oclIsKindOf(Artifact) or oclIsKindOf(Class) or   oclIsKindOf(Component) or oclIsKindOf(Port) or oclIsKindOf(Property) or   oclIsKindOf(Interface) or oclIsKindOf(Package) or oclIsKindOf(ActivityNode) or   oclIsKindOf(ActivityPartition) or oclIsKindOf(InstanceSpecification))) and     (self.informationTarget->forAll(oclIsKindOf(Actor) or oclIsKindOf(Node) or       oclIsKindOf(UseCase) or oclIsKindOf(Artifact) or oclIsKindOf(Class) or       oclIsKindOf(Component) or oclIsKindOf(Port) or oclIsKindOf(Property) or       oclIsKindOf(Interface) or oclIsKindOf(Package) or oclIsKindOf(ActivityNode) or       oclIsKindOf(ActivityPartition) or oclIsKindOf(InstanceSpecification)))")

;;; =========================================================
;;; ====================== InformationItem
;;; =========================================================
(def-mm-class |InformationItem| :UML25 (|Classifier|)
 "InformationItems represent many kinds of information that can flow from
  sources to targets in very abstract ways.  They represent the kinds of
  information that may move within a system, but do not elaborate details
  of the transferred information.  Details of transferred information are
  the province of other Classifiers that may ultimately define InformationItems.
   Consequently, InformationItems cannot be instantiated and do not themselves
  have features, generalizations, or associations. An important use of InformationItems
  is to represent information during early design stages, possibly before
  the detailed modeling decisions that will ultimately define them have been
  made. Another purpose of InformationItems is to abstract portions of complex
  models in less precise, but perhaps more general and communicable, ways."
  ((|represented| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |representation|)
    :documentation
     "Determines the classifiers that will specify the structure and nature of
      the information. An information item represents all its represented classifiers.")))


(def-mm-constraint "has_no" |InformationItem| 
   "An informationItem has no feature, no generalization, and no associations."
   :operation-body
   "self.generalization->isEmpty() and self.feature->isEmpty()")

(def-mm-constraint "not_instantiable" |InformationItem| 
   "It is not instantiable."
   :operation-body
   "isAbstract")

(def-mm-constraint "sources_and_targets" |InformationItem| 
   "The sources and targets of an information item (its related information
    flows) must designate subsets of the sources and targets of the representation
    information item, if any.The Classifiers that can realize an information
    item can only be of the following kind: Class, Interface, InformationItem,
    Signal, Component."
   :operation-body
   "(self.represented->select(oclIsKindOf(InformationItem))->forAll(p |   p.conveyingFlow.source->forAll(q | self.conveyingFlow.source->includes(q)) and     p.conveyingFlow.target->forAll(q | self.conveyingFlow.target->includes(q)))) and       (self.represented->forAll(oclIsKindOf(Class) or oclIsKindOf(Interface) or         oclIsKindOf(InformationItem) or oclIsKindOf(Signal) or oclIsKindOf(Component)))")

;;; =========================================================
;;; ====================== InitialNode
;;; =========================================================
(def-mm-class |InitialNode| :UML25 (|ControlNode|)
 "An initial node is a control node at which flow starts when the activity
  is invoked."
  ())


(def-mm-constraint "control_edges" |InitialNode| 
   "Only control edges can have initial nodes as source."
   :operation-body
   "true")

(def-mm-constraint "no_incoming_edges" |InitialNode| 
   "An initial node has no incoming edges."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== InputPin
;;; =========================================================
(def-mm-class |InputPin| :UML25 (|Pin|)
 "An input pin is a pin that holds input values to be consumed by an action."
  ())


(def-mm-constraint "outgoing_edges_structured_only" |InputPin| 
   "Input pins may have outgoing edges only when they are on actions that are
    structured nodes, and these edges must target a node contained by the structured
    node."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== InstanceSpecification
;;; =========================================================
(def-mm-class |InstanceSpecification| :UML25 (|DeploymentTarget| |PackageableElement| |DeployedArtifact|)
 "An InstanceSpecification is a model element that represents an instance
  in a modeled system. An InstanceSpecification can act as a DeploymentTarget
  in a Deployment relationship, in the case that it represents an instance
  of a Node. It can also act as a DeployedArtifact, if it represents an instance
  of an Artifact."
  ((|classifier| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |instanceSpecification|)
    :documentation
     "The Classifier or Classifiers of the represented instance. If multiple
      Classifiers are specified, the instance is classified by all of them.")
   (|slot| :range |Slot| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Slot| |owningInstance|)
    :documentation
     "A Slot giving the value or values of a StructuralFeature of the instance.
      An InstanceSpecification can have one Slot per StructuralFeature of its
      Classifiers, including inherited features. It is not necessary to model
      a Slot for every StructuralFeature, in which case the InstanceSpecification
      is a partial description.")
   (|specification| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningInstanceSpec|)
    :documentation
     "A specification of how to compute, derive, or construct the instance.")))


(def-mm-constraint "defining_feature" |InstanceSpecification| 
   "The defining feature of each slot is a StructuralFeature (directly or inherited)
    of a classifier of the InstanceSpecification."
   :operation-body
   "slot->forAll(s | classifier->exists (c | c.allFeatures()->includes (s.definingFeature)))")

(def-mm-constraint "deployment_artifact" |InstanceSpecification| 
   "An InstanceSpecification can act as a DeployedArtifact if it represents
    an instance of an Artifact."
   :operation-body
   "deploymentForArtifact->notEmpty() implies classifier->exists(oclIsKindOf(Artifact))")

(def-mm-constraint "deployment_target" |InstanceSpecification| 
   "An InstanceSpecification can act as a DeploymentTarget if it represents
    an instance of a Node and functions as a part in the internal structure
    of an encompassing Node."
   :operation-body
   "deployment->notEmpty() implies classifier->exists(node | node.oclIsKindOf(Node) and Node.allInstances()->exists(n | n.part->exists(p | p.type = node)))")

(def-mm-constraint "structural_feature" |InstanceSpecification| 
   "One StructuralFeature (including the same feature inherited from multiple
    classifiers) is the defining feature of at most one slot in an InstanceSpecification."
   :operation-body
   "classifier->forAll(c | (c.allFeatures()->forAll(f | slot->select(s | s.definingFeature = f)->size() <= 1)))")

;;; =========================================================
;;; ====================== InstanceValue
;;; =========================================================
(def-mm-class |InstanceValue| :UML25 (|ValueSpecification|)
 "An InstanceValue is a ValueSpecification that identifies an instance."
  ((|instance| :range |InstanceSpecification| :multiplicity (1 1) :soft-opposite (|InstanceSpecification| |instanceValue|)
    :documentation
     "The InstanceSpecification that represents the specified value.")))


;;; =========================================================
;;; ====================== Interaction
;;; =========================================================
(def-mm-class |Interaction| :UML25 (|InteractionFragment| |Behavior|)
 "An Interaction is a unit of Behavior that focuses on the observable exchange
  of information between connectable elements."
  ((|action| :range |Action| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Action| |interaction|)
    :documentation
     "Actions owned by the Interaction.")
   (|formalGate| :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Gate| |interaction|)
    :documentation
     "Specifies the gates that form the message interface between this Interaction
      and any InteractionUses which reference it.")
   (|fragment| :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingInteraction|)
    :documentation
     "The ordered set of fragments in the Interaction.")
   (|lifeline| :range |Lifeline| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Lifeline| |interaction|)
    :documentation
     "Specifies the participants in this Interaction.")
   (|message| :range |Message| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Message| |interaction|)
    :documentation
     "The Messages contained in this Interaction.")))


(def-mm-constraint "not_contained" |Interaction| 
   "An Interaction instance must not be contained within another Interaction
    instance"
   :operation-body
   "enclosingInteraction->isEmpty()")

;;; =========================================================
;;; ====================== InteractionConstraint
;;; =========================================================
(def-mm-class |InteractionConstraint| :UML25 (|Constraint|)
 "An InteractionConstraint is a Boolean expression that guards an operand
  in a CombinedFragment."
  ((|maxint| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |interactionConstraint|)
    :documentation
     "The maximum number of iterations of a loop")
   (|minint| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |interactionConstraint|)
    :documentation
     "The minimum number of iterations of a loop")))


(def-mm-constraint "dynamic_variables" |InteractionConstraint| 
   "The dynamic variables that take part in the constraint must be owned by
    the ConnectableElement corresponding to the covered Lifeline."
   :operation-body
   "true")

(def-mm-constraint "global_data" |InteractionConstraint| 
   "The constraint may contain references to global data or write-once data."
   :operation-body
   "true")

(def-mm-constraint "maxint_greater_equal_minint" |InteractionConstraint| 
   "If maxint is specified, then minint must be specified and the evaluation
    of maxint must be >= the evaluation of minint"
   :operation-body
   "true")

(def-mm-constraint "maxint_positive" |InteractionConstraint| 
   "If maxint is specified, then the expression must evaluate to a positive
    integer."
   :operation-body
   "true")

(def-mm-constraint "minint_maxint" |InteractionConstraint| 
   "Minint/maxint can only be present if the InteractionConstraint is associated
    with the operand of a loop CombinedFragment."
   :operation-body
   "true")

(def-mm-constraint "minint_non_negative" |InteractionConstraint| 
   "If minint is specified, then the expression must evaluate to a non-negative
    integer."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== InteractionFragment
;;; =========================================================
(def-mm-class |InteractionFragment| :UML25 (|NamedElement|)
 "InteractionFragment is an abstract notion of the most general interaction
  unit. An InteractionFragment is a piece of an Interaction. Each InteractionFragment
  is conceptually like an Interaction by itself."
  ((|covered| :range |Lifeline| :multiplicity (0 -1)
    :opposite (|Lifeline| |coveredBy|)
    :documentation
     "References the Lifelines that the InteractionFragment involves.")
   (|enclosingInteraction| :range |Interaction| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |fragment|)
    :documentation
     "The Interaction enclosing this InteractionFragment.")
   (|enclosingOperand| :range |InteractionOperand| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|InteractionOperand| |fragment|)
    :documentation
     "The operand enclosing this InteractionFragment (they may nest recursively)")
   (|generalOrdering| :range |GeneralOrdering| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|GeneralOrdering| |interactionFragment|)
    :documentation
     "The general ordering relationships contained in this fragment.")))


;;; =========================================================
;;; ====================== InteractionOperand
;;; =========================================================
(def-mm-class |InteractionOperand| :UML25 (|InteractionFragment| |Namespace|)
 "An InteractionOperand is contained in a CombinedFragment. An InteractionOperand
  represents one operand of the expression given by the enclosing CombinedFragment."
  ((|fragment| :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingOperand|)
    :documentation
     "The fragments of the operand.")
   (|guard| :range |InteractionConstraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|InteractionConstraint| |interactionOperand|)
    :documentation
     "Constraint of the operand.")))


(def-mm-constraint "guard_contain_references" |InteractionOperand| 
   "The guard must contain only references to values local to the Lifeline
    on which it resides, or values global to the whole Interaction."
   :operation-body
   "true")

(def-mm-constraint "guard_directly_prior" |InteractionOperand| 
   "The guard must be placed directly prior to (above) the OccurrenceSpecification
    that will become the first OccurrenceSpecification within this InteractionOperand."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== InteractionUse
;;; =========================================================
(def-mm-class |InteractionUse| :UML25 (|InteractionFragment|)
 "An InteractionUse refers to an Interaction. The InteractionUse is a shorthand
  for copying the contents of the referenced Interaction where the InteractionUse
  is. To be accurate the copying must take into account substituting parameters
  with arguments and connect the formal Gates with the actual ones."
  ((|actualGate| :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Gate| |interactionUse|)
    :documentation
     "The actual gates of the InteractionUse")
   (|argument| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |interactionUse|)
    :documentation
     "The actual arguments of the Interaction")
   (|refersTo| :range |Interaction| :multiplicity (1 1) :soft-opposite (|Interaction| |interactionUse|)
    :documentation
     "Refers to the Interaction that defines its meaning")
   (|returnValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |interactionUse|)
    :documentation
     "The value of the executed Interaction.")
   (|returnValueRecipient| :range |Property| :multiplicity (0 1) :soft-opposite (|Property| |interactionUse|)
    :documentation
     "The recipient of the return value.")))


(def-mm-constraint "all_lifelines" |InteractionUse| 
   "The InteractionUse must cover all Lifelines of the enclosing Interaction
    that are common with the lifelines covered by the referred Interaction.
    Lifelines are common if they have the same selector and represents associationEnd
    values."
   :operation-body
   "let parentInteraction : Set(Interaction) = enclosingInteraction->asSet()-> union(enclosingOperand.combinedFragment->closure(enclosingOperand.combinedFragment)-> collect(enclosingInteraction).oclAsType(Interaction)->asSet()) in parentInteraction->size()=1 and let refInteraction : Interaction = refersTo in parentInteraction.covered-> forAll(intLifeline : Lifeline | refInteraction.covered-> forAll( refLifeline : Lifeline | refLifeline.represents = intLifeline.represents and  refLifeline.selector = intLifeline.selector implies self.covered->asSet()->includes(intLifeline)))")

(def-mm-constraint "arguments_are_constants" |InteractionUse| 
   "The arguments must only be constants, parameters of the enclosing Interaction
    or attributes of the classifier owning the enclosing Interaction."
   :operation-body
   "true")

(def-mm-constraint "arguments_correspond_to_parameters" |InteractionUse| 
   "The arguments of the InteractionUse must correspond to parameters of the
    referred Interaction"
   :operation-body
   "true")

(def-mm-constraint "gates_match" |InteractionUse| 
   "Actual Gates of the InteractionUse must match Formal Gates of the referred
    Interaction. Gates match when their names are equal and their messages
    correspond."
   :operation-body
   "actualGate->notEmpty() implies  refersTo.formalGate->forAll( fg : Gate | self.actualGate->select(matches(fg))->size()=1) and self.actualGate->forAll(ag : Gate | refersTo.formalGate->select(matches(ag))->size()=1) ")

(def-mm-constraint "returnValueRecipient_coverage" |InteractionUse| 
   "The returnValueRecipient must be a Property of a ConnectableElement that
    is represented by a Lifeline covered by this InteractionUse."
   :operation-body
   "true")

(def-mm-constraint "returnValue_type_recipient_correspondence" |InteractionUse| 
   "The type of the returnValue must correspond to the type of the returnValueRecipient."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Interface
;;; =========================================================
(def-mm-class |Interface| :UML25 (|Classifier|)
 "Interfaces declare coherent services that are implemented by BehavioredClassifiers
  that implement the Interfaces via InterfaceRealizations."
  ((|nestedClassifier| :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Classifier| |interface|)
    :documentation
     "References all the Classifiers that are defined (nested) within the Interface.")
   (|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |interface|)
    :documentation
     "The attributes (i.e. the Properties) owned by the Interface.")
   (|ownedOperation| :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |interface|)
    :documentation
     "The Operations owned by the Interface.")
   (|ownedReception| :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|)) :soft-opposite (|Reception| |interface|)
    :documentation
     "Receptions that objects providing this Interface are willing to accept.")
   (|protocol| :range |ProtocolStateMachine| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|ProtocolStateMachine| |interface|)
    :documentation
     "References a ProtocolStateMachine specifying the legal sequences of the
      invocation of the BehavioralFeatures described in the Interface.")
   (|redefinedInterface| :range |Interface| :multiplicity (0 -1)
    :subsetted-properties ((|Classifier| |redefinedClassifier|)) :soft-opposite (|Interface| |interface|)
    :documentation
     "References all the Interfaces redefined by this Interface.")))


(def-mm-constraint "visibility" |Interface| 
   "The visibility of all Features owned by an Interface must be public."
   :operation-body
   "feature->forAll(visibility = VisibilityKind::public)")

;;; =========================================================
;;; ====================== InterfaceRealization
;;; =========================================================
(def-mm-class |InterfaceRealization| :UML25 (|Realization|)
 "An InterfaceRealization is a specialized realization relationship between
  a BehavioredClassifier and an Interface. This relationship signifies that
  the realizing BehavioredClassifier conforms to the contract specified by
  the Interface."
  ((|contract| :range |Interface| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|)) :soft-opposite (|Interface| |interfaceRealization|)
    :documentation
     "References the Interface specifying the conformance contract.")
   (|implementingClassifier| :range |BehavioredClassifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|BehavioredClassifier| |interfaceRealization|)
    :documentation
     "References the BehavioredClassifier that owns this InterfaceRealization,
      i.e., the BehavioredClassifier that realizes the Interface to which it
      refers.")))


;;; =========================================================
;;; ====================== InterruptibleActivityRegion
;;; =========================================================
(def-mm-class |InterruptibleActivityRegion| :UML25 (|ActivityGroup|)
 "An interruptible activity region is an activity group that supports termination
  of tokens flowing in the portions of an activity."
  ((|interruptingEdge| :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |interrupts|)
    :documentation
     "The edges leaving the region that will abort other tokens flowing in the
      region.")
   (|node| :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inInterruptibleRegion|)
    :documentation
     "Nodes immediately contained in the group.")))


(def-mm-constraint "interrupting_edges" |InterruptibleActivityRegion| 
   "Interrupting edges of a region must have their source node in the region
    and their target node outside the region in the same activity containing
    the region."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Interval
;;; =========================================================
(def-mm-class |Interval| :UML25 (|ValueSpecification|)
 "An interval defines the range between two value specifications."
  ((|max| :range |ValueSpecification| :multiplicity (1 1) :soft-opposite (|ValueSpecification| |interval|)
    :documentation
     "Refers to the ValueSpecification denoting the maximum value of the range.")
   (|min| :range |ValueSpecification| :multiplicity (1 1) :soft-opposite (|ValueSpecification| |interval|)
    :documentation
     "Refers to the ValueSpecification denoting the minimum value of the range.")))


;;; =========================================================
;;; ====================== IntervalConstraint
;;; =========================================================
(def-mm-class |IntervalConstraint| :UML25 (|Constraint|)
 "An interval constraint is a constraint that refers to an interval."
  ((|specification| :range |Interval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|Interval| |intervalConstraint|)
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied." :redefined-property (|Constraint| |specification|))))


;;; =========================================================
;;; ====================== InvocationAction
;;; =========================================================
(def-mm-class |InvocationAction| :UML25 (|Action|)
 "In addition to targeting an object, invocation actions can also invoke
  behavioral features on ports from where the invocation requests are routed
  onwards on links deriving from attached connectors. Invocation actions
  may also be sent to a target via a given port, either on the sending object
  or on another object. InvocationAction is an abstract class for the various
  actions that invoke behavior."
  ((|argument| :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |invocationAction|)
    :documentation
     "Specification of the ordered set of argument values that appears during
      execution.")
   (|onPort| :range |Port| :multiplicity (0 1) :soft-opposite (|Port| |invocationAction|)
    :documentation
     "A optional port of the receiver object on which the behavioral feature
      is invoked.")))


(def-mm-constraint "on_port_receiver" |InvocationAction| 
   "The onPort must be a port on the receiver object."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== JoinNode
;;; =========================================================
(def-mm-class |JoinNode| :UML25 (|ControlNode|)
 "A join node is a control node that synchronizes multiple flows. Join nodes
  have a Boolean value specification using the names of the incoming edges
  to specify the conditions under which the join will emit a token."
  ((|isCombineDuplicate| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether tokens having objects with the same identity are combined
      into one by the join.")
   (|joinSpec| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |joinNode|)
    :documentation
     "A specification giving the conditions under which the join with emit a
      token. Default is \"and\".")))


(def-mm-constraint "incoming_object_flow" |JoinNode| 
   "If a join node has an incoming object flow, it must have an outgoing object
    flow, otherwise, it must have an outgoing control flow."
   :operation-body
   "incoming->select(oclIsKindOf(ObjectFlow))->notEmpty() implies   outgoing->forAll(oclIsKindOf(ObjectFlow)) and     (incoming->select(oclIsKindOf(ObjectFlow))->isEmpty() implies       outgoing->forAll(oclIsKindOf(ControlFlow)))")

(def-mm-constraint "one_outgoing_edge" |JoinNode| 
   "A join node has one outgoing edge."
   :operation-body
   "outgoing->size() = 1")

;;; =========================================================
;;; ====================== Lifeline
;;; =========================================================
(def-mm-class |Lifeline| :UML25 (|NamedElement|)
 "A Lifeline represents an individual participant in the Interaction. While
  parts and structural features may have multiplicity greater than 1, Lifelines
  represent only one interacting entity."
  ((|coveredBy| :range |InteractionFragment| :multiplicity (0 -1)
    :opposite (|InteractionFragment| |covered|)
    :documentation
     "References the InteractionFragments in which this Lifeline takes part.")
   (|decomposedAs| :range |PartDecomposition| :multiplicity (0 1) :soft-opposite (|PartDecomposition| |lifeline|)
    :documentation
     "References the Interaction that represents the decomposition.")
   (|interaction| :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |lifeline|)
    :documentation
     "References the Interaction enclosing this Lifeline.")
   (|represents| :range |ConnectableElement| :multiplicity (0 1) :soft-opposite (|ConnectableElement| |lifeline|)
    :documentation
     "References the ConnectableElement within the classifier that contains the
      enclosing interaction.")
   (|selector| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |lifeline|)
    :documentation
     "If the referenced ConnectableElement is multivalued, then this specifies
      the specific individual part within that set.")))


(def-mm-constraint "interaction_uses_share_lifeline" |Lifeline| 
   "If two (or more) InteractionUses within one Interaction, refer to Interactions
    with 'common Lifelines,' those Lifelines must also appear in the Interaction
    with the InteractionUses. By common Lifelines we mean Lifelines with the
    same selector and represents associations.  recast as:  If a lifeline in
    an Interaction refered to by an InteractionUse in an enclosing Interaction,
     and that lifeline is common with another lifeline in an Interaction referred
    by by another InteractonUse within that same enclosing Interaction, it
    must be common to a lifeline within that enclosing Interaction. By common
    Lifelines we mean Lifelines with the same selector and represents associations."
   :operation-body
   "let intUses : Set(InteractionUse) = interaction.interactionUse  in intUses->notEmpty() implies intUses->forAll ( iuse : InteractionUse |  let usingInteraction : Set(Interaction)  = iuse.enclosingInteraction->asSet() ->union( iuse.enclosingOperand.combinedFragment->asSet()->closure(enclosingOperand.combinedFragment).enclosingInteraction->asSet()                )  in let peerUses : Set(InteractionUse) = usingInteraction.fragment->select(oclIsKindOf(InteractionUse)).oclAsType(InteractionUse)->asSet() ->union( usingInteraction.fragment->select(oclIsKindOf(CombinedFragment)).oclAsType(CombinedFragment)->asSet() ->closure(operand.fragment->select(oclIsKindOf(CombinedFragment)).oclAsType(CombinedFragment)).operand.fragment-> select(oclIsKindOf(InteractionUse)).oclAsType(InteractionUse)->asSet()                )->excluding(iuse)  in peerUses->notEmpty() implies peerUses->forAll( peerUse : InteractionUse |  peerUse.refersTo.lifeline->forAll( l : Lifeline | (l.represents = self.represents and l.selector = self.selector ) implies  usingInteraction.lifeline->select(represents = self.represents and selector = self.selector)->notEmpty()                                                 )                     ) )")

(def-mm-constraint "same_classifier" |Lifeline| 
   "The classifier containing the referenced ConnectableElement must be the
    same classifier, or an ancestor, of the classifier that contains the interaction
    enclosing this lifeline."
   :operation-status :rewritten
   :editor-note "_'context' not 'context'."
   :original-body
   "represents.namespace->closure(namespace)->includes(interaction.'context')  "
   :operation-body
   "represents.namespace->closure(namespace)->includes(interaction._'context')  ")

(def-mm-constraint "selector_specified" |Lifeline| 
   "The selector for a Lifeline must only be specified if the referenced Part
    is multivalued."
   :operation-body
   "(self.selector->isEmpty() implies not self.represents.oclAsType(MultiplicityElement).isMultivalued()) or (not self.selector->isEmpty() implies self.represents.oclAsType(MultiplicityElement).isMultivalued())")

;;; =========================================================
;;; ====================== LinkAction
;;; =========================================================
(def-mm-class |LinkAction| :UML25 (|Action|)
 "LinkAction is an abstract class for all link actions that identify their
  links by the objects at the ends of the links and by the qualifiers at
  ends of the links."
  ((|endData| :range |LinkEndData| :multiplicity (2 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|LinkEndData| |linkAction|)
    :documentation
     "Data identifying one end of a link by the objects on its ends and qualifiers.")
   (|inputValue| :range |InputPin| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |linkAction|)
    :documentation
     "Pins taking end objects and qualifier values as input.")))


(def-mm-constraint "not_static" |LinkAction| 
   "The association ends of the link end data must not be static."
   :operation-body
   "endData->forAll(not end.isStatic)")

(def-mm-constraint "same_association" |LinkAction| 
   "The association ends of the link end data must all be from the same association
    and include all and only the association ends of that association."
   :operation-body
   "self.endData->collect(end) = self.association()->collect(memberEnd)")

(def-mm-constraint "same_pins" |LinkAction| 
   "The input pins of the action are the same as the pins of the link end data
    and insertion pins."
   :operation-body
   "self.input->asSet() = let ledpins : Set(InputPin) = self.endData->collect(value)->asSet() in   if self.oclIsKindOf(LinkEndCreationData)   then ledpins->union(self.endData.oclAsType(LinkEndCreationData).insertAt->asSet())   else ledpins endif ")

(def-mm-operation "association" |LinkAction| 
   "The association operates on LinkAction. It returns the association of the
    action."
   :operation-body
   "endData->asSequence()->first().end.association"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Association|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LinkEndCreationData
;;; =========================================================
(def-mm-class |LinkEndCreationData| :UML25 (|LinkEndData|)
 "A link end creation data is not an action. It is an element that identifies
  links. It identifies one end of a link to be created by a create link action."
  ((|insertAt| :range |InputPin| :multiplicity (0 1) :soft-opposite (|InputPin| |linkEndCreationData|)
    :documentation
     "Specifies where the new link should be inserted for ordered association
      ends, or where an existing link should be moved to. The type of the input
      is UnlimitedNatural, but the input cannot be zero. This pin is omitted
      for association ends that are not ordered.")
   (|isReplaceAll| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the existing links emanating from the object on this
      end should be destroyed before creating a new link.")))


(def-mm-constraint "create_link_action" |LinkEndCreationData| 
   "LinkEndCreationData can only be end data for CreateLinkAction or one of
    its specializations."
   :operation-body
   "true")

(def-mm-constraint "single_input_pin" |LinkEndCreationData| 
   "Link end creation data for ordered association ends must have a single
    input pin for the insertion point with type UnlimitedNatural and multiplicity
    of 1..1, otherwise the action has no input pin for the insertion point."
   :operation-body
   "if  not end.isOrdered then insertAt = null else   let insertAtPin : InputPin = insertAt->asSequence()->first() in     insertAt <> null     and insertAtPin.type = UnlimitedNatural     and insertAtPin.is(1,1) endif ")

;;; =========================================================
;;; ====================== LinkEndData
;;; =========================================================
(def-mm-class |LinkEndData| :UML25 (|Element|)
 "A link end data is not an action. It is an element that identifies links.
  It identifies one end of a link to be read or written by the children of
  a link action. A link cannot be passed as a runtime value to or from an
  action. Instead, a link is identified by its end objects and qualifier
  values, if any. This requires more than one piece of data, namely, the
  statically-specified end in the user model, the object on the end, and
  the qualifier values for that end, if any. These pieces are brought together
  around a link end data. Each association end is identified separately with
  an instance of the LinkEndData class."
  ((|end| :range |Property| :multiplicity (1 1) :soft-opposite (|Property| |linkEndData|)
    :documentation
     "Association end for which this link-end data specifies values.")
   (|qualifier| :range |QualifierValue| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|QualifierValue| |linkEndData|)
    :documentation
     "List of qualifier values")
   (|value| :range |InputPin| :multiplicity (0 1) :soft-opposite (|InputPin| |linkEndData|)
    :documentation
     "Input pin that provides the specified object for the given end. This pin
      is omitted if the link-end data specifies an 'open' end for reading.")))


(def-mm-constraint "end_object_input_pin" |LinkEndData| 
   "The end object input pin is not also a qualifier value input pin."
   :operation-body
   "value->excludesAll(qualifier.value)")

(def-mm-constraint "multiplicity" |LinkEndData| 
   "The multiplicity of the end object input pin must be 1..1."
   :operation-body
   "self.value.is(1,1)")

(def-mm-constraint "property_is_association_end" |LinkEndData| 
   "The property must be an association end."
   :operation-body
   "end.association <> null")

(def-mm-constraint "qualifiers" |LinkEndData| 
   "The qualifiers include all and only the qualifiers of the association end."
   :operation-body
   "qualifier->collect(qualifier)->asSet() = end.qualifier")

(def-mm-constraint "same_type" |LinkEndData| 
   "The type of the end object input pin is the same as the type of the association
    end."
   :operation-body
   "value.type = end.type")

;;; =========================================================
;;; ====================== LinkEndDestructionData
;;; =========================================================
(def-mm-class |LinkEndDestructionData| :UML25 (|LinkEndData|)
 "A link end destruction data is not an action. It is an element that identifies
  links. It identifies one end of a link to be destroyed by destroy link
  action."
  ((|destroyAt| :range |InputPin| :multiplicity (0 1) :soft-opposite (|InputPin| |linkEndDestructionData|)
    :documentation
     "Specifies the position of an existing link to be destroyed in ordered nonunique
      association ends. The type of the pin is UnlimitedNatural, but the value
      cannot be zero or unlimited.")
   (|isDestroyDuplicates| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to destroy duplicates of the value in nonunique association
      ends.")))


(def-mm-constraint "destroy_link_action" |LinkEndDestructionData| 
   "LinkEndDestructionData can only be end data for DestroyLinkAction or one
    of its specializations."
   :operation-body
   "true")

(def-mm-constraint "unlimited_natural_and_multiplicity" |LinkEndDestructionData| 
   "LinkEndDestructionData for ordered nonunique association ends must have
    a single destroyAt input pin if isDestroyDuplicates is false. It must be
    of type UnlimitedNatural and have a multiplicity of 1..1. Otherwise, the
    action has no input pin for the removal position."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== LiteralBoolean
;;; =========================================================
(def-mm-class |LiteralBoolean| :UML25 (|LiteralSpecification|)
 "A literal Boolean is a specification of a Boolean value."
  ((|value| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "The specified Boolean value.")))


(def-mm-operation "booleanValue" |LiteralBoolean| 
   "The query booleanValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isComputable" |LiteralBoolean| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralInteger
;;; =========================================================
(def-mm-class |LiteralInteger| :UML25 (|LiteralSpecification|)
 "A literal integer is a specification of an integer value."
  ((|value| :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The specified Integer value.")))


(def-mm-operation "integerValue" |LiteralInteger| 
   "The query integerValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-mm-operation "isComputable" |LiteralInteger| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralNull
;;; =========================================================
(def-mm-class |LiteralNull| :UML25 (|LiteralSpecification|)
 "A literal null specifies the lack of a value."
  ())


(def-mm-operation "isComputable" |LiteralNull| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isNull" |LiteralNull| 
   "The query isNull() returns true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralReal
;;; =========================================================
(def-mm-class |LiteralReal| :UML25 (|LiteralSpecification|)
 "A literal real is a specification of a real value."
  ((|value| :range |Real| :multiplicity (1 1))))


(def-mm-operation "isComputable" |LiteralReal| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "realValue" |LiteralReal| 
   "The query realValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Real|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralSpecification
;;; =========================================================
(def-mm-class |LiteralSpecification| :UML25 (|ValueSpecification|)
 "A literal specification identifies a literal constant being modeled."
  ())


;;; =========================================================
;;; ====================== LiteralString
;;; =========================================================
(def-mm-class |LiteralString| :UML25 (|LiteralSpecification|)
 "A literal string is a specification of a string value."
  ((|value| :range |String| :multiplicity (0 1)
    :documentation
     "The specified String value.")))


(def-mm-operation "isComputable" |LiteralString| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "stringValue" |LiteralString| 
   "The query stringValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralUnlimitedNatural
;;; =========================================================
(def-mm-class |LiteralUnlimitedNatural| :UML25 (|LiteralSpecification|)
 "A literal unlimited natural is a specification of an unlimited natural
  number."
  ((|value| :range |UnlimitedNatural| :multiplicity (1 1) :default 0
    :documentation
     "The specified UnlimitedNatural value.")))


(def-mm-operation "isComputable" |LiteralUnlimitedNatural| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "unlimitedValue" |LiteralUnlimitedNatural| 
   "The query unlimitedValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LoopNode
;;; =========================================================
(def-mm-class |LoopNode| :UML25 (|StructuredActivityNode|)
 "A loop node is a structured activity node that represents a loop with setup,
  test, and body sections."
  ((|bodyOutput| :range |OutputPin| :multiplicity (0 -1) :is-ordered-p T :soft-opposite (|OutputPin| |loopNode|)
    :documentation
     "A list of output pins within the body fragment the values of which are
      moved to the loop variable pins after completion of execution of the body,
      before the next iteration of the loop begins or before the loop exits.")
   (|bodyPart| :range |ExecutableNode| :multiplicity (0 -1) :soft-opposite (|ExecutableNode| |loopNode|)
    :documentation
     "The set of nodes and edges that perform the repetitive computations of
      the loop. The body section is executed as long as the test section produces
      a true value.")
   (|decider| :range |OutputPin| :multiplicity (1 1) :soft-opposite (|OutputPin| |loopNode|)
    :documentation
     "An output pin within the test fragment the value of which is examined after
      execution of the test to determine whether to execute the loop body.")
   (|isTestedFirst| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the test is performed before the first execution of the body.
      If false, the body is executed once before the test is performed.")
   (|loopVariable| :range |OutputPin| :multiplicity (0 -1) :is-ordered-p T :soft-opposite (|OutputPin| |loopNode|)
    :documentation
     "A list of output pins that hold the values of the loop variables during
      an execution of the loop. When the test fails, the values are movied to
      the result pins of the loop.")
   (|loopVariableInput| :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T :soft-opposite (|InputPin| |loopNode|)
    :documentation
     "A list of values that are moved into the loop variable pins before the
      first iteration of the loop." :redefined-property (|StructuredActivityNode| |structuredNodeInput|))
   (|result| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T :soft-opposite (|OutputPin| |loopNode|)
    :documentation
     "A list of output pins that constitute the data flow output of the entire
      loop." :redefined-property (|StructuredActivityNode| |structuredNodeOutput|))
   (|setupPart| :range |ExecutableNode| :multiplicity (0 -1) :soft-opposite (|ExecutableNode| |loopNode|)
    :documentation
     "The set of nodes and edges that initialize values or perform other setup
      computations for the loop.")
   (|test| :range |ExecutableNode| :multiplicity (1 -1) :soft-opposite (|ExecutableNode| |loopNode|)
    :documentation
     "The set of nodes, edges, and designated value that compute a Boolean value
      to determine if another execution of the body will be performed.")))


(def-mm-constraint "body_output_pins" |LoopNode| 
   "The bodyOutput pins are output pins on actions in the body of the loop
    node."
   :operation-body
   "true")

(def-mm-constraint "executable_nodes" |LoopNode| 
   "The union of the ExecutableNodes in the setupPart, test and bodyPart of
    a LoopNode must be the same as the subset of nodes contained in the LoopNode
    (considered as a StructuredActivityNode) that are ExecutableNodes."
   :operation-body
   "true")

(def-mm-constraint "input_edges" |LoopNode| 
   "Loop variable inputs must not have outgoing edges."
   :operation-body
   "true")

(def-mm-constraint "result_no_incoming" |LoopNode| 
   "The result output pins have no incoming edges."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Manifestation
;;; =========================================================
(def-mm-class |Manifestation| :UML25 (|Abstraction|)
 "A manifestation is the concrete physical rendering of one or more model
  elements by an artifact."
  ((|utilizedElement| :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|)) :soft-opposite (|PackageableElement| |manifestation|)
    :documentation
     "The model element that is utilized in the manifestation in an Artifact.")))


;;; =========================================================
;;; ====================== MergeNode
;;; =========================================================
(def-mm-class |MergeNode| :UML25 (|ControlNode|)
 "A merge node is a control node that brings together multiple alternate
  flows. It is not used to synchronize concurrent flows but to accept one
  among several alternate flows."
  ())


(def-mm-constraint "edges" |MergeNode| 
   "The edges coming into and out of a merge node must be either all object
    flows or all control flows."
   :operation-body
   "true")

(def-mm-constraint "one_outgoing_edge" |MergeNode| 
   "A merge node has one outgoing edge."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Message
;;; =========================================================
(def-mm-class |Message| :UML25 (|NamedElement|)
 "A Message defines a particular communication between Lifelines of an Interaction."
  ((|argument| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |message|)
    :documentation
     "The arguments of the Message")
   (|connector| :range |Connector| :multiplicity (0 1) :soft-opposite (|Connector| |message|)
    :documentation
     "The Connector on which this Message is sent.")
   (|interaction| :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |message|)
    :documentation
     "The enclosing Interaction owning the Message")
   (|messageKind| :range |MessageKind| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :unknown
    :documentation
     "The derived kind of the Message (complete, lost, found or unknown)")
   (|messageSort| :range |MessageSort| :multiplicity (1 1) :default :synchcall
    :documentation
     "The sort of communication reflected by the Message")
   (|receiveEvent| :range |MessageEnd| :multiplicity (0 1) :soft-opposite (|MessageEnd| |endMessage|)
    :documentation
     "References the Receiving of the Message")
   (|sendEvent| :range |MessageEnd| :multiplicity (0 1) :soft-opposite (|MessageEnd| |endMessage|)
    :documentation
     "References the Sending of the Message.")
   (|signature| :range |NamedElement| :multiplicity (0 1) :soft-opposite (|NamedElement| |message|)
    :documentation
     "The signature of the Message is the specification of its content. It refers
      either an Operation or a Signal.")))


(def-mm-constraint "arguments" |Message| 
   "Arguments of a Message must only be: i) attributes of the sending lifeline
    ii) constants iii) symbolic values (which are wildcard values representing
    any legal value) iv) explicit parameters of the enclosing Interaction v)
    attributes of the class owning the Interaction"
   :operation-body
   "true")

(def-mm-constraint "cannot_cross_boundaries" |Message| 
   "Messages cannot cross boundaries of CombinedFragments or their operands.
     This is true if and only if both MessageEnds are enclosed within the same
    InteractionFragment (i.e., an InteractionOperand or an Interaction)."
   :operation-body
   "sendEvent->notEmpty() and receiveEvent->notEmpty() implies let sendEnclosingFrag : Set(InteractionFragment) =  sendEvent->asOrderedSet()->first().enclosingFragment() in  let receiveEnclosingFrag : Set(InteractionFragment) =  receiveEvent->asOrderedSet()->first().enclosingFragment() in  sendEnclosingFrag = receiveEnclosingFrag")

(def-mm-constraint "occurrence_specifications" |Message| 
   "If the MessageEnds are both OccurrenceSpecifications then the connector
    must go between the Parts represented by the Lifelines of the two MessageEnds."
   :operation-body
   "true")

(def-mm-constraint "sending_receiving_message_event" |Message| 
   "If the sendEvent and the receiveEvent of the same Message are on the same
    Lifeline, the sendEvent must be ordered before the receiveEvent."
   :operation-body
   "sendEvent.oclIsKindOf(MessageOccurrenceSpecification)->notEmpty() and receiveEvent.oclIsKindOf(MessageOccurrenceSpecification)->notEmpty() implies let f :  Lifeline = sendEvent.oclIsKindOf(MessageOccurrenceSpecification).oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first().covered in f = receiveEvent.oclIsKindOf(MessageOccurrenceSpecification).oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first().covered  implies f.events->indexOf(sendEvent.oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first() ) <  f.events->indexOf(receiveEvent.oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first() )")

(def-mm-constraint "signature_is_operation" |Message| 
   "In the case when the Message signature is an Operation, the arguments of
    the Message must correspond to the parameters of the Operation. A Parameter
    corresponds to an Argument if the Argument is of the same Class or a specialization
    of that of the Parameter."
   :operation-body
   "true")

(def-mm-constraint "signature_is_signal" |Message| 
   "In the case when the Message signature is a Signal, the arguments of the
    Message must correspond to the attributes of the Signal. A Message Argument
    corresponds to a Signal Attribute if the Arguement is of the same Class
    or a specialization of that of the Attribute."
   :operation-body
   "true")

(def-mm-constraint "signature_refer_to" |Message| 
   "The signature must either refer an Operation (in which case messageSort
    is either synchCall or asynchCall or reply) or a Signal (in which case
    messageSort is asynchSignal). The name of the NamedElement referenced by
    signature must be the same as that of the Message."
   :operation-body
   "signature->notEmpty() implies  ((signature.oclIsKindOf(Operation) and  (messageSort = MessageSort::asynchCall or messageSort = MessageSort::synchCall or messageSort = MessageSort::reply)  ) or (signature.oclIsKindOf(Signal)  and messageSort = MessageSort::asynchSignal )  ) and name = signature.name    ")

(def-mm-operation "isDistinguishableFrom" |Message| 
   "The query isDistinguishableFrom() specifies that any two Messages may coexist
    in the same Namespace, regardless of their names."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-mm-operation "messageKind.1" |Message| 
   "This query returns the MessageKind value for this Message"
   :operation-body
   "messageKind"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|MessageKind|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== MessageEnd
;;; =========================================================
(def-mm-class |MessageEnd| :UML25 (|NamedElement|)
 "MessageEnd is an abstract specialization of NamedElement that represents
  what can occur at the end of a Message."
  ((|message| :range |Message| :multiplicity (0 1) :soft-opposite (|Message| |messageEnd|)
    :documentation
     "References a Message.")))


(def-mm-operation "enclosingFragment" |MessageEnd| 
   "This query returns a set including the enclosing InteractionFragment this
    MessageEnd is enclosed within"
   :operation-body
   "if self->select(oclIsKindOf(Gate))->notEmpty()  then -- it is a Gate 
let endGate : Gate =    self->select(oclIsKindOf(Gate)).oclAsType(Gate)->asOrderedSet()->first()   in   if endGate.isOutsideCF()    then endGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(endGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet())   else if endGate.isInsideCF()      then endGate.combinedFragment.oclAsType(InteractionFragment)->asSet()     else if endGate.isFormal()        then endGate.interaction.oclAsType(InteractionFragment)->asSet()       else if endGate.isActual()          then endGate.interactionUse.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->      union(endGate.interactionUse.enclosingOperand.oclAsType(InteractionFragment)->asSet())         else null         endif       endif     endif   endif else -- it is a MessageOccurrenceSpecification 
let endMOS : MessageOccurrenceSpecification  =    self->select(oclIsKindOf(MessageOccurrenceSpecification)).oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first()    in   if endMOS.enclosingInteraction->notEmpty()    then endMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()   else endMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet()   endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InteractionFragment|
                        :parameter-return-p T))
)

(def-mm-operation "isReceive" |MessageEnd| 
   "This query returns value true if this MessageEnd is a receiveEvent"
   :operation-body
   "message.receiveEvent->asSet()->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isSend" |MessageEnd| 
   "This query returns value true if this MessageEnd is a sendEvent"
   :operation-body
   "message.sendEvent->asSet()->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "oppositeEnd" |MessageEnd| 
   "This query returns a set including the MessageEnd (if exists) at the opposite
    end of the Message for this MessageEnd"
   :operation-body
   "message->asSet().messageEnd->asSet()->excluding(self)    "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|MessageEnd|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== MessageEvent
;;; =========================================================
(def-mm-class |MessageEvent| :UML25 (|Event|)
 "A message event specifies the receipt by an object of either a call or
  a signal."
  ())


;;; =========================================================
;;; ====================== MessageOccurrenceSpecification
;;; =========================================================
(def-mm-class |MessageOccurrenceSpecification| :UML25 (|MessageEnd| |OccurrenceSpecification|)
 "A MessageOccurrenceSpecification specifies the occurrence of Message events,
  such as sending and receiving of Signals or invoking or receiving of Operation
  calls. A MessageOccurrenceSpecification is a kind of MessageEnd. Messages
  are generated either by synchronous Operation calls or asynchronous Signal
  sends. They are received by the execution of corresponding AcceptEventActions."
  ())


;;; =========================================================
;;; ====================== Model
;;; =========================================================
(def-mm-class |Model| :UML25 (|Package|)
 "A model captures a view of a physical system. It is an abstraction of the
  physical system, with a certain purpose. This purpose determines what is
  to be included in the model and what is irrelevant. Thus the model completely
  describes those aspects of the physical system that are relevant to the
  purpose of the model, at the appropriate level of detail."
  ((|viewpoint| :range |String| :multiplicity (0 1)
    :documentation
     "The name of the viewpoint that is expressed by a model (This name may refer
      to a profile definition).")))


;;; =========================================================
;;; ====================== MultiplicityElement
;;; =========================================================
(def-mm-class |MultiplicityElement| :UML25 (|Element|)
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
   (|lower| :range |Integer| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "Specifies the lower bound of the multiplicity interval.")
   (|lowerValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningLower|)
    :documentation
     "The specification of the lower bound for this multiplicity.")
   (|upper| :range |UnlimitedNatural| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "Specifies the upper bound of the multiplicity interval.")
   (|upperValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningUpper|)
    :documentation
     "The specification of the upper bound for this multiplicity.")))


(def-mm-constraint "lower_ge_0" |MultiplicityElement| 
   "The lower bound must be a non-negative integer literal."
   :operation-body
   "lowerBound() <> null implies lowerBound() >= 0")

(def-mm-constraint "upper_ge_lower" |MultiplicityElement| 
   "The upper bound must be greater than or equal to the lower bound."
   :operation-body
   "(upperBound() <> null and lowerBound() <> null) implies upperBound() >= lowerBound()")

(def-mm-constraint "value_specification_constant" |MultiplicityElement| 
   "If a non-literal ValueSpecification is used for the lower or upper bound,
    then that specification must be a constant expression."
   :operation-body
   "true")

(def-mm-constraint "value_specification_no_side_effects" |MultiplicityElement| 
   "If a non-literal ValueSpecification is used for the lower or upper bound,
    then evaluating that specification must not have side effects."
   :operation-body
   "true")

(def-mm-operation "compatibleWith" |MultiplicityElement| 
   "The operation compatibleWith takes another multiplicity as input. It checks
    if one multiplicity is compatible with another."
   :operation-body
   "(other.lowerBound() <= self.lowerBound()) and ((other.upperBound() = *) or (self.upperBound() <= other.upperBound()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|MultiplicityElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "includesMultiplicity" |MultiplicityElement| 
   "The query includesMultiplicity() checks whether this multiplicity includes
    all the cardinalities allowed by the specified multiplicity."
   :operation-body
   "(self.lowerBound() <= M.lowerBound()) and (self.upperBound() >= M.upperBound())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name 'M :parameter-type '|MultiplicityElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "is" |MultiplicityElement| 
   "The operation is determines if the upper and lower bound of the ranges
    are the ones given."
   :operation-body
   "lowerbound = self.lowerBound() and upperbound = self.upperBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|lowerbound| :parameter-type '|Integer|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|upperbound| :parameter-type '|UnlimitedNatural|
                        :parameter-return-p NIL))
)

(def-mm-operation "isMultivalued" |MultiplicityElement| 
   "The query isMultivalued() checks whether this multiplicity has an upper
    bound greater than one."
   :operation-body
   "upperBound() > 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "lower.1" |MultiplicityElement| 
   "The derived lower attribute must equal the lowerBound."
   :operation-body
   "lowerBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-mm-operation "lowerBound" |MultiplicityElement| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    integer."
   :operation-body
   "if lowerValue=null then 1 else lowerValue.integerValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-mm-operation "upper.1" |MultiplicityElement| 
   "The derived upper attribute must equal the upperBound."
   :operation-body
   "upperBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-mm-operation "upperBound" |MultiplicityElement| 
   "The query upperBound() returns the upper bound of the multiplicity for
    a bounded multiplicity as an unlimited natural."
   :operation-body
   "if upperValue=null then 1 else upperValue.unlimitedValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== NamedElement
;;; =========================================================
(def-mm-class |NamedElement| :UML25 (|Element|)
 "A named element supports using a string expression to specify its name.
  This allows names of model elements to involve template parameters. The
  actual name is evaluated from the string expression only when it is sensible
  to do so (e.g., when a template is bound). A named element is an element
  in a model that may have a name."
  ((|clientDependency| :range |Dependency| :multiplicity (0 -1)
    :opposite (|Dependency| |client|)
    :documentation
     "Indicates the dependencies that reference the client.")
   (|name| :range |String| :multiplicity (0 1)
    :documentation
     "The name of the NamedElement.")
   (|nameExpression| :range |StringExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|StringExpression| |namedElement|)
    :documentation
     "The string expression used to define the name of this named element.")
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
   "name=null or allNamespaces()->select( ns | ns.name=null )->notEmpty() implies qualifiedName = null")

(def-mm-constraint "has_qualified_name" |NamedElement| 
   "When there is a name, and all of the containing namespaces have a name,
    the qualified name is constructed from the names of the containing namespaces."
   :operation-body
   "(name <> null and allNamespaces()->select(ns | ns.name = null)->isEmpty()) implies   qualifiedName = allNamespaces()->iterate( ns : Namespace; agg: String = name | ns.name.concat(self.separator()).concat(agg))")

(def-mm-constraint "visibility_needs_ownership" |NamedElement| 
   "If a NamedElement is not owned by a Namespace, it does not have a visibility."
   :operation-body
   "namespace = null implies visibility = null")

(def-mm-operation "allNamespaces" |NamedElement| 
   "The query allNamespaces() gives the sequence of namespaces in which the
    NamedElement is nested, working outwards."
   :operation-body
   "if namespace->isEmpty() then OrderedSet{} else namespace.allNamespaces()->prepend(namespace) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T))
)

(def-mm-operation "allOwningPackages" |NamedElement| 
   "The query allOwningPackages() returns all the directly or indirectly owning
    packages."
   :operation-body
   "if namespace.oclIsKindOf(Package) then   let owningPackage : Package = namespace.oclAsType(Package) in     owningPackage->union(owningPackage.allOwningPackages()) else   null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-mm-operation "isDistinguishableFrom" |NamedElement| 
   "The query isDistinguishableFrom() determines whether two NamedElements
    may logically co-exist within a Namespace. By default, two named elements
    are distinguishable if (a) they have unrelated types or (b) they have related
    types but different names."
   :operation-body
   "(self.oclIsKindOf(n.oclType()) or n.oclIsKindOf(self.oclType())) implies     ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty() "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-mm-operation "qualifiedName.1" |NamedElement| 
   "When there is a name, and all of the containing namespaces have a name,
    the qualified name is constructed from the names of the containing namespaces."
   :operation-body
   "if self.name <> null and self.allNamespaces()->select( ns | ns.name=null )->isEmpty() then      self.allNamespaces()->iterate( ns : Namespace; agg: String = self.name | ns.name.concat(self.separator()).concat(agg)) else    null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-mm-operation "separator" |NamedElement| 
   "The query separator() gives the string that is used to separate names when
    constructing a qualified name."
   :operation-body
   "'::'"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-mm-class |Namespace| :UML25 (|NamedElement|)
 "A namespace is an element in a model that contains a set of named elements
  that can be identified by name."
  ((|elementImport| :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ElementImport| |importingNamespace|)
    :documentation
     "References the ElementImports owned by the Namespace.")
   (|importedMember| :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|)) :soft-opposite (|PackageableElement| |namespace|)
    :documentation
     "References the PackageableElements that are members of this Namespace as
      a result of either PackageImports or ElementImports.")
   (|member| :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T :soft-opposite (|NamedElement| |memberNamespace|)
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
    :opposite (|Constraint| |context|)
    :documentation
     "Specifies a set of Constraints owned by this Namespace.")
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
   "imps->reject(imp1  | imps->exists(imp2 | not imp1.isDistinguishableFrom(imp2, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "getNamesOfMember" |Namespace| 
   "The query getNamesOfMember() takes importing into account. It gives back
    the set of names that an element would have in an importing namespace,
    either because it is owned, or if not owned then imported individually,
    or if not individually then from a package. The query getNamesOfMember()
    gives a set of all of the names that a member would have in a Namespace.
    In general a member can have multiple names in a Namespace if it is imported
    more than once with different aliases. The query takes account of importing.
    It gives back the set of names that an element would have in an importing
    namespace, either because it is owned, or if not owned then imported individually,
    or if not individually then from a package."
   :operation-body
   "if self.ownedMember ->includes(element) then Set{element.name} else let elementImports : Set(ElementImport) = self.elementImport->select(ei | ei.importedElement = element) in   if elementImports->notEmpty()   then      elementImports->collect(el | el.getName())->asSet()   else       self.packageImport->select(pi | pi.importedPackage.visibleMembers().oclAsType(NamedElement)->includes(element))-> collect(pi | pi.importedPackage.getNamesOfMember(element))->asSet()   endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|element| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "importMembers" |Namespace| 
   "The query importMembers() defines which of a set of PackageableElements
    are actually imported into the namespace. This excludes hidden ones, i.e.,
    those which have names that conflict with names of owned members, and also
    excludes elements which would have the same name when imported."
   :operation-body
   "self.excludeCollisions(imps)->select(imp | self.ownedMember->forAll(mem | imp.isDistinguishableFrom(mem, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "importedMember.1" |Namespace| 
   "The importedMember property is derived from the ElementImports and the
    PackageImports. References the PackageableElements that are members of
    this Namespace as a result of either PackageImports or ElementImports."
   :operation-body
   "self.importMembers(elementImport.importedElement->asSet()->union(packageImport.importedPackage->collect(p | p.visibleMembers()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

(def-mm-operation "membersAreDistinguishable" |Namespace| 
   "The Boolean query membersAreDistinguishable() determines whether all of
    the namespace's members are distinguishable within it."
   :operation-body
   "member->forAll( memb |    member->excluding(memb)->forAll(other |        memb.isDistinguishableFrom(other, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Node
;;; =========================================================
(def-mm-class |Node| :UML25 (|Class| |DeploymentTarget|)
 "A node is computational resource upon which artifacts may be deployed for
  execution. Nodes can be interconnected through communication paths to define
  network structures."
  ((|nestedNode| :range |Node| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Node| |node|)
    :documentation
     "The Nodes that are defined (nested) within the Node.")))


(def-mm-constraint "internal_structure" |Node| 
   "The internal structure of a Node (if defined) consists solely of parts
    of type Node."
   :operation-body
   "part->forAll(oclIsKindOf(Node))")

;;; =========================================================
;;; ====================== ObjectFlow
;;; =========================================================
(def-mm-class |ObjectFlow| :UML25 (|ActivityEdge|)
 "An object flow is an activity edge that can have objects or data passing
  along it. Object flows have support for multicast/receive, token selection
  from object nodes, and transformation of tokens."
  ((|isMulticast| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the objects in the flow are passed by multicasting.")
   (|isMultireceive| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the objects in the flow are gathered from respondents to
      multicasting.")
   (|selection| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |objectFlow|)
    :documentation
     "Selects tokens from a source object node.")
   (|transformation| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |objectFlow|)
    :documentation
     "Changes or replaces data tokens flowing along edge.")))


(def-mm-constraint "compatible_types" |ObjectFlow| 
   "Object nodes connected by an object flow, with optionally intervening control
    nodes, must have compatible types. In particular, the downstream object
    node type must be the same or a supertype of the upstream object node type."
   :operation-body
   "true")

(def-mm-constraint "input_and_output_parameter" |ObjectFlow| 
   "A selection behavior has one input parameter and one output parameter.
    The input parameter must be a bag of elements of the same as or a supertype
    of the type of source object node. The output parameter must be the same
    or a subtype of the type of source object node. The behavior cannot have
    side effects."
   :operation-body
   "true")

(def-mm-constraint "is_multicast_or_is_multireceive" |ObjectFlow| 
   "isMulticast and isMultireceive cannot both be true."
   :operation-body
   "true")

(def-mm-constraint "no_actions" |ObjectFlow| 
   "Object flows may not have actions at either end."
   :operation-body
   "true")

(def-mm-constraint "same_upper_bounds" |ObjectFlow| 
   "Object nodes connected by an object flow, with optionally intervening control
    nodes, must have the same upper bounds."
   :operation-body
   "true")

(def-mm-constraint "selection_behaviour" |ObjectFlow| 
   "An object flow may have a selection behavior only if has an object node
    as a source."
   :operation-body
   "true")

(def-mm-constraint "target" |ObjectFlow| 
   "An edge with constant weight may not target an object node, or lead to
    an object node downstream with no intervening actions, that has an upper
    bound less than the weight."
   :operation-body
   "true")

(def-mm-constraint "transformation_behaviour" |ObjectFlow| 
   "A transformation behavior has one input parameter and one output parameter.
    The input parameter must be the same as or a supertype of the type of object
    token coming from the source end. The output parameter must be the same
    or a subtype of the type of object token expected downstream. The behavior
    cannot have side effects."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ObjectNode
;;; =========================================================
(def-mm-class |ObjectNode| :UML25 (|TypedElement| |ActivityNode|)
 "Object nodes have support for token selection, limitation on the number
  of tokens, specifying the state required for tokens, and carrying control
  values. An object node is an abstract activity node that is part of defining
  object flow in an activity."
  ((|inState| :range |State| :multiplicity (0 -1) :soft-opposite (|State| |objectNode|)
    :documentation
     "The required states of the object available at this point in the activity.")
   (|isControlType| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the type of the object node is to be treated as control.")
   (|ordering| :range |ObjectNodeOrderingKind| :multiplicity (1 1) :default :fifo
    :documentation
     "Tells whether and how the tokens in the object node are ordered for selection
      to traverse edges outgoing from the object node.")
   (|selection| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |objectNode|)
    :documentation
     "Selects tokens for outgoing edges.")
   (|upperBound| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |objectNode|)
    :documentation
     "The maximum number of tokens allowed in the node. Objects cannot flow into
      the node if the upper bound is reached.")))


(def-mm-constraint "input_output_parameter" |ObjectNode| 
   "A selection behavior has one input parameter and one output parameter.
    The input parameter must be a bag of elements of the same type as the object
    node or a supertype of the type of object node. The output parameter must
    be the same or a subtype of the type of object node. The behavior cannot
    have side effects."
   :operation-body
   "true")

(def-mm-constraint "object_flow_edges" |ObjectNode| 
   "All edges coming into or going out of object nodes must be object flow
    edges."
   :operation-body
   "true")

(def-mm-constraint "selection_behavior" |ObjectNode| 
   "If an object node has a selection behavior, then the ordering of the object
    node is ordered, and vice versa."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Observation
;;; =========================================================
(def-mm-class |Observation| :UML25 (|PackageableElement|)
 "Observation is a superclass of TimeObservation and DurationObservation
  in order for TimeExpression and Duration to refer to either in a simple
  way."
  ())


;;; =========================================================
;;; ====================== OccurrenceSpecification
;;; =========================================================
(def-mm-class |OccurrenceSpecification| :UML25 (|InteractionFragment|)
 "An OccurrenceSpecification is the basic semantic unit of Interactions.
  The sequences of occurrences specified by them are the meanings of Interactions."
  ((|covered| :range |Lifeline| :multiplicity (1 1) :soft-opposite (|Lifeline| |events|)
    :documentation
     "References the Lifeline on which the OccurrenceSpecification appears." :redefined-property (|InteractionFragment| |covered|))
   (|toAfter| :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |before|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur after this OccurrenceSpecification")
   (|toBefore| :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |after|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur before this OccurrenceSpecification")))


;;; =========================================================
;;; ====================== OpaqueAction
;;; =========================================================
(def-mm-class |OpaqueAction| :UML25 (|Action|)
 "An action with implementation-specific semantics."
  ((|body| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the action in one or more languages.")
   (|inputValue| :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |opaqueAction|)
    :documentation
     "Provides input to the action.")
   (|language| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Languages the body strings use, in the same order as the body strings")
   (|outputValue| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |opaqueAction|)
    :documentation
     "Takes output from the action.")))


;;; =========================================================
;;; ====================== OpaqueBehavior
;;; =========================================================
(def-mm-class |OpaqueBehavior| :UML25 (|Behavior|)
 "An behavior with implementation-specific semantics."
  ((|body| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the behavior in one or more languages.")
   (|language| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Languages the body strings use in the same order as the body strings.")))


;;; =========================================================
;;; ====================== OpaqueExpression
;;; =========================================================
(def-mm-class |OpaqueExpression| :UML25 (|ValueSpecification|)
 "An opaque expression is an uninterpreted textual statement that denotes
  a (possibly empty) set of values when evaluated in a context. Provides
  a mechanism for precisely defining the behavior of an opaque expression.
  An opaque expression is defined by a behavior restricted to return one
  result."
  ((|behavior| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |opaqueExpression|)
    :documentation
     "Specifies the behavior of the opaque expression.")
   (|body| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The text of the expression, possibly in multiple languages.")
   (|language| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the languages in which the expression is stated. The interpretation
      of the expression body depends on the languages. If the languages are unspecified,
      they might be implicit from the expression body or the context. Languages
      are matched to body strings by order.")
   (|result| :range |Parameter| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Parameter| |opaqueExpression|)
    :documentation
     "Restricts an opaque expression to return exactly one return result. When
      the invocation of the opaque expression completes, a single set of values
      is returned to its owner. This association is derived from the single return
      result parameter of the associated behavior.")))


(def-mm-constraint "language_body_size" |OpaqueExpression| 
   "If the language attribute is not empty, then the size of the body and language
    arrays must be the same."
   :operation-body
   "language->notEmpty() implies (_'body'->size() = language->size())")

(def-mm-constraint "one_return_result_parameter" |OpaqueExpression| 
   "The behavior must have exactly one return result parameter."
   :operation-body
   "self.behavior <> null implies   self.behavior.ownedParameter->select(direction=ParameterDirectionKind::return)->size() = 1")

(def-mm-constraint "only_return_result_parameters" |OpaqueExpression| 
   "The behavior may only have return result parameters."
   :operation-body
   "behavior <> null implies behavior.ownedParameter->select(direction<>ParameterDirectionKind::return)->isEmpty()")

(def-mm-operation "isIntegral" |OpaqueExpression| 
   "The query isIntegral() tells whether an expression is intended to produce
    an integer."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isNonNegative" |OpaqueExpression| 
   "The query isNonNegative() tells whether an integer expression has a non-negative
    value."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isPositive" |OpaqueExpression| 
   "The query isPositive() tells whether an integer expression has a positive
    value."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "result.1" |OpaqueExpression| 
   "Missing derivation for OpaqueExpression::/result : Parameter"
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-mm-operation "value" |OpaqueExpression| 
   "The query value() gives an integer value for an expression intended to
    produce one."
   :operation-body
   "0"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Operation
;;; =========================================================
(def-mm-class |Operation| :UML25 (|TemplateableElement| |ParameterableElement| |BehavioralFeature|)
 "An Operation is a BehavioralFeature of a Classifier that specifies the
  name, type, parameters, and constraints for invoking an associated Behavior.
  An Operation may invoke both the execution of method behaviors as well
  as other behavioral responses. Operation specializes TemplateableElement
  in order to support specification of template operations and bound operations.
  Operation specializes ParameterableElement to specify that an operation
  can be exposed as a formal template parameter, and provided as an actual
  parameter in a binding of a template."
  ((|bodyCondition| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |bodyContext|)
    :documentation
     "An optional Constraint on the result values of an invocation of this Operation.")
   (|class| :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Class| |ownedOperation|)
    :documentation
     "The Class that owns this operation, if any.")
   (|datatype| :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|DataType| |ownedOperation|)
    :documentation
     "The DataType that owns this Operation, if any.")
   (|interface| :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Interface| |ownedOperation|)
    :documentation
     "The Interface that owns this Operation, if any.")
   (|isOrdered| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "Specifies whether the return parameter is ordered or not, if present. 
      This information is derived from the return result for this Operation.")
   (|isQuery| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether an execution of the BehavioralFeature leaves the state
      of the system unchanged (isQuery=true) or whether side effects may occur
      (isQuery=false).")
   (|isUnique| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :true
    :documentation
     "Specifies whether the return parameter is unique or not, if present. This
      information is derived from the return result for this Operation.")
   (|lower| :range |Integer| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :default 1
    :documentation
     "Specifies the lower multiplicity of the return parameter, if present. This
      information is derived from the return result for this Operation.")
   (|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :opposite (|Parameter| |operation|)
    :documentation
     "The parameters owned by this Operation." :redefined-property (|BehavioralFeature| |ownedParameter|))
   (|postcondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |postContext|)
    :documentation
     "An optional set of Constraints specifying the state of the system when
      the Operation is completed.")
   (|precondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |preContext|)
    :documentation
     "An optional set of Constraints on the state of the system when the Operation
      is invoked.")
   (|raisedException| :range |Type| :multiplicity (0 -1) :soft-opposite (|Type| |operation|)
    :documentation
     "The Types representing exceptions that may be raised during an invocation
      of this operation." :redefined-property (|BehavioralFeature| |raisedException|))
   (|redefinedOperation| :range |Operation| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Operation| |operation|)
    :documentation
     "The Operations that are redefined by this Operation.")
   (|templateParameter| :range |OperationTemplateParameter| :multiplicity (0 1)
    :opposite (|OperationTemplateParameter| |parameteredElement|)
    :documentation
     "The OperationTemplateParameter that exposes this element as a formal parameter." :redefined-property (|ParameterableElement| |templateParameter|))
   (|type| :range |Type| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Type| |operation|)
    :documentation
     "The return type of the operation, if present. This information is derived
      from the return result for this Operation.")
   (|upper| :range |UnlimitedNatural| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :default 1
    :documentation
     "The upper multiplicity of the return parameter, if present. This information
      is derived from the return result for this Operation.")))


(def-mm-constraint "at_most_one_return" |Operation| 
   "An Operation can have at most one return parameter; i.e., an owned parameter
    with the direction set to 'return'"
   :operation-body
   "self.ownedParameter->select(direction = ParameterDirectionKind::return)->size() <= 1")

(def-mm-constraint "only_body_for_query" |Operation| 
   "A bodyCondition can only be specified for a query Operation."
   :operation-body
   "bodyCondition <> null implies isQuery")

(def-mm-operation "isConsistentWith" |Operation| 
   "A redefining operation is consistent with a redefined operation if it has
    the same number of owned parameters, and the type of each owned parameter
    conforms to the type of the corresponding redefined parameter.  The query
    isConsistentWith() specifies, for any two Operations in a context in which
    redefinition is possible, whether redefinition would be consistent in the
    sense of maintaining type covariance. Other senses of consistency may be
    required, for example to determine consistency in the sense of contravariance.
    Users may define alternative queries under names different from 'isConsistentWith()',
    as for example, users may define a query named 'isContravariantWith()'."
   :operation-body
   "redefinee.oclIsKindOf(Operation) and let op : Operation = redefinee.oclAsType(Operation) in  self.ownedParameter->size() = op.ownedParameter->size() and  Sequence{1..self.ownedParameter->size()}->   forAll(i |op.ownedParameter->at(1).type.conformsTo(self.ownedParameter->at(i).type))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isOrdered.1" |Operation| 
   "If this operation has a return parameter, isOrdered equals the value of
    isOrdered for that parameter. Otherwise isOrdered is false."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()-> exists(isOrdered) else false endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isUnique.1" |Operation| 
   "If this operation has a return parameter, isUnique equals the value of
    isUnique for that parameter. Otherwise isUnique is true."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->exists(isUnique) else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "lower.1" |Operation| 
   "If this operation has a return parameter, lower equals the value of lower
    for that parameter. Otherwise lower is not defined."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->any(true).lower else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-mm-operation "returnResult" |Operation| 
   "The query returnResult() returns the set containing the return parameter
    of the Operation if one exists, otherwise, it returns an empty set"
   :operation-body
   "ownedParameter->select (direction = ParameterDirectionKind::return)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-mm-operation "type.1" |Operation| 
   "If this operation has a return parameter, type equals the value of type
    for that parameter. Otherwise type is not defined."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->any(true).type else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-mm-operation "upper.1" |Operation| 
   "If this operation has a return parameter, upper equals the value of upper
    for that parameter. Otherwise upper is not defined."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->any(true).upper else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== OperationTemplateParameter
;;; =========================================================
(def-mm-class |OperationTemplateParameter| :UML25 (|TemplateParameter|)
 "An OperationTemplateParameter exposes an Operation as a formal parameter
  for a template."
  ((|parameteredElement| :range |Operation| :multiplicity (1 1)
    :opposite (|Operation| |templateParameter|)
    :documentation
     "The Operation exposed by this OperationTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))


;;; =========================================================
;;; ====================== OutputPin
;;; =========================================================
(def-mm-class |OutputPin| :UML25 (|Pin|)
 "An output pin is a pin that holds output values produced by an action."
  ())


(def-mm-constraint "incoming_edges_structured_only" |OutputPin| 
   "Output pins may have incoming edges only when they are on actions that
    are structured nodes, and these edges may not target a node contained by
    the structured node."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Package
;;; =========================================================
(def-mm-class |Package| :UML25 (|PackageableElement| |TemplateableElement| |Namespace|)
 "A package can have one or more profile applications to indicate which profiles
  have been applied. Because a profile is a package, it is possible to apply
  a profile not only to packages, but also to profiles. Package specializes
  TemplateableElement and PackageableElement specializes ParameterableElement
  to specify that a package can be used as a template and a PackageableElement
  as a template parameter. A package is used to group elements, and provides
  a namespace for the grouped elements."
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
   (|ownedStereotype| :range |Stereotype| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|)) :soft-opposite (|Stereotype| |owningPackage|)
    :documentation
     "References the Stereotypes that are owned by the Package")
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
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|PackageableElement| |owningPackage|)
    :documentation
     "Specifies the packageable elements that are owned by this Package.")
   (|profileApplication| :range |ProfileApplication| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ProfileApplication| |applyingPackage|)
    :documentation
     "References the ProfileApplications that indicate which profiles have been
      applied to the Package.")))


(def-mm-constraint "elements_public_or_private" |Package| 
   "If an element that is owned by a package has visibility, it is public or
    private."
   :operation-body
   "packagedElement->forAll(e | e.visibility<> null implies e.visibility = VisibilityKind::public or e.visibility = VisibilityKind::private)")

(def-mm-operation "allApplicableStereotypes" |Package| 
   "The query allApplicableStereotypes() returns all the directly or indirectly
    owned stereotypes, including stereotypes contained in sub-profiles."
   :operation-body
   "let ownedPackages : Bag(Package) = ownedMember->select(oclIsKindOf(Package))->collect(oclAsType(Package)) in  ownedStereotype->union(ownedPackages.allApplicableStereotypes())->flatten()->asSet() "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

(def-mm-operation "containingProfile" |Package| 
   "The query containingProfile() returns the closest profile directly or indirectly
    containing this package (or this package itself, if it is a profile)."
   :operation-body
   "if self.oclIsKindOf(Profile) then   self.oclAsType(Profile) else  self.namespace.oclAsType(Package).containingProfile() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-mm-operation "makesVisible" |Package| 
   "The query makesVisible() defines whether a Package makes an element visible
    outside itself. Elements with no visibility and elements with public visibility
    are made visible."
   :operation-body
   "ownedMember->includes(el) or (elementImport->select(ei|ei.importedElement = VisibilityKind::public)->collect(importedElement.oclAsType(NamedElement))->includes(el)) or (packageImport->select(visibility = VisibilityKind::public)->collect(importedPackage.member->includes(el))->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|el| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "mustBeOwned" |Package| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "nestedPackage.1" |Package| 
   "Missing derivation for Package::/nestedPackage : Package"
   :operation-body
   "packagedElement->select(oclIsKindOf(Package))->collect(oclAsType(Package))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-mm-operation "ownedStereotype.1" |Package| 
   "Missing derivation for Package::/ownedStereotype : Stereotype"
   :operation-body
   "packagedElement->select(oclIsKindOf(Stereotype))->collect(oclAsType(Stereotype))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

(def-mm-operation "ownedType.1" |Package| 
   "Missing derivation for Package::/ownedType : Type"
   :operation-body
   "packagedElement->select(oclIsKindOf(Type))->collect(oclAsType(Type))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-mm-operation "visibleMembers" |Package| 
   "The query visibleMembers() defines which members of a Package can be accessed
    outside it."
   :operation-body
   "member->select( m | m.oclIsKindOf(PackageableElement) and self.makesVisible(m))->collect(oclAsType(PackageableElement))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== PackageImport
;;; =========================================================
(def-mm-class |PackageImport| :UML25 (|DirectedRelationship|)
 "A package import is a relationship that allows the use of unqualified names
  to refer to package members from other namespaces."
  ((|importedPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|Package| |packageImport|)
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
   "visibility = VisibilityKind::public or visibility = VisibilityKind::private")

;;; =========================================================
;;; ====================== PackageMerge
;;; =========================================================
(def-mm-class |PackageMerge| :UML25 (|DirectedRelationship|)
 "A package merge defines how the contents of one package are extended by
  the contents of another package."
  ((|mergedPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|Package| |packageMerge|)
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
(def-mm-class |PackageableElement| :UML25 (|ParameterableElement| |NamedElement|)
 "A packageable element indicates a named element that may be owned directly
  by a package. Packageable elements are able to serve as a template parameter."
  ((|visibility| :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Indicates that packageable elements must always have a visibility, i.e.,
      visibility is not optional." :redefined-property (|NamedElement| |visibility|))))


;;; =========================================================
;;; ====================== Parameter
;;; =========================================================
(def-mm-class |Parameter| :UML25 (|MultiplicityElement| |ConnectableElement|)
 "A Parameter is a specification of an argument used to pass information
  into or out of an invocation of a BehavioralFeature.  Parameters can be
  treated as ConnectableElements within Collaborations."
  ((|default| :range |String| :multiplicity (0 1) :is-derived-p T
    :documentation
     "A String that represents a value to be used when no argument is supplied
      for the Parameter.")
   (|defaultValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningParameter|)
    :documentation
     "Specifies a ValueSpecification that represents a value to be used when
      no argument is supplied for the Parameter.")
   (|direction| :range |ParameterDirectionKind| :multiplicity (1 1) :default :in
    :documentation
     "Indicates whether a parameter is being sent into or out of a behavioral
      element.")
   (|effect| :range |ParameterEffectKind| :multiplicity (0 1)
    :documentation
     "Specifies the effect that the owner of the parameter has on values passed
      in or out of the parameter.")
   (|isException| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an output parameter may emit a value to the exclusion of
      the other outputs.")
   (|isStream| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an input parameter may accept values while its behavior is
      executing, or whether an output parameter may post values while the behavior
      is executing.")
   (|operation| :range |Operation| :multiplicity (0 1)
    :opposite (|Operation| |ownedParameter|)
    :documentation
     "The Operation owning this parameter.")
   (|parameterSet| :range |ParameterSet| :multiplicity (0 -1)
    :opposite (|ParameterSet| |parameter|)
    :documentation
     "The ParameterSets containing the parameter. See ParameterSet.")))


(def-mm-constraint "connector_end" |Parameter| 
   "A Parameter may only be associated with a Connector end within the context
    of a Collaboration."
   :operation-body
   "end->notEmpty() implies collaboration->notEmpty()")

(def-mm-constraint "in_and_out" |Parameter| 
   "Only in and inout Parameters may have a delete effect. Only out, inout,
    and return Parameters may have a create effect."
   :operation-body
   "(effect = ParameterEffectKind::delete implies (direction = ParameterDirectionKind::_'in' or direction = ParameterDirectionKind::inout)) and (effect = ParameterEffectKind::create implies (direction = ParameterDirectionKind::out or direction = ParameterDirectionKind::inout or direction = ParameterDirectionKind::return))")

(def-mm-constraint "not_exception" |Parameter| 
   "An input Parameter cannot be an exception."
   :operation-body
   "isException implies (direction <> ParameterDirectionKind::_'in' and direction <> ParameterDirectionKind::inout)")

(def-mm-constraint "reentrant_behaviors" |Parameter| 
   "Reentrant behaviors cannot have stream Parameters."
   :operation-body
   "(isStream and behavior <> null) implies not behavior.isReentrant")

(def-mm-constraint "stream_and_exception" |Parameter| 
   "A Parameter cannot be a stream and exception at the same time."
   :operation-body
   "not (isException and isStream)")

(def-mm-operation "default.1" |Parameter| 
   "Missing derivation for Parameter::/default : String"
   :operation-body
   "if self.type = String then defaultValue.stringValue() else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ParameterSet
;;; =========================================================
(def-mm-class |ParameterSet| :UML25 (|NamedElement|)
 "A ParameterSet designates alternative sets of inputs or outputs that a
  Behavior may use."
  ((|condition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Constraint| |parameterSet|)
    :documentation
     "A constraint that should be satisfied for the owner of the Parameters in
      an input ParameterSet to start execution using the values provided for
      those Parameters, or the owner of the Parameters in an output ParameterSet
      to end execution providing the values for those Parameters, if all preconditions
      and conditions on input ParameterSets were satisfied.")
   (|parameter| :range |Parameter| :multiplicity (1 -1)
    :opposite (|Parameter| |parameterSet|)
    :documentation
     "Parameters in the ParameterSet.")))


(def-mm-constraint "input" |ParameterSet| 
   "If a Behavior has input Parameters that are in a ParameterSet, then any
    inputs that are not in a ParameterSet must be streaming. Same for output
    Parameters."
   :operation-body
   "(parameter->exists(direction = ParameterDirectionKind::_'in' and behavior <> null) implies    parameter->any(true).behavior.ownedParameter->forAll(p | p.parameterSet->isEmpty() implies p.direction = ParameterDirectionKind::_'in'))     and (parameter->exists(direction = ParameterDirectionKind::out and behavior <> null) implies      parameter->any(true).behavior.ownedParameter->forAll(p | p.parameterSet->isEmpty() implies p.direction = ParameterDirectionKind::out))")

(def-mm-constraint "same_parameterized_entity" |ParameterSet| 
   "The Parameters in a ParameterSet must all be inputs or all be outputs of
    the same parameterized entity, and the ParameterSet is owned by that entity."
   :operation-body
   "parameter->forAll(p1, p2 | self.owner = p1.owner and self.owner = p2.owner and p1.direction = p2.direction)")

(def-mm-constraint "two_parameter_sets" |ParameterSet| 
   "Two ParameterSets cannot have exactly the same set of Parameters."
   :operation-body
   "parameter->forAll(parameterSet->forAll(s1, s2 | s1->size() = s2->size() implies s1.parameter->exists(p | not s2.parameter->includes(p))))")

;;; =========================================================
;;; ====================== ParameterableElement
;;; =========================================================
(def-mm-class |ParameterableElement| :UML25 (|Element|)
 "A parameterable element is an element that can be exposed as a formal template
  parameter for a template, or specified as an actual parameter in a binding
  of a template."
  ((|owningTemplateParameter| :range |TemplateParameter| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|) (|ParameterableElement| |templateParameter|))
    :opposite (|TemplateParameter| |ownedParameteredElement|)
    :documentation
     "The formal template parameter that owns this element.")
   (|templateParameter| :range |TemplateParameter| :multiplicity (0 1)
    :opposite (|TemplateParameter| |parameteredElement|)
    :documentation
     "The template parameter that exposes this element as a formal parameter.")))


(def-mm-operation "isCompatibleWith" |ParameterableElement| 
   "The query isCompatibleWith() determines if this parameterable element is
    compatible with the specified parameterable element. By default parameterable
    element P is compatible with parameterable element Q if the kind of P is
    the same or a subtype as the kind of Q. Subclasses should override this
    operation to specify different compatibility constraints."
   :operation-body
   "p->oclIsKindOf(self.oclType())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isTemplateParameter" |ParameterableElement| 
   "The query isTemplateParameter() determines if this parameterable element
    is exposed as a formal template parameter."
   :operation-body
   "templateParameter->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== PartDecomposition
;;; =========================================================
(def-mm-class |PartDecomposition| :UML25 (|InteractionUse|)
 "A PartDecomposition is a description of the internal Interactions of one
  Lifeline relative to an Interaction."
  ())


(def-mm-constraint "assume" |PartDecomposition| 
   "Assume that within Interaction X, Lifeline L is of class C and decomposed
    to D. Within X there is a sequence of constructs along L (such constructs
    are CombinedFragments, InteractionUse and (plain) OccurrenceSpecifications).
    Then a corresponding sequence of constructs must appear within D, matched
    one-to-one in the same order. i) CombinedFragment covering L are matched
    with an extra-global CombinedFragment in D ii) An InteractionUse covering
    L are matched with a global (i.e. covering all Lifelines) InteractionUse
    in D. iii) A plain OccurrenceSpecification on L is considered an actualGate
    that must be matched by a formalGate of D"
   :operation-body
   "true")

(def-mm-constraint "commutativity_of_decomposition" |PartDecomposition| 
   "Assume that within Interaction X, Lifeline L is of class C and decomposed
    to D. Assume also that there is within X an InteractionUse (say) U that
    covers L. According to the constraint above U will have a counterpart CU
    within D. Within the Interaction referenced by U, L should also be decomposed,
    and the decomposition should reference CU. (This rule is called commutativity
    of decomposition)"
   :operation-body
   "true")

(def-mm-constraint "parts_of_internal_structures" |PartDecomposition| 
   "PartDecompositions apply only to Parts that are Parts of Internal Structures
    not to Parts of Collaborations."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Pin
;;; =========================================================
(def-mm-class |Pin| :UML25 (|ObjectNode| |MultiplicityElement|)
 "A pin is an object node for inputs and outputs to actions. A pin is a typed
  element and multiplicity element that provides values to actions and accept
  result values from them."
  ((|isControl| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the pins provide data to the actions, or just controls when
      it executes it.")))


(def-mm-constraint "control_pins" |Pin| 
   "Control pins have a control type"
   :operation-body
   "isControl implies isControlType")

;;; =========================================================
;;; ====================== Port
;;; =========================================================
(def-mm-class |Port| :UML25 (|Property|)
 "A Port is a property of an EncapsulatedClassifier that specifies a distinct
  interaction point between that EncapsulatedClassifier and its environment
  or between the (behavior of the) EncapsulatedClassifier and its internal
  parts. Ports are connected to Properties of the EncapsulatedClassifier
  by Connectors through which requests can be made to invoke BehavioralFeatures.
  A Port may specify the services an EncapsulatedClassifier provides (offers)
  to its environment as well as the services that an EncapsulatedClassifier
  expects (requires) of its environment.  A Port may have an associated ProtocolStateMachine."
  ((|isBehavior| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether requests arriving at this Port are sent to the classifier
      behavior of this EncapsulatedClassifier. Such a Port is referred to as
      a behavior Port. Any invocation of a BehavioralFeature targeted at a behavior
      Port will be handled by the instance of the owning EncapsulatedClassifier
      itself, rather than by any instances that it may contain.")
   (|isConjugated| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies the way that the provided and required Interfaces are derived
      from the Port s Type.")
   (|isService| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true indicates that this Port is used to provide the published functionality
      of an EncapsulatedClassifier.  If false, this Port is used to implement
      the EncapsulatedClassifier but is not part of the essential externally-visible
      functionality of the EncapsulatedClassifier and can, therefore, be altered
      or deleted along with the internal implementation of the EncapsulatedClassifier
      and other properties that are considered part of its implementation.")
   (|protocol| :range |ProtocolStateMachine| :multiplicity (0 1) :soft-opposite (|ProtocolStateMachine| |port|)
    :documentation
     "An optional ProtocolStateMachine which describes valid interactions at
      this interaction point.")
   (|provided| :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Interface| |port|)
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
   (|redefinedPort| :range |Port| :multiplicity (0 -1)
    :subsetted-properties ((|Property| |redefinedProperty|)) :soft-opposite (|Port| |port|)
    :documentation
     "A Port may be redefined when its containing EncapsulatedClassifier is specialized.
      The redefining Port may have additional Interfaces to those that are associated
      with the redefined Port or it may replace an Interface by one of its subtypes.")
   (|required| :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Interface| |port|)
    :documentation
     "The Interfaces specifying the set of Operations and Receptions that the
      EncapsulatedCassifier expects its environment to handle via this port.
      This association is derived according to the value of isConjugated. If
      isConjugated is false, required is derived as the union of the sets of
      Interfaces used by the type of the Port and its supertypes. If isConjugated
      is true, it is derived as the union of the sets of Interfaces realized
      by the type of the Port and its supertypes, or directly from the type of
      the Port if the Port is typed by an Interface.")))


(def-mm-constraint "default_value" |Port| 
   "A defaultValue for port cannot be specified when the type of the Port is
    an Interface"
   :operation-body
   "type.oclIsKindOf(Interface) implies defaultValue->isEmpty()")

(def-mm-constraint "encapsulated_owner" |Port| 
   "All Ports are owned by an EncapsulatedClassifier"
   :operation-body
   "owner = encapsulatedClassifier")

(def-mm-constraint "port_aggregation" |Port| 
   "Port.aggregation must be composite."
   :operation-body
   "aggregation = AggregationKind::composite")

(def-mm-operation "basicProvided" |Port| 
   "The union of the sets of Interfaces realized by the type of the Port and
    its supertypes, or directly the type of the Port if the Port is typed by
    an Interface."
   :operation-body
   "if type.oclIsKindOf(Interface)  then type.oclAsType(Interface)->asSet()  else type.oclAsType(Classifier).allRealizedInterfaces()  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "basicRequired" |Port| 
   "The union of the sets of Interfaces used by the type of the Port and its
    supertypes."
   :operation-body
   " type.oclAsType(Classifier).allUsedInterfaces() "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "provided.1" |Port| 
   "Derivation for Port::/provided"
   :operation-body
   "if isConjugated then basicRequired() else basicProvided() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-mm-operation "required.1" |Port| 
   "Derivation for Port::/required"
   :operation-body
   "if isConjugated then basicProvided() else basicRequired() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== PrimitiveType
;;; =========================================================
(def-mm-class |PrimitiveType| :UML25 (|DataType|)
 "A PrimitiveType defines a predefined DataType, without any substructure.
  A PrimitiveType may have an algebra and operations defined outside of UML,
  for example, mathematically."
  ())


;;; =========================================================
;;; ====================== Profile
;;; =========================================================
(def-mm-class |Profile| :UML25 (|Package|)
 "A profile defines limited extensions to a reference metamodel with the
  purpose of adapting the metamodel to a specific platform or domain."
  ((|metaclassReference| :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |elementImport|)) :soft-opposite (|ElementImport| |profile|)
    :documentation
     "References a metaclass that may be extended.")
   (|metamodelReference| :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |packageImport|)) :soft-opposite (|PackageImport| |profile|)
    :documentation
     "References a package containing (directly or indirectly) metaclasses that
      may be extended.")))


(def-mm-constraint "metaclass_reference_not_specialized" |Profile| 
   "An element imported as a metaclassReference is not specialized or generalized
    in a Profile."
   :operation-body
   "metaclassReference.importedElement->  select(c | c.oclIsKindOf(Classifier) and   (c.oclAsType(Classifier).allParents()->collect(namespace)->includes(self)))->isEmpty() and  packagedElement->     select(oclIsKindOf(Classifier))->collect(oclAsType(Classifier).allParents())->        intersection(metaclassReference.importedElement->select(oclIsKindOf(Classifier))->collect(oclAsType(Classifier)))->isEmpty()")

(def-mm-constraint "references_same_metamodel" |Profile| 
   "All elements imported either as metaclassReferences or through metamodelReferences
    are members of the same base reference metamodel."
   :operation-body
   "metamodelReference.importedPackage.elementImport.importedElement.allOwningPackages()->   union(metaclassReference.importedElement.allOwningPackages() )->notEmpty()")

;;; =========================================================
;;; ====================== ProfileApplication
;;; =========================================================
(def-mm-class |ProfileApplication| :UML25 (|DirectedRelationship|)
 "A profile application is used to show which profiles have been applied
  to a package."
  ((|appliedProfile| :range |Profile| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|Profile| |profileApplication|)
    :documentation
     "References the Profiles that are applied to a Package through this ProfileApplication.")
   (|applyingPackage| :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Package| |profileApplication|)
    :documentation
     "The package that owns the profile application.")
   (|isStrict| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies that the Profile filtering rules for the metaclasses of the referenced
      metamodel shall be strictly applied.")))


;;; =========================================================
;;; ====================== Property
;;; =========================================================
(def-mm-class |Property| :UML25 (|ConnectableElement| |DeploymentTarget| |StructuralFeature|)
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
  ((|aggregation| :range |AggregationKind| :multiplicity (1 1) :default :none
    :documentation
     "Specifies the kind of aggregation that applies to the Property.")
   (|association| :range |Association| :multiplicity (0 1)
    :opposite (|Association| |memberEnd|)
    :documentation
     "The Association of which this Property is a member, if any.")
   (|associationEnd| :range |Property| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Property| |qualifier|)
    :documentation
     "Designates the optional association end that owns a qualifier attribute.")
   (|class| :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Class| |ownedAttribute|)
    :documentation
     "The Class that owns this Property, if any.")
   (|datatype| :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|DataType| |ownedAttribute|)
    :documentation
     "The DataType that owns this Property, if any.")
   (|default| :range |String| :multiplicity (0 1) :is-derived-p T
    :documentation
     "A String that is evaluated to give a default value for the Property when
      an object of the owning Classifier is instantiated.")
   (|defaultValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningProperty|)
    :documentation
     "A ValueSpecification that is evaluated to give a default value for the
      Property when an object of the owning Classifier is instantiated.")
   (|interface| :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interface| |ownedAttribute|)
    :documentation
     "The Interface that owns this Property, if any.")
   (|isComposite| :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "If isComposite is true, the object containing the attribute is a container
      for the object or value contained in the attribute. This is a derived value,
      indicating whether the aggregation of the Property is composite or not.")
   (|isDerived| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the Property is derived, i.e., whether its value or values
      can be computed from other information.")
   (|isDerivedUnion| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the property is derived as the union of all of the Properties
      that are constrained to subset it.")
   (|isID| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True indicates this property can be used to uniquely identify an instance
      of the containing Class.")
   (|isReadOnly| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isReadOnly is true, the Property may not be written to after initialization." :redefined-property (|StructuralFeature| |isReadOnly|))
   (|opposite| :range |Property| :multiplicity (0 1) :is-derived-p T :soft-opposite (|Property| |property|)
    :documentation
     "In the case where the Property is one end of a binary association this
      gives the other end.")
   (|owningAssociation| :range |Association| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|Property| |association|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Association| |ownedEnd|)
    :documentation
     "The owning association of this property, if any.")
   (|qualifier| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Property| |associationEnd|)
    :documentation
     "An optional list of ordered qualifier attributes for the end.")
   (|redefinedProperty| :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Property| |property|)
    :documentation
     "The properties that are redefined by this property, if any.")
   (|subsettedProperty| :range |Property| :multiplicity (0 -1) :soft-opposite (|Property| |property|)
    :documentation
     "The properties of which this Property is constrained to be a subset, if
      any.")))


(def-mm-constraint "binding_to_attribute" |Property| 
   "A binding of a PropertyTemplateParameter representing an attribute must
    be to an attribute."
   :operation-body
   "(isAttribute(self) and (templateParameterSubstitution->notEmpty())   implies (templateParameterSubstitution->forAll(ts | ts.formal.oclIsKindOf(Property) and isAttribute(ts.formal.oclAsType(Property)))))")

(def-mm-constraint "deployment_target" |Property| 
   "A Property can be a DeploymentTarget if it is a kind of Node and functions
    as a part in the internal structure of an encompassing Node."
   :operation-body
   "deployment->notEmpty() implies owner.oclIsKindOf(Node) and Node.allInstances()->exists(n | n.part->exists(p | p = self))")

(def-mm-constraint "derived_union_is_derived" |Property| 
   "A derived union is derived."
   :operation-body
   "isDerivedUnion implies isDerived")

(def-mm-constraint "derived_union_is_read_only" |Property| 
   "A derived union is read only."
   :operation-body
   "isDerivedUnion implies isReadOnly")

(def-mm-constraint "multiplicity_of_composite" |Property| 
   "A multiplicity on the composing end of a composite aggregation must not
    have an upper bound greater than 1."
   :operation-body
   "isComposite and association <> null implies opposite.upperBound() <= 1  ")

(def-mm-constraint "redefined_property_inherited" |Property| 
   "A redefined Property must be inherited from a more general Classifier."
   :operation-body
   "(redefinedProperty->notEmpty()) implies   (redefinitionContext->notEmpty() and       redefinedProperty->forAll(rp|         ((redefinitionContext->collect(fc|           fc.allParents()))->asSet())->collect(c| c.allFeatures())->asSet()->includes(rp)))")

(def-mm-constraint "subsetted_property_names" |Property| 
   "A Property may not subset a Property with the same name."
   :operation-body
   "subsettedProperty->forAll(sp | sp.name <> name)")

(def-mm-constraint "subsetting_context_conforms" |Property| 
   "Subsetting may only occur when the context of the subsetting property conforms
    to the context of the subsetted property."
   :operation-body
   "subsettedProperty->notEmpty() implies   (subsettingContext()->notEmpty() and subsettingContext()->forAll (sc |     subsettedProperty->forAll(sp |       sp.subsettingContext()->exists(c | sc.conformsTo(c)))))")

(def-mm-constraint "subsetting_rules" |Property| 
   "A subsetting Property may strengthen the type of the subsetted Property,
    and its upper bound may be less."
   :operation-body
   "subsettedProperty->forAll(sp |   self.type.conformsTo(sp.type) and     ((self.upperBound()->notEmpty() and sp.upperBound()->notEmpty()) implies       self.upperBound() <= sp.upperBound() ))")

(def-mm-operation "default.1" |Property| 
   "Missing derivation for Property::/default : String"
   :operation-body
   "if self.type = String then defaultValue.stringValue() else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-mm-operation "isAttribute" |Property| 
   "The query isAttribute() is true if the Property is defined as an attribute
    of some Classifier."
   :operation-body
   "Classifier.allInstances()->exists(c | c.attribute->includes(p))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|Property|
                        :parameter-return-p NIL))
)

(def-mm-operation "isCompatibleWith" |Property| 
   "The query isCompatibleWith() determines if this Property is compatible
    with the specified ParameterableElement. By default ParameterableElement
    P is compatible with ParameterableElement Q if the kind of P is the same
    or a subtype as the kind of Q. In addition, for Properties, the type must
    be conformant with the type of the specified ParameterableElement."
   :operation-body
   "p.oclIsKindOf(self.oclType()) and self.type.conformsTo(p.oclAsType(Property).type)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isComposite.1" |Property| 
   "The value of isComposite is true only if aggregation is composite."
   :operation-body
   "aggregation = AggregationKind::composite"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isConsistentWith" |Property| 
   "The query isConsistentWith() specifies, for any two Properties in a context
    in which redefinition is possible, whether redefinition would be logically
    consistent. A redefining Property is consistent with a redefined Property
    if the type of the redefining Property conforms to the type of the redefined
    Property, and the multiplicity of the redefining Property (if specified)
    is contained in the multiplicity of the redefined Property."
   :operation-body
   "redefinee.oclIsKindOf(Property) and    let prop : Property = redefinee.oclAsType(Property) in    (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and    ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and    (self.isComposite implies prop.isComposite))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isNavigable" |Property| 
   "The query isNavigable() indicates whether it is possible to navigate across
    the property."
   :operation-body
   "not classifier->isEmpty() or association.navigableOwnedEnd->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "opposite.1" |Property| 
   "If this property is a memberEnd of a binary association then opposite gives
    the other end."
   :operation-body
   "if association <> null and association.memberEnd->size() = 2 then     association.memberEnd->any(e | e <> self) else     null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-mm-operation "subsettingContext" |Property| 
   "The query subsettingContext() gives the context for subsetting a Property.
    It consists, in the case of an attribute, of the corresponding Classifier,
    and in the case of an association end, all of the Classifiers at the other
    ends."
   :operation-body
   "if association <> null then association.endType->excluding(type) else    if classifier<>null   then classifier->asSet()   else Set{}    endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ProtocolConformance
;;; =========================================================
(def-mm-class |ProtocolConformance| :UML25 (|DirectedRelationship|)
 "A ProtocolStateMachine can be redefined into a more specific ProtocolStateMachine
  or into behavioral StateMachine. ProtocolConformance declares that the
  specific ProtocolStateMachine specifies a protocol that conforms to the
  general ProtocolStateMachine or that the specific behavioral StateMachine
  abides by the protocol of the general ProtocolStateMachine."
  ((|generalMachine| :range |ProtocolStateMachine| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|ProtocolStateMachine| |protocolConformance|)
    :documentation
     "Specifies the protocol state machine to which the specific state machine
      conforms.")
   (|specificMachine| :range |ProtocolStateMachine| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|ProtocolStateMachine| |conformance|)
    :documentation
     "Specifies the state machine which conforms to the general state machine.")))


;;; =========================================================
;;; ====================== ProtocolStateMachine
;;; =========================================================
(def-mm-class |ProtocolStateMachine| :UML25 (|StateMachine|)
 "A ProtocolStateMachine is always defined in the context of a Classifier.
  It specifies which BehavioralFeatures of the Classifier can be called in
  which State and under which conditions, thus specifying the allowed invocation
  sequences on the Classifier's Behavioralfeatures. A ProtocolStateMachine
  specifies the possible and permitted transitions on the instances of its
  context Classifier, together with the BehavioralFeatures that carry the
  transitions. In this manner, an instance lifecycle can be specified for
  a Classifier, by defining the order in which the BehavioralFeatures can
  be activated and the States through which an instance progresses during
  its existence."
  ((|conformance| :range |ProtocolConformance| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ProtocolConformance| |specificMachine|)
    :documentation
     "Conformance between protocol state machines.")))


(def-mm-constraint "classifier_context" |ProtocolStateMachine| 
   "A protocol state machine must only have a classifier context, not a behavioral
    feature context."
   :operation-body
   "_'context' <> null and specification = null")

(def-mm-constraint "deep_or_shallow_history" |ProtocolStateMachine| 
   "Protocol state machines cannot have deep or shallow history pseudostates."
   :operation-body
   "region->forAll (r | r.subvertex->forAll (v | v.oclIsKindOf(Pseudostate) implies ((v.oclAsType(Pseudostate).kind <>  PseudostateKind::deepHistory) and (v.oclAsType(Pseudostate).kind <> PseudostateKind::shallowHistory)))) ")

(def-mm-constraint "entry_exit_do" |ProtocolStateMachine| 
   "The states of a protocol state machine cannot have entry, exit, or do activity
    actions."
   :operation-body
   "region->forAll(r | r.subvertex->forAll(v | v.oclIsKindOf(State) implies (v.oclAsType(State).entry->isEmpty() and v.oclAsType(State).exit->isEmpty() and v.oclAsType(State).doActivity->isEmpty()))) ")

(def-mm-constraint "ports_connected" |ProtocolStateMachine| 
   "If two ports are connected, then the protocol state machine of the required
    interface (if defined) must be conformant to the protocol state machine
    of the provided interface (if defined)."
   :operation-body
   "true")

(def-mm-constraint "protocol_transitions" |ProtocolStateMachine| 
   "All transitions of a protocol state machine must be protocol transitions.
    (transitions as extended by the ProtocolStateMachines package)"
   :operation-body
   "region->forAll(r | r.transition->forAll(t | t.oclIsTypeOf(ProtocolTransition)))")

;;; =========================================================
;;; ====================== ProtocolTransition
;;; =========================================================
(def-mm-class |ProtocolTransition| :UML25 (|Transition|)
 "A ProtocolTransition specifies a legal transition for an operation. Transitions
  of ProtocolStateMachines have the following information: a pre-condition
  (guard), a Trigger, and a post-condition. Every ProtocolTransition is associated
  with at most one BehavioralFeature belonging to the context Classifier
  of the ProtocolStateMachine."
  ((|postCondition| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |owningTransition|)
    :documentation
     "Specifies the post condition of the transition which is the condition that
      should be obtained once the transition is triggered. This post condition
      is part of the post condition of the operation connected to the transition.")
   (|preCondition| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Transition| |guard|)) :soft-opposite (|Constraint| |protocolTransition|)
    :documentation
     "Specifies the precondition of the transition. It specifies the condition
      that should be verified before triggering the transition. This guard condition
      added to the source state will be evaluated as part of the precondition
      of the operation referred by the transition if any.")
   (|referred| :range |Operation| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Operation| |protocolTransition|)
    :documentation
     "This association refers to the associated operation. It is derived from
      the operation of the call trigger when applicable.")))


(def-mm-constraint "associated_actions" |ProtocolTransition| 
   "A protocol transition never has associated actions."
   :operation-body
   "effect = null")

(def-mm-constraint "belongs_to_psm" |ProtocolTransition| 
   "A protocol transition always belongs to a protocol state machine."
   :operation-body
   "container.belongsToPSM()")

(def-mm-constraint "refers_to_operation" |ProtocolTransition| 
   "If a protocol transition refers to an operation (i. e. has a call trigger
    corresponding to an operation), then that operation should apply to the
    context classifier of the state machine of the protocol transition."
   :operation-body
   "true")

(def-mm-operation "referred.1" |ProtocolTransition| 
   "Missing derivation for ProtocolTransition::/referred : Operation"
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Operation|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Pseudostate
;;; =========================================================
(def-mm-class |Pseudostate| :UML25 (|Vertex|)
 "A Pseudostate is an abstraction that encompasses different types of transient
  Verticies in the StateMachine graph. A StateMachine instance never comes
  to rest in a Pseudostate, instead, it will exit and enter the Pseudostate
  within a single run-to-completion step."
  ((|kind| :range |PseudostateKind| :multiplicity (1 1) :default :initial
    :documentation
     "Determines the precise type of the Pseudostate and can be one of: entryPoint,
      exitPoint, initial, deepHistory, shallowHistory, join, fork, junction,
      terminate or choice.")
   (|state| :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |connectionPoint|)
    :documentation
     "The State that owns this pseudostate and in which it appears.")
   (|stateMachine| :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |connectionPoint|)
    :documentation
     "The StateMachine in which this Pseudostate is defined. This only applies
      to Pseudostates of the kind entryPoint or exitPoint.")))


(def-mm-constraint "choice_vertex" |Pseudostate| 
   "In a complete statemachine, a choice vertex must have at least one incoming
    and one outgoing transition."
   :operation-body
   "(kind = PseudostateKind::choice) implies (incoming->size() >= 1 and outgoing->size() >= 1) ")

(def-mm-constraint "fork_vertex" |Pseudostate| 
   "In a complete statemachine, a fork vertex must have at least two outgoing
    transitions and exactly one incoming transition."
   :operation-body
   "(kind = PseudostateKind::fork) implies (incoming->size() = 1 and outgoing->size() >= 2) ")

(def-mm-constraint "history_vertices" |Pseudostate| 
   "History vertices can have at most one outgoing transition."
   :operation-body
   "((kind = PseudostateKind::deepHistory) or (kind = PseudostateKind::shallowHistory)) implies (outgoing->size() <= 1) ")

(def-mm-constraint "initial_vertex" |Pseudostate| 
   "An initial vertex can have at most one outgoing transition."
   :operation-body
   "(kind = PseudostateKind::initial) implies (outgoing->size() <= 1)")

(def-mm-constraint "join_vertex" |Pseudostate| 
   "In a complete statemachine, a join vertex must have at least two incoming
    transitions and exactly one outgoing transition."
   :operation-body
   "(kind = PseudostateKind::join) implies (outgoing->size() = 1 and incoming->size() >= 2) ")

(def-mm-constraint "junction_vertex" |Pseudostate| 
   "In a complete statemachine, a junction vertex must have at least one incoming
    and one outgoing transition."
   :operation-body
   "(kind = PseudostateKind::junction) implies (incoming->size() >= 1 and outgoing->size() >= 1) ")

(def-mm-constraint "outgoing_from_initial" |Pseudostate| 
   "The outgoing transition from and initial vertex may have a behavior, but
    not a trigger or a guard."
   :operation-body
   "(kind = PseudostateKind::initial) implies (outgoing.guard = null and outgoing.trigger->isEmpty())")

(def-mm-constraint "transitions_incoming" |Pseudostate| 
   "All transitions incoming a join vertex must originate in different regions
    of an orthogonal state."
   :operation-body
   "--(kind = PseudostateKind::join) implies --  incoming->forAll (t1, t2 | t1<>t2 implies --    (stateMachine.LCA(t1.source, t2.source).container.isOrthogonal))  -- This is incorrectly typed. LCA returns a Namespace, so container is not valid.  -- container is valid on Vertex and Transition, but these are different properties -- The only thing that understands isOrthogonal is State -- This logic appears to bear little resemblance to what the description says  true          ")

(def-mm-constraint "transitions_outgoing" |Pseudostate| 
   "All transitions outgoing a fork vertex must target states in different
    regions of an orthogonal state."
   :operation-body
   "--(kind = PseudostateKind::fork) implies --  outgoing->forAll (t1, t2 | t1<>t2 implies --    (stateMachine.LCA(t1.target, t2.target).container.isOrthogonal))      -- This is incorrectly typed. LCA returns a Namespace, so container is not valid.  -- container is valid on Vertex and Transition, but these are different properties -- The only thing that understands isOrthogonal is State -- This logic appears to bear little resemblance to what the description says  true")

;;; =========================================================
;;; ====================== QualifierValue
;;; =========================================================
(def-mm-class |QualifierValue| :UML25 (|Element|)
 "A qualifier value is not an action. It is an element that identifies links.
  It gives a single qualifier within a link end data specification."
  ((|qualifier| :range |Property| :multiplicity (1 1) :soft-opposite (|Property| |qualifierValue|)
    :documentation
     "Attribute representing the qualifier for which the value is to be specified.")
   (|value| :range |InputPin| :multiplicity (1 1) :soft-opposite (|InputPin| |qualifierValue|)
    :documentation
     "Input pin from which the specified value for the qualifier is taken.")))


(def-mm-constraint "multiplicity_of_qualifier" |QualifierValue| 
   "The multiplicity of the qualifier value input pin is \"1..1\"."
   :operation-body
   "self.value.is(1,1)")

(def-mm-constraint "qualifier_attribute" |QualifierValue| 
   "The qualifier attribute must be a qualifier of the association end of the
    link-end data."
   :operation-body
   "linkEndData.end->collect(qualifier)->includes(qualifier)")

(def-mm-constraint "type_of_qualifier" |QualifierValue| 
   "The type of the qualifier value input pin is the same as the type of the
    qualifier attribute."
   :operation-body
   "value.type = qualifier.type")

;;; =========================================================
;;; ====================== RaiseExceptionAction
;;; =========================================================
(def-mm-class |RaiseExceptionAction| :UML25 (|Action|)
 "A raise exception action is an action that causes an exception to occur.
  The input value becomes the exception object."
  ((|exception| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |raiseExceptionAction|)
    :documentation
     "An input pin whose value becomes an exception object.")))


;;; =========================================================
;;; ====================== ReadExtentAction
;;; =========================================================
(def-mm-class |ReadExtentAction| :UML25 (|Action|)
 "A read extent action is an action that retrieves the current instances
  of a classifier."
  ((|classifier| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |readExtentAction|)
    :documentation
     "The classifier whose instances are to be retrieved.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readExtentAction|)
    :documentation
     "The runtime instances of the classifier.")))


(def-mm-constraint "multiplicity_of_result" |ReadExtentAction| 
   "The multiplicity of the result output pin is 0..*."
   :operation-body
   "true")

(def-mm-constraint "type_is_classifier" |ReadExtentAction| 
   "The type of the result output pin is the classifier."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ReadIsClassifiedObjectAction
;;; =========================================================
(def-mm-class |ReadIsClassifiedObjectAction| :UML25 (|Action|)
 "A read is classified object action is an action that determines whether
  a runtime object is classified by a given classifier."
  ((|classifier| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |readIsClassifiedObjectAction|)
    :documentation
     "The classifier against which the classification of the input object is
      tested.")
   (|isDirect| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the classifier must directly classify the input object.")
   (|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |readIsClassifiedObjectAction|)
    :documentation
     "Holds the object whose classification is to be tested.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readIsClassifiedObjectAction|)
    :documentation
     "After termination of the action, will hold the result of the test.")))


(def-mm-constraint "boolean_result" |ReadIsClassifiedObjectAction| 
   "The type of the output pin is Boolean"
   :operation-body
   "result.type = Boolean")

(def-mm-constraint "multiplicity_of_input" |ReadIsClassifiedObjectAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "object.is(1,1)")

(def-mm-constraint "multiplicity_of_output" |ReadIsClassifiedObjectAction| 
   "The multiplicity of the output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "no_type" |ReadIsClassifiedObjectAction| 
   "The input pin has no type."
   :operation-body
   "object.type = null")

;;; =========================================================
;;; ====================== ReadLinkAction
;;; =========================================================
(def-mm-class |ReadLinkAction| :UML25 (|LinkAction|)
 "A read link action is a link action that navigates across associations
  to retrieve objects on one end."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readLinkAction|)
    :documentation
     "The pin on which are put the objects participating in the association at
      the end not specified by the inputs.")))


(def-mm-constraint "compatible_multiplicity" |ReadLinkAction| 
   "The multiplicity of the open association end must be compatible with the
    multiplicity of the result output pin."
   :operation-body
   "let openEnd : Property = endData->select(value=null)->asSequence()->first().end in   openEnd.compatibleWith(result) ")

(def-mm-constraint "navigable_open_end" |ReadLinkAction| 
   "The open end must be navigable."
   :operation-body
   "let openEnd : Property = endData->select(value=null)->asSequence()->first().end in   openEnd.isNavigable() ")

(def-mm-constraint "one_open_end" |ReadLinkAction| 
   "Exactly one link-end data specification (the 'open' end) must not have
    an end object input pin."
   :operation-body
   "self.endData->select(value=null )->size() = 1")

(def-mm-constraint "type_and_ordering" |ReadLinkAction| 
   "The type and ordering of the result output pin are same as the type and
    ordering of the open association end."
   :operation-body
   "let openEnd : Property = endData->select(value=null)->asSequence()->first().end in   result.type = openEnd.type   and result.isOrdered = openEnd.isOrdered ")

(def-mm-constraint "visibility" |ReadLinkAction| 
   "Visibility of the open end must allow access to the object performing the
    action."
   :operation-body
   "let host : Classifier = _'context' in   let openEnd : Property = endData->select(value = null)->asSequence()->first().end in     openEnd.visibility = VisibilityKind::public     or endData->exists(oed | not (oed.end = openEnd)       and (host = oed.end.type       or (openEnd.visibility = VisibilityKind::protected       and host.allParents()->includes(oed.end.type.oclAsType(Classifier))))) ")

;;; =========================================================
;;; ====================== ReadLinkObjectEndAction
;;; =========================================================
(def-mm-class |ReadLinkObjectEndAction| :UML25 (|Action|)
 "A read link object end action is an action that retrieves an end object
  from a link object."
  ((|end| :range |Property| :multiplicity (1 1) :soft-opposite (|Property| |readLinkObjectEndAction|)
    :documentation
     "Link end to be read.")
   (|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |readLinkObjectEndAction|)
    :documentation
     "Gives the input pin from which the link object is obtained.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readLinkObjectEndAction|)
    :documentation
     "Pin where the result value is placed.")))


(def-mm-constraint "association_of_association" |ReadLinkObjectEndAction| 
   "The association of the association end must be an association class."
   :operation-body
   "end.association.oclIsKindOf(AssociationClass)")

(def-mm-constraint "ends_of_association" |ReadLinkObjectEndAction| 
   "The ends of the association must not be static."
   :operation-body
   "end.association.memberEnd->forAll(e | not e.isStatic)")

(def-mm-constraint "multiplicity_of_object" |ReadLinkObjectEndAction| 
   "The multiplicity of the object input pin is 1..1."
   :operation-body
   "object.is(1,1)")

(def-mm-constraint "multiplicity_of_result" |ReadLinkObjectEndAction| 
   "The multiplicity of the result output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "property" |ReadLinkObjectEndAction| 
   "The property must be an association end."
   :operation-body
   "end.association <> null")

(def-mm-constraint "type_of_object" |ReadLinkObjectEndAction| 
   "The type of the object input pin is the association class that owns the
    association end."
   :operation-body
   "object.type = end.association")

(def-mm-constraint "type_of_result" |ReadLinkObjectEndAction| 
   "The type of the result output pin is the same as the type of the association
    end."
   :operation-body
   "result.type = end.type")

;;; =========================================================
;;; ====================== ReadLinkObjectEndQualifierAction
;;; =========================================================
(def-mm-class |ReadLinkObjectEndQualifierAction| :UML25 (|Action|)
 "A read link object end qualifier action is an action that retrieves a qualifier
  end value from a link object."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |readLinkObjectEndQualifierAction|)
    :documentation
     "Gives the input pin from which the link object is obtained.")
   (|qualifier| :range |Property| :multiplicity (1 1) :soft-opposite (|Property| |readLinkObjectEndQualifierAction|)
    :documentation
     "The attribute representing the qualifier to be read.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readLinkObjectEndQualifierAction|)
    :documentation
     "Pin where the result value is placed.")))


(def-mm-constraint "association_of_association" |ReadLinkObjectEndQualifierAction| 
   "The association of the association end of the qualifier attribute must
    be an association class."
   :operation-body
   "qualifier.associationEnd.association.oclIsKindOf(AssociationClass)")

(def-mm-constraint "ends_of_association" |ReadLinkObjectEndQualifierAction| 
   "The ends of the association must not be static."
   :operation-body
   "qualifier.associationEnd.association.memberEnd->forAll(e | not e.isStatic)")

(def-mm-constraint "multiplicity_of_object" |ReadLinkObjectEndQualifierAction| 
   "The multiplicity of the object input pin is 1..1."
   :operation-body
   "object.is(1,1)")

(def-mm-constraint "multiplicity_of_qualifier" |ReadLinkObjectEndQualifierAction| 
   "The multiplicity of the qualifier attribute is 1..1."
   :operation-body
   "qualifier.is(1,1)")

(def-mm-constraint "multiplicity_of_result" |ReadLinkObjectEndQualifierAction| 
   "The multiplicity of the result output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "qualifier_attribute" |ReadLinkObjectEndQualifierAction| 
   "The qualifier attribute must be a qualifier attribute of an association
    end."
   :operation-body
   "qualifier.associationEnd <> null")

(def-mm-constraint "same_type" |ReadLinkObjectEndQualifierAction| 
   "The type of the result output pin is the same as the type of the qualifier
    attribute."
   :operation-body
   "result.type = qualifier.type")

(def-mm-constraint "type_of_object" |ReadLinkObjectEndQualifierAction| 
   "The type of the object input pin is the association class that owns the
    association end that has the given qualifier attribute."
   :operation-body
   "object.type = qualifier.associationEnd.association")

;;; =========================================================
;;; ====================== ReadSelfAction
;;; =========================================================
(def-mm-class |ReadSelfAction| :UML25 (|Action|)
 "A read self action is an action that retrieves the host object of an action."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readSelfAction|)
    :documentation
     "Gives the output pin on which the hosting object is placed.")))


(def-mm-constraint "contained" |ReadSelfAction| 
   "The action must be contained in an behavior that has a host classifier."
   :operation-body
   "_'context' <> null")

(def-mm-constraint "multiplicity" |ReadSelfAction| 
   "The multiplicity of the result output pin is 1..1."
   :operation-body
   "result.is(1,1)")

(def-mm-constraint "not_static" |ReadSelfAction| 
   "If the action is contained in an behavior that is acting as the body of
    a method, then the operation of the method must not be static."
   :operation-body
   "true")

(def-mm-constraint "type" |ReadSelfAction| 
   "The type of the result output pin is the host classifier."
   :operation-body
   "result.type = _'context'")

;;; =========================================================
;;; ====================== ReadStructuralFeatureAction
;;; =========================================================
(def-mm-class |ReadStructuralFeatureAction| :UML25 (|StructuralFeatureAction|)
 "A read structural feature action is a structural feature action that retrieves
  the values of a structural feature."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readStructuralFeatureAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "multiplicity" |ReadStructuralFeatureAction| 
   "The multiplicity of the structural feature must be compatible with the
    multiplicity of the output pin."
   :operation-body
   "structuralFeature.compatibleWith(result)")

(def-mm-constraint "type_and_ordering" |ReadStructuralFeatureAction| 
   "The type and ordering of the result output pin are the same as the type
    and ordering of the structural feature."
   :operation-body
   "result.type =structuralFeature.type and result.isOrdered = structuralFeature.isOrdered ")

;;; =========================================================
;;; ====================== ReadVariableAction
;;; =========================================================
(def-mm-class |ReadVariableAction| :UML25 (|VariableAction|)
 "A read variable action is a variable action that retrieves the values of
  a variable."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readVariableAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "compatible_multiplicity" |ReadVariableAction| 
   "The multiplicity of the variable must be compatible with the multiplicity
    of the output pin."
   :operation-body
   "variable.compatibleWith(result)")

(def-mm-constraint "type_and_ordering" |ReadVariableAction| 
   "The type and ordering of the result output pin of a read-variable action
    are the same as the type and ordering of the variable."
   :operation-body
   "result.type =variable.type and result.isOrdered = variable.isOrdered ")

;;; =========================================================
;;; ====================== Realization
;;; =========================================================
(def-mm-class |Realization| :UML25 (|Abstraction|)
 "Realization is a specialized abstraction relationship between two sets
  of model elements, one representing a specification (the supplier) and
  the other represents an implementation of the latter (the client). Realization
  can be used to model stepwise refinement, optimizations, transformations,
  templates, model synthesis, framework composition, etc."
  ())


;;; =========================================================
;;; ====================== Reception
;;; =========================================================
(def-mm-class |Reception| :UML25 (|BehavioralFeature|)
 "A Reception is a declaration stating that a Classifier is prepared to react
  to the receipt of a Signal."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |reception|)
    :documentation
     "The Signal that this Reception handles.")))


;;; =========================================================
;;; ====================== ReclassifyObjectAction
;;; =========================================================
(def-mm-class |ReclassifyObjectAction| :UML25 (|Action|)
 "A reclassify object action is an action that changes which classifiers
  classify an object."
  ((|isReplaceAll| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing classifiers should be removed before adding
      the new classifiers.")
   (|newClassifier| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |reclassifyObjectAction|)
    :documentation
     "A set of classifiers to be added to the classifiers of the object.")
   (|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |reclassifyObjectAction|)
    :documentation
     "Holds the object to be reclassified.")
   (|oldClassifier| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |reclassifyObjectAction|)
    :documentation
     "A set of classifiers to be removed from the classifiers of the object.")))


(def-mm-constraint "classifier_not_abstract" |ReclassifyObjectAction| 
   "None of the new classifiers may be abstract."
   :operation-body
   "not newClassifier->exists(isAbstract)")

(def-mm-constraint "input_pin" |ReclassifyObjectAction| 
   "The input pin has no type."
   :operation-body
   "object.type = null")

(def-mm-constraint "multiplicity" |ReclassifyObjectAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "object.is(1,1)")

;;; =========================================================
;;; ====================== RedefinableElement
;;; =========================================================
(def-mm-class |RedefinableElement| :UML25 (|NamedElement|)
 "A RedefinableElement is an element that, when defined in the context of
  a Classifier, can be redefined more specifically or differently in the
  context of another Classifier that specializes (directly or indirectly)
  the context Classifier."
  ((|isLeaf| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether it is possible to further redefine a RedefinableElement.
      If the value is true, then it is not possible to further redefine the RedefinableElement.")
   (|redefinedElement| :range |RedefinableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T :soft-opposite (|RedefinableElement| |redefinableElement|)
    :documentation
     "The RedefinableElement that is being redefined by this element.")
   (|redefinitionContext| :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T :soft-opposite (|Classifier| |redefinableElement|)
    :documentation
     "The contexts that this element may be redefined from.")))


(def-mm-constraint "non_leaf_redefinition" |RedefinableElement| 
   "A RedefinableElement can only redefine non-leaf RedefinableElements"
   :operation-body
   "redefinedElement->forAll(not isLeaf)")

(def-mm-constraint "redefinition_consistent" |RedefinableElement| 
   "A redefining element must be consistent with each redefined element."
   :operation-body
   "redefinedElement->forAll(isConsistentWith(self))")

(def-mm-constraint "redefinition_context_valid" |RedefinableElement| 
   "At least one of the redefinition contexts of the redefining element must
    be a specialization of at least one of the redefinition contexts for each
    redefined element."
   :operation-body
   "redefinedElement->forAll(e | isRedefinitionContextValid(e))")

(def-mm-operation "isConsistentWith" |RedefinableElement| 
   "The query isConsistentWith() specifies, for any two RedefinableElements
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. By default, this is false; this operation must
    be overridden for subclasses of RedefinableElement to define the consistency
    conditions."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isRedefinitionContextValid" |RedefinableElement| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of this RedefinableElement are properly related to the redefinition
    contexts of the specified RedefinableElement to allow this element to redefine
    the other. By default at least one of the redefinition contexts of this
    element must be a specialization of at least one of the redefinition contexts
    of the specified element."
   :operation-body
   "redefinitionContext->exists(c | c.allParents()->includesAll(redefined.redefinitionContext))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== RedefinableTemplateSignature
;;; =========================================================
(def-mm-class |RedefinableTemplateSignature| :UML25 (|RedefinableElement| |TemplateSignature|)
 "A RedefinableTemplateSignature supports the addition of formal template
  parameters in a specialization of a template classifier."
  ((|classifier| :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|))
    :opposite (|Classifier| |ownedTemplateSignature|)
    :documentation
     "The Classifier that owns this RedefinableTemplateSignature." :redefined-property (|TemplateSignature| |template|))
   (|extendedSignature| :range |RedefinableTemplateSignature| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|RedefinableTemplateSignature| |redefinableTemplateSignature|)
    :documentation
     "The RedefinableTemplateSignature that is extended by this RedefinableTemplateSignature.")
   (|inheritedParameter| :range |TemplateParameter| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|TemplateSignature| |parameter|)) :soft-opposite (|TemplateParameter| |redefinableTemplateSignature|)
    :documentation
     "The formal template parameters of the extended signature.")))


(def-mm-operation "inheritedParameter.1" |RedefinableTemplateSignature| 
   "Missing derivation for RedefinableTemplateSignature::/inheritedParameter
    : TemplateParameter"
   :operation-body
   "if extendedSignature->isEmpty() then Set{} else extendedSignature.parameter->asSet() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|TemplateParameter|
                        :parameter-return-p T))
)

(def-mm-operation "isConsistentWith" |RedefinableTemplateSignature| 
   "The query isConsistentWith() specifies, for any two RedefinableTemplateSignatures
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. A redefining template signature is always consistent
    with a redefined template signature, since redefinition only adds new formal
    parameters."
   :operation-body
   "redefinee.oclIsKindOf(RedefinableTemplateSignature)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== ReduceAction
;;; =========================================================
(def-mm-class |ReduceAction| :UML25 (|Action|)
 "A reduce action is an action that reduces a collection to a single value
  by combining the elements of the collection."
  ((|collection| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |reduceAction|)
    :documentation
     "The collection to be reduced.")
   (|isOrdered| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the order of the input collection should determine the order
      in which the behavior is applied to its elements.")
   (|reducer| :range |Behavior| :multiplicity (1 1) :soft-opposite (|Behavior| |reduceAction|)
    :documentation
     "Behavior that is applied to two elements of the input collection to produce
      a value that is the same type as elements of the collection.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |reduceAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


(def-mm-constraint "input_type_is_collection" |ReduceAction| 
   "The type of the input must be a collection."
   :operation-body
   "true")

(def-mm-constraint "output_types_are_compatible" |ReduceAction| 
   "The type of the output must be compatible with the type of the output of
    the reducer behavior."
   :operation-body
   "true")

(def-mm-constraint "reducer_inputs_output" |ReduceAction| 
   "The reducer behavior must have two input parameters and one output parameter,
    of types compatible with the types of elements of the input collection."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Region
;;; =========================================================
(def-mm-class |Region| :UML25 (|Namespace| |RedefinableElement|)
 "A Region is a top-level part of a StateMachine or a a composite State,
  that serves as a container for the Vertices and Transitions of the StateMachine.
  A StateMachine or composite State may contain multiple Regions representing
  behaviors that may occur in parallel."
  ((|extendedRegion| :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Region| |region|)
    :documentation
     "The region of which this region is an extension.")
   (|redefinitionContext| :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Classifier| |region|)
    :documentation
     "References the Classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|state| :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |region|)
    :documentation
     "The State that owns the Region. If a Region is owned by a State, then it
      cannot also be owned by a StateMachine.")
   (|stateMachine| :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |region|)
    :documentation
     "The StateMachine that owns the Region. If a Region is owned by a StateMachine,
      then it cannot also be owned by a State.")
   (|subvertex| :range |Vertex| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Vertex| |container|)
    :documentation
     "The set of vertices that are owned by this region.")
   (|transition| :range |Transition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Transition| |container|)
    :documentation
     "The set of transitions owned by the region.")))


(def-mm-constraint "deep_history_vertex" |Region| 
   "A region can have at most one deep history vertex"
   :operation-body
   "self.subvertex->select (oclIsKindOf(Pseudostate))->collect(oclAsType(Pseudostate))->    select(kind = PseudostateKind::deepHistory)->size() <= 1 ")

(def-mm-constraint "initial_vertex" |Region| 
   "A region can have at most one initial vertex"
   :operation-body
   "self.subvertex->select (oclIsKindOf(Pseudostate))->collect(oclAsType(Pseudostate))->   select(kind = PseudostateKind::initial)->size() <= 1 ")

(def-mm-constraint "owned" |Region| 
   "If a Region is owned by a StateMachine, then it cannot also be owned by
    a State and vice versa."
   :operation-body
   "(stateMachine <> null implies state = null) and (state <> null implies stateMachine = null)")

(def-mm-constraint "shallow_history_vertex" |Region| 
   "A region can have at most one shallow history vertex"
   :operation-body
   "subvertex->select(oclIsKindOf(Pseudostate))->collect(oclAsType(Pseudostate))->   select(kind = PseudostateKind::shallowHistory)->size() <= 1 ")

(def-mm-operation "belongsToPSM" |Region| 
   "The operation belongsToPSM () checks if the region belongs to a protocol
    state machine"
   :operation-body
   "if  stateMachine <> null  then   stateMachine.oclIsKindOf(ProtocolStateMachine) else    state <> null  implies  state.container.belongsToPSM() endif "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "containingStateMachine" |Region| 
   "The operation containingStateMachine() returns the sate machine in which
    this Region is defined"
   :operation-body
   "if stateMachine = null  then   state.containingStateMachine() else   stateMachine endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-mm-operation "isConsistentWith" |Region| 
   "The query isConsistentWith() specifies that a redefining region is consistent
    with a redefined region provided that the redefining region is an extension
    of the redefined region, i.e. it adds vertices and transitions and it redefines
    states and transitions of the redefined region."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isRedefinitionContextValid" |Region| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of a region are properly related to the redefinition contexts
    of the specified region to allow this element to redefine the other. The
    containing statemachine/state of a redefining region must redefine the
    containing statemachine/state of the redefined region."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|Region|
                        :parameter-return-p NIL))
)

(def-mm-operation "redefinitionContext.1" |Region| 
   "The redefinition context of a region is the nearest containing statemachine"
   :operation-body
   "let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Relationship
;;; =========================================================
(def-mm-class |Relationship| :UML25 (|Element|)
 "Relationship is an abstract concept that specifies some kind of relationship
  between elements."
  ((|relatedElement| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T :soft-opposite (|Element| |relationship|)
    :documentation
     "Specifies the elements related by the Relationship.")))


;;; =========================================================
;;; ====================== RemoveStructuralFeatureValueAction
;;; =========================================================
(def-mm-class |RemoveStructuralFeatureValueAction| :UML25 (|WriteStructuralFeatureAction|)
 "A remove structural feature value action is a write structural feature
  action that removes values from structural features."
  ((|isRemoveDuplicates| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique structural
      features.")
   (|removeAt| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |removeStructuralFeatureValueAction|)
    :documentation
     "Specifies the position of an existing value to remove in ordered nonunique
      structural features. The type of the pin is UnlimitedNatural, but the value
      cannot be zero or unlimited.")))


(def-mm-constraint "non_unique_removal" |RemoveStructuralFeatureValueAction| 
   "Actions removing a value from ordered non-unique structural features must
    have a single removeAt input pin and no value input pin if isRemoveDuplicates
    is false. The removeAt pin must be of type Unlimited Natural with multiplicity
    1..1. Otherwise, the action has a value input pin and no removeAt input
    pin."
   :operation-body
   "if not structuralFeature.isOrdered or structuralFeature.isUnique or  isRemoveDuplicates then   self.removeAt = null and self.value <> null else   self.value = null and   self.removeAt <> null and   self.removeAt.type = UnlimitedNatural and   self.removeAt.is(1,1) endif")

;;; =========================================================
;;; ====================== RemoveVariableValueAction
;;; =========================================================
(def-mm-class |RemoveVariableValueAction| :UML25 (|WriteVariableAction|)
 "A remove variable value action is a write variable action that removes
  values from variables."
  ((|isRemoveDuplicates| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique variables.")
   (|removeAt| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |removeVariableValueAction|)
    :documentation
     "Specifies the position of an existing value to remove in ordered nonunique
      variables. The type of the pin is UnlimitedNatural, but the value cannot
      be zero or unlimited.")))


(def-mm-constraint "unlimited_natural" |RemoveVariableValueAction| 
   "Actions removing a value from ordered non-unique variables must have a
    single removeAt input pin and no value input pin if isRemoveDuplicates
    is false. The removeAt pin must be of type Unlimited Natural with multiplicity
    1..1. Otherwise, the action has a value input pin and no removeAt input
    pin."
   :operation-body
   "if not variable.isOrdered or variable.isUnique or isRemoveDuplicates then    self.removeAt = null and self.value <> null else   self.value = null and   self.removeAt <> null and   self.removeAt.type = UnlimitedNatural and   self.removeAt.is(1,1) endif")

;;; =========================================================
;;; ====================== ReplyAction
;;; =========================================================
(def-mm-class |ReplyAction| :UML25 (|Action|)
 "A reply action is an action that accepts a set of return values and a value
  containing return information produced by a previous accept call action.
  The reply action returns the values to the caller of the previous call,
  completing execution of the call."
  ((|replyToCall| :range |Trigger| :multiplicity (1 1) :soft-opposite (|Trigger| |replyAction|)
    :documentation
     "The trigger specifying the operation whose call is being replied to.")
   (|replyValue| :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |replyAction|)
    :documentation
     "A list of pins containing the reply values of the operation. These values
      are returned to the caller.")
   (|returnInformation| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |replyAction|)
    :documentation
     "A pin containing the return information value produced by an earlier AcceptCallAction.")))


(def-mm-constraint "event_on_reply_to_call_trigger" |ReplyAction| 
   "The event on replyToCall trigger must be a CallEvent replyToCallEvent.oclIsKindOf(CallEvent)"
   :operation-body
   "replyToCall.event.oclIsKindOf(CallEvent)")

(def-mm-constraint "pins_match_parameter" |ReplyAction| 
   "The reply value pins must match the return, out, and inout parameters of
    the operation on the event on the trigger in number, type, and order."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== SendObjectAction
;;; =========================================================
(def-mm-class |SendObjectAction| :UML25 (|InvocationAction|)
 "A send object action is an action that transmits an object to the target
  object, where it may invoke behavior such as the firing of state machine
  transitions or the execution of an activity. The value of the object is
  available to the execution of invoked behaviors. The requestor continues
  execution immediately. Any reply message is ignored and is not transmitted
  to the requestor."
  ((|request| :range |InputPin| :multiplicity (1 1) :is-composite-p T :soft-opposite (|InputPin| |sendObjectAction|)
    :documentation
     "The request object, which is transmitted to the target object. The object
      may be copied in transmission, so identity might not be preserved." :redefined-property (|InvocationAction| |argument|))
   (|target| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |sendObjectAction|)
    :documentation
     "The target object to which the object is sent.")))


;;; =========================================================
;;; ====================== SendSignalAction
;;; =========================================================
(def-mm-class |SendSignalAction| :UML25 (|InvocationAction|)
 "A send signal action is an action that creates a signal instance from its
  inputs, and transmits it to the target object, where it may cause the firing
  of a state machine transition or the execution of an activity. The argument
  values are available to the execution of associated behaviors. The requestor
  continues execution immediately. Any reply message is ignored and is not
  transmitted to the requestor. If the input is already a signal instance,
  use a send object action."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |sendSignalAction|)
    :documentation
     "The type of signal transmitted to the target object.")
   (|target| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |sendSignalAction|)
    :documentation
     "The target object to which the signal is sent.")))


(def-mm-constraint "number_order" |SendSignalAction| 
   "The number and order of argument pins must be the same as the number and
    order of attributes in the signal."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity" |SendSignalAction| 
   "The type, ordering, and multiplicity of an argument pin must be the same
    as the corresponding attribute of the signal."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== SequenceNode
;;; =========================================================
(def-mm-class |SequenceNode| :UML25 (|StructuredActivityNode|)
 "A sequence node is a structured activity node that executes its actions
  in order."
  ((|executableNode| :range |ExecutableNode| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T :soft-opposite (|ExecutableNode| |sequenceNode|)
    :documentation
     "An ordered set of executable nodes." :redefined-property (|StructuredActivityNode| |node|))))


;;; =========================================================
;;; ====================== Signal
;;; =========================================================
(def-mm-class |Signal| :UML25 (|Classifier|)
 "A Signal is a specification of a kind of communication between objects
  in which a reaction is asynchronously triggered in the receiver without
  a reply."
  ((|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|)) :soft-opposite (|Property| |owningSignal|)
    :documentation
     "The attributes owned by the Signal.")))


;;; =========================================================
;;; ====================== SignalEvent
;;; =========================================================
(def-mm-class |SignalEvent| :UML25 (|MessageEvent|)
 "A signal event represents the receipt of an asynchronous signal instance.
  A signal event may, for example, cause a state machine to trigger a transition."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |signalEvent|)
    :documentation
     "The specific signal that is associated with this event.")))


;;; =========================================================
;;; ====================== Slot
;;; =========================================================
(def-mm-class |Slot| :UML25 (|Element|)
 "A Slot designates that an entity modeled by an InstanceSpecification has
  a value or values for a specific StructuralFeature."
  ((|definingFeature| :range |StructuralFeature| :multiplicity (1 1) :soft-opposite (|StructuralFeature| |slot|)
    :documentation
     "The StructuralFeature that specifies the values that may be held by the
      Slot.")
   (|owningInstance| :range |InstanceSpecification| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|InstanceSpecification| |slot|)
    :documentation
     "The InstanceSpecification that owns this Slot.")
   (|value| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningSlot|)
    :documentation
     "The value or values held by the Slot.")))


;;; =========================================================
;;; ====================== StartClassifierBehaviorAction
;;; =========================================================
(def-mm-class |StartClassifierBehaviorAction| :UML25 (|Action|)
 "A start classifier behavior action is an action that starts the classifier
  behavior of the input."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |startClassifierBehaviorAction|)
    :documentation
     "Holds the object on which to start the owned behavior.")))


(def-mm-constraint "multiplicity" |StartClassifierBehaviorAction| 
   "The multiplicity of the input pin is 1..1"
   :operation-body
   "true")

(def-mm-constraint "type_has_classifier" |StartClassifierBehaviorAction| 
   "If the input pin has a type, then the type must have a classifier behavior."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== StartObjectBehaviorAction
;;; =========================================================
(def-mm-class |StartObjectBehaviorAction| :UML25 (|CallAction|)
 "StartObjectBehaviorAction is an action that starts the execution either
  of a directly instantiated behavior or of the classifier behavior of an
  object. Argument values may be supplied for the input parameters of the
  behavior. If the behavior is invoked synchronously, then output values
  may be obtained for output parameters."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |startObjectBehaviorAction|)
    :documentation
     "Holds the object which is either a behavior to be started or has a classifier
      behavior to be started.")))


(def-mm-constraint "multiplicity_of_object" |StartObjectBehaviorAction| 
   "The multiplicity of the object input pin must be [1..1]."
   :operation-body
   "true")

(def-mm-constraint "number_order_arguments" |StartObjectBehaviorAction| 
   "The number and order of the argument pins must be the same as the number
    and order of the in and in-out parameters of the invoked behavior. Pins
    are matched to parameters by order."
   :operation-body
   "true")

(def-mm-constraint "number_order_results" |StartObjectBehaviorAction| 
   "The number and order of result pins must be the same as the number and
    order of the in-out, out and return parameters of the invoked behavior.
    Pins are matched to parameters by order."
   :operation-body
   "true")

(def-mm-constraint "type_of_object" |StartObjectBehaviorAction| 
   "The type of the object input pin must be either a Behavior or a BehavioredClassifier
    with a classifier behavior."
   :operation-body
   "true")

(def-mm-constraint "type_ordering_multiplicity_match" |StartObjectBehaviorAction| 
   "The type, ordering, and multiplicity of an argument or result pin must
    be the same as the corresponding parameter of the behavior."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== State
;;; =========================================================
(def-mm-class |State| :UML25 (|RedefinableElement| |Namespace| |Vertex|)
 "A State models a situation during which some (usually implicit) invariant
  condition holds. For behavior StateMachines, States are internal elements
  hidden from view of extenal parties. However, the states of ProtocolStateMachines
  are intended to be exposed to the users of their context Classifiers. A
  protocol State represents an exposed stable situation of its context classifier:
  when an instance of the Classifier is not processing any BehavioralFeature,
  external parties interacting with this instance can always know its State
  configuration."
  ((|connection| :range |ConnectionPointReference| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ConnectionPointReference| |state|)
    :documentation
     "The entry and exit connection points used in conjunction with this (submachine)
      state, i.e. as targets and sources, respectively, in the region with the
      submachine state. A connection point reference references the corresponding
      definition of a connection point pseudostate in the statemachine referenced
      by the submachinestate.")
   (|connectionPoint| :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Pseudostate| |state|)
    :documentation
     "The entry and exit pseudostates of a composite state. These can only be
      entry or exit Pseudostates, and they must have different names. They can
      only be defined for composite states.")
   (|deferrableTrigger| :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Trigger| |state|)
    :documentation
     "A list of triggers that are candidates to be retained by the state machine
      if they trigger no transitions out of the state (not consumed). A deferred
      trigger is retained until the state machine reaches a state configuration
      where it is no longer deferred.")
   (|doActivity| :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Behavior| |state|)
    :documentation
     "An optional behavior that is executed while being in the state. The execution
      starts when this state is entered, and stops either by itself, or when
      the state is exited, whichever comes first.")
   (|entry| :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Behavior| |state|)
    :documentation
     "An optional behavior that is executed whenever this state is entered regardless
      of the transition taken to reach the state. If defined, entry actions are
      always executed to completion prior to any internal behavior or transitions
      performed within the state.")
   (|exit| :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Behavior| |state|)
    :documentation
     "An optional behavior that is executed whenever this state is exited regardless
      of which transition was taken out of the state. If defined, exit actions
      are always executed to completion only after all internal activities and
      transition actions have completed execution.")
   (|isComposite| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isComposite=true is said to be a composite state. A composite
      state is a state that contains at least one region.")
   (|isOrthogonal| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isOrthogonal=true is said to be an orthogonal composite state.
      An orthogonal composite state contains two or more regions.")
   (|isSimple| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :true
    :documentation
     "A state with isSimple=true is said to be a simple state. A simple state
      does not have any regions and it does not refer to any submachine state
      machine.")
   (|isSubmachineState| :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isSubmachineState=true is said to be a submachine state. Such
      a state refers to a state machine (submachine).")
   (|redefinedState| :range |State| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|State| |state|)
    :documentation
     "The state of which this state is a redefinition.")
   (|redefinitionContext| :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Classifier| |state|)
    :documentation
     "References the classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|region| :range |Region| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |state|)
    :documentation
     "The regions owned directly by the state.")
   (|stateInvariant| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |owningState|)
    :documentation
     "Specifies conditions that are always true when this state is the current
      state. In protocol state machines, state invariants are additional conditions
      to the preconditions of the outgoing transitions, and to the postcondition
      of the incoming transitions.")
   (|submachine| :range |StateMachine| :multiplicity (0 1)
    :opposite (|StateMachine| |submachineState|)
    :documentation
     "The state machine that is to be inserted in place of the (submachine) state.")))


(def-mm-constraint "composite_states" |State| 
   "Only composite states can have entry or exit pseudostates defined."
   :operation-body
   "connectionPoint->notEmpty() implies isComposite")

(def-mm-constraint "destinations_or_sources_of_transitions" |State| 
   "The connection point references used as destinations/sources of transitions
    associated with a submachine state must be defined as entry/exit points
    in the submachine state machine."
   :operation-body
   "self.isSubmachineState implies (self.connection->forAll (cp |   cp.entry->forAll (ps | ps.stateMachine = self.submachine) and   cp.exit->forAll (ps | ps.stateMachine = self.submachine)))")

(def-mm-constraint "entry_or_exit" |State| 
   "Only entry or exit pseudostates can serve as connection points."
   :operation-body
   "connectionPoint->forAll(kind = PseudostateKind::entryPoint or kind = PseudostateKind::exitPoint)")

(def-mm-constraint "submachine_or_regions" |State| 
   "A state is not allowed to have both a submachine and regions."
   :operation-body
   "isComposite implies not isSubmachineState")

(def-mm-constraint "submachine_states" |State| 
   "Only submachine states can have connection point references."
   :operation-body
   "isSubmachineState implies connection->notEmpty( )")

(def-mm-operation "containingStateMachine" |State| 
   "The query containingStateMachine() returns the state machine that contains
    the state either directly or transitively."
   :operation-body
   "container.containingStateMachine()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-mm-operation "isComposite.1" |State| 
   "A composite state is a state with at least one region."
   :operation-body
   "region->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isConsistentWith" |State| 
   "The query isConsistentWith() specifies that a redefining state is consistent
    with a redefined state provided that the redefining state is an extension
    of the redefined state: A simple state can be redefined (extended) to become
    a composite state (by adding a region) and a composite state can be redefined
    (extended) by adding regions and by adding vertices, states, and transitions
    to inherited regions. All states may add or replace entry, exit, and 'doActivity'
    actions."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isOrthogonal.1" |State| 
   "An orthogonal state is a composite state with at least 2 regions"
   :operation-body
   "region->size () > 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isRedefinitionContextValid" |State| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of a state are properly related to the redefinition contexts of
    the specified state to allow this element to redefine the other. The containing
    region of a redefining state must redefine the containing region of the
    redefined state."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-mm-operation "isSimple.1" |State| 
   "A simple state is a state without any regions."
   :operation-body
   "region->isEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isSubmachineState.1" |State| 
   "Only submachine states can have a reference statemachine."
   :operation-body
   "submachine <> null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "redefinitionContext.1" |State| 
   "The redefinition context of a state is the nearest containing statemachine."
   :operation-body
   "let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== StateInvariant
;;; =========================================================
(def-mm-class |StateInvariant| :UML25 (|InteractionFragment|)
 "A StateInvariant is a runtime constraint on the participants of the Interaction.
  It may be used to specify a variety of different kinds of Constraints,
  such as values of Attributes or Variables, internal or external States,
  and so on. A StateInvariant is an InteractionFragment and it is placed
  on a Lifeline."
  ((|covered| :range |Lifeline| :multiplicity (1 1) :soft-opposite (|Lifeline| |stateInvariant|)
    :documentation
     "References the Lifeline on which the StateInvariant appears." :redefined-property (|InteractionFragment| |covered|))
   (|invariant| :range |Constraint| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Constraint| |stateInvariant|)
    :documentation
     "A Constraint that should hold at runtime for this StateInvariant")))


;;; =========================================================
;;; ====================== StateMachine
;;; =========================================================
(def-mm-class |StateMachine| :UML25 (|Behavior|)
 "StateMachines can be used to express event-driven behaviors of parts of
  a system. Behavior is modeled as a traversal of a graph of Vertices interconnected
  by one or more joined Transition arcs that are triggered by the dispatching
  of successive Event occurrences. During this traversal, the StateMachine
  may execute a sequence of Behaviors associated with various elements of
  the StateMachine."
  ((|connectionPoint| :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Pseudostate| |stateMachine|)
    :documentation
     "The connection points defined for this state machine. They represent the
      interface of the state machine when used as part of submachine state.")
   (|extendedStateMachine| :range |StateMachine| :multiplicity (0 -1) :soft-opposite (|StateMachine| |stateMachine|)
    :documentation
     "The state machines of which this is an extension." :redefined-property (|Behavior| |redefinedBehavior|))
   (|region| :range |Region| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |stateMachine|)
    :documentation
     "The regions owned directly by the state machine.")
   (|submachineState| :range |State| :multiplicity (0 -1)
    :opposite (|State| |submachine|)
    :documentation
     "References the submachine(s) in case of a submachine state. Multiple machines
      are referenced in case of a concurrent state.")))


(def-mm-constraint "classifier_context" |StateMachine| 
   "The classifier context of a state machine cannot be an interface."
   :operation-body
   "_'context' <> null implies not _'context'.oclIsKindOf(Interface)")

(def-mm-constraint "connection_points" |StateMachine| 
   "The connection points of a state machine are pseudostates of kind entry
    point or exit point."
   :operation-body
   "connectionPoint->forAll (kind = PseudostateKind::entryPoint or kind = PseudostateKind::exitPoint)")

(def-mm-constraint "context_classifier" |StateMachine| 
   "The context classifier of the method state machine of a behavioral feature
    must be the classifier that owns the behavioral feature."
   :operation-body
   "specification <> null implies ( _'context' <> null and specification.featuringClassifier->exists(c | c = _'context'))")

(def-mm-constraint "method" |StateMachine| 
   "A state machine as the method for a behavioral feature cannot have entry/exit
    connection points."
   :operation-body
   "specification <> null implies connectionPoint->isEmpty()")

(def-mm-operation "LCA" |StateMachine| 
   "The operation LCA(s1,s2) returns an orthogonal state or region which is
    the least common ancestor of states s1 and s2, based on the statemachine
    containment hierarchy."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|Vertex|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|Vertex|
                        :parameter-return-p NIL))
)

(def-mm-operation "ancestor" |StateMachine| 
   "The query ancestor(s1, s2) checks whether s1 is an ancestor state of state
    s2."
   :operation-body
   "if (s2 = s1) then   true  else   if (s2.container->isEmpty() or not s2.container.owner.oclIsKindOf(State)) then    false   else    ancestor(s1, s2.container.owner.oclAsType(State))  endif endif  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|State|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-mm-operation "isConsistentWith" |StateMachine| 
   "The query isConsistentWith() specifies that a redefining state machine
    is consistent with a redefined state machine provided that the redefining
    state machine is an extension of the redefined state machine: Regions are
    inherited and regions can be added, inherited regions can be redefined.
    In case of multiple redefining state machines, extension implies that the
    redefining state machine gets orthogonal regions for each of the redefined
    state machines."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isRedefinitionContextValid" |StateMachine| 
   "The query isRedefinitionContextValid() specifies whether the redefinition
    contexts of a statemachine are properly related to the redefinition contexts
    of the specified statemachine to allow this element to redefine the other.
    The containing classifier of a redefining statemachine must redefine the
    containing classifier of the redefined statemachine."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|StateMachine|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== Stereotype
;;; =========================================================
(def-mm-class |Stereotype| :UML25 (|Class|)
 "A stereotype defines how an existing metaclass may be extended, and enables
  the use of platform or domain specific terminology or notation in place
  of, or in addition to, the ones used for the extended metaclass."
  ((|icon| :range |Image| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Image| |stereotype|)
    :documentation
     "Stereotype can change the graphical appearance of the extended model element
      by using attached icons. When this association is not null, it references
      the location of the icon content to be displayed within diagrams presenting
      the extended model elements.")
   (|profile| :range |Profile| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Profile| |stereotype|)
    :documentation
     "The profile that directly or indirectly contains this stereotype.")))


(def-mm-constraint "associationEndOwnership" |Stereotype| 
   "Where a stereotype s property is an association end for an association
    other than a kind of extension, and the other end is not a stereotype,
    the other end must be owned by the association itself."
   :operation-body
   "ownedAttribute ->select(association->notEmpty() and not association.oclIsKindOf(Extension) and not type.oclIsKindOf(Stereotype)) ->forAll(opposite.owner = association)")

(def-mm-constraint "binaryAssociationsOnly" |Stereotype| 
   "Stereotypes may only participate in binary associations."
   :operation-body
   "ownedAttribute.association->forAll(memberEnd->size()=2)")

(def-mm-constraint "generalize" |Stereotype| 
   "A Stereotype may only generalize or specialize another Stereotype."
   :operation-body
   "allParents()->forAll(oclIsKindOf(Stereotype))  and Classifier.allInstances()->forAll(c | c.allParents()->exists(oclIsKindOf(Stereotype)) implies c.oclIsKindOf(Stereotype)) ")

(def-mm-constraint "name_not_clash" |Stereotype| 
   "Stereotype names should not clash with keyword names for the extended model
    element."
   :operation-body
   "true")

(def-mm-operation "containingProfile" |Stereotype| 
   "The query containingProfile returns the closest profile directly or indirectly
    containing this stereotype."
   :operation-body
   "self.namespace.oclAsType(Package).containingProfile()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-mm-operation "profile.1" |Stereotype| 
   "A stereotype must be contained, directly or indirectly, in a profile."
   :operation-body
   "self.containingProfile()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== StringExpression
;;; =========================================================
(def-mm-class |StringExpression| :UML25 (|TemplateableElement| |Expression|)
 "An expression that specifies a string value that is derived by concatenating
  a set of sub string expressions, some of which might be template parameters."
  ((|owningExpression| :range |StringExpression| :multiplicity (0 1) :is-ordered-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|StringExpression| |subExpression|)
    :documentation
     "The string expression of which this expression is a substring.")
   (|subExpression| :range |StringExpression| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|StringExpression| |owningExpression|)
    :documentation
     "The StringExpressions that constitute this StringExpression.")))


(def-mm-constraint "operands" |StringExpression| 
   "All the operands of a StringExpression must be LiteralStrings"
   :operation-body
   "operand->forAll (oclIsKindOf (LiteralString))")

(def-mm-constraint "subexpressions" |StringExpression| 
   "If a StringExpression has sub-expressions, it cannot have operands and
    vice versa (this avoids the problem of having to define a collating sequence
    between operands and subexpressions)."
   :operation-body
   "if subExpression->notEmpty() then operand->isEmpty() else operand->notEmpty() endif")

(def-mm-operation "stringValue" |StringExpression| 
   "The query stringValue() returns the string that concatenates, in order,
    all the component string literals of all the subexpressions that are part
    of the StringExpression."
   :operation-body
   "if subExpression->notEmpty() then subExpression->iterate(se; stringValue: String = '' | stringValue.concat(se.stringValue())) else operand->iterate(op; stringValue: String = '' | stringValue.concat(op.stringValue())) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== StructuralFeature
;;; =========================================================
(def-mm-class |StructuralFeature| :UML25 (|MultiplicityElement| |TypedElement| |Feature|)
 "A StructuralFeature is a typed feature of a Classifier that specifies the
  structure of instances of the Classifier."
  ((|isReadOnly| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True if the StructuralFeature's value may not be modified by a client.")))


;;; =========================================================
;;; ====================== StructuralFeatureAction
;;; =========================================================
(def-mm-class |StructuralFeatureAction| :UML25 (|Action|)
 "StructuralFeatureAction is an abstract class for all structural feature
  actions."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |structuralFeatureAction|)
    :documentation
     "Gives the input pin from which the object whose structural feature is to
      be read or written is obtained.")
   (|structuralFeature| :range |StructuralFeature| :multiplicity (1 1) :soft-opposite (|StructuralFeature| |structuralFeatureAction|)
    :documentation
     "Structural feature to be read.")))


(def-mm-constraint "multiplicity" |StructuralFeatureAction| 
   "The multiplicity of the object input pin must be 1..1."
   :operation-body
   "object.is(1,1)")

(def-mm-constraint "not_static" |StructuralFeatureAction| 
   "The structural feature must not be static."
   :operation-body
   "not structuralFeature.isStatic")

(def-mm-constraint "one_featuring_classifier" |StructuralFeatureAction| 
   "A structural feature has exactly one featuringClassifier."
   :operation-body
   "structuralFeature.featuringClassifier->size() = 1")

(def-mm-constraint "same_type" |StructuralFeatureAction| 
   "The structural feature must either be owned by the type of the object input
    pin, or it must be an owned end of a binary association with the type of
    the opposite end being the type of the object input pin."
   :operation-body
   "structuralFeature.featuringClassifier.oclAsType(Type)->includes(object.type) or  structuralFeature.oclAsType(Property).opposite.type = object.type")

(def-mm-constraint "visibility" |StructuralFeatureAction| 
   "Visibility of structural feature must allow access to the object performing
    the action."
   :operation-body
   "let host : Classifier = _'context' in structuralFeature.visibility = VisibilityKind::public or host = self.structuralFeature.featuringClassifier->asSequence()->first() or (self.structuralFeature.visibility = VisibilityKind::protected and    host.allParents()->includesAll(self.structuralFeature.featuringClassifier)) ")

;;; =========================================================
;;; ====================== StructuredActivityNode
;;; =========================================================
(def-mm-class |StructuredActivityNode| :UML25 (|Namespace| |ActivityGroup| |Action|)
 "Because of the concurrent nature of the execution of actions within and
  across activities, it can be difficult to guarantee the consistent access
  and modification of object memory. In order to avoid race conditions or
  other concurrency-related problems, it is sometimes necessary to isolate
  the effects of a group of actions from the effects of actions outside the
  group. This may be indicated by setting the mustIsolate attribute to true
  on a structured activity node. If a structured activity node is \"isolated,\"
  then any object used by an action within the node cannot be accessed by
  any action outside the node until the structured activity node as a whole
  completes. Any concurrent actions that would result in accessing such objects
  are required to have their execution deferred until the completion of the
  node. A structured activity node is an executable activity node that may
  have an expansion into subordinate nodes as an activity group. The subordinate
  nodes must belong to only one structured activity node, although they may
  be nested."
  ((|activity| :range |Activity| :multiplicity (0 1)
    :opposite (|Activity| |structuredNode|)
    :documentation
     "Activity immediately containing the node." :redefined-property (|ActivityGroup| |inActivity|))
   (|edge| :range |ActivityEdge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |containedEdge|) (|Element| |ownedElement|))
    :opposite (|ActivityEdge| |inStructuredNode|)
    :documentation
     "Edges immediately contained in the structured node.")
   (|mustIsolate| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, then the actions in the node execute in isolation from actions
      outside the node.")
   (|node| :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |containedNode|) (|Element| |ownedElement|))
    :opposite (|ActivityNode| |inStructuredNode|)
    :documentation
     "Nodes immediately contained in the group.")
   (|structuredNodeInput| :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |structuredActivityNode|))
   (|structuredNodeOutput| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |structuredActivityNode|))
   (|variable| :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |scope|)
    :documentation
     "A variable defined in the scope of the structured activity node. It has
      no value and may not be accessed")))


(def-mm-constraint "edges" |StructuredActivityNode| 
   "The edges owned by a structured node must have source and target nodes
    in the structured node, and vice versa."
   :operation-body
   "true")

(def-mm-constraint "input_pin_edges" |StructuredActivityNode| 
   "The incoming edges of the input pins of a StructuredActivityNode must have
    sources that are not within the StructuredActivityNode."
   :operation-body
   "true")

(def-mm-constraint "output_pin_edges" |StructuredActivityNode| 
   "The outgoing edges of the output pins of a StructuredActivityNode must
    have targets that are not within the StructuredActivityNode."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== StructuredClassifier
;;; =========================================================
(def-mm-class |StructuredClassifier| :UML25 (|Classifier|)
 "StructuredClassifiers may contain an internal structure of connected elements
  each of which plays a role in the overall Behavior modeled by the StructuredClassifier."
  ((|ownedAttribute| :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|) (|StructuredClassifier| |role|)) :soft-opposite (|Property| |structuredClassifier|)
    :documentation
     "The Properties owned by the StructuredClassifier.")
   (|ownedConnector| :range |Connector| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|)) :soft-opposite (|Connector| |structuredClassifier|)
    :documentation
     "The connectors owned by the StructuredClassifier.")
   (|part| :range |Property| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T :soft-opposite (|Property| |structuredClassifier|)
    :documentation
     "The Properties specifying instances that the StructuredClassifier owns
      by composition. This collection is derived, selecting those owned Properties
      where isComposite is true.")
   (|role| :range |ConnectableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|)) :soft-opposite (|ConnectableElement| |structuredClassifier|)
    :documentation
     "The roles that instances may play in this StructuredClassifier.")))


(def-mm-operation "part.1" |StructuredClassifier| 
   "Derivation for StructuredClassifier::/part"
   :operation-body
   "ownedAttribute->select(isComposite)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Substitution
;;; =========================================================
(def-mm-class |Substitution| :UML25 (|Realization|)
 "A substitution is a relationship between two classifiers signifies that
  the substituting classifier complies with the contract specified by the
  contract classifier. This implies that instances of the substituting classifier
  are runtime substitutable where instances of the contract classifier are
  expected."
  ((|contract| :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|)) :soft-opposite (|Classifier| |substitution|)
    :documentation
     "The contract with which the substituting classifier complies.")
   (|substitutingClassifier| :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|) (|Element| |owner|))
    :opposite (|Classifier| |substitution|)
    :documentation
     "Instances of the substituting classifier are runtime substitutable where
      instances of the contract classifier are expected.")))


;;; =========================================================
;;; ====================== TemplateBinding
;;; =========================================================
(def-mm-class |TemplateBinding| :UML25 (|DirectedRelationship|)
 "A template binding represents a relationship between a templateable element
  and a template. A template binding specifies the substitutions of actual
  parameters for the formal parameters of the template."
  ((|boundElement| :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|TemplateableElement| |templateBinding|)
    :documentation
     "The element that is bound by this binding.")
   (|parameterSubstitution| :range |TemplateParameterSubstitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateParameterSubstitution| |templateBinding|)
    :documentation
     "The parameter substitutions owned by this template binding.")
   (|signature| :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|TemplateSignature| |templateBinding|)
    :documentation
     "The template signature for the template that is the target of the binding.")))


(def-mm-constraint "one_parameter_substitution" |TemplateBinding| 
   "A binding contains at most one parameter substitution for each formal template
    parameter of the target template signature."
   :operation-body
   "signature.parameter->forAll(p | parameterSubstitution->select(b | b.formal = p)->size() <= 1)")

(def-mm-constraint "parameter_substitution_formal" |TemplateBinding| 
   "Each parameter substitution must refer to a formal template parameter of
    the target template signature."
   :operation-body
   "parameterSubstitution->forAll(b | signature.parameter->includes(b.formal))")

;;; =========================================================
;;; ====================== TemplateParameter
;;; =========================================================
(def-mm-class |TemplateParameter| :UML25 (|Element|)
 "A template parameter exposes a parameterable element as a formal template
  parameter of a template."
  ((|default| :range |ParameterableElement| :multiplicity (0 1) :soft-opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The element that is the default for this formal template parameter.")
   (|ownedDefault| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |default|)) :soft-opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The element that is owned by this template parameter for the purpose of
      providing a default.")
   (|ownedParameteredElement| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |parameteredElement|))
    :opposite (|ParameterableElement| |owningTemplateParameter|)
    :documentation
     "The element that is owned by this template parameter.")
   (|parameteredElement| :range |ParameterableElement| :multiplicity (1 1)
    :opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The element exposed by this template parameter.")
   (|signature| :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateSignature| |ownedParameter|)
    :documentation
     "The template signature that owns this template parameter.")))


(def-mm-constraint "must_be_compatible" |TemplateParameter| 
   "The default must be compatible with the formal template parameter."
   :operation-body
   "default <> null implies default.isCompatibleWith(parameteredElement)")

;;; =========================================================
;;; ====================== TemplateParameterSubstitution
;;; =========================================================
(def-mm-class |TemplateParameterSubstitution| :UML25 (|Element|)
 "A template parameter substitution relates the actual parameter to a formal
  template parameter as part of a template binding."
  ((|actual| :range |ParameterableElement| :multiplicity (1 1) :soft-opposite (|ParameterableElement| |templateParameterSubstitution|)
    :documentation
     "The element that is the actual parameter for this substitution.")
   (|formal| :range |TemplateParameter| :multiplicity (1 1) :soft-opposite (|TemplateParameter| |templateParameterSubstitution|)
    :documentation
     "The formal template parameter that is associated with this substitution.")
   (|ownedActual| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameterSubstitution| |actual|)) :soft-opposite (|ParameterableElement| |owningTemplateParameterSubstitution|)
    :documentation
     "The actual parameter that is owned by this substitution.")
   (|templateBinding| :range |TemplateBinding| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateBinding| |parameterSubstitution|)
    :documentation
     "The optional bindings from this element to templates.")))


(def-mm-constraint "must_be_compatible" |TemplateParameterSubstitution| 
   "The actual parameter must be compatible with the formal template parameter,
    e.g. the actual parameter for a class template parameter must be a class."
   :operation-body
   "actual->forAll(a | a.isCompatibleWith(formal.parameteredElement))")

;;; =========================================================
;;; ====================== TemplateSignature
;;; =========================================================
(def-mm-class |TemplateSignature| :UML25 (|Element|)
 "A template signature bundles the set of formal template parameters for
  a templated element."
  ((|ownedParameter| :range |TemplateParameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateSignature| |parameter|))
    :opposite (|TemplateParameter| |signature|)
    :documentation
     "The formal template parameters that are owned by this template signature.")
   (|parameter| :range |TemplateParameter| :multiplicity (1 -1) :is-ordered-p T :soft-opposite (|TemplateParameter| |templateSignature|)
    :documentation
     "The ordered set of all formal template parameters for this template signature.")
   (|template| :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateableElement| |ownedTemplateSignature|)
    :documentation
     "The element that owns this template signature.")))


(def-mm-constraint "own_elements" |TemplateSignature| 
   "Parameters must own the elements they parameter or those elements must
    be owned by the element being templated."
   :operation-body
   "template.ownedElement->includesAll(parameter.parameteredElement->asSet() - parameter.ownedParameteredElement->asSet())")

;;; =========================================================
;;; ====================== TemplateableElement
;;; =========================================================
(def-mm-class |TemplateableElement| :UML25 (|Element|)
 "A templateable element is an element that can optionally be defined as
  a template and bound to other templates."
  ((|ownedTemplateSignature| :range |TemplateSignature| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateSignature| |template|)
    :documentation
     "The optional template signature specifying the formal template parameters.")
   (|templateBinding| :range |TemplateBinding| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateBinding| |boundElement|)
    :documentation
     "The optional bindings from this element to templates.")))


(def-mm-operation "isTemplate" |TemplateableElement| 
   "The query isTemplate() returns whether this templateable element is actually
    a template."
   :operation-body
   "ownedTemplateSignature <> null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "parameterableElements" |TemplateableElement| 
   "The query parameterableElements() returns the set of elements that may
    be used as the parametered elements for a template parameter of this templateable
    element. By default, this set includes all the owned elements. Subclasses
    may override this operation if they choose to restrict the set of parameterable
    elements."
   :operation-body
   "self.allOwnedElements()->select(oclIsKindOf(ParameterableElement)).oclAsType(ParameterableElement)->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ParameterableElement|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== TestIdentityAction
;;; =========================================================
(def-mm-class |TestIdentityAction| :UML25 (|Action|)
 "A test identity action is an action that tests if two values are identical
  objects."
  ((|first| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |testIdentityAction|)
    :documentation
     "Gives the pin on which an object is placed.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |testIdentityAction|)
    :documentation
     "Tells whether the two input objects are identical.")
   (|second| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |testIdentityAction|)
    :documentation
     "Gives the pin on which an object is placed.")))


(def-mm-constraint "multiplicity" |TestIdentityAction| 
   "The multiplicity of the input pins is 1..1."
   :operation-body
   "first.is(1,1) and second.is(1,1) ")

(def-mm-constraint "no_type" |TestIdentityAction| 
   "The input pins have no type."
   :operation-body
   "first.type= null and second.type = null ")

(def-mm-constraint "result_is_boolean" |TestIdentityAction| 
   "The type of the result is the UML standard primitive type Boolean. (This
    is not directly representable in OCL at the metamodel level.)"
   :operation-body
   "true ")

;;; =========================================================
;;; ====================== TimeConstraint
;;; =========================================================
(def-mm-class |TimeConstraint| :UML25 (|IntervalConstraint|)
 "A time constraint is a constraint that refers to a time interval."
  ((|firstEvent| :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "The value of firstEvent is related to constrainedElement. If firstEvent
      is true, then the corresponding observation event is the first time instant
      the execution enters constrainedElement. If firstEvent is false, then the
      corresponding observation event is the last time instant the execution
      is within constrainedElement.")
   (|specification| :range |TimeInterval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|TimeInterval| |timeConstraint|)
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied." :redefined-property (|IntervalConstraint| |specification|))))


;;; =========================================================
;;; ====================== TimeEvent
;;; =========================================================
(def-mm-class |TimeEvent| :UML25 (|Event|)
 "A time event can be defined relative to entering the current state of the
  executing state machine. A time event specifies a point in time. At the
  specified time, the event occurs."
  ((|isRelative| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether it is relative or absolute time.")
   (|when| :range |TimeExpression| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|TimeExpression| |timeEvent|)
    :documentation
     "Specifies the corresponding time deadline.")))


(def-mm-constraint "starting_time" |TimeEvent| 
   "The starting time for a relative time event may only be omitted for a time
    event that is the trigger of a state machine."
   :operation-body
   "true")

(def-mm-constraint "when_non_negative" |TimeEvent| 
   "The ValueSpecification when must return a non-negative Integer."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== TimeExpression
;;; =========================================================
(def-mm-class |TimeExpression| :UML25 (|ValueSpecification|)
 "A time expression defines a value specification that represents a time
  value."
  ((|expr| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |timeExpression|)
    :documentation
     "The value of the time expression.")
   (|observation| :range |Observation| :multiplicity (0 -1) :soft-opposite (|Observation| |timeExpression|)
    :documentation
     "Refers to the time and duration observations that are involved in expr.")))


;;; =========================================================
;;; ====================== TimeInterval
;;; =========================================================
(def-mm-class |TimeInterval| :UML25 (|Interval|)
 "A time interval defines the range between two time expressions."
  ((|max| :range |TimeExpression| :multiplicity (1 1) :soft-opposite (|TimeExpression| |timeInterval|)
    :documentation
     "Refers to the TimeExpression denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :range |TimeExpression| :multiplicity (1 1) :soft-opposite (|TimeExpression| |timeInterval|)
    :documentation
     "Refers to the TimeExpression denoting the minimum value of the range." :redefined-property (|Interval| |min|))))


;;; =========================================================
;;; ====================== TimeObservation
;;; =========================================================
(def-mm-class |TimeObservation| :UML25 (|Observation|)
 "A time observation is a reference to a time instant during an execution.
  It points out the element in the model to observe and whether the observation
  is when this model element is entered or when it is exited."
  ((|event| :range |NamedElement| :multiplicity (1 1) :soft-opposite (|NamedElement| |timeObservation|)
    :documentation
     "The observation is determined by the entering or exiting of the event element
      during execution.")
   (|firstEvent| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "The value of firstEvent is related to event. If firstEvent is true, then
      the corresponding observation event is the first time instant the execution
      enters event. If firstEvent is false, then the corresponding observation
      event is the time instant the execution exits event.")))


;;; =========================================================
;;; ====================== Transition
;;; =========================================================
(def-mm-class |Transition| :UML25 (|Namespace| |RedefinableElement|)
 "A Transition represents an arc between one source Vertex and one Target
  vertex (the source and targets may be the same Vertex). It may form part
  of a compound transition, which takes the StateMachine from one steady
  State configuration to another, representing the full response of the StateMachine
  to an occurrence of an Event that triggers it."
  ((|container| :range |Region| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |transition|)
    :documentation
     "Designates the region that owns this transition.")
   (|effect| :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Behavior| |transition|)
    :documentation
     "Specifies an optional behavior to be performed when the transition fires.")
   (|guard| :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |transition|)
    :documentation
     "A guard is a constraint that provides a fine-grained control over the firing
      of the transition. The guard is evaluated when an event occurrence is dispatched
      by the state machine. If the guard is true at that time, the transition
      may be enabled, otherwise, it is disabled. Guards should be pure expressions
      without side effects. Guard expressions with side effects are ill formed.")
   (|kind| :range |TransitionKind| :multiplicity (1 1) :default :external
    :documentation
     "Indicates the precise type of the transition.")
   (|redefinedTransition| :range |Transition| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|)) :soft-opposite (|Transition| |transition|)
    :documentation
     "The transition that is redefined by this transition.")
   (|redefinitionContext| :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Classifier| |transition|)
    :documentation
     "References the Classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|source| :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |outgoing|)
    :documentation
     "Designates the originating vertex (state or pseudostate) of the transition.")
   (|target| :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |incoming|)
    :documentation
     "Designates the target vertex that is reached when the transition is taken.")
   (|trigger| :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Trigger| |transition|)
    :documentation
     "Specifies the triggers that may fire the transition.")))


(def-mm-constraint "fork_segment_guards" |Transition| 
   "A fork segment must not have guards or triggers."
   :operation-body
   "(source.oclIsKindOf(Pseudostate) and source.oclAsType(Pseudostate).kind = PseudostateKind::fork) implies (guard = null and trigger->isEmpty())")

(def-mm-constraint "fork_segment_state" |Transition| 
   "A fork segment must always target a state."
   :operation-body
   "(source.oclIsKindOf(Pseudostate) and  source.oclAsType(Pseudostate).kind = PseudostateKind::fork) implies (target.oclIsKindOf(State))")

(def-mm-constraint "initial_transition" |Transition| 
   "An initial transition at the topmost level (region of a statemachine) either
    has no trigger or it has a trigger with the stereotype >."
   :operation-body
   "--self.source.oclIsKindOf(Pseudostate) implies --(self.source.oclAsType(Pseudostate).kind = PseudostateKind::initial) implies --(self.source.container = self.stateMachine.top) implies --((self.trigger->isEmpty) or --(self.trigger.stereotype.name = 'create'))  -- several problems here: -- 1) the nested implies - the first two should be and, I think -- 2) \"top\" is not defined -- 3) there is no way in OCL that you can get to the applied stereotype for an element. \"stereotype\" does not do it. See email thread also -- 4) the \"create\" stereotype in the standard profile, which should be capitalized, does not apply to Trigger; it applies to BehavioralFeature or Classifier  true")

(def-mm-constraint "join_segment_guards" |Transition| 
   "A join segment must not have guards or triggers."
   :operation-body
   "(target.oclIsKindOf(Pseudostate) and target.oclAsType(Pseudostate).kind = PseudostateKind::join) implies (guard = null and trigger->isEmpty())")

(def-mm-constraint "join_segment_state" |Transition| 
   "A join segment must always originate from a state."
   :operation-body
   "(target.oclIsKindOf(Pseudostate) and target.oclAsType(Pseudostate).kind = PseudostateKind::join) implies (source.oclIsKindOf(State))")

(def-mm-constraint "outgoing_pseudostates" |Transition| 
   "Transitions outgoing pseudostates may not have a trigger."
   :operation-body
   "source.oclIsKindOf(Pseudostate) and (source.oclAsType(Pseudostate).kind <> PseudostateKind::initial) implies trigger->isEmpty()")

(def-mm-constraint "signatures_compatible" |Transition| 
   "In case of more than one trigger, the signatures of these must be compatible
    in case the parameters of the signal are assigned to local variables/attributes."
   :operation-body
   "true")

(def-mm-constraint "state_is_external" |Transition| 
   "A transition with kind external can source any vertex except entry points."
   :operation-body
   "(kind = TransitionKind::external) implies  not (source.oclIsKindOf(Pseudostate) and source.oclAsType(Pseudostate).kind = PseudostateKind::entryPoint)")

(def-mm-constraint "state_is_internal" |Transition| 
   "A transition with kind internal must have a state as its source, and its
    source and target must be equal."
   :operation-body
   "(kind = TransitionKind::internal) implies   (source.oclIsKindOf (State) and source = target)")

(def-mm-constraint "state_is_local" |Transition| 
   "A transition with kind local must have a composite state or an entry point
    as its source."
   :operation-body
   "(kind = TransitionKind::local) implies   ((source.oclIsKindOf (State) and source.oclAsType(State).isComposite) or   (source.oclIsKindOf (Pseudostate) and source.oclAsType(Pseudostate).kind = PseudostateKind::entryPoint))")

(def-mm-operation "containingStateMachine" |Transition| 
   "The query containingStateMachine() returns the state machine that contains
    the transition either directly or transitively."
   :operation-body
   "container.containingStateMachine()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-mm-operation "isConsistentWith" |Transition| 
   "The query isConsistentWith() specifies that a redefining transition is
    consistent with a redefined transition provided that the redefining transition
    has the following relation to the redefined transition: A redefining transition
    redefines all properties of the corresponding redefined transition, except
    the source state and the trigger."
   :operation-body
   "redefinee.oclIsKindOf(Transition) and   let trans: Transition = redefinee.oclAsType(Transition) in     (source = trans.source and trigger = trans.trigger)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "redefinitionContext.1" |Transition| 
   "The redefinition context of a transition is the nearest containing statemachine."
   :operation-body
   "let sm : StateMachine = containingStateMachine() in if sm._'context' = null or sm.general->notEmpty() then   sm else   sm._'context' endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Trigger
;;; =========================================================
(def-mm-class |Trigger| :UML25 (|NamedElement|)
 "A trigger relates an event to a behavior that may affect an instance of
  the classifier. A trigger specification may be qualified by the port on
  which the event occurred."
  ((|event| :range |Event| :multiplicity (1 1) :soft-opposite (|Event| |trigger|)
    :documentation
     "The event that causes the trigger.")
   (|port| :range |Port| :multiplicity (0 -1) :soft-opposite (|Port| |trigger|)
    :documentation
     "A optional port of the receiver object on which the behavioral feature
      is invoked.")))


;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-mm-class |Type| :UML25 (|PackageableElement|)
 "A type is a named element that is used as the type for a typed element.
  A type can be contained in a package. A type constrains the values represented
  by a typed element."
  ((|package| :range |Package| :multiplicity (0 1)
    :opposite (|Package| |ownedType|)
    :documentation
     "Specifies the owning package of this classifier, if any.")))


(def-mm-operation "conformsTo" |Type| 
   "The query conformsTo() gives true for a type that conforms to another.
    By default, two types do not conform to each other. This query is intended
    to be redefined for specific conformance situations."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Type|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== TypedElement
;;; =========================================================
(def-mm-class |TypedElement| :UML25 (|NamedElement|)
 "A typed element has a type. A typed element is a kind of named element
  that represents an element with a type."
  ((|type| :range |Type| :multiplicity (0 1) :soft-opposite (|Type| |typedElement|)
    :documentation
     "The type of the TypedElement. This information is derived from the return
      result for this Operation.")))


;;; =========================================================
;;; ====================== UnmarshallAction
;;; =========================================================
(def-mm-class |UnmarshallAction| :UML25 (|Action|)
 "An unmarshall action is an action that breaks an object of a known type
  into outputs each of which is equal to a value from a structural feature
  of the object."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |unmarshallAction|)
    :documentation
     "The object to be unmarshalled.")
   (|result| :range |OutputPin| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |unmarshallAction|)
    :documentation
     "The values of the structural features of the input object.")
   (|unmarshallType| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |unmarshallAction|)
    :documentation
     "The type of the object to be unmarshalled.")))


(def-mm-constraint "multiplicity_of_object" |UnmarshallAction| 
   "The multiplicity of the object input pin is 1..1"
   :operation-body
   "true")

(def-mm-constraint "multiplicity_of_result" |UnmarshallAction| 
   "The multiplicity of each result output pin must be compatible with the
    multiplicity of the corresponding structural features of the unmarshall
    classifier."
   :operation-body
   "true")

(def-mm-constraint "number_of_result" |UnmarshallAction| 
   "The number of result output pins must be the same as the number of structural
    features of the unmarshall classifier."
   :operation-body
   "true")

(def-mm-constraint "same_type" |UnmarshallAction| 
   "The type of the object input pin must be the same as the unmarshall classifier."
   :operation-body
   "true")

(def-mm-constraint "structural_feature" |UnmarshallAction| 
   "The unmarshall classifier must have at least one structural feature."
   :operation-body
   "true")

(def-mm-constraint "type_and_ordering" |UnmarshallAction| 
   "The type and ordering of each result output pin must be the same as the
    corresponding structural feature of the unmarshall classifier."
   :operation-body
   "true")

(def-mm-constraint "unmarshallType_is_classifier" |UnmarshallAction| 
   "unmarshallType must be a Classifier with ordered attributes"
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Usage
;;; =========================================================
(def-mm-class |Usage| :UML25 (|Dependency|)
 "A usage is a relationship in which one element requires another element
  (or set of elements) for its full implementation or operation. A usage
  is a dependency in which the client requires the presence of the supplier."
  ())


;;; =========================================================
;;; ====================== UseCase
;;; =========================================================
(def-mm-class |UseCase| :UML25 (|BehavioredClassifier|)
 "A UseCase specifies a set of actions performed by its subject, which yields
  an observable result that is of value for one or more Actors or other stakeholders
  of the subject."
  ((|extend| :range |Extend| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Extend| |extension|)
    :documentation
     "The Extend relationships owned by this UseCase.")
   (|extensionPoint| :range |ExtensionPoint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ExtensionPoint| |useCase|)
    :documentation
     "The ExtensionPoints owned by this UseCase.")
   (|include| :range |Include| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Include| |includingCase|)
    :documentation
     "The Include relationships owned by this UseCase.")
   (|subject| :range |Classifier| :multiplicity (0 -1)
    :opposite (|Classifier| |useCase|)
    :documentation
     "The subjects to which this UseCase applies. The subject or its parts realize
      all the UseCases that apply to this subject. UseCases need not be attached
      to any specific subject, however. The subject may, but need not, own the
      UseCases that apply to it.")))


(def-mm-constraint "binary_associations" |UseCase| 
   "UseCases can only be involved in binary Associations."
   :operation-body
   "Association.allInstances()->forAll(a | a.memberEnd.type->includes(self) implies a.memberEnd->size() = 2)")

(def-mm-constraint "cannot_include_self" |UseCase| 
   "A UseCase cannot include UseCases that directly or indirectly include it."
   :operation-body
   "not allIncludedUseCases()->includes(self)")

(def-mm-constraint "must_have_name" |UseCase| 
   "A UseCase must have a name."
   :operation-body
   "name -> notEmpty ()")

(def-mm-constraint "no_association_to_use_case" |UseCase| 
   "UseCases can not have Associations to UseCases specifying the same subject."
   :operation-body
   "Association.allInstances()->forAll(a | a.memberEnd.type->includes(self) implies     (    let usecases: Set(UseCase) = a.memberEnd.type->select(oclIsKindOf(UseCase))->collect(oclAsType(UseCase))->asSet() in    usecases->size() > 1 implies usecases->collect(subject)->size() > 1    ) )")

(def-mm-operation "allIncludedUseCases" |UseCase| 
   "The query allIncludedUseCases() returns the transitive closure of all UseCases
    (directly or indirectly) included by this UseCase."
   :operation-body
   "self.include.addition->union(self.include.addition->collect(uc | uc.allIncludedUseCases()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UseCase|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ValuePin
;;; =========================================================
(def-mm-class |ValuePin| :UML25 (|InputPin|)
 "A value pin is an input pin that provides a value by evaluating a value
  specification."
  ((|value| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |valuePin|)
    :documentation
     "Value that the pin will provide.")))


(def-mm-constraint "compatible_type" |ValuePin| 
   "The type of value specification must be compatible with the type of the
    value pin."
   :operation-body
   "true")

(def-mm-constraint "no_incoming_edges" |ValuePin| 
   "Value pins have no incoming edges."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== ValueSpecification
;;; =========================================================
(def-mm-class |ValueSpecification| :UML25 (|TypedElement| |PackageableElement|)
 "ValueSpecification specializes ParameterableElement to specify that a value
  specification can be exposed as a formal template parameter, and provided
  as an actual parameter in a binding of a template. A value specification
  is the specification of a (possibly empty) set of instances, including
  both objects and data values."
  ())


(def-mm-operation "booleanValue" |ValueSpecification| 
   "The query booleanValue() gives a single Boolean value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "integerValue" |ValueSpecification| 
   "The query integerValue() gives a single Integer value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-mm-operation "isCompatibleWith" |ValueSpecification| 
   "The query isCompatibleWith() determines if this parameterable element is
    compatible with the specified parameterable element. By default parameterable
    element P is compatible with parameterable element Q if the kind of P is
    the same or a subtype as the kind of Q. In addition, for ValueSpecification,
    the type must be conformant with the type of the specified parameterable
    element."
   :operation-body
   "p.oclIsKindOf(self.oclType()) and self.type.conformsTo(p.oclAsType(TypedElement).type)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|ParameterableElement|
                        :parameter-return-p NIL))
)

(def-mm-operation "isComputable" |ValueSpecification| 
   "The query isComputable() determines whether a value specification can be
    computed in a model. This operation cannot be fully defined in OCL. A conforming
    implementation is expected to deliver true for this operation for all value
    specifications that it can compute, and to compute all of those for which
    the operation is true. A conforming implementation is expected to be able
    to compute the value of all literals."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "isNull" |ValueSpecification| 
   "The query isNull() returns true when it can be computed that the value
    is null."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-mm-operation "realValue" |ValueSpecification| 
   "The query realValue() gives a single Real value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Real|
                        :parameter-return-p T))
)

(def-mm-operation "stringValue" |ValueSpecification| 
   "The query stringValue() gives a single String value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-mm-operation "unlimitedValue" |ValueSpecification| 
   "The query unlimitedValue() gives a single UnlimitedNatural value when one
    can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ValueSpecificationAction
;;; =========================================================
(def-mm-class |ValueSpecificationAction| :UML25 (|Action|)
 "A value specification action is an action that evaluates a value specification."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |valueSpecificationAction|)
    :documentation
     "Gives the output pin on which the result is put.")
   (|value| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |valueSpecificationAction|)
    :documentation
     "Value specification to be evaluated.")))


(def-mm-constraint "compatible_type" |ValueSpecificationAction| 
   "The type of value specification must be compatible with the type of the
    result pin."
   :operation-body
   "true")

(def-mm-constraint "multiplicity" |ValueSpecificationAction| 
   "The multiplicity of the result pin is 1..1"
   :operation-body
   "true")

;;; =========================================================
;;; ====================== Variable
;;; =========================================================
(def-mm-class |Variable| :UML25 (|ConnectableElement| |MultiplicityElement|)
 "A variable is considered a connectable element. Variables are elements
  for passing data between actions indirectly. A local variable stores values
  shared by the actions within a structured activity group but not accessible
  outside it. The output of an action may be written to a variable and read
  for the input to a subsequent action, which is effectively an indirect
  data flow path. Because there is no predefined relationship between actions
  that read and write variables, these actions must be sequenced by control
  flows to prevent race conditions that may occur between actions that read
  or write the same variable."
  ((|activityScope| :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Activity| |variable|)
    :documentation
     "An activity that owns the variable.")
   (|scope| :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StructuredActivityNode| |variable|)
    :documentation
     "A structured activity node that owns the variable.")))


(def-mm-constraint "owned" |Variable| 
   "A variable is owned by a StructuredNode or Activity, but not both."
   :operation-body
   "true")

(def-mm-operation "isAccessibleBy" |Variable| 
   "The isAccessibleBy() operation is not defined in standard UML. Implementations
    should define it to specify which actions can access a variable."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\a :parameter-type '|Action|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== VariableAction
;;; =========================================================
(def-mm-class |VariableAction| :UML25 (|Action|)
 "VariableAction is an abstract class for actions that operate on a statically
  specified variable."
  ((|variable| :range |Variable| :multiplicity (1 1) :soft-opposite (|Variable| |variableAction|)
    :documentation
     "Variable to be read.")))


(def-mm-constraint "scope_of_variable" |VariableAction| 
   "The action must be in the scope of the variable."
   :operation-body
   "variable.isAccessibleBy(self)")

;;; =========================================================
;;; ====================== Vertex
;;; =========================================================
(def-mm-class |Vertex| :UML25 (|NamedElement|)
 "A Vertex is an abstraction of a node in a StateMachine It can be the source
  or destination of any number of Transitions."
  ((|container| :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |subvertex|)
    :documentation
     "The region that contains this vertex.")
   (|incoming| :range |Transition| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Transition| |target|)
    :documentation
     "Specifies the transitions entering this vertex.")
   (|outgoing| :range |Transition| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Transition| |source|)
    :documentation
     "Specifies the transitions departing from this vertex.")))


(def-mm-operation "containingStateMachine" |Vertex| 
   "The operation containingStateMachine() returns the state machine in which
    this Vertex is defined"
   :operation-body
   "if container <> null then -- the container is a region    
 container.containingStateMachine() else     if (self.oclIsKindOf(Pseudostate)) and ((self.oclAsType(Pseudostate).kind = PseudostateKind::entryPoint) or (self.oclAsType(Pseudostate).kind = PseudostateKind::exitPoint)) then       self.oclAsType(Pseudostate).stateMachine    else        if (self.oclIsKindOf(ConnectionPointReference)) then           self.oclAsType(ConnectionPointReference).state.containingStateMachine() -- no other valid cases possible       
else            null       endif    endif endif  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-mm-operation "incoming.1" |Vertex| 
   "Missing derivation for Vertex::/incoming : Transition"
   :operation-body
   "Transition.allInstances()->select(target=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-mm-operation "outgoing.1" |Vertex| 
   "Missing derivation for Vertex::/outgoing : Transition"
   :operation-body
   "Transition.allInstances()->select(source=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== WriteLinkAction
;;; =========================================================
(def-mm-class |WriteLinkAction| :UML25 (|LinkAction|)
 "WriteLinkAction is an abstract class for link actions that create and destroy
  links."
  ())


(def-mm-constraint "allow_access" |WriteLinkAction| 
   "The visibility of at least one end must allow access to the class using
    the action."
   :operation-body
   "true")

;;; =========================================================
;;; ====================== WriteStructuralFeatureAction
;;; =========================================================
(def-mm-class |WriteStructuralFeatureAction| :UML25 (|StructuralFeatureAction|)
 "WriteStructuralFeatureAction is an abstract class for structural feature
  actions that change structural feature values."
  ((|result| :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |writeStructuralFeatureAction|)
    :documentation
     "Gives the output pin on which the result is put.")
   (|value| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |writeStructuralFeatureAction|)
    :documentation
     "Value to be added or removed from the structural feature.")))


(def-mm-constraint "input_pin" |WriteStructuralFeatureAction| 
   "The type of the value input pin is the same as the type of the structural
    feature."
   :operation-body
   "value <> null implies value.type = structuralFeature.type")

(def-mm-constraint "multiplicity" |WriteStructuralFeatureAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "value.is(1,1)")

(def-mm-constraint "multiplicity_of_result" |WriteStructuralFeatureAction| 
   "The multiplicity of the result output pin must be 1..1."
   :operation-body
   "result <> null implies result.is(1,1)")

(def-mm-constraint "type_of_result" |WriteStructuralFeatureAction| 
   "The type of the result output pin is the same as the type of the inherited
    object input pin."
   :operation-body
   "result <> null implies result.type = object.type")

;;; =========================================================
;;; ====================== WriteVariableAction
;;; =========================================================
(def-mm-class |WriteVariableAction| :UML25 (|VariableAction|)
 "WriteVariableAction is an abstract class for variable actions that change
  variable values."
  ((|value| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |writeVariableAction|)
    :documentation
     "Value to be added or removed from the variable.")))


(def-mm-constraint "multiplicity" |WriteVariableAction| 
   "The multiplicity of the input pin is 1..1."
   :operation-body
   "value.is(1,1)")

(def-mm-constraint "same_type" |WriteVariableAction| 
   "The type input pin is the same as the type of the variable."
   :operation-body
   "value <> null implies value.type = variable.type")

(def-mm-package |Actions| UML :UML25 
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
    |ValuePin|))

(def-mm-package |Activities| UML :UML25 
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
    |ObjectNodeOrderingKind|))

(def-mm-package |Classification| UML :UML25 
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
    |ParameterEffectKind|))

(def-mm-package |CommonBehavior| UML :UML25 
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
    |Trigger|))

(def-mm-package |CommonStructure| UML :UML25 
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
    |VisibilityKind|))

(def-mm-package |Deployments| UML :UML25 
   (|Artifact|
    |CommunicationPath|
    |DeployedArtifact|
    |Deployment|
    |DeploymentSpecification|
    |DeploymentTarget|
    |Device|
    |ExecutionEnvironment|
    |Manifestation|
    |Node|))

(def-mm-package |InformationFlows| UML :UML25 
   (|InformationFlow|
    |InformationItem|))

(def-mm-package |Interactions| UML :UML25 
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
    |MessageSort|))

(def-mm-package |Packages| UML :UML25 
   (|Extension|
    |ExtensionEnd|
    |Image|
    |Model|
    |Package|
    |PackageMerge|
    |Profile|
    |ProfileApplication|
    |Stereotype|))

(def-mm-package |PrimitiveTypes| UML :UML25 
   (|Boolean|
    |Integer|
    |Real|
    |String|
    |UnlimitedNatural|))

(def-mm-package |SimpleClassifiers| UML :UML25 
   (|BehavioredClassifier|
    |DataType|
    |Enumeration|
    |EnumerationLiteral|
    |Interface|
    |InterfaceRealization|
    |PrimitiveType|
    |Reception|
    |Signal|))

(def-mm-package |StateMachines| UML :UML25 
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
    |TransitionKind|))

(def-mm-package |StructuredClassifiers| UML :UML25 
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
    |ConnectorKind|))

(def-mm-package UML NIL :UML25 
   (|Actions|
    |Activities|
    |Classification|
    |CommonBehavior|
    |CommonStructure|
    |Deployments|
    |InformationFlows|
    |Interactions|
    |Packages|
    |PrimitiveTypes|
    |SimpleClassifiers|
    |StateMachines|
    |StructuredClassifiers|
    |UseCases|
    |Values|))

(def-mm-package |UseCases| UML :UML25 
   (|Actor|
    |Extend|
    |ExtensionPoint|
    |Include|
    |UseCase|))

(def-mm-package |Values| UML :UML25 
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
    |ValueSpecification|))

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
     (setf mofi:ns-uri NIL)
     (setf mofi:ns-prefix NIL))