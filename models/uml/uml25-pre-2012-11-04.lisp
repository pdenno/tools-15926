;;; Automatically created by pop-gen at 2012-06-01 15:29:00.
;;; Source file is uml25-2012-06-01-clean.xmi

(in-package :UML25)



(def-meta-primitive |Boolean| (:model :UML25 :superclasses NIL :xmi-id "_PSic1ToZEeCmpu-HRutBsg"))



(def-meta-primitive |Integer| (:model :UML25 :superclasses NIL :xmi-id "_PSic1zoZEeCmpu-HRutBsg"))



(def-meta-primitive |Real| (:model :UML25 :superclasses NIL :xmi-id "_PSic2ToZEeCmpu-HRutBsg"))



(def-meta-primitive |String| (:model :UML25 :superclasses NIL :xmi-id "_PSic2zoZEeCmpu-HRutBsg"))



(def-meta-primitive |UnlimitedNatural| (:model :UML25 :superclasses NIL :xmi-id "_PSic3ToZEeCmpu-HRutBsg"))



(def-meta-enum |AggregationKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_CH1-xjoZEeCmpu-HRutBsg")
   (|none| |shared| |composite|)
   "AggregationKind is an Enumeration for specifying the kind of aggregation
    of a Property.")



(def-meta-enum |CallConcurrencyKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_CH1-zjoZEeCmpu-HRutBsg")
   (|sequential| |guarded| |concurrent|)
   "CallConcurrencyKind is an Enumeration used to specify the semantics of
    concurrent calls to a BehavioralFeature.")



(def-meta-enum |ConnectorKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_LPmM4zoZEeCmpu-HRutBsg")
   (|assembly| |delegation|)
   "ConnectorKind is an enumeration that defines whether a Connector is an
    assembly or a delegation.")



(def-meta-enum |ExpansionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_AkdfOToZEeCmpu-HRutBsg")
   (|parallel| |iterative| |stream|)
   "ExpansionKind is an enumeration type used to specify how multiple executions
    of an expansion region interact.")



(def-meta-enum |InteractionOperatorKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_F_wqYzoZEeCmpu-HRutBsg")
   (|seq| |alt| |opt| |break| |par| |strict| |loop| |critical| |neg| |assert| |ignore| |consider|)
   "InteractionOperatorKind is an enumeration designating the different kinds
    of operators of CombinedFragments. The InteractionOperand defines the type
    of operator of a CombinedFragment.")



(def-meta-enum |MessageKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_F_wqfToZEeCmpu-HRutBsg")
   (|complete| |lost| |found| |unknown|)
   "This is an enumerated type that identifies the type of Message.")



(def-meta-enum |MessageSort| (:model :UML25 :superclasses NIL 
   :xmi-id "_F_wqhzoZEeCmpu-HRutBsg")
   (|synchCall| |asynchCall| |asynchSignal| |createMessage| |deleteMessage| |reply|)
   "This is an enumerated type that identifies the type of communication action
    that was used to generate the Message.")



(def-meta-enum |ObjectNodeOrderingKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_BHevkzoZEeCmpu-HRutBsg")
   (|unordered| |ordered| LIFO FIFO)
   "ObjectNodeOrderingKind is an enumeration indicating queuing order within
    a node.")



(def-meta-enum |ParameterDirectionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_CH1-1joZEeCmpu-HRutBsg")
   (|in| |inout| |out| |return|)
   "ParameterDirectionKind is an Enumeration that defines literals used to
    specify direction of parameters.")



(def-meta-enum |ParameterEffectKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_CH1-4DoZEeCmpu-HRutBsg")
   (|create| |read| |update| |delete|)
   "ParameterEffectKind is an Enumeration that indicates the effect of a Behavior
    on values passed in or out of its parameters.")



(def-meta-enum |PseudostateKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_Kq8ByToZEeCmpu-HRutBsg")
   (|initial| |deepHistory| |shallowHistory| |join| |fork| |junction| |choice| |entryPoint| |exitPoint| |terminate|)
   "PseudostateKind is an Enumeration type that is used to differentiate various
    kinds of Pseudostates.")



(def-meta-enum |TransitionKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_Kq8B3zoZEeCmpu-HRutBsg")
   (|internal| |local| |external|)
   "TransitionKind is an Enumeration type used to differentiate the various
    kinds of Transitions.")



(def-meta-enum |VisibilityKind| (:model :UML25 :superclasses NIL 
   :xmi-id "_D3SikjoZEeCmpu-HRutBsg")
   (|public| |private| |protected| |package|)
   "VisibilityKind is an enumeration type that defines literals to determine
    the visibility of Elements in a model.")



;;; =========================================================
;;; ====================== Abstraction
;;; =========================================================
(def-meta-class |Abstraction| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3Iy8zoZEeCmpu-HRutBsg")
 "An Abstraction is a Relationship that relates two Elements or sets of Elements
  that represent the same concept at different levels of abstraction or from
  different viewpoints."
  ((|mapping| :range |OpaqueExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|OpaqueExpression| |abstraction|)
    :documentation
     "An OpaqueExpression that states the abstraction relationship between the
      supplier(s) and the client(s). In some cases, such as derivation, it is
      usually formal and unidirectional; in other cases, such as trace, it is
      usually informal and bidirectional. The mapping expression is optional
      and may be omitted if the precise relationship between the Elements is
      not specified.")))


;;; =========================================================
;;; ====================== AcceptCallAction
;;; =========================================================
(def-meta-class |AcceptCallAction| 
   (:model :UML25 :superclasses (|AcceptEventAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfQToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== AcceptEventAction
;;; =========================================================
(def-meta-class |AcceptEventAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfTzoZEeCmpu-HRutBsg")
 "A accept event action is an action that waits for the occurrence of an
  event meeting specified conditions."
  ((|isUnmarshall| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether there is a single output pin for the event, or multiple
      output pins for attributes of the event.")
   (|result| :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
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


;;; =========================================================
;;; ====================== Action
;;; =========================================================
(def-meta-class |Action| 
   (:model :UML25 :superclasses (|ExecutableNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfaDoZEeCmpu-HRutBsg")
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


(def-meta-operation "context.1" |Action| 
   ""
   :operation-body
   "if activity->notEmpty() then activity._'context' else null endif  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ActionExecutionSpecification
;;; =========================================================
(def-meta-class |ActionExecutionSpecification| 
   (:model :UML25 :superclasses (|ExecutionSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_nikToZEeCmpu-HRutBsg")
 "An ActionExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of an Action."
  ((|action| :range |Action| :multiplicity (1 1) :soft-opposite (|Action| |actionExecutionSpecification|)
    :documentation
     "Action whose execution is occurring.")))


;;; =========================================================
;;; ====================== ActionInputPin
;;; =========================================================
(def-meta-class |ActionInputPin| 
   (:model :UML25 :superclasses (|InputPin|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfiToZEeCmpu-HRutBsg")
 "An action input pin is a kind of pin that executes an action to determine
  the values to input to another."
  ((|fromAction| :range |Action| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Action| |actionInputPin|)
    :documentation
     "The action used to provide values.")))


;;; =========================================================
;;; ====================== Activity
;;; =========================================================
(def-meta-class |Activity| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHetxToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ActivityEdge
;;; =========================================================
(def-meta-class |ActivityEdge| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHet9joZEeCmpu-HRutBsg")
 "An activity edge is an abstract class for directed connections between
  two activity nodes. Activity edges can be contained in interruptible regions."
  ((|activity| :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |edge|)
    :documentation
     "Activity containing the edge.")
   (|guard| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
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
   (|weight| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |activityEdge|)
    :documentation
     "The minimum number of tokens that must traverse the edge at the same time.")))


;;; =========================================================
;;; ====================== ActivityFinalNode
;;; =========================================================
(def-meta-class |ActivityFinalNode| 
   (:model :UML25 :superclasses (|FinalNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuIDoZEeCmpu-HRutBsg")
 "An activity final node is a final node that stops all flows in an activity."
  ())


;;; =========================================================
;;; ====================== ActivityGroup
;;; =========================================================
(def-meta-class |ActivityGroup| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuIzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ActivityNode
;;; =========================================================
(def-meta-class |ActivityNode| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuQToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ActivityParameterNode
;;; =========================================================
(def-meta-class |ActivityParameterNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuaDoZEeCmpu-HRutBsg")
 "An activity parameter node is an object node for inputs and outputs to
  activities."
  ((|parameter| :range |Parameter| :multiplicity (1 1) :soft-opposite (|Parameter| |activityParameterNode|)
    :documentation
     "The parameter the object node will be accepting or providing values for.")))


;;; =========================================================
;;; ====================== ActivityPartition
;;; =========================================================
(def-meta-class |ActivityPartition| 
   (:model :UML25 :superclasses (|ActivityGroup|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeugjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Actor
;;; =========================================================
(def-meta-class |Actor| 
   (:model :UML25 :superclasses (|BehavioredClassifier|) 
    :packages (UML |UseCases|) 
    :xmi-id "_LuSTfToZEeCmpu-HRutBsg")
 "An Actor specifies a role played by a user or any other system that interacts
  with the subject."
  ())


;;; =========================================================
;;; ====================== AddStructuralFeatureValueAction
;;; =========================================================
(def-meta-class |AddStructuralFeatureValueAction| 
   (:model :UML25 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdflzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== AddVariableValueAction
;;; =========================================================
(def-meta-class |AddVariableValueAction| 
   (:model :UML25 :superclasses (|WriteVariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfpjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== AnyReceiveEvent
;;; =========================================================
(def-meta-class |AnyReceiveEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF0rXDoZEeCmpu-HRutBsg")
 "A trigger for an AnyReceiveEvent is triggered by the receipt of any message
  that is not explicitly handled by any related trigger."
  ())


;;; =========================================================
;;; ====================== Artifact
;;; =========================================================
(def-meta-class |Artifact| 
   (:model :UML25 :superclasses (|Classifier| |DeployedArtifact|) 
    :packages (UML |Deployments|) 
    :xmi-id "_EntUiDoZEeCmpu-HRutBsg")
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
(def-meta-class |Association| 
   (:model :UML25 :superclasses (|Relationship| |Classifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPcd4ToZEeCmpu-HRutBsg")
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


(def-meta-operation "endType.1" |Association| 
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
(def-meta-class |AssociationClass| 
   (:model :UML25 :superclasses (|Class| |Association|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPceCzoZEeCmpu-HRutBsg")
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
    :xmi-id "_DF0rXzoZEeCmpu-HRutBsg")
 "Behavior is a specification of how its context BehavioredClassifier changes
  state over time. This specification may be either a definition of possible
  behavior execution or emergent behavior, or a selective illustration of
  an interesting subset of possible executions. The latter form is typically
  used for capturing examples, such as a trace of a particular execution."
  ((|context| :range |BehavioredClassifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|)) :soft-opposite (|BehavioredClassifier| |behavior|)
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
      the context BehavioredCassifier as well as the Elements visible to the
      context Classifier are visible to the Behavior.")
   (|isReentrant| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether the Behavior can be invoked while it is still executing from
      a previous invocation.")
   (|ownedParameter| :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Parameter| |behavior|)
    :documentation
     "References a list of Parameters to the Behavior which describes the order
      and type of arguments that can be given when the Behavior is invoked and
      of the values which will be returned when the Behavior completes its execution.")
   (|ownedParameterSet| :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|ParameterSet| |behavior|)
    :documentation
     "The ParameterSets owned by this Behavior.")
   (|postcondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |behavior|)
    :documentation
     "An optional set of Constraints specifying what is fulfilled after the execution
      of the Behavior is completed, if its precondition was fulfilled before
      its invocation.")
   (|precondition| :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|)) :soft-opposite (|Constraint| |behavior|)
    :documentation
     "An optional set of Constraints specifying what must be fulfilled before
      the Behavior is invoked.")
   (|redefinedBehavior| :range |Behavior| :multiplicity (0 -1)
    :subsetted-properties ((|Classifier| |redefinedClassifier|)) :soft-opposite (|Behavior| |behavior|)
    :documentation
     "References the Behaviosr that this Behavior redefines. A subtype of Behavior
      may redefine any other subtype of Behavior. If the Behavior implements
      a BehavioralFeature, it replaces the redefined Behavior. If the Behavior
      is a classifierBehavior, it extends the redefined Behavior.")
   (|specification| :range |BehavioralFeature| :multiplicity (0 1)
    :opposite (|BehavioralFeature| |method|)
    :documentation
     "Designates a BehavioralFeature that the Behavior implements. The BehavioralFeature
      must be owned by the BehavioredClassifier that owns the Behavior or be
      inherited by it. The Parameters of the BehavioralFeature and the implementing
      Behavior must match. A Behavior does not need to have a specification,
      in which case it either is the classiferBehavior of a BehavioredClassifier
      or it can only be invoked by another Behavior of the Classifier.")))


(def-meta-operation "behavioredClassifier" |Behavior| 
   "The first BehavioredClassifier reached by following the chain of owner
    relationships from the Behavior, if any"
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
   "if nestingClass <> null then      null  else      let b:BehavioredClassifier = self.behavioredClassifier(self.owner) in      if b.oclIsKindOf(Behavior) and b.oclAsType(Behavior)._'context' <> null then           b.oclAsType(Behavior)._'context'      else           b       endif  endif          "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|BehavioredClassifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== BehaviorExecutionSpecification
;;; =========================================================
(def-meta-class |BehaviorExecutionSpecification| 
   (:model :UML25 :superclasses (|ExecutionSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_nimToZEeCmpu-HRutBsg")
 "A BehaviorExecutionSpecification is a kind of ExecutionSpecification representing
  the execution of a Behavior."
  ((|behavior| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |behaviorExecutionSpecification|)
    :documentation
     "Behavior whose execution is occurring.")))


;;; =========================================================
;;; ====================== BehavioralFeature
;;; =========================================================
(def-meta-class |BehavioralFeature| 
   (:model :UML25 :superclasses (|Feature| |Namespace|) 
    :packages (UML |Classification|) 
    :xmi-id "_CHsOTToZEeCmpu-HRutBsg")
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


(def-meta-operation "isDistinguishableFrom" |BehavioralFeature| 
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
(def-meta-class |BehavioredClassifier| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwOzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== BroadcastSignalAction
;;; =========================================================
(def-meta-class |BroadcastSignalAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknPojoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== CallAction
;;; =========================================================
(def-meta-class |CallAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknPrToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== CallBehaviorAction
;;; =========================================================
(def-meta-class |CallBehaviorAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknPwDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== CallEvent
;;; =========================================================
(def-meta-class |CallEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZSToZEeCmpu-HRutBsg")
 "A CallEvent models the receipt by an object of a message invoking a call
  of an Operation."
  ((|operation| :range |Operation| :multiplicity (1 1) :soft-opposite (|Operation| |callEvent|)
    :documentation
     "Designates the Operation whose invocation raised the CalEvent.")))


;;; =========================================================
;;; ====================== CallOperationAction
;;; =========================================================
(def-meta-class |CallOperationAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknPzjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== CentralBufferNode
;;; =========================================================
(def-meta-class |CentralBufferNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuqToZEeCmpu-HRutBsg")
 "A central buffer node is an object node for managing flows from multiple
  sources and destinations."
  ())


;;; =========================================================
;;; ====================== ChangeEvent
;;; =========================================================
(def-meta-class |ChangeEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZTjoZEeCmpu-HRutBsg")
 "A ChangeEvent models a change in the system configuration that makes a
  condition true."
  ((|changeExpression| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |changeEvent|)
    :documentation
     "A Boolean-valued ValueSpecification that will result in a ChangeEvent whenever
      its value changes from false to true.")))


;;; =========================================================
;;; ====================== Class
;;; =========================================================
(def-meta-class |Class| 
   (:model :UML25 :superclasses (|BehavioredClassifier| |EncapsulatedClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPceFToZEeCmpu-HRutBsg")
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


(def-meta-operation "extension.1" |Class| 
   "Derivation for Class::/extension : Extension"
   :operation-body
   "Extension.allInstances()->select(ext |     let endTypes : Sequence(Classifier) = ext.memberEnd->collect(type.oclAsType(Classifier)) in    endTypes->includes(self) or endTypes.allParents()->includes(self) )"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Extension|
                        :parameter-return-p T))
)

(def-meta-operation "inherit" |Class| 
   "The inherit operation is overridden to exclude redefined Properties."
   :operation-body
   "let excludedElements : Set(RedefinableElement) =    inhs->select(inh |       inh.oclIsKindOf(RedefinableElement) and           let redinh : RedefinableElement = inh.oclAsType(RedefinableElement) in             (self.ownedMember->select(oclIsKindOf(RedefinableElement)) ->collect(oclAsType(RedefinableElement).redefinedElement))->includes(redinh))->                 collect(oclAsType(RedefinableElement))->asSet()    in     inhs -  excludedElements"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "superClass.1" |Class| 
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
(def-meta-class |Classifier| 
   (:model :UML25 :superclasses (|Namespace| |Type| |TemplateableElement| |RedefinableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "_CHsOcDoZEeCmpu-HRutBsg")
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


(def-meta-operation "allFeatures" |Classifier| 
   "The query allFeatures() gives all of the features in the namespace of the
    Classifier. In general, through mechanisms such as inheritance, this will
    be a larger set than feature."
   :operation-body
   "member->select(oclIsKindOf(Feature))->collect(oclAsType(Feature))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Feature|
                        :parameter-return-p T))
)

(def-meta-operation "allParents" |Classifier| 
   "The query allParents() gives all of the direct and indirect ancestors of
    a generalized Classifier."
   :operation-body
   "parents()->union(parents()->collect(allParents())->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "allRealizedInterfaces" |Classifier| 
   "The Interfaces realized by this Classifier and all of its generalizations"
   :operation-body
   "directlyRealizedInterfaces()->union(self.allParents()->collect(directlyRealizedInterfaces()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "allUsedInterfaces" |Classifier| 
   "The Interfaces used by this Classifier and all of its generalizations"
   :operation-body
   "directlyUsedInterfaces()->union(self.allParents()->collect(directlyUsedInterfaces()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "conformsTo" |Classifier| 
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

(def-meta-operation "directlyRealizedInterfaces" |Classifier| 
   "The Interfaces directly realized by this Classifier"
   :operation-body
   "(clientDependency->    select(oclIsKindOf(Realization) and supplier->forAll(oclIsKindOf(Interface))))->        collect(supplier.oclAsType(Interface))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "directlyUsedInterfaces" |Classifier| 
   "The Interfaces directly used by this Classifier"
   :operation-body
   "(supplierDependency->    select(oclIsKindOf(Usage) and client->forAll(oclIsKindOf(Interface))))->      collect(client.oclAsType(Interface))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "general.1" |Classifier| 
   "The general Classifiers are the ones referenced by the Generalization relationships."
   :operation-body
   "parents()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "hasVisibilityOf" |Classifier| 
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

(def-meta-operation "inherit" |Classifier| 
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

(def-meta-operation "inheritableMembers" |Classifier| 
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

(def-meta-operation "inheritedMember.1" |Classifier| 
   "The inheritedMember association is derived by inheriting the inheritable
    members of the parents."
   :operation-body
   "inherit(parents()->collect(inheritableMembers(self))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T))
)

(def-meta-operation "isSubstitutableFor" |Classifier| 
   ""
   :operation-body
   "substitution.contract->includes(contract)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name '|contract| :parameter-type '|Classifier|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isTemplate" |Classifier| 
   "The query isTemplate() returns whether this Classifier is actually a template."
   :operation-body
   "ownedTemplateSignature <> null or general->exists(g | g.isTemplate())"
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
   "self.oclIsKindOf(c.oclType())"
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
   "generalization.general->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ClassifierTemplateParameter
;;; =========================================================
(def-meta-class |ClassifierTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |Classification|) 
    :xmi-id "_CHsPFDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Clause
;;; =========================================================
(def-meta-class |Clause| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknP4ToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ClearAssociationAction
;;; =========================================================
(def-meta-class |ClearAssociationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQAjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ClearStructuralFeatureAction
;;; =========================================================
(def-meta-class |ClearStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQDzoZEeCmpu-HRutBsg")
 "A clear structural feature action is a structural feature action that removes
  all values of a structural feature."
  ((|result| :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |clearStructuralFeatureAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


;;; =========================================================
;;; ====================== ClearVariableAction
;;; =========================================================
(def-meta-class |ClearVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQGzoZEeCmpu-HRutBsg")
 "A clear variable action is a variable action that removes all values of
  a variable."
  ())


;;; =========================================================
;;; ====================== Collaboration
;;; =========================================================
(def-meta-class |Collaboration| 
   (:model :UML25 :superclasses (|StructuredClassifier| |BehavioredClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmLzDoZEeCmpu-HRutBsg")
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
(def-meta-class |CollaborationUse| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmL1DoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== CombinedFragment
;;; =========================================================
(def-meta-class |CombinedFragment| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_ninzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Comment
;;; =========================================================
(def-meta-class |Comment| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3Iy-ToZEeCmpu-HRutBsg")
 "A Comment is a textual annotation that can be attached to a set of Elements."
  ((|annotatedElement| :range |Element| :multiplicity (0 -1) :soft-opposite (|Element| |comment|)
    :documentation
     "References the Element(s) being commented.")
   (|body| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies a string that is the comment.")))


;;; =========================================================
;;; ====================== CommunicationPath
;;; =========================================================
(def-meta-class |CommunicationPath| 
   (:model :UML25 :superclasses (|Association|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3CoToZEeCmpu-HRutBsg")
 "A communication path is an association between two deployment targets,
  through which they are able to exchange signals and messages."
  ())


;;; =========================================================
;;; ====================== Component
;;; =========================================================
(def-meta-class |Component| 
   (:model :UML25 :superclasses (|Class|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmL5joZEeCmpu-HRutBsg")
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


(def-meta-operation "provided.1" |Component| 
   "Derivation for Comppnent::/provided"
   :operation-body
   "let  ris : Set(Interface) = allRealizedInterfaces(),          realizingClassifiers : Set(Classifier) =  self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),          allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),          realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allRealizedInterfaces())),          ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),          providedByPorts : Set(Interface) = ports.provided->asSet()  in     ris->union(realizingClassifierInterfaces) ->union(providedByPorts)->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "required.1" |Component| 
   "Derivation for Comppnent::/required"
   :operation-body
   "let  uis : Set(Interface) = allUsedInterfaces(),          realizingClassifiers : Set(Classifier) = self.realization.realizingClassifier->union(self.allParents()->collect(realization.realizingClassifier))->asSet(),          allRealizingClassifiers : Set(Classifier) = realizingClassifiers->union(realizingClassifiers.allParents())->asSet(),          realizingClassifierInterfaces : Set(Interface) = allRealizingClassifiers->iterate(c; rci : Set(Interface) = Set{} | rci->union(c.allUsedInterfaces())),          ports : Set(Port) = self.ownedPort->union(allParents()->collect(ownedPort))->asSet(),          usedByPorts : Set(Interface) = ports.required->asSet()  in     uis->union(realizingClassifierInterfaces)->union(usedByPorts)->asSet()  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ComponentRealization
;;; =========================================================
(def-meta-class |ComponentRealization| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMIToZEeCmpu-HRutBsg")
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
(def-meta-class |ConditionalNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQHjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ConnectableElement
;;; =========================================================
(def-meta-class |ConnectableElement| 
   (:model :UML25 :superclasses (|TypedElement| |ParameterableElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMKjoZEeCmpu-HRutBsg")
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


(def-meta-operation "end.1" |ConnectableElement| 
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
(def-meta-class |ConnectableElementTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMPToZEeCmpu-HRutBsg")
 "A ConnectableElementTemplateParameter exposes a ConnectableElement as a
  formal parameter for a template."
  ((|parameteredElement| :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |templateParameter|)
    :documentation
     "The ConnectableElement for this ConnectableElementTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))


;;; =========================================================
;;; ====================== ConnectionPointReference
;;; =========================================================
(def-meta-class |ConnectionPointReference| 
   (:model :UML25 :superclasses (|Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq7_7ToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Connector
;;; =========================================================
(def-meta-class |Connector| 
   (:model :UML25 :superclasses (|Feature|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMQjoZEeCmpu-HRutBsg")
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


(def-meta-operation "kind.1" |Connector| 
   "Derivation for Connector::/kind : ConnectorKind"
   :operation-body
   "if end->exists(    role.oclIsKindOf(Port)     and partWithPort->isEmpty()    and not role.oclAsType(Port).isBehavior)  then ConnectorKind::delegation   else ConnectorKind::assembly   endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorKind|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ConnectorEnd
;;; =========================================================
(def-meta-class |ConnectorEnd| 
   (:model :UML25 :superclasses (|MultiplicityElement|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMaDoZEeCmpu-HRutBsg")
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


(def-meta-operation "definingEnd.1" |ConnectorEnd| 
   "Derivation for ConnectorEnd::/definingEnd : Property"
   :operation-body
   "if connector.type = null   then    null   else    let index : Integer = connector.end->indexOf(self) in      connector.type.memberEnd->at(index)  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ConsiderIgnoreFragment
;;; =========================================================
(def-meta-class |ConsiderIgnoreFragment| 
   (:model :UML25 :superclasses (|CombinedFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_niuDoZEeCmpu-HRutBsg")
 "A ConsiderIgnoreFragment is a kind of CombinedFragment that is used for
  the consider and ignore cases, which require lists of pertinent Messages
  to be specified."
  ((|message| :range |NamedElement| :multiplicity (0 -1) :soft-opposite (|NamedElement| |considerIgnoreFragment|)
    :documentation
     "The set of messages that apply to this fragment")))


;;; =========================================================
;;; ====================== Constraint
;;; =========================================================
(def-meta-class |Constraint| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3IzAzoZEeCmpu-HRutBsg")
 "A Constraint is a condition or restriction expressed in natural language
  text or in a machine readable language for the purpose of declaring some
  of the semantics of an Element or set of Elements."
  ((|constrainedElement| :range |Element| :multiplicity (0 -1) :is-ordered-p T :soft-opposite (|Element| |constraint|)
    :documentation
     "The ordered set of Elements referenced by this Constraint.")
   (|context| :range |Namespace| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Namespace| |ownedRule|)
    :documentation
     "Specifies the Namespace that owns the Constraint.")
   (|specification| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningConstraint|)
    :documentation
     "A condition that must be true when evaluated in order for the Constraint
      to be satisfied.")))


;;; =========================================================
;;; ====================== Continuation
;;; =========================================================
(def-meta-class |Continuation| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_nixToZEeCmpu-HRutBsg")
 "A Continuation is a syntactic way to define continuations of different
  branches of an alternative CombinedFragment. Continuations are intuitively
  similar to labels representing intermediate points in a flow of control."
  ((|setting| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "True: when the Continuation is at the end of the enclosing InteractionFragment
      and False when it is in the beginning.")))


;;; =========================================================
;;; ====================== ControlFlow
;;; =========================================================
(def-meta-class |ControlFlow| 
   (:model :UML25 :superclasses (|ActivityEdge|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeurDoZEeCmpu-HRutBsg")
 "A control flow is an edge that starts an activity node after the previous
  one is finished."
  ())


;;; =========================================================
;;; ====================== ControlNode
;;; =========================================================
(def-meta-class |ControlNode| 
   (:model :UML25 :superclasses (|ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeusjoZEeCmpu-HRutBsg")
 "A control node is an abstract activity node that coordinates flows in an
  activity."
  ())


;;; =========================================================
;;; ====================== CreateLinkAction
;;; =========================================================
(def-meta-class |CreateLinkAction| 
   (:model :UML25 :superclasses (|WriteLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQQDoZEeCmpu-HRutBsg")
 "A create link action is a write link action for creating links."
  ((|endData| :range |LinkEndCreationData| :multiplicity (2 -1) :is-composite-p T :soft-opposite (|LinkEndCreationData| |createLinkAction|)
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))


;;; =========================================================
;;; ====================== CreateLinkObjectAction
;;; =========================================================
(def-meta-class |CreateLinkObjectAction| 
   (:model :UML25 :superclasses (|CreateLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQSjoZEeCmpu-HRutBsg")
 "A create link object action creates a link object."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |createLinkObjectAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


;;; =========================================================
;;; ====================== CreateObjectAction
;;; =========================================================
(def-meta-class |CreateObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQWDoZEeCmpu-HRutBsg")
 "A create object action is an action that creates an object that conforms
  to a statically specified classifier and puts it on an output pin at runtime."
  ((|classifier| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |createObjectAction|)
    :documentation
     "Classifier to be instantiated.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |createObjectAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


;;; =========================================================
;;; ====================== DataStoreNode
;;; =========================================================
(def-meta-class |DataStoreNode| 
   (:model :UML25 :superclasses (|CentralBufferNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeutToZEeCmpu-HRutBsg")
 "A data store node is a central buffer node for non-transient information."
  ())


;;; =========================================================
;;; ====================== DataType
;;; =========================================================
(def-meta-class |DataType| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwTToZEeCmpu-HRutBsg")
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


(def-meta-operation "inherit" |DataType| 
   "The inherit operation is overridden to exclude redefined properties."
   :operation-body
   "inhs->reject(inh |       inh.oclIsKindOf(RedefinableElement) and ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh.oclAsType(RedefinableElement)))->notEmpty())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

;;; =========================================================
;;; ====================== DecisionNode
;;; =========================================================
(def-meta-class |DecisionNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeuuDoZEeCmpu-HRutBsg")
 "A decision node is a control node that chooses between outgoing flows."
  ((|decisionInput| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |decisionNode|)
    :documentation
     "Provides input to guard specifications on edges outgoing from the decision
      node.")
   (|decisionInputFlow| :range |ObjectFlow| :multiplicity (0 1) :soft-opposite (|ObjectFlow| |decisionNode|)
    :documentation
     "An additional edge incoming to the decision node that provides a decision
      input value.")))


;;; =========================================================
;;; ====================== Dependency
;;; =========================================================
(def-meta-class |Dependency| 
   (:model :UML25 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3IzGzoZEeCmpu-HRutBsg")
 "A Dependency is a Relationship that signifies that a single or a set of
  model Elements requires other model Elements for their specification or
  implementation. This means that the complete semantics of the client Element(s)
  are either semantically or structurally dependent on the definition of
  the supplier Element(s)."
  ((|client| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|NamedElement| |clientDependency|)
    :documentation
     "The Element(s) dependent on the supplier Element(s). In some cases (such
      as a trace Abstraction) the assignment of direction (that is, the designation
      of the client Element) is at the discretion of the modeler and is a stipulation.")
   (|supplier| :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|NamedElement| |supplierDependency|)
    :documentation
     "The Element(s) on which the client Element(s) depend some respect.The modeler
      may stipulate a sense of Dependency direction suitable for their domain.")))


;;; =========================================================
;;; ====================== DeployedArtifact
;;; =========================================================
(def-meta-class |DeployedArtifact| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3CpzoZEeCmpu-HRutBsg")
 "A deployed artifact is an artifact or artifact instance that has been deployed
  to a deployment target."
  ())


;;; =========================================================
;;; ====================== Deployment
;;; =========================================================
(def-meta-class |Deployment| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3CqjoZEeCmpu-HRutBsg")
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
(def-meta-class |DeploymentSpecification| 
   (:model :UML25 :superclasses (|Artifact|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3CuDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== DeploymentTarget
;;; =========================================================
(def-meta-class |DeploymentTarget| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3CyjoZEeCmpu-HRutBsg")
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


(def-meta-operation "deployedElement.1" |DeploymentTarget| 
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
(def-meta-class |DestroyLinkAction| 
   (:model :UML25 :superclasses (|WriteLinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQazoZEeCmpu-HRutBsg")
 "A destroy link action is a write link action that destroys links and link
  objects."
  ((|endData| :range |LinkEndDestructionData| :multiplicity (2 -1) :is-composite-p T :soft-opposite (|LinkEndDestructionData| |destroyLinkAction|)
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))


;;; =========================================================
;;; ====================== DestroyObjectAction
;;; =========================================================
(def-meta-class |DestroyObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQcjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== DestructionOccurrenceSpecification
;;; =========================================================
(def-meta-class |DestructionOccurrenceSpecification| 
   (:model :UML25 :superclasses (|MessageOccurrenceSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_ni1DoZEeCmpu-HRutBsg")
 "A DestructionOccurenceSpecification models the destruction of an object."
  ())


;;; =========================================================
;;; ====================== Device
;;; =========================================================
(def-meta-class |Device| 
   (:model :UML25 :superclasses (|Node|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3C3DoZEeCmpu-HRutBsg")
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
    :xmi-id "_D3IzJToZEeCmpu-HRutBsg")
 "A DirectedRelationship represents a relationship between a collection of
  source model Elements and a collection of target model Elements."
  ((|source| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|)) :soft-opposite (|Element| |directedRelationship|)
    :documentation
     "Specifies the source Element(s) of the DirectedRelationship.")
   (|target| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|)) :soft-opposite (|Element| |directedRelationship|)
    :documentation
     "Specifies the target Element(s) of the DirectedRelationship.")))


;;; =========================================================
;;; ====================== Duration
;;; =========================================================
(def-meta-class |Duration| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTh9DoZEeCmpu-HRutBsg")
 "A Duration is a ValueSpecification that specifies the temporal distance
  between two time instants."
  ((|expr| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |duration|)
    :documentation
     "A ValueSpecification that evaluates to the value of the Duration.")
   (|observation| :range |Observation| :multiplicity (0 -1) :soft-opposite (|Observation| |duration|)
    :documentation
     "Refers to the Observations that are involved in the computation of the
      Duration value")))


;;; =========================================================
;;; ====================== DurationConstraint
;;; =========================================================
(def-meta-class |DurationConstraint| 
   (:model :UML25 :superclasses (|IntervalConstraint|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTh_joZEeCmpu-HRutBsg")
 "A DurationConstraint is a Constraint that refers to a DurationInterval."
  ((|firstEvent| :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to constrainedElement[i] (where i
      is 1 or 2). If firstEvent[i] is true, then the corresponding observation
      event is the first time instant the execution enters constrainedElement[i].
      If firstEvent[i] is false, then the corresponding observation event is
      the last time instant the execution is within constrainedElement[i].")
   (|specification| :range |DurationInterval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|DurationInterval| |durationConstraint|)
    :documentation
     "The DurationInterval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))


;;; =========================================================
;;; ====================== DurationInterval
;;; =========================================================
(def-meta-class |DurationInterval| 
   (:model :UML25 :superclasses (|Interval|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiCjoZEeCmpu-HRutBsg")
 "A DurationInterval defines the range between two Durations."
  ((|max| :range |Duration| :multiplicity (1 1) :soft-opposite (|Duration| |durationInterval|)
    :documentation
     "Refers to the Duration denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :range |Duration| :multiplicity (1 1) :soft-opposite (|Duration| |durationInterval|)
    :documentation
     "Refers to the Duration denoting the minimum value of the range." :redefined-property (|Interval| |min|))))


;;; =========================================================
;;; ====================== DurationObservation
;;; =========================================================
(def-meta-class |DurationObservation| 
   (:model :UML25 :superclasses (|Observation|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiEToZEeCmpu-HRutBsg")
 "A DurationObservation is a reference to a duration during an execution.
  It points out the NamedElement(s) in the model to observe and whether the
  observations are when this NamedElement is entered or when it is exited."
  ((|event| :range |NamedElement| :multiplicity (1 2) :soft-opposite (|NamedElement| |durationObservation|)
    :documentation
     "The DurationObservation is determined as the duration betweeo the entering
      or exiting of a single event Element during execution, or the entering/exiting
      of one event Element and the entering/exiting of a second.")
   (|firstEvent| :range |Boolean| :multiplicity (0 2)
    :documentation
     "The value of firstEvent[i] is related to event[i] (where i is 1 or 2).
      If firstEvent[i] is true, then the corresponding observation event is the
      first time instant the execution enters event[i]. If firstEvent[i] is false,
      then the corresponding observation event is the time instant the execution
      exits event[i].")))


;;; =========================================================
;;; ====================== Element
;;; =========================================================
(def-meta-class |Element| 
   (:model :UML25 :superclasses NIL 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3IzLjoZEeCmpu-HRutBsg")
 "An Element is a constituent of a model. As such, it has the capability
  of owning other Elements."
  ((|ownedComment| :range |Comment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|Comment| |owningElement|)
    :documentation
     "The Comments owned by this Element.")
   (|ownedElement| :range |Element| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :opposite (|Element| |owner|)
    :documentation
     "The Elements owned by this Element.")
   (|owner| :range |Element| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Element| |ownedElement|)
    :documentation
     "The Element that owns this Element.")))


(def-meta-operation "allOwnedElements" |Element| 
   "The query allOwnedElements() gives all of the direct and indirect ownedElements
    of an Element."
   :operation-body
   "ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Element|
                        :parameter-return-p T))
)

(def-meta-operation "mustBeOwned" |Element| 
   "The query mustBeOwned() indicates whether Elements of this type must have
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
(def-meta-class |ElementImport| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3IzTToZEeCmpu-HRutBsg")
 "An ElementImport identifies an Element in a different Namespace, and allows
  the Element to be referenced using its name without a qualifier in the
  Namespace owning the ElementImport."
  ((|alias| :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the name that should be added to the importing Namespace in lieu
      of the name of the imported PackagableElement. The alias must not clash
      with any other member in the importing Namespace. By default, no alias
      is used.")
   (|importedElement| :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|PackageableElement| |import|)
    :documentation
     "Specifies the PackageableElement whose name is to be added to a Namespace.")
   (|importingNamespace| :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |elementImport|)
    :documentation
     "Specifies the Namespace that imports a PackageableElement from another
      Namespace.")
   (|visibility| :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElement within the
      importingNamespace, i.e., whetherthe  importedElement will in turn be visible
      to other Namespaces. If the ElementImport is public, the importedElement
      will be visible outside the importingNamespace while, if the ElementImport
      is private, it will not")))


(def-meta-operation "getName" |ElementImport| 
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
(def-meta-class |EncapsulatedClassifier| 
   (:model :UML25 :superclasses (|StructuredClassifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMhToZEeCmpu-HRutBsg")
 "An EncapsulatedClassifier may own Ports to specify typed interaction points."
  ((|ownedPort| :range |Port| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|StructuredClassifier| |ownedAttribute|)) :soft-opposite (|Port| |encapsulatedClassifier|)
    :documentation
     "The Ports owned by the EncapsulatedClassifier.")))


(def-meta-operation "ownedPort.1" |EncapsulatedClassifier| 
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
(def-meta-class |Enumeration| 
   (:model :UML25 :superclasses (|DataType|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwYjoZEeCmpu-HRutBsg")
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
(def-meta-class |EnumerationLiteral| 
   (:model :UML25 :superclasses (|InstanceSpecification|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwaToZEeCmpu-HRutBsg")
 "An EnumerationLiteral is a user-defined data value for an Enumeration."
  ((|classifier| :range |Enumeration| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Enumeration| |enumerationLiteral|)
    :documentation
     "The classifier of this EnumerationLiteral derived to be equal to its Enumeration." :redefined-property (|InstanceSpecification| |classifier|))
   (|enumeration| :range |Enumeration| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Enumeration| |ownedLiteral|)
    :documentation
     "The Enumeration that this EnumerationLiteral is a member of.")))


(def-meta-operation "classifier.1" |EnumerationLiteral| 
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
(def-meta-class |Event| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZUzoZEeCmpu-HRutBsg")
 "An Event is the specification of some occurrence that may potentially trigger
  effects by an object."
  ())


;;; =========================================================
;;; ====================== ExceptionHandler
;;; =========================================================
(def-meta-class |ExceptionHandler| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeu2ToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ExecutableNode
;;; =========================================================
(def-meta-class |ExecutableNode| 
   (:model :UML25 :superclasses (|ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeu8ToZEeCmpu-HRutBsg")
 "An executable node is an abstract class for activity nodes that may be
  executed. It is used as an attachment point for exception handlers. AnA
  A executableA A nodeA A isA A anA A abstractA A classA A forA A activityA
  A nodesA A thatA A mayA A beA A executed.A A ItA A isA A usedA A asA A
  anA A attachmentA A pointA A forA A exceptionA A handlers."
  ((|handler| :range |ExceptionHandler| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ExceptionHandler| |protectedNode|)
    :documentation
     "A set of exception handlers that are examined if an uncaught exception
      propagates to the outer level of the executable node.")))


;;; =========================================================
;;; ====================== ExecutionEnvironment
;;; =========================================================
(def-meta-class |ExecutionEnvironment| 
   (:model :UML25 :superclasses (|Node|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3C3zoZEeCmpu-HRutBsg")
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
    :xmi-id "_F_ni2joZEeCmpu-HRutBsg")
 "An ExecutionOccurrenceSpecification represents moments in time at which
  Actions or Behaviors start or finish."
  ((|execution| :range |ExecutionSpecification| :multiplicity (1 1) :soft-opposite (|ExecutionSpecification| |executionOccurrenceSpecification|)
    :documentation
     "References the execution specification describing the execution that is
      started or finished at this execution event.")))


;;; =========================================================
;;; ====================== ExecutionSpecification
;;; =========================================================
(def-meta-class |ExecutionSpecification| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_ni3zoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ExpansionNode
;;; =========================================================
(def-meta-class |ExpansionNode| 
   (:model :UML25 :superclasses (|ObjectNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQgzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ExpansionRegion
;;; =========================================================
(def-meta-class |ExpansionRegion| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQjzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Expression
;;; =========================================================
(def-meta-class |Expression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiHjoZEeCmpu-HRutBsg")
 "An Expression represents a node in an expression tree, which may be non-terminal
  or terminal. It defines a symbol, and has a possibly empty sequence of
  operands that are ValueSpecifications. It denotes a (possibly empty) set
  of values when evaluated in a context."
  ((|operand| :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |expression|)
    :documentation
     "Specifies a sequence of operand ValueSpecifications.")
   (|symbol| :range |String| :multiplicity (0 1)
    :documentation
     "The symbol associated with this node in the expression tree.")))


;;; =========================================================
;;; ====================== Extend
;;; =========================================================
(def-meta-class |Extend| 
   (:model :UML25 :superclasses (|NamedElement| |DirectedRelationship|) 
    :packages (UML |UseCases|) 
    :xmi-id "_LuSThjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Extension
;;; =========================================================
(def-meta-class |Extension| 
   (:model :UML25 :superclasses (|Association|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8frzoZEeCmpu-HRutBsg")
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


(def-meta-operation "isRequired.1" |Extension| 
   "The query isRequired() is true if the owned end has a multiplicity with
    the lower bound of 1."
   :operation-body
   "ownedEnd.lowerBound() = 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "metaclass.1" |Extension| 
   "The query metaclass() returns the metaclass that is being extended (as
    opposed to the extending stereotype)."
   :operation-body
   "metaclassEnd().type.oclAsType(Class)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Class|
                        :parameter-return-p T))
)

(def-meta-operation "metaclassEnd" |Extension| 
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
(def-meta-class |ExtensionEnd| 
   (:model :UML25 :superclasses (|Property|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8fzjoZEeCmpu-HRutBsg")
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


(def-meta-operation "lowerBound" |ExtensionEnd| 
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
(def-meta-class |ExtensionPoint| 
   (:model :UML25 :superclasses (|RedefinableElement|) 
    :packages (UML |UseCases|) 
    :xmi-id "_LuSTlzoZEeCmpu-HRutBsg")
 "An ExtensionPoint identifies a point in the behavior of a UseCase where
  that behavior can be extended by the behavior of some other (extending)
  UseCase, as specified by an Extend relationship."
  ((|useCase| :range |UseCase| :multiplicity (1 1)
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
    :xmi-id "_CHsPIzoZEeCmpu-HRutBsg")
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
(def-meta-class |FinalNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHeu-ToZEeCmpu-HRutBsg")
 "A final node is an abstract control node at which a flow in an activity
  stops."
  ())


;;; =========================================================
;;; ====================== FinalState
;;; =========================================================
(def-meta-class |FinalState| 
   (:model :UML25 :superclasses (|State|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AAToZEeCmpu-HRutBsg")
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
    :xmi-id "_BHeu_zoZEeCmpu-HRutBsg")
 "A flow final node is a final node that terminates a flow."
  ())


;;; =========================================================
;;; ====================== ForkNode
;;; =========================================================
(def-meta-class |ForkNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevAjoZEeCmpu-HRutBsg")
 "A fork node is a control node that splits a flow into multiple concurrent
  flows."
  ())


;;; =========================================================
;;; ====================== FunctionBehavior
;;; =========================================================
(def-meta-class |FunctionBehavior| 
   (:model :UML25 :superclasses (|OpaqueBehavior|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZVjoZEeCmpu-HRutBsg")
 "A FunctionBehavior is an OpaqueBehavior that does not access or modify
  any objects or other external data."
  ())


(def-meta-operation "hasAllDataTypeAttributes" |FunctionBehavior| 
   "The hasAllDataTypeAttributes query tests whether the types of the attributes
    of the given DataType are all DataTypes, and similarly for all those DataTypes."
   :operation-body
   "d.ownedAttribute->forAll(a |      a.type.oclIsKindOf(DataType) and        hasAllDataTypeAttributes(a.type.oclAsType(DataType)))"
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
    :xmi-id "_F_ni6ToZEeCmpu-HRutBsg")
 "A Gate is a MessageEnd which serves as a connection point for relating
  a Message which has a MessageEnd (sendEvent / receiveEvent) outside an
  InteractionFragment with another Message which has a MessageEnd (receiveEvent
  / sendEvent)  inside that InteractionFragment."
  ())


(def-meta-operation "getName" |Gate| 
   "This query returns the name of the gate, either the explicit name (.name)
    or the constructed name ('out_' or 'in_' concatenated in front of .message.name)
    if the explicit name is not present."
   :operation-body
   "if name->notEmpty() then name->asOrderedSet()->first()  else  if isActual() or isOutsideCF()     then if isSend()       then 'out_'.concat(self.message.name->asOrderedSet()->first())      else 'in_'.concat(self.message.name->asOrderedSet()->first())      endif    else if isSend()      then 'in_'.concat(self.message.name->asOrderedSet()->first())      else 'out_'.concat(self.message.name->asOrderedSet()->first())      endif    endif  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "isActual" |Gate| 
   "This query returns true value if this Gate is an actualGate of an InteractionUse"
   :operation-body
   "interactionUse->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isFormal" |Gate| 
   "This query returns true if this Gate is a formalGat of an Interaction."
   :operation-body
   "interaction->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isInsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present) is inside of an InteractionOperator of the
    same CombindedFragment."
   :operation-body
   "self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies  let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in  if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)   then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification)   in combinedFragment = oppMOS.enclosingOperand.combinedFragment  else let oppGate : Gate = oppEnd.oclAsType(Gate)   in combinedFragment = oppGate.combinedFragment  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isOutsideCF" |Gate| 
   "This query returns true if this Gate is attached to the boundary of a CombinedFragment,
    and its other end (if present)  is outside of the same CombindedFragment."
   :operation-body
   "self.oppositeEnd()-> notEmpty() and combinedFragment->notEmpty() implies  let oppEnd : MessageEnd = self.oppositeEnd()->asOrderedSet()->first() in  if oppEnd.oclIsKindOf(MessageOccurrenceSpecification)   then let oppMOS : MessageOccurrenceSpecification = oppEnd.oclAsType(MessageOccurrenceSpecification)  in  self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =       oppMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(oppMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet())  else let oppGate : Gate = oppEnd.oclAsType(Gate)   in self.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(self.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet()) =       oppGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(oppGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet())  endif"
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
    value)"
   :operation-body
   "self.getName() = gateToMatch.getName() and   self.message.messageSort = gateToMatch.message.messageSort and  self.message.name = gateToMatch.message.name and  self.message.sendEvent->includes(self) implies gateToMatch.message.receiveEvent->includes(gateToMatch)  and  self.message.receiveEvent->includes(self) implies gateToMatch.message.sendEvent->includes(gateToMatch) and  self.message.signature = gateToMatch.message.signature"
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
    :xmi-id "_F_ni8joZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Generalization
;;; =========================================================
(def-meta-class |Generalization| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Classification|) 
    :xmi-id "_CHsPLToZEeCmpu-HRutBsg")
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
(def-meta-class |GeneralizationSet| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "_CHsPQDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Image
;;; =========================================================
(def-meta-class |Image| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8f5DoZEeCmpu-HRutBsg")
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
(def-meta-class |Include| 
   (:model :UML25 :superclasses (|DirectedRelationship| |NamedElement|) 
    :packages (UML |UseCases|) 
    :xmi-id "_LuSTnzoZEeCmpu-HRutBsg")
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
(def-meta-class |InformationFlow| 
   (:model :UML25 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (UML |InformationFlows|) 
    :xmi-id "_FQPSwToZEeCmpu-HRutBsg")
 "InformationFlows describe circulation of information through a system in
  a general manner. They do not specify the nature of the information, mechanisms
  by which it is conveyed, sequences of exchange or any control conditions.
  During more detailed modeling, representation and realization links may
  be added to specify which model elements implement an InformationFlow and
  to show how information is conveyed.  InformationFlows require some kind
  of A A A information channelA A A  for unidirectional transmission of information
  items from sources to targets.A A  They specify the information channelA
  A A s realizations, if any, and identify the information that flows along
  them.A A  Information moving along the information channel may be represented
  by abstract InformationItems and by concrete Classifiers."
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


;;; =========================================================
;;; ====================== InformationItem
;;; =========================================================
(def-meta-class |InformationItem| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |InformationFlows|) 
    :xmi-id "_FQPS5zoZEeCmpu-HRutBsg")
 "InformationItems represent many kinds of information that can flow from
  sources to targets in very abstract ways.A A  They represent the kinds
  of information that may move within a system, but do not elaborate details
  of the transferred information.A A  Details of transferred information
  are the province of other Classifiers that may ultimately define InformationItems.A
  A  Consequently, InformationItems cannot be instantiated and do not themselves
  have features, generalizations, or associations.A A An important use of
  InformationItems is to represent information during early design stages,
  possibly before the detailed modeling decisions that will ultimately define
  them have been made. Another purpose of InformationItems is to abstract
  portions of complex models in less precise, but perhaps more general and
  communicable, ways."
  ((|represented| :range |Classifier| :multiplicity (0 -1) :soft-opposite (|Classifier| |representation|)
    :documentation
     "Determines the classifiers that will specify the structure and nature of
      the information. An information item represents all its represented classifiers.")))


;;; =========================================================
;;; ====================== InitialNode
;;; =========================================================
(def-meta-class |InitialNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevCzoZEeCmpu-HRutBsg")
 "An initial node is a control node at which flow starts when the activity
  is invoked."
  ())


;;; =========================================================
;;; ====================== InputPin
;;; =========================================================
(def-meta-class |InputPin| 
   (:model :UML25 :superclasses (|Pin|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQnzoZEeCmpu-HRutBsg")
 "An input pin is a pin that holds input values to be consumed by an action."
  ())


;;; =========================================================
;;; ====================== InstanceSpecification
;;; =========================================================
(def-meta-class |InstanceSpecification| 
   (:model :UML25 :superclasses (|DeploymentTarget| |PackageableElement| |DeployedArtifact|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH18-DoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== InstanceValue
;;; =========================================================
(def-meta-class |InstanceValue| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH19FToZEeCmpu-HRutBsg")
 "An InstanceValue is a ValueSpecification that identifies an instance."
  ((|instance| :range |InstanceSpecification| :multiplicity (1 1) :soft-opposite (|InstanceSpecification| |instanceValue|)
    :documentation
     "The InstanceSpecification that represents the specified value.")))


;;; =========================================================
;;; ====================== Interaction
;;; =========================================================
(def-meta-class |Interaction| 
   (:model :UML25 :superclasses (|InteractionFragment| |Behavior|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_ni_DoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== InteractionConstraint
;;; =========================================================
(def-meta-class |InteractionConstraint| 
   (:model :UML25 :superclasses (|Constraint|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_njFDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== InteractionFragment
;;; =========================================================
(def-meta-class |InteractionFragment| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_njLzoZEeCmpu-HRutBsg")
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
(def-meta-class |InteractionOperand| 
   (:model :UML25 :superclasses (|InteractionFragment| |Namespace|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wpszoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== InteractionUse
;;; =========================================================
(def-meta-class |InteractionUse| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wpxDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Interface
;;; =========================================================
(def-meta-class |Interface| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTweDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== InterfaceRealization
;;; =========================================================
(def-meta-class |InterfaceRealization| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwlzoZEeCmpu-HRutBsg")
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
(def-meta-class |InterruptibleActivityRegion| 
   (:model :UML25 :superclasses (|ActivityGroup|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevFDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Interval
;;; =========================================================
(def-meta-class |Interval| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiKToZEeCmpu-HRutBsg")
 "An Interval defines the range between two ValueSpecifications."
  ((|max| :range |ValueSpecification| :multiplicity (1 1) :soft-opposite (|ValueSpecification| |interval|)
    :documentation
     "Refers to the ValueSpecification denoting the maximum value of the range.")
   (|min| :range |ValueSpecification| :multiplicity (1 1) :soft-opposite (|ValueSpecification| |interval|)
    :documentation
     "Refers to the ValueSpecification denoting the minimum value of the range.")))


;;; =========================================================
;;; ====================== IntervalConstraint
;;; =========================================================
(def-meta-class |IntervalConstraint| 
   (:model :UML25 :superclasses (|Constraint|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiMDoZEeCmpu-HRutBsg")
 "An IntervalConstraint is a Constraint that is specified by an Intervall."
  ((|specification| :range |Interval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|Interval| |intervalConstraint|)
    :documentation
     "The Interval that specifies the condition of the IntervalConstraint." :redefined-property (|Constraint| |specification|))))


;;; =========================================================
;;; ====================== InvocationAction
;;; =========================================================
(def-meta-class |InvocationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQpToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== JoinNode
;;; =========================================================
(def-meta-class |JoinNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevIjoZEeCmpu-HRutBsg")
 "A join node is a control node that synchronizes multiple flows. Join nodes
  have a Boolean value specification using the names of the incoming edges
  to specify the conditions under which the join will emit a token."
  ((|isCombineDuplicate| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether tokens having objects with the same identity are combined
      into one by the join.")
   (|joinSpec| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |joinNode|)
    :documentation
     "A specification giving the conditions under which the join will emit a
      token.")))


;;; =========================================================
;;; ====================== Lifeline
;;; =========================================================
(def-meta-class |Lifeline| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wp6ToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== LinkAction
;;; =========================================================
(def-meta-class |LinkAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQszoZEeCmpu-HRutBsg")
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


(def-meta-operation "association" |LinkAction| 
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
(def-meta-class |LinkEndCreationData| 
   (:model :UML25 :superclasses (|LinkEndData|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQyzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== LinkEndData
;;; =========================================================
(def-meta-class |LinkEndData| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQ2joZEeCmpu-HRutBsg")
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
     "AssociationA A endA A forA A whichA A thisA A link-endA A dataA A specifiesA
      A values.")
   (|qualifier| :range |QualifierValue| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|QualifierValue| |linkEndData|)
    :documentation
     "List of qualifier values")
   (|value| :range |InputPin| :multiplicity (0 1) :soft-opposite (|InputPin| |linkEndData|)
    :documentation
     "Input pin that provides the specified object for the given end. This pin
      is omitted if the link-end data specifies an 'open' end for reading.")))


;;; =========================================================
;;; ====================== LinkEndDestructionData
;;; =========================================================
(def-meta-class |LinkEndDestructionData| 
   (:model :UML25 :superclasses (|LinkEndData|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknQ9ToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== LiteralBoolean
;;; =========================================================
(def-meta-class |LiteralBoolean| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiNToZEeCmpu-HRutBsg")
 "A LiteralBoolean is a specification of a Boolean value."
  ((|value| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "The specified Boolean value.")))


(def-meta-operation "booleanValue" |LiteralBoolean| 
   "The query booleanValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralBoolean| 
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
(def-meta-class |LiteralInteger| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiRToZEeCmpu-HRutBsg")
 "A LiteralInteger is a specification of an Integer value."
  ((|value| :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The specified Integer value.")))


(def-meta-operation "integerValue" |LiteralInteger| 
   "The query integerValue() gives the value."
   :operation-body
   "value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralInteger| 
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
(def-meta-class |LiteralNull| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiVToZEeCmpu-HRutBsg")
 "A LiteralNull specifies the lack of a value."
  ())


(def-meta-operation "isComputable" |LiteralNull| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |LiteralNull| 
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
(def-meta-class |LiteralReal| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiYjoZEeCmpu-HRutBsg")
 "A LiteralReal is a specification of a Real value."
  ((|value| :range |Real| :multiplicity (1 1)
    :documentation
     "The specified Real value.")))


(def-meta-operation "isComputable" |LiteralReal| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "realValue" |LiteralReal| 
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
(def-meta-class |LiteralSpecification| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTicDoZEeCmpu-HRutBsg")
 "A LiteralSpecification identifies a literal constant being modeled."
  ())


;;; =========================================================
;;; ====================== LiteralString
;;; =========================================================
(def-meta-class |LiteralString| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiczoZEeCmpu-HRutBsg")
 "A LiteralString is a specification of a String value."
  ((|value| :range |String| :multiplicity (0 1)
    :documentation
     "The specified String value.")))


(def-meta-operation "isComputable" |LiteralString| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |LiteralString| 
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
(def-meta-class |LiteralUnlimitedNatural| 
   (:model :UML25 :superclasses (|LiteralSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTigzoZEeCmpu-HRutBsg")
 "A LiteralUnlimitedNatural is a specification of an UnlimitedNatural number."
  ((|value| :range |UnlimitedNatural| :multiplicity (1 1) :default 0
    :documentation
     "The specified UnlimitedNatural value.")))


(def-meta-operation "isComputable" |LiteralUnlimitedNatural| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |LiteralUnlimitedNatural| 
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
(def-meta-class |LoopNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRBDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Manifestation
;;; =========================================================
(def-meta-class |Manifestation| 
   (:model :UML25 :superclasses (|Abstraction|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3C4joZEeCmpu-HRutBsg")
 "A manifestation is the concrete physical rendering of one or more model
  elements by an artifact."
  ((|utilizedElement| :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|)) :soft-opposite (|PackageableElement| |manifestation|)
    :documentation
     "The model element that is utilized in the manifestation in an Artifact.")))


;;; =========================================================
;;; ====================== MergeNode
;;; =========================================================
(def-meta-class |MergeNode| 
   (:model :UML25 :superclasses (|ControlNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevMToZEeCmpu-HRutBsg")
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
    :xmi-id "_F_wqBDoZEeCmpu-HRutBsg")
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


(def-meta-operation "isDistinguishableFrom" |Message| 
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

(def-meta-operation "messageKind.1" |Message| 
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
(def-meta-class |MessageEnd| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wqOToZEeCmpu-HRutBsg")
 "MessageEnd is an abstract specialization of NamedElement that represents
  what can occur at the end of a Message."
  ((|message| :range |Message| :multiplicity (0 1) :soft-opposite (|Message| |messageEnd|)
    :documentation
     "References a Message.")))


(def-meta-operation "enclosingFragment" |MessageEnd| 
   "This query returns a set including the enclosing InteractionFragment this
    MessageEnd is enclosed within"
   :operation-body
   "if self->select(oclIsKindOf(Gate))->notEmpty()   then -- it is a Gate  let endGate : Gate =     self->select(oclIsKindOf(Gate)).oclAsType(Gate)->asOrderedSet()->first()    in    if endGate.isOutsideCF()     then endGate.combinedFragment.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(endGate.combinedFragment.enclosingOperand.oclAsType(InteractionFragment)->asSet())    else if endGate.isInsideCF()       then endGate.combinedFragment.oclAsType(InteractionFragment)->asSet()      else if endGate.isFormal()         then endGate.interaction.oclAsType(InteractionFragment)->asSet()        else if endGate.isActual()           then endGate.interactionUse.enclosingInteraction.oclAsType(InteractionFragment)->asSet()->       union(endGate.interactionUse.enclosingOperand.oclAsType(InteractionFragment)->asSet())          else null          endif        endif      endif    endif  else -- it is a MessageOccurrenceSpecification  let endMOS : MessageOccurrenceSpecification  =     self->select(oclIsKindOf(MessageOccurrenceSpecification)).oclAsType(MessageOccurrenceSpecification)->asOrderedSet()->first()     in    if endMOS.enclosingInteraction->notEmpty()     then endMOS.enclosingInteraction.oclAsType(InteractionFragment)->asSet()    else endMOS.enclosingOperand.oclAsType(InteractionFragment)->asSet()    endif  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|InteractionFragment|
                        :parameter-return-p T))
)

(def-meta-operation "isReceive" |MessageEnd| 
   "This query returns value true if this MessageEnd is a receiveEvent"
   :operation-body
   "message.receiveEvent->asSet()->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isSend" |MessageEnd| 
   "This query returns value true if this MessageEnd is a sendEvent"
   :operation-body
   "message.sendEvent->asSet()->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "oppositeEnd" |MessageEnd| 
   "This query returns a set including the MessageEnd (if exists) at the opposite
    end of the Message for this MessageEnd"
   :operation-body
   "message->asSet().messageEnd->asSet()->excluding(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|MessageEnd|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== MessageEvent
;;; =========================================================
(def-meta-class |MessageEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZXzoZEeCmpu-HRutBsg")
 "A MessageEvent specifies the receipt by an object of either an Operation
  call or a Signal instance."
  ())


;;; =========================================================
;;; ====================== MessageOccurrenceSpecification
;;; =========================================================
(def-meta-class |MessageOccurrenceSpecification| 
   (:model :UML25 :superclasses (|MessageEnd| |OccurrenceSpecification|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wqPzoZEeCmpu-HRutBsg")
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
    :xmi-id "_IH8f8DoZEeCmpu-HRutBsg")
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
(def-meta-class |MultiplicityElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3IzZToZEeCmpu-HRutBsg")
 "A multiplicity is a definition of an inclusive interval of non-negative
  integers beginning with a lower bound and ending with a (possibly infinite)
  upper bound. A MultiplicityElement embeds this information to specify the
  allowable cardinalities for an instantiation of the Element."
  ((|isOrdered| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "For a multivalued multiplicity, this attribute specifies whether the values
      in an instantiation of this MultiplicityElement are sequentially ordered.")
   (|isUnique| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a multivalued multiplicity, this attributes specifies whether the values
      in an instantiation of this MultiplicityElement are unique.")
   (|lower| :range |Integer| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "The lower bound of the multiplicity interval.")
   (|lowerValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningLower|)
    :documentation
     "The specification of the lower bound for this multiplicity.")
   (|upper| :range |UnlimitedNatural| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "The upper bound of the multiplicity interval.")
   (|upperValue| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |owningUpper|)
    :documentation
     "The specification of the upper bound for this multiplicity.")))


(def-meta-operation "compatibleWith" |MultiplicityElement| 
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

(def-meta-operation "includesMultiplicity" |MultiplicityElement| 
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

(def-meta-operation "is" |MultiplicityElement| 
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

(def-meta-operation "isMultivalued" |MultiplicityElement| 
   "The query isMultivalued() checks whether this multiplicity has an upper
    bound greater than one."
   :operation-body
   "upperBound() > 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |MultiplicityElement| 
   "The derived lower attribute must equal the lowerBound."
   :operation-body
   "lowerBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "lowerBound" |MultiplicityElement| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    integer, which is the integerValue of lowerValue, if this is given, and
    1 otherwise."
   :operation-body
   "if lowerValue=null then 1 else lowerValue.integerValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |MultiplicityElement| 
   "The derived upper attribute must equal the upperBound."
   :operation-body
   "upperBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-meta-operation "upperBound" |MultiplicityElement| 
   "The query upperBound() returns the upper bound of the multiplicity for
    a bounded multiplicity as an unlimited natural, which is the unlimitedNaturalValue
    of upperValue, if given, and 1, otherwise."
   :operation-body
   "if upperValue=null then 1 else upperValue.unlimitedValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== NamedElement
;;; =========================================================
(def-meta-class |NamedElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3ShVToZEeCmpu-HRutBsg")
 "A NamedElement is an Element in a model that may have a name. The name
  may be given directly and/or via the use of a StringExpression."
  ((|clientDependency| :range |Dependency| :multiplicity (0 -1)
    :opposite (|Dependency| |client|)
    :documentation
     "Indicates the Dependencies that reference this NamedElement as a client.")
   (|name| :range |String| :multiplicity (0 1)
    :documentation
     "The name of the NamedElement.")
   (|nameExpression| :range |StringExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|StringExpression| |namedElement|)
    :documentation
     "The StringExpression used to define the name of this NamedElement.")
   (|namespace| :range |Namespace| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Namespace| |ownedMember|)
    :documentation
     "Specifies the Namespace that owns the NamedElement.")
   (|qualifiedName| :range |String| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A name which allows the NamedElement to be identified within a hierarchy
      of nested Namespaces. It is constructed from the names of the containing
      Namespaces starting at the root of the hierarchy and ending with the name
      of the NamedElement itself.")
   (|visibility| :range |VisibilityKind| :multiplicity (0 1)
    :documentation
     "Determines whether and how the NamedElement is visible outside its owning
      Namespace.")))


(def-meta-operation "allNamespaces" |NamedElement| 
   "The query allNamespaces() gives the sequence of Namespaces in which the
    NamedElement is nested, working outwards."
   :operation-body
   "if namespace->isEmpty() then OrderedSet{} else namespace.allNamespaces()->prepend(namespace) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T))
)

(def-meta-operation "allOwningPackages" |NamedElement| 
   "The query allOwningPackages() returns all the Packages that in which this
    NamedElement is directly or indirectly contained, without any intervening
    Namespace that is not a Package."
   :operation-body
   "if namespace.oclIsKindOf(Package)  then    let owningPackage : Package = namespace.oclAsType(Package) in      owningPackage->union(owningPackage.allOwningPackages())  else    null  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-meta-operation "isDistinguishableFrom" |NamedElement| 
   "The query isDistinguishableFrom() determines whether two NamedElements
    may logically co-exist within a Namespace. By default, two named elements
    are distinguishable if (a) they have types neither of which is a kind of
    the other or (b) they have different names."
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

(def-meta-operation "qualifiedName.1" |NamedElement| 
   "When a NamedElement has a name, and all of its containing Namespaces have
    a name, the qualifiedName is constructed from the name of the NamedElement
    and the names of the containing Namespaces."
   :operation-body
   "if self.name <> null and self.allNamespaces()->select( ns | ns.name=null )->isEmpty() then      self.allNamespaces()->iterate( ns : Namespace; agg: String = self.name | ns.name.concat(self.separator()).concat(agg)) else    null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "separator" |NamedElement| 
   "The query separator() gives the string that is used to separate names when
    constructing a qualifiedName."
   :operation-body
   "'::'"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-meta-class |Namespace| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3ShmjoZEeCmpu-HRutBsg")
 "A Namespace is an Element in a model that owns and/or imports a set of
  NamedElements that can be identified by name."
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


(def-meta-operation "excludeCollisions" |Namespace| 
   "The query excludeCollisions() excludes from a set of PackageableElements
    any that would not be distinguishable from each other in this Namespace."
   :operation-body
   "imps->reject(imp1  | imps->exists(imp2 | not imp1.isDistinguishableFrom(imp2, self)))"
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
   "if self.ownedMember ->includes(element) then Set{element.name} else let elementImports : Set(ElementImport) = self.elementImport->select(ei | ei.importedElement = element) in   if elementImports->notEmpty()   then      elementImports->collect(el | el.getName())->asSet()   else       self.packageImport->select(pi | pi.importedPackage.visibleMembers().oclAsType(NamedElement)->includes(element))-> collect(pi | pi.importedPackage.getNamesOfMember(element))->asSet()   endif endif"
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
    also excludes PackageableElements that would have the same name as each
    other when imported."
   :operation-body
   "self.excludeCollisions(imps)->select(imp | self.ownedMember->forAll(mem | imp.isDistinguishableFrom(mem, self)))"
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
   "self.importMembers(elementImport.importedElement->asSet()->union(packageImport.importedPackage->collect(p | p.visibleMembers()))->asSet())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T))
)

(def-meta-operation "membersAreDistinguishable" |Namespace| 
   "The Boolean query membersAreDistinguishable() determines whether all of
    the Namespace's members are distinguishable within it."
   :operation-body
   "member->forAll( memb |    member->excluding(memb)->forAll(other |        memb.isDistinguishableFrom(other, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== Node
;;; =========================================================
(def-meta-class |Node| 
   (:model :UML25 :superclasses (|Class| |DeploymentTarget|) 
    :packages (UML |Deployments|) 
    :xmi-id "_En3C5zoZEeCmpu-HRutBsg")
 "A node is computational resource upon which artifacts may be deployed for
  execution. Nodes can be interconnected through communication paths to define
  network structures."
  ((|nestedNode| :range |Node| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|)) :soft-opposite (|Node| |node|)
    :documentation
     "The Nodes that are defined (nested) within the Node.")))


;;; =========================================================
;;; ====================== ObjectFlow
;;; =========================================================
(def-meta-class |ObjectFlow| 
   (:model :UML25 :superclasses (|ActivityEdge|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevOjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ObjectNode
;;; =========================================================
(def-meta-class |ObjectNode| 
   (:model :UML25 :superclasses (|TypedElement| |ActivityNode|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevYjoZEeCmpu-HRutBsg")
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
   (|upperBound| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |objectNode|)
    :documentation
     "The maximum number of tokens allowed in the node. Objects cannot flow into
      the node if the upper bound is reached.")))


;;; =========================================================
;;; ====================== Observation
;;; =========================================================
(def-meta-class |Observation| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTikzoZEeCmpu-HRutBsg")
 "Observation specifies a value determined by observing an event or events
  that occur relative to other model Elements."
  ())


;;; =========================================================
;;; ====================== OccurrenceSpecification
;;; =========================================================
(def-meta-class |OccurrenceSpecification| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wqQzoZEeCmpu-HRutBsg")
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
(def-meta-class |OpaqueAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRMzoZEeCmpu-HRutBsg")
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
(def-meta-class |OpaqueBehavior| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZYjoZEeCmpu-HRutBsg")
 "An OpaqueBehavior is a Behavior whose specification is given in a textual
  language other than UML."
  ((|body| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the behavior in one or more languages.")
   (|language| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Languages the body strings use in the same order as the body strings.")))


;;; =========================================================
;;; ====================== OpaqueExpression
;;; =========================================================
(def-meta-class |OpaqueExpression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTiljoZEeCmpu-HRutBsg")
 "An OpaqueExpression is a ValueSpecification that specifies the computation
  of a set of values either in terms of a UML Behavior or based on a textual
  statement in a language other than UML"
  ((|behavior| :range |Behavior| :multiplicity (0 1) :soft-opposite (|Behavior| |opaqueExpression|)
    :documentation
     "Specifies the behavior of the OpaqueExpression as a UML Behavior.")
   (|body| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "A textual definition of the behavior of the OpaqueExpression, possibly
      in multiple languages.")
   (|language| :range |String| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "Specifies the languages used to express the textual bodies of the OpaqueExpression.
       Languages are matched to body Strings by order. The interpretation of
      the the body depends on the languages. If the languages are unspecified,
      they may be implicit from the expression body or the context.")
   (|result| :range |Parameter| :multiplicity (0 1) :is-readonly-p T :is-derived-p T :soft-opposite (|Parameter| |opaqueExpression|)
    :documentation
     "If an OpaqueExpression is specified using a UML Behavior, then this refers
      to the single required return Parameter of that Behavior. When the Behavior
      completes execution, the values on this Parameter give the result of evaluating
      the OpaqueExpression.")))


(def-meta-operation "isIntegral" |OpaqueExpression| 
   "The query isIntegral() tells whether an expression is intended to produce
    an Integer."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNonNegative" |OpaqueExpression| 
   "The query isNonNegative() tells whether an integer expression has a non-negative
    value."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isPositive" |OpaqueExpression| 
   "The query isPositive() tells whether an integer expression has a positive
    value."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "result.1" |OpaqueExpression| 
   "Missing derivation for OpaqueExpression::/result : Parameter"
   :operation-body
   "if behavior = null then   null  else   behavior.ownedParameter->first()  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "value" |OpaqueExpression| 
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
(def-meta-class |Operation| 
   (:model :UML25 :superclasses (|TemplateableElement| |ParameterableElement| |BehavioralFeature|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH19GjoZEeCmpu-HRutBsg")
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


(def-meta-operation "isConsistentWith" |Operation| 
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
   "redefinee.oclIsKindOf(Operation) and  let op : Operation = redefinee.oclAsType(Operation) in   self.ownedParameter->size() = op.ownedParameter->size() and   Sequence{1..self.ownedParameter->size()}->    forAll(i |op.ownedParameter->at(1).type.conformsTo(self.ownedParameter->at(i).type))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isOrdered.1" |Operation| 
   "If this operation has a return parameter, isOrdered equals the value of
    isOrdered for that parameter. Otherwise isOrdered is false."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()-> exists(isOrdered) else false endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isUnique.1" |Operation| 
   "If this operation has a return parameter, isUnique equals the value of
    isUnique for that parameter. Otherwise isUnique is true."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->exists(isUnique) else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |Operation| 
   "If this operation has a return parameter, lower equals the value of lower
    for that parameter. Otherwise lower is not defined."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->any(true).lower else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "returnResult" |Operation| 
   "The query returnResult() returns the set containing the return parameter
    of the Operation if one exists, otherwise, it returns an empty set"
   :operation-body
   "ownedParameter->select (direction = ParameterDirectionKind::return)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "type.1" |Operation| 
   "If this operation has a return parameter, type equals the value of type
    for that parameter. Otherwise type is not defined."
   :operation-body
   "if returnResult()->notEmpty() then returnResult()->any(true).type else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |Operation| 
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
(def-meta-class |OperationTemplateParameter| 
   (:model :UML25 :superclasses (|TemplateParameter|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH19jToZEeCmpu-HRutBsg")
 "An OperationTemplateParameter exposes an Operation as a formal parameter
  for a template."
  ((|parameteredElement| :range |Operation| :multiplicity (1 1)
    :opposite (|Operation| |templateParameter|)
    :documentation
     "The Operation exposed by this OperationTemplateParameter." :redefined-property (|TemplateParameter| |parameteredElement|))))


;;; =========================================================
;;; ====================== OutputPin
;;; =========================================================
(def-meta-class |OutputPin| 
   (:model :UML25 :superclasses (|Pin|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRRjoZEeCmpu-HRutBsg")
 "An output pin is a pin that holds output values produced by an action."
  ())


;;; =========================================================
;;; ====================== Package
;;; =========================================================
(def-meta-class |Package| 
   (:model :UML25 :superclasses (|PackageableElement| |TemplateableElement| |Namespace|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8f9joZEeCmpu-HRutBsg")
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


(def-meta-operation "allApplicableStereotypes" |Package| 
   "The query allApplicableStereotypes() returns all the directly or indirectly
    owned stereotypes, including stereotypes contained in sub-profiles."
   :operation-body
   "let ownedPackages : Bag(Package) = ownedMember->select(oclIsKindOf(Package))->collect(oclAsType(Package)) in   ownedStereotype->union(ownedPackages.allApplicableStereotypes())->flatten()->asSet()  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

(def-meta-operation "containingProfile" |Package| 
   "The query containingProfile() returns the closest profile directly or indirectly
    containing this package (or this package itself, if it is a profile)."
   :operation-body
   "if self.oclIsKindOf(Profile) then    self.oclAsType(Profile)  else   self.namespace.oclAsType(Package).containingProfile()  endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-meta-operation "makesVisible" |Package| 
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

(def-meta-operation "mustBeOwned" |Package| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "nestedPackage.1" |Package| 
   "Missing derivation for Package::/nestedPackage : Package"
   :operation-body
   "packagedElement->select(oclIsKindOf(Package))->collect(oclAsType(Package))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-meta-operation "ownedStereotype.1" |Package| 
   "Missing derivation for Package::/ownedStereotype : Stereotype"
   :operation-body
   "packagedElement->select(oclIsKindOf(Stereotype))->collect(oclAsType(Stereotype))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Stereotype|
                        :parameter-return-p T))
)

(def-meta-operation "ownedType.1" |Package| 
   "Missing derivation for Package::/ownedType : Type"
   :operation-body
   "packagedElement->select(oclIsKindOf(Type))->collect(oclAsType(Type))->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-operation "visibleMembers" |Package| 
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
(def-meta-class |PackageImport| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3Sh8ToZEeCmpu-HRutBsg")
 "A PackageImport is a Relationship that imports all the non-private members
  of a Package into the Namespace owning the PackageImport, so that those
  Elements may be referred to by their unqualified names in the importingNamespace."
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
      importingNamespace, i.e., whether imported Elements will in turn be visible
      to other Namespaces. If the PackageImport is public, the imported Elements
      will be visible outside the importingNamespace, while, if the PackageImport
      is private, they will not.")))


;;; =========================================================
;;; ====================== PackageMerge
;;; =========================================================
(def-meta-class |PackageMerge| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8gVDoZEeCmpu-HRutBsg")
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
(def-meta-class |PackageableElement| 
   (:model :UML25 :superclasses (|ParameterableElement| |NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3Sh6DoZEeCmpu-HRutBsg")
 "A PackageableElement is a NamedElement that may be owned directly by a
  Package. A PackageableElement is also able to serve as the parameteredElement
  of a TemplateParameter."
  ((|visibility| :range |VisibilityKind| :multiplicity (0 1) :default :public
    :documentation
     "A PackageableElement must have a visibility specified if it is owned by
      a Namespace. The default visibility is public." :redefined-property (|NamedElement| |visibility|))))


;;; =========================================================
;;; ====================== Parameter
;;; =========================================================
(def-meta-class |Parameter| 
   (:model :UML25 :superclasses (|MultiplicityElement| |ConnectableElement|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH19kjoZEeCmpu-HRutBsg")
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


(def-meta-operation "default.1" |Parameter| 
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
(def-meta-class |ParameterSet| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH19xjoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ParameterableElement
;;; =========================================================
(def-meta-class |ParameterableElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3Sh_joZEeCmpu-HRutBsg")
 "A ParameterableElement is an Element that can be exposed as a formal TemplateParameter
  for a template, or specified as an actual parameter in a binding of a template."
  ((|owningTemplateParameter| :range |TemplateParameter| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|) (|ParameterableElement| |templateParameter|))
    :opposite (|TemplateParameter| |ownedParameteredElement|)
    :documentation
     "The formal TemplateParameter that owns this ParameterableElement.")
   (|templateParameter| :range |TemplateParameter| :multiplicity (0 1)
    :opposite (|TemplateParameter| |parameteredElement|)
    :documentation
     "The TemplateParameter that exposes this ParameterableElement as a formal
      parameter.")))


(def-meta-operation "isCompatibleWith" |ParameterableElement| 
   "The query isCompatibleWith() determines if this ParameterableElement is
    compatible with the specified ParameterableElement. By default, ParameterableElement
    P is compatible with ParameterableElement Q if the kind of P is the same
    as or a subtype of the kind of Q. Subclasses should override this operation
    to specify different compatibility constraints."
   :operation-body
   "p->oclIsKindOf(self.oclType())"
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
   "templateParameter->notEmpty()"
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
    :xmi-id "_F_wqUDoZEeCmpu-HRutBsg")
 "A PartDecomposition is a description of the internal Interactions of one
  Lifeline relative to an Interaction."
  ())


;;; =========================================================
;;; ====================== Pin
;;; =========================================================
(def-meta-class |Pin| 
   (:model :UML25 :superclasses (|ObjectNode| |MultiplicityElement|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRTDoZEeCmpu-HRutBsg")
 "A pin is an object node for inputs and outputs to actions. A pin is a typed
  element and multiplicity element that provides values to actions and accept
  result values from them."
  ((|isControl| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the pins provide data to the actions, or just controls when
      it executes it.")))


;;; =========================================================
;;; ====================== Port
;;; =========================================================
(def-meta-class |Port| 
   (:model :UML25 :superclasses (|Property|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMkzoZEeCmpu-HRutBsg")
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
      from the PortA A A s Type.")
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


(def-meta-operation "basicProvided" |Port| 
   "The union of the sets of Interfaces realized by the type of the Port and
    its supertypes, or directly the type of the Port if the Port is typed by
    an Interface."
   :operation-body
   "if type.oclIsKindOf(Interface)   then type.oclAsType(Interface)->asSet()   else type.oclAsType(Classifier).allRealizedInterfaces()   endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "basicRequired" |Port| 
   "The union of the sets of Interfaces used by the type of the Port and its
    supertypes."
   :operation-body
   " type.oclAsType(Classifier).allUsedInterfaces() "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "provided.1" |Port| 
   "Derivation for Port::/provided"
   :operation-body
   "if isConjugated then basicRequired() else basicProvided() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Interface|
                        :parameter-return-p T))
)

(def-meta-operation "required.1" |Port| 
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
(def-meta-class |PrimitiveType| 
   (:model :UML25 :superclasses (|DataType|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwnjoZEeCmpu-HRutBsg")
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
    :xmi-id "_IH8gWzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ProfileApplication
;;; =========================================================
(def-meta-class |ProfileApplication| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8gbDoZEeCmpu-HRutBsg")
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
(def-meta-class |Property| 
   (:model :UML25 :superclasses (|ConnectableElement| |DeploymentTarget| |StructuralFeature|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH192ToZEeCmpu-HRutBsg")
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


(def-meta-operation "default.1" |Property| 
   "Missing derivation for Property::/default : String"
   :operation-body
   "if self.type = String then defaultValue.stringValue() else null endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "isAttribute" |Property| 
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

(def-meta-operation "isCompatibleWith" |Property| 
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

(def-meta-operation "isComposite.1" |Property| 
   "The value of isComposite is true only if aggregation is composite."
   :operation-body
   "aggregation = AggregationKind::composite"
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
   "redefinee.oclIsKindOf(Property) and    let prop : Property = redefinee.oclAsType(Property) in    (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and    ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and    (self.isComposite implies prop.isComposite))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isNavigable" |Property| 
   "The query isNavigable() indicates whether it is possible to navigate across
    the property."
   :operation-body
   "not classifier->isEmpty() or association.navigableOwnedEnd->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "opposite.1" |Property| 
   "If this property is a memberEnd of a binary association then opposite gives
    the other end."
   :operation-body
   "if association <> null and association.memberEnd->size() = 2 then     association.memberEnd->any(e | e <> self) else     null endif"
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
   "if association <> null then association.endType->excluding(type) else    if classifier<>null   then classifier->asSet()   else Set{}    endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ProtocolConformance
;;; =========================================================
(def-meta-class |ProtocolConformance| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AFjoZEeCmpu-HRutBsg")
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
(def-meta-class |ProtocolStateMachine| 
   (:model :UML25 :superclasses (|StateMachine|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AHToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ProtocolTransition
;;; =========================================================
(def-meta-class |ProtocolTransition| 
   (:model :UML25 :superclasses (|Transition|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AMzoZEeCmpu-HRutBsg")
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


(def-meta-operation "referred.1" |ProtocolTransition| 
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
(def-meta-class |Pseudostate| 
   (:model :UML25 :superclasses (|Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AUDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== QualifierValue
;;; =========================================================
(def-meta-class |QualifierValue| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRVzoZEeCmpu-HRutBsg")
 "A qualifier value is not an action. It is an element that identifies links.
  It gives a single qualifier within a link end data specification."
  ((|qualifier| :range |Property| :multiplicity (1 1) :soft-opposite (|Property| |qualifierValue|)
    :documentation
     "Attribute representing the qualifier for which the value is to be specified.")
   (|value| :range |InputPin| :multiplicity (1 1) :soft-opposite (|InputPin| |qualifierValue|)
    :documentation
     "Input pin from which the specified value for the qualifier is taken.")))


;;; =========================================================
;;; ====================== RaiseExceptionAction
;;; =========================================================
(def-meta-class |RaiseExceptionAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRZzoZEeCmpu-HRutBsg")
 "A raise exception action is an action that causes an exception to occur.
  The input value becomes the exception object."
  ((|exception| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |raiseExceptionAction|)
    :documentation
     "An input pin whose value becomes an exception object.")))


;;; =========================================================
;;; ====================== ReadExtentAction
;;; =========================================================
(def-meta-class |ReadExtentAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRbDoZEeCmpu-HRutBsg")
 "A read extent action is an action that retrieves the current instances
  of a classifier."
  ((|classifier| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |readExtentAction|)
    :documentation
     "The classifier whose instances are to be retrieved.")
   (|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readExtentAction|)
    :documentation
     "The runtime instances of the classifier.")))


;;; =========================================================
;;; ====================== ReadIsClassifiedObjectAction
;;; =========================================================
(def-meta-class |ReadIsClassifiedObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknReToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ReadLinkAction
;;; =========================================================
(def-meta-class |ReadLinkAction| 
   (:model :UML25 :superclasses (|LinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRkToZEeCmpu-HRutBsg")
 "A read link action is a link action that navigates across associations
  to retrieve objects on one end."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readLinkAction|)
    :documentation
     "The pin on which are put the objects participating in the association at
      the end not specified by the inputs.")))


;;; =========================================================
;;; ====================== ReadLinkObjectEndAction
;;; =========================================================
(def-meta-class |ReadLinkObjectEndAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRpToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ReadLinkObjectEndQualifierAction
;;; =========================================================
(def-meta-class |ReadLinkObjectEndQualifierAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknRwzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ReadSelfAction
;;; =========================================================
(def-meta-class |ReadSelfAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknR5DoZEeCmpu-HRutBsg")
 "A read self action is an action that retrieves the host object of an action."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readSelfAction|)
    :documentation
     "Gives the output pin on which the hosting object is placed.")))


;;; =========================================================
;;; ====================== ReadStructuralFeatureAction
;;; =========================================================
(def-meta-class |ReadStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknR9ToZEeCmpu-HRutBsg")
 "A read structural feature action is a structural feature action that retrieves
  the values of a structural feature."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readStructuralFeatureAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


;;; =========================================================
;;; ====================== ReadVariableAction
;;; =========================================================
(def-meta-class |ReadVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSADoZEeCmpu-HRutBsg")
 "A read variable action is a variable action that retrieves the values of
  a variable."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |readVariableAction|)
    :documentation
     "Gives the output pin on which the result is put.")))


;;; =========================================================
;;; ====================== Realization
;;; =========================================================
(def-meta-class |Realization| 
   (:model :UML25 :superclasses (|Abstraction|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiEjoZEeCmpu-HRutBsg")
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
    :xmi-id "_JBTwoToZEeCmpu-HRutBsg")
 "A Reception is a declaration stating that a Classifier is prepared to react
  to the receipt of a Signal."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |reception|)
    :documentation
     "The Signal that this Reception handles.")))


;;; =========================================================
;;; ====================== ReclassifyObjectAction
;;; =========================================================
(def-meta-class |ReclassifyObjectAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSCzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== RedefinableElement
;;; =========================================================
(def-meta-class |RedefinableElement| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH1-bToZEeCmpu-HRutBsg")
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


(def-meta-operation "isConsistentWith" |RedefinableElement| 
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

(def-meta-operation "isRedefinitionContextValid" |RedefinableElement| 
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
(def-meta-class |RedefinableTemplateSignature| 
   (:model :UML25 :superclasses (|RedefinableElement| |TemplateSignature|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH1-kjoZEeCmpu-HRutBsg")
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


(def-meta-operation "inheritedParameter.1" |RedefinableTemplateSignature| 
   "Missing derivation for RedefinableTemplateSignature::/inheritedParameter
    : TemplateParameter"
   :operation-body
   "if extendedSignature->isEmpty() then Set{} else extendedSignature.parameter->asSet() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|TemplateParameter|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |RedefinableTemplateSignature| 
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
(def-meta-class |ReduceAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSJDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== Region
;;; =========================================================
(def-meta-class |Region| 
   (:model :UML25 :superclasses (|Namespace| |RedefinableElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AdzoZEeCmpu-HRutBsg")
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


(def-meta-operation "belongsToPSM" |Region| 
   "The operation belongsToPSM () checks if the region belongs to a protocol
    state machine"
   :operation-body
   "if  stateMachine <> null  then   stateMachine.oclIsKindOf(ProtocolStateMachine) else    state <> null  implies  state.container.belongsToPSM() endif "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "containingStateMachine" |Region| 
   "The operation containingStateMachine() returns the sate machine in which
    this Region is defined"
   :operation-body
   "if stateMachine = null  then   state.containingStateMachine() else   stateMachine endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Region| 
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

(def-meta-operation "isRedefinitionContextValid" |Region| 
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

(def-meta-operation "redefinitionContext.1" |Region| 
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
(def-meta-class |Relationship| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiFToZEeCmpu-HRutBsg")
 "Relationship is an abstract concept that specifies some kind of relationship
  between Elements."
  ((|relatedElement| :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T :soft-opposite (|Element| |relationship|)
    :documentation
     "Specifies the elements related by the Relationship.")))


;;; =========================================================
;;; ====================== RemoveStructuralFeatureValueAction
;;; =========================================================
(def-meta-class |RemoveStructuralFeatureValueAction| 
   (:model :UML25 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSOToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== RemoveVariableValueAction
;;; =========================================================
(def-meta-class |RemoveVariableValueAction| 
   (:model :UML25 :superclasses (|WriteVariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSRToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== ReplyAction
;;; =========================================================
(def-meta-class |ReplyAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSUToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== SendObjectAction
;;; =========================================================
(def-meta-class |SendObjectAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSYjoZEeCmpu-HRutBsg")
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
(def-meta-class |SendSignalAction| 
   (:model :UML25 :superclasses (|InvocationAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSaToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== SequenceNode
;;; =========================================================
(def-meta-class |SequenceNode| 
   (:model :UML25 :superclasses (|StructuredActivityNode|) 
    :packages (UML |Actions|) 
    :xmi-id "_AknSdjoZEeCmpu-HRutBsg")
 "A sequence node is a structured activity node that executes its actions
  in order."
  ((|executableNode| :range |ExecutableNode| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T :soft-opposite (|ExecutableNode| |sequenceNode|)
    :documentation
     "An ordered set of executable nodes." :redefined-property (|StructuredActivityNode| |node|))))


;;; =========================================================
;;; ====================== Signal
;;; =========================================================
(def-meta-class |Signal| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |SimpleClassifiers|) 
    :xmi-id "_JBTwqToZEeCmpu-HRutBsg")
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
(def-meta-class |SignalEvent| 
   (:model :UML25 :superclasses (|MessageEvent|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZbToZEeCmpu-HRutBsg")
 "A SignalEvent represents the receipt of an asynchronous Signal instance."
  ((|signal| :range |Signal| :multiplicity (1 1) :soft-opposite (|Signal| |signalEvent|)
    :documentation
     "The specific Signal that is associated with this SignalEvent.")))


;;; =========================================================
;;; ====================== Slot
;;; =========================================================
(def-meta-class |Slot| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH1-sjoZEeCmpu-HRutBsg")
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
(def-meta-class |StartClassifierBehaviorAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZkDoZEeCmpu-HRutBsg")
 "A start classifier behavior action is an action that starts the classifier
  behavior of the input."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |startClassifierBehaviorAction|)
    :documentation
     "Holds the object on which to start the owned behavior.")))


;;; =========================================================
;;; ====================== StartObjectBehaviorAction
;;; =========================================================
(def-meta-class |StartObjectBehaviorAction| 
   (:model :UML25 :superclasses (|CallAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZmzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== State
;;; =========================================================
(def-meta-class |State| 
   (:model :UML25 :superclasses (|RedefinableElement| |Namespace| |Vertex|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8AtToZEeCmpu-HRutBsg")
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


(def-meta-operation "containingStateMachine" |State| 
   "The query containingStateMachine() returns the state machine that contains
    the state either directly or transitively."
   :operation-body
   "container.containingStateMachine()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isComposite.1" |State| 
   "A composite state is a state with at least one region."
   :operation-body
   "region->notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |State| 
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

(def-meta-operation "isOrthogonal.1" |State| 
   "An orthogonal state is a composite state with at least 2 regions"
   :operation-body
   "region->size () > 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isRedefinitionContextValid" |State| 
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

(def-meta-operation "isSimple.1" |State| 
   "A simple state is a state without any regions."
   :operation-body
   "region->isEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isSubmachineState.1" |State| 
   "Only submachine states can have a reference statemachine."
   :operation-body
   "submachine <> null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "redefinitionContext.1" |State| 
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
(def-meta-class |StateInvariant| 
   (:model :UML25 :superclasses (|InteractionFragment|) 
    :packages (UML |Interactions|) 
    :xmi-id "_F_wqXDoZEeCmpu-HRutBsg")
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
(def-meta-class |StateMachine| 
   (:model :UML25 :superclasses (|Behavior|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8BJDoZEeCmpu-HRutBsg")
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


(def-meta-operation "LCA" |StateMachine| 
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

(def-meta-operation "ancestor" |StateMachine| 
   "The query ancestor(s1, s2) checks whether s1 is an ancestor state of state
    s2."
   :operation-body
   "if (s2 = s1) then    true   else    if (s2.container->isEmpty() or not s2.container.owner.oclIsKindOf(State)) then     false    else     ancestor(s1, s2.container.owner.oclAsType(State))   endif  endif   "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|State|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-meta-operation "isConsistentWith" |StateMachine| 
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

(def-meta-operation "isRedefinitionContextValid" |StateMachine| 
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
(def-meta-class |Stereotype| 
   (:model :UML25 :superclasses (|Class|) 
    :packages (UML |Packages|) 
    :xmi-id "_IH8gdjoZEeCmpu-HRutBsg")
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


(def-meta-operation "containingProfile" |Stereotype| 
   "The query containingProfile returns the closest profile directly or indirectly
    containing this stereotype."
   :operation-body
   "self.namespace.oclAsType(Package).containingProfile()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Profile|
                        :parameter-return-p T))
)

(def-meta-operation "profile.1" |Stereotype| 
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
(def-meta-class |StringExpression| 
   (:model :UML25 :superclasses (|TemplateableElement| |Expression|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTi0ToZEeCmpu-HRutBsg")
 "A StringExpression is an Expression that specifies a String value that
  is derived by concatenating a sequence of operands with String values or
  a sequence of subExpressions, some of which might be template parameters."
  ((|owningExpression| :range |StringExpression| :multiplicity (0 1) :is-ordered-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|StringExpression| |subExpression|)
    :documentation
     "The StringExpression of which this StringExpression is a subExpression.")
   (|subExpression| :range |StringExpression| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|StringExpression| |owningExpression|)
    :documentation
     "The StringExpressions that constitute this StringExpression.")))


(def-meta-operation "stringValue" |StringExpression| 
   "The query stringValue() returns the String resulting from concatenating,
    in order, all the component String values of all the operands or subExpressions
    that are part of the StringExpression."
   :operation-body
   "if subExpression->notEmpty() then subExpression->iterate(se; stringValue: String = '' | stringValue.concat(se.stringValue())) else operand->iterate(op; stringValue: String = '' | stringValue.concat(op.stringValue())) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== StructuralFeature
;;; =========================================================
(def-meta-class |StructuralFeature| 
   (:model :UML25 :superclasses (|MultiplicityElement| |TypedElement| |Feature|) 
    :packages (UML |Classification|) 
    :xmi-id "_CH1-vToZEeCmpu-HRutBsg")
 "A StructuralFeature is a typed feature of a Classifier that specifies the
  structure of instances of the Classifier."
  ((|isReadOnly| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True if the StructuralFeature's value may not be modified by a client.")))


;;; =========================================================
;;; ====================== StructuralFeatureAction
;;; =========================================================
(def-meta-class |StructuralFeatureAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZrzoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== StructuredActivityNode
;;; =========================================================
(def-meta-class |StructuredActivityNode| 
   (:model :UML25 :superclasses (|Namespace| |ActivityGroup| |Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZxToZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== StructuredClassifier
;;; =========================================================
(def-meta-class |StructuredClassifier| 
   (:model :UML25 :superclasses (|Classifier|) 
    :packages (UML |StructuredClassifiers|) 
    :xmi-id "_LPmMxjoZEeCmpu-HRutBsg")
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


(def-meta-operation "part.1" |StructuredClassifier| 
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
(def-meta-class |Substitution| 
   (:model :UML25 :superclasses (|Realization|) 
    :packages (UML |Classification|) 
    :xmi-id "_D3SiGzoZEeCmpu-HRutBsg")
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
(def-meta-class |TemplateBinding| 
   (:model :UML25 :superclasses (|DirectedRelationship|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiODoZEeCmpu-HRutBsg")
 "A TemplateBinding is a DirectedRelationship between a TemplateableElement
  and a template. A TemplateBinding specifies the TemplateParameterSubstitutions
  of actual parameters for the formal parameters of the template."
  ((|boundElement| :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|TemplateableElement| |templateBinding|)
    :documentation
     "The TemplateableElement that is bound by this TemplateBiinding.")
   (|parameterSubstitution| :range |TemplateParameterSubstitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateParameterSubstitution| |templateBinding|)
    :documentation
     "The TemplateParameterSubstitutions owned by this TemplateBinding.")
   (|signature| :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|)) :soft-opposite (|TemplateSignature| |templateBinding|)
    :documentation
     "The TemplateSignature for the template that is the target of this TemplateBinding.")))


;;; =========================================================
;;; ====================== TemplateParameter
;;; =========================================================
(def-meta-class |TemplateParameter| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiSToZEeCmpu-HRutBsg")
 "A TemplateParameter exposes a ParameterableElement as a formal parameter
  of a template."
  ((|default| :range |ParameterableElement| :multiplicity (0 1) :soft-opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The ParameterableElement that is the default for this formal TemplateParameter.")
   (|ownedDefault| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |default|)) :soft-opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The ParameterableElement that is owned by this TemplateParameter for the
      purpose of providing a default.")
   (|ownedParameteredElement| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameter| |parameteredElement|))
    :opposite (|ParameterableElement| |owningTemplateParameter|)
    :documentation
     "The ParameterableElement that is owned by this TemplateParameter for the
      purpose of exposing it as the parameteredElement.")
   (|parameteredElement| :range |ParameterableElement| :multiplicity (1 1)
    :opposite (|ParameterableElement| |templateParameter|)
    :documentation
     "The ParameterableElement exposed by this TemplateParameter.")
   (|signature| :range |TemplateSignature| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateSignature| |ownedParameter|)
    :documentation
     "The TemplateSignature that owns this TemplateParameter.")))


;;; =========================================================
;;; ====================== TemplateParameterSubstitution
;;; =========================================================
(def-meta-class |TemplateParameterSubstitution| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiXDoZEeCmpu-HRutBsg")
 "A TemplateParameterSubstitution relates the actual parameter to a formal
  TemplateParameter as part of a template binding."
  ((|actual| :range |ParameterableElement| :multiplicity (1 1) :soft-opposite (|ParameterableElement| |templateParameterSubstitution|)
    :documentation
     "The ParameterableElement that is the actual parameter for this TemplateParameterSubstitution.")
   (|formal| :range |TemplateParameter| :multiplicity (1 1) :soft-opposite (|TemplateParameter| |templateParameterSubstitution|)
    :documentation
     "The formal TemplateParameter that is associated with this TemplateParameterSubstitution.")
   (|ownedActual| :range |ParameterableElement| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateParameterSubstitution| |actual|)) :soft-opposite (|ParameterableElement| |owningTemplateParameterSubstitution|)
    :documentation
     "The ParameterableElement that is owned by this TemplateParameterSubstitution
      as its actual parameter.")
   (|templateBinding| :range |TemplateBinding| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateBinding| |parameterSubstitution|)
    :documentation
     "The TemplateBinding that owns this TemplateParameterSubstitution.")))


;;; =========================================================
;;; ====================== TemplateSignature
;;; =========================================================
(def-meta-class |TemplateSignature| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiazoZEeCmpu-HRutBsg")
 "A Template Signature bundles the set of formal TemplateParameters for a
  template."
  ((|ownedParameter| :range |TemplateParameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|) (|TemplateSignature| |parameter|))
    :opposite (|TemplateParameter| |signature|)
    :documentation
     "The formal parameters that are owned by this TemplateSignature.")
   (|parameter| :range |TemplateParameter| :multiplicity (1 -1) :is-ordered-p T :soft-opposite (|TemplateParameter| |templateSignature|)
    :documentation
     "The ordered set of all formal TemplateParameters for this TemplateSignature.")
   (|template| :range |TemplateableElement| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|TemplateableElement| |ownedTemplateSignature|)
    :documentation
     "The TemplateableElement that owns this TemplateSignature.")))


;;; =========================================================
;;; ====================== TemplateableElement
;;; =========================================================
(def-meta-class |TemplateableElement| 
   (:model :UML25 :superclasses (|Element|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiIjoZEeCmpu-HRutBsg")
 "A TemplateableElement is an Element that can optionally be defined as a
  template and bound to other templates."
  ((|ownedTemplateSignature| :range |TemplateSignature| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateSignature| |template|)
    :documentation
     "The optional TemplateSignature specifying the formal TemplateParameters
      for this TemplateableElement. If a TemplateableElement has a TemplateSignature,
      then it is a template.")
   (|templateBinding| :range |TemplateBinding| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|TemplateBinding| |boundElement|)
    :documentation
     "The optional TemplateBindings from this TemplateableElement to one ore
      more templates.")))


(def-meta-operation "isTemplate" |TemplateableElement| 
   "The query isTemplate() returns whether this TemplateableElement is actually
    a template."
   :operation-body
   "ownedTemplateSignature <> null"
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
   "self.allOwnedElements()->select(oclIsKindOf(ParameterableElement)).oclAsType(ParameterableElement)->asSet()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ParameterableElement|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== TestIdentityAction
;;; =========================================================
(def-meta-class |TestIdentityAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZ7DoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== TimeConstraint
;;; =========================================================
(def-meta-class |TimeConstraint| 
   (:model :UML25 :superclasses (|IntervalConstraint|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTi5zoZEeCmpu-HRutBsg")
 "A TimeConstraint is a Constraint that refers to a TimeInterval."
  ((|firstEvent| :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "The value of firstEvent is related to the constrainedElement. If firstEvent
      is true, then the corresponding observation event is the first time instant
      the execution enters the constrainedElement. If firstEvent is false, then
      the corresponding observation event is the last time instant the execution
      is within the constrainedElement.")
   (|specification| :range |TimeInterval| :multiplicity (1 1) :is-composite-p T :soft-opposite (|TimeInterval| |timeConstraint|)
    :documentation
     "TheTimeInterval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))


;;; =========================================================
;;; ====================== TimeEvent
;;; =========================================================
(def-meta-class |TimeEvent| 
   (:model :UML25 :superclasses (|Event|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZcjoZEeCmpu-HRutBsg")
 "A TimeEvent is an Event that occurs at a specific point in time."
  ((|isRelative| :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the TimeEvent is specified as an absolute or relative
      time.")
   (|when| :range |TimeExpression| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|TimeExpression| |timeEvent|)
    :documentation
     "Specifies the time of the TimeEvent.")))


;;; =========================================================
;;; ====================== TimeExpression
;;; =========================================================
(def-meta-class |TimeExpression| 
   (:model :UML25 :superclasses (|ValueSpecification|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTi8DoZEeCmpu-HRutBsg")
 "A TimeExpression is a ValueSpecification that represents a time value."
  ((|expr| :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |timeExpression|)
    :documentation
     "A ValueSpecification that evaluates to the value of the TimeExpression")
   (|observation| :range |Observation| :multiplicity (0 -1) :soft-opposite (|Observation| |timeExpression|)
    :documentation
     "Refers to the Observations that are involved in the computation of the
      TimeExpression value")))


;;; =========================================================
;;; ====================== TimeInterval
;;; =========================================================
(def-meta-class |TimeInterval| 
   (:model :UML25 :superclasses (|Interval|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTi-joZEeCmpu-HRutBsg")
 "A TimeInterval defines the range between two TimeExpressions."
  ((|max| :range |TimeExpression| :multiplicity (1 1) :soft-opposite (|TimeExpression| |timeInterval|)
    :documentation
     "Refers to the TimeExpression denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :range |TimeExpression| :multiplicity (1 1) :soft-opposite (|TimeExpression| |timeInterval|)
    :documentation
     "Refers to the TimeExpression denoting the minimum value of the range." :redefined-property (|Interval| |min|))))


;;; =========================================================
;;; ====================== TimeObservation
;;; =========================================================
(def-meta-class |TimeObservation| 
   (:model :UML25 :superclasses (|Observation|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTjAToZEeCmpu-HRutBsg")
 "A TimeObservation is a reference to a time instant during an execution.
  It points out the NamedElement in the model to observe and whether the
  observation is when this NamedElement is entered or when it is exited."
  ((|event| :range |NamedElement| :multiplicity (1 1) :soft-opposite (|NamedElement| |timeObservation|)
    :documentation
     "The TimeObservation is determined by the entering or exiting of the event
      Element during execution.")
   (|firstEvent| :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "The value of firstEvent is related to the event. If firstEvent is true,
      then the corresponding observation event is the first time instant the
      execution enters the event Element. If firstEvent is false, then the corresponding
      observation event is the time instant the execution exits the event Element.")))


;;; =========================================================
;;; ====================== Transition
;;; =========================================================
(def-meta-class |Transition| 
   (:model :UML25 :superclasses (|Namespace| |RedefinableElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8BXDoZEeCmpu-HRutBsg")
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


(def-meta-operation "containingStateMachine" |Transition| 
   "The query containingStateMachine() returns the state machine that contains
    the transition either directly or transitively."
   :operation-body
   "container.containingStateMachine()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Transition| 
   "The query isConsistentWith() specifies that a redefining transition is
    consistent with a redefined transition provided that the redefining transition
    has the following relation to the redefined transition: A redefining transition
    redefines all properties of the corresponding redefined transition, except
    the source state and the trigger."
   :operation-body
   "redefinee.oclIsKindOf(Transition) and    let trans: Transition = redefinee.oclAsType(Transition) in      (source = trans.source and trigger = trans.trigger)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "redefinitionContext.1" |Transition| 
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
(def-meta-class |Trigger| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonBehavior|) 
    :xmi-id "_DF-ZgToZEeCmpu-HRutBsg")
 "A Trigger specifies a specific point  at which an Event occurrence may
  trigger an effect in a Behavior. A Trigger may be qualified by the Port
  on which the Event occured."
  ((|event| :range |Event| :multiplicity (1 1) :soft-opposite (|Event| |trigger|)
    :documentation
     "The Event that detected by the Trigger.")
   (|port| :range |Port| :multiplicity (0 -1) :soft-opposite (|Port| |trigger|)
    :documentation
     "A optional Port of through which the given effect is detected.")))


;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-meta-class |Type| 
   (:model :UML25 :superclasses (|PackageableElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SiejoZEeCmpu-HRutBsg")
 "A Type constrains the values represented by a TypedElement."
  ((|package| :range |Package| :multiplicity (0 1)
    :opposite (|Package| |ownedType|)
    :documentation
     "Specifies the owning Package of this Type, if any.")))


(def-meta-operation "conformsTo" |Type| 
   "The query conformsTo() gives true for a Type that conforms to another.
    By default, two Types do not conform to each other. This query is intended
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
(def-meta-class |TypedElement| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SihzoZEeCmpu-HRutBsg")
 "A TypedElement is a NamedElement that may have a Type specified for it."
  ((|type| :range |Type| :multiplicity (0 1) :soft-opposite (|Type| |typedElement|)
    :documentation
     "The type of the TypedElement.")))


;;; =========================================================
;;; ====================== UnmarshallAction
;;; =========================================================
(def-meta-class |UnmarshallAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwZ_joZEeCmpu-HRutBsg")
 "An unmarshall action is an action that breaks an object of a known type
  into outputs each of which is equal to a value from a structural feature
  of the object."
  ((|object| :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |unmarshallAction|)
    :documentation
     "The object to be unmarshalled.")
   (|result| :range |OutputPin| :multiplicity (1 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |unmarshallAction|)
    :documentation
     "The values of the structural features of the input object.")
   (|unmarshallType| :range |Classifier| :multiplicity (1 1) :soft-opposite (|Classifier| |unmarshallAction|)
    :documentation
     "The type of the object to be unmarshalled.")))


;;; =========================================================
;;; ====================== Usage
;;; =========================================================
(def-meta-class |Usage| 
   (:model :UML25 :superclasses (|Dependency|) 
    :packages (UML |CommonStructure|) 
    :xmi-id "_D3SijzoZEeCmpu-HRutBsg")
 "A Usage is a Dependency in which the client Element requires the supplier
  Element (or set of Elements) for its full implementation or operation."
  ())


;;; =========================================================
;;; ====================== UseCase
;;; =========================================================
(def-meta-class |UseCase| 
   (:model :UML25 :superclasses (|BehavioredClassifier|) 
    :packages (UML |UseCases|) 
    :xmi-id "_LuSTpzoZEeCmpu-HRutBsg")
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


(def-meta-operation "allIncludedUseCases" |UseCase| 
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
(def-meta-class |ValuePin| 
   (:model :UML25 :superclasses (|InputPin|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkwaHToZEeCmpu-HRutBsg")
 "A value pin is an input pin that provides a value by evaluating a value
  specification."
  ((|value| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |valuePin|)
    :documentation
     "Value that the pin will provide.")))


;;; =========================================================
;;; ====================== ValueSpecification
;;; =========================================================
(def-meta-class |ValueSpecification| 
   (:model :UML25 :superclasses (|TypedElement| |PackageableElement|) 
    :packages (UML |Values|) 
    :xmi-id "_MYTjCToZEeCmpu-HRutBsg")
 "A ValueSpecification is the specification of a (possibly empty) set of
  values. A ValueSpecificaiton is a Parameterable elemented that may be exposed
  as a formal TemplateParameter and provided as the actual parameter in the
  binding of a template."
  ())


(def-meta-operation "booleanValue" |ValueSpecification| 
   "The query booleanValue() gives a single Boolean value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "integerValue" |ValueSpecification| 
   "The query integerValue() gives a single Integer value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isCompatibleWith" |ValueSpecification| 
   "The query isCompatibleWith() determines if this Parameterable element is
    compatible with the specified parameterable element. By default parameterable
    element P is compatible with parameterable element Q if the kind of P is
    the same or a subtype as the kind of Q. In addition, for a ValueSpecification,
    the type must be conformant with the type of the specified ParameterableElement
    (which must have a type, since it must be a kind of ValueSpecification)."
   :operation-body
   "p.oclIsKindOf(self.oclType()) and self.type.conformsTo(p.oclAsType(TypedElement).type)"
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
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |ValueSpecification| 
   "The query isNull() returns true when it can be computed that the value
    is null."
   :operation-body
   "false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "realValue" |ValueSpecification| 
   "The query realValue() gives a single Real value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Real|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |ValueSpecification| 
   "The query stringValue() gives a single String value when one can be computed."
   :operation-body
   "null"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |ValueSpecification| 
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
(def-meta-class |ValueSpecificationAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_Akde_ToZEeCmpu-HRutBsg")
 "A value specification action is an action that evaluates a value specification."
  ((|result| :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|)) :soft-opposite (|OutputPin| |valueSpecificationAction|)
    :documentation
     "Gives the output pin on which the result is put.")
   (|value| :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|)) :soft-opposite (|ValueSpecification| |valueSpecificationAction|)
    :documentation
     "Value specification to be evaluated.")))


;;; =========================================================
;;; ====================== Variable
;;; =========================================================
(def-meta-class |Variable| 
   (:model :UML25 :superclasses (|ConnectableElement| |MultiplicityElement|) 
    :packages (UML |Activities|) 
    :xmi-id "_BHevfzoZEeCmpu-HRutBsg")
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


(def-meta-operation "isAccessibleBy" |Variable| 
   "The isAccessibleBy() operation is not defined in standard UML. Implementations
    may define it to specify which actions can access a variable."
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
(def-meta-class |VariableAction| 
   (:model :UML25 :superclasses (|Action|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfCjoZEeCmpu-HRutBsg")
 "VariableAction is an abstract class for actions that operate on a statically
  specified variable."
  ((|variable| :range |Variable| :multiplicity (1 1) :soft-opposite (|Variable| |variableAction|)
    :documentation
     "Variable to be read.")))


;;; =========================================================
;;; ====================== Vertex
;;; =========================================================
(def-meta-class |Vertex| 
   (:model :UML25 :superclasses (|NamedElement|) 
    :packages (UML |StateMachines|) 
    :xmi-id "_Kq8BqDoZEeCmpu-HRutBsg")
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


(def-meta-operation "containingStateMachine" |Vertex| 
   "The operation containingStateMachine() returns the state machine in which
    this Vertex is defined"
   :operation-body
   "if container <> null then -- the container is a region    container.containingStateMachine() else     if (self.oclIsKindOf(Pseudostate)) and ((self.oclAsType(Pseudostate).kind = PseudostateKind::entryPoint) or (self.oclAsType(Pseudostate).kind = PseudostateKind::exitPoint)) then       self.oclAsType(Pseudostate).stateMachine    else        if (self.oclIsKindOf(ConnectionPointReference)) then           self.oclAsType(ConnectionPointReference).state.containingStateMachine() -- no other valid cases possible       else            null       endif    endif endif  "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "incoming.1" |Vertex| 
   "Missing derivation for Vertex::/incoming : Transition"
   :operation-body
   "Transition.allInstances()->select(target=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-meta-operation "outgoing.1" |Vertex| 
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
(def-meta-class |WriteLinkAction| 
   (:model :UML25 :superclasses (|LinkAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfEjoZEeCmpu-HRutBsg")
 "WriteLinkAction is an abstract class for link actions that create and destroy
  links."
  ())


;;; =========================================================
;;; ====================== WriteStructuralFeatureAction
;;; =========================================================
(def-meta-class |WriteStructuralFeatureAction| 
   (:model :UML25 :superclasses (|StructuralFeatureAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfGDoZEeCmpu-HRutBsg")
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


;;; =========================================================
;;; ====================== WriteVariableAction
;;; =========================================================
(def-meta-class |WriteVariableAction| 
   (:model :UML25 :superclasses (|VariableAction|) 
    :packages (UML |Actions|) 
    :xmi-id "_AkdfLToZEeCmpu-HRutBsg")
 "WriteVariableAction is an abstract class for variable actions that change
  variable values."
  ((|value| :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|)) :soft-opposite (|InputPin| |writeVariableAction|)
    :documentation
     "Value to be added or removed from the variable.")))


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
    |ValuePin|) :xmi-id "_Aja80DoZEeCmpu-HRutBsg")

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
    |ObjectNodeOrderingKind|) :xmi-id "_BHLKIDoZEeCmpu-HRutBsg")

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
    |ParameterEffectKind|) :xmi-id "_CHPgADoZEeCmpu-HRutBsg")

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
    |Trigger|) :xmi-id "_DF0oIDoZEeCmpu-HRutBsg")

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
    |VisibilityKind|) :xmi-id "_D211YDoZEeCmpu-HRutBsg")

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
    |Node|) :xmi-id "_EntRoDoZEeCmpu-HRutBsg")

(def-meta-package |InformationFlows| UML :UML25 
   (|InformationFlow|
    |InformationItem|) :xmi-id "_FQPRQDoZEeCmpu-HRutBsg")

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
    |MessageSort|) :xmi-id "_F_Uk0DoZEeCmpu-HRutBsg")

(def-meta-package |Packages| UML :UML25 
   (|Extension|
    |ExtensionEnd|
    |Image|
    |Model|
    |Package|
    |PackageMerge|
    |Profile|
    |ProfileApplication|
    |Stereotype|) :xmi-id "_IHytMDoZEeCmpu-HRutBsg")

(def-meta-package |PrimitiveTypes| UML :UML25 
   (|Boolean|
    |Integer|
    |Real|
    |String|
    |UnlimitedNatural|) :xmi-id "_PSicoDoZEeCmpu-HRutBsg")

(def-meta-package |SimpleClassifiers| UML :UML25 
   (|BehavioredClassifier|
    |DataType|
    |Enumeration|
    |EnumerationLiteral|
    |Interface|
    |InterfaceRealization|
    |PrimitiveType|
    |Reception|
    |Signal|) :xmi-id "_JBJ-IDoZEeCmpu-HRutBsg")

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
    |TransitionKind|) :xmi-id "_KqpEcDoZEeCmpu-HRutBsg")

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
    |ConnectorKind|) :xmi-id "_LPJfsDoZEeCmpu-HRutBsg")

(def-meta-package UML NIL :UML25 
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
    |Values|) :xmi-id "+The-Model+")

(def-meta-package |UseCases| UML :UML25 
   (|Actor|
    |Extend|
    |ExtensionPoint|
    |Include|
    |UseCase|) :xmi-id "_LuIhwDoZEeCmpu-HRutBsg")

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
    |ValueSpecification|) :xmi-id "_MYJvIDoZEeCmpu-HRutBsg")

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