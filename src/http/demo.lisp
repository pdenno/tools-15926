;;; Copyright (c) 2012, Peter Denno.  All rights reserved.

(in-package :project-http)


(defun demo-dsp ()
  "Display the Emerson Demo homepage"
  (app-page-wrapper :cre (:view "EPC/Supplier Demo" :menu-pos '(:root :demo))
    (with-vo (mut)
      (setf mut *demo-mut*)
      (let ((mems (coerce (mofi:members mut) 'list)))
	(when-bind (subsys ;(find "Area 11 CHL System" :test #'string= :key #'uml241:%name))
		    (find-if #'(lambda (x) (and (typep x 'sysml12:|RequirementRelated|)
						(typep x 'sysml12:|Block|)))
			     mems))
	  (let ((components
		 (loop for c in (ocl:value (uml241:%owned-attribute subsys))
		    when (and (not (typep c 'uml241:|Port|))
			      (typep (uml241:%type c) 'sysml12:|Block|))
		    collect c)))
	    (htm
	     (:h1 "System")
	     (:br) (:a :href "/cre/object-inventory" "Object Inventory")
	     (:h2 "Subsystem / Components")
	     (str (mofb:url-object-browser subsys :force-text (uml241:%name subsys)))
	     (:ul
	      (str (with-output-to-string (s)
		     (loop for c in components
			do (format s "<li>~A : ~A -- ~A</li>" 
				   (uml241:%name c)
				   (uml241:%name (uml241:%type c))
				   (if (part-designed-p c)
				       (mofb:url-object-browser c :force-text "View specification")
				       (url-specify-part c :force-text "Specify design")))))))
	     (:a :href "/cre/show-part" "v"))))))))


(defun url-specify-part (obj &key force-text)
  "Provide a URL for the object keying by object type and tag number"
  (let ((app (find-http-app (safe-app-name))))
    (format nil "<a href='~A/specify-part?tag=~A&equip-type=~A'>~A</a>"
	    (app-url-prefix app)
	    (tbnl:url-encode (uml241:%name obj))
	    (tbnl:url-encode (uml241:%name (uml241:%type obj)))
	    (cl-who:escape-string (or force-text (format nil "~A" obj))))))

;;; http://localhost/cre/specify-part?obj-key=FT-30002&object-type=Flow%20Transmitter
(defun demo-specify-part-dsp ()
  "Display the Emerson Demo homepage"
  (app-page-wrapper :cre (:view "EPC/Supplier Demo" :menu-pos '(:root :demo))
    (when-bind (tag (safe-get-parameter "tag"))
      ;(when-bind (etype (safe-get-parameter "equip-type"))
	(let ((props (request-process-data tag)))
	  (htm
	   (:h1 "Specify Part")
	   (:h3 "Process Environment")
	   (:table :border 0  :cellspacing 1 :cellpadding 0
		   (str
		    (with-output-to-string (s)
		      (loop for p in '(JIP::+SERVICE+ JIP::+DESIGN-PRESS-MIN+ JIP::+DESIGN-PRESS-MAX+ 
				       JIP::+DESIGN-TEMP-MIN+ JIP::+DESIGN-TEMP-MAX+ JIP::+OP-PRESS-MIN+
				       JIP::+OP-PRESS-NOR+ JIP::+OP-PRESS-MAX+ JIP::+OP-TEMP-MIN+
				       JIP::+OP-TEMP-NOR+ JIP::+OP-TEMP-MAX+)
			 for title in '("Service" "Min Design Pressure (barg)" "Max Design Pressure (barg)"
					"Min Design Temp (C)" "Max Design Temp (C)" "Min Operating Pressure (barg)"
					"Normal Operating Pressure (barg)" "Max Operating Pressure (barg)"
					"Min Operating Temp (C)" "Normal Operating Temp (C)" "Max Operating Temp (C)")
			 do (format s "~%<tr> <td><strong>~A: </strong></td> <td>~A</td> </tr>"
				    title (cdr (assoc p props)))))))
	   (:h3 "Specify Transmitter")
	   (:form :method :post :enctype "multipart/form-data"
		  (:table :border 0 :cellpadding 10 :cellspacing 0 :bgcolor "#FDFDD8"
			  (:tr (:td "Model Number: ")    
			       (:td (:select :name "exercise"
					     (:option :value 
						      "3051SMV5M12G4R3A11A1BC2E1M5Q4Q8Q15T1BRRA0135" 
						      "3051SMV5M12G4R3A11A1BC2E1M5Q4Q8Q15T1BRRA0135"))))
			  (:tr (:td "Upload Datasheet: ") 
			       (:td (:input :type :file :name "uml-file")))
			  (:tr (:td (:input :type :submit :value "Upload Design"))))))))))

;;; http://localhost/cre/specify-part?obj-key=FT-30002&object-type=Flow%20Transmitter
(defun demo-show-part-dsp ()
  "Display the Emerson Demo homepage"
  (app-page-wrapper :cre (:view "EPC/Supplier Demo" :menu-pos '(:root :demo))
    (let ((props (request-transmitter "FT-30002")))
      (htm
       (:h1 "Specification for FT-30002 (Transmitter)")
       (:table :border 0  :cellspacing 1 :cellpadding 0
	       (str
		(with-output-to-string (s)
		  (loop for p in '(JIP::+TAG+ 
				   JIP::+TRANS-MODEL-NO+
				   JIP::+INST-TYPE+ JIP::+TRANS-ACCURACY+ JIP::+TRANS-PROCESS-CONNECT+ 
				   JIP::+TRANS-ENCLOSURE+ JIP::+TRANS-CONDUIT-ENTRY+ JIP::+TRANS-ELEM-MATL+ 
				   JIP::+TRANS-MOUNTING+ JIP::+TRANS-OUTPUT+ JIP::+TRANS-CAL-RANGE-MIN+ 
				   JIP::+TRANS-CAL-RANGE-MAX+ JIP::+TRANS-TRANSIENT-PROTECT+ 
				   JIP::+ACC-MOUNTING-BRACKET+ 
				   JIP::+ACC-WIRE-ON-TAG+)
		     for title in '("Tag" "Model Number" "Instrument Type" "Transmitter Accuracy"
				    "Process Connect" "Enclosure" "Conduit Entry" "Element Material"
				    "Mounting" "Output" "Min Calibration Range (mBar)"
				    "Max Calibration Range (mBar)" "Transient Protection"
				    "Mounting Bracket (accessory)" "Wire On Tag (accessory)")
		     do (format s "~%<tr> <td><strong>~A: </strong></td> <td>~A</td> </tr>"
				title (cdr (assoc p props)))))))))))


(defun cre-drakma-body-format-function (headers external-format-in)
  "To be bound to drakma:*body-format-function* (original value is drakma:DETERMINE-BODY-FORMAT)
   Forces translation to utf-8."
  ;(VARS headers external-format-in)
  (declare (ignore headers external-format-in))
  (flexi-streams:make-external-format :utf-8))


(setf json:*identifier-name-to-key* #'identity)


(defun request-transmitter (tag &key (subfield 'jip::properties)) ; jip::links
  "Return a structure from the iRING service describing transmitter with tag TAG."
  (request-internal 
   (list 
    "http://localhost:8055/Services/data/XYZ/Test2/TRANSMITTERS?format=json"
    tag
    subfield)))

(defun request-process-data (tag &key (subfield 'jip::properties)) ; jip::links
  "Return a structure from the iRING service describing transmitter with tag TAG."
  (request-internal 
   (list 
    "http://localhost:8055/Services/data/XYZ/Test2/PROCESS_DATA?format=json"
    tag
    subfield)))


(defmemo-equal request-internal (arg-list)
  "Return a structure from the iRING service describing transmitter etc with tag TAG."
  (dbind (url tag subfield) arg-list
    (with-input-from-string 
	(s (drakma:http-request url))
      (let ((json:*identifier-name-to-key* #'(lambda (x) (intern (string-upcase (string x)) :jip))))
	(declare (special json:*identifier-name-to-key*))
	(when-bind (json-return (json:with-decoder-simple-list-semantics 	(json:decode-json s)))
	  (when-bind (items (cdar (member 'jip::items json-return :key #'car)))
	    (cdr 
	     (find subfield 
		   (assoc `(jip::id . ,tag) items :test #'equal)
		   :key #'car))))))))


;;; POD The implementation below is temporary, for demo!
(defun part-designed-p (property)
  "Return T if a model number has been defined for the part described by PROPERTY."
  (if (string= "FT-30002" (uml241:%name property)) nil t))




#|
;; using url-encode on pulled:
"http://www.iringsandbox.org/facades/bentleypid/query?query=PREFIX%20owl%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E%20%0APREFIX%20tpl%3A%20%3Chttp%3A%2F%2Ftpl.rdlfacade.org%2Fdata%23%3E%0APREFIX%20dm%3A%20%3Chttp%3A%2F%2Fdm.rdlfacade.org%2Fdata%23%3E%20%0APREFIX%20rdf%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%20%0APREFIX%20rdfs%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%20%0APREFIX%20xsd%3A%20%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%20%0APREFIX%20dc%3A%20%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E%20%0APREFIX%20rdl%3A%20%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E%20%0APREFIX%20base%3A%20%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%3E%20%0APREFIX%20rds%3A%20%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F06%2FOWL%2FRDL%23%3E%20%0A%0ASELECT%20*%0AWHERE%0A%7B%20%3Fs%20%3Fp%20%3Fo%7D%0ALIMIT%201000&default-graph-uri="

;;; pulled, correcting curly brackets
"http://www.iringsandbox.org/facades/bentleypid/query?query=PREFIX+owl%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E+%0D%0APREFIX+tpl%3A+%3Chttp%3A%2F%2Ftpl.rdlfacade.org%2Fdata%23%3E%0D%0APREFIX+dm%3A+%3Chttp%3A%2F%2Fdm.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E+%0D%0APREFIX+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E+%0D%0APREFIX+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E+%0D%0APREFIX+dc%3A+%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E+%0D%0APREFIX+rdl%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+base%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%3E+%0D%0APREFIX+rds%3A+%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F06%2FOWL%2FRDL%23%3E+%0D%0A%0D%0ASELECT+*%0D%0AWHERE%0D%0A%7B+%3Fs+%3Fp+%3Fo%7D%0D%0ALIMIT+1000%0D%0A++++++&default-graph-uri="



;;; pulled directly
"http://www.iringsandbox.org/facades/bentleypid/query?query=PREFIX+owl%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E+%0D%0APREFIX+tpl%3A+%3Chttp%3A%2F%2Ftpl.rdlfacade.org%2Fdata%23%3E%0D%0APREFIX+dm%3A+%3Chttp%3A%2F%2Fdm.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E+%0D%0APREFIX+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E+%0D%0APREFIX+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E+%0D%0APREFIX+dc%3A+%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E+%0D%0APREFIX+rdl%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+base%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%3E+%0D%0APREFIX+rds%3A+%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F06%2FOWL%2FRDL%23%3E+%0D%0A%0D%0ASELECT+*%0D%0AWHERE%0D%0A{+%3Fs+%3Fp+%3Fo}%0D%0ALIMIT+1000%0D%0A++++++&default-graph-uri="


;; My User age


(drakma:http-request "http://www.iringsandbox.org/facades/bentleypid/query?query=PREFIX+owl%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2002%2F07%2Fowl%23%3E+%0D%0APREFIX+tpl%3A+%3Chttp%3A%2F%2Ftpl.rdlfacade.org%2Fdata%23%3E%0D%0APREFIX+dm%3A+%3Chttp%3A%2F%2Fdm.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E+%0D%0APREFIX+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E+%0D%0APREFIX+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E+%0D%0APREFIX+dc%3A+%3Chttp%3A%2F%2Fpurl.org%2Fdc%2Felements%2F1.1%2F%3E+%0D%0APREFIX+rdl%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%23%3E+%0D%0APREFIX+base%3A+%3Chttp%3A%2F%2Frdl.rdlfacade.org%2Fdata%3E+%0D%0APREFIX+rds%3A+%3Chttp%3A%2F%2Frds.posccaesar.org%2F2008%2F06%2FOWL%2FRDL%23%3E+%0D%0A%0D%0ASELECT+*%0D%0AWHERE%0D%0A{+%3Fs+%3Fp+%3Fo}%0D%0ALIMIT+1000%0D%0A++++++&default-graph-uri="
    :additional-headers '(("Accept-Encoding" . "gzip, deflate"))
    :user-agent :firefox
    :keep-alive t
    :close nil
    :accept "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")

|#




