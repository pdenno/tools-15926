
;; Purpose: Define objects for the "initial set" of templates described in 15926-7 Clause 6.3


(in-package :iso15926-7)

(defclass easy-template ()
  ;; camelCase text identifier
  ((name :initarg :name :initform nil :reader name)
   ;; text description
   (desc :initarg :desc :initform nil :reader desc)
   ;; roles and types of each object
   (sig  :initarg :sig :initform nil :reader sig)
   ;; A string, typically containing just one biconditional
   (formal :initarg :formal :initform nil :reader template-formal)))

(defmethod print-object ((obj easy-template) stream)
  (format stream "{Easy-Template ~A}" (name obj)))

(defparameter *initial-set* nil "List of 19 initial templates for individuals and 26 initial templates
 for classes.")

(defun show-initial-set ()
  (loop for temp in *initial-set* do 
       (pprint (template-formal temp))
       (format t "~2%")))

(defmacro def-template (name &key desc sig formal)
  (with-gensyms (old)
    `(progn 
       (when-bind (,old (find ',name *initial-set* :key #'name))
	 (setf *initial-set* (remove ,old *initial-set*)))
       (push (make-instance 'easy-template :name ',name :desc ,desc :sig ,sig :formal ,formal)
	    *initial-set*))))

;;;===========================================================
;;; Clause 6 -- Templates for individuals
;;;===========================================================

;;; 6.3.1 ClassificationOfIndividual
;;; EXAMPLE The classification of Alfred as an Engineer can be expressed using this template. 
;;; The expansion of the statement ClassificationOfIndividual(Alfred, Person) -- isInstanceOf
(def-template |ClassificationOfIndividual|
    :desc "This is a template for classification of individuals (as opposed to pairs of individuals, 
           classes, or relations).ClassificafionOfIndividual(a, b) means that a is an individual, 
           b is a class of individuals, and a is a member of b."
    :sig
    '((1 "Individual" |PossibleIndividual|)
      (2 "Class" |ClassOfIndividual|))
    :formal 
    "(<=>
       (ClassificationOfIndividual ?X ?Y) 
       (and (PossibleIndividual ?X) 
            (ClassOfIndividual ?Y)
            (ClassificationTemplate ?X ?Y)))")

;;; 6.3.2 ClassificationOfRelationship
;;; EXAMPLE ClassificationOfRelationship((Alfred, ACME Co.), Employment) -- So it just means
;;; that Employment is a relationship, it doesn't classify it.
(def-template |ClassificationOfRelationship|
    :desc "This is a template for giving type to relationships. It is a classification template, 
           restricted to classifying pairs of things as members of relations.
           ClassificafionOFRelationship(a, b) means that a is an ordered pair, 
           b is a relation, and a is a member of b."
    :sig
    '((1 "Pair" |Relationship|)
      (2 "Relation" |ClassOfRelation|))
    :formal 
    "(<=>
       (ClassificationOfRelationship ?X ?Y) 
       (and (Relationship ?X) 
	    (ClassOfRelationship ?Y) 
	    (ClassificationTemplate ?X ?Y)))")


;;; 6.3.3 InstanceOfRelationship
;;; EXAMPLE Let Alfred and ACME Co. be instances of Person, and Employment a custom-defined relation 
;;; (i.e., a ClassOfRelationshipWithSignature). InstanceOfRelation(Employment, Alfred, ACME Co.) then expands 
;;;  to the following representation...
(def-template |InstanceOfRelationship|
    :desc "This is a template for expressing relationships that do not have a predefined ISO 15926-2 type. 
           InstanceOfRelation(a, b, c) means that a is a custom-defined relation by which b is related to c."
    :sig
    '((1 "Relation" |ClassOfRelationshipWithSignature|)
      (2 "First element" |Thing|)
      (3 "Second element" |Thing|))
    :formal 
    "(<=>
     (InstanceOfRelation ?X1 ?X2 ?X3) 
     (and (ClassOfRelationshipWithSignature ?X1)
	  (Thing ?X2) 
	  (Thing ?X3) 
	  (exists (?U) (and (OtherRelationshipTriple ?U ?X2 ?X3)
			    (ClassificationOfRelationship ?U ?X1)))))")

;;; 6.3.4
(def-template |IdentificationByNumber|
    :desc "IdenfificafionByNumber(a, b) means that a is a real number, and a refers to b."
    :sig
    '((1 "Identifier" |ExpressReal|)
      (2 "Identified" |Thing|))
    :formal 
    "(<=>
     (InstanceOfRelation ?X1 ?X2 ?X3) 
     (and (ClassOfRelationshipWithSignature ?X1)
	  (Thing ?X2)
	  (Thing ?X3) 
	  (exists (?U) (and (OtherRelationshipTriple ?U ?X2 ?X3)
			    (ClassificationOfRelationship ?U ?X1)))))")

;;; 6.3.5
;;; EXAMPLE The statement ClassifiedIdentification("Alfred", "PN4723", "Employee No. ACME Co.") 
;;; (e.g., an assignment of employee number) expands as follows...
(def-template |ClassifiedIdentification|
    :desc "This is a template for typed naming of things.
           ClassifiedIdentification(a, b, c) means that b is a string and c a type of name assignment, 
           and that b is a c-type name for a."
    :sig
    '((1 "Object" |Thing|)
      (2 "Identifier" |ExpressString|)
      (3 "Context" |ClassOfClassOfIdentification|))
    :formal 
    "(<=>
       (ClassifiedIdentification ?X1 ?X2 ?X3) 
       (and (Thing ?X1) 
	    (ExpressString ?X2) 
	    (ClassOfClassOfIdentification ?X3) 
	    (exists (?U) (and (ClassOfIdentificationTriple ?U ?X2 ?X1)
			      (ClassificationTemplate ?U ?X3)))))")

;;; 6.3.6 LocationOfActivity
(def-template |LocationOfActivity|
    :desc "This is a template for stating where activities take place.
           LocationOfActivity(a, b) means that a is an activity, b is a location, and that a takes place at b."
    :sig
    '((1 "Activity" |Activity|)
      (2 "Location" |SpatialLocation|))
    :formal 
    "(<=>
      (LocationOfActivity ?X1 ?X2) 
      (and (Activity ?X1) 
	  (SpatialLocation ?X2) 
	  (InstanceOfRelation (ActivityLocation ?X1 ?X2))))")   ; <================== POD ???

;;; 6.3.7 BeginningOfIndividual
(def-template |BeginningOfIndividual|
    :desc "This is a template for stating start time of existence.
           BeginningOflndividual(a, b) means that a is an individual and b is a point in time, 
           and that a begins to exist at b."
    :sig
    '((1 "Individual" |PossibleIndividual|)
      (2 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
      (BeginningOfIndividual ?X1 ?X2) 
      (and (PossibleIndividual ?X1)  
	   (RepresentationOfGregorianDateAndUtcTime ?X2)
	   (exists (?U) (and (PointInTime ?U) 
		  	     (BeginningTemplate ?U ?X1) 
			     (ClassOfRepresentationOfThingTemplate ?X2 ?U)))))")

;;; 6.3.8 BeginningEndOfIndividual
(def-template |BeginningEndOfIndividual|
    :desc "This is a template for stating start and end times of existence.
           BeginningEndOfIndividual(a, b, c) means that a is an individual and b and c are points in time, 
           and that a begins to exist at b and ceases to exist at c."
    :sig
    '((1 "Individual" |PossibleIndividual|)
      (2 "Start time" |RepresentationOfGregorianDateAndUtcTime|)
      (3 "End time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
      (BeginningEndOfIndividual ?X1 ?X2 ?X3)
       (and (PossibleIndividual ?X1)  
	    (RepresentationOfGregorianDateAndUtcTime ?X2)
	    (RepresentationOfGregorianDateAndUtcTime ?X3) 
	    (exists (?U) (and (PointInTime ?U) 
			    (BeginningTemplate ?U ?X2) 
			    (ClassOfRepresentationOfThingTemplate ?X2 ?U)))
	    (exists (?V) (and (PointInTime ?V) 
 			    (EndTemplate ?V ?X3) 
			    (ClassOfRepresentationOfThingTemplate ?X3 ?V)))))")

;;; 6.3.9 BeginningOfTemporalPart
(def-template |BeginningOfTemporalPart|
    :desc "This template is for stating that an individual is a temporal part of another, 
           initiated at a time represented by a timestamp data value.
           BeginningOfTemporalPart(a, b, c) means that a is an individual and 
           b is an individual and c is a point in time, that a is a temporal part of b, 
           and that a begins to exist at c."
    :sig
    '((1 "Part" |PossibleIndividual|)
      (2 "Whole" |PossibleIndividual|)
      (3 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
      (BeginningOfTemporalPart ?X1 ?X2 ?X3) 
      (and (PossibleIndividual ?X1)  
	   (PossibleIndividual ?X2)
	   (RepresentationOfGregorianDateAndUtcTime ?X3)
	   (TemporalWholePartTemplate ?X2 ?X2)
 	   (BeginningOfIndividual ?X1 ?X3)))")

;;; 6.3.10 BeginningEndLocationOfActivity
(def-template |BeginningEndLocationOfActivity|
    :desc "This is a template for expressing where and when an activity takes place.
           BeginningEndLocationOfActivity(a, b, c, d) means that a is an activity, b and c are points in time, 
           and d is a location, and that a takes place at d, starting at b and ending at c."
    :sig
    '((1 "Activity" |Activity|)
      (2 "Start time" |RepresentationOfGregorianDateAndUtcTime|)
      (3 "End time"   |RepresentationOfGregorianDateAndUtcTime|)
      (4 "Location" |SpatialLocation|))
    :formal 
    "(<=>
      (BeginningEndLocationOfActivity ?X1 ?X2 ?X3 ?X4) 
      (and (Activity ?X1)
	   (RepresentationOfGregorianDateAndUtcTime ?X2) 
	   (RepresentationOfGregorianDateAndUtcTime ?X3) 
	   (SpatialLocation ?X4) 
	   (BeginningEndOfIndividual ?X1 ?X2 ?X3)
	   (LocationOfActivity ?X1 ?X4)))")


;;; 6.3.11 InstanceOfIndirectProperty
(def-template |InstanceOfIndirectProperty|
    :desc "This template is for expressing the classified possession by an individual of an indirect property.
           InstanceOfIndirectProperty(a, b, c) means that a is a ClassOfIndirectProperty, b 
           a (temporal part of) PossibleIndividual to which the relation applies and c is the 
           instance of Property. b has a a type of ClassOfIndirectProperty, which has c instance of Property."
    :sig
    '((1 "Property type" |ClassOfIndirectProperty|)
      (2 "Property possessor" |PossibleIndividual|)
      (3 "Property" |Property|))
    :formal 
    "(<=>
     (InstanceOfIndirectProperty ?X1 ?X2 ?X3) 
     (and
      (ClassOfIndirectProperty ?X1)
      (PossibleIndividual ?X2) 
      (Property ?X3) 
      (exists (?U) (and (ClassificationOfRelationship ?U ?X1) 
		        (IndirectPropertyTriple ?U ?X2 ?X3)))))")

;;; 6.3.12 RealMagnitudeOfProperty
(def-template |RealMagnitudeOfProperty|
    :desc "This template provides a version of MagnitudeOfProperty for which the magnitude is given by 
           a datatyped representation rather than a number object.
           RealMagnitudeOfProperty(a, b, c) means that a is is an instance of Property, 
           b is a floating point number with the property value and d the Scale as unit of measurement."
    :sig
    '((1 "Property" |Property|)
      (2 "Property value" |ExpressReal|)
      (3 "Property scale" |Scale|))
    :formal 
    "(<=>
     (RealMagnitudeOfProperty ?X1 ?X2 ?X3) 
     (and
      (Property ?X1) 
      (ExpressReal ?X2)
      (Scale ?X3) 
      (exists (?U) (and
		    (MagnitudeOfProperty ?X1 ?U ?X3)
 		    (IdentificationByNumber ?X2 ?U)))))")


;;; 6.3.13 IndirectPropertyScaleReal
(def-template |IndirectPropertyScaleReal|
    :desc "This template is for assigning a typed indirect property to an individual, 
           with magnitude given as a real number and a scale.
           IndirectPropertyScaleReal(a, b, c, d) means that a is a ClassOfIndirectProperty, 
           b a (temporal part of) PossibleIndividual to which the relation applies, 
           c is a floating point number with the property value and d the Scale as unit of measurement. 
           b has a a type of ClassOfIndirectProperty, which has c value and d unit of measurement."
    :sig
    '((1 "Property type" |ClassOfIdirectProperty|)
      (2 "Property possessor" |PossibleIndividual|)
      (3 "Property value" |ExpressReal|)
      (4 "Property scale" |Scale|))
    :formal 
    "(<=>
     (IndirectPropertyScaleReal ?X1 ?X2 ?X3 ?X4)
     (and (ClassOfIndirectProperty ?X1) 
	  (PossibleIndividual ?X2) 
	  (ExpressReal ?X3) 
	  (Scale ?X4) 
	  (exists (?U) (and (InstanceOfIndirectProperty ?X1 ?X2 ?U) 
			    (RealMagnitudeOfProperty ?U ?X3 ?X4)))))")


;;; 6.3.14 StatusApproval
(def-template |StatusApproval|
    :desc "This template is for stating that an approver assigns a status to a relationship.
           StatusApproval(a, b, c) means that a is an relationship and b is a class of approval 
           by status and c is a approver and that c assigns a with status b."
    :sig
    '((1 "Relationship" |Relationship|)
      (2 "Status" |ClassOfApprovalByStatus|)
      (3 "Approver" |PossibleIndividual|))
    :formal 
    "(<=>
     (StatusApproval ?X1 ?X2 ?X3) 
     (and (Relationship ?X1) 
	  (ClassOfApprovalByStatus ?X2) 
	  (PossibleIndividual ?X3) 
	  (exists (?U) (and (ApprovalTriple ?U ?X1 ?X3) 
			    (ClassificationTemplate ?U ?X2)))))")

;;; 6.3.15 ClassifiedInvolvement
(def-template |ClassifiedInvolvement|
    :desc "This template is for stating that a thing is involved in an activity, 
           where the kind of involvement is classified.
           NOTE 1 This template is also suitable for weak kinds of involvement, \"by reference\".
           ClassifiedInvolvement(a, b, c) means that a is an thing and b is an activity and c is 
           a type of involvement. a is involved in activity b and c is the type of involvement."
    :sig
    '((1 "Involved" |Thing|)
      (2 "Involver activity" |Activity|)
      (3 "Involvement type" |ClassOfInvolvementByReference|))
    :formal 
    "(<=>
     (ClassifiedInvolvement ?X1 ?X2 ?X3)
     (and (Thing ?X1) 
	  (Activity ?X2) 
	  (ClassOfInvolvementByReference ?X3)
	  (exists (?U) (and (InvolvementByReferenceTriple ?U ?X1 ?X2) 
			    (ClassificationTemplate ?U ?X3)))))")

;;; 6.3.16 InvolvementStatus
(def-template |InvolvementStatus|
    :desc "This template is for stating that a thing is involved in an activity, that the involvement 
           is classified to be of a certain kind, and that the involvement is approved by an approver 
           to have a certain status.
           <p/>
           InvolvementStatus(a, b, c, d, e) means that a is an thing and b is an activity and c is a 
           type of involvement, d is an approval status and e is the approver. a is involved in activity b 
           and c is the type of involvement, the activity is approved, 
           d is type of status of the approval and e is the approver."
    :sig
    '((1 "Involved" |Thing|)
      (2 "Involver activity" |Activity|)
      (3 "Involvement type" |ClassOfInvolvementByReference|)
      (4 "Status" |ClassOfApprovalByStatus|)
      (5 "Approver" |PossibleIndividual|))
    :formal 
    "(<=>
     (InvolvementStatus ?X1 ?X2 ?X3 ?X4 ?X5)
     (and (Thing ?X1) 
	  (Activity ?X2) 
	  (ClassOfInvolvementByReference ?X3)
	  (ClassOfApprovalByStatus ?X4) 
	  (PossibleIndividual ?X5) 
	  (exists (?U) (and (InvolvementByReferenceTriple ?U ?X1 ?X2)
			    (ClassificationTemplate ?U ?X3)
  			    (StatusApproval ?U ?X4 ?X5)))))")

;;; 6.3.17 InvolvementStatusBeginning
(def-template |InvolvementStatusBeginning|
    :desc "This template is for stating that starting at a certain time, a thing is involved in an activity, 
           and that the involvement is classified to be of a certain kind, and that the involvement 
           is approved by an approver to have a certain status.
           <p/>
           InvolvementStatusBeginning(a, b, c, d, e, f) means that a is an thing and b is an activity 
           and c is a type of involvement, d is an approval status and e is the approver and f is a point in time. 
           a is involved in activity b and c is the type of involvement, the activity is approved, 
           d is type of status of the approval and e is the approver, f is the start time of the activity."
    :sig
    '((1 "Involved" |Thing|)
      (2 "Involver activity" |Activity|)
      (3 "Involvement type" |ClassOfInvolvementByReference|)
      (4 "Status" |ClassOfApprovalByStatus|)
      (5 "Approver" |PossibleIndividual|)
      (6 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
     (InvolvementStatusBeginning ?X1 ?X2 ?X3 ?X4 ?X5 ?X6)
     (and (Thing ?X1) 
	  (Activity ?X2)
	  (ClassOfInvolvementByReference ?X3)
	  (ClassOfApprovalByStatus ?X4)
	  (PossibleIndividual ?X5)
	  (RepresentationOfGregorianDateAndUtcTime ?X6)
	  (exists (?U) (and (BeginningOfTemporalPart ?U ?X2 ?X6)
			    (InvolvementStatus ?X1 ?U ?X3 ?X4 ?X5)))))")

;;; 6.3.18 SuccessionOfInvolvementByReference
(def-template |SuccessionOfInvolvementByReference|
    :desc "This template is for expressing that one involvement is succeeded by another. 
           <p/>
           SuccessionOfInvolvementByReference(a, b) means that a is a involvement and b is an involvement, 
           and that a is succeeded by b.
           <p/>
           NOTE: SuccessionOfInvolvementByReference is an RDL template because the reference 
           individual InvolvementSuccession appears in its template axiom."
    :sig
    '((1 "Predecessor" |InvolvementByReference|)
      (2 "Successor" |InvolvementByReference|))
    :formal 
    "(<=>
     (SuccessionOfInvolvementByReference ?X1 ?X2)
     (and (InvolvementByReference ?X1) 
	  (InvolvementByReference ?X2) 
	  (InstanceOfRelation InvolvementSuccession ?X1 ?X2)))")

;;; 6.3.19 SuccessionOfInvolvementInActivity
(def-template |SuccessionOfInvolvementInActivity|
    :desc "This template is for expressing that in an activity, 
           one thing that's involved in the activity is succeeded by another.
           <p/>
           NOTE 1 Here the involved things are arguments to the template, 
           not the involvement relationships themselves.
           <p/>
           SuccessionOfInvolvementInActivity(a, b, c) means that a is a involvement and b is an involvement, 
           and c an activity. b succeeds a, and both are involved in activity c."
    :sig
    '((1 "Involved predecessor" |Thing|)
      (2 "Involved successor" |Thing|)
      (3 "Involver" |Activity|))
    :formal 
    "(<=>
     (SuccessionOfInvolvementInActivity ?X1 ?X2 ?X3)
     (and (Thing ?X1)
	  (Thing ?X2) 
	  (Activity ?X3) 
	  (exists (?U1 ?U2) 
		  (and 
		     (InvolvementByReferenceTriple ?U1 ?X1 ?X3)
		     (InvolvementByReferenceTriple ?U2 ?X2 ?X3)
		     (SuccessionOfInvolvementByReference ?U1 ?U2)))))")

;;;===========================================================
;;; Clause 7 -- Templates for classes
;;;===========================================================
;;; POD Need too look also at Table 2 in clause 7.2 of Part 7. It contains necessary individuals, 
;;; named EmptyClass, SetOf1Class, etc. 

;;;; 7.5.1 ClassificationOfClass
(def-template |ClassificationOfClass|
    :desc "This is a template for classifying classes. ClassificationOfClass(a,b) means that
     a is a class, that b is a class of classes, and that a is a member of b."
    :sig
    '((1 "Class" |Class|)
      (2 "Class Classifier" |ClassOfClass|))
    :formal 
    "(<=>
     (ClassificationOfClass ?X1 ?X2) 
     (and
      (Class ?X1) 
      (ClassOfClass ?X2)
      (ClassificationTemplate ?X1 ?X2)))")

;;;; 7.5.2 ClassificationOfClassOfIndividual
(def-template |ClassificationOfClassOfIndividual|
    :desc "This is a template for classifying classes that only have individuals as members.
           ClassificationOfClassOfIndividual(a, b) means that a is a first-order class, 
           that b is a second-order class, and that a is a member of b."
    :sig
    '((1 "Class" |ClassOfIndividual|)
      (2 "Class Classifier" |ClassOfClassOfIndividual|))
    :formal 
    "(<=>
     (ClassificationOfClassOfIndividual ?X1 ?X2) 
     (and
      (ClassOfIndividual ?X1)
      (ClassOfClassOfIndividual ?X2)
      (ClassificationOfClass ?X1 ?X2)))")

;;;; 7.5.3 ClassificationOfClassOfRelationship
(def-template |ClassificationOfClassOfRelationship|
    :desc "This is a template for classifying relations.
           ClassificationOfClassOfRelationship(a, b) means that a is a relation and b a class of relations, 
           and that a is a member of b."
    :sig
    '((1 "Class" |ClassOfRelationship|)
      (2 "Class Classifier" |ClassOfClassOfRelationship|))
    :formal 
    "(<=>
     (ClassificationOfClassOfRelationship ?X1 ?X2) 
     (and (ClassOfRelationship ?X1) 
	  (ClassOfClassOfRelationship ?X2)
	  (ClassificationOfClass ?X1 ?X2)))")

;;;; 7.5.4 RelationOfIndividualsToIndividuals
(def-template |RelationOfIndividualsToIndividuals|
    :desc "This is a template for expressing that a relation relates individuals only.
           RelationOfIndividualsTolndividuals(a) means that a is a relation of one of the 
           subtypes of ClassOfRela-tionship, and that its domain and range 
           (as determined by attributes according to the entity type) are both first-order classes."
    :sig
    '((1 "Relation" |ClassOfRelationship|))
    :formal 
    "(<=>
     (RelationOfIndividualsToIndividuals ?X)
     (and (ClassOfRelationship ?X) 
	  (exists (?Y1 ?Y2)
		  (and (EntityTriple ?X ?Y1 ?Y2)
		       (ClassOfIndividual ?Y1) 
		       (ClassOfIndividual ?Y2)))))")

;;;; 7.5.5 SpecializationOfIndividualRelation|
(def-template |SpecializationOfIndividualRelation|
    :desc "This is a template for expressing that one relation is a subrelation of another, 
           constrained to relations between individuals.
           SpecializationOfIndividualRelation(a, b) means that a and b are relations between individuals, 
           and that a is a subrelation of b."
    :sig
    '((1 "Subrelation" |ClassOfRelationship|)
      (2 "Superrelation" |ClassOfRelationship|))
    :formal 
    "(<=> 
     (SpecializationOfIndividualRelation ?X1 ?X2)
     (and (ClassOfRelationship ?X1) 
	  (ClassOfRelationship ?X2)
	  (RelationOfIndividualsToIndividuals ?X1) 
	  (RelationOfIndividualsToIndividuals ?X2) 
	  (SpecializationTemplate ?X1 ?X2)))")

;;;; 7.5.6 EnumeratedSetOf2Classes
(def-template |EnumeratedSetOf2Classes|
    :desc "EnumeratedSetOf2Classes is a template for collecting two classes into a third.
           EnumeratedSetOf2Classes(a, b, c) means that a, b, and c are classes, and that 
           a has precisely b and c as members."
    :sig
    '((1 "Classified 1" |Class|)
      (2 "Classified 2" |Class|)
      (3 "Enumerated Set Of Class" |EnumeratedSetOfClass|))
    :formal 
    "(<=>
     (EnumeratedSetOf2Classes ?X1 ?X2 ?X3)
     (and
      (Class ?X1)
      (Class ?X2)
      (EnumeratedSetOfClass ?X3)
      (ClassificationTemplate ?X1 ?X3)
      (ClassificationTemplate ?X2 ?X3) 
      (ClassificationTemplate ?X3  SetOf2Classes)))") ; <--- POD Use of individual

;;;; 7.5.7 EnumeratedSetOf3Classes
(def-template |EnumeratedSetOf3Classes|
    :desc "EnumeratedSetOf2Classes is a template for collecting three classes into a fourth.
           EnumeratedSetOf2Classes(a, b, c, d) means that a, b, c, and d are classes, 
           and that a has precisely b, c, and d as members."
    :sig
    '((1 "Classified 1" |Class|)
      (2 "Classified 2" |Class|)
      (3 "Classified 3" |Class|)
      (4 "Enumerated Set Of Class" |EnumeratedSetOfClass|))
    :formal 
    "(<=> 
     (EnumeratedSetOf3Classes ?X1 ?X2 ?X3 ?X4)
     (and (Class ?X1) 
	  (Class ?X2) 
	  (Class ?X3) 
	  (EnumeratedSetOfClass ?X4) 
	  (ClassificationTemplate ?X1 ?X4) 
	  (ClassificationTemplate ?X2 ?X4) 
	  (ClassificationTemplate ?X3 ?X4) 
	  (ClassificationTemplate ?X4 SetOf3Classes)))") ; <--- POD Use of individual

;;;; 7.5.8 UnionOf2Classes
(def-template |UnionOf2Classes|
    :desc "UnionOf2Classes is a template for expressing that a class is the union of two classes.
           UnionOf2Classes(a, b, c) means that a, b, and c are classes, and that c is the union of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Union" |Class|))
    :formal 
    "(<=>
     (UnionOf2Classes ?X1 ?X2 ?X3) 
     (and (Class ?X1)
	  (Class ?X2) 
	  (Class ?X3) 
	  (exists (?Y)
		  (and (EnumeratedSetOf2Classes ?X1 ?X2 ?Y) 
		       (UnionOfSetOfClassTemplate ?Y ?X3)))))")

;;;; 7.5.9 IntersectionOf2Classes
(def-template |IntersectionOf2Classes|
    :desc "IntersectionOf2Classes is a template for expressing that a class is the intersection of two classes. 
           IntersectionOf2Classes(a, b, c) means that c is the intersection of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Intersection" |Class|))
    :formal 
    "(<=>
     (IntersectionOf2Classes ?X1 ?X2 ?X3) 
     (and 
      (Class ?X1)
      (Class ?X2) 
      (Class ?X3) 
      (exists (?Y)
	      (and (EnumeratedSetOf2Classes ?X1 ?X2 ?Y) 
		   (IntersectionOfSetOfClassTemplate ?Y ?X3)))))")

;;;; 7.5.10 DifferenceOf2Classes
(def-template |DifferenceOf2Classes|
    :desc "DifferenceOf2Classes is a template for expressing that a class is the difference, 
           as given in ISO 15926-2, of two classes.
           DifferenceOf2Classes(a, b, c) means that c is the difference of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Difference" |Class|))
    :formal 
    "(<=>
     (DifferenceOf2Classes ?X1 ?X2 ?X3) 
     (and
      (Class ?X1)
      (Class ?X2)
      (Class ?X3)
      (exists (?Y)
	      (and (EnumeratedSetOf2Classes ?X1 ?X2 ?Y) 
		   (DifferenceOfSetOfClassTemplate ?Y ?X3)))))") ; POD What is this DOSOCT?

;;;; 7.5.11 RelativeComplementOf2Classes
(def-template |RelativeComplementOf2Classes|
    :desc "RelativeComplementOf2Classes is a template for expressing that a class is the relative complement 
           of two classes.
           RelativeComplementOf2Classes(a, b, c) means that c is the relative complement of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Relative Complement" |Class|))
    :formal 
    "(<=>
     (RelativeComplementOf2Classes ?X1 ?X2 ?X3) 
     (and (Class ?X1) 
	  (Class ?X2)
	  (Class ?X3) 
	  (exists (?Y) (and 
		         (DifferenceOfSetOfClassTemplate ?X1 ?X2 ?Y)  ; POD What is this DOSOCT?
		         (IntersectionOf2Classes ?X1 ?Y ?X3)))))")

;;;; 7.5.12 DisjointnessOf2Classes
(def-template |DisjointnessOf2Classes|
    :desc "This template expresses that two classes have no members in common (that the classes are disjoint). 
           DisjointnessOf2Classes(x, y) means that the intersection of x and y is empty."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|))
    :formal 
    "(<=>
     (DisjointnessOf2Classes ?X1 ?X2) 
     (and
      (Class ?X1) 
      (Class ?X2)
      (IntersectionOf2Classes ?X1 ?X2 EmptyClass)))") ; <--- POD Use of individual

;;;; 7.5.13a SpecializationAsEnd1UniversalRestriction
(def-template |SpecializationAsEnd1UniversalRestriction|
    :desc "SpecializationAsEndlUniversalRestriction and SpecializationAsEnd2UniversalRestriction 
           are templates for expressing relation specialisations with the force of universal restriction.
           These templates have the same roles, and similar definitions except for the use of 
           reference items End1UniversalRestriction, resp. End2UniversalRestriction.
           SpecializationAsEnd1UniversalRestriction means that a and b are relations, 
           that a is a subrelation of b, and that the specialization relation between a and b 
           is a member of End1UniversalRestriction."
    :sig
    '((1 "Subrelation" |ClassOfRelationship|)
      (2 "Subrelation" |ClassOfRelationship|))
    :formal 
    "(<=>
     (SpecializationAsEnd1UniversalRestriction ?X1 ?X2) 
     (and 
      (ClassOfRelationship ?X1) 
      (ClassOfRelationship ?X2)
      (exists (?Y) (and (SpecializationTriple ?Y ?X1 ?X2) 
		        (ClassificationTemplate ?Y End1UniversalRestriction)))))") ;<--- POD Use of individual

;;;; 7.5.13b SpecializationAsEnd2UniversalRestriction
(def-template |SpecializationAsEnd2UniversalRestriction|
    :desc "SpecializationAsEndlUniversalRestriction and SpecializationAsEnd2UniversalRestriction 
           are templates for expressing relation specialisations with the force of universal restriction.
           These templates have the same roles, and similar definitions except for the use of 
           reference items End1UniversalRestriction, resp. End2UniversalRestriction.
           SpecializationAsEnd1UniversalRestriction means that a and b are relations, 
           that a is a subrelation of b, and that the specialization relation between a and b 
           is a member of End1UniversalRestriction."
    :sig
    '((1 "Subrelation" |ClassOfRelationship|)
      (2 "Subrelation" |ClassOfRelationship|))
    :formal 
    "(<=>
     (SpecializationAsEnd2UniversalRestriction ?X1 ?X2) 
     (and
      (ClassOfRelationship ?X1)
      (ClassOfRelationship ?X2) 
      (exists (?Y) (and
		    (SpecializationTriple ?Y ?X1 ?X2) 
		    (ClassificationTemplate ?Y End2UniversalRestriction)))))") ;<--- POD Use of individual

;;;; 7.5.14a CardinalityMin
(def-template |CardinalityMin|
    :desc "CardinalityMin, CardinalityMax, and CardinalityMinMax are templates for expressing the 
           values of cardinalities.
           CardinalityMinMax(a, b, c) means that a is a cardinality and b and c are integers, 
           and that b is the min¬imal, c the maximal, constraint of a. 
           CardinalityMin and CardinalityMax are similar, and apply to just the minimal, resp. 
           the maximal constraint."
    :sig
    '((1 "Cardinality" |Cardinality|)
      (2 "Minimum Cardinality" INTEGER))
    :formal 
    "(<=> (CardinalityMin ?X1 ?X2) 
	 (and
	  (Cardinality ?X1) 
	  (ExpressInteger ?X2) 
	  (hasMinimumCardinality ?X1 ?X2)))")

;;;; 7.5.14b CardinalityMax
(def-template |CardinalityMin|
    :desc "CardinalityMin, CardinalityMax, and CardinalityMinMax are templates for expressing the 
           values of cardinalities.
           CardinalityMinMax(a, b, c) means that a is a cardinality and b and c are integers, 
           and that b is the min¬imal, c the maximal, constraint of a. 
           CardinalityMin and CardinalityMax are similar, and apply to just the minimal, resp. 
           the maximal constraint."
    :sig
    '((1 "Cardinality" |Cardinality|)
      (2 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=> 
     (CardinalityMax ?X1 ?X2) 
     (and
      (Cardinality ?X1)
      (ExpressInteger ?X2) 
      (hasMaximumCardinality ?X1 ?X2)))")


;;;; 7.5.14c CardinalityMinMax
(def-template |CardinalityMinMax|
    :desc "CardinalityMin, CardinalityMax, and CardinalityMinMax are templates for expressing the 
           values of cardinalities.
           CardinalityMinMax(a, b, c) means that a is a cardinality and b and c are integers, 
           and that b is the min¬imal, c the maximal, constraint of a. 
           CardinalityMin and CardinalityMax are similar, and apply to just the minimal, resp. 
           the maximal constraint."
    :sig
    '((1 "Cardinality" |Cardinality|)
      (2 "Minimum Cardinality" INTEGER)
      (3 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=> (CardinalityMinMax ?X1 ?X2 ?X3) 
	 (and 
	  (Cardinality ?X1) 
	  (ExpressInteger?X2)
	  (ExpressInteger ?X3)
	  (CardinalityMin ?X1 ?X2)
	  (CardinalityMax ?X1 ?X3)))")

;;;; 7.5.15a Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd1Min|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Minimum Cardinality" INTEGER))
    :formal 
    "(<=>
     (CardinalityEnd1Min ?X1 ?X2)
     (and
      (ClassOfRelationship ?X1)
      (ExpressInteger ?X2)
      (exists (?U) (and
		     (CardinalityMin ?U ?X2)
		     (hasEnd1Cardinality ?X1 ?U)))))")

;;;; 7.5.15b Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd1Max|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=> 
     (CardinalityEnd1Max ?X1 ?X2)
     (and
      (ClassOfRelationship ?X1)
      (ExpressInteger ?X2)
      (exists (?U) (and
		     (CardinalityMax ?U ?X2)
		     (hasEnd1Cardinality ?X1 ?U)))))")

;;;; 7.5.15c Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd1MinMax|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Minimum Cardinality" INTEGER)
      (3 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=> (CardinalityEnd1MinMax ?X1 ?X2) 
	 (and 
	  (ClassOfRelationship ?X1)
	  (ExpressInteger ?X2)
	  (ExpressInteger ?X3) 
	  (exists (?U) (and
		         (CardinalityMinMax ?U ?X2 ?X3) 
		         (hasEnd1Cardinality ?X1 ?U)))))")

;;;; 7.5.15d Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd2Min|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Minimum Cardinality" INTEGER))
    :formal 
    "(<=>
     (CardinalityEnd2Min ?X1 ?X2) 
     (and
      (ClassOfRelationship ?X1) 
      (ExpressInteger ?X2) 
      (exists (?U) (and
		     (CardinalityMin ?U ?X2) 
		     (hasEnd2Cardinality ?X1 ?U)))))")

;;;; 7.5.15b Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd2Max|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=>
      (CardinalityEnd2Max ?X1 ?X2) 
      (and (ClassOfRelationship ?X1) 
	  (ExpressInteger ?X2)
	  (exists (?U) (and
		         (CardinalityMax ?U ?X2)
		         (hasEnd2Cardinality ?X1 ?U)))))")

;;;; 7.5.15c Assignment ("Cardinality Assignment Templates")
(def-template |CardinalityEnd2MinMax|
    :desc "CardinalityEnd1Min, CardinalityEnd1Max, CardinalityEnd1MinMax, CardinalityEnd2Min, CardinalityEnd2Max, 
           and CardinalityEnd2MinMax are templates for expressing cardinality constraints on rela¬tions.
           CardinalityEnd1MinMax(a, b) means that a is a relation and b and c are integers, and that 
           the first role of a has b as minimum, c as maximum cardinality. 
           The other templates in this group follow the same pattern."
    :sig
    '((1 "Relationship" |ClassOfRelationship|)
      (2 "Minimum Cardinality" INTEGER)
      (3 "Maximum Cardinality" INTEGER))
    :formal 
    "(<=>
     (CardinalityEnd2MinMax ?X1 ?X2) 
     (and (ClassOfRelationship ?X1) 
	  (ExpressInteger ?X2)
	  (ExpressInteger ?X3)
	  (exists (?U) (and
		         (CardinalityMinMax ?U ?X2 ?X3)
		         (hasEnd2Cardinality ?X1 ?U)))))")

;;;; 7.5.16 TimeRepresentation
(def-template |TimeRepresentation|
    :desc ""
    :sig
    '((1 "Time" |RepresentationOfGregorianDateAndUtcTime|)
      (2 "Year"   INTEGER)
      (3 "Month"  INTEGER)
      (4 "Day"    INTEGER)
      (5 "Hour"   INTEGER)
      (6 "Minute" INTEGER)
      (7 "Second" REAL))
    :formal 
    "(<=>
     (TimeRepresentation ?X1 ?X2 ?X3 ?X4 ?X5 ?X6 ?X7)
     (and
      (RepresentationOfGregorianDateAndUtcTime ?X1) 
      (ExpressInteger ?X2) 
      (ExpressInteger ?X3)
      (ExpressInteger ?X4)
      (ExpressInteger ?X5) 
      (ExpressInteger ?X6) 
      (ExpressReal ?X7) 
      (hasYear ?X1 ?X2)
      (hasMonth ?X1 ?X3)
      (hasDay ?X1 ?X4)
      (hasHour ?X1 ?X4)
      (hasMinute ?X1 ?X6)
      (hasSecond ?X1 ?X7)))")

;;;; 7.5.17 MagnitudeOfProperty
(def-template |MagnitudeOfProperty|
    :desc "MagnitudeOfProperty is a template for stating magnitude of properties.
           MagnitudeOfProperty(a, b, c) means that a is a property, b is a number, 
           and c is a scale, and that b is the value of a as measured on the scale c."
    :sig
    '((1 "Property" |Property|)
      (2 "Property value" |ArithmeticNumber|)
      (3 "Property scale" |Scale|))
    :formal 
    "(<=>
     (MagnitudeOfProperty ?X1 ?X2 ?X3) 
     (and
      (Property ?X1) 
      (ArithmeticNumber ?X2)
      (Scale ?X3) 
      (exists (?U) (and
		     (PropertyQuantificationTriple ?U ?X1 ?X2)
		     (ClassificationTemplate ?U ?X3)))))")

;;;; 7.5.18 LowerUpperOfNumberRange
(def-template |LowerUpperOfNumberRange|
    :desc "LowerUpperOfNumberRange is a template for stating what the upper and lower bounds 
           of a number range are.
           LowerUpperOfNumberRange(a, b, c) means that a is a number range and b and c are numbers, 
           and that b is the lower, c the upper bound of a."
    :sig
    '((1 "Range" |NumberRange|)
      (2 "Lower bound" |ArithmeticNumber|)
      (3 "Upper bound" |ArithmeticNumber|))
    :formal 
    "(<=>
     (LowerUpperOfNumberRange ?X1 ?X2 ?X3) 
     (and
      (NumberRange ?X1) 
      (ArithmeticNumber ?X2)
      (ArithmeticNumber ?X3) 
      (LowerBoundOfNumberRangeTemplate ?X2 ?X1)
      (UpperBoundOfNumberRangeTemplate ?X3 ?X1)))")

;;;; 7.5.19 LowerUpperOfPropertyRange
(def-template |LowerUpperOfPropertyRange|
    :desc ""
    :sig
    '((1 "Range" |NumberRange|)
      (2 "Lower bound" |ArithmeticNumber|)
      (3 "Upper bound" |ArithmeticNumber|))
    :formal 
    "(<=>
     (LowerUpperOfNumberRange ?X1 ?X2 ?X3)
     (and
      (NumberRange ?X1) 
      (ArithmeticNumber ?X2) 
      (ArithmeticNumber ?X3) 
      (LowerBoundOfNumberRangeTemplate ?X2 ?X1)
      (UpperBoundOfNumberRangeTemplate ?X3 ?X1)))")

;;;; 7.5.20 LowerUpperMagnitudeOfPropertyRange
(def-template |LowerUpperMagnitudeOfPropertyRange|
    :desc "LowerUpperOfPropertyRange is a template for stating what the upper and lower bounds 
           of a property range are.
           LowerUpperOfPropertyRange(a, b, c) means that a is a property range and b and c are properties, 
           and that b is the lower, c the upper bound of a."
    :sig
    '((1 "Property Range" |PropertyRange|)
      (2 "Lower bound" |Property|)
      (3 "Upper bound" |Property|))
    :formal 
    "(<=>
     (LowerUpperOfPropertyRange ?X1 ?X2 ?X3) 
     (and
      (PropertyRange ?X1) 
      (Property ?X2) 
      (Property ?X3) 
      (LowerBoundOfNumberPropertyRangeTemplate ?X2 ?X1) 
      (UpperBoundOfNumberPropertyRangeTemplate ?X3 ?X1)))")

;;;; 7.5.21 PropertyRangeRestrictionOfClass
(def-template |PropertyRangeRestrictionOfClass|
    :desc "PropertyRangeRestrictionOfClassis a template for stating about a class of individuals that the
           magnitude of a property is restricted to a range of values.
           PropertyRangeRestrictionOfClass(a, b, c) means that a is a class, b is a property relation, 
           and c is a range of properties, and that every b property assignment to an a belongs to 
           a subrelation of b for which the range is restricted to c."
    :sig
    '((1 "Class" |ClassOfIndividual|)
      (2 "Property" |ClassOfIndirectProperty|)
      (3 "Range" |PropertyRange|))
    :formal 
    "(<=>
     (PropertyRangeRestrictionOfClass ?X1 ?X2 ?X3)
     (and
      (ClassOfIndividual ?X1)
      (ClassOfIndirectProperty ?X2)
      (PropertyRange ?X3) 
      (exists (?U) (and
		     (ClassOfIndirectPropertyTriple ?U ?X1 ?X3)      ; This one is a pseudo-template
		     (SpecializationAsEnd2UniversalRestriction ?U ?X2)))))")

;;;; 7.5.22 PropertyRangeMagnitudeRestrictionOfClass
(def-template |PropertyRangeMagnitudeRestrictionOfClass|
    :desc "PropertyRangeMagnitudeRestrictionOfClass is a template for stating which range of values 
           of a property can apply to a class of individuals.
           PropertyRangeMagnitudeRestrictionOfClass(a, b, c, d, e) means that a is a class of individuals, 
           b is a property relation, c is a scale, and d and e are real numbers, and that every b property 
           of an a has a value in the d to e range, measured on the c scale."
    :sig
    '((1 "Class" |ClassOfIndividual|)
      (2 "Restricted Property" |ClassOfIndirectProperty|)
      (3 "Scale" |Scale|)
      (4 "Upper Bound" |ExpressReal|)
      (5 "Lower Bound" |ExpressReal|))
    :formal 
    "(<=>
     (PropertyRangeMagnitudeRestrictionOfClass ?X1 ?X2 ?X3 ?X4 ?X5) 
     (and
      (ClassOfIndividual ?X1)
      (ClassOfIndirectProperty ?X2) 
      (Scale ?X3) 
      (ExpressReal ?X4) 
      (ExpressReal ?X5) 
      (exists (?U) (and
		     (PropertyRangeRestrictionOfClass ?X1 ?X2 ?U) 
		     (exists (?Y1 ?Y2)
			  (and
			     (IdentificationByNumber ?X4 ?Y1) 
			     (IdentificationByNumber ?X5 ?Y2) 
			     (LowerUpperMagnitudeOfPropertyRange ?U ?X3 ?Y1 ?Y2)))))))")

;;;; 7.5.23 SymbolOfScale
(def-template |SymbolOfScale|
    :desc "SymbolOfScale is a template for expressing that a symbol represents a scale.
           SymbolOfScale(a, b, c) means that a is a scale, b is a string and that b is an identifier 
           for a designated as a unit of measure symbol."
    :sig
    '((1 "Scale" |Scale|)
      (2 "Symbol" |ExpressString|))
    :formal 
    "(<=>
     (SymbolOfScale ?X1 ?X2) 
     (and
      (Scale ?X1)
      (ExpressString ?X2) 
      (ClassifiedIdentification ?X1 ?X2 UomSymbolAssignment)))") ;<--- POD Use of individual

;;;; 7.5.24 DimensionUnitNumberRangeOfScale
(def-template |DimensionUnitNumberRangeOfScale|
    :desc "DimensionUnitNumberRangeOfScale is a template for stating which dimension, 
           number range and sym¬bol applies to a scale.
           DimensionUnitNumberRangeOfScale(a, b, c, d) means that a is a scale, b is a string, 
           c is a property dimension, and d is a number range, that b is a unit of measure symbol 
           for the scale and that c is the dimension and d the number range of the scale."
    :sig
    '((1 "Scale" |Scale|)
      (2 "Symbol" |ClassOfldentification|)
      (3 "Dimension" |SinglePropertyDimension|)
      (4 "Number Range" |NumberRange|))
    :formal 
    "(<=>
     (DimensionUnitNumberRangeOfScale ?X1 ?X2 ?X3 ?X4) 
     (and
      (Scale ?X1) 
      (ExpressString ?X2) 
      (SinglePropertyDimension ?X3)
      (NumberRange ?X4) 
      (SymbolOfScale ?X1 ?X2)
      (ScaleTriple ?X1 ?X4 ?X3)))")

;;; What nonsense!
;;;; 7.5.25 ClassInvolvementStatusBeginning
(def-template |ClassInvolvementStatusBeginning|
    :desc "This template specializes template InvolvementStatusBeginning by restricting the thing 
           involved in an activity to be a class.
           ClassInvolvementStatusBeginning(a, b, c, d, e, f) means that a is a class and b is an activity 
           and c is a type of involvement, d is an approval status and e is the approver 
           and f is a point in time. a is involved in activity b and c is the type of involvement, 
           the activity is approved, d is type of status of the approval and e is the approver, 
           f is the start time of the activity."
    :sig
    '((1 "Involved class" |Class|)
      (2 "Involver activity" |Activity|)
      (3 "Involvement type" |ClassOfInvolvementByReference|)
      (4 "Status"  |ClassOfApprovalByStatus|)
      (5 "Approver" |PossibleIndividual|)
      (6 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
     (ClassInvolvementStatusBeginning ?X1 ?X2 ?X3 ?X4 ?X5)
     (and
      (Class ?X1) 
      (Activity ?X2)
      (ClassOfInvolvementByReference ?X3) 
      (ClassOfApprovalByStatus ?X4) 
      (PossibleIndividual ?X5)
      (RepresentationOfGregorianDateAndUtcTime ?X6)
      (InvolvementStatusBeginning ?X1 ?X2 ?X3 ?X4 ?X5 ?X6)))") ; POD May be a problem here. ?X2 was U. 

;;;; 7.5.26 ClassInvolvementSuccesion
(def-template |ClassInvolvementSuccesion|
    :desc "ClassInvolvementSuccession(a, b, c, d, e, f, g, h) means two classes a, b are involved 
           in the same capacity in activity c. From time h, the involvement of a is succeeded by 
           involvement of b; and approver g assigns status e to a's involvement, status f to b's involvement."
    :sig
    '((1 "Predecessor class" |Class|)
      (2 "Successor class" |Class|)
      (3 "Involver activity" |Activity|)
      (4 "Involvement type" |ClassOfInvolvementByReference|)
      (5 "Status of predecessor" |ClassOfApprovalByStatus|)
      (6 "Status of successor" |ClassOfApprovalByStatus|)
      (7 "Status approver" |PossibleIndividual|)
      (8 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    "(<=>
     (ClassInvolvementSuccession ?X1 ?X2 ?X3 ?X4 ?X5 ?X6 ?X7 ?X8) 
     (and
      (Class ?X1) 
      (Class ?X2) 
      (Activity ?X3) 
      (ClassOfInvolvementByReference ?X4)
      (ClassOfApprovalByStatus x5) 
      (ClassOfApprovalByStatus ?X6) 
      (PossibleIndividual ?X7) 
      (RepresentationOfGregorianDateAndUtcTime ?X8) 
      (exists (?U1)
	      (exists (?U2 ?U3)
		      (and
			 (BeginningOfTemporalPart ?U1 ?X3 ?X8) 
			 (InvolvementByReferenceTriple ?U2 ?X1 ?U1)
			 (InvolvementByReferenceTriple ?U3 ?X2 ?U1)
			 (ClassificationTemplate ?U2 ?X4)
			 (ClassificationTemplate ?U3 ?X4)
			 (StatusApproval ?U2 ?X5 ?X7)
			 (StatusApproval ?U3 ?X6 ?X7)
			 (SuccessionOfInvolvementByReference ?U2 ?U3))))))")


;;; POD 2012-08-09 I'm confused by the following (that I wrote earlier). There is, of course, 
;;  a proto-template for Classification. The second role would be a Class, not Thing. 
;;; The proto-template would not make this constraint. 
;;; This one isn't quite defined, but necessary, I think!
(def-template |ClassificationTemplate*| ; 2012-08-09 I added the * to the name.
    :desc "Clause: 6.3.2 (about ClassificationOfRelationship). 'It is a classification template, 
           restricted to classifying pairs of things a members of relations.'
           The formula in :forma; is from Annex H, Example2. Note: Use of 'classification' and 
           'specialization' : Section 4.4: 'With the frequently used relation types Classification (membership)
           and Specialization (subclassing),..."
    :sig
    '((1 "First Role" |Thing|)     ; guessing 2012-08-08 Should one of these be Class?
      (2 "Second Role" |Thing|))  ; guessing
    :formal 
    "(forall (?X)
       (forall (?Y)
          (=> (ClassificationTemplate ?X ?Y) (not (ClassificationTemplate ?Y ?X)))))")







