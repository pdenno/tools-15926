;;; Automatically created by pop-gen at 2016-01-08 18:15:09.
;;; Source file is NIL

(in-package :OWL-PROFILE)



;;; =========================================================
;;; ====================== Annotation
;;; =========================================================
(def-meta-stereotype |Annotation| 
   (:model :OWL-PROFILE :superclasses (|Axiom|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288731257865_134805_2619")
 ""
  ((|base_Class| :xmi-id "_16_8_e980341_1288731264841_98557_2621"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288731264841_730525_2620"      
  :name |unamed-assoc-1|      
  :metatype :extension      
  :member-ends ((|Annotation| "base_Class")
                ("_16_8_e980341_1288731264842_441908_2622" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288731264842_441908_2622" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288731264842_441908_2622" 
    :type |Annotation| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288731264841_730525_2620" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== AnonymousIndividual
;;; =========================================================
(def-meta-stereotype |AnonymousIndividual| 
   (:model :OWL-PROFILE :superclasses (|owlIndividual|) :extends (UML241:|InstanceSpecification|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_630020f_1262551030432_905013_1655")
 "An OWL 2 anonymous individual (i.e., one that has no identity, synonymous
  with an RDF blank node)."
  ((|base_InstanceSpecification| :xmi-id "_16_6_630020f_1262551037731_30329_1657"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))))

(def-meta-constraint "unnamed1" |AnonymousIndividual|
   ""
   :operation-body
   "self.label -> isEmpty()")

(def-meta-constraint "unnamed2" |AnonymousIndividual|
   ""
   :operation-body
   "self.identifier -> isEmpty()")

(def-meta-assoc "_16_6_630020f_1262551037731_928635_1656"      
  :name |unamed-assoc-41|      
  :metatype :extension      
  :member-ends ((|AnonymousIndividual| "base_InstanceSpecification")
                ("_16_6_630020f_1262551037731_868876_1658" "extension_"))      
  :owned-ends  (("_16_6_630020f_1262551037731_868876_1658" "extension_")))

(def-meta-assoc-end "_16_6_630020f_1262551037731_868876_1658" 
    :type |AnonymousIndividual| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1262551037731_928635_1656" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Assertion
;;; =========================================================
(def-meta-stereotype |Assertion| 
   (:model :OWL-PROFILE :superclasses (|Axiom|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288359800746_911826_2596")
 "OWL 2 supports a rich set of axioms for stating assertions     axioms about
  individuals that are often also called facts."
  ((|base_Class| :xmi-id "_16_8_e980341_1288359810636_502146_2598"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288359810635_649074_2597"      
  :name |unamed-assoc-26|      
  :metatype :extension      
  :member-ends ((|Assertion| "base_Class")
                ("_16_8_e980341_1288359810636_764352_2599" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288359810636_764352_2599" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288359810636_764352_2599" 
    :type |Assertion| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288359810635_649074_2597" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Axiom
;;; =========================================================
(def-meta-stereotype |Axiom| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288291025077_788807_4355")
 "The main component of an OWL 2 ontology is a set of axioms     statements
  that say what is true in the domain. OWL 2 provides an extensive set of
  axioms, all of which extend the Axiom class in the structural specification."
  ((|base_Class| :xmi-id "_16_8_e980341_1288291036430_47836_4357"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288291036430_627905_4356"      
  :name |unamed-assoc-19|      
  :metatype :extension      
  :member-ends ((|Axiom| "base_Class")
                ("_16_8_e980341_1288291036431_133561_4358" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288291036431_133561_4358" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288291036431_133561_4358" 
    :type |Axiom| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288291036430_627905_4356" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== ClassAxiom
;;; =========================================================
(def-meta-stereotype |ClassAxiom| 
   (:model :OWL-PROFILE :superclasses (|Axiom|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288291175538_972660_4498")
 "Class axioms allow relationships to be established between class expressions.
  The SubClassOf axiom allows one to state that each instance of one class
  expression is also an instance of another class expression, and thus to
  construct a hierarchy of classes. The EquivalentClasses axiom allows one
  to state that several class expressions are equivalent to each other. The
  DisjointClasses axiom allows one to state that several class expressions
  are pairwise disjoint     that is, that they have no instances in common.
  Finally, the DisjointUnion class expression allows one to define a class
  as a disjoint union of several class expressions and thus to express covering
  constraints."
  ((|base_Class| :xmi-id "_16_8_e980341_1288291184901_580923_4500"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288291184901_684351_4499"      
  :name |unamed-assoc-44|      
  :metatype :extension      
  :member-ends ((|ClassAxiom| "base_Class")
                ("_16_8_e980341_1288291184901_619873_4501" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288291184901_619873_4501" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288291184901_619873_4501" 
    :type |ClassAxiom| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288291184901_684351_4499" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== ClassExpression
;;; =========================================================
(def-meta-stereotype |ClassExpression| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|rdfsClass|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1255032857717_48736_934")
 "Class expressions provide the basic building blocks for defining sets of
  individuals in OWL. Classes and property expressions are used to construct
  class expression, (sometimes called descriptions, as in the OWL 1 specifications),
  and, in the description logic literature, complex concepts. Class expressions
  represent sets of individuals by formally specifying conditions on the
  individuals' properties; individuals satisfying these conditions are said
  to be instances of the respective class expressions."
  ())

;;; =========================================================
;;; ====================== ComplementClass
;;; =========================================================
(def-meta-stereotype |ComplementClass| 
   (:model :OWL-PROFILE :superclasses (|ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1255033129536_537002_1047")
 "Complement classes are used to define the complement of a particular class
  expression. The relationship is one to one (i.e., a class should have exactly
  one complement containing -everything- that is not in the class itself).
  Note that complement expressions should be used sparingly, as they may
  lead to unintended inconsistencies. For example, animate vs. inanimate
  objects seem natural complements within the context of things that are
  tangible objects, but there are also other things in the universe that
  may not be defined in another ontology as an object, such as ideas or other
  abstract conceptual notions. Unless you are quite certain that the closure
  over a particular class and its complement is complete and true for all
  cases in which an ontology might be used, it may be safer to say that the
  classes are disjoint rather than using complement expressions."
  ())

;;; =========================================================
;;; ====================== ComplementDatatype
;;; =========================================================
(def-meta-stereotype |ComplementDatatype| 
   (:model :OWL-PROFILE :superclasses (|DataRange|) :extends (UML241:|DataType|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1299354348370_549832_2062")
 ""
  ((|base_DataType| :xmi-id "_16_9_15100de_1299354748676_249126_2338"
    :range UML241:|DataType| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299354748676_467430_2337"      
  :name |unamed-assoc-11|      
  :metatype :extension      
  :member-ends ((|ComplementDatatype| "base_DataType")
                ("_16_9_15100de_1299354748676_422624_2339" "extension_ComplementDatatype"))      
  :owned-ends  (("_16_9_15100de_1299354748676_422624_2339" "extension_ComplementDatatype")))

(def-meta-assoc-end "_16_9_15100de_1299354748676_422624_2339" 
    :type |ComplementDatatype| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299354748676_467430_2337" 
    :name "extension_ComplementDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== DataEnumeration
;;; =========================================================
(def-meta-stereotype |DataEnumeration| 
   (:model :OWL-PROFILE :superclasses (|DataRange|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_2_15100de_1273082719807_357729_458")
 ""
  ())

;;; =========================================================
;;; ====================== DataRange
;;; =========================================================
(def-meta-stereotype |DataRange| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|DataType|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194371445218_26410_1722")
 ""
  ((|base_DataType| :xmi-id "_16_0_1_630020f_1243639041013_805375_809"
    :range UML241:|DataType| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_630020f_1243639041013_735123_808"      
  :name |unamed-assoc-42|      
  :metatype :extension      
  :member-ends ((|DataRange| "base_DataType")
                ("_16_0_1_630020f_1243639041013_45642_810" "extension_dataRange"))      
  :owned-ends  (("_16_0_1_630020f_1243639041013_45642_810" "extension_dataRange")))

(def-meta-assoc-end "_16_0_1_630020f_1243639041013_45642_810" 
    :type |DataRange| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1243639041013_735123_808" 
    :name "extension_dataRange" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== DatatypeRestriction
;;; =========================================================
(def-meta-stereotype |DatatypeRestriction| 
   (:model :OWL-PROFILE :superclasses (|DataRange|) :extends (UML241:|DataType|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1299354367836_41336_2074")
 ""
  ((|base_DataType| :xmi-id "_16_9_15100de_1299354744339_317082_2320"
    :range UML241:|DataType| :multiplicity (1 1))
   (|langRange| :xmi-id "_17_0_1_15100de_1303239449782_797946_2384"
    :range |String| :multiplicity (0 1))
   (|length| :xmi-id "_17_0_1_15100de_1303239404692_657069_2360"
    :range |String| :multiplicity (0 1))
   (|maxExclusive| :xmi-id "_17_0_1_15100de_1303239242784_716873_2339"
    :range |String| :multiplicity (0 1))
   (|maxInclusive| :xmi-id "_17_0_1_15100de_1303239308135_377251_2346"
    :range |String| :multiplicity (0 1))
   (|maxLength| :xmi-id "_17_0_1_15100de_1303239418321_890268_2368"
    :range |String| :multiplicity (0 1))
   (|minExclusive| :xmi-id "_17_0_1_15100de_1303239054566_208459_2312"
    :range |String| :multiplicity (0 1))
   (|minInclusive| :xmi-id "_17_0_1_15100de_1303239027563_678121_2305"
    :range |String| :multiplicity (0 1))
   (|minLength| :xmi-id "_17_0_1_15100de_1303239385088_229230_2353"
    :range |String| :multiplicity (0 1))
   (|pattern| :xmi-id "_17_0_1_15100de_1303239431583_634199_2376"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "_16_9_15100de_1299354744339_990969_2319"      
  :name |unamed-assoc-54|      
  :metatype :extension      
  :member-ends ((|DatatypeRestriction| "base_DataType")
                ("_16_9_15100de_1299354744339_760002_2321" "extension_DatatypeRestriction"))      
  :owned-ends  (("_16_9_15100de_1299354744339_760002_2321" "extension_DatatypeRestriction")))

(def-meta-assoc-end "_16_9_15100de_1299354744339_760002_2321" 
    :type |DatatypeRestriction| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299354744339_990969_2319" 
    :name "extension_DatatypeRestriction" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Entity
;;; =========================================================
(def-meta-stereotype |Entity| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|namedResource|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1254862709016_884318_1353")
 "Entities are the fundamental building blocks of OWL 2 ontologies, and they
  define the vocabulary     the named terms     of an ontology."
  ((|isDeprecated| :xmi-id "_12_5_1_2c17055e_1195865915735_652749_2636"
    :range |Boolean| :multiplicity (0 1) :default :false)
   (|versionInfo| :xmi-id "_16_5_4_630020f_1254862757829_522509_1375"
    :range |String| :multiplicity (0 -1))))

;;; =========================================================
;;; ====================== EnumeratedClass
;;; =========================================================
(def-meta-stereotype |EnumeratedClass| 
   (:model :OWL-PROFILE :superclasses (|ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194325413515_18128_4389")
 "Enumeration classes define an exhaustive enumeration of individuals that
  together form the instances of a class."
  ((|isComplete| :xmi-id "_12_5_1_2c17055e_1195866041757_380893_2640"
    :range |Boolean| :multiplicity (0 1))))

;;; =========================================================
;;; ====================== IntersectionClass
;;; =========================================================
(def-meta-stereotype |IntersectionClass| 
   (:model :OWL-PROFILE :superclasses (|ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1255033075588_797584_1003")
 "Intersection classes define a set of individuals that are members of the
  intersection of two or more class expressions."
  ())

;;; =========================================================
;;; ====================== IntersectionDatatype
;;; =========================================================
(def-meta-stereotype |IntersectionDatatype| 
   (:model :OWL-PROFILE :superclasses (|DataRange|) :extends (UML241:|DataType|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1299354244586_944456_2027")
 ""
  ((|base_DataType| :xmi-id "_16_9_15100de_1299354737029_40851_2302"
    :range UML241:|DataType| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299354737028_516720_2301"      
  :name |unamed-assoc-34|      
  :metatype :extension      
  :member-ends ((|IntersectionDatatype| "base_DataType")
                ("_16_9_15100de_1299354737029_185252_2303" "extension_IntersectionDatatype"))      
  :owned-ends  (("_16_9_15100de_1299354737029_185252_2303" "extension_IntersectionDatatype")))

(def-meta-assoc-end "_16_9_15100de_1299354737029_185252_2303" 
    :type |IntersectionDatatype| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299354737028_516720_2301" 
    :name "extension_IntersectionDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== NamedIndividual
;;; =========================================================
(def-meta-stereotype |NamedIndividual| 
   (:model :OWL-PROFILE :superclasses (|owlIndividual| |Entity|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_630020f_1262550960306_644512_1628")
 "OWL 2 distinguishes named individuals from those that are anonymous. Named
  individuals must have identity."
  ())

(def-meta-constraint "unnamed3" |NamedIndividual|
   ""
   :operation-body
   "self.identifier -> nonEmpty()")

;;; =========================================================
;;; ====================== NegativePropertyAssertion
;;; =========================================================
(def-meta-stereotype |NegativePropertyAssertion| 
   (:model :OWL-PROFILE :superclasses (|Assertion|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288731539201_359648_2752")
 ""
  ((|base_Class| :xmi-id "_16_8_e980341_1288731547640_360083_2754"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288731547640_732605_2753"      
  :name |unamed-assoc-30|      
  :metatype :extension      
  :member-ends ((|NegativePropertyAssertion| "base_Class")
                ("_16_8_e980341_1288731547641_38445_2755" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288731547641_38445_2755" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288731547641_38445_2755" 
    :type |NegativePropertyAssertion| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288731547640_732605_2753" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== PropertyAxiom
;;; =========================================================
(def-meta-stereotype |PropertyAxiom| 
   (:model :OWL-PROFILE :superclasses (|Axiom|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288291888649_275167_4958")
 "Object property axioms can be used to characterize and establish relationships
  between object property expressions."
  ((|base_Class| :xmi-id "_16_8_e980341_1288291897251_915332_4960"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288291897251_310320_4959"      
  :name |unamed-assoc-3|      
  :metatype :extension      
  :member-ends ((|PropertyAxiom| "base_Class")
                ("_16_8_e980341_1288291897252_646648_4961" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288291897252_646648_4961" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288291897252_646648_4961" 
    :type |PropertyAxiom| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288291897251_310320_4959" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== Singleton
;;; =========================================================
(def-meta-stereotype |Singleton| 
   (:model :OWL-PROFILE :superclasses (|Entity|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_2c17055e_1195867959734_869501_2760")
 "A singleton is a UML class representation of an OWL individual; this provides
  an alternate graphical notation for the basic owlIndividual instance specification,
  as needed, to model complex individuals. For modeling consistency, best
  practice would be to model both the instance specification and the singleton,
  and then use the rdfAbout dependency to link the singleton to the instance
  specification it refines."
  ((|base_Class| :xmi-id "_15_0_137b03ac_1201330087296_389960_2509"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_15_0_137b03ac_1201330087296_976374_2508"      
  :name |unamed-assoc-17|      
  :metatype :extension      
  :member-ends ((|Singleton| "base_Class")
                ("_15_0_137b03ac_1201330087296_136094_2510" "extension_singleton"))      
  :owned-ends  (("_15_0_137b03ac_1201330087296_136094_2510" "extension_singleton")))

(def-meta-assoc-end "_15_0_137b03ac_1201330087296_136094_2510" 
    :type |Singleton| 
    :multiplicity (0 1) 
    :association "_15_0_137b03ac_1201330087296_976374_2508" 
    :name "extension_singleton" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== SurrogateAnnotationProperty
;;; =========================================================
(def-meta-stereotype |SurrogateAnnotationProperty| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|surrogateProperty|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_4_1_e980341_1379972948611_164472_4273")
 ""
  ((|base_Class| :xmi-id "_17_0_4_1_e980341_1379972961715_599397_4304"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_17_0_4_1_e980341_1379972961715_653359_4303"      
  :name |unamed-assoc-76|      
  :metatype :extension      
  :member-ends ((|SurrogateAnnotationProperty| "base_Class")
                ("_17_0_4_1_e980341_1379972961715_643317_4305" "extension_"))      
  :owned-ends  (("_17_0_4_1_e980341_1379972961715_643317_4305" "extension_")))

(def-meta-assoc-end "_17_0_4_1_e980341_1379972961715_643317_4305" 
    :type |SurrogateAnnotationProperty| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1379972961715_653359_4303" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== SurrogateDatatypeProperty
;;; =========================================================
(def-meta-stereotype |SurrogateDatatypeProperty| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|surrogateProperty|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_630020f_1262642885726_64965_1284")
 ""
  ((|base_Class| :xmi-id "_16_6_630020f_1262642891488_532746_1286"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_6_630020f_1262642891488_886851_1285"      
  :name |unamed-assoc-51|      
  :metatype :extension      
  :member-ends ((|SurrogateDatatypeProperty| "base_Class")
                ("_16_6_630020f_1262642891488_504827_1287" "extension_"))      
  :owned-ends  (("_16_6_630020f_1262642891488_504827_1287" "extension_")))

(def-meta-assoc-end "_16_6_630020f_1262642891488_504827_1287" 
    :type |SurrogateDatatypeProperty| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1262642891488_886851_1285" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== SurrogateObjectProperty
;;; =========================================================
(def-meta-stereotype |SurrogateObjectProperty| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|surrogateProperty|) :extends (UML241:|Class|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_630020f_1262642829902_31451_1257")
 ""
  ((|base_Class| :xmi-id "_16_6_630020f_1262642840224_449876_1259"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_16_6_630020f_1262642840224_729876_1258"      
  :name |unamed-assoc-22|      
  :metatype :extension      
  :member-ends ((|SurrogateObjectProperty| "base_Class")
                ("_16_6_630020f_1262642840224_265088_1260" "extension_"))      
  :owned-ends  (("_16_6_630020f_1262642840224_265088_1260" "extension_")))

(def-meta-assoc-end "_16_6_630020f_1262642840224_265088_1260" 
    :type |SurrogateObjectProperty| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1262642840224_729876_1258" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== UnionClass
;;; =========================================================
(def-meta-stereotype |UnionClass| 
   (:model :OWL-PROFILE :superclasses (|ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1255033015415_310027_967")
 "Union classes define the set of individuals that are members of the union
  of two or more class expressions."
  ((|isDisjointUnion| :xmi-id "_17_0_1_15100de_1300685778558_883989_1665"
    :range |Boolean| :multiplicity (0 1))))

;;; =========================================================
;;; ====================== UnionDatatype
;;; =========================================================
(def-meta-stereotype |UnionDatatype| 
   (:model :OWL-PROFILE :superclasses (|DataRange|) :extends (UML241:|DataType|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1299354353267_373446_2068")
 ""
  ((|base_DataType| :xmi-id "_16_9_15100de_1299354753178_61758_2356"
    :range UML241:|DataType| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299354753178_82398_2355"      
  :name |unamed-assoc-40|      
  :metatype :extension      
  :member-ends ((|UnionDatatype| "base_DataType")
                ("_16_9_15100de_1299354753178_605499_2357" "extension_UnionDatatype"))      
  :owned-ends  (("_16_9_15100de_1299354753178_605499_2357" "extension_UnionDatatype")))

(def-meta-assoc-end "_16_9_15100de_1299354753178_605499_2357" 
    :type |UnionDatatype| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299354753178_82398_2355" 
    :name "extension_UnionDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== allValuesFrom
;;; =========================================================
(def-meta-stereotype |allValuesFrom| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_15_0_1_137b03ac_1218003170728_400194_3316")
 "A restriction containing an owl:allValuesFrom constraint is used to describe
  a class of all individuals for which all values of the property under consideration
  are either members of the class extension of the class expression or are
  data values within the specified data range. All values expressions (object
  or data) are essentially used for universal quantification over property
  expressions."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1218004287540_739772_339"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1218004287524_94739_338"      
  :name |unamed-assoc-6|      
  :metatype :extension      
  :member-ends ((|allValuesFrom| "base_Dependency")
                ("_15_0_1_137b03ac_1218004287540_458292_340" "extension_allValuesFrom"))      
  :owned-ends  (("_15_0_1_137b03ac_1218004287540_458292_340" "extension_allValuesFrom")))

(def-meta-assoc-end "_15_0_1_137b03ac_1218004287540_458292_340" 
    :type |allValuesFrom| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1218004287524_94739_338" 
    :name "extension_allValuesFrom" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== annotatedProperty
;;; =========================================================
(def-meta-stereotype |annotatedProperty| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288733282284_197767_3093")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288733288836_498512_3095"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288733288836_399289_3094"      
  :name |unamed-assoc-20|      
  :metatype :extension      
  :member-ends ((|annotatedProperty| "base_Dependency")
                ("_16_8_e980341_1288733288837_801299_3096" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288733288837_801299_3096" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288733288837_801299_3096" 
    :type |annotatedProperty| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288733288836_399289_3094" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== annotatedSource
;;; =========================================================
(def-meta-stereotype |annotatedSource| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288733251623_301529_3069")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288733256762_918886_3071"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288733256762_209288_3070"      
  :name |unamed-assoc-21|      
  :metatype :extension      
  :member-ends ((|annotatedSource| "base_Dependency")
                ("_16_8_e980341_1288733256763_472284_3072" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288733256763_472284_3072" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288733256763_472284_3072" 
    :type |annotatedSource| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288733256762_209288_3070" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== annotatedTarget
;;; =========================================================
(def-meta-stereotype |annotatedTarget| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288733318220_226339_3117")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288733323060_364513_3119"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288733323059_18873_3118"      
  :name |unamed-assoc-4|      
  :metatype :extension      
  :member-ends ((|annotatedTarget| "base_Dependency")
                ("_16_8_e980341_1288733323060_188394_3120" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288733323060_188394_3120" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288733323060_188394_3120" 
    :type |annotatedTarget| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288733323059_18873_3118" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== annotationProperty
;;; =========================================================
(def-meta-stereotype |annotationProperty| 
   (:model :OWL-PROFILE :superclasses (|Entity| RDF-PROFILE:|annotationProperty|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194320082953_752842_4020")
 "OWL annotations provide a means to add metadata or make statements about
  elements of an OWL ontology, including annotations of annotations, outside
  of the set of axioms used as a basis for reasoning."
  ())

(def-meta-constraint "annotationTarget" |annotationProperty| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(Entity)) or (self.target.oclType()=oclIsKindOf(RDFProfile::literal)) or (self.target.oclType()=oclIsKindOf(RDFProfile::IRI))")

;;; =========================================================
;;; ====================== assertionProperty
;;; =========================================================
(def-meta-stereotype |assertionProperty| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288732352677_264839_2930")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288732357991_247049_2932"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288732357990_945642_2931"      
  :name |unamed-assoc-46|      
  :metatype :extension      
  :member-ends ((|assertionProperty| "base_Dependency")
                ("_16_8_e980341_1288732357991_712749_2933" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288732357991_712749_2933" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288732357991_712749_2933" 
    :type |assertionProperty| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288732357990_945642_2931" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== backwardCompatibleWith
;;; =========================================================
(def-meta-stereotype |backwardCompatibleWith| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|builtInVocabularyElement|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194324599531_868732_4176")
 "The owl:backwardCompatibleWith annotation property specifies the IRI of
  a prior version of the containing ontology that is compatible with the
  current version of the containing ontology. Within a UML model, owl:backwardCompatibleWith
  is represented as a dependency from the current model to the model that
  is a compatible prior version. This typically means that any changes made
  are non-destructive (additive and logically consistent with the earlier
  version)."
  ())

(def-meta-constraint "SourceMustBeAnOntologyOrIRI" |backwardCompatibleWith| 
   ""
   :operation-body
   "(self.source.oclType()=oclIsKindOf(owlOntology)) or (self.source.oclType()=oclIsKindOf(RDFProfile::IRI))")

(def-meta-constraint "TargetMustBeAnIRI" |backwardCompatibleWith| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(RDFProfile::IRI))")

;;; =========================================================
;;; ====================== complementOf
;;; =========================================================
(def-meta-stereotype |complementOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194327435046_139665_4501")
 "A complementOf dependency links a class to a class extension, and means
  that the extension of the target class represents the set complement of
  the source class (i.e., the extension of the target class contains exactly
  those individuals that do not belong to the extension of the source class).
  owl:complementOf is analogous to logical negation."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202880979500_84622_2399"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202880979500_615963_2398"      
  :name |unamed-assoc-9|      
  :metatype :extension      
  :member-ends ((|complementOf| "base_Dependency")
                ("_15_0_1_137b03ac_1202880979500_797089_2400" "extension_complementOf"))      
  :owned-ends  (("_15_0_1_137b03ac_1202880979500_797089_2400" "extension_complementOf")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202880979500_797089_2400" 
    :type |complementOf| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202880979500_615963_2398" 
    :name "extension_complementOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== datatypeFacet
;;; =========================================================
(def-meta-stereotype |datatypeFacet| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303923851650_829554_1722")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303923863801_176413_1724"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303923863800_437284_1723"      
  :name |unamed-assoc-65|      
  :metatype :extension      
  :member-ends ((|datatypeFacet| "base_Dependency")
                ("_17_0_1_15100de_1303923863801_192676_1725" "extension_"))      
  :owned-ends  (("_17_0_1_15100de_1303923863801_192676_1725" "extension_")))

(def-meta-assoc-end "_17_0_1_15100de_1303923863801_192676_1725" 
    :type |datatypeFacet| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303923863800_437284_1723" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== datatypeProperty
;;; =========================================================
(def-meta-stereotype |datatypeProperty| 
   (:model :OWL-PROFILE :superclasses (|owlProperty|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194369733718_478221_1166")
 "Data properties in OWL link individuals to data values."
  ())

;;; =========================================================
;;; ====================== deprecated
;;; =========================================================
(def-meta-stereotype |deprecated| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|builtInVocabularyElement|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288228523510_117525_3413")
 "An annotation with the owl:deprecated annotation property and the value
  equal to true (xsd boolean) can be used to specify that an IRI is deprecated."
  ())

(def-meta-constraint "deprecatedTarget" |deprecated| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(xsd::boolean))")

;;; =========================================================
;;; ====================== differentFrom
;;; =========================================================
(def-meta-stereotype |differentFrom| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194371089171_459705_1640")
 "owl:differentFrom is used to state that two URI references refer to different
  individuals."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202881053078_710118_2414"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202881053078_999916_2413"      
  :name |unamed-assoc-23|      
  :metatype :extension      
  :member-ends ((|differentFrom| "base_Dependency")
                ("_15_0_1_137b03ac_1202881053078_959174_2415" "extension_differentFrom"))      
  :owned-ends  (("_15_0_1_137b03ac_1202881053078_959174_2415" "extension_differentFrom")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202881053078_959174_2415" 
    :type |differentFrom| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202881053078_999916_2413" 
    :name "extension_differentFrom" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== differentIndividuals
;;; =========================================================
(def-meta-stereotype |differentIndividuals| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749038941_891312_1809")
 ""
  ())

;;; =========================================================
;;; ====================== disjointClasses
;;; =========================================================
(def-meta-stereotype |disjointClasses| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749024117_442984_1716")
 ""
  ())

;;; =========================================================
;;; ====================== disjointProperties
;;; =========================================================
(def-meta-stereotype |disjointProperties| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749029859_298642_1747")
 ""
  ())

;;; =========================================================
;;; ====================== disjointProperty
;;; =========================================================
(def-meta-stereotype |disjointProperty| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288305219000_505252_5294")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288305224323_306340_5296"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288305224323_328966_5295"      
  :name |unamed-assoc-33|      
  :metatype :extension      
  :member-ends ((|disjointProperty| "base_Dependency")
                ("_16_8_e980341_1288305224324_493928_5297" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288305224324_493928_5297" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288305224324_493928_5297" 
    :type |disjointProperty| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288305224323_328966_5295" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== disjointUnionOf
;;; =========================================================
(def-meta-stereotype |disjointUnionOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_5_4_630020f_1254953264837_235926_972")
 "A disjointUnionOf generalization set is used together with an anonymous
  unionClass to define a set union (that is explicitly disjoint). The generalization
  set is drawn from the member class expressions to the anonymous union class
  (i.e., the arrow-head should point to the unionClass). A union can contain
  one or more member class extensions. In order to model this, the ontologist
  must draw individual generalizations, stereotyped by disjointUnionOf, from
  each member class expression to the anonymous unionClass, then select and
  group the generalizations together as a generalization set, also stereotyped
  by disjointUnionOf. In order to match the OWL semantics, the generalization
  set should be covering and disjoint (see unionOf for cases where members
  of the union may be overlapping). Note that intersections in OWL are analogous
  to logical disjunction."
  ((|base_Generalization| :xmi-id "_16_6_630020f_1265505110199_306578_1255"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-constraint "IsCovering" |disjointUnionOf| 
   ""
   :operation-body
   "isCovering=true")

(def-meta-constraint "IsDisjoint" |disjointUnionOf| 
   ""
   :operation-body
   "isDisjoint=true")

(def-meta-assoc "_16_6_630020f_1265505110199_613077_1254"      
  :name |unamed-assoc-49|      
  :metatype :extension      
  :member-ends ((|disjointUnionOf| "base_Generalization")
                ("_16_6_630020f_1265505110199_152334_1256" "extension_disjointUnionOf"))      
  :owned-ends  (("_16_6_630020f_1265505110199_152334_1256" "extension_disjointUnionOf")))

(def-meta-assoc-end "_16_6_630020f_1265505110199_152334_1256" 
    :type |disjointUnionOf| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1265505110199_613077_1254" 
    :name "extension_disjointUnionOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== disjointWith
;;; =========================================================
(def-meta-stereotype |disjointWith| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194367207421_103646_1102")
 "A disjointWith dependency links a class with a class expression, and states
  that the source and target classes have no individuals in their extensions
  in common."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202880522890_935408_2369"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202880522890_711011_2368"      
  :name |unamed-assoc-56|      
  :metatype :extension      
  :member-ends ((|disjointWith| "base_Dependency")
                ("_15_0_1_137b03ac_1202880522890_156309_2370" "extension_disjointWith"))      
  :owned-ends  (("_15_0_1_137b03ac_1202880522890_156309_2370" "extension_disjointWith")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202880522890_156309_2370" 
    :type |disjointWith| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202880522890_711011_2368" 
    :name "extension_disjointWith" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== distinctMember
;;; =========================================================
(def-meta-stereotype |distinctMember| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194371151656_268356_1669")
 "distinctMember is used together with an instance of the foundation library
  AllDifferent class as an idiom for stating that a list of individuals are
  all different."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202881079281_367794_2419"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202881079281_754706_2418"      
  :name |unamed-assoc-7|      
  :metatype :extension      
  :member-ends ((|distinctMember| "base_Dependency")
                ("_15_0_1_137b03ac_1202881079281_112874_2420" "extension_allDifferent"))      
  :owned-ends  (("_15_0_1_137b03ac_1202881079281_112874_2420" "extension_allDifferent")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202881079281_112874_2420" 
    :type |distinctMember| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202881079281_754706_2418" 
    :name "extension_allDifferent" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== equivalentClass
;;; =========================================================
(def-meta-stereotype |equivalentClass| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194367300515_647326_1131")
 "An equivalentClass dependency links a class to a class expression, and
  means that the two classes have exactly the same extension (i.e., the exact
  same set of individuals comprise their extension)."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202881002765_387348_2404"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_16_6_630020f_1265505402574_233864_1620"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202881002765_668870_2403"      
  :name |unamed-assoc-27|      
  :metatype :extension      
  :member-ends ((|equivalentClass| "base_Dependency")
                ("_15_0_1_137b03ac_1202881002765_394843_2405" "extension_equivalentClass"))      
  :owned-ends  (("_15_0_1_137b03ac_1202881002765_394843_2405" "extension_equivalentClass")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202881002765_394843_2405" 
    :type |equivalentClass| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202881002765_668870_2403" 
    :name "extension_equivalentClass" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_6_630020f_1265505402574_367840_1619"      
  :name |unamed-assoc-47|      
  :metatype :extension      
  :member-ends ((|equivalentClass| "base_Generalization")
                ("_16_6_630020f_1265505402574_115025_1621" "extension_equivalentClass"))      
  :owned-ends  (("_16_6_630020f_1265505402574_115025_1621" "extension_equivalentClass")))

(def-meta-assoc-end "_16_6_630020f_1265505402574_115025_1621" 
    :type |equivalentClass| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1265505402574_367840_1619" 
    :name "extension_equivalentClass" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== equivalentClasses
;;; =========================================================
(def-meta-stereotype |equivalentClasses| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291748956457_218101_1649")
 ""
  ())

;;; =========================================================
;;; ====================== equivalentDatatype
;;; =========================================================
(def-meta-stereotype |equivalentDatatype| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1298771382155_422672_1657")
 ""
  ((|base_Dependency| :xmi-id "_16_9_15100de_1298771425487_561838_1674"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_16_9_15100de_1298771425484_283486_1669"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1298771425487_528875_1673"      
  :name |unamed-assoc-31|      
  :metatype :extension      
  :member-ends ((|equivalentDatatype| "base_Dependency")
                ("_16_9_15100de_1298771425487_607410_1675" "extension_equivalentDatatype"))      
  :owned-ends  (("_16_9_15100de_1298771425487_607410_1675" "extension_equivalentDatatype")))

(def-meta-assoc-end "_16_9_15100de_1298771425487_607410_1675" 
    :type |equivalentDatatype| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1298771425487_528875_1673" 
    :name "extension_equivalentDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_9_15100de_1298771425483_404064_1668"      
  :name |unamed-assoc-36|      
  :metatype :extension      
  :member-ends ((|equivalentDatatype| "base_Generalization")
                ("_16_9_15100de_1298771425484_101781_1670" "extension_equivalentDatatype"))      
  :owned-ends  (("_16_9_15100de_1298771425484_101781_1670" "extension_equivalentDatatype")))

(def-meta-assoc-end "_16_9_15100de_1298771425484_101781_1670" 
    :type |equivalentDatatype| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1298771425483_404064_1668" 
    :name "extension_equivalentDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== equivalentProperties
;;; =========================================================
(def-meta-stereotype |equivalentProperties| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749016988_10308_1685")
 ""
  ())

;;; =========================================================
;;; ====================== equivalentProperty
;;; =========================================================
(def-meta-stereotype |equivalentProperty| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194370383046_902286_1389")
 "An equivalentProperty dependency links a property to a property expression,
  and means that the two properties have exactly the same extension (i.e.,
  the properties are synonymous, and can be used interchangeably without
  changing the meaning of the ontology)."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202880474937_778403_2231"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_16_6_1_15100de_1267002336474_923238_1225"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_16_6_1_15100de_1267002336474_77302_1224"      
  :name |unamed-assoc-12|      
  :metatype :extension      
  :member-ends ((|equivalentProperty| "base_Generalization")
                ("_16_6_1_15100de_1267002336474_879872_1226" "extension_equivalentProperty"))      
  :owned-ends  (("_16_6_1_15100de_1267002336474_879872_1226" "extension_equivalentProperty")))

(def-meta-assoc-end "_16_6_1_15100de_1267002336474_879872_1226" 
    :type |equivalentProperty| 
    :multiplicity (0 1) 
    :association "_16_6_1_15100de_1267002336474_77302_1224" 
    :name "extension_equivalentProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_15_0_1_137b03ac_1202880474937_680746_2230"      
  :name |unamed-assoc-48|      
  :metatype :extension      
  :member-ends ((|equivalentProperty| "base_Dependency")
                ("_15_0_1_137b03ac_1202880474937_189_2232" "extension_equivalentProperty"))      
  :owned-ends  (("_15_0_1_137b03ac_1202880474937_189_2232" "extension_equivalentProperty")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202880474937_189_2232" 
    :type |equivalentProperty| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202880474937_680746_2230" 
    :name "extension_equivalentProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== hasDataRange
;;; =========================================================
(def-meta-stereotype |hasDataRange| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_4_1_e980341_1383940357741_981779_4597")
 ""
  ((|base_Dependency| :xmi-id "_17_0_4_1_e980341_1383940376756_779700_4599"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_4_1_e980341_1383940376755_935856_4598"      
  :name |unamed-assoc-77|      
  :metatype :extension      
  :member-ends ((|hasDataRange| "base_Dependency")
                ("_17_0_4_1_e980341_1383940376756_853402_4600" "extension_"))      
  :owned-ends  (("_17_0_4_1_e980341_1383940376756_853402_4600" "extension_")))

(def-meta-assoc-end "_17_0_4_1_e980341_1383940376756_853402_4600" 
    :type |hasDataRange| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1383940376755_935856_4598" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== hasKey
;;; =========================================================
(def-meta-stereotype |hasKey| 
   (:model :OWL-PROFILE :superclasses (|Axiom|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288359422075_870880_2563")
 "A key axiom HasKey( CE ( OPE1 ... OPEm ) ( DPE1 ... DPEn ) ) states that
  each (named) instance of the class expression CE is uniquely identified
  by the object property expressions OPEi and/or the data property experssions
  DPEj     that is, no two distinct (named) instances of CE can coincide
  on the values of all object property expressions OPEi and all data property
  expressions DPEj. In each such axiom in an OWL ontology, m or n (or both)
  MUST be larger than zero. A key axiom of the form HasKey( owl:Thing ( OPE
  ) () ) is similar to the axiom InverseFunctionalObjectProperty( OPE ),
  the main differences being that the former axiom is applicable only to
  individuals that are explicitly named in an ontology, while the latter
  axiom is also applicable to individuals whose existence is implied by existential
  quantification."
  ((|base_Dependency| :xmi-id "_16_9_15100de_1299371866504_123935_1693"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299371866444_825625_1692"      
  :name |unamed-assoc-61|      
  :metatype :extension      
  :member-ends ((|hasKey| "base_Dependency")
                ("_16_9_15100de_1299371866505_254863_1694" "extension_hasKey"))      
  :owned-ends  (("_16_9_15100de_1299371866505_254863_1694" "extension_hasKey")))

(def-meta-assoc-end "_16_9_15100de_1299371866505_254863_1694" 
    :type |hasKey| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299371866444_825625_1692" 
    :name "extension_hasKey" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== hasSelf
;;; =========================================================
(def-meta-stereotype |hasSelf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288299585746_786496_5134")
 "The ObjectHasSelf class expression contains those individuals that are
  connected by an object property expression to themselves."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288299605732_731997_5136"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288299605732_326852_5135"      
  :name |unamed-assoc-5|      
  :metatype :extension      
  :member-ends ((|hasSelf| "base_Dependency")
                ("_16_8_e980341_1288299605732_954510_5137" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288299605732_954510_5137" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288299605732_954510_5137" 
    :type |hasSelf| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288299605732_326852_5135" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== hasValue
;;; =========================================================
(def-meta-stereotype |hasValue| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_15_0_1_137b03ac_1218004603149_244122_426")
 "A restriction containing an owl:hasValue constraint is used to describe
  a class of all individuals for which the property under consideration has
  at least one value semantically equal to the value of the restriction (it
  may have others)."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1218004725071_132572_433"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1218004725071_765436_432"      
  :name |unamed-assoc-15|      
  :metatype :extension      
  :member-ends ((|hasValue| "base_Dependency")
                ("_15_0_1_137b03ac_1218004725071_659881_434" "extension_hasValue"))      
  :owned-ends  (("_15_0_1_137b03ac_1218004725071_659881_434" "extension_hasValue")))

(def-meta-assoc-end "_15_0_1_137b03ac_1218004725071_659881_434" 
    :type |hasValue| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1218004725071_765436_432" 
    :name "extension_hasValue" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== incompatibleWith
;;; =========================================================
(def-meta-stereotype |incompatibleWith| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|builtInVocabularyElement|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194324816000_910224_4234")
 "The owl:incompatibleWith annotation property specifies the IRI of a prior
  version of the containing ontology that is incompatible with the current
  version of the containing ontology. Within a UML model, owl:incompatibleWith
  is represented as a dependency from the current model to the model that
  is an incompatible prior version."
  ())

(def-meta-constraint "SourceMustBeAnOntologyOrIRI" |incompatibleWith| 
   ""
   :operation-body
   "(self.source.oclType()=oclIsKindOf(owlOntology)) or (self.source.oclType()=oclIsKindOf(RDFProfile::IRI))")

(def-meta-constraint "TargetMustBeAnIRI" |incompatibleWith| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(RDFProfile::IRI))")

;;; =========================================================
;;; ====================== integer
;;; =========================================================
(def-meta-class |integer| 
   (:model :OWL-PROFILE :superclasses NIL 
    :packages (|OWLProfile|) 
    :xmi-id "_17_0_1_15100de_1303239054484_193401_2311")
 ""
  ())

;;; =========================================================
;;; ====================== intersectionOf
;;; =========================================================
(def-meta-stereotype |intersectionOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194366769812_837442_1073")
 "An intersectionOf generalization is used together with an anonymous intersectionClass
  to define a set intersection. The generalization is drawn from the intersection
  class to a class expression that is a member of the intersection (i.e.,
  the arrow-head should point to the class extension at the opposite end
  of the relationship from the intersectionClass). An intersection can contain
  one or more member class extensions. Note that intersections in OWL are
  analogous to logical conjunction."
  ((|base_Dependency| :xmi-id "_16_9_15100de_1292105874161_17160_1616"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_15_0_1_137b03ac_1203013883734_929194_1779"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1292105874160_763763_1615"      
  :name |unamed-assoc-24|      
  :metatype :extension      
  :member-ends ((|intersectionOf| "base_Dependency")
                ("_16_9_15100de_1292105874162_236865_1617" "extension_intersectionOf"))      
  :owned-ends  (("_16_9_15100de_1292105874162_236865_1617" "extension_intersectionOf")))

(def-meta-assoc-end "_16_9_15100de_1292105874162_236865_1617" 
    :type |intersectionOf| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1292105874160_763763_1615" 
    :name "extension_intersectionOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_15_0_1_137b03ac_1203013883734_956239_1778"      
  :name |unamed-assoc-8|      
  :metatype :extension      
  :member-ends ((|intersectionOf| "base_Generalization")
                ("_15_0_1_137b03ac_1203013883750_471815_1780" "extension_intersectionOf"))      
  :owned-ends  (("_15_0_1_137b03ac_1203013883750_471815_1780" "extension_intersectionOf")))

(def-meta-assoc-end "_15_0_1_137b03ac_1203013883750_471815_1780" 
    :type |intersectionOf| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1203013883734_956239_1778" 
    :name "extension_intersectionOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== inverseOf
;;; =========================================================
(def-meta-stereotype |inverseOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194370700765_231238_1554")
 "In RDF and OWL, all properties are binary and directed, from domain to
  range. Similarly to UML, property inverses can be either implicit or explicit
  -- owl:inverseOf allows us to make such properties explicit in OWL. Because
  of the directional nature of properties in OWL, although the reverse of
  an inverse can be inferred, it is sometimes useful to state both directions,
  in order to increase run-time performance for some applications. Note that
  the domain and range of an OWL inverse property must be object properties."
  ((|base_Dependency| :xmi-id "_16_0_1_630020f_1243638647196_519408_371"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_630020f_1243638647195_160715_370"      
  :name |unamed-assoc-13|      
  :metatype :extension      
  :member-ends ((|inverseOf| "base_Dependency")
                ("_16_0_1_630020f_1243638647196_600134_372" "extension_inverseOf"))      
  :owned-ends  (("_16_0_1_630020f_1243638647196_600134_372" "extension_inverseOf")))

(def-meta-assoc-end "_16_0_1_630020f_1243638647196_600134_372" 
    :type |inverseOf| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1243638647195_160715_370" 
    :name "extension_inverseOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== inverseProperty
;;; =========================================================
(def-meta-stereotype |inverseProperty| 
   (:model :OWL-PROFILE :superclasses (|objectProperty|) :extends (UML241:|Property| UML241:|Class| UML241:|Association|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291791117330_591958_1669")
 ""
  ((|base_Association| :xmi-id "_16_9_15100de_1291791132341_699495_1713"
    :range UML241:|Association| :multiplicity (1 1))
   (|base_Class| :xmi-id "_16_9_15100de_1299373523785_91705_1863"
    :range UML241:|Class| :multiplicity (1 1))
   (|base_Property| :xmi-id "_16_9_15100de_1291791132337_201283_1708"
    :range UML241:|Property| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1291791132341_526013_1712"      
  :name |unamed-assoc-16|      
  :metatype :extension      
  :member-ends ((|inverseProperty| "base_Association")
                ("_16_9_15100de_1291791132341_546960_1714" "extension_"))      
  :owned-ends  (("_16_9_15100de_1291791132341_546960_1714" "extension_")))

(def-meta-assoc-end "_16_9_15100de_1291791132341_546960_1714" 
    :type |inverseProperty| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1291791132341_526013_1712" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_9_15100de_1299373523785_344628_1862"      
  :name |unamed-assoc-29|      
  :metatype :extension      
  :member-ends ((|inverseProperty| "base_Class")
                ("_16_9_15100de_1299373523785_707515_1864" "extension_inverseProperty"))      
  :owned-ends  (("_16_9_15100de_1299373523785_707515_1864" "extension_inverseProperty")))

(def-meta-assoc-end "_16_9_15100de_1299373523785_707515_1864" 
    :type |inverseProperty| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299373523785_344628_1862" 
    :name "extension_inverseProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_9_15100de_1291791132336_653358_1707"      
  :name |unamed-assoc-32|      
  :metatype :extension      
  :member-ends ((|inverseProperty| "base_Property")
                ("_16_9_15100de_1291791132337_784827_1709" "extension_"))      
  :owned-ends  (("_16_9_15100de_1291791132337_784827_1709" "extension_")))

(def-meta-assoc-end "_16_9_15100de_1291791132337_784827_1709" 
    :type |inverseProperty| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1291791132336_653358_1707" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== langRange
;;; =========================================================
(def-meta-stereotype |langRange| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924317275_184552_1984")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924354753_875365_2024"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924354753_704745_2023"      
  :name |unamed-assoc-66|      
  :metatype :extension      
  :member-ends ((|langRange| "base_Dependency")
                ("_17_0_1_15100de_1303924354754_548009_2025" "extension_langRange"))      
  :owned-ends  (("_17_0_1_15100de_1303924354754_548009_2025" "extension_langRange")))

(def-meta-assoc-end "_17_0_1_15100de_1303924354754_548009_2025" 
    :type |langRange| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924354753_704745_2023" 
    :name "extension_langRange" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== length
;;; =========================================================
(def-meta-stereotype |length| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924285281_717231_1886")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924358846_116769_2042"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924358846_108164_2041"      
  :name |unamed-assoc-67|      
  :metatype :extension      
  :member-ends ((|length| "base_Dependency")
                ("_17_0_1_15100de_1303924358846_612575_2043" "extension_length"))      
  :owned-ends  (("_17_0_1_15100de_1303924358846_612575_2043" "extension_length")))

(def-meta-assoc-end "_17_0_1_15100de_1303924358846_612575_2043" 
    :type |length| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924358846_108164_2041" 
    :name "extension_length" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== maxExclusive
;;; =========================================================
(def-meta-stereotype |maxExclusive| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924249473_838632_1822")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924375567_789000_2096"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924375567_764937_2095"      
  :name |unamed-assoc-70|      
  :metatype :extension      
  :member-ends ((|maxExclusive| "base_Dependency")
                ("_17_0_1_15100de_1303924375568_636528_2097" "extension_maxExclusive"))      
  :owned-ends  (("_17_0_1_15100de_1303924375568_636528_2097" "extension_maxExclusive")))

(def-meta-assoc-end "_17_0_1_15100de_1303924375568_636528_2097" 
    :type |maxExclusive| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924375567_764937_2095" 
    :name "extension_maxExclusive" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== maxInclusive
;;; =========================================================
(def-meta-stereotype |maxInclusive| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303765303982_472403_1740")
 ""
  ())

;;; =========================================================
;;; ====================== maxLength
;;; =========================================================
(def-meta-stereotype |maxLength| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924298488_807096_1917")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924369022_857864_2078"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924369022_371123_2077"      
  :name |unamed-assoc-69|      
  :metatype :extension      
  :member-ends ((|maxLength| "base_Dependency")
                ("_17_0_1_15100de_1303924369022_72733_2079" "extension_maxLength"))      
  :owned-ends  (("_17_0_1_15100de_1303924369022_72733_2079" "extension_maxLength")))

(def-meta-assoc-end "_17_0_1_15100de_1303924369022_72733_2079" 
    :type |maxLength| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924369022_371123_2077" 
    :name "extension_maxLength" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== members
;;; =========================================================
(def-meta-stereotype |members| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288726869106_737025_2531")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288726877571_610371_2533"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288726877570_248191_2532"      
  :name |unamed-assoc-14|      
  :metatype :extension      
  :member-ends ((|members| "base_Dependency")
                ("_16_8_e980341_1288726877571_356462_2534" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288726877571_356462_2534" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288726877571_356462_2534" 
    :type |members| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288726877570_248191_2532" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== minExclusive
;;; =========================================================
(def-meta-stereotype |minExclusive| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924226193_535890_1791")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924364815_221323_2060"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924364815_445061_2059"      
  :name |unamed-assoc-68|      
  :metatype :extension      
  :member-ends ((|minExclusive| "base_Dependency")
                ("_17_0_1_15100de_1303924364815_188479_2061" "extension_minExclusive"))      
  :owned-ends  (("_17_0_1_15100de_1303924364815_188479_2061" "extension_minExclusive")))

(def-meta-assoc-end "_17_0_1_15100de_1303924364815_188479_2061" 
    :type |minExclusive| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924364815_445061_2059" 
    :name "extension_minExclusive" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== minInclusive
;;; =========================================================
(def-meta-stereotype |minInclusive| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303765279790_740161_1710")
 ""
  ())

;;; =========================================================
;;; ====================== minLength
;;; =========================================================
(def-meta-stereotype |minLength| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924266729_797314_1855")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924380879_724907_2114"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924380879_755041_2113"      
  :name |unamed-assoc-71|      
  :metatype :extension      
  :member-ends ((|minLength| "base_Dependency")
                ("_17_0_1_15100de_1303924380880_708718_2115" "extension_minLength"))      
  :owned-ends  (("_17_0_1_15100de_1303924380880_708718_2115" "extension_minLength")))

(def-meta-assoc-end "_17_0_1_15100de_1303924380880_708718_2115" 
    :type |minLength| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924380879_755041_2113" 
    :name "extension_minLength" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== naryAxiom
;;; =========================================================
(def-meta-stereotype |naryAxiom| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749454378_711354_1942")
 ""
  ((|base_InstanceSpecification| :xmi-id "_16_9_15100de_1291749464920_79262_1944"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|operand| :xmi-id "_16_9_15100de_1291749885507_316383_2209"
    :range RDF-PROFILE:|resource| :multiplicity (0 -1))))

(def-meta-assoc "_16_9_15100de_1291749464920_863838_1943"      
  :name |unamed-assoc-57|      
  :metatype :extension      
  :member-ends ((|naryAxiom| "base_InstanceSpecification")
                ("_16_9_15100de_1291749464921_108140_1945" "extension_"))      
  :owned-ends  (("_16_9_15100de_1291749464921_108140_1945" "extension_")))

(def-meta-assoc-end "_16_9_15100de_1291749464921_108140_1945" 
    :type |naryAxiom| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1291749464920_863838_1943" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== objectProperty
;;; =========================================================
(def-meta-stereotype |objectProperty| 
   (:model :OWL-PROFILE :superclasses (|owlProperty|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194369864359_316287_1200")
 "Object properties in OWL link individuals to other individuals."
  ((|isAsymmetric| :xmi-id "_16_5_4_630020f_1257373342538_873208_921"
    :range |Boolean| :multiplicity (0 1))
   (|isInverseFunctional| :xmi-id "_12_5_1_137b03ac_1194369925281_156632_1216"
    :range |Boolean| :multiplicity (0 1))
   (|isIrreflexive| :xmi-id "_16_5_4_630020f_1257373291140_340306_917"
    :range |Boolean| :multiplicity (0 1))
   (|isReflexive| :xmi-id "_16_5_4_630020f_1257373167888_204109_913"
    :range |Boolean| :multiplicity (0 1))
   (|isSymmetric| :xmi-id "_12_5_1_137b03ac_1194369964625_918729_1219"
    :range |Boolean| :multiplicity (0 1))
   (|isTransitive| :xmi-id "_12_5_1_2c17055e_1195867072829_603538_2738"
    :range |Boolean| :multiplicity (0 1))))

;;; =========================================================
;;; ====================== onClass
;;; =========================================================
(def-meta-stereotype |onClass| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288299181064_391266_5097")
 "All cardinality restrictions can be qualified or unqualified: in the former
  case, the cardinality restriction only applies to individuals that are
  connected by the object property expression and are instances of the qualifying
  class expression; in the latter case the restriction applies to all individuals
  that are connected by the object property expression (this is equivalent
  to the qualified case with the qualifying class expression equal to owl:Thing).
  The onClass stereotype is used for qualified cardinality restrictions to
  indicate the qualifying class expression."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288299190071_468302_5099"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288299190071_936098_5098"      
  :name |unamed-assoc-37|      
  :metatype :extension      
  :member-ends ((|onClass| "base_Dependency")
                ("_16_8_e980341_1288299190090_8310_5100" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288299190090_8310_5100" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288299190090_8310_5100" 
    :type |onClass| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288299190071_936098_5098" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== onDataRange
;;; =========================================================
(def-meta-stereotype |onDataRange| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288498067355_304228_2702")
 "For use with qualified cardinality constraints on data properties, the
  onDataRange dependency links the restriction class to the qualifying datatype."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288498081524_303004_2704"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288498081524_579184_2703"      
  :name |unamed-assoc-45|      
  :metatype :extension      
  :member-ends ((|onDataRange| "base_Dependency")
                ("_16_8_e980341_1288498081525_101717_2705" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288498081525_101717_2705" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288498081525_101717_2705" 
    :type |onDataRange| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288498081524_579184_2703" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== onDatatype
;;; =========================================================
(def-meta-stereotype |onDatatype| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288487609287_865266_2659")
 "A datatype restriction DatatypeRestriction( DT F1 lt1 ... Fn ltn ) consists
  of a unary datatype DT and n pairs ( Fi , lti ). The resulting data range
  is unary and is obtained by restricting the value space of DT according
  to the semantics of all ( Fi , vi ) (multiple pairs are interpreted conjunctively),
  where vi are the data values of the literals lti. The onDatatype dependency
  links the datatype in question to the restriction."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288487617300_671787_2661"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288487617300_992240_2660"      
  :name |unamed-assoc-55|      
  :metatype :extension      
  :member-ends ((|onDatatype| "base_Dependency")
                ("_16_8_e980341_1288487617300_344982_2662" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288487617300_344982_2662" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288487617300_344982_2662" 
    :type |onDatatype| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288487617300_992240_2660" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== onProperties
;;; =========================================================
(def-meta-stereotype |onProperties| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288486081114_390863_2585")
 "An onProperties dependency links a restriction class to the data properties
  that it restricts. This construct is used to support n-ary existential
  and universal quantification over data properties."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288486088976_118442_2587"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288486088975_362315_2586"      
  :name |unamed-assoc-53|      
  :metatype :extension      
  :member-ends ((|onProperties| "base_Dependency")
                ("_16_8_e980341_1288486088976_77099_2588" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288486088976_77099_2588" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288486088976_77099_2588" 
    :type |onProperties| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288486088975_362315_2586" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== onProperty
;;; =========================================================
(def-meta-stereotype |onProperty| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_15_0_1_137b03ac_1217058334841_980646_2955")
 "An onProperty dependency links a restriction class to the property that
  it restricts. A particular restriction should be linked to one and only
  one property."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1217058403793_953993_2962"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1217058403793_109992_2961"      
  :name |unamed-assoc-35|      
  :metatype :extension      
  :member-ends ((|onProperty| "base_Dependency")
                ("_15_0_1_137b03ac_1217058403793_753022_2963" "extension_onProperty"))      
  :owned-ends  (("_15_0_1_137b03ac_1217058403793_753022_2963" "extension_onProperty")))

(def-meta-assoc-end "_15_0_1_137b03ac_1217058403793_753022_2963" 
    :type |onProperty| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1217058403793_109992_2961" 
    :name "extension_onProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== onType
;;; =========================================================
(def-meta-stereotype |onType| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1299269260362_93889_1897")
 ""
  ((|base_Dependency| :xmi-id "_16_9_15100de_1299269318572_520290_1917"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299269318572_722048_1916"      
  :name |unamed-assoc-60|      
  :metatype :extension      
  :member-ends ((|onType| "base_Dependency")
                ("_16_9_15100de_1299269318572_725969_1918" "extension_onType"))      
  :owned-ends  (("_16_9_15100de_1299269318572_725969_1918" "extension_onType")))

(def-meta-assoc-end "_16_9_15100de_1299269318572_725969_1918" 
    :type |onType| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299269318572_722048_1916" 
    :name "extension_onType" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== oneOf
;;; =========================================================
(def-meta-stereotype |oneOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_6_2_15100de_1273123479441_410669_458")
 ""
  ((|base_Dependency| :xmi-id "_16_6_2_15100de_1273123496928_866018_465"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_6_2_15100de_1273123496928_553021_464"      
  :name |unamed-assoc-28|      
  :metatype :extension      
  :member-ends ((|oneOf| "base_Dependency")
                ("_16_6_2_15100de_1273123496928_883527_466" "extension_oneOf"))      
  :owned-ends  (("_16_6_2_15100de_1273123496928_883527_466" "extension_oneOf")))

(def-meta-assoc-end "_16_6_2_15100de_1273123496928_883527_466" 
    :type |oneOf| 
    :multiplicity (0 1) 
    :association "_16_6_2_15100de_1273123496928_553021_464" 
    :name "extension_oneOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== operand
;;; =========================================================
(def-meta-stereotype |operand| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749757579_877874_2153")
 ""
  ((|base_Dependency| :xmi-id "_16_9_15100de_1291749846876_99188_2155"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|index| :xmi-id "_17_0_1_15100de_1303064483355_9108_1845"
    :range |Integer| :multiplicity (1 1) :default 0)
   (|name| :xmi-id "_17_0_1_15100de_1303520989477_565084_1681"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "_16_9_15100de_1291749846876_99045_2154"      
  :name |unamed-assoc-52|      
  :metatype :extension      
  :member-ends ((|operand| "base_Dependency")
                ("_16_9_15100de_1291749846877_20986_2156" "extension_"))      
  :owned-ends  (("_16_9_15100de_1291749846877_20986_2156" "extension_")))

(def-meta-assoc-end "_16_9_15100de_1291749846877_20986_2156" 
    :type |operand| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1291749846876_99045_2154" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== owlClass
;;; =========================================================
(def-meta-stereotype |owlClass| 
   (:model :OWL-PROFILE :superclasses (|Entity| |ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194325238078_997500_4316")
 "The class of OWL classes. In OWL 2, the class of -named- OWL classes. Like
  RDF classes (and, in fact, UML classes), every OWL class represents a set
  of individuals, i.e., its extension. A class has an intensional meaning
  (the underlying concept) which is related but not equal to its class extension.
  Two classes may have the same extension, yet define unique concepts. The
  classic example here is the \"Morning Star\" vs. the \"Evening Star\"."
  ())

;;; =========================================================
;;; ====================== owlImports
;;; =========================================================
(def-meta-stereotype |owlImports| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|references|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194324728968_493854_4205")
 "An OWL ontology can import other ontologies in order to gain access to
  their entities, expressions, and axioms, thus providing the basic facility
  for ontology modularization. In UML, this feature is emulated through the
  package import facility."
  ())

;;; =========================================================
;;; ====================== owlIndividual
;;; =========================================================
(def-meta-stereotype |owlIndividual| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|namedResource|) :extends (UML241:|InstanceSpecification|)
 :packages (|OWLProfile|) 
 :xmi-id "_15_0_137b03ac_1201330208281_398389_2705")
 "Individuals in OWL are defined via individual axioms (facts), which may
  include facts about class membership and property values as well as facts
  regarding individual identity."
  ((|base_InstanceSpecification| :xmi-id "_15_0_137b03ac_1201330270796_222609_2712"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|isAnonymous| :xmi-id "_17_0_2_2_15100de_1355449328571_105111_2307"
    :range |Boolean| :multiplicity (0 1) :default :false)))

(def-meta-assoc "_15_0_137b03ac_1201330270796_84095_2711"      
  :name |unamed-assoc-25|      
  :metatype :extension      
  :member-ends ((|owlIndividual| "base_InstanceSpecification")
                ("_15_0_137b03ac_1201330270796_735256_2713" "extension_owlIndividual"))      
  :owned-ends  (("_15_0_137b03ac_1201330270796_735256_2713" "extension_owlIndividual")))

(def-meta-assoc-end "_15_0_137b03ac_1201330270796_735256_2713" 
    :type |owlIndividual| 
    :multiplicity (0 1) 
    :association "_15_0_137b03ac_1201330270796_84095_2711" 
    :name "extension_owlIndividual" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== owlOntology
;;; =========================================================
(def-meta-stereotype |owlOntology| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|rdfSource|) :extends (UML241:|Package|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194319654750_608170_3796")
 "An ontology specifies a rich description of the terminology, concepts,
  and the relationships among those concepts relevant to a particular domain
  or area of interest. Ontologies can provide insight into the nature of
  information particular to a given field and are essential to any attempts
  to arrive at a shared understanding of the relevant concepts. They may
  be specified at various levels of complexity and formality depending on
  the domain and needs of the participants in a given conversation. An OWL
  ontology is an ontology that satisfies certain conditions given in the
  OWL language specifications. The main component of an OWL 2 ontology is
  its set of axioms. Because the association between an ontology and its
  axioms is a set, an ontology cannot contain two axioms that are structurally
  equivalent. Apart from axioms, ontologies can also contain ontology annotations,
  and they can also import other ontologies."
  ((|base_Package| :xmi-id "_17_0_2_2_15100de_1361749060018_945215_2304"
    :range UML241:|Package| :multiplicity (1 1))
   (|versionIRI| :xmi-id "_15_0_137b03ac_1201300096375_85649_4522"
    :range RDF-PROFILE:IRI :multiplicity (0 1))))

(def-meta-assoc "_17_0_2_2_15100de_1361749060018_486908_2303"      
  :name |unamed-assoc-75|      
  :metatype :extension      
  :member-ends ((|owlOntology| "base_Package")
                ("_17_0_2_2_15100de_1361749060019_545621_2305" "extension_owlOntology"))      
  :owned-ends  (("_17_0_2_2_15100de_1361749060019_545621_2305" "extension_owlOntology")))

(def-meta-assoc-end "_17_0_2_2_15100de_1361749060019_545621_2305" 
    :type |owlOntology| 
    :multiplicity (0 1) 
    :association "_17_0_2_2_15100de_1361749060018_486908_2303" 
    :name "extension_owlOntology" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== owlProperty
;;; =========================================================
(def-meta-stereotype |owlProperty| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|rdfProperty| |Entity|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194370054984_719501_1243")
 "owlProperty is an abstract stereotype used to collect properties common
  to both OWL object and datatype properties."
  ((|isFunctional| :xmi-id "_12_5_1_137b03ac_1194370134781_838016_1262"
    :range |Boolean| :multiplicity (0 1))))

;;; =========================================================
;;; ====================== owlPropertyGeneralizationSet
;;; =========================================================
(def-meta-class |owlPropertyGeneralizationSet| 
   (:model :OWL-PROFILE :superclasses NIL 
    :packages (|OWLProfile| |owlProperty|) 
    :xmi-id "_16_0_1_630020f_1244328363433_817848_770")
 ""
  ())

;;; =========================================================
;;; ====================== owlRestriction
;;; =========================================================
(def-meta-stereotype |owlRestriction| 
   (:model :OWL-PROFILE :superclasses (|ClassExpression|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194325570734_68953_4443")
 "Restriction classes are classes defined through property restrictions --
  they are defined by constraining set of individuals that may be included
  in the class by restricting range of a property of that class. These restrictions
  may include restrictions on the values that property may have, or the number
  of values it may have."
  ((|cardinality| :xmi-id "_16_0_1_630020f_1243640148444_793981_794"
    :range |UnlimitedNatural| :multiplicity (0 1))
   (|hasSelf| :xmi-id "_16_9_15100de_1299353622873_722121_1623"
    :range |Boolean| :multiplicity (0 1))
   (|maxCardinality| :xmi-id "_16_0_1_630020f_1243640263213_893874_804"
    :range |UnlimitedNatural| :multiplicity (0 1))
   (|minCardinality| :xmi-id "_16_0_1_630020f_1243640219340_410935_799"
    :range |UnlimitedNatural| :multiplicity (0 1))
   (|onProperty| :xmi-id "_12_5_1_137b03ac_1194325727921_756495_4497"
    :range |owlProperty| :multiplicity (1 1))))

;;; =========================================================
;;; ====================== owlValue
;;; =========================================================
(def-meta-stereotype |owlValue| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Property|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194366574765_954001_1036")
 ""
  ((|allValuesFrom| :xmi-id "_15_0_1_137b03ac_1222750173894_36563_3953"
    :range UML241:|Class| :multiplicity (0 1))
   (|base_Property| :xmi-id "_12_5_1_137b03ac_1194366605906_519223_1043"
    :range UML241:|Property| :multiplicity (1 1))
   (|hasValue| :xmi-id "_12_5_1_137b03ac_1194366645250_491746_1065"
    :range UML241:|InstanceSpecification| :multiplicity (0 -1))
   (|someValuesFrom| :xmi-id "_12_5_1_137b03ac_1194366672890_7477_1069"
    :range UML241:|Class| :multiplicity (0 1))))

(def-meta-assoc "_12_5_1_137b03ac_1194366605906_334976_1042"      
  :name |unamed-assoc-2|      
  :metatype :extension      
  :member-ends ((|owlValue| "base_Property")
                ("_12_5_1_137b03ac_1194366605906_125932_1044" "extension_owlValue"))      
  :owned-ends  (("_12_5_1_137b03ac_1194366605906_125932_1044" "extension_owlValue")))

(def-meta-assoc-end "_12_5_1_137b03ac_1194366605906_125932_1044" 
    :type |owlValue| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1194366605906_334976_1042" 
    :name "extension_owlValue" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== pattern
;;; =========================================================
(def-meta-stereotype |pattern| 
   (:model :OWL-PROFILE :superclasses (|datatypeFacet|) :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303924308409_176507_1950")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1303924384686_509526_2132"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303924384686_323879_2131"      
  :name |unamed-assoc-72|      
  :metatype :extension      
  :member-ends ((|pattern| "base_Dependency")
                ("_17_0_1_15100de_1303924384687_759249_2133" "extension_pattern"))      
  :owned-ends  (("_17_0_1_15100de_1303924384687_759249_2133" "extension_pattern")))

(def-meta-assoc-end "_17_0_1_15100de_1303924384687_759249_2133" 
    :type |pattern| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303924384686_323879_2131" 
    :name "extension_pattern" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== priorVersion
;;; =========================================================
(def-meta-stereotype |priorVersion| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|builtInVocabularyElement|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194324927578_28788_4263")
 "The owl:priorVersion annotation property specifies the IRI of a prior version
  of the containing ontology. Within a UML model, owl:priorVersion is represented
  as a dependency from the current model to the model that is a prior version."
  ())

(def-meta-constraint "SourceMustBeAnOntologyOrIRI" |priorVersion| 
   ""
   :operation-body
   "(self.source.oclType()=oclIsKindOf(owlOntology)) or (self.source.oclType()=oclIsKindOf(RDFProfile::IRI))")

(def-meta-constraint "TargetMustBeAnIRI" |priorVersion| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(RDFProfile::IRI))")

;;; =========================================================
;;; ====================== propertyChain
;;; =========================================================
(def-meta-stereotype |propertyChain| 
   (:model :OWL-PROFILE :superclasses (|objectProperty|) :extends (UML241:|Property| UML241:|Class| UML241:|Association|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1303064422673_157674_1774")
 ""
  ((|base_Association| :xmi-id "_17_0_1_15100de_1303064436375_794538_1807"
    :range UML241:|Association| :multiplicity (1 1))
   (|base_Class| :xmi-id "_17_0_1_15100de_1303064436380_806982_1812"
    :range UML241:|Class| :multiplicity (1 1))
   (|base_Property| :xmi-id "_17_0_1_15100de_1303064436385_358058_1817"
    :range UML241:|Property| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1303064436375_333948_1806"      
  :name |unamed-assoc-62|      
  :metatype :extension      
  :member-ends ((|propertyChain| "base_Association")
                ("_17_0_1_15100de_1303064436375_446737_1808" "extension_"))      
  :owned-ends  (("_17_0_1_15100de_1303064436375_446737_1808" "extension_")))

(def-meta-assoc-end "_17_0_1_15100de_1303064436375_446737_1808" 
    :type |propertyChain| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303064436375_333948_1806" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_1_15100de_1303064436380_749171_1811"      
  :name |unamed-assoc-63|      
  :metatype :extension      
  :member-ends ((|propertyChain| "base_Class")
                ("_17_0_1_15100de_1303064436381_708489_1813" "extension_"))      
  :owned-ends  (("_17_0_1_15100de_1303064436381_708489_1813" "extension_")))

(def-meta-assoc-end "_17_0_1_15100de_1303064436381_708489_1813" 
    :type |propertyChain| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303064436380_749171_1811" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_1_15100de_1303064436385_822653_1816"      
  :name |unamed-assoc-64|      
  :metatype :extension      
  :member-ends ((|propertyChain| "base_Property")
                ("_17_0_1_15100de_1303064436385_706636_1818" "extension_"))      
  :owned-ends  (("_17_0_1_15100de_1303064436385_706636_1818" "extension_")))

(def-meta-assoc-end "_17_0_1_15100de_1303064436385_706636_1818" 
    :type |propertyChain| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1303064436385_822653_1816" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== propertyGroup
;;; =========================================================
(def-meta-stereotype |propertyGroup| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1305242480947_715044_2654")
 ""
  ((|base_InstanceSpecification| :xmi-id "_17_0_1_15100de_1306198991054_316168_1697"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1306198991053_884575_1696"      
  :name |unamed-assoc-74|      
  :metatype :extension      
  :member-ends ((|propertyGroup| "base_InstanceSpecification")
                ("_17_0_1_15100de_1306198991054_604032_1698" "extension_propertyGroup"))      
  :owned-ends  (("_17_0_1_15100de_1306198991054_604032_1698" "extension_propertyGroup")))

(def-meta-assoc-end "_17_0_1_15100de_1306198991054_604032_1698" 
    :type |propertyGroup| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1306198991053_884575_1696" 
    :name "extension_propertyGroup" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== sameAs
;;; =========================================================
(def-meta-stereotype |sameAs| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1194371013171_545685_1611")
 "owl:sameAs is used to state that two URI references refer to the same individual."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1202881036031_97260_2409"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1202881036031_851929_2408"      
  :name |unamed-assoc-18|      
  :metatype :extension      
  :member-ends ((|sameAs| "base_Dependency")
                ("_15_0_1_137b03ac_1202881036031_67528_2410" "extension_sameAs"))      
  :owned-ends  (("_15_0_1_137b03ac_1202881036031_67528_2410" "extension_sameAs")))

(def-meta-assoc-end "_15_0_1_137b03ac_1202881036031_67528_2410" 
    :type |sameAs| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1202881036031_851929_2408" 
    :name "extension_sameAs" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== sameIndividual
;;; =========================================================
(def-meta-stereotype |sameIndividual| 
   (:model :OWL-PROFILE :superclasses (|naryAxiom|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_9_15100de_1291749033586_900314_1778")
 ""
  ())

;;; =========================================================
;;; ====================== someValuesFrom
;;; =========================================================
(def-meta-stereotype |someValuesFrom| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_15_0_1_137b03ac_1218004322196_86034_343")
 "A restriction containing an owl:someValuesFrom constraint is used to describe
  a class of all individuals for which at least one value of the property
  under consideration is either a member of the class extension of the class
  expression or a data value within the specified data range. Some values
  expressions (object or data) are essentially used for existential quantification
  over property expressions."
  ((|base_Dependency| :xmi-id "_15_0_1_137b03ac_1218004350462_427654_350"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_15_0_1_137b03ac_1218004350462_989953_349"      
  :name |unamed-assoc-58|      
  :metatype :extension      
  :member-ends ((|someValuesFrom| "base_Dependency")
                ("_15_0_1_137b03ac_1218004350462_701722_351" "extension_someValuesFrom"))      
  :owned-ends  (("_15_0_1_137b03ac_1218004350462_701722_351" "extension_someValuesFrom")))

(def-meta-assoc-end "_15_0_1_137b03ac_1218004350462_701722_351" 
    :type |someValuesFrom| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1218004350462_989953_349" 
    :name "extension_someValuesFrom" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== sourceIndividual
;;; =========================================================
(def-meta-stereotype |sourceIndividual| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288732280092_935884_2882")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288732291343_331627_2884"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288732291343_733710_2883"      
  :name |unamed-assoc-10|      
  :metatype :extension      
  :member-ends ((|sourceIndividual| "base_Dependency")
                ("_16_8_e980341_1288732291344_714523_2885" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288732291344_714523_2885" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288732291344_714523_2885" 
    :type |sourceIndividual| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288732291343_733710_2883" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== targetIndividual
;;; =========================================================
(def-meta-stereotype |targetIndividual| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288732315916_516230_2906")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288732322043_864997_2908"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288732322043_78451_2907"      
  :name |unamed-assoc-59|      
  :metatype :extension      
  :member-ends ((|targetIndividual| "base_Dependency")
                ("_16_8_e980341_1288732322043_969888_2909" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288732322043_969888_2909" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288732322043_969888_2909" 
    :type |targetIndividual| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288732322043_78451_2907" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== targetValue
;;; =========================================================
(def-meta-stereotype |targetValue| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288732377388_357149_2954")
 ""
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288732384889_363067_2956"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288732384889_822084_2955"      
  :name |unamed-assoc-39|      
  :metatype :extension      
  :member-ends ((|targetValue| "base_Dependency")
                ("_16_8_e980341_1288732384890_177471_2957" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288732384890_177471_2957" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288732384890_177471_2957" 
    :type |targetValue| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288732384889_822084_2955" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== unionOf
;;; =========================================================
(def-meta-stereotype |unionOf| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_12_5_1_137b03ac_1196810825718_788941_1153")
 "A unionOf generalization set is used together with an anonymous unionClass
  to define a set union. The generalization set is drawn from the member
  class expressions to the anonymous union class (i.e., the arrow-head should
  point to the unionClass). A union can contain one or more member class
  extensions. In order to model this, the ontologist must draw individual
  generalizations, stereotyped by unionOf, from each member class expression
  to the anonymous unionClass, then select and group the generalizations
  together as a generalization set, also stereotyped by unionOf. In order
  to match the OWL semantics, the generalization set should be covering,
  but may be overlapping (see disjointUnionOf for cases where all members
  of the union are explicitly disjoint). Note that intersections in OWL are
  analogous to logical disjunction."
  ((|base_Dependency| :xmi-id "_16_9_15100de_1292105892211_927801_1625"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_16_6_630020f_1265504788620_829929_1250"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-constraint "IsCovering" |unionOf| 
   ""
   :operation-body
   "isCovering=true")

(def-meta-constraint "IsDisjoint" |unionOf| 
   ""
   :operation-body
   "isDisjoint=false")

(def-meta-assoc "_16_9_15100de_1292105892211_831602_1624"      
  :name |unamed-assoc-43|      
  :metatype :extension      
  :member-ends ((|unionOf| "base_Dependency")
                ("_16_9_15100de_1292105892211_43264_1626" "extension_unionOf"))      
  :owned-ends  (("_16_9_15100de_1292105892211_43264_1626" "extension_unionOf")))

(def-meta-assoc-end "_16_9_15100de_1292105892211_43264_1626" 
    :type |unionOf| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1292105892211_831602_1624" 
    :name "extension_unionOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_6_630020f_1265504788605_832923_1249"      
  :name |unamed-assoc-50|      
  :metatype :extension      
  :member-ends ((|unionOf| "base_Generalization")
                ("_16_6_630020f_1265504788620_728957_1251" "extension_unionOf"))      
  :owned-ends  (("_16_6_630020f_1265504788620_728957_1251" "extension_unionOf")))

(def-meta-assoc-end "_16_6_630020f_1265504788620_728957_1251" 
    :type |unionOf| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1265504788605_832923_1249" 
    :name "extension_unionOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== versionIRI
;;; =========================================================
(def-meta-stereotype |versionIRI| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_17_0_1_15100de_1305068237308_41678_1739")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1305068264905_253907_1752"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1305068264904_900283_1751"      
  :name |unamed-assoc-73|      
  :metatype :extension      
  :member-ends ((|versionIRI| "base_Dependency")
                ("_17_0_1_15100de_1305068264905_339302_1753" "extension_versionIRI"))      
  :owned-ends  (("_17_0_1_15100de_1305068264905_339302_1753" "extension_versionIRI")))

(def-meta-assoc-end "_17_0_1_15100de_1305068264905_339302_1753" 
    :type |versionIRI| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1305068264904_900283_1751" 
    :name "extension_versionIRI" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== versionInfo
;;; =========================================================
(def-meta-stereotype |versionInfo| 
   (:model :OWL-PROFILE :superclasses (RDF-PROFILE:|builtInVocabularyElement|) :extends NIL
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288227917176_591289_3206")
 "The owl:versionInfo annotation property can be used to provide an IRI with
  a string that describes the IRI's version."
  ())

(def-meta-constraint "versionInfoTarget" |versionInfo| 
   ""
   :operation-body
   "(self.target.oclType()=oclIsKindOf(RDFProfile::literal))")

;;; =========================================================
;;; ====================== withRestrictions
;;; =========================================================
(def-meta-stereotype |withRestrictions| 
   (:model :OWL-PROFILE :superclasses NIL :extends (UML241:|Dependency|)
 :packages (|OWLProfile|) 
 :xmi-id "_16_8_e980341_1288486825711_133276_2622")
 "A datatype restriction DatatypeRestriction( DT F1 lt1 ... Fn ltn ) consists
  of a unary datatype DT and n pairs ( Fi , lti ). The resulting data range
  is unary and is obtained by restricting the value space of DT according
  to the semantics of all ( Fi , vi ) (multiple pairs are interpreted conjunctively),
  where vi are the data values of the literals lti. The withRestrictions
  dependency links the datatype restriction to one or more facet value pairs
  that restrict the value space."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288486834223_421783_2624"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288486834223_811358_2623"      
  :name |unamed-assoc-38|      
  :metatype :extension      
  :member-ends ((|withRestrictions| "base_Dependency")
                ("_16_8_e980341_1288486834223_645603_2625" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288486834223_645603_2625" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288486834223_645603_2625" 
    :type |withRestrictions| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288486834223_811358_2623" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-package |OWLProfile| NIL :OWL-PROFILE 
   (|Entity|
    |onClass|
    |disjointProperties|
    |annotationProperty|
    |AnonymousIndividual|
    |equivalentDatatype|
    |versionInfo|
    |DataRange|
    |Annotation|
    |ComplementDatatype|
    |objectProperty|
    |SurrogateObjectProperty|
    |hasSelf|
    |hasKey|
    |owlValue|
    |owlRestriction|
    |EnumeratedClass|
    |targetValue|
    |annotatedProperty|
    |inverseOf|
    |UnionDatatype|
    |PropertyAxiom|
    |targetIndividual|
    |UnionClass|
    |disjointUnionOf|
    |withRestrictions|
    |allValuesFrom|
    |Singleton|
    |equivalentClasses|
    |onType|
    |members|
    |complementOf|
    |equivalentProperty|
    |ComplementClass|
    |Axiom|
    |DatatypeRestriction|
    |backwardCompatibleWith|
    |Assertion|
    |disjointProperty|
    |equivalentProperties|
    |distinctMember|
    |unionOf|
    |inverseProperty|
    |hasValue|
    |priorVersion|
    |equivalentClass|
    |sameAs|
    |owlIndividual|
    |annotatedTarget|
    |disjointWith|
    |intersectionOf|
    |onDatatype|
    |naryAxiom|
    |ClassExpression|
    |IntersectionClass|
    |NegativePropertyAssertion|
    |oneOf|
    |owlOntology|
    |deprecated|
    |assertionProperty|
    |owlImports|
    |onDataRange|
    |owlProperty|
    |DataEnumeration|
    |differentFrom|
    |someValuesFrom|
    |differentIndividuals|
    |incompatibleWith|
    |owlClass|
    |IntersectionDatatype|
    |disjointClasses|
    |annotatedSource|
    |operand|
    |sameIndividual|
    |NamedIndividual|
    |onProperties|
    |datatypeProperty|
    |SurrogateDatatypeProperty|
    |sourceIndividual|
    |ClassAxiom|
    |onProperty|
    |propertyChain|
    |integer|
    |minInclusive|
    |maxInclusive|
    |datatypeFacet|
    |minExclusive|
    |maxExclusive|
    |minLength|
    |length|
    |maxLength|
    |pattern|
    |langRange|
    |versionIRI|
    |propertyGroup|
    |SurrogateAnnotationProperty|
    |hasDataRange|) :xmi-id "_12_5_1_137b03ac_1194319380250_490899_3794")

(def-meta-package UML\ 2.4.1 NIL :OWL-PROFILE 
   () :xmi-id NIL)

(in-package :mofi)


(with-slots (abstract-classes ns-uri ns-prefix) *model*
     (setf abstract-classes 
        '(OWL-PROFILE::|Assertion|
          OWL-PROFILE::|Axiom|
          OWL-PROFILE::|ClassAxiom|
          OWL-PROFILE::|ClassExpression|
          OWL-PROFILE::|DataRange|
          OWL-PROFILE::|Entity|
          OWL-PROFILE::|PropertyAxiom|
          OWL-PROFILE::|datatypeFacet|
          OWL-PROFILE::|integer|
          OWL-PROFILE::|naryAxiom|
          OWL-PROFILE::|owlProperty|))
     (setf ns-uri "http://modelegator.nist.gov/OWL-PROFILE")
     (setf ns-prefix "OWL-PROFILE"))
