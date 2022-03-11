
;;; Purpose: Create an RDF/XML XML document from ODM objects
;;; Date: 2013-01-07

#|
  DONE - Generation of namespaces will require *prefix-defs* object. -- It is in mofi:source-elem
  DONE - Will need to create a graph -- find root nodes, etc. 
 - Subjects that are uri nodes are "rdf:about"
 - Subjects that are blank nodes are embed as object of other nodes
 - Not clear how to maintain ordering. debug and id not assigned until closing of object.
 BUG: It is probably a mistake to uniquify predicates
|#

(defvar *zippy* nil)

(defvar *graph-ht* (make-hash-table) 
  "a hash-table with subject as key and list of (pred . obj) as values.")

(defvar *namespaces* nil 
  "Set to an alist of (prefix . URI) hidden in odm-graph.source-elem.")

(declaim (inline serialized-p))
(defun serialized-p (node)
  "Return t if node is serialized."
  (mofi:%token-position node))

(defgeneric (setf serialized-p) (val obj))
(defmethod (setf serialized-p) (val node)
  (setf (mofi:%token-position node) val))

(defun clear-serialized (odm-graph)
  "Set all node and arcs to 'not serialized'."
  (loop for triple in (odm:%triple odm-graph) do
       (setf (serialized-p (odm:%r-d-fsubject triple)) nil)
       (setf (serialized-p (odm:%r-d-fpredicate triple)) nil)
       (setf (serialized-p (odm:%r-d-fobject triple)) nil)))

(defun all-serialized-p (odm-graph)
  "Return nil unless all nodes are and edges serialized."
  (loop for triple in (odm:%triple odm-graph)
       unless (and (serialized-p (odm:%r-d-fsubject triple))
		   (serialized-p (odm:%r-d-fpredicate triple))
		   (serialized-p (odm:%r-d-fobject triple)))
       return nil
       finally return t))

;;; ======================== Toplevel ===========================
(defun odmrdf2xml (odm-graph &key (stream *standard-output*))
  "Create an XML document (Anderson's XML Query Document Model) from ODM objects."
  (clear-serialized odm-graph)
  (compute-graph-ht odm-graph)
  (let ((roots (compute-root-nodes)))
    (write-rdf odm-graph roots stream))
  ;(unless (all-serialized-p odm-graph) (error "Incomplete serialization."))
  )

(defun compute-graph-ht (odm-graph)
  "Create a hash-table with subject as key and list of predicate/object as values."
  (clrhash *graph-ht*)
  (setf *namespaces* (mofi:%source-elem odm-graph))
  (loop for triple in (odm:%triple odm-graph)
     for subject = (odm:%r-d-fsubject triple)
     do (setf (gethash subject *graph-ht*)
	      (push 
	       (cons (odm:%r-d-fpredicate triple)
		     (odm:%r-d-fobject triple))
	       (gethash subject *graph-ht*))))
  *graph-ht*)

(defun compute-root-nodes ()
  "Return the root nodes of the graph contained in the subject-keyed hashtable GRAPH-HT."
  (let (roots)
    (loop for subject being the hash-key of *graph-ht* 
	  for found = nil do 
	 (loop for vals being the hash-value of *graph-ht* 
	      when (loop for pred/obj in vals
		      when (eql subject (cdr pred/obj)) do 
			(setf found t) (return t))
	      do (return t))
	 unless found do (push subject roots))
    roots))

(defun write-rdf (odm-graph roots stream)
  "Write ODM-GRAPH, an ODM:RDFGraph object, to STREAM."
  (declare (ignore stream)) ; POD!
  (let ((doc (xmlp:document-parser 
	      "<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'></rdf:RDF>")))
    (setf (xqdm:namespaces (xqdm:root doc)) 
	  (append (xqdm:namespaces (xqdm:root doc))
		  (make-namespaces doc (mofi:%source-elem odm-graph))))
    (VARS roots)
    (loop for r in roots do (add-node r (xqdm:root doc) doc))
    (format t "~3%")
    (usr-bin-xmllint :instring
		     (with-output-to-string (str)
		       (xqdm:write-node doc str)))))

;;; Subject is an IRI or blank node
;;; Predicate is an IRI
;;; Object is an IRI, literal or blank node.
(defun add-node (node parent doc)
  (let ((elem (xqdm:make-elem-node :name '|rdf|::|Description| :parent parent :document doc))
	leaves non-leaves)
    (mvs (leaves non-leaves) (leaf-objects node))
    (push elem (xqdm:children parent))
    ;; attributes
    (setf (xqdm:attributes elem)
	  (append
	   (unless (typep node 'rdfb:|BlankNode|) 
	     (list (mk-about-attr (odm:%name (odm:%uri (odm:%uri-ref node))) elem)))
	   (loop for (pred . obj) in leaves
	         unless (typep obj 'rdfb:|Node|) 
	         collect (mk-leaf-attr (pred2elem-name pred) obj parent))))
    ;; terminal objects e.g. <ex:homePage rdf:resource="http://purl.org/net/dajobe/" />
    (loop for (pred . obj) in leaves
       when (typep obj 'rdfb:|Node|) do
	 (push (mk-leaf-elem (pred2elem-name pred) obj elem doc)
	       (xqdm:children elem))
	 (setf (serialized-p pred) t))
    ;; Non-leaf objects
    (loop for (pred . obj) in non-leaves
	  for child = (xqdm:make-elem-node :name (pred2elem-name pred) :parent elem :document doc) do
	  (add-node obj child doc) 
	  (push-last child (xqdm:children elem)))
    elem))

;;; Purpose: element name of a predicate
(defun pred2elem-name (pred)
  "Intern a symbol for the predicate using package nicknames."
  (let ((uri-string  (odm:%name (odm:%uri (odm:%uri-ref pred)))))
    (if-bind (ns (mofi:%obj-id (odm:%uri-ref pred)))
	     (format nil "~A:~A" (car ns) (subseq uri-string (length (cdr ns))))
	     (format nil "~A" uri-string))))

(defun leaf-objects (node)
  "Return values:
   -- (edge . object) pairs that are outbound edges of NODE 
      for with OBJECT is terminal (including literal) 
   -- and those that are not."
  (let (leafs non-terms)
    (loop for pred/obj in (gethash node *graph-ht*)
          if (gethash (cdr pred/obj) *graph-ht*) 
          do (push pred/obj non-terms)
	  else do (push pred/obj leafs))
    (values leafs non-terms)))

;;;  <ex:homePage rdf:resource="http://purl.org/net/dajobe/" />
(defun mk-leaf-elem (elem-name obj-node parent doc)
  (setf (serialized-p obj-node) t)
  (let ((elem (xqdm:make-elem-node :name elem-name :parent parent :document doc))
	(uri (odm:%name (odm:%uri (odm:%uri-ref obj-node)))))
    (setf (xqdm:attributes elem)
	  (list (xqdm:make-string-attr-node 
		 :name '|rdf|::|resource|
		 :value uri
		 :children (list uri)
		 :parent parent)))
    elem))

(defun mk-leaf-attr (pred obj parent)
  "Make an XML attribute for a predicate with a terminal object."
  (setf (serialized-p pred) t)
  (xqdm:make-string-attr-node 
   :name pred
   :value obj
   :children (list obj)
   :parent parent))

(defun mk-about-attr (uri parent)
  "Make an rdf:about XML attribute."
  (xqdm:make-string-attr-node 
   :name '|rdf|:|about|
   :value uri
   :children (list uri)
   :parent parent))

(defun make-namespaces (doc ns-list)
  "Make xqdm:ns-nodes for xqdm:document DOC. NS-LIST is (prefix . longstring)."
  (loop for (prefix . ns) in (remove-if #'(lambda (x) (string= "rdf" (car x))) ns-list)
        for namespace = (or (find-package ns) 
			    (make-package ns 
					  :nicknames (unless (find-package prefix) (list prefix))))
        collect (xqdm:make-ns-node :prefix (intern prefix '|xmlns|)
				   :namespace namespace
				   :document doc 
				   :parent (xqdm:root doc))))


;;; When a predicate arc in an RDF graph points to an object node which has no further predicate arcs, 
;;; which appears in RDF/XML as an empty node element <rdf:Description rdf:about="..."> </rdf:Description> 
;;  (or <rdf:Description rdf:about="..." />) this form can be shortened. 
;;; This is done by using the RDF URI reference of the object node as the 
;;; value of an XML attribute rdf:resource on the containing property element and 
;;; making the property element empty. 
;;;
;;; Example (ex7): <ex:homePage rdf:resource="http://purl.org/net/dajobe/" />




#|
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix dc: <http://purl.org/dc/elements/1.1/> .
@prefix ex: <http://example.org/stuff/1.0/> .

<http://www.w3.org/TR/rdf-syntax-grammar>
  dc:title "RDF/XML Syntax Specification (Revised)" ;
  ex:editor [
    ex:fullname "Dave Beckett";
    ex:homePage <http://purl.org/net/dajobe/>
  ] .

?xml version="1.0"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns:ex="http://example.org/stuff/1.0/">
  <rdf:Description rdf:about="http://www.w3.org/TR/rdf-syntax-grammar"
		   dc:title="RDF/XML Syntax Specification (Revised)">
    <ex:editor>
      <rdf:Description ex:fullName="Dave Beckett">
	<ex:homePage rdf:resource="http://purl.org/net/dajobe/" />
      </rdf:Description>
    </ex:editor>
  </rdf:Description>
</rdf:RDF>


<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
         xmlns:ex="http://example.org/stuff/1.0/" 
         xmlns:dc="http://purl.org/dc/elements/1.1/" 
         xmlns:xsd="http://www.w3.org/2001/XMLSchema#">
  <rdf:Description rdf:about="http://www.w3.org/TR/rdf-syntax-grammar" 
                   dc:title="RDF/XML Syntax Specification (Revised)">
    <ex:editor>
      <rdf:Description ex:fullname="Dave Beckett">
        <ex:homePage rdf:resource="http://purl.org/net/dajobe/"/>
      </rdf:Description>
    </ex:editor>
  </rdf:Description>
</rdf:RDF>

|#
