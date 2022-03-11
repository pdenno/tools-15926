
;;; Purpose: Analyze axiom using P2 elements

(in-package :tlogic)

;;; - Check that the number of {Roles} = number of rules in LHS, and conjuncts of RHS enforce these. 
;;; - Expand xTemplate and xTriple
;;; - Check that the type referenced actually exists
;;; - Check that type has property referenced
;;; - Bind variables (to type or instance?)

(defmethod print-object ((obj odm-cl:|AtomicSentence|) stream)
  (format stream "<AtomS (~A ~{~A~^,~}) id=~A>" 
	  (elip (odm:%predicate obj) 12)
	  (odm:%argument obj)
	  (mofi:%debug-id obj)))

(defvar *bindings* nil "Dynamically bound to bindings.")
(defstruct binding
  ;; A construct that creates a scope (Existential and Universal quantifications)
  (-scope nil) 
  ;; a list of either (var) or (var . type)
  (-pairs nil))

;;; This could be smarter: it could update existing bindings to a more specific type, 
;;; and otherwise, push a new binding. 
(defun add-pair (var type)
  "Add a binding pair (VAR . TYPE) to the binding struct at head of *bindings*."
  (pushnew (cons var type) (binding--pairs (car *bindings*)) :test #'equal))

(defgeneric discover-bindings (form))
(defgeneric infer-bindings (form))
(defgeneric validate (form bindings))

(defun validate-template (tmpl)
  "Analyze a template for errors, pushing conditions into its conditions slot.
   There may already be something in tmpl.conditions, from reading..."
  (setf *tmpl* tmpl) ; Used to set template slot in some error conditions (tlogic-parse-error)
  (with-slots (conditions) tmpl
    (let ((*error-output* *null-stream*))
      (handler-bind ((error #'(lambda (c) (push c conditions) (return-from validate-template)))
		     (simple-warning #'(lambda (c) (push c conditions) (muffle-warning))))
	(validate-roles tmpl)
	(let ((*bindings* nil))
	  (declare (special *bindings*))
	  (with-slots (logic-text logic) tmpl
	    (if logic-text 
	      (progn (setf logic (tlogic2lisp logic-text))
		     (discover-bindings logic)
		     (infer-bindings logic)
		     (validate logic *bindings*))
	      (warn 'axiom-no-logic-text)))
	  *bindings*)))))

;;;  #<PURI:URI http://rds.posccaesar.org/2008/06/OWL/RDL#RDS364686618>
(defun validate-roles (tmpl)
  "Check number of roles and call to validate each role."
  (with-slots (roles number-of-roles) tmpl
      (when number-of-roles
	(unless (= (length roles) number-of-roles)
	  (warn 'axiom-role-count-wrong :actual (length roles) :declared number-of-roles)))
      (loop for role in roles
	 do (validate-role role))))

(defun validate-role (r)
  (declare (ignore r)))

#+nil ;;; It is not an error for a role to be filled by a possible individual.
(defun validate-role (r)
  "Check for appropriate type"
  (with-slots ((uri type)) r
    (when (typep uri 'puri:uri)
      (when (and (string= (puri:uri-host uri) "rds.posccaesar.org")
		 (string= (puri:uri-path uri) "/2008/06/OWL/RDL"))
	;; Then the type is defined in the RDL. 
	(when-bind (type (rds-lookup-type (puri:uri-fragment uri)))
	  (let ((ruri (puri:parse-uri type)))
	    (when (member (find-class (intern "POSSIBLE_INDIVIDUAL" :p2))
			  (class-precedence-list 
			   (mofb::class2iclass 
			    (find-class
			     (intern
			      (string-upcase
			       (c-name2lisp (puri:uri-fragment ruri) :dash #\_))
			      :p2)))))
	      (with-slots (name) r
		(warn 'tlogic-role-type-individual :role-name name)))))))))


(defmethod discover-bindings ((form odm-cl:|UniversalQuantification|))
  (let ((b (make-binding :-scope form :-pairs (mapcar #'(lambda (var) (cons var "THING")) (odm:%binding form)))))
    (push b *bindings*)
    (discover-bindings (odm:%body form))))

(defmethod discover-bindings ((form odm-cl:|ExistentialQuantification|))
  (let ((b (make-binding :-scope form :-pairs (mapcar #'(lambda (var) (cons var "THING")) (odm:%binding form)))))
    (push b *bindings*)
    (discover-bindings (odm:%body form))))

(defmethod discover-bindings ((form odm-cl:|Biconditional|))
  (discover-bindings (odm:%rvalue form))) ; POD there are no biconditionals except at the toplevel.

(defmethod discover-bindings ((form odm-cl:|Conjunction|))
  (mapcar #'discover-bindings (odm:%conjunct form)))

;;; POD All of the predicates should mean something; if they don't, warn. ... hmmm, 
;;; there are unary predicates that should resolve to things in RDLs, maybe this comment
;;; only applies to binary predicates (relations) for which there is nothing in Part 2. 
(defmethod discover-bindings ((form odm-cl:|AtomicSentence|))
  "Update the bindings structure with binding pairs (type information) evident 
   from unary predicates and the types of roles in relations."
  (let ((arity (predicate-arity form)) type-name)
    (cond ((= arity 1) ; Unary, bind arg to type named by predicate
	   (add-pair (car (odm:%argument form)) (p7name2p2name (odm:%predicate form))))
	  ((and (= arity 2) (setf type-name (proto-template-p form))) ; proto-template
	   (when-bind (type (find-iclass (p7name2p2name type-name)))
	     (when-bind (ptroles (proto-roles type))
	       (let ((args (odm:%argument form)))
		 (add-pair (first args)  (translate-etype (first ptroles)))
		 (add-pair (second args) (translate-etype (second ptroles)))))))
	  ((and (= arity 3) (setf type-name (proto-triple-p form))) ; proto-triple
	   (when-bind (type (find-iclass (p7name2p2name type-name)))
	     (when-bind (ptroles (proto-roles type))
	       (let ((args (odm:%argument form)))
		 (add-pair (first args) (p7name2p2name type-name)) ; 2012-11-08
		 (add-pair (second args) (translate-etype (first ptroles)))
		 (add-pair (third  args) (translate-etype (second ptroles))))))))))

(defmethod infer-bindings ((form odm-cl:|UniversalQuantification|))
  "These do additional type inference on variable using classification."
  (infer-bindings (odm:%body form)))

(defmethod infer-bindings ((form odm-cl:|ExistentialQuantification|))
  (infer-bindings (odm:%body form)))

(defmethod infer-bindings ((form odm-cl:|Biconditional|))
  (infer-bindings (odm:%rvalue form))) ; POD there are no biconditionals except at the toplevel.

(defmethod infer-bindings ((form odm-cl:|Conjunction|))
  (mapcar #'(lambda (x) 
	      (infer-bindings x)) (odm:%conjunct form)))

;;; POD All of the predicates should mean something; if they don't, warn. ... hmmm, 
;;; there are unary predicates that should resolve to things in RDLs, maybe this comment
;;; only applies to binary predicates (relations) for which there is nothing in Part 2. 
(defmethod infer-bindings ((form odm-cl:|AtomicSentence|))
  "Add bindings using an inference on ClassificationTemplate assertions."
  (let ((arity (predicate-arity form)))
    (cond ((and (= arity 2) (String= (odm:%predicate form) "ClassificationTemplate"))
	   (when-bind (classifier (cdr (find-binding (second (odm:%argument form)) form)))
	     (let* ((var1 (first (odm:%argument form)))
		    (quant (defining-quantifier var1 form)))
	       (when-bind (meta-1 (or (find classifier *defined-classification-relations* 
					    :key #'car :test #'string=)
				      (find classifier *intended-classification-relations* 
					    :key #'car :test #'string=)))
		 (if-bind (b (find quant *bindings* :key #'binding--scope))
			  (progn
			    (pushnew (cons var1 (second meta-1)) (binding--pairs b))
			    #|(format t "~% inferred binding: ~A" (cons var1 (second meta-1)))|#)
			  (warn "Could not find scope for binding inference.")))))))))

(defun defining-quantifier (var form)
  "Return the nearest enclosing quantifier of FORM."
  (loop for f = form then (mofi:%source-elem f)
        while f
        when (and (typep f 'odm-cl::|QuantifiedSentence|) ; POD not exported?
		  (find var (odm:%binding f) :test #'string=))
        return f))

;;; mofi:%source-elem is used like uml:%owner.
(defun find-binding (var form)
  "Return the binding of VAR in FORM an AtomicSentence (typically?)."
  (when-bind (quantifier (defining-quantifier var form))
    (when-bind (b (find quantifier *bindings* :key #'binding--scope))
      (assoc var (binding--pairs b) :test #'string=))))


(defun proto-roles (type)
  "Return a list of two elements: the range types ('translated') of
   the attributes assigned to in the proto-template/proto-triple TYPE. 
   TYPE is an expo:i-e-e-t."
  (let* ((slots (class-slots type))
	 (len (length slots)))
    (list
     (expo::slot-definition-range (nth (- len 2) slots))
     (expo::slot-definition-range (nth (- len 1) slots)))))

(defun translate-etype (type)
  "Translate an expo type to a class or keyword."
  (typecase type
    (expo:integer-typ :number)
    (expo:real-typ    :number)
    (expo:string-typ :string)
    (symbol (string type))
    (t nil)))
  
;;;==============
(defmethod validate ((form odm-cl:|UniversalQuantification|) bindings)
  (check-type-consistency bindings)
  (validate (odm:%body form) bindings))

(defmethod validate ((form odm-cl:|ExistentialQuantification|) bindings)
  (validate (odm:%body form) bindings))

(defmethod validate ((form odm-cl:|Biconditional|) bindings)
  (validate (odm:%rvalue form) bindings)) ; POD there are no biconditionals except at the toplevel.

(defmethod validate ((form odm-cl:|Conjunction|) bindings)
  (mapcar #'(lambda (f) (validate f bindings)) (odm:%conjunct form)))

(defmethod validate ((form odm-cl:|AtomicSentence|) bindings)
  (when (proto-triple-p form)
    (unless (= 3 (predicate-arity form))
      (warn 'axiom-wrong-arity-triple :atom form)))
  (when (proto-template-p form)
    (unless (= 2 (predicate-arity form))
      (warn 'axiom-wrong-arity-proto-template :atom form))))

(defun type-consistent-p (t1 t2)
  "Return T if T1 and T2 (strings naming P2 types) are type compatible."
  (let ((t1 (find-class (intern t1 :part2) nil))
	(t2 (find-class (intern t2 :part2) nil))
	(it1 (find-iclass (intern t1 :part2)))
	(it2 (find-iclass (intern t2 :part2))))
    (cond ((not (and t1 t2)) t)
	  ((or 
	    (find t1 (cdr (class-precedence-list it2)))
	    (find t2 (cdr (class-precedence-list it1))))))))

(defun check-type-consistency (bindings)
  "Check the bindings of each variable in each scope for type consistency."
  (loop for scope in bindings 
        for pairs = (binding--pairs scope) do
       (loop for var in (remove-duplicates (mapcar #'car pairs) :test #'string=)
	     for types = (loop for p in pairs when (string= var (car p)) collect (cdr p)) do
	    (loop for ty in types
                  for others on types do
		 (loop for o in others
		      unless (type-consistent-p ty o) do
                      (warn 'axiom-type-consistency :var var :type1 ty :type2 o))))))

;;; RTriple(z,x,y) <-> (and (R z) (hasR1 z x) (hasR2 z y)) 
;;; If T inherits its roles from R: (TTriple z x y) -> (and (T z) (RTriple z x y))
(defvar *indent* 0 "Current indent, dynamically bound.")
(defun n-nbsp (n) 
  "Return a string containgin 3*N &nbsp;s."
  (with-output-to-string (str)
    (loop for i from 1 to n do (format str "~A" "&nbsp;&nbsp;&nbsp;"))))

(defgeneric stringify (obj stream))
(defgeneric stringify! (obj stream))

(defmethod stringify ((obj odm-cl:|UniversalQuantification|) stream)
  (setf *indent* 0)
  (stringify (odm:%body obj) stream))

(defmethod stringify ((obj odm-cl:|Biconditional|) stream)
  (stringify (odm:%lvalue obj) stream)
  (format stream "<br/>&lt;--&gt;")
  (stringify (odm:%rvalue obj) stream))

(defmethod stringify ((obj odm-cl:|ExistentialQuantification|) stream)
  (format stream "~%<br/>~A~{exists ~A ~}" (n-nbsp *indent*) (odm:%binding obj))
  (format stream "~%~A(" (n-nbsp (incf *indent*)))
  (stringify (odm:%body obj) stream)
  (format stream ")")
  (decf *indent*))

(defmethod stringify ((obj odm-cl:|Conjunction|) stream)
  (let ((juncts (loop for c in (odm:%conjunct obj)
		   collect (format nil "~A~A" 
				   (n-nbsp *indent*) 
				   (with-output-to-string (str) (stringify c str))))))
    (format stream "~{~A~^&nbsp;&amp;~}" juncts)))

(defmethod stringify ((obj odm-cl:|AtomicSentence|) stream)
  (format stream "~%<br/>~A~A(~{~A~^,&nbsp;~})" 
	  (n-nbsp *indent*) 
	  (odm:%predicate obj)
	  (mapcar #'(lambda (a) (stringify a nil)) (odm:%argument obj))))

(defmethod stringify! ((obj odm-cl:|AtomicSentence|) stream)
  (format stream "~A(~{~A~^,&nbsp;~})" 
	  (odm:%predicate obj)
	  (mapcar #'(lambda (a) (stringify a nil)) (odm:%argument obj))))

(defmethod stringify ((obj pod:string-const) stream)
  (format stream "'~A'" (string-const--value obj)))

(defmethod stringify ((obj t) stream)
   (format stream "~A" obj))
  
