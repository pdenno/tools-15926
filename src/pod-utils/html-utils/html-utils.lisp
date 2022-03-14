;;; Copyright 2004, Peter Denno

;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------

;;;  Author: Peter Denno
;;;  Date: 2006.09.02
;;;  Purpose: Utilities for doing 'HTTP and HTML things' using Edi Weitz's TBNL

(in-package :pod-utils)

;;;==================================================
;;; Stuff about LHS Menu / "div sideBox"
;;;==================================================
(defclass menu-node ()
  ((name :initarg :name :reader name)
   (text :initarg :text :reader text)
   (url  :initarg :url :reader url)
   (children :initarg :children :reader children :initform nil)))

(defmethod print-object ((obj menu-node) stream)
  (with-slots (name) obj
     (format stream "#<menu-node ~A>" name)))

(eval-when (:compile-toplevel :load-toplevel :execute)
 (defun mk-mnode (name text url &rest children)
   (setf children (remove-if #'null children)) ; because I have conditional code in the list
   (make-instance 'menu-node :name name :text text :url url  :children children))
) ;eval-when

(defmacro HVARS (&rest variables)
  `(cl-who:with-html-output (stream *standard-output*)
      (format stream "<br/>~A"
	 (escape-string
	  (format nil
	   ,(loop with result = ""
		  for var in variables
		  do
		  (setf result
			(if (and (consp var)
				 (eq (first var) 'quote))
			    (concatenate 'string result " ~S ")
			  (concatenate 'string result (string-downcase var) " = ~S ")))
		  finally (return result))
	   ,@variables)))))

(defmacro hformat (format-string &rest args)
  `(cl-who:with-html-output (stream *standard-output*)
     (format stream "~A"
	     (escape-string (apply #'format nil ,format-string ,args)))))

;;; POD I'm assuming here that if it isn't a string, it isn't uploaded from the user client.
;;; For example, the first element of the list returned from post-parameter can be a
;;; pathname that hunchentoot defines.
;;; POD 2012-02-24 -- This prevents responding to browse-model CorrelationSubscription ("script")
(defun xss-attack-p (str)
  "Returns t if the string looks like a cross-site scripting attempt."
  (when (stringp str)
    (when (or (cl-ppcre:scan "(?i)<script>" str)
	      (cl-ppcre:scan "[<,>]" str)
	      (cl-ppcre:scan "(?i)alert\\(\\s*\\d+\\\s*\\)" str))
      (tbnl:log-message* :warn "Cross-site scripting attempt from ~A" (tbnl:remote-addr tbnl:*request*))
      t)))

;;; Perhaps this should just use escape-string.
(defun safe-get-parameter (name &optional (request tbnl:*request*))
  "Call tbnl:get-parameter, checking for cross-site-scripting attempt."
  (when-bind (param (tbnl:get-parameter name request))
    (unless (xss-attack-p param) param)))

;;; Perhaps this should just use escape-string.
(defun safe-post-parameter (name &optional (request tbnl:*request*))
  "Call tbnl:post-parameter, checking for cross-site-scripting attempt."
  (when-bind (params (tbnl:post-parameter name request))
    (unless (some #'xss-attack-p params) params)))

(defun safe-leaf (text)
  "Return a list for sidebox-menu :leaf of for (uri-request text),
   or nil if uri-request contains XSS vulnerability characters."
  (let ((uri (tbnl:request-uri tbnl:*request*)))
    (unless (xss-attack-p uri) (list uri text))))

;;; This session-specific object contains information generated as part of a validation.
(defclass session-vo ()
  (;; This is set to a http-app.name (:moss, :sei, :et, etc) every time
   ;; an app-page-wrapper is encountered. The session-vo will be created if necessary.
   (app-name :initarg :app-name :reader app-name)
   ;; models is typically used to bind to *models* for mofi:find-model
   (session-models :accessor session-models :initarg :models :initform nil)
   ;; MUT = model-under-test A Model, the result of loading the file.
   (mut :accessor mut :initform nil) ; 2010-09-14 I'm regretting this already.
   ;; A hash table indexed (typically) by a gensym'ed variable
   ;; (see object-key-fn in mof-browser.lisp) with a value being the object
   ;; to present when the anchored text is selected.
   (view-objects :accessor view-objects :initform (make-hash-table :test #'equal))
   ;; Good for debugging, bind to *session* object
   (tbnl-session :reader tbnl-session :initarg :tbnl-session :initform nil)
   ;; a filename for temporary use. Ugh!
   (filename :initform nil)))

;(declaim (inline safe-app-name))
(defun safe-app-name ()
  "Find the app name even when there isn't a vo-object. This happens
   when for example, the user comes in from a URL in email, rather
   than a page wrapped in app-page-wrapper."
    (cond ((and (boundp 'tbnl:*session*) (tbnl:session-value 'session-vo))
	   (app-name (tbnl:session-value 'session-vo)))
	  ;; POD Alternative implementation would search app-url-prefix
	  ((boundp 'tbnl:*request*)
	   (let ((uri (tbnl:request-uri tbnl:*request*)))
	     (cond ((cl-ppcre:scan "^/se-interop" uri) :sei)
		   ((cl-ppcre:scan "^/moss" uri) :moss)
		   ((cl-ppcre:scan "^/exports" uri) :et)
		   ((cl-ppcre:scan "^/scm" uri) :scm))))
	  ((and (not (member :moss.exe *features*))
		(not (member :sei.exe *features*))
		(not (member :scm.exe *features*))
		(app-name (first (http-apps)))))
	  (t (error "Cannot determine application."))))

(defparameter *spare-session-vo* (make-instance 'session-vo :app-name :sei)
  "Points to a session-vo even when tbnl:*session* in not bound
   (that's when running at toplevel for debugging).")

(defmacro with-vo ((&rest slots) &body body)
  "Do with-slots on the session-vo, which is either the  *spare-session-vo* or,
   if 'tbnl:*session* is bound, the one on that. (Bindings of dynamic vars is per-thread)."
  (with-gensyms (obj)
    `(let ((,obj (or (and (boundp 'tbnl:*session*)
			  (tbnl:session-value 'session-vo))
		     *spare-session-vo*)))
     (with-slots ,slots ,obj ,@body))))

;;;================================
;;; Page wrapping stuff.
;;;================================
(defclass http-app ()
  ;; Name is typically a keyword (:moss :sei :et)
  ((app-name :initarg :app-name :reader app-name)
   ;; This may appear as the browser window title.
   (app-title :initarg :app-title :reader app-title)
   ;; URL to top of the application
   (app-url-prefix :initarg :app-url-prefix :reader app-url-prefix)
   ;; The class of the session-vo
   (session-vo-class :initarg :session-vo-class :initform 'session-vo :reader session-vo-class)
   ;; A menu structure of mk-mnode, typically for the LHS of each page
   (app-menu :initarg :app-menu :accessor app-menu)
   ;; A function called to define (and possibly record) the parameter to the URL tracking an object
   (app-url-key-fn :initarg :app-url-key-fn :reader app-url-key-fn)
   ;; Probably obsolete
   (app-authorization-fn :initarg :app-authorization-fn :reader app-authorization-fn
			 :initform     #'(lambda (user pw) (declare (ignore user pw))
						 (error "No authorization function provided."))))

  (:documentation "A class to track all the presentation aspects of
   an application. MOSS, Exports, and SEI separate applications."))

(defmethod print-object ((obj http-app) stream)
  (with-slots (app-name) obj
      (format stream "{http-app ~A}" app-name)))

(let (http-apps)
  (defun register-http-app (app)
    (with-slots (app-name) app
	(setf http-apps (cons app (remove app-name http-apps :key #'app-name)))))
  (defun find-http-app (app-name) (find app-name http-apps :key #'app-name))
  (defun http-apps () http-apps)
)

(defmethod initialize-instance :after ((obj http-app) &key)
  (register-http-app obj))

(defun app-epilogue ()
  (cl-who:with-html-output (*standard-output*)
   "<br/><br/><br/><hr/><p/>Send questions or comments to
    <a href='mailto:xmi-interop@omg.org'>xmi-interop@omg.org</a>.<br/>"))

(defun div-top ()
  (cl-who:with-html-output (*standard-output*)
    (:div :id "top")))

; Each application may have its own graphic banner.
(defgeneric div-header (app))

(defun div-sideboxes (app menu-pos leaf)
  "Produce the stuff on the left, including the menu, opened to MENU-POS."
  (cl-who:with-html-output (*standard-output*)
      (:div :class "sideBox LHS"
	    (:div "Contents")
	    (str (emit-menu-html app menu-pos leaf))) ; sbcl point out this should be :str. Doesn't work in LW!
      (div-disclaimers app)))

(defun emit-menu-html (app menu-pos leaf)
  "Boldifies every item along the path of the menu-pos. Add leaf items for class name, etc.
   Does not show items below siblings of things on the path."
  (let ((result "") siblings-of-on-path)
    (depth-first-search ; calculate siblings-of-on-path
     (app-menu (find-http-app app))
     #'fail
     #'(lambda (x) (when x (children x)))
     :tracking t
     :do #'(lambda (n)
	     (unless (member (name n) menu-pos)
	       (when (second (tree-search-path))
		 (when (intersection menu-pos (mapcar #'name (children (second (tree-search-path)))))
		   (push n siblings-of-on-path))))))
    (flet ((add (str) (setf result (strcat result str))))
      (depth-first-search
       (app-menu (find-http-app app))
       #'fail #'(lambda (x) (when x (children x))) :tracking t
       :do
       #'(lambda (n)
	   (let ((spaces (case (length (tree-search-path))
			   ((0 1 2) "")
			   (3 "&nbsp;&nbsp;&nbsp;")
			   (4 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
			   (5 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
			   (otherwise "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"))))
	     (unless (eql :root (name n))
	       (when (or (member (name n) menu-pos) ; the node is on path
			 (member n siblings-of-on-path)
			 (eql (last1 menu-pos) (name (second (tree-search-path))))) ; child of selected
		  (if (member (name n) menu-pos) ; of course this gets botched up on non-unique key components!
		      (progn
			(add (format nil "~%<a href='~A'><strong>~A~A</strong></a>" (url n) spaces (text n)))
			(when  (and (eql (name n) (last1 menu-pos)) leaf)
			  (add (format nil "~%<a href='~A'><strong>~A&nbsp;&nbsp;&nbsp;~A</strong></a>"
				  (car leaf) spaces (second leaf)))))
		    (add (format nil "~%<a href='~A'>~A~A</a>" (url n) spaces (text n)))))))))
      result)))

(defmacro basic-page-wrapper (app &body body)
  "A wrapper that associates a session object with the user, but doesn't involve responding with project-styled HTML."
  `(progn
     ;; Creating a vo-object if there isn't one, set vo-object.app-name,
     (if (and (boundp 'tbnl:*session*) (tbnl:session-value 'session-vo))
	 (with-slots (app-name) (tbnl:session-value 'session-vo) (setf app-name ,app))
	 (progn
	   (tbnl:start-session)
	   (setf (tbnl:session-value 'session-vo)
		 (setf *spare-session-vo*
		       (make-instance (session-vo-class (find-http-app ,app))
				      :app-name ,app
				      :tbnl-session tbnl:*session*)))))
     ,@body))

(defmacro app-page-wrapper (app (&key (menu-pos ''(:root)) leaf disclaimer-p  view  ; auth-required
				      js-tree scripts force-new-session)
			    &body body)
  "Wrap the raw html with the HTML header, title, css stylesheet reference and LHS menu.
   NYI: Run the body in a process and kill it if it takes too long. (probably TBNL does this!)"
  `(progn
     ;; Creating a vo-object if there isn't one, set vo-object.app-name,
     (if (and (and (boundp 'tbnl:*session*) (tbnl:session-value 'session-vo))
	      (not ,force-new-session))
	 (with-slots (app-name) (tbnl:session-value 'session-vo) (setf app-name ,app))
	 (progn
	   (tbnl:start-session)
	   (setf (tbnl:session-value 'session-vo)
		 (setf *spare-session-vo*
		       (make-instance (session-vo-class (find-http-app ,app))
				      :app-name ,app
				      :tbnl-session tbnl:*session*)))))
     ;(setf (cl-who:html-mode) :sgml) ; if allowed to be :xml, kristy's graphics will "explode"
;    ,@(when auth-required (list `(authorized?))) ; commented out 2015-06-03
;;; Hans Hubner suggests:
;;;  (with-output-to-string (s)
;;;    (cl-who:with-html-output (s) ...))
    (cl-who:with-html-output-to-string (*standard-output* nil :prologue t)
      (:html
       (:head (:title (str ,(or view `(app-title (find-http-app ,app))))) ;; 2009-05-10 Should I use charset=utf8 ?
	      (:meta :http-equiv "content-type" :content "text/html; charset=iso-8859-1")
	      (:link :rel "stylesheet"
		     :type "text/css"
		     :href  (format nil "~A/static/style.css" (app-url-prefix (find-http-app ,app)))
		     :title "Stylesheet")
	      ,@(when scripts (list (include-scripts scripts)))
	      ,(when js-tree `(str ,(tree-javascript app))))
       (:body
	:class "soria"
;	(div-top)
	(div-header ,app)
	(:br)
	(div-sideboxes ,app ,menu-pos ,leaf)
	(:div :id "bodyText"
	      ,@body
	      ,@(when disclaimer-p '((software-disclaimer)))
	      (app-epilogue)))))))

(defun include-scripts (scripts)
  `(str
     ,(if scripts
	 (with-output-to-string (s)
	   (loop for script in scripts do
		(dbind (fname &optional (args "")) script
		  (if (pathnamep fname)
		      (with-open-file (in fname :direction :input)
			(format s "~%<script type='text/javascript'>~%")
			(loop for line = (read-line in nil nil)
			   while line do (format s "~A~%" line))
			(format s "~%</script>~%"))
		      ;; POD Why can't the following use empty element syntax !?!?
		      (format s "~%<script type='text/javascript' src='~A' ~A></script>" fname args))))
	 ""))))

#+nil ; 2014-06-03 I'm trying to get rid of this.
(defun authorized? (&optional (request tbnl:*request*))
  "Call tbnl:authorization which will check the request headers for user/password.
   Check against known users. If not there, send back headers to require authorization.
   (tbnl:require-authorization)."
    (mvb (user password) (tbnl:authorization request)
      (unless (and
	       user
	       password
	       (funcall (app-authorization-fn (find-http-app (safe-app-name))) user password))
	(tbnl:log-message* :info "Failed login attempt user ~A from IP address ~A" user
			  (tbnl:header-in "remote-ip-addr")) ; 2014-05-27 sbcl I #+nil until this is fixed; wants 2 args
	(tbnl:require-authorization "Interoperability Project, members-only"))))

(defun tree-javascript (app)
  "Javascript for a twistdown tree that I ought to be doing with my own code instead!"
  (with-output-to-string (out)
    (format out "~%<script language='JavaScript'>~%")
    (format out
"  var openImg   = new Image();
   var closedImg = new Image();")
   (format out "~% openImg.src   = \"/~A/image/down-arrow.png\";" (case app (:moss "moss") (:sei "se-interop")))
   (format out "~% closedImg.src = \"/~A/image/right-arrow.png\";" (case app (:moss "moss") (:sei "se-interop")))
   (format out
"
   function showBranch(branch) {
      var objBranch = document.getElementById(branch).style;
      if (objBranch.display==\"block\") objBranch.display=\"none\";
      else objBranch.display=\"block\";
   }

   function swapFolder(img) {
      objImg = document.getElementById(img);
      if(objImg.src.indexOf(closedImg.src)>-1) objImg.src = openImg.src;
      else objImg.src = closedImg.src;
   }")
  (format out "~%</script>")))



;;; This one doesn't work! ... :href (str ....))
(defmethod div-disclaimers ((app t))
  "Write disclaimers."
  (with-slots (app-url-prefix) (find-http-app app)
    (cl-who:with-html-output (*standard-output*)
      (:div :class "disclaimer LHS"
	    (:a :href (str (format nil "~A/software-disclaimer" app-url-prefix)) "Software Disclaimer")))))

(defun software-disclaimer ()
  (cl-who:with-html-output-to-string (s)
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


(declaim (inline app-redirect))
(defun app-redirect (uri-rhs)
  "Wrapper on tbnl:redirect, append the application to string URI.."
  (tbnl:redirect (strcat (app-url-prefix (find-http-app (safe-app-name))) uri-rhs)))
