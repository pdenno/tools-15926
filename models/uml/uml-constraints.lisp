;;; Automatically generated from the SYSML MM (see u4s-reader.lisp) on 2007-04-07 15:09:44
;;; Do not edit. Edit the OCL in uml.lisp instead.
(in-package :uml)

;;;==================================
;;; AcceptCallAction
;;;==================================
;;; Constraint trigger_call_event:
#|   trigger.event.oclIsKindOf(CallEvent) |#
;;; Constraint unmarshall:
#|   isUnmarshall = true |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |AcceptCallAction|))
  (WITH-OCL-CONTEXT (|AcceptCallAction|)
    (WITH-CONSTRAINT ("result_pins") :TRUE)
    (WITH-CONSTRAINT ("trigger_call_event")
      (OCL-IS-KIND-OF (%EVENT (%TRIGGER SELF)) (find-class '|CallEvent|)))
    (WITH-CONSTRAINT ("unmarshall")
      (OCL-= (%IS-UNMARSHALL SELF) :TRUE))))

;;;==================================
;;; AcceptEventAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |AcceptEventAction|))
  (WITH-OCL-CONTEXT (|AcceptEventAction|)
    (WITH-CONSTRAINT ("no_input_pins") :TRUE)
    (WITH-CONSTRAINT ("no_output_pins") :TRUE)
    (WITH-CONSTRAINT ("trigger_events") :TRUE)
    (WITH-CONSTRAINT ("unmarshall_signal_events") :TRUE)))

;;;==================================
;;; ActionExecutionSpecification
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActionExecutionSpecification|))
  (WITH-OCL-CONTEXT (|ActionExecutionSpecification|)
    (WITH-CONSTRAINT ("action_referenced") :TRUE)))

;;;==================================
;;; ActionInputPin
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActionInputPin|))
  (WITH-OCL-CONTEXT (|ActionInputPin|)
    (WITH-CONSTRAINT ("one_output_pin") :TRUE)
    (WITH-CONSTRAINT ("input_pin") :TRUE)
    (WITH-CONSTRAINT ("no_control_or_data_flow") :TRUE)))

;;;==================================
;;; Activity
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Activity|))
  (WITH-OCL-CONTEXT (|Activity|)
    (WITH-CONSTRAINT ("no_supergroups") :TRUE)
    (WITH-CONSTRAINT ("activity_parameter_node") :TRUE)
    (WITH-CONSTRAINT ("autonomous") :TRUE)))

;;;==================================
;;; ActivityEdge
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActivityEdge|))
  (WITH-OCL-CONTEXT (|ActivityEdge|)
    (WITH-CONSTRAINT ("source_and_target") :TRUE)
    (WITH-CONSTRAINT ("owned") :TRUE)
    (WITH-CONSTRAINT ("structured_node") :TRUE)))

;;;==================================
;;; ActivityGroup
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActivityGroup|))
  (WITH-OCL-CONTEXT (|ActivityGroup|)
    (WITH-CONSTRAINT ("nodes_and_edges") :TRUE)
    (WITH-CONSTRAINT ("not_contained") :TRUE)
    (WITH-CONSTRAINT ("group_owned") :TRUE)))

;;;==================================
;;; ActivityNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActivityNode|))
  (WITH-OCL-CONTEXT (|ActivityNode|)
    (WITH-CONSTRAINT ("owned_structured_node") :TRUE)
    (WITH-CONSTRAINT ("owned") :TRUE)))

;;;==================================
;;; ActivityParameterNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActivityParameterNode|))
  (WITH-OCL-CONTEXT (|ActivityParameterNode|)
    (WITH-CONSTRAINT ("has_parameters") :TRUE)
    (WITH-CONSTRAINT ("same_type") :TRUE)
    (WITH-CONSTRAINT ("no_edges") :TRUE)
    (WITH-CONSTRAINT ("no_incoming_edges") :TRUE)
    (WITH-CONSTRAINT ("no_outgoing_edges") :TRUE)))

;;;==================================
;;; ActivityPartition
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ActivityPartition|))
  (WITH-OCL-CONTEXT (|ActivityPartition|)
    (WITH-CONSTRAINT ("dimension_not_contained") :TRUE)
    (WITH-CONSTRAINT ("represents_part") :TRUE)
    (WITH-CONSTRAINT ("represents_classifier") :TRUE)
    (WITH-CONSTRAINT ("represents_part_and_is_contained") :TRUE)))

;;;==================================
;;; Actor
;;;==================================
;;; Constraint must_have_name:
#|   name->notEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Actor|))
  (WITH-OCL-CONTEXT (|Actor|)
    (WITH-CONSTRAINT ("must_have_name") (OCL-NOT-EMPTY (%NAME SELF)))))

;;;==================================
;;; AddStructuralFeatureValueAction
;;;==================================
;;; Constraint unlimited_natural_and_multiplicity:
#|   structuralFeature.isOrdered implies (insertAt->size() = 1 and
    insertAt.is(1,1)     and   insertAt.type.oclIsKindOf(UnlimitedNatural))
   or insertAt->size() = 0 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |AddStructuralFeatureValueAction|))
  (WITH-OCL-CONTEXT (|AddStructuralFeatureValueAction|)
    (WITH-CONSTRAINT ("unlimited_natural_and_multiplicity")
      (OCL-IMPLIES (%IS-ORDERED (%STRUCTURAL-FEATURE SELF))
                   (OCL-OR (OCL-AND (OCL-AND
                                     (OCL-=
                                      (OCL-SIZE (%INSERT-AT SELF))
                                      1)
                                     (IS (%INSERT-AT SELF) 1 1))
                                    (OCL-IS-KIND-OF
                                     (%TYPE (%INSERT-AT SELF))
                                     (find-class '|UnlimitedNatural|)))
                           (OCL-= (OCL-SIZE (%INSERT-AT SELF)) 0))))))

;;;==================================
;;; AddVariableValueAction
;;;==================================
;;; Constraint single_input_pin:
#|   variable.ordering = #ordered implies (insertAt.is(1,1) and insertAt.type.oclIsKindOf(UnlimitedNatural))
  or insertAt->size() = 0 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |AddVariableValueAction|))
  (WITH-OCL-CONTEXT (|AddVariableValueAction|)
    (WITH-CONSTRAINT ("single_input_pin")
      (OCL-IMPLIES (OCL-= (%ORDERING (%VARIABLE SELF)) :ORDERED)
                   (OCL-OR (OCL-AND (IS (%INSERT-AT SELF) 1 1)
                                    (OCL-IS-KIND-OF
                                     (%TYPE (%INSERT-AT SELF))
                                     (find-class '|UnlimitedNatural|)))
                           (OCL-= (OCL-SIZE (%INSERT-AT SELF)) 0))))))

;;;==================================
;;; Association
;;;==================================
#|   self.memberEnd->collect(e | e.type) |#
(DEFMETHOD END-TYPE.1
  ((SELF |Association|))
  "  endType is derived from the types of the member ends."
  (OCL-COLLECT (%MEMBER-END SELF) #'(LAMBDA ($E) (%TYPE $E))))

;;; Constraint specialized_end_number:
#|   self.parents()->forAll(p | p.memberEnd.size() = self.memberEnd.size()) |#
;;; Constraint association_ends:
#|   memberEnd->size() > 2 implies ownedEnd->includesAll(memberEnd) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Association|))
  (WITH-OCL-CONTEXT (|Association|)
    (WITH-CONSTRAINT ("specialized_end_number")
      (OCL-FOR-ALL (PARENTS SELF)
                   #'(LAMBDA ($P)
                       (OCL-= (OCL-SIZE (%MEMBER-END $P))
                              (OCL-SIZE (%MEMBER-END SELF))))))
    (WITH-CONSTRAINT ("specialized_end_types") :TRUE)
    (WITH-CONSTRAINT ("association_ends")
      (OCL-IMPLIES (OCL-> (OCL-SIZE (%MEMBER-END SELF)) 2)
                   (OCL-INCLUDES-ALL (%OWNED-END SELF)
                                     (%MEMBER-END SELF))))))

;;;==================================
;;; AssociationClass
;;;==================================
#|   memberEnd->union ( self.parents ()->collect (p | p.allConnections
  ())) |#
(DEFMETHOD ALL-CONNECTIONS
  ((SELF |AssociationClass|))
  "  The operation allConnections results in the set of all AssociationEnds
  of the Association."
  (OCL-UNION (%MEMBER-END SELF)
             (OCL-COLLECT (PARENTS SELF)
                          #'(LAMBDA ($P) (ALL-CONNECTIONS $P)))))

;;; Constraint cannot_be_defined:
#|   self.endType->excludes(self) and self.endType->collect(et|et.allParents()->excludes(self)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |AssociationClass|))
  (WITH-OCL-CONTEXT (|AssociationClass|)
    (WITH-CONSTRAINT ("cannot_be_defined")
      (OCL-AND (OCL-EXCLUDES (%END-TYPE SELF) SELF)
               (OCL-COLLECT (%END-TYPE SELF)
                            #'(LAMBDA ($ET)
                                (OCL-EXCLUDES
                                 (ALL-PARENTS $ET)
                                 SELF)))))))

;;;==================================
;;; Behavior
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Behavior|))
  (WITH-OCL-CONTEXT (|Behavior|)
    (WITH-CONSTRAINT ("parameters_match") :TRUE)
    (WITH-CONSTRAINT ("feature_of_context_classifier") :TRUE)
    (WITH-CONSTRAINT ("must_realize") :TRUE)
    (WITH-CONSTRAINT ("most_one_behaviour") :TRUE)))

;;;==================================
;;; BehavioralFeature
;;;==================================
#|   def: isDistinguishableFrom (n : NamedElement, ns : Namespace)
  if n.oclIsKindOf(BehavioralFeature) then   if ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->notEmpty()
    then Set{}->including(self)->including(n)->isUnique(bf | bf.ownedParameter->collect(type))
    else true   endif else true endif |#
(DEFMETHOD IS-DISTINGUISHABLE-FROM
  ((SELF |BehavioralFeature|) $N $NS)
  (OCL-ASSERT (|NamedElement| $N))
  (OCL-ASSERT (|Namespace| $NS))
  (OCL-IF (OCL-IS-KIND-OF $N (find-class '|BehavioralFeature|))
          (OCL-IF (OCL-NOT-EMPTY (OCL-INTERSECTION
                                  (GET-NAMES-OF-MEMBER $NS SELF)
                                  (GET-NAMES-OF-MEMBER $NS $N)))
                  (OCL-IS-UNIQUE (OCL-INCLUDING
                                  (OCL-INCLUDING
                                   (MAKE-INSTANCE '|Set| :VALUE NIL)
                                   SELF)
                                  $N)
                                 #'(LAMBDA
                                    ($BF)
                                    (OCL-COLLECT
                                     (%OWNED-PARAMETER $BF)
                                     #'(LAMBDA
                                        (%VAR-1)
                                        (%TYPE %VAR-1)))))
                  :TRUE)
          :TRUE))

;;;==================================
;;; BehavioredClassifier
;;;==================================
;;; Constraint class_behavior:
#|   true -- (POD no attribute specification)                 -- self.classifierBehavior.notEmpty()
  implies self.specification.isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |BehavioredClassifier|))
  (WITH-OCL-CONTEXT (|BehavioredClassifier|)
    (WITH-CONSTRAINT ("class_behavior") :TRUE)))

;;;==================================
;;; BroadcastSignalAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |BroadcastSignalAction|))
  (WITH-OCL-CONTEXT (|BroadcastSignalAction|)
    (WITH-CONSTRAINT ("number_and_order") :TRUE)
    (WITH-CONSTRAINT ("type_ordering_multiplicity") :TRUE)))

;;;==================================
;;; CallAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CallAction|))
  (WITH-OCL-CONTEXT (|CallAction|)
    (WITH-CONSTRAINT ("synchronous_call") :TRUE)
    (WITH-CONSTRAINT ("number_and_order") :TRUE)
    (WITH-CONSTRAINT ("type_ordering_multiplicity") :TRUE)))

;;;==================================
;;; CallBehaviorAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CallBehaviorAction|))
  (WITH-OCL-CONTEXT (|CallBehaviorAction|)
    (WITH-CONSTRAINT ("argument_pin_equal_parameter") :TRUE)
    (WITH-CONSTRAINT ("result_pin_equal_parameter") :TRUE)
    (WITH-CONSTRAINT ("type_ordering_multiplicity") :TRUE)))

;;;==================================
;;; CallOperationAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CallOperationAction|))
  (WITH-OCL-CONTEXT (|CallOperationAction|)
    (WITH-CONSTRAINT ("argument_pin_equal_parameter") :TRUE)
    (WITH-CONSTRAINT ("result_pin_equal_parameter") :TRUE)
    (WITH-CONSTRAINT ("type_ordering_multiplicity") :TRUE)
    (WITH-CONSTRAINT ("type_target_pin") :TRUE)))

;;;==================================
;;; Class
;;;==================================
;;; Constraint passive_class:
#|   not self.isActive implies self.ownedReception.isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Class|))
  (WITH-OCL-CONTEXT (|Class|)
    (WITH-CONSTRAINT ("passive_class")
      (OCL-IMPLIES (OCL-NOT (%IS-ACTIVE SELF))
                   (OCL-IS-EMPTY (%OWNED-RECEPTION SELF))))))

;;;==================================
;;; Classifier
;;;==================================
#|   generalization->collect(general) |#
(DEFMETHOD PARENTS
  ((SELF |Classifier|))
  "  The query parents() gives all of the immediate ancestors of a
  generalized Classifier."
  (OCL-COLLECT (%GENERALIZATION SELF)
               #'(LAMBDA (%VAR-2) (%GENERAL %VAR-2))))

#|   member->select(oclIsKindOf(Feature)) |#
(DEFMETHOD ALL-FEATURES
  ((SELF |Classifier|))
  "  The query allFeatures() gives all of the features in the namespace
  of the classifier. In general, through mechanisms such as inheritance,
  this will be a larger set than feature."
  (OCL-SELECT (%MEMBER SELF)
              #'(LAMBDA (%VAR-3) (OCL-IS-KIND-OF %VAR-3 (find-class '|Feature|)))))

#|   def: conformsTo (other : Classifier) (self=other) or (self.allParents()->includes(other)) |#
(DEFMETHOD CONFORMS-TO
  ((SELF |Classifier|) $OTHER)
  (OCL-ASSERT (|Classifier| $OTHER))
  (OCL-OR (OCL-= SELF $OTHER) (OCL-INCLUDES (ALL-PARENTS SELF) $OTHER)))

;;; POD 2007-06-29 I changed OCL-COLLECT to OCL-SELECT below. 
;;; (1) Q: Why isn't there an includesAll here, like in the 07-02-03-super and 07-02-04-infra specs ???
;;;     A: If it did, it wouldn't be a constraint. (It is placed in the constraints section.)
;;;;       Was the XMI intentionally transformed, or is it out of date? 
;;;  From the spec:
;;   self.inheritedMember->includesAll(self.inherit(self.parents()->collect(p | p.inheritableMembers(self)))
#|                                     self.inherit(self.parents()->collect(p | p.inheritableMembers(self)))
 |#
(DEFMETHOD INHERITED-MEMBER.1
  ((SELF |Classifier|))
  "  The inheritedMember association is derived by inheriting the
  inheritable members of the parents."
  (INHERIT SELF
           (OCL-select (PARENTS SELF)
                        #'(LAMBDA ($P) (INHERITABLE-MEMBERS $P SELF)))))

#|   oclAsType(TemplateableElement).isTemplate() or general->exists(g
  | g.isTemplate()) |#
(DEFMETHOD IS-TEMPLATE
  ((SELF |Classifier|))
  "  The query isTemplate() returns whether this templateable element
  is actually a template."
  (OCL-OR (IS-TEMPLATE (OCL-AS-TYPE SELF '|TemplateableElement|))
          (OCL-EXISTS (%GENERAL SELF)
                      #'(LAMBDA ($G) (IS-TEMPLATE $G)))))

#|   def: hasVisibilityOf (n : NamedElement) if (self.inheritedMember->includes(n))
  then (n.visibility <> #private) else true endif |#
(DEFMETHOD HAS-VISIBILITY-OF
  ((SELF |Classifier|) $N)
  (OCL-ASSERT (|NamedElement| $N))
  (OCL-IF (OCL-INCLUDES (%INHERITED-MEMBER SELF) $N)
          (OCL-<> (%VISIBILITY $N) :PRIVATE)
          :TRUE))

#|   def: hasVisibilityOf (n : NamedElement) self.allParents()->collect(c
  | c.member)->includes(n) |#
(DEFMETHOD HAS-VISIBILITY-OF
  ((SELF |Classifier|) $N)
  (OCL-ASSERT (|NamedElement| $N))
  (OCL-INCLUDES (OCL-COLLECT (ALL-PARENTS SELF)
                             #'(LAMBDA ($C) (%MEMBER $C)))
                $N))

#|   self.parents() |#
(DEFMETHOD GENERAL.1
  ((SELF |Classifier|))
  "  The general classifiers are the classifiers referenced by the
  generalization relationships."
  (PARENTS SELF))

#|   def: inherit (inhs : NamedElement) inhs |#
(DEFMETHOD INHERIT
  ((SELF |Classifier|) $INHS)
  ;pod(OCL-ASSERT (|NamedElement| $INHS))
  $INHS)

#|   self.parents()->union(self.parents()->collect(p | p.allParents())) |#
(DEFMETHOD ALL-PARENTS
  ((SELF |Classifier|))
  "  The query allParents() gives all of the direct and indirect ancestors
  of a generalized Classifier."
  (OCL-UNION (PARENTS SELF)
             (OCL-COLLECT (PARENTS SELF)
                          #'(LAMBDA ($P) (ALL-PARENTS $P)))))

#|   def: inheritableMembers (c : Classifier) member->select(m | c.hasVisibilityOf(m)) |#
(DEFMETHOD INHERITABLE-MEMBERS
  ((SELF |Classifier|) $C)
  (OCL-ASSERT (|Classifier| $C))
  (OCL-SELECT (%MEMBER SELF) #'(LAMBDA ($M) (HAS-VISIBILITY-OF $C $M))))

#|   def: inheritableMembers (c : Classifier) c.allParents()->includes(self) |#
(DEFMETHOD INHERITABLE-MEMBERS
  ((SELF |Classifier|) $C)
  (OCL-ASSERT (|Classifier| $C))
  (OCL-INCLUDES (ALL-PARENTS $C) SELF))

#|   def: maySpecializeType (c : Classifier) self.oclIsKindOf(c.oclType()) |#
(DEFMETHOD MAY-SPECIALIZE-TYPE
  ((SELF |Classifier|) $C)
  (OCL-ASSERT (|Classifier| $C))
  (OCL-IS-KIND-OF SELF (OCL-TYPE $C)))

;;; Constraint no_cycles_in_generalization:
#|   not self.allParents()->includes(self) |#
;;; Constraint generalization_hierarchies:
#|   not self.allParents()->includes(self) |#
;;; Constraint specialize_type:
#|   self.parents()->forAll(c | self.maySpecializeType(c)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Classifier|))
  (WITH-OCL-CONTEXT (|Classifier|)
    (WITH-CONSTRAINT ("no_cycles_in_generalization")
      (OCL-NOT (OCL-INCLUDES (ALL-PARENTS SELF) SELF)))
    (WITH-CONSTRAINT ("generalization_hierarchies")
      (OCL-NOT (OCL-INCLUDES (ALL-PARENTS SELF) SELF)))
    (WITH-CONSTRAINT ("specialize_type")
      (OCL-FOR-ALL (PARENTS SELF)
                   #'(LAMBDA ($C) (MAY-SPECIALIZE-TYPE SELF $C))))
    (WITH-CONSTRAINT ("maps_to_generalization_set") :TRUE)))

;;;==================================
;;; ClassifierTemplateParameter
;;;==================================
;;; Constraint has_constraining_classifier:
#|   allowSubstitutable implies constrainingClassifier->notEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ClassifierTemplateParameter|))
  (WITH-OCL-CONTEXT (|ClassifierTemplateParameter|)
    (WITH-CONSTRAINT ("has_constraining_classifier")
      (OCL-IMPLIES (%ALLOW-SUBSTITUTABLE SELF)
                   (OCL-NOT-EMPTY (%CONSTRAINING-CLASSIFIER SELF))))))

;;;==================================
;;; Clause
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Clause|))
  (WITH-OCL-CONTEXT (|Clause|)
    (WITH-CONSTRAINT ("decider_output") :TRUE)
    (WITH-CONSTRAINT ("body_output_pins") :TRUE)))

;;;==================================
;;; ClearAssociationAction
;;;==================================
;;; Constraint same_type:
#|   self.association->exists(end.type = self.object.type) |#
;;; Constraint multiplicity:
#|   self.object.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ClearAssociationAction|))
  (WITH-OCL-CONTEXT (|ClearAssociationAction|)
    (WITH-CONSTRAINT ("same_type")
      (OCL-EXISTS (%ASSOCIATION SELF)
                  #'(LAMBDA (%VAR-4)
                      (OCL-= (%TYPE (%END %VAR-4))
                             (%TYPE (%OBJECT %VAR-4))))))
    (WITH-CONSTRAINT ("multiplicity") (IS (%OBJECT SELF) 1 1))))

;;;==================================
;;; CollaborationUse
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CollaborationUse|))
  (WITH-OCL-CONTEXT (|CollaborationUse|)
    (WITH-CONSTRAINT ("client_elements") :TRUE)
    (WITH-CONSTRAINT ("every_role") :TRUE)
    (WITH-CONSTRAINT ("connectors") :TRUE)))

;;;==================================
;;; CombinedFragment
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CombinedFragment|))
  (WITH-OCL-CONTEXT (|CombinedFragment|)
    (WITH-CONSTRAINT ("opt_loop_break_neg") :TRUE)
    (WITH-CONSTRAINT ("minint_and_maxint") :TRUE)
    (WITH-CONSTRAINT ("break") :TRUE)))

;;;==================================
;;; CommunicationPath
;;;==================================
;;; Constraint association_ends:
#|   result = self.endType->forAll (t | t.oclIsKindOf(DeploymentTarget)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CommunicationPath|))
  (WITH-OCL-CONTEXT (|CommunicationPath|)
    (WITH-CONSTRAINT ("association_ends")
      (OCL-FOR-ALL (%END-TYPE SELF)
                   #'(LAMBDA ($T)
                       (OCL-IS-KIND-OF $T (find-class '|DeploymentTarget|)))))))

;;;==================================
;;; Component
;;;==================================
#|   def: realizedInterfaces (classifier : Classifier) classifier.clientDependency->
  select(dependency|dependency.oclIsKindOf(Realization) and dependency.supplier.oclIsKindOf(Interface))->
  collect(dependency|dependency.client) |#
(DEFMETHOD REALIZED-INTERFACES
  ((SELF |Component|) $CLASSIFIER)
  (OCL-ASSERT (|Classifier| $CLASSIFIER))
  (OCL-COLLECT (OCL-SELECT (%CLIENT-DEPENDENCY $CLASSIFIER)
                           #'(LAMBDA ($DEPENDENCY)
                               (OCL-AND
                                (OCL-IS-KIND-OF
                                 $DEPENDENCY
                                 (find-class '|Realization|))
                                (OCL-IS-KIND-OF
                                 (%SUPPLIER $DEPENDENCY)
                                 (find-class '|Interface|)))))
               #'(LAMBDA ($DEPENDENCY) (%CLIENT $DEPENDENCY))))

;;;==================================
;;; ConditionalNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ConditionalNode|))
  (WITH-OCL-CONTEXT (|ConditionalNode|)
    (WITH-CONSTRAINT ("result_no_incoming") :TRUE)))

;;;==================================
;;; ConnectionPointReference
;;;==================================
;;; Constraint entry_pseudostates:
#|   entry->notEmpty() implies entry->forAll(e | e.kind = #entryPoint) |#
;;; Constraint exit_pseudostates:
#|   exit->notEmpty() implies exit->forAll(e | e.kind = #exitPoint) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ConnectionPointReference|))
  (WITH-OCL-CONTEXT (|ConnectionPointReference|)
    (WITH-CONSTRAINT ("entry_pseudostates")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%ENTRY SELF))
                   (OCL-FOR-ALL (%ENTRY SELF)
                                #'(LAMBDA
                                   ($E)
                                   (OCL-= (%KIND $E) :ENTRYPOINT)))))
    (WITH-CONSTRAINT ("exit_pseudostates")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%EXIT SELF))
                   (OCL-FOR-ALL (%EXIT SELF)
                                #'(LAMBDA
                                   ($E)
                                   (OCL-= (%KIND $E) :EXITPOINT)))))))

;;;==================================
;;; Connector
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Connector|))
  (WITH-OCL-CONTEXT (|Connector|)
    (WITH-CONSTRAINT ("between_interface_port_signature") :TRUE)
    (WITH-CONSTRAINT ("between_interface_port_implements") :TRUE)
    (WITH-CONSTRAINT ("between_interfaces_ports") :TRUE)
    (WITH-CONSTRAINT ("types") :TRUE)
    (WITH-CONSTRAINT ("roles") :TRUE)
    (WITH-CONSTRAINT ("compatible") :TRUE)
    (WITH-CONSTRAINT ("assembly_connector") :TRUE)
    (WITH-CONSTRAINT ("union_signature_compatible") :TRUE)))

;;;==================================
;;; ConnectorEnd
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ConnectorEnd|))
  (WITH-OCL-CONTEXT (|ConnectorEnd|)
    (WITH-CONSTRAINT ("multiplicity") :TRUE)
    (WITH-CONSTRAINT ("part_with_port_empty") :TRUE)
    (WITH-CONSTRAINT ("role_and_part_with_port") :TRUE)
    (WITH-CONSTRAINT ("self_part_with_port") :TRUE)))

;;;==================================
;;; ConsiderIgnoreFragment
;;;==================================
;;; Constraint consider_or_ignore:
#|   (interactionOperator = #consider) or (interactionOperator = #ignore) |#
;;; Constraint type:
#|   message->forAll(m | m.oclIsKindOf(Operation) or m.oclIsKindOf(Reception)
  or m.oclIsKindOf(Signal)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ConsiderIgnoreFragment|))
  (WITH-OCL-CONTEXT (|ConsiderIgnoreFragment|)
    (WITH-CONSTRAINT ("consider_or_ignore")
      (OCL-OR (OCL-= (%INTERACTION-OPERATOR SELF) :CONSIDER)
              (OCL-= (%INTERACTION-OPERATOR SELF) :IGNORE)))
    (WITH-CONSTRAINT ("type")
      (OCL-FOR-ALL (%MESSAGE SELF)
                   #'(LAMBDA ($M)
                       (OCL-OR (OCL-OR
                                (OCL-IS-KIND-OF $M (find-class '|Operation|))
                                (OCL-IS-KIND-OF $M (find-class '|Reception|)))
                               (OCL-IS-KIND-OF $M (find-class '|Signal|))))))))

;;;==================================
;;; Constraint
;;;==================================
;;; Constraint not_apply_to_self:
#|   not constrainedElement->includes(self) |#
;;; Constraint value_specification_boolean:
#|   self.specification.booleanValue().oclIsKindOf(Boolean) |#
;;; Constraint not_applied_to_self:
#|   not constrainedElement->includes(self) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Constraint|))
  (WITH-OCL-CONTEXT (|Constraint|)
    (WITH-CONSTRAINT ("not_apply_to_self")
      (OCL-NOT (OCL-INCLUDES (%CONSTRAINED-ELEMENT SELF) SELF)))
    (WITH-CONSTRAINT ("value_specification_boolean")
      (OCL-IS-KIND-OF (BOOLEAN-VALUE (%SPECIFICATION SELF))
                      (find-class '|Boolean|)))
    (WITH-CONSTRAINT ("boolean_value") :TRUE)
    (WITH-CONSTRAINT ("no_side_effects") :TRUE)
    (WITH-CONSTRAINT ("not_applied_to_self")
      (OCL-NOT (OCL-INCLUDES (%CONSTRAINED-ELEMENT SELF) SELF)))))

;;;==================================
;;; Continuation
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Continuation|))
  (WITH-OCL-CONTEXT (|Continuation|)
    (WITH-CONSTRAINT ("same_name") :TRUE)
    (WITH-CONSTRAINT ("global") :TRUE)
    (WITH-CONSTRAINT ("first_or_last_interaction_fragment") :TRUE)))

;;;==================================
;;; ControlFlow
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ControlFlow|))
  (WITH-OCL-CONTEXT (|ControlFlow|)
    (WITH-CONSTRAINT ("object_nodes") :TRUE)))

;;;==================================
;;; CreateLinkAction
;;;==================================
;;; Constraint association_not_abstract:
#|   self.association().isAbstract = #false |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CreateLinkAction|))
  (WITH-OCL-CONTEXT (|CreateLinkAction|)
    (WITH-CONSTRAINT ("association_not_abstract")
      (OCL-= (%IS-ABSTRACT (ASSOCIATION SELF)) :FALSE))))

;;;==================================
;;; CreateLinkObjectAction
;;;==================================
;;; Constraint association_class:
#|   self.association().oclIsKindOf(Class) |#
;;; Constraint type_of_result:
#|   self.result.type = self.association() |#
;;; Constraint multiplicity:
#|   self.result.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CreateLinkObjectAction|))
  (WITH-OCL-CONTEXT (|CreateLinkObjectAction|)
    (WITH-CONSTRAINT ("association_class")
      (OCL-IS-KIND-OF (ASSOCIATION SELF) (find-class '|Class|)))
    (WITH-CONSTRAINT ("type_of_result")
      (OCL-= (%TYPE (%RESULT SELF)) (ASSOCIATION SELF)))
    (WITH-CONSTRAINT ("multiplicity") (IS (%RESULT SELF) 1 1))))

;;;==================================
;;; CreateObjectAction
;;;==================================
;;; Constraint classifier_not_abstract:
#|   not (self.classifier.isAbstract = #true) |#
;;; Constraint classifier_not_association_class:
#|   not self.classifier.oclIsKindOf(AssociationClass) |#
;;; Constraint same_type:
#|   self.result.type = self.classifier |#
;;; Constraint multiplicity:
#|   self.result.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CreateObjectAction|))
  (WITH-OCL-CONTEXT (|CreateObjectAction|)
    (WITH-CONSTRAINT ("classifier_not_abstract")
      (OCL-NOT (OCL-= (%IS-ABSTRACT (%CLASSIFIER SELF)) :TRUE)))
    (WITH-CONSTRAINT ("classifier_not_association_class")
      (OCL-NOT (OCL-IS-KIND-OF (%CLASSIFIER SELF)
                               (find-class '|AssociationClass|))))
    (WITH-CONSTRAINT ("same_type")
      (OCL-= (%TYPE (%RESULT SELF)) (%CLASSIFIER SELF)))
    (WITH-CONSTRAINT ("multiplicity") (IS (%RESULT SELF) 1 1))))

;;;==================================
;;; CreationEvent
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |CreationEvent|))
  (WITH-OCL-CONTEXT (|CreationEvent|)
    (WITH-CONSTRAINT ("no_occurrence_above") :TRUE)))

;;;==================================
;;; DecisionNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DecisionNode|))
  (WITH-OCL-CONTEXT (|DecisionNode|)
    (WITH-CONSTRAINT ("one_incoming_edge") :TRUE)
    (WITH-CONSTRAINT ("input_parameter") :TRUE)
    (WITH-CONSTRAINT ("edges") :TRUE)))

;;;==================================
;;; DeploymentSpecification
;;;==================================
;;; Constraint deployed_elements:
#|   self.deployment->forAll (d | d.location.deployedElement->forAll
  (de |   de.oclIsKindOf(Component))) |#
;;; Constraint deployment_target:
#|   result = self.deployment->forAll (d | d.location.oclIsKindOf(ExecutionEnvironment)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DeploymentSpecification|))
  (WITH-OCL-CONTEXT (|DeploymentSpecification|)
    (WITH-CONSTRAINT ("deployed_elements")
      (OCL-FOR-ALL (%DEPLOYMENT SELF)
                   #'(LAMBDA ($D)
                       (OCL-FOR-ALL (%DEPLOYED-ELEMENT (%LOCATION $D))
                                    #'(LAMBDA
                                       ($DE)
                                       (OCL-IS-KIND-OF
                                        $DE
                                        (find-class '|Component|)))))))
    (WITH-CONSTRAINT ("deployment_target")
      (OCL-FOR-ALL (%DEPLOYMENT SELF)
                   #'(LAMBDA ($D)
                       (OCL-IS-KIND-OF (%LOCATION $D)
                                       (find-class '|ExecutionEnvironment|)))))))

;;;==================================
;;; DeploymentTarget
;;;==================================
#|   ((self.deployment->collect(deployedArtifact))->collect(manifestation))->collect(utilizedElement) |#
(DEFMETHOD DEPLOYED-ELEMENT.1
  ((SELF |DeploymentTarget|))
  ""
  (OCL-COLLECT (OCL-COLLECT (OCL-COLLECT (%DEPLOYMENT SELF)
                                         #'(LAMBDA
                                            (%VAR-5)
                                            (%DEPLOYED-ARTIFACT
                                             %VAR-5)))
                            #'(LAMBDA (%VAR-6)
                                (%MANIFESTATION %VAR-6)))
               #'(LAMBDA (%VAR-7) (%UTILIZED-ELEMENT %VAR-7))))

;;;==================================
;;; DestroyObjectAction
;;;==================================
;;; Constraint multiplicity:
#|   self.target.is(1,1) |#
;;; Constraint no_type:
#|   self.target.type->size() = 0 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DestroyObjectAction|))
  (WITH-OCL-CONTEXT (|DestroyObjectAction|)
    (WITH-CONSTRAINT ("multiplicity") (IS (%TARGET SELF) 1 1))
    (WITH-CONSTRAINT ("no_type")
      (OCL-= (OCL-SIZE (%TYPE (%TARGET SELF))) 0))))

;;;==================================
;;; DestructionEvent
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DestructionEvent|))
  (WITH-OCL-CONTEXT (|DestructionEvent|)
    (WITH-CONSTRAINT ("no_occurrence_specifications_below") :TRUE)))

;;;==================================
;;; DurationConstraint
;;;==================================
;;; Constraint first_event_multiplicity:
#|   if (constrainedElement->size() =2)   then (firstEvent->size()
  = 2) else (firstEvent->size() = 0) endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DurationConstraint|))
  (WITH-OCL-CONTEXT (|DurationConstraint|)
    (WITH-CONSTRAINT ("first_event_multiplicity")
      (OCL-IF (OCL-= (OCL-SIZE (%CONSTRAINED-ELEMENT SELF)) 2)
              (OCL-= (OCL-SIZE (%FIRST-EVENT SELF)) 2)
              (OCL-= (OCL-SIZE (%FIRST-EVENT SELF)) 0)))))

;;;==================================
;;; DurationObservation
;;;==================================
;;; Constraint first_event_multiplicity:
#|   if (event->size() = 2)   then (firstEvent->size() = 2) else (firstEvent->size()
  = 0) endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |DurationObservation|))
  (WITH-OCL-CONTEXT (|DurationObservation|)
    (WITH-CONSTRAINT ("first_event_multiplicity")
      (OCL-IF (OCL-= (OCL-SIZE (%EVENT SELF)) 2)
              (OCL-= (OCL-SIZE (%FIRST-EVENT SELF)) 2)
              (OCL-= (OCL-SIZE (%FIRST-EVENT SELF)) 0)))))

;;;==================================
;;; Element
;;;==================================
#|   true |#
(DEFMETHOD MUST-BE-OWNED
  ((SELF |Element|))
  "  The query mustBeOwned() indicates whether elements of this type
  must have an owner. Subclasses of Element that do not require
  an owner must override this operation."
  :TRUE)

#|   ownedElement->union(ownedElement->collect(e | e.allOwnedElements())) |#
(DEFMETHOD ALL-OWNED-ELEMENTS
  ((SELF |Element|))
  "  The query allOwnedElements() gives all of the direct and indirect
  owned elements of an element."
  (OCL-UNION (%OWNED-ELEMENT SELF)
             (OCL-COLLECT (%OWNED-ELEMENT SELF)
                          #'(LAMBDA ($E) (ALL-OWNED-ELEMENTS $E)))))

;;; Constraint not_own_self:
#|   not self.allOwnedElements()->includes(self) |#
;;; Constraint has_owner:
#|   self.mustBeOwned() implies owner->notEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Element|))
  (WITH-OCL-CONTEXT (|Element|)
    (WITH-CONSTRAINT ("not_own_self")
      (OCL-NOT (OCL-INCLUDES (ALL-OWNED-ELEMENTS SELF) SELF)))
    (WITH-CONSTRAINT ("has_owner")
      (OCL-IMPLIES (MUST-BE-OWNED SELF)
                   (OCL-NOT-EMPTY (%OWNER SELF))))))

;;;==================================
;;; ElementImport
;;;==================================
#|   if self.alias->notEmpty() then   self.alias else   self.importedElement.name
  endif |#
(DEFMETHOD GET-NAME
  ((SELF |ElementImport|))
  "  The query getName() returns the name under which the imported
  PackageableElement will be known in the importing namespace."
  (OCL-IF (OCL-NOT-EMPTY (%ALIAS SELF))
          (%ALIAS SELF)
          (%NAME (%IMPORTED-ELEMENT SELF))))

;;; Constraint visibility_public_or_private:
#|   self.visibility = #public or self.visibility = #private |#
;;; Constraint imported_element_is_public:
#|   self.importedElement.visibility.notEmpty() implies self.importedElement.visibility
  = #public |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ElementImport|))
  (WITH-OCL-CONTEXT (|ElementImport|)
    (WITH-CONSTRAINT ("visibility_public_or_private")
      (OCL-OR (OCL-= (%VISIBILITY SELF) :PUBLIC)
              (OCL-= (%VISIBILITY SELF) :PRIVATE)))
    (WITH-CONSTRAINT ("imported_element_is_public")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%VISIBILITY
                                   (%IMPORTED-ELEMENT SELF)))
                   (OCL-= (%VISIBILITY (%IMPORTED-ELEMENT SELF))
                          :PUBLIC)))))

;;;==================================
;;; ExceptionHandler
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ExceptionHandler|))
  (WITH-OCL-CONTEXT (|ExceptionHandler|)
    (WITH-CONSTRAINT ("exception_body") :TRUE)
    (WITH-CONSTRAINT ("result_pins") :TRUE)
    (WITH-CONSTRAINT ("one_input") :TRUE)
    (WITH-CONSTRAINT ("edge_source_target") :TRUE)))

;;;==================================
;;; ExecutionSpecification
;;;==================================
;;; Constraint same_lifeline:
#|   start.lifeline = finish.lifeline |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ExecutionSpecification|))
  (WITH-OCL-CONTEXT (|ExecutionSpecification|)
    (WITH-CONSTRAINT ("same_lifeline")
      (OCL-= (%LIFELINE (%START SELF)) (%LIFELINE (%FINISH SELF))))))

;;;==================================
;;; ExpansionRegion
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ExpansionRegion|))
  (WITH-OCL-CONTEXT (|ExpansionRegion|)
    (WITH-CONSTRAINT ("expansion_nodes") :TRUE)))

;;;==================================
;;; Extend
;;;==================================
;;; Constraint extension_points:
#|   extensionLocation->forAll (xp | extendedCase.extensionPoint->includes(xp)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Extend|))
  (WITH-OCL-CONTEXT (|Extend|)
    (WITH-CONSTRAINT ("extension_points")
      (OCL-FOR-ALL (%EXTENSION-LOCATION SELF)
                   #'(LAMBDA ($XP)
                       (OCL-INCLUDES (%EXTENSION-POINT
                                      (%EXTENDED-CASE SELF))
                                     $XP))))))

;;;==================================
;;; Extension
;;;==================================
#|   (ownedEnd->lowerBound() = 1) |#
(DEFMETHOD IS-REQUIRED.1
  ((SELF |Extension|))
  "  The query isRequired() is true if the owned end has a multiplicity
  with the lower bound of 1."
  (OCL-= (LOWER-BOUND (%OWNED-END SELF)) 1))

#|   metaclassEnd().type |#
(DEFMETHOD METACLASS.1
  ((SELF |Extension|))
  "  The query metaclass() returns the metaclass that is being extended
  (as opposed to the extending stereotype)."
  (%TYPE (METACLASS-END SELF)))

#|   memberEnd->reject(ownedEnd) |#
(DEFMETHOD METACLASS-END
  ((SELF |Extension|))
  "  The query metaclassEnd() returns the Property that is typed by
  a metaclass (as opposed to a stereotype)."
  (OCL-REJECT (%MEMBER-END SELF)
              #'(LAMBDA (%VAR-8) (%OWNED-END %VAR-8))))

;;; Constraint non_owned_end:
#|   metaclassEnd()->notEmpty() and metaclass()->oclIsKindOf(Class) |#
;;; Constraint is_binary:
#|   memberEnd->size() = 2 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Extension|))
  (WITH-OCL-CONTEXT (|Extension|)
    (WITH-CONSTRAINT ("non_owned_end")
      (OCL-AND (OCL-NOT-EMPTY (METACLASS-END SELF))
               (OCL-IS-KIND-OF (METACLASS SELF) (find-class '|Class|))))
    (WITH-CONSTRAINT ("is_binary")
      (OCL-= (OCL-SIZE (%MEMBER-END SELF)) 2))))

;;;==================================
;;; ExtensionEnd
;;;==================================
;;; Constraint multiplicity:
#|   (self->lowerBound() = 0 or self->lowerBound() = 1) and self->upperBound()
  = 1 |#
;;; Constraint aggregation:
#|   self.aggregation = #composite |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ExtensionEnd|))
  (WITH-OCL-CONTEXT (|ExtensionEnd|)
    (WITH-CONSTRAINT ("multiplicity")
      (OCL-AND (OCL-OR (OCL-= (LOWER-BOUND SELF) 0)
                       (OCL-= (LOWER-BOUND SELF) 1))
               (OCL-= (UPPER-BOUND SELF) 1)))
    (WITH-CONSTRAINT ("aggregation")
      (OCL-= (%AGGREGATION SELF) :COMPOSITE))))

;;;==================================
;;; ExtensionPoint
;;;==================================
;;; Constraint must_have_name:
#|   self.name->notEmpty () |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ExtensionPoint|))
  (WITH-OCL-CONTEXT (|ExtensionPoint|)
    (WITH-CONSTRAINT ("must_have_name") (OCL-NOT-EMPTY (%NAME SELF)))))

;;;==================================
;;; FinalNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |FinalNode|))
  (WITH-OCL-CONTEXT (|FinalNode|)
    (WITH-CONSTRAINT ("no_outgoing_edges") :TRUE)))

;;;==================================
;;; FinalState
;;;==================================
;;; Constraint no_outgoing_transitions:
#|   self.outgoing->size() = 0 |#
;;; Constraint no_regions:
#|   self.region->size() = 0 |#
;;; Constraint cannot_reference_submachine:
#|   self.submachine->isEmpty() |#
;;; Constraint no_entry_behavior:
#|   self.entry->isEmpty() |#
;;; Constraint no_exit_behavior:
#|   self.exit->isEmpty() |#
;;; Constraint no_state_behavior:
#|   self.doActivity->isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |FinalState|))
  (WITH-OCL-CONTEXT (|FinalState|)
    (WITH-CONSTRAINT ("no_outgoing_transitions")
      (OCL-= (OCL-SIZE (%OUTGOING SELF)) 0))
    (WITH-CONSTRAINT ("no_regions")
      (OCL-= (OCL-SIZE (%REGION SELF)) 0))
    (WITH-CONSTRAINT ("cannot_reference_submachine")
      (OCL-IS-EMPTY (%SUBMACHINE SELF)))
    (WITH-CONSTRAINT ("no_entry_behavior")
      (OCL-IS-EMPTY (%ENTRY SELF)))
    (WITH-CONSTRAINT ("no_exit_behavior") (OCL-IS-EMPTY (%EXIT SELF)))
    (WITH-CONSTRAINT ("no_state_behavior")
      (OCL-IS-EMPTY (%DO-ACTIVITY SELF)))))

;;;==================================
;;; ForkNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ForkNode|))
  (WITH-OCL-CONTEXT (|ForkNode|)
    (WITH-CONSTRAINT ("one_incoming_edge") :TRUE)
    (WITH-CONSTRAINT ("edges") :TRUE)))

;;;==================================
;;; FunctionBehavior
;;;==================================
;;; Constraint one_output_parameter:
#|   self.ownedParameter->   select(p | p.direction=#out or p.direction=#inout
  or p.direction=#return)->size() >= 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |FunctionBehavior|))
  (WITH-OCL-CONTEXT (|FunctionBehavior|)
    (WITH-CONSTRAINT ("one_output_parameter")
      (OCL->= (OCL-SIZE (OCL-SELECT (%OWNED-PARAMETER SELF)
                                    #'(LAMBDA
                                       ($P)
                                       (OCL-OR
                                        (OCL-OR
                                         (OCL-= (%DIRECTION $P) :OUT)
                                         (OCL-=
                                          (%DIRECTION $P)
                                          :INOUT))
                                        (OCL-=
                                         (%DIRECTION $P)
                                         :RETURN)))))
              1))))

;;;==================================
;;; Gate
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Gate|))
  (WITH-OCL-CONTEXT (|Gate|)
    (WITH-CONSTRAINT ("messages_actual_gate") :TRUE)
    (WITH-CONSTRAINT ("messages_combined_fragment") :TRUE)))

;;;==================================
;;; Generalization
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Generalization|))
  (WITH-OCL-CONTEXT (|Generalization|)
    (WITH-CONSTRAINT ("generalization_same_classifier") :TRUE)))

;;;==================================
;;; GeneralizationSet
;;;==================================
;;; Constraint generalization_same_classifier:
#|   generalization->collect(g | g.general)->asSet()->size() <= 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |GeneralizationSet|))
  (WITH-OCL-CONTEXT (|GeneralizationSet|)
    (WITH-CONSTRAINT ("generalization_same_classifier")
      (OCL-<= (OCL-SIZE (OCL-AS-SET (OCL-COLLECT
                                     (%GENERALIZATION SELF)
                                     #'(LAMBDA ($G) (%GENERAL $G)))))
              1))
    (WITH-CONSTRAINT ("maps_to_generalization_set") :TRUE)))

;;;==================================
;;; InformationFlow
;;;==================================
;;; Constraint convey_classifiers:
#|   self.conveyed.represented->forAll(p | p->oclIsKindOf(Class) or
  oclIsKindOf(Interface)   or oclIsKindOf(InformationItem) or oclIsKindOf(Signal)
  or oclIsKindOf(Component)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InformationFlow|))
  (WITH-OCL-CONTEXT (|InformationFlow|)
    (WITH-CONSTRAINT ("must_conform") :TRUE)
    (WITH-CONSTRAINT ("convey_classifiers")
      (OCL-FOR-ALL (%REPRESENTED (%CONVEYED SELF))
                   #'(LAMBDA ($P)
                       (OCL-OR (OCL-OR
                                (OCL-OR
                                 (OCL-OR
                                  (OCL-IS-KIND-OF $P (find-class '|Class|))
                                  (OCL-IS-KIND-OF SELF (find-class '|Interface|)))
                                 (OCL-IS-KIND-OF
                                  SELF
                                  '|InformationItem|))
                                (OCL-IS-KIND-OF SELF (find-class '|Signal|)))
                               (OCL-IS-KIND-OF SELF (find-class '|Component|))))))))

;;;==================================
;;; InformationItem
;;;==================================
;;; Constraint sources_and_targets:
#|   (self.source->forAll(p | p->oclIsKindOf(Actor) or oclIsKindOf(Node)
  or   oclIsKindOf(UseCase) or oclIsKindOf(Artifact) or oclIsKindOf(Class)
  or   oclIsKindOf(Component) or oclIsKindOf(Port) or oclIsKindOf(Property)
  or   oclIsKindOf(Interface) or oclIsKindOf(Package) or oclIsKindOf(ActivityNode)
  or   oclIsKindOf(ActivityPartition) or oclIsKindOf(InstanceSpecification)))
  and     (self.target->forAll(p | p->oclIsKindOf(Actor) or oclIsKindOf(Node)
  or       oclIsKindOf(UseCase) or oclIsKindOf(Artifact) or oclIsKindOf(Class)
  or       oclIsKindOf(Component) or oclIsKindOf(Port) or oclIsKindOf(Property)
  or       oclIsKindOf(Interface) or oclIsKindOf(Package) or oclIsKindOf(ActivityNode)
  or       oclIsKindOf(ActivityPartition) or oclIsKindOf(InstanceSpecification))) |#
;;; Constraint has_no:
#|   self.generalization->isEmpty() and self.feature->isEmpty() |#
;;; Constraint not_instantiable:
#|   isAbstract |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InformationItem|))
  (WITH-OCL-CONTEXT (|InformationItem|)
    (WITH-CONSTRAINT ("sources_and_targets")
      (OCL-AND (OCL-FOR-ALL (%SOURCE SELF)
                            #'(LAMBDA ($P)
                                (OCL-OR
                                 (OCL-OR
                                  (OCL-OR
                                   (OCL-OR
                                    (OCL-OR
                                     (OCL-OR
                                      (OCL-OR
                                       (OCL-OR
                                        (OCL-OR
                                         (OCL-OR
                                          (OCL-OR
                                           (OCL-OR
                                            (OCL-IS-KIND-OF
                                             $P
                                             (find-class '|Actor|))
                                            (OCL-IS-KIND-OF
                                             SELF
                                             (find-class '|Node|)))
                                           (OCL-IS-KIND-OF
                                            SELF
                                            (find-class '|UseCase|)))
                                          (OCL-IS-KIND-OF
                                           SELF
                                           (find-class '|Artifact|)))
                                         (OCL-IS-KIND-OF
                                          SELF
                                          (find-class '|Class|)))
                                        (OCL-IS-KIND-OF
                                         SELF
                                         (find-class '|Component|)))
                                       (OCL-IS-KIND-OF SELF (find-class '|Port|)))
                                      (OCL-IS-KIND-OF
                                       SELF
                                       (find-class '|Property|)))
                                     (OCL-IS-KIND-OF
                                      SELF
                                      (find-class '|Interface|)))
                                    (OCL-IS-KIND-OF SELF (find-class '|Package|)))
                                   (OCL-IS-KIND-OF
                                    SELF
                                    (find-class '|ActivityNode|)))
                                  (OCL-IS-KIND-OF
                                   SELF
                                   (find-class '|ActivityPartition|)))
                                 (OCL-IS-KIND-OF
                                  SELF
                                  (find-class '|InstanceSpecification|)))))
               (OCL-FOR-ALL (%TARGET SELF)
                            #'(LAMBDA ($P)
                                (OCL-OR
                                 (OCL-OR
                                  (OCL-OR
                                   (OCL-OR
                                    (OCL-OR
                                     (OCL-OR
                                      (OCL-OR
                                       (OCL-OR
                                        (OCL-OR
                                         (OCL-OR
                                          (OCL-OR
                                           (OCL-OR
                                            (OCL-IS-KIND-OF
                                             $P
                                             (find-class '|Actor|))
                                            (OCL-IS-KIND-OF
                                             SELF
                                             (find-class '|Node|)))
                                           (OCL-IS-KIND-OF
                                            SELF
                                            (find-class '|UseCase|)))
                                          (OCL-IS-KIND-OF
                                           SELF
                                           (find-class '|Artifact|)))
                                         (OCL-IS-KIND-OF
                                          SELF
                                          (find-class '|Class|)))
                                        (OCL-IS-KIND-OF
                                         SELF
                                         (find-class '|Component|)))
                                       (OCL-IS-KIND-OF SELF (find-class '|Port|)))
                                      (OCL-IS-KIND-OF
                                       SELF
                                       (find-class '|Property|)))
                                     (OCL-IS-KIND-OF
                                      SELF
                                      (find-class '|Interface|)))
                                    (OCL-IS-KIND-OF SELF (find-class '|Package|)))
                                   (OCL-IS-KIND-OF
                                    SELF
                                    (find-class '|ActivityNode|)))
                                  (OCL-IS-KIND-OF
                                   SELF
                                   (find-class '|ActivityPartition|)))
                                 (OCL-IS-KIND-OF
                                  SELF
                                  (find-class '|InstanceSpecification|)))))))
    (WITH-CONSTRAINT ("has_no")
      (OCL-AND (OCL-IS-EMPTY (%GENERALIZATION SELF))
               (OCL-IS-EMPTY (%FEATURE SELF))))
    (WITH-CONSTRAINT ("not_instantiable") (%IS-ABSTRACT SELF))))

;;;==================================
;;; InitialNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InitialNode|))
  (WITH-OCL-CONTEXT (|InitialNode|)
    (WITH-CONSTRAINT ("no_incoming_edges") :TRUE)
    (WITH-CONSTRAINT ("control_edges") :TRUE)))

;;;==================================
;;; InputPin
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InputPin|))
  (WITH-OCL-CONTEXT (|InputPin|)
    (WITH-CONSTRAINT ("outgoing_edges_structured_only") :TRUE)))

;;;==================================
;;; InstanceSpecification
;;;==================================
;;; Constraint defining_feature:
#|   slot->forAll(s | classifier->exists (c | c.allFeatures()->includes
  (s.definingFeature))) |#
;;; Constraint structural_feature:
#|   classifier->forAll(c | (c.allFeatures()->forAll(f | slot->select(s
  | s.definingFeature = f)->size() <= 1))) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InstanceSpecification|))
  (WITH-OCL-CONTEXT (|InstanceSpecification|)
    (WITH-CONSTRAINT ("defining_feature")
      (OCL-FOR-ALL (%SLOT SELF)
                   #'(LAMBDA ($S)
                       (OCL-EXISTS (%CLASSIFIER SELF)
                                   #'(LAMBDA
                                      ($C)
                                      (OCL-INCLUDES
                                       (ALL-FEATURES $C)
                                       (%DEFINING-FEATURE $S)))))))
    (WITH-CONSTRAINT ("structural_feature")
      (OCL-FOR-ALL (%CLASSIFIER SELF)
                   #'(LAMBDA ($C)
                       (OCL-FOR-ALL (ALL-FEATURES $C)
                                    #'(LAMBDA
                                       ($F)
                                       (OCL-<=
                                        (OCL-SIZE
                                         (OCL-SELECT
                                          (%SLOT SELF)
                                          #'(LAMBDA
                                             ($S)
                                             (OCL-=
                                              (%DEFINING-FEATURE $S)
                                              $F))))
                                        1))))))
    (WITH-CONSTRAINT ("deployment_target") :TRUE)
    (WITH-CONSTRAINT ("deployment_artifact") :TRUE)))

;;;==================================
;;; InteractionConstraint
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InteractionConstraint|))
  (WITH-OCL-CONTEXT (|InteractionConstraint|)
    (WITH-CONSTRAINT ("dynamic_variables") :TRUE)
    (WITH-CONSTRAINT ("global_data") :TRUE)
    (WITH-CONSTRAINT ("minint_maxint") :TRUE)
    (WITH-CONSTRAINT ("minint_non_negative") :TRUE)
    (WITH-CONSTRAINT ("maxint_positive") :TRUE)
    (WITH-CONSTRAINT ("maxint_greater_equal_minint") :TRUE)))

;;;==================================
;;; InteractionOperand
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InteractionOperand|))
  (WITH-OCL-CONTEXT (|InteractionOperand|)
    (WITH-CONSTRAINT ("guard_directly_prior") :TRUE)
    (WITH-CONSTRAINT ("guard_contain_references") :TRUE)))

;;;==================================
;;; InteractionUse
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InteractionUse|))
  (WITH-OCL-CONTEXT (|InteractionUse|)
    (WITH-CONSTRAINT ("gates_match") :TRUE)
    (WITH-CONSTRAINT ("all_lifelines") :TRUE)
    (WITH-CONSTRAINT ("arguments_correspond_to_parameters") :TRUE)
    (WITH-CONSTRAINT ("arguments_are_constants") :TRUE)))

;;;==================================
;;; Interface
;;;==================================
;;; Constraint visibility:
#|   self.feature->forAll(f | f.visibility = #public) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Interface|))
  (WITH-OCL-CONTEXT (|Interface|)
    (WITH-CONSTRAINT ("visibility")
      (OCL-FOR-ALL (%FEATURE SELF)
                   #'(LAMBDA ($F) (OCL-= (%VISIBILITY $F) :PUBLIC))))))

;;;==================================
;;; InterruptibleActivityRegion
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InterruptibleActivityRegion|))
  (WITH-OCL-CONTEXT (|InterruptibleActivityRegion|)
    (WITH-CONSTRAINT ("interrupting_edges") :TRUE)))

;;;==================================
;;; InvocationAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |InvocationAction|))
  (WITH-OCL-CONTEXT (|InvocationAction|)
    (WITH-CONSTRAINT ("on_port_receiver") :TRUE)))

;;;==================================
;;; JoinNode
;;;==================================
;;; Constraint one_outgoing_edge:
#|   self.outgoing->size() = 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |JoinNode|))
  (WITH-OCL-CONTEXT (|JoinNode|)
    (WITH-CONSTRAINT ("one_outgoing_edge")
      (OCL-= (OCL-SIZE (%OUTGOING SELF)) 1))))

;;;==================================
;;; Lifeline
;;;==================================
;;; Constraint selector_specified:
#|   (self.selector->isEmpty() implies not self.represents.isMultivalued())
  or (not self.selector->isEmpty() implies self.represents.isMultivalued()) |#
;;; Constraint same_classifier:
#|   if (represents->notEmpty()) then if selector->notEmpty() then
  represents.isMultivalued() else not represents.isMultivalued()
  endif else false endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Lifeline|))
  (WITH-OCL-CONTEXT (|Lifeline|)
    (WITH-CONSTRAINT ("interaction_uses_share_lifeline") :TRUE)
    (WITH-CONSTRAINT ("selector_specified")
      (OCL-OR (OCL-IMPLIES (OCL-IS-EMPTY (%SELECTOR SELF))
                           (OCL-NOT (IS-MULTIVALUED
                                     (%REPRESENTS SELF))))
              (OCL-IMPLIES (OCL-NOT (OCL-IS-EMPTY (%SELECTOR SELF)))
                           (IS-MULTIVALUED (%REPRESENTS SELF)))))
    (WITH-CONSTRAINT ("same_classifier")
      (OCL-IF (OCL-NOT-EMPTY (%REPRESENTS SELF))
              (OCL-IF (OCL-NOT-EMPTY (%SELECTOR SELF))
                      (IS-MULTIVALUED (%REPRESENTS SELF))
                      (OCL-NOT (IS-MULTIVALUED (%REPRESENTS SELF))))
              :FALSE))))

;;;==================================
;;; LinkAction
;;;==================================
#|   self.endData->asSequence().first().end.association |#
(DEFMETHOD ASSOCIATION
  ((SELF |LinkAction|))
  "  The association operates on LinkAction. It returns the association
  of the action."
  (%ASSOCIATION (%END (OCL-FIRST (OCL-AS-SEQUENCE (%END-DATA SELF))))))

;;; Constraint same_association:
#|   self.endData->collect(end) = self.association()->collect(connection) |#
;;; Constraint not_static:
#|   self.endData->forAll(end.isStatic = false) |#
;;; Constraint same_pins:
#|   self.input->asSet() = let ledpins : Set = self.endData->collect(value)
  in if self.oclIsKindOf(LinkEndCreationData) then ledpins->union(self.endData.oclAsType(LinkEndCreationData).insertAt)
  else ledpins endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |LinkAction|))
  (WITH-OCL-CONTEXT (|LinkAction|)
    (WITH-CONSTRAINT ("same_association")
      (OCL-= (OCL-COLLECT (%END-DATA SELF)
                          #'(LAMBDA (%VAR-9) (%END %VAR-9)))
             (OCL-COLLECT (ASSOCIATION SELF)
                          #'(LAMBDA (%VAR-10) (%CONNECTION %VAR-10)))))
    (WITH-CONSTRAINT ("not_static")
      (OCL-FOR-ALL (%END-DATA SELF)
                   #'(LAMBDA (%VAR-11)
                       (OCL-= (%IS-STATIC (%END %VAR-11)) :FALSE))))
    (WITH-CONSTRAINT ("same_pins")
      (OCL-= (OCL-AS-SET (%INPUT SELF))
             (LET (($LEDPINS
                    (OCL-COLLECT (%END-DATA SELF)
                                 #'(LAMBDA
                                    (%VAR-12)
                                    (%VALUE %VAR-12)))))
               (OCL-ASSERT (|Set| $LEDPINS))
               (OCL-IF (OCL-IS-KIND-OF SELF (find-class '|LinkEndCreationData|))
                       (OCL-UNION $LEDPINS
                                  (%INSERT-AT
                                   (OCL-AS-TYPE
                                    (%END-DATA SELF)
                                    (find-class '|LinkEndCreationData|))))
                       $LEDPINS))))))

;;;==================================
;;; LinkEndCreationData
;;;==================================
;;; Constraint single_input_pin:
#|   end.ordering = #ordered implies  (insertAt->size() = 1 and insertAt.type.oclIsKindOf(UnlimitedNatural)
  and insertAt.is(1,1))   or insertAt->size() = 0 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |LinkEndCreationData|))
  (WITH-OCL-CONTEXT (|LinkEndCreationData|)
    (WITH-CONSTRAINT ("single_input_pin")
      (OCL-IMPLIES (OCL-= (%ORDERING (%END SELF)) :ORDERED)
                   (OCL-OR (OCL-AND (OCL-AND
                                     (OCL-=
                                      (OCL-SIZE (%INSERT-AT SELF))
                                      1)
                                     (OCL-IS-KIND-OF
                                      (%TYPE (%INSERT-AT SELF))
                                      (find-class '|UnlimitedNatural|)))
                                    (IS (%INSERT-AT SELF) 1 1))
                           (OCL-= (OCL-SIZE (%INSERT-AT SELF)) 0))))))

;;;==================================
;;; LinkEndData
;;;==================================
;;; Constraint property_is_association_end:
#|   self.end.association->size() = 1 |#
;;; Constraint same_type:
#|   self.value.type = self.end.type |#
;;; Constraint multiplicity:
#|   self.value.is(1,1) |#
;;; Constraint qualifiers:
#|   self.qualifier->collect(qualifier) = self.end.qualifier |#
;;; Constraint end_object_input_pin:
#|   self.value->excludesAll(self.qualifier.value) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |LinkEndData|))
  (WITH-OCL-CONTEXT (|LinkEndData|)
    (WITH-CONSTRAINT ("property_is_association_end")
      (OCL-= (OCL-SIZE (%ASSOCIATION (%END SELF))) 1))
    (WITH-CONSTRAINT ("same_type")
      (OCL-= (%TYPE (%VALUE SELF)) (%TYPE (%END SELF))))
    (WITH-CONSTRAINT ("multiplicity") (IS (%VALUE SELF) 1 1))
    (WITH-CONSTRAINT ("qualifiers")
      (OCL-= (OCL-COLLECT (%QUALIFIER SELF)
                          #'(LAMBDA (%VAR-13) (%QUALIFIER %VAR-13)))
             (%QUALIFIER (%END SELF))))
    (WITH-CONSTRAINT ("end_object_input_pin")
      (OCL-EXCLUDES-ALL (%VALUE SELF) (%VALUE (%QUALIFIER SELF))))))

;;;==================================
;;; LinkEndDestructionData
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |LinkEndDestructionData|))
  (WITH-OCL-CONTEXT (|LinkEndDestructionData|)
    (WITH-CONSTRAINT ("destroy_link_action") :TRUE)
    (WITH-CONSTRAINT ("unlimited_natural_and_multiplicity") :TRUE)))

;;;==================================
;;; LiteralBoolean
;;;==================================
#|   value |#
(DEFMETHOD BOOLEAN-VALUE
  ((SELF |LiteralBoolean|))
  "  The query booleanValue() gives the value."
  (%VALUE SELF))

#|   true |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |LiteralBoolean|))
  "  The query isComputable() is redefined to be true."
  :TRUE)

;;;==================================
;;; LiteralInteger
;;;==================================
#|   value |#
(DEFMETHOD INTEGER-VALUE
  ((SELF |LiteralInteger|))
  "  The query integerValue() gives the value."
  (%VALUE SELF))

#|   true |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |LiteralInteger|))
  "  The query isComputable() is redefined to be true."
  :TRUE)

;;;==================================
;;; LiteralNull
;;;==================================
#|   true |#
(DEFMETHOD IS-NULL
  ((SELF |LiteralNull|))
  "  The query isNull() returns true."
  :TRUE)

#|   true |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |LiteralNull|))
  "  The query isComputable() is redefined to be true."
  :TRUE)

;;;==================================
;;; LiteralString
;;;==================================
#|   value |#
(DEFMETHOD STRING-VALUE
  ((SELF |LiteralString|))
  "  The query stringValue() gives the value."
  (%VALUE SELF))

#|   true |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |LiteralString|))
  "  The query isComputable() is redefined to be true."
  :TRUE)

;;;==================================
;;; LiteralUnlimitedNatural
;;;==================================
#|   value |#
(DEFMETHOD UNLIMITED-VALUE
  ((SELF |LiteralUnlimitedNatural|))
  "  The query unlimitedValue() gives the value."
  (%VALUE SELF))

#|   true |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |LiteralUnlimitedNatural|))
  "  The query isComputable() is redefined to be true."
  :TRUE)

;;;==================================
;;; LoopNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |LoopNode|))
  (WITH-OCL-CONTEXT (|LoopNode|)
    (WITH-CONSTRAINT ("input_edges") :TRUE)
    (WITH-CONSTRAINT ("body_output_pins") :TRUE)
    (WITH-CONSTRAINT ("result_no_incoming") :TRUE)))

;;;==================================
;;; MergeNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |MergeNode|))
  (WITH-OCL-CONTEXT (|MergeNode|)
    (WITH-CONSTRAINT ("one_outgoing_edge") :TRUE)
    (WITH-CONSTRAINT ("edges") :TRUE)))

;;;==================================
;;; Message
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Message|))
  (WITH-OCL-CONTEXT (|Message|)
    (WITH-CONSTRAINT ("signature_is_signal") :TRUE)
    (WITH-CONSTRAINT ("signature_is_operation") :TRUE)
    (WITH-CONSTRAINT ("occurrence_specifications") :TRUE)
    (WITH-CONSTRAINT ("cannot_cross_boundaries") :TRUE)
    (WITH-CONSTRAINT ("signature_refer_to") :TRUE)
    (WITH-CONSTRAINT ("sending_receiving_message_event") :TRUE)
    (WITH-CONSTRAINT ("arguments") :TRUE)))

;;;==================================
;;; MultiplicityElement
;;;==================================
#|   def: is (lowerbound : Integer, upperbound : Integer) (lowerbound
  = self.lower and upperbound = self.upper) |#
(DEFMETHOD IS
  ((SELF |MultiplicityElement|) $LOWERBOUND $UPPERBOUND)
  (OCL-ASSERT (|Integer| $LOWERBOUND))
  (OCL-ASSERT (|Integer| $UPPERBOUND))
  (OCL-AND (OCL-= $LOWERBOUND (%LOWER SELF))
           (OCL-= $UPPERBOUND (%UPPER SELF))))

#|   lowerBound() |#
(DEFMETHOD LOWER.1
  ((SELF |MultiplicityElement|))
  "  The derived lower attribute must equal the lowerBound."
  (LOWER-BOUND SELF))

#|   upperBound() > 1 |#
(DEFMETHOD IS-MULTIVALUED
  ((SELF |MultiplicityElement|))
  "  The query isMultivalued() checks whether this multiplicity has
  an upper bound greater than one."
  (OCL-> (UPPER-BOUND SELF) 1))

#|   upperBound()->notEmpty() |#
(DEFMETHOD IS-MULTIVALUED
  ((SELF |MultiplicityElement|))
  "  The query isMultivalued() checks whether this multiplicity has
  an upper bound greater than one."
  (OCL-NOT-EMPTY (UPPER-BOUND SELF)))

#|   if lowerValue->isEmpty() then 1 else lowerValue.integerValue()
  endif |#
(DEFMETHOD LOWER-BOUND
  ((SELF |MultiplicityElement|))
  "  The query lowerBound() returns the lower bound of the multiplicity
  as an integer."
  (OCL-IF (OCL-IS-EMPTY (%LOWER-VALUE SELF))
          1
          (INTEGER-VALUE (%LOWER-VALUE SELF))))

#|   upperBound() |#
(DEFMETHOD UPPER.1
  ((SELF |MultiplicityElement|))
  "  The derived upper attribute must equal the upperBound."
  (UPPER-BOUND SELF))

#|   def: includesCardinality (C : Integer) (lowerBound() <= C) and
  (upperBound() >= C) |#
(DEFMETHOD INCLUDES-CARDINALITY
  ((SELF |MultiplicityElement|) $C)
  (OCL-ASSERT (|Integer| $C))
  (OCL-AND (OCL-<= (LOWER-BOUND SELF) $C)
           (OCL->= (UPPER-BOUND SELF) $C)))

#|   def: includesCardinality (C : Integer) upperBound()->notEmpty()
  and lowerBound()->notEmpty() |#
(DEFMETHOD INCLUDES-CARDINALITY
  ((SELF |MultiplicityElement|) $C)
  (OCL-ASSERT (|Integer| $C))
  (OCL-AND (OCL-NOT-EMPTY (UPPER-BOUND SELF))
           (OCL-NOT-EMPTY (LOWER-BOUND SELF))))

#|   if upperValue.oclIsUndefined() then 1 else upperValue.unlimitedValue()
  endif |#
(DEFMETHOD UPPER-BOUND
  ((SELF |MultiplicityElement|))
  "  The query upperBound() returns the upper bound of the multiplicity
  for a bounded multiplicity as an unlimited natural."
  (OCL-IF (OCL-IS-UNDEFINED (%UPPER-VALUE SELF))
          1
          (UNLIMITED-VALUE (%UPPER-VALUE SELF))))

#|   def: includesMultiplicity (M : MultiplicityElement) (self.lowerBound()
  <= M.lowerBound()) and (self.upperBound() >= M.upperBound()) |#
(DEFMETHOD INCLUDES-MULTIPLICITY
  ((SELF |MultiplicityElement|) $M)
  (OCL-ASSERT (|MultiplicityElement| $M))
  (OCL-AND (OCL-<= (LOWER-BOUND SELF) (LOWER-BOUND $M))
           (OCL->= (UPPER-BOUND SELF) (UPPER-BOUND $M))))

#|   def: includesMultiplicity (M : MultiplicityElement) self.upperBound()->notEmpty()
  and self.lowerBound()->notEmpty() and M.upperBound()->notEmpty()
  and M.lowerBound()->notEmpty() |#
(DEFMETHOD INCLUDES-MULTIPLICITY
  ((SELF |MultiplicityElement|) $M)
  (OCL-ASSERT (|MultiplicityElement| $M))
  (OCL-AND (OCL-AND (OCL-AND (OCL-NOT-EMPTY (UPPER-BOUND SELF))
                             (OCL-NOT-EMPTY (LOWER-BOUND SELF)))
                    (OCL-NOT-EMPTY (UPPER-BOUND $M)))
           (OCL-NOT-EMPTY (LOWER-BOUND $M))))

;;; Constraint upper_gt_0:
#|   not upperBound().oclIsUndefined() implies upperBound() > 0 |#
;;; Constraint lower_ge_0:
#|   not lowerBound().oclIsUndefined() implies lowerBound() >= 0 |#
;;; Constraint upper_ge_lower:
#|   not upperBound().oclIsUndefined() and not lowerBound().oclIsUndefined()
  implies upperBound() >= lowerBound() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |MultiplicityElement|))
  (WITH-OCL-CONTEXT (|MultiplicityElement|)
    (WITH-CONSTRAINT ("upper_gt_0")
      (OCL-IMPLIES (OCL-NOT (OCL-IS-UNDEFINED (UPPER-BOUND SELF)))
                   (OCL-> (UPPER-BOUND SELF) 0)))
    (WITH-CONSTRAINT ("lower_ge_0")
      (OCL-IMPLIES (OCL-NOT (OCL-IS-UNDEFINED (LOWER-BOUND SELF)))
                   (OCL->= (LOWER-BOUND SELF) 0)))
    (WITH-CONSTRAINT ("upper_ge_lower")
      (OCL-IMPLIES (OCL-AND (OCL-NOT (OCL-IS-UNDEFINED
                                      (UPPER-BOUND SELF)))
                            (OCL-NOT (OCL-IS-UNDEFINED
                                      (LOWER-BOUND SELF))))
                   (OCL->= (UPPER-BOUND SELF) (LOWER-BOUND SELF))))
    (WITH-CONSTRAINT ("value_specification_no_side_effects") :TRUE)
    (WITH-CONSTRAINT ("value_specification_constant") :TRUE)))

;;;==================================
;;; NamedElement
;;;==================================
#|   '::' |#
(DEFMETHOD SEPARATOR
  ((SELF |NamedElement|))
  "  The query separator() gives the string that is used to separate
  names when constructing a qualified name."
  "::")

#|   def: isDistinguishableFrom (n : NamedElement, ns : Namespace)
  if self.oclIsKindOf(n.oclType()) or n.oclIsKindOf(self.oclType())
  then ns.getNamesOfMember(self)->intersection(ns.getNamesOfMember(n))->isEmpty()
  else true endif |#
(DEFMETHOD IS-DISTINGUISHABLE-FROM
  ((SELF |NamedElement|) $N $NS)
  (OCL-ASSERT (|NamedElement| $N))
  (OCL-ASSERT (|Namespace| $NS))
  (OCL-IF (OCL-OR (OCL-IS-KIND-OF SELF (OCL-TYPE $N))
                  (OCL-IS-KIND-OF $N (OCL-TYPE SELF)))
          (OCL-IS-EMPTY (OCL-INTERSECTION (GET-NAMES-OF-MEMBER
                                           $NS
                                           SELF)
                                          (GET-NAMES-OF-MEMBER
                                           $NS
                                           $N)))
          :TRUE))

#|   if self.namespace->isEmpty() then Sequence{} else self.namespace.allNamespaces()->prepend(self.namespace)
  endif |#
(DEFMETHOD ALL-NAMESPACES
  ((SELF |NamedElement|))
  "  The query allNamespaces() gives the sequence of namespaces in
  which the NamedElement is nested, working outwards."
  (OCL-IF (OCL-IS-EMPTY (%NAMESPACE SELF))
          (MAKE-INSTANCE '|Sequence| :VALUE NIL)
          (OCL-PREPEND (ALL-NAMESPACES (%NAMESPACE SELF))
                       (%NAMESPACE SELF))))

#|   if self.name->notEmpty() and self.allNamespaces()->select(ns
  | ns.name->isEmpty())->isEmpty() then      self.allNamespaces()->iterate(
  ns : Namespace; result: String = self.name | ns.name->union(self.separator())->union(result))
  else     Set{} endif |#
(DEFMETHOD QUALIFIED-NAME.1
  ((SELF |NamedElement|))
  "  When there is a name, and all of the containing namespaces have
  a name, the qualified name is constructed from the names of the
  containing namespaces."
  (OCL-IF (OCL-AND (OCL-NOT-EMPTY (%NAME SELF))
                   (OCL-IS-EMPTY (OCL-SELECT
                                  (ALL-NAMESPACES SELF)
                                  #'(LAMBDA
                                     ($NS)
                                     (OCL-IS-EMPTY (%NAME $NS))))))
          (OCL-ITERATE (ALL-NAMESPACES SELF)
                       $NS
                       $RESULT
                       (%NAME SELF)
                       (OCL-UNION (OCL-UNION
                                   (%NAME $NS)
                                   (SEPARATOR SELF))
                                  $RESULT))
          (MAKE-INSTANCE '|Set| :VALUE NIL)))

;;; Constraint has_no_qualified_name:
#|   (self.name->isEmpty() or self.allNamespaces()->select(ns | ns.name->isEmpty())->notEmpty())
    implies self.qualifiedName->isEmpty() |#
;;; Constraint has_qualified_name:
#|   (self.name->notEmpty() and self.allNamespaces()->select(ns |
  ns.name->isEmpty())->isEmpty()) implies   self.qualifiedName
  = self.allNamespaces()->iterate( ns : Namespace; result: String
  = self.name | ns.name->union(self.separator())->union(result)) |#
;;; Constraint visibility_needs_ownership:
#|   namespace->isEmpty() implies visibility->isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |NamedElement|))
  (WITH-OCL-CONTEXT (|NamedElement|)
    (WITH-CONSTRAINT ("has_no_qualified_name")
      (OCL-IMPLIES (OCL-OR (OCL-IS-EMPTY (%NAME SELF))
                           (OCL-NOT-EMPTY (OCL-SELECT
                                           (ALL-NAMESPACES SELF)
                                           #'(LAMBDA
                                              ($NS)
                                              (OCL-IS-EMPTY
                                               (%NAME $NS))))))
                   (OCL-IS-EMPTY (%QUALIFIED-NAME SELF))))
    (WITH-CONSTRAINT ("has_qualified_name")
      (OCL-IMPLIES (OCL-AND (OCL-NOT-EMPTY (%NAME SELF))
                            (OCL-IS-EMPTY (OCL-SELECT
                                           (ALL-NAMESPACES SELF)
                                           #'(LAMBDA
                                              ($NS)
                                              (OCL-IS-EMPTY
                                               (%NAME $NS))))))
                   (OCL-= (%QUALIFIED-NAME SELF)
                          (OCL-ITERATE (ALL-NAMESPACES SELF)
                                       $NS
                                       $RESULT
                                       (%NAME SELF)
                                       (OCL-UNION
                                        (OCL-UNION
                                         (%NAME $NS)
                                         (SEPARATOR SELF))
                                        $RESULT)))))
    (WITH-CONSTRAINT ("visibility_needs_ownership")
      (OCL-IMPLIES (OCL-IS-EMPTY (%NAMESPACE SELF))
                   (OCL-IS-EMPTY (%VISIBILITY SELF))))))

;;;==================================
;;; Namespace
;;;==================================
#|   def: excludeCollisions (imps : PackageableElement) imps->reject(imp1
  | imps.exists(imp2 | not imp1.isDistinguishableFrom(imp2, self))) |#
(DEFMETHOD EXCLUDE-COLLISIONS
  ((SELF |Namespace|) $IMPS)
  (OCL-ASSERT (|PackageableElement| $IMPS))
  (OCL-REJECT $IMPS
              #'(LAMBDA ($IMP1)
                  (OCL-EXISTS $IMPS
                              #'(LAMBDA
                                 ($IMP2)
                                 (OCL-NOT
                                  (IS-DISTINGUISHABLE-FROM
                                   $IMP1
                                   $IMP2
                                   SELF)))))))

#|   self.member->forAll( memb | self.member->excluding(memb)->forAll(other
  | memb.isDistinguishableFrom(other, self))) |#
(DEFMETHOD MEMBERS-ARE-DISTINGUISHABLE
  ((SELF |Namespace|))
  "  The Boolean query membersAreDistinguishable() determines whether
  all of the namespace's members are distinguishable within it."
  (OCL-FOR-ALL (%MEMBER SELF)
               #'(LAMBDA ($MEMB)
                   (OCL-FOR-ALL (OCL-EXCLUDING (%MEMBER SELF) $MEMB)
                                #'(LAMBDA
                                   ($OTHER)
                                   (IS-DISTINGUISHABLE-FROM
                                    $MEMB
                                    $OTHER
                                    SELF))))))

#|   def: getNamesOfMember (element : NamedElement) if self.ownedMember
  ->includes(element) then if element.name.oclIsUndefined() then
  Set{} else Set{}->including(element.name) endif else let elementImports
  = self.elementImport->select(ei | ei.importedElement = element)
  in   if elementImports->notEmpty()   then elementImports->collect(el
  | el.getName())   else self.packageImport->select(pi | pi.importedPackage.visibleMembers()->includes(element))->
  collect(pi | pi.importedPackage.getNamesOfMember(element))  
  endif endif |#
(DEFMETHOD GET-NAMES-OF-MEMBER
  ((SELF |Namespace|) $ELEMENT)
  (OCL-ASSERT (|NamedElement| $ELEMENT))
  (OCL-IF (OCL-INCLUDES (%OWNED-MEMBER SELF) $ELEMENT)
          (OCL-IF (OCL-IS-UNDEFINED (%NAME $ELEMENT))
                  (MAKE-INSTANCE '|Set| :VALUE NIL)
                  (OCL-INCLUDING (MAKE-INSTANCE '|Set| :VALUE NIL)
                                 (%NAME $ELEMENT)))
          (LET (($ELEMENTIMPORTS
                 (OCL-SELECT (%ELEMENT-IMPORT SELF)
                             #'(LAMBDA
                                ($EI)
                                (OCL-=
                                 (%IMPORTED-ELEMENT $EI)
                                 $ELEMENT)))))
            (OCL-IF (OCL-NOT-EMPTY $ELEMENTIMPORTS)
                    (OCL-COLLECT $ELEMENTIMPORTS
                                 #'(LAMBDA ($EL) (GET-NAME $EL)))
                    (OCL-COLLECT (OCL-SELECT
                                  (%PACKAGE-IMPORT SELF)
                                  #'(LAMBDA
                                     ($PI)
                                     (OCL-INCLUDES
                                      (VISIBLE-MEMBERS
                                       (%IMPORTED-PACKAGE $PI))
                                      $ELEMENT)))
                                 #'(LAMBDA
                                    ($PI)
                                    (GET-NAMES-OF-MEMBER
                                     (%IMPORTED-PACKAGE $PI)
                                     $ELEMENT)))))))

;;; Constraint members_distinguishable:
#|   membersAreDistinguishable() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Namespace|))
  (WITH-OCL-CONTEXT (|Namespace|)
    (WITH-CONSTRAINT ("members_distinguishable")
      (MEMBERS-ARE-DISTINGUISHABLE SELF))))

;;;==================================
;;; Node
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Node|))
  (WITH-OCL-CONTEXT (|Node|)
    (WITH-CONSTRAINT ("internal_structure") :TRUE)))

;;;==================================
;;; ObjectFlow
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ObjectFlow|))
  (WITH-OCL-CONTEXT (|ObjectFlow|)
    (WITH-CONSTRAINT ("target") :TRUE)
    (WITH-CONSTRAINT ("is_multicast_or_is_multireceive") :TRUE)
    (WITH-CONSTRAINT ("input_and_output_parameter") :TRUE)
    (WITH-CONSTRAINT ("selection_behaviour") :TRUE)
    (WITH-CONSTRAINT ("same_upper_bounds") :TRUE)
    (WITH-CONSTRAINT ("transformation_behaviour") :TRUE)
    (WITH-CONSTRAINT ("compatible_types") :TRUE)
    (WITH-CONSTRAINT ("no_actions") :TRUE)))

;;;==================================
;;; ObjectNode
;;;==================================
;;; Constraint not_unique:
#|   isUnique = false |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ObjectNode|))
  (WITH-OCL-CONTEXT (|ObjectNode|)
    (WITH-CONSTRAINT ("object_flow_edges") :TRUE)
    (WITH-CONSTRAINT ("not_unique") (OCL-= (%IS-UNIQUE SELF) :FALSE))
    (WITH-CONSTRAINT ("selection_behavior") :TRUE)
    (WITH-CONSTRAINT ("input_output_parameter") :TRUE)))

;;;==================================
;;; OpaqueExpression
;;;==================================
#|   false |#
(DEFMETHOD IS-NON-NEGATIVE
  ((SELF |OpaqueExpression|))
  "  The query isNonNegative() tells whether an integer expression
  has a non-negative value."
  :FALSE)

#|   self.isIntegral() |#
(DEFMETHOD IS-NON-NEGATIVE
  ((SELF |OpaqueExpression|))
  "  The query isNonNegative() tells whether an integer expression
  has a non-negative value."
  (IS-INTEGRAL SELF))

#|   false |#
(DEFMETHOD IS-POSITIVE
  ((SELF |OpaqueExpression|))
  "  The query isPositive() tells whether an integer expression has
  a positive value."
  :FALSE)

#|   self.isIntegral() |#
(DEFMETHOD IS-POSITIVE
  ((SELF |OpaqueExpression|))
  "  The query isPositive() tells whether an integer expression has
  a positive value."
  (IS-INTEGRAL SELF))

#|   false |#
(DEFMETHOD IS-INTEGRAL
  ((SELF |OpaqueExpression|))
  "  The query isIntegral() tells whether an expression is intended
  to produce an integer."
  :FALSE)

#|   true |#
(DEFMETHOD VALUE
  ((SELF |OpaqueExpression|))
  "  The query value() gives an integer value for an expression intended
  to produce one."
  :TRUE)

#|   self.isIntegral() |#
(DEFMETHOD VALUE
  ((SELF |OpaqueExpression|))
  "  The query value() gives an integer value for an expression intended
  to produce one."
  (IS-INTEGRAL SELF))

;;; Constraint language_body_size:
#|   language->notEmpty() implies (body->size() = language->size()) |#
;;; Constraint only_return_result_parameters:
#|   self.behavior.notEmpty() implies   self.behavior.ownedParameter->select(p
  | p.direction<>#return)->isEmpty() |#
;;; Constraint one_return_result_parameter:
#|   self.behavior.notEmpty() implies   self.behavior.ownedParameter->select(p
  | p.direction=#return)->size() = 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |OpaqueExpression|))
  (WITH-OCL-CONTEXT (|OpaqueExpression|)
    (WITH-CONSTRAINT ("language_body_size")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%LANGUAGE SELF))
                   (OCL-= (OCL-SIZE (%BODY SELF))
                          (OCL-SIZE (%LANGUAGE SELF)))))
    (WITH-CONSTRAINT ("only_return_result_parameters")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%BEHAVIOR SELF))
                   (OCL-IS-EMPTY (OCL-SELECT
                                  (%OWNED-PARAMETER (%BEHAVIOR SELF))
                                  #'(LAMBDA
                                     ($P)
                                     (OCL-<>
                                      (%DIRECTION $P)
                                      :RETURN))))))
    (WITH-CONSTRAINT ("one_return_result_parameter")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%BEHAVIOR SELF))
                   (OCL-= (OCL-SIZE (OCL-SELECT
                                     (%OWNED-PARAMETER
                                      (%BEHAVIOR SELF))
                                     #'(LAMBDA
                                        ($P)
                                        (OCL-=
                                         (%DIRECTION $P)
                                         :RETURN))))
                          1)))))

;;;==================================
;;; Operation
;;;==================================
#|   if returnResult()->notEmpty() then returnResult()->any().lower
  else Set{} endif |#
(DEFMETHOD LOWER.1
  ((SELF |Operation|))
  "  If this operation has a return parameter, lower equals the value
  of lower for that parameter. Otherwise lower is not defined."
  (OCL-IF (OCL-NOT-EMPTY (RETURN-RESULT SELF))
          (%LOWER (OCL-ANY (RETURN-RESULT SELF)
                           #'(LAMBDA (%VAR-14) %VAR-14)))
          (MAKE-INSTANCE '|Set| :VALUE NIL)))

#|   if returnResult()->notEmpty() then returnResult()->any().upper
  else Set{} endif |#
(DEFMETHOD UPPER.1
  ((SELF |Operation|))
  "  If this operation has a return parameter, upper equals the value
  of upper for that parameter. Otherwise upper is not defined."
  (OCL-IF (OCL-NOT-EMPTY (RETURN-RESULT SELF))
          (%UPPER (OCL-ANY (RETURN-RESULT SELF)
                           #'(LAMBDA (%VAR-15) %VAR-15)))
          (MAKE-INSTANCE '|Set| :VALUE NIL)))

#|   if returnResult()->notEmpty() then returnResult()->any().type
  else Set{} endif |#
(DEFMETHOD TYPE.1
  ((SELF |Operation|))
  "  If this operation has a return parameter, type equals the value
  of type for that parameter. Otherwise type is not defined."
  (OCL-IF (OCL-NOT-EMPTY (RETURN-RESULT SELF))
          (%TYPE (OCL-ANY (RETURN-RESULT SELF)
                          #'(LAMBDA (%VAR-16) %VAR-16)))
          (MAKE-INSTANCE '|Set| :VALUE NIL)))

#|   if returnResult()->notEmpty() then returnResult()->any().isOrdered
  else false endif |#
(DEFMETHOD IS-ORDERED.1
  ((SELF |Operation|))
  "  If this operation has a return parameter, isOrdered equals the
  value of isOrdered for that parameter. Otherwise isOrdered is
  false."
  (OCL-IF (OCL-NOT-EMPTY (RETURN-RESULT SELF))
          (%IS-ORDERED (OCL-ANY (RETURN-RESULT SELF)
                                #'(LAMBDA (%VAR-17) %VAR-17)))
          :FALSE))

#|   ownedParameter->select (par | par.direction = #return) |#
(DEFMETHOD RETURN-RESULT
  ((SELF |Operation|))
  "  The query returnResult() returns the set containing the return
  parameter of the Operation if one exists, otherwise, it returns
  an empty set"
  (OCL-SELECT (%OWNED-PARAMETER SELF)
              #'(LAMBDA ($PAR) (OCL-= (%DIRECTION $PAR) :RETURN))))

#|   def: isConsistentWith (redefinee : RedefinableElement) redefinee.isRedefinitionContextValid(self) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |Operation|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (IS-REDEFINITION-CONTEXT-VALID $REDEFINEE SELF))

#|   if returnResult()->notEmpty() then returnResult()->any().isUnique
  else true endif |#
(DEFMETHOD IS-UNIQUE.1
  ((SELF |Operation|))
  "  If this operation has a return parameter, isUnique equals the
  value of isUnique for that parameter. Otherwise isUnique is true."
  (OCL-IF (OCL-NOT-EMPTY (RETURN-RESULT SELF))
          (%IS-UNIQUE (OCL-ANY (RETURN-RESULT SELF)
                               #'(LAMBDA (%VAR-18) %VAR-18)))
          :TRUE))

;;; Constraint at_most_one_return:
#|   self.ownedParameter->select(par | par.direction = #return)->size()
  <= 1 |#
;;; Constraint only_body_for_query:
#|   bodyCondition->notEmpty() implies isQuery |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Operation|))
  (WITH-OCL-CONTEXT (|Operation|)
    (WITH-CONSTRAINT ("at_most_one_return")
      (OCL-<= (OCL-SIZE (OCL-SELECT (%OWNED-PARAMETER SELF)
                                    #'(LAMBDA
                                       ($PAR)
                                       (OCL-=
                                        (%DIRECTION $PAR)
                                        :RETURN))))
              1))
    (WITH-CONSTRAINT ("only_body_for_query")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%BODY-CONDITION SELF))
                   (%IS-QUERY SELF)))))

;;;==================================
;;; OutputPin
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |OutputPin|))
  (WITH-OCL-CONTEXT (|OutputPin|)
    (WITH-CONSTRAINT ("incoming_edges_structured_only") :TRUE)))

;;;==================================
;;; Package
;;;==================================
#|   def: makesVisible (el : NamedElement) (ownedMember->includes(el))
  or (elementImport->select(ei|ei.importedElement = #public)->collect(ei|ei.importedElement)->includes(el))
  or (packageImport->select(pi|pi.visibility = #public)->collect(pi|pi.importedPackage.member->includes(el))->notEmpty()) |#
(DEFMETHOD MAKES-VISIBLE
  ((SELF |Package|) $EL)
  (OCL-ASSERT (|NamedElement| $EL))
  (OCL-OR (OCL-OR (OCL-INCLUDES (%OWNED-MEMBER SELF) $EL)
                  (OCL-INCLUDES (OCL-COLLECT
                                 (OCL-SELECT
                                  (%ELEMENT-IMPORT SELF)
                                  #'(LAMBDA
                                     ($EI)
                                     (OCL-=
                                      (%IMPORTED-ELEMENT $EI)
                                      :PUBLIC)))
                                 #'(LAMBDA
                                    ($EI)
                                    (%IMPORTED-ELEMENT $EI)))
                                $EL))
          (OCL-NOT-EMPTY (OCL-COLLECT (OCL-SELECT
                                       (%PACKAGE-IMPORT SELF)
                                       #'(LAMBDA
                                          ($PI)
                                          (OCL-=
                                           (%VISIBILITY $PI)
                                           :PUBLIC)))
                                      #'(LAMBDA
                                         ($PI)
                                         (OCL-INCLUDES
                                          (%MEMBER
                                           (%IMPORTED-PACKAGE $PI))
                                          $EL))))))

#|   def: makesVisible (el : NamedElement) self.member->includes(el) |#
(DEFMETHOD MAKES-VISIBLE
  ((SELF |Package|) $EL)
  (OCL-ASSERT (|NamedElement| $EL))
  (OCL-INCLUDES (%MEMBER SELF) $EL))

#|   member->select( m | self.makesVisible(m)) |#
(DEFMETHOD VISIBLE-MEMBERS
  ((SELF |Package|))
  "  The query visibleMembers() defines which members of a Package
  can be accessed outside it."
  (OCL-SELECT (%MEMBER SELF) #'(LAMBDA ($M) (MAKES-VISIBLE SELF $M))))

#|   false |#
(DEFMETHOD MUST-BE-OWNED
  ((SELF |Package|))
  "  The query mustBeOwned() indicates whether elements of this type
  must have an owner."
  :FALSE)

;;;==================================
;;; PackageImport
;;;==================================
;;; Constraint public_or_private:
#|   self.visibility = #public or self.visibility = #private |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |PackageImport|))
  (WITH-OCL-CONTEXT (|PackageImport|)
    (WITH-CONSTRAINT ("public_or_private")
      (OCL-OR (OCL-= (%VISIBILITY SELF) :PUBLIC)
              (OCL-= (%VISIBILITY SELF) :PRIVATE)))))

;;;==================================
;;; Parameter
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Parameter|))
  (WITH-OCL-CONTEXT (|Parameter|)
    (WITH-CONSTRAINT ("stream_and_exception") :TRUE)
    (WITH-CONSTRAINT ("not_exception") :TRUE)
    (WITH-CONSTRAINT ("reentrant_behaviors") :TRUE)
    (WITH-CONSTRAINT ("in_and_out") :TRUE)))

;;;==================================
;;; ParameterSet
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ParameterSet|))
  (WITH-OCL-CONTEXT (|ParameterSet|)
    (WITH-CONSTRAINT ("same_parameterized_entity") :TRUE)
    (WITH-CONSTRAINT ("input") :TRUE)
    (WITH-CONSTRAINT ("two_parameter_sets") :TRUE)))

;;;==================================
;;; ParameterableElement
;;;==================================
#|   templateParameter->notEmpty() |#
(DEFMETHOD IS-TEMPLATE-PARAMETER
  ((SELF |ParameterableElement|))
  "  The query isTemplateParameter() determines if this parameterable
  element is exposed as a formal template parameter."
  (OCL-NOT-EMPTY (%TEMPLATE-PARAMETER SELF)))

#|   def: isCompatibleWith (p : ParameterableElement) p->oclIsKindOf(self.oclType()) |#
(DEFMETHOD IS-COMPATIBLE-WITH
  ((SELF |ParameterableElement|) $P)
  (OCL-ASSERT (|ParameterableElement| $P))
  (OCL-IS-KIND-OF $P (OCL-TYPE SELF)))

;;;==================================
;;; PartDecomposition
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |PartDecomposition|))
  (WITH-OCL-CONTEXT (|PartDecomposition|)
    (WITH-CONSTRAINT ("parts_of_internal_structures") :TRUE)
    (WITH-CONSTRAINT ("assume") :TRUE)
    (WITH-CONSTRAINT ("commutativity_of_decomposition") :TRUE)))

;;;==================================
;;; Pin
;;;==================================
;;; Constraint control_pins:
#|   isControl implies isControlType |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Pin|))
  (WITH-OCL-CONTEXT (|Pin|)
    (WITH-CONSTRAINT ("control_pins")
      (OCL-IMPLIES (%IS-CONTROL SELF) (%IS-CONTROL-TYPE SELF)))))

;;;==================================
;;; Port
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Port|))
  (WITH-OCL-CONTEXT (|Port|)
    (WITH-CONSTRAINT ("required_interfaces") :TRUE)
    (WITH-CONSTRAINT ("port_aggregation") :TRUE)
    (WITH-CONSTRAINT ("port_destroyed") :TRUE)
    (WITH-CONSTRAINT ("default_value") :TRUE)))

;;;==================================
;;; Property
;;;==================================
#|   if owningAssociation->isEmpty()                        and association->notEmpty()
                        and association.memberEnd->size() = 2 
   then     -- POD let otherEnd = (association.memberEnd - self)->any()
  in     let otherEnd = (association.memberEnd->excluding(self))->any()
  in        if otherEnd.owningAssociation->isEmpty() then otherEnd
  else Set{} endif     else Set {}     endif |#
(DEFMETHOD OPPOSITE.1
  ((SELF |Property|))
  "  If this property is owned by a class, associated with a binary
  association, and the other end of the association is also owned
  by a class, then opposite gives the other end."
  (OCL-IF (OCL-AND (OCL-AND (OCL-IS-EMPTY (%OWNING-ASSOCIATION SELF))
                            (OCL-NOT-EMPTY (%ASSOCIATION SELF)))
                   (OCL-= (OCL-SIZE (%MEMBER-END (%ASSOCIATION SELF)))
                          2))
          (LET (($OTHEREND
                 (OCL-ANY (OCL-EXCLUDING (%MEMBER-END
                                          (%ASSOCIATION SELF))
                                         SELF)
                          #'(LAMBDA (%VAR-19) %VAR-19))))
            (OCL-IF (OCL-IS-EMPTY (%OWNING-ASSOCIATION $OTHEREND))
                    $OTHEREND
                    (MAKE-INSTANCE '|Set| :VALUE NIL)))
          (MAKE-INSTANCE '|Set| :VALUE NIL)))

#|   def: isCompatibleWith (p : ParameterableElement) p->oclIsKindOf(self.oclType())
  and self.type.conformsTo(p.oclAsType(TypedElement).type) |#
(DEFMETHOD IS-COMPATIBLE-WITH
  ((SELF |Property|) $P)
  (OCL-ASSERT (|ParameterableElement| $P))
  (OCL-AND (OCL-IS-KIND-OF $P (OCL-TYPE SELF))
           (CONFORMS-TO (%TYPE SELF)
                        (%TYPE (OCL-AS-TYPE $P (find-class '|TypedElement|))))))

#|   (self.aggregation = #composite) |#
(DEFMETHOD IS-COMPOSITE.1
  ((SELF |Property|))
  "  The value of isComposite is true only if aggregation is composite."
  (OCL-= (%AGGREGATION SELF) :COMPOSITE))

#|   def: isConsistentWith (redefinee : RedefinableElement) redefinee.oclIsKindOf(Property)
  and    let prop : Property = redefinee.oclAsType(Property) in
     (prop.type.conformsTo(self.type) and    ((prop.lowerBound()->notEmpty()
  and self.lowerBound()->notEmpty()) implies prop.lowerBound()
  >= self.lowerBound()) and    ((prop.upperBound()->notEmpty()
  and self.upperBound()->notEmpty()) implies prop.lowerBound()
  <= self.lowerBound()) and    (self.isDerived implies prop.isDerived)
  and   (self.isComposite implies prop.isComposite)) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |Property|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (OCL-AND (OCL-IS-KIND-OF $REDEFINEE (find-class '|Property|))
           (LET (($PROP (OCL-AS-TYPE $REDEFINEE (find-class '|Property|))))
             (OCL-ASSERT (|Property| $PROP))
             (OCL-AND (OCL-AND (OCL-AND
                                (OCL-AND
                                 (CONFORMS-TO
                                  (%TYPE $PROP)
                                  (%TYPE SELF))
                                 (OCL-IMPLIES
                                  (OCL-AND
                                   (OCL-NOT-EMPTY (LOWER-BOUND $PROP))
                                   (OCL-NOT-EMPTY (LOWER-BOUND SELF)))
                                  (OCL->=
                                   (LOWER-BOUND $PROP)
                                   (LOWER-BOUND SELF))))
                                (OCL-IMPLIES
                                 (OCL-AND
                                  (OCL-NOT-EMPTY (UPPER-BOUND $PROP))
                                  (OCL-NOT-EMPTY (UPPER-BOUND SELF)))
                                 (OCL-<=
                                  (LOWER-BOUND $PROP)
                                  (LOWER-BOUND SELF))))
                               (OCL-IMPLIES
                                (%IS-DERIVED SELF)
                                (%IS-DERIVED $PROP)))
                      (OCL-IMPLIES (%IS-COMPOSITE SELF)
                                   (%IS-COMPOSITE $PROP))))))

#|   def: isConsistentWith (redefinee : RedefinableElement) redefinee.isRedefinitionContextValid(self) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |Property|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (IS-REDEFINITION-CONTEXT-VALID $REDEFINEE SELF))

;;; Constraint derived_union_is_derived:
#|   isDerivedUnion implies isDerived |#
;;; Constraint multiplicity_of_composite:
#|   isComposite implies (upperBound()->isEmpty() or upperBound()
  <= 1) |#
;;; Constraint derived_union_is_read_only:
#|   isDerivedUnion implies isReadOnly |#
;;; Constraint redefined_property_inherited:
#|   redefinedProperty->notEmpty() implies            redefinitionContext->notEmpty()
  and            redefinedProperty->forAll(rp|redefinitionContext->collect(fc
  | fc.allParents())->asSet()                             ->collect(c|
  c.allFeatures())->asSet()->includes(rp)) |#
;;; Constraint subsetting_rules:
#|   self.subsettedProperty->forAll(sp |   self.type.conformsTo(sp.type)
  and     ((self.upperBound()->notEmpty() and sp.upperBound()->notEmpty())
  implies       self.upperBound()<=sp.upperBound() )) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Property|))
  (WITH-OCL-CONTEXT (|Property|)
    (WITH-CONSTRAINT ("derived_union_is_derived")
      (OCL-IMPLIES (%IS-DERIVED-UNION SELF) (%IS-DERIVED SELF)))
    (WITH-CONSTRAINT ("multiplicity_of_composite")
      (OCL-IMPLIES (%IS-COMPOSITE SELF)
                   (OCL-OR (OCL-IS-EMPTY (UPPER-BOUND SELF))
                           (OCL-<= (UPPER-BOUND SELF) 1))))
    (WITH-CONSTRAINT ("derived_union_is_read_only")
      (OCL-IMPLIES (%IS-DERIVED-UNION SELF) (%IS-READ-ONLY SELF)))
    (WITH-CONSTRAINT ("subsetted_property_names") :TRUE)
    (WITH-CONSTRAINT ("redefined_property_inherited")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%REDEFINED-PROPERTY SELF))
                   (OCL-AND (OCL-NOT-EMPTY (%REDEFINITION-CONTEXT
                                            SELF))
                            (OCL-FOR-ALL (%REDEFINED-PROPERTY SELF)
                                         #'(LAMBDA
                                            ($RP)
                                            (OCL-INCLUDES
                                             (OCL-AS-SET
                                              (OCL-COLLECT
                                               (OCL-AS-SET
                                                (OCL-COLLECT
                                                 (%REDEFINITION-CONTEXT
                                                  SELF)
                                                 #'(LAMBDA
                                                    ($FC)
                                                    (ALL-PARENTS
                                                     $FC))))
                                               #'(LAMBDA
                                                  ($C)
                                                  (ALL-FEATURES $C))))
                                             $RP))))))
    (WITH-CONSTRAINT ("deployment_target") :TRUE)
    (WITH-CONSTRAINT ("subsetting_rules")
      (OCL-FOR-ALL (%SUBSETTED-PROPERTY SELF)
                   #'(LAMBDA ($SP)
                       (OCL-AND (CONFORMS-TO (%TYPE SELF) (%TYPE $SP))
                                (OCL-IMPLIES
                                 (OCL-AND
                                  (OCL-NOT-EMPTY (UPPER-BOUND SELF))
                                  (OCL-NOT-EMPTY (UPPER-BOUND $SP)))
                                 (OCL-<=
                                  (UPPER-BOUND SELF)
                                  (UPPER-BOUND $SP)))))))))

;;;==================================
;;; ProtocolStateMachine
;;;==================================
;;; Constraint classifier_context:
#|   (not context->isEmpty( )) and specification->isEmpty() |#
;;; Constraint protocol_transitions:
#|   region->forAll(r | r.transition->forAll(t | t.oclIsTypeOf(ProtocolTransition))) |#
;;; Constraint entry_exit_do:
#|   region->forAll(r | r.subvertex->forAll(v | v.oclIsKindOf(State)
  implies (v.entry->isEmpty() and v.exit->isEmpty() and v.doActivity->isEmpty()))) |#
;;; Constraint deep_or_shallow_history:
#|   region->forAll (r | r.subvertex->forAll (v | v.oclIsKindOf(Pseudostate)
  implies     ((v.kind <> #deepHistory) and (v.kind <> #shallowHistory)))) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ProtocolStateMachine|))
  (WITH-OCL-CONTEXT (|ProtocolStateMachine|)
    (WITH-CONSTRAINT ("classifier_context")
      (OCL-AND (OCL-NOT (OCL-IS-EMPTY (%CONTEXT SELF)))
               (OCL-IS-EMPTY (%SPECIFICATION SELF))))
    (WITH-CONSTRAINT ("protocol_transitions")
      (OCL-FOR-ALL (%REGION SELF)
                   #'(LAMBDA ($R)
                       (OCL-FOR-ALL (%TRANSITION $R)
                                    #'(LAMBDA
                                       ($T)
                                       (OCL-IS-TYPE-OF
                                        $T
                                        '|ProtocolTransition|))))))
    (WITH-CONSTRAINT ("entry_exit_do")
      (OCL-FOR-ALL (%REGION SELF)
                   #'(LAMBDA ($R)
                       (OCL-FOR-ALL (%SUBVERTEX $R)
                                    #'(LAMBDA
                                       ($V)
                                       (OCL-IMPLIES
                                        (OCL-IS-KIND-OF $V (find-class '|State|))
                                        (OCL-AND
                                         (OCL-AND
                                          (OCL-IS-EMPTY (%ENTRY $V))
                                          (OCL-IS-EMPTY (%EXIT $V)))
                                         (OCL-IS-EMPTY
                                          (%DO-ACTIVITY $V)))))))))
    (WITH-CONSTRAINT ("deep_or_shallow_history")
      (OCL-FOR-ALL (%REGION SELF)
                   #'(LAMBDA ($R)
                       (OCL-FOR-ALL (%SUBVERTEX $R)
                                    #'(LAMBDA
                                       ($V)
                                       (OCL-IMPLIES
                                        (OCL-IS-KIND-OF
                                         $V
                                         (find-class '|Pseudostate|))
                                        (OCL-AND
                                         (OCL-<>
                                          (%KIND $V)
                                          :DEEPHISTORY)
                                         (OCL-<>
                                          (%KIND $V)
                                          :SHALLOWHISTORY))))))))
    (WITH-CONSTRAINT ("ports_connected") :TRUE)))

;;;==================================
;;; ProtocolTransition
;;;==================================
;;; Constraint belongs_to_psm:
#|   container.belongsToPSM() |#
;;; Constraint associated_actions:
#|   effect->isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ProtocolTransition|))
  (WITH-OCL-CONTEXT (|ProtocolTransition|)
    (WITH-CONSTRAINT ("belongs_to_psm")
      (BELONGS-TO-P-S-M (%CONTAINER SELF)))
    (WITH-CONSTRAINT ("associated_actions")
      (OCL-IS-EMPTY (%EFFECT SELF)))
    (WITH-CONSTRAINT ("refers_to_operation") :TRUE)))

;;;==================================
;;; Pseudostate
;;;==================================
;;; Constraint choice_vertex:
#|   (self.kind = #choice) implies ((self.incoming->size() >= 1) and
  (self.outgoing->size() >= 1)) |#
;;; Constraint join_vertex:
#|   (self.kind = #join) implies ((self.outgoing->size() = 1) and
  (self.incoming->size() >= 2)) |#
;;; Constraint junction_vertex:
#|   (self.kind = #junction) implies ((self.incoming->size() >= 1)
  and (self.outgoing->size() >= 1)) |#
;;; Constraint transitions_outgoing:
#|   (self.kind = #fork) implies   self.outgoing->forAll (t1, t2 |
  t1<>t2 implies     (self.stateMachine.LCA(t1.target, t2.target).container.isOrthogonal)) |#
;;; Constraint history_vertices:
#|   ((self.kind = #deepHistory) or (self.kind = #shallowHistory))
  implies (self.outgoing->size() <= 1) |#
;;; Constraint fork_vertex:
#|   (self.kind = #fork) implies ((self.incoming->size() = 1) and
  (self.outgoing->size() >= 2)) |#
;;; Constraint initial_vertex:
#|   (self.kind = #initial) implies (self.outgoing->size() <= 1) |#
;;; Constraint outgoing_from_initial:
#|   (self.kind = #initial) implies (self.outgoing.guard->isEmpty()
    and self.outgoing.trigger->isEmpty()) |#
;;; Constraint transitions_incoming:
#|   (self.kind = #join) implies   self.incoming->forAll (t1, t2 |
  t1<>t2 implies     (self.stateMachine.LCA(t1.source, t2.source).container.isOrthogonal)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Pseudostate|))
  (WITH-OCL-CONTEXT (|Pseudostate|)
    (WITH-CONSTRAINT ("choice_vertex")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :CHOICE)
                   (OCL-AND (OCL->= (OCL-SIZE (%INCOMING SELF)) 1)
                            (OCL->= (OCL-SIZE (%OUTGOING SELF)) 1))))
    (WITH-CONSTRAINT ("join_vertex")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :JOIN)
                   (OCL-AND (OCL-= (OCL-SIZE (%OUTGOING SELF)) 1)
                            (OCL->= (OCL-SIZE (%INCOMING SELF)) 2))))
    (WITH-CONSTRAINT ("junction_vertex")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :JUNCTION)
                   (OCL-AND (OCL->= (OCL-SIZE (%INCOMING SELF)) 1)
                            (OCL->= (OCL-SIZE (%OUTGOING SELF)) 1))))
    (WITH-CONSTRAINT ("transitions_outgoing")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :FORK)
                   (OCL-FOR-ALL (%OUTGOING SELF)
                                #'(LAMBDA
                                   ($T2)
                                   (OCL-FOR-ALL
                                    (%OUTGOING SELF)
                                    #'(LAMBDA
                                       ($T1)
                                       (OCL-IMPLIES
                                        (OCL-<> $T1 $T2)
                                        (%IS-ORTHOGONAL
                                         (%CONTAINER
                                          (L-C-A
                                           (%STATE-MACHINE SELF)
                                           (%TARGET $T1)
                                           (%TARGET $T2)))))))))))
    (WITH-CONSTRAINT ("history_vertices")
      (OCL-IMPLIES (OCL-OR (OCL-= (%KIND SELF) :DEEPHISTORY)
                           (OCL-= (%KIND SELF) :SHALLOWHISTORY))
                   (OCL-<= (OCL-SIZE (%OUTGOING SELF)) 1)))
    (WITH-CONSTRAINT ("fork_vertex")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :FORK)
                   (OCL-AND (OCL-= (OCL-SIZE (%INCOMING SELF)) 1)
                            (OCL->= (OCL-SIZE (%OUTGOING SELF)) 2))))
    (WITH-CONSTRAINT ("initial_vertex")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :INITIAL)
                   (OCL-<= (OCL-SIZE (%OUTGOING SELF)) 1)))
    (WITH-CONSTRAINT ("outgoing_from_initial")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :INITIAL)
                   (OCL-AND (OCL-IS-EMPTY (%GUARD (%OUTGOING SELF)))
                            (OCL-IS-EMPTY (%TRIGGER
                                           (%OUTGOING SELF))))))
    (WITH-CONSTRAINT ("transitions_incoming")
      (OCL-IMPLIES (OCL-= (%KIND SELF) :JOIN)
                   (OCL-FOR-ALL (%INCOMING SELF)
                                #'(LAMBDA
                                   ($T2)
                                   (OCL-FOR-ALL
                                    (%INCOMING SELF)
                                    #'(LAMBDA
                                       ($T1)
                                       (OCL-IMPLIES
                                        (OCL-<> $T1 $T2)
                                        (%IS-ORTHOGONAL
                                         (%CONTAINER
                                          (L-C-A
                                           (%STATE-MACHINE SELF)
                                           (%SOURCE $T1)
                                           (%SOURCE $T2)))))))))))))

;;;==================================
;;; QualifierValue
;;;==================================
;;; Constraint type_of_qualifier:
#|   self.value.type = self.qualifier.type |#
;;; Constraint multiplicity_of_qualifier:
#|   self.value.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |QualifierValue|))
  (WITH-OCL-CONTEXT (|QualifierValue|)
    (WITH-CONSTRAINT ("type_of_qualifier")
      (OCL-= (%TYPE (%VALUE SELF)) (%TYPE (%QUALIFIER SELF))))
    (WITH-CONSTRAINT ("multiplicity_of_qualifier")
      (IS (%VALUE SELF) 1 1))))

;;;==================================
;;; ReadExtentAction
;;;==================================
;;; Constraint multiplicity_of_result:
#|   self.result.is(0,LiteralUnlimitedNatural) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadExtentAction|))
  (WITH-OCL-CONTEXT (|ReadExtentAction|)
    (WITH-CONSTRAINT ("type_is_classifier") :TRUE)
    (WITH-CONSTRAINT ("multiplicity_of_result")
      (IS (%RESULT SELF) 0 '|LiteralUnlimitedNatural|))))

;;;==================================
;;; ReadIsClassifiedObjectAction
;;;==================================
;;; Constraint multiplicity_of_input:
#|   self.object.is(1,1) |#
;;; Constraint no_type:
#|   self.object.type->isEmpty() |#
;;; Constraint multiplicity_of_output:
#|   self.result.is(1,1) |#
;;; Constraint boolean_result:
#|   self.result.type = Boolean |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadIsClassifiedObjectAction|))
  (WITH-OCL-CONTEXT (|ReadIsClassifiedObjectAction|)
    (WITH-CONSTRAINT ("multiplicity_of_input") (IS (%OBJECT SELF) 1 1))
    (WITH-CONSTRAINT ("no_type") (OCL-IS-EMPTY (%TYPE (%OBJECT SELF))))
    (WITH-CONSTRAINT ("multiplicity_of_output")
      (IS (%RESULT SELF) 1 1))
    (WITH-CONSTRAINT ("boolean_result")
      (OCL-= (%TYPE (%RESULT SELF)) '|Boolean|))))

;;;==================================
;;; ReadLinkAction
;;;==================================
;;; Constraint one_open_end:
#|   self.endData->select(ed | ed.value->size() = 0)->size() = 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadLinkAction|))
  (WITH-OCL-CONTEXT (|ReadLinkAction|)
    (WITH-CONSTRAINT ("one_open_end")
      (OCL-= (OCL-SIZE (OCL-SELECT (%END-DATA SELF)
                                   #'(LAMBDA
                                      ($ED)
                                      (OCL-=
                                       (OCL-SIZE (%VALUE $ED))
                                       0))))
             1))))

;;;==================================
;;; ReadLinkObjectEndAction
;;;==================================
;;; Constraint property:
#|   self.end.association.notEmpty() |#
;;; Constraint multiplicity_of_result:
#|   self.result.is(1,1) |#
;;; Constraint type_of_result:
#|   self.result.type = self.end.type |#
;;; Constraint multiplicity_of_object:
#|   self.object.is(1,1) |#
;;; Constraint type_of_object:
#|   self.object.type = self.end.association |#
;;; Constraint ends_of_association:
#|   self.end.association.memberEnd->forAll(e | not e.isStatic) |#
;;; Constraint association_of_association:
#|   self.end.association.oclIsKindOf(AssociationClass) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadLinkObjectEndAction|))
  (WITH-OCL-CONTEXT (|ReadLinkObjectEndAction|)
    (WITH-CONSTRAINT ("property")
      (OCL-NOT-EMPTY (%ASSOCIATION (%END SELF))))
    (WITH-CONSTRAINT ("multiplicity_of_result")
      (IS (%RESULT SELF) 1 1))
    (WITH-CONSTRAINT ("type_of_result")
      (OCL-= (%TYPE (%RESULT SELF)) (%TYPE (%END SELF))))
    (WITH-CONSTRAINT ("multiplicity_of_object")
      (IS (%OBJECT SELF) 1 1))
    (WITH-CONSTRAINT ("type_of_object")
      (OCL-= (%TYPE (%OBJECT SELF)) (%ASSOCIATION (%END SELF))))
    (WITH-CONSTRAINT ("ends_of_association")
      (OCL-FOR-ALL (%MEMBER-END (%ASSOCIATION (%END SELF)))
                   #'(LAMBDA ($E) (OCL-NOT (%IS-STATIC $E)))))
    (WITH-CONSTRAINT ("association_of_association")
      (OCL-IS-KIND-OF (%ASSOCIATION (%END SELF)) (find-class '|AssociationClass|)))))

;;;==================================
;;; ReadLinkObjectEndQualifierAction
;;;==================================
;;; Constraint multiplicity_of_result:
#|   self.result.is(1,1) |#
;;; Constraint ends_of_association:
#|   self.qualifier.associationEnd.association.memberEnd->forAll(e
  | not e.isStatic) |#
;;; Constraint multiplicity_of_qualifier:
#|   self.qualifier.is(1,1) |#
;;; Constraint same_type:
#|   self.result.type = self.qualifier.type |#
;;; Constraint association_of_association:
#|   self.qualifier.associationEnd.association.oclIsKindOf(AssociationClass) |#
;;; Constraint type_of_object:
#|   self.object.type = self.qualifier.associationEnd.association |#
;;; Constraint multiplicity_of_object:
#|   self.object.is(1,1) |#
;;; Constraint qualifier_attribute:
#|   self.qualifier.associationEnd->size() = 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadLinkObjectEndQualifierAction|))
  (WITH-OCL-CONTEXT (|ReadLinkObjectEndQualifierAction|)
    (WITH-CONSTRAINT ("multiplicity_of_result")
      (IS (%RESULT SELF) 1 1))
    (WITH-CONSTRAINT ("ends_of_association")
      (OCL-FOR-ALL (%MEMBER-END (%ASSOCIATION
                                 (%ASSOCIATION-END (%QUALIFIER SELF))))
                   #'(LAMBDA ($E) (OCL-NOT (%IS-STATIC $E)))))
    (WITH-CONSTRAINT ("multiplicity_of_qualifier")
      (IS (%QUALIFIER SELF) 1 1))
    (WITH-CONSTRAINT ("same_type")
      (OCL-= (%TYPE (%RESULT SELF)) (%TYPE (%QUALIFIER SELF))))
    (WITH-CONSTRAINT ("association_of_association")
      (OCL-IS-KIND-OF (%ASSOCIATION (%ASSOCIATION-END
                                     (%QUALIFIER SELF)))
                      (find-class '|AssociationClass|)))
    (WITH-CONSTRAINT ("type_of_object")
      (OCL-= (%TYPE (%OBJECT SELF))
             (%ASSOCIATION (%ASSOCIATION-END (%QUALIFIER SELF)))))
    (WITH-CONSTRAINT ("multiplicity_of_object")
      (IS (%OBJECT SELF) 1 1))
    (WITH-CONSTRAINT ("qualifier_attribute")
      (OCL-= (OCL-SIZE (%ASSOCIATION-END (%QUALIFIER SELF))) 1))))

;;;==================================
;;; ReadSelfAction
;;;==================================
;;; Constraint contained:
#|   self.context->size() = 1 |#
;;; Constraint type:
#|   self.result.type = self.context |#
;;; Constraint multiplicity:
#|   self.result.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadSelfAction|))
  (WITH-OCL-CONTEXT (|ReadSelfAction|)
    (WITH-CONSTRAINT ("contained")
      (OCL-= (OCL-SIZE (%CONTEXT SELF)) 1))
    (WITH-CONSTRAINT ("not_static") :TRUE)
    (WITH-CONSTRAINT ("type")
      (OCL-= (%TYPE (%RESULT SELF)) (%CONTEXT SELF)))
    (WITH-CONSTRAINT ("multiplicity") (IS (%RESULT SELF) 1 1))))

;;;==================================
;;; ReadStructuralFeatureAction
;;;==================================
;;; Constraint type_and_ordering:
#|   self.result.type = self.structuralFeature.type and self.result.ordering
  = self.structuralFeature.ordering |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadStructuralFeatureAction|))
  (WITH-OCL-CONTEXT (|ReadStructuralFeatureAction|)
    (WITH-CONSTRAINT ("type_and_ordering")
      (OCL-AND (OCL-= (%TYPE (%RESULT SELF))
                      (%TYPE (%STRUCTURAL-FEATURE SELF)))
               (OCL-= (%ORDERING (%RESULT SELF))
                      (%ORDERING (%STRUCTURAL-FEATURE SELF)))))))

;;;==================================
;;; ReadVariableAction
;;;==================================
;;; Constraint type_and_ordering:
#|   self.result.type =self.variable.type and self.result.ordering
  = self.variable.ordering |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReadVariableAction|))
  (WITH-OCL-CONTEXT (|ReadVariableAction|)
    (WITH-CONSTRAINT ("type_and_ordering")
      (OCL-AND (OCL-= (%TYPE (%RESULT SELF)) (%TYPE (%VARIABLE SELF)))
               (OCL-= (%ORDERING (%RESULT SELF))
                      (%ORDERING (%VARIABLE SELF)))))))

;;;==================================
;;; Reception
;;;==================================
;;; Constraint not_query:
#|   not self.isQuery |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Reception|))
  (WITH-OCL-CONTEXT (|Reception|)
    (WITH-CONSTRAINT ("not_query") (OCL-NOT (%IS-QUERY SELF)))))

;;;==================================
;;; ReclassifyObjectAction
;;;==================================
;;; Constraint classifier_not_abstract:
#|   not self.newClassifier->exists(isAbstract = true) |#
;;; Constraint multiplicity:
#|   self.argument.is(1,1) |#
;;; Constraint input_pin:
#|   self.argument.type->size() = 0 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReclassifyObjectAction|))
  (WITH-OCL-CONTEXT (|ReclassifyObjectAction|)
    (WITH-CONSTRAINT ("classifier_not_abstract")
      (OCL-NOT (OCL-EXISTS (%NEW-CLASSIFIER SELF)
                           #'(LAMBDA (%VAR-20)
                               (OCL-= (%IS-ABSTRACT %VAR-20) :TRUE)))))
    (WITH-CONSTRAINT ("multiplicity") (IS (%ARGUMENT SELF) 1 1))
    (WITH-CONSTRAINT ("input_pin")
      (OCL-= (OCL-SIZE (%TYPE (%ARGUMENT SELF))) 0))))

;;;==================================
;;; RedefinableElement
;;;==================================
#|   def: isRedefinitionContextValid (redefined : RedefinableElement)
  redefinitionContext->exists(c | c.allParents()->includes(redefined.redefinitionContext)) |#
(DEFMETHOD IS-REDEFINITION-CONTEXT-VALID
  ((SELF |RedefinableElement|) $REDEFINED)
  (OCL-ASSERT (|RedefinableElement| $REDEFINED))
  (OCL-EXISTS (%REDEFINITION-CONTEXT SELF)
              #'(LAMBDA ($C)
                  (OCL-INCLUDES (ALL-PARENTS $C)
                                (%REDEFINITION-CONTEXT $REDEFINED)))))

#|   def: isConsistentWith (redefinee : RedefinableElement) false |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |RedefinableElement|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  :FALSE)

;;; Constraint redefinition_context_valid:
#|   self.redefinedElement->forAll(e | self.isRedefinitionContextValid(e)) |#
;;; Constraint redefinition_consistent:
#|   self.redefinedElement->forAll(re | re.isConsistentWith(self)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |RedefinableElement|))
  (WITH-OCL-CONTEXT (|RedefinableElement|)
    (WITH-CONSTRAINT ("redefinition_context_valid")
      (OCL-FOR-ALL (%REDEFINED-ELEMENT SELF)
                   #'(LAMBDA ($E)
                       (IS-REDEFINITION-CONTEXT-VALID SELF $E))))
    (WITH-CONSTRAINT ("redefinition_consistent")
      (OCL-FOR-ALL (%REDEFINED-ELEMENT SELF)
                   #'(LAMBDA ($RE) (IS-CONSISTENT-WITH $RE SELF))))))

;;;==================================
;;; RedefinableTemplateSignature
;;;==================================
#|   def: isConsistentWith (redefinee : RedefinableElement) redefinee.oclIsKindOf(RedefinableTemplateSignature) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |RedefinableTemplateSignature|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (OCL-IS-KIND-OF $REDEFINEE (find-class '|RedefinableTemplateSignature|)))

#|   def: isConsistentWith (redefinee : RedefinableElement) redefinee.isRedefinitionContextValid(self) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |RedefinableTemplateSignature|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (IS-REDEFINITION-CONTEXT-VALID $REDEFINEE SELF))

;;; Constraint inherited_parameters:
#|   if extendedSignature->isEmpty() then Set{} else extendedSignature.parameter
  endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |RedefinableTemplateSignature|))
  (WITH-OCL-CONTEXT (|RedefinableTemplateSignature|)
    (WITH-CONSTRAINT ("inherited_parameters")
      (OCL-IF (OCL-IS-EMPTY (%EXTENDED-SIGNATURE SELF))
              (MAKE-INSTANCE '|Set| :VALUE NIL)
              (%PARAMETER (%EXTENDED-SIGNATURE SELF))))))

;;;==================================
;;; ReduceAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReduceAction|))
  (WITH-OCL-CONTEXT (|ReduceAction|)
    (WITH-CONSTRAINT ("input_type_is_collection") :TRUE)
    (WITH-CONSTRAINT ("output_types_are_compatible") :TRUE)
    (WITH-CONSTRAINT ("reducer_inputs_output") :TRUE)))

;;;==================================
;;; Region
;;;==================================
#|   if not stateMachine->isEmpty() then oclIsTypeOf(ProtocolStateMachine)
  else if not state->isEmpty() then state.container.belongsToPSM
  () else false endif endif |#
(DEFMETHOD BELONGS-TO-P-S-M
  ((SELF |Region|))
  "  The operation belongsToPSM () checks if the region belongs to
  a protocol state machine"
  (OCL-IF (OCL-NOT (OCL-IS-EMPTY (%STATE-MACHINE SELF)))
          (OCL-IS-TYPE-OF SELF '|ProtocolStateMachine|)
          (OCL-IF (OCL-NOT (OCL-IS-EMPTY (%STATE SELF)))
                  (BELONGS-TO-P-S-M (%CONTAINER (%STATE SELF)))
                  :FALSE)))

#|   if stateMachine->isEmpty()  then state.containingStateMachine()
  else stateMachine endif |#
(DEFMETHOD CONTAINING-STATE-MACHINE
  ((SELF |Region|))
  "  The operation containingStateMachine() returns the sate machine
  in which this Region is defined"
  (OCL-IF (OCL-IS-EMPTY (%STATE-MACHINE SELF))
          (CONTAINING-STATE-MACHINE (%STATE SELF))
          (%STATE-MACHINE SELF)))

#|   def: isConsistentWith (redefinee : RedefinableElement) true |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |Region|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  :TRUE)

#|   def: isRedefinitionContextValid (redefined : Region) true |#
(DEFMETHOD IS-REDEFINITION-CONTEXT-VALID
  ((SELF |Region|) $REDEFINED)
  (OCL-ASSERT (|Region| $REDEFINED))
  :TRUE)

#|   let sm = containingStateMachine() in if sm.context->isEmpty()
  or sm.general->notEmpty() then sm else sm.context endif |#
(DEFMETHOD REDEFINITION-CONTEXT.1
  ((SELF |Region|))
  "  The redefinition context of a region is the nearest containing
  statemachine"
  (LET (($SM (CONTAINING-STATE-MACHINE SELF)))
    (OCL-IF (OCL-OR (OCL-IS-EMPTY (%CONTEXT $SM))
                    (OCL-NOT-EMPTY (%GENERAL $SM)))
            $SM
            (%CONTEXT $SM))))

;;; Constraint initial_vertex:
#|   self.subvertex->select (v | v.oclIsKindOf(Pseudostate))-> select(p
  : Pseudostate | p.kind = #initial)->size() <= 1 |#
;;; Constraint deep_history_vertex:
#|   self.subvertex->select (v | v.oclIsKindOf(Pseudostate))-> select(p
  : Pseudostate | p.kind = #deepHistory)->size() <= 1 |#
;;; Constraint shallow_history_vertex:
#|   self.subvertex->select(v | v.oclIsKindOf(Pseudostate))-> select(p
  : Pseudostate | p.kind = #shallowHistory)->size() <= 1 |#
;;; Constraint owned:
#|   (stateMachine->notEmpty() implies state->isEmpty()) and (state->notEmpty()
  implies stateMachine->isEmpty()) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Region|))
  (WITH-OCL-CONTEXT (|Region|)
    (WITH-CONSTRAINT ("initial_vertex")
      (OCL-<= (OCL-SIZE (OCL-SELECT (OCL-SELECT
                                     (%SUBVERTEX SELF)
                                     #'(LAMBDA
                                        ($V)
                                        (OCL-IS-KIND-OF
                                         $V
                                         (find-class '|Pseudostate|))))
                                    #'(LAMBDA
                                       ($P)
                                       (OCL-= (%KIND $P) :INITIAL))))
              1))
    (WITH-CONSTRAINT ("deep_history_vertex")
      (OCL-<= (OCL-SIZE (OCL-SELECT (OCL-SELECT
                                     (%SUBVERTEX SELF)
                                     #'(LAMBDA
                                        ($V)
                                        (OCL-IS-KIND-OF
                                         $V
                                         (find-class '|Pseudostate|))))
                                    #'(LAMBDA
                                       ($P)
                                       (OCL-=
                                        (%KIND $P)
                                        :DEEPHISTORY))))
              1))
    (WITH-CONSTRAINT ("shallow_history_vertex")
      (OCL-<= (OCL-SIZE (OCL-SELECT (OCL-SELECT
                                     (%SUBVERTEX SELF)
                                     #'(LAMBDA
                                        ($V)
                                        (OCL-IS-KIND-OF
                                         $V
                                         (find-class '|Pseudostate|))))
                                    #'(LAMBDA
                                       ($P)
                                       (OCL-=
                                        (%KIND $P)
                                        :SHALLOWHISTORY))))
              1))
    (WITH-CONSTRAINT ("owned")
      (OCL-AND (OCL-IMPLIES (OCL-NOT-EMPTY (%STATE-MACHINE SELF))
                            (OCL-IS-EMPTY (%STATE SELF)))
               (OCL-IMPLIES (OCL-NOT-EMPTY (%STATE SELF))
                            (OCL-IS-EMPTY (%STATE-MACHINE SELF)))))))

;;;==================================
;;; RemoveStructuralFeatureValueAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |RemoveStructuralFeatureValueAction|))
  (WITH-OCL-CONTEXT (|RemoveStructuralFeatureValueAction|)
    (WITH-CONSTRAINT ("non_unique_removal") :TRUE)))

;;;==================================
;;; RemoveVariableValueAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |RemoveVariableValueAction|))
  (WITH-OCL-CONTEXT (|RemoveVariableValueAction|)
    (WITH-CONSTRAINT ("unlimited_natural") :TRUE)))

;;;==================================
;;; ReplyAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ReplyAction|))
  (WITH-OCL-CONTEXT (|ReplyAction|)
    (WITH-CONSTRAINT ("pins_match_parameter") :TRUE)))

;;;==================================
;;; SendSignalAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |SendSignalAction|))
  (WITH-OCL-CONTEXT (|SendSignalAction|)
    (WITH-CONSTRAINT ("number_order") :TRUE)
    (WITH-CONSTRAINT ("type_ordering_multiplicity") :TRUE)))

;;;==================================
;;; StartClassifierBehaviorAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StartClassifierBehaviorAction|))
  (WITH-OCL-CONTEXT (|StartClassifierBehaviorAction|)
    (WITH-CONSTRAINT ("multiplicity") :TRUE)
    (WITH-CONSTRAINT ("type_has_classifier") :TRUE)))

;;;==================================
;;; State
;;;==================================
#|   let sm = containingStateMachine() in if sm.context->isEmpty()
  or sm.general->notEmpty() then sm else sm.context endif |#
(DEFMETHOD REDEFINITION-CONTEXT.1
  ((SELF |State|))
  "  The redefinition context of a state is the nearest containing
  statemachine."
  (LET (($SM (CONTAINING-STATE-MACHINE SELF)))
    (OCL-IF (OCL-OR (OCL-IS-EMPTY (%CONTEXT $SM))
                    (OCL-NOT-EMPTY (%GENERAL $SM)))
            $SM
            (%CONTEXT $SM))))

#|   submachine.notEmpty() |#
(DEFMETHOD IS-SUBMACHINE-STATE.1
  ((SELF |State|))
  "  Only submachine states can have a reference statemachine."
  (OCL-NOT-EMPTY (%SUBMACHINE SELF)))

#|   (region->size () > 1) |#
(DEFMETHOD IS-ORTHOGONAL.1
  ((SELF |State|))
  "  An orthogonal state is a composite state with at least 2 regions"
  (OCL-> (OCL-SIZE (%REGION SELF)) 1))

#|   region.notEmpty() |#
(DEFMETHOD IS-COMPOSITE.1
  ((SELF |State|))
  "  A composite state is a state with at least one region."
  (OCL-NOT-EMPTY (%REGION SELF)))

#|   region.isEmpty() |#
(DEFMETHOD IS-SIMPLE.1
  ((SELF |State|))
  "  A simple state is a state without any regions."
  (OCL-IS-EMPTY (%REGION SELF)))

#|   container.containingStateMachine() |#
(DEFMETHOD CONTAINING-STATE-MACHINE
  ((SELF |State|))
  "  The query containingStateMachine() returns the state machine
  that contains the state either directly or transitively."
  (CONTAINING-STATE-MACHINE (%CONTAINER SELF)))

#|   def: isConsistentWith (redefinee : RedefinableElement) true |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |State|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  :TRUE)

#|   def: isRedefinitionContextValid (redefined : State) true |#
(DEFMETHOD IS-REDEFINITION-CONTEXT-VALID
  ((SELF |State|) $REDEFINED)
  (OCL-ASSERT (|State| $REDEFINED))
  :TRUE)

;;; Constraint submachine_states:
#|   isSubmachineState implies connection->notEmpty ( ) |#
;;; Constraint destinations_or_sources_of_transitions:
#|   self.isSubmachineState implies (self.connection->forAll (cp |
  cp.entry->forAll (p | p.stateMachine = self.submachine) and cp.exit->forAll
  (p | p.stateMachine = self.submachine))) |#
;;; Constraint submachine_or_regions:
#|   isComposite implies not isSubmachineState |#
;;; Constraint composite_states:
#|   connectionPoint->notEmpty() implies isComposite |#
;;; Constraint entry_or_exit:
#|   connectionPoint->forAll(cp|cp.kind = #entry or cp.kind = #exit) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |State|))
  (WITH-OCL-CONTEXT (|State|)
    (WITH-CONSTRAINT ("submachine_states")
      (OCL-IMPLIES (%IS-SUBMACHINE-STATE SELF)
                   (OCL-NOT-EMPTY (%CONNECTION SELF))))
    (WITH-CONSTRAINT ("destinations_or_sources_of_transitions")
      (OCL-IMPLIES (%IS-SUBMACHINE-STATE SELF)
                   (OCL-FOR-ALL (%CONNECTION SELF)
                                #'(LAMBDA
                                   ($CP)
                                   (OCL-AND
                                    (OCL-FOR-ALL
                                     (%ENTRY $CP)
                                     #'(LAMBDA
                                        ($P)
                                        (OCL-=
                                         (%STATE-MACHINE $P)
                                         (%SUBMACHINE SELF))))
                                    (OCL-FOR-ALL
                                     (%EXIT $CP)
                                     #'(LAMBDA
                                        ($P)
                                        (OCL-=
                                         (%STATE-MACHINE $P)
                                         (%SUBMACHINE SELF)))))))))
    (WITH-CONSTRAINT ("submachine_or_regions")
      (OCL-IMPLIES (%IS-COMPOSITE SELF)
                   (OCL-NOT (%IS-SUBMACHINE-STATE SELF))))
    (WITH-CONSTRAINT ("composite_states")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%CONNECTION-POINT SELF))
                   (%IS-COMPOSITE SELF)))
    (WITH-CONSTRAINT ("entry_or_exit")
      (OCL-FOR-ALL (%CONNECTION-POINT SELF)
                   #'(LAMBDA ($CP)
                       (OCL-OR (OCL-= (%KIND $CP) :ENTRY)
                               (OCL-= (%KIND $CP) :EXIT)))))))

;;;==================================
;;; StateMachine
;;;==================================
#|   def: isConsistentWith (redefinee : RedefinableElement) true |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |StateMachine|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  :TRUE)

#|   def: isRedefinitionContextValid (redefined : StateMachine) true |#
(DEFMETHOD IS-REDEFINITION-CONTEXT-VALID
  ((SELF |StateMachine|) $REDEFINED)
  (OCL-ASSERT (|StateMachine| $REDEFINED))
  :TRUE)

#|   def: ancestor (s1 : State, s2 : State) if (s2 = s1) then true
  else if (s1.container->isEmpty()) then true else if (s2.container->isEmpty())
  then false else (ancestor (s1, s2.container)) endif endif endif |#
(DEFMETHOD ANCESTOR
  ((SELF |StateMachine|) $S1 $S2)
  (OCL-ASSERT (|State| $S1))
  (OCL-ASSERT (|State| $S2))
  (OCL-IF (OCL-= $S2 $S1)
          :TRUE
          (OCL-IF (OCL-IS-EMPTY (%CONTAINER $S1))
                  :TRUE
                  (OCL-IF (OCL-IS-EMPTY (%CONTAINER $S2))
                          :FALSE
                          (ANCESTOR SELF $S1 (%CONTAINER $S2))))))

#|   def: LCA (s1 : State, s2 : State) true |#
(DEFMETHOD L-C-A
  ((SELF |StateMachine|) $S1 $S2)
  (OCL-ASSERT (|State| $S1))
  (OCL-ASSERT (|State| $S2))
  :TRUE)

;;; Constraint classifier_context:
#|   context->notEmpty() implies not context.oclIsKindOf(Interface) |#
;;; Constraint context_classifier:
#|   specification->notEmpty() implies (context->notEmpty() and specification->featuringClassifier->exists
  (c | c = context)) |#
;;; Constraint connection_points:
#|   connectionPoint->forAll (c | c.kind = #entryPoint or c.kind =
  #exitPoint) |#
;;; Constraint method:
#|   specification->notEmpty() implies connectionPoint->isEmpty() |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StateMachine|))
  (WITH-OCL-CONTEXT (|StateMachine|)
    (WITH-CONSTRAINT ("classifier_context")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%CONTEXT SELF))
                   (OCL-NOT (OCL-IS-KIND-OF (%CONTEXT SELF)
                                            (find-class '|Interface|)))))
    (WITH-CONSTRAINT ("context_classifier")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%SPECIFICATION SELF))
                   (OCL-AND (OCL-NOT-EMPTY (%CONTEXT SELF))
                            (OCL-EXISTS (%FEATURING-CLASSIFIER
                                         (%SPECIFICATION SELF))
                                        #'(LAMBDA
                                           ($C)
                                           (OCL-=
                                            $C
                                            (%CONTEXT SELF)))))))
    (WITH-CONSTRAINT ("connection_points")
      (OCL-FOR-ALL (%CONNECTION-POINT SELF)
                   #'(LAMBDA ($C)
                       (OCL-OR (OCL-= (%KIND $C) :ENTRYPOINT)
                               (OCL-= (%KIND $C) :EXITPOINT)))))
    (WITH-CONSTRAINT ("method")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%SPECIFICATION SELF))
                   (OCL-IS-EMPTY (%CONNECTION-POINT SELF))))))

;;;==================================
;;; Stereotype
;;;==================================
;;; Constraint generalize:
#|   generalization.general->forAll(e |e.oclIsKindOf(Stereotype))
  and generalization.specific->forAll(e | e.oclIsKindOf(Stereotype)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Stereotype|))
  (WITH-OCL-CONTEXT (|Stereotype|)
    (WITH-CONSTRAINT ("name_not_clash") :TRUE)
    (WITH-CONSTRAINT ("generalize")
      (OCL-AND (OCL-FOR-ALL (%GENERAL (%GENERALIZATION SELF))
                            #'(LAMBDA ($E)
                                (OCL-IS-KIND-OF $E (find-class '|Stereotype|))))
               (OCL-FOR-ALL (%SPECIFIC (%GENERALIZATION SELF))
                            #'(LAMBDA ($E)
                                (OCL-IS-KIND-OF $E (find-class '|Stereotype|))))))))

;;;==================================
;;; StringExpression
;;;==================================
#|   if subExpression->notEmpty() then subExpression->iterate(se;
  stringValue = '' | stringValue.concat(se.stringValue())) else
  operand->iterate(op; stringValue = '' | stringValue.concat(op.value))
  endif |#
(DEFMETHOD STRING-VALUE
  ((SELF |StringExpression|))
  "  The query stringValue() returns the string that concatenates,
  in order, all the component string literals of all the subexpressions
  that are part of the StringExpression."
  (OCL-IF (OCL-NOT-EMPTY (%SUB-EXPRESSION SELF))
          (OCL-ITERATE (%SUB-EXPRESSION SELF)
                       $SE
                       $STRINGVALUE
                       ""
                       (OCL-CONCAT $STRINGVALUE (STRING-VALUE $SE)))
          (OCL-ITERATE (%OPERAND SELF)
                       $OP
                       $STRINGVALUE
                       ""
                       (OCL-CONCAT $STRINGVALUE (%VALUE $OP)))))

;;; Constraint operands:
#|   operand->forAll (op | op.oclIsKindOf (LiteralString)) |#
;;; Constraint subexpressions:
#|   if subExpression->notEmpty() then operand->isEmpty() else operand->notEmpty()
  endif |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StringExpression|))
  (WITH-OCL-CONTEXT (|StringExpression|)
    (WITH-CONSTRAINT ("operands")
      (OCL-FOR-ALL (%OPERAND SELF)
                   #'(LAMBDA ($OP)
                       (OCL-IS-KIND-OF $OP (find-class '|LiteralString|)))))
    (WITH-CONSTRAINT ("subexpressions")
      (OCL-IF (OCL-NOT-EMPTY (%SUB-EXPRESSION SELF))
              (OCL-IS-EMPTY (%OPERAND SELF))
              (OCL-NOT-EMPTY (%OPERAND SELF))))))

;;;==================================
;;; StructuralFeatureAction
;;;==================================
;;; Constraint not_static:
#|   self.structuralFeature.isStatic = #false |#
;;; Constraint multiplicity:
#|   self.object.is(1,1) |#
;;; Constraint one_featuring_classifier:
#|   self.structuralFeature.featuringClassifier->size() = 1 |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StructuralFeatureAction|))
  (WITH-OCL-CONTEXT (|StructuralFeatureAction|)
    (WITH-CONSTRAINT ("not_static")
      (OCL-= (%IS-STATIC (%STRUCTURAL-FEATURE SELF)) :FALSE))
    (WITH-CONSTRAINT ("same_type") :TRUE)
    (WITH-CONSTRAINT ("multiplicity") (IS (%OBJECT SELF) 1 1))
    (WITH-CONSTRAINT ("one_featuring_classifier")
      (OCL-= (OCL-SIZE (%FEATURING-CLASSIFIER (%STRUCTURAL-FEATURE
                                               SELF)))
             1))))

;;;==================================
;;; StructuredActivityNode
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StructuredActivityNode|))
  (WITH-OCL-CONTEXT (|StructuredActivityNode|)
    (WITH-CONSTRAINT ("edges") :TRUE)))

;;;==================================
;;; StructuredClassifier
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |StructuredClassifier|))
  (WITH-OCL-CONTEXT (|StructuredClassifier|)
    (WITH-CONSTRAINT ("multiplicities") :TRUE)))

;;;==================================
;;; TemplateBinding
;;;==================================
;;; Constraint parameter_substitution_formal:
#|   parameterSubstitution->forAll(b | template.parameter->includes(b.formal)) |#
;;; Constraint one_parameter_substitution:
#|   template.parameter->forAll(p | parameterSubstitution->select(b
  | b.formal = p)->size() <= 1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |TemplateBinding|))
  (WITH-OCL-CONTEXT (|TemplateBinding|)
    (WITH-CONSTRAINT ("parameter_substitution_formal")
      (OCL-FOR-ALL (%PARAMETER-SUBSTITUTION SELF)
                   #'(LAMBDA ($B)
                       (OCL-INCLUDES (%PARAMETER (%TEMPLATE SELF))
                                     (%FORMAL $B)))))
    (WITH-CONSTRAINT ("one_parameter_substitution")
      (OCL-FOR-ALL (%PARAMETER (%TEMPLATE SELF))
                   #'(LAMBDA ($P)
                       (OCL-<= (OCL-SIZE
                                (OCL-SELECT
                                 (%PARAMETER-SUBSTITUTION SELF)
                                 #'(LAMBDA
                                    ($B)
                                    (OCL-= (%FORMAL $B) $P))))
                               1))))))

;;;==================================
;;; TemplateParameter
;;;==================================
;;; Constraint must_be_compatible:
#|   default->notEmpty() implies default->isCompatibleWith(parameteredElement) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |TemplateParameter|))
  (WITH-OCL-CONTEXT (|TemplateParameter|)
    (WITH-CONSTRAINT ("must_be_compatible")
      (OCL-IMPLIES (OCL-NOT-EMPTY (%DEFAULT SELF))
                   (IS-COMPATIBLE-WITH (%DEFAULT SELF)
                                       (%PARAMETERED-ELEMENT SELF))))))

;;;==================================
;;; TemplateParameterSubstitution
;;;==================================
;;; Constraint must_be_compatible:
#|   actual->forAll(a | a.isCompatibleWith(formal.parameteredElement)) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |TemplateParameterSubstitution|))
  (WITH-OCL-CONTEXT (|TemplateParameterSubstitution|)
    (WITH-CONSTRAINT ("must_be_compatible")
      (OCL-FOR-ALL (%ACTUAL SELF)
                   #'(LAMBDA ($A)
                       (IS-COMPATIBLE-WITH $A
                                           (%PARAMETERED-ELEMENT
                                            (%FORMAL SELF))))))))

;;;==================================
;;; TemplateableElement
;;;==================================
#|   ownedTemplateSignature->notEmpty() |#
(DEFMETHOD IS-TEMPLATE
  ((SELF |TemplateableElement|))
  "  The query isTemplate() returns whether this templateable element
  is actually a template."
  (OCL-NOT-EMPTY (%OWNED-TEMPLATE-SIGNATURE SELF)))

#|   allOwnedElements()->select(oclIsKindOf(ParameterableElement)) |#
(DEFMETHOD PARAMETERABLE-ELEMENTS
  ((SELF |TemplateableElement|))
  "  The query parameterableElements() returns the set of elements
  that may be used as the parametered elements for a template parameter
  of this templateable element. By default, this set includes all
  the owned elements. Subclasses may override this operation if
  they choose to restrict the set of parameterable elements."
  (OCL-SELECT (ALL-OWNED-ELEMENTS SELF)
              #'(LAMBDA (%VAR-21)
                  (OCL-IS-KIND-OF %VAR-21 (find-class '|ParameterableElement|)))))

;;;==================================
;;; TestIdentityAction
;;;==================================
;;; Constraint no_type:
#|   self.first.type->size() = 0 and self.second.type->size() = 0 |#
;;; Constraint multiplicity:
#|   self.first.is(1,1) and self.second.is(1,1) |#
;;; Constraint result_is_boolean:
#|   self.result.type.oclIsTypeOf(Boolean) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |TestIdentityAction|))
  (WITH-OCL-CONTEXT (|TestIdentityAction|)
    (WITH-CONSTRAINT ("no_type")
      (OCL-AND (OCL-= (OCL-SIZE (%TYPE (%FIRST SELF))) 0)
               (OCL-= (OCL-SIZE (%TYPE (%SECOND SELF))) 0)))
    (WITH-CONSTRAINT ("multiplicity")
      (OCL-AND (IS (%FIRST SELF) 1 1) (IS (%SECOND SELF) 1 1)))
    (WITH-CONSTRAINT ("result_is_boolean")
      (OCL-IS-TYPE-OF (%TYPE (%RESULT SELF)) '|Boolean|))))

;;;==================================
;;; TimeEvent
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |TimeEvent|))
  (WITH-OCL-CONTEXT (|TimeEvent|)
    (WITH-CONSTRAINT ("when_non_negative") :TRUE)
    (WITH-CONSTRAINT ("starting_time") :TRUE)))

;;;==================================
;;; Transition
;;;==================================
#|   container.containingStateMachine() |#
(DEFMETHOD CONTAINING-STATE-MACHINE
  ((SELF |Transition|))
  "  The query containingStateMachine() returns the state machine
  that contains the transition either directly or transitively."
  (CONTAINING-STATE-MACHINE (%CONTAINER SELF)))

#|   def: isConsistentWith (redefinee : RedefinableElement) redefinedTransition.oclIsKindOf(Transition)
  and               let trans: Transition = redefinedTransition.oclAsType(Transition)
  in                  (source = trans.source) and (trigger = trans.trigger) |#
(DEFMETHOD IS-CONSISTENT-WITH
  ((SELF |Transition|) $REDEFINEE)
  (OCL-ASSERT (|RedefinableElement| $REDEFINEE))
  (OCL-AND (OCL-IS-KIND-OF (%REDEFINED-TRANSITION SELF) (find-class '|Transition|))
           (LET (($TRANS
                  (OCL-AS-TYPE (%REDEFINED-TRANSITION SELF)
                               '|Transition|)))
             (OCL-ASSERT (|Transition| $TRANS))
             (OCL-AND (OCL-= (%SOURCE SELF) (%SOURCE $TRANS))
                      (OCL-= (%TRIGGER SELF) (%TRIGGER $TRANS))))))

#|   let sm = containingStateMachine() in if sm.context->isEmpty()
  or sm.general->notEmpty() then sm else sm.context endif |#
(DEFMETHOD REDEFINITION-CONTEXT.1
  ((SELF |Transition|))
  "  The redefinition context of a transition is the nearest containing
  statemachine."
  (LET (($SM (CONTAINING-STATE-MACHINE SELF)))
    (OCL-IF (OCL-OR (OCL-IS-EMPTY (%CONTEXT $SM))
                    (OCL-NOT-EMPTY (%GENERAL $SM)))
            $SM
            (%CONTEXT $SM))))

;;; Constraint outgoing_pseudostates:
#|   source.oclIsKindOf(Pseudostate) and ((source.kind <> #junction)
  and (source.kind <> #join) and (source.kind <> #initial)) implies
  trigger->isEmpty() |#
;;; Constraint join_segment_state:
#|   (target.oclIsKindOf(Pseudostate) and target.kind = #join) implies
  (source.oclIsKindOf(State)) |#
;;; Constraint fork_segment_state:
#|   (source.oclIsKindOf(Pseudostate) and source.kind = #fork) implies
  (target.oclIsKindOf(State)) |#
;;; Constraint join_segment_guards:
#|   (target.oclIsKindOf(Pseudostate) and target.kind = #join) implies
  (guard->isEmpty() and trigger->isEmpty()) |#
;;; Constraint fork_segment_guards:
#|   (source.oclIsKindOf(Pseudostate) and source.kind = #fork) implies
  (guard->isEmpty() and trigger->isEmpty()) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Transition|))
  (WITH-OCL-CONTEXT (|Transition|)
    (WITH-CONSTRAINT ("outgoing_pseudostates")
      (OCL-IMPLIES (OCL-AND (OCL-IS-KIND-OF (%SOURCE SELF)
                                            (find-class '|Pseudostate|))
                            (OCL-AND (OCL-AND
                                      (OCL-<>
                                       (%KIND (%SOURCE SELF))
                                       :JUNCTION)
                                      (OCL-<>
                                       (%KIND (%SOURCE SELF))
                                       :JOIN))
                                     (OCL-<>
                                      (%KIND (%SOURCE SELF))
                                      :INITIAL)))
                   (OCL-IS-EMPTY (%TRIGGER SELF))))
    (WITH-CONSTRAINT ("join_segment_state")
      (OCL-IMPLIES (OCL-AND (OCL-IS-KIND-OF (%TARGET SELF)
                                            (find-class '|Pseudostate|))
                            (OCL-= (%KIND (%TARGET SELF)) :JOIN))
                   (OCL-IS-KIND-OF (%SOURCE SELF) '|State|)))
    (WITH-CONSTRAINT ("fork_segment_state")
      (OCL-IMPLIES (OCL-AND (OCL-IS-KIND-OF (%SOURCE SELF)
                                            (find-class '|Pseudostate|))
                            (OCL-= (%KIND (%SOURCE SELF)) :FORK))
                   (OCL-IS-KIND-OF (%TARGET SELF) (find-class '|State|))))
    (WITH-CONSTRAINT ("join_segment_guards")
      (OCL-IMPLIES (OCL-AND (OCL-IS-KIND-OF (%TARGET SELF)
                                            (find-class '|Pseudostate|))
                            (OCL-= (%KIND (%TARGET SELF)) :JOIN))
                   (OCL-AND (OCL-IS-EMPTY (%GUARD SELF))
                            (OCL-IS-EMPTY (%TRIGGER SELF)))))
    (WITH-CONSTRAINT ("signatures_compatible") :TRUE)
    (WITH-CONSTRAINT ("fork_segment_guards")
      (OCL-IMPLIES (OCL-AND (OCL-IS-KIND-OF (%SOURCE SELF)
                                            (find-class '|Pseudostate|))
                            (OCL-= (%KIND (%SOURCE SELF)) :FORK))
                   (OCL-AND (OCL-IS-EMPTY (%GUARD SELF))
                            (OCL-IS-EMPTY (%TRIGGER SELF)))))))

;;;==================================
;;; Type
;;;==================================
#|   def: conformsTo (other : Type) false |#
(DEFMETHOD CONFORMS-TO
  ((SELF |Type|) $OTHER)
  (OCL-ASSERT (|Type| $OTHER))
  :FALSE)

;;;==================================
;;; UnmarshallAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |UnmarshallAction|))
  (WITH-OCL-CONTEXT (|UnmarshallAction|)
    (WITH-CONSTRAINT ("structural_feature") :TRUE)
    (WITH-CONSTRAINT ("type_and_ordering") :TRUE)
    (WITH-CONSTRAINT ("number_of_result") :TRUE)
    (WITH-CONSTRAINT ("same_type") :TRUE)
    (WITH-CONSTRAINT ("multiplicity_of_result") :TRUE)
    (WITH-CONSTRAINT ("unmarshallType_is_classifier") :TRUE)
    (WITH-CONSTRAINT ("multiplicity_of_object") :TRUE)))

;;;==================================
;;; UseCase
;;;==================================
#|   self.include->union(self.include->collect(in | in.allIncludedUseCases())) |#
(DEFMETHOD ALL-INCLUDED-USE-CASES
  ((SELF |UseCase|))
  "  The query allIncludedUseCases() returns the transitive closure
  of all use cases (directly or indirectly) included by this use
  case."
  (OCL-UNION (%INCLUDE SELF)
             (OCL-COLLECT (%INCLUDE SELF)
                          #'(LAMBDA ($IN)
                              (ALL-INCLUDED-USE-CASES $IN)))))

;;; Constraint must_have_name:
#|   self.name -> notEmpty () |#
;;; Constraint cannot_include_self:
#|   not self.allIncludedUseCases()->includes(self) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |UseCase|))
  (WITH-OCL-CONTEXT (|UseCase|)
    (WITH-CONSTRAINT ("must_have_name") (OCL-NOT-EMPTY (%NAME SELF)))
    (WITH-CONSTRAINT ("binary_associations") :TRUE)
    (WITH-CONSTRAINT ("no_association_to_use_case") :TRUE)
    (WITH-CONSTRAINT ("cannot_include_self")
      (OCL-NOT (OCL-INCLUDES (ALL-INCLUDED-USE-CASES SELF) SELF)))))

;;;==================================
;;; ValuePin
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ValuePin|))
  (WITH-OCL-CONTEXT (|ValuePin|)
    (WITH-CONSTRAINT ("compatible_type") :TRUE)
    (WITH-CONSTRAINT ("no_incoming_edges") :TRUE)))

;;;==================================
;;; ValueSpecification
;;;==================================
#|   value.oclAsType(UnlimitedNatural) |#
(DEFMETHOD UNLIMITED-VALUE
  ((SELF |ValueSpecification|))
  "  The query unlimitedValue() gives a single UnlimitedNatural value
  when one can be computed."
  (OCL-AS-TYPE (%VALUE SELF) '|UnlimitedNatural|))

#|   false |#
(DEFMETHOD IS-NULL
  ((SELF |ValueSpecification|))
  "  The query isNull() returns true when it can be computed that
  the value is null."
  :FALSE)

#|   Set{} |#
(DEFMETHOD BOOLEAN-VALUE
  ((SELF |ValueSpecification|))
  "  The query booleanValue() gives a single Boolean value when one
  can be computed."
  (MAKE-INSTANCE '|Set| :VALUE NIL))

#|   Set{} |#
(DEFMETHOD STRING-VALUE
  ((SELF |ValueSpecification|))
  "  The query stringValue() gives a single String value when one
  can be computed."
  (MAKE-INSTANCE '|Set| :VALUE NIL))

#|   def: isCompatibleWith (p : ParameterableElement) p->oclIsKindOf(self.oclType())
  and self.type.conformsTo(p.oclAsType(TypedElement).type) |#
(DEFMETHOD IS-COMPATIBLE-WITH
  ((SELF |ValueSpecification|) $P)
  (OCL-ASSERT (|ParameterableElement| $P))
  (OCL-AND (OCL-IS-KIND-OF $P (OCL-TYPE SELF))
           (CONFORMS-TO (%TYPE SELF)
                        (%TYPE (OCL-AS-TYPE $P (find-class '|TypedElement|))))))

#|   Set{} |#
(DEFMETHOD INTEGER-VALUE
  ((SELF |ValueSpecification|))
  "  The query integerValue() gives a single Integer value when one
  can be computed."
  (MAKE-INSTANCE '|Set| :VALUE NIL))

#|   false |#
(DEFMETHOD IS-COMPUTABLE
  ((SELF |ValueSpecification|))
  "  The query isComputable() determines whether a value specification
  can be computed in a model. This operation cannot be fully defined
  in OCL. A conforming implementation is expected to deliver true
  for this operation for all value specifications that it can compute,
  and to compute all of those for which the operation is true.
  A conforming implementation is expected to be able to compute
  the value of all literals."
  :FALSE)

;;;==================================
;;; ValueSpecificationAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |ValueSpecificationAction|))
  (WITH-OCL-CONTEXT (|ValueSpecificationAction|)
    (WITH-CONSTRAINT ("compatible_type") :TRUE)
    (WITH-CONSTRAINT ("multiplicity") :TRUE)))

;;;==================================
;;; Variable
;;;==================================
#|   def: isAccessibleBy (a : Action) true |#
(DEFMETHOD IS-ACCESSIBLE-BY
  ((SELF |Variable|) $A)
  (OCL-ASSERT (|Action| $A))
  :TRUE)

(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |Variable|))
  (WITH-OCL-CONTEXT (|Variable|) (WITH-CONSTRAINT ("owned") :TRUE)))

;;;==================================
;;; VariableAction
;;;==================================
;;; Constraint scope_of_variable:
#|   self.variable.isAccessibleBy(self) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |VariableAction|))
  (WITH-OCL-CONTEXT (|VariableAction|)
    (WITH-CONSTRAINT ("scope_of_variable")
      (IS-ACCESSIBLE-BY (%VARIABLE SELF) SELF))))

;;;==================================
;;; Vertex
;;;==================================
#|   if not container->isEmpty()    then container.containingStateMachine()
     else if (oclIsKindOf(Pseudostate))             then if (kind
  = #entryPoint) or (kind = #exitPoint)                      then
  stateMachine                     else if (oclIsKindOf(ConnectionPointReference))
                               then state.containingStateMachine()
  -- no other valid cases possible                            
  else false                           endif                 endif
             else false        endif endif |#
(DEFMETHOD CONTAINING-STATE-MACHINE
  ((SELF |Vertex|))
  "  The operation containingStateMachine() returns the state machine
  in which this Vertex is defined"
  (OCL-IF (OCL-NOT (OCL-IS-EMPTY (%CONTAINER SELF)))
          (CONTAINING-STATE-MACHINE (%CONTAINER SELF))
          (OCL-IF (OCL-IS-KIND-OF SELF (find-class '|Pseudostate|))
                  (OCL-IF (OCL-OR (OCL-= (%KIND SELF) :ENTRYPOINT)
                                  (OCL-= (%KIND SELF) :EXITPOINT))
                          (%STATE-MACHINE SELF)
                          (OCL-IF (OCL-IS-KIND-OF
                                   SELF
                                   (find-class '|ConnectionPointReference|))
                                  (CONTAINING-STATE-MACHINE
                                   (%STATE SELF))
                                  :FALSE))
                  :FALSE)))

;;;==================================
;;; WriteLinkAction
;;;==================================
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |WriteLinkAction|))
  (WITH-OCL-CONTEXT (|WriteLinkAction|)
    (WITH-CONSTRAINT ("allow_access") :TRUE)))

;;;==================================
;;; WriteStructuralFeatureAction
;;;==================================
;;; Constraint input_pin:
#|   self.value.type = self.structuralFeature.featuringClassifier |#
;;; Constraint multiplicity:
#|   self.value.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |WriteStructuralFeatureAction|))
  (WITH-OCL-CONTEXT (|WriteStructuralFeatureAction|)
    (WITH-CONSTRAINT ("input_pin")
      (OCL-= (%TYPE (%VALUE SELF))
             (%FEATURING-CLASSIFIER (%STRUCTURAL-FEATURE SELF))))
    (WITH-CONSTRAINT ("multiplicity") (IS (%VALUE SELF) 1 1))))

;;;==================================
;;; WriteVariableAction
;;;==================================
;;; Constraint same_type:
#|   self.value.type = self.variable.type |#
;;; Constraint multiplicity:
#|   self.value.is(1,1) |#
(DEFMETHOD OCL-CONSTRAINTS
  :AFTER
  ((SELF |WriteVariableAction|))
  (WITH-OCL-CONTEXT (|WriteVariableAction|)
    (WITH-CONSTRAINT ("same_type")
      (OCL-= (%TYPE (%VALUE SELF)) (%TYPE (%VARIABLE SELF))))
    (WITH-CONSTRAINT ("multiplicity") (IS (%VALUE SELF) 1 1))))
