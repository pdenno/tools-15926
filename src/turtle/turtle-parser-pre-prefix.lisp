
(in-package :turtle)

(defvar *scope* nil "A list of prefix definitions.")

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

(defmethod turtle2rdf ((stream stream) &key)
  "Top-level call. Returns a translated ocl expression. SCOPE is used when coming in from QVT."
  (setf *tags-trace* nil)
  (setf *scope* nil)
  (parse-data stream '|turtleDoc|))

(defmethod parse-data :around ((stream turtle-stream) tag &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S~%" tag args (peek-token stream))
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with value ~S ~%" tag result)
    (force-output *debug-stream*)
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

;;; turtleDoc ::= statement*
(defparse |turtleDoc| ()
    (setf *line-number* 1) 
    (with-instance (rdfb:|RDFGraph|)
     (setf rdfb:|triple| 
	   (loop until (eql :eof (peek-token stream))
	         collect (parse |sentence|)))))

;;; statement ::= directive | triples '.'
(defparse |sentence| ()
  (let ((peek (peek-token stream)))
    (prog1
	(if (or (typep peek 'iriref) (typep peek 'blank-node))
	    (parse |triples|)
	    (parse |directive|))
      (assert-token #\. stream))))

;;; directive ::=  prefixID | base | sparqlPrefix | sparqlBase
(defparse |directive| ()
  (let ((p (peek-token stream)))
    (cond ((or (eql p :prefix) (parse |prefixID|))
	  ((string-equal p "prefix") (parse |sparqlPrefix|))
	  ((eql p :base) (parse |base|))
	  ((string-equal p "base") (parse |sparqlBase|))
	  (t (error 'turtle-parse-token-error :expect "a prefix or base declaration" :got p)))))

;;; POD They don't really mean to put the #\. here. They have it at the end of statement.
;;; POD Thus there are 2 simplifications possible here prefixID/sparqlPrefix base/sparqlBase
;;; prefixID ::= '@prefix' PNAME_NS IRIREF '.'
(defparse |prefixID| ()
  (assert-token :prefix stream)
  (let ((ns (read-token stream))
	(iri (read-token stream)))
    (assert-token #\. stream)
    (unless (and (typep ns 'pname)
		 (string= "" (pname--ln ns)))
      (error 'turtle-parse-token-error :expect "a namespace name" :got (pname--ln ns)))
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons (pname--ns ns) (iriref--body iri)) *scope*)))

;;; Note that this one doesn't end in #\.
;;; sparqlPrefix ::= [Pp] [Rr] [Ee] [Ff] [Ii] [Xx] PNAME_NS IRIREF
(defparse |sparqlPrefix| ()
  (read-token stream) ; POD was checked earlier.
  (let ((ns (read-token stream))
	(iri (read-token stream)))
    (unless (and (typep ns 'pname)
		 (string= "" (pname--ln ns)))
      (error 'turtle-parse-token-error :expect "a namespace name" :got (pname--ln ns)))
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons (pname--ns ns) (iriref--body iri)) *scope*)))

(defparse |base| ()
  (assert-token :base stream)
  (let ((iri (read-token stream)))
    (assert-token #\. stream)
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons :base (iriref--body iri)) *scope*)))

;;; Note that this one doesn't end in .
(defparse |sparqlBase| ()
  (read-token stream) ; POD was checked earlier.
  (let ((iri (read-token stream)))
    (unless (typep iri 'iriref)
      (error 'turtle-parse-token-error :expect "an IRI" :got iri))
    (push (cons :base (iriref--body iri)) *scope*)))

;;; POD NYI: change the RDFsubject and RDFpredicate into nodes.

;;; triples ::=	subject predicateObjectList | blankNodePropertyList predicateObjectList?
(defparse |triples| ()
    (with-instance (|Triple|)
       (setf |RDFsubject| (parse |subject|))
       (setf |RDFpredicate| (parse |predicate|)) ; POD NYI
       (setf |RDFobject| (parse |object|))))     ; POD NYI

;;; subject ::=	iri | blank
(defparse |subject| ()
    (let ((peek (peek-token stream)))
      (if (or (typep peek 'iriref) (typep peek 'prefixed-name))
	  (parse |iri|)
	  (parse |blank|))))

;;; blank ::= BlankNode | collection
(defparse |blank| ()
  (let ((peek (peek-token stream)))
    (if (typep peek 'blank-node)
	(read-token stream)
	(parse |collection|))))

;;; collection 	::= '(' object* ')'
(defparse |collection| ()
  (assert-token #\( stream )
  (prog1
      (loop for p = (peek-token stream)
	    until (eql p #\))
	    collect (parse |object|))
    (read-token stream)))

;;; object ::= 	iri | blank | blankNodePropertyList | literal
(defparse |object| ()
  (let ((peek (peek-token stream)))
    (cond ((or (typep peek 'iriref) (typep peek 'prefixed-name))
	   (parse |iri|))
	  ((or (typep peek 'blank-node) 
	       (eql peek #\()) 
	   (parse |blank|))
	  ((eql peek #\[)
	   (parse |blankNodePropertyList|))
	  ((or (numberp peek) (stringp peek))
	   (parse |literal|))
	  (t 
	   (error 'turtle-parse-token-error :expect "an IRI, Blank, [ or literal" :got peek)))))

;;; iri ::= IRIREF | PrefixedName
(defparse |iri| ()
  (let ((result (read-token stream)))
    (typecase result
      (iriref (make-instance 'rdfb:|URIReference|
		      :uri (make-instance 'rdfb:|UniformResourceIdentifier| 
					 :name (iriref--body result))))
      (pname (resolve-prefixed-name result))
      (t (error 'turtle-parse-token-error :expect "an IRI or prefixed name" :got result)))))

;;; The token a in the predicate position of a Turtle triple represents the 
;;; IRI http://www.w3.org/1999/02/22-rdf-syntax-ns#type .
(defparse |predicate| ()
  (parse |iri|))



(defun resolve-prefixed-name (pname)
  "Resolve a prefixed name using an in-scope prefix definition, 
   return a rdf-base:URIReference."
  (let ((ns (pname--ns pname)))
    (if-bind (ns-name (cdr (find ns *scope* :key #'car :test #'string=)))
       (make-instance 'rdfb:|URIReference|
		      :uri (make-instance 'rdfb:|UniformResourceIdentifier|
					 :name (strcat ns-name (pname--ln pname))))
      (error 'turtle-parse-token-error :expect "a defined namespace prefix" :got ns))))
  
  
		  
      



#|
(turtle2rdf " <http://example.org/#spiderman> <http://www.perceive.net/schemas/relationship/enemyOf> <http://example.org/#green-goblin> .")

(turtle2rdf "@prefix rel: <http://www.perceive.net/schemas/relationship/> .
   <http://example.org/#green-goblin> rel:enemyOf <http://example.org/#spiderman> .")
|#