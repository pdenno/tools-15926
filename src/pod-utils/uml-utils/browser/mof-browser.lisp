
;;; Purpose : Common code for browser display of MOF-based information through TBNL. 
;;;           Only load this file when :iface-http is on *features*, it's all about html.

(in-package :mof-browser)

(defvar *zippy* nil)

(defgeneric encode-for-url (obj))
(defgeneric decode-for-url-meth (type str))

(declaim (inline slot-def-name))
(defun slot-def-name (slot)
  (when slot (closer-mop:slot-definition-name slot)))

;;;====================
;;; URLs
;;;====================
;;; pod7 eliminate population (a subtype of abstract-model)
;;; 2010-09-18 Can't use of-model, which is accurate logically, but the
;;; class-name (which is what is needed to get the class) may actually
;;; be interned in a UML package (to account for profiles used against multiple
;;; base meta-models). 
(defmethod encode-for-url ((obj mofi:mm-type-mo))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "type*~A*~A" 
;	    (esc (model-name (of-model obj)))
	    (esc 
	     (if-bind (pkg (symbol-package (class-name obj)))
		(or (car (package-nicknames pkg))
		    (package-name (symbol-package (class-name obj)))) ; 2012-07-16 added esc
		"foo")) ; Added 2013-12-12 probably useless.
	    (esc (encode-angle (string (class-name obj)))))))

#+cre
(defmethod encode-for-url ((obj expo:express-entity-type-mo))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "type*~A*~A" 
	    (esc (package-name (symbol-package (class-name obj))))
	    (esc (encode-angle (string (class-name obj)))))))


;;; POD 2009-12-14: This has problems when the symbol is || Why would it be that?
;;; POD 2009-12-14: I added the if zerop stuff for that reason. Still not working. 
(defmethod encode-for-url ((obj symbol))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "symbol*~A*~A" 
	    (esc (package-name (symbol-package obj)))
	    (esc (if (zerop (length (string obj))) "NIL" obj)))))

(defmethod encode-for-url ((obj string))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "string*~A" (esc obj))))

(defmethod encode-for-url ((obj mofi:abstract-model))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "model*~A" (esc (model-name obj)))))

(defmethod encode-for-url ((obj mofi::mm-effective-slot-definition))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (let ((slot-name (slot-def-name obj))
	  (slot-source (slot-definition-effective-source obj)))
      (format nil "eslot*~A*~A*~A*~A"
	      (esc (package-name (symbol-package slot-name)))
	      (esc slot-name)
	      (esc (package-name (symbol-package (class-name slot-source))))
	      (esc (encode-angle (string (class-name slot-source))))))))

#+cre
(defmethod encode-for-url ((obj expo::express-effective-slot-definition))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (let ((slot-name (string (expo::slot-definition-simple-name obj)))
	  (slot-source (slot-definition-effective-source obj)))
      (format nil "eslot*~A*~A*~A*~A"
	      (esc (package-name (symbol-package slot-name)))
	      (esc slot-name)
	      (esc (package-name (symbol-package (class-name slot-source))))
	      (esc (encode-angle (string (class-name slot-source))))))))

      ;; 2008-03-08: Problem here in that slot-details, when it sees only the 
      ;; slot-definition-source, can't provide the effective slot details, like
      ;; the actual derived union sources. 
(defmethod encode-for-url ((obj mofi::mm-direct-slot-definition))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (let ((slot-name (slot-def-name obj))
	  (slot-source (slot-definition-source obj)))
      (format nil "dslot*~A*~A*~A*~A"
	      (esc (package-name (symbol-package slot-name)))
	      (esc slot-name)
	      (esc (package-name (symbol-package (class-name slot-source))))
	      (esc (encode-angle (string (class-name slot-source))))))))

(defmethod encode-for-url ((obj population))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (format nil "population*~A" (esc (model-name obj)))))

(defmethod encode-for-url ((obj ocl:|Ocl-type-proxy|))
  (format nil "ocl-type-proxy*~A" (ocl:%proxy-name obj)))

(defmethod encode-for-url ((obj ptypes:|Ptype-type-proxy|))
  (format nil "ptype-type-proxy*~A" (ptypes::%proxy-name obj)))

(defmethod encode-for-url ((obj ocl-constraint))
  (macrolet ((esc (v) `(tbnl:url-encode (string ,v))))
    (with-slots (operation-class operation-name) obj
      (format nil "constraint*~A*~A*~A"
	      (esc (model-name (of-model operation-class)))
	      (esc (encode-angle (string (class-name operation-class))))
	      (esc operation-name)))))

(defun decode-for-url (str)
  "Decode to the object it denotes, the argument string encoded by encode-for-url."
  (decode-for-url-meth (kintern (car (split str #\*))) str))

;;; 2010-09-03 I'm guessing. 
(defmethod decode-for-url-meth ((type (eql :ocl-type-proxy)) str)
  (let ((type (second (split str #\*))))
    (find-class (intern type :ocl) nil)))

(defmethod decode-for-url-meth ((type (eql :ptype-type-proxy)) str)
  (let ((type (second (split str #\*))))
    (find-class (intern type :ptypes) nil)))

(defmethod decode-for-url-meth ((type (eql :type)) str)
  (declare (special *models*))
  (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (dbind (model-name class-name) (cdr vals)
	(when-bind (pkg (find-package (tbnl:url-decode model-name)))
	  (find-class (intern (tbnl:url-decode (decode-angle class-name)) pkg ) nil))))))

(defmethod decode-for-url-meth ((type (eql :symbol)) str)
  (let ((vals (split str #\*)))
    (dbind (pkg name) (cdr vals)
      (when-bind (pkg (find-package (tbnl:url-decode pkg)))
	(intern (tbnl:url-decode name) pkg)))))

(defmethod decode-for-url-meth ((type (eql :string)) str)
  (let ((vals (split str #\*)))
    (tbnl:url-decode (second vals))))

(defmethod decode-for-url-meth ((type (eql :model)) str)
  (declare (special *models*))
  (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (find-model (tbnl:url-decode (second vals)) :error-p nil))))

;;; 2010-09-10 eslot/dslot distinction made. Not sure it is useful! (Should have been). 
(defmethod decode-for-url-meth ((type (eql :dslot)) str)
  (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (declare (special *models*))
      (dbind (slot-pkg slot-name class-pkg class-name) (cdr vals)
	(when-bind (pkg (find-package (tbnl:url-decode slot-pkg)))
	  (let ((slot-name (intern (tbnl:url-decode slot-name) pkg))
		(class (find-class (intern (tbnl:url-decode (decode-angle class-name))
					   (mofi:lisp-package (find-model (tbnl:url-decode class-pkg))))
				   nil)))
	    (find slot-name (closer-mop:class-direct-slots class)
		  :key #'slot-def-name)))))))

(defmethod decode-for-url-meth ((type (eql :eslot)) str)
  (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (declare (special *models*))
      (dbind (slot-pkg slot-name class-pkg class-name) (cdr vals)
	(when-bind (pkg (find-package (tbnl:url-decode slot-pkg)))
	  (let ((slot-name (intern (tbnl:url-decode slot-name) pkg))
		(class (find-class (intern (tbnl:url-decode (decode-angle class-name))
					   (mofi:lisp-package (find-model (tbnl:url-decode class-pkg)))))))
	    (find slot-name (closer-mop:class-slots class)
		  :key #'slot-def-name)))))))

(defmethod decode-for-url-meth ((type (eql :population)) str)
  (declare (special *models*))
  (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (find-model (tbnl:url-decode (second vals)) :error-p nil))))

(defmethod decode-for-url-meth ((type (eql :constraint)) str)
  (declare (special *models*))
    (with-vo (session-models)
    (let ((*models* session-models)
	  (vals (split str #\*)))
      (dbind (model-name class-name cname) (cdr vals)
	(when-bind (class (find-class (intern (tbnl:url-decode (decode-angle class-name))
					      (mofi:lisp-package (find-model (tbnl:url-decode model-name))))))
	  (find cname (type-constraints class) :key #'operation-name :test #'string=))))))

(defmethod decode-for-url-meth ((type (eql :menu)) str)
  (let ((vals (split str #\*)))
    (mapcar #'kintern (cdr vals))))

(defmethod decode-for-url-meth ((type (eql :nil)) str)
  (declare (ignore str)) nil)

;;; Very important:
(defmethod decode-for-url-meth ((type t) (str t))
  (declare (ignore type str)) nil)

(defun encode-angle (str)
  "Substitute #\( for #\< and #\) for #\> in STR."
  (with-output-to-string (s)
    (loop for c across str
	  do (cond ((eql #\< c) (write-char #\( s))
		   ((eql #\> c) (write-char #\) s))
		   (t (write-char c s))))))

(defun decode-angle (str)
  "Substitute #\< for #\( and #\> for #\) in STR."
  (with-output-to-string (s)
    (loop for c across str
	  do (cond ((eql #\( c) (write-char #\< s))
		   ((eql #\) c) (write-char #\> s))
		   (t (write-char c s))))))

(defgeneric url-class-browser (obj &key))

;;; POD There really could be two methods for this: one for class, one for slot.
(defmethod url-class-browser :around ((obj t) &key)
  (call-next-method))

;;; This one sets the menu parameter, all others just pick it off the current request.
(defmethod url-class-browser ((class mofi:mm-type-mo) &key force-text menu)
  "Provide href anchored text for CLASS reference." 
  (format nil "<a href='~A/class-view?class=~A~A'>~A</a>"
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url class)
	  (if menu (format nil "&menu=menu*~{~A~^*~}" menu) (menu-from-request))
	  (cl-who:escape-string (or force-text (string (class-name class))))))

#+cre
(defmethod url-class-browser ((class expo:express-entity-type-mo) &key force-text menu)
  "Provide href anchored text for CLASS reference." 
  (format nil "<a href='~A/class-view?class=~A~A'>~A</a>"
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url class)
	  (if menu (format nil "&menu=menu*~{~A~^*~}" menu) (menu-from-request))
	  (cl-who:escape-string (or force-text (string (class-name class))))))

#+cre
(defmethod url-class-browser ((class expo:instantiable-express-entity-type-mo) &key force-text menu)
  "Provide href anchored text for CLASS reference." 
  (format nil "<a href='~A/class-view?class=~A~A'>~A</a>"
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url (find-class (tlog:type-symbol class) nil))
	  (if menu (format nil "&menu=menu*~{~A~^*~}" menu) (menu-from-request))
	  (cl-who:escape-string (or force-text (string (class-name class))))))

#+cre ; I don't want links to these, and there is more to do here, but
(defmethod url-class-browser ((obj expo:data-typ) &key)
  "Provide href anchored text for CLASS reference." 
  (expo:p11-string obj "" :text))

(defun menu-from-request ()
  "Return the menu parameter string, or a null string if none."
  (if (boundp '*request*)
      (if-bind (menu (safe-get-parameter "menu"))
	       (format nil "&menu=~A" menu)
	       "")
      ""))

;;; POD, this one doesn't handle menu yet. It might be worthwhile to replace the ""
;;; in menu-from-request with a value formd from *mof-browser-class-view-menu-structure* 
(defmethod url-class-browser ((slot mofi::mm-direct-slot-definition) &key force-text)
  "Provide href anchored text for class referenced through SLOT (the only open slot), 
   but this method is only called on mof/conditions.lisp."
  (let ((class (slot-definition-source slot)))
    (format nil "<a href='~A/class-view?class=~A&open-slots=~A~A#~A'>~A</a>"
	    (app-url-prefix (find-http-app (safe-app-name)))
	    (encode-for-url class) 
	    (encode-for-url slot)
	    (menu-from-request)
	    (slot-def-name slot)
	    (cl-who:escape-string (or force-text
				      (format nil "~A.~A"
					      (class-name class)
					      (slot-def-name slot)))))))

;;; POD, this one doesn't handle menu yet.
(defmethod url-class-browser ((slot mofi::mm-effective-slot-definition) &key force-text)
  "Provide href anchored text for class referenced through SLOT (the only open slot), 
   but this method is only called on mof/conditions.lisp."
  (let ((class (slot-definition-effective-source slot)))
    (format nil "<a href='~A/class-view?class=~A&open-slots=~A~A#~A'>~A</a>"
	    (app-url-prefix (find-http-app (safe-app-name)))
	    (encode-for-url class) 
	    (encode-for-url slot)
	    (menu-from-request)
	    (slot-def-name slot)
	    (cl-who:escape-string (or force-text 
				      (format nil "~A.~A" 
					      (class-name class)
					      (slot-def-name slot)))))))

(defmethod url-class-browser ((obj ocl:|Ocl-type-proxy|) &key force-text)
  "Ocl-type-proxy is used for things with no browsable internal structure,
   thus return a string."
  (declare (ignore force-text))
  (string (ocl:%proxy-name obj)))
#|  (format nil "<a href='~A/class-view?class=~A~A'>~A</a>" 
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (or force-text
	      (encode-for-url obj))
	  (menu-from-request)
	  (ocl:%proxy-name obj)))|#

(defmethod url-class-browser ((obj ptypes:|Ptype-type-proxy|) &key force-text)
  "Ocl-type-proxy is used for things with no browsable internal structure,
   thus return a string."
  (declare (ignore force-text))
  (string (ptypes::%proxy-name obj)))

#+alf
(defmethod url-class-browser ((obj alfi::|Alf-type-proxy|) &key force-text)
  "Ocl-type-proxy is used for things with no browsable internal structure,
   thus return a string."
  (declare (ignore force-text))
  (string (alfi::%proxy-name obj)))

(defmethod url-class-browser ((obj ocl:ocl-metaclass) &key force-text)
  "Ocl-metaclass is used for things with no browsable internal structure,
   thus return a string."
  (declare (ignore force-text))
  (string (class-name obj)))

#+alf
(defmethod url-class-browser ((obj alfi::alf-metaclass) &key force-text)
  "Ocl-metaclass is used for things with no browsable internal structure,
   thus return a string."
  (declare (ignore force-text))
  (string (class-name obj)))

(defmethod url-class-browser ((obj t) &key (force-text "broken link"))
  (format nil "<a href='~A/class-view'>~A</a>" 
	  (app-url-prefix (find-http-app (safe-app-name))) force-text))

(defun url-object-browser (object &key force-text)
  "Register the OBJECT with the session-vo, and return a URL (string) to the object viewer."
  (let ((app (find-http-app (safe-app-name))))
    (format nil "<a href='~A/object-view?obj-key=~A'>~A</a>"
	    (app-url-prefix app)
	    (funcall (app-url-key-fn app) object)
	    (cl-who:escape-string (or force-text (format nil "~A" object))))))

;;; Added 2012-05-30. The expo method caused me to specialize on slot, and this gets called for both d- and e-.
(defmethod url-property-button (class (slot mofi::mm-effective-slot-definition) &key open-slots image object)
  (when-bind (dslot (find (#-sbcl clos:slot-definition-name #+sbcl slot-definition-name slot) 
			  (closer-mop:class-direct-slots (mofi:slot-definition-source slot))
			   :key #-sbcl #'clos:slot-definition-name #+sbcl #'slot-definition-name))
    (url-property-button class dslot :open-slots open-slots :image image :object object)))

;;; POD It was a mistake to send open-slots everywhere. You can always get it from the request.
(defmethod url-property-button (class (slot mofi::mm-direct-slot-definition) &key open-slots image object)
  "Provide an anchored image to open/close the property details.
    OPEN-SLOTS - a list of strings of other open slots
    IMAGE - either :open or :close
    OBJECT - a 'VOBJ' object key.
    -- Note that image html doesn't look like xml. (Works on firefox, but not IE)."
  (let* ((app (find-http-app (safe-app-name)))
	 (img (case image 
	       (:open  (format nil "<img src='~A/image/down-arrow.png'>" (app-url-prefix app)))
	       (:close (format nil "<img src='~A/image/right-arrow.png'>" (app-url-prefix app)))))
	 (slot-name (slot-def-name slot))
	 (n-examples 2))
    (when-bind (num (safe-get-parameter "examples"))
      (setf n-examples (read-from-string num)))
    (if object 
	(format nil "<a href='~A/object-view?obj-key=~A&open-slots=~{~A~^|~}&examples=~A~A#~A' name='~A'>~A</a>" 
		(app-url-prefix app)
		object 
		(mapcar #'encode-for-url (mapcar #'(lambda (x) (when x (slot-direct-slot x))) open-slots))
		n-examples
		(menu-from-request)
		slot-name slot-name img)
	(format nil "<a href='~A/class-view?class=~A&open-slots=~{~A~^|~}&examples=~A~A#~A' name='~A'>~A</a>" 
		(app-url-prefix app)
		(encode-for-url class)
		(mapcar #'encode-for-url (mapcar #'(lambda (x) (when x (slot-direct-slot x))) open-slots))
		n-examples
		(menu-from-request)
		slot-name slot-name img))))


;;; POD It was a mistake to send open-slots everywhere. You can always get it from the request.
#+cre
(defmethod url-property-button (class (slot expo::express-effective-slot-definition) &key open-slots image object)
  "Provide an anchored image to open/close the property details.
    OPEN-SLOTS - a list of strings of other open slots
    IMAGE - either :open or :close
    OBJECT - a 'VOBJ' object key.
    -- Note that image html doesn't look like xml. (Works on firefox, but not IE)."
  (let* ((app (find-http-app (safe-app-name)))
	 (img (case image 
	       (:open  (format nil "<img src='~A/image/down-arrow.png'>" (app-url-prefix app)))
	       (:close (format nil "<img src='~A/image/right-arrow.png'>" (app-url-prefix app)))))
	 (slot-name (string (expo::slot-definition-simple-name slot)))
	 (n-examples 2))
    (when-bind (num (safe-get-parameter "examples"))
      (setf n-examples (read-from-string num)))
    (if object 
	(format nil "<a href='~A/object-view?obj-key=~A&open-slots=~{~A~^|~}&examples=~A~A#~A' name='~A'>~A</a>" 
		(app-url-prefix app)
		object 
		(mapcar #'encode-for-url (mapcar #'(lambda (x) (when x (slot-direct-slot x))) open-slots))
		n-examples
		(menu-from-request)
		slot-name slot-name img)
	(format nil "<a href='~A/class-view?class=~A&open-slots=~{~A~^|~}&examples=~A~A#~A' name='~A'>~A</a>" 
		(app-url-prefix app)
		(encode-for-url class)
		(mapcar #'encode-for-url (mapcar #'(lambda (x) (when x (slot-direct-slot x))) open-slots))
		n-examples
		(menu-from-request)
		slot-name slot-name img))))


(defun url-ocl-operator (operation)
  "Return anchored text for a CLASS.OPERATOR() reference."
  (let ((op-name (operation-name operation)))
    (format nil "<a href='~A/class-view?class=~A&operator=~A#~A'>~A::~A()</a>" 
	    (app-url-prefix (find-http-app (safe-app-name)))
	    (encode-for-url (operation-class operation))
	    op-name 
	    op-name 
	    (class-name (operation-class operation))
	    op-name)))

(defmethod url-mof-model ((m mofi:population) &key (describe t))
  "Return a URL to bring us in to model browsing. MODEL-NAME is a string designator."
  (format nil "<a href='~A/browse-model?model=~A'>~A</a>~A" 
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url m)
	  (model-name m)
	  (if describe 
	      (if-bind (uri (mofi:href-uri m))
		       (format nil " - a population of ~A referenced as ~A" 
			       (mofi:model-name (mofi:model-n+1 m))uri)
		       (format nil " - a population of ~A" (mofi:model-name (mofi:model-n+1 m))))
	      "")))

(defmethod url-mof-model ((m mofi:user-profile) &key (describe t))
  (format nil "<a href='~A/browse-model?model=~A'>~A</a>~A" 
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url m)
	  (mofi::pretty-name m)
	  (if describe 
	      (format nil " - a user-provided profile referenced as ~A" (mofi:href-uri m))
	      "")))

(defmethod url-mof-model ((m mofi:abstract-profile) &key (describe t))
  (format nil "<a href='~A/browse-model?model=~A'>~A</a>~A" 
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url m)
	  (model-name m)
	  (if describe " - a profile" "")))

(defmethod url-mof-model ((m t) &key (describe t))
  "Return a URL to bring us in to model browsing. MODEL-NAME is a string designator."
  (format nil "<a href='~A/browse-model?model=~A'>~A</a>~A" 
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (encode-for-url m)
	  (model-name m)
	  (if describe " - a metamodel" "")))

(defun url-remove-model (m)
  "URL for qvt pages removal of a model." 
  (format nil "<a href='~A/remove-model?model=~A~A'>&nbsp;&nbsp;Remove</a>"
	  (app-url-prefix (find-http-app (safe-app-name)))
	  (mofb:encode-for-url m)
	  (format nil "&redirect=~A" (tbnl:script-name *request*))))

;;; Arguably, this doesn't belong here. 
;;; http://syseng.nist.gov/se-interop/remove-mode?model=whatever
(defun remove-model-dsp ()
  "Remove a model and redisplay the page."
  (when-bind (redirect (safe-get-parameter "redirect"))
    (when-bind (model (mofb:decode-for-url (safe-get-parameter "model")))
      (with-vo (session-models)
	(setf session-models (remove model session-models))
	(mofi:unintern-model model)))
    (redirect redirect)))

;;;============================================================
;;; Class List
;;;============================================================
(defun mof-model-list-dsp (&key app menu)
  "Display a list of all the objects in the model or metamodel"
  (when-bind (mstr (safe-get-parameter "model"))
    (when-bind (m (decode-for-url mstr))
      (let ((title (format nil "Model ~A" 
			   (typecase m
			     (mofi:user-profile (mofi::pretty-name m))
			     (t (or (car (nicknames m)) (mofi:model-name m)))))))
	(app-page-wrapper (or app (safe-app-name))
	    (:view title :menu-pos (or menu *mof-browser-class-view-menu-structure*))
	  (:h1 (str (format nil "Contents of ~A" title)))
	  (str
	   (with-output-to-string (out)
	     (format out "<ul>")
	     (typecase m 
	       (population 
		(let (#+cre(schema (intern "Schema" (find-package :mexico)))
			#+cre(entity (intern "EntityType" (find-package :mexico))))
		  (mapc #'(lambda (x) (format out "<li>~A</li>" (url-object-browser x)))
			#-cre(coerce (mofi:members m) 'list)
			#+cre(remove-if-not #'(lambda (x) (or (typep x schema) (typep x entity)))
					    (coerce (mofi:members m) 'list)))))
	       (t 
		(mapc #'(lambda (x) (format out "<li>~A</li>" (url-class-browser x)))
		      (sort (coerce (mofi:types m) 'list) #'string< 
				      :key #'(lambda (x) (string (class-name x)))))))
	     (format out "</ul>"))))))))


;;;============================================================
;;; Class View /se-interop/class-view
;;;============================================================
(defun mof-class-view-dsp (&key app)
  "Return html for the browser class or enumeration view page."
  (setf *zippy* (list *request* *acceptor*))
  (let ((class (decode-for-url (safe-get-parameter "class"))) 
	(operator (safe-get-parameter "operator"))
	(menu (decode-for-url (safe-get-parameter "menu")))
	(open-slots  (mapcar #'(lambda (x) (when x (slot-direct-slot x)))
			     (mapcar #'decode-for-url 
				     (split 
				      (safe-get-parameter "open-slots") 
				      #\|)))))
    ;; pod7 specialization at the mm level sure would be nice...
    (when class
      (if (mofi:enum-p class)
	  (mof-class-view--enum class :menu menu :app app) 
	  (mof-class-view--class class operator open-slots :menu menu :app app)))))

(defmethod wrap-class-direct-superclasses ((class t)) (closer-mop:class-direct-superclasses class))
(defmethod wrap-class-direct-superclasses ((class ocl::|Ocl-type-proxy|)) nil)
(defmethod wrap-class-direct-subclasses ((class t)) (closer-mop:class-direct-subclasses class))
(defmethod wrap-class-direct-subclasses ((class ocl::|Ocl-type-proxy|)) nil)
(defmethod wrap-class-precedence-list ((class t)) (closer-mop:class-precedence-list class))
(defmethod wrap-class-precedence-list ((class ocl::|Ocl-type-proxy|)) (list class))

(defparameter *mof-browser-class-view-menu-structure* 
  '(:root :tools :mof-browser)
  "A list of the side-box menu item node names for when the browser page is displayed.")

(defmethod mof-class-view--class ((class mm-type-mo) operator open-slots &key menu app)
  "Return html for the browser class view page, class name CLASS-NAME 
   optional detail for slot OPEN-SLOTS or OPERATOR (but not both)."
  (let ((class-name (class-name class))
	(class-slots (closer-mop:class-slots class))
	(model-name (string (mofi:model-name (mofi:of-model class))))
	(n-examples 2))
    ;; The slots-specified by open-slots are described-by effective-source.
    ;; We need to replace these with the corresponding slot from CLASS. 
    (setf open-slots
	  (loop for s in open-slots
		for new-slot = (when s (find (slot-def-name s) class-slots
					     :key #'slot-def-name))
		when new-slot collect new-slot))
    (app-page-wrapper (or app (safe-app-name))
	(:view (format nil "~A ~A" 
		       (if (mofi:stereotype-p class) "Stereotype" "Class")
		       (cl-who:escape-string (string class-name)))
	       :menu-pos (or menu *mof-browser-class-view-menu-structure*)
	       :leaf 
	       (list (request-uri tbnl:*request*)
		     (elip (format nil "~A::~A"
				   model-name class-name))))
      (htm
       (:h1 (str (pprint-type-name class)))
       (htm (:h3 "Description: "))
       (str (or (documentation class 'type) "")))
      (htm (:p) (:strong "Direct Superclasses: "))
      (str 
       (format nil "~{~A~^, ~}"
	       (mapcar #'url-class-browser 
 		       (remove (find-class 'mofi:mm-root-supertype)
			       (wrap-class-direct-superclasses class)))))
      (when (mofi:stereotype-p class)
	(htm (:p) (:strong "Extended Metaclasses: ")
	     (str 
	      (format nil "~{~A~^, ~}"
		      (mapcar #'url-class-browser (mofi:extended-metaclasses class))))))
      (htm (:p) (:strong "Direct Subclasses: ")
	   (str 
	    (format nil "~{~A~^, ~}"
		    (mapcar #'url-class-browser 
			    (wrap-class-direct-subclasses class)))))
      (unless (stereotype-p class)
	(htm (:p) (:strong "Class Precedence List: "))
	(let ((cpl (wrap-class-precedence-list class)))
	  (str 
	   (format nil "~{~A~^, ~}"
		   (mapcar #'url-class-browser 
			   (subseq cpl 0 (position (find-class 'mofi:mm-root-supertype) cpl)))))))
      (with-vo (mut) 
	(when mut
	  (htm (:h3 "Example objects:"))
	  (when-bind (num (safe-get-parameter "examples"))
	    (setf n-examples (read-from-string num)))
	       (let ((examples (loop for m across (mofi:members mut) with count = 0
				     while (< count n-examples)
				     when (typep m class) collect m and do (incf count))))
		 (if examples
		     (htm (str (format nil "~{~A~^<br/> ~}"
				       (mapcar #'url-object-browser examples)))
			  (str (url-more-examples)))
		     (str " None in the uploaded file.")))))
      (str (pr-attributes class open-slots))
      (str (pr-constraints class operator))
      (str (pr-operations class operator)))))


#+cre
(defmethod mof-class-view--class ((class expo:express-entity-type-mo) operator open-slots &key menu app)
  "Return html for the browser class view page, class name CLASS-NAME 
   optional detail for slot OPEN-SLOTS or OPERATOR (but not both)."
  (let ((class-name (class-name class))
	(class-slots (closer-mop:class-slots class))
	(model-name (string (mofi:model-name (mofi:of-model class)))))
    ;; The slots-specified by open-slots are described-by effective-source.
    ;; We need to replace these with the corresponding slot from CLASS. 
    (setf open-slots
	  (loop for s in open-slots
		for new-slot = (when s (find (slot-def-name s) class-slots
					     :key #'slot-def-name))
		when new-slot collect new-slot))
    (app-page-wrapper (or app (safe-app-name))
	(:view (format nil "Entity Type ~A" 
		       (cl-who:escape-string (string class-name)))
	       :menu-pos (or menu *mof-browser-class-view-menu-structure*)
	       :leaf 
	       (list (request-uri tbnl:*request*)
		     (elip (format nil "~A::~A"
				   model-name class-name))))
      (htm
       (:h1 (str (pprint-type-name class)))
       (htm (:h3 "Description: "))
       (str (or (documentation class 'type) "")))

      (htm (:p) (:strong "Direct Superclasses: "))
      (str 
       (format nil "~{~A~^, ~}"
	       (mapcar #'url-class-browser 
		       (remove (find-class 'expo:entity-root-supertype)
			       (remove-if #'null (mapcar #'(lambda (x) (find-class x nil))
							 (expo::subtype-of class)))))))
      (htm (:p) (:strong "Direct Subclasses: "))
      (str 
       (format nil "~{~A~^, ~}"
	       (mapcar #'url-class-browser 
		       (mapcar #'find-class (expo::subtypes class-name)))))
      (htm (:p) (:strong "Class Precedence List: "))
      (str 
       (format nil "~{~A~^, ~}"
	       (mapcar #'url-class-browser 
		       (mapcar #'find-class (expo::p21-precedence-order class-name)))))
      (str (pr-attributes class open-slots)))))

(defun url-more-examples ()
  "Returns a url with examples= (* 2 what it was)."
  (let ((href 
	 (if (safe-get-parameter "examples") ; prior to 2008-07-15 was get-parameter
	     (mvb (success parts) (cl-ppcre:scan-to-strings "(.+)&examples=(\\d+)(.*)" 
							    (request-uri tbnl:*request*))
	       (if success
		   (format nil "~A&examples=~A~A" 
			   (aref parts 0) 
			   (* 2 (read-from-string (aref parts 1)))
			   (aref parts 2))
		   (request-uri tbnl:*request*)))
	     (format nil "~A&examples=4" (request-uri tbnl:*request*)))))
    (format nil "<a href='~A'>...more</a>" href)))

(defun mof-class-view--enum (enum &key menu app)
  "Return html for the browser enumeration view page."
  (let ((enum-name (class-name enum)))
    (app-page-wrapper (or app (safe-app-name))
	(:view (format nil "Class ~A" enum-name) 
	       :menu-pos (or menu *mof-browser-class-view-menu-structure*))
      (:h1 (str (format nil "Enumeration ~A" enum-name)))
      (:h3 "Description: ")
      (str (or (documentation enum 'type) ""))
      (:p)
      (:br) (:strong "Values:") (:br)
      (str (loop for v in (mofi:enum-values enum) with result = ""
		 do (setf result (strcat result (format nil "<br/>~A" v)))
		 finally (return result))))))

(defmethod pr-constraints ((class ocl::|Ocl-type-proxy|) operator)
  (declare (ignore operator)) "")

(defmethod pr-constraints ((class mofi:mm-type-mo) operator &aux found-p)
  "Chunk of code used in sysml-show-class"
  (with-html-output-to-string (stream)
    (:h3 "Constraints:")
    (when-bind (cs (mofi:type-constraints class))
      (loop for c in cs do
	    (setf found-p t)
	    (with-slots ((name mofi:operation-name) (comment mofi:operation-comment) 
			 (body mofi:operation-body) (original mofi:original-body)
			 (edit mofi:editor-note)) c
	      (when (string-equal name operator) (format stream "<a name=~A></a>" operator))
	      (format stream "<p/><strong>Signature:</strong> ~A() : Boolean;<br/>" name)
	      (format stream "<strong>Description:</strong> ~A<br/>" comment)
	      (when original (format stream "<strong>The OCL used here is not normative.</strong><br/>"))
	      (when edit (format stream "<strong>Editor's notes:</strong> ~A<br/>" edit))
	      (format stream "<strong>Expression:</strong><code> ~A</code>" body)
	      (when original (format stream "<br/><strong>Original:</strong><code> ~A</code>" original)))))
    (unless found-p (str "No additional constraints."))))

(defmethod pr-operations ((class ocl::|Ocl-type-proxy|) operator)
  (declare (ignore operator)) "")

(defmethod pr-operations ((class mofi:mm-type-mo) operator &aux found-p)
  "Chunk of code used in sysml-show-class"
  (with-html-output-to-string (stream)
    (:h3 "Operations:")
    (when-bind (cs (mofi:type-operations class))
      (loop for c in cs do
	    (setf found-p t)
	    (with-slots ((name mofi:operation-name) (comment mofi:operation-comment) 
			 (body mofi:operation-body) (params mofi:operation-parameters)
			 (original mofi:original-body) (edit mofi:editor-note)) c
	      (when (string-equal name operator) (format stream "<a name=~A></a>" operator))
	      (format stream "<p/><strong>Signature:</strong> ~A(~{~A : ~A; ~}) : ~A;<br/>" 
		      name
		      (loop for p in params
			    unless (slot-value p 'mofi:parameter-return-p)
			    collect (slot-value p 'mofi:parameter-name) 
			    and collect (slot-value p 'mofi:parameter-type))
		      (when-bind (r (find-if #'mofi:parameter-return-p params))
			(mofi:parameter-type r)))
	      (format stream "<strong>Description:</strong> ~A<br/>" comment)
	      (when original (format stream "<strong>The OCL used here is not normative.</strong><br/>"))
	      (when edit (format stream "<strong>Editor's notes:</strong> ~A<br/>" edit))
	      (format stream "<strong>Expression:</strong><code> ~A</code>" body)
	      (when original (format stream "<br/><strong>Original:</strong><code> ~A</code>" original)))))
    (unless found-p (str "No additional operations."))))

(defgeneric show-slot (view slot class open-slots &key object &allow-other-keys))

(defmethod pr-attributes ((class ocl::|Ocl-type-proxy|) open-slots)
  (declare (ignore open-slots))
  "")

(defmethod pr-attributes ((class mofi:mm-type-mo) open-slots)
  "Chunk of code used in sysml-show-class. Loops through slots in class precedence, 
   and then alphabetical, order"
  (with-html-output-to-string (stream)
    (htm
     (:h3 "Properties:")
     (loop for slot in (mofi:mapped-slots class) 
	   do (format stream "~A" (show-slot :class-browser slot class open-slots))))))

#+cre
(defun class2iclass (class)
  (expo::find-programmatic-class 
   (list (class-name class)) :allow-partial t))

#+cre
(defmethod pr-attributes ((class expo:express-entity-type-mo) open-slots)
  "Chunk of code used in sysml-show-class. Loops through slots in class precedence, 
   and then alphabetical, order"
  (with-html-output-to-string (stream)
    (htm
     (:h3 "Attributes:")
     (loop for slot in (remove-if #'mofi:slot-definition-xmi-hidden 
				  (clos:class-slots (class2iclass class)))
	   for c = (expo::slot-definition-source slot) 
	   do (format stream "~A" (expo-show-slot :class-browser slot c open-slots))))))

(defmethod show-slot ((view (eql :class-browser)) slot class open-slots &key)
  "Produce html for slot, its multiplicity, source etc."
  (let* ((open-p (member slot open-slots))
	 (source-class (mofi:slot-definition-source slot))
	 (range-class  (mofi:slot-definition-range slot)))
    (with-html-output-to-string (stream) stream
      (htm
       (str (url-property-button class slot
				 :image (if open-p :close :open)
				 :open-slots (if open-p 
						 (remove slot open-slots)
						 (cons slot open-slots))))
       " " (str (slot-def-name slot)) " : "
       (str (if range-class (url-class-browser range-class) "")) " "
       (str (substitute '* -1 (mofi:slot-definition-multiplicity slot)))
       "; -- source " (str (if source-class (url-class-browser source-class) ""))
       (str (if open-p (mof-slot-details slot) ""))
       (:br)))))

#+cre
(defmethod expo-show-slot ((view (eql :class-browser)) slot class open-slots &key)
  "Produce html for slot, its multiplicity, source etc."
  (let* ((open-p (member slot open-slots))
	 (source-class (expo::slot-definition-source slot))
	 (range-class  (expo::slot-definition-range slot)))
    (when (symbolp range-class)
      (when-bind (c (find-class range-class)) (setf range-class c)))
    (with-html-output-to-string (stream) stream
      (htm
       (str (url-property-button class slot
				 :image (if open-p :close :open)
				 :open-slots (if open-p 
						 (remove slot open-slots)
						 (cons slot open-slots))))
       " " (str (string (expo::slot-definition-simple-name slot))) " : "
       (str (if range-class (url-class-browser range-class) "")) " "
       "; -- source " (str (if source-class (url-class-browser source-class) ""))
       (str (if open-p (mof-slot-details slot) ""))
       (:br)))))

(defmethod show-slot ((view (eql :object-browser)) slot class open-slots &key object vobj)
  "Produce html for slot, its multiplicity, source etc."
  (let* ((open-p (member slot open-slots))
	 (range-class  (mofi:slot-definition-range slot)))
    (with-html-output-to-string (stream) stream
      (htm
       (str (url-property-button class slot
				 :image (if open-p :close :open)
				 :open-slots (if open-p 
						 (remove slot open-slots)
						 (cons slot open-slots))
				 :object vobj))
       " " (str (slot-def-name slot)) " : "
       (str (if range-class (url-class-browser range-class) "")) 
       " "
       (str (substitute '* -1 (mofi:slot-definition-multiplicity slot))) 
       " =  "
       (str (mof-pprint (funcall (mofi:mm-accessor-fn-name slot) object)))
       ;; 2008-03-08 -- Don't use the (direct) slot that is only known through its source.
       ;; Rather, use the effective slot on the class of OBJECT.
       (setf slot (find (slot-def-name slot)
			(closer-mop:class-slots (class-of object))
			:key #'slot-def-name :test #'equal))
       (str (if open-p (mof-slot-details slot) ""))
       (:br)))))

(defun mof-slot-details (slot)
  "Print detailed information about the property, for class and object browsers."
  (flet ((pr-dotted (ls) (format nil "~A.~A" (car ls) (cadr ls))))
    (with-html-output-to-string (stream) stream
     (htm
      (:p)
      (str (or (documentation slot 'slot) ""))
      (when-bind (props 
		  (append
		   (when (mofi:slot-definition-is-composite-p slot) (list "<strong>composite</strong>"))
		   (when (mofi:slot-definition-is-readonly-p slot) (list "<strong>readonly</strong>"))
		   (when (mofi:slot-definition-is-ordered-p slot) (list "<strong>ordered</strong>"))
		   (when (mofi:slot-definition-is-derived-p slot) 
		     (unless (mofi:slot-definition-is-derived-union-p slot)
		       (list "<strong>derived</strong>")))))
	(str (format nil "<br/>{~{~A~^, ~}}" props)))
      (when (mofi:slot-definition-is-derived-union-p slot)
	(str (format nil "<br/><strong>Derived union with sources:</strong> (~{~A~^, ~})"
		     (mofi::slot-definition-derived-union-sources slot))))
      (when-bind (subs (mofi:slot-definition-subsetted-properties slot))
	(str (format nil "<br/><strong>Subsets:</strong> ~{~A~^, ~}" (mapcar #'pr-dotted subs))))
      (when-bind (redef (mofi:slot-definition-redefined-property slot))
	(str (format nil "<br/><strong>Redefines:</strong> ~{~A~^, ~}" 
		     (loop while redef collect (pr-dotted (list (pop redef) (pop redef)))))))
      (when-bind (spec (mofi:slot-definition-specializes slot))
	(str (format nil "<br/><strong>Specializes:</strong> ~A" (mapcar #'pr-dotted spec))))
      (when-bind (opp (mofi:slot-definition-opposite slot))
	(str (format nil "<br/><strong>Opposite:</strong> ~A" (pr-dotted opp))))
      (when-bind (default-val (mofi:slot-definition-default slot))
	(str (format nil "<br/><strong>Default value:</strong> ~A" 
		     (if (listp default-val)
			 (format nil "a ~A with value ~A" 
				 (find-if #'stringp (flatten default-val))
				 (last1 default-val))
			 default-val))))
      (when (member (slot-direct-slot slot)
		    (mofi:derived-slots-no-fn (mofi:of-model (mofi:slot-definition-source slot))))
	(str "<br/><strong>The spec does not provide a function to compute this derived property!</strong>"))
      (:br)))))

;;;======================================================================
;;; Object Browser /se-interop/object-view?obj-key=VOBJ123
;;;======================================================================
(defun mof-obj-view-dsp (&key app (menu *mof-browser-class-view-menu-structure*))
  (when-bind (obj-key (safe-get-parameter "obj-key"))
    (with-vo (view-objects)
      (when-bind (obj (gethash obj-key view-objects))
	(let ((open-slots (mapcar #'slot-direct-slot 
				  (mapcar #'decode-for-url 
					  (split 
					   (safe-get-parameter "open-slots") 
					   #\|)))))
	  (app-page-wrapper (or app (safe-app-name))
	      (:view (format nil "Object Browser ~A" obj)
		     :menu-pos menu
		     :leaf (list (request-uri tbnl:*request*)
				 (cond ((listp obj) "a Collection")
				       ((typep obj 'ocl:|Collection|)
					(format nil "a ~A of ~A" 
						(class-name (class-of obj))
						(ocl:base-type (ocl:typ-d obj))))
				       (t (elip (format nil "~A::~A"
							(let ((m (mofi:%of-model obj)))
							  (if (typep m 'mofi:population)
							      (model-name (mofi:model-n+1 m))
							      (model-name m)))
							(class-name (class-of obj))))))))
	    (str (mof-object-browser obj open-slots obj-key))))))))

(defgeneric mof-object-browser (obj &optional open-slots obj-key))

#-sei(defun mofi:perfect-ht (ignore) (declare (ignore ignore)) nil)

(defmethod mof-object-browser ((obj mofi:mm-root-supertype) &optional open-slots obj-key)
  "Produce html for an |Element|, H1 header and everything."
  (let* ((class (class-of obj))
	 (subtitle (format nil "~A ~A" 
			   (car (mofi:nicknames (mofi:model-n+1 (mofi:%of-model obj))))
			   (class-name class))))
    (with-html-output-to-string (stream) stream
      (if (typep (mofi:%of-model obj) 'mofi::tc-population)
	  (htm 
	   (:h1 :style "background-color:lightgreen;"
		 (str (strcat (cl-who:escape-string (format nil "Object ~A" obj))
			      "<br/>"
			      (url-class-browser class :force-text subtitle)))))
	   (htm
	    (:h1 
	     (str (strcat (cl-who:escape-string (format nil "Object ~A" obj))
			  "<br/>"
			  (url-class-browser class :force-text subtitle))))))
      (htm
       (with-vo (mut)
	 (when-bind (results (mofi:processing-results mut))
	   (when-bind (matches (mofi::tc-matches results))
	     (when-bind (perfect-ht (mofi:perfect-ht matches))
	       (when-bind (vobj (gethash obj perfect-ht))
		 (format stream "Corresponding valid.xmi object: ~A" (url-object-browser vobj)))))))
       (:h3 "Properties:")
       (loop for slot in (mapcar #'slot-direct-slot (mofi:mapped-slots class)) do
	     (format stream "~A" (show-slot :object-browser slot class open-slots 
						  :object obj :vobj obj-key)))))))

(defmethod mof-object-browser ((obj ocl:|Collection|) &optional open-slots obj-key)
  "Produce html for a |Collection|, H1 header and everything."
    (with-html-output-to-string (stream) stream
      (if (member-if #'(lambda (x)
			 (and (typep x 'mm-root-supertype)
			      (typep (mofi:%of-model x) 'mofi::tc-population)))
		     (ocl:value obj))
	   (htm 
	    (:h1 :style "background-color:lightgreen;"
		 (str (cl-who:escape-string  (format nil "Collection ~A " obj)))))
	   (htm 
	    (:h1 (str (cl-who:escape-string  (format nil "Collection ~A " obj))))))
       (htm
       (:h3 "Elements:")
       (str
	(loop for val in (ocl::value obj) with result = "[<br/>"
	      do (setf result (strcat result (mof-pprint val) "<br/>"))
	      finally (return (strcat result "]")))))))

(defmethod mof-object-browser ((obj ocl:|Ocl-type-proxy|) &optional open-slots obj-key)
  "Produce html for a |Collection|, H1 header and everything."
  (declare (ignore open-slots obj-key))
  (with-html-output-to-string (stream) stream
      (htm 
       (:h1 (str (cl-who:escape-string  (format nil "Primitive Type OCL::~A"  (ocl:%proxy-name obj))))))))


(defparameter *list-title-fn* #'(lambda (l) (declare (ignore l)) "List")
  "A function of one argument (the list) 
   that the user may specify to describe better the content of the list.")

;;; Useful for models like QVT, where (at least now) I don't do replace
;;; lisp lists with ocl:|Collections
(defmethod mof-object-browser ((obj list) &optional open-slots obj-key)
  "Produce html for a list, H1 header and everything."
    (declare (ignore open-slots obj-key))
    (with-html-output-to-string (stream) stream
      (htm 
       (:h1 (str (cl-who:escape-string  (funcall *list-title-fn* obj))))
       (:h3 "Elements:")
       (str
	(loop for val in obj with result = "[<br/>"
	      do (setf result (strcat result (mof-pprint val) "<br/>"))
	      finally (return (strcat result "]")))))))

;;;=============================
;;; Utilities
;;;=============================
(defgeneric pretty-html (obj)
  (:documentation "Return the object in htm printable form.")
  (:method ((obj string)) obj)
  (:method ((obj symbol)) (string obj))
  (:method ((obj mofi:mm-root-supertype)) 
	   (format nil "'...an instance of ~A'" 
		   (url-class-browser (class-of obj))))
  (:method ((obj t)) obj))

(defun mof-pprint (obj)
  "Print OBJ as html"
  (if (or (get-debugging :data) (not (boundp '*session*)))
      (format nil "~A" obj)
      (typecase obj
	(string (cl-who:escape-string (format nil "'~A'" obj)))
	(list (let ((len (length obj)))
		(if (zerop len) 
		    "null"
		    (url-object-browser 
		     obj :force-text
		     (format nil "<list of ~A elements>" len)))))
	(number (format nil "~A" obj))
	(null "null")
	(keyword (format nil "~A" obj))
	(symbol (format nil "~S" obj))
	(ocl:|Collection| 
	     (if (zerop (length (ocl::value obj))) 
		 "null" 
		 (url-object-browser obj)))
	(mofi:mm-type-mo ; it is a MM object, test data is probably a Profile.
	 (url-class-browser obj :force-text (format nil "~A" obj)))
	(t (url-object-browser obj)))))

(defgeneric pprint-type-name (type))

(defmethod pprint-type-name ((type mofi:mm-type-mo))
  "Prints the title of a page describing a type."
    (format nil "~A ~A ~A::~A"
	    (if (mofi:abstract-p type) "Abstract" "")
	    (cond ((mofi:enum-p type) "Enumeration")
		  ((mofi:datatype-p type) "Data Type")
		  ((mofi:primitive-type-p type) "Primitive Type")
		  ((mofi:stereotype-p type) "Stereotype")
		  (t "Class"))
	    (or (car (mofi:nicknames (mofi:of-model type)))
		(package-name (symbol-package (class-name type))))
	    (cl-who:escape-string (string (class-name type)))))

#+cre
(defmethod pprint-type-name ((type expo:express-entity-type-mo))
  "Prints the title of a page describing a type."
  (format nil "~A ~A ~A"
	  (if (mofi:abstract-p type) "Abstract" "")
	  "Entity Type"
	  (cl-who:escape-string (string (class-name type)))))


  


