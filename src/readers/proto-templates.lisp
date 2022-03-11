
(in-package :iso15926-2)

;;; Purpose: functions for proto-templates.

;;; Prototemplates are defined for the relational entity types of 15926-2. 
;;; Clause 2.1.21: "The Relational entity types of ISO 15926 are all the entity types [of 15926-2 ?] 
;;; which have exactly two attributes, except class_of_relationship."
;;;
;;; That's not quite what what was intended. What they intend are the single entity types
;;; that define two attributes, and subtypes of these. Those subtypes may define more attributes.

(defparameter *relational-entity-types* nil "A list of the relational entity types.")

(defun find-entity-type (name &key (error-p t))
  "Return the mex:EntityType with name NAME (a string) Can use either _ or camelcase naming scheme."
  (reset-15926-mofi-members)
  (loop for e across (mofi:members (mofi:find-model :15926-2)) with n = nil
     when (and (typep e 'mex:|EntityType|)
	       (or (string= name (setf n (mex:%local-name (mex:%id e))))
		   (string= name (dash-to-camel! n))))
     do (return-from find-entity-type e))
  (when error-p (error "No entity-type ~A" name)))

(defun entity-subtype-of-p (x y)
  "Return T if X is equal Y or a proper subtype of Y."
  (member y (entity-cpl x)))

;;; POD may not yet be properly ordered! Or maybe it is. (Not investigated).
(defun entity-cpl (c)
  "Returns the class precedence list of class C."
  (remove-duplicates (cons c (mapappend #'entity-cpl (mex:%subtype-of c)))))

;;; This includes the subtypes (not strictly what 15926-7 calls 'relational entity types', 
;;; but then, their definition is quite flawed!
(defun compute-relational-entity-types ()
  "Return a list of the subtypes of mex:EntityType Relationship."
  (let ((rel (find-entity-type "Relationship")))
    (remove rel
	    (loop for e in (remove-if-not #'(lambda (x) (typep x 'mex:|EntityType|)) 
					  (coerce (mofi:members (mofi:find-model :15926-2)) 'list))
	       when (and
		     (entity-subtype-of-p e rel)
		     (not (entity-subtype-of-p e (find-entity-type "ClassOfRelationship"))))
	       collect e))))


    

;;; Here are the ones used in the initial set
#|
(OtherRelationshipTriple ?U ?X2 ?X3)
(ClassOfIdentificationTriple ?U ?X2 ?X1)
(IndirectPropertyTriple ?U ?X2 ?X3)
(ApprovalTriple ?U ?X1 ?X3)
(InvolvementByReferenceTriple ?U ?X1 ?X2)
(EntityTriple ?X ?Y1 ?Y2)
(SpecializationTriple ?Y ?X1 ?X2)
(PropertyQuantificationTriple ?U ?X1 ?X2)
(ClassOfIndirectPropertyTriple ?U ?X1 ?X3)
(ScaleTriple ?X1 ?X4 ?X3)
|#


(defparameter *set-in-doc* 
  '("Approval"
    "BoundaryOfNumberSpace"
    "BoundaryOfPropertySpace"
    "CauseOfEvent"
    "ClassOfApproval"
    "ClassOfCauseOfBeginningOfClassOfIndividual"
    "ClassOfCauseOfEndingOfClassOfIndividual"
    "ClassOfClassOfComposition"
    "ClassOfClassOfRepresentation"
    "ClassOfClassOfRepresentationTranslation"
    "ClassOfClassOfResponsibilityForRepresentation"
    "ClassOfClassOfUsageOfRepresentation"
    "ClassOfClassification"
    "ClassOfCompositionOfIndividual"
    "ClassOfConnectionOfIndividual"
    "ClassOfDimensionForShape"
    "ClassOfFunctionalMapping"
    "ClassOfIndirectProperty"
    "ClassOfIndividualUsedInConnection"
    "ClassOfIntendedRoleAndDomain"
    "ClassOfInvolvementByReference"
    "ClassOfNamespace"
    "ClassOfParticipation"
    "ClassOfPossibleRoleAndDomain"
    "ClassOfRecognition"
    "ClassOfRelationshipWithSignature"
    "ClassOfRelativeLocation"
    "ClassOfRepresentationOfThing"
    "ClassOfRepresentationTranslation"
    "ClassOfResponsibilityForRepresentation"
    "ClassOfScaleConversion"
    "ClassOfSpecialization"
    "ClassOfTemporalSequence"
    "ClassOfUsageOfRepresentation"
    "Classification"
    "ComparisonOfProperty"
    "CompositionOfIndividual"
    "ConnectionOfIndividual"
    "DifferenceOfSetOfClass"
    "DimensionOfIndividual"
    "DimensionOfShape"
    "FunctionalMapping"
    "IndirectProperty"
    "IndividualUsedInConnection"
    "IntendedRoleAndDomain"
    "IntersectionOfSetOfClass"
    "InvolvementByReference"
    "LifecycleStage"
    "LowerBoundOfNumberRange"
    "LowerBoundOfPropertyRange"
    "OtherRelationship"
    "PossibleRoleAndDomain"
    "PropertyForShapeDimension"
    "PropertyQuantification"
    "PropertySpaceForClassOfShapeDimension"
    "Recognition"
    "RelativeLocation"
    "RepresentationOfThing"
    "ResponsibilityForRepresentation"
    "Scale"
    "Specialization"
    "SpecializationByRole"
    "SpecializationOfIndividualDimensionFromProperty"
    "TemporalSequence"
    "UnionOfSetOfClass"
    "UpperBoundOfNumberRange"
    "UpperBoundOfPropertyRange"
    "UsageOfRepresentation"))

(defparameter *set-in-doc-subtype* 
  '("ArrangementOfIndividual"
    "AssemblyOfIndividual"
    "Beginning"
    "ClassOfArrangementOfIndividual"
    "ClassOfAssemblyOfIndividual"
    "ClassOfClassOfDefinition"
    "ClassOfClassOfDescription"
    "ClassOfClassOfIdentification"
    "ClassOfClassOfRelationshipWithSignature"
    "ClassOfContainmentOfIndividual"
    "ClassOfDefinition"
    "ClassOfDescription"
    "ClassOfDirectConnection"
    "ClassOfFeatureWholePart"
    "ClassOfIdentification"
    "ClassOfIndirectConnection"
    "ClassOfIsomorphicFunctionalMapping"
    "ClassOfLeftNamespace"
    "ClassOfRightNamespace"
    "ClassOfTemporalWholePart"
    "ContainmentOfIndividual"
    "CoordinateSystem"
    "Definition"
    "Description"
    "DirectConnection"
    "Ending"
    "FeatureWholePart"
    "Identification"
    "IndirectConnection"
    "LeftNamespace"
    "MultidimensionalScale"
    "Namespace"
    "Participation"
    "RightNamespace"
    "SpecializationByDomain"
    "TemporalBounding"
    "TemporalWholePart"))


;;; All of these are either subtypes of Relationship or subtypes of Class
;;; None are subtypes of both. They all either have 2 defined or redefined attributes and 
;;; ClassOfRelationship is only a subtype of Class.
(defun wtf-are-these? ()
  "Determine the conditions for membership in *set-in-doc*."
  (let* ((set-in-doc         (mapcar #'find-entity-type *set-in-doc*))
	 (set-in-doc-subtype (mapcar #'find-entity-type *set-in-doc-subtype*))
	 (total-in-doc (append set-in-doc set-in-doc-subtype))
	 (members (coerce (mofi:members (mofi:find-model :15926-2)) 'list))
	 (entity-types (remove-if-not #'(lambda (x) (typep x 'mex:|EntityType|)) members))
	 (rel (find-entity-type "Relationship"))
	 (cla (find-entity-type "Class")) ; Don't know why this should be included!
	 (clara (find-entity-type "ClassOfRelationship"))
	 (oneof-rel-cla-2-attrs ; but some of these are subtypes of ClassOfRelationship
	  (loop for e in entity-types
 	        when (and (or (and (entity-subtype-of-p e rel) 
				   (not (entity-subtype-of-p e cla)))
			      (and (not (entity-subtype-of-p e rel))
				   (entity-subtype-of-p e cla))) ; ONEOF eliminates 5
			  (= 2 (+ (length (mex:%declares (mex:%declares e)))
				  (length (mex:%redeclarations e)))))
	       collect e))
	 (subtypes-of-those
	  (loop for e in entity-types
	       when (and (some #'(lambda (x) (entity-subtype-of-p e x)) oneof-rel-cla-2-attrs)
			 (not (member e oneof-rel-cla-2-attrs)))
	     collect e))
	 (total-calculated ;(remove-if #'(lambda (x) (entity-subtype-of-p x clara))
				      (append oneof-rel-cla-2-attrs subtypes-of-those)));)
    (format t "~% Number in doc: ~A" (length total-in-doc))
    (format t "~% Number calculcated: ~A" (length total-calculated))
    (list
     (set-difference total-in-doc total-calculated)
     (set-difference total-calculated total-in-doc))))

;;; There are 43 of these. 
(defun these-are-clara ()
  "Determine the conditions for membership in *set-in-doc*."
  (let* ((set-in-doc         (mapcar #'find-entity-type *set-in-doc*))
	 (set-in-doc-subtype (mapcar #'find-entity-type *set-in-doc-subtype*))
	 (total-in-doc (append set-in-doc set-in-doc-subtype))
	 (clara (find-entity-type "ClassOfRelationship")))
    (loop for e in total-in-doc
	  when (entity-subtype-of-p e clara) collect e)))


#| 
 Not resolved. Possibly they don't actually care whether or not
 the entity types are "relational." They might only want 3-place
 templates. (They don't have those right either!)
|#
