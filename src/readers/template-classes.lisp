
(in-package :tlogic)

(defclass template ()
  ((name :initarg :name :initform nil :reader name)
   (parent-template :initarg :parent-template :initform nil)
   (comment :initarg :comment :initform "")
   ;; ONEOF  p7tm;BaseTemplateStatement p7tpl;InitialSetTemplateStatement p7tpl;ProtoTemplateStatement etc.
   (template-metatype :initarg :template-metatype :reader template-metatype :initform nil)
   (uri   :initarg :uri :initform nil)
   (number-of-roles :initform nil) ; this is in XML, used to cross-check...
   (roles :initarg :roles :initform nil :accessor roles)
   (logic :initarg :logic :initform nil :reader logic)
   (logic-text :initarg :logic-text :initform nil :accessor logic-text)
   (conditions :initform nil :accessor conditions :initarg :conditions)
   (of-model :initarg :of-model :reader mofi:%of-model :initform nil)))

(defmethod print-object ((obj template) stream)
  (with-slots (name conditions) obj
    (if conditions
	(format stream "{Template ~A (~A)}" name (length conditions))
	(format stream "{Template ~A}" name))))

#|
  <owl:Thing rdf:ID="TemplateRoleDescription_of_ClassOfParticipationDefinition_1">
    <rdf:type rdf:resource="http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#TemplateRoleDescription"/>
    <rdfs:label>(1) hasUrClass </rdfs:label>
    <p7tm:valRoleIndex rdf:datatype="http://www.w3.org/2001/XMLSchema#integer">1</p7tm:valRoleIndex>
    <p7tm:hasRole rdf:resource="#hasUrClass"/>
    <p7tm:hasRoleFillerType rdf:resource="http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/data-model#ClassOfActivity"/>
    <p7tm:hasTemplate rdf:resource="#ClassOfParticipationDefinition"/>
  </owl:Thing>

{Role hasActivity} is a TEMPLATE-ROLE
NAME         "hasActivity"
TYPE         {Part2 ACTIVITY}
INDEX        1
URI          NIL
COMMENT      ""
|#
(defclass template-role ()
  ((name :initarg :name :initform nil :reader name)
   (type :initarg :type :initform nil)
   (cardinality :initform nil)
   (index :initarg :index :initform nil :reader index)
   (uri   :initarg :uri :initform nil) ; ???
   (comment :initarg :comment :initform "")
   (of-template :initarg :of-template)))

(defmethod print-object ((obj template-role) stream)
  (with-slots (name) obj
    (format stream "{Role ~A}" name)))

