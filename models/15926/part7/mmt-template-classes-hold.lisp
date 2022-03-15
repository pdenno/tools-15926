
(in-package :mmt-template-classes)

(mofi:def-mm-class |ActivityCausesBeginningOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesBeginningOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfBegun| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesEndingOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ActivityCausesEndingOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfEnded| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |AggregateOfMonotypeIndividual| :mmt-template-classes NIL
   ""
   ((|hasParticleType| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   (|hasObjectType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasAggregate| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valAggregateCount| :range :INTEGER :multiplicity (1 1))
   ))

(mofi:def-mm-class |ApprovalWithStatusByIndividual| :mmt-template-classes NIL
   ""
   ((|hasApprover| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationship| :range DM:RELATIONSHIP :multiplicity (1 1))
   (|hasStatus| :range DM:CLASS_OF_APPROVAL_BY_STATUS :multiplicity (1 1))
   ))

(mofi:def-mm-class |ArrangementOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasArrangementType| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ArrangementOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasArrangementType| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |AssemblyOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasAssemblyType| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |AssemblyOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasAssemblyType| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfPossibleIndividualAtClassifiedEvent| :mmt-template-classes NIL
   ""
   ((|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:THING :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |BeginningOfTemporalPartAtClassifiedEvent| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfArrangementDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfAssemblyDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_ASSEMBLY_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCauseOfBeginningOfClassOfIndividualDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasIndividualType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCauseOfEndingOfClassOfIndividualDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasIndividualType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfCompositionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_COMPOSITION_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfContainmentDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocator| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfLocated| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasCardinalityOfLocator| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfLocated| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfDirectConnectionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_DIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfFeatureWholePartDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfWhole| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfPart| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   (|hasCardinalityOfWhole| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfPart| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfInIndividualWithEnumeratedIndirectProperties| :mmt-template-classes NIL
   ""
   ((|hasSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectConnectionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide1| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSide2| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfSide1| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSide2| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithBoundingValues| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valLowerBound| :range :FLOAT :multiplicity (1 1))
   (|valUpperBound| :range :FLOAT :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithMaximumValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valMaximumValue| :range :FLOAT :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithMinimumValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valMinimumValue| :range :FLOAT :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithPointValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasBasePropertyType| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|valPointValue| :range :FLOAT :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndirectPropertyWithReferencePropertySpace| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|hasPropertySpaceType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndividualUsedInDirectConnectionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfConnection| :range DM:CLASS_OF_DIRECT_CONNECTION :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfUsed| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfConnection| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfIndividualUsedInIndirectConnectionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfUsed| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfConnection| :range DM:CLASS_OF_INDIRECT_CONNECTION :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasCardinalityOfUsed| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfConnection| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfInvolvementByReferenceDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasInvolvedType| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvedRole| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfInvolved| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfParticipationApplicableYesNo| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasParticipantType| :range DM:THING :multiplicity (1 1))
   (|hasParticipantRole| :range DM:ROLE :multiplicity (1 1))
   (|hasApplicableYesNo| :range DM:CLASS_OF_ASSERTION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfParticipationDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   (|hasParticipantType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipantRole| :range DM:ROLE :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfParticipant| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRecognitionDefinition| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivityType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasRecognized| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|hasCardinalityOfActivity| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfRecognized| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfRelationshipWithDualParticipation| :mmt-template-classes NIL
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

(mofi:def-mm-class |ClassOfRelationshipWithParticipationAndReference| :mmt-template-classes NIL
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

(mofi:def-mm-class |ClassOfRelativeLocationDefinition| :mmt-template-classes NIL
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

(mofi:def-mm-class |ClassOfShapeDefinition| :mmt-template-classes NIL
   ""
   ((|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasShapeDimension| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfShapeOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasPossessorCardinality| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfShapeWithEnumeratedShapeDimensions| :mmt-template-classes NIL
   ""
   ((|hasSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfStreamDestination| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfDestination| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfDestination| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfStream| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfDestination| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassOfStreamSource| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfStream| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasUrClassOfSource| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfSource| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|hasCardinalityOfStream| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfSource| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified| :range DM:CLASS :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithBiologicalMatterType| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithCompositeMaterialType| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOSITE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithCompoundType| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithParticulateMaterialType| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfIndividualWithPhase| :mmt-template-classes NIL
   ""
   ((|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:PHASE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifierType| :range DM:CLASS_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithBiologicalMatterType| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithCompositeMaterialType| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOSITE_MATERIAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithCompoundType| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithParticulateMaterialType| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassificationOfTemporalPartWithPhase| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasClassifier| :range DM:PHASE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedClassOfDirectConnectionDefinition| :mmt-template-classes NIL
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

(mofi:def-mm-class |ClassifiedClassOfIndirectConnectionDefinition| :mmt-template-classes NIL
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

(mofi:def-mm-class |ClassifiedDefinitionOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|valDefinition| :range :STRING :multiplicity (1 1))
   (|hasDefinitionType| :range DM:CLASS_OF_CLASS_OF_DEFINITION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfClassInLanguage| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfIndividualInLanguage| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedDescriptionOfTemporalPartInLanguage| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasDescriptionType| :range DM:CLASS_OF_CLASS_OF_DESCRIPTION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfClassInLanguage| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ClassifiedIdentificationOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|hasIdentificationType| :range DM:CLASS_OF_CLASS_OF_IDENTIFICATION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCompositionType| :range DM:CLASS_OF_COMPOSITION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfClassOfInformationRepresentation| :mmt-template-classes NIL
   ""
   ((|hasWhole| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasPart| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfOIM| :mmt-template-classes NIL
   ""
   ((|hasEnumeratedSet| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasMember| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |CompositionOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCompositionType| :range DM:THING :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyOfClassOfIndividualWithValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyWithValueOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ConditionalPropertyWithValueOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConditionType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasCondition| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContainmentOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainerType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContainmentOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContained| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ContentsOfADocument| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasContents| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefiningAClassVariant| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasObject| :range DM:CLASS :multiplicity (1 1))
   (|hasOIM| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefiningACoordinateSystem| :mmt-template-classes NIL
   ""
   ((|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|hasXNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasYNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasZNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|hasScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfAnInformationRepresentation| :mmt-template-classes NIL
   ""
   ((|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasDefinition| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|valDefinition| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithExternalCode| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasShape| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresentationType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   (|valRepresentation| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfClassWithSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDefined| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DefinitionOfShapeRepresentationWithExternalCode| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:SHAPE :multiplicity (1 1))
   (|hasShape| :range DM:SHAPE :multiplicity (1 1))
   (|hasRepresentationType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|hasRepresentationForm| :range DM:REPRESENTATION_FORM :multiplicity (1 1))
   (|valRepresentation| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
    ;pod(|hasDescribed| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassInLanguage| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfClassWithSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasDescribed| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualInLanguage| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfIndividualWithSign| :mmt-template-classes NIL
   ""
   ((|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartInLanguage| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valDescriptor| :range :STRING :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DescriptionOfTemporalPartWithSign| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDescribed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DifferenceOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassDifference| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DimensionedShapeOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasShapeDimension| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |DirectConnectionOfTwoIndividuals| :mmt-template-classes NIL
   ""
   ((|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |DirectConnectionOfTwoTemporalParts| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DisjointnessOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentApproval| :mmt-template-classes NIL
   ""
   ((|hasApprovingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasApprovedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasApprovalStatus| :range DM:STATUS :multiplicity (1 1))
   (|valApprovalDate| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentDefinitionByExample| :mmt-template-classes NIL
   ""
   ((|hasDefinition| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasExample| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentPublishing| :mmt-template-classes NIL
   ""
   ((|hasPublishingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPublishedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasPublishingStatus| :range DM:STATUS :multiplicity (1 1))
   (|valPublishingDate| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentRevision| :mmt-template-classes NIL
   ""
   ((|hasRevisingType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUrDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRevisedDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRevisedContent| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|valRevisionDate| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |DocumentTypeAboutAClassApplicableYesNo| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasDocumentType| :range DM:DOCUMENT_DEFINITION :multiplicity (1 1))
   (|hasApplicableYesNo| :range DM:CLASS_OF_ASSERTION :multiplicity (1 1))
   ))

(mofi:def-mm-class |EditorialChangeOfInformationRepresentation| :mmt-template-classes NIL
   ""
   ((|hasEditingInput| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasEditingResult| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |EmploymentOfClassOfPersonByClassOfOrganization| :mmt-template-classes NIL
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

(mofi:def-mm-class |EmploymentOfPersonByOrganization| :mmt-template-classes NIL
   ""
   ((|hasEmployee| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmployer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmploymentType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |EmploymentOfTemporalPartOfPersonByOrganization| :mmt-template-classes NIL
   ""
   ((|hasEmployeeTemporalWhole| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasEmployee| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasEmployerTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmployer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEmploymentType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfPossibleIndividualAtClassifiedEvent| :mmt-template-classes NIL
   ""
   ((|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EndingOfTemporalPartAtClassifiedEvent| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEventType| :range DM:CLASS_OF_EVENT :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EnumeratedSetOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClassified1| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified2| :range DM:CLASS :multiplicity (1 1))
   (|hasEnumeratedSetOfClass| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |EnumeratedSetOf3Classes| :mmt-template-classes NIL
   ""
   ((|hasClassified1| :range DM:CLASS :multiplicity (1 1))
   (|hasClassified2| :range DM:CLASS :multiplicity (1 1))
   (|hasEnumeratedSetOfClass| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasClassified3| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |EruptingBehaviourOfClassOfIndividual| :mmt-template-classes NIL
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

(mofi:def-mm-class |EruptingBehaviourOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfBeginningType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEventTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |EruptingBehaviourOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfBeginningType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |FeatureOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasFeatureWholePartType| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   ))

(mofi:def-mm-class |FeatureOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasFeatureType| :range DM:CLASS_OF_FEATURE_WHOLE_PART :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |FunctionalMappingWith2Properties| :mmt-template-classes NIL
   ""
   ((|hasFunction| :range DM:CLASS_OF_FUNCTIONAL_MAPPING :multiplicity (1 1))
   (|hasInput1| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType1| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasInput2| :range DM:PROPERTY :multiplicity (1 1))
   (|hasInputType2| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|hasResult| :range DM:PROPERTY :multiplicity (1 1))
   (|hasResultType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   ))

(mofi:def-mm-class |FunctionalMappingWith3Properties| :mmt-template-classes NIL
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

(mofi:def-mm-class |FunctionalPhysicalObjectFulfilsUnitOperation| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfUnitOperationn| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperationn| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
    ;pod(|NIL| :range DM:THING :multiplicity (1 1))
   (|hasFulfilment| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassInLanguage| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|hasLanguage| :range DM:LANGUAGE :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfClassWithSign| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasIdentified| :range DM:CLASS :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividualWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfIndividualWithSign| :mmt-template-classes NIL
   ""
   ((|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valIdentifier| :range :STRING :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPartWithClassifiedSign| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSignType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IdentificationOfTemporalPartWithSign| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIdentified| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSign| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectConnectionOfTwoIndividuals| :mmt-template-classes NIL
   ""
   ((|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectConnectionOfTwoTemporalParts| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasConnectionType| :range DM:CLASS_OF_CONNECTION_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasReferenceProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyWithValueOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndirectPropertyWithValueOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIndirectPropertyType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndividualUsedInADirectConnection| :mmt-template-classes NIL
   ""
   ((|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |IndividualUsedInAnIndirectConnection| :mmt-template-classes NIL
   ""
   ((|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |InstallationOfTemporalPartMaterializedPhysicalObjectInFunctionPlace| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasTemporalWholeOfInstallable| :range DM:MATERIALIZED_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasInstallable| :range DM:MATERIALIZED_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFulfilment| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasInstalledObject| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |IntersectionOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassIntersection| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfClassInActivity| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfClassInTemporalPartActivity| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:CLASS :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfIndividualInActivity| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfIndividualInTemporalPartActivity| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfTemporalPartInActivity| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |InvolvementByReferenceOfTemporalPartInTemporalPartActivity| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolved| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInvolvementType| :range DM:CLASS_OF_INVOLVEMENT_BY_REFERENCE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |LifecycleStageOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfObject| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasObjectOfInterest| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfParty| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasInterestedParty| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLifecycleStageType| :range DM:CLASS_OF_LIFECYCLE_STAGE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ManufacturingOfProductClassByClassOfOrganization| :mmt-template-classes NIL
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

(mofi:def-mm-class |MeasuringAPropertyOfATemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfATemporalPartOverAPeriodInTime| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |MeasuringAPropertyOfAnIndividualOverAPeriodInTime| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMeasurementType| :range DM:CLASS_OF_RECOGNITION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |MonetaryValueOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCostType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valMonetaryValue| :range :FLOAT :multiplicity (1 1))
   (|hasCurrency| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |MonetaryValueOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCostType| :range DM:CLASS_OF_INDIRECT_PROPERTY :multiplicity (1 1))
   (|valMonetaryValue| :range :FLOAT :multiplicity (1 1))
   (|hasCurrency| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberRangeWithBoundingRealValues| :mmt-template-classes NIL
   ""
   ((|hasNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|valLowerBound| :range :FLOAT :multiplicity (1 1))
   (|valUpperBound| :range :FLOAT :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberRangeWithBoundingReferenceNumbers| :mmt-template-classes NIL
   ""
   ((|hasNumberRange| :range DM:NUMBER_RANGE :multiplicity (1 1))
   (|valLowerBound| :range DM:ARITHMETIC_NUMBER :multiplicity (1 1))
   (|valUpperBound| :range DM:ARITHMETIC_NUMBER :multiplicity (1 1))
   ))

(mofi:def-mm-class |NumberSpaceWithBoundingNumberSpace| :mmt-template-classes NIL
   ""
   ((|hasNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   (|hasBoundingSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfIndividualInActivity| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfTemporalPartInActivity| :mmt-template-classes NIL
   ""
   ((|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ParticipationOfTemporalPartInTemporalPartActivity| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipant| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasParticipationType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |PlacingATemporalPartInAContext| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalPart| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|hasContextDetail| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   ))

(mofi:def-mm-class |PlantDesignFulfilsProcessDesign| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfUnitOperation| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasUnitOperation| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasRoleInUnitOperation| :range DM:ROLE :multiplicity (1 1))
   (|hasUrClassOfPlantDesignTag| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPlantDesignTag| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |PositionOfATemporalPartInACoordinateSystem| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPositioned| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|valX| :range :FLOAT :multiplicity (1 1))
   (|valY| :range :FLOAT :multiplicity (1 1))
   (|valZ| :range :FLOAT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |PositionOfAnIndividualInACoordinateSystem| :mmt-template-classes NIL
   ""
   ((|hasPositioned| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCoordinateSystem| :range DM:COORDINATE_SYSTEM :multiplicity (1 1))
   (|valX| :range :FLOAT :multiplicity (1 1))
   (|valY| :range :FLOAT :multiplicity (1 1))
   (|valZ| :range :FLOAT :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductClassFulfilsClassOfFunctionPlace| :mmt-template-classes NIL
   ""
   ((|hasFunctionPlaceClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasProductClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasClassOfFulfilled| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductManufacturedByOrganization| :mmt-template-classes NIL
   ""
   ((|hasManufactured| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufactureType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ProductManufacturedByTemporalPartOrganization| :mmt-template-classes NIL
   ""
   ((|hasManufactured| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufacturer| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasManufactureType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfClassOfIndividualWithValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfStreamAtRelativeLocationAndTime| :mmt-template-classes NIL
   ""
   ((|hasPropertyPossessor| :range DM:STREAM :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyOfTemporalPartOfStreamAtRelativeLocationAndTime| :mmt-template-classes NIL
   ""
   ((|hasStreamTemporalWhole| :range DM:STREAM :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:STREAM :multiplicity (1 1))
   (|hasLocatorTemporalWhole| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasLowerBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasUpperBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividualWithPointValue| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|valPointValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeOfClassOfIndividualWithValues| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|valLowerBound| :range :FLOAT :multiplicity (1 1))
   (|valUpperBound| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|hasClassificationType| :range DM:CLASS_OF_CLASSIFICATION :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyRangeWithBoundingReferenceProperties| :mmt-template-classes NIL
   ""
   ((|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|hasLowerBound| :range DM:PROPERTY :multiplicity (1 1))
   (|hasUpperBound| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyWithValueOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |PropertyWithValueOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |QuenchingBehaviourIOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasBehaviourPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfEndingType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEventTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |QuenchingBehaviourOfClassOfIndividual| :mmt-template-classes NIL
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

(mofi:def-mm-class |QuenchingBehaviourOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBehaviouePossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedBehaviour| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBehaviourType| :range DM:CLASS_OF_PARTICIPATION :multiplicity (1 1))
   (|hasCausingActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasCauseOfEndingType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyRangeOfClassOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPropertyRangeType| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|hasCardinalityOfPossessorType| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyRangeWithValues| :mmt-template-classes NIL
   ""
   ((|hasPropertyRangeTypw| :range DM:CLASS_OF_PROPERTY_SPACE :multiplicity (1 1))
   (|hasPropertyRange| :range DM:PROPERTY_RANGE :multiplicity (1 1))
   (|valLowerBound| :range :FLOAT :multiplicity (1 1))
   (|valUpperBound| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyWithReferenceValue| :mmt-template-classes NIL
   ""
   ((|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ReferencePropertyWithValue| :mmt-template-classes NIL
   ""
   ((|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|hasPropertyType| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelationBetweenIndividualAndClass| :mmt-template-classes NIL
   ""
   ((|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEnd1RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasEnd2RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfClass| :range DM:CARDINALITY :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelationBetweenTemporalPartAndClass| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEnd1RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasEnd2RoleAndDomain| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasCardinalityOfIndividual| :range DM:CARDINALITY :multiplicity (1 1))
   (|hasCardinalityOfClass| :range DM:CARDINALITY :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeComplementOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassRelativeComplement| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeLocationOfAnIndividual| :mmt-template-classes NIL
   ""
   ((|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelativeLocationType| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RelativeLocationOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasTemporalWholeOfLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocated| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelativeLocationType| :range DM:CLASS_OF_RELATIVE_LOCATION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfClassContainedInDocument| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasUrClassOfDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfClassOnDocument| :mmt-template-classes NIL
   ""
   ((|hasUrClassOfRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasRepresented| :range DM:CLASS :multiplicity (1 1))
   (|hasUrClassOfDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfIndividualContainedInDocument| :mmt-template-classes NIL
   ""
   ((|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfIndividualOnDocument| :mmt-template-classes NIL
   ""
   ((|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfTemporalPartContainedInDocument| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresentation| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |RepresentationOfTemporalPartOnDocument| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRepresented| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasDocument| :range DM:CLASS_OF_INFORMATION_OBJECT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ScaleDefinition| :mmt-template-classes NIL
   ""
   ((|hasDefined| :range DM:SCALE :multiplicity (1 1))
   (|hasScaleType| :range DM:CLASS_OF_SCALE :multiplicity (1 1))
   (|valSymbol| :range :STRING :multiplicity (1 1))
   (|hasPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasProperty| :range DM:PROPERTY :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeWithDimensionOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |ShapeWithDimensionOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasShapeType| :range DM:CLASS_OF_SHAPE :multiplicity (1 1))
   (|hasDimensionType| :range DM:CLASS_OF_SHAPE_DIMENSION :multiplicity (1 1))
   (|hasPropertyType| :range DM:SINGLE_PROPERTY_DIMENSION :multiplicity (1 1))
   (|valPropertyValue| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale| :range DM:SCALE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |SkillOfAPerson| :mmt-template-classes NIL
   ""
   ((|hasPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSkill| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SkillOfClassOfPerson| :mmt-template-classes NIL
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

(mofi:def-mm-class |SkillOfTemporalPartOfPerson| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasPerson| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSkill| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByBiologicalMatterType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_BIOLOGICAL_MATTER :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCompositeMaterialType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:THING :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCompoundType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByCrystallineStructureType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_COMPOUND :multiplicity (1 1))
   (|hasSuperClass| :range DM:CRYSTALLINE_STRUCTURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByFunctionalObjectType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasFunctionType| :range DM:CLASS_OF_FUNCTIONAL_OBJECT :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByParticulateMaterialType| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_PARTICULATE_MATERIAL :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationByPhase| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSubClass| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasSuperClass| :range DM:PHASE :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfClass| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS :multiplicity (1 1))
   (|hasTwpType| :range DM:CLASS_OF_TEMPORAL_WHOLE_PART :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfClassOfRelationship| :mmt-template-classes NIL
   ""
   ((|hasSubClass| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   (|hasSuperClass| :range DM:CLASS_OF_RELATIONSHIP :multiplicity (1 1))
   ))

(mofi:def-mm-class |SpecializationOfRoleAndDomain| :mmt-template-classes NIL
   ""
   ((|hasSubClass| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   (|hasSuperClass| :range DM:ROLE_AND_DOMAIN :multiplicity (1 1))
   ))

(mofi:def-mm-class |StatusOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasStatusPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatus| :range DM:STATUS :multiplicity (1 1))
   ))

(mofi:def-mm-class |StatusOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatusPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasStatusType| :range DM:CLASS_OF_STATUS :multiplicity (1 1))
   (|hasStatus| :range DM:STATUS :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamAtRelativeLocationAndPeriodInTime| :mmt-template-classes NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamHasDestination| :mmt-template-classes NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |StreamHasSource| :mmt-template-classes NIL
   ""
   ((|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesBeginningOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   (|valStartTimeOfActivity| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesBeginningOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfBegun| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasBegunIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_BEGINNING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valStartTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   (|valStartTimeOfActivity| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesEndingOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:WHOLE_LIFE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   (|valStartTimeOfActivity| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartActivityCausesEndingOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasActivity| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasTemporalWholeOfEnded| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasEndedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasCauseType| :range DM:CLASS_OF_CAUSE_OF_ENDING_OF_CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTimeOfIndividual| :range :DATETIME :multiplicity (1 1))
   (|valStartTimeOfActivity| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartOfStreamAtRelativeLocationAndPeriodInTime| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasLocator| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasContainmentType| :range DM:CLASS_OF_CONTAINMENT_OF_INDIVIDUAL :multiplicity (1 1))
   (|valEndTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartStreamHasDestination| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasDestination| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartStreamHasSource| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfStream| :range DM:STREAM :multiplicity (1 1))
   (|hasStream| :range DM:STREAM :multiplicity (1 1))
   (|hasTemporalWholeOfSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasSource| :range DM:PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasRelationshipType| :range DM:CLASS_OF_RELATIONSHIP_WITH_SIGNATURE :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartUsedInADirectConnection| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfUsed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TemporalPartUsedInAnIndirectConnection| :mmt-template-classes NIL
   ""
   ((|hasTemporalWholeOfUsed| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasUsedIndividual| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide1| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasSide2| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasRelationType| :range DM:CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |ThreeDimensionalRealNumber| :mmt-template-classes NIL
   ""
   ((|has3DRealNumber| :range DM:MULTIDIMENSIONAL_NUMBER :multiplicity (1 1))
   (|has3DRealNumberType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumber| :range :FLOAT :multiplicity (1 1))
   (|valSecondNumber| :range :FLOAT :multiplicity (1 1))
   (|valThirdNumber| :range :FLOAT :multiplicity (1 1))
   ))

(mofi:def-mm-class |TranslationOfClassOfInformationRepresentation| :mmt-template-classes NIL
   ""
   ((|hasTranslationInput| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasTranslationResult| :range DM:CLASS_OF_INFORMATION_REPRESENTATION :multiplicity (1 1))
   (|hasTranslationType| :range DM:CLASS_OF_CLASS_OF_REPRESENTATION_TRANSLATION :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalNumberSpace| :mmt-template-classes NIL
   ""
   ((|has2DRealNumberSpace| :range DM:MULTIDIMENSIONAL_NUMBER_SPACE :multiplicity (1 1))
   (|has2DRealNumberSpaceType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   (|valSecondNumberSpace| :range DM:NUMBER_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyOfClassOfIndividualWithValues| :mmt-template-classes NIL
   ""
   ((|hasUrClass| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessorType| :range DM:CLASS_OF_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertySpace| :mmt-template-classes NIL
   ""
   ((|has2DPropertySpace| :range DM:MULTIDIMENSIONAL_PROPERTY_SPACE :multiplicity (1 1))
   (|has2DPropertySpaceType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasFirstPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   (|hasSecondPropertySpace| :range DM:PROPERTY_SPACE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyWithValuesOfIndividual| :mmt-template-classes NIL
   ""
   ((|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalPropertyWithValuesOfTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasTemporalWhole| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasPossessor| :range DM:POSSIBLE_INDIVIDUAL :multiplicity (1 1))
   (|hasMultidimensionalPropertyType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasPropertyType1| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue1| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale1| :range DM:SCALE :multiplicity (1 1))
   (|hasPropertyType2| :range DM:CLASS_OF_PROPERTY :multiplicity (1 1))
   (|valPropertyValue2| :range :FLOAT :multiplicity (1 1))
   (|hasPropertyScale2| :range DM:SCALE :multiplicity (1 1))
   (|hasStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalRealNumber| :mmt-template-classes NIL
   ""
   ((|has2DRealNumber| :range DM:MULTIDIMENSIONAL_NUMBER :multiplicity (1 1))
   (|has2DRealNumberType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|valFirstNumber| :range :FLOAT :multiplicity (1 1))
   (|valSecondNumber| :range :FLOAT :multiplicity (1 1))
   ))

(mofi:def-mm-class |TwoDimensionalScale| :mmt-template-classes NIL
   ""
   ((|has2DScale| :range DM:MULTIDIMENSIONAL_SCALE :multiplicity (1 1))
   (|has2DScaleType| :range DM:CLASS_OF_MULTIDIMENSIONAL_OBJECT :multiplicity (1 1))
   (|hasFirstScale| :range DM:SCALE :multiplicity (1 1))
   (|hasSecondScale| :range DM:SCALE :multiplicity (1 1))
   ))

(mofi:def-mm-class |UnionOf2Classes| :mmt-template-classes NIL
   ""
   ((|hasClass1| :range DM:CLASS :multiplicity (1 1))
   (|hasClass2| :range DM:CLASS :multiplicity (1 1))
   (|hasClassUnion| :range DM:CLASS :multiplicity (1 1))
   ))

(mofi:def-mm-class |UrFunctionalPhysicalObjectWithTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasUrFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasFunctionPlace| :range DM:FUNCTIONAL_PHYSICAL_OBJECT :multiplicity (1 1))
   (|hasUrFunctionPlaceType| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   ;pod(|hasFunctionPlace| :range DM:CLASS_OF_ARRANGED_INDIVIDUAL :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))

(mofi:def-mm-class |UrUnitOperationWithTemporalPart| :mmt-template-classes NIL
   ""
   ((|hasUrUnitOperation| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperation| :range DM:ACTIVITY :multiplicity (1 1))
   (|hasUnitOperationType| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasProcessDesign| :range DM:CLASS_OF_ACTIVITY :multiplicity (1 1))
   (|hasContext| :range DM:ENUMERATED_SET_OF_CLASS :multiplicity (1 1))
   (|valStartTime| :range :DATETIME :multiplicity (1 1))
   ))
