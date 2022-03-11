
;;; Purpose: Utilities to lookup content in RDS endpoints.
;;; Date: 2012-08-08

(in-package :tlogic)

(defpackage "http://www.w3.org/2005/sparql-results#" 
  (:nicknames :sparqlr))

(defclass cached-rds-lookup ()
  ((term :initarg :term)
   (query :initarg :query)
   (endpoint :initarg :endpoint :initform "http://jord-dev.org/endpoint/")
   (result :initarg :result :initform "")))

(defparameter *query-prefix*
  '((:jord .
     "PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX RDL: <http://posccaesar.org/rdl/>
PREFIX fn: <http://www.w3.org/2005/xpath-functions#>
PREFIX p2: <http://rds.posccaesar.org/2008/02/OWL/ISO-15926-2_2003#>
PREFIX rds: <http://rdl.rdlfacade.org/data#>
PREFIX afn: <http://jena.hpl.hp.com/ARQ/function#>
")
    (:pca-local .
"PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX rdl: <http://rds.posccaesar.org/2008/06/OWL/RDL#>
PREFIX RDL: <http://rds.posccaesar.org/2008/06/OWL/RDL#>
PREFIX list: <http://www.co-ode.org/ontologies/list.owl#>
PREFIX part2: <http://rds.posccaesar.org/2008/02/OWL/ISO-15926-2_2003#>
PREFIX rds: <http://rdl.rdlfacade.org/data#>
")))


(defun sparql-select-string (&key vars triples)
  "Return a string formatting the variable and triples into a SPARQL SELECT stmt."
  (format nil "SELECT {~{~A ~} ~%~{   ~A .~} ~%       }" vars triples))

(defgeneric rds-parse (encoding variable content))

#|
<sparql xmlns="http://www.w3.org/2005/sparql-results#">
  <head>
    <variable name="superclass"/>
    <variable name="desig"/>
  </head>
  <results>
    <result>
      <binding name="superclass">
        <uri>http://posccaesar.org/rdl/RDS279134</uri>
      </binding>
      <binding name="desig">
        <literal>MECHANICAL SEPARATOR</literal>
      </binding>
    </result>
    <result>
      <binding name="superclass">
        <uri>http://posccaesar.org/rdl/RDS905765431</uri>
      </binding>
      <binding name="desig">
        <literal>FLUID TRANSFORM DEVICE</literal>
      </binding>
    </result>
  </results>
</sparql>
|#

;;; (rds-parse ... '(?x ?y)...) ==> ((x-val1 yval-1) (xval2 yval2))
(defmethod rds-parse ((encoding (eql :xml)) vars content)
  "Return list of sublists to all bindings to VARs."
  (setf content (xml-squeeze content))
  (when-bind (sparql (car (xqdm:children content)))
    (when-bind (head (xml-find-child "head" (xqdm:children sparql)))
      (let ((head-vars (mapcar #'(lambda (x) (xml-get-attr x "name"))
			       (remove-if-not #'(lambda (x) (xml-typep x 'sparqlr::|variable|))
					      (xqdm:children head)))))
	(loop for v in vars
	   unless (find v head-vars :test #'string=)
	   do (error "SPARQL Results: ~A is not a variable bound by the query." v))
	(when-bind (results (xml-find-child "results" (xqdm:children (car (xqdm:children content)))))
	  (loop for r in (xqdm:children results)
	       collect
	       (loop for v in vars
		  for b in (xqdm:children r) do
		    (unless (string= (xml-get-attr b "name") v) 
		      (error "SPARQL results bindings out of order."))
		  collect (car (xqdm:children (car (xqdm:children b)))))))))))


(declaim (inline key2endpoint))
(defun key2endpoint (endpoint-key)
  "Return the URI to the endpoint associated with ENDPOINT-KEY, a keyword."
  (ecase endpoint-key
    (:jord "http://posccaesar.org/endpoint/sparql")
    (:pca-local "http://localhost:3030/rdl/query")))

(defparameter *endpoint-memo* 
  (list 
   (cons :pca-local (make-hash-table :test #'equal))
   (cons :jord (make-hash-table :test #'equal)))
  "An alist of memo-lookup hash tables. The alist is keyed on endpoint-key, 
   the hashtable is keyed on the query made.")

;;; (sparql-query :pca-local "SELECT * {?S ?O ?P} LIMIT 10")
;;; (sparql-query :pca-local "SELECT ?id WHERE {?class RDL:hasDesignation 'ACTUATOR'. ?class RDL:hasIdPCA ?id.}")
(defun sparql-query (ep-key query &key (encoding :xml))
  "Make QUERY to endpoint key, EP-KEY returning XML or nil."
  (declare (ignore encoding))
  (let ((ht (or (cdr (assoc ep-key *endpoint-memo*))
		(let ((ht (make-hash-table :test #'equal)))
		  (push (cons ep-key ht) *endpoint-memo*)
		  ht))))
    (when-bind (hit (gethash query ht))
      #-cre.exe(format t "~% HIT!") 
	(when-debugging (:query 3)
	   (with-output-to-string (str)
	     (xmlp:write-node hit *standard-output*)))
      (return-from sparql-query (if (eql hit :no-value) nil hit)))
    ;; Otherwise make a query
    (let ((uri (strcat (key2endpoint ep-key)
		       "?query="
		       (tbnl:url-encode (cdr (assoc ep-key *query-prefix*)))
		       (tbnl:url-encode query)
		       "&output=xml")))
      (mvb (reply status)
	  (drakma:http-request uri :preserve-uri t)
	#-cre.exe(format t "~%....no hit")
	(if (= 200 status)
	    (setf (gethash query ht) 
		  (xmlp:document-parser
		   (with-output-to-string (str)
		     (loop for code across reply do (write-char (code-char code) str)))))
	    (setf (gethash query ht) :no-value))
	(when-debugging (:query 3)
	   (with-output-to-string (str)
	     (xmlp:write-node (gethash query ht) *standard-output*)))
	(gethash query ht)))))

;;;======================================================
;;; Applications
;;;======================================================
(defun rds-lookup-desig2pca-id (designation &key (rds :pca-local))
  "Return the hasIDPCA value the object with hasDesignation DESIGNATION."
  (let ((result 
	 (tlogic:sparql-query 
	  rds
	  (format nil "SELECT ?id WHERE {?class RDL:hasDesignation '~A'. ?class RDL:hasIdPCA ?id.}"
		  designation))))
    (when-bind (r-val (caar (rds-parse :xml '("id") result)))
      (caar (rds-parse :xml '("id") result)))))

(defun rds-lookup-pca-id2desig (name &key (rds :pca-local))
  "Return the hasDesignation of the object with hasIDPCA."
  (let ((result 
	 (tlogic:sparql-query 
	  rds
	  (format nil "SELECT ?name WHERE {?class RDL:hasIdPCA '~A'. ?class RDL:hasDesignation ?name.}"
		  name))))
    (when-bind (r-val (caar (rds-parse :xml '("name") result)))
      (caar (rds-parse :xml '("name") result)))))

(defun rds-lookup-type (pca-id &key (rds :jord))
  "Return a list of type names for the given PCA-id"
  (let ((result 
	 (tlogic:sparql-query 
	  rds
	  (format nil "SELECT ?class WHERE {?obj RDL:hasIdPCA '~A' . ?obj a ?class .}"
		  pca-id))))
    (when-bind (r-val (caar (rds-parse :xml '("class") result)))
      (caar (rds-parse :xml '("class") result)))))


#|
;;; Works
(defun ptryme ()
  (let ((result 
	 (tlogic:sparql-query 
	  :jord
"SELECT ?class { 
  ?class a p2:ClassOfInanimatePhysicalObject . 
  ?class RDL:hasDesignation \"ACTUATOR\" . } ")))
    (xmlp:write-node result *standard-output*)))


(defun ptryme ()
  (let ((result 
	 (tlogic:sparql-query 
	  :jord
 "SELECT ?class { 
  \"RDS364686618?class a ?class . }")
  ?class RDL:hasDesignation \"ACTUATOR\" . } ")))
    (xmlp:write-node result *standard-output*)))



;;; Doesn't Work
(defun tryme ()
  (let ((result 
	 (tlogic:sparql-query 
	  :jord
"SELECT ?sup { 
  ?class a p2:ClassOfInanimatePhysicalObject . 
  ?class RDL:hasDesignation \"ACTUATOR\" .
  ?class p2:hasSuperclass ?sup . }")))
    (xmlp:write-node result *standard-output*)))





(defun tryme ()
  (let ((result 
	 (tlogic:sparql-query 
	  :jord
 "SELECT ?sup { 
   ?class a p2:ClassOfClassOfIndividual . 
   ?class RDL:hasDesignation \"ACTUATOR CLA\" . 
   ?class p2:hasSuperclass ?sup . }")))
    (xmlp:write-node result *standard-output*)))
|#


#+nil
(defun tryme ()
  (let ((uri (strcat "http://posccaesar.org/endpoint/sparql?query="
		     (tbnl:url-encode *query-string*)
		     "&output=xml")))
    (mvb (reply status)
	(drakma:http-request uri :preserve-uri t)
      (when (= 200 status)
	(with-output-to-string (str)
	  (loop for code across reply do (write-char (code-char code) str)))))))





