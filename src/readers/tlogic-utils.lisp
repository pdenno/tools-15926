
(in-package :tlogic)

(declaim (inline p7name2p2name p2name2p7name))
(defun p7name2p2name (str)
  "PossibleIndividual to POSSIBLE_INDIVIDUAL"
  (string-upcase (c-name2lisp (string str) :dash #\_)))

(defun p2name2p7name (str)
  "POSSIBLE_INDIVIDUAL to PossibleIndividual"
  (dash-to-camel (string-downcase (string str))))

(declaim (inline predicate-arity unary-predicate-p binary-predicate-p proto-triple-p))
(defun predicate-arity (atom)
  (length (odm:%argument atom)))

(defun unary-predicate-p (atom)
  "Return T if AtomicSentence ATOM is unary."
  (null (cdr (odm:%argument atom))))

(defun binary-predicate-p (atom)
  "Return T if AtomicSentence ATOM is unary."
  (= 2 (length (odm:%argument atom))))

(defun proto-triple-p (atom)
  "Return type name if AtomicSentence ATOM is a proto-template triple."
  (mvb (success vec)
      (cl-ppcre:scan-to-strings "^([a-z,A-Z,0-9]+)Triple$" (odm:%predicate atom))
    (when success (svref vec 0))))

(defun proto-template-p (atom)
  "Return type name if AtomicSentence ATOM is a proto-template triple."
  (mvb (success vec)
      (cl-ppcre:scan-to-strings "^([a-z,A-Z,0-9]+)Template$" (odm:%predicate atom))
    (when success (svref vec 0))))

(declaim (inline find-iclass))
;;; (find-class 'part2:arranged_individual)
;;; (find-iclass 'arranged_individual)
(defun find-iclass (name)
  "Find the instantiable-express-entity-type corresponding to name."
  (when (find-class (intern (string name) :part2) nil)
    (expo::find-programmatic-class (list (intern (string name) :part2)) :allow-partial t)))

;;; Probably just for diagnostics
(defun find-template (name &key (model-name :mmt-templates) model)
  "Find a template named NAME (a string) in a MOF model."
  (when-bind (m (or model (mofi:find-model model-name)))
    (find (string name) (mofi:templates m) :test #'string= :key #'name)))

;;; Probably just for diagnostics
(defun tlogic-find-instance (id)
    "Find the instance with debug-id ID in the MUT."
    (with-vo (mofi::mut)
      (when-bind (ht (mofi:instances mofi::mut))
	(loop for inst being the hash-value of ht 
	   when (and (mofi:%debug-id inst)
		     (= id (mofi:%debug-id inst)))
	     return inst))))

;;; From https://www.posccaesar.org/wiki/ISO15926inOWLPart2EntityMembership
(defparameter *defined-classification-relations*
  '(("CLASS_OF_ABSTRACT_OBJECT" "ABSTRACT_OBJECT")
    ("CLASS_OF_ACTIVITY" "ACTIVITY")
    ("CLASS_OF_APPROVAL" "APPROVAL")
    ("CLASS_OF_ARRANGEMENT_OF_INDIVIDUAL" "ARRANGEMENT_OF_INDIVIDUAL")
    ("CLASS_OF_ASSEMBLY_OF_INDIVIDUAL" "ASSEMBLY_OF_INDIVIDUAL")
    ("CLASS_OF_CLASS" "CLASS")
    ("CLASS_OF_CLASS_OF_DEFINITION" "CLASS_OF_DEFINITION")
    ("CLASS_OF_CLASS_OF_DESCRIPTION" "CLASS_OF_DESCRIPTION")
    ("CLASS_OF_CLASS_OF_IDENTIFICATION" "CLASS_OF_IDENTIFICATION")
    ("CLASS_OF_CLASS_OF_INDIVIDUAL" "CLASS_OF_INDIVIDUAL")
    ("CLASS_OF_CLASS_OF_RELATIONSHIP" "CLASS_OF_RELATIONSHIP")
    ("CLASS_OF_CLASS_OF_RELATIONSHIP_WITH_SIGNATURE" "CLASS_OF_RELATIONSHIP_WITH_SIGNATURE")
    ("CLASS_OF_CLASS_OF_REPRESENTATION_TRANSLATION" "CLASS_OF_REPRESENTATION_TRANSLATION")
    ("CLASS_OF_CLASS_OF_RESPONSIBILITY_FOR_REPRESENTATION" "CLASS_OF_RESPONSIBILITY_FOR_REPRESENTATION")
    ("CLASS_OF_CLASS_OF_USAGE_OF_REPRESENTATION" "CLASS_OF_USAGE_OF_REPRESENTATION")
    ("CLASS_OF_CLASSIFICATION" "CLASSIFICATION")
    ("CLASS_OF_COMPOSITION_OF_INDIVIDUAL" "COMPOSITION_OF_INDIVIDUAL")
    ("CLASS_OF_CONNECTION_OF_INDIVIDUAL" "CONNECTION_OF_INDIVIDUAL")
    ("CLASS_OF_CONTAINMENT_OF_INDIVIDUAL" "CONTAINMENT_OF_INDIVIDUAL")
    ("CLASS_OF_DIRECT_CONNECTION" "DIRECT_CONNECTION")
    ("CLASS_OF_EVENT" "EVENT")
    ("CLASS_OF_FEATURE_WHOLE_PART" "FEATURE_WHOLE_PART")
    ("CLASS_OF_INDIRECT_CONNECTION" "INDIRECT_CONNECTION")
    ("CLASS_OF_INDIVIDUAL_USED_IN_CONNECTION" "INDIVIDUAL_USED_IN_CONNECTION")
    ("CLASS_OF_INVOLVEMENT_BY_REFERENCE" "INVOLVEMENT_BY_REFERENCE")
    ("CLASS_OF_LIFECYCLE_STAGE" "LIFECYCLE_STAGE")
    ("CLASS_OF_MULTIDIMENSIONAL_OBJECT" "MULTIDIMENSIONAL_OBJECT")
    ("CLASS_OF_PERIOD_IN_TIME" "PERIOD_IN_TIME")
    ("CLASS_OF_POINT_IN_TIME" "POINT_IN_TIME")
    ("CLASS_OF_PROPERTY" "PROPERTY")
    ("CLASS_OF_PROPERTY_SPACE" "PROPERTY_SPACE")
    ("CLASS_OF_RELATIONSHIP" "RELATIONSHIP")
    ("CLASS_OF_RELATIVE_LOCATION" "RELATIVE_LOCATION")
    ("CLASS_OF_SCALE" "SCALE")
    ("CLASS_OF_SHAPE" "SHAPE")
    ("CLASS_OF_SPECIALIZATION" "SPECIALIZATION")
    ("CLASS_OF_STATUS" "STATUS")
    ("CLASS_OF_TEMPORAL_WHOLE_PART" "TEMPORAL_WHOLE_PART")
    ;; These are also defined, but they don't follow the pattern)
    ("CLASS_OF_CLASS_OF_REPRESENTATION"  "CLASS_OF_REPRESENTATION_OF_THING")
    ("CLASS_OF_INDIVIDUAL" "POSSIBLE_INDIVIDUAL")
    ("CLASS_OF_NUMBER" "ARITHMETIC_NUMBER")
    ("CLASS_OF_CLASS_OF_COMPOSITION" "CLASS_OF_COMPOSITION_OF_INDIVIDUAL")))

;;; Note that there are also a set things for which there is a "ClassOfX" but no X is defined in Part 2. 

;;; Also from https://www.posccaesar.org/wiki/ISO15926inOWLPart2EntityMembership
;;; These follow the pattern, but the text doesn't specifically say that the 
;;; classification relationship exists.
(defparameter *intended-classification-relations*
  '(("CLASS_OF_ARRANGED_INDIVIDUAL" "ARRANGED_INDIVIDUAL")
    ("CLASS_OF_CLASS_OF_INFORMATION_REPRESENTATION" "CLASS_OF_INFORMATION_REPRESENTATION")
    ("CLASS_OF_DEFINITION" "DEFINITION")
    ("CLASS_OF_DESCRIPTION" "DESCRIPTION")
    ("CLASS_OF_FUNCTIONAL_MAPPING" "FUNCTIONAL_MAPPING")
    ("CLASS_OF_IDENTIFICATION" "IDENTIFICATION")
    ("CLASS_OF_INDIRECT_PROPERTY" "INDIRECT_PROPERTY")
    ("CLASS_OF_INTENDED_ROLE_AND_DOMAIN" "INTENDED_ROLE_AND_DOMAIN")
    ("CLASS_OF_LEFT_NAMESPACE" "LEFT_NAMESPACE")
    ("CLASS_OF_NAMESPACE" "NAMESPACE")
    ("CLASS_OF_PARTICIPATION" "PARTICIPATION")
    ("CLASS_OF_POSSIBLE_ROLE_AND_DOMAIN" "POSSIBLE_ROLE_AND_DOMAIN")
    ("CLASS_OF_RECOGNITION" "RECOGNITION")
    ("CLASS_OF_REPRESENTATION_OF_THING" "REPRESENTATION_OF_THING")
    ("CLASS_OF_RESPONSIBILITY_FOR_REPRESENTATION" "RESPONSIBILITY_FOR_REPRESENTATION")
    ("CLASS_OF_RIGHT_NAMESPACE" "RIGHT_NAMESPACE")
    ("CLASS_OF_SHAPE_DIMENSION" "SHAPE_DIMENSION")
    ("CLASS_OF_TEMPORAL_SEQUENCE" "TEMPORAL_SEQUENCE")
    ("CLASS_OF_USAGE_OF_REPRESENTATION" "USAGE_OF_REPRESENTATION")
    ;; These next ones are where the text SEEMS TO INDICATE that the individual is of the class.
    ("CLASS_OF_RELATIONSHIP_WITH_SIGNATURE" "OTHER_RELATIONSHIP")
    ("CLASS_OF_INDIRECT_PROPERTY" "INDIRECT_PROPERTY")
    ("SHAPE_DIMENSION" "INDIVIDUAL_DIMENSION")
    ("PROPERTY_SPACE" "PROPERTY")
    ("CLASS_OF_ORGANIZATION" "PHYSICAL_OBJECT")))


