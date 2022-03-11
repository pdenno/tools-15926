
(in-package :turtle)

;;; To capture a turtle document requires more object types than just those
;;; found in the ODM RDF and RDFS packages. The additional objects are defined here. 

(defvar *blank-node-cnt* 0)
(defvar *triples* nil "A list of triples created. Cleared after each |Statement|")

;;; Defined-at is set in mof-types.lisp for mm-root-supertype.
(defclass turtle-base-type ()
  ((mofi:|defined-at| :initform nil :reader mofi:%defined-at)))

(defclass |TurtleDoc| (turtle-base-type)
  ((|statements| :initform nil :reader %statements)))

(defmethod print-object ((obj |TurtleDoc|) stream)
  (with-slots (|statements|) obj
    (format stream "#<TurtleDoc ~A statements>"
	    (length |statements|))))

(defclass |PrefixDecl| (turtle-base-type)
  ((|prefix| :initform nil :initarg :prefix)
   (IRI :initform nil :initarg :iri)))

(defmethod print-object ((obj |PrefixDecl|) stream)
  (with-slots (|prefix|) obj
    (format stream "#<PrefixDecl ~A >" |prefix|)))

(defclass |BaseDecl|  (turtle-base-type)
  ((IRI :initform nil :initarg :iri)))

(defun ensure-node (iri)
  "Return an existing node, or make a new one."
  (break "POD not used now. Might not be right.")
  (let ((iri-string (odm:%iri-string iri)))
    (or (gethash iri-string *nodes*)
	(setf (gethash iri-string *nodes*)
	      (make-instance 'odm:IRI :iri-string iri-string)))))
  
(defun ensure-blank-node (&optional label)
  "Return an existing blank node, or make a new one. 
  This serves a new node for each ANON. (LABEL is null string in that case.)"
  (let (new)
    (cond ((gethash label *nodes*))
	  ((null label)
	   (let ((label (format nil "_mod_blank~A" (incf *blank-node-cnt*))))
	     (setf (gethash label *nodes*)
		   (setf new (make-instance 'odm:|BlankNode| :node-i-d label)))
	     (when-debugging (:parser 5) (format t "~%+++ New BlankNode: ~A~%" new)))
	   new)
	  (t
	   (setf (gethash label *nodes*)
		 (setf new (make-instance 'odm:|BlankNode| :node-i-d label)))
	   (when-debugging (:parser 5) (format t "~%+++ New BlankNode: ~A~%" new))))))

;;; ODM Spec: "The subject and object of a Triple are of type Node. 
;;;            ReferenceNode, BlankNode, and Literal form a complete and disjoint covering of Node."
(defun mk-triple (s v o)
  "Make a triple, converting the subject (and object if necessary) into Nodes
   and the predicate into an RDFProperty ."
  ;pod2014(unless (typep s 'odm:|BlankNode|) (setf s (ensure-node s)))
  ;pod2014(setf v (make-instance 'odm:|RDFProperty| :iri v))
  ;pod2014(when (typep o 'odm:IRI)
  ;pod2014  (setf o (ensure-node o)))
  (let ((trip (make-instance 'odm:|Triple| :r-d-fsubject s :r-d-fpredicate v :r-d-fobject o)))
    (push-last trip *triples*)
    (when-debugging (:parser 5) (format t "~%*** Made Triple: ~A~%" trip))
    trip))

(defun resolve-prefixed-name (pname)
  "Resolve a prefixed name using an in-scope prefix definition, 
   return a rdf-base:URIReference."
  (let ((ns (pname--ns pname)))
    (if-bind (ns-name (cdr (find ns *prefix-defs* :key #'car :test #'string=)))
	     (strcat ns-name (pname--ln pname))
	     (error 'turtle-parse-token-error :expect "a defined namespace prefix" :got ns))))

;;; POD Not sure I want to uniquify uri-refs, but here goes...  
(defun ensure-uri-ref (str &key prefix)
  "Return an existing reference to the URIReference, or make a new one."
;  (or
;   (gethash str *uri-refs*)
;   (setf (gethash str *uri-refs*)
	 (make-instance 'odm:IRI
			:iri-string str ;; hide prefix info for use in XML serialization.
			:obj-id (assoc prefix *prefix-defs* :test #'string=)))

(defstruct rdf-literal
   (-val)
   (-lang)
   (-ns))

(defun turtle-find-triple (doc &key id)
  (find-if #'(lambda (x) (and (typep x 'odm:|Triple|)
			      (= (mofi:%debug-id x) id)))
	   (%statements doc)))

;;;===================================================================
;;; Junk
;;;===================================================================
(defun dogfood1 ()
  (turtle2rdf #P"/home/pdenno/projects/mm/FactoryProject/FactoryProject/qif2.ttl"))

(defun dogfood2 (doc)
  (with-open-file (stream 
		   (lpath :mylib "w3c-utils/turtle/dogfood.ttl") 
		   :direction :output :if-exists :supersede)
    (odm2ttl doc stream)))

(defun doit ()
  (turtle2rdf 
"
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix ex: <http://example.org/stuff/1.0/> .

<http://www.w3.org/TR/rdf-syntax-grammar>
  dc:title \"RDF/XML Syntax Specification (Revised)\" ;
  ex:editor [
    ex:fullname \"Dave Beckett\";
    ex:homePage <http://purl.org/net/dajobe/>
  ] .
"))


(defun doit ()
  (turtle2rdf 

"@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix dtype: <http://www.linkedmodel.org/schema/dtype#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix qif2: <http://qifstandards.org/xsd/qif2#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

qif2:B2TypeDatatype
  rdf:type rdfs:Datatype ;
  dc:description \"The B2Type is an array of two Boolean values.\"^^xsd:string ;
  rdfs:label \"B2Type datatype\"^^xsd:string ;
  rdfs:subClassOf qif2:ListBoolTypeDatatype ;
  owl:equivalentClass [
      rdf:type rdfs:Datatype ;
      owl:onDatatype qif2:ListBoolTypeDatatype ;
      owl:withRestrictions (
          [
            xsd:length \"2\"^^xsd:anySimpleType ;
          ]
        ) ;
    ] ;
."))


(defun doit ()
  (turtle2rdf 

"@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix dtype: <http://www.linkedmodel.org/schema/dtype#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix qif2: <http://qifstandards.org/xsd/qif2#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

qif2:Int15TypeDatatype
  rdf:type rdfs:Datatype ;
  dc:description \"The Int15Type is an integer type, having values from the range [1..5].\"^^xsd:string ;
  rdfs:label \"Int15Type datatype\"^^xsd:string ;
  rdfs:subClassOf xsd:integer ;
  owl:equivalentClass [
      rdf:type rdfs:Datatype ;
      owl:onDatatype xsd:integer ;
      owl:withRestrictions (
          [
            xsd:maxInclusive 5 ;
          ]
          [
            xsd:minInclusive 1 ;
          ]
        ) ;
    ] ;
."))

