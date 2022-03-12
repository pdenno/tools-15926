
(in-package :tlogic)

(defgeneric unique-errors (type conditions))
(defgeneric url-xml-example (type keys))
(defgeneric condition-details (type unique-ht stream &key &allow-other-keys))

;;; The idea of the unique-errors macro is that it arranges to store hashtable values
;;; on a tbnl:session-value named by the type-name. The hash-table is keyed
;;; by components classifying the error. All errors fitting that classifcation
;;; are stored with the key. (Should have been called 'def-keyed-errors')
(defmacro def-unique-errors (type-name (&key key (url-prefix "/validator/xml-example")) &body body)
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
      (defmethod url-xml-example ((type (eql ',type-name)) key)
	"Return a URL to xml-example. URL parameters are key and type."
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
		  (format stream "<br/>~A" (url-xml-example type key)))))))))

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
    (defmethod url-xml-example ((type (eql ',type-name)) keys)
      "Return a URL to xml-example. URL parameters are keys and type."
      (declare (ignore keys))
       (strcat
	(format nil "<a href='~A/validator/xml-example?one-key=true&type=~A'>" 
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
	(format stream "<br/>~A" (url-xml-example type nil))))))

;;;==========================================
;;; Conditions
;;;==========================================
;;; POD May want to expand this so that it can do things without use of clos. 
;;; (LW uses clos for conditions, but it isn't required.)

(defmacro defcondition (name superclasses slots &rest options)
  `(progn
     (define-condition ,name ,superclasses ,slots
       (:documentation ,(cadr (assoc :documentation options)))
       (:report ,(cadr (assoc :report options))))
     (setf (get :title ',name) ,(cadr (assoc :title options)))
     (setf (get :id-num ',name) ,(or (cadr (assoc :id-num options)) 1000))
     (setf (get :explanation ',name) ,(cadr (assoc :explanation options)))
     (export ',name)))

;;;==== End MOFI Stuff
(define-condition tlogic-warning (simple-warning)
  ((xml :initarg :xml :initform nil)
   (red-regex :initform nil))
  (:documentation "Abstract condition. Superclass of others here."))

(define-condition template-warning (tlogic-warning)
  ())

(define-condition instance-warning (tlogic-warning)
  ())

(define-condition template-error (error)
  ()
  (:documentation "Abstract condition. Superclass of others here."))

(define-condition instance-error (error)
  ()
  (:documentation "Abstract condition. Superclass of others here."))


(defun url-relevant-xml (next-text-length)
  (let* ((url (tbnl:request-uri tbnl:*request*))
	 (url-minus-len (subseq url 0 
				(search "&text-length=" url))))
    (format nil "<a href='~A&text-length=~A'>&nbsp;&nbsp;...more</a>" 
	    url-minus-len next-text-length)))

(defmethod tlogic-relevant-xml ((c t))
  "Return the chunk of html describing the xml implicated in condition C."
  (with-slots (xml red-regex) c
    (if xml
	(with-output-to-string (out)
	  (let* ((str (with-output-to-string (s) (xml-utils:xml-write-node xml s)))
		 (len (length str))
		 (textlen (if-bind (len (safe-get-parameter "text-length")) 
				   (read-from-string len) 512))
		 (pretty (pretty-xml
			  (if (> len textlen) 
			      (strcat (cl-who:escape-string (subseq str 0 textlen))
				      (url-relevant-xml (* textlen 4)))
			      (cl-who:escape-string str)))))
	    (write-string "<h3>Your file contains:</h3>" out)
	    (if (null red-regex)
		(write-string pretty out)
		(mvb (success vec) (cl-ppcre:scan-to-strings red-regex pretty)
		  (if success
		      (write-string (cl-ppcre:regex-replace 
				     (aref vec 0)
				     pretty 
				     (format nil "<font color='red'>~A</font>" (aref vec 0)))
				    out)
		      (write-string pretty out))))))
	"")))

(defun pretty-xml  (str)
  "Remove blank lines and insert &nbsp; etc to make xml print nicer."
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


;;;================= Instance Processing (1 series) =========================

(defcondition instance-unknown-type (instance-warning)
  ((type-name :initarg :type-name))
  (:id-num 1)
  (:title "Type referenced in the instance cannot be resolved")
  (:documentation "A type referenced in an instance cannot be resolved")
  (:explanation "A type referenced in the template definition cannot be resolved.
    <p/>This error is reported in post-processing of the instance.")
  (:report 
    (lambda (err stream)
      (with-slots (type-name red-regex) err
	(setf red-regex (format nil "(~A)" (string type-name)))
	(format stream "<strong>The type ~A, cannot be resolved.</strong> ~A" 
		type-name (tlogic-relevant-xml err))))))

(def-combine-errors instance-unknown-type
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition instance-role-type-violation (instance-warning)
  ((type-name :initarg :type-name))
  (:id-num 2)
  (:title "Value provided not consistent with template role type")
  (:documentation "A role value provided is not consistent with template role type")
  (:explanation "Template instances reference template definitions. These template definitions define
     types restrictions on the value provided by instances for each template role. 
     This instance provides values for a role that is inconsistent with type restriction
     of that role.
    <p/>This error is reported in post-processing of the instance.")
  (:report 
    (lambda (err stream)
      (with-slots (type-name red-regex) err
	(setf red-regex (format nil "(~A)" (string type-name)))
	(format stream "<strong>The type ~A, cannot be resolved.</strong> ~A" 
		type-name (tlogic-relevant-xml err))))))

(def-combine-errors instance-role-type-violation
  (format nil "Value provided violates template role type."))

(defcondition instance-local-deref-failure (instance-warning)
  ((ref :initarg :ref)
   (tmpl :initarg :tmpl)
   (inst :initarg :inst)
   (role :initarg :role))
  (:id-num 3)
  (:title "Template instance local reference is not resolved")
  (:documentation "A local reference in the template instance could not be resolved")
  (:explanation "The template instance makes a reference through a UUID that could
    not be resolved. 
    <p/>This error is reported while instantiating from a template definition.")
  (:report
   (lambda (err stream)
     (with-slots (ref tmpl role red-regex) err
	(setf red-regex (format nil "(~A)" ref))
	(format stream "<strong>The local reference ~A in ~A.~A cannot be resolved.</strong> ~A" 
		ref (class-name tmpl) role (tlogic-relevant-xml err))))))

(def-unique-errors instance-local-deref-failure (:key (tmpl role)) ()
  (format nil "References to template ~A role ~A are not unique."
	  tmpl role))

(defcondition instance-role-name-failure (instance-warning)
  ((tmpl :initarg :tmpl)
   (inst :initarg :inst)
   (role-name :initarg :role-name))
  (:id-num 4)
  (:title "The template instance references a role name not defined in the template")
  (:documentation "The template instance references a role name not in the template")
  (:explanation "The template instance makes a reference to a role name that 
    is not found in the template definition. 
    <p/>This error is reported while instantiating from a template definition.")
  (:report
   (lambda (err stream)
     (with-slots (tmpl inst role-name red-regex) err
	(setf red-regex (format nil "(~A)" role-name))
	(format stream "<strong>The template instance ~A reference a role '~A' not found in template ~A.</strong> ~A" 
		inst role-name (phttp:url-template tmpl) (tlogic-relevant-xml err))))))

(def-unique-errors instance-role-name-failure (:key (tmpl role-name)) ()
  (format nil "Template ~A does not have a role named ~A."
	  tmpl role-name))

;;;================= Template Definitions (100 series) ===========================  
(defcondition axiom-no-logic-text (template-warning)
  ()
  (:id-num 101)
  (:title "No logical form")
  (:documentation "No logical form was provided in the template definition")
  (:explanation
   "Template definitions typically provide a biconditional logical form relating
    the signature to a collecton of Data Model objects. This one didn't do that.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (declare (ignore err))
      (format stream "<strong>The template did not specify a template axiom and none is 
       available in any parent templates.</strong>"))))

(def-combine-errors axiom-no-logic-text
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition axiom-wrong-arity-triple (template-warning)
  ((atom :initarg :atom))
  (:id-num 102)
  (:title "Proto-template, but not a triple")
  (:documentation "A proto-template triple (RTriple z, x, y) has wrong arity")
  (:explanation
   "In processing the template logical form, a statement was encountered whose 
    predicate symbol suggests it is a proto-template, but the arity is wrong.
     RTriple(z,x,y) <=> (and (R z) (hasR1 z x) (hasR2 z y)
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (atom) err
	(format stream "<strong>Predicate ~A looks like a proto-template triple, but has incorrect arity.</strong>" 
		(stringify! atom nil))))))

(def-combine-errors axiom-wrong-arity-triple
  (format nil "Object detail is provided through an unresolved URI reference."))


;;; POD How is this different from the above???
(defcondition axiom-wrong-arity-proto-template (template-warning)
  ((atom :initarg :atom))
  (:id-num 103)
  (:title "Proto-template, but not a triple")
  (:documentation "A proto-template form (RTemplate x, y) has wrong arity")
  (:explanation
   "In processing the template logical form, a statement was encountered whose 
    predicate symbol suggests it is a proto-template, but the arity is wrong.
    (RTemplate x y) <=> (exists z (RTriple z x y))
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (atom) err
	(format stream "<strong>Predicate ~A looks like a proto-template, but has incorrect arity.</strong>" 
		(stringify! atom nil))))))

(def-combine-errors axiom-wrong-arity-proto-template
  (format nil "Object detail is provided through an unresolved URI reference."))


;;; Roles
(defcondition axiom-role-count-wrong (template-warning)
  ((actual :initarg :actual)
   (declared :initarg :declared))
  (:id-num 104)
  (:title "Proto-template, but not a triple")
  (:documentation "The number of roles encountered not consistent with p7tm:valNumberOfRoles")
  (:explanation
   "In processing the template logical form, the value of p7tm:valNumberOfRoles is different
    than the number of role objects encountered while processing roles.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (actual declared) err
	(format stream "<strong>The OWL file p7tm:valNumberOfRoles declares that there are ~A roles 
                        but ~A ~A were found.</strong>"
		(if (< actual declared) " only " "")
		declared actual)))))

(def-combine-errors axiom-role-count-wrong
  (format nil "Object detail is provided through an unresolved URI reference."))

#+nil
(define-condition template-unknown-predicate (tlogic-warning)
  ((atom :initarg :atom))
  (:report 
    (lambda (err stream)
      (with-slots (atom) err
	(format stream "~A looks like it names a relational predicate, but is unknown." 
		(stringify! atom nil))))))

(defcondition axiom-type-consistency (template-warning)
  ((var :initarg :var)
   (type1 :initarg :type1)
   (type2 :initarg :type2))
  (:id-num 105)
  (:title "Logical form type declarations not consistent")
  (:documentation "The binding of a variable in the logical form is not consistent")
  (:explanation "The variable cited is used in multiple roles, the types required by 
    those roles are differ and are not compatible with each other.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (var type1 type2) err
	(format stream "<strong>Variable ~A is used in roles of type ~A and ~A. 
                         It is likely that that is not what is intended.</strong>" 
		var 
		(mofb:url-class-browser (find-class (intern type1 :part2) nil) :force-text (p2name2p7name type1))
		(mofb:url-class-browser (find-class (intern type2 :part2) nil) :force-text (p2name2p7name type2)))))))

(def-combine-errors axiom-type-consistency
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-unknown-metatype (template-warning)
  ((tmpl :initarg :tmpl))
  (:id-num 106)
  (:title "Template did not declare its metatype")
  (:documentation "The metatype of the template was not declared")
  (:explanation "The metatype of the template was not declared.
    <p/>This error is reported in post-processing of template definitions.")
  (:report
   (lambda (err stream)
     (with-slots (tmpl) err
       (format stream "<strong>The template ~A did not declare its metatype.</strong>" tmpl)))))

(def-combine-errors template-unknown-metatype
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-unresolved-class (template-warning)
  ((class-name :initarg :class-name))
  (:id-num 107)
  (:title "A class referenced in the template could not be resolved")
  (:documentation "A class reference in the template could not be resolved")
  (:explanation "A class reference in the template could not be resolved
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (class-name red-regex) err
	(setf red-regex (format nil "(~A)" (string class-name)))
	(format stream "<strong>The class name ~A did not resolve to any term in an RDL.</strong> ~A" 
		class-name (tlogic-relevant-xml err))))))

(def-combine-errors template-unresolved-class
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-type-mismatch (template-warning)
  ((from-owl :initarg :from-owl)
   (from-role-spec :initarg :from-role-spec))
  (:id-num 108)
  (:title "Types declared in the template definition are not consistent.")
  (:documentation "Types declared in the template definition are not consistent")
  (:explanation "Template definitions define role types through owl:allValuesFrom and 
     p7tm:hasRoleFillerType the values provided by these two forms are not consistent.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (from-owl from-role-spec) err
	(format stream "<strong>In owl:allValuesFrom ~A was specified; in p7tm:hasRoleFillerType ~A.</strong>"
		from-owl from-role-spec)))))

(def-combine-errors template-type-mismatch
  (format nil "Object detail is provided through an unresolved URI reference."))


;;;                    <owl:onProperty rdf:resource="hasUrFunctionPlace"/>
(defcondition template-no-such-role (template-warning)
  ((role-name :initarg :role-name))
  (:id-num 109)
  (:title "No such role")
  (:documentation "The template role described by a owl:onProperty does not exist")
  (:explanation "An subclass of BaseTemplateStatement defines a restriction for
      which the object referenced as onProperty cannot be resolved.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (role-name red-regex) err
	(setf red-regex (format nil "(~A)" (string role-name)))
	(format stream "<strong>The template does not have a role named '~A'.</strong> ~A"
		role-name (tlogic-relevant-xml err))))))

(def-combine-errors template-no-such-role
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-unknown-type (template-warning)
  ((type-name :initarg :type-name))
  (:id-num 110)
  (:title "Type in template definition or instance cannot be resolved")
  (:documentation "A type referenced in the template definition cannot be resolved")
  (:explanation "A type referenced in the template definition cannot be resolved.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (type-name red-regex) err
	(setf red-regex (format nil "(~A)" (string type-name)))
	(format stream "<strong>The type ~A, cannot be resolved.</strong> ~A" 
		type-name (tlogic-relevant-xml err))))))

(def-combine-errors template-unknown-type
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-cannot-resolve-base-template (template-warning)
  ((base-name :initarg :base-name))
  (:id-num 111)
  (:title "The base template reference cannot be resolved")
  (:documentation "A base template referenced in the template definition cannot be resolved")
  (:explanation "The base template referenced in the template definition cannot be resolved.
    <p/>This error is reported in post-processing of template definitions.")
  (:report 
    (lambda (err stream)
      (with-slots (base-name) err
	(format stream "<strong>Could not resolve the base template name '~A'.</strong>" base-name)))))

(def-combine-errors template-cannot-resolve-base-template
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-missing-namespace (template-warning)
  ((ns :initarg :ns))
  (:id-num 112)
  (:title "Namespace unknown")
  (:documentation "A namespace is used in a significant role, yet was not be resolved")
  (:explanation "A namespace is used in a significant role, yet was not be resolved
    <p/>This error is reported in post-processing of template definitions.")
  (:report
    (lambda (err stream)
      (with-slots (ns) err
	(format stream "<strong>Could not find namespace ~A.</strong>"
		(package-name (find-package ns)))))))

(def-combine-errors template-missing-namespace
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition template-xml-no-rdfs-label (template-warning)
  ()
  (:id-num 113)
  (:title "Template definition, no rdfs:label")
  (:documentation "The template definition does not define an rdfs:label")
  (:explanation "An owl:Class appears to be defining a template but does not specify 
    the template's name (rdfs:label).
    <p/>This error is reported in post-processing of template definitions.")
  (:report
   (lambda (err stream)
     (format stream "<strong>XML element looks like a owl:Class defining a template, 
                       but doesn't contain an rdfs:label.</strong> ~A" 
	     (tlogic-relevant-xml err)))))

(def-combine-errors template-xml-no-rdfs-label
  (format nil "Object detail is provided through an unresolved URI reference."))

;;;================= Parsing Conditions (1000 series) ======================
(define-condition tlogic-parse-error (error) 
  ((tag :initarg :tag :initform nil)
   (tags :initarg :tags :initform nil)
   (expected :initarg :expected :initform nil)
   (actual :initarg :actual :initform nil)
   (line-number :initarg :line-number :initform nil)
   (template :initarg :template :initform *tmpl*) ; POD maybe not a good idea???
   (red-regex :initform nil))
  (:documentation "Abstract condition. Superclass of others here."))

(defcondition axiom-parse-token-error (tlogic-parse-error)
  ()
  (:id-num 1001)
  (:title "Template axiom parsing error")
  (:documentation "The was a grammatical error in the template axiom")
  (:explanation "The template definition axiom had a grammatical error.
    <p/>This error is reported while parsing a template definition axiom.")
  (:report (lambda (err stream)
	     (with-slots (tags expected actual) err
	       (format stream "<strong>~A : expected ~A  got '~A'</strong>"
		       (car tags)
		       (if (stringp expected) expected (format nil "'~A'" expected))
		       actual)))))
;	       (format stream "~%<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(def-combine-errors axiom-parse-token-error
  (format nil "Object detail is provided through an unresolved URI reference."))

(defcondition axiom-parse-incomplete (tlogic-parse-error)
  ((actual :initarg :actual))
  (:id-num 1002)
  (:title "Template axiom incomplete")
  (:documentation "The parsing of a template axiom could not be completed")
  (:explanation "Parsing of a template axiom could not be completed 
    because of a grammatical error. For example, parentheses did not balance
    <p/>This error is reported while parsing a template definition axiom.")
  (:report 
    (lambda (err stream)
      (with-slots (actual) err
	(format stream "<strong>Syntax Error: Parse ended with input remaining. Current token: ~A</strong>" actual)))))
;	(format stream "~%<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(def-combine-errors axiom-parse-incomplete
  (format nil "Object detail is provided through an unresolved URI reference."))


(defcondition axiom-unbound-variable (tlogic-parse-error)
  ((var :initarg :var))
  (:id-num 1003)
  (:title "Template axiom uses a variable before declaring it")
  (:documentation "The template axiom uses a variable before declaring it")
  (:explanation "The template axiom uses a variable before declaring it. 
    Note that by convention the axiom shall be stated as a bi-conditional with 
    the left hand side being a single form representing the signature of
    the template. All of the variables in this signature are assumed to be 
    universally quantified with a lexical scope that includes the right hand
    side of that bi-conditional. All other variables must by explicitly declared
    through an 'exists' or (at least in principal) a forall form.
    <p/>This error is identified while parsing a template definition axiom.")
  (:report 
    (lambda (err stream)
      (with-slots (var) err
	(format stream "<strong>Syntax Error: The variable ~A is unbound.</strong>" var)))))
;	(format stream "~%<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)

(def-combine-errors axiom-unbound-variable
  (format nil "Object detail is provided through an unresolved URI reference."))


(defcondition axiom-duplicate-variable-lhs (tlogic-parse-error)
  ((vars :initarg :vars))
  (:id-num 1004)
  (:title "Template axiom LHS introduces the same variable multiply.")
  (:documentation "The template axiom LHS introduces the same variable multiply")
  (:explanation "The template axiom introduce the same variable multiply in 
    a single scope of the LHS.
    <p/>This error is identified while parsing a template definition axiom.")
  (:report 
    (lambda (err stream)
      (with-slots (vars) err
	(format stream "<strong>Syntax Error: Duplicate variables in the biconditional LHS: ~{~A~^,~}</strong>" vars)))))
;	(format stream "~%<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(def-combine-errors axiom-duplicate-variable-lhs
  (format nil "Object detail is provided through an unresolved URI reference."))




