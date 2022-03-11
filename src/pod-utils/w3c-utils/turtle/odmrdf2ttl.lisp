
(in-package :turtle)

;;; ToDo: 
;;;  DONE -  Investigate why this is SO SLOW! See function (trip-on-subject). Not much I can do about it
;;;          other than not worry about statements far from the current one (in the list TurtleDoc.statements).
;;;          All the regex scanning in printing IRI using prefixes must take mounds of time too. 
;;;       -  Improve formatting. See notes 2014-12-15 for a TBC example that doesn't indent nicely.
;;;       -  (From uml2owl code): Fix the opposite slots (I assume that's what they are) for Ontology
;;;       -  (From uml2owl code): Write a prefix facility.
;;;       -  2015-09-21: Investigate use of odm:Property. Should it be abstract?

;;; Change Log:
;;;      2014-12-01 : Continuing to upgrade turtle parser to use 2014 ODM RDF objects
;;;      2015-03-10 : Merged code of modelegator/uml2owl/owl2turtle.lisp
;;;      2015-09-19 : Continued investigation of outputing ODM RDF. 

(defvar *odm-pop* nil)

;;; Throwaways
(defun tryme (&key to-files)
  (setf *odm-pop* mofi:*population*)
  (odm2ttl mofi:*population* nil :to-files to-files))

(defun not-serialized ()
  (collect-if #'(lambda (x) (not (written-p x)))))

(defparameter *line-number* 1)
(defparameter *written-ht* (make-hash-table) "Tracks whether it has been written")
(defparameter *default-prefixes*     
  '(("modelica"  . "<http://modelmeth.nist.gov/modelica/ModelicaMetamodel#>")
    ("expression" . "<http://modelmeth.nist.gov/modelica/Expression#>")
    ;; POD these should be mandatory, since it is hardcoded. Serves you right if use them in other ways.
    ("owl"  . "<http://www.w3.org/2002/07/owl#>")
    ("rdf"  . "<http://www.w3.org/1999/02/22-rdf-syntax-ns#>")
    ("rdfs" . "<http://www.w3.org/2000/01/rdf-schema#>")
    ("xsd" .  "<http://www.w3.org/2001/XMLSchema#>"))
  "an alist of known prefixes")
(defvar *prefixes* nil) ; 2015-09-19
(defvar *stmts* nil "means to access statements without need for passing arguments.")
(defvar *in-subject* nil "dynamically bound to current subject")
(defvar *zippy* nil "diagnostics")
(defvar *stmt-nesting* 0 "Counts how deeply nested statements are.")

(declaim (inline set-written written-p))
(defun set-written (obj)
  (setf (gethash obj *written-ht*) t))

(defun written-p (obj) (gethash obj *written-ht*))

(defmemo trip-on-subject (subj)
  "Returns a list of triples with SUB as their rdf:subject."
  (loop for trip in *stmts*
        when (and (typep trip 'odm:|Triple|)
		  (eql subj (odm:%r-d-fsubject trip)))
       collect trip))
       
(defgeneric odm2ttl (obj stream &key &allow-other-keys))

(defun collect-if (pred)
  (loop for m across (mofi:members *odm-pop*)
     when (funcall pred m) collect m))


;;; This one to serialize an ODM population created by whatever means (e.g. QVT mapping of a UML class diagram). 
;;; These could be ordered much better by having restrictions and properties called from classes. 
(defmethod odm2ttl ((popu mofi:population) stream &key to-files)
  (let ((*odm-pop* popu))
    (setf *prefixes* *default-prefixes*)
    (unless (eql (mofi:find-model :odm) (mofi:model-n+1 popu))
      (error "The argument is not a population of ODM: ~A" popu))
    (let ((ontos (collect-if #'(lambda (x) (typep x 'odm:|OWLOntology|)))))
      (loop for o in ontos 
	 for classes = (sort (collect-if #'(lambda (x) (and (typep x 'odm:|OWLClass|)
							    (member o (ocl:value (odm:%ontology x))))))
			     #'string<
			     :key #'(lambda (x) (iri-frag (odm:%iri-string (odm:%iri x)))))
         ;; POD I don't know how these are supposed to be associated with an ontology.
	 for enums = (collect-if #'(lambda (x) (and (typep x 'odm:|OWLDataEnumeration|))))
	 do 
	   (let (s)
	     (if to-files 
		 (setf s (open (lpath :mylib (format nil "pod-utils/w3c-utils/turtle/examples/~A.ttl" (o2fname o)))
			       :direction :output :if-exists :supersede))
		 (setf s *standard-output*))
	     (format s "~2%# ======= Ontology ~A =========" (odm:%iri-string (odm:%iri o)))
	     (format s "~%# ======= NIST ModelMeth tools generated ~A =========~%" (now))
	     (print-prefixes s)
	     (odm2ttl o s)
	     (loop for c in classes
		do (odm2ttl c s))
	     (loop for o in enums
		do (odm2ttl o s))
	     (when to-files (close s)))))))

(defun o2fname (ontology)
  (last1 (split (odm:%iri-string (odm:%iri ontology)) #\/)))

(defun print-prefixes (stream)
  (loop for (p . iri) in *prefixes*
       do (format stream "~%@prefix ~A: ~A ." p iri))
  (format stream "~2%"))

;;; This one just to re-serialize a document that you read in with the turtle parser.
(defmethod odm2ttl ((obj |TurtleDoc|) stream &key)
  (with-slots (|statements|) obj
    (clear-memoize 'trip-on-subject)
    (clrhash *written-ht*)
    (setf *prefixes* *default-prefixes*)
    (setf *stmts* |statements|)
    (loop for stmt in |statements| 
	 unless (written-p stmt) do
	 (odm2ttl stmt stream)
	 (if (typep stmt '|PrefixDecl|)
	     (format stream " .")
	     (format stream "~%.")))))

(defmethod odm2ttl ((obj |PrefixDecl|) stream &key)
  (with-slots (|prefix| IRI) obj
    (format stream "~%@prefix ~A <~A>" |prefix| IRI)
    (push (cons |prefix| IRI) *prefixes*)
    (set-written obj)))

;;; This is an attempt to print in abbeviated syntax! 
;;; POD I have not yet implemented object lists. In fact, for reasons of style, I probably won't 
(defmethod odm2ttl ((trip odm:|Triple|) stream &key pred-obj-only)
  (with-slots ((s odm:|RDFsubject|) (p odm:|RDFpredicate|) (o odm:|RDFobject|)) trip
    (cond (pred-obj-only 
	   (if (typep o 'odm:|BlankNode|) ; then blank node property list (always, otherwise pointless triple)
	       (progn (set-written trip)
		      (format stream "~%  ~A [~{       ~A ~} ~%  ]"  ; "~%  ~A [~%~{   ~A~^ ;~%~} ~%  ]" 
			      (odm2ttl p nil)
			      (loop for tr in (remove-if #'written-p (trip-on-subject o))
				 collect (odm2ttl tr nil :pred-obj-only t))))
	       (write-trip trip stream :two)))
	  (t
	   (setf *in-subject* s)
	   ;; NYI: I think here I have to look for an object list for this subject predicate!
	   (write-trip trip stream :three)
	   ;(format t "~%More on subject: ~{~A~%~}" (trip-on-subject s))
	   (loop for trp in (remove-if #'written-p (trip-on-subject s)) do
		(odm2ttl trp stream :pred-obj-only t))))))

(defmethod odm2ttl ((obj odm:IRI) stream &key)
  (set-written obj)
  (with-slots (odm:|iriString|) obj
    (destructuring-bind (url &rest frag) (cl-ppcre:split "\\#" odm:|iriString|)
      (let (p)
	(if (and (single-p frag) (setf p (lookup-prefix url)))
	    (format stream "~A:~A" p (car frag))
	    (format stream "<~A>" odm:|iriString|))))))

(defun iri-frag (str)  
  (mvb (success vec)
      (cl-ppcre:scan-to-strings ".*\\#(.*)" str)
    (when success (aref vec 0))))

;;; rdf-literals are created from parsing turtle, not QVT mapping (yet). 
(defmethod odm2ttl ((obj rdf-literal) stream &key)
  (with-slots (-val -ns -lang) obj
    (cond (-ns (format stream "\"~A\"^^~A" -val (odm2ttl -ns nil)))
	  (-lang (format stream "~A@~A" -val -lang))
	  (t (format stream "~A" -val)))))

(defmethod odm2ttl ((obj odm:|RDFList|) stream &key)
  (labels ((list-from-rdflist (obj accum)
	     (if (null obj) 
		 accum
		 (list-from-rdflist (odm:%r-d-frest obj) (cons (odm:%r-d-ffirst obj) accum)))))
    (format stream " (~%~{  ~A~%~}~%  )" 
	    (mapcar #'(lambda (x) (odm2ttl x nil)) (list-from-rdflist obj nil)))))

;;; This is not executed as much as you'd think, due to the handling in the Triples method. 
;;; My only known usage is as an element from RDFList. 
;;; POD This is a hack! I don't see places in TBC-generated ontologies where a blank node
;;; is the object of a triple. I'm printing here assuming it is the subject. 
(defmethod odm2ttl ((obj odm:|BlankNode|) stream &key)
  (format stream "    [ ~{                ~A~}~%   ]"
	  (mapcar #'(lambda (x) (write-trip x nil :two))
		  (remove-if #'written-p (trip-on-subject obj)))))

(defmethod odm2ttl ((obj string) stream &key)
  (format stream "\"~A\"" obj))

(defmethod odm2ttl ((obj number) stream &key)
  (format stream "~A" obj))

(defun write-trip (trip stream parts &key)
  (set-written trip) 
  (with-slots ((s odm:|RDFsubject|) (p odm:|RDFpredicate|) (o odm:|RDFobject|)) trip
    (case parts 
      (:one   (format stream "~A" (odm2ttl o nil)))
      (:two   (format stream "~%  ~A ~A ;" (odm2ttl p nil) (odm2ttl o nil)))
      (:three (format stream "~2%~A~%  ~A ~A" (odm2ttl s nil) (odm2ttl p nil) (odm2ttl o nil))))))

;;;============================================================================================
;;; OWL stuff (originally from modelegator/uml2owl/owl2turtle.lisp called odm2turtle
;;; THIS IS WHAT IS BEING USED BY ODM QVT MAPPING (not some of the stuff above, like 'triple').
;;;=============================================================================================

(defmethod odm2ttl ((obj odm:|OWLOntology|) stream &key)
  (set-written obj)
  (with-slots (odm:|iri|) obj
    (format stream "<~A>
  rdf:type owl:Ontology ;" (odm:%iri-string odm:|iri|))
    (when (string= "ModelicaMetamodel" (o2fname obj)) ; POD Temporary!!!
      (format stream "~%  owl:imports expression: ;"))
    (format stream "~%  owl:versionInfo \"Created by Modelegator mapping\"^^xsd:string ;~%.~%"))) ; This will USUALLY be true.

(defmethod odm2ttl ((obj odm:|OWLClass|) stream &key name-only)
  (with-slots (odm:|iri| odm:|RDFSsubClassOf|) obj
    (if name-only
	(odm2ttl odm:|iri| nil)
	(progn
	  (set-written obj)
	  (format stream "~2%# ------ Class ~A -----~%" (odm2ttl odm:|iri| nil))
	  (format stream "~A" (odm2ttl odm:|iri| nil))
	  (format stream "~%  rdf:type owl:Class ;")
	  (when odm:|RDFSsubClassOf|
	    (loop for sub in (ocl:value odm:|RDFSsubClassOf|) do
		 (format stream "~%  rdfs:subClassOf ~A ;" (odm2ttl sub nil :name-only t))
		 (set-written sub)))
	  (format stream "~%.~%")
	  ;; Write related properties
	  (loop for p in (collect-if #'(lambda (x) (and (or (typep x 'odm:|OWLObjectProperty|)
							    (typep x 'odm:|OWLDatatypeProperty|))
							(eq obj (first (ocl:value (odm:%r-d-f-sdomain x))))))) do
	       (odm2ttl p stream))
	  ;; Write related restrictions
	  (loop for r in (collect-if #'(lambda (x) (and (or (typep x 'odm:|MaxCardinalityRestriction|)
							    (typep x 'odm:|MinCardinalityRestriction|))
							(eq obj (odm:%qualified-by-class x))))) do
	       (odm2ttl r stream))))))
#|
:hasComment
  rdf:type owl:DatatypeProperty ;
  rdfs:domain [
      rdf:type owl:Class ;
      owl:unionOf (
          :NamedElement
          :Equation
          :Modification
        ) ;
    ] ;
  rdfs:range xsd:string ;
.
:hasComponents
  rdf:type owl:ObjectProperty ;
  rdfs:domain :ComponentReference ;
  rdfs:range :SubscriptedIdent ;
|#

(defmethod odm2ttl ((obj odm:|OWLObjectProperty|) stream &key name-only)
  (with-slots (odm:|iri| odm:|RDFSdomain| odm:|RDFSrange|) obj
    (if name-only
	(odm2ttl odm:|iri| nil)
	(progn 
	  (unless (written-p obj)
	    (set-written obj)
	    (format stream "~%~A
        rdf:type owl:ObjectProperty ;
        rdfs:domain ~A ;       
        rdfs:range ~A ;~%.~%"
		    (odm2ttl odm:|iri| nil)
		    (odm2ttl (first (ocl:value odm:|RDFSdomain|)) nil :name-only t)
		    (odm2ttl (first (ocl:value odm:|RDFSrange|)) nil :name-only t)))))))

(defmethod odm2ttl ((obj odm:|OWLDatatypeProperty|) stream &key name-only)
  (with-slots (odm:|iri| odm:|RDFSdomain| odm:|RDFSrange|) obj
    (if name-only
	(odm2ttl odm:|iri| nil)
	(progn 
	  (unless (written-p obj)
	    (set-written obj)
	    (format stream "~%~A
        rdf:type owl:DatatypeProperty ;
        rdfs:domain ~A ;
        rdfs:range ~A ;~%.~%"
		    (odm2ttl odm:|iri| nil)
		    (odm2ttl (first (ocl:value odm:|RDFSdomain|)) nil :name-only t)
		    (odm2ttl (first (ocl:value odm:|RDFSrange|)) nil :name-only t))))))) 

(defmethod odm2ttl ((obj odm:|Property|) stream &key name-only)
  (with-slots (odm:|iri|) obj
    (if name-only
	(odm2ttl odm:|iri| nil)
	(warn "Unexpected use of odm:Property."))))

(defmethod odm2ttl ((obj odm:|MaxCardinalityRestriction|) stream &key)
  (with-slots (odm:|cardinality| odm:|qualifiedByClass| odm:|OWLonProperty|) obj
      (set-written obj)
      (format stream "~%~A   
       rdfs:subClassOf [
       rdf:type owl:Restriction ;
       owl:maxCardinality \"~A\"^^xsd:int ;
       owl:onProperty ~A ;
     ] ;~%.~%" 
	      (odm2ttl odm:|qualifiedByClass| nil :name-only t)
	      odm:|cardinality|
	      (odm2ttl odm:|OWLonProperty| nil :name-only t))))

(defmethod odm2ttl ((obj odm:|MinCardinalityRestriction|) stream &key)
  (with-slots (odm:|cardinality| odm:|qualifiedByClass| odm:|OWLonProperty|) obj
      (set-written obj)
      (format stream "~%~A   
       rdfs:subClassOf [
       rdf:type owl:Restriction ;
       owl:minCardinality \"~A\"^^xsd:int ;
       owl:onProperty ~A ;
     ] ;~%.~%" 
	      (odm2ttl odm:|qualifiedByClass| nil :name-only t)
	      odm:|cardinality|
	      (odm2ttl odm:|OWLonProperty| nil :name-only t))))


#|
Expression:MultOp
  rdf:type owl:Class ;
  owl:equivalentClass [
      rdf:type owl:Class ;
      owl:oneOf (
          Expression:multiply
          Expression:divide
          Expression:multiplyElementwise
          Expression:divideElementwise
        ) ;
    ] ;
.|#
(defmethod odm2ttl ((obj odm:|OWLDataEnumeration|) stream &key)
  (with-slots (odm:|iri| odm:|dataOneOf|) obj
    (set-written obj)
    (let ((iri (odm2ttl odm:|iri| nil)))
      (format stream "~%~A   
       rdf:type owl:Class ;
       owl:equivalentClass [
          rdf:type owl:Class ;
          owl:oneOf (~{~%                ~A~}
           ) ;
       ] ;
.~%"
       iri
      (when odm:|dataOneOf| (mapcar #'(lambda (x) (odm2ttl x nil :iri odm:|iri|)) (ocl:value odm:|dataOneOf|))))
      ;; Write classes for enum vals.
      (when odm:|dataOneOf|
	    (loop for e in (ocl:value odm:|dataOneOf|) do
		 (format stream "~%~A
  rdf:type ~A ;
.~%"
			 (odm2ttl e nil :iri odm:|iri|)
			 iri))))))

(defmethod odm2ttl ((obj odm:|Literal|) stream &key iri) ; POD passing IRI to give this a prefix!!!
  (with-slots (odm:|lexicalForm|) obj
    (set-written obj)
    (if iri
	(destructuring-bind (url &rest frag) (cl-ppcre:split "\\#" (odm:%iri-string iri))
	  (let (p)
	    (if (and (single-p frag) (setf p (lookup-prefix url)))
		(format stream "~A:~A" p odm:|lexicalForm|)
		(format stream "~A"  odm:|lexicalForm|))))
	(format stream "~A"  odm:|lexicalForm|))))


;;; 2015-03-10: This is what it said in the original owl code (not sure what it means):
;;; POD THIS IS NOT RIGHT. Look at *prefixes* <...#> etc.
(defun lookup-prefix (url)
  (loop for (p . turl) in *prefixes*
     when (cl-ppcre:scan url turl)
     return p))

(defmethod odm2ttl ((obj t) stream &key)
  (warn "Method NYI for ~A" obj))





    




