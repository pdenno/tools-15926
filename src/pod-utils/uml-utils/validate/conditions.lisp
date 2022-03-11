
;;; Purpose: Defines conditions raised by XMI parsing, UML Validation and model-diff. 

;;; THERE IS PROBABLY A SIMPLER APPROACH: STORE THE URL IN THE CONDITION!

(in-package :mofi)

#-iface-http(defun mofb:url-object-browser (obj) obj)
#-iface-http(defun mofb:url-class-browser (obj) obj)
#-iface-http(defun mofb:url-ocl-operator (obj) obj)

(defgeneric unique-errors (type conditions))
(defgeneric url-xmi-example (type keys))
(defgeneric condition-details (type unique-ht stream &key &allow-other-keys))
#-moss(defgeneric validation-details (warning-type classes conditions))

(defmethod condition-details (type conditions stream &key) "")

(defmethod unique-errors ((type T) conditions)
  "This one is probably just used during development."
  (let ((unique-ht (make-hash-table :test #'equal)))
    (loop for c across conditions
	  when (typep c type) do 
	  (setf (gethash (list c) unique-ht) (list c)))
    unique-ht))

;;; pod7 These might belong in the application.
#-moss(defmethod validation-details ((warning-type (eql 'mof-warning)) classes conditions)
  "Generate the detailed html string for the condition type, WARNING-TYPE."
  (if-bind (errs (remove-if-not #'(lambda (c) (typep c 'mof-warning)) conditions))
	   (with-output-to-string (out)
	     (format out "<h2>General Errors</h2><hr/>")
	     (mapcar #'(lambda (c) 
			 (condition-details (class-name c) (unique-errors (class-name c) errs) out))
		     classes))
	   ""))

#-moss(defmethod validation-details ((warning-type (eql 'mof-diff-warning)) classes conditions)
  "Generate the detailed html string for the condition type, WARNING-TYPE."
  (if-bind (errs (remove-if-not #'(lambda (c) (typep c 'mof-warning)) conditions))
	   (with-output-to-string (out)
	     (format out "<h2>Differences to Test Case Valid.xmi</h2><hr/>")
	     (mapcar #'(lambda (c)
			 (condition-details (class-name c) (unique-errors (class-name c) errs) out))
		     classes))
	   ""))

#-moss(defmethod validation-details ((warning-type t) classes conditions)
  "Generate the detailed html string for miscellaneous condition types."
  (if-bind (errs (remove-if (complement #'(lambda (c) (typep c warning-type))) conditions))
	   "<strong>No report available (it is under construction).</strong>"
	   ""))

;;; The idea of the unique-errors macro is that it arranges to store hashtable values
;;; on a tbnl:session-value named by the type-name. The hash-table is keyed
;;; by components classifying the error. All errors fitting that classifcation
;;; are stored with the key. (Should have been called 'def-keyed-errors')
#+:iface-http
(defmacro def-unique-errors (type-name (&key key (url-prefix "/validator/xmi-example")) &body body)
  "KEY is a list whose components identify the error type.
   URL-PREFIX is used to customize the URL to the application (MOSS, SEI, etc.)"
  (let ((slot-converters (mapcar #'(lambda (k) (if (atom k) k (car k))) key))
	(key-converters (mapcar #'(lambda (k) (if (atom k) k (cadr k))) key)))
    `(progn
      (defmethod unique-errors ((type (eql ',type-name)) conditions)
	"Populate a ht with errors where each ht value is a list of errors for a given key."
	(let ((unique-ht (make-hash-table :test #'equal)))
	  (loop for c across conditions
		when (typep c ',type-name) do 
		(with-slots ,slot-converters  c
		  (push c (gethash (list ,@key-converters) unique-ht))))
	  (with-vo (phttp:error-reports)
	    (setf (gethash ',type-name phttp:error-reports) unique-ht))
	unique-ht))
      (defmethod url-xmi-example ((type (eql ',type-name)) key)
	"Return a URL to xmi-example. URL parameters are key and type."
	(strcat
	 (format nil "<a href='~A~A?key=~{~A~^|~}&type=~A'>"  
		 (app-url-prefix (find-http-app (safe-app-name)))
		 ,url-prefix
		 (mapcar #'encode-for-url key)
		 ',type-name)
	 (format nil "View Instance 1</a>")))
      (defmethod condition-details ((type (eql ',type-name)) unique-ht stream &key)
	(when (> (hash-table-count unique-ht) 0)
	  (format stream "<h3>~A (~A)</h3>" (get :title ',type-name)
		  (loop for v being the hash-value of unique-ht sum (length v)))
	  (if (= 1 (hash-table-count unique-ht))
	      (format stream "<strong>There is only one form of this error:</strong>")
	      (format stream "<strong>There are ~A variations of this error:</strong>" 
		      (hash-table-count unique-ht)))
	  (format stream "<br/>")
	  (loop for key being the hash-key of unique-ht using (hash-value errs)
	     do (dbind ,slot-converters  key 
		  (format stream "<p/>~A instances of this:<br/>" (length errs))
		  (format stream "~A" (strcat ,@body))
		  (format stream "<br/>~A" (url-xmi-example type key)))))))))

;;; Should have been called 'one-form-errors"
(defmacro def-combine-errors (type-name &body body)
  `(progn
     (defmethod unique-errors ((type (eql ',type-name)) conditions)
       "Populate a ht with errors where each ht value is a list of errors for a given key."
       (let ((unique-ht (make-hash-table :test #'equal)))
	 (loop for c across conditions
	       when (typep c ',type-name) do 
	       (push c (gethash :one-key unique-ht)))
	 (with-vo (phttp:error-reports)
	   (setf (gethash ',type-name phttp:error-reports) unique-ht))
	 unique-ht))
    (defmethod url-xmi-example ((type (eql ',type-name)) keys)
      "Return a URL to xmi-example. URL parameters are keys and type."
      (declare (ignore keys))
       (strcat
	(format nil "<a href='~A/validator/xmi-example?one-key=true&type=~A'>" 
		 (app-url-prefix (find-http-app (safe-app-name)))
		 ',type-name)
	"View Instance 1</a>"))
    (defmethod condition-details ((type (eql ',type-name)) unique-ht stream &key)
      (when (> (hash-table-count unique-ht) 0)
	(format stream "<h3>~A (~A)</h3>" (get :title ',type-name)
		(loop for v being the hash-value of unique-ht sum (length v)))
	(format stream "<strong>There is only one form of this error:</strong>")
	(format stream "<br/>")
	(format stream "<p/>~A instances of this:<br/>" (length (gethash :one-key unique-ht)))
	(format stream "~A" (strcat ,@body))
	(format stream "<br/>~A" (url-xmi-example type nil))))))

;;;==========================================
;;; Conditions
;;;==========================================
;;; POD May want to expand this so that it can do things without use of clos. 
;;; (LW uses clos for conditions, but it isn't required.)
(defparameter *mofi-all-conditions* nil "A list of condition names.")

;;; Put properties :report, :title, :id-num :explanation on the symbol. 
(defmacro defcondition (name superclasses slots &rest options)
  `(progn
     (pushnew ',name *mofi-all-conditions*)
     (define-condition ,name ,superclasses ,slots
       (:documentation ,(cadr (assoc :documentation options)))
       (:report ,(cadr (assoc :report options))))
     (setf (get :report ',name) ,(cadr (assoc :report options)))
     (setf (get :title ',name) ,(cadr (assoc :title options)))
     (setf (get :id-num ',name) ,(or (cadr (assoc :id-num options)) 1000))
     (setf (get :explanation ',name) ,(cadr (assoc :explanation options)))
     (export ',name)))

(defcondition mof-error (error) 
  ()
  (:documentation "Abstract condition. Superclass of some others here.")
  (:report 
   (lambda (arg stream) 
     (format stream "Generic mof-error (should not occur): ~A." arg))))

(defcondition mof-warning (simple-warning) 
  ((object :initarg :object :initform nil)
   (elem :initarg :elem :initform nil)
   #+sbcl(reporter-function :initarg :report :initform nil)
   (red-regex :initform nil))
  (:documentation "Abstract condition. Superclass of others here.")
  (:report
   (lambda (arg stream) 
     (format stream "Generic mof-warning (should not occur): ~A." arg))))

(defmethod initialize-instance :around ((c mof-warning) &key)
  "The original xml object will be transformed to canonical;
   this saves a serialization of the element as it appears 
   before transformation."
  (call-next-method)
  #+sbcl(setf (slot-value c 'sb-kernel::format-control) (get :report (class-name (class-of c)))) ; 2019
  (with-slots (elem object) c
    (when-bind (node (or elem (and (typep object 'mm-root-supertype) (mofi:%source-elem object))))
      (setf (slot-value c 'elem) 
	    (let ((*print-pretty* t))
	      (with-output-to-string (str) (xml-write-node node str)))))))

(defgeneric xml-copy-elem (obj))

(defmethod xml-copy-elem (obj) obj)

(defcondition tool-limitation (simple-warning) 
  ()
  (:documentation "Abstract condition. Reports on a limitation 
   of this validation tool's capabilities.")
  (:report
   (lambda (arg stream) 
     (format stream "Generic tool-limitation (should not occur): ~A." arg))))

;;;====================
;;; mof-warnings types
;;;====================
;;;---- id-num 1 ----------------------
(defcondition mof-object-ref-not-found (mof-warning)
  ((xmi-idref :initarg :xmi-idref)
   (class :initarg :class)
   (slot :initarg :slot))
  (:id-num 1)
  (:title "Referent not found")
  (:documentation "An object referenced was not found in the file.")
  (:explanation
   "An object, in reference to one of its properties, names a referent
    that was not provided in the exchange file. 
    <p/>This error is reported in post-processing of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (xmi-idref object slot red-regex) c
        (setf red-regex (format nil "(~A)" (string xmi-idref)))
	(format stream "The referent to object ~A property  ~A.~A does not exist. <br/> Name referenced is  <code>~A</code>." 
		(mofb:url-object-browser object)
		(cl-who:escape-string (string (class-name (class-of object))))
		(cl-who:escape-string (string (closer-mop:slot-definition-name slot)))
		xmi-idref)))))

(def-combine-errors mof-object-ref-not-found
  (format nil "Object detail is provided through an unresolved xmi:id reference."))

;;;---- id-num 1.12 ----------------------
;;; POD fix this to use nicknames for models.
(defcondition mof-unresolvable-uri (mof-warning)
  ((xmi-href :initarg :xmi-href :initform nil))
  (:id-num 1.12)
  (:title "Unresolved URI used for object identification")
  (:documentation "The XMI uses a URI the Validator cannot resolve")
  (:explanation 
   "XMI allows reference to objects defined in external files. Reference to these
    objects is provided by URIs. This method of reference is typically 
    used to refer to the standard UML Stereotypes, objects in a Profile, 
    or in the case that the test data is a meta-model, UML itself. 
    Standard URIs are associated with the aforementioned specifications. The URI used
    in the case where this error was signaled was not a standard URI known to
    the Validator. URLs for models known to the validator can be found
    <a href='/se-interop/tools-overview#preloads'>here</a>. <p/>You can use the 'Load Metamodels' menu
    item on the left to load models and specify the URI by which they should be dereferenced.")
  (:report
   (lambda (c stream)
     (with-slots (object xmi-href red-regex) c
       (setf red-regex (format nil "(~A)" (string xmi-href)))
       (format stream "Object detail of ~A is provided through unresolved URI: ~A. <br/>
                       Note: You can use the 'Load Metamodels' menu item on the left to load models and specify 
                       the URI by which they should be dereferenced."
	       (mofb:url-object-browser object) xmi-href)))))

#+iface-http
(def-combine-errors mof-unresolvable-uri
  (format nil "Object detail is provided through an unresolved URI reference."))

;;;---- id-num 1.13 ----------------------
(defcondition mof-href/mut-version-mismatch (mof-warning)
  ((xmi-href :initarg :xmi-href :initform nil))
  (:id-num 1.13)
  (:title "XMI href version mismatch")
  (:documentation "An XMI href dereferences to a primitive type or element in a version of UML other than that of the model.")
  (:explanation
   "XMI allows reference to primitive types and elements using href syntax. (See the XMI spec.) In the case of
    the subject XMI element, the reference appears to be to something in UML, but not in the version of UML declared for the model.
    For example, the model declares to be a UML 2.5 model but this href is to something in UML 2.4.1.")
  (:report
   (lambda (c stream)
     (with-slots (object xmi-href red-regex) c
       (setf red-regex (format nil "(~A)" (string xmi-href)))
       (format stream "Object detail of ~A is provided through an XMI href: ~A. <br/>That object belongs to 
                       a version of UML other than the one declared for the model. <br/>"
	       (mofb:url-object-browser object) xmi-href)))))

#+iface-http
(def-combine-errors mof-href/mut-version-mismatch
  (format nil "The XMI references a primitive type or uml:Element whose version is not that of the model."))

;;;---- id-num 2 ----------------------
(defcondition mof-set-values-not-unique (mof-warning)
  ((set :initarg :set :initform nil)
   (class :initarg :class :initform nil)
   (slot  :initarg :slot :initform nil))
  (:id-num 2)
  (:title "Set members not unique")
  (:documentation "The members of a Set are not unique.")
  (:explanation
   "The Model, or some OCL that was executed against it, created an ocl:Collection of
    type ocl:Set that has at least two identical members.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot set) c
	(format stream "The Collection ~A, declared to be a Set, and found in ~A.~A (object ~A), 
                        has non-unique members."
		(mofb:url-object-browser set)
		(class-name class) 
		(closer-mop:slot-definition-name slot)
		(mofb:url-object-browser object))))))

#+iface-http
(def-unique-errors mof-set-values-not-unique (:key (class slot)) ()
  (progn (declare-ignore class) "")
  (format nil "The member of the declared Set ~A are not unique."
	  (mofb:url-class-browser slot)))

;;;---- id-num 3 ----------------------
(defcondition mof-missing-mandatory (mof-warning)
  ((class :initarg :class)
   (slot :initarg :slot))
  (:id-num 3)
  (:title "Missing mandatory value")
  (:documentation "A property of the object doesn't specify a value where one is required.")
  (:explanation 
   "The property of the object doesn't specify a value where, because of the defined 
    multiplicity of the property, one is required. Where this error is reported, the 
    'lower' multiplicity is 1 or more. This error report is also produced when a value was 
    provided as a reference to an xmi:id, but the file did not contain the referent. 
    There will be an additional error report to this effect if there was no referent 
    ('Referenced object not found'). 
    <p/>This error is identified during structural validation of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot) c
       (declare (ignore class))
       (format stream "Object ~A, value not specified for mandatory attribute ~A" ; 2013-12-07 was ~A.~A
	       (mofb:url-object-browser object) 
	       ;;(class-name class) ; 2013-12-07
	       ;;(closer-mop:slot-definition-name slot) ; 2013-12-07
	       (mofb:url-class-browser slot)))))) ; 2013-12-07 added browser

#+iface-http
(def-unique-errors mof-missing-mandatory (:key (class slot))
  (progn (declare-ignore class) "")
  (format nil "~A" (mofb:url-class-browser slot))
  (format nil " requires a value be specified. None was."))

#| This is probably useless. If there is no derivation, it will throw.
;;;---- id-num 3.5 ----------------------
(defcondition mof-missing-mandatory-but-derived (mof-warning)
  ((class :initarg :class)
   (slot :initarg :slot))
  (:id-num 3.5)
  (:title "Missing mandatory value (spec does not provide derivation)")
  (:documentation "A property of the object doesn't specify a value where one is required.")
  (:explanation 
   "The property of the object doesn't specify a value where, because of the defined 
    multiplicity of the property, one is required. <strong>However</strong>, the 
    specification declares that this value is to be derived, but doesn't provide
    the derivation. So it is not your fault (unless you helped to write the spec ;^).
    <p/>This error is identified during structural validation of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot) c
	(format stream "Object ~A, value not specified for mandatory, but derived, attribute ~A.~A"
		(mofb:url-object-browser object) 
		(class-name class) 
		(closer-mop:slot-definition-name slot))))))

#+iface-http
(def-unique-errors mof-missing-mandatory-but-derived (:key (class slot))
  (progn (declare-ignore class) "")
  (format nil "~A" (mofb:url-class-browser slot))
  (format nil " requires a value be specified. None was."))
|#


;;;---- id-num 4 ----------------------
(defcondition mof-class-not-found (mof-warning)
  ((class-name :initarg :class-name))
  (:id-num 4)
  (:title "No class with name specified")
  (:documentation "No class with the name specified exists in the metamodel.")
  (:explanation
   "The read XMI file references by name a class that is not found in the metamodel.
    <p/>This error is identified while the XMI file is being read.")
  (:report 
   (lambda (c stream) 
     (with-slots (class-name) c
	(format stream "~A is not defined in any metamodel within scope." class-name)))))

#+iface-http
(def-unique-errors mof-class-not-found (:key (class-name))
  (format nil "Class <code>~A</code> not found." class-name))

;;;---- id-num 5 ----------------------
(defcondition mof-no-such-attr (mof-warning)
  ((class :initarg :class)
   (slot-name :initarg :slot-name)
   (useless))
  (:id-num 5)
  (:title "Property not found")
  (:documentation "The class of the object does not define the property specified.")
  (:explanation
   "The XMI defining an object appears to be naming a property of the object, that name
    appears as either the name of an XML attribute or the name of a child element. 
    But the class of this object does not define a property by that name. 
    <p/>This error is identified during instantiation of objects from the XMI exchange file.")
  (:report
   (lambda (c stream)
     (with-slots (class slot-name red-regex) c
       (setf red-regex (format nil "(~A=)" slot-name))
       (format stream "~A does not have a property ~A." 
	       (mofb:url-class-browser class) slot-name)))))

#+iface-http
(def-unique-errors mof-no-such-attr (:key (class slot-name)) ()
  (format nil "~A does not have a property ~A." 
	  (mofb:url-class-browser class) slot-name))

;;;---- id-num 6 ----------------------
(defcondition mof-cannot-infer-type (mof-warning)
  ((class :initarg :class)
   (slot  :initarg :slot))
  (:id-num 6)
  (:title "Cannot infer class of object")
  (:documentation "The processor cannot infer the type implied.")
  (:explanation 
   "The XMI specification, clause 6.4.2, section 2g, states <em>If the class of the object cannot
    be determined unambiguously from the model, you must specify the class using the</em> 
    <code>type</code><em> attribute.</em> 
    In the situation being reported, <code>xmi:type</code> was not specified, so some inference
    of what is intended is required. 
    However, the spec doesn't elaborate on how one should determine the class. The approach 
    taken by the Validator is to consider the declared type of the property of the object 
    (the object triggering the error report). If that type has subtypes, then there is apparently
    no straightforward way to know which of those subtypes was intended. Thus the error report.
    <p/>The error is identified during instantiation of objects from the XMI. 
    The error might be better classified as an XMI error, but it is not so classified now.")
  (:report
   (lambda (c stream)
     (with-slots (class slot) c
	(format stream "Cannot infer type (XMI rule 2g) in ~A.~A" 
		(class-name class)
		(closer-mop:slot-definition-name slot))))))

#+iface-http
(def-unique-errors mof-cannot-infer-type (:key (class slot)) ()
  (progn (declare-ignore class) "") ;; POD!!!
  (format nil "The type of property ~A allows subclasses.<br/>"
	  (mofb:url-class-browser slot))
  (format nil "The intended class should have been specified."))

;;;---- id-num 7 ----------------------
(defcondition mof-violates-multiplicity (mof-warning)
  ((class :initarg :class)
   (slot :initarg :slot))
  (:id-num 7)
  (:title "Multiplicity violation")
  (:documentation "The value of a property violates the multiplicity constraint 
   of the property.")
  (:explanation  "The value of a property violates the multiplicity constraint 
   of the property. The required multiplicity (i.e. cardinality) is declared in 
   the UML metamodel. This error report is also produced when a value was 
   provided as a reference to an xmi:id, but the file did not contain the referent. 
   There will be an additional error report to this effect if there was no referent 
   ('Referenced object not found'). <p/>This error is reported in post-processing 
   of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot) c
	 (format stream "The cardinality of property ~A of object ~A is in violation of
                        its multiplicity constraint."
		 (mofb:url-class-browser slot)
		 (mofb:url-object-browser object)
		 (if-bind (model (of-model class))
			  (if (member slot (derived-slots-no-fn model))
			      "<br/><strong>The spec does not provide a function to compute  
                                 this derived property!</strong>"
				"")
			  ""))))))

#+iface-http
(def-unique-errors mof-violates-multiplicity (:key (class slot))
  (progn (declare-ignore class) "") ;; POD!!!
  (format nil "The value of ~A violates the multiplicity of this property." 
	  (mofb:url-class-browser slot)))

;;;---- id-num 8 ----------------------
(defcondition mof-violates-type (mof-warning)
  ((class :initarg :class)
   (slot  :initarg :slot)
   (slot-range :initarg :slot-range)
   (value :initarg :value)
   (value-type :initarg :value-type))
  (:id-num 8)
  (:title "Type violation")
  (:documentation "The value of a property is incompatible with its declared type.")
  (:explanation 
   "The value provided is not of the type required by the class declaring the property. 
    <p/>This error is reported in post-processing of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot value slot-range) c
	(format stream "Object ~A, property ~A.~A value ~S is not a ~A."
		(mofb:url-object-browser object) 
		(class-name class)
		(closer-mop:slot-definition-name slot)
		value 
		(mofb:url-class-browser slot-range)))))) ; 2013-11-27 I added url-class-browser. Is that OK?

             
;;; errs is a list of conditions for a given key value. --- POD 2009 HUH? Where is it defined?
;;; This is the key: (class-name attr-name attr-range value-type) 
;;; slot-range is a symbol
;;; The arguments to def-unique-errors are of 2 form 
;;;   1 - symbol which is both the slot on condition and the key component
;;;   2- (slot-on-condition form-on-slots-of-condition) where the slot-on-condition
;;;      is used in (with-slots (s-o-c) c just as in (1), but where the key value
;;;      in the hash-table attached to the session-value (e.g. 'mof-violates-type)
;;;      is the form provided by form-on-slots-on-condition. 
;;;      Thus below there is a slot 'class' and a key component associated is
;;;      (class-name class). 
#+iface-http
(def-unique-errors mof-violates-type (:key 
                                      (class           ;; This...
				       slot            ;; ...is..
				       slot-range      ;; ...a.. 
				       value-type))     ;; ...key. (cdr if applicable).
  (progn (declare-ignore value-type) (declare-ignore class) "") ; These variables are needed for the key only.
  (format nil "Property ~A (declared type ~A) has value ~A."
	  ;; Confusing, but as it shows above, the value is the slot name, now we need the slot...
	  (mofb:url-class-browser slot)
	  (mofb:url-class-browser slot-range)
	  (mofb:pretty-html (slot-value (car errs) 'value)))
  ;; pod7 this really ought to be enum-p
  (if-bind (e-vals (enum-values slot-range))
      (format nil "<br/>~A is an enumeration with values ~{~A~^, ~}." 
	      (mofb:url-class-browser slot-range)
	      e-vals)
      ""))

(defmethod print-object ((obj mof-no-such-attr) stream)
  (with-slots (class slot-name) obj
     (format stream "#<mof-no-such-attr ~A.~A>" (class-name class) slot-name)))

;;;---- id-num 8.5 ----------------------
(defcondition mof-no-object-for-stereotyping (mof-warning)
  ((id :initarg :id)
   (attr-name :initarg :attr-name))
  (:id-num 8.5)
  (:title "No object for stereotyping")
  (:documentation "The object to be extended by the stereotype, referenced by its xmi:id, could not be found.")
  (:explanation
   "This error is reported when the system failed to find the object being extended
    by a stereotype included in the XMI. The object referenced through the 'base_ XMI attribute' 
    does not exist.")
  (:report
   (lambda (c stream)
     (with-slots (object id attr-name red-regex) c
       (cond (id
	      (setf red-regex (format nil "(~A)" (string attr-name)))
	      (format stream "The object referenced through ~A (ref ~A) is not present in the file." attr-name id))
	     (t (format stream "The object referenced through the 'base_' attribute is not present in the file.
		<br/>The types that may be extended are: ~{~A~^ ~}."
			(mapcar #'(lambda (x) (subseq x 5))
				(stereotype-base-names (class-of object))))))))))

#+iface-http
(def-combine-errors mof-no-object-for-stereotyping
  (format nil "No metaclass for stereotyping object."))


;;;---- id-num 8.6 ----------------------
(defcondition mof-invalid-sterotype-application (mof-warning)
  ((stereo-object :initarg :stereo-object))
  (:id-num 8.6)
  (:title "Invalid stereotype application (object type)")
  (:documentation "The object to be extended by the stereotype is not of a type that can be
   extended by the stereotype.")
  (:explanation
   "This error is reported when the a stereotype is applied to an object that is not of a type
    declared by the profile as valid for application of the stereotype.")
  (:report
   (lambda (c stream)
     (with-slots (object stereo-object) c
       (format stream "The stereotype ~A is not valid for type ~A."
	       (class-of stereo-object) (class-of object))))))

#+iface-http
(def-combine-errors mof-duplicate-sterotype-application
  (format nil "Duplicate stereotype application"))

;;;---- id-num 8.65 ----------------------
(defcondition mof-duplicate-sterotype-application (mof-warning)
  ((duplicates :initarg :duplicates))
  (:id-num 8.65)
  (:title "Stereotype applied multiple times")
  (:documentation "The same type of stereotype is applied multiply to the object.")
  (:explanation
   "This error is reported when an attempt is made to apply a type of stereotype that has already been 
    applied to the object.")
  (:report
   (lambda (c stream)
     (with-slots (object duplicates) c
       (format stream "The object ~A is subject to multiple application of the same stereotype: ~%~{~A~%~}"
	       (mofb:url-object-browser object)
	       duplicates)))))

#+iface-http
(def-combine-errors mof-duplicate-sterotype-application
  (format nil "Duplicate stereotype application"))


;;;---- id-num 8.7 ----------------------
(defcondition mof-stereotype-application-in-model (mof-warning)
  ()
  (:id-num 8.7)
  (:title "Stereotype applied within uml:Model")
  (:documentation "The file contains XMI elements from a stereotype inside the uml:Model XML element.")
  (:explanation "Stereotypes must be applied outside the model. Typically this is achieved by 
                 the file containing a xmi:xmi object that contains both the uml:Model and the stereotype 
                 applications. 
           <p>This error is identified while the XMI is being read. The stereotype is applied despite
               despite being in the wrong place in the file.")
  (:report
   (lambda (c stream)
     (declare (ignore c))
     (format stream "The XML element shown below was found inside the XML element defining the uml:Model."))))

#+iface-http
(def-combine-errors mof-stereotype-application-in-model
  (format nil "XML elements used to apply a stereotype were found inside XMI for uml:Model."))



;;;---- id-num 9 ----------------------
(defcondition mof-creates-abstract-class (mof-warning)
  ((class :initarg :class))
  (:id-num 9)
  (:title "Creation of abstract class")
  (:documentation "Direct creation of an instance of an abstract class is implied.")
  (:explanation
   "This error is reported when the file references an object type that is
    defined in the metamodel as abstract. <p/>This error is identified during instantiation
    of objects from the XMI exchange file.")
  (:report
   (lambda (c stream)
     (with-slots (class object) c
	(format stream "The class ~A of object ~A is abstract." 
		(mofb:url-class-browser class)
		(mofb:url-object-browser object))))))

#+iface-http
(def-unique-errors mof-creates-abstract-class (:key (class)) ()
  (format nil "The class ~A is abstract." (mofb:url-class-browser class)))

;;;---- id-num 10 ----------------------
(defcondition ocl-violation (mof-warning)
  ((constraint :initarg :constraint :initform nil))
  (:id-num 10)
  (:title "OCL constraint violation")
  (:documentation "The evaluation of an OCL constraint against the object returned ocl:False.")
  (:explanation
   "The evaluation of an OCL constraint against the object identified returned ocl:False. 
    This is the error correctly reported when the OCL is valid but, in the manner defined
    by that OCL code, your model isn't. Identifying what it is about your exchange file
    that the the OCL is objecting to is a typical debugging exercise, and due to the 
    lack of debugging tools, can be hard to grasp. If you can't see the problem, send a note 
    to xmi-interop@omg.org.
    <p/>
    Whether or not processors will behave 
    properly when faced with OCL constraint violations depends on the details of the constraint. 
    <p/>
    <strong>Note:</strong> Unfortunately, many of the constraints described in the 
    text of the specifications (particularly in SysML and UML Activities) have not been 
    coded in OCL. If we find it useful, we will write the relevant OCL.")
  (:report
   (lambda (c stream)
     (with-slots (object constraint) c
       (format stream "Evaluation of OCL Constraint ~A on object ~A returned ocl:False."
	       (mofb:url-ocl-operator constraint)
	       (mofb:url-object-browser object))))))

#+iface-http
(def-unique-errors ocl-violation (:key (constraint)) ()
  (format nil "The constraint ~A was violated."  
	  (mofb:url-ocl-operator constraint)))


;;;---- id-num 11 ----------------------
;;; This is a wrapper for more specific errors (of type ocl-error) found in ocl/conditions.
(defcondition ocl-execution-error (mof-warning)
  ((constraint :initarg :constraint :initform nil)
   (lisp-error :initarg :lisp-error :initform nil))
  (:id-num 11)
  (:title "OCL execution errors")
  (:documentation "There was an error while executing OCL code.")
  (:explanation 
   "There was an 'exceptional situation' (e.g. program exception) while evaluating OCL code.
    The source of this error may be a bug with the Validator, but it might also be due to a 
    bug in the metamodel's (or profile's) OCL code. It might even be due to a fault in the
    XMI exchange file being processed. (Every effort has been made to eliminate this last source.)
    Detailed explanation of these errors in not yet provided because the explanations are so various
    and can be complex. If you are really interested, ask xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (object constraint lisp-error) c
	(format stream "Evaluation of OCL Constraint ~A:~A on object ~A produced exception ~A."
		(operation-class constraint) (operation-name constraint) object
		(cl-who:escape-string (format nil "~A" lisp-error)))))))

(defcondition ocl-type-error-report (mof-warning)
  ((constraint :initarg :constraint :initform nil)
   (lisp-error :initarg :lisp-error :initform nil))
  (:id-num 11.4)
  (:title "OCL type error")
  (:documentation "There is an error in the metamodel causing a type exception.")
  (:explanation 
   "Type checking during execution of an OCL constraint caused an exceptional situation
    where the type of an operand provided to an operator was incorrect. The source
    of this error is almost always in the metamodel OCL itself. Users should not worry about these.")
  (:report
   (lambda (c stream)
     (with-slots (object constraint) c
	(format stream "Evaluation of OCL Constraint ~A:~A on object ~A produced a type exception."
		(operation-class constraint) (operation-name constraint) object)))))


;;; pod7 new
;;;---- id-num 11.5 ----------------------
(defcondition ocl-error-calculating-derived (mof-warning)
  ((class-name :initarg :class-name :initform nil)
   (reader-name :initarg :reader-name :initform nil)
   (lisp-error :initarg :lisp-error :initform nil))
  (:id-num 11.5)
  (:title "OCL errors while evaluating a derived attribute")
  (:documentation "There was an error while executing OCL that provides the value of a derived attribute.")
  (:explanation 
   "There was an 'exceptional situation' (e.g. program exception) while evaluating OCL code.
    The source of this error may be a bug with the Validator, but it might also be due to a 
    bug in the metamodel's (or profile's) OCL code. It might even be due to a fault in the
    XMI exchange file being processed. (Every effort has been made to eliminate this last source.)
    Detailed explanation of these errors in not yet provided because the explanations are so various
    and can be complex. If you are really interested, send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (object class-name reader-name lisp-error) c
	(format stream "Evaluation of OCL derived attribute ~A.~A on object ~A produced exception ~A."
		class-name reader-name object
		(cl-who:escape-string (format nil "~A" lisp-error)))))))

;;; pod7 new
;;;---- id-num 11.6 ----------------------
(defcondition ocl-attempts-executing-absent-derived (mof-warning)
  ((class-name :initarg :class-name :initform nil)
   (attribute-name :initarg :attribute-name :initform nil))
  (:id-num 11.6)
  (:title "OCL errors due to missing derived attribute specifications")
  (:documentation "OCL code tried to evaluate a declared derived attribute for which derivation is absent.")
  (:explanation 
   "This is a bug in the spec (whatever spec defines the subject attribute). 
    The spec declared that the subject attribute is derived
    but didn't provide the OCL code whereby we could derive values.
    See the ChangeLog entry for 2006-12-09 
    <a href='/se-interop/miwg/tools/changelog/'>here</a>.")
  (:report
   (lambda (c stream)
     (with-slots (object class-name attribute-name) c
	(format stream "Evaluation of OCL code ~A.~A on object ~A: Derived attibute derivation is missing."
		class-name attribute-name object)))))

;;;---- id-num 13 ----------------------
(defcondition mof-duplicate-xmi-id (mof-warning)
  ((original :initarg :original)
   (xmi-id :initarg :xmi-id))
  (:id-num 13)
  (:title "Identical XMI attribute xmi:id used by multiple XML elements")
  (:documentation "The file contains two or more XML elements with identical xmi:id.")
  (:explanation "This error is reported when the file defines two or more XML elements 
    with identical xmi:id attributes. 
    <p/>The error is identified during instantiation  of objects from the XMI exchange file.")
  (:report
   (lambda (c stream)
     (with-slots (object original) c
	(format stream 
		"Identical XMI attribute xmi:id used by multiple XML elements. Original object: ~A, Duplicate: ~A"
		(mofb:url-object-browser original)
		(mofb:url-object-browser object))))))

#+iface-http
(def-unique-errors mof-duplicate-xmi-id (:key (xmi-id)) ()
  (format nil "At least two elements have XMI:id  '~A'" xmi-id))

;;;---- id-num 14 ----------------------
(defcondition mof-expected-primitive (mof-warning)
  ((expected :initarg :expected)
   (got :initarg :got))
  (:id-num 14)
  (:title "Expected a uml:PrimitiveType")
  (:documentation "A PrimitiveType was expected; what was found is not that.")
  (:explanation "This error is reported when a uml:PrimitiveType was anticipated but not found.
    <p/>The error is identified during reading of the XMI.")
  (:report
   (lambda (c stream)
     (with-slots (expected got) c
	(format stream "Expected type ~A but got ~A" expected got)))))

#+iface-http
(def-combine-errors mof-expected-primitive
  (format nil "Expected a primitive type."))

;;;---- id-num 15 ----------------------
(defcondition xmi-excess-space (mof-warning)
  ((string :initarg :string))
  (:id-num 15)
  (:title "XMI attribute xmi:id references excessive space chars")
  (:documentation "A list of references specified by XMI encoding rule 2j uses 
   more than one space between references.")
  (:explanation "This error is reported when a list of references specified by XMI 
    encoding rule 2j uses more than one space between references.
    <p/>The error is identified during reading of the XMI.")
  (:report
   (lambda (c stream)
     (with-slots (string) c
	(format stream "Excess space between object references encoded by rule 2j: ~A" string)))))

;;;---- id-num 16 ----------------------
(defcondition xmi-serializes-default (mof-warning)
  ((class :initarg :class)
   (slot  :initarg :slot))
  (:id-num 16)
  (:title "XMI serializes a default value")
  (:documentation "The file serializes a default value.")
  (:explanation "A value was provided in the user's file for a property that has a default value, 
 and the value provided is that default value. This is prohibited in XMI.")
  (:report
   (lambda (c stream)
     (with-slots (object slot red-regex) c
       (setf red-regex (format nil "(~A)" (string (slot-definition-name slot))))
	(format stream "Object ~A, property ~A serialized the default value ~A."
		(mofb:url-object-browser object) 
		(mofb:url-class-browser slot)
		(slot-definition-default slot))))))
             
#+iface-http
(def-unique-errors xmi-serializes-default (:key (class slot)) ()
  (progn (declare-ignore class) "") ; These variables are needed for the key only.
  (format nil "The default value is serialized in property ~A."
	  (mofb:url-class-browser slot)))


;;;---- id-num 17 ----------------------
(defcondition xmi-serializes-derived (mof-warning)
  ((class :initarg :class)
   (slot  :initarg :slot))
  (:id-num 17)
  (:title "XMI serializes a derived value")
  (:documentation "The file serializes a derived value.")
  (:explanation "A value was provided in the user's file for a property is derived,
  yet the file provides a value for it. This is prohibited in XMI.")
  (:report
   (lambda (c stream)
     (with-slots (object class slot red-regex) c
       (setf red-regex (format nil "(~A=)" (slot-definition-name slot)))
	(format stream "Object ~A serialized a value for the property ~A. A value should have been obtained ~A"
		(mofb:url-object-browser object) 
		(mofb:url-class-browser slot)
		(if (slot-definition-is-derived-union-p slot) 
		    (format nil "as a derived union with sources: ~{~A~^, ~}." 
			    (let* ((src-names (slot-definition-derived-union-sources slot))
				   (sources (loop for s in (mapped-slots class)
					       when (member (slot-definition-name s) src-names)
					      collect s)))
			      (if (null sources) 
				  '("No declared sources! There may be a bug in the metamodel")
				  (mapcar #'mofb:url-class-browser sources))))
		    "through OCL computation."))))))

             
#+iface-http
(def-unique-errors xmi-serializes-derived (:key (class slot)) ()
  (progn (declare-ignore class) "") ; These variables are needed for the key only.
  (format nil "A value is provided for derived property ~A."
	  (mofb:url-class-browser slot)))

;;;---- id-num 18 ----------------------
(defcondition xmi-serializes-opposite (mof-warning)
  ((comp-slot  :initarg :comp-slot)
   (other-slot  :initarg :other-slot))
  (:id-num 18)
  (:title "XMI serializes values for the opposite of a property declared composite")
  (:documentation "The file serializes values for the opposite of a property declared composite.")
  (:explanation "A value was provided in the user's file for an opposite value of a property 
   declared composite. This is prohibited in XMI. (See MOF/XMI 2.4.1, section 9.4.1.)")
  (:report
   (lambda (c stream)
     (with-slots (object comp-slot other-slot red-regex) c
       (setf red-regex (format nil "(~A)" (string (second (slot-definition-opposite comp-slot)))))
	(format stream "Object ~A, serialized a value for the opposite of composite property ~A, ~A."
		(mofb:url-object-browser object) 
		(mofb:url-class-browser comp-slot)
		(mofb:url-class-browser other-slot))))))
             
#+iface-http
(def-unique-errors xmi-serializes-opposite (:key (comp-slot other-slot)) ()
  (format nil "A value is provided for property ~A. It's opposite, ~A, is composite."
	  (mofb:url-class-browser other-slot)
	  (mofb:url-class-browser comp-slot)))



;;;---- id-num 19 ----------------------
(defcondition uml-ownership-cycle (mof-warning)
  ((cycle :initarg :cycle))
  (:id-num 19)
  (:title "A cycle of uml:OwnedElement exists")
  (:documentation "A cycle exists in the uml:OwnedElement property of the reported elements.")
  (:explanation "This error is reported when a cycle is found in the values of the property
    Element:ownedElement.
    <p/>The error is identified during validation; it prevents Canonical XMI diffing where 
        that test would be applicable. The check for cycles here is equivalent in intent to 
        the constraint Element:not_own_self() but is more robust than the implementation 
        of that found in the UML spec.")
  (:report
   (lambda (c stream)
     (with-slots (cycle) c
	(format stream "A cycle exists among these Elements <ul>~{<li>~A</li>~}"
		(mapcar #'mofb:url-object-browser cycle))))))

#+iface-http
(def-combine-errors uml-ownership-cycle
  (format nil "A cycle of uml:OwnedElement exists."))

;;;---- id-num 20 ----------------------
(defcondition xmi-type-in-href (mof-warning)
  ((cycle :initarg :cycle))
  (:id-num 20)
  (:title "xmi:type was specified in an XML element that uses href")
  (:documentation "The xmi:type attribute was specified with an XML element that uses href.")
  (:explanation "This error is reported when xmi:type is specified when using href to reference an object. <br/>
                 This is prohibited in XMI beginning with XMI 2.4.")
  (:report
   (lambda (c stream)
     (with-slots (elem) c
       (format stream "xmi:type was used with an href:<br/>~A"
	       (let ((*print-pretty* t))
		 (with-output-to-string (str) (xml-write-node elem str))))))))

#+iface-http
(def-combine-errors xmi-type-in-href
  (format nil "xmi:type was specified in element that uses href."))


;;;---- id-num 21 ----------------------
(defcondition xmi-general-error (mof-error)
  ((str :initarg :str))
  (:id-num 21)
  (:title "XMI general error")
  (:documentation "An error that is not classified. See the error text for details.")
  (:report
   (lambda (c stream)
     (declare (ignorable c))
     (with-slots (str) c
       (format stream "~A" str)))))
       
;;;---- id-num 20 ----------------------
#| This was defined 2012-10-10 to catch a problem with redefinition.
  It was never used.
  Would need to explain better what the problem is (using a property whose name
  was redefined) because there already is something for non-existent properties (See ID-num 5, no-such-attr.)
(defcondition mof-ref-undefined-property (mof-warning)
  ((property-name :initarg :property-name))
  (:id-num 20)
  (:title "Referencing an undefined property")
  (:documentation "The XMI references by name an undefined property.")
  (:explanation "This error is reported when a XMI reference a property that is undefined. 
    Sometimes the property was redefined and given a new name. In that case, the 
    error message reports additional information about the redefinition.")
  (:report
   (lambda (c stream)
     (with-slots (object property-name) c
	(format stream "There is no property named '~A' in object ~A."
		property-name
		(mofb:url-object-browser object))))))

#+iface-http
(def-combine-errors mof-ref-undefined-property 
  (format nil "A reference is made to an undefined property."))

|#


;;;=========================================================
;; XMI Diff checking
;;;=========================================================
;;; POD This would be useful in a new file called pod-utils/xmi-utils.lisp.
(defmacro xml-finder (fname attr)
  `(defmethod ,fname ((elem t)) ; 2019-06-18 I'm going to try to let it slide. 
     "Return the xmi:id of the element. Assumes you don't know what XMI pkg is being used."
     (when (dom:element-p elem)
       (loop for pkg in (all-xmis)
	  for val = (xml-get-attr-value elem ,(strcat "xmi:" attr))
	  when val return val))))

(xml-finder xmi-id    "id")
(xml-finder xmi-idref "idref")
(xml-finder uuid      "uuid")

(defun xmi-abbrev (elem &key (len 250))
  "Return a string describing the element concisely."
  (let ((str (with-output-to-string (s) (xml-write-node elem s))))
    (if (< (length str) len)
	str
	(if-bind (id (xmi-id elem))
	  (format nil "<~A xmi:id='~A'...>" (dom:name elem) id)
	  (format nil "~A..." (subseq str 0 len))))))

(define-condition mof-diff-warning (mof-warning) 
  ((prop-name :initarg :prop-name :initform nil)
   (uline    :initarg :uline :initform nil)
   (vline    :initarg :vline :initform nil)
   (uelem :initarg :uelem :initform nil)   ; don't use elem, it is already a string.
   (velem :initarg :velem :initform nil) 
   (uval :initarg :uval :initform nil)     
   (vval :initarg :vval :initform nil)
   (uobj :initarg :uobj :initform nil)
   (vobj :initarg :vobj :initform nil)
   (class :initarg :class)
   (slot :initarg :slot)))

;;;---- id-num 100 ----------------------
(defcondition xmi-odd-match (mof-diff-warning)
  ()
  (:id-num 100)
  (:title "Imperfect matching of a User.xmi object to a Valid.xmi object")
  (:documentation "The user indicated that the file is a MIWG test case. Two objects that 
                   seemed to match each other in many respects are nonetheless of differing type.
                   The validator isn't currently implementing MIWG test cases.
                   If you need this, send email to xmi-interop@omg.org.")
  (:explanation "The user stated that the file he is uploading is a MIWG Test Case. The validator 
    compared objects in the two files, seeking corresponding objects. The corresponding objects
    that are the subject of this report are not of identical types. No further matching into
    these objects was performed. The validator isn't currently implementing MIWG test cases.
    If you need this, send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (uobj vobj) c
       (format stream "~A"
	       (with-output-to-string (out)
		 (format out "User object is ~A." (mofb:url-object-browser uobj))
		 (format out "<br/>Valid object is ~A." (mofb:url-object-browser vobj))))))))

#+iface-http
(def-combine-errors xmi-odd-match
  ()
  (format nil "No perfect match to a Valid.xmi object was found."))


;;;---- id-num 101 ----------------------
(defcondition xmi-diff-user-missing (mof-diff-warning)
  ()
  (:id-num 101)
  (:title "User.xmi is missing an element present in valid.xmi")
  (:documentation "The user indicated that the file is a MIWG test case; the canonical XMI generated for it 
                   contains an element not found in the user's (Canonical XMI-transformed) file.")
  (:explanation "The Validator generates canonical XMI; you can see it by navigating the link on
    the validator report called 'Canonical XMI'. (See the MIWG Wiki for discussion of the notion of Canonical XMI).
    The user stated that the file he is uploading is a MIWG Test Case. The validator compared the
    canonical form of his XMI (the XML shown at the link) with a stored Canonical XMI file 
    generated from valid.xmi.<p/> Each error report of this type describes a significant
    difference between the generated canonical XMI and the stored valid canonical XMI.
    The validator isn't currently implementing MIWG test cases. If you need this, send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (velem vobj red-regex) c
       (setf red-regex (if-bind (id (xml-get-attr-value velem "xmi:id"))
				(format nil "(~A)" id)
				"forget it"))
       (format stream "~A"
	       (with-output-to-string (out)
		 (format out "Valid.xmi, has element <font color='green'>~A</font>."
			 (escape-for-html (xmi-abbrev velem)))
		 (format out "<br/>User file has nothing like this.")
		 (format out "<br/>Valid object is ~A"
			 (mofb:url-object-browser vobj))))))))

#+iface-http
(def-combine-errors xmi-diff-user-missing
  ()
  (format nil "User.xmi is missing an element present in valid.xmi."))

;;;---- id-num 102 ----------------------
(defcondition xmi-diff-valid-missing (mof-diff-warning)
  ()
  (:id-num 102)
  (:title "User.xmi contains an element not present in valid.xmi")
  (:documentation "The user indicated that the file is a MIWG test case; the user's (canonical XMI-transformed) file
                   contains an element not found in valid.xmi
 		   The validator isn't currently implementing MIWG test cases. If you need this,
                   send email to xmi-interop@omg.org.")
  (:explanation "The Validator generates canonical XMI; you can see it by navigating the link on
    the validator report called 'Canonical XMI'. (See the MIWG Wiki for discussion of the notion of Canonical XMI).
    The user stated that the file he is uploading is a MIWG Test Case. The validator compared the
    canonical form of his XMI (the XML shown at the link) with a stored Canonical XMI file 
    generated from valid.xmi. Each error report of this type describes a significant
    difference between the generated canonical XMI and the stored valid canonical XMI.
    <p/>NOTE: This error will be reported for each instance where the user file serializes
    a default or derived value. It is easiest to fix those errors before studying these.
    The validator isn't currently implementing MIWG test cases. If you need this,
    send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (uelem red-regex uobj) c
       (setf red-regex (if-bind (id (xml-get-attr-value uelem "xmi:id"))
				(format nil "(~A)" id)
				"forget it"))
       (format stream "~A"
	       (with-output-to-string (out)
		 (format out "The user's file has element <font color='red'>~A</font>."
			 (escape-for-html (xmi-abbrev uelem)))
		 (format out "<br/>Valid.xmi has nothing like this.")
		 (when uobj (format out "<br/>User object involved is ~A" 
				    (mofb:url-object-browser uobj)))))))))

#+iface-http
(def-combine-errors xmi-diff-valid-missing
  ()
  (format nil "User.xmi has an element not present in valid.xmi"))


;;;---- id-num 104 ----------------------
(defcondition xmi-diff-property-values-differ (mof-diff-warning)
  ()
  (:id-num 104)
  (:title "An object property value in user.xmi differs from that of valid.xmi")
  (:documentation "The user indicated that the file is a MIWG test case. An object property
                   in the user's file differs from that of the corresponding object in 
                   valid.xmi. The validator isn't currently implementing MIWG test cases.
                   If you need this, send email to xmi-interop@omg.org.")
  (:explanation " The user stated that the file he is uploading is a MIWG Test Case. 
    The validator compared the user's XMI with a stored Canonical XMI file (valid.xmi)
    Each error report of this type describes a significant difference between user's
    file and the valid canonical XMI. The validator isn't currently implementing MIWG test cases.
    If you need this, send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (uobj vobj prop-name uval vval red-regex uelem) c
       (when uelem
	 (setf red-regex 
	       (format nil "(~A)" 
		       (with-output-to-string (s) (xml-write-node (car (xml-children uelem)) s)))))
        (format stream "User object ~A, property ~A has value '~A' where valid.xmi has '~A'.
                        <br/>
                        Valid object is ~A"
		(mofb:url-object-browser uobj)
		prop-name
		(cond ((null uval) "null")
		      ((typep uval 'mm-root-supertype) (mofb:url-object-browser uval))
		      (t uval))
		(cond ((null vval) "null")
		      ((typep vval 'mm-root-supertype) (mofb:url-object-browser vval))
		      (t vval))
		(mofb:url-object-browser vobj))))))


#+iface-http
(def-combine-errors xmi-diff-property-values-differ
  ()
  (format nil "User.xmi and valid.xmi have differing property values for some object"))

#|
#+iface-http
(def-unique-errors xmi-diff-property-values-differ (:key (class slot)) ()
  (progn (declare-ignore class) "") ; These variables are needed for the key only.
  (format nil "User.xmi and Valid.xmi values differ  for ~A"
	  (mofb:url-class-browser slot)))
|#

;;;---- id-num 105 ----------------------
(defcondition xmi-diff-property-not-specified (mof-diff-warning)
  ()
  (:id-num 105)
  (:title "User object missing a value specified in valid.xmi")
  (:documentation "The user indicated that the file is a MIWG test case. An object property
                   in the user's file does not specify a value where valid.xmi does.
  		   The validator isn't currently implementing MIWG test cases.
                   If you need this, send email to xmi-interop@omg.org.")
  (:explanation " The user stated that the file he is uploading is a MIWG Test Case. 
    The validator compared the user's XMI with a stored Canonical XMI file (valid.xmi)
    Each error report of this type describes a significant difference between user's
    file and the valid canonical XMI. The validator isn't currently implementing MIWG test cases.
    If you need this, send email to xmi-interop@omg.org.")
  (:report
   (lambda (c stream)
     (with-slots (uobj vobj prop-name vval) c
       (format stream "User object ~A specifies no value for property ~A. Valid.xmi has value ~A.
                        <br/>
                        Corresponding valid.xmi object is ~A."
	       (mofb:url-object-browser uobj)
	       prop-name
	       (cond ((null vval) "null")
		     ((typep vval 'mm-root-supertype) (mofb:url-object-browser vval))
		     (t vval))
	       (mofb:url-object-browser vobj))))))

#+iface-http
(def-combine-errors xmi-diff-property-not-specified
  ()
  (format nil "User.xmi does not specify a value where valid.xmi does."))



#| 
#+iface-http 
(def-unique-errors xmi-diff-property-not-specified (:key (class slot)) ()
  (progn (declare-ignore class) "") ; These variables are needed for the key only.
  (format nil "User.xmi does not specify a value for ~A"
	  (mofb:url-class-browser slot)))
|#


;;;====================
;;; mof-errors
;;;====================
(defcondition mof-no-model (mof-error)
  ()
  (:title "No uml:Model element found")
  (:documentation "No uml:Model element can be found in the XMI file.")
  (:report
   (lambda (c stream)
     (declare (ignorable c))
     (format stream "No uml:Model element found in the file."))))

(defcondition xmi-namespace-unknown (mof-error)
  ((provided :initarg :provided))
  (:title "No such XMI namespace")
  (:documentation "Either an XMI namespace was not provided or what was provided is not known to be associated with XMI.")
  (:report
   (lambda (c stream)
     (declare (ignorable c))
     (with-slots (provided) c
     (format stream 
	     "There is no XMI specification known to the Validator as ~A.<br/> 
              Provide the standard URI for xmlns:xmi .<br/> The following namespaces are 
              associated with XMI: </br> ~{~A <br/>~}." 
	     provided
	     (mapappend #'nicknames (remove-if-not #'(lambda (x) (typep x 'exchange-model)) *models*)))))))





;;;==================================================
;;; XMI output
;;;==================================================
(defun url-relevant-xmi (next-text-length)
  (let* ((url (tbnl:request-uri tbnl:*request*))
	 (url-minus-len (subseq url 0 
				(search "&text-length=" url))))
    (format nil "<a href='~A&text-length=~A'>&nbsp;&nbsp;...more</a>" 
	    url-minus-len next-text-length)))

(defun pretty-xmi  (str)
  "Remove blank lines and insert &nbsp; etc to make xmi print nicer."
  (flet ((first-char (s) 
	   (mvb (i1 i2 sv i3) (cl-ppcre:scan "\\s*(\\S)" s)
	     (declare (ignore i1 i2 i3)) (svref sv 0))))
    (let ((in (make-string-input-stream str)))
      (with-output-to-string (out)
	(loop for line = (read-line in nil :eof) until (eql :eof line)
	   unless (cl-ppcre:scan "^\\s*$" (string-trim '(#\Space #+lispworks #\No-Break-Space) line))
	   do (let ((start-text (first-char line)))
		(write-string (cl-ppcre:regex-replace-all "\\s" line "&nbsp;&nbsp;" :end start-text) out)
		(write-string (subseq line start-text) out)
		(write-string "<br/>" out)))))))

(defgeneric relevant-xmi (condition))

(defmethod relevant-xmi ((c t))
  "Return the chunk of html describing the xmi implicated in condition C.
   The condition must specify a value for either elem or obj."
  (with-slots ((str elem) red-regex) c
    (with-output-to-string (out)
      (when (and str (stringp str)) ; 2011-03-18 Where is this set to a string?!?
	(let* ((len (length str))
	       (textlen (if-bind (len (safe-get-parameter "text-length")) (read-from-string len) 512))
	       (pretty (pretty-xmi
			(if (> len textlen) 
			    (strcat (escape-for-html (subseq str 0 textlen))
				    (url-relevant-xmi (* textlen 4)))
			    (escape-for-html str)))))
	  
	  (write-string "<h3>User.xmi:</h3>" out)
	  (if (null red-regex)
	      (write-string pretty out)
	      (mvb (success vec) (cl-ppcre:scan-to-strings red-regex pretty)
		(if success
		    (write-string (cl-ppcre:regex-replace 
				   (aref vec 0)
				   pretty 
				   (format nil "<font color='red'>~A</font>" (aref vec 0)))
				  out)
		    (write-string pretty out)))))))))

;;; Problem is that elem is coming in as a string!
(defun relevant-xmi-pretty (elem title stream &key red-regex (color "red"))
  "Auxiliary function for relevant-xmi. Prints LEN characers of ELEM xmi on STREAM."
  (let* ((str (with-output-to-string (s) (xml-write-node elem s)))
	 (len (length str))
	 (textlen (if-bind (len (safe-get-parameter "text-length")) (read-from-string len) 512))
	 (pretty (pretty-xmi
		  (if (> len textlen) 
		      (strcat (escape-for-html (subseq str 0 textlen))
			      (url-relevant-xmi (* textlen 4)))
		      (escape-for-html str)))))
    (write-string title stream)
    (if (null red-regex)
      (write-string pretty stream)
      (mvb (success vec) (cl-ppcre:scan-to-strings red-regex pretty)
	(if success
	    (write-string (cl-ppcre:regex-replace 
			   (aref vec 0)
			   pretty 
			   (format nil "<font color='~A'>~A</font>" color (aref vec 0)))
			  stream)
	    (write-string pretty stream))))))

(defun relevant-xmi-tree (elem title stream &key (color "red"))
  "Auxiliary function for relevant-xmi. Output an abreviated tree of XML leading to the error."
    (format stream title)
    (loop for p in (cdr (reverse (loop for p = elem then (xml-parent p) while p collect p)) )
       for i from 1 do 
	 (write-string "<br/>" stream)
	 (loop for j from 1 to i do (write-string "&nbsp;&nbsp;" stream))
	 (when (eql p elem) (format stream "<font color='~A'>" color))
	 (write-string (escape-for-html (xmi-abbrev p :len 120)) stream)
	 (when (eql p elem) (write-string "</font>" stream))))

(defmethod relevant-xmi ((c mof-diff-warning))
  (with-slots (uelem uline velem vline) c
    (with-output-to-string (out)
      (when uelem
	(relevant-xmi-pretty uelem (format nil "<h3>User.xmi line ~A:</h3>" uline) out))
      (when velem
	(relevant-xmi-pretty velem (format nil "<h3>Valid.xmi line ~A:</h3>" vline) out))
      (when uelem
	(relevant-xmi-tree uelem "<h3>User.xmi XML Tree</h3>" out))
      (when (and velem (not uelem))
	(relevant-xmi-tree velem "<h3>Valid.xmi XML Tree</h3>" out)))))

;;;====================
;;; Utilities
;;;====================

;;; POD I don't know where the definition of this is.
(defun escape-for-html (str) 
  (cl-who:escape-string str))


