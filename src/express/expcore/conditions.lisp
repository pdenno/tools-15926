
;;; Condition and Error definitions. 
;;; Many of these have been adapted from mof/conditions.lisp

(in-package :EXPO)

;;; Borrowed from mofi. Used there... an expediency.

;(defparameter *mofi-all-conditions* nil "A list of condition names.")

(defmacro mofi:defcondition (name superclasses slots &rest options)
  `(progn
;     (pushnew ',name *mofi-all-conditions*)
     (define-condition ,name ,superclasses ,slots
       (:documentation ,(cadr (assoc :documentation options)))
       (:report ,(cadr (assoc :report options))))
     (setf (get :title ',name) ,(cadr (assoc :title options)))
     (setf (get :id-num ',name) ,(or (cadr (assoc :id-num options)) 1000))
     (setf (get :explanation ',name) ,(cadr (assoc :explanation options)))
     (export ',name)))

(defmacro mofi:def-unique-errors (type-name (&key key (url-prefix "/validator/xmi-example")) &body body)
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

(defmacro mofi:def-combine-errors (type-name &body body)
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



;;;-----------------------------------------------------------------------
;;; Error definitions
;;;-----------------------------------------------------------------------
(mofi:defcondition express-error (simple-warning) 
  ()
  (:documentation "Abstract condition. Superclass of others here."))

(mofi:defcondition data-error (express-error)
  ((instance :initarg :instance))
  (:documentation "Abstract condition. Superclass of others here."))

;;; id-num 1 -----------------------------
(mofi:defcondition failed-global-rule (data-error)
  ((rule-name :initarg :rule-name)
   (rule-label :initarg :rule-label))
  (:id-num 1)
  (:title "Failed global rules")
  (:documentation "The population failed a global rule.")
  (:explanation "The population failed the rule named in the error message.")
  (:report
   (lambda (err stream)
     (with-slots (rule-name rule-label) err
       (format stream "The population failed the rule ~A.~A" rule-name rule-label)))))

#+iface-http
(mofi:def-unique-errors failed-global-rule (:key (rule-name rule-label) 
				       :url-prefix "/ap233/validator/example")
  (format nil "The global rule ~A.~A failed."  rule-name rule-label))

;;; http://localhost/se-interop/validator/xmi-example?
;;; key=string*PRODUCT_VIEW_DEFINITION|string*WR2&type=FAILED-DOMAIN-RULE
;;; id-num 2 -----------------------------
(mofi:defcondition failed-domain-rule (data-error)
  ((rule-name :initarg :rule-name) ; names an entity type.
   (rule-label :initarg :rule-label))
  (:id-num 2)
  (:title "Failed domain rule")
  (:documentation "The referenced instance failed the a domain rule.")
  (:explanation "The instance failed the domain rule.")
  (:report
   (lambda (err stream)
     (with-vo (mut)
       (with-slots (rule-name rule-label instance) err
	 (format stream "The instance ~A failed the rule ~A.~A."
		 (gethash instance (names-by-instance-ht (dataset mut)))
		 rule-name 
		 rule-label))))))

#+iface-http
(mofi:def-unique-errors failed-domain-rule (:key (rule-name rule-label)
				       :url-prefix "/ap233/validator/example")
  (format nil "The domain rule ~A.~A failed." rule-name rule-label))

;;; id-num 2.5 (from MOF)  -----------------------------
(mofi:defcondition exp-violates-type (data-error)
  ((class :initarg :class)
   (slot  :initarg :slot)
   (value :initarg :value)
   (slot-range  :initarg :slot-range)
   (value-type :initarg :value-type))
  (:id-num 2.5)
  (:title "Type violation")
  (:documentation "The value of an attribute is incompatible with its declared type.")
  (:explanation 
   "The value provided is not of the type required by the class declaring the property. 
    <p/>This error is reported in post-processing of the Model.")
  (:report
   (lambda (c stream)
     (with-slots (instance class slot value slot-range) c
	(format stream "Object ~A, property ~A.~A value ~A is not a ~A."
		instance
		(class-name class)
		(closer-mop:slot-definition-name slot)
		value
		slot-range)))))

#+iface-http
(mofi:def-unique-errors exp-violates-type (:key (class           ;; This...
				            slot            ;; ...is..
					    slot-range      ;; ...a.. 
					    value-type)     ;; ...key. (cdr if applicable).
					   :url-prefix "/ap233/validator/example")
  (progn (declare-ignore value-type) (declare-ignore class) "") ;; POD!!!
  (format nil "Attribute ~A (declared type ~A) has value ~S."
	  ;; Confusing, but as it shows above, the value is the slot name, now we need the slot...
	  (mofb:url-class-browser slot)
	  "some type" ; (mofb:url-class-browser slot-range)
	  (mofb:pretty-html (slot-value (car mofi::errs) 'value)))
#| POD Sampson NYI (was from MOF code)
  ;; pod7 this really ought to be enum-p
  (if-bind (e-vals (enum-values slot-range))
      (format nil "<br/>~A is an enumeration with values ~{~A~^, ~}." 
	      (closer-mop:slot-definition-name slot-range) 
	      e-vals)
      "")|#)

;;; id-num 2.5 (from MOF)  -----------------------------
(mofi:defcondition exp-missing-mandatory (data-error)
  ((class :initarg :class)
   (slot :initarg :slot))
  (:id-num 2.6)
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
     (with-slots (instance class slot) c
	(format stream "Object ~A, value not specified for mandatory attribute ~A.~A"
		(mofb:url-object-browser instance) 
		(class-name class) 
		(closer-mop:slot-definition-name slot))))))

#+iface-http
(mofi:def-unique-errors exp-missing-mandatory (:key (class slot)
					  :url-prefix "/ap233/validator/example")
  (progn (declare-ignore class) "")
  (format nil "~A" (mofb:url-class-browser slot))
  (format nil " requires a value be specified. None was."))


;;; id-num 3 -----------------------------
(mofi:defcondition abstract-entity (data-error)
  ((unsupported-type :initarg :unsupported-type)
   (possible-subtypes :initarg :possible-subtypes))
  (:id-num 3)
  (:title "Creates instances of abstract entity types")
  (:documentation "The data attempts to create an instance of an abstract entity")
  (:explanation "The data attempts to create an instance of an abstract entity")
  (:report
   (lambda (err stream)
     (with-slots (unsupported-type possible-subtypes) err
       (format stream "The type ~A is abstract and no concrete subtype was selected. ~
                       ~%The possible subtypes are ~{~%~A~^, ~}." 
               unsupported-type possible-subtypes)))))

#+iface-http
(mofi:def-unique-errors expo:abstract-entity (:key (unsupported-type)
				         :url-prefix "/ap233/validator/example")
  (format nil "The type ~A is abstract." unsupported-type))

;;; id-num 3.5 -----------------------------
(mofi:defcondition exp-unresolved-entity-ref (data-error) 
  ((ref  :initarg :ref))
  (:id-num 3.5)
  (:title "Reference in serialization was not resolved")
  (:documentation "The serialization of the instance make a reference that cannot be resolved.")
  (:explanation "In the call to a function (built-in or defined in a schema), the arguments provided in a function call were incompatible with the function's formal parameters.")
  (:report
   (lambda (err stream)
     (with-slots (instance ref) err
       (format stream "The instance ~A contains an unresolved reference to ~A" 
	       instance ref)))))

#+iface-http
(mofi:def-unique-errors exp-unresolved-entity-ref (:key (instance)
				              :url-prefix "/ap233/validator/example")
  (format stream "The instance ~A contains an unresolved reference." instance))

;;; id-num 4 -----------------------------
(mofi:defcondition incompatible-args (data-error) 
  ((function :initarg :function)
   (args  :initarg :args))
  (:id-num 4)
  (:title "Arguments incompatible with the function's formal parameters")
  (:documentation "The arguments provided were incompatible with the function's formal parameters.")
  (:explanation "In the call to a function (built-in or defined in a schema), the arguments provided in a function call were incompatible with the function's formal parameters.")
  (:report
   (lambda (err stream)
     (with-slots (function args) err
       (format stream "The arguments  ~{~A~^, ~} ~% are incompatible with the formal parameters of ~A."
	       args function )))))

#+iface-http
(mofi:def-unique-errors incompatible-args (:key (function)
			              :url-prefix "/ap233/validator/example")
  (format nil "Incompatible arguments in application of function ~A." function))

;;; id-num 5 -----------------------------
(mofi:defcondition disjoint-types (data-error)
  ((types :initarg :types))
  (:id-num 5)
  (:title "Instances have no common supertype")
  (:documentation "The instance has no common supertype.")
  (:explanation "In the creation of the entity instance, there is no common supertype.")
  (:report
   (lambda (err stream)
     (with-slots (types) err
       (format stream "The is not a single common supertype to the selected entity types.")
       (format stream "The supertypes are ~A" types)))))

#+iface-http
(mofi:def-unique-errors disjoint-types (:key (types)
				   :url-prefix "/ap233/validator/example")
  (format nil "No common supertype in ~A." types))

;;; id-num 6 -----------------------------
;;; POD This one needs work, only argument is the text string.
(mofi:defcondition bad-entity (data-error)
  ((format-string :initarg :format-string)
   (format-arguments :initarg :format-arguments))
  (:id-num 6)
  (:title "Instances not well-formed")
  (:documentation "The entity instance is not well-formed")
  (:explanation "The entity instance is not well-formed. What exactly this means depends on the  details described in the error text. (This is work in progress).")
  (:report 
   (lambda (err stream)
     (with-slots (format-string format-arguments) err
       (apply #'format stream format-string format-arguments)))))

#+iface-http
(mofi:def-combine-errors bad-entity 
  (format nil "Instance not well formed."))

;;; id-num 7 -----------------------------
(mofi:defcondition no-slot-in-instance (data-error)
  ((instance :initarg :instance)
   (slot     :initarg :slot))
  (:id-num 7)
  (:title "Instances do not have specified attribute" )
  (:documentation  "The instance does not have the referenced attribute." )
  (:explanation "The instance does not have the referenced attribute. This error may be due to either an error in the schema, or an ill-formed instance (the one referencing the instance identified in this error report.")
  (:report
   (lambda (err stream)
     ;(with-vo (conditions) (vector-push-extend err conditions))
     (with-slots (instance slot) err
       (format stream "The instance ~S does not have attribute ~S."  instance slot)))))

#+iface-http
(mofi:def-unique-errors no-slot-in-instance (:key (slot)
				       :url-prefix "/ap233/validator/example")
  (format nil "There is no attribute ~A in these instances." slot))

;;; id-num 8 -----------------------------
(mofi:defcondition index-out-of-bounds (data-error)
  ((aggregate :initarg :aggregate)
   (index :initarg :index))
  (:id-num 8)
  (:title "Index out of bounds" )
  (:documentation "An index to an aggregate was out of bounds")
  (:explanation "An index to an aggregate was out of bounds.")
  (:report
   (lambda (err stream)
     ;(with-vo (conditions) (vector-push-extend err conditions))
     (with-slots (aggregate index) err
       (format stream "The index ~A is outside the bounds for the aggregate ~A"  index aggregate)))))

#+iface-http
(mofi:def-combine-errors index-out-of-bounds 
  (format nil "Index out of bounds."))

;;; id-num 9 -- express-execution-error (no details)
(mofi:defcondition express-execution-error (data-error)
  ((rule-name :initarg :rule-name :initform nil)
   (rule-label :initarg :rule-label :initform nil)
   (lisp-error :initarg :lisp-error :initform nil))
  (:id-num 9)
  (:title "EXPRESS execution error" )
  (:documentation "An error occurred during evaluation of EXPRESS code.")
  (:explanation "An error occurred during evaluation of EXPRESS code. 
    The source of this error may be a bug with the Validator, but it might also be due to a 
    bug in the EXPRESS schema. It might even be due to a fault in the data
    file (part 21 or part 28) being processed. (Every effort has been made to eliminate this last source.)
    Detailed explanation of these errors in not yet provided because the explanations are so various
    and can be complex. If you are really interested, ask at se-interop@nist.gov.")
  (:report
   (lambda (err stream)
     ;(with-vo (conditions) (vector-push-extend err conditions))
     (with-slots (instance rule-name rule-label lisp-error) err
	(format stream "Evaluation of EXPRESS ~A:~A on object ~A produced exception ~A."
		rule-name rule-label instance
		#+iface-http(cl-who:escape-string (format nil "~A" lisp-error))
		#+iface-cgtk(format nil "~A" lisp-error))))))

;;; id-num 10 -----------------------------
(mofi:defcondition domain-rule-returned-indeterminate (data-error)
  ((rule-name :initarg :rule-name) ; names an entity type
   (rule-label :initarg :rule-label))
  (:id-num 10)
  (:title "Domain rule returned indeterminate value")
  (:documentation "The referenced instance domain rule returned indeterminate value.")
  (:explanation "The referenced instance domain rule returned indeterminate value. 
                 This is not actually an error but a situation which you may want to investigate further.")
  (:report
   (lambda (err stream)
     ;(with-vo (conditions) (vector-push-extend err conditions))
     (with-slots (rule-name rule-label instance) err
       (format stream "Domain rule ~A.~A returned an indeterminate value for instance ~A."
	       rule-name rule-label instance )))))

#+iface-http
(mofi:def-unique-errors domain-rule-returned-indeterminate 
    (:key (rule-name rule-label)
     :url-prefix "/ap233/validator/example")
  (format nil "The domain rule ~A.~A returned indeterminate." rule-name rule-label))

;;; NYI ------------------------------------------------------------
;;; NYI ------------------------------------------------------------
;;; NYI ------------------------------------------------------------

(define-condition bad-operand (express-error)
  ()
  (:documentation "Abstract condition. Superclass of others here."))

(mofi:defcondition index1-greater-than-index2 (bad-operand)
  ((index1 :initarg :index1)
   (index2 :initarg :index2))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (index1 index2) err
       (format stream "The index qualifier [~A:~A] requires that index-1 ~
			less than or equal to index-2."
	       index1 index2)))))

(mofi:defcondition aggregate-index-negative (bad-operand)
  ((index     :initarg :index)
   (aggregate :initarg :aggregate))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (index aggregate) err
       (format stream "The index (~A) used to access the aggregate ~A was negative."
	       index aggregate)))))

(mofi:defcondition derived-attr-refs-undefined-entity (bad-operand)
  ((attribute  :initarg :attribute)
   (entity-ref :initarg :entity-ref))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (attribute entity-ref) err
       (format stream "The DERIVEd attribute ~A references the entity ~A which is not yet defined.~%~
			You may want to try turning off uniqueness checking."
	       attribute entity-ref)))))

(mofi:defcondition usedin-role-2-dots (bad-operand)
  ((role :initarg :role))
  (:id-num 0)
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (role) err
       (format stream "USEDIN Role (~A) must contain exactly two '.'" role)))))

(mofi:defcondition usedin-invalid-type (bad-operand) 
  ()
  (:id-num 0)
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "Invalid type in USEDIN role."))))

(mofi:defcondition usedin-bad-entity-or-attribute (bad-operand)
  ((entity    :initarg :entity)
   (attribute :initarg :attribute))
  (:id-num 0)
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (entity attribute) err
       (format stream "USEDIN was called with either an entity type (~A) ~
			or an attribute (~A) that doesn't exist.~%~
			(Hint: Is the attribute defined in a supertype?)"
	       entity attribute)))))

(mofi:defcondition no-entity-in-schema (bad-operand)
  ((entity :initarg :entity)
   (schema :initarg :schema))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (entity schema) err
       (format stream "~A does not name an entity type in the schema ~A."
	       entity schema)))))

(mofi:defcondition length-invalid-arg (bad-operand)
  ((arg :initarg :arg))
  (:id-num 0)
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (arg) err
       (format stream "LENGTH called with ~S" arg)))))

(mofi:defcondition like-bad-operand (bad-operand)
  ((string :initarg :string)
   (expr   :initarg :expr))
  (:report
   (lambda (err stream)
     (with-slots (string expr) err
       (format stream "LIKE called with bad operand of either ~A or ~A"
	       string expr)))))

(mofi:defcondition extent-invalid-type (bad-operand)
  ((type :initarg :type))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (type) err
       (format stream "EXTENT called with invalid type '~A'" type)))))

(mofi:defcondition coerce-select-value-expected-logical (bad-operand)
  ((value :initarg :value))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (value) err
       (format stream "COERCE_SELECT_VALUE expected a logical but got ~A" value)))))

(mofi:defcondition coerce-select-value-expected-boolean (bad-operand)
  ((value :initarg :value))
  (:report
   (lambda (err stream)
     (with-slots (value) err
       (format stream "COERCE_SELECT_VALUE expected a boolean but got ~A" value)))))

(mofi:defcondition coerce-select-value-invalid-type (bad-operand)
  ((type :initarg :type))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (type) err
       (format stream "COERCE_SELECT_VALUE called with the invalid type ~A" type)))))

(mofi:defcondition constant-non-existent (bad-operand)
  ((name :initarg :name))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "~A does not name a constant" name)))))

(mofi:defcondition bad-accessor-call (bad-operand)
  ((accessor :initarg :accessor)
   (object   :initarg :object))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (accessor object) err
       (format stream "Call to accessor ~A with argument ~A"
	       accessor object)))))


(mofi:defcondition entity-no-attribute (bad-operand)
  ((entity    :initarg :entity)
   (attribute :initarg :attribute))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (entity attribute) err
       (format stream "The entity type ~A does not have an attribute named ~A"
	       entity attribute)))))

(mofi:defcondition entity-no-attribute-or-multiple (bad-operand)
  ((attribute :initarg :attribute))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (attribute) err
       (format stream "Either zero or more than one attribute by the name ~A exist in the instance."
	       attribute)))))

(mofi:defcondition malformed-call (express-error)
  ((string :initarg :string))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (string) err
       (format stream "Malformed function call: ~A" string)))))

(mofi:defcondition no-instance (express-error)
  ((name :initarg :name))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "There is no instance ~A" name)))))


(mofi:defcondition invalid-class-name (express-error)
  ((name :initarg :name))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (name) err
       ;; "Using an invalid *current-class-name*!!!"
       (format stream "~S is not the name of a class" name)))))

(mofi:defcondition no-attribute-on-entity (express-error)
  ((entity :initarg :entity)
   (attribute :initarg :attribute))
  (:id-num )
  (:title )
  (:documentation )
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (entity attribute) err
       ;; "Can't find entity type ~a attribute ~a"
       (format stream "Can't find the attribute ~S on entity ~S"
	       attribute entity)))))

;;;==========================================================
;;; Non-validator errors (define-condition, not mofi:defcondition
;;;=========================================================
(define-condition not-yet-implemented (express-error)
  ((string :initarg :string))
  (:report
   (lambda (err stream)
     (with-slots (string) err
       (format stream "~:[Not Yet Implemented~;~:*~A~]" string)))))

(define-condition setting-derived-attribute (bad-operand)
  ((attribute :initarg :attribute)
   (object    :initarg :object))
  (:report
   (lambda (err stream)
     (with-slots (attribute object) err
       (format stream "Trying to set the value of the derived attribute ~A of ~A"
	       attribute object)))))

(define-condition cant-print-external-mapping (express-error)
  ((object :initarg :object))
  (:report
   (lambda (err stream)
     (with-slots (object) err
       ;; "Can't print external mapping of ~S"
       (format stream "Can't print external mapping of ~S" object)))))

(define-condition terminal-not-found-in-grammar (express-error)
  ((grammar :initarg :grammar)
   (token :initarg :token))
  (:report
   (lambda (err stream)
     (with-slots (grammar token) err
       ;; "POD: Can not find the terminal in the grammar ~a"
       (format stream "The terminal ~S was not found in grammar ~S"
	       token grammar)))))

(define-condition simple-express-error (express-error)
  ((format-string :initarg :format-string)
   (format-arguments :initarg :format-arguments))
  (:report 
   (lambda (err stream)
     (with-slots (format-string format-arguments) err
       (apply #'format stream format-string format-arguments)))))


#+nil
(define-condition p21-nested-comment (express-error)
  ((line-number :initarg :line-number))
  (:report
   (lambda (err stream)
     (with-slots (line-number) err
       (format stream "At line ~D: Part 21 Comments cannot be nested."
	       line-number)))))

#+nil
(define-condition function-deprecated (express-error)
  ((function-name :initarg :function-name))
  (:report
   (lambda (err stream)
     (with-slots (function-name) err
       (format stream "The function ~A is deprecated and will be removed later."
	       function-name)))))

#+nil
(define-condition developer-version (express-error)
  ((string :initarg :string))
  (:report
   (lambda (err stream)
     (with-slots (string) err
       (princ string stream)))))

#+nil
(define-condition unknown-type (express-error)
  ((type :initarg :type))
  (:report
   (lambda (err stream)
     (with-slots (type) err
       (format stream "~S is an unknown type" type)))))

#+nil
(define-condition wrong-arg-type (express-error)
  ((name :initarg :name)
   (desc :initarg :description)
   (value :initarg :value))
  (:report
   (lambda (err stream)
     (with-slots (name value desc) err
       (format stream "The arg ~A was supplied with the value ~A which is not ~A"
	       name value desc)))))

#+nil
(define-condition unknown-platform (express-error)
  ((string :initarg :string))
  (:report
   (lambda (err stream)
     (with-slots (string) err
       (format stream "~A ~A: ~A" (lisp-implementation-type) (lisp-implementation-version)
	       string)))))

#+nil
(define-condition cant-merge-perdicates (express-error)
  ((pred1 :initarg :pred1)
   (pred2 :initarg :pred2))
  (:explanation )
  (:report
   (lambda (err stream)
     (with-slots (pred1 pred2) err
       (format stream "Can't merge duplicates: ~S ~S" pred1 pred2)))))

(define-condition undefined-supertype-in-map (express-error)
  ((map-name :initarg :map-name)
   (supertype-name :initarg :supertype-name))
  (:report
   (lambda (err stream)
     (with-slots (map-name supertype-name) err
       (format stream "The MAP ~A references an undefined supertype ~A"
	       map-name supertype-name)))))

(define-condition unknown-map (express-error)
  ((name :initarg :name))
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "Can't find the MAP named ~A" name)))))

(define-condition invalid-map-target-in-call (express-error)
  ((map-name :initarg :map-name)
   (target :initarg :target))
  (:report
   (lambda (err stream)
     (with-slots (map-name target) err
       (format stream "In explicit call to MAP ~A, ~A is not a target parameter reference."
	       map-name target)))))

(define-condition mapcall-unhandled (express-error)
  ((map-name :initarg :map-name)
   (partition :initarg :partition)
   (params :initarg :params))
  (:report
   (lambda (err stream)
     (with-slots (map-name partition params) err
       (let ((pparams (loop for p in params
                            if (typep p 'entity-root-supertype)
                            collect (format nil "#~A" (entity-id p (instance-dataset p)))
                            else collect p)))
       (format stream "Error: Mapcall ~A~@[\~A~](~{~S~^ ~}) does not map ~{~S~^ ~}."
	       map-name partition pparams pparams))))))

(define-condition null-extent (express-error)
  ()
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "Called extent with nil."))))

(define-condition inconsistent-extent (express-error)
  ()
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "Called extent with inconsistent arguments."))))

(define-condition attribute-not-in-entity (express-error)
  ((entity :initarg entity)
   (attribute :initarg :attribute))
  (:report
   (lambda (err stream)
     (with-slots (entity attribute) err
       (format stream "The entity ~A (~A) does not have an attribute named ~A"
	       (entity-id entity (entity-dataset entity))
	       (bi-typeof entity)
	       attribute)))))

(define-condition attribute-not-in-view (express-error)
  ((view :initarg :view)
   (attribute :initarg :attribute))
  (:report
   (lambda (err stream)
     (with-slots (view attribute) err
       (format stream "The view ~A does not have an attribute named ~A"
	       view attribute)))))

(define-condition duplicate-identifier-in-schema (express-error)
  ((type :initarg :type)
   (id :initarg :id))
  (:report
   (lambda (err stream)
     (with-slots (type id) err
       (format stream "An ~A identifier named ~A already exists in this schema"
	       type id)))))

(define-condition duplicate-schema-names (express-error)
  ((schema-name :initarg :schema-name))
  (:report
   (lambda (err stream)
     (with-slots (schema-name) err
       (format stream "Another schema by the name ~A already exists. Rename one of the schema." 
	       schema-name)))))

(define-condition dataset-lookup-failure (express-error)
  ((criteria :initarg :criteria))
  (:report
   (lambda (err stream)
     (with-slots (criteria) err
       (format stream "Could not find the dataset identfied by ~S" criteria)))))

(define-condition express-x-no-referenced-schema (express-error)
  ((schema-name :initarg :schema-name)
   (schema-type :initarg :schema-type))
  (:report
   (lambda (err stream)
     (with-slots (schema-name schema-type) err
       (if (eql schema-type :source)
           (format stream "You have not loaded the source schema ~A REFERENCEd in this express-x schema." schema-name)
         (format stream "You have not loaded the target schema ~A REFERENCEd in this express-x schema." schema-name))))))

(define-condition express-x-same-schema (express-error) 
  ((name :initarg :name))
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "You specified the same schema for source and target: ~a" name)))))

(define-condition no-loaded-schema (express-error)
  ()
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "You must load a schema first."))))

(define-condition no-loaded-x-schema (express-error)
  ()
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "You must load an Express-x schema first."))))

(define-condition no-loaded-data (express-error)
  ()
  (:report
   (lambda (err stream)
     (declare (ignore err))
     (format stream "You must load some data first."))))

(define-condition no-loaded-schema (express-error)
  ((name :initarg :name))  
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "The schema named '~A' was not found." name)))))

(define-condition unknown-schema-alias (express-error)
  ((name :initarg :name))  
  (:report
   (lambda (err stream)
     (with-slots (name) err
       (format stream "The schema alias '~A' is unknown." name)))))

;;;=========================================================================
;;; Previously this stuff was in the P11P package, but that wasn't usable
;;; from the EMM package (scope.lisp), which is define upstream of P11P. 
;;;=========================================================================
#|
(def-parse-error scope-error ()
  ()
  (:report (lambda (err stream)
	     (with-slots (pod::line-number pod::text) err ; PODTT
		  (format stream "Line ~A: ~A" pod::line-number pod::text))))) ; PODTT


(def-parse-error parse-invalid-base-type (parse-error-with-token)
  ((definition :initarg :definition)
   (token :initarg token))
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (if definition
		      (format stream "While parsing ~A, the token '~A' is not a valid base_type"
				  definition token)
		      (format stream "While parsing token = ~A (no definition), invalid base type error."
				 token))))))

(def-parse-error parse-invalid-bi-constant (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_constant"
			   definition token)))))

(def-parse-error parse-invalid-bi-function (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_function"
			   definition token)))))

(def-parse-error parse-invalid-bi-procedure (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_procedure"
			  definition token)))))

(def-parse-error parse-invalid-decl (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid declaration."
			   definition token)))))

(def-parse-error parse-bad-call (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is neither an entity nor a function."
			  definition token)))))

(def-parse-error parse-redefine-enumeration-id (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, there was an attempt to redeclare the enumeration_id '~A'"
			  definition token)))))

(def-parse-error parse-cmd-bad-call (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing your input: ~A~%, the token '~A' is neither an entity nor a function."
			   definition token)))))


;;;--- not really parsing errors, but associated with a line
(def-parse-error pprocess-error ()
  ())
|#

;;;---- P14 ---

(def-parse-error parse-unqualified-name ()
  ((kind :initarg :kind)
   (name :initarg :name))
  (:report 
   (lambda (err stream)
     (with-slots (kind name) err
       (format stream "The ~A named '~A' must be qualified by a schema name." kind name)))))

;;;---- P14 ---

(def-parse-error p21-parse-error ()
  ((tag :initarg :tag)
   (expected :initarg :expected)
   (actual :initarg :actual))
  (:report (lambda (err stream)
	     (with-slots (tag expected actual) err
	       (format stream "~A : expected '~A', got '~A'"
			  tag expected actual)))))

(def-parse-error p21-wrong-number-of-values ()
  ((id       :initarg :id)
   (found    :initarg :found)
   (expected :initarg :expected))
  (:report
   (lambda (err stream)
     (with-slots (id found expected) err
       (format stream "Instance #~D has the wrong number of values: found ~D, expected ~D"
	       id found expected)))))






