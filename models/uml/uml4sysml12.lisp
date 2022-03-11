;;; Automatically created by pop-gen at 2013-12-30 13:48:17.
;;; Source file is UML4SysML-metamodel.uml

(in-package :UML4SYSML12)



(def-meta-primitive |Boolean| (:model :UML4SYSML12 :superclasses NIL :xmi-id "Boolean"))



(def-meta-primitive |Integer| (:model :UML4SYSML12 :superclasses NIL :xmi-id "Integer"))



(def-meta-primitive |String| (:model :UML4SYSML12 :superclasses NIL :xmi-id "String"))



(def-meta-primitive |UnlimitedNatural| (:model :UML4SYSML12 :superclasses NIL :xmi-id "UnlimitedNatural"))



(def-meta-enum |AggregationKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "AggregationKind")
   (|none| |shared| |composite|)
   "AggregationKind is an enumeration type that specifies the literals for
    defining the kind of aggregation of a property.")



(def-meta-enum |CallConcurrencyKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "CallConcurrencyKind")
   (|sequential| |guarded| |concurrent|)
   "CallConcurrencyKind is an enumeration type.")



(def-meta-enum |InteractionOperatorKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "InteractionOperatorKind")
   (|seq| |alt| |opt| |break| |par| |strict| |loop| |critical| |neg| |assert| |ignore| |consider|)
   "InteractionOperatorKind is an enumeration designating the different kinds
    of operators of combined fragments. The interaction operand defines the
    type of operator of a combined fragment.")



(def-meta-enum |MessageKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "MessageKind")
   (|complete| |lost| |found| |unknown|)
   "This is an enumerated type that identifies the type of message.")



(def-meta-enum |MessageSort| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "MessageSort")
   (|synchCall| |asynchCall| |asynchSignal| |createMessage| |deleteMessage| |reply|)
   "This is an enumerated type that identifies the type of communication action
    that was used to generate the message.")



(def-meta-enum |ObjectNodeOrderingKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "ObjectNodeOrderingKind")
   (|unordered| |ordered| LIFO FIFO)
   "ObjectNodeOrderingKind is an enumeration indicating queuing order within
    a node.")



(def-meta-enum |ParameterDirectionKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "ParameterDirectionKind")
   (|in| |inout| |out| |return|)
   "Parameter direction kind is an enumeration type that defines literals used
    to specify direction of parameters.")



(def-meta-enum |ParameterEffectKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "ParameterEffectKind")
   (|create| |read| |update| |delete|)
   "The datatype ParameterEffectKind is an enumeration that indicates the effect
    of a behavior on values passed in or out of its parameters.")



(def-meta-enum |PseudostateKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "PseudostateKind")
   (|initial| |deepHistory| |shallowHistory| |join| |fork| |junction| |choice| |entryPoint| |exitPoint| |terminate|)
   "PseudostateKind is an enumeration type.")



(def-meta-enum |TransitionKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "TransitionKind")
   (|internal| |local| |external|)
   "TransitionKind is an enumeration type.")



(def-meta-enum |VisibilityKind| (:model :UML4SYSML12 :superclasses NIL 
   :xmi-id "VisibilityKind")
   (|public| |private| |protected| |package|)
   "VisibilityKind is an enumeration type that defines literals to determine
    the visibility of elements in a model.")



;;; =========================================================
;;; ====================== Abstraction
;;; =========================================================
(def-meta-class |Abstraction| 
   (:model :UML4SYSML12 :superclasses (|Dependency|) 
    :packages (|UML4SysML|) 
    :xmi-id "Abstraction")
 "An abstraction is a relationship that relates two elements or sets of elements
  that represent the same concept at different levels of abstraction or from
  different viewpoints."
  ((|mapping| :xmi-id "Abstraction-mapping"
    :range |OpaqueExpression| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An composition of an Expression that states the abstraction relationship
      between the supplier and the client. In some cases, such as Derivation,
      it is usually formal and unidirectional; in other cases, such as Trace,
      it is usually informal and bidirectional. The mapping expression is optional
      and may be omitted if the precise relationship between the elements is
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
   (:model :UML4SYSML12 :superclasses (|AcceptEventAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "AcceptCallAction")
 "An accept call action is an accept event action representing the receipt
  of a synchronous call request. In addition to the normal operation parameters,
  the action produces an output that is needed later to supply the information
  to the reply action necessary to return control to the caller. This action
  is for synchronous calls. If it is used to handle an asynchronous call,
  execution of the subsequent reply action will complete immediately with
  no effects."
  ((|returnInformation| :xmi-id "AcceptCallAction-returnInformation"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Pin where a value is placed containing sufficient information to perform
      a subsequent reply and return control to the caller. The contents of this
      value are opaque. It can be passed and copied but it cannot be manipulated
      by the model.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "AcceptEventAction")
 "A accept event action is an action that waits for the occurrence of an
  event meeting specified conditions."
  ((|isUnmarshall| :xmi-id "AcceptEventAction-isUnmarshall"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether there is a single output pin for the event, or multiple
      output pins for attributes of the event.")
   (|result| :xmi-id "AcceptEventAction-result"
    :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Pins holding the received event objects or their attributes. Event objects
      may be copied in transmission, so identity might not be preserved.")
   (|trigger| :xmi-id "AcceptEventAction-trigger"
    :range |Trigger| :multiplicity (1 -1) :is-composite-p T
    :documentation
     "The type of events accepted by the action, as specified by triggers. For
      triggers with signal events, a signal of the specified type or any subtype
      of the specified signal type is accepted.")))

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
   (:model :UML4SYSML12 :superclasses (|ExecutableNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "Action")
 "An action is a named element that is the fundamental unit of executable
  functionality. The execution of an action represents some transformation
  or processing in the modeled system, be it a computer system or otherwise.An
  action represents a single step within an activity, that is, one that is
  not further decomposed within the activity.An action has pre- and post-conditions."
  ((|context| :xmi-id "Action-context"
    :range |Classifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The classifier that owns the behavior of which this action is a part.")
   (|input| :xmi-id "Action-input"
    :range |InputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ordered set of input pins connected to the Action. These are among
      the total set of inputs.")
   (|isLocallyReentrant| :xmi-id "Action-isLocallyReentrant"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the action can begin a new, concurrent execution, even if there
      is already another execution of the action ongoing. If false, the action
      cannot begin a new execution until any previous execution has completed.")
   (|localPostcondition| :xmi-id "Action-localPostcondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Constraint that must be satisfied when executed is completed.")
   (|localPrecondition| :xmi-id "Action-localPrecondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Constraint that must be satisfied when execution is started.")
   (|output| :xmi-id "Action-output"
    :range |OutputPin| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The ordered set of output pins connected to the Action. The action places
      its results onto pins in this set.")))

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
   (:model :UML4SYSML12 :superclasses (|ExecutionSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActionExecutionSpecification")
 "An action execution specification is a kind of execution specification
  representing the execution of an action."
  ((|action| :xmi-id "ActionExecutionSpecification-action"
    :range |Action| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|InputPin|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActionInputPin")
 "An action input pin is a kind of pin that executes an action to determine
  the values to input to another."
  ((|fromAction| :xmi-id "ActionInputPin-fromAction"
    :range |Action| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The action used to provide values.")))

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
   (:model :UML4SYSML12 :superclasses (|Behavior|) 
    :packages (|UML4SysML|) 
    :xmi-id "Activity")
 "An activity is the specification of parameterized behavior as the coordinated
  sequencing of subordinate units whose individual elements are actions."
  ((|edge| :xmi-id "Activity-edge"
    :range |ActivityEdge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityEdge| |activity|)
    :documentation
     "Edges expressing flow between nodes of the activity.")
   (|group| :xmi-id "Activity-group"
    :range |ActivityGroup| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |inActivity|)
    :documentation
     "Top-level groups in the activity.")
   (|isReadOnly| :xmi-id "Activity-isReadOnly"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, this activity must not make any changes to variables outside the
      activity or to objects. (This is an assertion, not an executable property.
      It may be used by an execution engine to optimize model execution. If the
      assertion is violated by the action, then the model is ill-formed.) The
      default is false (an activity may make nonlocal changes).")
   (|isSingleExecution| :xmi-id "Activity-isSingleExecution"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, all invocations of the activity are handled by the same execution.")
   (|node| :xmi-id "Activity-node"
    :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityNode| |activity|)
    :documentation
     "Nodes coordinated by the activity.")
   (|partition| :xmi-id "Activity-partition"
    :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|Activity| |group|))
    :documentation
     "Top-level partitions in the activity.")
   (|structuredNode| :xmi-id "Activity-structuredNode"
    :range |StructuredActivityNode| :multiplicity (0 -1) :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Activity| |node|) (|Activity| |group|))
    :opposite (|StructuredActivityNode| |activity|)
    :documentation
     "Top-level structured nodes in the activity.")
   (|variable| :xmi-id "Activity-variable"
    :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |activityScope|)
    :documentation
     "Top-level variables in the activity.")))

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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityEdge")
 "An activity edge is an abstract class for directed connections between
  two activity nodes.Activity edges can be contained in interruptible regions."
  ((|activity| :xmi-id "ActivityEdge-activity"
    :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |edge|)
    :documentation
     "Activity containing the edge.")
   (|guard| :xmi-id "ActivityEdge-guard"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specification evaluated at runtime to determine if the edge can be traversed.")
   (|inGroup| :xmi-id "ActivityEdge-inGroup"
    :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedEdge|)
    :documentation
     "Groups containing the edge.")
   (|inPartition| :xmi-id "ActivityEdge-inPartition"
    :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityEdge| |inGroup|))
    :opposite (|ActivityPartition| |edge|)
    :documentation
     "Partitions containing the edge.")
   (|interrupts| :xmi-id "ActivityEdge-interrupts"
    :range |InterruptibleActivityRegion| :multiplicity (0 1)
    :opposite (|InterruptibleActivityRegion| |interruptingEdge|)
    :documentation
     "Region that the edge can interrupt.")
   (|redefinedEdge| :xmi-id "ActivityEdge-redefinedEdge"
    :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "Inherited edges replaced by this edge in a specialization of the activity.")
   (|source| :xmi-id "ActivityEdge-source"
    :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |outgoing|)
    :documentation
     "Node from which tokens are taken when they traverse the edge.")
   (|target| :xmi-id "ActivityEdge-target"
    :range |ActivityNode| :multiplicity (1 1)
    :opposite (|ActivityNode| |incoming|)
    :documentation
     "Node to which tokens are put when they traverse the edge.")
   (|weight| :xmi-id "ActivityEdge-weight"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The minimum number of tokens that must traverse the edge at the same time.")))

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

(def-meta-assoc "A_target_incoming"      
  :name |A_target_incoming|      
  :metatype :association      
  :member-ends ((|ActivityEdge| "target")
                (|ActivityNode| "incoming"))      
  :owned-ends  ())

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
   (:model :UML4SYSML12 :superclasses (|FinalNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityFinalNode")
 "An activity final node is a final node that stops all flows in an activity."
  ())

;;; =========================================================
;;; ====================== ActivityGroup
;;; =========================================================
(def-meta-class |ActivityGroup| 
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityGroup")
 "ActivityGroup is an abstract class for defining sets of nodes and edges
  in an activity."
  ((|containedEdge| :xmi-id "ActivityGroup-containedEdge"
    :range |ActivityEdge| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityEdge| |inGroup|)
    :documentation
     "Edges immediately contained in the group.")
   (|containedNode| :xmi-id "ActivityGroup-containedNode"
    :range |ActivityNode| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityNode| |inGroup|)
    :documentation
     "Nodes immediately contained in the group.")
   (|inActivity| :xmi-id "ActivityGroup-inActivity"
    :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |group|)
    :documentation
     "Activity containing the group.")
   (|subgroup| :xmi-id "ActivityGroup-subgroup"
    :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ActivityGroup| |superGroup|)
    :documentation
     "Groups immediately contained in the group.")
   (|superGroup| :xmi-id "ActivityGroup-superGroup"
    :range |ActivityGroup| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|ActivityGroup| |subgroup|)
    :documentation
     "Group immediately containing the group.")))

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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityNode")
 "ActivityNode is an abstract class for points in the flow of an activity
  connected by edges."
  ((|activity| :xmi-id "ActivityNode-activity"
    :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Activity| |node|)
    :documentation
     "Activity containing the node.")
   (|inGroup| :xmi-id "ActivityNode-inGroup"
    :range |ActivityGroup| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|ActivityGroup| |containedNode|)
    :documentation
     "Groups containing the node.")
   (|inInterruptibleRegion| :xmi-id "ActivityNode-inInterruptibleRegion"
    :range |InterruptibleActivityRegion| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|InterruptibleActivityRegion| |node|)
    :documentation
     "Interruptible regions containing the node.")
   (|inPartition| :xmi-id "ActivityNode-inPartition"
    :range |ActivityPartition| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|ActivityPartition| |node|)
    :documentation
     "Partitions containing the node.")
   (|inStructuredNode| :xmi-id "ActivityNode-inStructuredNode"
    :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|ActivityNode| |inGroup|))
    :opposite (|StructuredActivityNode| |node|)
    :documentation
     "Structured activity node containing the node.")
   (|incoming| :xmi-id "ActivityNode-incoming"
    :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |target|)
    :documentation
     "Edges that have the node as target.")
   (|outgoing| :xmi-id "ActivityNode-outgoing"
    :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |source|)
    :documentation
     "Edges that have the node as source.")
   (|redefinedNode| :xmi-id "ActivityNode-redefinedNode"
    :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "Inherited nodes replaced by this node in a specialization of the activity.")))

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

(def-meta-assoc "A_outgoing_source"      
  :name |A_outgoing_source|      
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
   (:model :UML4SYSML12 :superclasses (|ObjectNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityParameterNode")
 "An activity parameter node is an object node for inputs and outputs to
  activities."
  ((|parameter| :xmi-id "ActivityParameterNode-parameter"
    :range |Parameter| :multiplicity (1 1)
    :documentation
     "The parameter the object node will be accepting or providing values for.")))

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
   (:model :UML4SYSML12 :superclasses (|ActivityGroup|) 
    :packages (|UML4SysML|) 
    :xmi-id "ActivityPartition")
 "An activity partition is a kind of activity group for identifying actions
  that have some characteristic in common."
  ((|edge| :xmi-id "ActivityPartition-edge"
    :range |ActivityEdge| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedEdge|))
    :opposite (|ActivityEdge| |inPartition|)
    :documentation
     "Edges immediately contained in the group.")
   (|isDimension| :xmi-id "ActivityPartition-isDimension"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the partition groups other partitions along a dimension.")
   (|isExternal| :xmi-id "ActivityPartition-isExternal"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the partition represents an entity to which the partitioning
      structure does not apply.")
   (|node| :xmi-id "ActivityPartition-node"
    :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inPartition|)
    :documentation
     "Nodes immediately contained in the group.")
   (|represents| :xmi-id "ActivityPartition-represents"
    :range |Element| :multiplicity (0 1)
    :documentation
     "An element constraining behaviors invoked by nodes in the partition.")
   (|subpartition| :xmi-id "ActivityPartition-subpartition"
    :range |ActivityPartition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |subgroup|))
    :opposite (|ActivityPartition| |superPartition|)
    :documentation
     "Partitions immediately contained in the partition.")
   (|superPartition| :xmi-id "ActivityPartition-superPartition"
    :range |ActivityPartition| :multiplicity (0 1)
    :subsetted-properties ((|ActivityGroup| |superGroup|))
    :opposite (|ActivityPartition| |subpartition|)
    :documentation
     "Partition immediately containing the partition.")))

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
   (:model :UML4SYSML12 :superclasses (|BehavioredClassifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "Actor")
 "An actor specifies a role played by a user or any other system that interacts
  with the subject."
  ())

;;; =========================================================
;;; ====================== AddStructuralFeatureValueAction
;;; =========================================================
(def-meta-class |AddStructuralFeatureValueAction| 
   (:model :UML4SYSML12 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "AddStructuralFeatureValueAction")
 "An add structural feature value action is a write structural feature action
  for adding values to a structural feature."
  ((|insertAt| :xmi-id "AddStructuralFeatureValueAction-insertAt"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the position at which to insert a new value or move an existing value
      in ordered structural features. The type of the pin is UnlimitedNatural,
      but the value cannot be zero. This pin is omitted for unordered structural
      features.")
   (|isReplaceAll| :xmi-id "AddStructuralFeatureValueAction-isReplaceAll"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the structural feature of the object
      should be removed before adding the new value.")))

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
   (:model :UML4SYSML12 :superclasses (|WriteVariableAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "AddVariableValueAction")
 "An add variable value action is a write variable action for adding values
  to a variable."
  ((|insertAt| :xmi-id "AddVariableValueAction-insertAt"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the position at which to insert a new value or move an existing value
      in ordered variables. The types is UnlimitedINatural, but the value cannot
      be zero. This pin is omitted for unordered variables.")
   (|isReplaceAll| :xmi-id "AddVariableValueAction-isReplaceAll"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing values of the variable should be removed before
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
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "AnyReceiveEvent")
 "A trigger for an AnyReceiveEvent is triggered by the receipt of any message
  that is not explicitly handled by any related trigger."
  ())

;;; =========================================================
;;; ====================== Association
;;; =========================================================
(def-meta-class |Association| 
   (:model :UML4SYSML12 :superclasses (|Relationship| |Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "Association")
 "An association describes a set of tuples whose values refer to typed instances.
  An instance of an association is called a link.A link is a tuple with one
  value for each end of the association, where each value is an instance
  of the type of the end.An association describes a set of tuples whose values
  refer to typed instances. An instance of an association is called a link.
  A link is a tuple with one value for each end of the association, where
  each value is an instance of the type of the end."
  ((|endType| :xmi-id "Association-endType"
    :range |Type| :multiplicity (1 -1) :is-readonly-p T :is-ordered-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "References the classifiers that are used as types of the ends of the association.")
   (|isDerived| :xmi-id "Association-isDerived"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the association is derived from other model elements
      such as other associations or constraints.")
   (|memberEnd| :xmi-id "Association-memberEnd"
    :range |Property| :multiplicity (2 -1) :is-ordered-p T
    :subsetted-properties ((|Namespace| |member|))
    :opposite (|Property| |association|)
    :documentation
     "Each end represents participation of instances of the classifier connected
      to the end in links of the association.")
   (|navigableOwnedEnd| :xmi-id "Association-navigableOwnedEnd"
    :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|Association| |ownedEnd|))
    :documentation
     "The navigable ends that are owned by the association itself.")
   (|ownedEnd| :xmi-id "Association-ownedEnd"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Association| |memberEnd|) (|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Property| |owningAssociation|)
    :documentation
     "The ends that are owned by the association itself.")))

(def-meta-operation "endType.1" |Association| 
   "endType is derived from the types of the member ends."
   :operation-body
   "result = self.memberEnd->collect(e | e.type)"
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
   (:model :UML4SYSML12 :superclasses (|Association| |Class|) 
    :packages (|UML4SysML|) 
    :xmi-id "AssociationClass")
 "A model element that has both association and class properties. An AssociationClass
  can be seen as an association that also has class properties, or as a class
  that also has association properties. It not only connects a set of classifiers
  but also defines a set of features that belong to the relationship itself
  and not to any of the classifiers."
  ())

;;; =========================================================
;;; ====================== Behavior
;;; =========================================================
(def-meta-class |Behavior| 
   (:model :UML4SYSML12 :superclasses (|Class|) 
    :packages (|UML4SysML|) 
    :xmi-id "Behavior")
 "Behavior is a specification of how its context classifier changes state
  over time. This specification may be either a definition of possible behavior
  execution or emergent behavior, or a selective illustration of an interesting
  subset of possible executions. The latter form is typically used for capturing
  examples, such as a trace of a particular execution.A behavior owns zero
  or more parameter sets."
  ((|context| :xmi-id "Behavior-context"
    :range |BehavioredClassifier| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|RedefinableElement| |redefinitionContext|))
    :documentation
     "The classifier that is the context for the execution of the behavior. If
      the behavior is owned by a BehavioredClassifier, that classifier is the
      context. Otherwise, the context is the first BehavioredClassifier reached
      by following the chain of owner relationships. For example, following this
      algorithm, the context of an entry action in a state machine is the classifier
      that owns the state machine. The features of the context classifier as
      well as the elements visible to the context classifier are visible to the
      behavior.")
   (|isReentrant| :xmi-id "Behavior-isReentrant"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether the behavior can be invoked while it is still executing from
      a previous invocation.")
   (|ownedParameter| :xmi-id "Behavior-ownedParameter"
    :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References a list of parameters to the behavior which describes the order
      and type of arguments that can be given when the behavior is invoked and
      of the values which will be returned when the behavior completes its execution.")
   (|ownedParameterSet| :xmi-id "Behavior-ownedParameterSet"
    :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The ParameterSets owned by this Behavior.")
   (|postcondition| :xmi-id "Behavior-postcondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying what is fulfilled after the execution
      of the behavior is completed, if its precondition was fulfilled before
      its invocation.")
   (|precondition| :xmi-id "Behavior-precondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying what must be fulfilled when the
      behavior is invoked.")
   (|redefinedBehavior| :xmi-id "Behavior-redefinedBehavior"
    :range |Behavior| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References a behavior that this behavior redefines. A subtype of Behavior
      may redefine any other subtype of Behavior. If the behavior implements
      a behavioral feature, it replaces the redefined behavior. If the behavior
      is a classifier behavior, it extends the redefined behavior.")
   (|specification| :xmi-id "Behavior-specification"
    :range |BehavioralFeature| :multiplicity (0 1)
    :opposite (|BehavioralFeature| |method|)
    :documentation
     "Designates a behavioral feature that the behavior implements. The behavioral
      feature must be owned by the classifier that owns the behavior or be inherited
      by it. The parameters of the behavioral feature and the implementing behavior
      must match. A behavior does not need to have a specification, in which
      case it either is the classifer behavior of a BehavioredClassifier or it
      can only be invoked by another behavior of the classifier.")))

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
   (:model :UML4SYSML12 :superclasses (|ExecutionSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "BehaviorExecutionSpecification")
 "A behavior execution specification is a kind of execution specification
  representing the execution of a behavior."
  ((|behavior| :xmi-id "BehaviorExecutionSpecification-behavior"
    :range |Behavior| :multiplicity (0 1)
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
   (:model :UML4SYSML12 :superclasses (|Feature| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "BehavioralFeature")
 "A behavioral feature is a feature of a classifier that specifies an aspect
  of the behavior of its instances.A behavioral feature is implemented (realized)
  by a behavior. A behavioral feature specifies that a classifier will respond
  to a designated request by invoking its implementing method.A behavioral
  feature owns zero or more parameter sets."
  ((|concurrency| :xmi-id "BehavioralFeature-concurrency"
    :range |CallConcurrencyKind| :multiplicity (1 1) :default :sequential
    :documentation
     "Specifies the semantics of concurrent calls to the same passive instance
      (i.e., an instance originating from a class with isActive being false).
      Active instances control access to their own behavioral features.")
   (|isAbstract| :xmi-id "BehavioralFeature-isAbstract"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, then the behavioral feature does not have an implementation, and
      one must be supplied by a more specific element. If false, the behavioral
      feature must have an implementation in the classifier or one must be inherited
      from a more general element.")
   (|method| :xmi-id "BehavioralFeature-method"
    :range |Behavior| :multiplicity (0 -1)
    :opposite (|Behavior| |specification|)
    :documentation
     "A behavioral description that implements the behavioral feature. There
      may be at most one behavior for a particular pairing of a classifier (as
      owner of the behavior) and a behavioral feature (as specification of the
      behavior).")
   (|ownedParameter| :xmi-id "BehavioralFeature-ownedParameter"
    :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the ordered set of formal parameters of this BehavioralFeature.")
   (|ownedParameterSet| :xmi-id "BehavioralFeature-ownedParameterSet"
    :range |ParameterSet| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "The ParameterSets owned by this BehavioralFeature.")
   (|raisedException| :xmi-id "BehavioralFeature-raisedException"
    :range |Type| :multiplicity (0 -1)
    :documentation
     "References the Types representing exceptions that may be raised during
      an invocation of this feature.")))

(def-meta-operation "isDistinguishableFrom" |BehavioralFeature| 
   "The query isDistinguishableFrom() determines whether two BehavioralFeatures
    may coexist in the same Namespace. It specifies that they have to have
    different signatures."
   :operation-body
   "result = if n.oclIsKindOf(BehavioralFeature) then   if ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()   then Set{}->including(self)->including(n)->isUnique(bf | bf.ownedParameter->collect(type))   else true   endif else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
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
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "BehavioredClassifier")
 "A behaviored classifier may have an interface realization.A classifier
  can have behavior specifications defined in its namespace. One of these
  may specify the behavior of the classifier itself."
  ((|classifierBehavior| :xmi-id "BehavioredClassifier-classifierBehavior"
    :range |Behavior| :multiplicity (0 1)
    :subsetted-properties ((|BehavioredClassifier| |ownedBehavior|))
    :documentation
     "A behavior specification that specifies the behavior of the classifier
      itself.")
   (|interfaceRealization| :xmi-id "BehavioredClassifier-interfaceRealization"
    :range |InterfaceRealization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|InterfaceRealization| |implementingClassifier|)
    :documentation
     "The set of InterfaceRealizations owned by the BehavioredClassifier. Interface
      realizations reference the Interfaces of which the BehavioredClassifier
      is an implementation.")
   (|ownedBehavior| :xmi-id "BehavioredClassifier-ownedBehavior"
    :range |Behavior| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References behavior specifications owned by a classifier.")
   (|ownedTrigger| :xmi-id "BehavioredClassifier-ownedTrigger"
    :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References Trigger descriptions owned by a Classifier.")))

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

(def-meta-assoc "A_ownedParameter_behavioredClassifier"      
  :name |A_ownedParameter_behavioredClassifier|      
  :metatype :association      
  :member-ends ((|BehavioredClassifier| "ownedBehavior")
                ("A_ownedParameter_behavioredClassifier-behavioredClassifier" "behavioredClassifier"))      
  :owned-ends  (("A_ownedParameter_behavioredClassifier-behavioredClassifier" "behavioredClassifier")))

(def-meta-assoc-end "A_ownedParameter_behavioredClassifier-behavioredClassifier" 
    :type |BehavioredClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedParameter_behavioredClassifier" 
    :name "behavioredClassifier")

(def-meta-assoc "A_ownedTrigger_behavioredClassifier"      
  :name |A_ownedTrigger_behavioredClassifier|      
  :metatype :association      
  :member-ends ((|BehavioredClassifier| "ownedTrigger")
                ("A_ownedTrigger_behavioredClassifier-behavioredClassifier" "behavioredClassifier"))      
  :owned-ends  (("A_ownedTrigger_behavioredClassifier-behavioredClassifier" "behavioredClassifier")))

(def-meta-assoc-end "A_ownedTrigger_behavioredClassifier-behavioredClassifier" 
    :type |BehavioredClassifier| 
    :multiplicity (0 1) 
    :association "A_ownedTrigger_behavioredClassifier" 
    :name "behavioredClassifier")

;;; =========================================================
;;; ====================== BroadcastSignalAction
;;; =========================================================
(def-meta-class |BroadcastSignalAction| 
   (:model :UML4SYSML12 :superclasses (|InvocationAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "BroadcastSignalAction")
 "A broadcast signal action is an action that transmits a signal instance
  to all the potential target objects in the system, which may cause the
  firing of a state machine transitions or the execution of associated activities
  of a target object. The argument values are available to the execution
  of associated behaviors. The requestor continues execution immediately
  after the signals are sent out. It does not wait for receipt. Any reply
  messages are ignored and are not transmitted to the requestor."
  ((|signal| :xmi-id "BroadcastSignalAction-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The specification of signal object transmitted to the target objects.")))

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
   (:model :UML4SYSML12 :superclasses (|InvocationAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "CallAction")
 "CallAction is an abstract class for actions that invoke behavior and receive
  return values."
  ((|isSynchronous| :xmi-id "CallAction-isSynchronous"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true, the call is synchronous and the caller waits for completion of
      the invoked behavior.  If false, the call is asynchronous and the caller
      proceeds immediately and does not expect a return values.")
   (|result| :xmi-id "CallAction-result"
    :range |OutputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "A list of output pins where the results of performing the invocation are
      placed.")))

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
   (:model :UML4SYSML12 :superclasses (|CallAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "CallBehaviorAction")
 "A call behavior action is a call action that invokes a behavior directly
  rather than invoking a behavioral feature that, in turn, results in the
  invocation of that behavior. The argument values of the action are available
  to the execution of the invoked behavior. For synchronous calls the execution
  of the call behavior action waits until the execution of the invoked behavior
  completes and a result is returned on its output pin. The action completes
  immediately without a result, if the call is asynchronous. In particular,
  the invoked behavior may be an activity."
  ((|behavior| :xmi-id "CallBehaviorAction-behavior"
    :range |Behavior| :multiplicity (1 1)
    :documentation
     "The invoked behavior. It must be capable of accepting and returning control.")))

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
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "CallEvent")
 "A call event models the receipt by an object of a message invoking a call
  of an operation."
  ((|operation| :xmi-id "CallEvent-operation"
    :range |Operation| :multiplicity (1 1)
    :documentation
     "Designates the operation whose invocation raised the call event.")))

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
   (:model :UML4SYSML12 :superclasses (|CallAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "CallOperationAction")
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
  ((|operation| :xmi-id "CallOperationAction-operation"
    :range |Operation| :multiplicity (1 1)
    :documentation
     "The operation to be invoked by the action execution.")
   (|target| :xmi-id "CallOperationAction-target"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The target object to which the request is sent. The classifier of the target
      object is used to dynamically determine a behavior to invoke. This object
      constitutes the context of the execution of the operation.")))

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
   (:model :UML4SYSML12 :superclasses (|ObjectNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "CentralBufferNode")
 "A central buffer node is an object node for managing flows from multiple
  sources and destinations."
  ())

;;; =========================================================
;;; ====================== ChangeEvent
;;; =========================================================
(def-meta-class |ChangeEvent| 
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "ChangeEvent")
 "A change event models a change in the system configuration that makes a
  condition true."
  ((|changeExpression| :xmi-id "ChangeEvent-changeExpression"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Boolean-valued expression that will result in a change event whenever
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
   (:model :UML4SYSML12 :superclasses (|BehavioredClassifier| |EncapsulatedClassifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "Class")
 "A class describes a set of objects that share the same specifications of
  features, constraints, and semantics.A class may be designated as active
  (i.e., each of its instances having its own thread of control) or passive
  (i.e., each of its instances executing within the context of some other
  object). A class may also specify which signals the instances of this class
  handle.Class has derived association that indicates how it may be extended
  through one or more stereotypes. Stereotype is the only kind of metaclass
  that cannot be extended by stereotypes.A class has the capability to have
  an internal structure and ports."
  ((|extension| :xmi-id "Class-extension"
    :range |Extension| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :opposite (|Extension| |metaclass|)
    :documentation
     "References the Extensions that specify additional properties of the metaclass.
      The property is derived from the extensions whose memberEnds are typed
      by the Class.")
   (|isAbstract| :xmi-id "Class-isAbstract"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "True when a class is abstract. If true, the Classifier does not provide
      a complete declaration and can typically not be instantiated. An abstract
      classifier is intended to be used by other classifiers e.g. as the target
      of general metarelationships or generalization relationships." :redefined-property (|Classifier| |isAbstract|))
   (|isActive| :xmi-id "Class-isActive"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Determines whether an object specified by this class is active or not.
      If true, then the owning class is referred to as an active class. If false,
      then such a class is referred to as a passive class.")
   (|nestedClassifier| :xmi-id "Class-nestedClassifier"
    :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References all the Classifiers that are defined (nested) within the Class.")
   (|ownedAttribute| :xmi-id "Class-ownedAttribute"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |class|)
    :documentation
     "The attributes (i.e. the properties) owned by the class." :redefined-property (|StructuredClassifier| |ownedAttribute|))
   (|ownedOperation| :xmi-id "Class-ownedOperation"
    :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |class|)
    :documentation
     "The operations owned by the class.")
   (|ownedReception| :xmi-id "Class-ownedReception"
    :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "Receptions that objects of this class are willing to accept.")
   (|superClass| :xmi-id "Class-superClass"
    :range |Class| :multiplicity (0 -1) :is-derived-p T
    :documentation
     "This gives the superclasses of a class." :redefined-property (|Classifier| |general|))))

(def-meta-operation "inherit" |Class| 
   "The inherit operation is overridden to exclude redefined properties."
   :operation-body
   "result = inhs->excluding(inh | ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-assoc "A_extension_metaclass"      
  :name |A_extension_metaclass|      
  :metatype :association      
  :member-ends ((|Class| "extension")
                (|Extension| "metaclass"))      
  :owned-ends  ())

(def-meta-assoc "A_nestedClassifier_class"      
  :name |A_nestedClassifier_class|      
  :metatype :association      
  :member-ends ((|Class| "nestedClassifier")
                ("A_nestedClassifier_class-class" "class"))      
  :owned-ends  (("A_nestedClassifier_class-class" "class")))

(def-meta-assoc-end "A_nestedClassifier_class-class" 
    :type |Class| 
    :multiplicity (0 1) 
    :association "A_nestedClassifier_class" 
    :name "class")

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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement| |Type| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "Classifier")
 "A classifier is a classification of instances - it describes a set of instances
  that have features in common. A classifier can specify a generalization
  hierarchy by referencing its general classifiers.A classifier has the capability
  to own collaboration uses. These collaboration uses link a collaboration
  with the classifier to give a description of the workings of the classifier.A
  classifier has the capability to own use cases. Although the owning classifier
  typically represents the subject to which the owned use cases apply, this
  is not necessarily the case. In principle, the same use case can be applied
  to multiple subjects, as identified by the subject association role of
  a use case."
  ((|attribute| :xmi-id "Classifier-attribute"
    :range |Property| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Classifier| |feature|))
    :documentation
     "Refers to all of the Properties that are direct (i.e. not inherited or
      imported) attributes of the classifier.")
   (|feature| :xmi-id "Classifier-feature"
    :range |Feature| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "Note that there may be members of the Classifier that are of the type Feature
      but are not included in this association, e.g. inherited features. Specifies
      each feature defined in the classifier.")
   (|general| :xmi-id "Classifier-general"
    :range |Classifier| :multiplicity (0 -1) :is-derived-p T
    :documentation
     "References the general classifier in the Generalization relationship. Specifies
      the general Classifiers for this Classifier.")
   (|generalization| :xmi-id "Classifier-generalization"
    :range |Generalization| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Generalization| |specific|)
    :documentation
     "Specifies the Generalization relationships for this Classifier. These Generalizations
      navigaten to more general classifiers in the generalization hierarchy.")
   (|inheritedMember| :xmi-id "Classifier-inheritedMember"
    :range |NamedElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "Specifies all elements inherited by this classifier from the general classifiers.")
   (|isAbstract| :xmi-id "Classifier-isAbstract"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier does not provide a complete declaration and can
      typically not be instantiated. An abstract classifier is intended to be
      used by other classifiers e.g. as the target of general metarelationships
      or generalization relationships.")
   (|isFinalSpecialization| :xmi-id "Classifier-isFinalSpecialization"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the Classifier cannot be specialized by generalization. Note that
      this property is preserved through package merge operations; that is, the
      capability to specialize a Classifier (i.e., isFinalSpecialization =false)
      must be preserved in the resulting Classifier of a package merge operation
      where a Classifier with isFinalSpecialization =false is merged with a matching
      Classifier with isFinalSpecialization =true: the resulting Classifier will
      have isFinalSpecialization =false.")
   (|ownedUseCase| :xmi-id "Classifier-ownedUseCase"
    :range |UseCase| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References the use cases owned by this classifier.")
   (|powertypeExtent| :xmi-id "Classifier-powertypeExtent"
    :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |powertype|)
    :documentation
     "Designates the GeneralizationSet of which the associated Classifier is
      a power type.")
   (|redefinedClassifier| :xmi-id "Classifier-redefinedClassifier"
    :range |Classifier| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References the Classifiers that are redefined by this Classifier.")
   (|substitution| :xmi-id "Classifier-substitution"
    :range |Substitution| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|) (|NamedElement| |clientDependency|))
    :opposite (|Substitution| |substitutingClassifier|)
    :documentation
     "References the substitutions that are owned by this Classifier.")
   (|useCase| :xmi-id "Classifier-useCase"
    :range |UseCase| :multiplicity (0 -1)
    :opposite (|UseCase| |subject|)
    :documentation
     "The set of use cases for which this Classifier is the subject.")))

(def-meta-operation "allFeatures" |Classifier| 
   "The query allFeatures() gives all of the features in the namespace of the
    classifier. In general, through mechanisms such as inheritance, this will
    be a larger set than feature."
   :operation-body
   "result = member->select(oclIsKindOf(Feature))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Feature|
                        :parameter-return-p T))
)

(def-meta-operation "allParents" |Classifier| 
   "The query allParents() gives all of the direct and indirect ancestors of
    a generalized Classifier."
   :operation-body
   "result = self.parents()->union(self.parents()->collect(p | p.allParents())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "conformsTo" |Classifier| 
   "The query conformsTo() gives true for a classifier that defines a type
    that conforms to another. This is used, for example, in the specification
    of signature conformance for operations."
   :operation-body
   "result = (self=other) or (self.allParents()->includes(other))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|Classifier|
                        :parameter-return-p NIL))
)

(def-meta-operation "general.1" |Classifier| 
   "The general classifiers are the classifiers referenced by the generalization
    relationships."
   :operation-body
   "result = self.parents()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Classifier|
                        :parameter-return-p T))
)

(def-meta-operation "hasVisibilityOf" |Classifier| 
   "The query hasVisibilityOf() determines whether a named element is visible
    in the classifier. By default all are visible. It is only called when the
    argument is something owned by a parent."
   :operation-body
   "result = if (self.inheritedMember->includes(n)) then (n.visibility <> #private) else true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "inherit" |Classifier| 
   "The inherit operation is overridden to exclude redefined properties. The
    query inherit() defines how to inherit a set of elements. Here the operation
    is defined to inherit them all. It is intended to be redefined in circumstances
    where inheritance is affected by redefinition."
   :operation-body
   "result = inhs"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "inheritableMembers" |Classifier| 
   "The query inheritableMembers() gives all of the members of a classifier
    that may be inherited in one of its descendants, subject to whatever visibility
    restrictions apply."
   :operation-body
   "result = member->select(m | c.hasVisibilityOf(m))"
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
   "result = self.inherit(self.parents()->collect(p | p.inheritableMembers(self))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T))
)

(def-meta-operation "maySpecializeType" |Classifier| 
   "The query maySpecializeType() determines whether this classifier may have
    a generalization relationship to classifiers of the specified type. By
    default a classifier may specialize classifiers of the same or a more general
    type. It is intended to be redefined by classifiers that have different
    specialization constraints."
   :operation-body
   "result = self.oclIsKindOf(c.oclType)"
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
   "result = generalization.general"
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

(def-meta-assoc "A_feature_classifier"      
  :name |A_feature_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "feature")
                ("A_feature_classifier-classifier" "classifier"))      
  :owned-ends  (("A_feature_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_feature_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 -1) 
    :association "A_feature_classifier" 
    :name "classifier" 
    :visibility :PUBLIC)

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

(def-meta-assoc "A_inheritedMember_classifier"      
  :name |A_inheritedMember_classifier|      
  :metatype :association      
  :member-ends ((|Classifier| "inheritedMember")
                ("A_inheritedMember_classifier-classifier" "classifier"))      
  :owned-ends  (("A_inheritedMember_classifier-classifier" "classifier")))

(def-meta-assoc-end "A_inheritedMember_classifier-classifier" 
    :type |Classifier| 
    :multiplicity (0 -1) 
    :association "A_inheritedMember_classifier" 
    :name "classifier")

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

(def-meta-assoc "A_substitution_substitutingClassifier"      
  :name |A_substitution_substitutingClassifier|      
  :metatype :association      
  :member-ends ((|Classifier| "substitution")
                (|Substitution| "substitutingClassifier"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== Clause
;;; =========================================================
(def-meta-class |Clause| 
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "Clause")
 "A clause is an element that represents a single branch of a conditional
  construct, including a test and a body section. The body section is executed
  only if (but not necessarily if) the test section evaluates true."
  ((|body| :xmi-id "Clause-body"
    :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "A nested activity fragment that is executed if the test evaluates to true
      and the clause is chosen over any concurrent clauses that also evaluate
      to true.")
   (|decider| :xmi-id "Clause-decider"
    :range |OutputPin| :multiplicity (1 1)
    :documentation
     "An output pin within the test fragment the value of which is examined after
      execution of the test to determine whether the body should be executed.")
   (|predecessorClause| :xmi-id "Clause-predecessorClause"
    :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |successorClause|)
    :documentation
     "A set of clauses whose tests must all evaluate false before the current
      clause can be tested.")
   (|successorClause| :xmi-id "Clause-successorClause"
    :range |Clause| :multiplicity (0 -1)
    :opposite (|Clause| |predecessorClause|)
    :documentation
     "A set of clauses which may not be tested unless the current clause tests
      false.")
   (|test| :xmi-id "Clause-test"
    :range |ExecutableNode| :multiplicity (1 -1)
    :documentation
     "A nested activity fragment with a designated output pin that specifies
      the result of the test.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ClearAssociationAction")
 "A clear association action is an action that destroys all links of an association
  in which a particular object participates."
  ((|association| :xmi-id "ClearAssociationAction-association"
    :range |Association| :multiplicity (1 1)
    :documentation
     "Association to be cleared.")
   (|object| :xmi-id "ClearAssociationAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the input pin from which is obtained the object whose participation
      in the association is to be cleared.")))

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
   (:model :UML4SYSML12 :superclasses (|StructuralFeatureAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "ClearStructuralFeatureAction")
 "A clear structural feature action is a structural feature action that removes
  all values of a structural feature."
  ((|result| :xmi-id "ClearStructuralFeatureAction-result"
    :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
   (:model :UML4SYSML12 :superclasses (|VariableAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "ClearVariableAction")
 "A clear variable action is a variable action that removes all values of
  a variable."
  ())

;;; =========================================================
;;; ====================== CombinedFragment
;;; =========================================================
(def-meta-class |CombinedFragment| 
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "CombinedFragment")
 "A combined fragment defines an expression of interaction fragments. A combined
  fragment is defined by an interaction operator and corresponding interaction
  operands. Through the use of combined fragments the user will be able to
  describe a number of traces in a compact and concise manner."
  ((|cfragmentGate| :xmi-id "CombinedFragment-cfragmentGate"
    :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies the gates that form the interface between this CombinedFragment
      and its surroundings")
   (|interactionOperator| :xmi-id "CombinedFragment-interactionOperator"
    :range |InteractionOperatorKind| :multiplicity (1 1) :default :seq
    :documentation
     "Specifies the operation which defines the semantics of this combination
      of InteractionFragments.")
   (|operand| :xmi-id "CombinedFragment-operand"
    :range |InteractionOperand| :multiplicity (1 -1) :is-composite-p T :is-ordered-p T
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
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "Comment")
 "A comment is a textual annotation that can be attached to a set of elements."
  ((|annotatedElement| :xmi-id "Comment-annotatedElement"
    :range |Element| :multiplicity (0 -1)
    :documentation
     "References the Element(s) being commented.")
   (|body| :xmi-id "Comment-body"
    :range |String| :multiplicity (0 1)
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
;;; ====================== ConditionalNode
;;; =========================================================
(def-meta-class |ConditionalNode| 
   (:model :UML4SYSML12 :superclasses (|StructuredActivityNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ConditionalNode")
 "A conditional node is a structured activity node that represents an exclusive
  choice among some number of alternatives."
  ((|clause| :xmi-id "ConditionalNode-clause"
    :range |Clause| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Set of clauses composing the conditional.")
   (|isAssured| :xmi-id "ConditionalNode-isAssured"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that at least one test will succeed.")
   (|isDeterminate| :xmi-id "ConditionalNode-isDeterminate"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the modeler asserts that at most one test will succeed.")))

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

;;; =========================================================
;;; ====================== ConnectableElement
;;; =========================================================
(def-meta-class |ConnectableElement| 
   (:model :UML4SYSML12 :superclasses (|TypedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ConnectableElement")
 "ConnectableElement is an abstract metaclass representing a set of instances
  that play roles of a classifier. Connectable elements may be joined by
  attached connectors and specify configurations of linked instances to be
  created within an instance of the containing classifier."
  ((|end| :xmi-id "ConnectableElement-end"
    :range |ConnectorEnd| :multiplicity (0 -1) :is-ordered-p T :is-derived-p T
    :opposite (|ConnectorEnd| |role|)
    :documentation
     "Denotes a connector that attaches to this connectable element.")))

(def-meta-operation "end.1" |ConnectableElement| 
   ""
   :operation-body
   "result = ConnectorEnd.allInstances()->select(e | e.role=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|ConnectorEnd|
                        :parameter-return-p T))
)

(def-meta-assoc "A_end_role"      
  :name |A_end_role|      
  :metatype :association      
  :member-ends ((|ConnectableElement| "end")
                (|ConnectorEnd| "role"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== ConnectionPointReference
;;; =========================================================
(def-meta-class |ConnectionPointReference| 
   (:model :UML4SYSML12 :superclasses (|Vertex|) 
    :packages (|UML4SysML|) 
    :xmi-id "ConnectionPointReference")
 "A connection point reference represents a usage (as part of a submachine
  state) of an entry/exit point defined in the statemachine reference by
  the submachine state."
  ((|entry| :xmi-id "ConnectionPointReference-entry"
    :range |Pseudostate| :multiplicity (0 -1)
    :documentation
     "The entryPoint kind pseudo states corresponding to this connection point.")
   (|exit| :xmi-id "ConnectionPointReference-exit"
    :range |Pseudostate| :multiplicity (0 -1)
    :documentation
     "The exitPoints kind pseudo states corresponding to this connection point.")
   (|state| :xmi-id "ConnectionPointReference-state"
    :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |connection|)
    :documentation
     "The State in which the connection point refreshens are defined.")))

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
   (:model :UML4SYSML12 :superclasses (|Feature|) 
    :packages (|UML4SysML|) 
    :xmi-id "Connector")
 "Specifies a link that enables communication between two or more instances.
  This link may be an instance of an association, or it may represent the
  possibility of the instances being able to communicate because their identities
  are known by virtue of being passed in as parameters, held in variables
  or slots, or because the communicating instances are the same instance.
  The link may be realized by something as simple as a pointer or by something
  as complex as a network connection. In contrast to associations, which
  specify links between any instance of the associated classifiers, connectors
  specify links between instances playing the connected parts only."
  ((|end| :xmi-id "Connector-end"
    :range |ConnectorEnd| :multiplicity (2 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A connector consists of at least two connector ends, each representing
      the participation of instances of the classifiers typing the connectable
      elements attached to this end. The set of connector ends is ordered.")
   (|redefinedConnector| :xmi-id "Connector-redefinedConnector"
    :range |Connector| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "A connector may be redefined when its containing classifier is specialized.
      The redefining connector may have a type that specializes the type of the
      redefined connector. The types of the connector ends of the redefining
      connector may specialize the types of the connector ends of the redefined
      connector. The properties of the connector ends of the redefining connector
      may be replaced.")
   (|type| :xmi-id "Connector-type"
    :range |Association| :multiplicity (0 1)
    :documentation
     "An optional association that specifies the link corresponding to this connector.")))

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
   (:model :UML4SYSML12 :superclasses (|MultiplicityElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ConnectorEnd")
 "A connector end is an endpoint of a connector, which attaches the connector
  to a connectable element. Each connector end is part of one connector."
  ((|definingEnd| :xmi-id "ConnectorEnd-definingEnd"
    :range |Property| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A derived association referencing the corresponding association end on
      the association which types the connector owing this connector end. This
      association is derived by selecting the association end at the same place
      in the ordering of association ends as this connector end.")
   (|partWithPort| :xmi-id "ConnectorEnd-partWithPort"
    :range |Property| :multiplicity (0 1)
    :documentation
     "Indicates the role of the internal structure of a classifier with the port
      to which the connector end is attached.")
   (|role| :xmi-id "ConnectorEnd-role"
    :range |ConnectableElement| :multiplicity (1 1)
    :opposite (|ConnectableElement| |end|)
    :documentation
     "The connectable element attached at this connector end. When an instance
      of the containing classifier is created, a link may (depending on the multiplicities)
      be created to an instance of the classifier that types this connectable
      element.")))

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
   (:model :UML4SYSML12 :superclasses (|CombinedFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "ConsiderIgnoreFragment")
 "A consider ignore fragment is a kind of combined fragment that is used
  for the consider and ignore cases, which require lists of pertinent messages
  to be specified."
  ((|message| :xmi-id "ConsiderIgnoreFragment-message"
    :range |NamedElement| :multiplicity (0 -1)
    :documentation
     "The set of messages that apply to this fragment")))

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
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Constraint")
 "A constraint is a condition or restriction expressed in natural language
  text or in a machine readable language for the purpose of declaring some
  of the semantics of an element."
  ((|constrainedElement| :xmi-id "Constraint-constrainedElement"
    :range |Element| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "The ordered set of Elements referenced by this Constraint.")
   (|context| :xmi-id "Constraint-context"
    :range |Namespace| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Namespace| |ownedRule|)
    :documentation
     "Specifies the namespace that owns the NamedElement.")
   (|specification| :xmi-id "Constraint-specification"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A condition that must be true when evaluated in order for the constraint
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
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "Continuation")
 "A continuation is a syntactic way to define continuations of different
  branches of an alternative combined fragment. Continuations is intuitively
  similar to labels representing intermediate points in a flow of control."
  ((|setting| :xmi-id "Continuation-setting"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "True: when the Continuation is at the end of the enclosing InteractionFragment
      and False when it is in the beginning.")))

;;; =========================================================
;;; ====================== ControlFlow
;;; =========================================================
(def-meta-class |ControlFlow| 
   (:model :UML4SYSML12 :superclasses (|ActivityEdge|) 
    :packages (|UML4SysML|) 
    :xmi-id "ControlFlow")
 "A control flow is an edge that starts an activity node after the previous
  one is finished."
  ())

;;; =========================================================
;;; ====================== ControlNode
;;; =========================================================
(def-meta-class |ControlNode| 
   (:model :UML4SYSML12 :superclasses (|ActivityNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ControlNode")
 "A control node is an abstract activity node that coordinates flows in an
  activity."
  ())

;;; =========================================================
;;; ====================== CreateLinkAction
;;; =========================================================
(def-meta-class |CreateLinkAction| 
   (:model :UML4SYSML12 :superclasses (|WriteLinkAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "CreateLinkAction")
 "A create link action is a write link action for creating links."
  ((|endData| :xmi-id "CreateLinkAction-endData"
    :range |LinkEndCreationData| :multiplicity (2 -1) :is-composite-p T
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))

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
   (:model :UML4SYSML12 :superclasses (|CreateLinkAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "CreateLinkObjectAction")
 "A create link object action creates a link object."
  ((|result| :xmi-id "CreateLinkObjectAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "CreateObjectAction")
 "A create object action is an action that creates an object that conforms
  to a statically specified classifier and puts it on an output pin at runtime."
  ((|classifier| :xmi-id "CreateObjectAction-classifier"
    :range |Classifier| :multiplicity (1 1)
    :documentation
     "Classifier to be instantiated.")
   (|result| :xmi-id "CreateObjectAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
;;; ====================== CreationEvent
;;; =========================================================
(def-meta-class |CreationEvent| 
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "CreationEvent")
 "A creation event models the creation of an object."
  ())

;;; =========================================================
;;; ====================== DataStoreNode
;;; =========================================================
(def-meta-class |DataStoreNode| 
   (:model :UML4SYSML12 :superclasses (|CentralBufferNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "DataStoreNode")
 "A data store node is a central buffer node for non-transient information."
  ())

;;; =========================================================
;;; ====================== DataType
;;; =========================================================
(def-meta-class |DataType| 
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "DataType")
 "A data type is a type whose instances are identified only by their value.
  A data type may contain attributes to support the modeling of structured
  data types."
  ((|ownedAttribute| :xmi-id "DataType-ownedAttribute"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |datatype|)
    :documentation
     "The Attributes owned by the DataType.")
   (|ownedOperation| :xmi-id "DataType-ownedOperation"
    :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |datatype|)
    :documentation
     "The Operations owned by the DataType.")))

(def-meta-operation "inherit" |DataType| 
   "The inherit operation is overridden to exclude redefined properties."
   :operation-body
   "result = inhs->excluding(inh | ownedMember->select(oclIsKindOf(RedefinableElement))->select(redefinedElement->includes(inh)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|NamedElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|inhs| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

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
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "DecisionNode")
 "A decision node is a control node that chooses between outgoing flows."
  ((|decisionInput| :xmi-id "DecisionNode-decisionInput"
    :range |Behavior| :multiplicity (0 1)
    :documentation
     "Provides input to guard specifications on edges outgoing from the decision
      node.")
   (|decisionInputFlow| :xmi-id "DecisionNode-decisionInputFlow"
    :range |ObjectFlow| :multiplicity (0 1)
    :documentation
     "An additional edge incoming to the decision node that provides a decision
      input value.")))

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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Dependency")
 "A dependency is a relationship that signifies that a single or a set of
  model elements requires other model elements for their specification or
  implementation. This means that the complete semantics of the depending
  elements is either semantically or structurally dependent on the definition
  of the supplier element(s)."
  ((|client| :xmi-id "Dependency-client"
    :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|NamedElement| |clientDependency|)
    :documentation
     "The element(s) dependent on the supplier element(s). In some cases (such
      as a Trace Abstraction) the assignment of direction (that is, the designation
      of the client element) is at the discretion of the modeler, and is a stipulation.")
   (|supplier| :xmi-id "Dependency-supplier"
    :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "The element(s) independent of the client element(s), in the same respect
      and the same dependency relationship. In some directed dependency relationships
      (such as Refinement Abstractions), a common convention in the domain of
      class-based OO software is to put the more abstract element in this role.
      Despite this convention, users of UML may stipulate a sense of dependency
      suitable for their domain, which makes a more abstract element dependent
      on that which is more specific.")))

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
;;; ====================== DestroyLinkAction
;;; =========================================================
(def-meta-class |DestroyLinkAction| 
   (:model :UML4SYSML12 :superclasses (|WriteLinkAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "DestroyLinkAction")
 "A destroy link action is a write link action that destroys links and link
  objects."
  ((|endData| :xmi-id "DestroyLinkAction-endData"
    :range |LinkEndDestructionData| :multiplicity (2 -1) :is-composite-p T
    :documentation
     "Specifies ends of association and inputs." :redefined-property (|LinkAction| |endData|))))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "DestroyObjectAction")
 "A destroy object action is an action that destroys objects."
  ((|isDestroyLinks| :xmi-id "DestroyObjectAction-isDestroyLinks"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether links in which the object participates are destroyed
      along with the object.")
   (|isDestroyOwnedObjects| :xmi-id "DestroyObjectAction-isDestroyOwnedObjects"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether objects owned by the object are destroyed along with
      the object.")
   (|target| :xmi-id "DestroyObjectAction-target"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The input pin providing the object to be destroyed.")))

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
;;; ====================== DestructionEvent
;;; =========================================================
(def-meta-class |DestructionEvent| 
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "DestructionEvent")
 "A destruction event models the destruction of an object."
  ())

;;; =========================================================
;;; ====================== DirectedRelationship
;;; =========================================================
(def-meta-class |DirectedRelationship| 
   (:model :UML4SYSML12 :superclasses (|Relationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "DirectedRelationship")
 "A directed relationship represents a relationship between a collection
  of source model elements and a collection of target model elements."
  ((|source| :xmi-id "DirectedRelationship-source"
    :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the sources of the DirectedRelationship.")
   (|target| :xmi-id "DirectedRelationship-target"
    :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Relationship| |relatedElement|))
    :documentation
     "Specifies the targets of the DirectedRelationship.")))

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
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "Duration")
 "Duration defines a value specification that specifies the temporal distance
  between two time instants."
  ((|expr| :xmi-id "Duration-expr"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :documentation
     "The value of the Duration.")
   (|observation| :xmi-id "Duration-observation"
    :range |Observation| :multiplicity (0 -1)
    :documentation
     "Refers to the time and duration observations that are involved in expr.")))

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
   (:model :UML4SYSML12 :superclasses (|IntervalConstraint|) 
    :packages (|UML4SysML|) 
    :xmi-id "DurationConstraint")
 "A duration constraint is a constraint that refers to a duration interval."
  ((|firstEvent| :xmi-id "DurationConstraint-firstEvent"
    :range |Boolean| :multiplicity (0 2) :default :true
    :documentation
     "The value of firstEvent[i] is related to constrainedElement[i] (where i
      is 1 or 2). If firstEvent[i] is true, then the corresponding observation
      event is the first time instant the execution enters constrainedElement[i].
      If firstEvent[i] is false, then the corresponding observation event is
      the last time instant the execution is within constrainedElement[i]. Default
      value is true applied when constrainedElement[i] refers an element that
      represents only one time instant.")
   (|specification| :xmi-id "DurationConstraint-specification"
    :range |DurationInterval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The interval constraining the duration." :redefined-property (|IntervalConstraint| |specification|))))

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
   (:model :UML4SYSML12 :superclasses (|Interval|) 
    :packages (|UML4SysML|) 
    :xmi-id "DurationInterval")
 "A duration interval defines the range between two durations."
  ((|max| :xmi-id "DurationInterval-max"
    :range |Duration| :multiplicity (1 1)
    :documentation
     "Refers to the Duration denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :xmi-id "DurationInterval-min"
    :range |Duration| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|Observation|) 
    :packages (|UML4SysML|) 
    :xmi-id "DurationObservation")
 "A duration observation is a reference to a duration during an execution.
  It points out the element(s) in the model to observe and whether the observations
  are when this model element is entered or when it is exited."
  ((|event| :xmi-id "DurationObservation-event"
    :range |NamedElement| :multiplicity (1 2)
    :documentation
     "The observation is determined by the entering or exiting of the event element
      during execution.")
   (|firstEvent| :xmi-id "DurationObservation-firstEvent"
    :range |Boolean| :multiplicity (0 2) :default :true
    :documentation
     "The value of firstEvent[i] is related to event[i] (where i is 1 or 2).
      If firstEvent[i] is true, then the corresponding observation event is the
      first time instant the execution enters event[i]. If firstEvent[i] is false,
      then the corresponding observation event is the time instant the execution
      exits event[i]. Default value is true applied when event[i] refers an element
      that represents only one time instant.")))

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
   (:model :UML4SYSML12 :superclasses NIL 
    :packages (|UML4SysML|) 
    :xmi-id "Element")
 "An element is a constituent of a model. As such, it has the capability
  of owning other elements."
  ((|ownedComment| :xmi-id "Element-ownedComment"
    :range |Comment| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The Comments owned by this element.")
   (|ownedElement| :xmi-id "Element-ownedElement"
    :range |Element| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :opposite (|Element| |owner|)
    :documentation
     "The Elements owned by this element.")
   (|owner| :xmi-id "Element-owner"
    :range |Element| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :opposite (|Element| |ownedElement|)
    :documentation
     "The Element that owns this element.")))

(def-meta-operation "allOwnedElements" |Element| 
   "The query allOwnedElements() gives all of the direct and indirect owned
    elements of an element."
   :operation-body
   "result = ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Element|
                        :parameter-return-p T))
)

(def-meta-operation "mustBeOwned" |Element| 
   "The query mustBeOwned() indicates whether elements of this type must have
    an owner. Subclasses of Element that do not require an owner must override
    this operation."
   :operation-body
   "result = true"
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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "ElementImport")
 "An element import identifies an element in another package, and allows
  the element to be referenced using its name without a qualifier."
  ((|alias| :xmi-id "ElementImport-alias"
    :range |String| :multiplicity (0 1)
    :documentation
     "Specifies the name that should be added to the namespace of the importing
      package in lieu of the name of the imported packagable element. The aliased
      name must not clash with any other member name in the importing package.
      By default, no alias is used.")
   (|importedElement| :xmi-id "ElementImport-importedElement"
    :range |PackageableElement| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the PackageableElement whose name is to be added to a Namespace.")
   (|importingNamespace| :xmi-id "ElementImport-importingNamespace"
    :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |elementImport|)
    :documentation
     "Specifies the Namespace that imports a PackageableElement from another
      Package.")
   (|visibility| :xmi-id "ElementImport-visibility"
    :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElement within the
      importing Package. The default visibility is the same as that of the imported
      element. If the imported element does not have a visibility, it is possible
      to add visibility to the element import.")))

(def-meta-operation "getName" |ElementImport| 
   "The query getName() returns the name under which the imported PackageableElement
    will be known in the importing namespace."
   :operation-body
   "result = if self.alias->notEmpty() then   self.alias else   self.importedElement.name endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-assoc "A_importedElement_elementImport"      
  :name |A_importedElement_elementImport|      
  :metatype :association      
  :member-ends ((|ElementImport| "importedElement")
                ("A_importedElement_elementImport-elementImport" "elementImport"))      
  :owned-ends  (("A_importedElement_elementImport-elementImport" "elementImport")))

(def-meta-assoc-end "A_importedElement_elementImport-elementImport" 
    :type |ElementImport| 
    :multiplicity (0 -1) 
    :association "A_importedElement_elementImport" 
    :name "elementImport")

;;; =========================================================
;;; ====================== EncapsulatedClassifier
;;; =========================================================
(def-meta-class |EncapsulatedClassifier| 
   (:model :UML4SYSML12 :superclasses (|StructuredClassifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "EncapsulatedClassifier")
 "A classifier has the ability to own ports as specific and type checked
  interaction points."
  ((|ownedPort| :xmi-id "EncapsulatedClassifier-ownedPort"
    :range |Port| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|StructuredClassifier| |ownedAttribute|))
    :documentation
     "References a set of ports that an encapsulated classifier owns.")))

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
   (:model :UML4SYSML12 :superclasses (|DataType|) 
    :packages (|UML4SysML|) 
    :xmi-id "Enumeration")
 "An enumeration is a data type whose values are enumerated in the model
  as enumeration literals."
  ((|ownedLiteral| :xmi-id "Enumeration-ownedLiteral"
    :range |EnumerationLiteral| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|EnumerationLiteral| |enumeration|)
    :documentation
     "The ordered set of literals for this Enumeration.")))

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
   (:model :UML4SYSML12 :superclasses (|InstanceSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "EnumerationLiteral")
 "An enumeration literal is a user-defined data value for an enumeration."
  ((|enumeration| :xmi-id "EnumerationLiteral-enumeration"
    :range |Enumeration| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Enumeration| |ownedLiteral|)
    :documentation
     "The Enumeration that this EnumerationLiteral is a member of.")))

;;; =========================================================
;;; ====================== Event
;;; =========================================================
(def-meta-class |Event| 
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Event")
 "An event is the specification of some occurrence that may potentially trigger
  effects by an object."
  ())

;;; =========================================================
;;; ====================== ExecutableNode
;;; =========================================================
(def-meta-class |ExecutableNode| 
   (:model :UML4SYSML12 :superclasses (|ActivityNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExecutableNode")
 "An executable node is an abstract class for activity nodes that may be
  executed. It is used as an attachment point for exception handlers."
  ())

;;; =========================================================
;;; ====================== ExecutionEvent
;;; =========================================================
(def-meta-class |ExecutionEvent| 
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExecutionEvent")
 "An ExecutionEvent models the start or finish of an execution specification."
  ())

;;; =========================================================
;;; ====================== ExecutionOccurrenceSpecification
;;; =========================================================
(def-meta-class |ExecutionOccurrenceSpecification| 
   (:model :UML4SYSML12 :superclasses (|OccurrenceSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExecutionOccurrenceSpecification")
 "An execution occurrence specification represents moments in time at which
  actions or behaviors start or finish."
  ((|event| :xmi-id "ExecutionOccurrenceSpecification-event"
    :range |ExecutionEvent| :multiplicity (1 1)
    :documentation
     "The event referenced is restricted to an execution event." :redefined-property (|OccurrenceSpecification| |event|))
   (|execution| :xmi-id "ExecutionOccurrenceSpecification-execution"
    :range |ExecutionSpecification| :multiplicity (1 1)
    :documentation
     "References the execution specification describing the execution that is
      started or finished at this execution event.")))

(def-meta-assoc "A_event_executionOccurrenceSpecification"      
  :name |A_event_executionOccurrenceSpecification|      
  :metatype :association      
  :member-ends ((|ExecutionOccurrenceSpecification| "event")
                ("A_event_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification"))      
  :owned-ends  (("A_event_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification")))

(def-meta-assoc-end "A_event_executionOccurrenceSpecification-executionOccurrenceSpecification" 
    :type |ExecutionOccurrenceSpecification| 
    :multiplicity (0 -1) 
    :association "A_event_executionOccurrenceSpecification" 
    :name "executionOccurrenceSpecification")

(def-meta-assoc "A_execution_executionOccurrenceSpecification"      
  :name |A_execution_executionOccurrenceSpecification|      
  :metatype :association      
  :member-ends ((|ExecutionOccurrenceSpecification| "execution")
                ("A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification"))      
  :owned-ends  (("A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" "executionOccurrenceSpecification")))

(def-meta-assoc-end "A_execution_executionOccurrenceSpecification-executionOccurrenceSpecification" 
    :type |ExecutionOccurrenceSpecification| 
    :multiplicity (1 1) 
    :association "A_execution_executionOccurrenceSpecification" 
    :name "executionOccurrenceSpecification")

;;; =========================================================
;;; ====================== ExecutionSpecification
;;; =========================================================
(def-meta-class |ExecutionSpecification| 
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExecutionSpecification")
 "An execution specification is a specification of the execution of a unit
  of behavior or action within the lifeline. The duration of an execution
  specification is represented by two cccurrence specifications, the start
  occurrence specification and the finish occurrence specification."
  ((|finish| :xmi-id "ExecutionSpecification-finish"
    :range |OccurrenceSpecification| :multiplicity (1 1)
    :documentation
     "References the OccurrenceSpecification that designates the finish of the
      Action or Behavior.")
   (|start| :xmi-id "ExecutionSpecification-start"
    :range |OccurrenceSpecification| :multiplicity (1 1)
    :documentation
     "References the OccurrenceSpecification that designates the start of the
      Action or Behavior")))

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
;;; ====================== Expression
;;; =========================================================
(def-meta-class |Expression| 
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "Expression")
 "An expression is a structured tree of symbols that denotes a (possibly
  empty) set of values when evaluated in a context.An expression represents
  a node in an expression tree, which may be non-terminal or terminal. It
  defines a symbol, and has a possibly empty sequence of operands which are
  value specifications."
  ((|operand| :xmi-id "Expression-operand"
    :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies a sequence of operands.")
   (|symbol| :xmi-id "Expression-symbol"
    :range |String| :multiplicity (0 1)
    :documentation
     "The symbol associated with the node in the expression tree.")))

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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship| |NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Extend")
 "A relationship from an extending use case to an extended use case that
  specifies how and when the behavior defined in the extending use case can
  be inserted into the behavior defined in the extended use case."
  ((|condition| :xmi-id "Extend-condition"
    :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "References the condition that must hold when the first extension point
      is reached for the extension to take place. If no constraint is associated
      with the extend relationship, the extension is unconditional.")
   (|extendedCase| :xmi-id "Extend-extendedCase"
    :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the use case that is being extended.")
   (|extension| :xmi-id "Extend-extension"
    :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|UseCase| |extend|)
    :documentation
     "References the use case that represents the extension and owns the extend
      relationship.")
   (|extensionLocation| :xmi-id "Extend-extensionLocation"
    :range |ExtensionPoint| :multiplicity (1 -1) :is-ordered-p T
    :documentation
     "An ordered list of extension points belonging to the extended use case,
      specifying where the respective behavioral fragments of the extending use
      case are to be inserted. The first fragment in the extending use case is
      associated with the first extension point in the list, the second fragment
      with the second point, and so on. (Note that, in most practical cases,
      the extending use case has just a single behavior fragment, so that the
      list of extension points is trivial.)")))

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
   (:model :UML4SYSML12 :superclasses (|Association|) 
    :packages (|UML4SysML|) 
    :xmi-id "Extension")
 "An extension is used to indicate that the properties of a metaclass are
  extended through a stereotype, and gives the ability to flexibly add (and
  later remove) stereotypes to classes."
  ((|isRequired| :xmi-id "Extension-isRequired"
    :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "Indicates whether an instance of the extending stereotype must be created
      when an instance of the extended class is created. The attribute value
      is derived from the value of the lower property of the ExtensionEnd referenced
      by Extension::ownedEnd; a lower value of 1 means that isRequired is true,
      but otherwise it is false. Since the default value of ExtensionEnd::lower
      is 0, the default value of isRequired is false.")
   (|metaclass| :xmi-id "Extension-metaclass"
    :range |Class| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :opposite (|Class| |extension|)
    :documentation
     "References the Class that is extended through an Extension. The property
      is derived from the type of the memberEnd that is not the ownedEnd.")
   (|ownedEnd| :xmi-id "Extension-ownedEnd"
    :range |ExtensionEnd| :multiplicity (1 1) :is-composite-p T
    :documentation
     "References the end of the extension that is typed by a Stereotype." :redefined-property (|Association| |ownedEnd|))))

(def-meta-operation "isRequired.1" |Extension| 
   "The query isRequired() is true if the owned end has a multiplicity with
    the lower bound of 1."
   :operation-body
   "result = (ownedEnd->lowerBound() = 1)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "metaclass.1" |Extension| 
   "The query metaclass() returns the metaclass that is being extended (as
    opposed to the extending stereotype)."
   :operation-body
   "result = metaclassEnd().type"
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
   (:model :UML4SYSML12 :superclasses (|Property|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExtensionEnd")
 "An extension end is used to tie an extension to a stereotype when extending
  a metaclass.The default multiplicity of an extension end is 0..1."
  ((|lower| :xmi-id "ExtensionEnd-lower"
    :range |Integer| :multiplicity (0 1) :is-derived-p T :default 0
    :documentation
     "This redefinition changes the default multiplicity of association ends,
      since model elements are usually extended by 0 or 1 instance of the extension
      stereotype." :redefined-property (|MultiplicityElement| |lower|))
   (|type| :xmi-id "ExtensionEnd-type"
    :range |Stereotype| :multiplicity (1 1)
    :documentation
     "References the type of the ExtensionEnd. Note that this association restricts
      the possible types of an ExtensionEnd to only be Stereotypes." :redefined-property (|TypedElement| |type|))))

(def-meta-operation "lowerBound" |ExtensionEnd| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    Integer. This is a redefinition of the default  lower bound, which normally,
    for MultiplicityElements, evaluates to 1 if empty."
   :operation-body
   "result = lowerBound = if lowerValue->isEmpty() then 0 else lowerValue->IntegerValue() endif"
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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ExtensionPoint")
 "An extension point identifies a point in the behavior of a use case where
  that behavior can be extended by the behavior of some other (extending)
  use case, as specified by an extend relationship."
  ((|useCase| :xmi-id "ExtensionPoint-useCase"
    :range |UseCase| :multiplicity (1 1)
    :opposite (|UseCase| |extensionPoint|)
    :documentation
     "References the use case that owns this extension point.")))

;;; =========================================================
;;; ====================== Feature
;;; =========================================================
(def-meta-class |Feature| 
   (:model :UML4SYSML12 :superclasses (|RedefinableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Feature")
 "A feature declares a behavioral or structural characteristic of instances
  of classifiers."
  ((|featuringClassifier| :xmi-id "Feature-featuringClassifier"
    :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "The Classifiers that have this Feature as a feature.")
   (|isStatic| :xmi-id "Feature-isStatic"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether this feature characterizes individual instances classified
      by the classifier (false) or the classifier itself (true).")))

(def-meta-assoc "A_feature_featuringClassifier"      
  :name |A_feature_featuringClassifier|      
  :metatype :association      
  :member-ends ((|Feature| "featuringClassifier"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== FinalNode
;;; =========================================================
(def-meta-class |FinalNode| 
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "FinalNode")
 "A final node is an abstract control node at which a flow in an activity
  stops."
  ())

;;; =========================================================
;;; ====================== FinalState
;;; =========================================================
(def-meta-class |FinalState| 
   (:model :UML4SYSML12 :superclasses (|State|) 
    :packages (|UML4SysML|) 
    :xmi-id "FinalState")
 "A special kind of state signifying that the enclosing region is completed.
  If the enclosing region is directly contained in a state machine and all
  other regions in the state machine also are completed, then it means that
  the entire state machine is completed."
  ())

;;; =========================================================
;;; ====================== FlowFinalNode
;;; =========================================================
(def-meta-class |FlowFinalNode| 
   (:model :UML4SYSML12 :superclasses (|FinalNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "FlowFinalNode")
 "A flow final node is a final node that terminates a flow."
  ())

;;; =========================================================
;;; ====================== ForkNode
;;; =========================================================
(def-meta-class |ForkNode| 
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "ForkNode")
 "A fork node is a control node that splits a flow into multiple concurrent
  flows."
  ())

;;; =========================================================
;;; ====================== FunctionBehavior
;;; =========================================================
(def-meta-class |FunctionBehavior| 
   (:model :UML4SYSML12 :superclasses (|OpaqueBehavior|) 
    :packages (|UML4SysML|) 
    :xmi-id "FunctionBehavior")
 "A function behavior is an opaque behavior that does not access or modify
  any objects or other external data."
  ())

;;; =========================================================
;;; ====================== Gate
;;; =========================================================
(def-meta-class |Gate| 
   (:model :UML4SYSML12 :superclasses (|MessageEnd|) 
    :packages (|UML4SysML|) 
    :xmi-id "Gate")
 "A gate is a connection point for relating a message outside an interaction
  fragment with a message inside the interaction fragment."
  ())

;;; =========================================================
;;; ====================== GeneralOrdering
;;; =========================================================
(def-meta-class |GeneralOrdering| 
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "GeneralOrdering")
 "A general ordering represents a binary relation between two occurrence
  specifications, to describe that one occurrence specification must occur
  before the other in a valid trace. This mechanism provides the ability
  to define partial orders of occurrence cpecifications that may otherwise
  not have a specified order."
  ((|after| :xmi-id "GeneralOrdering-after"
    :range |OccurrenceSpecification| :multiplicity (1 1)
    :opposite (|OccurrenceSpecification| |toBefore|)
    :documentation
     "The OccurrenceSpecification referenced comes after the OccurrenceSpecification
      referenced by before.")
   (|before| :xmi-id "GeneralOrdering-before"
    :range |OccurrenceSpecification| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "Generalization")
 "A generalization is a taxonomic relationship between a more general classifier
  and a more specific classifier. Each instance of the specific classifier
  is also an indirect instance of the general classifier. Thus, the specific
  classifier inherits the features of the more general classifier.A generalization
  relates a specific classifier to a more general classifier, and is owned
  by the specific classifier."
  ((|general| :xmi-id "Generalization-general"
    :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the general classifier in the Generalization relationship.")
   (|generalizationSet| :xmi-id "Generalization-generalizationSet"
    :range |GeneralizationSet| :multiplicity (0 -1)
    :opposite (|GeneralizationSet| |generalization|)
    :documentation
     "Designates a set in which instances of Generalization is considered members.")
   (|isSubstitutable| :xmi-id "Generalization-isSubstitutable"
    :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "Indicates whether the specific classifier can be used wherever the general
      classifier can be used. If true, the execution traces of the specific classifier
      will be a superset of the execution traces of the general classifier.")
   (|specific| :xmi-id "Generalization-specific"
    :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Classifier| |generalization|)
    :documentation
     "References the specializing classifier in the Generalization relationship.")))

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
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "GeneralizationSet")
 "A generalization set is a packageable element whose instances define collections
  of subsets of generalization relationships."
  ((|generalization| :xmi-id "GeneralizationSet-generalization"
    :range |Generalization| :multiplicity (0 -1)
    :opposite (|Generalization| |generalizationSet|)
    :documentation
     "Designates the instances of Generalization which are members of a given
      GeneralizationSet.")
   (|isCovering| :xmi-id "GeneralizationSet-isCovering"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates (via the associated Generalizations) whether or not the set of
      specific Classifiers are covering for a particular general classifier.
      When isCovering is true, every instance of a particular general Classifier
      is also an instance of at least one of its specific Classifiers for the
      GeneralizationSet. When isCovering is false, there are one or more instances
      of the particular general Classifier that are not instances of at least
      one of its specific Classifiers defined for the GeneralizationSet.")
   (|isDisjoint| :xmi-id "GeneralizationSet-isDisjoint"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether or not the set of specific Classifiers in a Generalization
      relationship have instance in common. If isDisjoint is true, the specific
      Classifiers for a particular GeneralizationSet have no members in common;
      that is, their intersection is empty. If isDisjoint is false, the specific
      Classifiers in a particular GeneralizationSet have one or more members
      in common; that is, their intersection is not empty. For example, Person
      could have two Generalization relationships, each with the different specific
      Classifier: Manager or Staff. This would be disjoint because every instance
      of Person must either be a Manager or Staff. In contrast, Person could
      have two Generalization relationships involving two specific (and non-covering)
      Classifiers: Sales Person and Manager. This GeneralizationSet would not
      be disjoint because there are instances of Person which can be a Sales
      Person and a Manager.")
   (|powertype| :xmi-id "GeneralizationSet-powertype"
    :range |Classifier| :multiplicity (0 1)
    :opposite (|Classifier| |powertypeExtent|)
    :documentation
     "Designates the Classifier that is defined as the power type for the associated
      GeneralizationSet.")))

;;; =========================================================
;;; ====================== Image
;;; =========================================================
(def-meta-class |Image| 
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "Image")
 "Physical definition of a graphical image."
  ((|content| :xmi-id "Image-content"
    :range |String| :multiplicity (0 1)
    :documentation
     "This contains the serialization of the image according to the format. The
      value could represent a bitmap, image such as a GIF file, or drawing 'instructions'
      using a standard such as Scalable Vector Graphic (SVG) (which is XML based).")
   (|format| :xmi-id "Image-format"
    :range |String| :multiplicity (0 1)
    :documentation
     "This indicates the format of the content - which is how the string content
      should be interpreted. The following values are reserved: SVG, GIF, PNG,
      JPG, WMF, EMF, BMP.    In addition the prefix 'MIME: ' is also reserved.
      This option can be used as an alternative to express the reserved values
      above, for example \"SVG\" could instead be expressed as \"MIME: image/svg+xml\".")
   (|location| :xmi-id "Image-location"
    :range |String| :multiplicity (0 1)
    :documentation
     "This contains a location that can be used by a tool to locate the image
      as an alternative to embedding it in the stereotype.")))

;;; =========================================================
;;; ====================== Include
;;; =========================================================
(def-meta-class |Include| 
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship| |NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Include")
 "An include relationship defines that a use case contains the behavior defined
  in another use case."
  ((|addition| :xmi-id "Include-addition"
    :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the use case that is to be included.")
   (|includingCase| :xmi-id "Include-includingCase"
    :range |UseCase| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :opposite (|UseCase| |include|)
    :documentation
     "References the use case which will include the addition and owns the include
      relationship.")))

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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship| |PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "InformationFlow")
 "An information flow specifies that one or more information items circulates
  from its sources to its targets. Information flows require some kind of
  information channel for transmitting information items from the source
  to the destination. An information channel is represented in various ways
  depending on the nature of its sources and targets. It may be represented
  by connectors, links, associations, or even dependencies. For example,
  if the source and destination are parts in some composite structure such
  as a collaboration, then the information channel is likely to be represented
  by a connector between them. Or, if the source and target are objects (which
  are a kind of instance specification), they may be represented by a link
  that joins the two, and so on."
  ((|conveyed| :xmi-id "InformationFlow-conveyed"
    :range |Classifier| :multiplicity (1 -1)
    :documentation
     "Specifies the information items that may circulate on this information
      flow.")
   (|informationSource| :xmi-id "InformationFlow-informationSource"
    :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |source|))
    :documentation
     "Defines from which source the conveyed InformationItems are initiated.")
   (|informationTarget| :xmi-id "InformationFlow-informationTarget"
    :range |NamedElement| :multiplicity (1 -1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Defines to which target the conveyed InformationItems are directed.")
   (|realization| :xmi-id "InformationFlow-realization"
    :range |Relationship| :multiplicity (0 -1)
    :documentation
     "Determines which Relationship will realize the specified flow")
   (|realizingActivityEdge| :xmi-id "InformationFlow-realizingActivityEdge"
    :range |ActivityEdge| :multiplicity (0 -1)
    :documentation
     "Determines which ActivityEdges will realize the specified flow.")
   (|realizingConnector| :xmi-id "InformationFlow-realizingConnector"
    :range |Connector| :multiplicity (0 -1)
    :documentation
     "Determines which Connectors will realize the specified flow.")
   (|realizingMessage| :xmi-id "InformationFlow-realizingMessage"
    :range |Message| :multiplicity (0 -1)
    :documentation
     "Determines which Messages will realize the specified flow.")))

(def-meta-assoc "A_conveyed_informationFlow"      
  :name |A_conveyed_informationFlow|      
  :metatype :association      
  :member-ends ((|InformationFlow| "conveyed")
                ("A_conveyed_informationFlow-informationFlow" "informationFlow"))      
  :owned-ends  (("A_conveyed_informationFlow-informationFlow" "informationFlow")))

(def-meta-assoc-end "A_conveyed_informationFlow-informationFlow" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_conveyed_informationFlow" 
    :name "informationFlow")

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

(def-meta-assoc "A_realization_abstraction"      
  :name |A_realization_abstraction|      
  :metatype :association      
  :member-ends ((|InformationFlow| "realization")
                ("A_realization_abstraction-abstraction" "abstraction"))      
  :owned-ends  (("A_realization_abstraction-abstraction" "abstraction")))

(def-meta-assoc-end "A_realization_abstraction-abstraction" 
    :type |InformationFlow| 
    :multiplicity (0 -1) 
    :association "A_realization_abstraction" 
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
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "InformationItem")
 "An information item is an abstraction of all kinds of information that
  can be exchanged between objects. It is a kind of classifier intended for
  representing information in a very abstract way, one which cannot be instantiated."
  ((|represented| :xmi-id "InformationItem-represented"
    :range |Classifier| :multiplicity (0 -1)
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
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "InitialNode")
 "An initial node is a control node at which flow starts when the activity
  is invoked."
  ())

;;; =========================================================
;;; ====================== InputPin
;;; =========================================================
(def-meta-class |InputPin| 
   (:model :UML4SYSML12 :superclasses (|Pin|) 
    :packages (|UML4SysML|) 
    :xmi-id "InputPin")
 "An input pin is a pin that holds input values to be consumed by an action."
  ())

;;; =========================================================
;;; ====================== InstanceSpecification
;;; =========================================================
(def-meta-class |InstanceSpecification| 
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "InstanceSpecification")
 "An instance specification is a model element that represents an instance
  in a modeled system."
  ((|classifier| :xmi-id "InstanceSpecification-classifier"
    :range |Classifier| :multiplicity (0 -1)
    :documentation
     "The classifier or classifiers of the represented instance. If multiple
      classifiers are specified, the instance is classified by all of them.")
   (|slot| :xmi-id "InstanceSpecification-slot"
    :range |Slot| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Slot| |owningInstance|)
    :documentation
     "A slot giving the value or values of a structural feature of the instance.
      An instance specification can have one slot per structural feature of its
      classifiers, including inherited features. It is not necessary to model
      a slot for each structural feature, in which case the instance specification
      is a partial description.")
   (|specification| :xmi-id "InstanceSpecification-specification"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "InstanceValue")
 "An instance value is a value specification that identifies an instance."
  ((|instance| :xmi-id "InstanceValue-instance"
    :range |InstanceSpecification| :multiplicity (1 1)
    :documentation
     "The instance that is the specified value.")))

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
   (:model :UML4SYSML12 :superclasses (|InteractionFragment| |Behavior|) 
    :packages (|UML4SysML|) 
    :xmi-id "Interaction")
 "An interaction is a unit of behavior that focuses on the observable exchange
  of information between connectable elements."
  ((|action| :xmi-id "Interaction-action"
    :range |Action| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Actions owned by the Interaction.")
   (|formalGate| :xmi-id "Interaction-formalGate"
    :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the gates that form the message interface between this Interaction
      and any InteractionUses which reference it.")
   (|fragment| :xmi-id "Interaction-fragment"
    :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingInteraction|)
    :documentation
     "The ordered set of fragments in the Interaction.")
   (|lifeline| :xmi-id "Interaction-lifeline"
    :range |Lifeline| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Lifeline| |interaction|)
    :documentation
     "Specifies the participants in this Interaction.")
   (|message| :xmi-id "Interaction-message"
    :range |Message| :multiplicity (0 -1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|Constraint|) 
    :packages (|UML4SysML|) 
    :xmi-id "InteractionConstraint")
 "An interaction constraint is a Boolean expression that guards an operand
  in a combined fragment."
  ((|maxint| :xmi-id "InteractionConstraint-maxint"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The maximum number of iterations of a loop")
   (|minint| :xmi-id "InteractionConstraint-minint"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "InteractionFragment")
 "InteractionFragment is an abstract notion of the most general interaction
  unit. An interaction fragment is a piece of an interaction. Each interaction
  fragment is conceptually like an interaction by itself."
  ((|covered| :xmi-id "InteractionFragment-covered"
    :range |Lifeline| :multiplicity (0 -1)
    :opposite (|Lifeline| |coveredBy|)
    :documentation
     "References the Lifelines that the InteractionFragment involves.")
   (|enclosingInteraction| :xmi-id "InteractionFragment-enclosingInteraction"
    :range |Interaction| :multiplicity (0 1)
    :opposite (|Interaction| |fragment|)
    :documentation
     "The Interaction enclosing this InteractionFragment.")
   (|enclosingOperand| :xmi-id "InteractionFragment-enclosingOperand"
    :range |InteractionOperand| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|InteractionOperand| |fragment|)
    :documentation
     "The operand enclosing this InteractionFragment (they may nest recursively)")
   (|generalOrdering| :xmi-id "InteractionFragment-generalOrdering"
    :range |GeneralOrdering| :multiplicity (0 -1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|InteractionFragment| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "InteractionOperand")
 "An interaction operand is contained in a combined fragment. An interaction
  operand represents one operand of the expression given by the enclosing
  combined fragment."
  ((|fragment| :xmi-id "InteractionOperand-fragment"
    :range |InteractionFragment| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|InteractionFragment| |enclosingOperand|)
    :documentation
     "The fragments of the operand.")
   (|guard| :xmi-id "InteractionOperand-guard"
    :range |InteractionConstraint| :multiplicity (0 1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "InteractionUse")
 "An interaction use refers to an interaction. The interaction use is a shorthand
  for copying the contents of the referenced interaction where the interaction
  use is. To be accurate the copying must take into account substituting
  parameters with arguments and connect the formal gates with the actual
  ones."
  ((|actualGate| :xmi-id "InteractionUse-actualGate"
    :range |Gate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The actual gates of the InteractionUse")
   (|argument| :xmi-id "InteractionUse-argument"
    :range |Action| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "The actual arguments of the Interaction")
   (|refersTo| :xmi-id "InteractionUse-refersTo"
    :range |Interaction| :multiplicity (1 1)
    :documentation
     "Refers to the Interaction that defines its meaning")))

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

;;; =========================================================
;;; ====================== Interface
;;; =========================================================
(def-meta-class |Interface| 
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "Interface")
 "An interface is a kind of classifier that represents a declaration of a
  set of coherent public features and obligations. An interface specifies
  a contract; any instance of a classifier that realizes the interface must
  fulfill that contract. The obligations that may be associated with an interface
  are in the form of various kinds of constraints (such as pre- and post-conditions)
  or protocol specifications, which may impose ordering restrictions on interactions
  through the interface.Interfaces may include receptions (in addition to
  operations)."
  ((|nestedClassifier| :xmi-id "Interface-nestedClassifier"
    :range |Classifier| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "References all the Classifiers that are defined (nested) within the Class.")
   (|ownedAttribute| :xmi-id "Interface-ownedAttribute"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :opposite (|Property| |interface|)
    :documentation
     "The attributes (i.e. the properties) owned by the class.")
   (|ownedOperation| :xmi-id "Interface-ownedOperation"
    :range |Operation| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :opposite (|Operation| |interface|)
    :documentation
     "The operations owned by the class.")
   (|ownedReception| :xmi-id "Interface-ownedReception"
    :range |Reception| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "Receptions that objects providing this interface are willing to accept.")
   (|redefinedInterface| :xmi-id "Interface-redefinedInterface"
    :range |Interface| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
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
   (:model :UML4SYSML12 :superclasses (|Realization|) 
    :packages (|UML4SysML|) 
    :xmi-id "InterfaceRealization")
 "An interface realization is a specialized realization relationship between
  a classifier and an interface. This relationship signifies that the realizing
  classifier conforms to the contract specified by the interface."
  ((|contract| :xmi-id "InterfaceRealization-contract"
    :range |Interface| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "References the Interface specifying the conformance contract.")
   (|implementingClassifier| :xmi-id "InterfaceRealization-implementingClassifier"
    :range |BehavioredClassifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|))
    :opposite (|BehavioredClassifier| |interfaceRealization|)
    :documentation
     "References the BehavioredClassifier that owns this Interfacerealization
      (i.e., the classifier that realizes the Interface to which it points).")))

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
   (:model :UML4SYSML12 :superclasses (|ActivityGroup|) 
    :packages (|UML4SysML|) 
    :xmi-id "InterruptibleActivityRegion")
 "An interruptible activity region is an activity group that supports termination
  of tokens flowing in the portions of an activity."
  ((|interruptingEdge| :xmi-id "InterruptibleActivityRegion-interruptingEdge"
    :range |ActivityEdge| :multiplicity (0 -1)
    :opposite (|ActivityEdge| |interrupts|)
    :documentation
     "The edges leaving the region that will abort other tokens flowing in the
      region.")
   (|node| :xmi-id "InterruptibleActivityRegion-node"
    :range |ActivityNode| :multiplicity (0 -1)
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inInterruptibleRegion|)
    :documentation
     "Nodes immediately contained in the group.")))

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
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "Interval")
 "An interval defines the range between two value specifications."
  ((|max| :xmi-id "Interval-max"
    :range |ValueSpecification| :multiplicity (1 1)
    :documentation
     "Refers to the ValueSpecification denoting the maximum value of the range.")
   (|min| :xmi-id "Interval-min"
    :range |ValueSpecification| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|Constraint|) 
    :packages (|UML4SysML|) 
    :xmi-id "IntervalConstraint")
 "An interval constraint is a constraint that refers to an interval."
  ((|specification| :xmi-id "IntervalConstraint-specification"
    :range |Interval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied." :redefined-property (|Constraint| |specification|))))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "InvocationAction")
 "InvocationAction is an abstract class for the various actions that invoke
  behavior.In addition to targeting an object, invocation actions can also
  invoke behavioral features on ports from where the invocation requests
  are routed onwards on links deriving from attached connectors. Invocation
  actions may also be sent to a target via a given port, either on the sending
  object or on another object."
  ((|argument| :xmi-id "InvocationAction-argument"
    :range |InputPin| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Specification of the ordered set of argument values that appears during
      execution.")
   (|onPort| :xmi-id "InvocationAction-onPort"
    :range |Port| :multiplicity (0 1)
    :documentation
     "A optional port of the receiver object on which the behavioral feature
      is invoked.")))

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
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "JoinNode")
 "A join node is a control node that synchronizes multiple flows.Join nodes
  have a Boolean value specification using the names of the incoming edges
  to specify the conditions under which the join will emit a token."
  ((|isCombineDuplicate| :xmi-id "JoinNode-isCombineDuplicate"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "Tells whether tokens having objects with the same identity are combined
      into one by the join.")
   (|joinSpec| :xmi-id "JoinNode-joinSpec"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A specification giving the conditions under which the join with emit a
      token. Default is \"and\".")))

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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Lifeline")
 "A lifeline represents an individual participant in the interaction. While
  parts and structural features may have multiplicity greater than 1, lifelines
  represent only one interacting entity."
  ((|coveredBy| :xmi-id "Lifeline-coveredBy"
    :range |InteractionFragment| :multiplicity (0 -1)
    :opposite (|InteractionFragment| |covered|)
    :documentation
     "References the InteractionFragments in which this Lifeline takes part.")
   (|decomposedAs| :xmi-id "Lifeline-decomposedAs"
    :range |PartDecomposition| :multiplicity (0 1)
    :documentation
     "References the Interaction that represents the decomposition.")
   (|interaction| :xmi-id "Lifeline-interaction"
    :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |lifeline|)
    :documentation
     "References the Interaction enclosing this Lifeline.")
   (|represents| :xmi-id "Lifeline-represents"
    :range |ConnectableElement| :multiplicity (0 1)
    :documentation
     "References the ConnectableElement within the classifier that contains the
      enclosing interaction.")
   (|selector| :xmi-id "Lifeline-selector"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "LinkAction")
 "LinkAction is an abstract class for all link actions that identify their
  links by the objects at the ends of the links and by the qualifiers at
  ends of the links."
  ((|endData| :xmi-id "LinkAction-endData"
    :range |LinkEndData| :multiplicity (2 -1) :is-composite-p T
    :documentation
     "Data identifying one end of a link by the objects on its ends and qualifiers.")
   (|inputValue| :xmi-id "LinkAction-inputValue"
    :range |InputPin| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Pins taking end objects and qualifier values as input.")))

(def-meta-operation "association" |LinkAction| 
   "The association operates on LinkAction. It returns the association of the
    action."
   :operation-body
   "result = self.endData->asSequence().first().end.association"
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
   (:model :UML4SYSML12 :superclasses (|LinkEndData|) 
    :packages (|UML4SysML|) 
    :xmi-id "LinkEndCreationData")
 "A link end creation data is not an action. It is an element that identifies
  links. It identifies one end of a link to be created by a create link action."
  ((|insertAt| :xmi-id "LinkEndCreationData-insertAt"
    :range |InputPin| :multiplicity (0 1)
    :documentation
     "Specifies where the new link should be inserted for ordered association
      ends, or where an existing link should be moved to. The type of the input
      is UnlimitedNatural, but the input cannot be zero. This pin is omitted
      for association ends that are not ordered.")
   (|isReplaceAll| :xmi-id "LinkEndCreationData-isReplaceAll"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the existing links emanating from the object on this
      end should be destroyed before creating a new link.")))

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
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "LinkEndData")
 "A link end data is not an action. It is an element that identifies links.
  It identifies one end of a link to be read or written by the children of
  a link action. A link cannot be passed as a runtime value to or from an
  action. Instead, a link is identified by its end objects and qualifier
  values, if any. This requires more than one piece of data, namely, the
  statically-specified end in the user model, the object on the end, and
  the qualifier values for that end, if any. These pieces are brought together
  around a link end data. Each association end is identified separately with
  an instance of the LinkEndData class."
  ((|end| :xmi-id "LinkEndData-end"
    :range |Property| :multiplicity (1 1)
    :documentation
     "Association end for which this link-end data specifies values.")
   (|qualifier| :xmi-id "LinkEndData-qualifier"
    :range |QualifierValue| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "List of qualifier values")
   (|value| :xmi-id "LinkEndData-value"
    :range |InputPin| :multiplicity (0 1)
    :documentation
     "Input pin that provides the specified object for the given end. This pin
      is omitted if the link-end data specifies an 'open' end for reading.")))

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
   (:model :UML4SYSML12 :superclasses (|LinkEndData|) 
    :packages (|UML4SysML|) 
    :xmi-id "LinkEndDestructionData")
 "A link end destruction data is not an action. It is an element that identifies
  links. It identifies one end of a link to be destroyed by destroy link
  action."
  ((|destroyAt| :xmi-id "LinkEndDestructionData-destroyAt"
    :range |InputPin| :multiplicity (0 1)
    :documentation
     "Specifies the position of an existing link to be destroyed in ordered nonunique
      association ends. The type of the pin is UnlimitedNatural, but the value
      cannot be zero or unlimited.")
   (|isDestroyDuplicates| :xmi-id "LinkEndDestructionData-isDestroyDuplicates"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to destroy duplicates of the value in nonunique association
      ends.")))

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
   (:model :UML4SYSML12 :superclasses (|LiteralSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralBoolean")
 "A literal Boolean is a specification of a Boolean value."
  ((|value| :xmi-id "LiteralBoolean-value"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "The specified Boolean value.")))

(def-meta-operation "booleanValue" |LiteralBoolean| 
   "The query booleanValue() gives the value."
   :operation-body
   "result = value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralBoolean| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralInteger
;;; =========================================================
(def-meta-class |LiteralInteger| 
   (:model :UML4SYSML12 :superclasses (|LiteralSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralInteger")
 "A literal integer is a specification of an integer value."
  ((|value| :xmi-id "LiteralInteger-value"
    :range |Integer| :multiplicity (1 1) :default 0
    :documentation
     "The specified Integer value.")))

(def-meta-operation "integerValue" |LiteralInteger| 
   "The query integerValue() gives the value."
   :operation-body
   "result = value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |LiteralInteger| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralNull
;;; =========================================================
(def-meta-class |LiteralNull| 
   (:model :UML4SYSML12 :superclasses (|LiteralSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralNull")
 "A literal null specifies the lack of a value."
  ())

(def-meta-operation "isComputable" |LiteralNull| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |LiteralNull| 
   "The query isNull() returns true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralSpecification
;;; =========================================================
(def-meta-class |LiteralSpecification| 
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralSpecification")
 "A literal specification identifies a literal constant being modeled."
  ())

;;; =========================================================
;;; ====================== LiteralString
;;; =========================================================
(def-meta-class |LiteralString| 
   (:model :UML4SYSML12 :superclasses (|LiteralSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralString")
 "A literal string is a specification of a string value."
  ((|value| :xmi-id "LiteralString-value"
    :range |String| :multiplicity (0 1)
    :documentation
     "The specified String value.")))

(def-meta-operation "isComputable" |LiteralString| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |LiteralString| 
   "The query stringValue() gives the value."
   :operation-body
   "result = value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LiteralUnlimitedNatural
;;; =========================================================
(def-meta-class |LiteralUnlimitedNatural| 
   (:model :UML4SYSML12 :superclasses (|LiteralSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "LiteralUnlimitedNatural")
 "A literal unlimited natural is a specification of an unlimited natural
  number."
  ((|value| :xmi-id "LiteralUnlimitedNatural-value"
    :range |UnlimitedNatural| :multiplicity (1 1) :default 0
    :documentation
     "The specified UnlimitedNatural value.")))

(def-meta-operation "isComputable" |LiteralUnlimitedNatural| 
   "The query isComputable() is redefined to be true."
   :operation-body
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |LiteralUnlimitedNatural| 
   "The query unlimitedValue() gives the value."
   :operation-body
   "result = value"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== LoopNode
;;; =========================================================
(def-meta-class |LoopNode| 
   (:model :UML4SYSML12 :superclasses (|StructuredActivityNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "LoopNode")
 "A loop node is a structured activity node that represents a loop with setup,
  test, and body sections."
  ((|bodyPart| :xmi-id "LoopNode-bodyPart"
    :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "The set of nodes and edges that perform the repetitive computations of
      the loop. The body section is executed as long as the test section produces
      a true value.")
   (|decider| :xmi-id "LoopNode-decider"
    :range |OutputPin| :multiplicity (1 1)
    :documentation
     "An output pin within the test fragment the value of which is examined after
      execution of the test to determine whether to execute the loop body.")
   (|isTestedFirst| :xmi-id "LoopNode-isTestedFirst"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If true, the test is performed before the first execution of the body.
      If false, the body is executed once before the test is performed.")
   (|setupPart| :xmi-id "LoopNode-setupPart"
    :range |ExecutableNode| :multiplicity (0 -1)
    :documentation
     "The set of nodes and edges that initialize values or perform other setup
      computations for the loop.")
   (|test| :xmi-id "LoopNode-test"
    :range |ExecutableNode| :multiplicity (1 -1)
    :documentation
     "The set of nodes, edges, and designated value that compute a Boolean value
      to determine if another execution of the body will be performed.")))

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
;;; ====================== MergeNode
;;; =========================================================
(def-meta-class |MergeNode| 
   (:model :UML4SYSML12 :superclasses (|ControlNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "MergeNode")
 "A merge node is a control node that brings together multiple alternate
  flows. It is not used to synchronize concurrent flows but to accept one
  among several alternate flows."
  ())

;;; =========================================================
;;; ====================== Message
;;; =========================================================
(def-meta-class |Message| 
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Message")
 "A message defines a particular communication between lifelines of an interaction."
  ((|argument| :xmi-id "Message-argument"
    :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The arguments of the Message")
   (|connector| :xmi-id "Message-connector"
    :range |Connector| :multiplicity (0 1)
    :documentation
     "The Connector on which this Message is sent.")
   (|interaction| :xmi-id "Message-interaction"
    :range |Interaction| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Interaction| |message|)
    :documentation
     "The enclosing Interaction owning the Message")
   (|messageKind| :xmi-id "Message-messageKind"
    :range |MessageKind| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :unknown
    :documentation
     "The derived kind of the Message (complete, lost, found or unknown)")
   (|messageSort| :xmi-id "Message-messageSort"
    :range |MessageSort| :multiplicity (1 1) :default :synchcall
    :documentation
     "The sort of communication reflected by the Message")
   (|receiveEvent| :xmi-id "Message-receiveEvent"
    :range |MessageEnd| :multiplicity (0 1)
    :documentation
     "References the Receiving of the Message")
   (|sendEvent| :xmi-id "Message-sendEvent"
    :range |MessageEnd| :multiplicity (0 1)
    :documentation
     "References the Sending of the Message.")
   (|signature| :xmi-id "Message-signature"
    :range |NamedElement| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "The definition of the type or signature of the Message (depending on its
      kind). The associated named element is derived from the message end that
      constitutes the sending or receiving message event. If both a sending event
      and a receiving message event are present, the signature is obtained from
      the sending event.")))

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

(def-meta-assoc "A_receiveEvent_message"      
  :name |A_receiveEvent_message|      
  :metatype :association      
  :member-ends ((|Message| "receiveEvent")
                ("A_receiveEvent_message-message" "message"))      
  :owned-ends  (("A_receiveEvent_message-message" "message")))

(def-meta-assoc-end "A_receiveEvent_message-message" 
    :type |Message| 
    :multiplicity (0 1) 
    :association "A_receiveEvent_message" 
    :name "message")

(def-meta-assoc "A_sendEvent_message"      
  :name |A_sendEvent_message|      
  :metatype :association      
  :member-ends ((|Message| "sendEvent")
                ("A_sendEvent_message-message" "message"))      
  :owned-ends  (("A_sendEvent_message-message" "message")))

(def-meta-assoc-end "A_sendEvent_message-message" 
    :type |Message| 
    :multiplicity (0 1) 
    :association "A_sendEvent_message" 
    :name "message")

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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "MessageEnd")
 "MessageEnd is an abstract specialization of NamedElement that represents
  what can occur at the end of a message."
  ((|message| :xmi-id "MessageEnd-message"
    :range |Message| :multiplicity (0 1)
    :documentation
     "References a Message.")))

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
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "MessageEvent")
 "A message event specifies the receipt by an object of either a call or
  a signal."
  ())

;;; =========================================================
;;; ====================== MessageOccurrenceSpecification
;;; =========================================================
(def-meta-class |MessageOccurrenceSpecification| 
   (:model :UML4SYSML12 :superclasses (|MessageEnd| |OccurrenceSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "MessageOccurrenceSpecification")
 "A message occurrence specification pecifies the occurrence of message events,
  such as sending and receiving of signals or invoking or receiving of operation
  calls. A message occurrence specification is a kind of message end. Messages
  are generated either by synchronous operation calls or asynchronous signal
  sends. They are received by the execution of corresponding accept event
  actions."
  ())

;;; =========================================================
;;; ====================== Model
;;; =========================================================
(def-meta-class |Model| 
   (:model :UML4SYSML12 :superclasses (|Package|) 
    :packages (|UML4SysML|) 
    :xmi-id "Model")
 "A model captures a view of a physical system. It is an abstraction of the
  physical system, with a certain purpose. This purpose determines what is
  to be included in the model and what is irrelevant. Thus the model completely
  describes those aspects of the physical system that are relevant to the
  purpose of the model, at the appropriate level of detail."
  ((|viewpoint| :xmi-id "Model-viewpoint"
    :range |String| :multiplicity (0 1)
    :documentation
     "The name of the viewpoint that is expressed by a model (This name may refer
      to a profile definition).")))

;;; =========================================================
;;; ====================== MultiplicityElement
;;; =========================================================
(def-meta-class |MultiplicityElement| 
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "MultiplicityElement")
 "A multiplicity is a definition of an inclusive interval of non-negative
  integers beginning with a lower bound and ending with a (possibly infinite)
  upper bound. A multiplicity element embeds this information to specify
  the allowable cardinalities for an instantiation of this element."
  ((|isOrdered| :xmi-id "MultiplicityElement-isOrdered"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "For a multivalued multiplicity, this attribute specifies whether the values
      in an instantiation of this element are sequentially ordered.")
   (|isUnique| :xmi-id "MultiplicityElement-isUnique"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "For a multivalued multiplicity, this attributes specifies whether the values
      in an instantiation of this element are unique.")
   (|lower| :xmi-id "MultiplicityElement-lower"
    :range |Integer| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "Specifies the lower bound of the multiplicity interval.")
   (|lowerValue| :xmi-id "MultiplicityElement-lowerValue"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The specification of the lower bound for this multiplicity.")
   (|upper| :xmi-id "MultiplicityElement-upper"
    :range |UnlimitedNatural| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "Specifies the upper bound of the multiplicity interval.")
   (|upperValue| :xmi-id "MultiplicityElement-upperValue"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The specification of the upper bound for this multiplicity.")))

(def-meta-operation "compatibleWith" |MultiplicityElement| 
   "The operation compatibleWith takes another multiplicity as input. It checks
    if one multiplicity is compatible with another."
   :operation-body
   "result = Integer.allInstances()->forAll(i : Integer | self.includesCardinality(i) implies other.includesCardinality(i))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|other| :parameter-type '|MultiplicityElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "includesCardinality" |MultiplicityElement| 
   "The query includesCardinality() checks whether the specified cardinality
    is valid for this multiplicity."
   :operation-body
   "result = (lowerBound() <= C) and (upperBound() >= C)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name 'C :parameter-type '|Integer|
                        :parameter-return-p NIL))
)

(def-meta-operation "includesMultiplicity" |MultiplicityElement| 
   "The query includesMultiplicity() checks whether this multiplicity includes
    all the cardinalities allowed by the specified multiplicity."
   :operation-body
   "result = (self.lowerBound() <= M.lowerBound()) and (self.upperBound() >= M.upperBound())"
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
   "result = (lowerbound = self.lowerbound and upperbound = self.upperbound)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|lowerbound| :parameter-type '|Integer|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|upperbound| :parameter-type '|Integer|
                        :parameter-return-p NIL))
)

(def-meta-operation "isMultivalued" |MultiplicityElement| 
   "The query isMultivalued() checks whether this multiplicity has an upper
    bound greater than one."
   :operation-body
   "result = upperBound() > 1"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |MultiplicityElement| 
   "The derived lower attribute must equal the lowerBound."
   :operation-body
   "result = lowerBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "lowerBound" |MultiplicityElement| 
   "The query lowerBound() returns the lower bound of the multiplicity as an
    integer."
   :operation-body
   "result = if lowerValue->isEmpty() then 1 else lowerValue.integerValue() endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |MultiplicityElement| 
   "The derived upper attribute must equal the upperBound."
   :operation-body
   "result = upperBound()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

(def-meta-operation "upperBound" |MultiplicityElement| 
   "The query upperBound() returns the upper bound of the multiplicity for
    a bounded multiplicity as an unlimited natural."
   :operation-body
   "result = if upperValue->isEmpty() then 1 else upperValue.unlimitedValue() endif"
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
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "NamedElement")
 "A named element is an element in a model that may have a name."
  ((|clientDependency| :xmi-id "NamedElement-clientDependency"
    :range |Dependency| :multiplicity (0 -1)
    :opposite (|Dependency| |client|)
    :documentation
     "Indicates the dependencies that reference the client.")
   (|name| :xmi-id "NamedElement-name"
    :range |String| :multiplicity (0 1)
    :documentation
     "The name of the NamedElement.")
   (|namespace| :xmi-id "NamedElement-namespace"
    :range |Namespace| :multiplicity (0 1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Namespace| |ownedMember|)
    :documentation
     "Specifies the namespace that owns the NamedElement.")
   (|qualifiedName| :xmi-id "NamedElement-qualifiedName"
    :range |String| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "A name which allows the NamedElement to be identified within a hierarchy
      of nested Namespaces. It is constructed from the names of the containing
      namespaces starting at the root of the hierarchy and ending with the name
      of the NamedElement itself.")
   (|visibility| :xmi-id "NamedElement-visibility"
    :range |VisibilityKind| :multiplicity (0 1)
    :documentation
     "Determines where the NamedElement appears within different Namespaces within
      the overall model, and its accessibility.")))

(def-meta-operation "allNamespaces" |NamedElement| 
   "The query allNamespaces() gives the sequence of namespaces in which the
    NamedElement is nested, working outwards."
   :operation-body
   "result = if self.namespace->isEmpty() then Sequence{} else self.namespace.allNamespaces()->prepend(self.namespace) endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T))
)

(def-meta-operation "allOwningPackages" |NamedElement| 
   "The query allOwningPackages() returns all the directly or indirectly owning
    packages."
   :operation-body
   "result = self.namespace->select(p | p.oclIsKindOf(Package))->union(p.allOwningPackages())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Package|
                        :parameter-return-p T))
)

(def-meta-operation "isDistinguishableFrom" |NamedElement| 
   "The query isDistinguishableFrom() determines whether two NamedElements
    may logically co-exist within a Namespace. By default, two named elements
    are distinguishable if (a) they have unrelated types or (b) they have related
    types but different names."
   :operation-body
   "result = if self.oclIsKindOf(n.oclType) or n.oclIsKindOf(self.oclType) then ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty() else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\n :parameter-type '|NamedElement|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|ns| :parameter-type '|Namespace|
                        :parameter-return-p NIL))
)

(def-meta-operation "qualifiedName.1" |NamedElement| 
   "When there is a name, and all of the containing namespaces have a name,
    the qualified name is constructed from the names of the containing namespaces."
   :operation-body
   "result = if self.name->notEmpty() and self.allNamespaces()->select(ns | ns.name->isEmpty())->isEmpty() then      self.allNamespaces()->iterate( ns : Namespace; result: String = self.name | ns.name->union(self.separator())->union(result)) else     Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "separator" |NamedElement| 
   "The query separator() gives the string that is used to separate names when
    constructing a qualified name."
   :operation-body
   "result = '::'"
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

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-meta-class |Namespace| 
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Namespace")
 "A namespace is an element in a model that contains a set of named elements
  that can be identified by name."
  ((|elementImport| :xmi-id "Namespace-elementImport"
    :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ElementImport| |importingNamespace|)
    :documentation
     "References the ElementImports owned by the Namespace.")
   (|importedMember| :xmi-id "Namespace-importedMember"
    :range |PackageableElement| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "References the PackageableElements that are members of this Namespace as
      a result of either PackageImports or ElementImports.")
   (|member| :xmi-id "Namespace-member"
    :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "A collection of NamedElements identifiable within the Namespace, either
      by being owned or by being introduced by importing or inheritance.")
   (|ownedMember| :xmi-id "Namespace-ownedMember"
    :range |NamedElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Element| |ownedElement|) (|Namespace| |member|))
    :opposite (|NamedElement| |namespace|)
    :documentation
     "A collection of NamedElements owned by the Namespace.")
   (|ownedRule| :xmi-id "Namespace-ownedRule"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Constraint| |context|)
    :documentation
     "Specifies a set of Constraints owned by this Namespace.")
   (|packageImport| :xmi-id "Namespace-packageImport"
    :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageImport| |importingNamespace|)
    :documentation
     "References the PackageImports owned by the Namespace.")))

(def-meta-operation "excludeCollisions" |Namespace| 
   "The query excludeCollisions() excludes from a set of PackageableElements
    any that would not be distinguishable from each other in this namespace."
   :operation-body
   "result = imps->reject(imp1 | imps.exists(imp2 | not imp1.isDistinguishableFrom(imp2, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "getNamesOfMember" |Namespace| 
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
   "result = if self.ownedMember ->includes(element) then Set{}->include(element.name) else let elementImports: ElementImport = self.elementImport->select(ei | ei.importedElement = element) in   if elementImports->notEmpty()   then elementImports->collect(el | el.getName())   else self.packageImport->select(pi | pi.importedPackage.visibleMembers()->includes(element))-> collect(pi | pi.importedPackage.getNamesOfMember(element))   endif endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|element| :parameter-type '|NamedElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "importMembers" |Namespace| 
   "The query importMembers() defines which of a set of PackageableElements
    are actually imported into the namespace. This excludes hidden ones, i.e.,
    those which have names that conflict with names of owned members, and also
    excludes elements which would have the same name when imported."
   :operation-body
   "result = self.excludeCollisions(imps)->select(imp | self.ownedMember->forAll(mem | mem.imp.isDistinguishableFrom(mem, self)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|PackageableElement|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|imps| :parameter-type '|PackageableElement|
                        :parameter-return-p NIL))
)

; POD
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
    the namespace's members are distinguishable within it."
   :operation-body
   "result = self.member->forAll( memb | self.member->excluding(memb)->forAll(other | memb.isDistinguishableFrom(other, self)))"
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

(def-meta-assoc "A_member_namespace"      
  :name |A_member_namespace|      
  :metatype :association      
  :member-ends ((|Namespace| "member")
                ("A_member_namespace-namespace" "namespace"))      
  :owned-ends  (("A_member_namespace-namespace" "namespace")))

(def-meta-assoc-end "A_member_namespace-namespace" 
    :type |Namespace| 
    :multiplicity (0 -1) 
    :association "A_member_namespace" 
    :name "namespace")

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
;;; ====================== ObjectFlow
;;; =========================================================
(def-meta-class |ObjectFlow| 
   (:model :UML4SYSML12 :superclasses (|ActivityEdge|) 
    :packages (|UML4SysML|) 
    :xmi-id "ObjectFlow")
 "An object flow is an activity edge that can have objects or data passing
  along it.Object flows have support for multicast/receive, token selection
  from object nodes, and transformation of tokens."
  ((|isMulticast| :xmi-id "ObjectFlow-isMulticast"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the objects in the flow are passed by multicasting.")
   (|isMultireceive| :xmi-id "ObjectFlow-isMultireceive"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the objects in the flow are gathered from respondents to
      multicasting.")
   (|selection| :xmi-id "ObjectFlow-selection"
    :range |Behavior| :multiplicity (0 1)
    :documentation
     "Selects tokens from a source object node.")
   (|transformation| :xmi-id "ObjectFlow-transformation"
    :range |Behavior| :multiplicity (0 1)
    :documentation
     "Changes or replaces data tokens flowing along edge.")))

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
   (:model :UML4SYSML12 :superclasses (|ActivityNode| |TypedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ObjectNode")
 "An object node is an abstract activity node that is part of defining object
  flow in an activity.Object nodes have support for token selection, limitation
  on the number of tokens, specifying the state required for tokens, and
  carrying control values."
  ((|inState| :xmi-id "ObjectNode-inState"
    :range |State| :multiplicity (0 -1)
    :documentation
     "The required states of the object available at this point in the activity.")
   (|isControlType| :xmi-id "ObjectNode-isControlType"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the type of the object node is to be treated as control.")
   (|ordering| :xmi-id "ObjectNode-ordering"
    :range |ObjectNodeOrderingKind| :multiplicity (1 1) :default :fifo
    :documentation
     "Tells whether and how the tokens in the object node are ordered for selection
      to traverse edges outgoing from the object node.")
   (|selection| :xmi-id "ObjectNode-selection"
    :range |Behavior| :multiplicity (0 1)
    :documentation
     "Selects tokens for outgoing edges.")
   (|upperBound| :xmi-id "ObjectNode-upperBound"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The maximum number of tokens allowed in the node. Objects cannot flow into
      the node if the upper bound is reached.")))

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
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Observation")
 "Observation is a superclass of TimeObservation and DurationObservation
  in order for TimeExpression and Duration to refer to either in a simple
  way."
  ())

;;; =========================================================
;;; ====================== OccurrenceSpecification
;;; =========================================================
(def-meta-class |OccurrenceSpecification| 
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "OccurrenceSpecification")
 "An occurrence specification is the basic semantic unit of interactions.
  The sequences of occurrences specified by them are the meanings of interactions."
  ((|covered| :xmi-id "OccurrenceSpecification-covered"
    :range |Lifeline| :multiplicity (1 1)
    :documentation
     "References the Lifeline on which the OccurrenceSpecification appears." :redefined-property (|InteractionFragment| |covered|))
   (|event| :xmi-id "OccurrenceSpecification-event"
    :range |Event| :multiplicity (1 1)
    :documentation
     "References a specification of the occurring event.")
   (|toAfter| :xmi-id "OccurrenceSpecification-toAfter"
    :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |before|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur after this OccurrenceSpecification")
   (|toBefore| :xmi-id "OccurrenceSpecification-toBefore"
    :range |GeneralOrdering| :multiplicity (0 -1)
    :opposite (|GeneralOrdering| |after|)
    :documentation
     "References the GeneralOrderings that specify EventOcurrences that must
      occur before this OccurrenceSpecification")))

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

(def-meta-assoc "A_event_occurrenceSpecification"      
  :name |A_event_occurrenceSpecification|      
  :metatype :association      
  :member-ends ((|OccurrenceSpecification| "event")
                ("A_event_occurrenceSpecification-occurrenceSpecification" "occurrenceSpecification"))      
  :owned-ends  (("A_event_occurrenceSpecification-occurrenceSpecification" "occurrenceSpecification")))

(def-meta-assoc-end "A_event_occurrenceSpecification-occurrenceSpecification" 
    :type |OccurrenceSpecification| 
    :multiplicity (0 -1) 
    :association "A_event_occurrenceSpecification" 
    :name "occurrenceSpecification")

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "OpaqueAction")
 "An action with implementation-specific semantics."
  ((|body| :xmi-id "OpaqueAction-body"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Specifies the action in one or more languages.")
   (|inputValue| :xmi-id "OpaqueAction-inputValue"
    :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Provides input to the action.")
   (|language| :xmi-id "OpaqueAction-language"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Languages the body strings use, in the same order as the body strings")
   (|outputValue| :xmi-id "OpaqueAction-outputValue"
    :range |OutputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Takes output from the action.")))

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
   (:model :UML4SYSML12 :superclasses (|Behavior|) 
    :packages (|UML4SysML|) 
    :xmi-id "OpaqueBehavior")
 "An behavior with implementation-specific semantics."
  ((|body| :xmi-id "OpaqueBehavior-body"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Specifies the behavior in one or more languages.")
   (|language| :xmi-id "OpaqueBehavior-language"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Languages the body strings use in the same order as the body strings.")))

;;; =========================================================
;;; ====================== OpaqueExpression
;;; =========================================================
(def-meta-class |OpaqueExpression| 
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "OpaqueExpression")
 "An opaque expression is an uninterpreted textual statement that denotes
  a (possibly empty) set of values when evaluated in a context.Provides a
  mechanism for precisely defining the behavior of an opaque expression.
  An opaque expression is defined by a behavior restricted to return one
  result."
  ((|behavior| :xmi-id "OpaqueExpression-behavior"
    :range |Behavior| :multiplicity (0 1)
    :documentation
     "Specifies the behavior of the opaque expression.")
   (|body| :xmi-id "OpaqueExpression-body"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "The text of the expression, possibly in multiple languages.")
   (|language| :xmi-id "OpaqueExpression-language"
    :range |String| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "Specifies the languages in which the expression is stated. The interpretation
      of the expression body depends on the languages. If the languages are unspecified,
      they might be implicit from the expression body or the context. Languages
      are matched to body strings by order.")
   (|result| :xmi-id "OpaqueExpression-result"
    :range |Parameter| :multiplicity (0 1) :is-readonly-p T :is-derived-p T
    :documentation
     "Restricts an opaque expression to return exactly one return result. When
      the invocation of the opaque expression completes, a single set of values
      is returned to its owner. This association is derived from the single return
      result parameter of the associated behavior.")))

(def-meta-operation "isIntegral" |OpaqueExpression| 
   "The query isIntegral() tells whether an expression is intended to produce
    an integer."
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNonNegative" |OpaqueExpression| 
   "The query isNonNegative() tells whether an integer expression has a non-negative
    value."
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isPositive" |OpaqueExpression| 
   "The query isPositive() tells whether an integer expression has a positive
    value."
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "value" |OpaqueExpression| 
   "The query value() gives an integer value for an expression intended to
    produce one."
   :operation-body
   "true"
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
   (:model :UML4SYSML12 :superclasses (|BehavioralFeature|) 
    :packages (|UML4SysML|) 
    :xmi-id "Operation")
 "An operation is a behavioral feature of a classifier that specifies the
  name, type, parameters, and constraints for invoking an associated behavior.An
  operation may invoke both the execution of method behaviors as well as
  other behavioral responses."
  ((|bodyCondition| :xmi-id "Operation-bodyCondition"
    :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional Constraint on the result values of an invocation of this Operation.")
   (|class| :xmi-id "Operation-class"
    :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Class| |ownedOperation|)
    :documentation
     "The class that owns the operation.")
   (|datatype| :xmi-id "Operation-datatype"
    :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|DataType| |ownedOperation|)
    :documentation
     "The DataType that owns this Operation.")
   (|interface| :xmi-id "Operation-interface"
    :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|RedefinableElement| |redefinitionContext|))
    :opposite (|Interface| |ownedOperation|)
    :documentation
     "The Interface that owns this Operation.")
   (|isOrdered| :xmi-id "Operation-isOrdered"
    :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "This information is derived from the return result for this Operation.
      Specifies whether the return parameter is ordered or not, if present.")
   (|isQuery| :xmi-id "Operation-isQuery"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether an execution of the BehavioralFeature leaves the state
      of the system unchanged (isQuery=true) or whether side effects may occur
      (isQuery=false).")
   (|isUnique| :xmi-id "Operation-isUnique"
    :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :true
    :documentation
     "This information is derived from the return result for this Operation.
      Specifies whether the return parameter is unique or not, if present.")
   (|lower| :xmi-id "Operation-lower"
    :range |Integer| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "This information is derived from the return result for this Operation.
      Specifies the lower multiplicity of the return parameter, if present.")
   (|ownedParameter| :xmi-id "Operation-ownedParameter"
    :range |Parameter| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :opposite (|Parameter| |operation|)
    :documentation
     "Specifies the ordered set of formal parameters of this BehavioralFeature.
      Specifies the parameters owned by this Operation." :redefined-property (|BehavioralFeature| |ownedParameter|))
   (|postcondition| :xmi-id "Operation-postcondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints specifying the state of the system when
      the Operation is completed.")
   (|precondition| :xmi-id "Operation-precondition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "An optional set of Constraints on the state of the system when the Operation
      is invoked.")
   (|raisedException| :xmi-id "Operation-raisedException"
    :range |Type| :multiplicity (0 -1)
    :documentation
     "References the Types representing exceptions that may be raised during
      an invocation of this operation." :redefined-property (|BehavioralFeature| |raisedException|))
   (|redefinedOperation| :xmi-id "Operation-redefinedOperation"
    :range |Operation| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References the Operations that are redefined by this Operation.")
   (|type| :xmi-id "Operation-type"
    :range |Type| :multiplicity (0 1) :is-derived-p T
    :documentation
     "This information is derived from the return result for this Operation.
      Specifies the return result of the operation, if present.")
   (|upper| :xmi-id "Operation-upper"
    :range |UnlimitedNatural| :multiplicity (0 1) :is-derived-p T :default 1
    :documentation
     "This information is derived from the return result for this Operation.
      Specifies the upper multiplicity of the return parameter, if present.")))

(def-meta-operation "isConsistentWith" |Operation| 
   "The query isConsistentWith() specifies, for any two Operations in a context
    in which redefinition is possible, whether redefinition would be consistent
    in the sense of maintaining type covariance. Other senses of consistency
    may be required, for example to determine consistency in the sense of contravariance.
    Users may define alternative queries under names different from 'isConsistentWith()',
    as for example, users may define a query named 'isContravariantWith()'.
    A redefining operation is consistent with a redefined operation if it has
    the same number of owned parameters, and the type of each owned parameter
    conforms to the type of the corresponding redefined parameter."
   :operation-body
   "result = redefinee.oclIsKindOf(Operation) and  let op : Operation = redefinee.oclAsType(Operation) in   self.ownedParameter->size() = op.ownedParameter->size() and   Sequence{1..self.ownedParameter->size()}->    forAll(i |op.ownedParameter->at(1).type.conformsTo(self.ownedParameter->at(i).type))"
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
   "result = if returnResult()->notEmpty() then returnResult()->any().isOrdered else false endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isUnique.1" |Operation| 
   "If this operation has a return parameter, isUnique equals the value of
    isUnique for that parameter. Otherwise isUnique is true."
   :operation-body
   "result = if returnResult()->notEmpty() then returnResult()->any().isUnique else true endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "lower.1" |Operation| 
   "If this operation has a return parameter, lower equals the value of lower
    for that parameter. Otherwise lower is not defined."
   :operation-body
   "result = if returnResult()->notEmpty() then returnResult()->any().lower else Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "returnResult" |Operation| 
   "The query returnResult() returns the set containing the return parameter
    of the Operation if one exists, otherwise, it returns an empty set"
   :operation-body
   "result = ownedParameter->select (par | par.direction = #return)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Parameter|
                        :parameter-return-p T))
)

(def-meta-operation "type.1" |Operation| 
   "If this operation has a return parameter, type equals the value of type
    for that parameter. Otherwise type is not defined."
   :operation-body
   "result = if returnResult()->notEmpty() then returnResult()->any().type else Set{} endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Type|
                        :parameter-return-p T))
)

(def-meta-operation "upper.1" |Operation| 
   "If this operation has a return parameter, upper equals the value of upper
    for that parameter. Otherwise upper is not defined."
   :operation-body
   "result = if returnResult()->notEmpty() then returnResult()->any().upper else Set{} endif"
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
;;; ====================== OutputPin
;;; =========================================================
(def-meta-class |OutputPin| 
   (:model :UML4SYSML12 :superclasses (|Pin|) 
    :packages (|UML4SysML|) 
    :xmi-id "OutputPin")
 "An output pin is a pin that holds output values produced by an action."
  ())

;;; =========================================================
;;; ====================== Package
;;; =========================================================
(def-meta-class |Package| 
   (:model :UML4SYSML12 :superclasses (|PackageableElement| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "Package")
 "A package is used to group elements, and provides a namespace for the grouped
  elements.A package can have one or more profile applications to indicate
  which profiles have been applied. Because a profile is a package, it is
  possible to apply a profile not only to packages, but also to profiles."
  ((|nestedPackage| :xmi-id "Package-nestedPackage"
    :range |Package| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Package| |nestingPackage|)
    :documentation
     "References the packaged elements that are Packages.")
   (|nestingPackage| :xmi-id "Package-nestingPackage"
    :range |Package| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Package| |nestedPackage|)
    :documentation
     "References the Package that owns this Package.")
   (|ownedStereotype| :xmi-id "Package-ownedStereotype"
    :range |Stereotype| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :documentation
     "References the Stereotypes that are owned by the Package")
   (|ownedType| :xmi-id "Package-ownedType"
    :range |Type| :multiplicity (0 -1) :is-composite-p T :is-derived-p T
    :subsetted-properties ((|Package| |packagedElement|))
    :opposite (|Type| |package|)
    :documentation
     "References the packaged elements that are Types.")
   (|packageMerge| :xmi-id "Package-packageMerge"
    :range |PackageMerge| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|PackageMerge| |receivingPackage|)
    :documentation
     "References the PackageMerges that are owned by this Package.")
   (|packagedElement| :xmi-id "Package-packagedElement"
    :range |PackageableElement| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :documentation
     "Specifies the packageable elements that are owned by this Package.")
   (|profileApplication| :xmi-id "Package-profileApplication"
    :range |ProfileApplication| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|ProfileApplication| |applyingPackage|)
    :documentation
     "References the ProfileApplications that indicate which profiles have been
      applied to the Package.")))

(def-meta-operation "allApplicableStereotypes" |Package| 
   "The query allApplicableStereotypes() returns all the directly or indirectly
    owned stereotypes, including stereotypes contained in sub-profiles."
   :operation-body
   "result =   self.ownedStereotype->union(self.ownedMember->   select(oclIsKindOf(Package)).oclAsType(Package).allApplicableStereotypes()->flatten())->asSet()"
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
   "result = (ownedMember->includes(el)) or (elementImport->select(ei|ei.importedElement = #public)->collect(ei|ei.importedElement)->includes(el)) or (packageImport->select(pi|pi.visibility = #public)->collect(pi|pi.importedPackage.member->includes(el))->notEmpty())"
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
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "visibleMembers" |Package| 
   "The query visibleMembers() defines which members of a Package can be accessed
    outside it."
   :operation-body
   "result = member->select( m | self.makesVisible(m))"
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

(def-meta-assoc "A_ownedStereotype_profile"      
  :name |A_ownedStereotype_profile|      
  :metatype :association      
  :member-ends ((|Package| "ownedStereotype")
                ("A_ownedStereotype_profile-profile" "profile"))      
  :owned-ends  (("A_ownedStereotype_profile-profile" "profile")))

(def-meta-assoc-end "A_ownedStereotype_profile-profile" 
    :type |Package| 
    :multiplicity (1 1) 
    :association "A_ownedStereotype_profile" 
    :name "profile")

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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "PackageImport")
 "A package import is a relationship that allows the use of unqualified names
  to refer to package members from other namespaces."
  ((|importedPackage| :xmi-id "PackageImport-importedPackage"
    :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "Specifies the Package whose members are imported into a Namespace.")
   (|importingNamespace| :xmi-id "PackageImport-importingNamespace"
    :range |Namespace| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Namespace| |packageImport|)
    :documentation
     "Specifies the Namespace that imports the members from a Package.")
   (|visibility| :xmi-id "PackageImport-visibility"
    :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Specifies the visibility of the imported PackageableElements within the
      importing Namespace, i.e., whether imported elements will in turn be visible
      to other packages that use that importingPackage as an importedPackage.
      If the PackageImport is public, the imported elements will be visible outside
      the package, while if it is private they will not.")))

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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "PackageMerge")
 "A package merge defines how the contents of one package are extended by
  the contents of another package."
  ((|mergedPackage| :xmi-id "PackageMerge-mergedPackage"
    :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the Package that is to be merged with the receiving package
      of the PackageMerge.")
   (|receivingPackage| :xmi-id "PackageMerge-receivingPackage"
    :range |Package| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "PackageableElement")
 "A packageable element indicates a named element that may be owned directly
  by a package."
  ((|visibility| :xmi-id "PackageableElement-visibility"
    :range |VisibilityKind| :multiplicity (1 1) :default :public
    :documentation
     "Indicates that packageable elements must always have a visibility, i.e.,
      visibility is not optional." :redefined-property (|NamedElement| |visibility|))))

;;; =========================================================
;;; ====================== Parameter
;;; =========================================================
(def-meta-class |Parameter| 
   (:model :UML4SYSML12 :superclasses (|TypedElement| |MultiplicityElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Parameter")
 "A parameter is a specification of an argument used to pass information
  into or out of an invocation of a behavioral feature.Parameters have support
  for streaming, exceptions, and parameter sets."
  ((|default| :xmi-id "Parameter-default"
    :range |String| :multiplicity (0 1) :is-derived-p T
    :documentation
     "Specifies a String that represents a value to be used when no argument
      is supplied for the Parameter.")
   (|defaultValue| :xmi-id "Parameter-defaultValue"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies a ValueSpecification that represents a value to be used when
      no argument is supplied for the Parameter.")
   (|direction| :xmi-id "Parameter-direction"
    :range |ParameterDirectionKind| :multiplicity (1 1) :default :in
    :documentation
     "Indicates whether a parameter is being sent into or out of a behavioral
      element.")
   (|effect| :xmi-id "Parameter-effect"
    :range |ParameterEffectKind| :multiplicity (0 1)
    :documentation
     "Specifies the effect that the owner of the parameter has on values passed
      in or out of the parameter.")
   (|isException| :xmi-id "Parameter-isException"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an output parameter may emit a value to the exclusion of
      the other outputs.")
   (|isStream| :xmi-id "Parameter-isStream"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether an input parameter may accept values while its behavior is
      executing, or whether an output parameter post values while the behavior
      is executing.")
   (|operation| :xmi-id "Parameter-operation"
    :range |Operation| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Operation| |ownedParameter|)
    :documentation
     "References the Operation owning this parameter.")
   (|parameterSet| :xmi-id "Parameter-parameterSet"
    :range |ParameterSet| :multiplicity (0 -1)
    :opposite (|ParameterSet| |parameter|)
    :documentation
     "The parameter sets containing the parameter. See ParameterSet.")))

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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ParameterSet")
 "A parameter set is an element that provides alternative sets of inputs
  or outputs that a behavior may use."
  ((|condition| :xmi-id "ParameterSet-condition"
    :range |Constraint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Constraint that should be satisfied for the owner of the parameters in
      an input parameter set to start execution using the values provided for
      those parameters, or the owner of the parameters in an output parameter
      set to end execution providing the values for those parameters, if all
      preconditions and conditions on input parameter sets were satisfied.")
   (|parameter| :xmi-id "ParameterSet-parameter"
    :range |Parameter| :multiplicity (1 -1)
    :opposite (|Parameter| |parameterSet|)
    :documentation
     "Parameters in the parameter set.")))

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
;;; ====================== PartDecomposition
;;; =========================================================
(def-meta-class |PartDecomposition| 
   (:model :UML4SYSML12 :superclasses (|InteractionUse|) 
    :packages (|UML4SysML|) 
    :xmi-id "PartDecomposition")
 "A part decomposition is a description of the internal interactions of one
  lifeline relative to an interaction."
  ())

;;; =========================================================
;;; ====================== Pin
;;; =========================================================
(def-meta-class |Pin| 
   (:model :UML4SYSML12 :superclasses (|MultiplicityElement| |ObjectNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "Pin")
 "A pin is a typed element and multiplicity element that provides values
  to actions and accept result values from them.A pin is an object node for
  inputs and outputs to actions."
  ((|isControl| :xmi-id "Pin-isControl"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the pins provide data to the actions, or just controls when
      it executes it.")))

;;; =========================================================
;;; ====================== Port
;;; =========================================================
(def-meta-class |Port| 
   (:model :UML4SYSML12 :superclasses (|Property|) 
    :packages (|UML4SysML|) 
    :xmi-id "Port")
 "A port is a property of a classifier that specifies a distinct interaction
  point between that classifier and its environment or between the (behavior
  of the) classifier and its internal parts. Ports are connected to properties
  of the classifier by connectors through which requests can be made to invoke
  the behavioral features of a classifier. A Port may specify the services
  a classifier provides (offers) to its environment as well as the services
  that a classifier expects (requires) of its environment."
  ((|isBehavior| :xmi-id "Port-isBehavior"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether requests arriving at this port are sent to the classifier
      behavior of this classifier. Such ports are referred to as behavior port.
      Any invocation of a behavioral feature targeted at a behavior port will
      be handled by the instance of the owning classifier itself, rather than
      by any instances that this classifier may contain.")
   (|isConjugated| :xmi-id "Port-isConjugated"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies the way that the provided and required interfaces are derived
      from the Port's Type.  The default value is false.")
   (|isService| :xmi-id "Port-isService"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "If true indicates that this port is used to provide the published functionality
      of a classifier; if false, this port is used to implement the classifier
      but is not part of the essential externally-visible functionality of the
      classifier and can, therefore, be altered or deleted along with the internal
      implementation of the classifier and other properties that are considered
      part of its implementation.")
   (|provided| :xmi-id "Port-provided"
    :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the interfaces specifying the set of operations and receptions
      that the classifier offers to its environment via this port, and which
      it will handle either directly or by forwarding it to a part of its internal
      structure.  This association is derived according to the value of isConjugated.
      If isConjugated is false, provided is derived as the union of the sets
      of interfaces realized by the type of the port and its supertypes, or directly
      from the type of the port if the port is typed by an interface. If isConjugated
      is true, it is derived as the union of the sets of interfaces used by the
      type of the port and its supertypes.")
   (|redefinedPort| :xmi-id "Port-redefinedPort"
    :range |Port| :multiplicity (0 -1)
    :subsetted-properties ((|Property| |redefinedProperty|))
    :documentation
     "A port may be redefined when its containing classifier is specialized.
      The redefining port may have additional interfaces to those that are associated
      with the redefined port or it may replace an interface by one of its subtypes.")
   (|required| :xmi-id "Port-required"
    :range |Interface| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the interfaces specifying the set of operations and receptions
      that the classifier expects its environment to handle via this port. This
      association is derived according to the value of isConjugated.  If isConjugated
      is false, required is derived as the union of the sets of interfaces used
      by the type of the port and its supertypes.  If isConjugated is true, it
      is derived as the union of the sets of interfaces realized by the type
      of the port and its supertypes, or directly from the type of the port if
      the port is typed by an interface.")))

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
   (:model :UML4SYSML12 :superclasses (|DataType|) 
    :packages (|UML4SysML|) 
    :xmi-id "PrimitiveType")
 "A primitive type defines a predefined data type, without any relevant substructure
  (i.e., it has no parts in the context of UML). A primitive datatype may
  have an algebra and operations defined outside of UML, for example, mathematically."
  ())

;;; =========================================================
;;; ====================== Profile
;;; =========================================================
(def-meta-class |Profile| 
   (:model :UML4SYSML12 :superclasses (|Package|) 
    :packages (|UML4SysML|) 
    :xmi-id "Profile")
 "A profile defines limited extensions to a reference metamodel with the
  purpose of adapting the metamodel to a specific platform or domain."
  ((|metaclassReference| :xmi-id "Profile-metaclassReference"
    :range |ElementImport| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |elementImport|))
    :documentation
     "References a metaclass that may be extended.")
   (|metamodelReference| :xmi-id "Profile-metamodelReference"
    :range |PackageImport| :multiplicity (0 -1) :is-composite-p T
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
   (:model :UML4SYSML12 :superclasses (|DirectedRelationship|) 
    :packages (|UML4SysML|) 
    :xmi-id "ProfileApplication")
 "A profile application is used to show which profiles have been applied
  to a package."
  ((|appliedProfile| :xmi-id "ProfileApplication-appliedProfile"
    :range |Profile| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |target|))
    :documentation
     "References the Profiles that are applied to a Package through this ProfileApplication.")
   (|applyingPackage| :xmi-id "ProfileApplication-applyingPackage"
    :range |Package| :multiplicity (1 1)
    :subsetted-properties ((|DirectedRelationship| |source|) (|Element| |owner|))
    :opposite (|Package| |profileApplication|)
    :documentation
     "The package that owns the profile application.")
   (|isStrict| :xmi-id "ProfileApplication-isStrict"
    :range |Boolean| :multiplicity (1 1) :default :false
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
   (:model :UML4SYSML12 :superclasses (|ConnectableElement| |StructuralFeature|) 
    :packages (|UML4SysML|) 
    :xmi-id "Property")
 "A property is a structural feature of a classifier that characterizes instances
  of the classifier. A property related by ownedAttribute to a classifier
  (other than an association) represents an attribute and might also represent
  an association end. It relates an instance of the class to a value or set
  of values of the type of the attribute. A property related by memberEnd
  or its specializations to an association represents an end of the association.
  The type of the property is the type of the end of the association.A property
  represents a set of instances that are owned by a containing classifier
  instance.Property represents a declared state of one or more instances
  in terms of a named relationship to a value or values. When a property
  is an attribute of a classifier, the value or values are related to the
  instance of the classifier by being held in slots of the instance. When
  a property is an association end, the value or values are related to the
  instance or instances at the other end(s) of the association. The range
  of valid values represented by the property can be controlled by setting
  the property's type."
  ((|aggregation| :xmi-id "Property-aggregation"
    :range |AggregationKind| :multiplicity (1 1) :default :none
    :documentation
     "Specifies the kind of aggregation that applies to the Property.")
   (|association| :xmi-id "Property-association"
    :range |Association| :multiplicity (0 1)
    :opposite (|Association| |memberEnd|)
    :documentation
     "References the association of which this property is a member, if any.")
   (|associationEnd| :xmi-id "Property-associationEnd"
    :range |Property| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|Property| |qualifier|)
    :documentation
     "Designates the optional association end that owns a qualifier attribute.")
   (|class| :xmi-id "Property-class"
    :range |Class| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|))
    :opposite (|Class| |ownedAttribute|)
    :documentation
     "References the Class that owns the Property.")
   (|datatype| :xmi-id "Property-datatype"
    :range |DataType| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|))
    :opposite (|DataType| |ownedAttribute|)
    :documentation
     "The DataType that owns this Property.")
   (|default| :xmi-id "Property-default"
    :range |String| :multiplicity (0 1) :is-derived-p T
    :documentation
     "Specifies a String that represents a value to be used when no argument
      is supplied for the Property. A String that is evaluated to give a default
      value for the Property when an object of the owning Classifier is instantiated.")
   (|defaultValue| :xmi-id "Property-defaultValue"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A ValueSpecification that is evaluated to give a default value for the
      Property when an object of the owning Classifier is instantiated.")
   (|interface| :xmi-id "Property-interface"
    :range |Interface| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|))
    :opposite (|Interface| |ownedAttribute|))
   (|isComposite| :xmi-id "Property-isComposite"
    :range |Boolean| :multiplicity (1 1) :is-derived-p T :default :false
    :documentation
     "If isComposite is true, the object containing the attribute is a container
      for the object or value contained in the attribute. This is a derived value,
      indicating whether the aggregation of the Property is composite or not.")
   (|isDerived| :xmi-id "Property-isDerived"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isDerived is true, the value of the attribute is derived from information
      elsewhere. Specifies whether the Property is derived, i.e., whether its
      value or values can be computed from other information.")
   (|isDerivedUnion| :xmi-id "Property-isDerivedUnion"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether the property is derived as the union of all of the properties
      that are constrained to subset it.")
   (|isReadOnly| :xmi-id "Property-isReadOnly"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "If isReadOnly is true, the attribute may not be written to after initialization.
      If true, the attribute may only be read, and not written." :redefined-property (|StructuralFeature| |isReadOnly|))
   (|opposite| :xmi-id "Property-opposite"
    :range |Property| :multiplicity (0 1) :is-derived-p T
    :documentation
     "In the case where the property is one navigable end of a binary association
      with both ends navigable, this gives the other end.")
   (|owningAssociation| :xmi-id "Property-owningAssociation"
    :range |Association| :multiplicity (0 1)
    :subsetted-properties ((|Feature| |featuringClassifier|) (|NamedElement| |namespace|) (|Property| |association|))
    :opposite (|Association| |ownedEnd|)
    :documentation
     "References the owning association of this property, if any.")
   (|qualifier| :xmi-id "Property-qualifier"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Property| |associationEnd|)
    :documentation
     "An optional list of ordered qualifier attributes for the end. If the list
      is empty, then the Association is not qualified.")
   (|redefinedProperty| :xmi-id "Property-redefinedProperty"
    :range |Property| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "References the properties that are redefined by this property.")
   (|subsettedProperty| :xmi-id "Property-subsettedProperty"
    :range |Property| :multiplicity (0 -1)
    :documentation
     "References the properties of which this property is constrained to be a
      subset.")))

(def-meta-operation "isAttribute" |Property| 
   "The query isAttribute() is true if the Property is defined as an attribute
    of some classifier."
   :operation-body
   "result = Classifier.allInstances->exists(c | c.attribute->includes(p))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '\p :parameter-type '|Property|
                        :parameter-return-p NIL))
)

(def-meta-operation "isComposite.1" |Property| 
   "The value of isComposite is true only if aggregation is composite."
   :operation-body
   "result = (self.aggregation = #composite)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isConsistentWith" |Property| 
   "The query isConsistentWith() specifies, for any two Properties in a context
    in which redefinition is possible, whether redefinition would be logically
    consistent. A redefining property is consistent with a redefined property
    if the type of the redefining property conforms to the type of the redefined
    property, the multiplicity of the redefining property (if specified) is
    contained in the multiplicity of the redefined property, and the redefining
    property is derived if the redefined property is derived."
   :operation-body
   "result = redefinee.oclIsKindOf(Property) and    let prop : Property = redefinee.oclAsType(Property) in    (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty() and self.lowerBound()->notEmpty()) implies prop.lowerBound() >= self.lowerBound()) and    ((prop.upperBound()->notEmpty() and self.upperBound()->notEmpty()) implies prop.lowerBound() <= self.lowerBound()) and    (self.isDerived implies prop.isDerived) and   (self.isComposite implies prop.isComposite))"
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
   "result = not classifier->isEmpty() or association.owningAssociation.navigableOwnedEnd->includes(self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "opposite.1" |Property| 
   "If this property is owned by a class, associated with a binary association,
    and the other end of the association is also owned by a class, then opposite
    gives the other end."
   :operation-body
   "result = if owningAssociation->isEmpty() and association.memberEnd->size() = 2   then     let otherEnd = (association.memberEnd - self)->any() in       if otherEnd.owningAssociation->isEmpty() then otherEnd else Set{} endif     else Set {}     endif"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Property|
                        :parameter-return-p T))
)

(def-meta-operation "subsettingContext" |Property| 
   "The query subsettingContext() gives the context for subsetting a property.
    It consists, in the case of an attribute, of the corresponding classifier,
    and in the case of an association end, all of the classifiers at the other
    ends."
   :operation-body
   "result = if association->notEmpty() then association.endType-type else if classifier->notEmpty() then Set{classifier} else Set{} endif endif"
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
;;; ====================== Pseudostate
;;; =========================================================
(def-meta-class |Pseudostate| 
   (:model :UML4SYSML12 :superclasses (|Vertex|) 
    :packages (|UML4SysML|) 
    :xmi-id "Pseudostate")
 "A pseudostate is an abstraction that encompasses different types of transient
  vertices in the state machine graph."
  ((|kind| :xmi-id "Pseudostate-kind"
    :range |PseudostateKind| :multiplicity (1 1) :default :initial
    :documentation
     "Determines the precise type of the Pseudostate and can be one of: entryPoint,
      exitPoint, initial, deepHistory, shallowHistory, join, fork, junction,
      terminate or choice.")
   (|state| :xmi-id "Pseudostate-state"
    :range |State| :multiplicity (0 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|State| |connectionPoint|)
    :documentation
     "The State that owns this pseudostate and in which it appears.")
   (|stateMachine| :xmi-id "Pseudostate-stateMachine"
    :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |connectionPoint|)
    :documentation
     "The StateMachine in which this Pseudostate is defined. This only applies
      to Pseudostates of the kind entryPoint or exitPoint.")))

;;; =========================================================
;;; ====================== QualifierValue
;;; =========================================================
(def-meta-class |QualifierValue| 
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "QualifierValue")
 "A qualifier value is not an action. It is an element that identifies links.
  It gives a single qualifier within a link end data specification."
  ((|qualifier| :xmi-id "QualifierValue-qualifier"
    :range |Property| :multiplicity (1 1)
    :documentation
     "Attribute representing the qualifier for which the value is to be specified.")
   (|value| :xmi-id "QualifierValue-value"
    :range |InputPin| :multiplicity (1 1)
    :documentation
     "Input pin from which the specified value for the qualifier is taken.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "RaiseExceptionAction")
 "A raise exception action is an action that causes an exception to occur.
  The input value becomes the exception object."
  ((|exception| :xmi-id "RaiseExceptionAction-exception"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "An input pin whose value becomes an exception object.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadExtentAction")
 "A read extent action is an action that retrieves the current instances
  of a classifier."
  ((|classifier| :xmi-id "ReadExtentAction-classifier"
    :range |Classifier| :multiplicity (1 1)
    :documentation
     "The classifier whose instances are to be retrieved.")
   (|result| :xmi-id "ReadExtentAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The runtime instances of the classifier.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadIsClassifiedObjectAction")
 "A read is classified object action is an action that determines whether
  a runtime object is classified by a given classifier."
  ((|classifier| :xmi-id "ReadIsClassifiedObjectAction-classifier"
    :range |Classifier| :multiplicity (1 1)
    :documentation
     "The classifier against which the classification of the input object is
      tested.")
   (|isDirect| :xmi-id "ReadIsClassifiedObjectAction-isDirect"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether the classifier must directly classify the input object.")
   (|object| :xmi-id "ReadIsClassifiedObjectAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Holds the object whose classification is to be tested.")
   (|result| :xmi-id "ReadIsClassifiedObjectAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "After termination of the action, will hold the result of the test.")))

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
   (:model :UML4SYSML12 :superclasses (|LinkAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadLinkAction")
 "A read link action is a link action that navigates across associations
  to retrieve objects on one end."
  ((|result| :xmi-id "ReadLinkAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The pin on which are put the objects participating in the association at
      the end not specified by the inputs.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadLinkObjectEndAction")
 "A read link object end action is an action that retrieves an end object
  from a link object."
  ((|end| :xmi-id "ReadLinkObjectEndAction-end"
    :range |Property| :multiplicity (1 1)
    :documentation
     "Link end to be read.")
   (|object| :xmi-id "ReadLinkObjectEndAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the input pin from which the link object is obtained.")
   (|result| :xmi-id "ReadLinkObjectEndAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Pin where the result value is placed.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadLinkObjectEndQualifierAction")
 "A read link object end qualifier action is an action that retrieves a qualifier
  end value from a link object."
  ((|object| :xmi-id "ReadLinkObjectEndQualifierAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the input pin from which the link object is obtained.")
   (|qualifier| :xmi-id "ReadLinkObjectEndQualifierAction-qualifier"
    :range |Property| :multiplicity (1 1)
    :documentation
     "The attribute representing the qualifier to be read.")
   (|result| :xmi-id "ReadLinkObjectEndQualifierAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Pin where the result value is placed.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadSelfAction")
 "A read self action is an action that retrieves the host object of an action."
  ((|result| :xmi-id "ReadSelfAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the hosting object is placed.")))

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
   (:model :UML4SYSML12 :superclasses (|StructuralFeatureAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadStructuralFeatureAction")
 "A read structural feature action is a structural feature action that retrieves
  the values of a structural feature."
  ((|result| :xmi-id "ReadStructuralFeatureAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
   (:model :UML4SYSML12 :superclasses (|VariableAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReadVariableAction")
 "A read variable action is a variable action that retrieves the values of
  a variable."
  ((|result| :xmi-id "ReadVariableAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
   (:model :UML4SYSML12 :superclasses (|Abstraction|) 
    :packages (|UML4SysML|) 
    :xmi-id "Realization")
 "Realization is a specialized abstraction relationship between two sets
  of model elements, one representing a specification (the supplier) and
  the other represents an implementation of the latter (the client). Realization
  can be used to model stepwise refinement, optimizations, transformations,
  templates, model synthesis, framework composition, etc."
  ())

;;; =========================================================
;;; ====================== ReceiveOperationEvent
;;; =========================================================
(def-meta-class |ReceiveOperationEvent| 
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReceiveOperationEvent")
 "A receive operation event specifies the event of receiving an operation
  invocation for a particular operation by the target entity."
  ((|operation| :xmi-id "ReceiveOperationEvent-operation"
    :range |Operation| :multiplicity (1 1)
    :documentation
     "The operation associated with this event.")))

(def-meta-assoc "A_operation_receiveOperationEvent"      
  :name |A_operation_receiveOperationEvent|      
  :metatype :association      
  :member-ends ((|ReceiveOperationEvent| "operation")
                ("A_operation_receiveOperationEvent-receiveOperationEvent" "receiveOperationEvent"))      
  :owned-ends  (("A_operation_receiveOperationEvent-receiveOperationEvent" "receiveOperationEvent")))

(def-meta-assoc-end "A_operation_receiveOperationEvent-receiveOperationEvent" 
    :type |ReceiveOperationEvent| 
    :multiplicity (0 -1) 
    :association "A_operation_receiveOperationEvent" 
    :name "receiveOperationEvent")

;;; =========================================================
;;; ====================== ReceiveSignalEvent
;;; =========================================================
(def-meta-class |ReceiveSignalEvent| 
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReceiveSignalEvent")
 "A receive signal event specifies the event of receiving a signal by the
  target entity."
  ((|signal| :xmi-id "ReceiveSignalEvent-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The signal associated with this event.")))

(def-meta-assoc "A_signal_receiveSignalEvent"      
  :name |A_signal_receiveSignalEvent|      
  :metatype :association      
  :member-ends ((|ReceiveSignalEvent| "signal")
                ("A_signal_receiveSignalEvent-receiveSignalEvent" "receiveSignalEvent"))      
  :owned-ends  (("A_signal_receiveSignalEvent-receiveSignalEvent" "receiveSignalEvent")))

(def-meta-assoc-end "A_signal_receiveSignalEvent-receiveSignalEvent" 
    :type |ReceiveSignalEvent| 
    :multiplicity (0 -1) 
    :association "A_signal_receiveSignalEvent" 
    :name "receiveSignalEvent")

;;; =========================================================
;;; ====================== Reception
;;; =========================================================
(def-meta-class |Reception| 
   (:model :UML4SYSML12 :superclasses (|BehavioralFeature|) 
    :packages (|UML4SysML|) 
    :xmi-id "Reception")
 "A reception is a declaration stating that a classifier is prepared to react
  to the receipt of a signal. A reception designates a signal and specifies
  the expected behavioral response. The details of handling a signal are
  specified by the behavior associated with the reception or the classifier
  itself."
  ((|signal| :xmi-id "Reception-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The signal that this reception handles.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReclassifyObjectAction")
 "A reclassify object action is an action that changes which classifiers
  classify an object."
  ((|isReplaceAll| :xmi-id "ReclassifyObjectAction-isReplaceAll"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether existing classifiers should be removed before adding
      the new classifiers.")
   (|newClassifier| :xmi-id "ReclassifyObjectAction-newClassifier"
    :range |Classifier| :multiplicity (0 -1)
    :documentation
     "A set of classifiers to be added to the classifiers of the object.")
   (|object| :xmi-id "ReclassifyObjectAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Holds the object to be reclassified.")
   (|oldClassifier| :xmi-id "ReclassifyObjectAction-oldClassifier"
    :range |Classifier| :multiplicity (0 -1)
    :documentation
     "A set of classifiers to be removed from the classifiers of the object.")))

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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "RedefinableElement")
 "A redefinable element is an element that, when defined in the context of
  a classifier, can be redefined more specifically or differently in the
  context of another classifier that specializes (directly or indirectly)
  the context classifier."
  ((|isLeaf| :xmi-id "RedefinableElement-isLeaf"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Indicates whether it is possible to further redefine a RedefinableElement.
      If the value is true, then it is not possible to further redefine the RedefinableElement.
      Note that this property is preserved through package merge operations;
      that is, the capability to redefine a RedefinableElement (i.e., isLeaf=false)
      must be preserved in the resulting RedefinableElement of a package merge
      operation where a RedefinableElement with isLeaf=false is merged with a
      matching RedefinableElement with isLeaf=true: the resulting RedefinableElement
      will have isLeaf=false. Default value is false.")
   (|redefinedElement| :xmi-id "RedefinableElement-redefinedElement"
    :range |RedefinableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "The redefinable element that is being redefined by this element.")
   (|redefinitionContext| :xmi-id "RedefinableElement-redefinitionContext"
    :range |Classifier| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :documentation
     "References the contexts that this element may be redefined from.")))

(def-meta-operation "isConsistentWith" |RedefinableElement| 
   "The query isConsistentWith() specifies, for any two RedefinableElements
    in a context in which redefinition is possible, whether redefinition would
    be logically consistent. By default, this is false; this operation must
    be overridden for subclasses of RedefinableElement to define the consistency
    conditions."
   :operation-body
   "result = false"
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
   "result = redefinitionContext->exists(c | c.allParents()->includes(redefined.redefinitionContext)))"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|RedefinableElement|
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
;;; ====================== ReduceAction
;;; =========================================================
(def-meta-class |ReduceAction| 
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReduceAction")
 "A reduce action is an action that reduces a collection to a single value
  by combining the elements of the collection."
  ((|collection| :xmi-id "ReduceAction-collection"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The collection to be reduced.")
   (|isOrdered| :xmi-id "ReduceAction-isOrdered"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Tells whether the order of the input collection should determine the order
      in which the behavior is applied to its elements.")
   (|reducer| :xmi-id "ReduceAction-reducer"
    :range |Behavior| :multiplicity (1 1)
    :documentation
     "Behavior that is applied to two elements of the input collection to produce
      a value that is the same type as elements of the collection.")
   (|result| :xmi-id "ReduceAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")))

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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "Region")
 "A region is an orthogonal part of either a composite state or a state machine.
  It contains states and transitions."
  ((|extendedRegion| :xmi-id "Region-extendedRegion"
    :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The region of which this region is an extension.")
   (|redefinitionContext| :xmi-id "Region-redefinitionContext"
    :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|state| :xmi-id "Region-state"
    :range |State| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|State| |region|)
    :documentation
     "The State that owns the Region. If a Region is owned by a State, then it
      cannot also be owned by a StateMachine.")
   (|stateMachine| :xmi-id "Region-stateMachine"
    :range |StateMachine| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StateMachine| |region|)
    :documentation
     "The StateMachine that owns the Region. If a Region is owned by a StateMachine,
      then it cannot also be owned by a State.")
   (|subvertex| :xmi-id "Region-subvertex"
    :range |Vertex| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Vertex| |container|)
    :documentation
     "The set of vertices that are owned by this region.")
   (|transition| :xmi-id "Region-transition"
    :range |Transition| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Transition| |container|)
    :documentation
     "The set of transitions owned by the region.")))

(def-meta-operation "containingStateMachine" |Region| 
   "The operation containingStateMachine() returns the sate machine in which
    this Region is defined"
   :operation-body
   "result = if stateMachine->isEmpty()  then state.containingStateMachine() else stateMachine endif"
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
   "result = true"
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
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|Region|
                        :parameter-return-p NIL))
)

(def-meta-operation "redefinitionContext.1" |Region| 
   "The redefinition context of a region is the nearest containing statemachine"
   :operation-body
   "result = let sm = containingStateMachine() in if sm.context->isEmpty() or sm.general->notEmpty() then sm else sm.context endif"
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
    :multiplicity (0 1) 
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
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "Relationship")
 "Relationship is an abstract concept that specifies some kind of relationship
  between elements."
  ((|relatedElement| :xmi-id "Relationship-relatedElement"
    :range |Element| :multiplicity (1 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
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
   (:model :UML4SYSML12 :superclasses (|WriteStructuralFeatureAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "RemoveStructuralFeatureValueAction")
 "A remove structural feature value action is a write structural feature
  action that removes values from structural features."
  ((|isRemoveDuplicates| :xmi-id "RemoveStructuralFeatureValueAction-isRemoveDuplicates"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique structural
      features.")
   (|removeAt| :xmi-id "RemoveStructuralFeatureValueAction-removeAt"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Specifies the position of an existing value to remove in ordered nonunique
      structural features. The type of the pin is UnlimitedNatural, but the value
      cannot be zero or unlimited.")))

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
   (:model :UML4SYSML12 :superclasses (|WriteVariableAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "RemoveVariableValueAction")
 "A remove variable value action is a write variable action that removes
  values from variables."
  ((|isRemoveDuplicates| :xmi-id "RemoveVariableValueAction-isRemoveDuplicates"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether to remove duplicates of the value in nonunique variables.")
   (|removeAt| :xmi-id "RemoveVariableValueAction-removeAt"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Specifies the position of an existing value to remove in ordered nonunique
      variables. The type of the pin is UnlimitedNatural, but the value cannot
      be zero or unlimited.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ReplyAction")
 "A reply action is an action that accepts a set of return values and a value
  containing return information produced by a previous accept call action.
  The reply action returns the values to the caller of the previous call,
  completing execution of the call."
  ((|replyToCall| :xmi-id "ReplyAction-replyToCall"
    :range |Trigger| :multiplicity (1 1)
    :documentation
     "The trigger specifying the operation whose call is being replied to.")
   (|replyValue| :xmi-id "ReplyAction-replyValue"
    :range |InputPin| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "A list of pins containing the reply values of the operation. These values
      are returned to the caller.")
   (|returnInformation| :xmi-id "ReplyAction-returnInformation"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "A pin containing the return information value produced by an earlier AcceptCallAction.")))

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
   (:model :UML4SYSML12 :superclasses (|InvocationAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "SendObjectAction")
 "A send object action is an action that transmits an object to the target
  object, where it may invoke behavior such as the firing of state machine
  transitions or the execution of an activity. The value of the object is
  available to the execution of invoked behaviors. The requestor continues
  execution immediately. Any reply message is ignored and is not transmitted
  to the requestor."
  ((|request| :xmi-id "SendObjectAction-request"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The request object, which is transmitted to the target object. The object
      may be copied in transmission, so identity might not be preserved." :redefined-property (|InvocationAction| |argument|))
   (|target| :xmi-id "SendObjectAction-target"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
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
;;; ====================== SendOperationEvent
;;; =========================================================
(def-meta-class |SendOperationEvent| 
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "SendOperationEvent")
 "A send operation event models the invocation of an operation call."
  ((|operation| :xmi-id "SendOperationEvent-operation"
    :range |Operation| :multiplicity (1 1)
    :documentation
     "The operation associated with this event.")))

(def-meta-assoc "A_operation_sendOperationEvent"      
  :name |A_operation_sendOperationEvent|      
  :metatype :association      
  :member-ends ((|SendOperationEvent| "operation")
                ("A_operation_sendOperationEvent-sendOperationEvent" "sendOperationEvent"))      
  :owned-ends  (("A_operation_sendOperationEvent-sendOperationEvent" "sendOperationEvent")))

(def-meta-assoc-end "A_operation_sendOperationEvent-sendOperationEvent" 
    :type |SendOperationEvent| 
    :multiplicity (0 -1) 
    :association "A_operation_sendOperationEvent" 
    :name "sendOperationEvent")

;;; =========================================================
;;; ====================== SendSignalAction
;;; =========================================================
(def-meta-class |SendSignalAction| 
   (:model :UML4SYSML12 :superclasses (|InvocationAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "SendSignalAction")
 "A send signal action is an action that creates a signal instance from its
  inputs, and transmits it to the target object, where it may cause the firing
  of a state machine transition or the execution of an activity. The argument
  values are available to the execution of associated behaviors. The requestor
  continues execution immediately. Any reply message is ignored and is not
  transmitted to the requestor. If the input is already a signal instance,
  use a send object action."
  ((|signal| :xmi-id "SendSignalAction-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The type of signal transmitted to the target object.")
   (|target| :xmi-id "SendSignalAction-target"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The target object to which the signal is sent.")))

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
;;; ====================== SendSignalEvent
;;; =========================================================
(def-meta-class |SendSignalEvent| 
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "SendSignalEvent")
 "A send signal event models the sending of a signal."
  ((|signal| :xmi-id "SendSignalEvent-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The signal associated with this event.")))

(def-meta-assoc "A_signal_sendSignalEvent"      
  :name |A_signal_sendSignalEvent|      
  :metatype :association      
  :member-ends ((|SendSignalEvent| "signal")
                ("A_signal_sendSignalEvent-sendSignalEvent" "sendSignalEvent"))      
  :owned-ends  (("A_signal_sendSignalEvent-sendSignalEvent" "sendSignalEvent")))

(def-meta-assoc-end "A_signal_sendSignalEvent-sendSignalEvent" 
    :type |SendSignalEvent| 
    :multiplicity (0 -1) 
    :association "A_signal_sendSignalEvent" 
    :name "sendSignalEvent")

;;; =========================================================
;;; ====================== SequenceNode
;;; =========================================================
(def-meta-class |SequenceNode| 
   (:model :UML4SYSML12 :superclasses (|StructuredActivityNode|) 
    :packages (|UML4SysML|) 
    :xmi-id "SequenceNode")
 "A sequence node is a structured activity node that executes its actions
  in order."
  ((|executableNode| :xmi-id "SequenceNode-executableNode"
    :range |ExecutableNode| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :documentation
     "An ordered set of executable nodes." :redefined-property (|StructuredActivityNode| |node|))))

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
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "Signal")
 "A signal is a specification of send request instances communicated between
  objects. The receiving object handles the received request instances as
  specified by its receptions. The data carried by a send request (which
  was passed to it by the send invocation occurrence that caused that request)
  are represented as attributes of the signal. A signal is defined independently
  of the classifiers handling the signal occurrence."
  ((|ownedAttribute| :xmi-id "Signal-ownedAttribute"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|))
    :documentation
     "The attributes owned by the signal.")))

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
   (:model :UML4SYSML12 :superclasses (|MessageEvent|) 
    :packages (|UML4SysML|) 
    :xmi-id "SignalEvent")
 "A signal event represents the receipt of an asynchronous signal instance.
  A signal event may, for example, cause a state machine to trigger a transition."
  ((|signal| :xmi-id "SignalEvent-signal"
    :range |Signal| :multiplicity (1 1)
    :documentation
     "The specific signal that is associated with this event.")))

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
   (:model :UML4SYSML12 :superclasses (|Element|) 
    :packages (|UML4SysML|) 
    :xmi-id "Slot")
 "A slot specifies that an entity modeled by an instance specification has
  a value or values for a specific structural feature."
  ((|definingFeature| :xmi-id "Slot-definingFeature"
    :range |StructuralFeature| :multiplicity (1 1)
    :documentation
     "The structural feature that specifies the values that may be held by the
      slot.")
   (|owningInstance| :xmi-id "Slot-owningInstance"
    :range |InstanceSpecification| :multiplicity (1 1)
    :subsetted-properties ((|Element| |owner|))
    :opposite (|InstanceSpecification| |slot|)
    :documentation
     "The instance specification that owns this slot.")
   (|value| :xmi-id "Slot-value"
    :range |ValueSpecification| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "The value or values corresponding to the defining feature for the owning
      instance specification.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "StartClassifierBehaviorAction")
 "A start classifier behavior action is an action that starts the classifier
  behavior of the input."
  ((|object| :xmi-id "StartClassifierBehaviorAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Holds the object on which to start the owned behavior.")))

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
   (:model :UML4SYSML12 :superclasses (|CallAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "StartObjectBehaviorAction")
 "StartObjectBehaviorAction is an action that starts the execution either
  of a directly instantiated behavior or of the classifier behavior of an
  object. Argument values may be supplied for the input parameters of the
  behavior. If the behavior is invoked synchronously, then output values
  may be obtained for output parameters."
  ((|object| :xmi-id "StartObjectBehaviorAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Holds the object which is either a behavior to be started or has a classifier
      behavior to be started.")))

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
   (:model :UML4SYSML12 :superclasses (|Vertex| |RedefinableElement| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "State")
 "A state models a situation during which some (usually implicit) invariant
  condition holds."
  ((|connection| :xmi-id "State-connection"
    :range |ConnectionPointReference| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ConnectionPointReference| |state|)
    :documentation
     "The entry and exit connection points used in conjunction with this (submachine)
      state, i.e. as targets and sources, respectively, in the region with the
      submachine state. A connection point reference references the corresponding
      definition of a connection point pseudostate in the statemachine referenced
      by the submachinestate.")
   (|connectionPoint| :xmi-id "State-connectionPoint"
    :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :opposite (|Pseudostate| |state|)
    :documentation
     "The entry and exit pseudostates of a composite state. These can only be
      entry or exit Pseudostates, and they must have different names. They can
      only be defined for composite states.")
   (|deferrableTrigger| :xmi-id "State-deferrableTrigger"
    :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "A list of triggers that are candidates to be retained by the state machine
      if they trigger no transitions out of the state (not consumed). A deferred
      trigger is retained until the state machine reaches a state configuration
      where it is no longer deferred.")
   (|doActivity| :xmi-id "State-doActivity"
    :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional behavior that is executed while being in the state. The execution
      starts when this state is entered, and stops either by itself, or when
      the state is exited, whichever comes first.")
   (|entry| :xmi-id "State-entry"
    :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional behavior that is executed whenever this state is entered regardless
      of the transition taken to reach the state. If defined, entry actions are
      always executed to completion prior to any internal behavior or transitions
      performed within the state.")
   (|exit| :xmi-id "State-exit"
    :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "An optional behavior that is executed whenever this state is exited regardless
      of which transition was taken out of the state. If defined, exit actions
      are always executed to completion only after all internal activities and
      transition actions have completed execution.")
   (|isComposite| :xmi-id "State-isComposite"
    :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isComposite=true is said to be a composite state. A composite
      state is a state that contains at least one region.")
   (|isOrthogonal| :xmi-id "State-isOrthogonal"
    :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isOrthogonal=true is said to be an orthogonal composite state.
      An orthogonal composite state contains two or more regions.")
   (|isSimple| :xmi-id "State-isSimple"
    :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :true
    :documentation
     "A state with isSimple=true is said to be a simple state. A simple state
      does not have any regions and it does not refer to any submachine state
      machine.")
   (|isSubmachineState| :xmi-id "State-isSubmachineState"
    :range |Boolean| :multiplicity (1 1) :is-readonly-p T :is-derived-p T :default :false
    :documentation
     "A state with isSubmachineState=true is said to be a submachine state. Such
      a state refers to a state machine (submachine).")
   (|redefinedState| :xmi-id "State-redefinedState"
    :range |State| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The state of which this state is a redefinition.")
   (|redefinitionContext| :xmi-id "State-redefinitionContext"
    :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|region| :xmi-id "State-region"
    :range |Region| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |state|)
    :documentation
     "The regions owned directly by the state.")
   (|stateInvariant| :xmi-id "State-stateInvariant"
    :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies conditions that are always true when this state is the current
      state. In protocol state machines, state invariants are additional conditions
      to the preconditions of the outgoing transitions, and to the postcondition
      of the incoming transitions.")
   (|submachine| :xmi-id "State-submachine"
    :range |StateMachine| :multiplicity (0 1)
    :opposite (|StateMachine| |submachineState|)
    :documentation
     "The state machine that is to be inserted in place of the (submachine) state.")))

(def-meta-operation "containingStateMachine" |State| 
   "The query containingStateMachine() returns the state machine that contains
    the state either directly or transitively."
   :operation-body
   "result = container.containingStateMachine()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "isComposite.1" |State| 
   "A composite state is a state with at least one region."
   :operation-body
   "result = region.notEmpty()"
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
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "isOrthogonal.1" |State| 
   "An orthogonal state is a composite state with at least 2 regions"
   :operation-body
   "result = (region->size () > 1)"
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
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-meta-operation "isSimple.1" |State| 
   "A simple state is a state without any regions."
   :operation-body
   "result = region.isEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isSubmachineState.1" |State| 
   "Only submachine states can have a reference statemachine."
   :operation-body
   "result = submachine.notEmpty()"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "redefinitionContext.1" |State| 
   "The redefinition context of a state is the nearest containing statemachine."
   :operation-body
   "result = let sm = containingStateMachine() in if sm.context->isEmpty() or sm.general->notEmpty() then sm else sm.context endif"
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
    :multiplicity (0 1) 
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
   (:model :UML4SYSML12 :superclasses (|InteractionFragment|) 
    :packages (|UML4SysML|) 
    :xmi-id "StateInvariant")
 "A state invariant is a runtime constraint on the participants of the interaction.
  It may be used to specify a variety of different kinds of constraints,
  such as values of attributes or variables, internal or external states,
  and so on. A state invariant is an interaction fragment and it is placed
  on a lifeline."
  ((|covered| :xmi-id "StateInvariant-covered"
    :range |Lifeline| :multiplicity (1 1)
    :documentation
     "References the Lifeline on which the StateInvariant appears." :redefined-property (|InteractionFragment| |covered|))
   (|invariant| :xmi-id "StateInvariant-invariant"
    :range |Constraint| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "A Constraint that should hold at runtime for this StateInvariant")))

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
   (:model :UML4SYSML12 :superclasses (|Behavior|) 
    :packages (|UML4SysML|) 
    :xmi-id "StateMachine")
 "State machines can be used to express the behavior of part of a system.
  Behavior is modeled as a traversal of a graph of state nodes interconnected
  by one or more joined transition arcs that are triggered by the dispatching
  of series of (event) occurrences. During this traversal, the state machine
  executes a series of activities associated with various elements of the
  state machine."
  ((|connectionPoint| :xmi-id "StateMachine-connectionPoint"
    :range |Pseudostate| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Pseudostate| |stateMachine|)
    :documentation
     "The connection points defined for this state machine. They represent the
      interface of the state machine when used as part of submachine state.")
   (|extendedStateMachine| :xmi-id "StateMachine-extendedStateMachine"
    :range |StateMachine| :multiplicity (0 -1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The state machines of which this is an extension.")
   (|region| :xmi-id "StateMachine-region"
    :range |Region| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Region| |stateMachine|)
    :documentation
     "The regions owned directly by the state machine.")
   (|submachineState| :xmi-id "StateMachine-submachineState"
    :range |State| :multiplicity (0 -1)
    :opposite (|State| |submachine|)
    :documentation
     "References the submachine(s) in case of a submachine state. Multiple machines
      are referenced in case of a concurrent state.")))

(def-meta-operation "LCA" |StateMachine| 
   "The operation LCA(s1,s2) returns an orthogonal state or region which is
    the least common ancestor of states s1 and s2, based on the statemachine
    containment hierarchy."
   :operation-body
   "true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Namespace|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|s1| :parameter-type '|State|
                        :parameter-return-p NIL)
          (make-instance 'ocl-parameter :parameter-name '|s2| :parameter-type '|State|
                        :parameter-return-p NIL))
)

(def-meta-operation "ancestor" |StateMachine| 
   "The query ancestor(s1, s2) checks whether s1 is an ancestor state of state
    s2."
   :operation-body
   "result =   if (s2 = s1) then    true   else    if (s2.container->isEmpty() or not s2.container.owner.oclIsKindOf(State)) then     false    else     ancestor(s1, s2.container.owner.oclAsType(State))   endif  endif   "
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
   "result = true"
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
   "result = true"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefined| :parameter-type '|StateMachine|
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
    :multiplicity (0 1) 
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
   (:model :UML4SYSML12 :superclasses (|Class|) 
    :packages (|UML4SysML|) 
    :xmi-id "Stereotype")
 "A stereotype defines how an existing metaclass may be extended, and enables
  the use of platform or domain specific terminology or notation in place
  of, or in addition to, the ones used for the extended metaclass."
  ((|icon| :xmi-id "Stereotype-icon"
    :range |Image| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "Stereotype can change the graphical appearance of the extended model element
      by using attached icons. When this association is not null, it references
      the location of the icon content to be displayed within diagrams presenting
      the extended model elements.")
   (|profile| :xmi-id "Stereotype-profile"
    :range |Profile| :multiplicity (1 1) :is-derived-p T
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
   "result = self.containingProfile()"
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
;;; ====================== StructuralFeature
;;; =========================================================
(def-meta-class |StructuralFeature| 
   (:model :UML4SYSML12 :superclasses (|Feature| |TypedElement| |MultiplicityElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "StructuralFeature")
 "A structural feature is a typed feature of a classifier that specifies
  the structure of instances of the classifier.By specializing multiplicity
  element, it supports a multiplicity that specifies valid cardinalities
  for the collection of values associated with an instantiation of the structural
  feature."
  ((|isReadOnly| :xmi-id "StructuralFeature-isReadOnly"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "States whether the feature's value may be modified by a client.")))

;;; =========================================================
;;; ====================== StructuralFeatureAction
;;; =========================================================
(def-meta-class |StructuralFeatureAction| 
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "StructuralFeatureAction")
 "StructuralFeatureAction is an abstract class for all structural feature
  actions."
  ((|object| :xmi-id "StructuralFeatureAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the input pin from which the object whose structural feature is to
      be read or written is obtained.")
   (|structuralFeature| :xmi-id "StructuralFeatureAction-structuralFeature"
    :range |StructuralFeature| :multiplicity (1 1)
    :documentation
     "Structural feature to be read.")))

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
   (:model :UML4SYSML12 :superclasses (|ActivityGroup| |ExecutableNode| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "StructuredActivityNode")
 "A structured activity node is an executable activity node that may have
  an expansion into subordinate nodes as an activity group. The subordinate
  nodes must belong to only one structured activity node, although they may
  be nested."
  ((|activity| :xmi-id "StructuredActivityNode-activity"
    :range |Activity| :multiplicity (0 1)
    :opposite (|Activity| |structuredNode|)
    :documentation
     "Activity immediately containing the node." :redefined-property (|ActivityNode| |activity|))
   (|node| :xmi-id "StructuredActivityNode-node"
    :range |ActivityNode| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|ActivityGroup| |containedNode|))
    :opposite (|ActivityNode| |inStructuredNode|)
    :documentation
     "Nodes immediately contained in the group.")
   (|variable| :xmi-id "StructuredActivityNode-variable"
    :range |Variable| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Variable| |scope|)
    :documentation
     "A variable defined in the scope of the structured activity node. It has
      no value and may not be accessed")))

(def-meta-assoc "A_node_inStructuredNode"      
  :name |A_node_inStructuredNode|      
  :metatype :association      
  :member-ends ((|StructuredActivityNode| "node")
                (|ActivityNode| "inStructuredNode"))      
  :owned-ends  ())

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
   (:model :UML4SYSML12 :superclasses (|Classifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "StructuredClassifier")
 "A structured classifier is an abstract metaclass that represents any classifier
  whose behavior can be fully or partly described by the collaboration of
  owned or referenced instances."
  ((|ownedAttribute| :xmi-id "StructuredClassifier-ownedAttribute"
    :range |Property| :multiplicity (0 -1) :is-composite-p T :is-ordered-p T
    :subsetted-properties ((|Classifier| |attribute|) (|Namespace| |ownedMember|) (|StructuredClassifier| |role|))
    :documentation
     "References the properties owned by the classifier.")
   (|ownedConnector| :xmi-id "StructuredClassifier-ownedConnector"
    :range |Connector| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Classifier| |feature|) (|Namespace| |ownedMember|))
    :documentation
     "References the connectors owned by the classifier.")
   (|part| :xmi-id "StructuredClassifier-part"
    :range |Property| :multiplicity (0 -1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the properties specifying instances that the classifier owns
      by composition. This association is derived, selecting those owned properties
      where isComposite is true.")
   (|role| :xmi-id "StructuredClassifier-role"
    :range |ConnectableElement| :multiplicity (0 -1) :is-derived-union-p T :is-readonly-p T :is-derived-p T
    :subsetted-properties ((|Namespace| |member|))
    :documentation
     "References the roles that instances may play in this classifier.")))

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
   (:model :UML4SYSML12 :superclasses (|Realization|) 
    :packages (|UML4SysML|) 
    :xmi-id "Substitution")
 "A substitution is a relationship between two classifiers signifies that
  the substituting classifier complies with the contract specified by the
  contract classifier. This implies that instances of the substituting classifier
  are runtime substitutable where instances of the contract classifier are
  expected."
  ((|contract| :xmi-id "Substitution-contract"
    :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |supplier|))
    :documentation
     "The contract with which the substituting classifier complies.")
   (|substitutingClassifier| :xmi-id "Substitution-substitutingClassifier"
    :range |Classifier| :multiplicity (1 1)
    :subsetted-properties ((|Dependency| |client|))
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
;;; ====================== TestIdentityAction
;;; =========================================================
(def-meta-class |TestIdentityAction| 
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "TestIdentityAction")
 "A test identity action is an action that tests if two values are identical
  objects."
  ((|first| :xmi-id "TestIdentityAction-first"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the pin on which an object is placed.")
   (|result| :xmi-id "TestIdentityAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Tells whether the two input objects are identical.")
   (|second| :xmi-id "TestIdentityAction-second"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Gives the pin on which an object is placed.")))

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
   (:model :UML4SYSML12 :superclasses (|IntervalConstraint|) 
    :packages (|UML4SysML|) 
    :xmi-id "TimeConstraint")
 "A time constraint is a constraint that refers to a time interval."
  ((|firstEvent| :xmi-id "TimeConstraint-firstEvent"
    :range |Boolean| :multiplicity (0 1) :default :true
    :documentation
     "The value of firstEvent is related to constrainedElement. If firstEvent
      is true, then the corresponding observation event is the first time instant
      the execution enters constrainedElement. If firstEvent is false, then the
      corresponding observation event is the last time instant the execution
      is within constrainedElement.")
   (|specification| :xmi-id "TimeConstraint-specification"
    :range |TimeInterval| :multiplicity (1 1) :is-composite-p T
    :documentation
     "A condition that must be true when evaluated in order for the constraint
      to be satisfied." :redefined-property (|IntervalConstraint| |specification|))))

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
   (:model :UML4SYSML12 :superclasses (|Event|) 
    :packages (|UML4SysML|) 
    :xmi-id "TimeEvent")
 "A time event specifies a point in time. At the specified time, the event
  occurs.A time event can be defined relative to entering the current state
  of the executing state machine."
  ((|isRelative| :xmi-id "TimeEvent-isRelative"
    :range |Boolean| :multiplicity (1 1) :default :false
    :documentation
     "Specifies whether it is relative or absolute time.")
   (|when| :xmi-id "TimeEvent-when"
    :range |TimeExpression| :multiplicity (1 1) :is-composite-p T
    :documentation
     "Specifies the corresponding time deadline.")))

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
   (:model :UML4SYSML12 :superclasses (|ValueSpecification|) 
    :packages (|UML4SysML|) 
    :xmi-id "TimeExpression")
 "A time expression defines a value specification that represents a time
  value."
  ((|expr| :xmi-id "TimeExpression-expr"
    :range |ValueSpecification| :multiplicity (0 1) :is-composite-p T
    :documentation
     "The value of the time expression.")
   (|observation| :xmi-id "TimeExpression-observation"
    :range |Observation| :multiplicity (0 -1)
    :documentation
     "Refers to the time and duration observations that are involved in expr.")))

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
   (:model :UML4SYSML12 :superclasses (|Interval|) 
    :packages (|UML4SysML|) 
    :xmi-id "TimeInterval")
 "A time interval defines the range between two time expressions."
  ((|max| :xmi-id "TimeInterval-max"
    :range |TimeExpression| :multiplicity (1 1)
    :documentation
     "Refers to the TimeExpression denoting the maximum value of the range." :redefined-property (|Interval| |max|))
   (|min| :xmi-id "TimeInterval-min"
    :range |TimeExpression| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|Observation|) 
    :packages (|UML4SysML|) 
    :xmi-id "TimeObservation")
 "A time observation is a reference to a time instant during an execution.
  It points out the element in the model to observe and whether the observation
  is when this model element is entered or when it is exited."
  ((|event| :xmi-id "TimeObservation-event"
    :range |NamedElement| :multiplicity (1 1)
    :documentation
     "The observation is determined by the entering or exiting of the event element
      during execution.")
   (|firstEvent| :xmi-id "TimeObservation-firstEvent"
    :range |Boolean| :multiplicity (1 1) :default :true
    :documentation
     "The value of firstEvent is related to event. If firstEvent is true, then
      the corresponding observation event is the first time instant the execution
      enters event. If firstEvent is false, then the corresponding observation
      event is the time instant the execution exits event.")))

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
   (:model :UML4SYSML12 :superclasses (|RedefinableElement| |Namespace|) 
    :packages (|UML4SysML|) 
    :xmi-id "Transition")
 "A transition is a directed relationship between a source vertex and a target
  vertex. It may be part of a compound transition, which takes the state
  machine from one state configuration to another, representing the complete
  response of the state machine to an occurrence of an event of a particular
  type."
  ((|container| :xmi-id "Transition-container"
    :range |Region| :multiplicity (1 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |transition|)
    :documentation
     "Designates the region that owns this transition.")
   (|effect| :xmi-id "Transition-effect"
    :range |Behavior| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Element| |ownedElement|))
    :documentation
     "Specifies an optional behavior to be performed when the transition fires.")
   (|guard| :xmi-id "Transition-guard"
    :range |Constraint| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedRule|))
    :documentation
     "A guard is a constraint that provides a fine-grained control over the firing
      of the transition. The guard is evaluated when an event occurrence is dispatched
      by the state machine. If the guard is true at that time, the transition
      may be enabled, otherwise, it is disabled. Guards should be pure expressions
      without side effects. Guard expressions with side effects are ill formed.")
   (|kind| :xmi-id "Transition-kind"
    :range |TransitionKind| :multiplicity (1 1) :default :external
    :documentation
     "Indicates  the precise type of the transition.")
   (|redefinedTransition| :xmi-id "Transition-redefinedTransition"
    :range |Transition| :multiplicity (0 1)
    :subsetted-properties ((|RedefinableElement| |redefinedElement|))
    :documentation
     "The transition that is redefined by this transition.")
   (|redefinitionContext| :xmi-id "Transition-redefinitionContext"
    :range |Classifier| :multiplicity (1 1) :is-readonly-p T :is-derived-p T
    :documentation
     "References the classifier in which context this element may be redefined." :redefined-property (|RedefinableElement| |redefinitionContext|))
   (|source| :xmi-id "Transition-source"
    :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |outgoing|)
    :documentation
     "Designates the originating vertex (state or pseudostate) of the transition.")
   (|target| :xmi-id "Transition-target"
    :range |Vertex| :multiplicity (1 1)
    :opposite (|Vertex| |incoming|)
    :documentation
     "Designates the target vertex that is reached when the transition is taken.")
   (|trigger| :xmi-id "Transition-trigger"
    :range |Trigger| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "Specifies the triggers that may fire the transition.")))

(def-meta-operation "containingStateMachine" |Transition| 
   "The query containingStateMachine() returns the state machine that contains
    the transition either directly or transitively."
   :operation-body
   "result = container.containingStateMachine()"
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
   "result = (redefinee.oclIsKindOf(Transition) and    let trans: Transition = redefinee.oclAsType(Transition) in      (source() = trans.source() and trigger() = tran.trigger())"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T)
          (make-instance 'ocl-parameter :parameter-name '|redefinee| :parameter-type '|RedefinableElement|
                        :parameter-return-p NIL))
)

(def-meta-operation "redefinitionContext.1" |Transition| 
   "The redefinition context of a transition is the nearest containing statemachine."
   :operation-body
   "result = let sm = containingStateMachine() in if sm.context->isEmpty() or sm.general->notEmpty() then sm else sm.context endif"
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
    :multiplicity (0 1) 
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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Trigger")
 "A trigger relates an event to a behavior that may affect an instance of
  the classifier.A trigger specification may be qualified by the port on
  which the event occurred."
  ((|event| :xmi-id "Trigger-event"
    :range |Event| :multiplicity (1 1)
    :documentation
     "The event that causes the trigger.")
   (|port| :xmi-id "Trigger-port"
    :range |Port| :multiplicity (0 -1)
    :documentation
     "A optional port of the receiver object on which the behavioral feature
      is invoked.")))

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
   (:model :UML4SYSML12 :superclasses (|PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Type")
 "A type is a named element that is used as the type for a typed element.
  A type can be contained in a package.A type constrains the values represented
  by a typed element."
  ((|package| :xmi-id "Type-package"
    :range |Package| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Package| |ownedType|)
    :documentation
     "Specifies the owning package of this classifier, if any.")))

(def-meta-operation "conformsTo" |Type| 
   "The query conformsTo() gives true for a type that conforms to another.
    By default, two types do not conform to each other. This query is intended
    to be redefined for specific conformance situations."
   :operation-body
   "result = false"
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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "TypedElement")
 "A typed element is a kind of named element that represents an element with
  a type.A typed element has a type."
  ((|type| :xmi-id "TypedElement-type"
    :range |Type| :multiplicity (0 1)
    :documentation
     "This information is derived from the return result for this Operation.
      The type of the TypedElement.")))

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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "UnmarshallAction")
 "An unmarshall action is an action that breaks an object of a known type
  into outputs each of which is equal to a value from a structural feature
  of the object."
  ((|object| :xmi-id "UnmarshallAction-object"
    :range |InputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "The object to be unmarshalled.")
   (|result| :xmi-id "UnmarshallAction-result"
    :range |OutputPin| :multiplicity (1 -1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "The values of the structural features of the input object.")
   (|unmarshallType| :xmi-id "UnmarshallAction-unmarshallType"
    :range |Classifier| :multiplicity (1 1)
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
   (:model :UML4SYSML12 :superclasses (|Dependency|) 
    :packages (|UML4SysML|) 
    :xmi-id "Usage")
 "A usage is a relationship in which one element requires another element
  (or set of elements) for its full implementation or operation. A usage
  is a dependency in which the client requires the presence of the supplier."
  ())

;;; =========================================================
;;; ====================== UseCase
;;; =========================================================
(def-meta-class |UseCase| 
   (:model :UML4SYSML12 :superclasses (|BehavioredClassifier|) 
    :packages (|UML4SysML|) 
    :xmi-id "UseCase")
 "A use case is the specification of a set of actions performed by a system,
  which yields an observable result that is, typically, of value for one
  or more actors or other stakeholders of the system."
  ((|extend| :xmi-id "UseCase-extend"
    :range |Extend| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Extend| |extension|)
    :documentation
     "References the Extend relationships owned by this use case.")
   (|extensionPoint| :xmi-id "UseCase-extensionPoint"
    :range |ExtensionPoint| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|ExtensionPoint| |useCase|)
    :documentation
     "References the ExtensionPoints owned by the use case.")
   (|include| :xmi-id "UseCase-include"
    :range |Include| :multiplicity (0 -1) :is-composite-p T
    :subsetted-properties ((|Namespace| |ownedMember|))
    :opposite (|Include| |includingCase|)
    :documentation
     "References the Include relationships owned by this use case.")
   (|subject| :xmi-id "UseCase-subject"
    :range |Classifier| :multiplicity (0 -1)
    :opposite (|Classifier| |useCase|)
    :documentation
     "References the subjects to which this use case applies. The subject or
      its parts realize all the use cases that apply to this subject. Use cases
      need not be attached to any specific subject, however. The subject may,
      but need not, own the use cases that apply to it.")))

(def-meta-operation "allIncludedUseCases" |UseCase| 
   "The query allIncludedUseCases() returns the transitive closure of all use
    cases (directly or indirectly) included by this use case."
   :operation-body
   "result = self.include->union(self.include->collect(in | in.allIncludedUseCases()))"
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
   (:model :UML4SYSML12 :superclasses (|InputPin|) 
    :packages (|UML4SysML|) 
    :xmi-id "ValuePin")
 "A value pin is an input pin that provides a value by evaluating a value
  specification."
  ((|value| :xmi-id "ValuePin-value"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :documentation
     "Value that the pin will provide.")))

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
   (:model :UML4SYSML12 :superclasses (|TypedElement| |PackageableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "ValueSpecification")
 "A value specification is the specification of a (possibly empty) set of
  instances, including both objects and data values."
  ())

(def-meta-operation "booleanValue" |ValueSpecification| 
   "The query booleanValue() gives a single Boolean value when one can be computed."
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "integerValue" |ValueSpecification| 
   "The query integerValue() gives a single Integer value when one can be computed."
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Integer|
                        :parameter-return-p T))
)

(def-meta-operation "isComputable" |ValueSpecification| 
   "The query isComputable() determines whether a value specification can be
    computed in a model. This operation cannot be fully defined in OCL. A conforming
    implementation is expected to deliver true for this operation for all value
    specifications that it can compute, and to compute all of those for which
    the operation is true. A conforming implementation is expected to be able
    to compute the value of all literals."
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "isNull" |ValueSpecification| 
   "The query isNull() returns true when it can be computed that the value
    is null."
   :operation-body
   "result = false"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Boolean|
                        :parameter-return-p T))
)

(def-meta-operation "stringValue" |ValueSpecification| 
   "The query stringValue() gives a single String value when one can be computed."
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|String|
                        :parameter-return-p T))
)

(def-meta-operation "unlimitedValue" |ValueSpecification| 
   "The query unlimitedValue() gives a single UnlimitedNatural value when one
    can be computed."
   :operation-body
   "result = Set{}"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|UnlimitedNatural|
                        :parameter-return-p T))
)

;;; =========================================================
;;; ====================== ValueSpecificationAction
;;; =========================================================
(def-meta-class |ValueSpecificationAction| 
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "ValueSpecificationAction")
 "A value specification action is an action that evaluates a value specification."
  ((|result| :xmi-id "ValueSpecificationAction-result"
    :range |OutputPin| :multiplicity (1 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")
   (|value| :xmi-id "ValueSpecificationAction-value"
    :range |ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :documentation
     "Value specification to be evaluated.")))

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
   (:model :UML4SYSML12 :superclasses (|MultiplicityElement| |ConnectableElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Variable")
 "Variables are elements for passing data between actions indirectly. A local
  variable stores values shared by the actions within a structured activity
  group but not accessible outside it. The output of an action may be written
  to a variable and read for the input to a subsequent action, which is effectively
  an indirect data flow path. Because there is no predefined relationship
  between actions that read and write variables, these actions must be sequenced
  by control flows to prevent race conditions that may occur between actions
  that read or write the same variable.A variable is considered a connectable
  element."
  ((|activityScope| :xmi-id "Variable-activityScope"
    :range |Activity| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Activity| |variable|)
    :documentation
     "An activity that owns the variable.")
   (|scope| :xmi-id "Variable-scope"
    :range |StructuredActivityNode| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|StructuredActivityNode| |variable|)
    :documentation
     "A structured activity node that owns the variable.")))

(def-meta-operation "isAccessibleBy" |Variable| 
   "The isAccessibleBy() operation is not defined in standard UML. Implementations
    should define it to specify which actions can access a variable."
   :operation-body
   "result = true"
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
   (:model :UML4SYSML12 :superclasses (|Action|) 
    :packages (|UML4SysML|) 
    :xmi-id "VariableAction")
 "VariableAction is an abstract class for actions that operate on a statically
  specified variable."
  ((|variable| :xmi-id "VariableAction-variable"
    :range |Variable| :multiplicity (1 1)
    :documentation
     "Variable to be read.")))

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
   (:model :UML4SYSML12 :superclasses (|NamedElement|) 
    :packages (|UML4SysML|) 
    :xmi-id "Vertex")
 "A vertex is an abstraction of a node in a state machine graph. In general,
  it can be the source or destination of any number of transitions."
  ((|container| :xmi-id "Vertex-container"
    :range |Region| :multiplicity (0 1)
    :subsetted-properties ((|NamedElement| |namespace|))
    :opposite (|Region| |subvertex|)
    :documentation
     "The region that contains this vertex.")
   (|incoming| :xmi-id "Vertex-incoming"
    :range |Transition| :multiplicity (0 -1) :is-derived-p T
    :opposite (|Transition| |target|)
    :documentation
     "Specifies the transitions entering this vertex.")
   (|outgoing| :xmi-id "Vertex-outgoing"
    :range |Transition| :multiplicity (0 -1) :is-derived-p T
    :opposite (|Transition| |source|)
    :documentation
     "Specifies the transitions departing from this vertex.")))

(def-meta-operation "containingStateMachine" |Vertex| 
   "The operation containingStateMachine() returns the state machine in which
    this Vertex is defined"
   :operation-body
   "result = if not container->isEmpty() then -- the container is a region container.containingStateMachine() else if (oclIsKindOf(Pseudostate)) then -- entry or exit point? if (kind = #entryPoint) or (kind = #exitPoint) then stateMachine else if (oclIsKindOf(ConnectionPointReference)) then state.containingStateMachine() -- no other valid cases possible endif "
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|StateMachine|
                        :parameter-return-p T))
)

(def-meta-operation "incoming.1" |Vertex| 
   ""
   :operation-body
   "result = Transition.allInstances()->select(t | t.target=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-meta-operation "outgoing.1" |Vertex| 
   ""
   :operation-body
   "result = Transition.allInstances()->select(t | t.source=self)"
   :parameters
   (list (make-instance 'ocl-parameter :parameter-name NIL :parameter-type '|Transition|
                        :parameter-return-p T))
)

(def-meta-assoc "A_incoming_target"      
  :name |A_incoming_target|      
  :metatype :association      
  :member-ends ((|Vertex| "incoming")
                (|Transition| "target"))      
  :owned-ends  ())

(def-meta-assoc "A_outgoing_source.1"      
  :name |A_outgoing_source|      
  :metatype :association      
  :member-ends ((|Vertex| "outgoing")
                (|Transition| "source"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== WriteLinkAction
;;; =========================================================
(def-meta-class |WriteLinkAction| 
   (:model :UML4SYSML12 :superclasses (|LinkAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "WriteLinkAction")
 "WriteLinkAction is an abstract class for link actions that create and destroy
  links."
  ())

;;; =========================================================
;;; ====================== WriteStructuralFeatureAction
;;; =========================================================
(def-meta-class |WriteStructuralFeatureAction| 
   (:model :UML4SYSML12 :superclasses (|StructuralFeatureAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "WriteStructuralFeatureAction")
 "WriteStructuralFeatureAction is an abstract class for structural feature
  actions that change structural feature values."
  ((|result| :xmi-id "WriteStructuralFeatureAction-result"
    :range |OutputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |output|))
    :documentation
     "Gives the output pin on which the result is put.")
   (|value| :xmi-id "WriteStructuralFeatureAction-value"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Value to be added or removed from the structural feature.")))

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
   (:model :UML4SYSML12 :superclasses (|VariableAction|) 
    :packages (|UML4SysML|) 
    :xmi-id "WriteVariableAction")
 "WriteVariableAction is an abstract class for variable actions that change
  variable values."
  ((|value| :xmi-id "WriteVariableAction-value"
    :range |InputPin| :multiplicity (0 1) :is-composite-p T
    :subsetted-properties ((|Action| |input|))
    :documentation
     "Value to be added or removed from the variable.")))

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

(def-meta-package |UML4SysML| NIL :UML4SYSML12 
   (|OpaqueAction|
    |InputPin|
    |SendSignalAction|
    |CallOperationAction|
    |Integer|
    |Boolean|
    |String|
    |UnlimitedNatural|
    |Element|
    |Comment|
    |DirectedRelationship|
    |LiteralSpecification|
    |LiteralInteger|
    |LiteralString|
    |LiteralBoolean|
    |LiteralNull|
    |Constraint|
    |ElementImport|
    |MultiplicityElement|
    |TypedElement|
    |Feature|
    |RedefinableElement|
    |StructuralFeature|
    |InstanceSpecification|
    |Slot|
    |PackageImport|
    |DataType|
    |Enumeration|
    |EnumerationLiteral|
    |PrimitiveType|
    |Association|
    |ValueSpecification|
    |Relationship|
    |PackageMerge|
    |InstanceValue|
    |LiteralUnlimitedNatural|
    |Type|
    |Expression|
    |AggregationKind|
    |ParameterDirectionKind|
    |VisibilityKind|
    |OpaqueExpression|
    |OpaqueBehavior|
    |FunctionBehavior|
    |ControlNode|
    |ControlFlow|
    |InitialNode|
    |ActivityParameterNode|
    |ValuePin|
    |CallBehaviorAction|
    |CallAction|
    |Usage|
    |Abstraction|
    |Dependency|
    |Realization|
    |Substitution|
    |PackageableElement|
    |Namespace|
    |InterfaceRealization|
    |CallEvent|
    |ChangeEvent|
    |Interface|
    |Reception|
    |Signal|
    |SignalEvent|
    |MessageEvent|
    |AnyReceiveEvent|
    |BehavioredClassifier|
    |Event|
    |Operation|
    |CallConcurrencyKind|
    |Connector|
    |StructuredClassifier|
    |ConnectableElement|
    |Message|
    |GeneralOrdering|
    |ExecutionSpecification|
    |OccurrenceSpecification|
    |MessageEnd|
    |StateInvariant|
    |ActionExecutionSpecification|
    |BehaviorExecutionSpecification|
    |ExecutionEvent|
    |CreationEvent|
    |DestructionEvent|
    |SendOperationEvent|
    |SendSignalEvent|
    |MessageOccurrenceSpecification|
    |ExecutionOccurrenceSpecification|
    |ReceiveOperationEvent|
    |ReceiveSignalEvent|
    |MessageKind|
    |MessageSort|
    |Actor|
    |Extend|
    |Include|
    |UseCase|
    |ExtensionPoint|
    |VariableAction|
    |ReadVariableAction|
    |WriteVariableAction|
    |ClearVariableAction|
    |AddVariableValueAction|
    |RemoveVariableValueAction|
    |RaiseExceptionAction|
    |ActionInputPin|
    |CreateObjectAction|
    |DestroyObjectAction|
    |TestIdentityAction|
    |ReadSelfAction|
    |StructuralFeatureAction|
    |ReadStructuralFeatureAction|
    |WriteStructuralFeatureAction|
    |ClearStructuralFeatureAction|
    |RemoveStructuralFeatureValueAction|
    |AddStructuralFeatureValueAction|
    |LinkAction|
    |ReadLinkAction|
    |LinkEndCreationData|
    |CreateLinkAction|
    |DestroyLinkAction|
    |WriteLinkAction|
    |ClearAssociationAction|
    |BroadcastSignalAction|
    |SendObjectAction|
    |LinkEndDestructionData|
    |ValueSpecificationAction|
    |ForkNode|
    |FlowFinalNode|
    |CentralBufferNode|
    |ActivityPartition|
    |MergeNode|
    |DecisionNode|
    |FinalNode|
    |ActivityFinalNode|
    |TimeExpression|
    |Duration|
    |DurationInterval|
    |TimeConstraint|
    |TimeInterval|
    |DurationConstraint|
    |IntervalConstraint|
    |Interval|
    |Observation|
    |TimeObservation|
    |DurationObservation|
    |InteractionUse|
    |PartDecomposition|
    |InteractionOperand|
    |InteractionConstraint|
    |Gate|
    |CombinedFragment|
    |Interaction|
    |Lifeline|
    |Continuation|
    |InteractionFragment|
    |ConsiderIgnoreFragment|
    |InteractionOperatorKind|
    |Stereotype|
    |Profile|
    |Package|
    |ProfileApplication|
    |Extension|
    |Image|
    |NamedElement|
    |ExtensionEnd|
    |Port|
    |EncapsulatedClassifier|
    |ConnectorEnd|
    |InvocationAction|
    |Trigger|
    |Class|
    |StateMachine|
    |State|
    |Transition|
    |Vertex|
    |Pseudostate|
    |FinalState|
    |ConnectionPointReference|
    |Region|
    |TimeEvent|
    |PseudostateKind|
    |TransitionKind|
    |ReadExtentAction|
    |ReclassifyObjectAction|
    |ReadIsClassifiedObjectAction|
    |StartClassifierBehaviorAction|
    |QualifierValue|
    |LinkEndData|
    |ReadLinkObjectEndAction|
    |ReadLinkObjectEndQualifierAction|
    |CreateLinkObjectAction|
    |AcceptEventAction|
    |AcceptCallAction|
    |ReplyAction|
    |UnmarshallAction|
    |ReduceAction|
    |StartObjectBehaviorAction|
    |JoinNode|
    |DataStoreNode|
    |ObjectFlow|
    |ActivityEdge|
    |ObjectNode|
    |ParameterSet|
    |Parameter|
    |InterruptibleActivityRegion|
    |BehavioralFeature|
    |Behavior|
    |Pin|
    |ObjectNodeOrderingKind|
    |ParameterEffectKind|
    |GeneralizationSet|
    |Classifier|
    |Generalization|
    |AssociationClass|
    |Property|
    |Model|
    |InformationItem|
    |InformationFlow|
    |StructuredActivityNode|
    |ConditionalNode|
    |LoopNode|
    |Clause|
    |Activity|
    |ActivityNode|
    |ExecutableNode|
    |SequenceNode|
    |Action|
    |ActivityGroup|
    |OutputPin|
    |Variable|) :xmi-id "_0")

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(UML4SYSML12::|Action|
          UML4SYSML12::|ActivityEdge|
          UML4SYSML12::|ActivityGroup|
          UML4SYSML12::|ActivityNode|
          UML4SYSML12::|Behavior|
          UML4SYSML12::|BehavioralFeature|
          UML4SYSML12::|BehavioredClassifier|
          UML4SYSML12::|CallAction|
          UML4SYSML12::|Classifier|
          UML4SYSML12::|ConnectableElement|
          UML4SYSML12::|ControlNode|
          UML4SYSML12::|DirectedRelationship|
          UML4SYSML12::|Element|
          UML4SYSML12::|EncapsulatedClassifier|
          UML4SYSML12::|Event|
          UML4SYSML12::|ExecutableNode|
          UML4SYSML12::|ExecutionSpecification|
          UML4SYSML12::|Feature|
          UML4SYSML12::|FinalNode|
          UML4SYSML12::|InteractionFragment|
          UML4SYSML12::|InvocationAction|
          UML4SYSML12::|LinkAction|
          UML4SYSML12::|LiteralSpecification|
          UML4SYSML12::|MessageEnd|
          UML4SYSML12::|MessageEvent|
          UML4SYSML12::|MultiplicityElement|
          UML4SYSML12::|NamedElement|
          UML4SYSML12::|Namespace|
          UML4SYSML12::|ObjectNode|
          UML4SYSML12::|Observation|
          UML4SYSML12::|PackageableElement|
          UML4SYSML12::|RedefinableElement|
          UML4SYSML12::|Relationship|
          UML4SYSML12::|StructuralFeature|
          UML4SYSML12::|StructuralFeatureAction|
          UML4SYSML12::|StructuredClassifier|
          UML4SYSML12::|Type|
          UML4SYSML12::|TypedElement|
          UML4SYSML12::|ValueSpecification|
          UML4SYSML12::|VariableAction|
          UML4SYSML12::|Vertex|
          UML4SYSML12::|WriteLinkAction|
          UML4SYSML12::|WriteStructuralFeatureAction|
          UML4SYSML12::|WriteVariableAction|))
     (setf mofi:ns-uri "http://www.omg.org/spec/SysML/20100301/UML4SysML")
     (setf mofi:ns-prefix "UML4SysML"))
