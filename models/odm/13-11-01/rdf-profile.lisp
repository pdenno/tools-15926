;;; Automatically created by pop-gen at 2016-01-08 16:39:29.
;;; Source file is NIL

(in-package :rdf-profile)



(def-meta-enum |ReificationKind| (:model :rdf-profile :superclasses NIL 
   :xmi-id "_17_0_4_1_e980341_1381345546286_772598_3546")
   (|none| |reified| |reifiedOnly|)
   "")



;;; =========================================================
;;; ====================== IRI
;;; =========================================================
(def-meta-stereotype IRI 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|LiteralString| UML241:|InstanceSpecification|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194021442187_410369_3394")
 "Any IRI or literal denotes something in the world (the universe of discourse).
  The resource denoted by an IRI is also called its referent. An IRI (Internationalized
  Resource Identifier) within an RDF graph is a Unicode string that conforms
  to the syntax defined in RFC 3987. Interoperability problems can be avoided
  by minting only IRIs that are normalized according to Section 5 of RFC3987."
  ((|base_InstanceSpecification| :xmi-id "_17_0_2_2_e980341_1360546453541_431648_2440"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_LiteralString| :xmi-id "_17_0_2_2_e980341_1360546453525_762322_2435"
    :range UML241:|LiteralString| :multiplicity (1 1))
   (|denotes| :xmi-id "_17_0_4_1_e980341_1376508589437_675490_3983"
    :range |resource| :multiplicity (0 1))))

(def-meta-assoc "_17_0_2_2_e980341_1360546453525_21455_2434"      
  :name |unamed-assoc-40|      
  :metatype :extension      
  :member-ends ((IRI "base_LiteralString")
                ("_17_0_2_2_e980341_1360546453525_814356_2436" "extension_IRI"))      
  :owned-ends  (("_17_0_2_2_e980341_1360546453525_814356_2436" "extension_IRI")))

(def-meta-assoc-end "_17_0_2_2_e980341_1360546453525_814356_2436" 
    :type IRI 
    :multiplicity (0 1) 
    :association "_17_0_2_2_e980341_1360546453525_21455_2434" 
    :name "extension_IRI" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_2_2_e980341_1360546453541_929504_2439"      
  :name |unamed-assoc-41|      
  :metatype :extension      
  :member-ends ((IRI "base_InstanceSpecification")
                ("_17_0_2_2_e980341_1360546453541_997728_2441" "extension_IRI"))      
  :owned-ends  (("_17_0_2_2_e980341_1360546453541_997728_2441" "extension_IRI")))

(def-meta-assoc-end "_17_0_2_2_e980341_1360546453541_997728_2441" 
    :type IRI 
    :multiplicity (0 1) 
    :association "_17_0_2_2_e980341_1360546453541_929504_2439" 
    :name "extension_IRI" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== URI
;;; =========================================================
(def-meta-stereotype URI 
   (:model :rdf-profile :superclasses (IRI) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194021308593_334315_3365")
 "IRIs are a generalization of URIs (which must conform to RFC3986) that
  permits a much wider range of Unicode characters. Every absolute URI and
  URL is an IRI, but not every IRI is an URI."
  ())

;;; =========================================================
;;; ====================== about
;;; =========================================================
(def-meta-stereotype |about| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|PackageImport| UML241:|Generalization| UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1257371723961_359332_813")
 "This stereotype is similar to rdf:about, and is used to link resources
  across vocabularies. To be more precise, it provides a mechanism to support
  local refinement of an RDF or OWL class, property, or individual in cases
  where an element is not explicitly redefined in the local RDF or OWL file
  (i.e., in the original vocabulary, axioms are added locally using the remote
  element's URI, rather than through creation of a local subclass, subproperty,
  or individual of the imported element and extending -that-). While this
  general modeling pattern is discouraged from a UML perspective, it is commonplace
  in the Semantic Web community. The stereotype is included to address challenges
  in importing multiple ontologies containing statements that redefine elements
  in an imported vocabulary or ontology in ways that are not permitted or
  encouraged in UML."
  ((|base_Dependency| :xmi-id "_16_6_15100de_1261528860861_578897_483"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_16_5_4_630020f_1257371731418_98248_815"
    :range UML241:|Generalization| :multiplicity (1 1))
   (|base_PackageImport| :xmi-id "_16_6_2_15100de_1272571175880_503103_393"
    :range UML241:|PackageImport| :multiplicity (1 1))))

(def-meta-assoc "_16_5_4_630020f_1257371731418_716930_814"      
  :name |unamed-assoc-16|      
  :metatype :extension      
  :member-ends ((|about| "base_Generalization")
                ("_16_5_4_630020f_1257371731418_990286_816" "extension_"))      
  :owned-ends  (("_16_5_4_630020f_1257371731418_990286_816" "extension_")))

(def-meta-assoc-end "_16_5_4_630020f_1257371731418_990286_816" 
    :type |about| 
    :multiplicity (0 1) 
    :association "_16_5_4_630020f_1257371731418_716930_814" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_6_15100de_1261528860860_646129_482"      
  :name |unamed-assoc-19|      
  :metatype :extension      
  :member-ends ((|about| "base_Dependency")
                ("_16_6_15100de_1261528860861_446385_484" "extension_rdfAbout"))      
  :owned-ends  (("_16_6_15100de_1261528860861_446385_484" "extension_rdfAbout")))

(def-meta-assoc-end "_16_6_15100de_1261528860861_446385_484" 
    :type |about| 
    :multiplicity (0 1) 
    :association "_16_6_15100de_1261528860860_646129_482" 
    :name "extension_rdfAbout" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_6_2_15100de_1272571175850_424712_392"      
  :name |unamed-assoc-5|      
  :metatype :extension      
  :member-ends ((|about| "base_PackageImport")
                ("_16_6_2_15100de_1272571175881_645412_394" "extension_rdfAbout"))      
  :owned-ends  (("_16_6_2_15100de_1272571175881_645412_394" "extension_rdfAbout")))

(def-meta-assoc-end "_16_6_2_15100de_1272571175881_645412_394" 
    :type |about| 
    :multiplicity (0 1) 
    :association "_16_6_2_15100de_1272571175850_424712_392" 
    :name "extension_rdfAbout" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== alt
;;; =========================================================
(def-meta-stereotype |alt| 
   (:model :rdf-profile :superclasses (|container|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254859716893_931107_922")
 "This class corresponds to the RDF resource, rdf:Alt. It is used conventionally
  to indicate that members of the container are considered alternatives (i.e.,
  an enumeration). The first member of the container, i.e. the value of the
  rdf:_1 property, is typically the default choice."
  ())

;;; =========================================================
;;; ====================== annotationProperty
;;; =========================================================
(def-meta-stereotype |annotationProperty| 
   (:model :rdf-profile :superclasses (|rdfProperty|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1286406966125_122245_2134")
 "Annotation properties can be used to provide an annotation for an ontology
  or vocabulary as well as for any model element represented in such a vocabulary.
  While not explicitly defined in RDF Schema, this profile element is provided
  as a convenience mechanism for use in organizing such properties in RDF,
  as well as for use with well-known vocabularies such as Dublin Core and
  SKOS in other vocabularies or ontologies."
  ())

;;; =========================================================
;;; ====================== bag
;;; =========================================================
(def-meta-stereotype |bag| 
   (:model :rdf-profile :superclasses (|container|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254859794964_390338_950")
 "This class corresponds to the RDF resource, rdf:Bag. It is used conventionally
  to indicate that the resources in the container are intended to be unordered."
  ())

(def-meta-constraint "UnorderedCollection" |bag| 
   ""
   :operation-body
   "self.containerMembershipProperty->(isOrdered=false)")

(def-meta-constraint "unnamed4" |bag| 
   ""
   :operation-body
   "")

;;; =========================================================
;;; ====================== blankNode
;;; =========================================================
(def-meta-stereotype |blankNode| 
   (:model :rdf-profile :superclasses (|node|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193948725187_601926_2630")
 "A blank node is a node that is not an IRI or a literal. In the RDF abstract
  syntax, a blank node is simply a unique node that can be used in one or
  more RDF statements, but has no intrinsic name. Blank nodes are an integral
  part of the RDF language, and are used extensively in OWL class descriptions.
  In practice in a UML tool environment, they are useful when reverse engineering
  RDF vocabularies and OWL ontologies, and for co-reference resolution when
  mapping across ontologies."
  ((|nodeID| :xmi-id "_12_5_1_137b03ac_1193949014828_569072_2662"
    :range |String| :multiplicity (0 1))))

(def-meta-constraint "CannotHaveLabel" |blankNode| 
   ""
   :operation-body
   "self.label->Empty()")

(def-meta-constraint "CannotHaveURI" |blankNode| 
   ""
   :operation-body
   "self.uriRef->isEmpty()")

;;; =========================================================
;;; ====================== builtInVocabularyElement
;;; =========================================================
(def-meta-stereotype |builtInVocabularyElement| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency| UML241:|Comment|)
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1288985084717_979212_1326")
 "The RDF and OWL specifications include built-in terms that can be used
  to provide additional information for any resource. These are idiomatic
  instances of rdf:Property that provide specific terms to help document
  vocabularies and ontologies."
  ((|base_Comment| :xmi-id "_16_8_e980341_1290804363138_32073_1367"
    :range UML241:|Comment| :multiplicity (1 1))
   (|base_Dependency| :xmi-id "_16_8_e980341_1288985119082_620217_1328"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|langTag| :xmi-id "_16_8_e980341_1290811653600_690853_1350"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "_16_8_e980341_1290804363138_395284_1366"      
  :name |unamed-assoc-30|      
  :metatype :extension      
  :member-ends ((|builtInVocabularyElement| "base_Comment")
                ("_16_8_e980341_1290804363138_774073_1368" "extension_builtInVocabulary"))      
  :owned-ends  (("_16_8_e980341_1290804363138_774073_1368" "extension_builtInVocabulary")))

(def-meta-assoc-end "_16_8_e980341_1290804363138_774073_1368" 
    :type |builtInVocabularyElement| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1290804363138_395284_1366" 
    :name "extension_builtInVocabulary" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_8_e980341_1288985119082_933704_1327"      
  :name |unamed-assoc-8|      
  :metatype :extension      
  :member-ends ((|builtInVocabularyElement| "base_Dependency")
                ("_16_8_e980341_1288985119083_852584_1329" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288985119083_852584_1329" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288985119083_852584_1329" 
    :type |builtInVocabularyElement| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288985119082_933704_1327" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== collection
;;; =========================================================
(def-meta-stereotype |collection| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|LiteralString| UML241:|InstanceSpecification| UML241:|Class|)
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254858932544_779197_833")
 "Collection is an abstract class used to support various kinds of collections
  in RDF"
  ((|base_Class| :xmi-id "_16_5_4_630020f_1254858973595_881071_835"
    :range UML241:|Class| :multiplicity (1 1))
   (|base_InstanceSpecification| :xmi-id "_17_0_4_1_e980341_1376513960304_650302_3973"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_LiteralString| :xmi-id "_17_0_4_1_e980341_1376513960304_595123_3968"
    :range UML241:|LiteralString| :multiplicity (1 1))))

(def-meta-assoc "_16_5_4_630020f_1254858973595_90595_834"      
  :name |unamed-assoc-20|      
  :metatype :extension      
  :member-ends ((|collection| "base_Class")
                ("_16_5_4_630020f_1254858973595_133804_836" "extension_"))      
  :owned-ends  (("_16_5_4_630020f_1254858973595_133804_836" "extension_")))

(def-meta-assoc-end "_16_5_4_630020f_1254858973595_133804_836" 
    :type |collection| 
    :multiplicity (0 1) 
    :association "_16_5_4_630020f_1254858973595_90595_834" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_4_1_e980341_1376513960304_769774_3967"      
  :name |unamed-assoc-44|      
  :metatype :extension      
  :member-ends ((|collection| "base_LiteralString")
                ("_17_0_4_1_e980341_1376513960304_414076_3969" "extension_collection"))      
  :owned-ends  (("_17_0_4_1_e980341_1376513960304_414076_3969" "extension_collection")))

(def-meta-assoc-end "_17_0_4_1_e980341_1376513960304_414076_3969" 
    :type |collection| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1376513960304_769774_3967" 
    :name "extension_collection" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_4_1_e980341_1376513960304_191949_3972"      
  :name |unamed-assoc-45|      
  :metatype :extension      
  :member-ends ((|collection| "base_InstanceSpecification")
                ("_17_0_4_1_e980341_1376513960304_412226_3974" "extension_collection"))      
  :owned-ends  (("_17_0_4_1_e980341_1376513960304_412226_3974" "extension_collection")))

(def-meta-assoc-end "_17_0_4_1_e980341_1376513960304_412226_3974" 
    :type |collection| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1376513960304_191949_3972" 
    :name "extension_collection" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== comment
;;; =========================================================
(def-meta-stereotype |comment| 
   (:model :rdf-profile :superclasses (|builtInVocabularyElement|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1286407362720_507451_2167")
 "rdfs:comment is an instance of rdf:Property that may be used to provide
  a human-readable description of a resource."
  ())

;;; =========================================================
;;; ====================== container
;;; =========================================================
(def-meta-stereotype |container| 
   (:model :rdf-profile :superclasses (|collection|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254859592984_451742_895")
 "This stereotype represents the class of RDF containers."
  ((|containerMembershipProperty| :xmi-id "_16_5_4_630020f_1254860169632_467717_1006"
    :range |rdfProperty| :multiplicity (0 -1))))

;;; =========================================================
;;; ====================== containerMembershipProperty
;;; =========================================================
(def-meta-stereotype |containerMembershipProperty| 
   (:model :rdf-profile :superclasses (|rdfProperty|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1286388789830_644804_1939")
 "rdfs:ContainerMembershipProperty provides a mechanism for defining ordered
  properties and linking them to a specified container in RDF. Instances
  of this property include rdf:_1, rdf:_2,rdf:_3 ..., and are used to state
  that the object of the property is member of the container specified as
  the subject."
  ())

;;; =========================================================
;;; ====================== dataset
;;; =========================================================
(def-meta-stereotype |dataset| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|Package|)
 :packages ("RDFProfile") 
 :xmi-id "_17_0_2_2_e980341_1360547767547_509921_2490")
 ""
  ((|base_Package| :xmi-id "_17_0_2_2_e980341_1360547822912_424369_2514"
    :range UML241:|Package| :multiplicity (1 1))
   (|defaultGraph| :xmi-id "_17_0_2_2_e980341_1360547829963_807292_2518"
    :range |graph| :multiplicity (1 1))
   (|namedGraph| :xmi-id "_17_0_2_2_e980341_1360547901318_176106_2522"
    :range |namedGraph| :multiplicity (0 -1))))

(def-meta-assoc "_17_0_2_2_e980341_1360547822912_484556_2513"      
  :name |unamed-assoc-42|      
  :metatype :extension      
  :member-ends ((|dataset| "base_Package")
                ("_17_0_2_2_e980341_1360547822912_841450_2515" "extension_dataset"))      
  :owned-ends  (("_17_0_2_2_e980341_1360547822912_841450_2515" "extension_dataset")))

(def-meta-assoc-end "_17_0_2_2_e980341_1360547822912_841450_2515" 
    :type |dataset| 
    :multiplicity (0 1) 
    :association "_17_0_2_2_e980341_1360547822912_484556_2513" 
    :name "extension_dataset" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== datatype
;;; =========================================================
(def-meta-stereotype |datatype| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_17_0_1_15100de_1300564873066_231995_1582")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1300564944990_459511_1589"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1300564944990_214062_1588"      
  :name |unamed-assoc-36|      
  :metatype :extension      
  :member-ends ((|datatype| "base_Dependency")
                ("_17_0_1_15100de_1300564944990_99312_1590" "extension_datatype"))      
  :owned-ends  (("_17_0_1_15100de_1300564944990_99312_1590" "extension_datatype")))

(def-meta-assoc-end "_17_0_1_15100de_1300564944990_99312_1590" 
    :type |datatype| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1300564944990_214062_1588" 
    :name "extension_datatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== domain
;;; =========================================================
(def-meta-stereotype |domain| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_15_0_1_137b03ac_1217055254284_973396_3484")
 "rdfs:domain indicates that RDF resources denoted by the subjects of triples
  whose predicate is a given property P are instances of the class denoted
  by the domain. When a property has multiple domains, then the resources
  denoted by the subjects of triples whose predicate is P are instances of
  all of the classes stated by the rdfs:domain properties (In OWL, this is
  typically thought of as an anonymous class representing the intersection
  of all of the classes said to be in the domain of the property)."
  ((|base_Dependency| :xmi-id "_16_0_1_2780137_1233724119449_661399_525"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_2780137_1233724119449_505097_524"      
  :name |unamed-assoc-25|      
  :metatype :extension      
  :member-ends ((|domain| "base_Dependency")
                ("_16_0_1_2780137_1233724119449_930442_526" "extension_rdfsDomain"))      
  :owned-ends  (("_16_0_1_2780137_1233724119449_930442_526" "extension_rdfsDomain")))

(def-meta-assoc-end "_16_0_1_2780137_1233724119449_930442_526" 
    :type |domain| 
    :multiplicity (0 1) 
    :association "_16_0_1_2780137_1233724119449_505097_524" 
    :name "extension_rdfsDomain" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== graph
;;; =========================================================
(def-meta-stereotype |graph| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Package|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193949169796_664111_2666")
 "An RDF graph is the container for the set of statements (subject, predicate,
  object subgraphs) in an RDF/S vocabulary. In UML this container is a package.
  This definition of a graph is included in the profile to support identification
  / componentization of RDF vocabularies through the use of named graphs,
  and for vocabulary mapping purposes."
  ((|base_Package| :xmi-id "_12_5_1_137b03ac_1193949210703_918692_2673"
    :range UML241:|Package| :multiplicity (1 1))
   (|equivalentGraph| :xmi-id "_16_0_1_630020f_1244047127357_706991_850"
    :range |graph| :multiplicity (0 -1))
   (|subGraphOf| :xmi-id "_17_0_2_2_e980341_1360568632626_955121_2220"
    :range |graph| :multiplicity (0 -1))
   (|triple| :xmi-id "_16_0_1_630020f_1244046437618_940794_811"
    :range |triple| :multiplicity (0 -1))))

(def-meta-assoc "_12_5_1_137b03ac_1193949210703_494829_2672"      
  :name |unamed-assoc-28|      
  :metatype :extension      
  :member-ends ((|graph| "base_Package")
                ("_12_5_1_137b03ac_1193949210718_877081_2674" "extension_RDFGraph"))      
  :owned-ends  (("_12_5_1_137b03ac_1193949210718_877081_2674" "extension_RDFGraph")))

(def-meta-assoc-end "_12_5_1_137b03ac_1193949210718_877081_2674" 
    :type |graph| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1193949210703_494829_2672" 
    :name "extension_RDFGraph" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== identifier
;;; =========================================================
(def-meta-stereotype |identifier| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_6_2_15100de_1272478451022_902111_392")
 ""
  ((|base_Dependency| :xmi-id "_16_6_2_15100de_1272478487581_932294_399"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_6_2_15100de_1272478487581_83479_398"      
  :name |unamed-assoc-24|      
  :metatype :extension      
  :member-ends ((|identifier| "base_Dependency")
                ("_16_6_2_15100de_1272478487581_323863_400" "extension_rdfID"))      
  :owned-ends  (("_16_6_2_15100de_1272478487581_323863_400" "extension_rdfID")))

(def-meta-assoc-end "_16_6_2_15100de_1272478487581_323863_400" 
    :type |identifier| 
    :multiplicity (0 1) 
    :association "_16_6_2_15100de_1272478487581_83479_398" 
    :name "extension_rdfID" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== isDefinedBy
;;; =========================================================
(def-meta-stereotype |isDefinedBy| 
   (:model :rdf-profile :superclasses (|seeAlso|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193954054750_654695_3257")
 "rdfs:isDefinedBy provides a means to indicate that a particular resource
  (the source, or owning classifier) is defined by another resource (the
  target resource). Note that RDF does not constrain the usage of rdfs:isDefinedBy,
  though in practice, vocabularies that use this construct, such as the Dublin
  Core, will do so."
  ())

;;; =========================================================
;;; ====================== label
;;; =========================================================
(def-meta-stereotype |label| 
   (:model :rdf-profile :superclasses (|builtInVocabularyElement|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1286407848272_375398_2277")
 "rdfs:label is an instance of rdf:Property that may be used to provide a
  human-readable version of a resource's name."
  ())

;;; =========================================================
;;; ====================== labeledResource
;;; =========================================================
(def-meta-stereotype |labeledResource| 
   (:model :rdf-profile :superclasses (|resource|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_2_630020f_1250724300918_77826_449")
 "Labeled resource is an abstract element used to attach a simple string
  label to an RDF resource. Annotation properties (e.g., label) can be used
  to create multiple, more complex and/or multi-lingual labels for any resource
  in a model."
  ((|label| :xmi-id "_16_5_2_630020f_1250724339887_205871_471"
    :range |String| :multiplicity (0 -1))))

;;; =========================================================
;;; ====================== langTag
;;; =========================================================
(def-meta-stereotype |langTag| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_17_0_1_15100de_1300653571471_692665_1571")
 ""
  ((|base_Dependency| :xmi-id "_17_0_1_15100de_1300653585589_88445_1578"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_15100de_1300653585588_11062_1577"      
  :name |unamed-assoc-38|      
  :metatype :extension      
  :member-ends ((|langTag| "base_Dependency")
                ("_17_0_1_15100de_1300653585589_496004_1579" "extension_lang"))      
  :owned-ends  (("_17_0_1_15100de_1300653585589_496004_1579" "extension_lang")))

(def-meta-assoc-end "_17_0_1_15100de_1300653585589_496004_1579" 
    :type |langTag| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1300653585588_11062_1577" 
    :name "extension_lang" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== list
;;; =========================================================
(def-meta-stereotype |list| 
   (:model :rdf-profile :superclasses (|collection|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254859168743_86713_857")
 "This stereotype is a proxy for rdf:List that can be used to build descriptions
  of lists and other list-like structures."
  ((|first| :xmi-id "_16_5_4_630020f_1254859222788_753957_879"
    :range |resource| :multiplicity (0 1))
   (|rest| :xmi-id "_16_5_4_630020f_1254859227014_442668_881"
    :range |list| :multiplicity (0 1))))

;;; =========================================================
;;; ====================== literal
;;; =========================================================
(def-meta-stereotype |literal| 
   (:model :rdf-profile :superclasses (|node|) :extends (UML241:|LiteralString| UML241:|InstanceSpecification|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193949885312_884819_2706")
 "Literals are used to identify values such as numbers and dates by means
  of a lexical representation. Anything represented by a literal could also
  be represented by a URI, but it is often more convenient or intuitive to
  use literals. A literal may be the object of an RDF statement, but not
  the subject or the predicate. Literals may be plain or typed. The string
  value associated with an   rdfsLiteral   corresponds to its lexical form."
  ((|base_InstanceSpecification| :xmi-id "_17_0_1_e980341_1300311383551_706806_2008"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_LiteralString| :xmi-id "_17_0_1_e980341_1300311383551_426765_2013"
    :range UML241:|LiteralString| :multiplicity (1 1))
   (|datatype| :xmi-id "_16_0_1_630020f_1243639565546_393745_294"
    :range |rdfsDatatype| :multiplicity (0 1))
   (|datatypeIRI| :xmi-id "_17_0_1_15100de_1306273249637_174349_1567"
    :range IRI :multiplicity (0 1))
   (|langTag| :xmi-id "_12_5_1_137b03ac_1193951341453_644643_2945"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "_17_0_1_e980341_1300311383551_332604_2007"      
  :name |unamed-assoc-34|      
  :metatype :extension      
  :member-ends ((|literal| "base_InstanceSpecification")
                ("_17_0_1_e980341_1300311383551_519475_2009" "extension_rdfsLiteral"))      
  :owned-ends  (("_17_0_1_e980341_1300311383551_519475_2009" "extension_rdfsLiteral")))

(def-meta-assoc-end "_17_0_1_e980341_1300311383551_519475_2009" 
    :type |literal| 
    :multiplicity (0 1) 
    :association "_17_0_1_e980341_1300311383551_332604_2007" 
    :name "extension_rdfsLiteral" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_1_e980341_1300311383551_390934_2012"      
  :name |unamed-assoc-35|      
  :metatype :extension      
  :member-ends ((|literal| "base_LiteralString")
                ("_17_0_1_e980341_1300311383551_315200_2014" "extension_rdfsLiteral"))      
  :owned-ends  (("_17_0_1_e980341_1300311383551_315200_2014" "extension_rdfsLiteral")))

(def-meta-assoc-end "_17_0_1_e980341_1300311383551_315200_2014" 
    :type |literal| 
    :multiplicity (0 1) 
    :association "_17_0_1_e980341_1300311383551_390934_2012" 
    :name "extension_rdfsLiteral" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== namedGraph
;;; =========================================================
(def-meta-stereotype |namedGraph| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Package|)
 :packages ("RDFProfile") 
 :xmi-id "_16_0_1_630020f_1244046766575_570086_823")
 "This stereotype enables use of named graphs within an RDF vocabulary or
  OWL ontology. A named graph is typically used for modularizing a particular
  ontology, and can be useful for mapping vocabularies or ontologies to one
  another."
  ((|base_Package| :xmi-id "_16_0_1_630020f_1244046775998_478853_826"
    :range UML241:|Package| :multiplicity (1 1))
   (|graph| :xmi-id "_16_0_1_630020f_1244046842329_968413_846"
    :range |graph| :multiplicity (1 1))
   (|graphName| :xmi-id "_17_0_2_2_e980341_1360568701796_39846_2224"
    :range IRI :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_630020f_1244046775998_979236_825"      
  :name |unamed-assoc-18|      
  :metatype :extension      
  :member-ends ((|namedGraph| "base_Package")
                ("_16_0_1_630020f_1244046775998_253622_827" "extension_"))      
  :owned-ends  (("_16_0_1_630020f_1244046775998_253622_827" "extension_")))

(def-meta-assoc-end "_16_0_1_630020f_1244046775998_253622_827" 
    :type |namedGraph| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1244046775998_979236_825" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== namedResource
;;; =========================================================
(def-meta-stereotype |namedResource| 
   (:model :rdf-profile :superclasses (|labeledResource|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_2_630020f_1250725403251_896961_1023")
 "named resource is an abstract element used to attach URIs/IRIs to RDF resources"
  ((|identifier| :xmi-id "_16_5_2_630020f_1250725447172_485996_1045"
    :range IRI :multiplicity (0 1))))

;;; =========================================================
;;; ====================== namespaceDefinition
;;; =========================================================
(def-meta-stereotype |namespaceDefinition| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages ("RDFProfile") 
 :xmi-id "_15_0_1_137b03ac_1205211158156_376523_3004")
 "A namespace is declared using a family of reserved attributes. These attributes,
  like any other XML attributes, may be provided directly or by default.
  Some names in XML documents (constructs corresponding to the non-terminal
  Name) may be given as qualified names. The prefix provides the namespace
  prefix part of the qualified name, and must be associated with a namespace
  URI in a namespace declaration."
  ((|base_InstanceSpecification| :xmi-id "_16_0_1_137b03ac_1234243623347_505203_444"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|namespaceIRI| :xmi-id "_15_0_1_137b03ac_1205211415812_355319_3018"
    :range IRI :multiplicity (1 1))
   (|namespacePrefix| :xmi-id "_15_0_1_137b03ac_1205211369343_324984_3015"
    :range |String| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_137b03ac_1234243623347_300798_443"      
  :name |unamed-assoc-17|      
  :metatype :extension      
  :member-ends ((|namespaceDefinition| "base_InstanceSpecification")
                ("_16_0_1_137b03ac_1234243623347_814572_445" "extension_namespaceDefinition"))      
  :owned-ends  (("_16_0_1_137b03ac_1234243623347_814572_445" "extension_namespaceDefinition")))

(def-meta-assoc-end "_16_0_1_137b03ac_1234243623347_814572_445" 
    :type |namespaceDefinition| 
    :multiplicity (0 1) 
    :association "_16_0_1_137b03ac_1234243623347_300798_443" 
    :name "extension_namespaceDefinition" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== node
;;; =========================================================
(def-meta-stereotype |node| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|LiteralString| UML241:|InstanceSpecification| UML241:|Comment|)
 :packages ("RDFProfile") 
 :xmi-id "_16_0_1_630020f_1244041748019_967508_662")
 "This stereotype provides a mechanism for saying things about nodes in an
  RDF graph."
  ((|base_Comment| :xmi-id "_17_0_1_e980341_1300311383551_566153_2003"
    :range UML241:|Comment| :multiplicity (1 1))
   (|base_InstanceSpecification| :xmi-id "_16_0_1_630020f_1244041765491_84808_665"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_LiteralString| :xmi-id "_16_0_1_630020f_1244041813508_483854_686"
    :range UML241:|LiteralString| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_e980341_1300311383551_714381_2002"      
  :name |unamed-assoc-33|      
  :metatype :extension      
  :member-ends ((|node| "base_Comment")
                ("_17_0_1_e980341_1300311383551_556877_2004" "extension_node"))      
  :owned-ends  (("_17_0_1_e980341_1300311383551_556877_2004" "extension_node")))

(def-meta-assoc-end "_17_0_1_e980341_1300311383551_556877_2004" 
    :type |node| 
    :multiplicity (0 1) 
    :association "_17_0_1_e980341_1300311383551_714381_2002" 
    :name "extension_node" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_0_1_630020f_1244041813508_755586_685"      
  :name |unamed-assoc-4|      
  :metatype :extension      
  :member-ends ((|node| "base_LiteralString")
                ("_16_0_1_630020f_1244041813508_953514_687" "extension_node"))      
  :owned-ends  (("_16_0_1_630020f_1244041813508_953514_687" "extension_node")))

(def-meta-assoc-end "_16_0_1_630020f_1244041813508_953514_687" 
    :type |node| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1244041813508_755586_685" 
    :name "extension_node" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_0_1_630020f_1244041765491_477137_664"      
  :name |unamed-assoc-9|      
  :metatype :extension      
  :member-ends ((|node| "base_InstanceSpecification")
                ("_16_0_1_630020f_1244041765491_845822_666" "extension_"))      
  :owned-ends  (("_16_0_1_630020f_1244041765491_845822_666" "extension_")))

(def-meta-assoc-end "_16_0_1_630020f_1244041765491_845822_666" 
    :type |node| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1244041765491_477137_664" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== object
;;; =========================================================
(def-meta-stereotype |object| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1288981820946_713541_1605")
 "The target of the dependency is the object of the triple or statement."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288981826185_655287_1607"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288981826185_709011_1606"      
  :name |unamed-assoc-14|      
  :metatype :extension      
  :member-ends ((|object| "base_Dependency")
                ("_16_8_e980341_1288981826186_244145_1608" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288981826186_244145_1608" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288981826186_244145_1608" 
    :type |object| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288981826185_709011_1606" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== predicate
;;; =========================================================
(def-meta-stereotype |predicate| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1288981788010_638392_1574")
 "The target of the dependency is the predicate of the triple or statement."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288981794436_389349_1576"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288981794436_236079_1575"      
  :name |unamed-assoc-21|      
  :metatype :extension      
  :member-ends ((|predicate| "base_Dependency")
                ("_16_8_e980341_1288981794437_660571_1577" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288981794437_660571_1577" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288981794437_660571_1577" 
    :type |predicate| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288981794436_236079_1575" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== range
;;; =========================================================
(def-meta-stereotype |range| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_15_0_1_137b03ac_1217055341581_819223_3513")
 "rdfs:range indicates that the values of a given property P are instances
  of the class denoted by the range. When a property has multiple rdfs:range
  properties, then the resources denoted by the objects of triples whose
  predicate is P are instances of all of the classes stated by the rdfs:range
  properties (In OWL, this is typically thought of as an anonymous class
  representing the intersection of all of the range classes)."
  ((|base_Dependency| :xmi-id "_16_0_1_2780137_1233724166467_21541_530"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_2780137_1233724166467_432635_529"      
  :name |unamed-assoc-22|      
  :metatype :extension      
  :member-ends ((|range| "base_Dependency")
                ("_16_0_1_2780137_1233724166467_547844_531" "extension_rdfsRange"))      
  :owned-ends  (("_16_0_1_2780137_1233724166467_547844_531" "extension_rdfsRange")))

(def-meta-assoc-end "_16_0_1_2780137_1233724166467_547844_531" 
    :type |range| 
    :multiplicity (0 1) 
    :association "_16_0_1_2780137_1233724166467_432635_529" 
    :name "extension_rdfsRange" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfDocument
;;; =========================================================
(def-meta-stereotype |rdfDocument| 
   (:model :rdf-profile :superclasses (|rdfSource|) :extends (UML241:|Package|)
 :packages ("RDFProfile") 
 :xmi-id "_17_0_2_2_e980341_1360548779665_514530_2613")
 ""
  ((|base_Package| :xmi-id "_17_0_2_2_e980341_1360548804360_805461_2640"
    :range UML241:|Package| :multiplicity (1 1))
   (|statementForDocument| :xmi-id "_12_5_1_137b03ac_1194021085265_884192_3340"
    :range |triple| :multiplicity (1 -1) :is-ordered-p T)))

(def-meta-assoc "_17_0_2_2_e980341_1360548804360_39400_2639"      
  :name |unamed-assoc-43|      
  :metatype :extension      
  :member-ends ((|rdfDocument| "base_Package")
                ("_17_0_2_2_e980341_1360548804360_546607_2641" "extension_rdfDocument"))      
  :owned-ends  (("_17_0_2_2_e980341_1360548804360_546607_2641" "extension_rdfDocument")))

(def-meta-assoc-end "_17_0_2_2_e980341_1360548804360_546607_2641" 
    :type |rdfDocument| 
    :multiplicity (0 1) 
    :association "_17_0_2_2_e980341_1360548804360_39400_2639" 
    :name "extension_rdfDocument" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfGlobal
;;; =========================================================
(def-meta-stereotype |rdfGlobal| 
   (:model :rdf-profile :superclasses (|rdfProperty|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194309273968_396187_2678")
 "An optional stereotype on a unidirectional association class, association,
  or property with   rdfProperty   applied, indicating the association/class
  property is defined globally, i.e., that class having the property (the
  non-navigable end of the association), is the class on which the property
  is introduced, i.e., the property is not inherited from a superclass."
  ())

;;; =========================================================
;;; ====================== rdfProperty
;;; =========================================================
(def-meta-stereotype |rdfProperty| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|Property| UML241:|Association|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194309085281_252601_2640")
 "A property in UML can be defined as part of an association or not. When
  it is not part of an association, the property is owned by the class that
  defines its domain, and the type of the property is the class that defines
  its range. When a property is part of an association, the association is
  binary, with the class that defines the domain of the property owning that
  property. Best modeling practices, in UML as well as in RDF/OWL, recommend
  usage of properties as associations unless the type of the property is
  a UML primitive data type. Properties in RDF and OWL are defined globally,
  that is, they are available to all classes in all vocabularies and ontologies
  - not only to classes in the vocabulary or ontology they are defined in,
  but to classes in other vocabularies and ontologies, including those that
  are imported. For RDF properties that are defined as associations without
  specifying a domain or range,best practice is to use an anonymous class
  (analogous to owl:Thing in OWL ontologies) for the missing end class."
  ((|base_Association| :xmi-id "_17_0_4_1_e980341_1376528257956_784422_3768"
    :range UML241:|Association| :multiplicity (1 1))
   (|base_Property| :xmi-id "_15_0_1_137b03ac_1222794704948_941519_3149"
    :range UML241:|Property| :multiplicity (1 1))))

(def-meta-constraint "HasIRI" |rdfProperty| 
   ""
   :operation-body
   "self.identifier->notEmpty()")

(def-meta-constraint "unnamed2" |rdfProperty| 
   ""
   :operation-body
   "isUnique=true")

(def-meta-constraint "unnamed3" |rdfProperty| 
   ""
   :operation-body
   "isOrdered=false")

(def-meta-assoc "_15_0_1_137b03ac_1222794704948_78697_3148"      
  :name |unamed-assoc-26|      
  :metatype :extension      
  :member-ends ((|rdfProperty| "base_Property")
                ("_15_0_1_137b03ac_1222794704948_150795_3150" "extension_rdfProperty"))      
  :owned-ends  (("_15_0_1_137b03ac_1222794704948_150795_3150" "extension_rdfProperty")))

(def-meta-assoc-end "_15_0_1_137b03ac_1222794704948_150795_3150" 
    :type |rdfProperty| 
    :multiplicity (0 1) 
    :association "_15_0_1_137b03ac_1222794704948_78697_3148" 
    :name "extension_rdfProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_4_1_e980341_1376528257956_43758_3767"      
  :name |unamed-assoc-46|      
  :metatype :extension      
  :member-ends ((|rdfProperty| "base_Association")
                ("_17_0_4_1_e980341_1376528257956_131768_3769" "extension_rdfProperty"))      
  :owned-ends  (("_17_0_4_1_e980341_1376528257956_131768_3769" "extension_rdfProperty")))

(def-meta-assoc-end "_17_0_4_1_e980341_1376528257956_131768_3769" 
    :type |rdfProperty| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1376528257956_43758_3767" 
    :name "extension_rdfProperty" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfSource
;;; =========================================================
(def-meta-stereotype |rdfSource| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|Package|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194020624296_145941_3320")
 "An RDF document represents the primary namespace mechanism / container
  for an RDF/S vocabulary. The ordered set of definitions (statements) that
  comprise an RDF vocabulary are contained in a document. This set of statements
  may also correspond to one or more graphs contained in the document. Note
  that this approach supports RDF graphs that span multiple documents, and
  enables multiple graphs to occur within a particular document, both of
  which are valid from an RDF perspective (although it is more natural from
  a UML modeling perspective to assume that there is a 1-1 mapping between
  a graph and a document)."
  ((|base_Package| :xmi-id "_12_5_1_137b03ac_1194020650609_374355_3327"
    :range UML241:|Package| :multiplicity (1 1))
   (|defaultNamespace| :xmi-id "_12_5_1_137b03ac_1194020681093_47000_3331"
    :range IRI :multiplicity (0 1))
   (|graph| :xmi-id "_17_0_2_2_e980341_1360548880769_492542_2645"
    :range |graph| :multiplicity (1 -1))
   (|namespaceDefinition| :xmi-id "_12_5_1_137b03ac_1194021016750_251598_3337"
    :range |namespaceDefinition| :multiplicity (0 -1))
   (|xmlBase| :xmi-id "_12_5_1_137b03ac_1194020993281_220307_3334"
    :range IRI :multiplicity (0 1))))

(def-meta-assoc "_12_5_1_137b03ac_1194020650609_262029_3326"      
  :name |unamed-assoc-10|      
  :metatype :extension      
  :member-ends ((|rdfSource| "base_Package")
                ("_12_5_1_137b03ac_1194020650609_733707_3328" "extension_rdfDocument"))      
  :owned-ends  (("_12_5_1_137b03ac_1194020650609_733707_3328" "extension_rdfDocument")))

(def-meta-assoc-end "_12_5_1_137b03ac_1194020650609_733707_3328" 
    :type |rdfSource| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1194020650609_262029_3326" 
    :name "extension_rdfDocument" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfType
;;; =========================================================
(def-meta-stereotype |rdfType| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_6_630020f_1265655448677_615116_547")
 "rdf:type is used to state that a resource is an instance of a class; it
  is implemented as a dependency from the resource (or individual or literal
  in OWL) to its classifier(s)"
  ((|base_Dependency| :xmi-id "_16_6_630020f_1265655463326_26720_549"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_6_630020f_1265655463326_88632_548"      
  :name |unamed-assoc-7|      
  :metatype :extension      
  :member-ends ((|rdfType| "base_Dependency")
                ("_16_6_630020f_1265655463327_835045_550" "extension_"))      
  :owned-ends  (("_16_6_630020f_1265655463327_835045_550" "extension_")))

(def-meta-assoc-end "_16_6_630020f_1265655463327_835045_550" 
    :type |rdfType| 
    :multiplicity (0 1) 
    :association "_16_6_630020f_1265655463326_88632_548" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfsClass
;;; =========================================================
(def-meta-stereotype |rdfsClass| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|Class|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193953653921_226495_3191")
 "The collection of resources that represents RDF Schema classes is itself
  a class, called rdfs:Class. Classes provide an abstraction mechanism for
  grouping resources with similar characteristics. The members of a class
  are known as instances of the class. Classes are resources. They are often
  identified by RDF URI References and may be described using RDF properties.
  An RDFS class maps closely to the UML definition of a class; one notable
  exception is that an RDFS class may have a URI reference."
  ((|base_Class| :xmi-id "_12_5_1_137b03ac_1193953690359_447544_3198"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-assoc "_12_5_1_137b03ac_1193953690359_510874_3197"      
  :name |unamed-assoc-31|      
  :metatype :extension      
  :member-ends ((|rdfsClass| "base_Class")
                ("_12_5_1_137b03ac_1193953690359_511486_3199" "extension_rdfsClass"))      
  :owned-ends  (("_12_5_1_137b03ac_1193953690359_511486_3199" "extension_rdfsClass")))

(def-meta-assoc-end "_12_5_1_137b03ac_1193953690359_511486_3199" 
    :type |rdfsClass| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1193953690359_510874_3197" 
    :name "extension_rdfsClass" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== rdfsDatatype
;;; =========================================================
(def-meta-stereotype |rdfsDatatype| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|DataType|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193953805640_648281_3224")
 "rdfs:Datatype represents the class of datatypes in RDF. Instances of rdfs:Datatype
  correspond to the RDF model of a datatype described in the RDF Concepts
  specification [RDF Concepts]. Note that built-in instances of rdfs:Datatype
  correspond to the subset of datatypes (defined in [XML Schema Datatypes])
  allowable for use in RDF, as specified in [RDF Concepts]. These are provided
  for use with the metamodel(s) and profile(s) in the model library given
  in Annex Annex A (Foundation Library (M1) for RDF and OWL). Use of user-defined
  datatypes should be carefully considered against any desire for reasoning
  over an RDF vocabulary, OWL ontology, or knowledge base. Some support for
  user-defined datatypes is provided in OWL2, which should be used as guidance
  for any types created in RDF as a best practice."
  ((|base_DataType| :xmi-id "_12_5_1_137b03ac_1193953882296_607349_3231"
    :range UML241:|DataType| :multiplicity (1 1))
   (|umlPrimitiveType| :xmi-id "_16_0_1_630020f_1243472530237_259838_294"
    :range UML241:|PrimitiveType| :multiplicity (0 1))))

(def-meta-constraint "HasIRI" |rdfsDatatype| 
   ""
   :operation-body
   "self.identifier->notEmpty()")

(def-meta-assoc "_12_5_1_137b03ac_1193953882296_217326_3230"      
  :name |unamed-assoc-11|      
  :metatype :extension      
  :member-ends ((|rdfsDatatype| "base_DataType")
                ("_12_5_1_137b03ac_1193953882296_798756_3232" "extension_rdfsDatatype"))      
  :owned-ends  (("_12_5_1_137b03ac_1193953882296_798756_3232" "extension_rdfsDatatype")))

(def-meta-assoc-end "_12_5_1_137b03ac_1193953882296_798756_3232" 
    :type |rdfsDatatype| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1193953882296_217326_3230" 
    :name "extension_rdfsDatatype" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== referenceNode
;;; =========================================================
(def-meta-stereotype |referenceNode| 
   (:model :rdf-profile :superclasses (|node|) :extends (UML241:|LiteralString| UML241:|InstanceSpecification|)
 :packages ("RDFProfile") 
 :xmi-id "_17_0_4_1_e980341_1376691743229_798661_3544")
 ""
  ((|base_InstanceSpecification| :xmi-id "_17_0_4_1_e980341_1376691764387_780838_3577"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_LiteralString| :xmi-id "_17_0_4_1_e980341_1376691764385_340797_3572"
    :range UML241:|LiteralString| :multiplicity (1 1))
   (|hasReferent| :xmi-id "_17_0_4_1_e980341_1376725043730_418993_3788"
    :range |namedResource| :multiplicity (1 1))))

(def-meta-assoc "_17_0_4_1_e980341_1376691764385_574825_3571"      
  :name |unamed-assoc-47|      
  :metatype :extension      
  :member-ends ((|referenceNode| "base_LiteralString")
                ("_17_0_4_1_e980341_1376691764385_363189_3573" "extension_"))      
  :owned-ends  (("_17_0_4_1_e980341_1376691764385_363189_3573" "extension_")))

(def-meta-assoc-end "_17_0_4_1_e980341_1376691764385_363189_3573" 
    :type |referenceNode| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1376691764385_574825_3571" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_4_1_e980341_1376691764387_476192_3576"      
  :name |unamed-assoc-48|      
  :metatype :extension      
  :member-ends ((|referenceNode| "base_InstanceSpecification")
                ("_17_0_4_1_e980341_1376691764388_470624_3578" "extension_"))      
  :owned-ends  (("_17_0_4_1_e980341_1376691764388_470624_3578" "extension_")))

(def-meta-assoc-end "_17_0_4_1_e980341_1376691764388_470624_3578" 
    :type |referenceNode| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1376691764387_476192_3576" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== references
;;; =========================================================
(def-meta-stereotype |references| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|PackageImport|)
 :packages ("RDFProfile") 
 :xmi-id "_15_0_1_137b03ac_1225399507515_464557_2841")
 "This dependency is used between packages to indicate that one vocabulary
  refers to elements of another, without requiring explicit ontology import."
  ((|base_PackageImport| :xmi-id "_16_6_2_15100de_1268090184472_47743_503"
    :range UML241:|PackageImport| :multiplicity (1 1))
   (|nsPrefix| :xmi-id "_16_6_2_15100de_1272572335821_373788_344"
    :range |String| :multiplicity (0 1))))

(def-meta-assoc "_16_6_2_15100de_1268090184472_934192_502"      
  :name |unamed-assoc-39|      
  :metatype :extension      
  :member-ends ((|references| "base_PackageImport")
                ("_16_6_2_15100de_1268090184472_287493_504" "extension_references"))      
  :owned-ends  (("_16_6_2_15100de_1268090184472_287493_504" "extension_references")))

(def-meta-assoc-end "_16_6_2_15100de_1268090184472_287493_504" 
    :type |references| 
    :multiplicity (0 1) 
    :association "_16_6_2_15100de_1268090184472_934192_502" 
    :name "extension_references" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== resource
;;; =========================================================
(def-meta-stereotype |resource| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Element|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1193950188718_678043_2735")
 "Any IRI or literal denotes something in the world (the universe of discourse).
  These things are called resources. Anything can be a resource, including
  physical things, documents, abstract concepts, numbers and strings; the
  term is synonymous with entity."
  ((|base_Element| :xmi-id "_17_0_4_1_e980341_1377724502435_538913_3833"
    :range UML241:|Element| :multiplicity (1 1))
   (|memberOf| :xmi-id "_12_5_1_137b03ac_1193950268875_825971_2749"
    :range IRI :multiplicity (0 -1))))

(def-meta-assoc "_17_0_4_1_e980341_1377724502435_230516_3832"      
  :name |unamed-assoc-49|      
  :metatype :extension      
  :member-ends ((|resource| "base_Element")
                ("_17_0_4_1_e980341_1377724502435_603384_3834" "extension_resource"))      
  :owned-ends  (("_17_0_4_1_e980341_1377724502435_603384_3834" "extension_resource")))

(def-meta-assoc-end "_17_0_4_1_e980341_1377724502435_603384_3834" 
    :type |resource| 
    :multiplicity (0 1) 
    :association "_17_0_4_1_e980341_1377724502435_230516_3832" 
    :name "extension_resource" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== seeAlso
;;; =========================================================
(def-meta-stereotype |seeAlso| 
   (:model :rdf-profile :superclasses (|builtInVocabularyElement|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194308523546_82483_2467")
 "rdfs:seeAlso indicates that more information about a particular resource
  (the source, or owning classifier) can be found at the target resource."
  ())

;;; =========================================================
;;; ====================== seq
;;; =========================================================
(def-meta-stereotype |seq| 
   (:model :rdf-profile :superclasses (|container|) :extends NIL
 :packages ("RDFProfile") 
 :xmi-id "_16_5_4_630020f_1254859900895_476035_980")
 "This class provides a proxy for rdf:Seq, which is used conventionally to
  indicate that the numerical ordering of the container membership properties
  of the container is intended to be significant."
  ())

(def-meta-constraint "OrderedList" |seq| 
   ""
   :operation-body
   "self.containerMembershipProperty->(isOrdered=true)")

;;; =========================================================
;;; ====================== statement
;;; =========================================================
(def-meta-stereotype |statement| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|InstanceSpecification|)
 :packages ("RDFProfile") 
 :xmi-id "_16_0_1_137b03ac_1234244242339_420098_1091")
 "An RDF statement is an instance of an rdfs:Class used to talk about a particular
  triple, or element of a triple. It provides a link to the elements of the
  triple and then allows statements to be made about those elements."
  ((|RDFobject| :xmi-id "_16_0_1_137b03ac_1234244890895_709793_1134"
    :range |node| :multiplicity (0 1))
   (|RDFpredicate| :xmi-id "_16_0_1_137b03ac_1234244753984_553079_1129"
    :range |rdfProperty| :multiplicity (0 1))
   (|RDFsubject| :xmi-id "_16_0_1_137b03ac_1234244505146_719697_1124"
    :range |node| :multiplicity (0 1))
   (|base_InstanceSpecification| :xmi-id "_16_0_1_137b03ac_1234244295294_78664_1098"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|reified| :xmi-id "_17_0_4_1_e980341_1381345749341_696317_3571"
    :range |ReificationKind| :multiplicity (1 1) :default :none)
   (|triple| :xmi-id "_16_0_1_137b03ac_1234244325295_479492_1102"
    :range |triple| :multiplicity (0 1))))

(def-meta-assoc "_16_0_1_137b03ac_1234244295294_123473_1097"      
  :name |unamed-assoc-12|      
  :metatype :extension      
  :member-ends ((|statement| "base_InstanceSpecification")
                ("_16_0_1_137b03ac_1234244295294_330370_1099" "extension_RDFStatement"))      
  :owned-ends  (("_16_0_1_137b03ac_1234244295294_330370_1099" "extension_RDFStatement")))

(def-meta-assoc-end "_16_0_1_137b03ac_1234244295294_330370_1099" 
    :type |statement| 
    :multiplicity (0 1) 
    :association "_16_0_1_137b03ac_1234244295294_123473_1097" 
    :name "extension_RDFStatement" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== subClassOf
;;; =========================================================
(def-meta-stereotype |subClassOf| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194308786500_75797_2496")
 "rdfs:subClassOf indicates that the resource is a subclass of the general
  class; it has the semantics of UML Generalization. However, classes on
  both ends of the generalization must be stereotyped   rdfsClass  , or 
   owlClass  , if used with the profile for OWL. Note in OWL DL that mixing
  inheritance among RDFS and OWL classes is permitted, as long as proper
  subclassing semantics is maintained. In order for a model to be well formed
  an OWL class can be a subclass of an RDFS class but not vice versa. In
  other words, once you're in OWL you need to stay there."
  ((|base_Dependency| :xmi-id "_16_9_15100de_1299371413315_737849_1543"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_12_5_1_137b03ac_1194308840890_185757_2503"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_12_5_1_137b03ac_1194308840890_778012_2502"      
  :name |unamed-assoc-23|      
  :metatype :extension      
  :member-ends ((|subClassOf| "base_Generalization")
                ("_12_5_1_137b03ac_1194308840890_346547_2504" "extension_rdfsSubClassOf"))      
  :owned-ends  (("_12_5_1_137b03ac_1194308840890_346547_2504" "extension_rdfsSubClassOf")))

(def-meta-assoc-end "_12_5_1_137b03ac_1194308840890_346547_2504" 
    :type |subClassOf| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1194308840890_778012_2502" 
    :name "extension_rdfsSubClassOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_9_15100de_1299371413314_744846_1542"      
  :name |unamed-assoc-3|      
  :metatype :extension      
  :member-ends ((|subClassOf| "base_Dependency")
                ("_16_9_15100de_1299371413315_757518_1544" "extension_subClassOf"))      
  :owned-ends  (("_16_9_15100de_1299371413315_757518_1544" "extension_subClassOf")))

(def-meta-assoc-end "_16_9_15100de_1299371413315_757518_1544" 
    :type |subClassOf| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299371413314_744846_1542" 
    :name "extension_subClassOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== subPropertyOf
;;; =========================================================
(def-meta-stereotype |subPropertyOf| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Generalization| UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_12_5_1_137b03ac_1194309900890_400126_2737")
 "rdfs:subPropertyOf is used to specialize RDF properties, similar to class
  generalization/specialization, and indicates that all the instances of
  the extension of the sub-property are instances of the extension of the
  super-property."
  ((|base_Dependency| :xmi-id "_16_9_15100de_1299371395095_22603_1534"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_Generalization| :xmi-id "_12_5_1_137b03ac_1194309944640_899124_2744"
    :range UML241:|Generalization| :multiplicity (1 1))))

(def-meta-assoc "_16_9_15100de_1299371395037_657656_1533"      
  :name |unamed-assoc-15|      
  :metatype :extension      
  :member-ends ((|subPropertyOf| "base_Dependency")
                ("_16_9_15100de_1299371395097_67328_1535" "extension_subPropertyOf"))      
  :owned-ends  (("_16_9_15100de_1299371395097_67328_1535" "extension_subPropertyOf")))

(def-meta-assoc-end "_16_9_15100de_1299371395097_67328_1535" 
    :type |subPropertyOf| 
    :multiplicity (0 1) 
    :association "_16_9_15100de_1299371395037_657656_1533" 
    :name "extension_subPropertyOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_12_5_1_137b03ac_1194309944640_764431_2743"      
  :name |unamed-assoc-2|      
  :metatype :extension      
  :member-ends ((|subPropertyOf| "base_Generalization")
                ("_12_5_1_137b03ac_1194309944640_375614_2745" "extension_rdfsSubPropertyOf"))      
  :owned-ends  (("_12_5_1_137b03ac_1194309944640_375614_2745" "extension_rdfsSubPropertyOf")))

(def-meta-assoc-end "_12_5_1_137b03ac_1194309944640_375614_2745" 
    :type |subPropertyOf| 
    :multiplicity (0 1) 
    :association "_12_5_1_137b03ac_1194309944640_764431_2743" 
    :name "extension_rdfsSubPropertyOf" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== subject
;;; =========================================================
(def-meta-stereotype |subject| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_8_e980341_1288981740426_559810_1543")
 "The target of the dependency is the subject of the triple or statement."
  ((|base_Dependency| :xmi-id "_16_8_e980341_1288981750441_163875_1545"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_8_e980341_1288981750440_209113_1544"      
  :name |unamed-assoc-13|      
  :metatype :extension      
  :member-ends ((|subject| "base_Dependency")
                ("_16_8_e980341_1288981750441_842584_1546" "extension_"))      
  :owned-ends  (("_16_8_e980341_1288981750441_842584_1546" "extension_")))

(def-meta-assoc-end "_16_8_e980341_1288981750441_842584_1546" 
    :type |subject| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1288981750440_209113_1544" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== surrogateFor
;;; =========================================================
(def-meta-stereotype |surrogateFor| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Dependency|)
 :packages ("RDFProfile") 
 :xmi-id "_16_0_1_630020f_1244141379590_886060_686")
 "This dependency links a surrogate property, reified as a class, to the
  association class that defines the property for which it is a surrogate."
  ((|base_Dependency| :xmi-id "_16_0_1_630020f_1244141388794_184053_689"
    :range UML241:|Dependency| :multiplicity (1 1))))

(def-meta-assoc "_16_0_1_630020f_1244141388794_49561_688"      
  :name |unamed-assoc-6|      
  :metatype :extension      
  :member-ends ((|surrogateFor| "base_Dependency")
                ("_16_0_1_630020f_1244141388794_168644_690" "extension_"))      
  :owned-ends  (("_16_0_1_630020f_1244141388794_168644_690" "extension_")))

(def-meta-assoc-end "_16_0_1_630020f_1244141388794_168644_690" 
    :type |surrogateFor| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1244141388794_49561_688" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== surrogateProperty
;;; =========================================================
(def-meta-stereotype |surrogateProperty| 
   (:model :rdf-profile :superclasses (|namedResource|) :extends (UML241:|Class|)
 :packages ("RDFProfile") 
 :xmi-id "_16_0_1_630020f_1244140884212_791691_295")
 "A surrogateProperty is a stand-in for an RDF property defined as an association
  class. This \"device\" is intended to support development of diagrams where
  one wants to show relationships between properties without \"dragging all
  of the related baggage\" (domain and range classes, for example) onto those
  diagrams. Examples where surrogates are useful include property hierarchies
  in RDF or OWL, and complex restrictions, property chains, and so forth
  in OWL. In order to create such a surrogate, the modeler should (1) create
  a diagram for the property definition, and on that diagram, define the
  RDF (or OWL) property as an association class, including the requisite
  domain and range information, (2) create the surrogate property and drag
  it onto the property definition diagram, and (3) link the two by creating
  a surrogateFor dependency, from the surrogate to the property it represents."
  ((|base_Class| :xmi-id "_16_0_1_630020f_1244140898158_74286_298"
    :range UML241:|Class| :multiplicity (1 1))))

(def-meta-constraint "HasURI" |surrogateProperty| 
   ""
   :operation-body
   "self.uriRef->notEmpty()")

(def-meta-assoc "_16_0_1_630020f_1244140898158_432162_297"      
  :name |unamed-assoc-27|      
  :metatype :extension      
  :member-ends ((|surrogateProperty| "base_Class")
                ("_16_0_1_630020f_1244140898158_327856_299" "extension_"))      
  :owned-ends  (("_16_0_1_630020f_1244140898158_327856_299" "extension_")))

(def-meta-assoc-end "_16_0_1_630020f_1244140898158_327856_299" 
    :type |surrogateProperty| 
    :multiplicity (0 1) 
    :association "_16_0_1_630020f_1244140898158_432162_297" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

;;; =========================================================
;;; ====================== triple
;;; =========================================================
(def-meta-stereotype |triple| 
   (:model :rdf-profile :superclasses NIL :extends (UML241:|Slot| UML241:|InstanceSpecification| UML241:|Dependency| UML241:|Comment|)
 :packages ("RDFProfile") 
 :xmi-id "_16_8_15100de_1290836020687_6169_1369")
 ""
  ((|base_Comment| :xmi-id "_16_8_15100de_1290836259431_872728_1371"
    :range UML241:|Comment| :multiplicity (1 1))
   (|base_Dependency| :xmi-id "_16_8_15100de_1290836259439_731511_1376"
    :range UML241:|Dependency| :multiplicity (1 1))
   (|base_InstanceSpecification| :xmi-id "_16_8_15100de_1290836259441_854869_1381"
    :range UML241:|InstanceSpecification| :multiplicity (1 1))
   (|base_Slot| :xmi-id "_17_0_1_15100de_1300583709128_820052_1564"
    :range UML241:|Slot| :multiplicity (1 1))
   (|object| :xmi-id "_17_0_1_15100de_1300744224434_804996_1566"
    :range |node| :multiplicity (0 1))
   (|predicate| :xmi-id "_16_8_15100de_1290836392181_944670_1430"
    :range |rdfProperty| :multiplicity (0 1))
   (|subject| :xmi-id "_17_0_1_15100de_1300743840956_985565_1563"
    :range |node| :multiplicity (0 1))))

(def-meta-assoc "_16_8_15100de_1290836259439_258760_1375"      
  :name |unamed-assoc-1|      
  :metatype :extension      
  :member-ends ((|triple| "base_Dependency")
                ("_16_8_15100de_1290836259439_384462_1377" "extension_"))      
  :owned-ends  (("_16_8_15100de_1290836259439_384462_1377" "extension_")))

(def-meta-assoc-end "_16_8_15100de_1290836259439_384462_1377" 
    :type |triple| 
    :multiplicity (0 1) 
    :association "_16_8_15100de_1290836259439_258760_1375" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_8_15100de_1290836259441_743638_1380"      
  :name |unamed-assoc-29|      
  :metatype :extension      
  :member-ends ((|triple| "base_InstanceSpecification")
                ("_16_8_15100de_1290836259441_350036_1382" "extension_"))      
  :owned-ends  (("_16_8_15100de_1290836259441_350036_1382" "extension_")))

(def-meta-assoc-end "_16_8_15100de_1290836259441_350036_1382" 
    :type |triple| 
    :multiplicity (0 1) 
    :association "_16_8_15100de_1290836259441_743638_1380" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_16_8_15100de_1290836259430_664489_1370"      
  :name |unamed-assoc-32|      
  :metatype :extension      
  :member-ends ((|triple| "base_Comment")
                ("_16_8_15100de_1290836259435_485893_1372" "extension_"))      
  :owned-ends  (("_16_8_15100de_1290836259435_485893_1372" "extension_")))

(def-meta-assoc-end "_16_8_15100de_1290836259435_485893_1372" 
    :type |triple| 
    :multiplicity (0 1) 
    :association "_16_8_15100de_1290836259430_664489_1370" 
    :name "extension_" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-assoc "_17_0_1_15100de_1300583709126_22852_1563"      
  :name |unamed-assoc-37|      
  :metatype :extension      
  :member-ends ((|triple| "base_Slot")
                ("_17_0_1_15100de_1300583709129_43431_1565" "extension_fact"))      
  :owned-ends  (("_17_0_1_15100de_1300583709129_43431_1565" "extension_fact")))

(def-meta-assoc-end "_17_0_1_15100de_1300583709129_43431_1565" 
    :type |triple| 
    :multiplicity (0 1) 
    :association "_17_0_1_15100de_1300583709126_22852_1563" 
    :name "extension_fact" 
    :aggregation :COMPOSITE 
    :visibility :PRIVATE)

(def-meta-package "RDFProfile" NIL :rdf-profile 
   (|collection|
    |predicate|
    |rdfType|
    |annotationProperty|
    |blankNode|
    |bag|
    |rdfSource|
    |triple|
    |label|
    |range|
    |container|
    |list|
    |object|
    |comment|
    |labeledResource|
    |containerMembershipProperty|
    |domain|
    |about|
    |seq|
    |literal|
    |node|
    |surrogateProperty|
    |rdfsDatatype|
    |subClassOf|
    |isDefinedBy|
    |resource|
    |subject|
    |builtInVocabularyElement|
    URI
    |rdfProperty|
    |graph|
    |alt|
    |identifier|
    |rdfsClass|
    |surrogateFor|
    |rdfGlobal|
    |namespaceDefinition|
    |namedResource|
    |seeAlso|
    |subPropertyOf|
    IRI
    |statement|
    |namedGraph|
    |datatype|
    |langTag|
    |references|
    |dataset|
    |rdfDocument|
    |referenceNode|
    |ReificationKind|) :xmi-id "+The-Model+")


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) *model*
     (setf mofi::abstract-classes 
        '(|builtInVocabularyElement|
          |collection|
          |labeledResource|
          |namedResource|
          |node|))
     (setf mofi:ns-uri "http://www.omg.org/spec/ODM/20131101/RDFProfile.xmi")
     (setf mofi:ns-prefix "RDFProfile"))
