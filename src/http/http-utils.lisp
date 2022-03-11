
(in-package :phttp)

(defun url-rds-lookup-class (class-rval text)
  "Return a URL to a page of information about an object that was found in an RDL."
  (format nil "<a href='http:///cre/validate/rds/class?endpoint=~A&class=~A'>~A</a>" "jord" class-rval text))

(defun url-rds-page (uri)
  "Return a URL to lookup an object. The URI returned references a human-readable html page
   if the URI is defeferenceable, otherwise a error page."
  (cond ((and (string= (puri:uri-host uri) "rds.posccaesar.org")
	      (string= (puri:uri-path uri) "/2008/06/OWL/RDL"))
	 (if-bind (type-name (tlogic:rds-lookup-pca-id2desig (puri:uri-fragment uri)))
		  (format nil "<a href='http://posccaesar.org/rdl/page/~A'>~A</a>" 
			  (puri:uri-fragment uri)
			  type-name)
		  (format nil "<a href='http:///cre/validate/no-deref?url=~A'>~A</a>" 
			  (tbnl:url-encode (puri::uri-string uri))
			  (puri:uri-fragment uri))))
	(t 
	 (format nil "<a href='http:///cre/validate/no-deref?url=~A'>~A</a>" 
		 (tbnl:url-encode (puri::uri-string uri))
		 (puri:uri-fragment uri)))))

		  
 

