;;; Automatically created by pop-gen at 2014-09-01 09:43:16.
;;; Source file is ODM-metamodels-ptc-13-08-04.xmi
;;; POD I then cut out everything not related to OWL.

;;; POD There is, in a directory below here, a file based on the 20131101 XMI. 
;;; It does not differ in any substantial way from this one. I fixed a few things
;;; in this one. Stick with it!

(in-package :ODM)

;;; =========================================================
;;; ====================== AllValuesFromRestriction
;;; =========================================================
(def-meta-class |AllValuesFromRestriction| 
   (:model :ODM :superclasses (|OWLRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_426937_3147")
 "An AllValuesFromRestriction describes a class for which all values of the
  property under consideration are either members of the class extension
  of the class description or are data values within the specified data range.
  In other words, it defines a class of individuals x for which holds that
  if the pair (x, y) is an instance of P (the property concerned), then y
  should be an instance of the class description or a value in the data range,
  respectively."
  ((|OWLallValuesFromClass| :xmi-id "_15_5_2c17055e_1218847223559_152614_3073"
    :range |ClassExpression| :multiplicity (0 1)
    :documentation
     "links the restriction class to the class expression containing all of the
      individuals in its range.")
   (|OWLallValuesFromDataRange| :xmi-id "_15_5_2c17055e_1218847223559_28238_3044"
    :range |DataRange| :multiplicity (0 1)
    :documentation
     "links the restriction class to the data range containing all of the data
      values in its range.")))

(def-meta-assoc "_15_5_2c17055e_1218847223569_552780_3291"      
  :name |AllValuesFromClass|      
  :metatype :association      
  :member-ends ((|AllValuesFromRestriction| "OWLallValuesFromClass")
                ("_15_5_2c17055e_1218847223559_817212_3048" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_817212_3048" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_817212_3048" 
    :type |AllValuesFromRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223569_552780_3291" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223579_601497_3494"      
  :name |AllValuesFromDataRange|      
  :metatype :association      
  :member-ends ((|AllValuesFromRestriction| "OWLallValuesFromDataRange")
                ("_15_5_2c17055e_1218847223559_525082_3076" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_525082_3076" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_525082_3076" 
    :type |AllValuesFromRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_601497_3494" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== BlankNode
;;; =========================================================
(def-meta-class |BlankNode| 
   (:model :ODM :superclasses (|Node|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_223621_2901")
 "A blank node is a node that is not a reference to a resource or a literal.
  In the RDF abstract syntax, a blank node is simply a unique node that can
  be used in one or more RDF statements, but has no intrinsic name. A convention
  used to refer to blank nodes by some linear representations of an RDF graph
  is to use a blank node identifier, which is a local identifier that can
  be distinguished from IRIs and literals. When graphs are merged, their
  blank nodes must be kept distinct if meaning is to be preserved. Blank
  node identifiers are not part of the RDF abstract syntax, and the representation
  of triples containing blank nodes is dependent on the particular concrete
  syntax used, thus no constraints are provided here on blank node identifiers.
  They are optional, included strictly as a placeholder for tool vendors
  whose applications require them, and in particular, for interoperability
  among such tools."
  ((|nodeID| :xmi-id "_15_5_2c17055e_1218847223559_263970_2998"
    :range |String| :multiplicity (0 1)
    :documentation
     "the optional blank node identifier.")))

(def-meta-constraint "CannotHaveLabel" |BlankNode| 
   ""
   :operation-body
   "self.RDFSlabel -> isEmpty()")

(def-meta-constraint "CannotHaveURI" |BlankNode| 
   ""
   :operation-body
   "self.iri -> isEmpty()")

;;; =========================================================
;;; ====================== CardinalityRestriction
;;; =========================================================
(def-meta-class |CardinalityRestriction| 
   (:model :ODM :superclasses (|OWLRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1384167494664_465380_4286")
 "This abstract class represents properties common to all cardinality restrictions."
  ((|cardinality| :xmi-id "_17_0_4_1_e4a0319_1384166617997_839183_4159"
    :range |UnlimitedNatural| :multiplicity (1 1)
    :documentation
     "represents the cardinality used for the restriction. The interpretation
      varies by the subclass for the specific kind of cardinality restriction..")
   (|qualifiedByClass| :xmi-id "_17_0_4_1_e4a0319_1384167784044_80696_4388"
    :range |ClassExpression| :multiplicity (0 1)
    :documentation
     "represents an optional qualification of the restriction by class membership
          if not empty then the property must satisfy not only the cardinality
      but the class membership.")))

(def-meta-assoc "_17_0_4_1_e4a0319_1384167784043_767260_4387"      
  :name |RestrictionQualifiedByClass|      
  :metatype :association      
  :member-ends ((|CardinalityRestriction| "qualifiedByClass")
                ("_17_0_4_1_e4a0319_1384167784045_831664_4389" "restrictionQualified"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1384167784045_831664_4389" "restrictionQualified")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1384167784045_831664_4389" 
    :type |CardinalityRestriction| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1384167784043_767260_4387" 
    :name "restrictionQualified" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ClassExpression
;;; =========================================================
(def-meta-class |ClassExpression| 
   (:model :ODM :superclasses (|RDFSClass|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_1_e980341_1306899679044_391723_1783")
 "A class expression describes an OWL class, either by a class name or by
  specifying the class extension of an unnamed anonymous class."
  ((|disjointClass| :xmi-id "_17_0_1_e980341_1306899788912_474429_1812"
    :range |ClassExpression| :multiplicity (0 -1)
    :documentation
     "links a class to zero or more classes that it is disjoint with.")
   (|equivalentClass| :xmi-id "_17_0_1_e980341_1306899816063_427555_1830"
    :range |ClassExpression| :multiplicity (0 -1)
    :documentation
     "links a class to zero or more classes that it is considered equivalent
      to.")))

(def-meta-assoc "_17_0_1_e980341_1306899788910_614043_1811"      
  :name |DisjointClass|      
  :metatype :association      
  :member-ends (("_17_0_1_e980341_1306899788916_79363_1814" "OWLdisjointWith")
                (|ClassExpression| "disjointClass"))      
  :owned-ends  (("_17_0_1_e980341_1306899788916_79363_1814" "OWLdisjointWith")))

(def-meta-assoc-end "_17_0_1_e980341_1306899788916_79363_1814" 
    :type |ClassExpression| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1306899788910_614043_1811" 
    :name "OWLdisjointWith" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1306899816058_338446_1827"      
  :name |EquivalentClass|      
  :metatype :association      
  :member-ends (("_17_0_1_e980341_1306899816060_637876_1828" "OWLequivalentClass")
                (|ClassExpression| "equivalentClass"))      
  :owned-ends  (("_17_0_1_e980341_1306899816060_637876_1828" "OWLequivalentClass")))

(def-meta-assoc-end "_17_0_1_e980341_1306899816060_637876_1828" 
    :type |ClassExpression| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1306899816058_338446_1827" 
    :name "OWLequivalentClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ComplementClass
;;; =========================================================
(def-meta-class |ComplementClass| 
   (:model :ODM :superclasses (|ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_469088_2980")
 "An owl:complementOf statement describes a class for which the class extension
  contains exactly those individuals that do not belong to the class extension
  of the class description that is the object of the statement. owl:complementOf
  is analogous to logical negation: the class extension consists of those
  individuals that are NOT members of the class extension of the complement
  class."
  ((|OWLcomplementOf| :xmi-id "_17_0_1_e980341_1306900003090_345052_1839"
    :range |ClassExpression| :multiplicity (1 1)
    :documentation
     "links a class to its set complement.")))

(def-meta-assoc "_17_0_1_e980341_1306900003084_912500_1836"      
  :name |ComplementClassForComplement|      
  :metatype :association      
  :member-ends ((|ComplementClass| "OWLcomplementOf")
                ("_17_0_1_e980341_1306900003087_381293_1837" "complementClass"))      
  :owned-ends  (("_17_0_1_e980341_1306900003087_381293_1837" "complementClass")))

(def-meta-assoc-end "_17_0_1_e980341_1306900003087_381293_1837" 
    :type |ComplementClass| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1306900003084_912500_1836" 
    :name "complementClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== ComplementDatatype
;;; =========================================================
(def-meta-class |ComplementDatatype| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1376902670815_617336_4458")
 "An owl:complementOf statement describes a datatype for which the extension
  contains exactly those values that do not belong to the extension of the
  data range that is the object of the statement. It is analogous to logical
  negation: the datatype extension consists of those values that are NOT
  members of the extension of the complement data range."
  ((|OWLcomplementOf| :xmi-id "_17_0_4_1_e4a0319_1376903147974_711448_4570"
    :range |DataRange| :multiplicity (1 1)
    :documentation
     "The DataRange complemented to define this datatype.")))

(def-meta-assoc "_17_0_4_1_e4a0319_1376903147973_159534_4569"      
  :name |ComplementDatatypeForComplement|      
  :metatype :association      
  :member-ends ((|ComplementDatatype| "OWLcomplementOf")
                ("_17_0_4_1_e4a0319_1376903147974_773692_4571" "complementDatatype"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1376903147974_773692_4571" "complementDatatype")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1376903147974_773692_4571" 
    :type |ComplementDatatype| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1376903147973_159534_4569" 
    :name "complementDatatype" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== DataRange
;;; =========================================================
(def-meta-class |DataRange| 
   (:model :ODM :superclasses (|RDFSClass|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1376902568636_588999_4436")
 "DataRange is an abstract class used for structuring the datatype expressions.
  It represents an anonymous type, but can also be used to define an OWLDatatype
  which is a named resource. Note, however, that these datatypes cannot themselves
  have DatatypeRestrictions nor they be used for Literals."
  ())

;;; =========================================================
;;; ====================== Dataset
;;; =========================================================
(def-meta-class |Dataset| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_17_0_3_e980341_1345649677035_898065_1818")
 "A RDF dataset is a collection of RDF graphs. Blank nodes may be shared
  between graphs in an RDF dataset."
  ((|defaultGraph| :xmi-id "_17_0_3_e980341_1345649801633_834517_1859"
    :range |Graph| :multiplicity (1 1) :is-composite-p T
    :documentation
     "the default graph for the dataset, which does not have a name and may be
      empty")
   (|namedGraph| :xmi-id "_17_0_3_e980341_1345650183917_915683_1925"
    :range |NamedGraph| :multiplicity (0 -1)
    :documentation
     "zero or more named graphs; each named graph is a pair consisting of the
      graph name and an RDF graph.")))

(def-meta-assoc "_17_0_3_e980341_1345649801633_757862_1858"      
  :name |DefaultGraphForDataset|      
  :metatype :association      
  :member-ends ((|Dataset| "defaultGraph")
                ("_17_0_3_e980341_1345649801633_231979_1860" "root"))      
  :owned-ends  (("_17_0_3_e980341_1345649801633_231979_1860" "root")))

(def-meta-assoc-end "_17_0_3_e980341_1345649801633_231979_1860" 
    :type |Dataset| 
    :multiplicity (0 1) 
    :association "_17_0_3_e980341_1345649801633_757862_1858" 
    :name "root" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_3_e980341_1345650183917_857747_1924"      
  :name |NamedGraphForDataset|      
  :metatype :association      
  :member-ends ((|Dataset| "namedGraph")
                ("_17_0_3_e980341_1345650183917_16955_1926" "root"))      
  :owned-ends  (("_17_0_3_e980341_1345650183917_16955_1926" "root")))

(def-meta-assoc-end "_17_0_3_e980341_1345650183917_16955_1926" 
    :type |Dataset| 
    :multiplicity (0 -1) 
    :association "_17_0_3_e980341_1345650183917_857747_1924" 
    :name "root" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== DatatypeRestriction
;;; =========================================================
(def-meta-class |DatatypeRestriction| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1376902835183_178747_4538")
 "This represents a DataRange which is a restriction of another datatype
  (which must be a RDFSDatatype)."
  ((|datatypeRestricted| :xmi-id "_17_0_4_1_e4a0319_1376903326453_943424_4645"
    :range |RDFSDatatype| :multiplicity (1 1)
    :documentation
     "The source datatype that the restriction is applied to.")
   (|exactLength| :xmi-id "_17_0_4_1_e4a0319_1384150379342_464509_4569"
    :range |UnlimitedNatural| :multiplicity (0 1)
    :documentation
     "exact string length (on string datatypes).")
   (|langRange| :xmi-id "_17_0_4_1_e4a0319_1384150424425_311427_4577"
    :range |String| :multiplicity (0 1)
    :documentation
     "restricts the natural language permitted for string datatypes. This is
      a Basic Language Range as specified in section 4.3 of the OWL 2 specification")
   (|maxExclusive| :xmi-id "_17_0_4_1_e4a0319_1384150235685_191746_4555"
    :range |String| :multiplicity (0 1)
    :documentation
     "maximum exclusive value (on numeric datatypes).")
   (|maxInclusive| :xmi-id "_17_0_4_1_e4a0319_1384150210193_746376_4551"
    :range |String| :multiplicity (0 1)
    :documentation
     "maximum inclusive value (on numeric datatypes).")
   (|maxLength| :xmi-id "_17_0_4_1_e4a0319_1384150357117_769435_4565"
    :range |UnlimitedNatural| :multiplicity (0 1)
    :documentation
     "maximum string length (on string datatypes).")
   (|minExclusive| :xmi-id "_17_0_4_1_e4a0319_1384150144876_518613_4547"
    :range |String| :multiplicity (0 1)
    :documentation
     "minimum exclusive value (on numeric datatypes)")
   (|minInclusive| :xmi-id "_17_0_4_1_e4a0319_1384150110578_356941_4543"
    :range |String| :multiplicity (0 1)
    :documentation
     "minimum inclusive value (on numeric datatypes).")
   (|minLength| :xmi-id "_17_0_4_1_e4a0319_1384150266938_615104_4559"
    :range |UnlimitedNatural| :multiplicity (0 1)
    :documentation
     "minimum string length (on string datatypes).")
   (|pattern| :xmi-id "_17_0_4_1_e4a0319_1384150407113_889408_4573"
    :range |String| :multiplicity (0 1)
    :documentation
     "pattern expressions constraining string datatypes. The syntax and usage
      is defined in Section 4.3.4 of [XML Schema Datatypes].")))

(def-meta-assoc "_17_0_4_1_e4a0319_1376903326453_633653_4644"      
  :name |DatatypeForRestriction|      
  :metatype :association      
  :member-ends ((|DatatypeRestriction| "datatypeRestricted")
                ("_17_0_4_1_e4a0319_1376903326454_900257_4646" "whereRestricted"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1376903326454_900257_4646" "whereRestricted")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1376903326454_900257_4646" 
    :type |DatatypeRestriction| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1376903326453_633653_4644" 
    :name "whereRestricted" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== Document
;;; =========================================================
(def-meta-class |Document| 
   (:model :ODM :superclasses (|Source|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223579_101066_3465")
 "RDF's conceptual model is a graph. RDF also provides an XML syntax for
  writing down and exchanging RDF graphs, called RDF/XML. An RDF document
  is a serialization of an RDF graph into a concrete syntax, as specified
  in [RDF Syntax], which provides the container for the graph, and conventionally
  also contains declarations of the XML namespaces referenced by the statements
  in the document. RDF refers to a set of IRIs, intended for use in a RDF
  Graph, as a vocabulary. Often, the IRIs in such vocabularies are organized
  so that they can be represented as sets of QNames using common prefixes.
  IRIs that are contained in the vocabulary are formed by appending individual
  local names to the relevant prefix. This practice is also commonly used
  in OWL ontology development for improved readability. While the metamodel
  does not explicitly support QNames, the elements required to enable such
  support in vendor implementations are provided."
  ((|documentIRI| :xmi-id "_16_8_e980341_1301491272472_229471_2032"
    :range IRI :multiplicity (0 -1) :is-composite-p T)
   (|resourceDefined| :xmi-id "_17_0_1_e980341_1311199238462_582667_2301"
    :range |RDFSResource| :multiplicity (0 -1)
    :documentation
     "the resources defined in this document.")
   (|triple| :xmi-id "_17_0_1_e980341_1311199233110_181087_2293"
    :range |Triple| :multiplicity (0 -1) :is-ordered-p T
    :documentation
     "links a document to the set of triples it contains.")))

(def-meta-assoc "_16_8_e980341_1301491272472_671767_2031"      
  :name |IRIForDocument|      
  :metatype :association      
  :member-ends ((|Document| "documentIRI")
                ("_16_8_e980341_1301491272472_932818_2033" "document"))      
  :owned-ends  (("_16_8_e980341_1301491272472_932818_2033" "document")))

(def-meta-assoc-end "_16_8_e980341_1301491272472_932818_2033" 
    :type |Document| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1301491272472_671767_2031" 
    :name "document" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311199238461_345066_2299"      
  :name |ResourceForDocument|      
  :metatype :association      
  :member-ends ((|Document| "resourceDefined")
                ("_17_0_1_e980341_1311199238462_487738_2300" "definingDocument"))      
  :owned-ends  (("_17_0_1_e980341_1311199238462_487738_2300" "definingDocument")))

(def-meta-assoc-end "_17_0_1_e980341_1311199238462_487738_2300" 
    :type |Document| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311199238461_345066_2299" 
    :name "definingDocument" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311199233100_673331_2292"      
  :name |TripleForDocument|      
  :metatype :association      
  :member-ends ((|Document| "triple")
                ("_17_0_1_e980341_1311199233110_178159_2294" "document"))      
  :owned-ends  (("_17_0_1_e980341_1311199233110_178159_2294" "document")))

(def-meta-assoc-end "_17_0_1_e980341_1311199233110_178159_2294" 
    :type |Document| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311199233100_673331_2292" 
    :name "document" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== EnumeratedClass
;;; =========================================================
(def-meta-class |EnumeratedClass| 
   (:model :ODM :superclasses (|ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_827007_3350")
 "A class description of the enumeration kind is defined with the owl:oneOf
  property. The value of this built-in OWL property must be a list of individuals
  that are the instances of the class. This enables a class to be described
  by exhaustively enumerating its instances."
  ((|OWLoneOf| :xmi-id "_15_5_2c17055e_1218847223579_400501_3493"
    :range |Individual| :multiplicity (0 -1)
    :documentation
     "links a class to the list of individuals that are its instances.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_297438_3186"      
  :name |IndividualForEnumeratedClass|      
  :metatype :association      
  :member-ends ((|EnumeratedClass| "OWLoneOf")
                ("_15_5_2c17055e_1218847223579_845752_3492" "enumeratedClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_845752_3492" "enumeratedClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_845752_3492" 
    :type |EnumeratedClass| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_297438_3186" 
    :name "enumeratedClass" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== ExactCardinalityRestriction
;;; =========================================================
(def-meta-class |ExactCardinalityRestriction| 
   (:model :ODM :superclasses (|CardinalityRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_59651_3254")
 "The cardinality constraint owl:cardinality is a built-in OWL property that
  links a restriction class to a data value belonging to the range of the
  XML Schema datatype xsd:nonNegativeInteger. A restriction containing an
  owl:cardinality constraint describes a class of all individuals that have
  exactly N semantically distinct values (individuals or data values) for
  the property concerned, where N is the value of the cardinality constraint.
  Syntactically, the cardinality constraint is represented as an RDF property
  element with the corresponding rdf:datatype attribute."
  ())


;;; =========================================================
;;; ====================== Graph
;;; =========================================================
(def-meta-class |Graph| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_729848_2886")
 "An RDF graph is a set of RDF triples. The set of nodes of an RDF graph
  is the set of subjects and objects of triples in the graph. A number of
  classes in the metamodel, including Graph, RDFStatement, Document, etc.,
  are included (1) for the sake of completeness, and (2) are provided for
  vendors to use, as needed from an application perspective. They may not
  be necessary for all tools, and may not necessarily be accessible to end
  users, again, depending on the application requirements."
  ((|bnode| :xmi-id "_16_8_e980341_1301075113066_113491_2223"
    :range |BlankNode| :multiplicity (0 -1) :is-composite-p T)
   (|triple| :xmi-id "_16_8_e980341_1301490360934_233717_1615"
    :range |Triple| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "links a graph to the triples it contains.")))

(def-meta-assoc "_16_8_e980341_1301075113066_910257_2222"      
  :name |BNodeForGraph|      
  :metatype :association      
  :member-ends ((|Graph| "bnode")
                ("_16_8_e980341_1301075113066_842772_2224" "graph"))      
  :owned-ends  (("_16_8_e980341_1301075113066_842772_2224" "graph")))

(def-meta-assoc-end "_16_8_e980341_1301075113066_842772_2224" 
    :type |Graph| 
    :multiplicity (1 1) 
    :association "_16_8_e980341_1301075113066_910257_2222" 
    :name "graph" 
    :visibility :PUBLIC)

(def-meta-assoc "_16_8_e980341_1301490360934_639396_1614"      
  :name |TripleForGraph|      
  :metatype :association      
  :member-ends ((|Graph| "triple")
                ("_16_8_e980341_1301490360934_475012_1616" "graph"))      
  :owned-ends  (("_16_8_e980341_1301490360934_475012_1616" "graph")))

(def-meta-assoc-end "_16_8_e980341_1301490360934_475012_1616" 
    :type |Graph| 
    :multiplicity (0 1) 
    :association "_16_8_e980341_1301490360934_639396_1614" 
    :name "graph" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== HasSelfRestriction
;;; =========================================================
(def-meta-class |HasSelfRestriction| 
   (:model :ODM :superclasses (|OWLRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1384166354647_85629_4102")
 "A HasSelfRestriction describes a class of all individuals for which the
  property concerned has a value semantically equal to the subject (it may
  have other values as well)."
  ())

;;; =========================================================
;;; ====================== HasValueRestriction
;;; =========================================================
(def-meta-class |HasValueRestriction| 
   (:model :ODM :superclasses (|OWLRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_171563_2907")
 "A HasValueRestriction describes a class of all individuals for which the
  property concerned has at least one value semantically equal to V (it may
  have other values as well)."
  ((|OWLhasIndividualValue| :xmi-id "_15_5_2c17055e_1218847223579_722197_3347"
    :range |Individual| :multiplicity (0 1)
    :documentation
     "links the restriction class to the class description containing the individual
      that fills its value role.")
   (|OWLhasLiteralValue| :xmi-id "_15_5_2c17055e_1218847223579_473292_3342"
    :range |Literal| :multiplicity (0 1) :is-composite-p T
    :documentation
     "links the restriction class to the literal that fills its value role.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_181458_3068"      
  :name |HasIndividualValue|      
  :metatype :association      
  :member-ends ((|HasValueRestriction| "OWLhasIndividualValue")
                ("_15_5_2c17055e_1218847223579_435072_3351" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_435072_3351" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_435072_3351" 
    :type |HasValueRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_181458_3068" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_156129_3208"      
  :name |HasLiteralValue|      
  :metatype :association      
  :member-ends ((|HasValueRestriction| "OWLhasLiteralValue")
                ("_15_5_2c17055e_1218847223579_524934_3343" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_524934_3343" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_524934_3343" 
    :type |HasValueRestriction| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_156129_3208" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== IRI
;;; =========================================================
(def-meta-class IRI 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223579_884717_3333")
 "An IRI (Internationalized Resource Identifier) is a Unicode string that
  conforms to the syntax defined in RFC 3987. IRIs are a generalization of
  URIs (Uniform Resource Identifiers, as defined in RFC3986), that can include
  a broader range of Unicode characters. IRIs in the RDF abstract syntax
  must be absolute, and may contain a fragment identifier. Some concrete
  RDF syntaxes allow the use of relative IRIs as a shorthand notation to
  make it easier to develop documents independently from their final publishing
  location. Relative IRIs must be resolved against a base IRI to make them
  absolute. Therefore, the RDF graph serialized in such syntaxes is well-defined
  only if a base IRI can be established per RFC3986."
  ((|iriString| :xmi-id "_17_0_1_e980341_1311615682939_224189_2161"
    :range |String| :multiplicity (1 1)
    :documentation
     "the string representing the IRI.")))
;;; =========================================================
;;; ====================== Individual
;;; =========================================================
(def-meta-class |Individual| 
   (:model :ODM :superclasses (|OWLUniverse|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223569_445540_3317")
 "Individuals are defined with individual axioms (also called facts). Two
  types of facts are supported in OWL: (1) Facts about class membership and
  property values of individuals, and (2) Facts about individual identity.
  Many facts are statements that define class membership of individuals and
  property values of individuals; these can also refer to anonymous individuals."
  ((|OWLdifferentFrom| :xmi-id "_15_5_2c17055e_1218847223559_970014_3122"
    :range |Individual| :multiplicity (0 -1))
   (|OWLsameAs| :xmi-id "_15_5_2c17055e_1218847223559_124447_2852"
    :range |Individual| :multiplicity (0 -1))))

(def-meta-assoc "_15_5_2c17055e_1218847223579_188242_3406"      
  :name |DifferentIndividual|      
  :metatype :association      
  :member-ends ((|Individual| "OWLdifferentFrom")
                ("_15_5_2c17055e_1218847223559_836775_3125" "differentIndividual"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_836775_3125" "differentIndividual")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_836775_3125" 
    :type |Individual| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_188242_3406" 
    :name "differentIndividual" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_805740_3006"      
  :name |SameIndividual|      
  :metatype :association      
  :member-ends ((|Individual| "OWLsameAs")
                ("_15_5_2c17055e_1218847223559_419309_2854" "sameIndividual"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_419309_2854" "sameIndividual")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_419309_2854" 
    :type |Individual| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_805740_3006" 
    :name "sameIndividual" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== IntersectionClass
;;; =========================================================
(def-meta-class |IntersectionClass| 
   (:model :ODM :superclasses (|ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_625799_3204")
 "The owl:intersectionOf property links a class to a list of class descriptions.
  An owl:intersectionOf statement describes a class for which the class extension
  contains precisely those individuals that are members of the class extension
  of all class descriptions in the list."
  ((|OWLintersectionOf| :xmi-id "_17_0_1_e980341_1306900008758_914489_1847"
    :range |ClassExpression| :multiplicity (2 -1)
    :documentation
     "links an intersection class to the classes participating in the intersection.")))

(def-meta-assoc "_17_0_1_e980341_1306900008752_645652_1844"      
  :name |IntersectionClassForIntersection|      
  :metatype :association      
  :member-ends ((|IntersectionClass| "OWLintersectionOf")
                ("_17_0_1_e980341_1306900008754_18472_1845" "intersectionClass"))      
  :owned-ends  (("_17_0_1_e980341_1306900008754_18472_1845" "intersectionClass")))

(def-meta-assoc-end "_17_0_1_e980341_1306900008754_18472_1845" 
    :type |IntersectionClass| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1306900008752_645652_1844" 
    :name "intersectionClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== IntersectionDatatype
;;; =========================================================
(def-meta-class |IntersectionDatatype| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1376902727232_128376_4506")
 "An owl:intersectionOf statement describes a datatype for which the extension
  contains exactly those values that belong to the extension of each of the
  data ranges that are the object of the statement. It is analogous to logical
  conjunction."
  ((|OWLintersectionOf| :xmi-id "_17_0_4_1_e4a0319_1376903212000_190125_4618"
    :range |DataRange| :multiplicity (2 -1)
    :documentation
     "The DataRanges intersectioned to form this datatype")))

(def-meta-assoc "_17_0_4_1_e4a0319_1376903212000_16574_4617"      
  :name |IntersectionDatatypeForIntersection|      
  :metatype :association      
  :member-ends ((|IntersectionDatatype| "OWLintersectionOf")
                ("_17_0_4_1_e4a0319_1376903212000_784365_4619" "intersectionDatatype"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1376903212000_784365_4619" "intersectionDatatype")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1376903212000_784365_4619" 
    :type |IntersectionDatatype| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1376903212000_16574_4617" 
    :name "intersectionDatatype" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== Literal
;;; =========================================================
(def-meta-class |Literal| 
   (:model :ODM :superclasses (|Node|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_648046_3143")
 "Literals are used to identify values such as numbers and dates by means
  of a lexical representation. Anything represented by a literal could also
  be represented by a URI, but it is often more convenient or intuitive to
  use literals. Literals have a lexical form, which is a Unicode string,
  and a datatype URI being an RDF URI reference. If they represents strings
  they may also have a language."
  ((|datatype| :xmi-id "_15_5_2c17055e_1218847223559_131520_3092"
    :range |RDFSDatatype| :multiplicity (1 1)
    :documentation
     "the link between the typed literal and the RDFSDatatype that defines its
      type (of which it is an instance).")
   (|language| :xmi-id "_15_5_2c17055e_1218847223569_680974_3294"
    :range |String| :multiplicity (0 1)
    :documentation
     "the optional language tag. The language property may only have a value
      if the datatype represents http://www.w3.org/1999/02/22-rdf-syntax-ns#langString.
      The value of the language property MUST be well-formed according to section
      2.2.9 of [BCP47].")
   (|lexicalForm| :xmi-id "_15_5_2c17055e_1218847223569_496943_3320"
    :range |String| :multiplicity (1 1)
    :documentation
     "represents a Unicode string in Normal Form C.")))

(def-meta-constraint "CannotHaveLabel" |Literal| 
   ""
   :operation-body
   "self.RDFSlabel -> isEmpty()")

(def-meta-constraint "CannotHaveURI" |Literal| 
   ""
   :operation-body
   "self.iri -> isEmpty()")

(def-meta-assoc "_15_5_2c17055e_1218847223559_830150_3050"      
  :name |DatatypeForLiteral|      
  :metatype :association      
  :member-ends ((|Literal| "datatype")
                ("_15_5_2c17055e_1218847223559_651528_3089" "literal"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_651528_3089" "literal")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_651528_3089" 
    :type |Literal| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_830150_3050" 
    :name "literal" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== MaxCardinalityRestriction
;;; =========================================================
(def-meta-class |MaxCardinalityRestriction| 
   (:model :ODM :superclasses (|CardinalityRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_991240_3202")
 "The cardinality constraint owl:maxCardinality is a built-in OWL property
  that links a restriction class to a data value belonging to the value space
  of the XML Schema datatype xsd:nonNegativeInteger. A restriction containing
  an owl:maxCardinality constraint describes a class of all individuals that
  have at most N semantically distinct values (individuals or data values)
  for the property concerned, where N is the value of the cardinality constraint.
  Syntactically, the cardinality constraint is represented as an RDF property
  element with the corresponding rdf:datatype attribute."
  ())

;;; =========================================================
;;; ====================== MinCardinalityRestriction
;;; =========================================================
(def-meta-class |MinCardinalityRestriction| 
   (:model :ODM :superclasses (|CardinalityRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_285424_3107")
 "The cardinality constraint owl:minCardinality is a built-in OWL property
  that links a restriction class to a data value belonging to the value space
  of the XML Schema datatype xsd:nonNegativeInteger. A restriction containing
  an owl:minCardinality constraint describes a class of all individuals that
  have at least N semantically distinct values (individuals or data values)
  for the property concerned, where N is the value of the cardinality constraint.
  Syntactically, the cardinality constraint is represented as an RDF property
  element with the corresponding rdf:datatype attribute."
  ())


;;; =========================================================
;;; ====================== NamedGraph
;;; =========================================================
(def-meta-class |NamedGraph| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1219353575538_322273_3948")
 "A named graph is a IRI and RDF graph pair. It effectively provides a way
  to name an RDF graph and thus refer to the graph in a graph."
  ((|graph| :xmi-id "_17_0_3_e980341_1351110276391_534891_2207"
    :range |Graph| :multiplicity (1 1) :is-composite-p T
    :documentation
     "the graph that is being named.")
   (|graphName| :xmi-id "_17_0_3_e980341_1345650739081_507996_2047"
    :range |Namespace| :multiplicity (1 1) :is-composite-p T
    :documentation
     "the name for the graph (as a Namespace)")))

(def-meta-assoc "_17_0_3_e980341_1351110276391_991309_2206"      
  :name |GraphForNamedGraph|      
  :metatype :association      
  :member-ends ((|NamedGraph| "graph")
                ("_17_0_3_e980341_1351110276391_675267_2208" "namedGraph"))      
  :owned-ends  (("_17_0_3_e980341_1351110276391_675267_2208" "namedGraph")))

(def-meta-assoc-end "_17_0_3_e980341_1351110276391_675267_2208" 
    :type |NamedGraph| 
    :multiplicity (0 1) 
    :association "_17_0_3_e980341_1351110276391_991309_2206" 
    :name "namedGraph" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_3_e980341_1345650739081_119419_2044"      
  :name |NameForGraph|      
  :metatype :association      
  :member-ends ((|NamedGraph| "graphName")
                ("_17_0_3_e980341_1345650739081_886356_2045" "namedGraph"))      
  :owned-ends  (("_17_0_3_e980341_1345650739081_886356_2045" "namedGraph")))

(def-meta-assoc-end "_17_0_3_e980341_1345650739081_886356_2045" 
    :type |NamedGraph| 
    :multiplicity (0 1) 
    :association "_17_0_3_e980341_1345650739081_119419_2044" 
    :name "namedGraph" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Namespace
;;; =========================================================
(def-meta-class |Namespace| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_357887_2948")
 "An XML namespace is a collection of names, identified by a IRI, which are
  used in XML documents as element types and attribute names."
  ((|namespaceIRI| :xmi-id "_15_5_2c17055e_1218847223559_996082_3024"
    :range IRI :multiplicity (1 1)
    :documentation
     "links a namespace to the corresponding IRI.")
   (|resourcesGrouped| :xmi-id "_17_0_4_1_e4a0319_1384310686360_971939_6244"
    :range |RDFSResource| :multiplicity (0 -1) :is-composite-p T
    :opposite (|RDFSResource| |groupingNamespace|)
    :documentation
     "the resources that are grouped by this namespace, i.e. that are based on
      its IRI.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_97055_3220"      
  :name |IRIForNamespace|      
  :metatype :association      
  :member-ends ((|Namespace| "namespaceIRI")
                ("_15_5_2c17055e_1218847223559_419574_3025" "namespace"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_419574_3025" "namespace")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_419574_3025" 
    :type |Namespace| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_97055_3220" 
    :name "namespace" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_4_1_e4a0319_1384310686360_258872_6243"      
  :name |NamespaceResources|      
  :metatype :association      
  :member-ends ((|Namespace| "resourcesGrouped")
                (|RDFSResource| "groupingNamespace"))      
  :owned-ends  ())

;;; =========================================================
;;; ====================== NamespaceDefinition
;;; =========================================================
(def-meta-class |NamespaceDefinition| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_472722_3009")
 "A namespace is declared using a family of reserved attributes. These attributes,
  like any other XML attributes, may be provided directly or by default.
  Some names in XML documents (constructs corresponding to the non-terminal
  Name) may be given as qualified names. The prefix provides the namespace
  prefix part of the qualified name, and must be associated with a namespace
  IRI in a namespace declaration. Namespace definitions are used in RDF and
  OWL for referencing and/or importing externally specified terms, vocabularies,
  or ontologies."
  ((|namespace| :xmi-id "_15_5_2c17055e_1218847223579_437123_3552"
    :range |Namespace| :multiplicity (1 1)
    :documentation
     "indicates that a namespace definition, if it exists, resolves to exactly
      one namespace.")
   (|prefix| :xmi-id "_17_0_1_e980341_1304610983744_157016_2190"
    :range |String| :multiplicity (1 1)
    :documentation
     "the string representing the namespace prefix.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_904942_3249"      
  :name |NamespaceDefinitionForNamespace|      
  :metatype :association      
  :member-ends ((|NamespaceDefinition| "namespace")
                ("_15_5_2c17055e_1218847223579_938133_3537" "namespaceDefinition"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_938133_3537" "namespaceDefinition")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_938133_3537" 
    :type |NamespaceDefinition| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_904942_3249" 
    :name "namespaceDefinition" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== Node
;;; =========================================================
(def-meta-class |Node| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1219341999773_378065_2994")
 "The subject and object of a Triple are of type Node. ReferenceNode, BlankNode,
  and Literal form a complete and disjoint covering of Node."
  ())

;;; =========================================================
;;; ====================== OWLAllDifferent
;;; =========================================================
(def-meta-class |OWLAllDifferent| 
   (:model :ODM :superclasses (|OWLClass|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_569904_3544")
 "For ontologies in which the unique-names assumption holds, the use of owl:differentFrom
  is likely to lead to a large number of statements, as all individuals have
  to be declared pairwise disjoint. For such situations OWL provides a special
  idiom in the form of the construct owl:AllDifferent. owl:AllDifferent is
  a special built-in OWL class, for which the property owl:distinctMembers
  is defined, which links an instance of owl:AllDifferent to a list of individuals.
  The intended meaning of such a statement is that all individuals in the
  list are all different from each other."
  ((|OWLdistinctMembers| :xmi-id "_15_5_2c17055e_1218847223559_429813_2942"
    :range |Individual| :multiplicity (2 -1)
    :documentation
     "specifies that a particular set of individuals are distinct from one another.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_134312_3005"      
  :name |DistinctIndividuals|      
  :metatype :association      
  :member-ends ((|OWLAllDifferent| "OWLdistinctMembers")
                ("_15_5_2c17055e_1218847223559_70295_2939" "allDifferent"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_70295_2939" "allDifferent")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_70295_2939" 
    :type |OWLAllDifferent| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_134312_3005" 
    :name "allDifferent" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLAnnotationProperty
;;; =========================================================
(def-meta-class |OWLAnnotationProperty| 
   (:model :ODM :superclasses (|OWLUniverse| |RDFProperty|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_727210_3169")
 "OWL Full does not put any constraints on annotations in an ontology. OWL
  Full does not put any constraints on annotations in an ontology. OWL DL
  allows annotations on classes, properties, individuals and ontology headers,
  as outlined in Section 11.8.1,    Classes in OWL DL."
  ())

;;; =========================================================
;;; ====================== OWLClass
;;; =========================================================
(def-meta-class |OWLClass| 
   (:model :ODM :superclasses (|OWLUniverse| |ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_242012_3072")
 "An OWLClass is a class that is a named resource."
  ((|isDeprecated| :xmi-id "_15_5_2c17055e_1218847223559_179468_2926"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "indicates that use of this class description is deprecated.")))

;;; =========================================================
;;; ====================== OWLDataEnumeration
;;; =========================================================
(def-meta-class |OWLDataEnumeration| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_654248_3352")
 "This represents a DataRange which is defined through listing its complete
  set of values."
  ((|dataOneOf| :xmi-id "_15_5_2c17055e_1218847223559_288499_2862"
    :range |Literal| :multiplicity (1 -1)
    :documentation
     "links a data range to the enumerated list of literals that comprise its
      values")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_508474_3182"      
  :name |ElementsForDataRange|      
  :metatype :association      
  :member-ends ((|OWLDataEnumeration| "dataOneOf")
                ("_15_5_2c17055e_1218847223559_407557_2859" "dataRange"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_407557_2859" "dataRange")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_407557_2859" 
    :type |OWLDataEnumeration| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_508474_3182" 
    :name "dataRange" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLDatatype
;;; =========================================================
(def-meta-class |OWLDatatype| 
   (:model :ODM :superclasses (|DataRange| |OWLUniverse|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1384138896974_718406_4495")
 "This represents a named Datatype which is a resource and is defined using
  a DataRange."
  ((|dataRange| :xmi-id "_17_0_4_1_e4a0319_1384152672081_773194_4601"
    :range |DataRange| :multiplicity (1 1)
    :documentation
     "The DataRange defining this datatype.")))

(def-meta-assoc "_17_0_4_1_e4a0319_1384152672081_508567_4600"      
  :name |DatatypeDefinition|      
  :metatype :association      
  :member-ends ((|OWLDatatype| "dataRange")
                ("_17_0_4_1_e4a0319_1384152672082_83747_4602" "datatypeDefined"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1384152672082_83747_4602" "datatypeDefined")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1384152672082_83747_4602" 
    :type |OWLDatatype| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1384152672081_508567_4600" 
    :name "datatypeDefined" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLDatatypeProperty
;;; =========================================================
(def-meta-class |OWLDatatypeProperty| 
   (:model :ODM :superclasses (|Property|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_651752_3088")
 "Datatype properties are used to link individuals to data values. A datatype
  property is defined as an instance of the built-in OWL class owl:DatatypeProperty."
  ())

;;; =========================================================
;;; ====================== OWLObjectProperty
;;; =========================================================
(def-meta-class |OWLObjectProperty| 
   (:model :ODM :superclasses (|Property|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223569_490561_3302")
 "An object property relates an individual to other individuals. An object
  property is defined as an instance of the built-in OWL class owl:ObjectProperty."
  ((|OWLinverseOf| :xmi-id "_15_5_2c17055e_1218847223559_127347_3197"
    :range |OWLObjectProperty| :multiplicity (0 -1))
   (|isAsymmetric| :xmi-id "_17_0_4_1_e4a0319_1384133523433_684135_4454"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "An asymmetric property is a property for which the triple (x, P, y) implies
      NOT(y, P, x)")
   (|isInverseFunctional| :xmi-id "_17_0_4_1_e4a0319_1384132961177_737065_4412"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "If a property is declared to be inverse-functional, then the object of
      a property statement uniquely determines the subject (some individual).
      More formally, if we state that isInverseFunctional = true for property
      P, then (x1, P, y) and (x2, P, y) are asserted then x1 is the same as x2
      (they cannot be distinct). Inverse-functional properties resemble the notion
      of a key in databases. Note that isInverseFunctional specifies global cardinality
      constraints. That is, no matter which class the property is applied to,
      the cardinality constraints must hold. This is different from the cardinality
      constraints contained in property restrictions. The latter are class descriptions
      and are only enforced on the property when applied to that class.")
   (|isIrreflexive| :xmi-id "_17_0_4_1_e4a0319_1384133539216_493797_4458"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "An irreflexive property is a property for which the triple (x, P, x) is
      always false.")
   (|isReflexive| :xmi-id "_17_0_4_1_e4a0319_1384133555841_970558_4462"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "A reflexive property is a property for which the triple (x, P, x) is always
      true")
   (|isSymmetric| :xmi-id "_17_0_4_1_e4a0319_1384133478406_119439_4446"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "A symmetric property is a property for which the triple (x, P, y) implies
      (y, P, x).")
   (|isTransitive| :xmi-id "_17_0_4_1_e4a0319_1384133493783_750212_4450"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "A transitive property is a property for which the triples (x, P, y) and
      (y, P, z) imply (x, P, z).")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_80673_3100"      
  :name |InverseProperty|      
  :metatype :association      
  :member-ends ((|OWLObjectProperty| "OWLinverseOf")
                ("_15_5_2c17055e_1218847223559_219756_3192" "inverseProperty"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_219756_3192" "inverseProperty")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_219756_3192" 
    :type |OWLObjectProperty| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_80673_3100" 
    :name "inverseProperty" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLOntology
;;; =========================================================
(def-meta-class |OWLOntology| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223569_768055_3300")
 "An OWL ontology contains a sequence of annotations, axioms, and facts.
  Annotations on OWL ontologies can be used to record authorship and other
  information associated with an ontology, including imports references to
  other ontologies. The main content of OWLOntology is carried in its axioms
  and facts, which provide information about classes, properties, and individuals
  in the ontology. Names of ontologies are used in the abstract syntax to
  carry the meaning associated with publishing an ontology on the Web. The
  intent is that the name of an ontology in the abstract syntax is the URI
  where it can be found, although this is not part of the formal meaning
  of OWL. Imports annotations, in effect, are directives to retrieve a Web
  document and treat it as an OWL ontology."
  ((|OWLbackwardCompatibleWith| :xmi-id "_15_5_2c17055e_1218847223579_432309_3402"
    :range |OWLOntology| :multiplicity (0 -1)
    :documentation
     "inks an ontology to zero or more other ontologies it has backwards compatibility
      with.")
   (|OWLimports| :xmi-id "_15_5_2c17055e_1218847223579_642851_3527"
    :range |OWLOntology| :multiplicity (0 -1)
    :documentation
     "inks an ontology to zero or more other ontologies it imports.")
   (|OWLincompatibleWith| :xmi-id "_15_5_2c17055e_1218847223559_417867_2944"
    :range |OWLOntology| :multiplicity (0 -1)
    :documentation
     "links an ontology to zero or more other ontologies it is not compatible
      with.")
   (|OWLpriorVersion| :xmi-id "_15_5_2c17055e_1218847223559_679171_2904"
    :range |OWLOntology| :multiplicity (0 -1)
    :documentation
     "links an ontology to zero or more other ontologies that are earlier versions
      of the current ontology.")
   (|OWLversionInfo| :xmi-id "_15_5_2c17055e_1218847223579_542592_3548"
    :range |Literal| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "links an ontology to an annotation providing version information.")
   (|owlUniverse| :xmi-id "_15_5_2c17055e_1218847223559_286577_2866"
    :range |OWLUniverse| :multiplicity (0 -1)
    :opposite (|OWLUniverse| |ontology|))
   (|triple| :xmi-id "_15_5_2c17055e_1219362791601_494644_2036"
    :range |Triple| :multiplicity (1 -1)
    :documentation
     "links an ontology to one or more triples it contains.")))

(def-meta-assoc "_15_5_2c17055e_1218847223579_12277_3543"      
  :name |BackwardCompatibleWith|      
  :metatype :association      
  :member-ends ((|OWLOntology| "OWLbackwardCompatibleWith")
                ("_15_5_2c17055e_1218847223579_426678_3400" "currentOntology"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_426678_3400" "currentOntology")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_426678_3400" 
    :type |OWLOntology| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_12277_3543" 
    :name "currentOntology" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_991192_3146"      
  :name |Imports|      
  :metatype :association      
  :member-ends ((|OWLOntology| "OWLimports")
                ("_15_5_2c17055e_1218847223579_284397_3528" "importingOntology"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_284397_3528" "importingOntology")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_284397_3528" 
    :type |OWLOntology| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_991192_3146" 
    :name "importingOntology" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223579_964970_3526"      
  :name |IncompatibleWith|      
  :metatype :association      
  :member-ends ((|OWLOntology| "OWLincompatibleWith")
                ("_15_5_2c17055e_1218847223559_744792_2945" "incompatibleOntology"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_744792_2945" "incompatibleOntology")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_744792_2945" 
    :type |OWLOntology| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_964970_3526" 
    :name "incompatibleOntology" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_381026_3098"      
  :name |PriorVersion|      
  :metatype :association      
  :member-ends ((|OWLOntology| "OWLpriorVersion")
                ("_15_5_2c17055e_1218847223559_219328_2899" "newerOntology"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_219328_2899" "newerOntology")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_219328_2899" 
    :type |OWLOntology| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_381026_3098" 
    :name "newerOntology" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1219362791601_790118_2035"      
  :name |TripleForOntology|      
  :metatype :association      
  :member-ends ((|OWLOntology| "triple")
                ("_15_5_2c17055e_1219362791601_702308_2037" "ontology"))      
  :owned-ends  (("_15_5_2c17055e_1219362791601_702308_2037" "ontology")))

(def-meta-assoc-end "_15_5_2c17055e_1219362791601_702308_2037" 
    :type |OWLOntology| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1219362791601_790118_2035" 
    :name "ontology" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_216339_3012"      
  :name |VersionInfo|      
  :metatype :association      
  :member-ends ((|OWLOntology| "OWLversionInfo")
                ("_15_5_2c17055e_1218847223579_833964_3547" "ontology"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_833964_3547" "ontology")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_833964_3547" 
    :type |OWLOntology| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_216339_3012" 
    :name "ontology" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLOntologyProperty
;;; =========================================================
(def-meta-class |OWLOntologyProperty| 
   (:model :ODM :superclasses (|OWLUniverse| |RDFProperty|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_260861_3566")
 "A document describing an ontology typically contains information about
  the ontology itself. An ontology is a resource, so it may be described
  using properties from the OWL and other namespaces. An ontology property
  is essentially an annotation property that allows us to say things about
  the current and other ontologies, such as indicating that a particular
  ontology is a prior version of the current ontology."
  ())

;;; =========================================================
;;; ====================== OWLRestriction
;;; =========================================================
(def-meta-class |OWLRestriction| 
   (:model :ODM :superclasses (|ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_657263_3503")
 "The class owl:Restriction is defined as a subclass of owl:Class. A restriction
  class should have exactly one triple linking the restriction to a particular
  property, using the owl:onProperty property. The restriction class should
  also have exactly one triple that represents the value constraint c.q.
  cardinality constraint on the property under consideration, e.g., that
  the cardinality of the property is exactly 1. Property restrictions can
  be applied both to datatype properties (properties for which the value
  is a data literal) and object properties (properties for which the value
  is an individual)."
  ((|OWLonProperty| :xmi-id "_15_5_2c17055e_1218847223579_886744_3535"
    :range |RDFProperty| :multiplicity (1 1)
    :documentation
     "links an OWL restriction class to the property that constrains it.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_286595_3017"      
  :name |RestrictionOnProperty|      
  :metatype :association      
  :member-ends ((|OWLRestriction| "OWLonProperty")
                ("_15_5_2c17055e_1218847223579_200410_3531" "propertyRestriction"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_200410_3531" "propertyRestriction")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_200410_3531" 
    :type |OWLRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_286595_3017" 
    :name "propertyRestriction" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== OWLUniverse
;;; =========================================================
(def-meta-class |OWLUniverse| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_551656_3473")
 "This class is intended to simplify packaging / mapping requirements for
  cases where the ability to determine the set of classes, individuals, and
  properties that together comprise a particular OWL ontology is required."
  ((|ontology| :xmi-id "_15_5_2c17055e_1218847223559_337080_2853"
    :range |OWLOntology| :multiplicity (1 -1)
    :opposite (|OWLOntology| |owlUniverse|)
    :documentation
     "specifies one or more OWLOntology that members of this universe are associated
      with/describe.")))

(def-meta-assoc "_15_5_2c17055e_1218847223579_25740_3397"      
  :name |UniverseForOntology|      
  :metatype :association      
  :member-ends ((|OWLUniverse| "ontology")
                (|OWLOntology| "owlUniverse"))      
  :owned-ends  ())


;;; =========================================================
;;; ====================== Property
;;; =========================================================
(def-meta-class |Property| 
   (:model :ODM :superclasses (|OWLUniverse| |RDFProperty|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_820312_2959")
 "Property is an abstract class that simplifies representation of property
  equivalence and deprecation, simplifies constraints for OWL DL and OWL
  Full, and facilitates mappings with other metamodels."
  ((|OWLequivalentProperty| :xmi-id "_15_5_2c17055e_1218847223559_929498_2871"
    :range |Property| :multiplicity (0 -1)
    :documentation
     "links a property to zero or more properties that it is considered equivalent
      to.")
   (|isDeprecated| :xmi-id "_15_5_2c17055e_1218847223559_376134_3168"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "indicates that use of this property is deprecated.")
   (|isFunctional| :xmi-id "_17_0_4_1_e4a0319_1384132865822_962692_4407"
    :range |Boolean| :multiplicity (0 1)
    :documentation
     "A functional property is a property that can have only one (unique) value
      y for each instance x, i.e., if the triples (x, P, y1) and (x, P, y2) are
      asserted then y1 must be the same as y2 (they cannot be distinct).")))

(def-meta-assoc "_15_5_2c17055e_1218847223579_714518_3337"      
  :name |EquivalentProperty|      
  :metatype :association      
  :member-ends ((|Property| "OWLequivalentProperty")
                ("_15_5_2c17055e_1218847223559_558704_2872" "equivalentProperty"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_558704_2872" "equivalentProperty")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_558704_2872" 
    :type |Property| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_714518_3337" 
    :name "equivalentProperty" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFAlt
;;; =========================================================
(def-meta-class |RDFAlt| 
   (:model :ODM :superclasses (|RDFSContainer|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223559_934070_3057")
 "This is the class of RDF Alternative containers. The rdf:Alt class is used
  conventionally to indicate to a human reader that typical processing will
  be to select one of the members of the container. The first member of the
  container, i.e,. the value of the rdf:_1 property, is the default choice."
  ())

;;; =========================================================
;;; ====================== RDFBag
;;; =========================================================
(def-meta-class |RDFBag| 
   (:model :ODM :superclasses (|RDFSContainer|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223579_443284_3546")
 "This is the class of RDF Bag containers. It is used conventionally to indicate
  that the container is intended to be unordered."
  ())

;;; =========================================================
;;; ====================== RDFList
;;; =========================================================
(def-meta-class |RDFList| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223579_304131_3433")
 "This class represents descriptions of RDF collections, conventionally called
  lists and other list-like structures."
  ((|RDFfirst| :xmi-id "_17_0_1_e980341_1311260471807_101038_2256"
    :range |RDFSResource| :multiplicity (0 1)
    :documentation
     "links a list to its first element.")
   (|RDFrest| :xmi-id "_15_5_2c17055e_1218847223579_628340_3358"
    :range |RDFList| :multiplicity (0 1)
    :documentation
     "links a list to its sublist excluding its first element.")))

(def-meta-assoc "_17_0_1_e980341_1311260471791_540843_2253"      
  :name |FirstElementInList|      
  :metatype :association      
  :member-ends ((|RDFList| "RDFfirst")
                ("_17_0_1_e980341_1311260471807_697709_2254" "list"))      
  :owned-ends  (("_17_0_1_e980341_1311260471807_697709_2254" "list")))

(def-meta-assoc-end "_17_0_1_e980341_1311260471807_697709_2254" 
    :type |RDFList| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311260471791_540843_2253" 
    :name "list" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_629780_2909"      
  :name |RestOfList|      
  :metatype :association      
  :member-ends ((|RDFList| "RDFrest")
                ("_15_5_2c17055e_1218847223579_397833_3361" "originalList"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_397833_3361" "originalList")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_397833_3361" 
    :type |RDFList| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_629780_2909" 
    :name "originalList" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFProperty
;;; =========================================================
(def-meta-class |RDFProperty| 
   (:model :ODM :superclasses (|RDFSResource|) ;(|RDFProperty|) ; POD package issue
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_17_0_1_e980341_1311203820155_369619_2965")
 "proxy for rdf:Property defined in the RDFBase package"
  ((|RDFSdomain| :xmi-id "_17_0_1_e980341_1311203931814_465328_3052"
    :range |RDFSClass| :multiplicity (0 -1)
    :documentation
     "links a property to zero or more classes representing the domain of that
      property. A triple of the form: P rdfs:domain C . states that P is an instance
      of the class rdf:Property, that C is an instance of the class rdfs:Class
      and that the resources denoted by the subjects of triples whose predicate
      is P are instances of the class C. Where a property P has more than one
      rdfs:domain property, then the resources denoted by subjects of triples
      with predicate P are instances of all the classes stated by the rdfs:domain
      properties.")
   (|RDFSrange| :xmi-id "_17_0_1_e980341_1311203926028_390355_3044"
    :range |RDFSClass| :multiplicity (0 -1)
    :documentation
     "links a property to zero or more classes representing the range of that
      property. A triple of the form: P rdfs:range C . states that P is an instance
      of the class rdf:Property, that C is an instance of the class rdfs:Class
      and that the resources denoted by the objects of triples whose predicate
      is P are instances of the class C. Where P has more than one rdfs:range
      property, then the resources denoted by the objects of triples with predicate
      P are instances of all the classes stated by the rdfs:range properties.")
   (|RDFSsubPropertyOf| :xmi-id "_17_0_1_e980341_1311203941664_113428_3068"
    :range |RDFProperty| :multiplicity (0 -1)
    :documentation
     "links a property to another property that generalizes it. The property
      rdfs:subPropertyOf is used to state that all resources related by one property
      are also related by another. A triple of the form: P1 rdfs:subPropertyOf
      P2 . states that P1 is an instance of rdf:Property, P2 is an instance of
      rdf:Property and P1 is a subproperty of P2. The rdfs:subPropertyOf property
      is transitive.")))

(def-meta-assoc "_17_0_1_e980341_1311203931813_635684_3049"      
  :name |DomainForProperty|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSdomain")
                ("_17_0_1_e980341_1311203931814_429887_3050" "propertyForDomain"))      
  :owned-ends  (("_17_0_1_e980341_1311203931814_429887_3050" "propertyForDomain")))

(def-meta-assoc-end "_17_0_1_e980341_1311203931814_429887_3050" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203931813_635684_3049" 
    :name "propertyForDomain" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203941662_608138_3065"      
  :name |PropertyGeneralization|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSsubPropertyOf")
                ("_17_0_1_e980341_1311203941663_713657_3066" "superPropertyOf"))      
  :owned-ends  (("_17_0_1_e980341_1311203941663_713657_3066" "superPropertyOf")))

(def-meta-assoc-end "_17_0_1_e980341_1311203941663_713657_3066" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203941662_608138_3065" 
    :name "superPropertyOf" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203926026_454246_3041"      
  :name |RangeForProperty|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSrange")
                ("_17_0_1_e980341_1311203926027_340405_3042" "propertyForRange"))      
  :owned-ends  (("_17_0_1_e980341_1311203926027_340405_3042" "propertyForRange")))

(def-meta-assoc-end "_17_0_1_e980341_1311203926027_340405_3042" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203926026_454246_3041" 
    :name "propertyForRange" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFProperty
;;; =========================================================
;(def-meta-class |RDFProperty| 
;   (:model :ODM :superclasses (|RDFSResource|) 
;    :packages ("ODM" "RDF" "RDFConcepts") 
;    :xmi-id "_15_5_2c17055e_1218847223579_637529_3542")
; "The RDF Concepts and Abstract Syntax specification [RDF Concepts] describes
;  the concept of an RDF property as a relation between subject resources
;  and object resources. Every property is associated with a set of instances,
;  called the property extension. Instances of properties are pairs of RDF
;  resources."
;  ())

(def-meta-assoc "_17_0_1_e980341_1311203931813_635684_3049"      
  :name |DomainForProperty|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSdomain")
                ("_17_0_1_e980341_1311203931814_429887_3050" "propertyForDomain"))      
  :owned-ends  (("_17_0_1_e980341_1311203931814_429887_3050" "propertyForDomain")))

(def-meta-assoc-end "_17_0_1_e980341_1311203931814_429887_3050" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203931813_635684_3049" 
    :name "propertyForDomain" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203941662_608138_3065"      
  :name |PropertyGeneralization|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSsubPropertyOf")
                ("_17_0_1_e980341_1311203941663_713657_3066" "superPropertyOf"))      
  :owned-ends  (("_17_0_1_e980341_1311203941663_713657_3066" "superPropertyOf")))

(def-meta-assoc-end "_17_0_1_e980341_1311203941663_713657_3066" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203941662_608138_3065" 
    :name "superPropertyOf" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203926026_454246_3041"      
  :name |RangeForProperty|      
  :metatype :association      
  :member-ends ((|RDFProperty| "RDFSrange")
                ("_17_0_1_e980341_1311203926027_340405_3042" "propertyForRange"))      
  :owned-ends  (("_17_0_1_e980341_1311203926027_340405_3042" "propertyForRange")))

(def-meta-assoc-end "_17_0_1_e980341_1311203926027_340405_3042" 
    :type |RDFProperty| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203926026_454246_3041" 
    :name "propertyForRange" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFSClass
;;; =========================================================
(def-meta-class |RDFSClass| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223579_336226_3390")
 "The group of resources that are RDF Schema classes is itself a class, called
  rdfs:Class. Classes provide an abstraction mechanism for grouping resources
  with similar characteristics. If a class C is a subclass of a class C',
  then all instances of C will also be instances of C'. The rdfs:subClassOf
  property may be used to state that one class is a subclass of another.
  The term superClassOf is used as the inverse of rdfs:subClassOf. If a class
  C' is a superclass of a class C, then all instances of C are also instances
  of C'."
  ((|RDFSsubClassOf| :xmi-id "_15_5_2c17055e_1218847223559_593034_3178"
    :range |RDFSClass| :multiplicity (0 -1)
    :documentation
     "inks a class to another class that generalizes it.")))

(def-meta-assoc "_15_5_2c17055e_1218847223579_674105_3379"      
  :name |ClassGeneralization|      
  :metatype :association      
  :member-ends ((|RDFSClass| "RDFSsubClassOf")
                ("_15_5_2c17055e_1218847223559_616975_3181" "superClassOf"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_616975_3181" "superClassOf")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_616975_3181" 
    :type |RDFSClass| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_674105_3379" 
    :name "superClassOf" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFSContainer
;;; =========================================================
(def-meta-class |RDFSContainer| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223579_582087_3408")
 "This is a super-class of RDF container classes."
  ())

;;; =========================================================
;;; ====================== RDFSContainerMembershipProperty
;;; =========================================================
(def-meta-class |RDFSContainerMembershipProperty| 
   (:model :ODM :superclasses (|RDFProperty|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223559_580343_2876")
 "The rdfs:ContainerMembershipProperty class has as instances the properties
  rdf:_1, rdf:_2, rdf:_3 ... that are used to state that a resource is a
  member of a container.. Each instance of this class is an rdfs:subPropertyOf
  the rdfs:memberOf property."
  ())

;;; =========================================================
;;; ====================== RDFSDatatype
;;; =========================================================
(def-meta-class |RDFSDatatype| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223559_181373_3142")
 "Datatypes are used by RDF in the representation of values such as integers,
  floating point numbers and dates. A datatype consists of a lexical space,
  a value space, and a lexical-to-value mapping. RDF predefines just one
  datatype rdf:XMLLiteral, used for embedding XML in RDF. There are no built-in
  concepts for numbers, dates, or other common values. Rather, RDF defers
  to datatypes that are defined separately and identified with URI references.
  The predefined XML Schema Datatypes [XML Schema Datatypes] are expected
  to be used for this purpose. Additionally, RDF provides no mechanism for
  defining new datatypes. XML Schema provides a framework suitable for defining
  new datatypes for use in RDF. rdfs:Datatype is the class of datatypes.
  All instances of rdfs:Datatype correspond to the RDF model of a datatype
  described in the RDF Concepts specification [RDF Concepts] rdfs:Datatype
  is both an instance of and a subclass of rdfs:Class. Each instance of rdfs:Datatype
  is a subclass of rdfs:Literal."
  ())

;;; =========================================================
;;; ====================== RDFSResource
;;; =========================================================
(def-meta-class |RDFSResource| 
    ;; I'm not bothering to accommodate the RDFS one. I borrowed its properties. (See below).
   (:model :ODM :superclasses nil ; (|RDFSResourcePrime|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_17_0_1_e980341_1311202866662_819360_2704")
 "proxy for rdfs:Resource defined in the RDFBase package. Note that the multiplicity
  on RDFtype is [1..*], meaning that every resource must be typed. Yet, many
  resources in RDF are not explicitly typed, so this may seem unintuitive
  from an RDF perspective. In essence, this says that every resource is,
  at a minimum, of type rdfs:Resource (required from a metamodeling and mapping
  perspective to support representation of RDF and OWL individuals without
  the addition of other artificial constructs). This does not, however, necessarily
  mean that vendors should add the inferred triples automatically when generating
  RDF/S and/or OWL from a model instance. This should only be done deliberately,
  depending on the application."
  ((|RDFSisDefinedBy| :xmi-id "_17_0_1_e980341_1311203041144_509377_2825"
    :range |RDFSResource| :multiplicity (0 -1)
    :documentation
     "relates a resource to another resource that defines it; rdfs:isDefinedBy
      is a subPropertyOf rdfs:seeAlso.")
   (|RDFSmember| :xmi-id "_17_0_1_e980341_1311260481011_130758_2272"
    :range |RDFSResource| :multiplicity (0 -1))
   (|RDFSseeAlso| :xmi-id "_17_0_1_e980341_1311203033808_932865_2809"
    :range |RDFSResource| :multiplicity (0 -1)
    :documentation
     "relates a resource to another resource that may provide additional information
      about it.")
   (|RDFtype| :xmi-id "_17_0_1_e980341_1311203047244_862592_2833"
    :range |RDFSClass| :multiplicity (1 -1)
    :documentation
     "relates a resource to its type (i.e., states that the resource is an instance
      of the class that is its type).")
  ;; Below here, from RDFSResourcePrime
  (|RDFScomment| :xmi-id "_15_5_2c17055e_1218847223579_443555_3405"
		 :range |Literal| :multiplicity (0 -1) :is-composite-p T)
  (|RDFSlabel| :xmi-id "_15_5_2c17055e_1218847223559_754717_2931"
	       :range |Literal| :multiplicity (0 -1) :is-composite-p T)
  (|groupingNamespace| :xmi-id "_17_0_4_1_e4a0319_1384310686361_962174_6245"
		       :range |Namespace| :multiplicity (0 1)
		       :opposite (|Namespace| |resourcesGrouped|))
  (|iri| :xmi-id "_15_5_2c17055e_1218847223569_560514_3274"
	 :range IRI :multiplicity (0 1) :is-composite-p T ;; POD Like in 2009, I changed multipllicity to (0,1) for qvt (was (0,-1))
	 :documentation
	 "iri: IRI [0..*] in association IRIForResource - the IRI(s) associated with
      a resource.")))

(def-meta-assoc "_15_5_2c17055e_1218847223579_600883_3399"      
  :name |CommentForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFScomment")
                ("_15_5_2c17055e_1218847223579_205586_3383" "commentedResource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_205586_3383" "commentedResource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_205586_3383" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223579_600883_3399" 
    :name "commentedResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203041143_655572_2822"      
  :name |DefinedByResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSisDefinedBy")
                ("_17_0_1_e980341_1311203041143_572399_2823" "definedResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203041143_572399_2823" "definedResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203041143_572399_2823" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203041143_655572_2822" 
    :name "definedResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223579_364431_3484"      
  :name |IRIForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "iri")
                ("_15_5_2c17055e_1218847223569_716525_3273" "resource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223569_716525_3273" "resource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223569_716525_3273" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223579_364431_3484" 
    :name "resource" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_240429_2829"      
  :name |LabelForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSlabel")
                ("_15_5_2c17055e_1218847223559_539219_2936" "labeledResource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_539219_2936" "labeledResource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_539219_2936" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_240429_2829" 
    :name "labeledResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311260481011_978137_2269"      
  :name |MemberOfResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSmember")
                ("_17_0_1_e980341_1311260481011_722074_2270" "container"))      
  :owned-ends  (("_17_0_1_e980341_1311260481011_722074_2270" "container")))

(def-meta-assoc-end "_17_0_1_e980341_1311260481011_722074_2270" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311260481011_978137_2269" 
    :name "container" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203033806_144859_2806"      
  :name |SeeAlsoForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSseeAlso")
                ("_17_0_1_e980341_1311203033807_351405_2807" "referringResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203033807_351405_2807" "referringResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203033807_351405_2807" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203033806_144859_2806" 
    :name "referringResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203047242_789615_2830"      
  :name |TypeForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFtype")
                ("_17_0_1_e980341_1311203047243_901781_2831" "typedResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203047243_901781_2831" "typedResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203047243_901781_2831" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203047242_789615_2830" 
    :name "typedResource" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFSResource
;;; =========================================================
#|
(def-meta-class |RDFSResourcePrime| ; POD did this.
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_114584_2992")
 "All things described by RDF are called resources. This is the class of
  everything. All other classes are subclasses of this class."
  ((|RDFScomment| :xmi-id "_15_5_2c17055e_1218847223579_443555_3405"
    :range |Literal| :multiplicity (0 -1) :is-composite-p T)
   (|RDFSlabel| :xmi-id "_15_5_2c17055e_1218847223559_754717_2931"
    :range |Literal| :multiplicity (0 -1) :is-composite-p T)
   (|groupingNamespace| :xmi-id "_17_0_4_1_e4a0319_1384310686361_962174_6245"
    :range |Namespace| :multiplicity (0 1)
    :opposite (|Namespace| |resourcesGrouped|))
   (|iri| :xmi-id "_15_5_2c17055e_1218847223569_560514_3274"
    :range IRI :multiplicity (0 1) :is-composite-p T ;; Like in 2009, I changed multipllicity to (0,1) for qvt (was (0,-1))
    :documentation
     "iri: IRI [0..*] in association IRIForResource - the IRI(s) associated with
      a resource.")))
|#

(def-meta-assoc "_15_5_2c17055e_1218847223579_600883_3399"      
  :name |CommentForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFScomment")
                ("_15_5_2c17055e_1218847223579_205586_3383" "commentedResource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223579_205586_3383" "commentedResource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223579_205586_3383" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223579_600883_3399" 
    :name "commentedResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203041143_655572_2822"      
  :name |DefinedByResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSisDefinedBy")
                ("_17_0_1_e980341_1311203041143_572399_2823" "definedResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203041143_572399_2823" "definedResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203041143_572399_2823" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203041143_655572_2822" 
    :name "definedResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223579_364431_3484"      
  :name |IRIForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "iri")
                ("_15_5_2c17055e_1218847223569_716525_3273" "resource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223569_716525_3273" "resource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223569_716525_3273" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223579_364431_3484" 
    :name "resource" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_240429_2829"      
  :name |LabelForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSlabel")
                ("_15_5_2c17055e_1218847223559_539219_2936" "labeledResource"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_539219_2936" "labeledResource")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_539219_2936" 
    :type |RDFSResource| 
    :multiplicity (0 1) 
    :association "_15_5_2c17055e_1218847223559_240429_2829" 
    :name "labeledResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311260481011_978137_2269"      
  :name |MemberOfResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSmember")
                ("_17_0_1_e980341_1311260481011_722074_2270" "container"))      
  :owned-ends  (("_17_0_1_e980341_1311260481011_722074_2270" "container")))

(def-meta-assoc-end "_17_0_1_e980341_1311260481011_722074_2270" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311260481011_978137_2269" 
    :name "container" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203033806_144859_2806"      
  :name |SeeAlsoForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFSseeAlso")
                ("_17_0_1_e980341_1311203033807_351405_2807" "referringResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203033807_351405_2807" "referringResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203033807_351405_2807" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203033806_144859_2806" 
    :name "referringResource" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_1_e980341_1311203047242_789615_2830"      
  :name |TypeForResource|      
  :metatype :association      
  :member-ends ((|RDFSResource| "RDFtype")
                ("_17_0_1_e980341_1311203047243_901781_2831" "typedResource"))      
  :owned-ends  (("_17_0_1_e980341_1311203047243_901781_2831" "typedResource")))

(def-meta-assoc-end "_17_0_1_e980341_1311203047243_901781_2831" 
    :type |RDFSResource| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203047242_789615_2830" 
    :name "typedResource" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== RDFSeq
;;; =========================================================
(def-meta-class |RDFSeq| 
   (:model :ODM :superclasses (|RDFSContainer|) 
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_15_5_2c17055e_1218847223559_928222_3097")
 "This is the class of RDF Sequence containers. It is used conventionally
  to indicate that the numerical ordering of the container membership properties
  of the container is intended to be significant."
  ())

;;; =========================================================
;;; ====================== RDFXMLLiteral
;;; =========================================================
(def-meta-class |RDFXMLLiteral| 
   (:model :ODM :superclasses (|Literal|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_590642_2975")
 "RDF predefines just one datatype, rdf:XMLLiteral, used for embedding XML
  in RDF. The class rdf:XMLLiteral is the class of XML literal values. It
  is an instance of RDFSDatatype and a subclass of TypedLiteral."
  ())

;;; =========================================================
;;; ====================== ReferenceNode
;;; =========================================================
(def-meta-class |ReferenceNode| 
   (:model :ODM :superclasses (|Node|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_142490_2962")
 "References to resources as subjects or objects of triples are captured
  as a distinct type of node: a ReferenceNode."
  ((|resource| :xmi-id "_17_0_1_e980341_1305581073882_452611_2244"
    :range |RDFSResource| :multiplicity (1 1)
    :documentation
     "the resource referenced by this node.")))

(def-meta-assoc "_17_0_1_e980341_1305581073881_240192_2243"      
  :name |ResourceForReference|      
  :metatype :association      
  :member-ends ((|ReferenceNode| "resource")
                ("_17_0_1_e980341_1305581073882_678145_2245" "referenceNode"))      
  :owned-ends  (("_17_0_1_e980341_1305581073882_678145_2245" "referenceNode")))

(def-meta-assoc-end "_17_0_1_e980341_1305581073882_678145_2245" 
    :type |ReferenceNode| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1305581073881_240192_2243" 
    :name "referenceNode" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== SomeValuesFromRestriction
;;; =========================================================
(def-meta-class |SomeValuesFromRestriction| 
   (:model :ODM :superclasses (|OWLRestriction|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223579_456067_3395")
 "A SomeValuesFromRestriction describes a class for which at least one value
  of the property under consideration is either a member of the class extension
  of the class description or is a data value within the specified data range.
  In other words, it defines a class of individuals x for which there is
  at least one y (either an instance of the class description or value in
  the data range) such that the pair (x, y) is an instance of P (the property
  concerned). This does not exclude that there are other instances (x, y')
  of P for which y' does not belong to the class description or data range."
  ((|OWLsomeValuesFromClass| :xmi-id "_15_5_2c17055e_1218847223559_213500_2842"
    :range |ClassExpression| :multiplicity (0 1)
    :documentation
     "links the restriction class to a class expression containing at least one
      of the values in its range.")
   (|OWLsomeValuesFromDataRange| :xmi-id "_15_5_2c17055e_1218847223559_443391_3081"
    :range |DataRange| :multiplicity (0 1)
    :documentation
     "links the restriction class to a data range containing at least one of
      the data values in its range.")))

(def-meta-assoc "_15_5_2c17055e_1218847223559_668632_3021"      
  :name |SomeValuesFromClass|      
  :metatype :association      
  :member-ends ((|SomeValuesFromRestriction| "OWLsomeValuesFromClass")
                ("_15_5_2c17055e_1218847223559_753659_2843" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_753659_2843" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_753659_2843" 
    :type |SomeValuesFromRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_668632_3021" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_186528_3223"      
  :name |SomeValuesFromDataRange|      
  :metatype :association      
  :member-ends ((|SomeValuesFromRestriction| "OWLsomeValuesFromDataRange")
                ("_15_5_2c17055e_1218847223559_364369_3080" "restrictionClass"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_364369_3080" "restrictionClass")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_364369_3080" 
    :type |SomeValuesFromRestriction| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_186528_3223" 
    :name "restrictionClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Source
;;; =========================================================
(def-meta-class |Source| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_16_8_e980341_1300998916350_324664_2074")
 "An RDF source is a persistent yet mutable source or container of RDF graphs.
  It is a resource that may be said to have a state that can change over
  time. A snapshot of the state can be expressed as an RDF graph. For example,
  any web document that has an RDF-bearing representation may be considered
  an RDF source. Like all resources, RDF sources may be named with IRIs and
  therefore described in other RDF graphs."
  ((|defaultNamespace| :xmi-id "_17_0_3_e980341_1344460099799_887908_2259"
    :range |Namespace| :multiplicity (0 1)
    :documentation
     "an optional default namespace for the source")
   (|graph| :xmi-id "_16_8_e980341_1300998978484_741577_2100"
    :range |Graph| :multiplicity (1 -1) :is-composite-p T
    :documentation
     "one or more graphs associated with the source.")
   (|namespaceDefinition| :xmi-id "_17_0_3_e980341_1344460539415_468114_2287"
    :range |NamespaceDefinition| :multiplicity (0 -1) :is-composite-p T
    :documentation
     "zero or more namespace definitions for the source, relating namespaces
      to preferred namespace prefixes, including an optional namespace prefix
      for the source as well as others used in the context of the source.")
   (|namespaceSuffixDelimiter| :xmi-id "_17_0_4_1_e4a0319_1384200365206_13415_6206"
    :range |String| :multiplicity (0 1) :default "/" ; pod this ws :"/" what gives?
    :documentation
     "the default is    /    and should not need to be specified; used to indicate
      when    #    is preferred")
   (|xmlBase| :xmi-id "_17_0_2_e980341_1317406059876_631078_1797"
    :range IRI :multiplicity (0 1)
    :documentation
     "an optional xmlbase allowing concise identification of elements in the
      source and, informally, linking them together in a vocabulary.")))

(def-meta-assoc "_17_0_2_e980341_1317406059871_919830_1794"      
  :name |BaseNamespace|      
  :metatype :association      
  :member-ends ((|Source| "xmlBase")
                ("_17_0_2_e980341_1317406059875_694794_1795" "vocabulary"))      
  :owned-ends  (("_17_0_2_e980341_1317406059875_694794_1795" "vocabulary")))

(def-meta-assoc-end "_17_0_2_e980341_1317406059875_694794_1795" 
    :type |Source| 
    :multiplicity (0 -1) 
    :association "_17_0_2_e980341_1317406059871_919830_1794" 
    :name "vocabulary" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_3_e980341_1344460099799_552704_2258"      
  :name |DefaultNamespaceForVocabulary|      
  :metatype :association      
  :member-ends ((|Source| "defaultNamespace")
                ("_17_0_3_e980341_1344460099799_793584_2260" "vocabulary"))      
  :owned-ends  (("_17_0_3_e980341_1344460099799_793584_2260" "vocabulary")))

(def-meta-assoc-end "_17_0_3_e980341_1344460099799_793584_2260" 
    :type |Source| 
    :multiplicity (0 1) 
    :association "_17_0_3_e980341_1344460099799_552704_2258" 
    :name "vocabulary" 
    :visibility :PUBLIC)

(def-meta-assoc "_17_0_3_e980341_1344460539415_982541_2286"      
  :name |NamespaceDefinitionForVocabulary|      
  :metatype :association      
  :member-ends ((|Source| "namespaceDefinition")
                ("_17_0_3_e980341_1344460539415_765019_2288" "vocabulary"))      
  :owned-ends  (("_17_0_3_e980341_1344460539415_765019_2288" "vocabulary")))

(def-meta-assoc-end "_17_0_3_e980341_1344460539415_765019_2288" 
    :type |Source| 
    :multiplicity (0 1) 
    :association "_17_0_3_e980341_1344460539415_982541_2286" 
    :name "vocabulary" 
    :visibility :PUBLIC)

(def-meta-assoc "_16_8_e980341_1300998978484_873240_2099"      
  :name |RootForGraph|      
  :metatype :association      
  :member-ends ((|Source| "graph")
                ("_16_8_e980341_1300998978484_735583_2101" "root"))      
  :owned-ends  (("_16_8_e980341_1300998978484_735583_2101" "root")))

(def-meta-assoc-end "_16_8_e980341_1300998978484_735583_2101" 
    :type |Source| 
    :multiplicity (1 1) 
    :association "_16_8_e980341_1300998978484_873240_2099" 
    :name "root" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== Statement
;;; =========================================================
(def-meta-class |Statement| 
   (:model :ODM :superclasses (|RDFSResource|) 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1218847223559_710426_3077")
 "Semantic extensions MAY limit the interpretation of these so that a triple
  of the form aaa rdf:type rdf:Statement . is true in I just when I(aaa)
  is a token of an RDF triple in some RDF document, and the three properties,
  when applied to such a denoted triple, have the same values as the respective
  components of that triple. This may be illustrated by considering the following
  two RDF graphs, the first of which consists of a single triple. <ex:a>
  <ex:b> <ex:c> . and _:xxx rdf:type rdf:Statement . _:xxx rdf:subject <ex:a>
  . _:xxx rdf:predicate <ex:b> . _:xxx rdf:object <ex:c> . The second graph
  is called a reification of the triple in the first graph, and the node
  which is intended to refer to the first triple - the blank node in the
  second graph - is called, rather confusingly, a reified triple. (This can
  be a blank node or a URI reference.) In the intended interpretation of
  the reification vocabulary, the second graph would be made true in an interpretation
  I by interpreting the reified triple to refer to a token of the triple
  in the first graph in some concrete RDF document, considering that token
  to be valid RDF syntax, and then using I to interpret the syntactic triple
  which the token instantiates, so that the subject, predicate and object
  of that triple are interpreted in the same way in the reification as in
  the triple described by the reification. [RDF Semantics, section 3.3]"
  ((|RDFobject| :xmi-id "_15_5_2c17055e_1218847223559_357535_2946"
    :range |RDFSResource| :multiplicity (1 1))
   (|RDFpredicate| :xmi-id "_15_5_2c17055e_1218847223559_334607_2822"
    :range |RDFProperty| :multiplicity (1 1))
   (|RDFsubject| :xmi-id "_15_5_2c17055e_1218847223559_474671_3161"
    :range |RDFSResource| :multiplicity (1 1))
   (|triple| :xmi-id "_15_5_2c17055e_1219353103299_919864_3870"
    :range |Triple| :multiplicity (0 1)
    :opposite (|Triple| |statement|))))

(def-meta-assoc "_15_5_2c17055e_1218847223559_711496_3265"      
  :name |RDFObject|      
  :metatype :association      
  :member-ends ((|Statement| "RDFobject")
                ("_15_5_2c17055e_1218847223559_45896_2940" "statementWithObject"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_45896_2940" "statementWithObject")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_45896_2940" 
    :type |Statement| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_711496_3265" 
    :name "statementWithObject" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223579_730139_3365"      
  :name |RDFPredicate|      
  :metatype :association      
  :member-ends ((|Statement| "RDFpredicate")
                ("_15_5_2c17055e_1218847223549_793955_2805" "statementWithPredicate"))      
  :owned-ends  (("_15_5_2c17055e_1218847223549_793955_2805" "statementWithPredicate")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223549_793955_2805" 
    :type |Statement| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223579_730139_3365" 
    :name "statementWithPredicate" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1218847223559_174423_2885"      
  :name |RDFSubject|      
  :metatype :association      
  :member-ends ((|Statement| "RDFsubject")
                ("_15_5_2c17055e_1218847223559_711200_3166" "statementWithSubject"))      
  :owned-ends  (("_15_5_2c17055e_1218847223559_711200_3166" "statementWithSubject")))

(def-meta-assoc-end "_15_5_2c17055e_1218847223559_711200_3166" 
    :type |Statement| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1218847223559_174423_2885" 
    :name "statementWithSubject" 
    :visibility :PUBLIC)


;;; =========================================================
;;; ====================== Triple
;;; =========================================================
(def-meta-class |Triple| 
   (:model :ODM :superclasses NIL 
    :packages ("ODM" "RDF" "RDFConcepts") 
    :xmi-id "_15_5_2c17055e_1219341923273_274379_2954")
 "An RDF triple contains three components: The subject, which is a resource
  reference or a blank node. The predicate, which is a resource reference
  and represents a relationship. The object, which is a resource reference,
  a literal, or a blank node. An RDF triple is conventionally written in
  the order subject, predicate, object. The relationship represented by the
  predicate is also known as the property of the triple. The direction of
  the arc is significant: it always points toward the object."
  ((|RDFobject| :xmi-id "_15_5_2c17055e_1219343416070_812092_3593"
    :range |Node| :multiplicity (1 1)
    :documentation
     "links a triple to the node that is the object of the triple.")
   (|RDFpredicate| :xmi-id "_15_5_2c17055e_1219342822266_802430_3321"
    :range |RDFProperty| :multiplicity (1 1)
    :documentation
     "links a triple to the property that is the predicate of the triple.")
   (|RDFsubject| :xmi-id "_15_5_2c17055e_1219343242991_350636_3378"
    :range |Node| :multiplicity (1 1)
    :documentation
     "links a triple to the node that is the subject of the triple.")
   (|statement| :xmi-id "_15_5_2c17055e_1219353103299_55199_3869"
    :range |Statement| :multiplicity (0 1)
    :opposite (|Statement| |triple|))))

(def-meta-assoc "_15_5_2c17055e_1219343416070_102363_3592"      
  :name |ObjectForTriple|      
  :metatype :association      
  :member-ends ((|Triple| "RDFobject")
                ("_15_5_2c17055e_1219343416070_878215_3594" "tripleWithObject"))      
  :owned-ends  (("_15_5_2c17055e_1219343416070_878215_3594" "tripleWithObject")))

(def-meta-assoc-end "_15_5_2c17055e_1219343416070_878215_3594" 
    :type |Triple| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1219343416070_102363_3592" 
    :name "tripleWithObject" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1219342822266_515272_3320"      
  :name |PredicateForTriple|      
  :metatype :association      
  :member-ends ((|Triple| "RDFpredicate")
                ("_15_5_2c17055e_1219342822266_500709_3322" "tripleWithPredicate"))      
  :owned-ends  (("_15_5_2c17055e_1219342822266_500709_3322" "tripleWithPredicate")))

(def-meta-assoc-end "_15_5_2c17055e_1219342822266_500709_3322" 
    :type |Triple| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1219342822266_515272_3320" 
    :name "tripleWithPredicate" 
    :visibility :PUBLIC)

(def-meta-assoc "_15_5_2c17055e_1219353103289_976024_3868"      
  :name |ReificationForTriple|      
  :metatype :association      
  :member-ends ((|Triple| "statement")
                (|Statement| "triple"))      
  :owned-ends  ())

(def-meta-assoc "_15_5_2c17055e_1219343242991_283553_3377"      
  :name |SubjectForTriple|      
  :metatype :association      
  :member-ends ((|Triple| "RDFsubject")
                ("_15_5_2c17055e_1219343242991_218672_3379" "tripleWithSubject"))      
  :owned-ends  (("_15_5_2c17055e_1219343242991_218672_3379" "tripleWithSubject")))

(def-meta-assoc-end "_15_5_2c17055e_1219343242991_218672_3379" 
    :type |Triple| 
    :multiplicity (0 -1) 
    :association "_15_5_2c17055e_1219343242991_283553_3377" 
    :name "tripleWithSubject" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== TypedLiteral
;;; =========================================================
(def-meta-class |TypedLiteral| 
   (:model :ODM :superclasses (|Literal|) ;;; POD Was RDF TypedLiteral (which inherited from Literal). Collapsing...
    :packages ("ODM" "RDF" "RDFS") 
    :xmi-id "_17_0_1_e980341_1311203211334_993277_2860")
 ""
  ((|datatype| :xmi-id "_17_0_1_e980341_1311203359701_765677_2910"
    :range |RDFSDatatype| :multiplicity (1 1))))

(def-meta-assoc "_17_0_1_e980341_1311203359701_929605_2909"      
  :name |DatatypeForTypedLiteral|      
  :metatype :association      
  :member-ends ((|TypedLiteral| "datatype")
                ("_17_0_1_e980341_1311203359701_422540_2911" "typedLiteral"))      
  :owned-ends  (("_17_0_1_e980341_1311203359701_422540_2911" "typedLiteral")))

(def-meta-assoc-end "_17_0_1_e980341_1311203359701_422540_2911" 
    :type |TypedLiteral| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203359701_929605_2909" 
    :name "typedLiteral" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== TypedLiteral
;;; =========================================================
;;; POD Eliminating inheritance
;(def-meta-class |TypedLiteral| 
;   (:model :ODM :superclasses (|Literal|) 
;    :packages ("ODM" "RDF" "RDFConcepts") 
;    :xmi-id "_15_5_2c17055e_1218847223579_867442_3359")
; "A typed literal is a string combined with a datatype URI. It denotes the
;  member of the identified datatype's value space obtained by applying the
;  lexical-to-value mapping to the literal string. [Resource Description Framework:
;  Concepts and Abstract Syntax, section 3.4]"
;  ())

(def-meta-assoc "_17_0_1_e980341_1311203359701_929605_2909"      
  :name |DatatypeForTypedLiteral|      
  :metatype :association      
  :member-ends ((|TypedLiteral| "datatype")
                ("_17_0_1_e980341_1311203359701_422540_2911" "typedLiteral"))      
  :owned-ends  (("_17_0_1_e980341_1311203359701_422540_2911" "typedLiteral")))

(def-meta-assoc-end "_17_0_1_e980341_1311203359701_422540_2911" 
    :type |TypedLiteral| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1311203359701_929605_2909" 
    :name "typedLiteral" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== UnionClass
;;; =========================================================
(def-meta-class |UnionClass| 
   (:model :ODM :superclasses (|ClassExpression|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_15_5_2c17055e_1218847223559_180467_2911")
 "The owl:unionOf property links a class to a list of class descriptions.
  An owl:unionOf statement describes an anonymous class for which the class
  extension contains those individuals that occur in at least one of the
  class extensions of the class descriptions in the list."
  ((|OWLunionOf| :xmi-id "_17_0_1_e980341_1306900143761_512091_1855"
    :range |ClassExpression| :multiplicity (2 -1)
    :documentation
     "links a union class to the class descriptions that participate in the union.")))

(def-meta-assoc "_17_0_1_e980341_1306900143756_373912_1852"      
  :name |UnionClassForUnion|      
  :metatype :association      
  :member-ends ((|UnionClass| "OWLunionOf")
                ("_17_0_1_e980341_1306900143759_381516_1853" "unionClass"))      
  :owned-ends  (("_17_0_1_e980341_1306900143759_381516_1853" "unionClass")))

(def-meta-assoc-end "_17_0_1_e980341_1306900143759_381516_1853" 
    :type |UnionClass| 
    :multiplicity (0 -1) 
    :association "_17_0_1_e980341_1306900143756_373912_1852" 
    :name "unionClass" 
    :visibility :PUBLIC)

;;; =========================================================
;;; ====================== UnionDatatype
;;; =========================================================
(def-meta-class |UnionDatatype| 
   (:model :ODM :superclasses (|DataRange|) 
    :packages ("ODM" "OWL" "OWLBase") 
    :xmi-id "_17_0_4_1_e4a0319_1376902702160_900878_4482")
 "An owl:unionOf statement describes a datatype for which the extension contains
  exactly those values that belong to the extension of at least one of the
  data ranges that are the object of the statement. It is analogous to logical
  disjunction."
  ((|OWLunionOf| :xmi-id "_17_0_4_1_e4a0319_1376903202335_13117_4597"
    :range |DataRange| :multiplicity (2 -1)
    :documentation
     "The DataRanges unioned to form this datatype.")))

(def-meta-assoc "_17_0_4_1_e4a0319_1376903202335_517390_4596"      
  :name |UnionDatatypeForUnion|      
  :metatype :association      
  :member-ends ((|UnionDatatype| "OWLunionOf")
                ("_17_0_4_1_e4a0319_1376903202336_286257_4598" "unionDatatype"))      
  :owned-ends  (("_17_0_4_1_e4a0319_1376903202336_286257_4598" "unionDatatype")))

(def-meta-assoc-end "_17_0_4_1_e4a0319_1376903202336_286257_4598" 
    :type |UnionDatatype| 
    :multiplicity (0 -1) 
    :association "_17_0_4_1_e4a0319_1376903202335_517390_4596" 
    :name "unionDatatype" 
    :visibility :PUBLIC)


(def-meta-package ODM NIL :ODM 
   (RDF
    OWL) :xmi-id "_15_5_2c17055e_1218847223559_968043_2830")

(def-meta-package OWL ODM :ODM 
   (OWLDL
    |OWLBase|
    |OWLFull|) :xmi-id "_15_5_2c17055e_1218847223559_2096_2892")

(def-meta-package |OWLBase| OWL :ODM 
   (|OWLClass|
    |OWLRestriction|
    |EnumeratedClass|
    |OWLAllDifferent|
    |OWLOntologyProperty|
    |MaxCardinalityRestriction|
    |OWLObjectProperty|
    |ComplementClass|
    |OWLOntology|
    |OWLAnnotationProperty|
    |Individual|
    |IntersectionClass|
    |Property|
    |HasValueRestriction|
    |ExactCardinalityRestriction|
    |UnionClass|
    |OWLUniverse|
    |OWLDatatypeProperty|
    |OWLDataEnumeration|
    |MinCardinalityRestriction|
    |SomeValuesFromRestriction|
    |AllValuesFromRestriction|
    |ClassExpression|
    |DataRange|
    |ComplementDatatype|
    |UnionDatatype|
    |IntersectionDatatype|
    |DatatypeRestriction|
    |OWLDatatype|
    |HasSelfRestriction|
    |CardinalityRestriction|) :xmi-id "_15_5_2c17055e_1218847223559_146511_3103")

(def-meta-package OWLDL OWL :ODM 
   () :xmi-id "_15_5_2c17055e_1218847223559_277714_2902")

(def-meta-package |OWLFull| OWL :ODM 
   () :xmi-id "_15_5_2c17055e_1218847223559_34463_3041")

(def-meta-package RDF ODM :ODM 
   (RDFS
    |RDFConcepts|) :xmi-id "_15_5_2c17055e_1218847223579_315471_3568")

(def-meta-package |RDFConcepts| RDF :ODM 
   (|BlankNode|
    |RDFXMLLiteral|
    |Triple|
    |TypedLiteral|
    |Statement|
    |Graph|
    |RDFProperty|
    |Node|
    |Literal|
    |Source|
    |RDFSResource|
    |ReferenceNode|
    |Dataset|
    |NamedGraph|
    |Document|
    IRI
    |Namespace|
    |NamespaceDefinition|) :xmi-id "_15_5_2c17055e_1218847223559_720925_2973")

(def-meta-package RDFS RDF :ODM 
   (|RDFAlt|
    |RDFBag|
    |RDFSClass|
    |RDFSDatatype|
    |RDFList|
    |RDFSeq|
    |RDFSContainerMembershipProperty|
    |RDFSContainer|
    |RDFSResource|
    |TypedLiteral|
    |RDFProperty|) :xmi-id "_15_5_2c17055e_1218847223559_917028_3121")

(in-package :mofi)

;;; POD Mistakes could be made here
(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(ODM::|CardinalityRestriction|
          ODM::|DataRange|
          ODM::|OWLRestriction|
          ODM::|OWLUniverse|
          ODM::|Property|))
     (setf mofi:ns-uri NIL)
     (setf mofi:ns-prefix "odm"))
