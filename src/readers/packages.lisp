(in-package :cl-user)

;;; According to Figure 1, dm imports p7tm and rdl
;;;                        p7tm import p7tpl
;;; and the RDL will import template instances.

(pod::defpackage* :dm
  (:nicknames "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/data-model#"
	      :part2 :ISO15926-2 :p2)
  (:use :cl :pod :closer-mop :expo)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod))


;;; was "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template#"
;;; Part 8 says it is for: "Templates defined in ISO/TS 15926-7, proto-templates and 'initial set'
;;; core templates."
(pod::defpackage* :p7tpl
  (:nicknames "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tpl#")
  (:export
   #:|InitialSetTemplateStatement|
   #:|ProtoTemplateStatement|
   #:|script|)) ; Looking at mmt file, it looks like these are the only thing in that namespace!

;;; was "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#"
;;; Part 8 says it is for: "Normative OWL declarations for templates and template roles "
(pod::defpackage* :p7tm
  (:nicknames "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tm#")
  (:export
   #:|BaseTemplateStatement|
   #:|hasRole|
   #:|hasRoleFillerType|
   #:|hasSubTemplate|
   #:|hasSuperTemplate|
   #:|hasTemplate|
   #:|TemplateDescription|
   #:|TemplateRoleDescription|
   #:|TemplateSpecialization|
   #:|valFOLCode|
   #:|valNumberOfRoles|
   #:|valRoleIndex|))

;;; I think the package :xsd is defined by Anderson.
(pod::defpackage* :xml-xsd
  (:nicknames "http://www.w3.org/2001/XMLSchema#")
  (:export
   #:|DateTime|
   date-time-val))

(pod::defpackage* "http://www.w3.org/2002/07/owl#"
  (:nicknames :owl "owl")
  (:export
   #:|allValuesFrom|
   #:|Class|
   #:|DataTypeProperty|
   #:|ObjectProperty|
   #:|intersectionOf|
   #:|onProperty|
   #:|Ontology|
   #:|qualifiedCardinality|
   #:|Restriction|
   #:|Thing|))

(pod::defpackage* "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  (:nicknames :rdf :rdf-ns "rdf")
  (:export
   #:|about|
   #:|datatype|
   #:id
   #:RDF
   #:|resource|
   #:|type|))

(pod::defpackage* "http://www.w3.org/2000/01/rdf-schema#"
  (:nicknames :rdfs "rdfs")
  (:export
   #:|comment|
   #:|label|
   #:|subClassOf|))

(pod::defpackage* :odm-cl
  (:use :cl :mofi :ocl :ptypes :pod-utils)
  (:shadowing-import-from :ocl #:|body|)
  (:export
   ;; ODM-CL also exports the following symbols:
   #:|binding| #:|predicate| #:|ExistentialQuantification|
   #:|QuantifiedSentence| #:|Implication| #:|lvalue|
   #:|AtomicSentence| #:|CommentedSentence| #:|argument|
   #:|localDomain| #:|commentForText| #:|Negation|
   #:|identifierForText| #:|Identifier| #:|Name|
   #:|FunctionalTerm| #:|Atom| #:|Equation| #:|Binding|
   #:|assertedContent| #:|Term| #:|phrase| #:|Argument|
   #:|Comment| #:|excludedName| #:|Importation|
   #:|sentence| #:|CommentedTerm| #:|Biconditional|
   #:|UniversalQuantification| #:|ExclusionSet| #:|body|
   #:|comment| #:|Sentence| #:|consequent| #:|boundName|
   #:|Module| #:|exclusionSet| #:|IrregularSentence|
   #:|conjunct| #:|rvalue| #:|Phrase|
   #:|boundSequenceMarker| #:|Conjunction| #:|antecedent|
   #:|disjunct| #:|SequenceMarker| #:|Disjunction|
   #:|operator| #:|BooleanSentence| #:|name| #:|Text|
   #:|term|))


;;; Exporting not working correctly on ODM, at least.
(export '(odm-cl::|Biconditional|
	  odm-cl::|BooleanSentence|
	  odm-cl::|AtomicSentence|
	  odm-cl::|lvalue|
	  odm-cl::|rvalue|
	  odm-cl::|ExistentialQuantification|
	  odm-cl::|UniversalQuantification|
	  odm-cl::|binding|
	  odm-cl::|Conjunction|
	  odm-cl::|conjunct|
	  odm-cl::|AtomicSentence|
	  odm-cl::|predicate|
	  odm-cl::|argument|)
	:odm-cl)

(pod::defpackage* :tlogic
  (:use :cl :pod :closer-mop :odm-cl)
  (:nicknames :tlog)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
;  (:shadow #:processing-results)
  (:export
   #:comment
   #:conditions
   #:name
   #:index
   #:instance-error
   #:instance-warning
   #:logic
   #:logic-text
   #:parent-template
   #:p2name2p7name
   #:p7name2p2name
   #:rds-parse
   #:rds-lookup-desig2pca-id
   #:rds-lookup-pca-id2desig
   #:read-owl
   #:roles
   #:sparql-query
   #:stringify
   #:template
   #:template-error
   #:template-warning
   #:template-role
   #:tlogic-parse-error
   #:tlogic-unresolved-class
   #:tlogic-cannot-resolve-base-template
   #:translate-legacy-ns
   #:type
   #:type-symbol
   #:xsd-standard-class))

;;; 2022 Move this?
(defclass tlogic:xsd-standard-class (standard-class)
  ())

(defmethod validate-superclass ((class tlogic:xsd-standard-class)
				(superclass standard-class))
  t)


(pod::defpackage* :p7
  (:use :cl :pod :tr :closer-mop :tlogic)
  (:nicknames :iso15926-7)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:*initial-set*
   #:template-formal))


(pod::defpackage* :emerson
  (:use :cl :pod :tr :closer-mop :tlogic)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:toplevel-read-emerson))
