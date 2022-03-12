
(in-package :tlogic)

; (rds-wip-equiv "R35989285259") ==> "http://posccaesar.org/rdl/RDS860444"
;;; This is what the query says on the posccaesar.org endpoint tool:
;;;  "Find a specific class from the RDS WIP, using its R number. 
;;;   The query is restricted to the mapping-graph for speed."

(defun rds-wip-equiv (r-number)
  "Query the posccaesar.org iring.map (a named graph) for the PCA id corresponding 
   to the argument rdsWIP r-number. Return the URL to the PCA object."
  (if-bind (xml
	      (tlogic:sparql-query 
	       :jord 
	       (format nil
		       "SELECT * {
                        GRAPH <http://irm.dnv.com/ontologies/iring.map> {
                        ?R RDL:rdsWipEquivalent ?RDS .
                        FILTER (afn:localname(?R)= '~A')
                                                                        }
                                 }"
		       r-number)))
	   (if-bind (rds (depth-first-search 
			  (xml-utils:xml-root xml)
			  #'(lambda (x) (and (xml-typep x "binding")
					     (when-bind (a (xml-get-attr x "name"))
					       (string= a "RDS"))))
			  #'xml-utils:xml-children :on-fail nil))
		    (if-bind (uri (find-if #'(lambda (x) (xml-typep x "uri")) 
					   (remove-if-not #'dom:element-p (xml-utils:xml-children rds))))
			     (car (xml-utils:xml-children uri))
			     (warn "rds-wip-equiv can't find uri: ~A" r-number))
		    (warn "rds-wip-equiv can't find binding.name = RDS: ~A" r-number))
	   (warn "rds-wip-equiv query returns nothing: ~A" r-number)))


(defun rewrite-pid-take-off ()
  "A throw-away to replace rdlfacade.org names with posccaesar.org rdsWipEquivalent."
  (let ((doc (xml-utils:xml-document-parser #P"/home/pdenno/projects/cre/part8-imp-forum/pid-take-off.owl")))
    (depth-first-search
     (xml-utils:xml-root doc)
     #'fail
     #'xml-utils:xml-children
     :do #'(lambda (x)
	     (when (and
		    (dom:element-p x)
		    (xml-typep x '|http://15926.org/templates-test/templates#|::|hasSuperClass|))
	       (mvb (success vec) 
		   (cl-ppcre:scan-to-strings ".*#(.*)" (xml-get-attr x "resource"))
		 (when success
		   (when-bind (pca-id (rds-wip-equiv (svref vec 0)))
		     (let ((attr (find-if #'(lambda (x) (eql '|http://www.w3.org/1999/02/22-rdf-syntax-ns#|::|resource|
							     (dom:local-name x))) (xml-utils:xml-attributes x))))
		       (setf (xml-utils:xml-children attr) (list pca-id)))))))))
    (xml-utils:xml-write-node doc *standard-output*)))

(defun xml2triples (doc)
  "Create ODM RDF triples for an XQDM-based RDF/XML document."
  
			     
		 

  
      
