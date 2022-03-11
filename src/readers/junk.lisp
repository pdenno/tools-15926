
(defun tlogic-write-xml (elem)
  (if elem
      (setf red-regex (format nil "(~A)" (string xmi-idref)))
      (strcat "<p/> "
	      (cl-who:escape-string
	       (with-output-to-string (str) (xmlp:write-node elem str)))))
  ""))



(defun translate-type (str)
  "Use the str to identify an EXPRESS entity type, or datatype (lisp symbol 'string, 'integer etc)."
  (VARS str)
  (if (null str) 
      (find-class 'p2::thing)
      (mvb (success vec) (cl-ppcre:scan-to-strings ".*#(.*)" str)
	(if success 
	    (let ((tstr (string-trim '(#\Space) (svref vec 0))))
	      (cond ((translate-type-aux tstr))
		    ((cl-ppcre:scan "AND" tstr) ; POD only works for two. 
		     (mvb (success vec) (cl-ppcre:scan-to-strings "(.*)AND(.*)" tstr)
		       (declare (ignore success)) ; Buddhist...
		       (let ((r1 (or (translate-type-aux (svref vec 0))
				     (warn "Don't know what to do with type(1) ~S" (svref vec 0))))
			     (r2 (or (translate-type-aux (svref vec 1))
				     (warn "Don't know what to do with type(2) ~S" (svref vec 1)))))
			 (list r1 r2))))
		    (t   (warn "Don't know what to do with type ~S" tstr))))
	    (warn "Couldn't parse type: ~A" str)))))


(defun translate-type-aux (tstr)
  "Return a type object for basic string (no AND)."
  (cond ((string= "" tstr) nil)
	((member (string-upcase tstr) '("FLOAT" "STRING" "INTEGER") :test #'string=)
	 (intern (string-upcase tstr) :cl))
	((string= "dateTime" tstr) :datetime)))



(defvar *tmpl-classes-ht*   (make-hash-table :test #'equal))
(defvar *tmpl-descs-ht*     (make-hash-table :test #'equal))
(defvar *tmpl-roles-ht*     (make-hash-table :test #'equal) "Roles (xml elements), indexed by template-name.")
(defvar *tmpl-logic-ht*     (make-hash-table :test #'equal) "Text of template logic, indexed by template-name.")

(defun tryme ()
  (process-templates 
   ;;:file (lpath :cre "data/part8-tests/TestGeometryTemplates-keith-formatted.owl")
   ;;:file (lpath :cre "data/part8-tests/mmt-templates.owl")
   :mmm *mmm*))


(defun read-owl (&key file model mmm)
  "Read an XML file of OWL descriptions of templates."
  (let ((doc (or mmm (xmlp:document-parser file))))
    ;(setf *mmm* doc)
    (catalog-template-roles doc)
    (catalog-template-logic doc)
    (loop for c in (xqdm:children (xqdm:root doc)) with i = 0 with result
       when (and (xml-typep c 'owl::|Thing|) (template-desc-p c)) do
	 (if-bind (temp-ref (xml-find-child 'p7tm::|hasTemplate| c)) ; attr is #:resource not rdf::resource. NI.
		  (let* ((name (rdf-resource temp-ref))
			 (logic-text (string-trim '(#\Space #\Tab #\Linefeed #\Return)
						  (or (gethash (subseq name 1) *tmpl-logic-ht*) ""))))
		    (when (string= "" logic-text) (setf logic-text nil))
		    (dbg-msg :parser 3 "~%;;;============================================================")
		    (dbg-msg :parser 3 "~%;;;------  Parsing ~A ---------------- ~%~A" (incf i) logic-text) 
		    (let ((temp (make-instance 
				 'template 
				 :name (subseq name 1)
				 :of-model model
				 :roles (sort (mapcar #'process-role (gethash name *tmpl-roles-ht*))
					      #'< :key #'index)
				 :logic-text logic-text)))
		      (push temp result)
		      (validate-template temp)))
		  (warn "~%Can't find TemplateDescription's template reference."))
	 finally return (sort result #'string< :key #'name))))



#|
(defun process-role (elem)
  "Create a template-role object from the XML element."
  (with-xml-attrs ((role p7tm::|hasRole|) (index p7tm::|valRoleIndex|) (type p7tm::|hasRoleFillerType|)
		   (comment rdfs::|label|)) elem
    (when comment
      (setf comment (string-trim '(#\Space) (car (xqdm:children comment))))
      (mvb (success vec)
	  (cl-ppcre:scan-to-strings "^\\(\\d+\\)\\s+\\w+\\s+(.*)$" comment)
	(if success (setf comment (svref vec 0)) (setf comment ""))))
      (make-instance 'template-role
		     :name (subseq (rdf-resource role) 1)
		     :index (read-from-string (car (xqdm:children index)))
		     :type (or (translate-type (rdf-resource type)) (find-class 'p2::thing))
		     :comment comment)))
|#


;;; The logic is in owl:Thing template description.
(defun catalog-template-logic (doc)
  "Populate a hash table of template logic text, indexed by template-name."
  (clrhash *tmpl-logic-ht*)
  (loop for cl in (remove-if-not #'(lambda (x) (xml-typep x 'owl::|Class|)) (xqdm:children (xqdm:root doc)))
        for la = (xml-find-child 'rdfs::|label| (xqdm:children cl)) do
        (if la
	    (let ((label (string-trim '(#\Space) (car (xqdm:children la)))))
	      (if-bind (t-desc 
			(find-if #'(lambda (x)
				     (and (xqdm:element-p x)
					  (xml-typep x 'owl::|Thing|)
					  (string= (format nil "TemplateDescription_of_~A" label)
						   (xml-get-attr-value x 'rdf::ID))))
				 (member cl (xqdm:children (xqdm:root doc)))))
		       (if-bind (logic (xml-find-child 'p7tpl::|valFOLCode| t-desc))
			  (if-bind (text (xml-find-child 'p7tpl::|script| logic))
			      (setf (gethash label *tmpl-logic-ht*) (second (xqdm:children text)))
			      (warn "Cannot find p7tpl:text."))
			  (warn "Cannot find p7tpl:ValFOLCode"))
		       (warn "Cannot find Template desc for ~A" label)))
	    (warn "Cannot find label for ~A" cl))))


(defun catalog-template-roles (doc)
  "Populate a hash table of roles (xml elements), indexed by template-name."
  (clrhash *tmpl-roles-ht*)
  (depth-first-search
   (xqdm:root doc)
   #'fail
   #'xqdm:children
   :do
   #'(lambda (x)
       (when (and (xml-typep x 'owl:|Thing|) (template-role-desc-p x))
	 (push x (gethash (xml-get-attr (xml-find-child 'p7tm::|hasTemplate| (xqdm:children x)) "resource")
			  *tmpl-roles-ht*))))))


(defun template-desc-p (node)
   "NODE should be an owl:Thing element. 
    Looks for child <rdf:type rdf:resource='&p7tm;TemplateDescription'/>"
   (find-if #'(lambda (x)
		(and (xml-typep x 'rdf::|type|)
		     (string= 
		      #.(strcat "http://standards.iso.org/iso/ts/15926/-8/ed-1/"
				"tech/reference-data/p7tm#TemplateDescription")
		      (xml-get-attr-value x 'rdf::|resource|))))
	    (xqdm:children node)))

(defun template-role-desc-p (node)
   "NODE should be a owl:Thing element. 
    Looks for child <rdf:type rdf:resource=&p7tm;TemplateRoleDescription'/>"
   (find-if #'(lambda (x)
		(and (xml-typep x 'rdf::|type|)
		     (string= 
		      #.(strcat "http://standards.iso.org/iso/ts/15926/-8/ed-1/"
				"tech/reference-data/p7tm#TemplateRoleDescription")
		      (xml-get-attr-value x 'rdf::|resource|))))
	    (xqdm:children node)))



#| Before 2012-11-14 the logic was in a comment.
(defun catalog-template-logic (doc)
  "Populate a hash table of template logic text, indexed by template-name."
  (clrhash *tmpl-logic-ht*)
  (loop for cl in (remove-if-not #'(lambda (x) (xml-typep x '#:|Class|)) (xqdm:children (xqdm:root doc)))
        for ch = (xqdm:children cl)
        for la = (xml-find-child 'rdfs::|label| ch)
        for co = (xml-find-child 'rdfs::|comment| ch) do
        (if (and la co) 
	    (setf (gethash (string-trim '(#\Space) (car (xqdm:children la))) *tmpl-logic-ht*)
		  (car (xqdm:children co)))
	    (warn "Cannot find label or comment for ~A" cl))))|#


(defmethod discover-bindings ((form odm-cl:|AtomicSentence|))
  (when (unary-predicate-p form)
    (push 
     (cons (car (odm:%argument form)) (p7name2p2name (odm:%predicate form)))
     (binding--pairs (car *bindings*))))
  (when-bind (type-name (or (and (= 2 (predicate-arity form)) (proto-template-p form))
			    (and (= 3 (predicate-arity form)) (proto-triple-p form))))
    (let* ((args (odm:%argument form))
	   (arg1 (if (proto-template-p form) (first args) (second args)))
	   (arg2 (if (proto-template-p form) (second args) (third args))))
    (when-bind (type (find-iclass (p7name2p2name type-name)))
      (when-bind (ptroles (proto-roles type))
	(push (cons arg1 (translate-etype (first ptroles)))
	      (binding--pairs (car *bindings*)))
	(push (cons arg2 (translate-etype (second ptroles)))
	      (binding--pairs (car *bindings*))))))))


(defmethod discover-bindings ((form odm-cl:|AtomicSentence|))
  "Update the bindings structure with type information."
  (let ((arity (predicate-arity form)))
    (cond ((= arity 1) ; Unary, bind arg to type named by predicate
	   (push 
	    (cons (car (odm:%argument form)) (p7name2p2name (odm:%predicate form)))
	    (binding--pairs (car *bindings*))))
	  ((or (= arity 2) (= arity 3))
	   (when-bind (type-name (or (and (= 2 arity) (proto-template-p form))
				     (and (= 3 arity) (proto-triple-p form))))
	     (let* ((args (odm:%argument form))
		    (arg1 (if (proto-template-p form) (first args) (second args)))
		    (arg2 (if (proto-template-p form) (second args) (third args))))
	       (when-bind (type (find-iclass (p7name2p2name type-name)))
		 (when-bind (ptroles (proto-roles type))
		   (push (cons arg1 (translate-etype (first ptroles)))
			 (binding--pairs (car *bindings*)))
		   (push (cons arg2 (translate-etype (second ptroles)))
			 (binding--pairs (car *bindings*))))))))



//posccaesar.org/endpoint/sparql?query=PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX RDL: <http://jord-dev.org/rdl/>
PREFIX fn: <http://www.w3.org/2005/xpath-functions#>
PREFIX p2: <http://rds.posccaesar.org/2008/02/OWL/ISO-15926-2_2003#>
PREFIX rds: <http://rdl.rdlfacade.org/data#>
PREFIX afn: <http://jena.hpl.hp.com/ARQ/function#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>

SELECT ?superclass ?desig
WHERE {?class RDL:hasDesignation \"FILTER\" .
       ?spec a p2:Specialization .
       ?spec p2:hasSubclass ?class .
       ?spec p2:hasSuperclass ?superclass .
       ?superclass RDL:hasDesignation ?desig .} &output=xml

posccaesar.org/endpoint/sparql?query=PREFIX%20owl%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E%0APREFIX%20rdf%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0APREFIX%20rdfs%3A%20%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0APREFIX%20xsd%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0APREFIX%20RDL%3A%20%3Chttp%3A%2F%2Fjord-dev.org%2Frdl%2F%3E%0APREFIX%20fn%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2005%2Fxpath-functions%23%3E%0APREFIX%20p2%3A%20%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F02%2FOWL%2FISO-15926-2_2003%23%3E%0APREFIX%20rds%3A%20%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E%0APREFIX%20afn%3A%20%3Chttp%3A%2F%2Fjena.hpl.hp.com%2FARQ%2Ffunction%23%3E%0APREFIX%20dc%3A%20%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E%0A%0ASELECT%20%3Fsuperclass%20%3Fdesig%0AWHERE%20%7B%3Fclass%20RDL%3AhasDesignation%20%22FILTER%22%20.%0A%20%20%20%20%20%20%20%3Fspec%20a%20p2%3ASpecialization%20.%0A%20%20%20%20%20%20%20%3Fspec%20p2%3AhasSubclass%20%3Fclass%20.%0A%20%20%20%20%20%20%20%3Fspec%20p2%3AhasSuperclass%20%3Fsuperclass%20.%0A%20%20%20%20%20%20%20%3Fsuperclass%20RDL%3AhasDesignation%20%3Fdesig%20.%7D%20&output=xml

posccaesar.org/endpoint/sparql?query=PREFIX%20owl%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E%0APREFIX%20rdf%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0APREFIX%20rdfs%3A%20%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0APREFIX%20xsd%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0APREFIX%20RDL%3A%20%3Chttp%3A%2F%2Fjord-dev.org%2Frdl%2F%3E%0APREFIX%20fn%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2005%2Fxpath-functions%23%3E%0APREFIX%20p2%3A%20%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F02%2FOWL%2FISO-15926-2_2003%23%3E%0APREFIX%20rds%3A%20%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E%0APREFIX%20afn%3A%20%3Chttp%3A%2F%2Fjena.hpl.hp.com%2FARQ%2Ffunction%23%3E%0APREFIX%20dc%3A%20%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E%0A%0ASELECT%20%3Fsuperclass%20%3Fdesig%0AWHERE%20%7B%3Fclass%20RDL%3AhasDesignation%20'FILTER'%20.%0A%20%20%20%20%20%20%20%3Fspec%20a%20p2%3ASpecialization%20.%0A%20%20%20%20%20%20%20%3Fspec%20p2%3AhasSubclass%20%3Fclass%20.%0A%20%20%20%20%20%20%20%3Fspec%20p2%3AhasSuperclass%20%3Fsuperclass%20.%0A%20%20%20%20%20%20%20%3Fsuperclass%20RDL%3AhasDesignation%20%3Fdesig%20.%7D%20&output=xml


(defgeneric ax-children (obj))

(defmethod ax-children ((obj odm-cl:|Biconditional|))
  (list (odm:%lvalue obj) (odm:%rvalue obj)))

(defmethod ax-children ((obj odm-cl:|AtomicSentence|))
  (list obj))

  (cons (odm:%predicate obj) (odm:%argument obj)))

(defmethod ax-children ((obj odm-cl:|Conjunction|))
  (mapappend #'ax-children (odm:%conjunct obj)))

(defmethod ax-children ((obj odm-cl:|ExistentialQuantification|))
  (append (odm:%binding obj) (ax-children (odm:%body obj))))


(defmethod initialize-instance :after ((obj template-privileged-population) &key)
  (call-next-method))

(defmethod print-object ((obj template-privileged-population) stream)
  (with-slots (mofi::model-name templates) obj
    (format stream "#<Template-pop ~A (~A templates)>" mofi::model-name (length templates))))


;;; This is weaker than ideal because names are not unique.
;;; This is type (b) second role, ?Y, in consequent
(defun mex2ax-roles-implies-attr-type ()
  "Output axioms that infer the type possessed from possesion of the property."
  ;; Several entity types may define an attribute of same name, so we need to do some work.
  (loop for attr-name in (remove-duplicates (mapcar #'third (trie-query-all '(entity-declares-attr ?X ?Y)))) do
       (let* ((entities (mapcar #'second (trie-query-all `(entity-declares-attr ?e ,attr-name))))
	      (types (remove-duplicates
		      (loop for e in entities
                            for query =  (trie-query `(entity-attr-type ,e ,attr-name ?t))        
			    when query collect (fourth query)))))
	 (cond ((null types) (warn "~A of one of ~A uses a list." attr-name entities))
	       ((single-p types)
		(trie-add `(=> (,attr-name ?X ?Y) (|instance| ?Y ,(car types)))))
	       (t 
		(trie-add `(=> (,attr-name ?X ?Y) 
			       (|or| ,@(mapcar #'(lambda (x) `(|instance| ?Y ,x)) types)))))))))



(defun compute-relational-entity-types ()
  "Examine the 15926-2 schema to compute a list of the relational entity-types.
   Set the value of *relational-entity-types."
  (setf *relational-entity-types*
	(remove-if #'(lambda (x) (entity-subtype-of x (find-entity-type "ClassOfRelationship")))
		   (mex:%collection (car (mex:%subtype-constraints (find-entity-type "Relationship"))))))
  (let ((elist (remove-if-not #'(lambda (x) (typep x 'mex:|EntityType|)) 
				(coerce (mofi:members (mofi:find-model :15926-2)) 'list))))
    (setf *relational-entity-types*
	  (sort
	   (remove-duplicates
	    (append *relational-entity-types*
		    (loop for e in elist 
			  when (some #'(lambda (x) (entity-subtype-of e x)) *relational-entity-types*)
			  collect e)))
	   #'string<
	   :key #'(lambda (x) (mex:%local-name (mex:%id x))))))
  *relational-entity-types*)

