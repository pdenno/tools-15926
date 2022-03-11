
(in-package :turtle)

;;; To Do:  
;;; DONE - ensure-uri-ref
;;; DONE - end of line comment. 
;;; DONE - encapsulate subject and object in a node. 
;;;      - check that complete syntax is implemented.
;;;      - check use of ODM literals (langtag, etc. ???)
;;;      - Reading literals like this: "That Seventies Show"^^xsd:string
;;; POSTPONED - use OCL collections
;;; 

(defvar *prefix-defs* nil "A list of prefix definitions.")
(defvar *subject* nil "A list scoping the subject of expressions. Car is current context.")
(defvar *uri-refs* (make-hash-table :test #'equal))
(defvar *nodes* (make-hash-table :test #'equal))
(defvar *triples* nil "A list of triples created")

(defmethod initialize-instance :after ((obj odb:|Triple|) &key)
  (when-debugging (:parser 5)
    (format t "~%*** Made Triple: ~A~%" obj))
  (push obj *triples*))

(defmethod initialize-instance :after ((obj odm:|BlankNode|) &key)
  (when-debugging (:parser 5)
    (format t "~%+++ New BlankNode: ~A~%" obj)))


(defclass turtle-stream (token-stream)
  ((read-fn :initform 'turtle-read)
   (pod::buffer-string :initform nil)))

(defmacro defparse (tag (&rest keys) &body body)
   "Defines a parse-data eql method on TAG. The method macrolets parse."
   `(defmethod parse-data ((stream turtle-stream) (tag (eql ',tag)) &key ,@keys)
      (macrolet ((parse (tag &rest keys) ; the mystery solved: pass2 needs to call parse too.
			`(parse-data stream ',tag ,@keys)))
	,@body)))

(defgeneric turtle2rdf (str &key debug-p &allow-other-keys))

(defmethod turtle2rdf ((str string) &key debug-p)
  "Create a string-intput-stream and call turtle2rdf with it."
  (when debug-p (format t "~%Testcase: ~S~%" str))
  (let ((string-stream (make-string-input-stream (strcat str " ")))
	(*package* (find-package :turtle)))
    (with-open-stream (stream (setf *token-stream* 
				    (make-instance 'turtle-stream :stream string-stream)))
      (let ((result (turtle2rdf stream)))
        (if (eql :eof (peek-token stream))
	    result
	  (error 'turtle-parse-incomplete :actual (peek-token stream)))))))

(defmethod turtle2rdf ((filename pathname) &key)
  (with-open-file (file-stream filename :direction :input)
    (with-open-stream (stream (setf *token-stream* 
				    (make-instance 'turtle-stream :stream file-stream)))
    (let ((result (turtle2rdf stream)))
      (if (eql :eof (peek-token stream))
	  result
	  (error 'turtle-parse-incomplete :actual (peek-token stream)))))))

(defmethod turtle2rdf ((stream stream) &key)
  "Top-level call. Returns a translated ocl expression. SCOPE is used when coming in from QVT."
  (setf *line-number* 1) 
  (setf *tags-trace* nil)
  (setf *prefix-defs* '(("xsd" . "http://www.w3.org/2001/XMLSchema#")))
  (setf *subject* nil)
  (setf *triples* nil)
  (clrhash *uri-refs*)
  (clrhash *nodes*)
  (parse-data stream '|turtleDoc|))

(defmethod parse-data :around ((stream turtle-stream) tag &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S *subject*=~A~%" tag args (peek-token stream) *subject*)
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with value ~S. ~%" tag result)
    (force-output *debug-stream*)
    (pop *tags-trace*)
    result))

(defvar *def* nil "Dynamically bound to the current MM object during parsing (when with-instance is used")

;;; This IS NOT a candidate for pod-utils. Each impementation differs (See the EXPRESS one.)
(defmacro with-instance ((type &rest init-args) &body body)
  "A macro that creates an object and provides with-slots to use it." 
  (let ((slot-names (mapcar #'clos:slot-definition-name (clos:class-slots (find-class type)))))
    `(let* ((*def* (make-instance ',type ,@init-args)))
      (with-slots ,slot-names *def*
	(declare (ignorable ,@slot-names))
	(setf mofi:|token-position| (token-position *token-stream*))
	,@body
	*def*))))

;;; ================== Grammar =============================

;;; turtleDoc ::= statement*
(defparse |turtleDoc| ()
  (loop until (eql :eof (peek-token stream)) do 
       (setf *subject* nil)
       (parse |statement|))
  (with-instance (odm:|Graph|) 
    (setf odm:|triple| *triples*) ; POD ocl:collection
    (setf mofi:|source-elem| *prefix-defs*)))

;;; statement ::= directive | triples '.'
(defparse |statement| ()
  (let ((p (peek-token stream)))
    (if (or (eql p :prefix) (eql p :base)
	    (and (stringp p) (string-equal p "prefix") (string-equal p "base")))
	(parse |directive|)
	(parse |triples|))
    (assert-token #\. stream)))

;;; directive ::=  prefixID | base | sparqlPrefix | sparqlBase
(defparse |directive| ()
  (let ((p (peek-token stream)))
    (cond ((or (eql p :prefix) (string-equal p "prefix"))
	   (parse |prefix-decl|))
	  ((or (eql p :base) (string-equal p "base"))
	   (parse |base-decl|))
	  (t (error 'turtle-parse-token-error :expect "a prefix or base declaration" :got p))))
  (values))

;;; POD They don't really mean to put the #\. here. They have it at the end of statement.
;;; POD Thus there are 2 simplifications possible here prefixID/sparqlPrefix base/sparqlBase... Done.
;;; prefixID ::= '@prefix' PNAME_NS IRIREF '.'
;;; sparqlPrefix ::= [Pp] [Rr] [Ee] [Ff] [Ii] [Xx] PNAME_NS IRIREF
(defparse |prefix-decl| ()
  (read-token stream) ; :prefix or "PrEfix"
  (let ((ns (read-token stream))
	(iri (read-token stream)))
    (unless (and (typep ns 'pname)
		 (string= "" (pname--ln ns)))
      (error 'turtle-parse-token-error :expect "a namespace name" :got (pname--ln ns)))
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons (pname--ns ns) (iriref--name iri)) *prefix-defs*)))

(defparse |base-decl| ()
  (read-token stream) ; :base or "BaSe"
  (let ((iri (read-token stream)))
    (assert-token #\. stream)
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons :base (iriref--name iri)) *prefix-defs*)))

;;; "In Turtle, fresh RDF blank nodes are also allocated when matching the production blankNodePropertyList 
;;; and the terminal ANON. Both of these may appear in the subject or object position of a triple 
;;; (see the Turtle Grammar). That subject or object is a fresh RDF blank node. 
;;; This blank node also serves as the subject of the triples produced by matching 
;;; the predicateObjectList production embedded in a blankNodePropertyList. 
;;; The generation of these triples is described in Predicate Lists. 
;;; Blank nodes are also allocated for collections..."

;;;[ foaf:name "Alice" ] foaf:knows [
;;;    foaf:name "Bob" ;
;;;    foaf:knows [
;;;        foaf:name "Eve" ] ;
;;;    foaf:mbox <bob@example.com> ] .

;;; triples ::=	subject predicateObjectList | blankNodePropertyList predicateObjectList?
(defparse |triples| ()
  (cond ((eql #\[ (peek-token stream))
	 (push (list (ensure-blank-node "")) *subject*)
	 (parse |blankNodePropertyList|)
	 (unless (eql #\. (peek-token stream))
	   (parse |predicateObjectList|)))
	(t
	 (push (parse |subject|) *subject*)
	 (parse |predicateObjectList|))))

;;; blankNodePropertyList ::= '[' predicateObjectList ']'
(defparse |blankNodePropertyList| ()
    (assert-token #\[ stream)
    (parse |predicateObjectList|)
    (assert-token #\] stream))

;;; ODM Spec: "The subject and object of a Triple are of type Node. 
;;;            ReferenceNode, BlankNode, and Literal form a complete and disjoint covering of Node."
(defun mk-triple (s v o)
  "Make a triple, converting the subject (and object if necessary) into Nodes
   and the predicate into an RDFProperty ."
  ;pod2014(unless (typep s 'odm:|BlankNode|) (setf s (ensure-node s)))
  ;pod2014(setf v (make-instance 'odm:|RDFProperty| :iri v))
  ;pod2014(when (typep o 'odm:IRI)
  ;pod2014  (setf o (ensure-node o)))
  (make-instance 'odm:|Triple| :r-d-fsubject s :r-d-fpredicate v :r-d-fobject o))

;;; predicateObjectList ::= verb objectList (';' predicateObjectList?)*
(defparse |predicateObjectList| ()
  (let ((verb (parse |verb|))
	(objs (parse |objectList|)))
    (loop for s in (car *subject*) do
	 (loop for obj in objs do (mk-triple s verb obj)))
    (loop while (eql #\; (peek-token stream)) do
	 (read-token stream)
	 ;; 2014-08-18 Added check for ] (ending predicateObjectList) Removed check for #\.. 
	 (unless (eql #\] (peek-token stream)) #|(eql #\. (peek-token stream))|#
	   (parse |predicateObjectList|))))) ;recursive

;;; objectList ::= object (',' object)*
(defparse |objectList| ()
  (loop collect (parse |object|)
        while (eql (peek-token stream) #\,)
        do (read-token stream)))

;;; The token a in the predicate position of a Turtle triple represents the 
;;; IRI http://www.w3.org/1999/02/22-rdf-syntax-ns#type .
;;; verb ::= predicate | 'a'
(defparse |verb| ()
  (let ((p (peek-token stream)))
    (if (and (stringp p) (string= "a" p))
	(ensure-uri-ref "http://www.w3.org/1999/02/22-rdf-syntax-ns#type")
	(parse |predicate|))))

;;; POD Note that the subject can be a collection! I return a list in all cases.
;;; subject ::=	iri | blank
(defparse |subject| ()
    (let ((p (peek-token stream)))
      (if (or (typep p 'iriref) (typep p 'pname))
	  (list (parse |iri|))
	  (let ((b (parse |blank|)))
	    (if (listp b) b (list b))))))

;;; predicate 	::= 	iri
(defparse |predicate| ()
  (parse |iri|))

;;; object ::= 	iri | blank | blankNodePropertyList | literal
(defparse |object| ()
  (let ((p (peek-token stream)))
    (cond ((or (typep p 'iriref) (typep p 'pname))
	   (parse |iri|))
	  ((or (typep p 'blank-node) 
	       (eql p #\()) 
	   (parse |blank|))
	  ((eql p #\[)
	   (push (list (ensure-blank-node "")) *subject*)
	   (parse |blankNodePropertyList|)
	   (car (pop *subject*)))
	  ((or (numberp p) (stringp p))
	   (parse |literal|))
	  (t 
	   (error 'turtle-parse-token-error :expect "an IRI, Blank, [ or literal" :got p)))))

;;; literal ::=	RDFLiteral | NumericLiteral | BooleanLiteral
(defparse |literal| ()
  (let ((p (peek-token stream)))
    (cond ((and (stringp p) (or (string= p "true") (string= p "false")))
	   (parse |BooleanLiteral|))
	  ((stringp p)
	   (parse |RDFLiteral|))
	  ((numberp p)
	   (parse |NumericLiteral|))
	  (t (error 'turtle-parse-token-error :expect "a literal" :got p)))))

;;; blank ::= BlankNode | collection
(defparse |blank| ()
  (let ((p (peek-token stream)))
    (if (typep p 'blank-node)
	(parse |BlankNode|)
	(parse |collection|))))

;;; collection 	::= '(' object* ')'
(defparse |collection| ()
  (assert-token #\( stream )
  (prog1
      (loop for p = (peek-token stream)
	    until (eql p #\))
	    collect (parse |object|))
    (read-token stream)))

;;; NumericLiteral ::= INTEGER | DECIMAL | DOUBLE
(defparse |NumericLiteral| ()
  (let ((tkn (read-token stream)))
    (unless (numberp tkn) (error 'turtle-parse-token-error :expect "a number" :got tkn))
    tkn))

;;; http://www.w3.org/TR/rdf11-concepts/ says:
;;; a non-empty language tag as defined by [BCP47]. 
;;; The language tag must be well-formed according to section 2.2.9 of [BCP47], 
;;; and must be normalized to lowercase.

;;; ODM: "As recommended in the RDF formal semantics, these plain literals are self-denoting."
;;; (So I'm just returning the whole thing as a string)

;;; RDFLiteral	::= String (LANGTAG | '^^' iri)?
(defparse |RDFLiteral| ()
  (let* ((tkn (parse |String|))
	 (p (peek-token stream)))
    (cond ((typep p 'langtag)
	   (format nil "~S@~A" tkn (langtag--value (read-token stream))))
	  ((and (stringp p) (string= p "^^"))
	   (read-token stream)
	   (format nil "~S^^<~A>" tkn (odm:%iri-string (parse |iri|))))
	  (t tkn))))

;;; BooleanLiteral ::= 'true' | 'false'
(defparse |BooleanLiteral| ()
  (let ((tkn (read-token stream)))
    (cond ((string= tkn "true") :true)
	  ((string= tkn "false") :false)
	  (t (error 'turtle-parse-token-error :expect "'true' or 'false'" :got tkn)))))

;;; String ::= STRING_LITERAL_QUOTE | STRING_LITERAL_SINGLE_QUOTE | 
;;;            STRING_LITERAL_LONG_SINGLE_QUOTE | STRING_LITERAL_LONG_QUOTE
(defparse |String| ()
  (let ((tkn (read-token stream)))
    (unless (stringp tkn) (error 'turtle-parse-token-error :expect "a string" :got tkn))
    tkn))

;;; iri ::= IRIREF | PrefixedName
(defparse |iri| ()
  (let ((p (peek-token stream)))
    (typecase p
      (iriref (ensure-uri-ref (iriref--name (read-token stream))))
      (pname (parse |PrefixedName|))
      (t (error 'turtle-parse-token-error :expect "an IRI or prefixed name" :got p)))))

;;; PrefixedName ::= PNAME_LN | PNAME_NS
(defparse |PrefixedName| ()
  (let ((tkn (read-token stream)))
    (unless (typep tkn 'pname)
      (error 'turtle-parse-token-error :expect "a prefixed name" :got tkn))
    (ensure-uri-ref (resolve-prefixed-name tkn) :prefix (pname--ns tkn))))

;;; BlankNode ::= BLANK_NODE_LABEL | ANON
(defparse |BlankNode| ()
  (let ((p (peek-token stream)))
    (cond ((typep p 'blank-node)
	   (ensure-blank-node (blank-node--label (read-token stream))))
	  ((and (eql #\[ p) (eql #\] (peek-token stream 2)))
	   (read-token stream) (read-token stream)
	   (ensure-blank-node ""))
	  (t (error 'turtle-parse-token-error :expect "a BLANK_NODE_LABEL or ANON" :got p)))))
  
;;; =========================== end of grammar ==================

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

(defun ensure-node (iri)
  "Return an existing node, or make a new one."
  (break "POD not used now. Might not be right.")
  (let ((iri-string (odm:%iri-string iri)))
    (or (gethash iri-string *nodes*)
	(setf (gethash iri-string *nodes*)
	      (make-instance 'odm:IRI :iri-string iri-string)))))
  
(defun ensure-blank-node (label)
  "Return an existing blank node, or make a new one. 
  This serves a new node for each ANON. (LABEL is null string in that case.)"
  (cond ((gethash label *nodes*))
	((string= label "")
	 (setf (gethash (gensym "anon") *nodes*)
	       (make-instance 'odm:|BlankNode| :node-i-d :anon)))
	(t
	 (setf (gethash label *nodes*)
	       (make-instance 'odm:|BlankNode| :node-i-d label)))))


#|
(defun tryme ()
  (with-input-from-string (in " 1 2 3 ")
    (format t "~% ~A" (turtle-read in))
    (format t "~% ~A" (turtle-read in))
    (format t "~% ~A" (turtle-read in))
    (format t "~% ~A" (turtle-read in))))

(turtle2rdf " <http://example.org/#spiderman> <http://www.perceive.net/schemas/relationship/enemyOf> <http://example.org/#green-goblin> .")

(turtle2rdf "@prefix rel: <http://www.perceive.net/schemas/relationship/> .
   <http://example.org/#green-goblin> rel:enemyOf <http://example.org/#spiderman> .")

(turtle2rdf " # A triple with all absolute IRIs
  <http://one.example/subject1> <http://one.example/predicate1> <http://one.example/object1> .")


(turtle2rdf 
"
@prefix foaf: <http://xmlns.com/foaf/0.1/> .

[ foaf:name 'Alice' ] foaf:knows [ 
    foaf:name 'Bob' ;
    foaf:knows [ foaf:name 'Eve' ] ] .")



(turtle2rdf 
"
@prefix foaf: <http://xmlns.com/foaf/0.1/> .

[ foaf:name 'Alice' ] foaf:knows [
    foaf:name 'Bob' ;
    foaf:knows [
        foaf:name 'Eve' ] ;
    foaf:mbox <bob@example.com> ] .")

(turtle2rdf 
"
@prefix : <http://example.org/foo> .
# the object of this triple is the RDF collection blank node
:subject :predicate ( :a :b :c ) .
")

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix ex: <http://example.org/stuff/1.0/> .

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
")

(turtle2rdf "@prefix : <http://example.org/stuff/1.0/> .

:a :b \"The first line\nThe second line\n  more\" .

:a :b \"\"\"The first line
The second line
  more\"\"\" .")

(turtle2rdf 
"@prefix : <http://example.org/stuff/1.0/> .
(1 2.0 3E1) :p \"w\" .")


|#

