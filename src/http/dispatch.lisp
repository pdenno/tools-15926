;;; Copyright (c) 2012, Peter Denno.  All rights reserved.

(in-package :project-http)

(defparameter *uploaded-files-dir* (lpath :tmp "upload/"))

(defun make-cre-menu ()
  (mk-mnode
   :root
   "<not used>"
   "<not used>"
   (mk-mnode :site-overview "Site Overview"     "/cre/index.html")
   (mk-mnode :validate "Template Validation"    "/cre/validate"
	     (mk-mnode :upload "Upload a file"  "/cre/validate/upload")
	     (mk-mnode :mmt "MMT Templates"     "/cre/validate/results/mmt")
	     (mk-mnode :em "Emerson Templates"  "/cre/validate/emerson"))
   (mk-mnode :browse        "Browse Models"     "/cre/model-list"
	     (mk-mnode :part2  "ISO15926-2"     "/cre/part2")
	     (mk-mnode :odm    "ODM"            "/cre/odm-tree")
	     (mk-mnode :mexico "EXPRESS"        "/cre/mexico")
    #-cre.exe(mk-mnode :uo     "Upper Ontology" "/cre/uo"))
   (mk-mnode :qvt
	     "QVT-r"
	     "/cre/qvt"
	     (mk-mnode :load-metamodels "Load Metamodels" "/cre/qvt/load-metamodels")
	     (mk-mnode :load-maps       "Load QVT-r Maps" "/cre/qvt/load-maps")
	     (mk-mnode :load-models     "Load Models"     "/cre/qvt/load-models")
	     (mk-mnode :map             "Execute Mapping" "/cre/qvt/map"))
   #+nil(mk-mnode :demo "EPC/Supplier Demo" "/cre/demo")
   (mk-mnode :changelog "Change Log" "/cre/changelog")))


;;; *dispatch-table* : A list of functions of one argument (request) that look at the uri,
;;; and if matches, returns a handler, otherwise, next one in table is tried.
;;; Example: create-static-file-dispatcher create a function that, when (eql (script-name *request*) uri),
;;; returns a function that handles the request. (Otherwise it declines by returning nil).

;;;(setf *default-handler* 'cre-default-handler)

(defun set-tbnl-dispatch-table ()
  (setf *dispatch-table*
	(list
	 (create-folder-dispatcher-and-handler
	  "/cre/static/" (namestring (lpath :src "http/static/")))
	 (create-folder-dispatcher-and-handler
	  "/cre/image/" (namestring (lpath :src "http/image/")))
	 (create-prefix-dispatcher "/cre/uo" 'upper-ontology-dsp)
	 (create-prefix-dispatcher "/cre/model-list" 'model-list-dsp)
	 (create-prefix-dispatcher "/cre/odm-tree" 'odm-tree-dsp)
	 (create-prefix-dispatcher "/cre/mexico" 'mexico-dsp)
	 (create-prefix-dispatcher "/cre/part2" 'part2-dsp)
	 (create-prefix-dispatcher "/cre/explain-legacy-xml" 'explain-legacy-xml-dsp)
	 (create-prefix-dispatcher "/cre/class-view" #'(lambda () (mofb:mof-class-view-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/object-view" #'(lambda () (mofb:mof-obj-view-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/browse-model" #'(lambda () (mofb:mof-model-list-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/remove-model" 'mofb:remove-model-dsp)
	 (create-prefix-dispatcher "/cre/object-inventory" 'object-inventory-page)
	 (create-prefix-dispatcher "/cre/changelog" 'cre-changelog-dsp)
	 (create-prefix-dispatcher "/cre/specify-part" 'demo-specify-part-dsp)
	 (create-prefix-dispatcher "/cre/show-part" 'demo-show-part-dsp)
#-cre.exe(create-prefix-dispatcher "/cre/demo" 'demo-dsp)

	 (create-prefix-dispatcher "/cre/validate/upload" 'template-validator-dsp)
	 (create-prefix-dispatcher "/cre/validate/tpage" 'template-show-page-dsp)
	 (create-prefix-dispatcher "/cre/validate/ipage" 'instance-show-page-dsp)
	 (create-prefix-dispatcher "/cre/validate/results/mmt" 'validate-show-mmt-list-dsp)
	 (create-prefix-dispatcher "/cre/validate/results/user" 'validate-show-user-list-dsp)
	 (create-prefix-dispatcher "/cre/validate/rds/class/" 'validate-show-rds-class-dsp)
	 (create-prefix-dispatcher "/cre/validate/explanation" 'mof-explain-dsp)
	 (create-prefix-dispatcher "/cre/validate/emerson" 'validate-em-dsp)
	 (create-prefix-dispatcher "/cre/validate" 'validate-home-dsp)

	 ;; QVT
	 (create-prefix-dispatcher "/cre/qvt/load-metamodels" #'(lambda () (qvth:qvt-load-metamodels-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/qvt/load-maps" #'(lambda () (qvth:qvt-compile-maps-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/qvt/load-models" #'(lambda () (qvth:qvt-load-models-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/qvt/map" #'(lambda () (qvth:qvt-execute-map-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/qvt/parse-errors" #'(lambda () (qvth:qvt-parse-errors-dsp :app :cre)))
	 (create-prefix-dispatcher "/cre/qvt/restore-defaults" 'qvth:qvt-restore-defaults-dsp)
	 #+nil(create-prefix-dispatcher "/cre/qvt/js" 'devl-js-post-dsp)
	 (create-prefix-dispatcher "/cre/qvt" #'(lambda () (qvth:qvt-dsp :app :cre)))

	 ;; Defaults
	 (create-prefix-dispatcher "/cre/index.html" 'cre-homepage)
	 (create-prefix-dispatcher "/cre/software-disclaimer" 'cre-software-disclaimer)
	 (create-regex-dispatcher  "/cre/$" 'cre-homepage)
	 (create-regex-dispatcher  "/cre$"  'cre-homepage)
	 'default-dispatcher)) ; tbnl function that returns *default-handler*
  (values))

;;; 2022 Added from SEI
(defun cre-clear-session ()
  "Clear up stuff so that it looks like a new user."
  (when (and (boundp 'tbnl:*session*) tbnl:*session*)
    (tbnl:remove-session tbnl:*session*))
  (tbnl:start-session)
  (setf (tbnl:session-value 'session-vo) ; 2011-07-27 setting 'session-vo is new!!!
	(setf *spare-session-vo*
	      (make-instance 'cre-session-vo
			     :app-name :cre
			     :tbnl-session tbnl:*session*)))
  (with-html-output-to-string (*standard-output*)
    (:html "Your session with Tools-15926 has been cleared.")))

(defun tool-under-construction ()
  (app-page-wrapper :cre (:menu-pos '(:root))
    (:h1 "Tool under construction")
    "This tool is not yet completely implemented. Check back soon."))

(defun make-apps ()
  "Create the apps from scratch."
  (set-tbnl-dispatch-table)
  (setf mofb:*mof-browser-class-view-menu-structure* '(:root :browse))
  (make-instance 'http-app
		 :app-name :cre
		 :app-url-prefix "/cre"
		 :app-title "ISO 15926 Tools"
		 :app-menu (make-cre-menu)
		 :session-vo-class 'cre-session-vo ; was a function in pod-utils
		 ;; app-url-key-fn is used by url-object-browser to track the instance in a URL parameter.
		 ;; It creates entries in the view-object hash-table of the session-vo."
		 :app-url-key-fn
		 #'(lambda (object)
		     (let ((obj-key (string (gensym "VOBJ"))))
		       (with-vo (view-objects)
			 (setf (gethash obj-key view-objects) object)
			 obj-key)))))
