
;; Purpose: Define objects for the "initial set" of templates described in 15926-7 Clause 6.3

(defpackage :iso15926-7
  (:use :cl :pod :tr :closer-mop)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod))

(in-package :iso15926-7)


(defclass template ()
  ;; camelCase text identifier
  ((name :initarg :name :initform nil :reader name)
   ;; text description
   (desc :initarg :desc :initform nil :reader desc)
   ;; roles and types of each object
   (sig  :initarg :sig :initform nil :reader sig)
   ;; A list of sentences, typically just a biconditional
   (formal :initarg :formal :initform nil :reader formal)))

(defmethod print-object ((obj template) stream)
  (format stream "{Template ~A}" (name obj)))
  

(defparameter *initial-set* nil "List of 190 initial templates for individuals and 26 initial templates
 for classes.")

(defmacro def-template (name &key desc sig formal)
  (with-gensyms (old)
    `(progn 
       (when-bind (,old (find ',name *initial-set* :key #'name))
	 (setf *initial-set* (remove ,old *initial-set*)))
       (push (make-instance 'template :name ',name :desc ,desc :sig ,sig :formal ,formal)
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
    '(((|ClassificationOfIndividual| X1 Y1) :<->
       (|PossibleIndividual| X1) :and 
       (|ClassOfIndividual| X2) :and
       (|ClassificationTemplate| X1 X2))))

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
    '(((|ClassificationOfRelationship| X1 Y1) :<->
       (|Relationship| X1) :and 
       (|ClassOfRelationship| X2) :and
       (|ClassificationTemplate| X1 X2))))


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
    '(((|InstanceOfRelation| X1 X2 X3) :<->
       (|ClassOfRelationshipWithSignature| X1)
       (|Thing| X2) :and 
       (|Thing| X3) :and
       (:exists U (|OtherRelationshipTriple| U X2 X3) :and
	(|ClassificationOfRelationship| U X1)))))

;;; 6.3.4
(def-template |IdentificationByNumber|
    :desc "IdenfificafionByNumber(a, b) means that a is a real number, and a refers to b."
    :sig
    '((1 "Identifier" |ExpressReal|)
      (2 "Identified" |Thing|))
    :formal 
    '(((|InstanceOfRelation| X1 X2 X3) :<->
       (|ClassOfRelationshipWithSignature| X1)
       (|Thing| X2) :and 
       (|Thing| X3) :and
       (:exists U (|OtherRelationshipTriple| U X2 X3) :and
	(|ClassificationOfRelationship| U X1)))))

;;; 6.3.5
;;; EXAMPLE The statement ClassifiedIdentification(Alfred, PN4723, Employee No. ACME Co.) 
;;; (e.g., an assignment of em¬ployee number) expands as follows...
(def-template |ClassifiedIdentification|
    :desc "This is a template for typed naming of things.
           ClassifiedIdenfification(a, b, c) means that b is a string and c a type of name assignment, 
           and that b is a c-type name for a."
    :sig
    '((1 "Object" |Thing|)
      (2 "Identifier" |ExpressString|)
      (3 "Context" |ClassOfClassOfIdentification|))
    :formal 
    '(((|ClassifiedIdentification| X1 X2 X3) :<->
       (|Thing| X1) :and
       (|ExpressString| X2) :and
       (|ClassOfClassIdentification| X3) :and
       (:exists U (|ClassOfIdentificationTriple| U X2 X1) :and
	(|ClassificationTemplate| U X3)))))

;;; 6.3.6 LocationOfActivity
(def-template |LocationOfActivity|
    :desc "This is a template for stating where activities take place.
           LocationOfActivity(a, b) means that a is an activity, b is a location, and that a takes place at b."
    :sig
    '((1 "Activity" |Activity|)
      (2 "Location" |SpatialLocation|))
    :formal 
    '(((|LocationOfActivity| X1 X2) :<->
       (|Activity| X1)  :and
       (|SpatialLocation| X2) :and
       (|InstanceOfRelation(ActivityLocation| X1 X2))))

;;; 6.3.7 BeginningOfIndividual
(def-template |BeginningOfIndividual|
    :desc "This is a template for stating start time of existence.
           BeginningOflndividual(a, b) means that a is an individual and b is a point in time, 
           and that a begins to exist at b."
    :sig
    '((1 "Individual" |PossibleIndividual|)
      (2 "Start time" |RepresentationOfGregorianDateAndUtcTime|))
    :formal 
    '(((|BeginningOfIndividual| X1 X2) :<->
       (|PossibleIndividual| X1)  :and
       (|RepresentationOfGregorianDateAndUtcTime| X2) :and
       (:exists U (|PointInTime| U) :and
	(|BeginningTemplate| U X1) :and
	(|ClassOfRepresentationOfThingTemplate| X2 U)))))

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
    '(((|BeginningEndOfIndividual| X1 X2 X3) :<->
       (|PossibleIndividual| X1)  :and
       (|RepresentationOfGregorianDateAndUtcTime| X2) :and
       (|RepresentationOfGregorianDateAndUtcTime| X3) :and
       (:exists U (|PointInTime| U) :and
	(|BeginningTemplate| U X2) :and
	(|ClassOfRepresentationOfThingTemplate| X2 u)) :and
       (:exists U (|PointInTime| U) :and
	(|EndTemplate| U X3) :and
	(|ClassOfRepresentationOfThingTemplate| X3 U)))))

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
    '(((|BeginningOfTemporalPart| X1 X2 X3) :<->
       (|PossibleIndividual| X1)  :and
       (|PossibleIndividual| X2)  :and
       (|RepresentationOfGregorianDateAndUtcTime| X3) :and
       (|TemporalWholePartTemplate| X2 X2)
       (|BeginningOfIndividual| X1 X3))))

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
    '(((|BeginningEndLocationOfActivity| X1 X2 X3 X4) :<->
       (|Activity| X1) :and
       (|RepresentationOfGregorianDateAndUtcTime| X2) :and
       (|RepresentationOfGregorianDateAndUtcTime| X3) :and
       (|SpatialLocation| X4) :and
       (|BeginningEndOfIndividual| X1 X2 X3) :and
       (|LocationOfActivity| X1 X4))))


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
    '(((|InstanceOfIndirectProperty| X1 X2 X3) :<->
       (|ClassOfIndirectProperty| X1) :and
       (|PossibleIndividual| X2) :and
       (|Property| X3) :and
       (:exists U (|ClassificationOfRelationship| U X1) :and 
	(|IndirectPropertyTriple| U X2 X3)))))

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
    '(((|RealMagnitudeOfProperty| X1 X2 X3) :<->
       (|Property| X1) :and
       (|ExpressReal| X2) :and
       (|Scale| X3) :and
       (:exists U (|MagnitudeOfProperty| X1 U X3) :and 
	(|IdentificationByNumber| X2 U)))))


;;; 6.3.13 IndirectPropertyScaleReal
(def-template |IndirectPropertyScaleReal|
    :desc "This template is for assigning a typed indirect property to an individual, 
           with magnitude given as a real number and a scale.
           IndirectPropertyScaleReal(a, b, c, d) means that a is is a ClassOfIndirectProperty, 
           b a (temporal part of) PossibleIndividual to which the relation applies, 
           c is a floating point number with the property value and d the Scale as unit of measurement. 
           b has a a type of ClassOfIndirectProperty, which has c value and d unit of measurement."
    :sig
    '((1 "Property type" |ClassOfIdirectProperty|)
      (2 "Property possessor" |PossibleIndividual|)
      (3 "Property value" |ExpressReal|)
      (4 "Property scale" |Scale|))
    :formal 
    '(((|IndirectPropertyScaleReal| X1 X2 X3 X4) :<->
       (|ClassOfIndirectProperty| X1) :and
       (|PossibleIndividual| X2) :and
       (|ExpressReal| X3) :and
       (|Scale| X4) :and
       (:exists U (|InstanceOfIndirectProperty| X1 X2 U) :and 
	(|RealMagnitudeOfProperty| U X3 X4)))))


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
    '(((|StatusApproval| X1 X2 X3) :<->
       (|Relationship| X1) :and
       (|ClassOfApprovalByStatus| X2) :and
       (|PossibleIndividual| X3) :and
       (:exists U (|ApprovalTriple| U X1 X3) :and 
	(|ClassificationTemplate| U X2)))))

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
    '(((|ClassifiedInvolvement| X1 X2 X3) :<->
       (|Thing| X1) :and
       (|Activity| X2) :and
       (|ClassOfInvolvementByReference| X3) :and
       (:exists U (|InvolvementByReferenceTriple| U X1 X2) :and 
	(|ClassificationTemplate| U X3)))))

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
    '(((|InvolvementStatus| X1 X2 X3 X4 X5) :<->
       (|Thing| X1) :and
       (|Activity| X2) :and
       (|ClassOfInvolvementByReference| X3) :and
       (|ClassOfApprovalByStatus| X4) :and
       (|PossibleIndividual| X5) :and
       (:exists U (|InvolvementByReferenceTriple| U X1 X2) :and 
	(|ClassificationTemplate| U X3) :and
	(|StatusApproval| U X4 X5)))))

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
    '(((|InvolvementStatusBeginning| X1 X2 X3 X4 X5 X6) :<->
       (|Thing| X1) :and
       (|Activity| X2) :and
       (|ClassOfInvolvementByReference| X3) :and
       (|ClassOfApprovalByStatus| X4) :and
       (|PossibleIndividual| X5) :and
       (|RepresentationOfGregorianDateAndUtcTime| X6) :and
       (:exists U (|BeginningOfTemporalPart| U X2 X6) :and 
	(|InvolvementStatus| X1 U X3 X4 X5)))))

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
    '(((|SuccessionOfInvolvementByReference| X1 X2) :<->
       (|InvolvementByReference| X1) :and
       (|InvolvementByReference| X2) :and
       (|InstanceOfRelation| |InvolvementSuccession| X1 X2))))

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
    '(((|SuccessionOfInvolvementInActivity| X1 X2 X3) :<->
       (|Thing| X1) :and
       (|Thing| X2) :and
       (|Activity| X3) :and
       (:exists u1 
	(:exists u2
		 (|InvolvementByReferenceTriple| u1 X1 X3) :and
		 (|InvolvementByReferenceTriple| u2 X2 X3) :and
		 (|SuccessionOfInvolvementByReference| u1 u2))))))

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
    '(((|ClassificationOfClass| X1 X2) :<-> 
       (|Class| X1) :and 
       (|ClassOfClass| X2) :and
       (|ClassificationTemplate| X1 X2)))))

;;;; 7.5.2 ClassificationOfClassOfIndividual
(def-template |ClassificationOfClassOfIndividual|
    :desc "This is a template for classifying classes that only have individuals as members.
           ClassificationOfClassOfIndividual(a, b) means that a is a first-order class, 
           that b is a second-order class, and that a is a member of b."
    :sig
    '((1 "Class" |ClassOfIndividual|)
      (2 "Class Classifier" |ClassOfClassOfIndividual|))
    :formal 
    '(((|ClassificationOfClassOfIndividual| X1 X2) :<-> 
       (|ClassOfIndividual| X1) :and
       (|ClassOfClassOfIndividual| X2) :and
       (|ClassificationOfClass| X1 X2))))

;;;; 7.5.3 ClassificationOfClassOfRelationship
(def-template |ClassificationOfClassOfRelationship|
    :desc "This is a template for classifying relations.
           ClassificationOfClassOfRelationship(a, b) means that a is a relation and b a class of relations, 
           and that a is a member of b."
    :sig
    '((1 "Class" |ClassOfRelationship|)
      (2 "Class Classifier" |ClassOfClassOfRelationship|))
    :formal 
    '(((|ClassificationOfClassOfRelationship| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and 
       (|ClassOfClassOfRelationship| X2) :and
       (|ClassificationOfClass| X1 X2))))

;;;; 7.5.4 RelationOfIndividualsToIndividuals
(def-template |RelationOfIndividualsToIndividuals|
    :desc "This is a template for expressing that a relation relates individuals only.
           RelationOfIndividualsTolndividuals(a) means that a is a relation of one of the 
           subtypes of ClassOfRela-tionship, and that its domain and range 
           (as determined by attributes according to the entity type) are both first-order classes."
    :sig
    '((1 "Relation" |ClassOfRelationship|))
    :formal 
    '(((|RelationOfIndividualsToIndividuals| X) :<-> 
       (|ClassOfRelationship| X) :and 
       (:exists Y1
	(:exists Y2
		 (|EntityTriple| X Y1 Y2) :and
		 (|ClassOfIndividual| Y1) :and
		 (|ClassOfIndividual| Y2))))))

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
    '(((|SpecializationOfIndividualRelation| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (|ClassOfRelationship| X2) :and
       (|RelationOfIndividualsToIndividuals| X1) :and 
       (|RelationOfIndividualsToIndividuals| X2) :and
       (|SpecializationTemplate| X1 X2))))

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
    '(|((EnumeratedSetOf2Classes| X1 X2 X3) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|EnumeratedSetOfClass| X3) :and
       (|ClassificationTemplate| X1 X3) :and
       (|ClassificationTemplate| X2 X3) :and
       (|ClassificationTemplate| X3  |SetOf2Classes|)))) ; <--- POD Use of individual

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
    '(((|EnumeratedSetOf3Classes| X1 X2 X3 X4) :<->
       (|Class| X1) :and
       (|Class| X2) :and
       (|Class| X3) :and
       (|EnumeratedSetOfClass| X4) :and
       (|ClassificationTemplate| X1 X4) :and 
       (|ClassificationTemplate| X2 X4) :and
       (|ClassificationTemplate| X3 X4) :and
       (|ClassificationTemplate| X4 SetOf3Classes)))) ; <--- POD Use of individual

;;;; 7.5.8 UnionOf2Classes
(def-template |UnionOf2Classes|
    :desc "UnionOf2Classes is a template for expressing that a class is the union of two classes.
           UnionOf2Classes(a, b, c) means that a, b, and c are classes, and that c is the union of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Union" |Class|))
    :formal 
    '(((|UnionOf2Classes| X1 X2 X3) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and 
       (|Class| X3) :and
       (:exists Y
	(|EnumeratedSetOf2Classes| X1 X2 Y) :and
	(|UnionOfSetOfClassTemplate| Y X3)))))

;;;; 7.5.9 IntersectionOf2Classes
(def-template |IntersectionOf2Classes|
    :desc "IntersectionOf2Classes is a template for expressing that a class is the intersection of two classes. 
           IntersectionOf2Classes(a, b, c) means that c is the intersection of a and b."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|)
      (3 "Class Intersection" |Class|))
    :formal 
    '(((|IntersectionOf2Classes| X1 X2 X3) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|Class| X3) :and
       (:exists y
	(|EnumeratedSetOf2Classes| X1 X2 Y) :and
	(|IntersectionOfSetOfClassTemplate| Y X3)))))

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
    '((|(DifferenceOf2Classes| X1 X2 X3) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|Class| X3) :and
       (:exists y
	(|EnumeratedSetOf2Classes| X1 X2 Y) :and
	(|DifferenceOfSetOfClassTemplate| Y X3)))))

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
    '(((|RelativeComplementOf2Classes| X1 X2 X3) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|Class| X3) :and
       (:exists y
	(|DifferenceOfSetOfClassTemplate| X1 X2 Y) :and
	(|IntersectionOf2Classes| X1 Y X3)))))

;;;; 7.5.12 DisjointnessOf2Classes
(def-template |DisjointnessOf2Classes|
    :desc "This template expresses that two classes have no members in common (that the classes are disjoint). 
           DisjointnessOf2Classes(x, y) means that the intersection of x and y is empty."
    :sig
    '((1 "Class 1" |Class|)
      (2 "Class 2" |Class|))
    :formal 
    '(((|DisjointnessOf2Classes| X1 X2) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|IntersectionOf2Classes| X1 X2 |EmptyClass|)))) ; <--- POD Use of individual

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
    '((|(SpecializationAsEnd1UniversalRestriction| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (|ClassOfRelationship| X2) :and
       (:exists Y
	(|SpecializationTriple| Y X1 X2) :and
	(|ClassificationTemplate| Y |End1UniversalRestriction|))))) ;<--- POD Use of individual

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
    '(((|SpecializationAsEnd2UniversalRestriction| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (|ClassOfRelationship| X2) :and
       (:exists Y
	(|SpecializationTriple| Y X1 X2) :and
	(|ClassificationTemplate| Y |End2UniversalRestriction|))))) ;<--- POD Use of individual

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
    '(((|CardinalityMin| X1 X2) :<-> 
       (|Cardinality| X1) :and
       (|INTEGER| X2) :and
       (|hasMinimumCardinality| X1 X2))))

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
    '(((|CardinalityMax| X1 X2) :<-> 
       (|Cardinality| X1) :and
       (|INTEGER| X2) :and
       (|hasMaximumCardinality| X1 X2))))


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
    '(((|CardinalityMinMax| X1 X2 X3) :<-> 
       (|Cardinality| X1) :and
       (|INTEGER| X2) :and
       (|INTEGER| X3) :and
       (|CardinalityMin| X1 X2)
       (|CardinalityMax| X1 X3))))

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
    '(((|CardinalityEnd1Min| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (:exists U
	(|CardinalityMin| U X2) :and
	(|hasEnd1Cardinality| X1 U)))))

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
    '(((|CardinalityEnd1Max| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (:exists U
	(|CardinalityMax| U X2) :and
	(|hasEnd1Cardinality| X1 U)))))

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
    '(((|CardinalityEnd1MinMax| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (INTEGER X3) :and
       (:exists U
	(|CardinalityMinMax| U X2 X3) :and
	(|hasEnd1Cardinality| X1 U)))))

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
    '(((|CardinalityEnd2Min| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (:exists U
	(|CardinalityMin| U X2) :and
	(|hasEnd2Cardinality| X1 U)))))

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
    '(((|CardinalityEnd2Max| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (:exists U
	(|CardinalityMax| U X2) :and
	(|hasEnd2Cardinality| X1 U)))))

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
    '(((|CardinalityEnd2MinMax| X1 X2) :<-> 
       (|ClassOfRelationship| X1) :and
       (INTEGER X2) :and
       (INTEGER X3) :and
       (:exists U
	(|CardinalityMinMax| U X2 X3) :and
	(|hasEnd2Cardinality| X1 U)))))

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
    '(((|TimeRepresentation| X1 X2 X3 X4 X5 X6 X7) :<->
       (|RepresentationOfGregorianDateAndUtcTime| X1) :and
       (INTEGER X2) :and
       (INTEGER X3) :and
       (INTEGER X4) :and
       (INTEGER X5) :and
       (INTEGER X6) :and
       (REAL X7) :and
       (|hasYear| X1 X2)
       (|hasMonth| X1 X3)
       (|hasDay| X1 X4)
       (|hasHour| X1 X4)
       (|hasMinute| X1 X6)
       (|hasSecond| X1 X7))))

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
    '(((|MagnitudeOfProperty| X1 X2 X3) :<-> 
       (|Property| X1) :and
       (|ArithmeticNumber| X2) :and 
       (|Scale| X3) :and
       (:exists U
	(|PropertyQuantificationTriple| U X1 X2) :and
	(|ClassificationTemplate| U X3)))))

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
    '(((|LowerUpperOfNumberRange| X1 X2 X3) :<-> 
       (|NumberRange| X1) :and
       (|ArithmeticNumber| X2) :and
       (|ArithmeticNumber| X3) :and
       (|LowerBoundOfNumberRangeTemplate| X2 X1) :and
       (|UpperBoundOfNumberRangeTemplate| X3 X1))))

;;;; 7.5.19 LowerUpperOfPropertyRange
(def-template |LowerUpperOfPropertyRange|
    :desc ""
    :sig
    '((1 "Range" |NumberRange|)
      (2 "Lower bound" |ArithmeticNumber|)
      (3 "Upper bound" |ArithmeticNumber|))
    :formal 
    '(((|LowerUpperOfNumberRange| X1 X2 X3) :<-> 
       (|NumberRange| X1) :and
       (|ArithmeticNumber| X2) :and
       (|ArithmeticNumber| X3) :and
       (|LowerBoundOfNumberRangeTemplate| X2 X1) :and
       (|UpperBoundOfNumberRangeTemplate| X3 X1))))

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
    '(((|LowerUpperOfPropertyRange| X1 X2 X3) :<-> 
       (|PropertyRange| X1) :and
       (|Property| X2) :and
       (|Property| X3) :and
       (|LowerBoundOfNumberPropertyRangeTemplate| X2 X1) :and
       (|UpperBoundOfNumberPropertyRangeTemplate| X3 X1))))

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
    '(((|PropertyRangeRestrictionOfClass| X1 X2 X3) :<-> 
       (|ClassOfIndividual| X1) :and 
       (|ClassOfIndirectProperty| X2) :and
       (|PropertyRange| X3) :and
       (:exists U
	(|ClassOflndirectPropertyTriple| U X1 X3) :and
	(|SpecializationAsEnd2UniversalRestriction| U X2)))))

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
    '(((|PropertyRangeMagnitudeRestrictionOfClass| X1 X2 X3 X4 X5) :<-> 
       (|ClassOfIndividual| X1) :and
       (|ClassOfIndirectProperty| X2) :and
       (|Scale| X3) :and
       (|ExpressReal| X4) :and
       (|ExpressReal| X5) :and
       (:exists U
	(|PropertyRangeRestrictionOfClass| X1 X2 U) :and
	(:exists Y1
		 (:exists Y2
			  (|IdentificationByNumber| X4 Y1) :and
			  (|IdentificationByNumber| X5 Y2) :and
			  (|LowerUpperMagnitudeOfPropertyRange| U X3 Y1 Y2)))))))

;;;; 7.5.23 SymbolOfScale
(def-template |SymbolOfScale|
    :desc "SymbolOfScale is a template for expressing that a symbol represents a scale.
           SymbolOfScale(a, b, c) means that a is a scale, b is a string and that b is an identifier 
           for a designated as a unit of measure symbol."
    :sig
    '((1 "Scale" |Scale|)
      (2 "Symbol" |ExpressString|))
    :formal 
    '(((|SymbolOfScale| X1 X2) :<-> 
       (|Scale| X1) :and
       (|ExpressString| X2) :and
       (|ClassifiedIdentification| X1 X2 |UomSymbolAssignment|)))) ;<--- POD Use of individual

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
    '(((|DimensionUnitNumberRangeOfScale| X1 X2 X3 X4) :<-> 
       (|Scale| X1) :and
       (|ExpressString| X2) :and
       (|SinglePropertyDimension| X3) :and
       (|NumberRange| X4) :and
       (|SymbolOfScale| X1 X2) :and
       (|ScaleTriple| X1 X4 X3))))

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
    '(((|ClassInvolvementStatusBeginning| X1 X2 X3 X4 X5) :<-> 
       (|Class| X1) :and
       (|Activity| X2) :and
       (|ClassOfInvolvementByReference| X3) :and
       (|ClassOfApprovalByStatus| X4) :and
       (|PossibleIndividual| X5) :and
       (|RepresentationOfGregorianDateAndUtcTime| X6) :and
       (|InvolvementStatusBeginning| X1 X2 X3 X4 X5 X6)))) ; POD May be a problem here. X2 was U. 

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
    '(((|ClassInvolvementSuccession| X1 X2 X3 X4 X5 X6 X7 X8) :<-> 
       (|Class| X1) :and
       (|Class| X2) :and
       (|Activity| X3) :and
       (|ClassOfInvolvementByReference| X4) :and
       (|ClassOfApprovalByStatus| x5) :and
       (|ClassOfApprovalByStatus| X6) :and
       (|PossibleIndividual| X7) :and
       (|RepresentationOfGregorianDateAndUtcTime| X8) :and
       (:exist U1
	(:exists U2
	  (:exists U3
	     (|BeginningOfTemporalPart| U1 X3 X8) :and
	     (|InvolvementByReferenceTriple| U2 X1 U1) :and
	     (|InvolvementByReferenceTriple| U3 X2 U1) :and
	     (|ClassificationTemplate| U2 X4) :and
	     (|ClassificationTemplate| U3 X4) :and
	     (|StatusApproval| U2 X5 X7) :and
	     (|StatusApproval| U3 X6 X7) :and
	     (|SuccessionOfInvolvementByReference| U2 U3)))))))





