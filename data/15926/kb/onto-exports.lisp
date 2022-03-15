
(in-package :KU)

;;; POD I need to start making ontologies their own packages, and this one is called SUMO-BASE!

(cl:export '( |expressedInLanguage| |WaterArea| |Motion| |ParticleWord| |May| |piece| |RelationExtendedToQuantities| |ExportLicence| |June| |April| |EndFn| |DayFn| |instrument| |Region| |domain| |NegativeInfinity| |duration| |GraphElement| |forall| |PlaneAngleMeasure| |Day| |refers| |Verb| |SubtractionFn| |Port| |OrganismProcess| |MereologicalSumFn| |holdsDuring| |SymmetricRelation| |MinFn| |BiologicalProcess| |subclass| |AntisymmetricRelation| |Exporting| |ProvisionOfGoods| |TernaryRelation| |ContentDevelopment| |uniqueIdentifier| |TernaryPredicate| |HoleHostFn| |YearDuration| |SymbolicString| |Friday| |cctCodeNameText| |IrrationalNumber| |length| |SecondDuration| |DivisionFn| |SocialInteraction| |Second| |disjoint| |Pi| |lessThan| |TransportationCompany| |disjointDecomposition| |Water| |Selling| |QuintaryRelation| |Inspection| |subsumingExternalConcept| |Obligation| |Object| |Wednesday| |Noun| |RationalNumberFn| |ElementalSubstance| |TrichotomizingRelation| |Device| |LogicalOperator| |FunctionQuantity| |SineFn| |SignumFn| |price| |confersNorm| |ListFn| |Risk| |Graph| |Month| |ImmediateFutureFn| |ComplexNumber| |RationalNumber| |measure| |QuintaryPredicate| |VariableArityRelation| |ImmediatePastFn| |exhaustiveDecomposition| |EvenInteger| |possesses| |SalesContract| |instance| |July| |relatedInternalConcept| |GovernmentFn| |AcrossRail| |equivalentContentInstance| |partition| |Sunday| |IntentionalProcess| |Formula| |InheritableRelation| |Class| |DenominatorFn| |EquivalenceRelation| |subrelation| |PredecessorFn| |ReciprocalFn| |additionFn| |Communication| |LeastCommonMultipleFn| |IntegerSquareRootFn| |PrimeNumber| |representsInLanguage| |PaymentOfPrice| |synonymousExternalConcept| |NumeratorFn| |RealNumberFn| |HourDuration| |issueDate| |Payment| |FloorFn| |Character| |Abstract| |NormativeAttribute| |time| |PrepositionalPhrase| |contains| |QuaternaryRelation| |BinaryRelation| |or| |meetsTemporally| |ObjectiveNorm| |Minute| |addFunction| |PartialValuedRelation| |Substance| |Thursday| |MinuteFn| |patient| |AdditionFn| |realization| |CeilingFn| |AlongsideShip| |BinaryPredicate| |CaseRole| |contraryAttribute| |Permission| |agreementMember| |property| |IntransitiveRelation| |Sentence| |HumanLanguage| |greaterThanOrEqualTo| |ReflexiveRelation| |AllRelatingCosts| |version| |representsForAgent| |Proposition| |ContinuousFunction| |TotalValuedRelation| |Promise| |AbsoluteValueFn| |AbstractionFn| |inverse| |Getting| |subProcess| |CardinalityFn| |PureSubstance| |NumberE| |member| |QuaternaryPredicate| |Hour| |LengthMeasure| |BinaryNumber| |Monday| |Loading| |Integer| |Adjective| |documentation| |CognitiveAgent| |TimeMeasure| |monetaryValue| |NegativeInteger| |ContentBearingObject| |OneToOneFunction| |MeasureFn| |Currency| |partlyLocated| |Writing| |DualObjectProcess| |Giving| |Manufacture| |destination| |Committing| |codeListAgencyNameText| |Fillable| |RemainderFn| |UnaryFunction| |OddInteger| |equal| |meetsSpatially| |distance| |ImaginaryNumber| |experiencer| |CurrencyMeasure| |Word| |SelfConnectedObject| |Delivery| |HourFn| |Agent| |temporallyBetween| |agent| |QuaternaryFunction| |codeListAgencyIdentifier| |SquareRootFn| |immediateSubclass| |MaxFn| |Stating| |Function| |Transaction| |PlaceOfDestination| |PortOfDestination| |SecondFn| |NonNullSet| |Creation| |ChangeOfPossession| |Tuesday| |Dead| |Saturday| |located| |properlyFills| |leader| |ExtensionFn| |LogFn| |October| |Relation| |partiallyFills| |BinaryFunction| |November| |overlapsSpatially| |PositiveInfinity| |SentientAgent| |CommonCarrier| |geographicSubregion| |TimeInterval| |RecurrentTimeIntervalFn| |Artifact| |VerbPhrase| |Invertebrate| |subAttribute| |Contract| |subProposition| |PhysicalQuantity| |Vertebrate| |exhaustiveAttribute| |NoticeToSeller| |RealNumber| |codeListNameText| |exists| |TimeDependentQuantity| |PowerSetFn| |CctCodeList| |temporallyBetweenOrEqual| |greaterThan| |March| |Duty| |List| |Carriage| |Adverb| |PositiveRealNumber| |holds| |governingIncoterm| |LandArea| |SuccessorFn| |seller| |SingleValuedRelation| |LeapYear| |rangeSubclass| |properPart| |Possibility| |resource| |part| |cooccur| |Certificate| |TransportationDevice| |TimeIntervalFn| |Human| |TimeDuration| |geopoliticalSubdivision| |result| |AssignmentFn| |January| |TotalOrderingRelation| |Icon| |UnaryConstantFunctionQuantity| |Physical| |AnimalLanguage| |subsumesContentClass| |Order| |TemporalCompositionFn| |Destruction| |beforeOrEqual| |ContractOfCarriage| |PositiveInteger| |PastFn| |Expressing| |Product| |path| |InternalChange| |PhysiologicProcess| |Translocation| |Entity| |codeListVersionIdentifier| |IrreflexiveRelation| |ExponentiationFn| |Number| |successorAttributeClosure| |Process| |LinguisticCommunication| |FutureFn| |cctCodeContent| |overlapsTemporally| |FinancialInstrument| |TimePoint| |MinuteDuration| |between| |range| |YearFn| |GreatestCommonDivisorFn| |TangentFn| |ContentBearingProcess| |identityElement| |MultiplicationFn| |TemporalRelation| |entails| |CompoundSubstance| |FinancialTransaction| |PartialOrderingRelation| |Continent| |attribute| |origin| |modalAttribute| |August| |during| |Living| |immediateInstance| |material| |inList| |RelationalAttribute| |NoticeToBuyer| |Hole| |Year| |Organism| |hole| |earlier| |GeopoliticalArea| |completelyFills| |ConstantQuantity| |fills| |CctCode| |CommutativeFunction| |names| |buyer| |starts| |AsymmetricRelation| |SequenceFunction| |MonthFn| |Week| |February| |Birth| |Text| |Costs| |Language| |DayDuration| |Attribute| |component| |temporalPart| |and| |ImaginaryPartFn| |December| |SetOrClass| |element| |RoundFn| |Death| |Quantity| |NounPhrase| |Declaring| |lessThanOrEqualTo| |date| |containsInformation| |OrganicObject| |domainSubclass| |BeginFn| |NegativeRealNumber| |Vehicle| |GeographicArea| |deprivesNorm| |InvalidOrder| |TransitiveRelation| |capability| |SpatialRelation| |WeekDuration| |ComputerLanguage| |Predicate| |LinguisticExpression| |relatedExternalConcept| |trichotomizingOn| |Awake| |transactionAmount| |Directing| |disjointRelation| |connected| |AssociativeFunction| |TimePosition| |not| |subsumedExternalConcept| |InternalAttribute| |Buying| |Transportation| |Making| |finishes| |CorpuscularObject| |before| |CosineFn| |Supposing| |requestedDeliveryDate| |TransferOfRisk| |represents| |hasPurpose| |valence| |NonnegativeRealNumber| |Phrase| |Collection| |WhereFn| |CommercialAgent| |September| |WhenFn| |NonnegativeInteger| |ListOrderFn| |subsumesContentInstance| |hasPurposeForAgent| |Set| |Island| |successorAttribute| |TernaryFunction| |Animal|))



