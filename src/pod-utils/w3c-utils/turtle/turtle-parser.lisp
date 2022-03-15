
(in-package :turtle)

;;; To Do:  
;;; DONE - ensure-uri-ref
;;; DONE - end of line comment. 
;;; DONE - encapsulate subject and object in a node. 
;;;      - check that complete syntax is implemented.
;;;      - check use of ODM literals (langtag, etc. ???)
;;;      - Reading literals like this: "That Seventies Show"^^xsd:string
;;; POSTPONED - use OCL collections

(defvar *prefix-defs* nil "A list of prefix definitions.")
(defvar *subject* nil "A list scoping the subject of expressions. Car is current context.")
(defvar *uri-refs* (make-hash-table :test #'equal))
(defvar *nodes* (make-hash-table :test #'equal))

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
  (setf *blank-node-cnt* 0)
  (setf *tags-trace* nil)
  (setf *prefix-defs* '(("xsd" . "http://www.w3.org/2001/XMLSchema#")))
  (clrhash *uri-refs*)
  (clrhash *nodes*)
  (clear-debugging)
  ;(set-debugging :parser 5)
  ;(set-debugging :triples 1)
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
	,@body
	*def*))))

;;; ================== Grammar =============================

;;; turtleDoc ::= statement*
(defparse |turtleDoc| ()
  (with-instance (|TurtleDoc|) ; turtleDoc is defined in utils.lisp
    (loop until (eql :eof (peek-token stream)) do 
	 (setf *subject* nil)
	 (parse |statement| :doc *def*))))

;;; statement ::= directive | triples '.'
(defparse |statement| (doc)
  (with-slots (|statements|) doc
    (let ((p (peek-token stream)))
      (cond ((or (eql p :prefix) (eql p :base)
		 (and (stringp p) (string-equal p "prefix") (string-equal p "base")))
	     (push-last (parse |directive|) |statements|))
	    (t
	     (setf *triples* nil)
	     (parse |triples|) 
	     (setf |statements| (append |statements| *triples*))))
      (assert-token #\. stream))))

;;; directive ::=  prefixID | base | sparqlPrefix | sparqlBase
(defparse |directive| ()
  (let ((p (peek-token stream))
	result)
    (cond ((or (eql p :prefix) (string-equal p "prefix"))
	   (setf result (parse |prefix-decl|)))
	  ((or (eql p :base) (string-equal p "base"))
	   (setf result (parse |base-decl|)))
	  (t (error 'turtle-parse-token-error :expect "a prefix or base declaration" :got p)))
    result))

;;; POD They don't really mean to put the #\. here. They have it at the end of statement.
;;; POD Thus there are 2 simplifications possible here prefixID/sparqlPrefix base/sparqlBase... Done.
;;; prefixID ::= '@prefix' PNAME_NS IRIREF '.'
;;; sparqlPrefix ::= [Pp] [Rr] [Ee] [Ff] [Ii] [Xx] PNAME_NS IRIREF
(defparse |prefix-decl| ()
  (read-token stream) ; :prefix or "PrEfix"
  (with-instance (|PrefixDecl|)
    (setf |prefix| (read-token stream))
    (setf iri (read-token stream))
    (setf mofi:|defined-at| *line-number*)
    (unless (and (typep |prefix| 'pname)
		 (string= "" (pname--ln |prefix|)))
      (error 'turtle-parse-token-error :expect "a namespace name" :got (pname--ln |prefix|)))
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (setf |prefix| (pname--ns |prefix|))
    (setf iri (iriref--name iri))
    (push (cons |prefix| iri) *prefix-defs*))) ; POD replace this???

(defparse |base-decl| ()
  (read-token stream) ; :base or "BaSe"
  (with-instance (|BaseDecl|)
    (setf mofi:|defined-at| *line-number*)
    (setf iri (read-token stream))
    (assert-token #\. stream)
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))))

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
	 (push (ensure-blank-node) *subject*)
	 (parse |blankNodePropertyList|)
	 (unless (eql #\. (peek-token stream))
	   (parse |predicateObjectList|)))
	(t
	 (push (parse |subject|) *subject*)
	 (parse |predicateObjectList|))))

;;; blankNodePropertyList ::= '[' predicateObjectList ']'
(defparse |blankNodePropertyList| ()
  (let (result)
    (assert-token #\[ stream)
    (setf result (parse |predicateObjectList|))
    (assert-token #\] stream)
    result))

;;; predicateObjectList ::= verb objectList (';' predicateObjectList?)*
(defparse |predicateObjectList| ()
  (let ((verb (parse |verb|))
	(objs (parse |objectList|)))
    (loop for obj in objs do (mk-triple (car *subject*) verb obj)) ; The ONLY PLACE triples are made!
    (loop while (eql #\; (peek-token stream)) do
	 (read-token stream)
	 ;; 2014-08-18 Added check for ] (ending predicateObjectList) Removed check for #\.
	 ;; 2014-12-12 Added back check for #\.
	 (unless (or (eql #\] (peek-token stream)) (eql #\. (peek-token stream)))
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
	  (parse |iri|)
	  (mklist (parse |blank|)))))

;;; predicate 	::= 	iri
(defparse |predicate| ()
  (parse |iri|))

;;; object ::= 	iri | blank | blankNodePropertyList | literal
(defparse |object| ()
  (let ((p (peek-token stream)))
    (setf *zippy* p)
    (cond ((or (typep p 'iriref) (typep p 'pname))
	   (parse |iri|))
	  ((or (typep p 'blank-node) 
	       (eql p #\()) 
	   (parse |blank|))
	  ((eql p #\[)
	   (push (ensure-blank-node) *subject*)
	   (parse |blankNodePropertyList|)
	   (pop *subject*))
	  ((or (numberp p) (stringp p))
	   (parse |literal|))
	  (t 
	   (error 'turtle-parse-token-error :expect "an IRI, Blank, [ or literal" :got p)))))

;;; literal ::=	RDFLiteral | NumericLiteral | BooleanLiteral
(defparse |literal| ()
  (let ((p (peek-token stream)))
    (cond ((and (stringp p) 
		(or (string= p "true") (string= p "false"))
		(not (eql '^^ (peek-token stream 2)))) ; If it is, process it as a RDFLiteral.
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
  (labels ((mk-rdf-list (lst)
	     (when lst
	       (make-instance 'odm:|RDFList|
			      :r-d-ffirst (car lst)
			      :r-d-frest (mk-rdf-list (cdr lst))))))
    (assert-token #\( stream )
    (let ((result
	   (loop for p = (peek-token stream)
	      until (eql p #\))
	      collect (parse |object|))))
      (read-token stream)
      (mk-rdf-list result))))

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
  (let* ((lit (make-rdf-literal :-val (parse |String|)))
	 (p (peek-token stream)))
    (cond ((typep p 'langtag)
	   (setf (rdf-literal--lang lit) (read-token stream)))
	  ((eql p '^^)
	   (read-token stream)
	   (setf (rdf-literal--ns lit) (parse |iri|))))
    lit))

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
	   (ensure-blank-node))
	  (t (error 'turtle-parse-token-error :expect "a BLANK_NODE_LABEL or ANON" :got p)))))
  
;;; =========================== end of grammar ==================


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

