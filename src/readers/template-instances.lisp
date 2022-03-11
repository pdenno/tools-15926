
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
			  (xqdm:root xml)
			  #'(lambda (x) (and (xml-typep x "binding")
					     (when-bind (a (xml-get-attr x "name"))
					       (string= a "RDS"))))
			  #'xqdm:children :on-fail nil))
		    (if-bind (uri (find-if #'(lambda (x) (xml-typep x "uri")) 
					   (remove-if-not #'xqdm:element-p (xqdm:children rds))))
			     (car (xqdm:children uri))
			     (warn "rds-wip-equiv can't find uri: ~A" r-number))
		    (warn "rds-wip-equiv can't find binding.name = RDS: ~A" r-number))
	   (warn "rds-wip-equiv query returns nothing: ~A" r-number)))


(defun rewrite-pid-take-off ()
  "A throw-away to replace rdlfacade.org names with posccaesar.org rdsWipEquivalent."
  (let ((doc (xmlp:document-parser #P"/home/pdenno/projects/cre/part8-imp-forum/pid-take-off.owl")))
    (depth-first-search
     (xqdm:root doc)
     #'fail
     #'xqdm:children
     :do #'(lambda (x)
	     (when (and
		    (xqdm:element-p x)
		    (xml-typep x '|http://15926.org/templates-test/templates#|::|hasSuperClass|))
	       (mvb (success vec) 
		   (cl-ppcre:scan-to-strings ".*#(.*)" (xml-get-attr x "resource"))
		 (when success
		   (when-bind (pca-id (rds-wip-equiv (svref vec 0)))
		     (let ((attr (find-if #'(lambda (x) (eql '|http://www.w3.org/1999/02/22-rdf-syntax-ns#|::|resource|
							     (xqdm:name x))) (xqdm:attributes x))))
		       (setf (xqdm:children attr) (list pca-id)))))))))
    (xqdm:write-node doc *standard-output*)))

(defun xml2triples (doc)
  "Create ODM RDF triples for an XQDM-based RDF/XML document."
  
			     
		 

  
      
