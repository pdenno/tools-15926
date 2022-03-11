
;;; Purpose: Meta-object definitions for QVT.
;;; Date: 2007-10-14

(in-package :qvt) 

(def-mm-class |Element| :qvt ()
  "Supertype of everything here."
    ((|owner| :range |Element| :multiplicity (1 1) :initform nil :initarg :owner
	      :documentation "The owner of this object.")
     (|ownedElement| :range |Element| :multiplicity (0 -1)
		     :documentation "Objects owned by this object.")))

(def-mm-class |NamedElement| :qvt (|Element|)
  "A named element supports using a string expression to specify its name."
  ((|name| :range ptypes:|String| :multiplicity (0 1 )
	   :documentation
	   "  The name of the NamedElement.")))

(def-mm-class |Operation| :qvt (|NamedElement|)
  "An Operation"
  ((|ownedParameter| :range ocl:|Variable| :multiplicity (0 1 ) :is-ordered-p t
	   :documentation "The parameters owned by this operation.")
   (|type| :range ocl::|Type| :multiplicity (0 1)))) ; don't try to export ocl:|Type|.


(def-mm-class |Class| :qvt (|NamedElement|)
    "A class."
    ())

(def-mm-class |Property| :qvt (|NamedElement|)
    "A property."
    ())

(def-mm-class |Package| :qvt (|NamedElement|)
    "A package."
    ())

;;;=======================================================
;;; QVT MM Proper
;;;=======================================================
(def-mm-class |QVTToplevel| :qvt (|Element|)
  "A toplevel metaobject, a 'mapping specification' for collecting transformations. 
  This object is not defined by the QVT spec."
 ((|importUnit| 
   :range |ImportUnit| :multiplicity (0 -1) 
   :documentation "Reference to other mapping specifications imported by this mapping specification.")
  (|transformation| 
   :range |Transformation| :multiplicity (0 -1)
   :documentation "Transformation objects defined in this mapping specification.")))

(def-mm-class |ImportUnit| :qvt (|Element|)
  "A reference to a mapping specification to be imported.
  This object is not defined by the QVT spec."
 ((|referencer| 
   :range ptypes:|String| :multiplicity (1 -1) 
   :documentation "List of reference path components identifying a specification for import.")))
      
;;; 7.11.1.1
(def-mm-class |Transformation| :qvt (|NamedElement| #|mof:Class mof:Package|#)
    "A Transformation defines how one set of models can be transformed into another."
    ((|extends| 
      :range |Transformation| :multiplicity (0 1)
      :documentation "A transformation can extend another transformation. 
      The rules of the extended transformation are included in the extending transformation 
      to specify the latter's execution behavior. Extension is transitive.")
     (|modelParameter| 
      :range |TypedModel| :multiplicity (0 -1)
      :documentation "The set of typed models which specify the types of models that may participate 
      in the transformation.")
     (|rule| 
      :range |Rule| :multiplicity (0 -1)
      :documentation "The rules owned by the transformation, which together specify the execution behavior 
      of the transformation.")
     (|function| 
      :range |Function| :multiplicity (0 -1)
      :documentation "The OM functions declared in the scope of this transformation.")))

;;; 7.11.1.2
(def-mm-class |TypedModel| :qvt (|NamedElement|)
  "A typed model specifies a named, typed parameter of a transformation. At runtime, a model which 
   is passed to the transformation by this name is constrained to contain only those model elements 
   whose types are specified in the set of model packages associated with the typed model. 
   At runtime, a transformation is always executed in a particular direction by selecting ONE of 
   the typed models as the target of the transformation.

   A target model may be produced from MORE THAN ONE source model, and in such cases a transformation 
   may require the selection of model elements from one source model to be constrained by the selection 
   of model elements from another source model. This situation may be modelled by a typed model declaring 
   a dependency on another typed model."
  ((|dependsOn| 
    :range |TypedModel| :multiplicity (1 1)
    :documentation "The set of typed models that this typed model declares a dependency on.")
   (|usedPackage| 
    :range |Package| :multiplicity (1 -1)
    :documentation "The meta model packages that specify the types for the model elements of 
    the models that conform to this typed model.")))

; 7.11.1.3
(def-mm-class |Domain| :qvt (|NamedElement|)
  "A domain specifies a set of model elements of a typed model that are of interest to a rule. 
   Domain is an abstract class, whose concrete subclasses are responsible for specifying the 
   exact mechanism by which the set of model elements of a domain may be specified. It may be specified 
   as a pattern graph, a set of typed variables and constraints, or any other suitable mechanism 
   (Please see 7.11.3.3, 'RelationDomain' and 9.17.5, 'CoreDomain' for details)."
  ((|isCheckable| 
    :range ptypes:|Boolean| :multiplicity (1 1) 
    :documentation "A checkable domain declares that the owning rule is only required to 
     check whether the model elements specified by the domain exist in the target model 
     and report errors when they do not.")
   (|isEnforceable| 
    :range ptypes:|Boolean| :multiplicity (1 1) 
    :documentation "An enforceable domain declares that the owning rule must ensure that the model elements 
     specified by the domain exist in the target model when the transformation is executed in 
     the direction of the typed model associated with the domain.")
   (|typedModel| 
    :range |TypedModel| :multiplicity (0 1)
    :documentation "The typed model that contains the types of the model elements specified by the domain.")))

(setf (abstract-p (find-class '|Domain|)) t)

;;; 7.11.1.4
(def-mm-class |Rule| :qvt (|NamedElement|)
  "A rule specifies how the model elements specified by its domains are related with each other, 
   and how the model elements of one domain are to be computed from the model elements of the other domains. 
   Rule is an abstract class, whose concrete subclasses are responsible for specifying the exact semantics 
   of how the domains are related and computed from one another 
   (please see 7.11.3.2, 'Relation' and 9.17.6, 'Mapping' for details).
   A rule may conditionally override another rule. The overriding rule is executed in place of 
   the overridden rule when the overriding conditions are satisfied. 
   The exact semantics of overriding are subclass specific."
  ((|domain| 
    :range |Domain| :multiplicity (0 -1)
    :documentation "The Domains owned by this rule.")
   (|overrides| 
    :range |Rule| :multiplicity (0 1)
    :documentation "The rule which this rule overrides.")))

(setf (abstract-p (find-class '|Rule|)) t)

;;; 7.11.1.5
(def-mm-class |Function| :qvt (|Operation|)
  "A function is a side-effect-free operation OWNED BY A TRANSFORMATION. 
   A function is required to produce the same result each time it is invoked with the same arguments. 
   A function may be specified by an OCL expression, or it may have a black-box implementation."
   ((|queryExpression| 
     :range ocl:|OclExpression| :multiplicity (0 1) 
     :documentation "The OCL expression that specifies the function. If this reference is absent, 
     then a black-box implementation is assumed.")))

;;; 7.11.1.6 -- POD I don't use this. I use ocl:VariableDeclaration.
;;;(def-mm-class |FunctionParameter| :qvt (#||Parameter| |Variable||#)
;;;  "A Parameter of a Function."
;;;   ())

;;; 7.11.1.7
(def-mm-class |Predicate| :qvt (|Element|)
  "A predicate is a boolean-valued expression owned by a pattern. 
   It is specified by an OCL expression which may contain
   references to the variables of the pattern that owns the predicate."
   ((|conditionExpression| 
     :range ocl:|OclExpression| :multiplicity (0 1) 
     :documentation "The OCL expression that specifies the predicate.")))

;;; 7.11.1.8
(def-mm-class |Pattern| :qvt (|Element|)
  "A pattern is a set of variable declarations and predicates, which when evaluated 
   in the context of a model, results in a set of bindings for the variables."
   ((|bindsTo| 
     :range |Variable| :multiplicity (0 -1) 
     :documentation "The set of variables which are to be bound when the pattern is evaluated.")
    (|predicate| 
     :range |Predicate| :multiplicity (0 -1) 
     :documentation "The set of predicates that must evaluate to true for a binding of the 
      variables of the pattern to be considered a valid binding.")))

;;; 7.11.2.1
(def-mm-class |TemplateExp| :qvt (|Element| #|ocl:LiteralExp|#) ; POD that's probably wrong.
   "A template expression specifies a pattern that matches model elements in a candidate model 
    of a transformation. The matched model element may be bound to a variable and this variable 
    may be used in other parts of the expression. A template expression matches a part of a 
    model only when the WHERE expression associated with the template expression evaluates to true. 
    A template expression may match either a single model element or a collection of model elements
    depending on whether it is an object template expression or a collection template expression."
   ((|when| 
     :range ocl:|OclExpression| :multiplicity (0 1)
     :documentation "A boolean expression that must evaluate to true for the template expression to match.")
    (|bindsTo| 
     :range ocl:|Variable| :multiplicity (0 1)
     :documentation "The variable that refers to the model element matched by this template expression.")))

(setf (abstract-p (find-class '|TemplateExp|)) t)

;;; 7.11.2.2
(def-mm-class |ObjectTemplateExp| :qvt (|TemplateExp|)
   "An object template expression specifies a pattern that may match only single model elements. 
    An object template has a type specified by the referred class. An object template is specified 
    by a collection of property template items each corresponding to different attributes of the 
    referred class."
   ((|referredClass| 
     :range |Class| :multiplicity (1 1)
     :documentation "The EMOF Class that specifies the type of objects to be matched by this expression.")
    (|part| 
     :range |PropertyTemplate| :multiplicity (0 -1)
     :documentation "Specification of a value expression that must be satisfied by the 
      corresponding slot of the object that matches the object template expression.")))

;;; 7.11.2.3
(def-mm-class |CollectionTemplateExp| :qvt (|TemplateExp|)
   "A collection template expression specifies a pattern that matches a collection of elements.
    It specifies a set of member expressions that match individual elements, and a collection-typed 
    variable that matches the rest of the collection. The type of collection that a template matches 
    is given by the referred collection type. If the referred collection type is a sequence then 
    the matching member elements must be present at the head of the sequence in the order 
    specified by the member expressions."
   ((|referredCollectionType| 
     :range ocl:|Collection| :multiplicity (0 1) ; POD syntax suggests this is (1 1)
     :documentation "The type of the collection that is being specified. 
      It can be any of the EMOF collection types such as Set, Sequence, OrderedSet, etc.")
    (|elementType| ; POD added, range should be anything <TypeCS>
     :range |Element| :multiplicity (1 1)
     :documentation "The type of elements of the collection")
    (|member| 
     :range ocl:|OclExpression| :multiplicity (0 -1)
     :documentation "The expressions that the elements of the collection must have matches for. 
      A special variable _ may be used to indicate that any arbitrary element may be matched and ignored.")
    (|rest| 
     :range ocl:|OclExpression| :multiplicity (0 1)
     :documentation "The variable that the rest of the collection (i.e. excluding elements matched 
     by member expressions) must match. A special variable _ may be used to indicate that any 
     arbitrary collection may be matched and ignored.")))

#|
A property template item has a valid match when the value of the referred property matches 
the value specified by the value expression. 
The following rules apply when the value is specified by a template expression:

   * If the value expression is an object template expression and the referred property is 
     single-valued then the property value must match the object template expression.

   * If the value expression is an object template expression and the referred property is multi-valued 
     then at least one of the property values must match the object template expression.

   * If the value expression is a collection template expression and the referred property is single-valued 
     then the property value is treated as a singleton collection that must match the 
     collection template expression.

  * If the value expression is a collection template expression and the referred property 
    is multi-valued then the collection of property values must match the collection template expression. 
    The following rules apply:
          ** If the property value is a set, then the collection type of the 
             collection template expression must be a set.
          ** If the property value is an ordered set, then the collection type of the 
             collection template expression can be one of set, sequence or ordered set.
          ** If the property value is a sequence, then the collection type of the 
             collection template expression can be one of set, sequence or ordered set. 
             When the collection type is a set or an ordered set, a valid match requires 
             that each value of the property be unique.
|#
;;; 7.11.2.4
(def-mm-class |PropertyTemplate| :qvt (|Element|)
   "Property template items are used to specify constraints on the values of the slots 
    of the model element matching the container object template expression. 
    The constraint is on the slot that is an instance of the referred property and the
    constraining expression is given by the value expression."
   ((|referredProperty| 
     :range |Property| :multiplicity (1 1)
     :documentation "The EMOF Property that identifies the slot that is being constrained.")
    (|value| 
     :range ocl:|OclExpression| :multiplicity (1 1) ;; POD Bug here. Should be OclExpression or Template. 
     :documentation "The value that the slot may take.")))

;;; 7.11.3.1
(def-mm-class |RelationalTransformation| :qvt (|Transformation|)
 "A RelationalTransformation is a specialization of a Transformation representing 
  a transformation definition that uses the QVT-Relation formalism."
 ((|ownedKey| :range |Key| :multiplicity (0 -1)
   :documentation "The keys defined within the transformation.")))

;;; 7.11.3.2
(def-mm-class |Relation| :qvt (|Rule|)
   "A relation is the basic unit of transformation behavior specification in the relations language. 
    It is a concrete subclass of Rule. It specifies a relationship that must hold between the model elements 
    of a set of candidate models that conform to the typed models of the transformation that owns the relation. 
    A relation is defined by two or more relation domains that specify the model elements that are to be related, 
    a when clause that specifies the conditions under which the relationship needs to hold, and a where clause 
    that specifies the condition that must be satisfied by the model elements that are being related. 
    A relation may optionally have an associated black-box operational implementation to enforce a domain.
    Please refer to sections 7.1 - 7.9 for a detailed description of the semantics, and section 12 
    for a more formal description in terms of a mapping to the core model."
   ((|isTopLevel| 
     :range ptypes:|Boolean| :multiplicity (1 1)
     :documentation "Indicates whether the relation is a top-level relation or a non-top-level relation. 
     The execution of a transformation requires that all its toplevel relations must hold, whereas a 
     non-top-level relation is required to hold only when it is invoked from another relation.")
    (|when|  
     :range |Pattern| :multiplicity (0 1)
     :documentation "The pattern (as a set of variables and predicates) that specifies the 
      when clause of the relation.")
    (|where| 
     :range |Pattern| :multiplicity (0 1)
     :documentation "The pattern (as a set of variables and predicates) that specifies the 
     where clause of the relation.")
    (|variable| 
     :range |Variable| :multiplicity (0 -1)
     :documentation "The set of variables occurring in the relation. 
      This set includes all the variables occurring in its domains and when and where clauses.")
    #| POD Spec seems to have this wrong. It sould be attached to the domain. 
    (|operationalImplementation|  ; Syntax shows this as attached to RelationDomain
     :range |RelationImplementation| :multiplicity (1 -1)
     :documentation "The set of black-box operational implementations, if any, that are associated 
      with the relation to enforce its domains.")) |#
   ))

;;; 7.11.3.3
(def-mm-class |RelationDomain| :qvt (|Domain|)
   "The class RelationDomain specifies the domains of a relation. It is a concrete subclass of Domain. 
    A relation domain has a distinguished typed variable called the root variable that can be matched 
    in a model of a given model type. A relation domain specifies a set of model elements of interest 
    by means of a domain pattern, which can be viewed as a graph of object nodes, their properties and 
    association links, with a distinguished root node that is bound to the root variable of the relation domain. 
    Please refer to sections 7.2, 7.3 and 7.10 for a detailed discussion of the semantics of domains 
    and domain patterns in the relationsí language."
  ((|rootVariable| :range ocl:|Variable| :multiplicity (1 1)
    :documentation "The distinguished typed variable of the relation domain that can be matched 
    in a model of a given model type.")
   (|pattern| :range |DomainPattern| :multiplicity (1 1)
    :documentation "The domain pattern that specifies the model elements of the relation domain. 
    The root object template expression (i.e. the root node) of the domain pattern must be bound 
    to the root variable of the relation domain.")
   (|defaultAssignment| :range |RelationDomain| :multiplicity (1 -1)
    :documentation "The assignments that set default values for the variables of the domain 
    that are required for its enforcement. (POD see note at 7.11.33 about reverse mapping.)")
   ;; POD This was moved here from |Relation|. Syntax shows this as attached to RelationDomain
   (|operationalImplementation|  
    :range |RelationImplementation| :multiplicity (1 -1)
    :documentation "The set of black-box operational implementations, if any, that are associated 
      with the relation to enforce its domains.")))

;;; 7.11.3.4
(def-mm-class |DomainPattern| :qvt (|Pattern|)
 "The class DomainPattern is a subclass of the class Pattern. A domain pattern can specify 
  an arbitrarily complex pattern graph in terms of template expressions consisting of object 
  template expressions, collection template expressions and property template items. A domain pattern 
  has a distinguished root template expression that is required to be bound to the root variable of 
  the relation domain that owns the domain pattern. An object template expression can have other
  template expressions nested inside it to an arbitrary depth. Please refer to section 7.10.3 for 
  a detailed discussion of the semantics of pattern matching involving template expressions."
 ((|templateExpression| :range |TemplateExp| :multiplicity (0 1)
  :documentation "The root template expression of the domain pattern. 
    This template expression must be bound to the root variable of the relation domain that 
    owns this domain pattern, and its type must be the same as the type of the root variable.")))

;;; 7.11.3.5
(def-mm-class |Key| :qvt (|Element|)
   "A key defines a set of properties of a class that uniquely identify an instance of the 
    class in a model extent. A class may have multiple keys (as in relational databases). 
    Please refer to section 7.4 for a detailed description of the role played by
    keys in the enforcement semantics of relations."
   ((|identifies| :range |Class| :multiplicity (1 1)
     :documentation "The class that is identified by the key.")
    (|part| :range |Property| :multiplicity (1 -1)
     :documentation "Properties of the class that make up the key.")))

;;; 7.11.3.6
(def-mm-class |RelationImplementation| :qvt (|Element|)
   "A RelationImplementation specifies an optional black-box operational implementation to enforce 
    a domain of a relation. The black-box operation is invoked when the relation is executed in 
    the direction of the typed model associated with the enforced domain and the relation evaluates 
    to false as per the checking semantics. The invoked operation is responsible for making the 
    necessary changes to the model in order to satisfy the specified relationship. It is a runtime exception 
    if the relation evaluates to false after the operation returns. The signature of the operation can be 
    derived from the domain specification of the relation - an output parameter corresponding to the 
    enforced domain, and an input parameter corresponding to each of the other domains."
  ((|impl| :range |Operation| :multiplicity (1 1)
    :documentation "The operation that implements the relation in the given direction.")
   (|inDirectionOf| :range |TypedModel| :multiplicity (1 1)
    :documentation "The direction of the relation being implemented.")))

;;; 7.11.3.7
(def-mm-class |RelationDomainAssignment| :qvt (|Element|)
 "A relation domain assignment sets the value of a domain variable by evaluating the 
  associated expression in the context of a relation."
 ((|variable| :range ocl:|Variable| :multiplicity (1 1) :initarg :variable
  :documentation "The variable being assigned.")
  (|valueExp| :range ocl:|OclExpression| :multiplicity (1 1) :initarg :value-exp
   :documentation "The expression that provides the value of the variable.")))

;;; 7.11.3.8
(def-mm-class |RelationCallExp| :qvt (|Element| #||OclExpression||#)
 "A relation call expression describes a call to a relation. A relation may be invoked 
  from the when or where clause of another relation. The expression contains a list of 
  argument expressions corresponding to the domains of the relation. The number and types of 
  the arguments must match the number of domains and types of the root variables of the domains
  respectively."
 ((|argument| :range ocl:|OclExpression| :multiplicity (0 -1) :initarg :argument
   :documentation "Arguments to the relation call.")
  ;; pod why not (1, 1)
  (|referredRelation| :range |Relation| :multiplicity (0 1) :initarg :referred-relation
   :documentation "The relation being called.")))

;;;========================================
;;; POD added the following
;;;========================================
(def-mm-class |WhenExpression| :qvt (|Element|)
  "A container for conditions of a relation 'when' expression."
  ((|condition| :range ocl:|OclExpression| :multiplicity (0 -1)
   :documentation "A boolean expression. (Note claiming that type is OclExpression is a bit of 
    a stretch, but is consistent with the spec.")))

(def-mm-class |WhereExpression| :qvt (|Element|)
  "A container for actions of a relation 'where' expression."
  ((|action| :range ocl:|OclExpression| :multiplicity (0 -1)
   :documentation "A boolean expression. (Note claiming that type is OclExpression is a bit of 
    a stretch, but is consistent with the spec.")))

(def-mm-class |PrimitiveTypeDomain| :qvt (|Domain|)
  "A Domain that describes a primitive 'leaf' type of a model."
  ((|variable| :range ocl:|Variable| :multiplicity (1 1)
    :documentation "The distinguished typed variable of the domain that can be matched 
    in a model of a given model type. This is equivalent to rootVariable in RelationDomain.")
   (|typ| :range ocl:|OclAny| :multiplicity (1 1) ; POD :range should be primitive types. 
    :documentation
    "The domain pattern that specifies a primitive typethe model elements of the relation domain. 
    The root object template expression (i.e. the root node) of the domain pattern must be bound 
    to the root variable of the relation domain.")))



