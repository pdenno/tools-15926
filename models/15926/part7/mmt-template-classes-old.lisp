
(in-package :MMTC)

(mofi:def-mm-class |ActivityCausesBeginningOfIndividual| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesBeginningOfTemporalPart| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfBegun| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesEndingOfIndividual| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesEndingOfTemporalPart| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfEnded| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |AggregateOfMonotypeIndividual| :MMTC NIL
   ""
   ((|hasParticleType| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   (|hasObjectType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasAggregate| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valAggregateCount| :range ptypes:|Integer| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ApprovalWithStatusByIndividual| :MMTC NIL
   ""
   ((|hasApprover| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationship| :range DM:RELATIONSHIP :multiplicity (1 1))
   (|hasStatus| :range DM:CLASS_OF_APPROVAL_BY_STATUS :multiplicity (1 1))
   ))

(mofi:def-mm-class |ArrangementOfAnIndividual| :MMTC NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasArrangementType| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ArrangementOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasArrangementType| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |AssemblyOfAnIndividual| :MMTC NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasAssemblyType| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |AssemblyOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasAssemblyType| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfIndividual| :MMTC NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfPossibleIndividualAtClassifiedEvent| :MMTC NIL
   ""
   ((|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:THING :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfTemporalPartAtClassifiedEvent| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfArrangementDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfAssemblyDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCauseOfBeginningOfClassOfIndividualDefinition| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasIndividualType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCauseOfEndingOfClassOfIndividualDefinition| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasIndividualType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCompositionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_COMPOSITION_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfContainmentDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfLocator| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfLocated| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfDirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_DIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfFeatureWholePartDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfInIndividualWithEnumeratedIndirectProperties| :MMTC NIL
   ""
   ((|hasSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithBoundingValues| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valLowerBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|valUpperBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithMaximumValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valMaximumValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithMinimumValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valMinimumValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithPointValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valPointValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithReferencePropertySpace| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasPropertySpaceType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndividualUsedInDirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfConnection| :range DM:CLASS_OF_DIRECT_CONNECTION :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfUsed| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfConnection| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndividualUsedInIndirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfConnection| :range DM:CLASS_OF_INDIRECT_CONNECTION :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfUsed| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfConnection| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfInvolvementByReferenceDefinition| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasInvolvedType| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvedRole| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfInvolved| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfParticipationApplicableYesNo| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasParticipantType| :range DM:THING :multiplicity (1 1))
   (|hasParticipantRole| :range DM:ROLE :multiplicity (1 1))
   (|hasApplicableYesNo| :range DM:CLASS_OF_ASSERTION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfParticipationDefinition| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   (|hasParticipantType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipantRole| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRecognitionDefinition| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasRecognized| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfRecognized| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRelationshipWithDualParticipation| :MMTC NIL
   ""
   ((|hasUrClassOfParticipant1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfParticipant1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfParticipant1| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfParticipant2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfParticipant2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfParticipant2| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfParticipant1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRelationshipWithParticipationAndReference| :MMTC NIL
   ""
   ((|hasUrClassOfParticipant1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfParticipant1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfParticipant1| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfParticipant2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfParticipant2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfParticipant2| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfParticipant1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRelativeLocationDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasLocationType| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   (|hasCardinalityOfLocator| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfLocated| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfShapeDefinition| :MMTC NIL
   ""
   ((|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasShapeDimension| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfShapeOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasPossessorCardinality| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfShapeWithEnumeratedShapeDimensions| :MMTC NIL
   ""
   ((|hasSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfStreamDestination| :MMTC NIL
   ""
   ((|hasUrClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfDestination| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfDestination| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfStream| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfDestination| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfStreamSource| :MMTC NIL
   ""
   ((|hasUrClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSource| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSource| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfStream| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSource| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified| :range DM:CLASS :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividual| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithBiologicalMatterType| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithCompositeMaterialType| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOSITE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithCompoundType| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithParticulateMaterialType| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithPhase| :MMTC NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:PHASE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifierType| :range DM:CLASS_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithBiologicalMatterType| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithCompositeMaterialType| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOSITE_MATERIAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithCompoundType| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithParticulateMaterialType| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithPhase| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:PHASE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedClassOfDirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_DIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedClassOfIndirectConnectionDefinition| :MMTC NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDefinitionOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|valDefinition| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDefinitionType| :range DM:CLASS_OF_CLASS_OF_DEFINITION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfClassInLanguage| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfIndividual| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfIndividualInLanguage| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfTemporalPartInLanguage| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfClassInLanguage| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfIndividual| :MMTC NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfAnIndividual| :MMTC NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCompositionType| :range DM:CLASS_OF_COMPOSITION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfClassOfInformationRepresentation| :MMTC NIL
   ""
   ((|hasWhole| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasPart| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfOIM| :MMTC NIL
   ""
   ((|hasEnumeratedSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasMember| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCompositionType| :range DM:THING :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyOfClassOfIndividualWithValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyWithValueOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyWithValueOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContainmentOfAnIndividual| :MMTC NIL
   ""
   ((|hasContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainerType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContainmentOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContentsOfADocument| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasContents| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefiningAClassVariant| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasObject| :range DM:CLASS :multiplicity (1 1))
   (|hasOIM| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefiningACoordinateSystem| :MMTC NIL
   ""
   ((|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|hasXNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasYNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasZNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfAnInformationRepresentation| :MMTC NIL
   ""
   ((|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasDefinition| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|valDefinition| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithClassifiedSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithExternalCode| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasShape| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresentationType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   (|valRepresentation| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfShapeRepresentationWithExternalCode| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:SHAPE :multiplicity (1 1))
   (|hasShape| :range DM:SHAPE :multiplicity (1 1))
   (|hasRepresentationType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   (|valRepresentation| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
    ;pod(|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassInLanguage| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassWithClassifiedSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassWithSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividual| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualInLanguage| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualWithClassifiedSign| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualWithSign| :MMTC NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartInLanguage| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range PTYPES:|String| :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartWithClassifiedSign| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartWithSign| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DifferenceOf2Classes| :MMTC NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassDifference| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DimensionedShapeOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasShapeDimension| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DirectConnectionOfTwoIndividuals| :MMTC NIL
   ""
   ((|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DirectConnectionOfTwoTemporalParts| :MMTC NIL
   ""
   ((|hasTemporalWholeOfSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DisjointnessOf2Classes| :MMTC NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentApproval| :MMTC NIL
   ""
   ((|hasApprovingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasApprovedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasApprovalStatus| :range DM:STATUS :multiplicity (1 1))
   (|valApprovalDate| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentDefinitionByExample| :MMTC NIL
   ""
   ((|hasDefinition| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasExample| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentPublishing| :MMTC NIL
   ""
   ((|hasPublishingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPublishedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasPublishingStatus| :range DM:STATUS :multiplicity (1 1))
   (|valPublishingDate| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentRevision| :MMTC NIL
   ""
   ((|hasRevisingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUrDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRevisedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRevisedContent| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|valRevisionDate| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentTypeAboutAClassApplicableYesNo| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasDocumentType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasApplicableYesNo| :range DM:CLASS_OF_ASSERTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |EditorialChangeOfInformationRepresentation| :MMTC NIL
   ""
   ((|hasEditingInput| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasEditingResult| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |EmploymentOfClassOfPersonByClassOfOrganization| :MMTC NIL
   ""
   ((|hasUrClassOfPerson| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPerson| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfPerson| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfOrganization| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfOrganization| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfOrganization| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfEmployee| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfEmployer| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |EmploymentOfPersonByOrganization| :MMTC NIL
   ""
   ((|hasEmployee| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmployer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmploymentType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |EmploymentOfTemporalPartOfPersonByOrganization| :MMTC NIL
   ""
   ((|hasEmployeeTemporalWhole| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasEmployee| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasEmployerTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmployer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmploymentType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfIndividual| :MMTC NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfPossibleIndividualAtClassifiedEvent| :MMTC NIL
   ""
   ((|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfTemporalPartAtClassifiedEvent| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EnumeratedSetOf2Classes| :MMTC NIL
   ""
   ((|hasClassified1| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified2| :range DM:CLASS :multiplicity (1 1))
   (|hasEnumeratedSetOfClass| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |EnumeratedSetOf3Classes| :MMTC NIL
   ""
   ((|hasClassified1| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified2| :range DM:CLASS :multiplicity (1 1))
   (|hasEnumeratedSetOfClass| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasClassified3| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |EruptingBehaviourOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorRole| :range DM:ROLE :multiplicity (1 1))
   (|hasCausingActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasBehaviour| :range DM:THING :multiplicity (1 1))
   (|hasCardinalityOfPossessor| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfBehaviour| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfCausingActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfBegunActivity| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |EruptingBehaviourOfIndividual| :MMTC NIL
   ""
   ((|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfBeginningType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEventTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |EruptingBehaviourOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfBeginningType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |FeatureOfIndividual| :MMTC NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasFeatureWholePartType| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   ))

(mofi:def-mm-class |FeatureOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasFeatureType| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |FunctionalMappingWith2Properties| :MMTC NIL
   ""
   ((|hasFunction| :range DM:CLASS_OF_FUNCTIONAL_MAPPING :multiplicity (1 1))
   (|hasInput1| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType1| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasInput2| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType2| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasResult| :range DM:PROPERTY :multiplicity (1 1))
   (|hasResultType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   ))

(mofi:def-mm-class |FunctionalMappingWith3Properties| :MMTC NIL
   ""
   ((|hasFunction| :range DM:CLASS_OF_FUNCTIONAL_MAPPING :multiplicity (1 1))
   (|hasInput1| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType1| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasInput2| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType2| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasInput3| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType3| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasResult| :range DM:PROPERTY :multiplicity (1 1))
   (|hasResultType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   ))

(mofi:def-mm-class |FunctionalPhysicalObjectFulfilsUnitOperation| :MMTC NIL
   ""
   ((|hasTemporalWholeOfUnitOperationn| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperationn| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
    ;pod(|NIL| :range DM:THING :multiplicity (1 1))
   (|hasFulfilment| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassInLanguage| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassWithClassifiedSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassWithSign| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividual| :MMTC NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividualWithClassifiedSign| :MMTC NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividualWithSign| :MMTC NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range PTYPES:|String| :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPartWithClassifiedSign| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPartWithSign| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectConnectionOfTwoIndividuals| :MMTC NIL
   ""
   ((|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectConnectionOfTwoTemporalParts| :MMTC NIL
   ""
   ((|hasTemporalWholeOfSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasReferenceProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyWithValueOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyWithValueOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndividualUsedInADirectConnection| :MMTC NIL
   ""
   ((|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndividualUsedInAnIndirectConnection| :MMTC NIL
   ""
   ((|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |InstallationOfTemporalPartMaterializedPhysicalObjectInFunctionPlace| :MMTC NIL
   ""
   ((|hasTemporalWholeOfFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasTemporalWholeOfInstallable| :range DM:MATERIALIZED_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasInstallable| :range DM:MATERIALIZED_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFulfilment| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasInstalledObject| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |IntersectionOf2Classes| :MMTC NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassIntersection| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfClassInActivity| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfClassInTemporalPartActivity| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfIndividualInActivity| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfIndividualInTemporalPartActivity| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfTemporalPartInActivity| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfTemporalPartInTemporalPartActivity| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |LifecycleStageOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfObject| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasObjectOfInterest| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfParty| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInterestedParty| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLifecycleStageType| :range DM:CLASS_OF_LIFECYCLE_STAGE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ManufacturingOfProductClassByClassOfOrganization| :MMTC NIL
   ""
   ((|hasUrClassOfProduct| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfProduct| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasRoleOfProduct| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfOrganization| :range DM:CLASS_OF_ORGANIZATION :multiplicity (1 1))
   (|hasClassOfOrganization| :range DM:CLASS_OF_ORGANIZATION :multiplicity (1 1))
   (|hasRoleOfOrganization| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfProduct| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfOrganization| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfATemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfATemporalPartOverAPeriodInTime| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfAnIndividual| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfAnIndividualOverAPeriodInTime| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |MonetaryValueOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCostType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valMonetaryValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasCurrency| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |MonetaryValueOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCostType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valMonetaryValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasCurrency| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberRangeWithBoundingRealValues| :MMTC NIL
   ""
   ((|hasNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|valLowerBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|valUpperBound| :range PTYPES:|Real| :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberRangeWithBoundingReferenceNumbers| :MMTC NIL
   ""
   ((|hasNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|valLowerBound| :range DM:ARITHMETIC_NUMBER :multiplicity (1 1))
   (|valUpperBound| :range DM:ARITHMETIC_NUMBER :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberSpaceWithBoundingNumberSpace| :MMTC NIL
   ""
   ((|hasNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   (|hasBoundingSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfIndividualInActivity| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfTemporalPartInActivity| :MMTC NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfTemporalPartInTemporalPartActivity| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |PlacingATemporalPartInAContext| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasContextDetail| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   ))

(mofi:def-mm-class |PlantDesignFulfilsProcessDesign| :MMTC NIL
   ""
   ((|hasUrClassOfUnitOperation| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasUnitOperation| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasRoleInUnitOperation| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfPlantDesignTag| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPlantDesignTag| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |PositionOfATemporalPartInACoordinateSystem| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPositioned| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|valX| :range PTYPES:|Real| :multiplicity (1 1))
   (|valY| :range PTYPES:|Real| :multiplicity (1 1))
   (|valZ| :range PTYPES:|Real| :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |PositionOfAnIndividualInACoordinateSystem| :MMTC NIL
   ""
   ((|hasPositioned| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|valX| :range PTYPES:|Real| :multiplicity (1 1))
   (|valY| :range PTYPES:|Real| :multiplicity (1 1))
   (|valZ| :range PTYPES:|Real| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductClassFulfilsClassOfFunctionPlace| :MMTC NIL
   ""
   ((|hasFunctionPlaceClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasProductClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfFulfilled| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductManufacturedByOrganization| :MMTC NIL
   ""
   ((|hasManufactured| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufactureType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductManufacturedByTemporalPartOrganization| :MMTC NIL
   ""
   ((|hasManufactured| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufactureType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfClassOfIndividualWithValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfIndividual| :MMTC NIL
   ""
   ((|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfStreamAtRelativeLocationAndTime| :MMTC NIL
   ""
   ((|hasPropertyPossessor| :range DM:STREAM :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfTemporalPartOfStreamAtRelativeLocationAndTime| :MMTC NIL
   ""
   ((|hasStreamTemporalWhole| :range DM:STREAM :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:STREAM :multiplicity (1 1))
   (|hasLocatorTemporalWhole| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasLowerBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasUpperBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividualWithPointValue| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|valPointValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividualWithValues| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|valLowerBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|valUpperBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeWithBoundingReferenceProperties| :MMTC NIL
   ""
   ((|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|hasLowerBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasUpperBound| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyWithValueOfIndividual| :MMTC NIL
   ""
   ((|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyWithValueOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |QuenchingBehaviourIOfIndividual| :MMTC NIL
   ""
   ((|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfEndingType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEventTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |QuenchingBehaviourOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorRole| :range DM:ROLE :multiplicity (1 1))
   (|hasCausingActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasBehaviour| :range DM:THING :multiplicity (1 1))
   (|hasCardinalityOfPossessor| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfBehaviour| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfCausingActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfEndedActivity| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |QuenchingBehaviourOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBehaviouePossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfEndingType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyRangeOfClassOfIndividual| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyRangeWithValues| :MMTC NIL
   ""
   ((|hasPropertyRangeTypw| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|valLowerBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|valUpperBound| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyWithReferenceValue| :MMTC NIL
   ""
   ((|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyWithValue| :MMTC NIL
   ""
   ((|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelationBetweenIndividualAndClass| :MMTC NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEnd1RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasEnd2RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfClass| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelationBetweenTemporalPartAndClass| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEnd1RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasEnd2RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfClass| :range DM:CARDINALITY :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeComplementOf2Classes| :MMTC NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassRelativeComplement| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeLocationOfAnIndividual| :MMTC NIL
   ""
   ((|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelativeLocationType| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeLocationOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelativeLocationType| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfClassContainedInDocument| :MMTC NIL
   ""
   ((|hasUrClassOfRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasUrClassOfDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfClassOnDocument| :MMTC NIL
   ""
   ((|hasUrClassOfRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasUrClassOfDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfIndividualContainedInDocument| :MMTC NIL
   ""
   ((|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfIndividualOnDocument| :MMTC NIL
   ""
   ((|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfTemporalPartContainedInDocument| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfTemporalPartOnDocument| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ScaleDefinition| :MMTC NIL
   ""
   ((|hasDefined| :range DM:SCALE :multiplicity (1 1))
   (|hasScaleType| :range DM:CLASS_OF_SCALE :multiplicity (1 1))
   (|valSymbol| :range PTYPES:|String| :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeWithDimensionOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeWithDimensionOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |SkillOfAPerson| :MMTC NIL
   ""
   ((|hasPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSkill| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SkillOfClassOfPerson| :MMTC NIL
   ""
   ((|hasUrClassOfPerson| :range DM:CLASS_OF_PERSON :multiplicity (1 1))
   (|hasClassOfPerson| :range DM:CLASS_OF_PERSON :multiplicity (1 1))
   (|hasRoleOfPerson| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfActivity| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasClassOfActivity| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasRoleOfActivity| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfPerson| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |SkillOfTemporalPartOfPerson| :MMTC NIL
   ""
   ((|hasTemporalWholeOfPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSkill| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByBiologicalMatterType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCompositeMaterialType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:THING :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCompoundType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCrystallineStructureType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|hasSuperClass| :range DM:CRYSTALLINE_STRUCTURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByFunctionalObjectType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasFunctionType| :range DM:CLASS_OF_FUNCTIONAL_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByParticulateMaterialType| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByPhase| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:PHASE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfClass| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasTwpType| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfClassOfRelationship| :MMTC NIL
   ""
   ((|hasSubClass| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfRoleAndDomain| :MMTC NIL
   ""
   ((|hasSubClass| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasSuperClass| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   ))

(mofi:def-mm-class |StatusOfIndividual| :MMTC NIL
   ""
   ((|hasStatusPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatus| :range DM:STATUS :multiplicity (1 1))
   ))

(mofi:def-mm-class |StatusOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatusPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatusType| :range DM:CLASS_OF_STATUS :multiplicity (1 1))
   (|hasStatus| :range DM:STATUS :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamAtRelativeLocationAndPeriodInTime| :MMTC NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamHasDestination| :MMTC NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamHasSource| :MMTC NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesBeginningOfIndividual| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   (|valStartTimeOfActivity| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesBeginningOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfBegun| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   (|valStartTimeOfActivity| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesEndingOfIndividual| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   (|valStartTimeOfActivity| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesEndingOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfEnded| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range tlog:|DateTime| :multiplicity (1 1))
   (|valStartTimeOfActivity| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartOfStreamAtRelativeLocationAndPeriodInTime| :MMTC NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartStreamHasDestination| :MMTC NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartStreamHasSource| :MMTC NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartUsedInADirectConnection| :MMTC NIL
   ""
   ((|hasTemporalWholeOfUsed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartUsedInAnIndirectConnection| :MMTC NIL
   ""
   ((|hasTemporalWholeOfUsed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |ThreeDimensionalRealNumber| :MMTC NIL
   ""
   ((|has3DRealNumber| :range DM:MULTIDIMENSIONAL_NUMBER :multiplicity (1 1))
   (|has3DRealNumberType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumber| :range PTYPES:|Real| :multiplicity (1 1))
   (|valSecondNumber| :range PTYPES:|Real| :multiplicity (1 1))
   (|valThirdNumber| :range PTYPES:|Real| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TranslationOfClassOfInformationRepresentation| :MMTC NIL
   ""
   ((|hasTranslationInput| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasTranslationResult| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasTranslationType| :range DM:CLASS_OF_CLASS_OF_REPRESENTATION_TRANSLATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalNumberSpace| :MMTC NIL
   ""
   ((|has2DRealNumberSpace| :range DM:MULTIDIMENSIONAL_NUMBER_SPACE :multiplicity (1 1))
   (|has2DRealNumberSpaceType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   (|valSecondNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyOfClassOfIndividualWithValues| :MMTC NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertySpace| :MMTC NIL
   ""
   ((|has2DPropertySpace| :range DM:MULTIDIMENSIONAL_PROPERTY_SPACE :multiplicity (1 1))
   (|has2DPropertySpaceType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasFirstPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasSecondPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyWithValuesOfIndividual| :MMTC NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyWithValuesOfTemporalPart| :MMTC NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range PTYPES:|Real| :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   (|hasStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalRealNumber| :MMTC NIL
   ""
   ((|has2DRealNumber| :range DM:MULTIDIMENSIONAL_NUMBER :multiplicity (1 1))
   (|has2DRealNumberType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumber| :range PTYPES:|Real| :multiplicity (1 1))
   (|valSecondNumber| :range PTYPES:|Real| :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalScale| :MMTC NIL
   ""
   ((|has2DScale| :range DM:MULTIDIMENSIONAL_SCALE :multiplicity (1 1))
   (|has2DScaleType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasFirstScale| :range DM:SCALE :multiplicity (1 1))
   (|hasSecondScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |UnionOf2Classes| :MMTC NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassUnion| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |UrFunctionalPhysicalObjectWithTemporalPart| :MMTC NIL
   ""
   ((|hasUrFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasUrFunctionPlaceType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ;pod(|hasFunctionPlace| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))

(mofi:def-mm-class |UrUnitOperationWithTemporalPart| :MMTC NIL
   ""
   ((|hasUrUnitOperation| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperation| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperationType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasProcessDesign| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|valStartTime| :range tlog:|DateTime| :multiplicity (1 1))
   ))
