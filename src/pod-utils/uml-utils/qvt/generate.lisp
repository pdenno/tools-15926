
;;; Purpose: Generate lisp forms for a QVT mapping specification.

(in-package :qvt)

(defparameter *stream* *standard-output*
  "Dynamically bound so that it doesn't need to be passed in to every method.")

;;; These are the methods generated. 
(defgeneric qvt-go (transformation))
(defgeneric root-var (obj))
(defgeneric relation-check   (relation domain bindings))
(defgeneric relation-enforce (relation domain bindings))
(defgeneric relation-executor (relation bindings))
(defgeneric key-completer (relation bindings))
(defgeneric when-where (relation bindings))

(declaim (inline home-pkg))
(defun home-pkg ()
  (declare (special *map-info*))
  (mofi:lisp-package (qvt-map-model *map-info*)))

(declaim (inline logic-var-p))
(defun logic-var-p (obj)
  "Returns T if OBJ is an logic variable. (starts with '?')."
  (and (symbolp obj)
       (eql (symbol-package obj) (home-pkg))
       (char= #\? (char (string obj) 0))))

(declaim (notinline mk-logic-var)) ; temporary not inline
(defun mk-logic-var (arg)
  ;(when (eql #\? (char (string str) 0)) (break "already a variable"))
  (cond ((eql arg :ordinary-ocl) arg)
	((keywordp arg) (break "argument is a keyword"))
	((logic-var-p arg) arg)
	(t (intern (strcat "?" (string arg)) (home-pkg)))))

(declaim (inline logic-var-p))
(defun accessor-p (obj)
  "Returns T if OBJ is an object accessor.  (start with '%')."
  (and (symbolp obj)
       (eql #\% (char (string obj) 0))))

(declaim (notinline domain-nick))
(defun domain-nick (d &key interned)
  "Return the nickname (a string) of domain D."
  (with-vo ((info qvt-map-info))
    (let ((str (car (find d (qvt-nicknames info) :key #'cdr))))
      (if interned
	  (intern str (home-pkg))
	  str))))

;;; Default method, for when no WHEN, no WHERE. 
(defmethod when-where ((rel T) bindings) bindings)
  
(defgeneric qvt2lisp (obj &key &allow-other-keys))

(defmethod qvt2lisp ((obj |QVTToplevel|) &key (stream *standard-output*))
   (let ((*stream* stream))
    (let ((*package* (home-pkg))
	  (*print-level* nil)
	  (*print-length* nil)
	  (*print-miser-width* nil)
	  (*print-lines* nil)
	  (*print-pretty* t))
      (qvt2lisp (%transformation obj)))))

(defmethod qvt2lisp ((obj |RelationalTransformation|) &key)
  (with-slots (|ownedKey| |rule| |function| |name|) obj
    (format *stream* "~%;;; Generated ~A using qvt2lisp. " (now))
    (format *stream* "~2%(in-package ~S)" |name|)
    (pp-go-method obj)
    (pp-key-info |ownedKey|)
    (loop for relation in |rule| do
	 (qvt2lisp relation))
    (pp-functions |function|))
  (format *stream* "~2%;;; End of file.")
  obj)

(defmethod pp-go-method ((obj |RelationalTransformation|))
  (with-slots (|rule| |name|) obj
    (let ((tops (loop for r in |rule| when (eql :true (%is-top-level r)) collect r)))
      (format *stream*
	      "~2%~S"
	      `(defmethod qvt-go ((trans (eql ',(intern |name| (home-pkg)))))
		"Toplevel method to execute all top relations"
		(format t "~2%++++++++++++ QVT Execution started ~A +++++++++++" (now))
		(let ((mofi:*model* (mofi:find-model ,|name| :session-too t)))
		  ,@(loop for r in tops
			  collect `(relation-executor ',(intern (%name r) (home-pkg)) nil))))))))

(defmethod qvt2lisp ((obj (eql nil)) &key)
  "Default for when no data" nil)

(defmethod qvt2lisp ((rel |Relation|) &key)
  (with-slots (|name| |domain| |when| |where|) rel
      (let ((roots (mapcar #'(lambda (d) (mk-logic-var (root-var d))) |domain|))
	    ;(check-name (intern (domain-nick (mofi:find-model :uml241)))) ; POD HACK!!!
	    (check-name nil)
	    (enforce-name nil)
	    (rel-name (intern |name| (home-pkg))))
	    ;; POD This isn't correct! The domain can be declared neither check nor enforce (e.g primitive )
	    ;; and further, 2010-06-19 nicknames (a list)
	(when-bind (c-domain (car (checkonly-domains-of rel))) ;(find-if #'qvt::%is-checkable |domain|))
	  (setf check-name  (intern (domain-nick (%typed-model c-domain)) (home-pkg))))
	(when-bind (e-domain (car (enforce-domains-of rel))) ; (find-if #'qvt::%is-checkable |domain|))
	  (setf enforce-name (intern (domain-nick (%typed-model (find-if #'qvt::%is-enforceable |domain|))) (home-pkg))))
	(format *stream* "~2%;;; ========== Relation ~A  ==========~%" rel-name)
	(pp-executor rel-name enforce-name check-name roots)
	(when (or |when| |where|) (pp-when-where rel))
	;; Generate check, enforce and key-completer methods.
	(loop for d in |domain| do (qvt2lisp d :relation-name (intern |name| (home-pkg)))))))

;;;=========================================
;;; Relation-executor
;;;=========================================
(defun pp-executor (rel-name enforce-name check-name roots)
  "Pretty print the relation-executor function."
  (declare (ignore where-lisp))
  (format *stream* "~%~S"
	  `(defmethod relation-executor ((rel (eql ',rel-name)) bindings)
	    "The mapping function of the relation, returns a list of binding sets for the argument variables."
	    (loop for checkset in (catch :no-match (relation-check ',rel-name ',check-name bindings))
	          for whenbinds = (catch :when-failed
				    (when-where ',rel-name (append-binds bindings checkset)))
     	          for key-completed = (when whenbinds
					(key-completer ',rel-name (append-binds bindings checkset whenbinds)))
	          for combined = (when whenbinds
				   (append-binds bindings checkset whenbinds key-completed))
	          when whenbinds do 
	          (relation-enforce ',rel-name ',enforce-name combined)
	          and collect (binds-keep-only combined ',roots)))))

(defvar *vars-in-scope* nil "Dynamically bound to collect variables.")

(defmethod qvt2lisp ((domain |RelationDomain|) &key relation-name)
  "Generate a lisp method for a domain pattern."
  (let ((domain-nick (intern (domain-nick (%typed-model domain)) (home-pkg))))
    (cond ((%is-enforceable domain)
	   (pp-relation-enforce domain domain-nick relation-name)
	   (pp-key-completer domain relation-name))
	  (t
	   (pp-relation-check domain domain-nick relation-name)))
    t))

;;;=========================================
;;; When-where
;;;=========================================
(defmethod pp-when-where ((rel |Relation|) &key)
  (with-slots (|name| |domain| |when| |where|) rel
    ;; The set of variables that can be sent are the variables used in the checkonly domains plus
    ;; formal parameters intersected with the variable used in the WHEN and WHERE forms.
    (let* ((transform (owner-of-type rel '|RelationalTransformation|))
	   (formals (formal-parameters transform (intern |name| (home-pkg))))
	   (all-vars 
	    (remove-duplicates 
	     (append 
	      (variables-used |when|) 
	      (variables-used |where|)
	      formals)
	     :test #'string=))
	   (param-vars (remove-duplicates
			(intersection 
			 all-vars
			 (loop for d in |domain| 
			    unless (eql :true (%is-enforceable d))
			    append (variables-used d)))))
	   (let-vars (set-difference all-vars param-vars))
	   (rel-name (intern |name| (home-pkg))))
;      (VARS all-vars)
;      (VARS let-vars)
;      (VARS formals)
;      (setf *zippy* rel)
;     (break "Relation ~A" |name|)
      (format 
       *stream* "~2%~S"
       `(defmethod when-where ((rel (eql ',rel-name)) bindings)
	 "Filters and add bindings as required by the WHEN and WHERE clauses and key completion"
	 (with-bindings (,param-vars bindings :exception :unbound)
	   (unless (and ,@(mapcar #'(lambda (v) `(qvt-boundp ,v)) param-vars))
	     ;(vars ,@param-vars)
	     (error ,(format nil "Insufficient specification of bindings to WHEN or WHERE in ~A" |name|)))
	   ;; before 2014 the lets just bound to +qvt-unbound_
	   (let (,@(append (mapcar #'(lambda (v) `(,v (find-binding ',v bindings :action :unbound))) let-vars) 
			   '((self +qvt-unbound+))))
	     (declare (ignorable self))
	     (with-when (,rel-name) ,@(qvt2lisp |when|))
	     (let ((keys (key-completer ',rel-name 
					(append-binds bindings (bind-vars ,@all-vars)))))
	       (with-where (,rel-name) 
		 ;(with-bindings (,enforce-formal keys :exception :unbound)
		  ; (declare (ignorable ,@enforce-formal)) ; removed 2014-08-31
		   ,@(qvt2lisp |where|));) ; 2014-08-31
		   (append-binds keys (bind-vars ,@all-vars))))))))))

(defmacro bind-vars (&rest vars)
  "Create a binding structure for variables named in VARS. The variables must
   be bound (at least to +qvt-unbound+) in the context of this macro."
  `(append ,@(mapcar #'(lambda (v) `(unless (eql ,v +qvt-unbound+) (list (cons ',v ,v)))) vars)))

;;; (bind-vars-to '?x 1 '?y 2) ==> ((?X . 1) (?Y . 2))
(defmacro bind-vars-to (&rest var-val-pairs)
  "Create a binding structure for variables named in VAR-VAL-PAIRS. 
   of the form var1 val1 ... varN valN. "
  `(append
    ,@(loop while var-val-pairs
	    for var = (pop var-val-pairs)
	    for val = (pop var-val-pairs)
	    collect `(unless (eql ,val +qvt-unbound+) (list (cons ,var ,val))))))


;;;=========================================
;;; Key-completer
;;;=========================================
(defun pp-key-completer (domain relation-name &key)
  "Print the key-completer method for RELATION-NAME."
  (let ((all-vars (mapcar #'mk-logic-var (variables-used domain)))
	(check-me nil))
    (format *stream* "~2%~S"
    `(defmethod key-completer 
      ((rel (eql ',relation-name)) bindings)
      "Produces additional bindings (and target objects!) as enabled by information about keys."
      (with-bindings (,all-vars bindings :exception :unbound)
	(let ,(mapcar #'(lambda (v) `(,(intern (format nil "~A-P" v) (home-pkg)) (qvt-boundp ,v))) all-vars)
	  ;; These are the things doing all the work; they return forms calling ensure-proxy-object.
	  ;; 2014: *I think* that if there are none of these, there is a bug in the relation.
	  ,@(setf check-me (mapappend #'(lambda (templ) 
					  (obj-template-exp2key-making  templ domain))
				      (all-object-templs domain)))
	  ;; And this check whether progress was made (and should therefore call itself again).
	  (if (or ,@(mapcar 
		     #'(lambda (v) `(and (qvt-boundp ,v) (not ,(intern (format nil "~A-P" v) (home-pkg)))))
		     all-vars))
	      (key-completer ',relation-name (bind-vars ,@all-vars))
	      ;; Otherwise return bindings (not keyword argument pairs).
	      (remove-if #'qvt-unboundp 
			 (list ,@(mapcar #'(lambda (v) `(cons ',v ,v)) all-vars)) :key #'cdr))))))
    (unless check-me (warn (strcat "Key-completer of relation ~A does not create objects."
                                   "~%         The compiler assumes that a supertype map does.")
			   relation-name))))

;;;	enforce domain rdbms t:Table {schema=s:Schema {}, 
;;;                                   name=cn,
;;;                    	              column=cl:Column {name=cn+'_tid', type='NUMBER' owner=t},
;;; 				      key=k:Key {name=cn+'_pk', owner=cl}}; 
(defmethod obj-template-exp2key-making ((exp |ObjectTemplateExp|) domain &key)
  "Return expressions (one for each Key clause for the argument ObjectTemplateExp.referredClass
   used by the key-completer to create a proxy-obj from the expression EXP."
  (with-slots (|referredClass| |part| |bindsTo|) exp
    (let* ((model-package (mofi:lisp-package (%typed-model domain)))
	   (class (intern (string |referredClass|) model-package))
	   (transform (owner-of-type exp '|RelationalTransformation|)))
      (unless (find-class class nil)
	(error "~A does not name a class in relation ~A." class (qvt::%name (qvt::%owner domain))))
      (loop for key in (get-key-info-from-transform transform class)
	    ;; Get the properties that have names matching the key components in key component order.
	    ;; If the value is an object template (rather than a primitive or ocl expression), 
	    ;; that template must bind to some variable. (Schema{} above binds to s.)
	    for properties = (loop for key-comp in key
				   for ptempl = (find key-comp |part| :key #'%referred-property :test #'string=)
				   when (and ptempl (or (not (typep (%value ptempl) '|ObjectTemplateExp|))
							(%binds-to (%value ptempl)))) 
				   collect ptempl)
	    for vars = (mapcar #'mk-logic-var
			       (remove-duplicates
				(loop for p in properties 
				      for val = (%value p)
				      append (if (typep val '|ObjectTemplateExp|) 
						 (list (%binds-to val))
						 (variables-used (%value p))))))
	    for root-var = |bindsTo|
	    when (and root-var
		      (= (length key) (length properties))
		      (not (member root-var vars))) ; ...then we have means to make one.
	    collect 
	    `(when (and (qvt-unboundp ,(mk-logic-var root-var)) ,@(mapcar #'(lambda (v) `(qvt-boundp ,v)) vars))
	      (setf ,(mk-logic-var root-var)
	       (ensure-proxy-obj 
		:class ',class 
		:properties ',key
		:values (list ,@(mapcar #'(lambda (p) 
					    (let ((val (%value p)))
					      (if (typep val '|ObjectTemplateExp|)
						  (mk-logic-var (%binds-to val))
						  (%value p))))
					properties)))))))))

;;; POD Note that (I think) we (still, 2014) do not handle 'alternative keys' (where
;;; a single class defines multiple keydecls. Though this function returns multiple keys.
(defmethod get-key-info-from-transform ((transform |RelationalTransformation|) class-name)
  "Return a list of lists of key properties for the argument
   CLASS (a string designator) of RelationalTransformation TRANSFORM."
   (with-slots (|ownedKey|) transform
     (remove-duplicates 
      (loop for c in (mapcar #'class-name
			     (reverse (cdr (member (find-class 'mofi::mm-root-supertype) 
						   (reverse (clos:class-precedence-list (find-class class-name)))))))
	 append (loop for k in |ownedKey| 
		   when (string= (string c) (%identifies k))
		   collect (mapcar #'(lambda (x) (intern x (home-pkg))) (%part k))))
      :test #'equal)))

(defun pp-key-info (keys)
  "Generate a form that will allow looking up key properties given 
   an object name (qvt interned symbol)."
  (let ((temp-ht (make-hash-table)))
    (loop for key in keys do
	  (with-slots (|identifies| |part|) key
	    (pushnew (mapcar #'(lambda (x) (intern x (home-pkg))) |part|) 
		     (gethash (intern |identifies| (home-pkg)) temp-ht))))
    (format *stream* "~2%~S"
	    `(defun get-key-info (class &key object-set)
	      "Returns a list of key properties for the argument CLASS."
	      (if object-set
		  '(,@(loop for k being the hash-key of temp-ht collect k))
		  (case class
		    ,@(loop for k being the hash-key of temp-ht using (hash-value val)
			    collect (list k `',val))))))))

;;;=========================================
;;; Relation-check
;;;=========================================
(defun pp-relation-check (domain domain-nick relation-name)
  "Print the complete defmethod relation-check."
  (let ((*vars-in-scope* nil)
	(model-package (mofi:lisp-package (%typed-model domain))))
    (declare (special *vars-in-scope*))
    (mvb (var class rest) (qvt2lisp (%pattern domain) :model-package model-package)
      (pushnew var *vars-in-scope*)
      (format *stream* "~2%~S"
	      `(defmethod relation-check
		((rel (eql ',relation-name))
		 (dom (eql ',domain-nick)) bindings)
		"Returns binding sets for a checked relation."
		(with-bindings (,*vars-in-scope* bindings :exception :symbol)
		  (with-trie-db (',(intern (string domain-nick) (home-pkg)))
		    (let ((result
			   (qvt-query
			    bindings
			    ,+bq+ (,(intern (string class) model-package) ,+cm+,var)
			    ,@(mapappend #'(lambda (r) (list +bq+ r)) rest))))
		      (if (eql result :fail) 
			  (progn (dbg-message :qvt 3 ,(princ (strcat "\~\%   Throw on no-match " 
								     (string relation-name))))
				 (VARS ,@*vars-in-scope*)
				 (throw :no-match nil))
			  result)))))))))

;;;=========================================
;;; Relation-enforce
;;;=========================================
(defun pp-relation-enforce (domain domain-nick relation-name)
  "Print the complete defmethod relation-enforce."
  (let ((*vars-in-scope* nil)
	(model-package (mofi:lisp-package (%typed-model domain))))
    (declare (special *vars-in-scope*))
    (mvb (var class rest) (qvt2lisp (%pattern domain) :model-package model-package)
      (when var (pushnew var *vars-in-scope*))
      (format *stream* "~2%~S"
	      `(defmethod relation-enforce
		((rel (eql ',relation-name))
		 (dom (eql ',domain-nick)) bindings)
		"Updates trie-db as prescribed by the bindings of an enforced domain template"
		(with-bindings (,*vars-in-scope* bindings :exception :error)
		  (with-trie-db (',(intern (string domain-nick) (home-pkg)))
		    (qvt-trie-add-upgrading ,+bq+ (,class ,+cm+ ,var))
		    ,@(mapcar #'(lambda (r) `(trie-add ,+bq+ ,r)) rest))))))))

;;;=========================================
;;; Functions
;;;=========================================
(defun pp-functions (funcs) ; 2014 I remove self as first param and (declare (ignore self)). Hmm....
  (loop for f in funcs do
	(with-slots (|name| |queryExpression| |ownedParameter|) f
	  (format *stream* "~2%~S"
		  `(defun ,(intern (string-upcase (c-name2lisp |name|)) (home-pkg))
		     ,(mapcar #'ocl:var-decl--name |ownedParameter|)
		     ,|queryExpression|)))))
	
;;;=========================================
;;; Low-level forms
;;;=========================================
(declaim (notinline property-owner))
(defun property-owner (class-name property-name)
  (or
    (when-bind (class (find-class class-name :errorp nil))
      (when-bind (slot (find property-name (mofi:mapped-slots class) 
			     :key #'closer-mop:slot-definition-name
			     :test #'string=))
	 (class-name (mofi:slot-definition-source slot))))
    (error "Class ~S does not define property ~S." class-name property-name)))


(defmethod qvt2lisp ((pattern |PropertyTemplate|) &key object object-var model-package)
  "Generate a lisp form for a PropertyTemplate."
  (let ((val (%value pattern))
	(predicate (intern (format nil "~A.~A" 
				   (property-owner object (%referred-property pattern))
				   (%referred-property pattern))
			   model-package)))
    (etypecase val
      (keyword ; an enumeration value
       `((,predicate ,+cm+, object-var ,val))) ; POD symbol implies variable???
      (symbol ; variable
       (when val (pushnew (mk-logic-var val) *vars-in-scope*))
       `((,predicate ,+cm+, object-var ,+cm+ ,(mk-logic-var val))))
      (list  ; An executable form (used on enforce only?).
       `((,predicate ,+cm+ ,object-var ,+cm+ ,val)))
      ((or string number)
       `((,predicate ,+cm+ ,object-var ,val)))
      (|ObjectTemplateExp| ; recursive
       (qvt2lisp val :model-package model-package :predicate predicate :object-var object-var))
      (|CollectionTemplateExp| ; recursive
       (qvt2lisp val :model-package model-package :predicate predicate :object-var object-var)))))

(defmethod qvt2lisp ((pattern |ObjectTemplateExp|) &key model-package predicate object-var)
  "Generate a lisp form for an ObjectTemplateExp."
  (with-slots (|referredClass| |bindsTo| |part|) pattern
    (let ((class (intern (string |referredClass|) model-package))
	  (var (mk-logic-var |bindsTo|)))
      (pushnew var *vars-in-scope*)
      (if predicate ; called from PropertyTemplate
	  `((,predicate ,+cm+ ,object-var ,+cm+ ,var)
	    (,class ,+cm+ ,var)
	    ;; parts are always PropertyTemplate. 
	    ;; PTI.value is ( ObjectTemplateExp | CollectionTemplateExp | simple value )
	    ,@(mapappend 
	       #'(lambda (part) 
		   (qvt2lisp part :object class :object-var var :model-package model-package))
	       |part|))
	  (values ; called from toplevel (relation-check / relation-enforce)
	   var
	   class
	   (mapappend #'(lambda (part) 
			  ;; parts are always properties (but their values can be objects).
			  (qvt2lisp part :object class :object-var var :model-package model-package))
		      |part|))))))

(defmethod qvt2lisp ((pattern |CollectionTemplateExp|) &key model-package predicate object-var)
  "Generate a lisp form for a CollectionTemplateExp. Unlike ObjectTemplateExp, 
   can only be called from PropertyTemplate."
  (with-slots (|bindsTo| |member|) pattern
    (let ((set-var (when |bindsTo| (mk-logic-var |bindsTo|))))
      (when set-var (pushnew set-var *vars-in-scope*))
      (let ((result
	     (mapappend
	      #'(lambda (mem) ; members are always ObjectTemplateExp (or CollectionTemplateExpression?)
		  (mvb (mem-var class rest) (qvt2lisp mem :model-package model-package)
		    (when mem-var (pushnew mem-var *vars-in-scope*))
		    ;; Predicate hooks it in to collection through second variable.
		    `((,predicate ,+cm+ ,object-var ,+cm+ ,(mk-logic-var (%binds-to mem)))
		      (,class ,+cm+ ,mem-var)
		      ,@rest)))
		  |member|)))
	(if set-var ; can optionally bind the collection object to a variable. 
	    (cons `(,(intern (format nil "~A.collection" predicate) model-package) ,+cm+ ,object-var ,+cm+ ,set-var)
		  result)
	    result)))))

;;; Get it? WHEN has 'condition' WHERE has 'action'
(defmethod qvt2lisp ((w |WhenExpression|) &key)
  (loop for w in (%condition w) collect (qvt2lisp w)))

(defmethod qvt2lisp ((w |WhereExpression|) &key)
  (loop for w in (%action w) collect (qvt2lisp w :from-where t)))

(defmethod qvt2lisp ((stmt |RelationDomainAssignment|) &key from-where)
  (with-slots (|variable| |valueExp|) stmt
    (let ((body 
	   (if (and (not from-where) (eql |variable| :ordinary-ocl))  ;2014-09-03
	       `(with-bindings (,(variables-used |valueExp|) bindings :exception :when-failed)
		  (unless (eql :true ,|valueExp|) (throw :when-failed nil)))  ;2014-09-03
	       `(setf ,|variable| ,|valueExp|))))
      (if from-where ; then wrap it in this
	  `(qvt-setq ((append-binds keys bindings) 
		      ,(variables-used |valueExp|))
	    ,body)
	  body))))


(defmethod qvt2lisp ((stmt |RelationCallExp|) &key from-where) ; That is T if it is from a WHERE clause!
  (with-slots (|argument| |referredRelation|) stmt
    (let* ((rel-name (intern |referredRelation| (home-pkg)))
	   (transform (owner-of-type stmt '|RelationalTransformation|))
	   (formal-params (remove-duplicates (mapcar #'mk-logic-var (formal-parameters transform rel-name)))) ; 2014 added rem-dups
	   ;; Args aren't necessarily variables, they could be expressions.
	   (arg-exps (mapcar #'(lambda (arg) (qvt2lisp arg)) |argument|))
	   (binds-to-form `(bind-vars-to ,@(mapappend #'(lambda (f v) `(',f ,v)) formal-params arg-exps))))
      (unless (= (length arg-exps) (length formal-params))
	(error "Incorrect specification of arguments to a RelationCallExp."))
      `(,(if from-where 'qvt-setq-where 'qvt-setq-when)
	,(loop for arg in arg-exps
	       for param in formal-params
	       when (symbolp arg) collect (list arg param))
	(relation-executor 
	 ',rel-name 
	 ,(if from-where 
	     `(append-binds keys ,binds-to-form)
	     binds-to-form))))))

(defmethod formal-parameters ((transform |RelationalTransformation|) relation-name)
  "Return the formal parameter (strings, no '?') of the relation RELATION-NAME
   of RelationalTranformation TRANSFORM."
  (with-slots (|rule|) transform
    (let ((rel (find relation-name |rule| :test #'string= :key #'%name)))
      (mapcar #'root-var (%domain rel)))))

(defmethod qvt2lisp ((obj symbol) &key)
  (unless (logic-var-p obj) (error "Not an ocl variable: ~A ???" obj))
  (if (keywordp obj) obj (mk-logic-var obj)))

(defmethod qvt2lisp ((obj string) &key) obj)
(defmethod qvt2lisp ((obj number) &key) obj)

(defmethod root-var :around ((obj t))
   (let ((result (call-next-method)))
     (unless (logic-var-p result) (error "Not a logic-var."))
     result))

(defmethod root-var ((d |RelationDomain|))
  (%root-variable d))

(defmethod root-var ((d |PrimitiveTypeDomain|))
  (%variable d))
  
(defmethod qvt2lisp ((stmt |PrimitiveTypeDomain|) &key)
  :primitive-type-domain-nyi)

;;;=========================================
;;; Utilities
;;;=========================================
(defun owner-of-type (node type)
  "Navigate the %owner slot starting at CHILD up to an object of type TYPE."
  (or (owner-of-type-aux node type)
      (error "~A is not owned by a ~A." node type)))

(defun owner-of-type-aux (node type)
  "Exists so error message on primary has meaningful CHILD value."
  (cond ((typep node type) node)
	((typep node '|QVTToplevel|) nil)
	(t 
	 (if-bind (owner (%owner node))
   	   (owner-of-type-aux owner type)
	   (error "The %owner property of ~A is not set!" node)))))

(defun strip? (var)
  "VAR should be a variable using the OCL convention of starting with '?'.
   strip off the ?."
  (unless (eql #\? (char var 0)) (error "~S doesn't look like a variable." var))
  (subseq var 1))

(defmethod enforce-domains-of ((rel |Relation|))
  "Return a list of the enforceable domains of Relation REL."
  (loop for d in (%domain rel) when (eql :true (%is-enforceable d)) collect d))

(defmethod checkonly-domains-of ((rel |Relation|))
  "Return a list of the checkable (and not enforceable) domains of Relation REL."
  (loop for d in (%domain rel) when (eql :true (%is-checkable d)) collect d))

(defmethod primitive-domains-of ((rel |Relation|))
  "Return a list of primitev domains of Relation REL."
  (loop for d in (%domain rel) when (typep d '|PrimitiveTypeDomain|) collect d))

(defun collect-accessors (form)
  "Return all the variables in the argument FORM."
  (remove-duplicates 
   (loop for atom in (flatten (mklist form)) ; not a particularly efficient impl...
	 when (accessor-p atom) collect atom)))

;;;-------------
(defmethod variables-used :around ((obj t))
   (let* ((result (mklist (call-next-method)))
	  (check (remove-if #'null (remove-duplicates (flatten result) :test #'string=))))
     (unless (every #'logic-var-p check)
       (error "These are not all logic vars: ~A" check))
     check))

(defmethod variables-used ((obj |RelationDomain|))
  "Return a list of variables (strings, no '?') used in OBJ."
  (with-slots (|pattern|) obj
    (variables-used |pattern|)))

(defmethod variables-used ((obj |PrimitiveTypeDomain|))
  (with-slots (|variable|) obj
    (variables-used |variable|)))

(defmethod variables-used ((obj |ObjectTemplateExp|))
  "Return a list of variables used in OBJ."
  (with-slots (|bindsTo| |part|) obj
     (append (variables-used  |bindsTo|)
	     (mapappend #'variables-used |part|))))

(defmethod variables-used ((obj |WhenExpression|))
  (with-slots (|condition|) obj
    (variables-used |condition|)))

(defmethod variables-used ((obj |WhereExpression|))
  (with-slots (|action|) obj
    (variables-used |action|)))

(defmethod variables-used ((obj |RelationCallExp|))
  (with-slots (|argument|) obj
    (variables-used |argument|)))

(defmethod variables-used ((obj |RelationDomainAssignment|))
  (with-slots (|valueExp| |variable|) obj
    (append (variables-used |variable|)
	    (variables-used |valueExp|))))
    
(defmethod variables-used ((obj (eql :ordinary-ocl)))
  nil)

(defmethod variables-used ((obj list))
 (mapcar #'variables-used obj))

(defmethod variables-used ((obj |PropertyTemplate|))	  
  "Return a list of variables used in OBJ."
   (variables-used (%value obj)))

(defmethod variables-used ((obj symbol))
  (when (logic-var-p obj) (list obj)))

(defmethod variables-used ((obj string))
  (unless (zerop (length obj))
    (when (eql #\? (char obj 0))
      (break "variables-used gets a ?string ~A" obj)
      (intern obj (home-pkg)))))

(defmethod variables-used ((obj |CollectionTemplateExp|))
  (with-slots (|member| |rest| |when| |bindsTo|) obj
    (append (variables-used |bindsTo|)
	    (variables-used |member|)
	    (variables-used |rest|)
	    (variables-used |when|))))

(defmethod variables-used ((obj number))
  nil)

(defmethod variables-used ((obj t))
  "Return a list of variables used in OBJ, its a list or variable symbol."
  (unless (null obj) (break "variables-used fell through: obj = ~A" obj))
  nil)


;;;-------------

(defmethod all-object-templs ((obj |RelationDomain|))
  "Return all ObjectTemplateExps (recursive) of the argument OBJ."
  (all-object-templs (%pattern obj)))

(defmethod all-object-templs ((obj |ObjectTemplateExp|))
  "Return all object templates (recursive) of the argument OBJ."
  (cons obj (mapappend #'all-object-templs (%part obj))))

(defmethod all-object-templs ((obj |PropertyTemplate|))
  (all-object-templs (%value obj)))

(defmethod all-object-templs ((obj t)) nil)



