

;;; This will get blown away after mexico is loaded. 2022 Is that really okay?
(defpackage "MEXICO" 
  (:use :cl :pod :mofi)
  (:shadow ocl:value) ; PODTT
  (:nicknames :mex)
  (:shadowing-import-from ; pod7 probably temporary while pod7
   :pod-utils "%%NAME" "%%TYPE" "%%PARENT" "%%CHILDREN" "%%IDS" "%%SCOPE")
  (:export
   #:|ScopedId|
   #:repeat
   #:extent
   #:query
   #:schema 
   #:const_e
   #:lobound
   #:loindex
;   #:value
   #:in
   ;; SBCL MEXICO also exports the following symbols
  #:%DOMAIN-VIEW #:|QueryExpression| #:%CONSTRAINT
  #:|EntityName| #:%BASED-ON #:END_MODEL
  #:|isOptional| #:%SUBTYPE-CONSTRAINTS
  #:%INSTANCES #:%PLAYS-DOMAIN-ROLE
  #:%OF-TYPE #:|ConcreteAggregationType|
  #:|BooleanValue| #:|isMandatory|
  #:|extents| #:%NAMED-SUPERTYPE
  #:%ASSIGNED-VALUE #:%SUBTYPE-OF
  #:%PLAYS-RANGE-ROLE #:SIZEOF
  #:|constrained-extents| #:|ActualLISTType|
  #:%REFERENT #:|data-type|
  #:|AlgorithmScope|
  #:|string-length-constraint|
  #:|EnumerationType| #:|return-value|
  #:|ARRAYValue| #:|RoleName| CASE
  #:|SETType| UNIQUE #:|to-value|
  #:%REPRESENTS #:|action| #:|specializes|
  #:WHILE #:|TypeName| IF #:|InParameter|
  #:|AGGREGATEType| #:|extension| #:FOR
  #:|invokes-function| #:|occurs-in|
  #:|ControlVariable| #:|InstantiableType|
  #:|AggregationType|
  #:|PartialEntityConstructor| #:|Extent|
  OCL:SELF #:|allowed-types| #:|StringType|
  #:%MODELS-ROLE #:|controlled-by|
  #:|increment| #:|Algorithm|
  #:|referenced-as| #:|Identifier|
  #:|GeneralAggregationType| #:OF
  #:|CaseAction| #:%SPECIALIZES #:%BINDINGS
  #:|range-type| #:%KEY-COMPONENT #:SELECT
  #:|BinaryOperation| #:%BODY-STATEMENTS
  #:|base-entity| TYPE #:%RETURNS-RESULT
  #:|isDefault| #:|required-type|
  #:END_LOCAL #:|Scope| #:|ReturnStatement|
  #:|AggregateInitializer| #:BAG
  #:%VALUE-EXPRESSION #:|declared-items|
  #:|ABSTRACTConstraint| #:|used-in|
  #:|BinaryOperator| #:|Population|
  #:|StringValue| #:MODEL #:%TEXT
  #:|refines| #:|in-ProcedureCall|
  #:|member-slot| #:THEN #:%RESTRICTED-TYPE
  #:|instantiates| #:|actual-parameters|
  #:|returns-result| #:|UniqueRule|
  #:%MATCHING-STRUCTURE #:|RepeatControl|
  #:|GeneralBAGType| #:|IndeterminateRef|
  #:%UNDERLYING-TYPE ABS #:|ActualParameter|
  #:%IN--FUNCTION-CALL ARRAY #:%LAST-CODE
  #:|MemberBinding| #:|based-on|
  #:%COMPONENTS #:|Remark| #:|Procedure|
  #:|variable-type| #:%SATISFIES-TYPE
  #:|BinaryType| #:%LAST-BIT #:DERIVE
  RETURN #:%DESCRIBES-SCHEMA NOT #:END_RULE
  #:%DECLARES #:|ARRAYType| #:|isTail|
  #:TARGET #:|isFixed| #:%CONTROLLED-BY
  #:END_CONSTANT COS #:|selection-expression|
  #:END_SUBTYPE_CONSTRAINT #:%UNTIL-EXPRESSION
  #:%ACTUAL-VALUE #:NVL #:|asserts|
  #:%DERIVATION #:|RepeatStatement|
  #:|BinaryIndex| #:|ConstantRef|
  #:VALUE_IN #:END_PROCEDURE
  #:%REFERENCED-AS #:|ordering| MOD
  #:|instance-of| #:USE
  #:|within-population| #:|base-value|
  #:%REFERS-TO #:%ACTION #:%BOUND
  #:END_ENTITY #:XOR #:|local-name|
  #:FROM #:END_CONTEXT #:|variables|
  #:|GeneralizedType| EXP #:|values|
  #:%DELIMITED #:|first-code|
  #:|VariableType| #:|for-type|
  #:|EnumerationItem| #:%LO-INDEX
  #:|localName| #:INDEXING #:PROCEDURE
  #:|EntityInstance| #:|attribute| #:VIEW
  #:%EXPLICIT #:|Keyword| #:ONEOF
  #:END_ALIAS #:|subtype-of|
  #:|ParameterRef| #:%COLLECTION
  #:|constraints| #:|BAGValue|
  #:|ActualStructure| #:WHERE #:|base|
  #:|documentation| #:EXISTS
  #:%REDECLARATIONS #:|equivalent-rule|
  #:|interpretation-context| #:|where-found|
  #:END_FUNCTION #:|has-skip| ASIN
  #:%LOCAL-SCOPE #:|assertsAbstract| TAN
  #:|lower-bound| #:%ACTUAL-PARAMETERS
  #:|NullStatement| #:|Attribute|
  #:%EQUIVALENT-RULE #:|DomainConstraint|
  #:|structure-constraints| #:|unique-rules|
  #:%INVERSE-OF #:|underlying-type|
  #:|hi-index| #:%COUNT REMOVE #:|Variable|
  #:|StringIndex| #:|formal-parameter|
  #:|namespace| #:|FunctionResult|
  #:%IS-TAGGED #:|redeclarations|
  #:|Coercion| #:|role| #:|name| #:VAR
  FUNCTION #:|text| #:|content|
  #:END_DEPENDENT_MAP #:%TYPE-CONSTRAINTS
  #:%ATTRIBUTE-GROUP #:%VARIABLE-TYPE
  #:|NamedType| #:|ExpressText|
  #:%ENTITY-INSTANCE #:%GOVERNING-SCHEMA STRING
  #:%INDEX #:|SubtypeConstraint|
  #:%VARIABLE #:|assigned-value| #:%SCOPE
  #:|EnumItemRef| #:|AggregateIndex|
  #:%IF-CONDITION #:RENAMED #:%MEMBER-TYPE
  #:|AttributeRef| #:%ELSE-ACTIONS
  #:%VERSION #:%IS-MANDATORY #:|Function|
  #:|alias-variable| #:LOCAL #:%HAS-SKIP
  #:|explicit| #:BASED_ON #:|actual-value|
  #:%QUERY-VARIABLE #:|value-expression|
  #:%CASES #:|lbound| #:%IS-EXTENSIBLE SIN
  #:%PROPERTIES #:|isEntity| #:|in-block|
  #:|ActualSETType| #:%COMMON-ELEMENTS
  #:%CONTENT #:|attribute-group|
  #:|interfacing-schema| #:|SimpleType|
  #:%STATE #:%INSTANCE-OF ACOS
  #:|EscapeStatement| LENGTH #:|matching-type|
  #:%SOURCE #:|creates-relationship|
  #:|ActualARRAYType| #:|ActualDataType|
  #:|RealType| #:%CONSTRAINED-SUBTYPES
  #:|matching-structure| #:|body|
  #:|declared-in| #:|supporting-body|
  #:|LogicType| #:|attribute-value|
  #:|TypedInstance| #:%BODY
  #:|unary-operand| OCL:VALUE #:|result|
  #:%IN--PROCEDURE-CALL #:IDENTIFIED_BY
  #:%CONDITION #:|EntityType|
  #:|VARParameter| #:|key-component|
  #:%DESCRIBES-ELEMENT #:%FIRST-CODE INTEGER
  #:%BASE-AGGREGATE #:EXTENSIBLE
  #:|fundamental-value| #:|composition|
  #:|label-value| #:%DEFINING-SCOPE
  #:%RETURN-VALUE #:|Primary| #:ESCAPE
  #:|index-value| #:SCHEMA_VIEW
  #:%BOUND-EXPRESSION #:|formal-parameters|
  #:|if-condition| #:|GenericElement|
  #:%FORMAL-PARAMETER #:OPTIONAL #:UNTIL
  #:%ALIAS #:|isExtensible| #:|BagMember|
  #:|target-type| #:|SelectType|
  #:|InterfacedElement| #:|includes-remarks|
  #:%RESULT #:|ArrayBound| #:|GroupRef|
  #:VALUE_UNIQUE #:|source| #:ALIAS
  #:|contains-rules| #:|LISTValue|
  #:HIINDEX #:|else-actions|
  #:%DOCUMENTATION #:|condition|
  #:|Relationship| #:ANDOR #:%VARIABLES
  #:|actual-types| #:|select-condition|
  #:|initial-value| #:|SkipStatement|
  #:|AttributeBinding| #:|position|
  #:|AggregateValue| #:EACH
  #:UNRESOLVED-OPERATOR #:%CONSTRAINED-EXTENTS
  #:%ATTRIBUTE #:|SETValue| #:BLENGTH
  #:|interfacedId| #:|range-view|
  #:|Operation| #:DIV #:|SizeConstraint|
  #:ORDERED_BY #:INVERSE
  #:|while-expression| #:|InvertibleAttribute|
  #:%FOR-TYPE #:%EXTENSION #:|Role|
  #:|VARVariable| #:|NumberValue|
  #:|QueryVariable| #:BINARY #:FIXED
  #:|range| #:|Instance| #:|result-value|
  #:|upper-bound| #:%CHARACTERIZING-TYPE
  #:%LBOUND #:%DOMAIN #:%DESCRIBES
  #:%NAME #:%IS-U-S-E #:|SchemaElement|
  #:%ASSERTS-EXPRESSION #:|represents|
  #:|delimited| SET #:LOGICAL #:%IMPLEMENTS
  #:%MATCHING-TYPE #:|CommonElement|
  #:|IntegerValue| #:|local-scope|
  #:|Schema| #:|right-operand| #:|operand|
  #:|SingleEntityType| #:|attributes|
  #:|maxLength| #:%PLACE-REFERENCE
  #:|collection| #:%SCHEMA-ELEMENTS
  #:%IS-OPTIONAL #:%UNARY-OPERAND
  #:|SingleLeafInstance| #:|defined-in|
  #:|first-bit| #:|UsedInRef| #:%FIRST-BIT
  #:%RANGE-TYPE #:%INVOKES #:%RIGHT-OPERAND
  #:|describes-element| #:%OF-ENTITY
  #:|appears-in| #:%ORDERING #:RULE
  #:|id| #:%ALLOWED-TYPES #:|LocalElement|
  #:END_TYPE #:%APPEARS-IN
  #:|RepeatUntilControl| #:|type-constraints|
  #:|BAGType| #:%REQUIRED-TYPE #:CONTEXT
  #:|Redeclaration| #:|IndexOperation|
  #:|DomainRole| #:%THEN-ACTIONS
  #:|SpecializedValue| #:%DOMAIN-RULES
  #:%UBOUND #:|RangeRole| #:AGGREGATE
  #:|PartialEntityValue| #:|Selector|
  #:|ExtentRef| NUMBER #:|repetition|
  #:%MAX-LENGTH #:%IS-DEFAULT #:|declares|
  #:|RealValue| #:|VariableCell|
  #:|isUnique| #:%IS-UNIQUE MAP
  #:|LocalVariable| #:AS
  #:%FUNDAMENTAL-VALUE LIST #:|GroupCell|
  #:|referent| #:%INTERPRETATION-CONTEXT
  #:|corresponds to| #:|in-FunctionCall|
  #:|controls| #:|member-value| #:REFERENCE
  #:SUBTYPE #:%LEFT-OPERAND #:|select-list|
  #:%ATTRIBUTE-VALUE #:|DataType|
  #:|GeneralARRAYType| #:%RANGE
  #:%INTERFACED-ELEMENTS #:|bound-value|
  #:|index| #:|NamedRule| #:|properties|
  #:%RESULT-VALUE #:|subtype-constraints|
  #:LIKE #:|for-function|
  #:|ActualTypeConstraint| #:%TO-VALUE
  #:%SELECT-LIST #:|interfaced-elements|
  #:END_REPEAT #:|domain-view|
  #:|plays-domain-role| #:|plays-range-role|
  #:%SELECT-CONDITION #:|definingScope|
  #:|IfStatement| #:|governing-schema| PI
  #:%INTERFACED-ID #:|UnaryOperator|
  #:|required-structure| #:|BooleanType|
  #:%REFINES #:UNKNOWN #:TRUE #:WITH
  #:%DECLARED-ITEMS #:%RANGE-VIEW #:END_IF
  #:|GenericType| #:|PartialEntityType|
  #:%BASE #:%REFINED-ROLE BOOLEAN
  #:%ATTRIBUTE-TYPE #:|left-operand|
  #:|ONEOFConstraint|
  #:|ActualStructureConstraint|
  #:|original-attribute| #:ELSIF
  #:|ConcreteValue| #:|ActualAggregationType|
  #:%ROLE #:|referenced-in|
  #:|restricted-type| #:|GlobalRule|
  #:|InverseAttribute| #:|formal-parameter-type|
  #:%IS-TAIL OR #:%ASSERTS-ABSTRACT AND
  #:|of-type| #:|scope| #:%IS-FIXED
  #:%EXTENTS #:|inverse| #:|IntegerType|
  #:%SELECTION-EXPRESSION #:|domain-rules|
  #:%ALIAS-VARIABLE #:%INTERFACING-SCHEMA
  #:INSERT #:|AliasStatement|
  #:%ACTUAL-TYPES #:|AliasRef|
  #:GENERIC_ENTITY #:%IS-ABSTRACT
  #:|Indeterminate| #:|Parameter| #:TYPEOF
  #:|characterizing-type|
  #:|RepeatIncrementControl| #:%TO-SLOT
  #:%ID #:|ParameterType| #:%ATTRIBUTES
  #:%DATA-TYPE #:|satisfies-type|
  #:|FunctionCall| #:|ExplicitAttribute|
  #:SUBTYPE_CONSTRAINT #:|control-variable|
  #:|ArrayMember| #:%DECLARED-IN
  #:|actual-referent| #:|DerivedAttribute|
  #:%ATTRIBUTE-NAME #:|isUSE| #:END_SCHEMA
  #:|refined-role| #:|%CORRESPONDS TO|
  #:|common-elements| #:%BOUND-VALUE
  #:|CaseStatement| #:%INDEX-VALUE
  #:|implements| #:|VARExpression|
  #:|lo-index| #:|Assignment| #:|%scope|
  #:%TYPE-ELEMENTS #:GENERIC
  #:%FUNDAMENTAL-TYPE #:|entity-instance| REAL
  #:%ORIGINAL-ATTRIBUTE #:|BinaryValue|
  #:|constraint-rules| #:ABSTRACT #:|cases|
  #:|ActualAGGREGATEType| #:END OTHERWISE
  #:ELSE #:SOURCE #:%OCCURS-IN
  #:|local-elements| #:%INTERFACES
  #:|constrained-subtypes| #:|GeneralSETType|
  #:|attribute-type| #:%IS-ENTITY
  #:|of-entity| #:%DEFINED-IN
  #:|body-statements| #:%SUPPORTING-BODY
  #:|instances| #:|evaluation| #:%OPERAND
  #:%ASSERTS #:|SingleEntityValue|
  #:|refers-to| #:|NumericType|
  #:%MEMBER-SLOT #:UNRESOLVED-ATTRIBUTE
  #:|LISTType| #:|last-code|
  #:%CONTAINS-RULES #:%LOCAL-ELEMENTS
  #:%FORMAL-PARAMETERS #:|query-variable|
  #:|base-aggregate| #:LOG10 #:%LABEL-VALUE
  #:|ANDConstraint| #:|AliasVariable|
  #:|aggregate-operand| #:|precision|
  #:|attribute-name| #:|invokes|
  #:|LogicalValue| #:|in-relationship|
  #:|contains| #:|enum-symbol|
  #:|type-elements| #:%INVOKES-FUNCTION
  #:%STRUCTURE-CONSTRAINTS #:|models-role|
  #:|LengthConstraint| #:|domain|
  #:|AttributeCell| #:|derivation|
  #:|NamedVariable| #:|components| #:ENTITY
  #:%FORMAL-PARAMETER-TYPE #:%CONTROLS
  #:UNRESOLVED-INVERSE #:|Constant| #:BEGIN
  #:|constraint| #:%REFERENCED-IN
  #:|place-reference| #:%OWNING-ENTITY
  #:|UnaryOperation| #:|Literal|
  #:%MEMBER-VALUE #:|ProcedureCall|
  #:%HAS-ESCAPE #:|asserts-expression| #:BY
  #:|named-elements| #:|until-expression|
  #:ROLESOF #:%WITHIN-POPULATION
  #:|SpecializedType| #:|TOTAL_OVERConstraint|
  #:|Statement| #:|bound| #:%CONTAINS
  #:|ActualBAGType| #:%UPPER-BOUND
  #:|fundamental-type| #:%IN-RELATIONSHIP
  #:%WHERE-FOUND #:%COMPOSITION #:%VALUES
  #:%REQUIRED-STRUCTURE #:%CONSTRAINTS
  #:ODD #:%ACTUAL-REFERENT
  #:|GeneralLISTType| #:|has-escape|
  #:%INVERSE #:%INSTANTIATES #:%POSITION
  #:|NamedElement| #:SCHEMA_MAP
  #:|equivalent| #:END_MAP #:LOG2
  #:%IN-BLOCK #:%BINARY-LENGTH-CONSTRAINT
  #:%AGGREGATE-OPERAND #:%ENUM-SYMBOL
  #:%WHILE-EXPRESSION #:%CONTROL-VARIABLE
  #:END_SCHEMA_VIEW #:|isTagged|
  #:|SupertypeRule| #:%TARGET-TYPE ATAN
  #:|interfaces| #:%PRECISION
  #:|RepeatWhileControl| #:%CONSTRAINT-RULES
  #:|named-supertype|
  #:|binary-length-constraint| #:|ConcreteType|
  #:|describes-schema| #:|GenericAggregate|
  #:|AnonymousType| #:%BASE-ENTITY
  #:%BASE-VALUE #:|Expression|
  #:|owning-entity| #:%NAMESPACE
  #:%FOR-FUNCTION #:|last-bit| #:%USED-IN
  #:|variable| #:|StatementBlock|
  #:|bindings| #:UNRESOLVED-ATTRIBUTE-REF
  #:ENUMERATION #:|schema-elements|
  #:%HI-INDEX #:%CREATES-RELATIONSHIP
  #:|OrderingKind| #:|ActualType|
  #:%INITIAL-VALUE #:|bound-expression|
  #:|DefinedType| #:%EVALUATION #:|ubound|
  #:|member-type| #:|inverse-of|
  #:%LOWER-BOUND #:|label|
  #:%STRING-LENGTH-CONSTRAINT #:|state|
  #:|then-actions| #:SKIP #:DEPENDENT_MAP
  #:PARTITION #:CONSTANT #:|to-slot|
  #:%EQUIVALENT #:|ActualGenericType| FORMAT
  #:%LABEL #:END_VIEW #:%UNIQUE-RULES
  #:END_CASE #:|SimpleValue| #:%OPERATOR
  #:|EntityValue| #:|SELFRef|
  #:|VariableRef| #:|DomainRule| #:|alias|
  #:|RepeatCount| #:USEDIN #:|describes|
  #:SUPERTYPE #:|AttributeValue|
  #:|MultiLeafInstance| #:|LocalScope|
  #:|ListMember| LOG #:|TypeElement|
  #:|isAbstract| #:TO SQRT #:|version|
  #:%REPETITION #:|count| #:HIBOUND
  #:%INCREMENT #:|ControlStatement|
  #:|MemberCell| #:|operator|
  #:END_SCHEMA_MAP #:FALSE))

   
#|
  (:export 
   #:unresolved-attribute
   #:|Operation|
   #:|name|))
|#   
