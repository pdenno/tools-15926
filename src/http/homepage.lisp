;;; Copyright (c) 2012, Peter Denno.  All rights reserved.

(in-package :project-http)

(defvar *hunchentoot-server* nil "Bound to the acceptor object.")

;;; This session-specific object contains information generated as part of a validation.
(defclass cre-session-vo (session-vo)
  ((app-name :initform :cre) ; already defined in session-vo, add value
   ;; Object used to describe qvt map
   (qvt-map-info :initform nil)
   ;; A hash-table indexed by the names of conditions, containing
   ;; the unique-ht (see mof/conditions.lisp)
   (error-reports :initform (make-hash-table))
   ;; nil if, for example, cycles are found
   (diffing-possible :initform nil)
   ;; Used in upload
   (filename :initform nil)))

;;; Object used to describe qvt map
(defclass qvt-map-info ()
  ;; A compiled metamodel associated with the checkonly domain
  ((source-meta :initform nil :initarg :source-meta)
   ;; A compiled metamodel associated with the enforce domain
   (target-meta :initform nil :initarg :target-meta)
   ;; The compiled model generated from parsing the QVT-r file.
   (qvt-map-model :initform nil)
   ;; A population corresponding to source-meta
   (source-pop :initform nil)
   ;; An alist of model nicknames, keyed by the nickname.
   (nicknames :initform nil :accessor nicknames)))

(defun set-tbnl-vars ()
  "Set hunchentoot configuration, depending on whether running production or development."
  (tbnl::def-http-return-code tbnl:+http-internal-server-error+ 
    500 
    "An error occurred in Tools-15926.<br/> You may email podenno@gmail.com to report the error.") 
  (setf tbnl:*tmp-directory* (namestring (lpath :tmp "hunchentoot/")))
  ;; Print the error in html. See hunchentoot/request.lisp
  (setf tbnl:*show-lisp-errors-p* (if (member :cre.exe *features*) t nil))
  ;; *catch-errors-p = nil --> invoke debugger
  (setf tbnl:*catch-errors-p* (if (member :cre.exe *features*) t nil))
  (setf tbnl:*log-lisp-warnings-p* t)
  (setf tbnl:*log-lisp-errors-p* t)
  (setf tbnl:*log-lisp-backtraces-p* t)) ; 2011-05-10 new

(defun act-like-exe ()
  "Allow error reporting like sei.exe (production compilation)."
  (setf tbnl:*catch-errors-p* t)
  (setf tbnl:*show-lisp-errors-p* t))

(defun act-like-devel ()
  "Allow error reporting like sei.exe (production compilation)."
  (setf tbnl:*catch-errors-p* nil)
  (setf tbnl:*show-lisp-errors-p* nil))

;;; POD Symbols to avoid are from both OCL and MOF, but I have not studied this
;;; in detail. Use of OCL in constraints might matter in the choices here.
(defun cre-start ( &key (port 3002)  (stream *standard-output*))
  "Called once, when the .exe starts. This is THE entry point."
  (system-clear-memoized-fns)
  (set-tbnl-vars)
  (make-apps)
  (format t "~% Execution mode is ~A." (if (member :cre.exe *features*) "production" "development"))
  (format t "~% Application is ~A." (find-http-app :cre))
  (format t "~%Done. (Now starting server on port ~A.)~%" port)
  (when *hunchentoot-server* (cre-stop))
  ;;2022(tbnl:start (setf *hunchentoot-server* (make-instance 'my-acceptor :port port)))
  (tbnl:start (make-instance 'tbnl:easy-acceptor :port port)) ; 2022 from xmi-validator
  (format stream "~%Tools-15926 available at http://localhost:~A/cre/" port)
  (values))

(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))

;;; 2022 commented out
#+nil(defclass my-acceptor (tbnl:acceptor)
  ())

;;; 2022 commented out
#+nil(defmethod handle-request ((tbnl:*acceptor* my-acceptor) (tbnl:*request* request))
  "Check that the request doesn't have xss stuff in it (including query)"
  (unless (cl-ppcre:scan "(?i)<script>" (tbnl:url-decode (query-string tbnl:*request*)))
      (call-next-method)))

(defvar *demo-mut* nil "Only way to associate mut to session?")

(defun load-demo-sysml-file ()
  #+lispworks(lw:set-default-character-element-type 'lw:simple-char)
  ;; Read the demo CHL system SysML file.
  (handler-bind ((simple-warning #'(lambda (c) (declare (ignore c)) (muffle-warning))))
    (with-debugging (:readers 0)
      (let ((pop (mofi:xmi2model-instance :file (lpath :models "ccw-sysml/DemoCHLSystem.mdxml")
					  :clone-p nil :force t)))
	  (change-class pop 'mofi:privileged-population)
	(setf *demo-mut* pop)))))

(defun kill-hunchentoot ()
  "At least in 2022, just stopping hunchntoot will leave the port open. Thus this."
  (loop for p in (bt:all-threads)
	for name = (bt:thread-name p)
	when (and (> (length name) 20)
		  (string-equal "hunchentoot-listener" (subseq name 0 20)))
	  do (format t "Killing ~A" p)
	     (bt:destroy-thread p)))

(defun cre-stop ()
  (when *hunchentoot-server*
    (tbnl:stop *hunchentoot-server*)
    (kill-hunchentoot)
    (setf *hunchentoot-server* nil)))

(defun cre-default-handler ()
  "The handler that serves the request if no other handler is called."
  (log-message :info "Default handler called for script ~A" (script-name tbnl:*request*))
  "<html><head><title>CRE</title></head><body><h2>CRE Default Page</h2>
	  <p>The resource you sought was not found on this server.</p>
	  <hr>
	  <address><a href='mailto:syseng@nist.gov'>syseng@nist.gov</a></address>
  </body></html>")

(defmacro show-it (&body body)
  `(show-html-expansion (*standard-output* nil :indent t)
			,@body))

(defun pod-load-lisp ()
  "Handler to load a fasl file. I hope I'm not going to regret this!"
  (app-page-wrapper :cre (:view "SysML / UML Validator"
				:menu-pos '(:root :cre))
    (:h1 "Diagnostic")
    (:form :method :post :enctype "multipart/form-data"
	   (:table :border 0 :cellpadding 10 :cellspacing 0
		   :bgcolor "#FDFDD8"
		   (:tr (:td "File: ") (:td (:input :type :file :name "file")))
		   (:tr (:td :colspan 2 :align "center"
			     (:input :type :submit :value "Upload and Process")))))
    (when-bind (lisp-file (car (safe-post-parameter "file")))
      (load lisp-file :verbose nil)
      (str (format nil "Loaded at ~A" (now))))))

;;;==================================================================
;;; Override TBNL process-run-function so that may timeout when hung.
;;; This is only used in debugging.
;;;==================================================================
(defparameter *pod-worker-process-timeout* 0 "Number of seconds to wait before killing the request.")

;;; 2022 Commented out
#+nil(defun tbnl::process-run-function (name function &rest args)
  (let ((p (apply #'mp:process-run-function name nil function args)))
    (start-reaper-process p)
    p))

;;; 2022 Commented out
#+nil(defun start-reaper-process (p &key (timeout *pod-worker-process-timeout*))
  "Start a process that waits for TIMEOUT seconds, then kills a process P,
   if P still exists."
  (unless (zerop *pod-worker-process-timeout*)
    (mp:process-run-function
     (format nil "Reaper Process for ~A" (mp:process-name p)) nil
     #'(lambda ()
	 (mp:process-wait-with-timeout (format nil "Waiting to kill ~A" (mp:process-name p)) timeout)
	 (when (member p (mp:list-all-processes))
	   (when (mp:process-alive-p p)
	     (mp:process-kill p)))))))

;;;==================================================
;;; Homepages
;;;==================================================
(defun cre-homepage ()
  (app-page-wrapper :cre (:menu-pos '(:root))
    (with-open-file (s (lpath :src "http/static/homepage.html"))
      (loop for line = (read-line s nil nil)
	    while line do (princ line) (terpri)))))

(defun cre-software-disclaimer ()
  (app-page-wrapper :cre ()
   (:h2 "Disclaimer")
   "This software was developed at the National Institute of Standards and Technology by
    employees of the Federal Government in the course of their official duties. Pursuant
    to title 17 Section 105 of the United States Code this software is not subject to copyright
    protection and is in the public domain. It is an experimental system. NIST assumes no
    responsibility whatsoever for its use by other parties, and makes no guarantees, expressed
    or implied, about its quality, reliability, or any other characteristic. We would appreciate
    acknowledgement if the software is used. This software can be redistributed and/or modified
    freely provided that any derivative works bear some notice that they are derived from it,
    and any modified versions bear some notice that they have been modified."))

(defmethod pod:div-header ((app (eql :cre)))
  "Emit html for the banner. "
  (with-html-output (*standard-output*)
    (:img :src  "/cre/image/header.png" ; 2022 "/cre/image/heading.gif"
	  :width 903 :height 108 :border 0
	  :usemap "#index_02_Map")
    (:map :name "#index_02_Map"
	  (:area :shape "rect" :coords "709,4,862,63"))))

(defun cre-changelog-dsp ()
  (app-page-wrapper :cre (:menu-pos '(:root :changelog))
    (:h1 "CRE Tools Changelog")
    "This page describes changes that affect the behavior of the CRE tools
     (Validator, Class Browser, etc.)."
    (:h2 "Changes")
    (:ul
     (:li (:strong "2022-03-12:")
	  (:ul
	   (:li "Compiled for SBCL")
	   (:li "Using Open source Vampire")
	   (:li "Using new MMT (Part 2) templates")))
     (:li (:strong "2013-08-15:")
	  (:ul
	   (:li "Template Instances: Added type checking for roles.")
	   (:li "Corrected a bug where error type explanations were not provided.")))
     (:li (:strong "2013-07-26:")
	  (:ul
	   (:li "The XML element named 'valFOLCode' is now expected to be in p7tm (where it belongs), not p7tpl.")
	   (:li "Provided basic reporting on Part 8 template instance files.")
	   (:li "Updated pre-loaded MMT templates to the version on 15926.org on 2013-07-25.")))
     (:li (:strong "2013-03-07:")
	  (:ul
	   (:li "Templates: Report where role type in owl:allValuesFrom and p7tm:hasRoleFillerType do not match.")
	   (:li "Templates: Report when template 'metatype' isn't one of p7tm:BaseTemplateStatement,
		p7tpl:InitialSetTemplateStatement, p7tpl:ProtoTemplateStatement.")
	   (:li "Templates: Report when owl:onProperty references a non-existent role.")))
     (:li (:strong "2013-02-14:")
	  (:ul
	   (:li "Removed invalid report of error where role type is dm:PossibleIndividual.")
	   (:li "Fixed bug where method for rdfs:comments was not specified.")
	   (:li "Fixed bug where non-relation data model types were processed as templates.")))
     (:li (:strong "2013-02-10:")
	  (:ul
	   (:li "Handle 'legacy' namespaces for p7tm, p7tpl, dm.")
	   (:li "Report an error where namespaces are not appropriate.")
	   (:li "Allow use of outer XML owl:Thing element on TemplateDescription, TemplateRoleDescription.")
	   (:li "Report where a template role type is not a dm:Class.")))
     (:li (:strong "2012-11-14:")
	  (:ul
	   (:li "Added type inference using ClassificationTemplate as suggested by Victor Agroskin.")
	   (:li "Adjusted reading of OWL templates to accommodate valFOLCode element.")
	   (:li "Default RDL lookup is to a local triple store containing a PCA snapshot.")))
     (:li (:strong "2012-10-23:")
	  (:ul
	   (:li "Added validation of Emerson templates.")
	   (:li "When role type is not specified in Emerson templates use P2:Thing.")
	   ;(:li "Implemented a page describing term resolutions against type JORD endpoint.")
	   (:li "Added a warning for situations where base template reference could not be resolved.")
	   (:li "Updated MMT template validation to use templates retrieved today.")))
     (:li (:strong "2012-10-04:")
	  (:ul
	   (:li "Deployed initial version."))))))
