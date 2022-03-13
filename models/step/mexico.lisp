;;; Automatically generated from the UML Metamodel by UML Testbed tools on 2008-03-21 19:15:41
;;; Load this file with ensure-model and load-model, not load
;;; Before editing, consider whether edits belong in the generator rather than here.

(in-package :MEXICO)

;;; POD 2009-06-12: I'm changing all |Integer| to |IntegerValue| (18 places).

; pod7 will have fix problem with forward-ref-class before changing to primitive types
(def-mm-class |BooleanType| :mexico (|LogicType|)
    "Not part of MEXICO. Added for use in Injector implementation."
    ())

(def-mm-class |IntegerType| :mexico (|NumericType|)
     "POD added this."
  ())

(def-mm-class |ABSTRACTConstraint| :mexico (|SubtypeConstraint|)
  "Not part of MEXICO. Added for use in Injector implementation."
    ())

(def-mm-class unresolved-attribute-ref :mexico ()
   "Not part of MEXICO. Added for use in Injector implementation."
  ((|local-name| :RANGE T :MULTIPLICITY (0 1)) ; 2022 Problem exporting this; mof has |local-name| too.
   (|entity-instance| :RANGE T :MULTIPLICITY (0 1))
   (|%scope| :RANGE T :MULTIPLICITY (0 1) :initarg :%scope
	   :xmi-hidden t))) ; 2012 added :xmi-hidden t, initarg

;;; These are used because the Scope object needed to create a ScopeId
;;; may not exist yet. (And resolving it without the defining-entity is impossible).
;;; They are used in :redeclared_attribute and UNIQUE Rules
(def-mm-class unresolved-attribute :mexico ()
   "Not part of MEXICO. Added for use in Injector implementation."
  ((|where-found| :RANGE T :MULTIPLICITY (0 1)) ; was defining-entity
   (|attribute-name| :RANGE T :MULTIPLICITY (0 1))))

;;; This is like unresolved-attribute, but won't get resolved.
(def-mm-class unresolved-inverse :mexico ()
   "Not part of MEXICO. Added for use in Injector implementation."
  ((|where-found| :RANGE T :MULTIPLICITY (0 1))
   (|attribute-name| :RANGE T :MULTIPLICITY (0 1))))

; pod 7 adding from injector/post-process.lisp
(def-mm-class unresolved-operator :mexico ()
   "Not part of MEXICO. Added for use in Injector implementation."
  ((|enum-symbol| :multiplicity (1 1) :RANGE |String|)))

(def-mm-class |RepeatControl| :mexico (|Statement|)
   "Not part of MEXICO. Added for use in Injector implementation."
   ())

(def-mm-class |RepeatIncrementControl| :mexico (|RepeatControl|)
   "Not part of MEXICO. Added for use in Injector implementation."
   ((|variable| :range |Variable|  :multiplicity (1 1) :xmi-hidden t)
    (|lbound|  :range |Expression| :multiplicity (1 1) :xmi-hidden t)
    (|ubound|  :range |Expression| :multiplicity (1 1) :xmi-hidden t)
    (|increment|  :range |Expression| :multiplicity (0 1) :xmi-hidden t)))

(def-mm-class |RepeatWhileControl| :mexico (|RepeatControl|)
   "Not part of MEXICO. Added for use in Injector implementation."
   ((|condition| :range |Expression| :multiplicity (1 1) :xmi-hidden t)))

(def-mm-class |RepeatUntilControl| :mexico (|RepeatControl|)
   "Not part of MEXICO. Added for use in Injector implementation."
   ((|condition| :range |Expression| :multiplicity (1 1) :xmi-hidden t)))

(setf (mofi:abstract-p  (find-class '|RepeatControl|)) t)


;;; ================== END POD ADDS (but not end of edits) ========================


(def-mm-primitive |EntityName|
 :MEXICO NIL
   "  represents the unique underlying identity of an entity instance, expressed
  as some kind of identifier.  The nature of this identifier is not defined
  in EXPRESS, but it is stated that this identifier is not necessarily constructed
  from any group of modeled attribute values.  Each EntityName is unique
  within a Population, but the actual namespace of an EntityName is not specified
  in Part 11.<note>See clause 5 of ISO 10303-11:2004.</note>")

(def-mm-primitive |ExpressText|
 :MEXICO NIL
   "  Represents any EXPRESS language text, including both unparsed text and
  specific syntactic elements..<note>See clause 7 of ISO 10303-11:2004.</note>")

(def-mm-primitive |Identifier|
 :MEXICO (|ExpressText|)
   "  EXPRESS language element used for naming NamedElements.<note>See
  7.4 of ISO 10303-11:2004.</note>")

(def-mm-primitive |Keyword|
 :MEXICO (|ExpressText|)
   "  EXPRESS language element used for names of built-in data types.<note>See
  7.2.1 of ISO 10303-11:2004.</note>")

;;; PODTT was -enum
#|
(def-mm-enum |BinaryOperator|
 :MEXICO () (AND |Add| |BagAdd| |BagRemove|
   |BagUnion| |BinaryAppend| DIV |Difference| |Divide|
   |EntityConstructor| |EntityValueEqual| |EntityValueNotEqual| |Equal| |Exponent|
   |Greater| IN |InstanceEqual| |InstanceNotEqual| |Intersection|
   LIKE |Less| |ListAddFirst| |ListAddLast| |ListAppend|
   MOD |Multiply| NVL |NotEqual| |NotGreater|
   |NotLess| OR |SetAdd| |SetUnion| |StringAppend|
   |Subset| |Subtract| |ValueIn| XOR )
    "  Conceptual EXPRESS language element representing the interpretation
  of a binary operation symbol in the context of the operand datatypes.
   Instances of this class are distinct operations, such as number-addition,
  set-union, string-compare-equal, etc.   Some BinaryOperators are denoted
  by 'built-in functions' in EXPRESS syntax. <note>See ISO 10303-11.2:2004
  clause 12 and some elements of clause 15.</note>")
|#

(def-mm-class |BinaryOperator|  :mexico ()
    "  Conceptual EXPRESS language element representing the interpretation
  of a binary operation symbol in the context of the operand datatypes.
   Instances of this class are distinct operations, such as number-addition,
  set-union, string-compare-equal, etc.   Some BinaryOperators are denoted
  by 'built-in functions' in EXPRESS syntax. <note>See ISO 10303-11.2:2004
  clause 12 and some elements of clause 15.</note>"
    ((|id| :xmi-hidden T :range T :multiplicity (1 1)
     :documentation "POD The requirements on enumerations are more extensive
     in MEXICO than in my UML-based specs. Instances carry the type info.
     keywords won't cut it.")))

#| 2012-01-02
(setf (slot-value (find-class '|BinaryOperator|) 'class-p) nil)
(setf (slot-value (find-class '|BinaryOperator|) 'enum-p) t)
(setf (slot-value (find-class '|BinaryOperator|) 'enum-values)
      '(:AND :|Add| :|BagAdd| :|BagRemove|
	:|BagUnion| :|BinaryAppend| :DIV :|Difference| :|Divide|
	:|EntityConstructor| :|EntityValueEqual| :|EntityValueNotEqual| :|Equal| :|Exponent|
	:|Greater| :|IN| :|InstanceEqual| :|InstanceNotEqual| :|Intersection|
	:LIKE :|Less| :|ListAddFirst| :|ListAddLast| :|ListAppend|
	:MOD :|Multiply| :NVL :|NotEqual| :|NotGreater|
	:|NotLess| :OR :|SetAdd| :|SetUnion| :|StringAppend|
	:|Subset| :|Subtract| :|ValueIn| :XOR :|LessEqual| :|UnEqual|)) ; POD added LessEqual
|#

#|
(def-mm-enum |OrderingKind|
 :MEXICO () (|indexed| |ordered| |unordered| )
    "")
|#

(def-mm-class |OrderingKind|  :MEXICO ()
    ""
    ((|id| :xmi-hidden T :range T :multiplicity (1 1)
     :documentation "POD The requirements on enumerations are more extensive
     in MEXICO than in my UML-based specs. Instances carry the type info.
     keywords won't cut it.")))

#| 2012-01-03
(setf (slot-value (find-class '|OrderingKind|) 'class-p) nil)
(setf (slot-value (find-class '|OrderingKind|) 'enum-p) t)
(setf (slot-value (find-class '|OrderingKind|) 'enum-values)
      '(:indexed :ordered :unordered))
|#

#|
(def-mm-enum |UnaryOperator|
 :MEXICO () (ABS ACOS ASIN ATAN
   |BinaryLength| COS EXISTS EXP |HiBound|
   |HiIndex| |Identity| LOG LOG10 LOG2
   |LoBound| |LoIndex| NOT |Negate| ODD
   |RolesOf| SIN SQRT |SizeOf| |StringLength|
   TAN |TypeOf| VALUE |ValueUnique| )
    "  Conceptual EXPRESS language element representing the interpretation
  of a unary operation symbol in the context of the operand datatype.   Instances
  of this class are distinct operations, such as numeric-negation, boolean-negation,
  real-square-root, absolute-value, etc.   Some UnaryOperators are denoted
  by 'built-in functions' in EXPRESS syntax. <note>See ISO 10303-11.2:2004
  clause 12 and some elements of clause 15.</note>")
|#

(def-mm-class |UnaryOperator|  :MEXICO ()
    "  Conceptual EXPRESS language element representing the interpretation
  of a unary operation symbol in the context of the operand datatype.   Instances
  of this class are distinct operations, such as numeric-negation, boolean-negation,
  real-square-root, absolute-value, etc.   Some UnaryOperators are denoted
  by 'built-in functions' in EXPRESS syntax. <note>See ISO 10303-11.2:2004
  clause 12 and some elements of clause 15.</note>"
    ((|id| :xmi-hidden T :range T :multiplicity (1 1)
     :documentation "POD The requirements on enumerations are more extensive
     in MEXICO than in my UML-based specs. Instances carry the type info.
     keywords won't cut it.")))

#| 2012-01-03
(setf (slot-value (find-class '|UnaryOperator|) 'class-p) nil)
(setf (slot-value (find-class '|UnaryOperator|) 'enum-p) t)
(setf (slot-value (find-class '|UnaryOperator|) 'enum-values)
      '(:ABS :ACOS :ASIN :ATAN
	:|BinaryLength| :COS :EXISTS :EXP :|HiBound|
	:|HiIndex| :|Identity| :LOG :LOG10 :LOG2
	:|LoBound| :|LoIndex| :NOT :|Negate| :ODD
	:|RolesOf| :SIN :SQRT :|SizeOf| :|StringLength|
	:TAN :|TypeOf| :VALUE :|ValueUnique|))
|#

(def-mm-DATATYPE |ScopedId| :MEXICO NIL
"  The combination of an Identifier and its namespace, which together constitute
  a well-defined symbol for an EXPRESS ModelElement.  A ScopedId whose Scope
  is a Schema is visible throughout the Schema, and possibly to other Schemas
  that interface the NamedElement.  A ScopedId whose Scope is a LocalScope
  is visible only in that LocalScope.  A ScopedId whose Scope is a NamedType
  is visible only in the declaration of that NamedType and in Expressions
  involving references to elements whose data type is that NamedType.  "
  ((|definingScope| :range |Scope| :multiplicity (1 1)
  :documentation
   "  Represents the relationship between the ScopedId and the Scope in which
  it is defined.<note>See Clause 10 of ISO 10303-11:2004.</note>")
   (|localName| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the EXPRESS identifier that uniquely identifies the NamedElement
  within the namespace that is the Scope.")))


(def-mm-class |AGGREGATEType| :MEXICO (|GeneralizedType|)
"  a GeneralizedType that is an abstraction of all AggregationTypes and
  all GeneralAggregationTypes.  That is, any ARRAY, BAG, LIST or SET Instance
  that satisfies the SizeConstraints (if any), whose members are of the specified
  member type or some specialization of it, is an instance of the AGGREGATEType.
    It follows that any ARRAY, BAG, LIST or SET type whose instances are
  necessarily instances of the AGGREGATEType is a specialization.<note>See
  9.5.3.1 of ISO 10303-11:2004.</note>"
  ((|constraint| :range |ActualStructureConstraint| :multiplicity (1 1)
  :documentation
   "  the ActualStructureConstraint, if any, that applies to this component
  of the GeneralizedType specification.<note>Only an AGGREGATEType that
  appears in the specification of the data type of a Parameter can have an
  ActualStructureConstraint.  The AGGREGATEType has an ActualStructureConstraint
  only if it has a syntactic type_label and does not itself define that type_label.
   See 9.5.3.4 of ISO 10303-11:2004.</note>")
   (|lower-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents a lower-bound constraint on aggregate values conforming to
  the AGGREGATE type.  If the lower-bound constraint is present, the number
  of members of the aggregate value shall be greater than or equal to this
  value.  If the lower-bound is not present or evaluates to zero, there is
  no constraint.  Unless the lower-bound specified for the AGGREGATIONType
  is an explicit '0', this constraint shall appear.<note>See 9.5.3.2
  of ISO 10303-11:2004.</note>")
   (|member-type| :range |ParameterType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an AGGREGATE Type and the specification
  for the data type of the members of its instances.  If the specification
  is an InstantiableType, the member-type of conforming aggregation types
  is required to be exactly that data type.  If the specification is a GeneralizedType,
  the member-type of the conforming aggregation types must conform to it.<note>See
  9.5.3.1 of ISO 10303-11:2004.</note>")
   (|upper-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents an upper-bound constraint on aggregate values conforming
  to the AGGREGATE type.  If the upper-bound constraint is present and does
  not evaluate to indeterminate ('?'), the number of members of the aggregate
  value shall be less than or equal to this value.  If the upper-bound is
  not present or evaluates to indeterminate, there is no constraint.  Unless
  the upper-bound specified for the AGGREGATE type is an explicit '?', this
  constraint shall appear.<note>See 9.5.3.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |ANDConstraint| :MEXICO (|SubtypeConstraint|)
"  a constraint requiring its two operands to be equal as sets.  Each operand
  can be a single Extent or a union of Extents.<note>See 9.2.5.4 of ISO
  10303-11:2004.</note>"
  ())


(def-mm-class |ARRAYType| :MEXICO (|ConcreteAggregationType|)
"  an AggregationType representing all EXPRESS ARRAY data types."
  ((|hi-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the ARRAYType and the upper bound
  on the Integer index-range of each value of the ARRAYType.<note>See
  8.2.1 and 15.11 of ISO 10303-11:2004.</note>")
   (|isOptional| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the member type is declared to be OPTIONAL in the syntactic
  designation for the ARRAYType; False otherwise.  When isOptional is True,
  any instance of the ARRAYType is permitted to have members whose value
  is unspecified ('?').<note>See 8.2.1 of ISO 10303-11:2004.</note>")
   (|lo-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the ARRAYType and the lower bound
  on the Integer index-range of each value of the ARRAYType.<note>See
  8.2.1 and 15.17 of ISO 10303-11:2004.</note>")))


(def-mm-class |ARRAYValue| :MEXICO (|AggregateValue|)
"  an AggregateValue, representing a value of an EXPRESS ARRAY data type:
  a set of pairs of the form (index value, domain value) where the index
  value is selected from a finite range of integers, and each such value
  occurs in exactly one pair, and the domain value is an instance of the
  member-type of the ARRAY."
  ((|member-slot| :range |ArrayMember| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an ArrayValue and each of its distinct
  slots for member values.")
   (|of-type| :range |ARRAYType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the ARRAYValue and the ARRAYTypes
  of which it is an instance.")))


(def-mm-class |ActualAGGREGATEType| :MEXICO (|ActualType|)
"  an ActualType that is an aggregation type whose structure is specified
  by an ActualStructure, which refers to the structure of a (component of)
  an actual parameter.The .label attribute is used to determine the ActualStructure
  to which it refers.The member-type of the ActualAGGREGATEType can be any
  VariableType (Instantiable or Actual) and need not have any relationship
  to the member type of the corresponding actual parameter.<note>See
  9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|label| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the 'type_label' on the AGGREGATE type, which is used to
  associate it with the ActualStructure.")
   (|lower-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents a lower-bound constraint on aggregate values that are instances
  of the actual aggregation type corresponding to the AGGREGATE type.  If
  the lower-bound constraint is present, the number of members of the aggregate
  value shall be greater than or equal to this value.  If the lower-bound
  is not present or evaluates to zero, there is no constraint.  Unless the
  lower-bound specified for the AGGREGATE type is an explicit '0', this constraint
  shall appear.<note>See 9.5.3.2 of ISO 10303-11:2004.</note>")
   (|member-type| :range |VariableType| :multiplicity (1 1)
  :documentation
   "  represents the type of the components of the actual aggregation type
  that has the structure that corresponds to the AGGREGATE type.  The type
  of the members may be an InstantiableType or an ActualType derived from
  a ParameterType.<note>See 9.5.3.1 of ISO 10303-11:2004.</note>")
   (|refers-to| :range |ActualStructure| :multiplicity (1 1)
  :documentation
   "  the AGGREGATEType to which the ActualAGGREGATEType corresponds.  When
  instantiated, the ActualType will use the aggregate structure of the ActualParameter
  that corresponds to this AGGREGATEType (element).")
   (|upper-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents an upper-bound constraint on aggregate values that are instances
  of the actual aggregation type corresponding to the AGGREGATE type.  If
  the upper-bound constraint is present and does not evaluate to indeterminate
  ('?'), the number of members of the aggregate value shall be less than
  or equal to this value.  If the upper-bound is not present or evaluates
  to indeterminate, there is no constraint.  Unless the upper-bound specified
  for the AGGREGATE type is an explicit '?', this constraint shall appear.<note>See
  9.5.3.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |ActualARRAYType| :MEXICO (|ActualAggregationType|)
"  An ActualAggregationType whose structure is an ARRAY with defined lower
  and upper bounds on the index."
  ((|hi-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  represents the upper bound on the Integer index-range of each value
  of the ActualARRAYType.<note>See 8.2.1 and 15.11 of ISO 10303-11:2004.</note>")
   (|isOptional| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the member type is declared to be OPTIONAL in the syntactic
  designation for the ARRAYType; False otherwise.  When isOptional is True,
  any instance of the ARRAYType is permitted to have members whose value
  is unspecified ('?').<note>See 8.2.1 of ISO 10303-11:2004.</note>")
   (|lo-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  represents the lower bound on the Integer index-range of each value
  of the ActualARRAYType.<note>See 8.2.1 and 15.11 of ISO 10303-11:2004.</note>")))


(def-mm-class |ActualAggregationType| :MEXICO (|AggregationType| |ActualType|)
"  An aggregation type whose member-type is an ActualType.An ActualAggregationType
  differs from an InstantiableAggregationType in that the data type of its
  components is dynamically specified."
  ((|member-type| :range |ActualType| :multiplicity (1 1)
  :documentation
   "  represents the ActualType that is the the type of the component elements
  of the ActualAggregationType.<note>If the member-type were not itself
  an ActualType, the ActualAggregationType would be an Instantiable AggregationType.</note>")))


(def-mm-class |ActualBAGType| :MEXICO (|ActualAggregationType|)
"  An ActualAggregationType whose structure is a BAG."
  ())


(def-mm-class |ActualDataType| :MEXICO (|GenericElement| |GenericType|)
"  A GENERIC or GENERIC_ENTITY type that defines a type_label to refer
  to the data type of the corresponding component of the .source ActualParameter.
   The ActualDataType is the first occurrence of the label among the Parameters
  of the Algorithm. Later occurrences in Parameters are ActualTypeConstraints
  (q.v.)."
  ())


(def-mm-class |ActualGenericType| :MEXICO (|ActualType|)
"  an ActualType that refers to an ActualDataType -- the data type of an
  actual parameter or component of an actual parameter.The .label attribute
  is used to determine the ActualStructure to which it refers. If the .isEntity
  attribute is FALSE (the EXPRESS keyword is GENERIC), the actual data type
  can be any Instantiable data type.   If the .isEntity attribute is TRUE
  (the EXPRESS keyword is GENERIC_ENTITY), the actual data type must be an
  EntityType.<note>See 9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|isEntity| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the ActualType is required to be an EntityType; False otherwise.")
   (|label| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the 'type_label' on the GENERIC or GENERIC_ENTITY type, which
  is used to associate it with the ActualDataType.")
   (|refers-to| :range |ActualDataType| :multiplicity (1 1)
  :documentation
   "  the GenericType to which the ActualGenericType corresponds.  When instantiated,
  the actual type will be the data type of the ActualParameter that corresponds
  to this GenericType (element).")))


(def-mm-class |ActualLISTType| :MEXICO (|ActualAggregationType|)
"  An ActualAggregationType whose structure is a LIST."
  ())


(def-mm-class |ActualParameter| :MEXICO NIL
"  represents the substitution of the actual parameter instance for the
  formal parameter and, where required, the substitution of the data type
  of the actual parameter for the GeneralizedType of the formal parameter
  and any derivatives.When the corresponding formal Parameter is an InParameter
  (always in a FunctionCall), the actual-value is present -- either an instance
  of an InstantiableType or Indeterminate.When the corresponding formal Parameter
  is a VARParameter (only in a ProcedureCall), the actual-value is not present,
  the actual-reference is present instead.  <note>See 12.8 of ISO 10303-11:2004.</note>"
  ((|actual-referent| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the VARExpression that denotes the referent object to be associated
  with the formal (VAR) Parameter during the invocation.")
   (|actual-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression that specifies the value to be passed for the ActualParameter.
   When the corresponding formal Parameter is an InParameter (always in a
  FunctionCall), the actual-value is present.  When the corresponding formal
  Parameter is a VARParameter (only in a ProcedureCall), the actual-value
  is not present.<note>See 12.8 of ISO 10303-11:2004.</note>")
   (|formal-parameter| :range |Parameter| :multiplicity (1 1)
  :documentation
   "  represents the formal parameter to which the ParameterBinding applies.<note>See
  12.8 of ISO 10303-11:2004.</note>")
   (|in-FunctionCall| :range |FunctionCall| :multiplicity (1 1)
  :documentation
   "  the FunctionCall, if any, that contains the ActualParameter.")
   (|in-ProcedureCall| :range |ProcedureCall| :multiplicity (1 1)
  :documentation
   "  the ProcedureCall, if any, in which the ActualParameter appears.")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents the position in which the ActualParameter occurs in the sequence
  associated with the FunctionCall (used to associate the ActualParameter
  with a formal parameter).<note>See 12.8 of ISO 10303-11:2004.</note>")))


(def-mm-class |ActualSETType| :MEXICO (|ActualAggregationType|)
"  An ActualAggregationType whose structure is a SET."
  ())


(def-mm-class |ActualStructure| :MEXICO (|AGGREGATEType| |GenericElement|)
"  An AGGREGATE type that defines a type_label to refer to the structure
  (ARRAY, BAG, LIST, SET) of the corresponding component of the corresponding
  ActualParameter.  The ActualStructure is the first occurrence of the label
  among the Parameters of the Algorithm. Later occurrences in Parameters
  of the same Algorithm are ActualStructureConstraints (q.v.)."
  ())


(def-mm-class |ActualStructureConstraint| :MEXICO NIL
"  A constraint on the aggregation structure of the data type of the actual
  parameter that corresponds to the formal parameter.  The constraint is
  declared in EXPRESS by a type_label on an AGGREGATE type that occurs in
  the specification of the data type of a formal parameter, but is <emphasis>not
  the definition</emphasis> of that type_label (cf. ActualStructure).  The
  requirement declared by the constraint is that the structure of the corresponding
  component of the data type of the corresponding actual parameter (the .matching-structure)
  must be the same as the structure referred to by the ActualStructure that
  is denoted by the (.label) type_label. <note>See 9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|label| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the type_label value on the syntactic AGGREGATE type that denotes the
  constraint.  Any occurrence of the same type_label after the first denotes
  a constraint.")
   (|matching-structure| :range |AGGREGATEType| :multiplicity (1 1)
  :documentation
   "  the AGGREGATE component in the specification of the data type of the
  formal parameter to which the constraint applies.")
   (|required-structure| :range |ActualStructure| :multiplicity (1 1)
  :documentation
   "  the ActualStructure that defines the .label type_label that is used
  to establish the constraint. The ActualStructure defines the required structure
  (ARRAY, BAG, LIST, SET) of the corresponding component of the data type
  of the actual parameter.")))


(def-mm-class |ActualType| :MEXICO (|LocalElement| |VariableType|)
"  specification of an instantiable data type by reference to (a component
  of) the data type of the actual parameter that corresponds to a formal
  parameter of the Algorithm. <note>See 9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|scope| :range |Algorithm| :multiplicity (1 1)
  :documentation
   "  The Algorithm in which the ActualType is specified.  The ActualType
  must be the data type of a Variable or Attribute whose scope is contained
  in the Algorithm.")))


(def-mm-class |ActualTypeConstraint| :MEXICO NIL
"  a constraint that requires type compatibility between the .required-type
  ActualDataType and the (component of the) actual data type of the actual
  parameter that corresponds to the occurrence of the .matching-type in the
  formal-parameter-type of the Parameter that has the constraint.The constraint
  is declared in EXPRESS by a type_label on a GENERIC or GENERIC_OBJECT type
  that occurs in the specification of the data type of a formal parameter,
  but is <emphasis>not the definition</emphasis> of that type_label (cf.
  ActualDataType).  The ActualTypeConstraint relates one Parameter and its
  formal-parameter-type to the ActualDataType that defines the .label type_label.If
  the formal parameter types of additional Parameters contain the same type_label,
  each such occurrence constitutes a distinct ActualTypeConstraint.  <note>See
  9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|label| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the type_label value on the syntactic AGGREGATE type that denotes the
  constraint.  Any occurrence of the same type_label after the first denotes
  a constraint.<note>See 9.5.3.4 of ISO 10303-11:2004.</note>")
   (|matching-type| :range |GenericType| :multiplicity (1 1)
  :documentation
   "  the GENERIC or GENERIC_ENTITY component in the specification of the
  data type of the formal parameter to which the constraint applies.")
   (|required-type| :range |ActualDataType| :multiplicity (1 1)
  :documentation
   "  the ActualDatatType that defines the .label type_label that is used
  to establish the constraint. The ActualDataType defines the data type with
  which the corresponding component of the data type of the actual parameter
  (the .matching-type) must be compatible.")
   ;; PODTT  POD added back this slot (was in 060301)
   (|for-function| :RANGE |Algorithm| :MULTIPLICITY (1 1)
   :documentation
   " represents the relationship between an ActualTypeConstraint and the
     Algorithm to which it applies.")))

(def-mm-class |AggregateIndex| :MEXICO (|IndexOperation|)
"  an IndexOperation that returns the value of a specified member of a
  given AggregateValue.  .base-value evaluates to the AggregateValue.  .index-value
  evaluates to the 'position' of the member to be extracted.  The interpretation
  of the .index-value depends on the kind of AggregateValue (Indexed, Ordered,
  Unordered).<note>See 12.6.1 of ISO 10303-11:2004.</note>"
  ((|index-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the (Integer) index value designating the member whose value
  is to be extracted.  The interpretation of the index value depends on the
  kind of AggregateValue.<note>See 12.6.1 of ISO 10303-11:2004.</note>")))


(def-mm-class |AggregateInitializer| :MEXICO (|Expression|)
"  represents the EXPRESS 'aggregate initializer'.   It produces a value
  of type AGGREGATE OF GENERIC, by binding a sequence of member values to
  positions in the generic aggregate value. <note>See 12.9 of ISO
  10303-11:2004.</note>"
  ((|bindings| :range |MemberBinding| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the AggregateInitializer and the
  set of MemberBindings it comprises.<note>See 12.9 of ISO 10303-11:2004.</note>")
   (|result-value| :range |GenericAggregate| :multiplicity (1 1)
  :documentation
   "  represents the aggregate value that results from the aggregate initializer.
   If the AggregateInitializer expression can be evaluated without regard
  to any actual population ('compile time'), this value shall be present,
  but not otherwise.<note>See 12.9 of ISO 10303-11:2004.</note>")))


(def-mm-class |AggregateValue| :MEXICO (|ConcreteValue|)
"  a ConcreteValue that is composite, consisting of a collection of Instances
  from a given member DataType."
  ())


(def-mm-class |AggregationType| :MEXICO NIL
"  an AnonymousType representing an EXPRESS 'aggregation type', whose instances
  are collections of instances of a 'member type': ARRAY, BAG, LIST, SET.<note>See
  8.2 of ISO 10303-11:2004.</note>"
  ((|isUnique| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the members of a given instance of the type are required to
  be distinct; else False.  isUnique is always True for a SET type, always
  False for a BAG type, and True for LIST and ARRAY types if and only if
  the UNIQUE keyword is present in the type designation<note>See 8.2
  of ISO 10303-11:2004.</note>")
   (|lower-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents the appearance of a lower-bound constraint in syntactic designation
  for the aggregation type.  Refines InstantiableType.constraints.  For this
  purpose the appearance of an explicit zero ('0') value may be considered
  to represent no lower-bound constraint; and the lower-bound relationship
  need not appear.  (The appearance of a lower-bound expression that may
  evaluate to zero shall always be represented by a lower-bound relationship.)<note>See
  8.2.x of ISO 10303-11:2004.</note>")
   (|ordering| :range |OrderingKind| :multiplicity (1 1)
  :documentation
   "  Specifies the structure of the AggregationType: indexed (ARRAY), ordered
  (LIST), unordered (BAG, SET).")
   (|upper-bound| :range |SizeConstraint| :multiplicity (1 1)
  :documentation
   "  represents the appearance of an upper-bound constraint in the syntactic
  designation for the aggregation type.  Refines InstantiableType.constraints.
   For this purpose the appearance of an explicit indeterminate value ('?')
  is considered to represent no upper-bound constraint, and shall not be
  represented by an upper-bound relationship.  (The appearance of an upper-bound
  expression that may evaluate to '?' shall be represented by an upper-bound
  relationship.)<note>See 8.2.x of ISO 10303-11:2004.</note>")))


(def-mm-class |Algorithm| :MEXICO (|CommonElement| |AlgorithmScope|)
"  a CommonElement that represents an operation or process that transforms
  information.  Every Algorithm is either a Procedure or a Function.  Every
  Algorithm is also an AlgorithmScope, in that it may define CommonElements
  and local ModelElements.<note>See 9.5 of ISO 10303-11:2004.</note>"
  ((|actual-types| :range |ActualType| :multiplicity (1 -1)
  :documentation
   "  the set of ActualTypes that are defined in the Algorithm.  subsets LocalScope.local-elements.")
   (|body| :range |Statement| :multiplicity (1 -1) ; pod was (1 1)
  :documentation
   "  represents the relationship between a (conceptual) Algorithm and a definition
  of the Algorithm as a Statement.  In most cases, the Statement is a StatementBlock
  -- a sequence of actions to be performed.  The body of the Algorithm is
  modeled as optional (0..1).  Support for the body is not a requirement
  for the support of Algorithms.<note>See 9.5 of ISO 10303-11:2004.</note>")
   (|formal-parameters| :range |Parameter| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the Algorithm and its formal parameters.")))


(def-mm-class |AlgorithmScope| :MEXICO (|LocalScope|)
"  A LocalScope that can be the namespace of CommonElements."
  ((|common-elements| :range |CommonElement| :multiplicity (1 -1)
  :documentation
   "  the CommonElements that are defined in the AlgorithmScope<note>See
  clause 10 of ISO 10303-11:2004.</note>")
   (|variables| :range |LocalVariable| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the AlgorithmScope and the set of
  LocalVariables that are defined within it.")))


(def-mm-class |AliasRef| :MEXICO (|VARExpression|)
"  A VARExpression consisting only of the identifier for a VARVariable,
  i.e. an AliasVariable, or a VARParameter.  The referent of the AliasRef
  VARExpression is the referent of the VARVariable designated by the .refers-to
  relationship."
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the lexical text of the identifier for the Parameter, subsets VARExpression.text")
   (|refers-to| :range |VARVariable| :multiplicity (1 1)
  :documentation
   "  the AliasVariable or VARParameter whose referent is the referent of
  the VARExpression. ")))


(def-mm-class |AliasStatement| :MEXICO (|Statement| |LocalScope|)
"  Represents an EXPRESS ALIAS statement.  Strictly speaking, an ALIAS
  statement is a purely syntactic convention -- it introduces a NamedVariable
  (the alias-variable) to represent the result of a VARExpression (the referent).But
  the AliasVariable is not a Variable, and the semantics is not assignment;
  it is rather creation of a VARVariable that is persistently associated
  with the Variable specified by the value of the referent expression, over
  changes in value of that Variable. Within the body of the ALIAS statement,
  any assignment to the AliasVariable assigns the value to the referent Variable,
  and any VariableRef that refers to the AliasVariable refers to the current
  value of that Variable.<note>See Clause 13.2 of ISO 10303-11:2004.</note>"
  ((|alias-variable| :range |AliasVariable| :multiplicity (1 1)
  :documentation
   "  the Variable that is introduced by the AliasStatement and bound to a
  Reference.")
   (|body| :range |Statement| :multiplicity (1 1)
  :documentation
   "  the Statement (or StatementBlock) specifying the action to be taken
  by the AliasStatement.<note>The AliasStatement has the effect of 'fixing'
  the referent of the alias-variable, in the case in which the Statement
  is a StatementBlock that includes actions that alter the values of elements
  of the VARExpression. </note>")))


(def-mm-class |AliasVariable| :MEXICO (|VARVariable|)
"  a NamedVariable that is created by an ALIAS statement, and whose scope
  is the body of the ALIAS statement.  An Alias Variable is a VARVariable:
  it does not hold an Instance; it refers to a Variable that holds an Instance.
   The referent of the AliasVariable is specified by the value of the VARExpression
  assigned to it by the ALIAS statement.<note>See Clause 13.2 of ISO
  10303-11:2004.</note>"
  ((|namespace| :range |AliasStatement| :multiplicity (1 1)
  :documentation
   "  the AliasStatement that is the scope of the AliasVariable.")
   (|referent| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the VARExpression that specifies the referent of the AliasVariable --
  the (member or component of the) Variable to which the AliasVariable refers
  during execution of the body of the ALIAS statement.")))


(def-mm-class |AnonymousType| :MEXICO (|ConcreteType|)
"  represents any InstantiableType that is not a NamedType."
  ((|specializes| :range |AnonymousType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an AnonymousType to an AnonymousType
  of which it is a 'specialization', as specified in Part 11 clause 9.2.7.
   Unlike the specialization for defined data types, these relationships
  are true subtypes: the domain of the 'specialization' is a subset of the
  domain of AnonymousType and has the same interpretation.")))


(def-mm-class |ArrayBound| :MEXICO NIL
"  represents a bound on the index domain of an ARRAY data type .<note>See
  8.2.1 of ISO 10303-11:2004.</note>"
  ((|bound| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  the integer value of the bound, when it can be determined 'by inspection'
  of the bound expression.<note>See 8.2.1 of ISO 10303-11:2004.</note>")
   (|bound-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression that defines the ArrayBound.<note>See 8.2.1 of ISO
  10303-11:2004.</note>")))


(def-mm-class |ArrayMember| :MEXICO NIL
"  Represents a single element of an ARRAYValue seen as a relation.  It
  maps one index-value to one value of the base data type (the 'member' value).
   In the case of an ARRAY OF OPTIONAL, the member-value need not be present."
  ((|index| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents the index value to which the ArrayMember corresponds. In
  a given ARRAYValue, there is exactly one ArrayMember that corresponds to
  each index value.")
   (|member-value| :range |Instance| :multiplicity (1 1)
  :documentation
   "  for a given ARRAYValue, represents the relationship between an index
  value (represented by an ArrayMember) and the Instance value that is the
  image of that index value in the base type. ")))


(def-mm-class |Assignment| :MEXICO (|Statement|)
"  Represents an EXPRESS assignment statement.  An Assignment causes the
  value of the .recipient location  to become equal to the result of the
  .assigned-value Expression.<note>See Clause 13.3 of ISO 10303-11:2004.</note>"
  ((|assigned-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression whose result is the value to be assigned.")
   (|variable| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the VARfExpression that designates the object whose value is to be replaced.<note>The
  VARExpression must not refer to an object that is part of the state of
  an EntityInstance in the Population.  It may, however, refer to an object
  that holds (a reference to) an EntityInstance.</note>")
   (|place-reference| :range |Expression| :multiplicity (1 1) :xmi-hidden t ; pod added slot
    :documentation "Not part of MEXICO. Added for implementation of the Injector.")))


(def-mm-class |Attribute| :MEXICO (|TypeElement|)
"  represents an EXPRESS attribute, i.e. a model of a property of an entity
  instance<note>See 9.2.1 of ISO 10303-11:2004.</note>"
  ((|attribute-type| :range |ParameterType| :multiplicity (1 1)
  :documentation
   "  represents the required DataType for all values of that Attribute in
  all instances of the EntityType.  The DataType is required to be an InstantiableType
  unless isAbstract is True for the EntityType, or the EntityType is defined
  in an AlgorithmScope (instead of a Schema).<note>See 9.2.1 of ISO 10303-11:2004.</note>")
   (|isAbstract| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if .isAbstract is True for the owning EntityType (see .of-entity)
  and the attribute-type of the EXPRESS attribute is a GeneralizedType; False
  in all other cases.  When .isAbstract is True, this Attribute must be redeclared
  to have an attribute-type that is an InstantiableType in any subtype of
  the owning EntityType that is not itself ABSTRACT.")
   (|of-entity| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship of an Attribute to the SingleEntityType
  for which it was originally declared.")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the position of the attribute declaration in the sequence
  of attribute declarations in the entity declaration.")))


(def-mm-class |AttributeBinding| :MEXICO NIL
"  represents the assignment of a specific value to one Attribute in the
  group that comprises the PartialEntityType.<note>See 9.2.6 of ISO 10303-11:2004.</note>"
  ((|attribute| :range |ExplicitAttribute| :multiplicity (1 1)
  :documentation
   "  represents the explicit attribute to which the AttributeBinding assigns
  a value.  Position is used to identify the attribute.<note>See 9.2.6
  of ISO 10303-11:2004.</note>")
   (|attribute-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the value to be assigned to the explicit attribute by the
  AttributeBinding, as the result of the Expression.<note>See 9.2.6 of
  ISO 10303-11:2004.</note>")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents the position of the AttributeBinding in the constructor (and
  thus the association with the explicit attribute).<note>See 9.2.6 of
  ISO 10303-11:2004.</note>")
   (|to-value| :range |AttributeValue| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the AttributeBinding and the AttributeValue
  in which the attribute-value (expression) is bound to the Attribute.  The
  AttributeValue is an .attribute-of a unique SingleEntityValue.When the
  PartialEntityConstructor (expression) is evaluated, the PartialEntityValue
  equivalent to that SingleEntityValue is the result of the expression.
  If the expression can be evaluated without regard to any actual population
  ('compile time'), this value shall be present, but not otherwise.")))


(def-mm-class |AttributeCell| :MEXICO (|VARExpression|)
"  A VARExpression whose referent is an 'attribute object' containing the
  value of one ExplicitAttribute in an EntityValue. The .referent
  attribute of the AttributeCell identifies the ExplicitAttribute that characterizes
  the attribute object.  The referent of the .base-entity VARExpression must
  be an object that holds an EntityValue that has a 'slot' for that ExplicitAttribute.
   That object/slot in the referent of the base-entity is the referent of
  the AttributeCell VARExpression.<note.> An EntityInstance in the Population
  is considered to be an object that holds an EntityValue.  And therefore,
  an EntityInstance can be the referent of the base-entity.  But it is not
  possible to change the value of an Attribute of an EntityInstance in the
  Population.</note>  <note>An entity-valued object -- a Variable, Attribute,
  or aggregation member whose data type is an EntityType (or a SelectType
  whose select-list contains EntityTypes) -- may contain EntityInstances
  from the Population, or contain EntityValues that correspond to the EntityType,
  without reference to Instances in the Population.  When the base-entity
  of an AttributeCell is an entity-valued object, it is not always clear
  whether it contains an EntityInstance, which is then the referent, or an
  EntityValue, which makes the entity-valued object the referent.</note>"
  ((|base-entity| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the Expression that identifies the object that contains the EntityInstance
  or EntityValue that contains an object representing the ExplicitAttribute
  to which the AttributeObject refers.")
   (|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the lexical text of the identifier for the Attribute, subsets VARExpression.text")
   (|referent| :range |ExplicitAttribute| :multiplicity (1 1)
  :documentation
   "  the ExplicitAttribute whose slot in the referent of the base-entity
  is the referent of the AttributeCell VARExpression.")))


(def-mm-class |AttributeRef| :MEXICO (|Selector|)
"  a Selector expression that returns the value of a given Attribute of
  a given entity instance<note>See 12.7.3 of ISO 10303-11:2004.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the reference.")
   (|refers-to| :range |Attribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the AttributeReference and the Attribute
  to which it refers.")))


(def-mm-class |AttributeValue| :MEXICO NIL
"  represents the assignment of a value to a given Attribute of the EntityType
  corresponding to the SingleEntityValue."
  ((|actual-value| :range |Instance| :multiplicity (1 1)
  :documentation
   "  represents the value assigned to the Attribute by the AttributeValue.
   If the Attribute is declared OPTIONAL, it is possible that no value is
  assigned.")
   (|attribute| :range |ExplicitAttribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the AttributeValue assignment and
  the ExplicitAttribute to which it assigns a value.")))


(def-mm-class |BAGType| :MEXICO (|ConcreteAggregationType|)
"  an AggregationType representing all EXPRESS BAG data types<note>See
  8.2.3 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |BAGValue| :MEXICO (|AggregateValue|)
"  an AggregateValue, representing a value of an EXPRESS BAG data type:
  a collection of instances of the member-type of the BAG, in which a given
  instance can appear more than once."
  ((|member-slot| :range |BagMember| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a BagValue and each of its distinct
  member values.  Each distinct member value is represented by a BagMember
  (slot) that counts its occurrences in the bag.")
   (|of-type| :range |BAGType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the BAGValue and the BAGTypes of
  which it is an instance.")))


(def-mm-class |BagMember| :MEXICO NIL
"  Represents the relationship between a BAGValue and one value of the
  base data type (the 'member' value).  It has a 'count' attribute that represents
  the number of times the given member-value occurs in the BAGValue."
  ((|count| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a BagMember and the number of occurrences
  of the member-value that it represents, i.e. the number of occurrences
  of that member-value in the bag. ")
   (|member-value| :range |Instance| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a BagMember and the Instance that
  it includes, one or more times, in the BAGValue.")))


(def-mm-class |BinaryIndex| :MEXICO (|IndexOperation|)
"  An IndexOperation that returns a substring of one or more bits from
  a BINARY value.  .base-value is the BINARY value.  .first-bit designates
  the position of the first bit to be extracted.  .last-bit designates the
  position of the last bit to be extracted.  .last-bit has no value if only
  one bit is to be extracted.<note>See clause 12.3.1. of ISO 10303-11:2004.</note>"
  ((|first-bit| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the (postive integer) value that designates the position
  of the first bit to be extracted.")
   (|last-bit| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the (postive integer) value that designates the position
  of the last bit to be extracted.  .last-bit has no value if only one bit
  is to be extracted.")))


(def-mm-class |BinaryOperation| :MEXICO (|Operation|)
"  an Operation representing the result of a well-defined mathematical
  operation or character manipulation on two Expression operands, which are
  distinguished.  An instance of BinaryOperation represents a usage of a
  value of BinaryOperator with a specific left and right operand.<note>See
  clause 12 of ISO 10303-11:2004.</note>"
  ((|left-operand| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the operand Expression that produces one input to a BinaryOperation,
  distinguished (if needed) as the 'left' operand in the definition of the
  operation<note>See clause 12 of ISO 10303-11:2004.</note>")
   (|operator| :range |BinaryOperator| :multiplicity (1 1)
  :documentation
   "  Represents the conceptual operation that is actually being performed
  by the BinaryOperation.<note>See ISO 10303-11.2:2004, clause 12.</note>")
   (|right-operand| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the operand Expression that produces one input to a BinaryOperation,
  distinguished (if needed) as the 'right' operand in the definition of the
  operation.<note>See clause 12 of ISO 10303-11:2004.</note>")))


(def-mm-class |BinaryType| :MEXICO (|SimpleType|)
"  a SimpleType representing all EXPRESS BINARY data types, which are distinguished
  by different LengthConstraints.  By definition, every EXPRESS BINARY type
  with a LengthConstraint is different from every other BINARY data type.
   (They may be compatible with others, but not the same.)  The only instance
  of BINARYType with no LengthConstraint is the EXPRESS data type BINARY.<note>See
  8.1.7 of ISO 10303-11:2004.</note>"
  ((|binary-length-constraint| :range |LengthConstraint| :multiplicity (1 1)
  :documentation
   "  represents a constraint on the length (in bits) of the values in the
  domain of the BINARY data type.  Refines InstantiableType.constraints.<note>See
  8.1.7 of ISO 10303-11:2004.</note>")))


(def-mm-class |BinaryValue| :MEXICO (|SimpleValue|)
"  an AggregateValue, representing a value of an EXPRESS BAG data type:
  a collection of instances of the member-type of the BAG, in which a given
  instance can appear more than once."
  ())


(def-mm-class |BooleanValue| :MEXICO (|LogicalValue|)
"  a SimpleValue,  a value of the EXPRESS data type BOOLEAN: TRUE, FALSE"
  ())


(def-mm-class |CaseAction| :MEXICO NIL
"  represents a possible action to be taken, together with the .label-values
  that identify the case and enable it to be selected.  Among the cases for
  a given CaseStatement, one CaseAction may be designated the 'default' action,
  which is taken if no other action meets the selection criteria."
  ((|action| :range |Statement| :multiplicity (1 1)
  :documentation
   "  the Statement (or StatementBlock) that defines the actions, if any,
  to be executed if that case is selected.")
   (|isDefault| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if this CaseAction represents the default action to be taken if
  no other case label matches the value of the .selection-expression; otherwise
  False.")
   (|label-value| :range |Expression| :multiplicity (1 -1)
  :documentation
   "  an Expression whose result is a case label.  When the value of the .selection-expression
  matches the value of the Expression (which is often a Literal), the associated
  CaseAction defines the action to be taken by the CaseStatement.")))


(def-mm-class |CaseStatement| :MEXICO (|Statement|)
"  represents an EXPRESS CASE statement.  The CASE statement selects and
  executes a single CaseAction (from a list of CaseActions), based on the
  value of a selection-expression.  The .cases are considered in order, and
  the first CaseAction whose label-value matches the value of the .selection-expression
  is the action that is taken.  If no CaseAction has a label-value that matches
  the value of the .selection-expression, the CaseAction for which .isDefault
  is true, if any, is taken; otherwise, no action is taken.<note>See
  Clause 13.4 of ISO 10303-11:2004.</note>"
  ((|cases| :range |CaseAction| :multiplicity (1 -1)
  :is-ordered-p t
  :documentation
   "  represents the possible actions to be taken, in order of consideration,
  each labeled by one or more values.  ")
   (|selection-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression that is used to choose the CaseAction to be taken")))


(def-mm-class |Coercion| :MEXICO (|Operation|)
"  an Operation representing the conversion of the operand to a specific
  data type (InstantiableType).  This operation is implicit in a number of
  EXPRESS expressions, notably:<br>- in converting between a defined data
  type and its fundamental type (on which the operations are defined), and
  <br>- in converting an EntityValue to an EntityInstance of the corresponding
  EntityType.<br>In most cases, the Coercion does not change the 'value'
  of the operand; rather the Coercion maps the value to the corresponding
  value of the related data type.<note>See clause 12 of ISO 10303-11:2004,
  and the proposed revision to clause 12.10.</note>"
  ((|operand| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the Expression whose result is to be converted to the target-type
  by the Coercion operation.")
   (|target-type| :range |VariableType| :multiplicity (1 1)
  :documentation
   "  represents the data type to which the operand of the Coercion is to
  be converted.")))


(def-mm-class |CommonElement| :MEXICO (|SchemaElement|)
"  a SchemaElement that can be defined in either a Schema or a LocalScope,
  and has (or may have) a unique identifier within that Scope.  This is an
  artifact of the declaration and namespace rules for the EXPRESS language.
   NamedTypes, Algorithms, Constants, and 'SupertypeRules' can be defined
  at the Schema level or within Algorithms and GlobalRules (AlgorithmScopes).
   Every CommonElement has a Scope.  The Scope is either a SchemaScope or
  an AlgorithmScope."
  ((|local-scope| :range |AlgorithmScope| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a CommonElement that is defined
  in an AlgorithmScope and the scope in which it is defined; also, the scope
  (set of model elements) in which the id of the CommonElement refers to
  that CommonElement.<note>See Clause 10 of ISO 10303-11:2004.</note>")))


(def-mm-class |ConcreteAggregationType| :MEXICO (|AnonymousType| |AggregationType|)
"  an anonymous InstantiableType that is an AggregationType whose member-type
  is itself an InstantiableType."
  ((|member-type| :range |InstantiableType| :multiplicity (1 1)
  :documentation
   "  represents data type of its components (members) of the InstantiableAggregationType.")))


(def-mm-class |ConcreteType| :MEXICO (|InstantiableType|)
"  represents any InstantiableType that is not an EntityType.<note>Note:
  See 9.1 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |ConcreteValue| :MEXICO (|Instance|)
"  represents a data item, an Instance that is an item of information that
  has an explicit data representation conveying its meaning."
  ())


(def-mm-class |Constant| :MEXICO (|CommonElement|)
"  a CommonElement denoting a single instance value throughout each of
  its life cycles.<note>Note: 'Constant' is a reserved word in EXPRESS;
  if this metamodel is converted to EXPRESS, this class must be renamed.</note><note>See
  clause 9.4 of ISO 10303-11:2004.</note>"
  ((|actual-value| :range |Instance| :multiplicity (1 1)
  :documentation
   "  represents the value resulting from evaluating the value-expression.
  This value may only be computable for a given population, or it may require
  computational capabilities a given agent does not have.")
   (|data-type| :range |InstantiableType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Constant and the DataType of
  the Instance denoted by the Constant.")
   (|value-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the Expression that specifies the value of the Constant for
  a given lifetime.")))


(def-mm-class |ConstantRef| :MEXICO (|Primary|)
"  a Primary Expression that returns the (current) value of a given Constant.
   The .id attribute refers to an identifier for a Constant defined in, or
  interfaced into, the schema.<note>See 12.7.1 of ISO 10303-11:2004.</note><note>Note:
  A reference to an EXPRESS 'Built-in Constant' is considered to be a Literal,
  not a ConstantRef.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the Reference.")
   (|refers-to| :range |Constant| :multiplicity (1 1)
  :documentation
   "  represents the Constant referred to by a ConstantRef.<note>See 12.7.1
  of ISO 10303-11:2004.</note>")))


(def-mm-class |ControlStatement| :MEXICO (|Statement|)
"  an abstract class representing EXPRESS statements whose action is 'transfer
  of control', i.e., a change in the sequence of execution..  This class
  was introduced primarily to simplify the metamodel diagram."
  ())


(def-mm-class |ControlVariable| :MEXICO (|NamedVariable|)
"  the specification for the control variable, if any, for the Repeat statement.
   The IncrementControl introduces the variable, whose scope is the RepeatStatement.
   It specifies the initial value, a bound-value, and possibly an increment
  value.  "
  ((|bound-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression whose value, taken together with the initial-value, specifies
  the bounds of a set of real numbers.  Iteration of the repeated-body of
  the RepeatStatement terminates when the value of the control-variable lies
  outside that set. ")
   (|increment| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression whose value is added to the value of the control-variable
  at the end of each iteration.<note>When the EXPRESS syntax does not
  specify an increment value, the Expression is a Literal referring to the
  Integer value 1.</note>")
   (|initial-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression that specifies the value to be assigned to the control-variable
  before the first interation.")
   (|namespace| :range |RepeatStatement| :multiplicity (1 1)
  :documentation
   "  the RepeatStatement whose execution is controlled by the IncrementControl.")))


(def-mm-class |DataType| :MEXICO NIL
"  an ExpressionType that represents all the data type notions that can
  be declared for objects and properties in EXPRESS.  Syntactically called
  parameter_type, it includes InstantiableTypes and GeneralizedTypes (which
  represent conformance rules for InstantiableTypes).  It excludes PartialEntityTypes,
  which are only classifiers for intermediate results.<note>See clause
  8 of ISO 10303-11:2004.</note>"
  ((|instances| :range |Instance| :multiplicity (1 -1)
  :documentation
   "  represents the (abstract) relationship between a DataType and its domain
  -- the Instances that satisfy it.<note>The association is not said
  to be navigable in this direction, because individual Instances of a DataType
  are only modeled in special cases.</note>")))


(def-mm-class |DefinedType| :MEXICO (|ConcreteType| |NamedType|)
"  a NamedType representing an EXPRESS defined data type, a type declared
  by a type_declaration.<note>See 8.3.2 and 9.1 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |DerivedAttribute| :MEXICO (|Attribute|)
"  represents an EXPRESS DERIVE attribute = a property whose value can
  be determined from other attributes and relationships of the entity instance.<note>See
  9.2.1.2 of ISO 10303-11:2004.</note>"
  ((|derivation| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Expression that specifies how to determine the value of the DerivedAttribute
  from the values of other Attributes.<note>See 9.2.1.2 of ISO 10303-11:2004.</note>")))


(def-mm-class |DomainConstraint| :MEXICO NIL
"  represents a constraint on the allowable values of an EXPRESS data type.
   This concept does not appear explicitly in the EXPRESS language.  Some
  DomainConstraints are explicit DomainRules (WHERE rules); others, such
  as SizeConstrraints and LengthConstraints, are stated in the EXPRESS syntax
  for the data type.  In this model, a DomainConstraint is always formulated
  as a (boolean) Expression, regardless of the EXPRESS syntax used to specify
  it."
  ((|asserts| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the domain constraint and a Boolean
  expression that can be evaluated to determine if it holds.<note>The
  asserts expression that formulates the DomainConstraint is wholly owned
  by the DomainConstraint.  It is not treated as reusable.</note>")
   (|domain| :range |ParameterType| :multiplicity (1 1)
  :documentation
   "  a dependency -- represents the relationship between the DomainConstraint
  and the data type whose values it constrains")))


(def-mm-class |DomainRole| :MEXICO (|Role|)
"  a role representing the behavior of the entity instances that is designated
  the 'domain' of the relationship"
  ((|domain| :range |EntityType| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the (single) entity data type common to all instances that
  play the Domain Role.  ")
   (|id| :range |ScopedId| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  Represents the 'complete' identifier for the Role.The identifier for
  the DomainRole is derived from the identifier for the InverseAttribute,
  when present, including the Identifier value and the associated EntityType
  identifier.  When there is no InverseAttribute, .id has no proper value,
  but the DomainRole may be identified by the pseudo-identifier: UsedIn.&lt;RangeRole.id&gt;,
  where &lt;RangeRole.id&gt; is the identifier for the RangeRole in the Relationship.")
   (|in-relationship| :range |Relationship| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a Domain Role and the (unique) Relationship
  in which it is defined")
   (|range-view| :range |InverseAttribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a domain-role and the inverse attributes
  of the range entities that model it.Different subtypes of the primary 'range'
  entity data type can define different views of (and constraints on) the
  domain role.  The 'range' entity has an inverse attribute that defines
  the 'domain' role (the role of the other entity).")))


(def-mm-class |DomainRule| :MEXICO (|DomainConstraint| |TypeElement|)
"  represents a DomainConstraint that is stated as an EXPRESS domain rule
  in a WHERE clause in the type_declaration or the entity declaration.  In
  a type_declaration, it is a Boolean expression in terms of SELF that limits
  the allowable values in the domain of the data type.  In an entity_declaration,
  it is a Boolean expression that constrains the values of one or more attributes
  (or other relationships) of the entity data type.<note>Note:  Part
  11 permits the evaluation of a DomainRule which evaluates to indeterminate
  ('?') and requires that to be treated as satisfied.  The most common case
  is the evaluation of an expression involving an OPTIONAL attribute.  Languages
  like OCL and OWL require the possibly indeterminate values to be protected
  by an EXISTS operation,  So translation of the EXPRESS DomainRule may require
  the rule to be prefixed with IF EXISTS(expression) THEN ...</note><note>See
  clauses 9.1 and 9.2.2.2 of ISO 10303-11:2004.</note>"
  ((|domain| :range |NamedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship of the DomainRule to the NamedType that
  is the domain of values to which it applies")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the position of the Domain Rule in the list of rules following
  the WHERE keyword in the entity/type declaration.")))


(def-mm-class |EntityInstance| :MEXICO (|TypedInstance|)
"  a TaggedInstance that represents an EXPRESS entity instance -- an instance
  of an entity data type, a view of an object that incorporates those properties
  and relationships that are significant to some particular purpose(s).The
  EntityInstance is distinct from the EntityValue -- a collection of information
  about the object that represents those properties and relationships.<note>See
  clause 5 of ISO 10303-11:2004.</note>"
  ((|id| :range |EntityName| :multiplicity (1 1)
  :documentation
   "  represents a nominal identifier for an EntityInstance that distinguishes
  it from other EntityInstances. The nature of this identifier is not defined
  in EXPRESS, but it is stated that this identifier is not necessarily constructed
  from any group of modeled attribute values.  Each EntityName is unique
  within a Population, but the actual namespace of an EntityName is not specified
  in Part 11.<note>See clause 5 of ISO 10303-11:2004.</note>")
   (|instance-of| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityInstance and each of the
  EntityType classifiers it satisfies.")
   (|state| :range |EntityValue| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the EntityInstance and the EntityValue
  that describes the current state of the Instance (in terms of its modeled
  properties) at any given time. ")))


(def-mm-class |EntityType| :MEXICO (|NamedType|)
"  a NamedType representing an EXPRESS entity data type, a type declared
  by an entity_declaration.<note>See 9.2 of ISO 10303-11:2004.</note>"
  (;(|attributes| :range |InvertibleAttribute| :multiplicity (1 -1)
  ;:documentation
  ; "  represents the relationship between an EntityType and the declared Attributes
  ;of that EntityType, including those in the entity declaration and those
  ;inherited from supertypes.<note>See 9.2 of ISO 10303-11:2004.</note>")
   (|attributes| :range |Attribute| :multiplicity (1 -1)
;2012   :is-derived-p t
  :documentation
   "  represents the relationship between an EntityType and the declared Attributes
  of that EntityType, including those in the entity declaration and those
  inherited from supertypes.<note>See 9.2 of ISO 10303-11:2004.</note>")
   (|constraint-rules| :range |GlobalRule| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityType and the GlobalRules
  that constrain it.<note>See 9.6 of ISO 10303-11:2004.</note>")
   (|declares| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  the SingleEntityType that is declared in the declaration for the EntityType,
  i.e., the group of Attributes that is named for the EntityType.")
   (|extension| :range |Extent| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityType and its extent (the
  set of corresponding EntityInstances) in a given Population. ")
   (|instances| :range |EntityInstance| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityType (classifier) and the
  EntityInstances that satisfy it.")
   (|isAbstract| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the EXPRESS entity data type is declared ABSTRACT in its orginal
  declaration, either as ABSTRACT entity or as ABSTRACT SUPERTYPE; False
  otherwise.  The entity data type can also/later be declared 'abstract'
  in a SUBTYPE_CONSTRAINT, e.g. in an interfacing Schema, but that is taken
  as a constraint on the usage of the EntityType in that context.<note>See
  9.2.4 and 9.2.5.1 of ISO 10303-11:2004.</note>")
   (|plays-domain-role| :range |DomainRole| :multiplicity (1 -1)
  :is-derived-p t
  :documentation
   "  represents the relationship betwen an entity type and the domain roles
  that its instances play.  For each InvertibleAttribute of the EntityType,
  the EntityType plays a corresponding DomainRole.An EntityInstance is considered
  to play the DomainRole once for each member of an InvertibleAttribute whose
  data type is an AggregationType.")
   (|plays-range-role| :range |RangeRole| :multiplicity (1 -1)
  :is-derived-p t
  :documentation
   "  represents the relationship betwen an entity type and the range roles
  that its instances play.  For each occurrence of the EntityType as the
  attribute-type, or a member of the attribute-type, of an explicit attribute
  (InvertibleAttribute), the EntityType plays the corresponding RangeRole
  (.models-role).")
   (|redeclarations| :range |Redeclaration| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the EntityType and any attribute
  Redeclarations that appear in its declaration.<note>See 9.2.3.4 of
  ISO 10303-11:2004.</note>")
   (|subtype-constraints| :range |SubtypeConstraint| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityType and the SubtypeConstraints
  that involve it.<note>See 9.2.5 of ISO 10303-11:2004.</note>")
   (|subtype-of| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an entity data type to its immediate
  supertypes -- those entity data types from whose common domain the instances
  of the EntityType are drawn.  For compatibility with the interpretation
  of other features of EXPRESS, this relationship extends only to those EntityTypes
  that are 'immediate supertypes', i.e. those explicitly declared in the
  SUBTYPE OF clause for this EntityType.<note>See 9.2.3 of ISO 10303-11:2004.</note>")
   (|unique-rules| :range |UniqueRule| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an EntityType and the local uniqueness
  rules that constrain the values of attributes of that EntityType<note>See
  9.2.2.1 of ISO 10303-11:2004.</note>")
   (|used-in| :range |InvertibleAttribute| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the EntityType and the InvertibleAttributes
  (of other EntityTypes) that establish relationships to it.")))


(def-mm-class |EntityValue| :MEXICO (|PartialEntityValue|)
"  A PartialEntityValue that completely describes an Instance of some EntityType(s)"
  ((|corresponds to| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  represents the EntityType(s) whose complete modeled description comprises
  a set of Attributes that is contained in the EntityValue.  The complete
  modeled description of an EntityType is a set of SingleEntityTypes, and
  the EntityValue contains SingleEntityValues corresponding to each of them.")
   (|describes| :range |EntityInstance| :multiplicity (1 -1)
  :documentation
   "  represents the EntityInstances, if any, whose current state is described
  by the EntityValue.  This direction of the association is only significant
  when the EntityValue is used as the means of identification of a particular
  EntityInstance.")))


(def-mm-class |EnumItemRef| :MEXICO (|Primary|)
"  a Primary Expression that returns an EnumerationItem (value)<note>See
  12.7.1 of ISO 10303-11:2004.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the reference.")
   (|refers-to| :range |EnumerationItem| :multiplicity (1 1)
  :documentation
   "  represents the EnumerationItem value referred to by an EnumItemRef.
   This relationship is modeled as implicit, because it specializes Expression.evaluation<note>See
  12.7.1 of ISO 10303-11:2004.</note>")))


(def-mm-class |EnumerationItem| :MEXICO (|TypeElement| |ConcreteValue| |TypedInstance|)
"  a ConcreteValue representing a named value of an EnumerationType. An
  EnumerationItem is also a TypedInstance, because the corresponding EnumerationType
  has an Identifier.  An EnumerationItem is also a TypeElement, in that the
  scope of its identifier is the EnumerationType.<note>See 8.4.1 of ISO
  10303-11:2004.</note>"
  ((|declared-in| :range |EnumerationType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an EnumerationItem and the EnumerationType
  whose declaration defines the item.")
   (|of-type| :range |EnumerationType| :multiplicity (1 -1)
  ;PODTT :is-derived-p t
  :documentation
   "  represents the relationship between an EnumerationItem and the EnumerationTypes
  of which it is a value.An EnumerationItem is a value of every EnumerationType
  that is related by extension to the type that declares it.  This relationship
  can be derived recursively from the sequence of .base relationships beginning
  with the .declared-in EnumerationType, and from the sequence of .extension
  relationships of that EnumerationType.<note>See 8.4.1 of ISO 10303-11:2004.</note>")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the position of the Enumeration Item in the list of items
  in the type_declaration that defines the EnumerationItem.That is, .position
  relates to the .declared-in EnumerationType.  When the number of values
  of .of-type (the types of which this EnumerationItem is a value) is exactly
  1, the position defines an ordering on the values of the EnumerationType.")))


(def-mm-class |EnumerationType| :MEXICO (|DefinedType|)
"  a DefinedType representing an EXPRESS defined data type whose underlying_type
  is a ENUMERATION data type.<note>See 8.4.1 of ISO 10303-11:2004.</note>"
  ((|base| :range |EnumerationType| :multiplicity (1 1)
  :documentation
   "  represents the relationship of an extended EnumerationType to the EnumerationType
  it is BASED ON.  The domain of the extended type includes all of the values
  of the base type and all the values defined in the extension.<note>See
  8.4.1 of ISO 10303-11:2004.</note>")
   (|declared-items| :range |EnumerationItem| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an EnumerationType to the EnumerationItems
  that are declared in its type_declaration.For extended enumeration types,
  this is distinct from the .values relationship, which captures all of the
  valid values of the type.<note>See 8.4.1 of ISO 10303-11:2004.</note>")
   (|extension| :range |EnumerationType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an EXTENSIBLE EnumerationType to the
  EnumerationTypes that are BASED ON it. Each extension type may add additional
  values to the domain, and these are considered to be values of the base
  type for all uses within the schema containing the extension.<note>See
  8.4.1 of ISO 10303-11:2004.</note>")
   (|isExtensible| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the EnumerationType can have additional values in a schema that
  interfaces it; False if not.In the context schema for a population,
  the final set of possible values is known.  But the set given in the defining
  schema may be incomplete and be extended by other EnumerationTypes for
  which this is the base.<note>See 8.4.1 of ISO 10303-11:2004.</note>")
   (|values| :range |EnumerationItem| :multiplicity (1 -1)
  ; PODTT :is-derived-p t
  :documentation
   "  represents the relationship between an EnumerationType and the EnumerationItems
  that are valid values of the type.  An EnumerationItem is a value of every
  EnumerationType that is related by extension to the type that declares
  it.  This relationship can be derived recursively as the union of the values
  of the .declared-items attribute for the EnumerationType, for each EnumerationType
  in the sequence of .base relationships from the EnumerationType, and from
  all the extensions of the EnumerationType.<note>See clause 8.4.1 of
  ISO 10303-11:2004.</note>")))


(def-mm-class |EscapeStatement| :MEXICO (|ControlStatement|)
"  Represents an EXPRESS ESCAPE statement.An ESCAPE statement is always
  contained within the body of a RepeatStatement.Execution of an ESCAPE statement
  results in terminating the repetitiion of the repeated-body and continuing
  the control flow with the statement following the RepeatStatement,.<note>See
  Clause 13.11 of ISO 10303-11:2004.</note>"
  ((|in-block| :range |StatementBlock| :multiplicity (1 1))))


(def-mm-class |ExplicitAttribute| :MEXICO (|Attribute|)
"  represents an EXPRESS 'explicit' attribute, a model of a property of
  an entity instance that is not, in general, derived from other properties
  of that instance or other entity instances.<note>See 9.2.1.1 of ISO
  10303-11:2004.</note>"
  ((|isOptional| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the entity instance is permitted to have no specified value
  for this attribute; False if a value for this attribute is required.<note>See
  9.2.1.1 of ISO 10303-11:2004.</note>")
   (|of-entity| :range |SingleEntityType| :multiplicity (1 1))))


(def-mm-class |Expression| :MEXICO NIL
"  In general, an Expression is the representation of an Instance by a
  set of computational operations that will produce that Instance when performed
  in the context in which the Expression occurs.  An Expression is always
  evaluated in a context which determines the assignment of Instances to
  model elements (e.g., Variables, Attributes, etc.) that appear in the Expression.
   The Instance produced by the same Expression may vary from context to
  context.  The Instance produced is said to be the value, or the evaluation,
  of the Expression. <note>The equivalent-expression that formulates
  the SubtypeConstraint is wholly owned by the SubtypeConstraint.  It is
  not treated as reusable.</note>"
  ((|data-type| :range |DataType| :multiplicity (1 1)
  :documentation
   "  represents the DataType of the evaluation of the Expression.  While
  the result of an Expression always has a DataType, it is not always possible
  to determine at model-analysis time what that data type is.  And in many
  cases, even when it is known, it is not necessary to specify it.")
   (|evaluation| :range |Instance| :multiplicity (1 1)
  :documentation
   "  represents the Instance (value) that results from evaluating the Expression.Since
  the same Expression can be evaluated in more than one 'situation', i.e.
  different values for the operands, the result in each situation may be
  a different Instance.  The evaluation is included in a model, however,
  only when it is 'constant' and can be computed at 'compile time'.")
   (|interpretation-context| :range |Scope| :multiplicity (1 1)
  :documentation
   "  An Expression is always evaluated in a context which determines the
  assignment of specific instances of model elements to symbols (e.g. Variables,
  Attributes, etc.).  When the Expression is represented by text only, this
  relationship is usually required, but in many cases it may be implicit.
   When the Expression is represented by the detailed model elements in the
  Expressions Package, the interpretation of the Text has been done, and
  this association is purely documentary and not required.  Certain permissible
  EXPRESS constructs, however, only permit interpretation of certain keyword
  symbols to Operations in the presence of actual operand Instances.")
   (|text| :range |ExpressText| :multiplicity (1 1)
  :documentation
   "  represents the actual EXPRESS language text denoting the Expression.
  The text is required if the Expressions Package is not implemented.  It
  is optional in most cases when the Expressions Package is implemented.
   Certain forms of Expression (in the Expressions Package) specialize the
  text attribute.")))


(def-mm-class |Extent| :MEXICO (|SETValue|)
"  the collection of all Instances in a given Population that satisfy the
  specified EntityType.That is, Extent is the SetValue that is the intersection
  of EntityType.instances and  Population.composition<note>See 9.6 of
  ISO 10303-11:2004.</note>"
  ((|content| :range |EntityInstance| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an Extent (within a Population)
  and the EntityInstances it contains.Extent is a SetValue and Extent.content
  is just the relationship between that SetValue and its members.")
   (|for-type| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an Extent and the EntityType to
  which it corresponds.<note>See 9.6 of ISO 10303-11:2004.</note>")
   (|id| :range |ScopedId| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  the identifier for the EntityType, used as a name for the Extent within
  the body of the Rule.<note>See 9.6 of ISO 10303-11:2004.</note>")
   (|within-population| :range |Population| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an Extent and the Population from
  which the Set of instances is drawn.<note>See 9.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |ExtentRef| :MEXICO (|Primary|)
"  a Primary Expression denoting the extent of a NamedType (almost always
  an entity data type), that is, the set of instances of that data type that
  appear in the population. This type of Primary is only permitted in an
  Expression that states a Rule.<note>See 9.6 of ISO 10303-11:2004.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the reference.")
   (|refers-to| :range |NamedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Extent Reference and the NamedType
  to which the .id value refers.  The value returned is the Extent of that
  NamedType within the (current) Population.")))


(def-mm-class |Function| :MEXICO (|Algorithm|)
"  an Algorithm that returns a single Instance and can appear in an Expression.<note>Note:
  'Function' is a reserved word in EXPRESS; if this metamodel is converted
  to EXPRESS, this class must be renamed.</note><note>See 9.5.1 of ISO 10303-11:2004.</note>"
  ((|result| :range |FunctionResult| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a Function and its FunctionResult.<note>See
  9.5.1 of ISO 10303-11:2004.</note>")))


(def-mm-class |FunctionCall| :MEXICO (|Expression|)
"  an Expression that represents the instance resulting from the invocation
  of a Function with zero or more Expression operands called &quot;actual
  parameters&quot;.<note>See 12.8 of ISO 10303-11:2004.</note>"
  ((|actual-parameters| :range |ActualParameter| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a FunctionCall and the specifications
  for the values of its actual parameters.")
   (|invokes-function| :range |Function| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the FunctionCall and the formal
  definition of the Function invoked.<note>See 12.8 of ISO 10303-11:2004.</note>")
   (|returns-result| :range |FunctionResult| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the relationship between the FunctionCall and the formal
  definition of the FunctionResult, which describes the instance that results
  from the FunctionCall.<note>See 12.8 of ISO 10303-11:2004.</note>")))


(def-mm-class |FunctionResult| :MEXICO (|Variable|)
"  the formal parameter representing the result Instance that is returned
  by the invocation of a Function.  Within the body of the Function, the
  FunctionResult is a Variable that is denoted by the Algorithm identifier.
   Upon termination of the execution of the function-body, the (current)
  value of that Variable is returned.<note>See 9.5.1 of ISO 10303-11:2004.</note>"
  ((|namespace| :range |Function| :multiplicity (1 1)
  :documentation
   "  the Function that is the AlgorithmScope in which the Function name refers
  to the FunctionResult.")))


(def-mm-class |GeneralARRAYType| :MEXICO (|GeneralAggregationType|)
"  represents a GeneralAggregationType whose structure is an ARRAY.  The
  hi-index and lo-index values of a conforming ARRAYInstance are required
  to be equal to the values given for the GeneralARRAYType.When the
  GeneralARRAYType is the data type of an abstract attribute (see 1.10.3.2),
  the datatype of every conforming redeclaration is required to be an ARRAYType
  or a GeneralARRAYType whose hi-index and lo-index values are equal to the
  values given for the GeneralARRAYType.  In addition, the .isOptional property
  of the redeclaration shall be as specified below.<note>See 9.5.3.5
  of ISO 10303-11:2004.</note>"
  ((|hi-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  The hi-index value of a conforming ARRAY data type is required to be
  equal to the hi-index value, if any, for the GeneralARRAYType.<note>See
  9.5.3.5 of ISO 10303-11:2004.</note>")
   (|isOptional| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  When isOptional is True, any conforming ARRAYInstance is permitted to
  have members whose value is indeterminate ('?').  When isOptional is False,
  no member of a conforming ARRAYInstance is permitted to have an unspecified
  value. If isOptional is True for an abstract attribute, the member
  type of any attribute that redeclares the abstract attribute may be declared
  to be OPTIONAL; if False,  the member type of an attribute that redeclares
  the abstract attribute shall not be declared to be OPTIONAL. <note>See
  9.5.3.5 of ISO 10303-11:2004.</note>")
   (|lo-index| :range |ArrayBound| :multiplicity (1 1)
  :documentation
   "  The lo-index value of a conforming ARRAY data type is required to be
  equal to the lo-index value, if any, for the GeneralARRAYType.<note>See
  9.5.3.5 of ISO 10303-11:2004.</note>")))


(def-mm-class |GeneralAggregationType| :MEXICO (|GeneralizedType| |AggregationType|)
"  represents a GeneralizedType whose instances are AggregateValues with
  a specific structure (ARRAY, BAG, LIST or SET), but whose member-types
  are specializations of some specified GeneralizedType.  That is, a GeneralAggregationType
  is an aggregation data type whose member-type is specified to be a GeneralizedType;
  while an (Instantiable) AggregationType is an aggregation data type whose
  member-type is specified to be an InstantiableType. Any instance
  of a GeneralAggregationType is required to be an AggregateValue that has
  the specified structure and has members that are instances of some InstantiableType
  that conforms to the specified member-type.  In addition,the instance must
  satisfy any DomainConstraints associated with the GeneralAggregationType.<note>See
  9.5.3.5 of ISO 10303-11:2004.</note>"
  ((|member-type| :range |GeneralizedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a GeneralAggregationType and the
  conformance specification for the member-type.<note>See 9.5.3.5 of
  ISO 10303-11:2004.</note>")))


(def-mm-class |GeneralBAGType| :MEXICO (|GeneralAggregationType|)
"  represents a GeneralAggregationType whose structure is a BAG.When
  the GeneralBAGType is the data type of an abstract attribute (see 1.10.3.2),
  the datatype of every conforming redeclaration is required to be a BAGType
  or a GeneralBAGType that includes or refines any DomainConstraint associated
  with the GeneralBAGType.<note>See 9.5.3.5 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |GeneralLISTType| :MEXICO (|GeneralAggregationType|)
"  represents a GeneralAggregationType whose structure is a LIST.When
  the GeneralLISTType is the data type of an abstract attribute (see 1.10.3.2),
  the datatype of every conforming redeclaration is required to be a LISTType
  or a GeneralLISTType that includes or refines any DomainConstraint associated
  with the GeneralLISTType.<note>See 9.5.3.5 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |GeneralSETType| :MEXICO (|GeneralAggregationType|)
"  represents a GeneralAggregationType whose structure is a SET.When
  the GeneralSETType is the data type of an abstract attribute (see 1.10.3.2),
  the datatype of every conforming redeclaration is required to be a SETType
  or a GeneralSETType that includes or refines any DomainConstraint associated
  with the GeneralSETType.<note>See 9.5.3.5 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |GeneralizedType| :MEXICO (|ParameterType|)
"  an abstract classifier, representing those EXPRESS data types that are
  'abstract', in the sense that every actual instance is an instance of some
  InstantiableType(s).These types are only permitted as the data type of
  formal parameters and the data type of 'abstract' Attributes of ABSTRACT
  EntityTypes.  GeneralizedType is a proper subclass of ParameterType that
  is disjoint with InstantiableType.<note>The syntactic occurrences of
  EXPRESS generalized_type do not always denote GeneralizedTypes per se.
   In particular, a generalized_type that appears with a type_label may denote
  an ActualType or a constraint.When used as the type of a LocalVariable
  or FunctionResult, it denotes an ActualType (q.v.).When used as the type
  of a Parameter, it may be a GenericElement that defines a reference to
  the data type of the corresponding actual parameter (in addition to being
  a GeneralizedType specification for the allowable data types of the actual
  parameter), or it may represent a constraint on the data type of the corresponding
  actual parameter that relates to the data type of another actual parameter.See
  9.5.3.4 of ISO 10303-11:2004.</note>"
  ((|occurs-in| :range |ParameterType| :multiplicity (1 -1)
  :documentation
   "  relates the GeneralizedType to the ParameterType in which it occurs.
   A GeneralizedType can be a ParameterType or be a component of another
  GeneralizedType.")))


(def-mm-class |GenericAggregate| :MEXICO (|LISTValue|)
"  An AggregateValue representing the output of an AggregateInitializer.
   It is interpreted as a LIST value whose member-type is GENERIC, but actually
  constrained to the common DataType of all the Expressions in the Initializer.It
  can be coerced to an ARRAY, BAG, SET or LIST value of the appropriate member-type,
  according to the context of its use.<note>Note:  Certain GenericAggregate
  values have a syntactic parse as a LIST of instances, but no clear semantics
  as to data type;  this is a defect in Part 11.</note><note>See 12.9 of
  ISO 10303-11:2004.</note>"
  ())


(def-mm-class |GenericElement| :MEXICO (|LocalElement|)
"  a LocalElement representing a component of the type description for
  a formal Parameter that refers to the corresponding type component of the
  corresponding actual parameter.  The GenericElement is denoted by a type_label
  (the .label attribute) that is unique within the scope of the Algorithm.
   The first occurrence of the type_label in the formal parameter list defines
  the GenericElement.  Any later occurrence of the same type_label in the
  formal parameter list (even in the same Parameter) specifies an ActualStructureConstraint
  or an ActualTypeConstraint that is based on the GenericElement."
  ((|label| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  represents the 'type_label' on the GENERIC, GENERIC_ENTITY or AGGREGATE
  type component, treated as a ScopedId whose namespace is the Algorithm
  in which it is defined.")
   (|namespace| :range |Algorithm| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  the Algorithm that is the namespace of the ScopedId that is the label.
   This relationship is derived -- the namespace of a GenericElement is the
  same as the namespace of its .source Parameter.")
   (|occurs-in| :range |ParameterType| :multiplicity (1 1)
  :is-derived-p t )
   (|source| :range |Parameter| :multiplicity (1 1)
  :documentation
   "  the Parameter whose formal parameter type is or includes the GenericElement
  and defines its label.  The first (by .position) Parameter whose formal
  parameter type contains the label defines the label.  The corresponding
  component of the data type of the actual parameter is used to define the
  actual data type or structure that corresponds to the GenericElement.<note>See
  9.5.3.4 of ISO 10303-11:2004.</note>")))


(def-mm-class |GenericType| :MEXICO (|GeneralizedType|)
"  represents the EXPRESS generalized types GENERIC and GENERIC_ENTITY,
  and some labelled instances of them.  Every data type is a specialization
  of the GenericType GENERIC, and every Instance is an Instance of GENERIC.
   Every entity data type is a specialization of the GenericType GENERIC_ENTITY.Every
  EntityInstance is an instance of GENERIC_ENTITY and every instance of GENERIC_ENTITY
  is an EntityInstance.<note>See 9.5.3.2 and 9.5.3.3 of ISO 10303-11:2004.</note>"
  ((|constraint| :range |ActualTypeConstraint| :multiplicity (1 1)
  :documentation
   "  the ActualTypeConstraint, if any, that applies to this component of
  the GeneralizedType specification.<note>Only an GenericType that appears
  in the specification of the data type of a Parameter can have an ActualTypeConstraint.The
  GenericType has an ActualTypeConstraint only if it has a syntactic type_label
  and does not itself define that type_label.See 9.5.3.4 of ISO 10303-11:2004.</note>")
   (|isEntity| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the corresponding data type is required to be an Entity data
  type; False otherwise.  .isEntity is True if the EXPRESS keyword was GENERIC_ENTITY.
  .isEntity is False if the EXPRESS keyword was GENERIC. ")))


(def-mm-class |GlobalRule| :MEXICO (|SchemaElement| |AlgorithmScope|)
"  a SchemaElement denoting a collection of NamedRules for the interaction
  of the Extents of one or more EntityTypes.  It corresponds to the RULE
  declaration in EXPRESS.  Every GlobalRule is also an AlgorithmScope and
  may define CommonElements and Variables.<note>See 9.6 of ISO 10303-11:2004.</note>"
  ((|constrained-extents| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  the EntityTypes whose Extents are constrained by the GlobalRule<note>See
  9.6 of ISO 10303-11:2004.</note>")
   (|contains-rules| :range |NamedRule| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the GlobalRule (container) and the
  NamedRules it contains.Since the GlobalRule also constitutes the scope
  of the id (if any) for the NamedRule, this relationship is treated as a
  specialization of the Scope.named-elements relationship.")
   (|supporting-body| :range |Statement| :multiplicity (1 1)
  :documentation
   "  represents the Statement, usually a StatementBlock, that provides values
  for LocalVariables used in the NamedRules that are contained in the GlobalRule.
   The supporting-body of the GlobalRule can only appear if one or more LocalVariables
  are introduced for use in the NamedRules, and even then, the supporting-body
  is not required if the value of each LocalVariable is completely defined
  by an initializing expression.If an implementation of the metamodel
  does not support the Statements compliance point, the supporting body should
  be captured as text when it is present.<note>See 9.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |GroupCell| :MEXICO (|VARExpression|)
"  A VARExpression whose referent is the group of objects/slots for the
  ExplicitAttributes that constitute a SingleEntityType in an object that
  holds an EntityValue. The .referent attribute of the GroupCell identifies
  the SingleEntityType that characterizes the attribute group.  The referent
  of the .base-entity VARExpression must be an object that holds an EntityValue
  that has 'slots' for the ExplicitAttributes constituting that SingleEntityType.
   Those slots in the referent of the base-entity constitute the referent
  of the GroupCell VARExpression. <note.> An EntityInstance in the Population
  is considered to be an object that holds an EntityValue.  And therefore,
  an EntityInstance can be the referent of the base-entity.  But it is not
  possible to change the value of an Attribute of an EntityInstance in the
  Population.</note>  <note>An entity-valued object -- a Variable, Attribute,
  or aggregation member whose data type is an EntityType (or a SelectType
  whose select-list contains EntityTypes) -- may contain EntityInstances
  from the Population, or contain EntityValues that correspond to the EntityType,
  without reference to Instances in the Population.  When the base-entity
  of an GroupCell is an entity-valued object, it is not always clear whether
  it contains an EntityInstance, which is then the referent, or an EntityValue,
  which makes the entity-valued object the referent.</note>"
  ((|base-entity| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the Expression that identifies the object that contains the EntityInstance
  or EntityValue that contains a collection of ExplicitAttribute objects
  representing the SingleEntityType to which the GroupObject refers.")
   (|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the lexical text of the identifier for the SingleEntityType, subsets
  VARExpression.text")
   (|referent| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  the SingleEntityType denoting the attribute group that is the referent
  of the GroupCell.")))


(def-mm-class |GroupRef| :MEXICO (|Selector|)
"  a Selector that returns a PartialEntityValue consisting of the values
  of the Attributes of a given entity instance that constitute a given SingleEntityType.<note>See
  12.7.4 of ISO 10303-11:2004.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the reference.")
   (|refers-to| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the GroupReference and the SingleEntityType
  (group of Attributes) to which it refers.")))


(def-mm-class |IfStatement| :MEXICO (|Statement|)
"  represents an EXPRESS IF...THEN...ELSE statement.<note>See Clause
  13.7 of ISO 10303-11:2004.</note>"
  ((|else-actions| :range |Statement| :multiplicity (1 1)
  :documentation
   "  the Statement (or StatementBlock) specifying the actions to be taken
  when the condition is False.")
   (|if-condition| :range |Expression| :multiplicity (1 1)
  :documentation
   "  an Expression that defines the condition used to determine whether to
  perform the 'then-actions' or the 'else-actions'.<note>The if-condition
  is wholly owned by the IfStatement.  It is not treated as reusable.</note>")
   (|then-actions| :range |Statement| :multiplicity (1 1)
  :documentation
   "  the Statement (or StatementBlock) specifying the actions to be taken
  when the condition is true.")))


(def-mm-class |InParameter| :MEXICO (|Variable| |Parameter|)
"  a formal parameter to a Procedure or Function to which the ActualParameter
  is passed 'by value'.  During an invocation of the Algorithm, the InParameter
  is a Variable that is initially set to the value of the corresponding ActualParameter,
   and its variable-type is the data type of the ActualParameter.  The value
  of an InParameter can be changed during the execution of the Algorithm.
   The value of the corresponding actual parameter does not change.<note>An
  InParameter has a formal-parameter-type, which is the type specification
  to which the oorresponding ActualParameters are required to conform, and
  a variable-type, which is the type specification for the Variable created
  to hold the value during invocation of the Algorithm.</note><note>See 9.5.3
  of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |Indeterminate| :MEXICO (|Instance|)
"  Represents the class containing only the 'indeterminate' value (?),
  which represents 'no value' or no meaningful value.  This value arises
  primarily as the evaluation of an Expression in which one of the operations
  'fails'.Indeterminate is not clearly an instance of any data type, or of
  all data types.<note>See 14.2 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |IndeterminateRef| :MEXICO (|Primary|)
"  a Primary Expression consisting of the symbol ('?') that denotes the
  Indeterminate value.<note>See 14.2 of ISO 10303-11:2004.</note>"
  ((|refers-to| :range |Indeterminate| :multiplicity (1 1)
  :documentation
   "  represents the fact that an IndeterminateRef (a literal '?') refers
  to the Indeterminate value.   This relationship is modeled as implicit,
  because it specializes Expression.evaluation")))


(def-mm-class |IndexOperation| :MEXICO (|Expression|)
"  an Expression that returns a value 'extracted from' a given base value."
  ((|base-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the base value from which the result value is to be extracted.
   For an AggregateIndex, the base-value Expression must evaluate to an AggregateValue.
   For a BinaryIndex, the base-value Expression must evaluate to a BINARY
  value.  For a StringIndex, the base-value Expression must evaluate to a
  STRING Value.")))


(def-mm-class |Instance| :MEXICO NIL
"  represents any real or conceptual object, information unit or data item."
  ((|of-type| :range |DataType| :multiplicity (1 -1)
  :documentation
   "  Represents the relationship between an Instance and the DataTypes of
  which it is a valid instance.  This is the abstract relationship -- every
  subclass of Instance has the of-type relationship to a specific class of
  DataTypes.")))


(def-mm-class |InstantiableType| :MEXICO (|VariableType|)
"  an abstract classifier, encompassing all the data type notions that
  characterize objects and properties in EXPRESS.  InstantiableType is a
  proper subtype of DataType (which includes classifiers that represent conformance
  rules for InstantiableTypes).<note>See 8.6.1 of ISO 10303-11:2004.</note>"
  ((|fundamental-type| :range |InstantiableType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the DefinedType and the data type
  used to represent its values.  The fundamental-type of a DefinedType is
  the fundamental-type of its underlying-type; the fundamental-type of any
  other InstantiableType is the type itself. <note>See 13.3.2 of ISO
  10303-11:2004.</note>")))


(def-mm-class |IntegerValue| :MEXICO (|RealValue|)
"  a SimpleValue,  a value of the EXPRESS data type INTEGER: any mathematical
  integer value."
  ())


(def-mm-class |InterfacedElement| :MEXICO NIL
"  represents the EXPRESS 'interface' relationship (USE, REFERENCE) between
  an interfacing Schema and one SchemaElement that is defined in some other
  Schema.  It can be viewed as a 'role' of the .refers-to SchemaElement in
  the interfacing schema.  Because a given schema can only inteface a given
  SchemaElement once, the combination (.interfacing-schema, .refers-to) uniquely
  identifies an InterfacedElement relationship.<note>See clause 11 of
  ISO 10303-11:2004.</note>"
  ((|interfacedId| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  the new Identifier for the .refers-to SchemaElement in the interfacing
  schema.<note>See clause 11 of ISO 10303-11:2004.</note>")
   (|interfacing-schema| :range |Schema| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the InterfacedElement and the Schema
  in which it appears.  If the InterfacedElement renames the .refers-to SchemaElement,
  the interfacing-schema is the namespace for the .interfacedId.")
   (|isUSE| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the interfacing statement is USE; False otherwise.  isUSE can
  only be True if the interfaced (.refers-to) SchemaElement is a NamedType.
   The interpretation of USE is that Instances of the interfaced NamedType
  are permitted to be 'independent entities' in a Population governed by
  the interfacing Schema.  When the interfacing statement is REFERENCE, Instances
  of that NamedType exist only to fulfill some Attribute of an entity that
  is ultimately dependent on an 'independent entity'.<note>See clause
  11.1 of ISO 10303-11:2004.</note>")
   (|refers-to| :range |SchemaElement| :multiplicity (1 1)
  :documentation
   "  represents the SchemaElement being imported (interfaced) into the interfacing
  schema as the InterfacedElement.")))


(def-mm-class |InverseAttribute| :MEXICO (|Attribute|)
"  represents an EXPRESS INVERSE attribute = a property of each instance
  of this entity data type that represents a relationship between it and
  instances of some other entity data type, created by an InvertibleAttribute
  of that entity data type.<note>See 9.2.1.3 of ISO 10303-11:2004.</note>"
  ((|explicit| :range |InvertibleAttribute| :multiplicity (1 1)
  :documentation
   "  the explicit attribute (InvertibleAttribute) of the associated entity
  data type that models the Relationship from which the inverse attribute
  is derived.<note>The attribute-type of the InverseAttribute may be
  a subtype of the entity data type that defines the InvertibleAttribute.
  </note><note>See 9.2.1.3 of ISO 10303-11:2004.</note>")
   (|isUnique| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the designated relationship between this instance and any given
  instance can occur at most once; False if it can occur more than once.
   (True if the INVERSE attribute is described as a SET; False if it is described
  as a BAG.)  <note>See 9.2.1.3 of ISO 10303-11:2004.</note>")
   (|models-role| :range |DomainRole| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an Inverse Attribute and the domain-role
  it refers to.  By extension (models-role.in-relationship), it models the
  relationship of the inverse attribute to the Relationship it denotes.")))


(def-mm-class |InvertibleAttribute| :MEXICO (|ExplicitAttribute|)
"  An ExplicitAttribute whose attribute type is one of:<br>- an EntityType<br>-
  a Select-type whose select-list consists of EntityTypes<br>- an AggregationType
  whose member-type is either of the aboveAn InvertibleAttribute models
  a Relationship between two EntityTypes  the EntityType that declares the
  InvertibleAttribute, and the EntityType that appears in its .attribute-type.An
  InvertibleAttribute whose attribute-type (or its member-type) is a SelectType
  defines one Relationship for each EntityType in the select-list.  <note>See
  ISO 10303-11.2:2004 clause 9.2.1.3</note>"
  ((|creates-relationship| :range |Relationship| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the relationship between an InvertibleAttribute and the Relatiionship
  between EntityTypes that it models.")
   (|inverse| :range |InverseAttribute| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an explicit attribute denoting a Relationship
  to the inverse attribute of the range entity data type that models the
  same Relationship.  While the inverse is conceptually unique, EXPRESS allows
  it to be declared differently in different subtypes of the original range
  entity.<note>See 9.2.1.3 of ISO 10303-11:2004.</note>")
   (|models-role| :range |RangeRole| :multiplicity (1 1)
  :documentation
   "  represents the relationship between an Invertible Attribute and the
  RangeRole it defines.  <note>An explicit attribute defines a RangeRole
  (and thus a Relationship) if and only if it is an InvertibleAttribute.</note>")
   (|owning-entity| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between an Attribute and the 'owner' EntityTypes
  of which it is an attribute, including those that inherit it.<note>See
  9.2 of ISO 10303-11:2004.</note>")
   (|range-type| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  models the relationship between the InvertibleAttribute and the EntityTypes
  that are, or are members of, its attribute-type.  These EntityTypes are
  the 'range' of the Relationship with the 'referencing' entity that is created
  by the InvertibleAttribute.")))


(def-mm-class |LISTType| :MEXICO (|ConcreteAggregationType|)
"  an AggregationType representing all EXPRESS LIST data types<note>See
  8.2.2 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |LISTValue| :MEXICO (|AggregateValue|)
"  an AggregateValue, representing a value of an EXPRESS LIST data type:
  a sequence of instances of the member-type of the LIST."
  ((|member-slot| :range |ListMember| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a ListValue and each of its distinct
  slots for member values.  Each member-slot represents a position in the
  ListValue.")
   (|of-type| :range |LISTType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the LISTValue and the LISTTypes
  of which it is an instance.")))


(def-mm-class |LengthConstraint| :MEXICO (|DomainConstraint|)
"  represents any maximum-length or fixed-length constraint on the length
  of the values of a STRING or BINARY type.  A LengthConstraint is a DomainConstraint,
  considered to have an equivalent Boolean expression using the built-in
  Length() function.<note>See 8.1.6 and 8.1.7 of ISO 10303-11:2004.</note>"
  ((|isFixed| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if all values of the SimpleType are required to be of the same
  length; False if the constraint specifies only the maximum length of the
  values.<note>See 8.1.6 and 8.1.8 of ISO 10303-11:2004.</note>")
   (|maxLength| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents a constant value specifying the required maximum/fixed length
  of the STRING or BINARY value.  This attribute is present when the constraint
  expression is a 'constant'.<note>See 8.1.6 and 8.1.9 of ISO 10303-11:2004.</note>")))


(def-mm-class |ListMember| :MEXICO NIL
"  represents one position in a ListValue and the instance of the member-type
  in that position."
  ((|member-value| :range |Instance| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a position in a LISTValue (represented
  by a ListMember) and the Instance that appears in that position.")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  the ordinal identifier for the position in the sequence.")))


(def-mm-class |Literal| :MEXICO (|Primary|)
"  a Primary Expression consisting of a symbol that denotes a specific
  value of a SimpleType.  The .text attribute of Expression is the representation
  of the value.<note>See 7.5 of ISO 10303-11:2004.</note>"
  ((|refers-to| :range |SimpleValue| :multiplicity (1 1)
  :documentation
   "  represents the SimpleValue to which the Literal refers. Every Literal
  refers to a SimpleValue in all cases; making it a SpecializedValue requires
  a (implicit) Coercion. This relationship is modeled as implicit, because
  it specializes Expression.evaluation.<note>See 7.5 of ISO 10303-11:2004.</note>")))


(def-mm-class |LocalElement| :MEXICO (|NamedElement|)
"  An abstract class, representing NamedElements whose scope is a LocalScope.
   No LocalElement is defined in the Core package."
  ((|namespace| :range |LocalScope| :multiplicity (1 1)
  :documentation
   "  the Scope in which the LocalElement is defined.  Unlike SchemaElements,
  a LocalElement is instantiated only in the context of a particular 'use'
  or 'invocation' of the Scope in which it is defined.  As a consequence,
  a LocalElement can be instantiated more than once in interpreting a Population
  under a given Schema, and each such instantiation has a 'lifetime' corresponding
  to that use/invocation")))


(def-mm-class |LocalScope| :MEXICO (|Scope|)
"  A Scope that is neither a Schema nor a NamedType.  Terms defined in
  a LocalScope are not visible at the Schema level.<note>See Clause 10
  of ISO 10303-11:2004.</note>"
  ((|local-elements| :range |LocalElement| :multiplicity (1 -1)
  :documentation
   "  the LocalElements that are defined in the LocalScope. (A LocalScope
  that is an AlgorithmScope may also be the scope of CommonElements.)<note>See
  Clause 10.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |LocalVariable| :MEXICO (|Variable|)
"  a Variable that is declared as LOCAL to an Algorithm or GlobalRule and
  given an Identifier, and possibly an initial value, in the declaration.
   A FunctionResult is a special case that is implicitly declared to be a
  LocalVariable in the FUNCTION declaration.<note>See 9.5.4 of ISO 10303-11:2004.</note>"
  ((|initial-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Variable and the Expression
  that specifies its initial-value on entry to the FunctionBody, which may
  be the body of an Algorithm or a GlobalRule")
   (|namespace| :range |AlgorithmScope| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the LocalVariable and the AlgorithmScope
  in which it is defined.This is a refinement of the NamedElement.namespace
  relationship.The lifetime of a LocalVariable is exactly equal to the lifetime
  of the algorithm invocation or the GlobalRule evaluation that has the AlgorithmScope.")))


(def-mm-class |LogicType| :MEXICO (|SimpleType|)
"  a SimpleType representing the EXPRESS data types BOOLEAN and LOGICAL,
  which are the only instances of LOGICALType.<note>See 8.1.4 of ISO
  10303-11:2004.</note>"
  ())


(def-mm-class |LogicalValue| :MEXICO (|SimpleValue|)
"  a SimpleValue,  a value of the EXPRESS data type LOGICAL: TRUE, UNKNOWN,
  FALSE."
  ())


(def-mm-class |MemberBinding| :MEXICO NIL
"  represents the placement of a member value in a particular position
  in the GenericAggregate value resulting from the aggregate initializer.
   Unless the member value has a repetition count, the member binding associates
  the .member-value with one .to-slot ListMember in the GenericAggregate.
   If the member value has a repetition count (that is not a literal '1'),
  the MemberBinding associates the .member-value with one or more consecutive
  ListMembers in the GenericAggregate.  If the member value has a repetition
  count that cannot be evaluated without a given population (i.e. at 'compile
  time'), the relationship between the MemberBinding and ListMembers is not
  specified.  When the AggregateInitializer contains any MemberBinding with
  such a repetition, the relationship between subsequent MemberBindings and
  ListMembers cannot be determined without a given population.<note>See
  12.9 of ISO 10303-11:2004.</note>"
  ((|member-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the member value to be assigned to the MemberBinding position
  in the aggregate value, as the result of the Expression.<note>See 12.9
  of ISO 10303-11:2004.</note>")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the ordinal position of the MemberBinding specification in
  the AggregateInitializer.  When no MemberBinding in the AggregateInitializer
  has a represented .repetition value, MemberBinding.position and .to-slot.position
  will coincide.  Otherwise, the relationship between the two .position values
  will depend on the .repetition values, and may not be determinable without
  a given Population. ")
   (|repetition| :range |RepeatCount| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the MemberBinding and an associated
  RepeatCount, if any.  If the repetition count for the .member-value is
  implicitly 1, or explicitly a literal '1', this relationship shall not
  appear.  In all other cases, this relationship shall appear.")
   (|to-slot| :range |ListMember| :multiplicity (1 -1)
  :documentation
   "  represents the slot in the GenericAggregate value to which the MemberBinding
  assigns the member-value.  ListMember.position is used to identify the
  slot.A MemberBinding with a repetition count can assign the same value
  to more than one slot.Each time the AggregateInitializer (expression) is
  evaluated, the resulting GenericAggregate can be different, and the ListMember
  is a part of that result.  If the (entire) AggregateInitializer expression
  can be evaluated without regard to any actual population ('compile time'),
  this relationship and the ListMember shall be present, but not otherwise.<note>See
  12.9 of ISO 10303-11:2004.</note>")))


(def-mm-class |MemberCell| :MEXICO (|VARExpression|)
"  A VARExpression that represents a reference to a member (object) of an
  object whose datatype is an aggregation data type. The aggregate object
  is the referent of the .base-aggregate VARExpression. The referent of the
  MemberCell VARExpression is the member object that is designated by the
  index or position value that is the result of the .index-value Expression."
  ((|base-aggregate| :range |VARExpression| :multiplicity (1 1)
  :documentation
   "  the Expression that identifies the aggregate object in which the referenced
  member object appears.")
   (|index-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the index or position value used to identify the member object within
  the aggregate object.")))


(def-mm-class |MultiLeafInstance| :MEXICO (|EntityInstance|)
"  A (complex) EntityInstance that is a valid instance of more than one
  EntityType and whose state includes more SingleEntityValues than are declared
  for, or inherited by, any named EntityType defined in the governing Schema.The
  subtype/supertype graph corresponding to such an EntityInstance has multiple
  'leaf' nodes.<note>This concept appears in Part 11 only in 3.3.12,
  but it appears in ISO 10303-21:2002 as an 'uncharacterized instance' whose
  representation requires the 'external mapping'.</note>"
  ())


(def-mm-class |NamedElement| :MEXICO NIL
"  An abstract class representing a principal modeling concept of the EXPRESS
  language: an object that is defined in a model, has a notion of 'lifetime',
  and has an identifier that refers to it in Schemas or in some nested Scope
  in a Schema.  <note>Note:  Every NamedElement has an .id attribute
  whose value is a ScopedId.  Some NamedElements are not required to have
  identifiers, and some NamedElements can have additional identifiers.  The
  scope of each such identifier is the Scope in which the NamedElement is
  defined.</note>"
  ((|documentation| :range |Remark| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a NamedElement and the Remarks,
  if any, that constitute its in-schema documentation.  If the Scope (.appears-in)
  of the Remark is, or is contained in, a different Schema from the declaration
  of the NamedElement, the Remark only applies to the NamedElement as-interfaced.<note>See
  7.1.6.3 of ISO 10303-11:2004.</note>")
   (|id| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that uniquely identifies the NamedElement
  within the Scope that is the .namespace.  Not all NamedElements are required
  to have identifiers.<note>See Clause 10 of ISO 10303-11:2004.</note>")
   (|namespace| :range |Scope| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a NamedElement and the 'scope' in
  which it is defined, i.e. the set of model elements for which that name
  refers to that NamedElement<note>See clause 10 of ISO 10303-11:2004.</note>")))


(def-mm-class |NamedRule| :MEXICO (|LocalElement|)
"  a constraint requiring a given Boolean Expression involving the Extents
  of one or more EntityTypes to evaluate to True.  It corresponds to a domain
  rule contained in a Rule declaration in EXPRESS.<note>See 9.6 of ISO
  10303-11:2004.</note>"
  ((|asserts-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the fact that every NamedRule states a Boolean expression
  that is required to be True for the Extents in a given Population.<note>See
  9.6 of ISO 10303-11:2004.</note><note>The asserted-expression that formulates
  the NamedRule is wholly owned by the NamedRule.  It is not treated as reusable.</note>")
   (|namespace| :range |GlobalRule| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the NamedRule and the GlobalRule
  that contains it.This is a refinement of the NamedElement.namespace relationship
  to Scope.In addition to being the namespace for the id of the NamedRule,
  the GlobalRule identifies the EntityTypes to which the NamedRule applies
  (and whose Extents may be referred to in the asserted-expression) and may
  define Variables that are used in the asserted-expression.")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the lexical position of the NamedRule in the sequence of
  NamedRules contained in the GlobalRule.")))


(def-mm-class |NamedType| :MEXICO (|CommonElement| |Scope| |InstantiableType|)
"  a CommonElement that defines a new InstantiableType.<note>See 8.3
  of ISO 10303-11:2004.</note>"
  ((|domain-rules| :range |DomainRule| :multiplicity (1 -1)
  :documentation
   "  a refinement of InstantiableType.constraints, represents the association
  of DomainRules that restrict the domain of valid values of the NamedType<note>See
  9.1  of ISO 10303-11:2004.</note>")
   (|instantiates| :range |SelectType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the NamedType and a SelectType whose
  domain includes it.<note>See 8.4.2 of ISO 10303-11:2004.</note>")
   (|type-elements| :range |TypeElement| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the NamedType and the TypeElements
  that are defined in its scope.")))


(def-mm-class |NamedVariable| :MEXICO (|LocalElement|)
"  Any EXPRESS syntactic variable: A LocalVariable, a QueryVariable, an
  increment ControlVariable, or an AliasVariable, or a Parameter or FunctionResult.
   A NamedVariable is a NamedElement and always has a name/identifier.  Each
  kind of NamedVariable has a different scope, but the scopes of all NamedVariables
  are LocalScopes.  Every NamedVariable has a declared variable-type, which
  may be an InstantiableType or an ActualType."
  ((|variable-type| :range |VariableType| :multiplicity (1 1)
  :documentation
   "  represents the actual data type of the Variable.  In any given invocation,
  the data type of the Variable is an InstantiableType.If the data type of
  the Variable is specified as an InstantiableType, it is fixed for all invocation.
  If the data type of the Variable is specified as a GeneralizedType, the
  actual data type varies from invocation to invocation, according  to the
  data type of an actual parameter.<note>See 9.5.4 of ISO 10303-11:2004.</note>")))


(def-mm-class |NullStatement| :MEXICO (|ControlStatement|)
"  Represents an EXPRESS Null statement.A NullStatement is just a syntactic
  placeholder, made necessary by grammar rules that require the presence
  at least 1 statement.  It has the semantics: Take no action.  It is modeled
  here, solely to permit reconstruction of the Express Text.<note>See
  Clause 13.1 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |NumberValue| :MEXICO (|SimpleValue|)
"  a SimpleValue,  a value of the EXPRESS data type NUMBER: any numeric
  value with its mathematical interpretation."
  ())


(def-mm-class |NumericType| :MEXICO (|SimpleType|)
"  a SimpleType representing the EXPRESS data types NUMBER, INTEGER and
  all REAL data types.  NUMBER and INTEGER are instances of NUMBERType.<note>See
  8.1.1 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |ONEOFConstraint| :MEXICO (|SubtypeConstraint|)
"  a constraint requiring all of its operands to be mutually exclusive.
   Each operand can be a single Extent or a union of Extents.<note>See
  9.2.5.2 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |Operation| :MEXICO (|Expression|)
"  an abstract subclass of Expression; represents the result of a well-defined
  mathematical operation or character manipulation.<note>See clause 12
  of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |Parameter| :MEXICO NIL
"  a formal parameter -- the formal description of an operand -- of a Procedure
  or Function.  Parameters are of two kinds:<ls><li>InParameters, to
  which the values of the corresponding ActualParameters are passed by value<li>VARParameters,
  to which the corresponding ActualParameters are passed by reference</ls>A
  Parameter is actually a NamedVariable whose scope is the Algorithm, and
  in each invocation of the Algorithm its (initial) value is set from the
  value or reference provided as the actual parameter.  The formal-parameter-type
  of the Parameter constrains the types/values of the corresponding actual
  parameters.  As a NamedVariable, it also has a VariableType, which is its
  data type for the purpose of operations within the body of the Algorithm.<note>See
  9.5.3 of ISO 10303-11:2004.</note>"
  ((|formal-parameter-type| :range |ParameterType| :multiplicity (1 1)
  :documentation
   "  the specification for the required data type of the actual parameters
  that correspond to the formal Parameter; the data type that represents
  the allowable values of the Parameter, or the requirements placed on the
  data type of the Parameter.<note>See 9.5.3 of ISO 10303-11:2004.</note>")
   (|namespace| :range |Algorithm| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Parameter and the Algorithm
  of which it is a formal parameter, and therefore the Algorithm which is
  the namespace for its .id. ")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  A positive integer value designating the ordinal position of the Parameter
  in the formal-parameter-list for the Algorithm that is its .namespace.
   The position is used to associate ActualParameters with the formal Parameter.<note>See
  9.5.3 of ISO 10303-11:2004.</note>")
   (|structure-constraints| :range |ActualStructureConstraint| :multiplicity (1 -1)
  :documentation
   "  the ActualStructureConstraints, if any, that constrain the allowable
  data types of the corresponding actual parameter.<note>See 9.5.3.4
  of ISO 10303-11:2004.</note>")
   (|type-constraints| :range |ActualTypeConstraint| :multiplicity (1 -1)
  :documentation
   "  the ActualTypeConstraints, if any, that constrain the allowable data
  types of the corresponding actual parameter.<note>See 9.5.3.4 of ISO
  10303-11:2004.</note>")
   ;; POD added, older version of Parameter interited from LocalElement, which
   ;; got this from NamedElement.
   (|id| :xmi-hidden t :range |ScopedId| :MULTIPLICITY (0 1)
     :documentation "Represents the identifier that uniquely identifies the NamedElement
   within the Scope that is the .namespace.
   Not all NamedElements are required to have identifiers.
   <note>See Clause 10 of ISO 10303-11:2004.</note>")))


(def-mm-class |ParameterRef| :MEXICO (|VariableRef|)
"  a Primary Expression that returns the current value associated with
  a given Parameter. A ParameterRef is only permitted within the body of
  an Algorithm. For an InParameter, the associated value is the current value
  of the InParameter (as a Variable).  For a VARParameter, the associated
  value  is the current value in the object to which the VarParameter refers.A
  ParameterRef is a subclass of VariableRef, because every Parameter is a
  NamedVariable and a ParameterRef is a reference to the value of the Parameter
  seen as a variable in the body of the Algorithm.<note>See 12.7.1 of
  ISO 10303-11:2004.</note>"
  ((|refers-to| :range |Parameter| :multiplicity (1 1)
  :documentation
   "  the formal Parameter to which the ParameterRef refers.If the formal
  Parameter is an InParameter, the ParameterRef refers to its current value.
   If the formal Parameter is a VarParameter, the ParameterRef refers to
  the current value of its referent.<note>See 12.7.1 of ISO 10303-11:2004.</note>")))


(def-mm-class |ParameterType| :MEXICO NIL
"  An abstract classification of Types that includes InstantiableTypes,
  ActualTypes and GeneralizedTypes.  That is, a ParameterType is any Type
  that is admissible as the declared type of a Parameter or an (abstract)
  ExplicitAttribute.<note>See ISO 10303-11:2004 clause 8.6.2</note>"
  ((|constraints| :range |DomainConstraint| :multiplicity (1 -1)
  :documentation
   "  represents the association of DomainConstraints that restrict the value
  domain of the AttributeType<note>See 8.1.6, 8.1.7, 8.2, and 9.1  of
  ISO 10303-11:2004.</note>")
   (|contains| :range |GeneralizedType| :multiplicity (1 -1)
  :documentation
   "  relates a ParameterType to the GeneralizedType elements  (with labels)
  that it contains.")
   (|role| :range |Attribute| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the ParameterType and the roles
  (attributes of entities) that its admissible values may play.<note>See
  9.2.1 of ISO 10303-11:2004.</note>")))


(def-mm-class |PartialEntityConstructor| :MEXICO (|Expression|)
"  represents the EXPRESS 'partial entity constructor' named for a 'single
  entity data type'.  It takes one actual parameter (AttributeBinding) for
  each ExplicitAttribute in the group of Attributes identified by the SingleEntityType,
  and binds the values to the ExplicitAttributes in order of their occurrence
  in the entity_declaration.  The result is a PartialEntityValue of the partial
  entity data type that consists of exactly that one single entity data type.
  <note>See 9.2.6 of ISO 10303-11:2004 (revised by TC#1).</note>"
  ((|attribute-group| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the PartialEntityConstructor and
  the SingleEntityType that defines it, i.e. the list of explicit attributes,.<note>See
  9.2.6 of ISO 10303-11:2004.</note>")
   (|bindings| :range |AttributeBinding| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the PartialEntityConstructor and
  the set of AttributeBindings it comprises.<note>See 9.2.6 of ISO 10303-11:2004.</note>")
   (|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier for the PartialEntityConstructor, which is
  the identifier for the SingleEntityType to which it refers.")
   (|result-value| :range |PartialEntityValue| :multiplicity (1 1)
  :documentation
   "  represents the instance that results from the partial entity constructor.
   If the expression can be evaluated without regard to any actual population
  ('compile time'), this value shall be present, but not otherwise.<note>See
  9.2.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |PartialEntityType| :MEXICO (|DataType|)
"  a-DataType representing a collection of SingleEntityTypes.  A PartialEntityType
  is the data type of a PartialEntityValue.<note>See 9.2.6 of ISO 10303-11:2004.</note>"
  ((|components| :range |SingleEntityType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the PartialEntityValue and the SingleEntityValues
  that make it up. <note>See 9.2.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |PartialEntityValue| :MEXICO (|Instance|)
"  an Instance that is a collection of Attributes (of SingleEntityTypes)
  with associated values."
  ((|components| :range |SingleEntityValue| :multiplicity (1 -1)
  :documentation
   "  the SingleEntityValues that make up the PartialEntityValue. ")
   (|of-type| :range |PartialEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a PartialEntityValue and the PartialEntityType
  that identifies the collection of SingleEntityTypes for which the PartialEntityValue
  provides values.")))


(def-mm-class |Population| :MEXICO NIL
"  represents the collection of all entity instances (instances of NamedTypes?)
  over which the LocalRules and GlobalRules of a schema are to be evaluated<note>See
  clause 5 of ISO 10303-11:2004.</note>"
  ((|composition| :range |Instance| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a Population and the Instances the
  make it up.")
   (|extents| :range |Extent| :multiplicity (1 -1)
  :documentation
   "  the collection of Extents of EntityTypes that make up the Population.")
   (|governing-schema| :range |Schema| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a Population and a Schema that governs
   (models, describes) it.<note>See 9.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |Primary| :MEXICO (|Expression|)
"  an abstract subclass of Expression representing a specific Instance,
  or the current value of an object that has a simple lexical designation.<note>See
  12.7 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |Procedure| :MEXICO (|Algorithm|)
"  an Algorithm that is executed as an action in a FunctionBody.<note>Note:
  'Procedure' is a reserved word in EXPRESS; if this metamodel is converted
  to EXPRESS, this class must be renamed.</note><note>See 9.5.2 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |ProcedureCall| :MEXICO (|Statement|)
"  Represents an EXPRESS procedure call statement.<note>See Clause
  13.8 of ISO 10303-11:2004.</note>"
  ((|actual-parameters| :range |ActualParameter| :multiplicity (1 -1)
  :documentation
   "  the ActualParameters to be passed at the time of invocation. ")
   (|invokes| :range |Procedure| :multiplicity (1 1)
  :documentation
   "  the Procedure that is invoked by the ProcedureCall.")))


(def-mm-class |QueryExpression| :MEXICO (|LocalScope| |Expression|)
"  an Expression representing the (aggregate) instance that results from
  extracting from the value of the aggregate-operand (an Expression yielding
  an aggregate value) the corresponding collection of member instances that
  satisfy a given select-condition.  Every QueryExpression is also the LocalScope
  for the QueryVariable that designates members of the aggregate value in
  the select-condition.<note>See 12.6.7 of ISO 10303-11:2004.</note>"
  ((|aggregate-operand| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the operand Expression whose result is the aggregate value
  from which members will be extracted by the Query operation.<note>See
  12.6.7 of ISO 10303-11:2004.</note>")
   (|query-variable| :range |QueryVariable| :multiplicity (1 1)
  :documentation
   "  the QueryVariable associated with the QueryExpression.  The QueryVariable
  ranges over the member elements of the aggregate-operand,  ")
   (|select-condition| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a Query expression and the Logical
  Expression that defines admissibility of members in the Query result.
  This Expression is treated as a kind of 'function definition' having a
  single Parameter which is the Query variable.  The .select-condition 'function'
  is invoked once for each member value of the .aggregate-value.<note>See
  Clause 12.6.7 of ISO 10303-11:2004.</note><note>The Expression that formulates
  the select-condition is owned by the QueryExpression.  It is not treated
  as reusable.</note>")))


(def-mm-class |QueryVariable| :MEXICO (|NamedVariable|)
"  a Variable that ranges over the member elements of the aggregate-operand
  in evaluating a the QueryExpression. The scope of a QueryVariable is the
  QueryExpression, that is, all references to it occur in the select-condition
  of the QueryExpression. The data-type of a QueryVariable is implicitly
  the data type of the member-element of the aggregate operand.<note>See
  12.6.7 of ISO 10303-11:2004.</note>"
  ((|namespace| :range |QueryExpression| :multiplicity (1 1)
  :documentation
   "  the QueryExpression in which the QueryVariable is defined.")))


(def-mm-class |RangeRole| :MEXICO (|Role|)
"  a role representing the behavior of the entity instances that is designated
  the 'range' of the relationship"
  ((|domain-view| :range |InvertibleAttribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a RangeRole and the InvertibleAttribute
  of the domain/referencing entity that models it.  ")
   (|id| :range |ScopedId| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  Represents the 'complete' identifier for the Role.  The identifier for
  a RangeRole is derived from the identifier for the ExplicitAttribute that
  creates the relationship, including the Identifier value and the associated
  EntityType identifier.")
   (|in-relationship| :range |Relationship| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a Range Role and the (unique) Relationship
  in which it is defined")
   (|range| :range |EntityType| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the (single) entity data type common to all instances that
  play the Range Role.  Derivation: .range = .domain-view.attribute-type")))


(def-mm-class |RealType| :MEXICO (|NumericType|)
"  represents all EXPRESS REAL data types, which are distinguished from
  one another by different values of 'precision'.  Type REAL (with no 'precision'
  value) is one instance of REALType.<note>See 8.1.2 of ISO 10303-11:2004.</note>"
  ((|precision| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents the number of significant figures in the values of the RealType,
  as specified in its syntactic designation.  Although the value of 'precision'
  is specified in EXPRESS to be an expression, it is assumed in this model
  that the value will in practice be a 'constant'.  The only REALType for
  which 'precision' is not present is the EXPRESS type REAL (with no precision
  specification).<note>See 8.1.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |RealValue| :MEXICO (|NumberValue|)
"  a SimpleValue,  a value of the EXPRESS data type REAL: supposedly a
  mathematical 'real' value, but properly a computational fixed or floating-point
  value."
  ())


(def-mm-class |Redeclaration| :MEXICO NIL
"  represents the 'redeclaration' of an EXPRESS attribute in a subtype
  of the entity data type for which that attribute was originally declared.
   A redeclaration represents a refinement of the original attribute concept
  in the subtype, and it states corresponding constraints on the possible
  values of that attribute in the subtype.  It may also rename the attribute
  for the subtype.  When the attribute-type of the original-attribute is
  an EntityType, the Redeclaration may be seen as refining the RangeRole
  represented by the original-attribute for the domain restricted to the
  subtype.<note>See 9.2.3.4 of ISO 10303-11:2004.</note>"
  ((|alias| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  an additional EXPRESS identifier that may be used to identify the original
  attribute in this subtype.<note>See 9.2.2.2 of ISO 10303-11:2004.</note>")
   (|derivation| :range |Expression| :multiplicity (1 1)
  :documentation
   "  When specified, represents a Redeclaration that redeclares an ExplicitAttribute
  to be 'derived' in the .scope subtype.  That is, it declares an Expression
  that can be used to derive (or validate) the value of the redeclared Attribute
  in this subtype.")
   (|isMandatory| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the entity instance is required to have a value for this attribute
  in this subtype; False if it is permitted to have no specified value.
  This attribute is only present if isOptional is True for the original attribute.<note>See
  9.2.3.4 of ISO 10303-11:2004.</note>")
   (|lower-bound| :range |SizeConstraint| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents a restriction on the minimum cardinality of the role that
  is stated by the Redeclaration.  This is the case when the Redeclaration
  redeclares the ParameterType to restrict the minimum size of the aggregate
  values.")
   (|original-attribute| :range |Attribute| :multiplicity (1 1)
  :documentation
   "  identifies the original Attribute being redeclared by the Redeclaration.
   If the Redeclaration redeclares another redeclared-attribute (see .refines),
  the .original-attribute is determined transitively.  Every Redeclaration
  ultimately constrains an original attribute in some supertype.<note>See
  9.2.3.4 of ISO 10303-11:2004.</note>")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the position of the redeclaration in the sequence of attribute
  declarations in the entity declaration.By convention these follow all the
  new attribute declarations of each kind.")
   (|refined-role| :range |Role| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the relationship between a Redeclaration and the Role represented
  by the .original-attribute.  If the Redeclaration redeclares an InvertibleAttribute,
  it refines the corresponding RangeRole by restricting the allowable participants
  in the RangeRole for the domain that is the .scope of the Redeclaration.
   If the Redeclaration redeclares an InverseAttribute, it refines the corresponding
  DomainRole by restricting the allowable participants in the DomainRole
  for the range that is the .scope of the Redeclaration.  ")
   (|refines| :range |Redeclaration| :multiplicity (1 1)
  :documentation
   "  This relationship is present only when a Redeclaration is stated as
  a refinement of another redeclared attribute.  .refines refers to the Redeclaration
  represented by that redeclared attribute.<note>See 9.2.3.4 of ISO 10303-11:2004.</note>")
   (|restricted-type| :range |ParameterType| :multiplicity (1 1)
  :documentation
   "  when specified, specifies the subtype or specialization of the data
  type of the original attribute to which all values of the original attribute
  in instances of the 'scope' EntityType must conform.<note>See 9.2.3.4
  of ISO 10303-11:2004.</note>")
   (|scope| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Redeclaration and the entity
  data type to which the redeclaration applies.Values for the original attribute
  are constrained by the Redeclaration for instances of the .scope EntityType
  and all of its subtypes.  The .scope EntityType is the namespace of the
  .alias identifier, if present.<note>See 9.2.3.4 of ISO 10303-11:2004.</note>")
   (|upper-bound| :range |SizeConstraint| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents a restriction on the maximum cardinality of the role that
  is stated by the Redeclaration.  This is the case when the Redeclaration
  redeclares the ParameterType to restrict the maximum size of the aggregate
  values.")))


(def-mm-class |Relationship| :MEXICO NIL
"  a 'distributive relationship' between entity data types.Every InvertibleAttribute
  creates a Relationship between two EntityTypes and creates two Roles --
  one for each participating EntityType.All relationships are directed.
  The InvertibleAttribute is an explicit attribute of the EntityType that
  plays the DomainRole; the range-type of the InvertibleAttribute is the
  EntityType that plays the RangeRoleThe range-type may have an inverse attribute
  denoting the DomainRole; or the DomainRole may be referred to by the UsedIn
  function."
  ((|based-on| :range |InvertibleAttribute| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents the relationship between a Relationship and the InvertibleAttribute
  on which it is based, i.e. the Attribute that creates the Relationship.")
   (|domain| :range |DomainRole| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Relationship and the Role that
  is its DomainRole.")
   (|range| :range |RangeRole| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the Relationship and its 'range'
  role.")))


(def-mm-class |Remark| :MEXICO NIL
"  A comment or or other documentation element that provides additional
  information about a model element. "
  ((|appears-in| :range |Scope| :multiplicity (1 1)
  :documentation
   "  the Schema that lexically contains the Remark.  <note>This may be
  the only cue as to the subject of the Remark.  The first edition of EXPRESS
  did not specify a means for binding Remarks to model elements.</note>")
   (|describes-element| :range |NamedElement| :multiplicity (1 -1)
  :documentation
   "  rthe NamedElement(s) described by the Remark.<note>See 7.1.6.3 of
  ISO 10303-11:2004.</note>")
   (|describes-schema| :range |Schema| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a Remark that describes a Schema
  and the Schema it describes.  The Remark may be Tagged to refer to the
  Schema, or it may be ascribed to the Schema if it lacks any other association.
   In particular, a Remark may appear in one Schema and refer to an interfaced
  Schema or to elements interfaced from it.<note>See 7.1.6.3 of ISO 10303-11:2004.
   Technically the Schema is a named element of the EXPRESS language, but
  it has no defined Scope.</note>")
   (|isTagged| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  Is TRUE if the Remark is 'tagged' to refer to one or more NamedElements,
  and FALSE if the remark is not explicitly tagged.<note>See 7.1.6.3
  of ISO 10303-11:2004.</note>")
   (|isTail| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  is True if the Remark is lexically a Tail Remark; and False if the Remark
  is lexically an Embedded remark<note>See 7.1.6 of ISO 10303-11:2004.</note>")
   (|text| :range |String| :multiplicity (1 1)
  :documentation
   "  Represents the actual text of the remark.Note: Part 11 requires that
  the character set of the remark be the EXPRESS character set, but in practice
  a larger subset of ISO 10646-1 Basic Multilingual Plane is often used.<note>See
  7.1.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |RepeatCount| :MEXICO NIL
"  A specification for repeating a given initial value into n consecutive
  ListMember slots, where n is the .count value.  The repetition value is
  specified by the .derivation expression.  If that expression is, or evaluates
  to, a constant (without regard to a Population), the value of .count is
  that constant.<note>See 12.9 of ISO 10303-11:2004.</note>"
  ((|count| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  The number of actual ListMembers that are to be filled with the member-value.
   If the .derivation expression evaluates to a constant, without regard
  to population, .count has a value; otherwise not.")
   (|derivation| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the RepeatCount and the Expression
  that denotes the value of the RepeatCount.  This relationship shall be
  present whenever the specification for the RepeatCount is not an integer
  literal.")))


(def-mm-class |RepeatStatement| :MEXICO (|Statement| |LocalScope|) ; POD switched order
"  Represents an EXPRESS REPEAT statement.  The RepeatStatement defines
  an iteration.  The execution of the repeated-body occurs zero or more times
  depending on the associated controls, which may be any combination of <br><ls><li>a
  variable-control (IncrementControl)</li><li>a while-expression</li><li>an
  until-expression</li></ls>If no control is specified, the iteration
  continues until an EscapeStatement is executed.<note>See Clause 13.9
  of ISO 10303-11:2004.</note>"
  ((|body| :range |Statement| :multiplicity (1 -1) ; pod changed, was (1,1)
  :documentation
   "  the Statement that specifies the actions to be iterated.  When the EXPRESS
  text for the body includes multiple statements, the body Statement is a
  StatementBlock.")
   (|control-variable| :range |ControlVariable| :multiplicity (1 1)
  :documentation
   "  the specification for the control variable, if any, and its initial
  and final values.")
   (|until-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Boolean Expression that specifies a condition for terminating the
  iteration.  If the value returned by the while-expression is True, the
  iteration is terminated.")
   (|while-expression| :range |Expression| :multiplicity (1 1)
  :documentation
   "  the Boolean Expression that specifies the condition for reiterating
  the repeated-body.  If the value returned by the while-expression is False,
  the iteration is terminated.")
   ; POD Added next. Used in implementation, which will have to post-process
   ; into the until and while expressions (which lose ordering?)
   (|controls| :range T :multiplicity (1 -1) :xmi-hidden t
     :documentation "Used in Injector implementation. Not part of MEXICO.")))


(def-mm-class |ReturnStatement| :MEXICO (|ControlStatement|)
"  Represents an EXPRESS RETURN statement.  A RETURN statement terminates
  the execution of a ProcedureCall or FunctionCall.  In the case of a FunctionCall,
  the RepeatStatement also specifies the value that is to be the actual result
  of the FunctionCall. <note>See Clause 13.9 of ISO 10303-11:2004.</note>"
  ((|return-value| :range |Expression| :multiplicity (1 1)
  :documentation
   "  An Expression that specifies the value to be returned as the Function
  result.  If this is not provided on a Return from a FunctionCall, the value
  of the FunctionResult variable is returned.")))


(def-mm-class |Role| :MEXICO NIL
"  a 'slot' in a relationship, denoting the behavior of one of the Instances
  involved in the relationship.Since all relationships in EXPRESS are directed,
  the two slots are nominally designated domain and range."
  ((|lower-bound| :range |SizeConstraint| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents a lower-bound on the number of Relationship instances in
  which a given EntityInstance can play this Role.  An explicit zero ('0')
  value may be considered to represent no lower-bound constraint; and the
  lower-bound relationship need not appear.  (A lower-bound expression that
  may evaluate to zero shall always be represented by a lower-bound relationship.)
   The lower-bound on the Domain role is specified by the Explicit Attribute
  that models the RangeRole.The lower-bound on the Range role is specified
  by the Inverse Attribute that models the Domain Role, if any, or possibly
  by a DomainRule on the 'range' EntityType involving UsedIn(SELF, <RangeRole>).<note>Note:
   Because the ExplicitAttribute that creates the Relationship may have an
  aggregation data type for which isUnique does not hold, a given pair of
  participating entity instances may occur more than once as an instance
  of the Relationship.  The Size constraint is on the count of pairs, not
  the count of distinct pairs.</note><note>See 9.2.1.3 of ISO 10303-11:2004.</note>")
   (|upper-bound| :range |SizeConstraint| :multiplicity (1 1)
  :is-derived-p t
  :documentation
   "  represents an upper-bound on the number of Relationship instances in
  which a given EntityInstance can play the Role.  An explicit indeterminate
  value ('?') is considered to represent no upper-bound constraint, and shall
  not be represented by an upper-bound relationship.  (An upper-bound expression
  that may evaluate to '?' shall be represented by an upper-bound relationship.)The
  upper-bound on the Domain role is specified by the Explicit Attribute that
  models the RangeRole.The upper-bound on the Range role is specified by
  the Inverse Attribute that models the Domain Role, if any, or possibly
  by a DomainRule on the 'range' EntityType involving UsedIn(SELF, <RangeRole>).
   <note>Note:  Because the ExplicitAttribute that creates the Relationship
  may have an aggregation data type for which isUnique does not hold, a given
  pair of participating entity instances may occur more than once as an instance
  of the Relationship.  The Size constraint is on the count of pairs, not
  the count of distinct pairs.</note><note>See 9.2.1.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |RoleName| :MEXICO (|StringValue|)
"  A RoleName is a reference to an Attribute that has the form of a StringValue.
   It is an instance of StringType ROLE.  RoleNames are produced as the result-type
  of the UnaryOperator RolesOf, and used as the formal parameter type for
  UsedIn.  They have reserved syntax and reserved interpretation.<note>Note:
   The result of RolesOf is only well-defined for Attributes of EntityTypes
  defined in the Schema.  Some problems arise with interfaced EntityTypes,
  renamed Attributes, and attributes of EntityTypes defined in AlgorithmScopes.</note><note>See
  Clause 15.25 of ISO 10303-11:2004.</note>"
  ((|refers-to| :range |Attribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a RoleName and the Attribute to
  which it refers.")
   (|represents| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the RoleName -- a StringValue --
  and the (structured) TypeScopedId for the Attribute, of which it is a representation.")))


(def-mm-class |SELFRef| :MEXICO (|Primary|)
"  A Primary Expression consisting of the symbol SELF.  It refers to the
  value of each instance (in any Population) of the data type being defined
  by the declaration in which it appears.  SELF is only a valid Symbol in
  a DomainRule.<note>See clause 14.5 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |SETType| :MEXICO (|ConcreteAggregationType|)
"  an AggregationType representing all EXPRESS SET data types.<note>See
  8.2.4 of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |SETValue| :MEXICO (|AggregateValue|)
"  an AggregateValue representing a value of a SET data type.  <note>Note:
  A SETValue can be viewed as a specialization of a BAGValue in which the
  'count' value for each BagMember is 1. But technically, the conversion
  of the SETValue to the corresponding BAGValue is a coercion, because the
  behavior of the resulting BAGValue is different.  For example, the union
  of two SETValues is different from the union of the corresponding BAGValues.</note>"
  ((|member-value| :range |Instance| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a SETValue and the Instances that
  appear in it.  Any given Instance can take this role at most once for any
  given SetValue.")
   (|of-type| :range |SETType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the SETValue and the SETTypes of
  which it is an instance.")))


(def-mm-class |Schema| :MEXICO (|Scope|)
"  a Scope that represents an EXPRESS SCHEMA, i.e. a collection of SchemaElement
  declarations and interface declarations.<note>Note: 'Schema' is a reserved
  word in EXPRESS; if this metamodel is converted to EXPRESS, this class
  must be renamed.</note><note>See 9.3 of ISO 10303-11:2004.</note>"
  ((|documentation| :range |Remark| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a Schema and the Remarks, if any,
  that constitute its in-schema documentation.  If the Scope (.appears-in)
  of the Remark is a different Schema, the Remark only applies to the Schema
  as-interfaced.<note>See 7.1.6.3 of ISO 10303-11:2004.  Technically
  the Schema is a named element of the EXPRESS language, but it has no defined
  Scope.</note>")
   (|interfaced-elements| :range |SchemaElement| :multiplicity (1 -1)
  :is-derived-p t
  :documentation
   "  represents relationship between a Schema and the SchemaElements it interfaces
  from other Schemas. .interfaced-elements = .interfaces.refers-to")
   (|interfaces| :range |InterfacedElement| :multiplicity (1 -1)
  :documentation
   "  Definition: the InterfacedElements that the SchemaElements that the
  Schema imports/interfaces from other Schemas.<note>See clause 11 of
  ISO 10303-11:2004.</note>")
   (|name| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the name of the EXPRESS schema.<note>See clause 9.3 of ISO 10303-11:2004.</note>")
   (|id| :xmi-hidden t :range |Identifier| :multiplicity (1 1)) ; PODTT added
   (|schema-elements| :range |SchemaElement| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the Schema and the SchemaElements
  that are defined in it, as distinct from those that are interfaced into
  it.refines the (abstract) Scope.named-elements relationship.<note>See
  9.3 of ISO 10303-11:2004.</note>")
   (|version| :range |String| :multiplicity (1 1)
  :documentation
   "  the version identifier for the EXPRESS schema, if any.<note>See
  9.3 of ISO 10303-11:2004.</note>")))

(def-mm-class |SchemaElement| :MEXICO (|NamedElement|)
"  a NamedElement whose scope can be a Schema.   This includes all CommonElements
  and GlobalRule.  The scope of CommonElements can be a Schema, but is not
  required to be a Schema."
  ((|defined-in| :range |Schema| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the SchemaElement and the Schema
  in which it is (originally) defined.refines the (abstract) NamedElement.namespace
  relationship<note>See 9.3 of ISO 10303-11:2004.</note>")
   (|referenced-as| :range |InterfacedElement| :multiplicity (1 -1)
  :documentation
   "  represents a use of the SchemaElement in some Schema other than the
  one in which it is defined.  Only a SchemaElement whose scope is a Schema
  can be referenced as an InterfacedElement.")
   (|referenced-in| :range |Schema| :multiplicity (1 -1)
  :is-derived-p t
  :documentation
   "  p>represents the relationship between a SchemaElement and the Schemas,
  if any, it is interfaced into.  .referenced-in = .referenced-as.interfacing-schema")))


(def-mm-class |Scope| :MEXICO NIL
"  any EXPRESS object that defines a namespace for the interpretation of
  identifiers.<note>See clause 10 of ISO 10303-11:2004.</note>"
  ((|includes-remarks| :range |Remark| :multiplicity (1 -1) ; 2022 mofi also has includes-remarks
  :documentation
   "  represents the relationship between a Schema and the Remarks that appear
  in it.<note>See 7.1.6 of ISO 10303-11:2004.</note>")
   (|named-elements| :range |NamedElement| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a Scope and the NamedElements that
   are defined in it.<note>This relationship is very much conceptual.
   Not every kind of NamedElement can be defined in every kind of Scope.</note><note>See
   clause 10 of ISO 10303-11:2004.</note>")
   ;; These are for Expresso implementation (thus XMI-Hidden)
   ;; 2022 I'm commenting these out. Is that what XMI-Hidden does?
   ; pod7 added pod:
   ;2022(|%parent| :xmi-hidden t :range |Scope| :multiplicity (1 1))
   ;2022(|%children| :xmi-hidden t :range |Scope| :multiplicity (0 -1))
   ;; ids - The keys in %%ids are P11UINTERNed (see add-type)
   ;2022(|%ids| :xmi-hidden t :range t :multiplicity (1 1))
   ;2022(|%inherited-objects| :xmi-hidden t :range |NamedType| :multiplicity (0 -1))
   ))


(def-mm-class |SelectType| :MEXICO (|DefinedType|)
"  a DefinedType representing an EXPRESS defined data type whose underlying_type
  is a SELECT data type.<note>See 8.4.2 of ISO 10303-11:2004.</note>"
  ((|allowed-types| :range |NamedType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of the SelectType to a NamedType whose values
  are included in the domain of the SelectType.All values in the domain of
  the NamedType are valid values of the SelectType.<note>See 8.4.2 of
  ISO 10303-11:2004.</note>")
   (|base| :range |SelectType| :multiplicity (1 1)
  :documentation
   "  represents the relationship of an extended select type to the (extensible)
  select type it is BASED ON.<note>See 8.4.2 of ISO 10303-11:2004.</note>")
   (|extension| :range |SelectType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of an EXTENSIBLE select type to a select
  type BASED ON it.<note>See 8.4.2 of ISO 10303-11:2004.</note>")
   (|isEntity| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  represents a constraint on the extensions of an Extensible SelectType:
  True if every NamedType in the extension must be an EntityType; otherwise
  False..")
   (|isExtensible| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  True if the SelectType is EXTENSIBLE, i.e. if it can have additional
  NamedTypes in the select-list when it is interfaced into another Schema;
  False otherwise.<note>See 8.4.2 of ISO 10303-11:2004.</note>")
   (|select-list| :range |NamedType| :multiplicity (1 -1)
  :is-ordered-p t
  :documentation
   "  represents the appearance of the NamedType in the select list in the
  declaration of the SelectType.  For extended and extensible SelectTypes,
  the NamedType should appear in exactly one of the select-lists in any set
  of SelectTypes related by extension.  This is distinct from .allowed-types,
  which represents all of the NamedTypes that can validly instantiate the
  SelectType, including any related by extension.  The select-list is said
  to be 'ordered', to convey the syntactic ordering.  The ordering has no
  semantic significance.<note>See 8.4.2 of ISO 10303-11:2004.</note>")))


(def-mm-class |Selector| :MEXICO (|Expression|)
"  A FullExpression that returns the value of one or more Attributes of
  an EntityInstance.<note>This concept does not appear in Part 11 per
  se, but the three subclasses all appear in Part 11 and have this property.</note>"
  ((|entity-instance| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the entity instance from which the Selector extracts the
  value of the named Attribute(s).<note>See 12.7.3 of ISO 10303-11:2004.</note>")))


(def-mm-class |SimpleType| :MEXICO (|AnonymousType|)
"  an AnonymousType representing those EXPRESS data types defined in the
  language as 'simple types': BINARY types, BOOLEAN, INTEGER, LOGICAL, NUMBER,
  REAL types, and STRING types.<note>See 8.1 of ISO 10303-11:2004.</note>"
  ((|id| :range |Keyword| :multiplicity (1 1)
  :documentation
   "  represents the EXPRESS keyword denoting the SimpleType, one of: BINARY,
  BOOLEAN, INTEGER, LOGICAL, NUMBER, REAL, STRING.<note>See 8.1 of ISO
  10303-11:2004.</note>")))


(def-mm-class |SimpleValue| :MEXICO (|ConcreteValue|)
"  a ConcreteValue that consists of a single atomic information unit of
  a data type defined in the EXPRESS language itself. "
  ((|name| :range |String| :multiplicity (1 1)
  :documentation
   "  the representation of the value, assumed to be a character string.")
   (|of-type| :range |SimpleType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a SimpleValue and the data types
  of which it is an instance.")))


(def-mm-class |SingleEntityType| :MEXICO NIL
"  the group of Attributes of a given EntityType that appear directly in
  the entity_declaration for that EntityType, i.e. excluding 'inherited'
  attributes.  A SingleEntityType corresponds to, and has the same id as,
  the EntityType whose declaration defines it.<note>A SingleEntityType
  is not a DataType; it cannot be the type of an Expression result or of
  any other EXPRESS concept.  It is only the 'type' of SingleEntityValues,
  and they are not Instances.</note><note>See 3.3.9 of ISO 10303-11:2004
  (should be corrected by TC#1).</note>"
  ((|declared-in| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the derivation of the SingleEntityType from the entity_declaration
  for the EntityType.")
   (|declares| :range |Attribute| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a SingleEntityType and the Attributes
  declared in the entity declaration for the corresponding EntityType..")
;   (|declares| :range |ExplicitAttribute| :multiplicity (1 -1))
   (|equivalent| :range |PartialEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the SingleEntityType and the 'equivalent'
  PartialEntityType, namely, the PartialEntityType that consists of exactly
  that one SingleEntityType.  For those PartialEntityTypes that are equivalent
  to SingleEntityTypes, the PartialEntityType.includes relationship is the
  inverse of this relationship.")
   (|id| :range |ScopedId| :multiplicity (1 1)
  ;PODTT :is-derived-p t
  :documentation
   "  Represents the EXPRESS Identifier for the SingleEntityType, which is
  the same as the Identifier for the corresponding EntityType")))


(def-mm-class |SingleEntityValue| :MEXICO NIL
"  A collection of values for the explicit Attributes of exactly one SingleEntityType.<note>Note:
   A SingleEntityValue is not an Instance; it is a part of a PartialEntityValue.
   It cannot be the result of an Expression, nor can it be the value of any
  EXPRESS concept.  The result of a PartialEntityConstructor is the .equivalent
  PartialEntityValue.</note>"
  ((|equivalent| :range |PartialEntityValue| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a SingleEntityValue and the PartialEntityValue
  that consists of exactly that one SingleEntityValue.")
   (|of-type| :range |SingleEntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a SingleEntityValue and the SingleEntityType
  that declares the Attributes whose values are contained in the SingleEntityValue.<note>While
  the relationship between a SingleEntityValue and a SingleEntityType appears
  to be an Instance-to-Type relationship, it is not treated as such in the
  metamodel, because SingleEntityValues are not Instances  they can only
  appear as components of a PartialEntityValue. </note>")
   (|properties| :range |AttributeValue| :multiplicity (1 -1)
  :documentation
   "  represents the relationship of the SingleEntityValue to the AttributeValue
  assignments it comprises.")))


(def-mm-class |SingleLeafInstance| :MEXICO (|EntityInstance|)
"  An EntityInstance that is completely characterized by a single EntityType
  (and all its supertypes) that is declared in the governing Schema<note>This
  concept does not appear in Part 11, but is the 'characterized instance'
  that is the basis for the 'internal mapping' in ISO 10303-21:2002.</note>"
  ((|characterizing-type| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the unique EntityType classifier that has (defines or inherits)
  exactly all of the Attributes present in the representation of the EntityInstance.
   Not every EntityInstance has a characterizing-type -- it may be an 'instance-of'
  two or more EntityTypes for which the intersection is not explicitly modeled,
  but permitted by the model to be non-empty.")))


(def-mm-class |SizeConstraint| :MEXICO (|DomainConstraint|)
"  A SizeConstraint represents a constraint on the number of members in
  each value of an EXPRESS aggregation type, stated as a bound in the syntactic
  designation for the type.  A SizeConstraint represents either an upper-bound
  or a lower-bound.  In the case of an ARRAY type, the value (hi-index -
  lo-index + 1) is both the lower-bound value and the upper-bound value.
   A SizeConstraint is a DomainConstraint, considered to have an equivalent
  Boolean expression using the built-in SizeOf() function.<note>See 8.2.2,
  8.2.3, and 8.2.4 of ISO 10303-11:2004.</note>"
  ((|bound| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  represents a constant value specifying the (upper or lower) bound on
  the number of members in a valid instance of the aggregation type.  This
  attribute is present when the bound expression is a 'constant'.<note>See
  8.2.2, 8.2.3, and 8.2.4 of ISO 10303-11:2004.</note>")))


(def-mm-class |SkipStatement| :MEXICO (|ControlStatement|)
"  Represents an EXPRESS SKIP statement.A SKIP statement is always contained
  within the body of a RepeatStatement.Execution of a SKIP statement results
  in continuing the control flow with the 'increment and test' operations
  of the RepeatStatement, skipping any intervening actions.<note>See
  Clause 13.11 of ISO 10303-11:2004.</note>"
  ((|in-block| :range |StatementBlock| :multiplicity (1 1))))


(def-mm-class |SpecializedType| :MEXICO (|DefinedType|)
"  <note>See 8.2.2, 8.2.3, and 8.2.4 of ISO 10303-11:2004.</note>"
  ((|underlying-type| :range |ConcreteType| :multiplicity (1 1)
  :documentation
   "  represents the EXPRESS 'specialization' relationship between a defined
  data type and the 'underlying type' used to represent it.<note>See
  9.1 and 9.7 of ISO 10303-11:2004.</note>")))


(def-mm-class |SpecializedValue| :MEXICO (|TypedInstance|)
"  a TypedInstance that is a value of a SpecializedType; every SpecializedInstance
  is represented by some ConcreteValue."
  ((|fundamental-value| :range |ConcreteValue| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a SpecializedInstance and the 'fundamental'
  ConcreteValue that is used to represent that Instance.")
   (|of-type| :range |SpecializedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a SpecializedValue and its data
  type.")))


(def-mm-class |Statement| :MEXICO NIL
"  An EXPRESS Statement, a directive to perform a certain set of operations.<note>See
  Clause 13 of ISO 10303-11:2004.</note>"
  ((|controlled-by| :range |RepeatStatement| :multiplicity (1 1)
  :documentation
   "  the RepeatStatement that controls the iterated execution of the actions
  of the Statement.")
   (|implements| :range |Algorithm| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a FunctionBody and the Algorithm
  for which it specifies an implementation.")
   (|in-block| :range |StatementBlock| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a Statement and the StatementBlock,
  if any, in which it occurs.<note>This relationship is needed for ESCAPE
  statements and SKIP statements, whose interpretation requires a path back
  to the REPEAT statement that owns them.  It may also be needed to associate
  a RETURN statement with the FunctionBody that includes it.</note>")
   (|text| :range |ExpressText| :multiplicity (1 1)
  :documentation
   "  Represents the EXPRESS statement verbatim.")))


(def-mm-class |StatementBlock| :MEXICO (|Statement|)
"  represents a sequence of Statements to be executed in the given order.
   In EXPRESS syntax, a number of constructs contain a statement or sequence
  of statements, and a 'compound statement' is a statement that begins with
  BEGIN and ends with END and contains a sequence of statements.All such
  sequences have the semantics of the StatementBlock.The BEGIN/END case is
  here modeled as .delimited = True.<note>See Clause 13.5 of ISO 10303-11:2004.</note>"
  ((|body-statements| :range |Statement| :multiplicity (1 -1)
  :is-ordered-p t
  :documentation
   "  represents the relationship of a StatementBlock to the Statements of
  which the sequence consists.<note>Every EXPRESS syntax whose semantics
  is a StatementBlock requires the body to consist of at least 1 statement,
  but it may consist solely of a Null statement.  This model permits the
  body to be (semantically) empty -- the single Null statement need not be
  modeled.  Even the EXPRESS text reconstruction is clear without the existence
  of a NullStatement in this case.</note>")
   (|delimited| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  Is true if the StatementBlock was delimited by BEGIN and END tokens,
  false if it is implicit in the body of some other Statement.<note>The
  sole purpose of this attribute is to be able to reconstruct the source
  EXPRESS text properly.</note>")
   (|has-escape| :range |EscapeStatement| :multiplicity (1 -1))
   (|has-skip| :range |SkipStatement| :multiplicity (1 -1))))


(def-mm-class |StringIndex| :MEXICO (|IndexOperation|)
"  An IndexOperation that returns a substring of one or more characters
  (codes) from a STRING value.  .base-value is the STRING value.  .first-code
  designates the position of the first character (code) to be extracted.
   .last-code designates the position of the last character (code) to be
  extracted.  .last-code has no value if only one character is to be extracted.<note>See
  clause 12.5.1. of ISO 10303-11:2004.</note>"
  ((|first-code| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the (postive integer) value that designates the position
  of the first character (code) to be extracted.")
   (|last-code| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the (postive integer) value that designates the position
  of the last character (code) to be extracted.  .last-code has no value
  if only one character (code) is to be extracted.")))


(def-mm-class |StringType| :MEXICO (|SimpleType|)
"  a SimpleType representing all EXPRESS STRING data types, which are distinguished
  by different LengthConstraints.  By definition, every EXPRESS STRING type
  with a LengthConstraint is different from every other STRING data type.
   (They may be compatible with others, but not the same.)  The only instance
  of STRINGType with no LengthConstraint is the EXPRESS data type STRING.<note>See
  8.1.6 of ISO 10303-11:2004.</note>"
  ((|string-length-constraint| :range |LengthConstraint| :multiplicity (1 1)
  :documentation
   "  represents a constraint on the length (in characters) of the values
  in the domain of the STRING data type.  Refines InstantiableType.constraints.<note>See
  8.1.6 of ISO 10303-11:2004.</note>")))


(def-mm-class |StringValue| :MEXICO (|SimpleValue|)
"  a SimpleValue, a value of the EXPRESS data type STRING: a sequence of
  character codes from the ISO 10646-1 Basic Multilanguage Plane."
  ())


(def-mm-class |SubtypeConstraint| :MEXICO NIL
"  a Rule requiring a specific relationship among the Extents of two or
  more subtypes of a given supertype EntityType.  The constraint can be stated
  as a relationship among the Extents as Sets of entity instances, and is
  equivalent to a NamedRule.<note>See 9.2.5 of ISO 10303-11:2004.</note>"
  ((|collection| :range |SupertypeRule| :multiplicity (1 1)
  :documentation
   "  represents the relationship of a SubtypeConstraint to the SupertypeRule
  that contains it, which also identifies the common supertype.")
   (|constrained-subtypes| :range |EntityType| :multiplicity (1 -1)
  :documentation
   "  the EntityTypes whose Extents are constrained by the SubtypeConstraint.<note>See
  9.2.5 of ISO 10303-11:2004.</note>")
   (|equivalent-rule| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the fact that every SubtypeConstraint is equivalent to a
  BooleanExpression involving the Extents of the EntityTypes named in the
  SubtypeConstraint.The Expression is required to evaluate to True.  The
  effect is that the SubtypeConstraint is equivalent to a NamedRule.<note>The
  equivalent-rule that formulates the SubtypeConstraint is wholly owned by
  the SubtypeConstraint. It is not treated as reusable. <note>")))


(def-mm-class |SupertypeRule| :MEXICO (|CommonElement|)
"  a CommonElement representing a collection of rules requiring specific
  relationships among the Extents of two or more subtypes of a given supertype
  EntityType.  The interpretation of a SupertypeRule is that all of the contained
  constraints shall hold.SupertypeRule corresponds to a SUBTYPE_CONSTRAINT
  declaration, or to the EXPRESS supertype-clause attached to an entity declaration.
   A supertype-clause cannot have a ScopedId; a SUBTYPE_CONSTRAINT can have
  a ScopedId, but is not required to.<note>See 9.2.5 and 9.7 of ISO 10303-11:2004.</note>"
  ((|assertsAbstract| :range ptypes:|Boolean| :multiplicity (1 1)
  :documentation
   "  Represents a declaration in a SUBTYPE_CONSTRAINT that the .supertype
  EntityType is to be treated as ABSTRACT in this context, which is usually
  an interfacing schema.<note>See clause 9.2.5.1 of ISO 10303-11:2004.</note>")
   (|constraints| :range |SubtypeConstraint| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a SupertypeRule (supertype-clause
  or SUBTYPE_CONSTRAINT) and the individual subtype constraints it contains.")
   (|named-supertype| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a SupertypeRule and the EntityType
  that is the supertype of all the EntityTypes that appear in the SupertypeRule.This
  relationship is nominal for ANDConstraints and ONEOFConstraints, but significant
  for ABSTRACT and TOTAL_OVERConstraints.<note>See 9.2.5 and 9.7 of ISO
  10303-11:2004.</note>")))


(def-mm-class |TOTAL_OVERConstraint| :MEXICO (|SubtypeConstraint|)
"  a constraint requiring the union of all of its operands to be equal
  to the Extent of the supertype.<note>See 9.7.2 of ISO 10303-11:2004.</note><note>NOTE:
  The proper model of a TOTAL_OVER constraint requires that the supertype
  be one of the operands of the equivalent-expression and that the supertype
  be included among the constrained-subtypes.</note>"
  ())


(def-mm-class |TypeElement| :MEXICO (|NamedElement|)
"  A NamedElement whose namespace is a data type (NamedType).<note>See
  8.2.2, 8.2.3, and 8.2.4 of ISO 10303-11:2004.</note>"
  ((|namespace| :range |NamedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the TypeElement and the NamedType
  in which it is defined.This is a refinement of the NamedElement.namespace
  and an abstraction of the specific relationships of TypeElements to their
  owner NamedTypes.")))


(def-mm-class |TypeName| :MEXICO (|StringValue|)
"  A TypeName is a reference to a DataType that has the form of a StringValue.
   It is an instance of StringType TYPE.  TypeNames are produced as the result-type
  of the UnaryOperator TypeOf.  They have reserved syntax and reserved interpretation.<note>Note:
   The result of TypeOf is only well-defined for NamedTypes defined in the
  Schema, although it can also produce EXPRESS keywords.  Some problems arise
  with interfaced NamedTypes, and NamedTypes defined in AlgorithmScopes.</note><note>See
  Clause 15.25 of ISO 10303-11:2004.</note>"
  ((|refers-to| :range |NamedType| :multiplicity (1 1)
  :documentation
   "  represents the relationship between a TypeName and the NamedType to
  which it refers.")
   (|represents| :range |ScopedId| :multiplicity (1 1)
  :documentation
   "  the (structured) ScopedId for the NamedType, of which the TypeName is
  a String representation.")))


(def-mm-class |TypedInstance| :MEXICO (|Instance|)
"  an abstract classifier, a subtype of Instance comprising those Instances
  that are instances of a NamedType.Only a TypedInstance can instantiate
  a SelectType."
  ((|satisfies-type| :range |SelectType| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between a TaggedInstance and the SelectTypes
  of which it is an allowable instance.")))


(def-mm-class |UnaryOperation| :MEXICO (|Operation|)
"  an Operation representing the result of a well-defined mathematical
  operation on a single Expression operand.  A UnaryOperation models a use
  of a UnaryOperator with a particular operand.<note>See clause 12 of
  ISO 10303-11:2004.</note>"
  ((|operator| :range |UnaryOperator| :multiplicity (1 1)
  :documentation
   "  Represents the conceptual operation that is actually being performed
  by the UnaryOperation.<note>See ISO 10303-11.2:2004, clause 12.</note>")
   (|unary-operand| :range |Expression| :multiplicity (1 1)
  :documentation
   "  represents the operand Expression that produces the input to a UnaryOperation.<note>See
  clause 12 of ISO 10303-11:2004.</note>")))


(def-mm-class |UniqueRule| :MEXICO (|TypeElement|)
"  represents an EXPRESS UNIQUE rule = a requirement that the combination
  of values of the specified 'key' attributes be unique over all instances
  of the entity data type in a given Population.<note>See 9.2.2.1 of
  ISO 10303-11:2004.</note>"
  ((|domain| :range |EntityType| :multiplicity (1 1)
  :documentation
   "  represents the relationship of the UniqueRule to the EntityType whose
  Extent is the domain of values to which it applies.")
   (|key-component| :range |Attribute| :multiplicity (1 -1)
  :documentation
   "  represents the relationship between the UniqueRule and the 'key' attributes
  of the (possibly joint) key for the instances of the EntityType<note>See
  9.2.2.1 of ISO 10303-11:2004.</note>")
   (|position| :range |IntegerValue| :multiplicity (1 1)
  :documentation
   "  Represents the position of the Unique Rule in the list of rules following
  the UNIQUE keyword in the entity/type declaration.")))


(def-mm-class |UsedInRef| :MEXICO (|Selector|)
"  a Selector expression that returns the Set of EntityInstances for which
  the given entity instance is in the range of the specified Attribute.
  In effect, it returns the value of the corresponding inverse attribute
  for the given entity instance.<note>See clause 15.26 of ISO 10303-11:2004.</note>"
  ((|inverse-of| :range |Attribute| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the UsedIn Reference and the Attribute
  designated by the .id value.  The UsedIn Reference effectively produces
  the 'inverse' of this Attribute.")))


(def-mm-class |VARExpression| :MEXICO NIL
"  an Expression that refers to an object that contains a value.  Unlike
  Primary Expressions, Index Expressions and Selector Expressions, which
  are similar in structure, a VARExpression formally refers to the object
  (place) that holds an Instance, rather than the Instance itself.  The object
  to which a VARExpression refers is called its 'referent'.Every referent
  object has a data type, but the type of the VARExpression that refers to
  it is 'reference to object with' that data type.The referent object can
  be:<br><ls><li>a LocalVariable<li>an InParameter or FunctionResult<li>a
  member of an AggregationType that is, or is part of, the content model
  of another object<li>an ExplicitAttribute of an EntityType that is the
  content model of another object<li>a SingleEntityType that is part of the
  content model of another object<li>an ExplicitAttribute of an EntityInstance
  that is the value of another object<li>a SingleEntityType that represents
  a set of ExplicitAttributes of an EntityInstance that is the value of another
  object.<li>the object that is the referent of an AliasVariable or a VARParameter.</ls>"
  ((|text| :range |ExpressText| :multiplicity (1 1)
  :documentation
   "  the lexical representation of the VARExpression. ")))


(def-mm-class |VARParameter| :MEXICO (|Parameter| |VARVariable|)
"  A formal parameter to a Procedure that is used as a reference to the
  Variable that is the ActualParameter in a given invocation.  That is, a
  VARParameter represents a parameter that is 'passed by reference'.A VARParameter
  is a VARVariable, and therefore a NamedVariable.  It is not a separate
  Variable; it is rather a temporary name for an existing object -- the ActualParameter.
   The variable-type of the VARParameter in each invocation of the Algorithm
  is the data type of the corresponding ActualParameter.<note>See 9.5.3
  of ISO 10303-11:2004.</note>"
  ())


(def-mm-class |VARVariable| :MEXICO (|NamedVariable|)
"  A VARVariable represents a 'reference' or 'pointer' object that functions
  as a reference to a Variable (or part of a Variable) during the execution
  of an Algorithm.  A VARVariable is not a Variable.  Unlike a Variable,
  it does not itself hold an Instance.  Instead, it points to a place that
  holds an Instance.  The place to which a VARVariable refers is called its
  referent.  The referent of a VARVariable can be anything to which a VARExpression
  (q.v.) can refer.  The referent of a VARVariable is fixed at the time the
  instance of the VARVariable is created.  There are two kinds of VARVariables:
  VARParameter and AliasVariable."
  ())


(def-mm-class |Variable| :MEXICO (|NamedVariable|)
"  an object that exists during an invocation of an Algorithm or the evaluation
  of a GlobalRule and contains an Instance of a specified data type.  (In
  essence, the variable-type of a Variable specifies the structure of the
  object that contains the value.)  During execution of the Algorithm or
  the body of the GlobalRule, the Instance contained in a Variable can change.
   <note>See 9.5.4 of ISO 10303-11:2004.</note><note>Part 11 uses the
  term 'variable' to denote any of several kinds of objects that hold values,
  including LocalVariables, FunctionResults, Parameters, aggregate elements,
  and ExplicitAttributes in EntityValues.  In this specification the term
  'Variable' is restricted to LocalVariables, FunctionResults, and InParameters.</note>"
  ())


(def-mm-class |VariableCell| :MEXICO (|VARExpression|)
"  A VARExpression that consists only of the identifier for a Variable.
   The Variable is designated by the .referent relationship.The referent
  of the VariableCell VARExpression is the object that is (the implementation
  of) that Variable (not the value of that Variable).  <note>A VARExpression
  that consists of the identifier for an AliasVariable or a VARParameter
  is a VARCell, not a VariableCell.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  the lexical text of the identifier for the NamedVariable, subsets VARExpression.text")
   (|referent| :range |Variable| :multiplicity (1 1)
  :documentation
   "  the Variable whose instantiation is the referent object of the VariableCell
  VARExpression. ")))


(def-mm-class |VariableRef| :MEXICO (|Primary|)
"  a Primary Expression that returns the value currently associated with
  a given NamedVariable. NamedVariables include LocalVariables, QueryVariables,
  ControlVariables, AliasVariables.  They also include Parameters and FunctionResults
  seen as variables within the body of the Algorithm.A VariableRef that refers-to
  a QueryVariable may occur anywhere within expressions in the owning Query.
  A VariableRef that refers-to a ControlVariable may occur anywhere within
  the RepeatStatement that defines the ControlVariable.A VariableRef that
  refers-to an AliasVariable may occur anywhere within the AliasStatement.A
  VariableRef that refers-to a LocalVariable may occur anywhere within the
  AlgorithmScope in which it is defined: - For a GlobalRule, it may occur
  anywhere within the body of the GlobalRule, or within the NamedRules contained
  in the GlobalRule. - For an Algorithm, it may occur within the body of
  an Algorithm.A VariableRef that refers to a Parameter or FunctionResult
  may occur anywhere within the body of the Algorithm.The value associated
  with a VariableRef that refers to VARVariable (an AliasVariable or a VARParameter)
  is the current value in the object  to which the VARVariable refers. The
  value associated with any other VariableRef is the current value in the
  Variable to which the VariableRef refers.<note>See 12.7.1 of ISO 10303-11:2004.</note>"
  ((|id| :range |Identifier| :multiplicity (1 1)
  :documentation
   "  Represents the identifier that is the content of the reference.  It
  can be the identifier for a LocalVariable, a Parameter, or a FunctionResult.")
   (|refers-to| :range |NamedVariable| :multiplicity (1 1)
  :documentation
   "  represents the relationship between the VariableReference and the local
  Variable to which it refers.")))


(def-mm-class |VariableType| :MEXICO (|ParameterType| |DataType|)
"   An abstract class representing the permissible data types of a variable:
  InstantiableTypes and ActualTypes. "
  ())

(with-slots (mofi::abstract-classes) *model*
    (setf mofi::abstract-classes '(|LocalElement| |Attribute| |DefinedType| |NamedType| |TypeElement| |ConcreteValue| |NamedVariable| |NamedElement| |IndexOperation| |AggregateValue| |CommonElement| |Operation| |ActualType| |Scope| |SchemaElement| |AggregationType| |Role| |SimpleValue| |VARExpression| |AnonymousType| |Primary| |ConcreteAggregationType| |Parameter| |GeneralAggregationType| |ActualAggregationType| |Selector| |TypedInstance| |VARVariable| |Instance| |VariableType| |InstantiableType| |ParameterType| |DomainConstraint| |ControlStatement| |SimpleType| |GeneralizedType| |GenericElement| |Variable| |Algorithm| |DataType| |AlgorithmScope| |LocalScope|)))

;;; End of Output
