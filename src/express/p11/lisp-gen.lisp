
(in-package :injector)

;;; Date: 2007-01-05
;;; Purpose: Output lisp forms for expresso executable schema

(defvar *zippy* nil "Diagnostic")

(defgeneric mm2lisp (object &key &allow-other-keys))

;;; Returning a lisp-compiled-express-file is PODsampson new. (used for listener-based execution).
(defmethod map-lisp ((schema mex:|Schema|) &key source-path out-path package)
  "Toplevel routine to output lisp for an instance of the express metamodel. 
   SCHEMA is an |Schema| MM instance. PATHNAME names the file that will be produced."
  (setf out-path "/home/pdenno/projects/cre/source/data/15926-2.lisp")
  (unless package (setf package :ap233)) ; POD temporary work-around.		     
  (with-open-file (stream out-path :direction :output :if-exists :supersede)
    (let ((*print-lines* nil)
	  (*print-level* nil)
	  (*print-pretty* t)
	  (*print-circle* nil)
	  (*print-length* nil)
	  (*package* (progn 
		       (if-bind (p (find-package package))
				(progn (do-symbols (s) (unintern s p)) p)
				(make-package package :use '(:cl :pod-utils :expo))))))
      (mm2lisp schema :stream stream :source-path source-path :package package)))
  (make-instance 'expo::lisp-compiled-express-file
		 :of-project (current-app *expresso*)
		 :path out-path
		 :file-size (file-size out-path)
		 :compiled-from (format nil "~A.~A" (pathname-name out-path) (pathname-type out-path))))


(defmethod mm2lisp ((schema mex:|Schema|) &key stream source-path package)
  (mm2lisp :prologue :schema schema :stream stream :source-path source-path :package (kintern package))
  (loop for type in '(mex:|SpecializedType| mex:|EntityType| mex:|GlobalRule| mex:|Function|)
     with schema-name = (string-upcase (mex:%name schema)) do
       (format stream "~3%;;;=================" type)
       (format stream "~%;;; ~As" type)
       (format stream "~%;;;=================")
       (loop for e in (mex:%schema-elements schema)
	  when (typep e type) 
	  unless (or (string-equal "GENERIC" (mex:%local-name (mex:%id e)))
		     (string-equal "GENERIC_ENTITY" (mex:%local-name (mex:%id e)))) do
	    (mm2lisp e :stream stream :schema-name (kintern schema-name))
	    (format stream "~2%")))
  (format stream "~2%;;; END OF OUTPUT"))

;;; -------  SpecializedType
(defmethod mm2lisp ((type mex:|SpecializedType|) &key ref-only-p stream schema-name)
  (unless (or stream ref-only-p) (error "Specify stream here."))
  (if ref-only-p
      (mm2lisp (mex:%id type)) 
      (let ((td (mm2lisp (mex:%underlying-type type) :ref-only-p t)))
	(pprint `(deftype-class ,(mm2lisp (mex:%id type) :symbol-p nil) ,schema-name
		 :type-descriptor ,(if (atom td) `',td td))
	      stream))))

(defmethod mm2lisp ((undertype mex:|EnumerationType|) &key)
  `(make-instance 'enum-typ
    :enumeration-list 
    ',(mapcar #'(lambda (x) (mm2lisp (mex:%id x) :prefix-p nil))
	      (mex:%values undertype))))

(defmethod mm2lisp ((undertype mex:|SelectType|) &key)
  `(make-instance 'select-typ
     :select-list 
     ',(mapcar #'(lambda (x) (mm2lisp (mex:%id x)))
	       (mex:%select-list undertype))))

;;; -------  EntityType
(defmethod mm2lisp ((entity mex:|EntityType|) &key ref-only-p stream schema-name)
  (unless (or stream ref-only-p) (error "Specify stream here."))
  (if ref-only-p
      (mm2lisp (mex:%id entity)) ; PODsampson was safe-find-eu-class
      (let ((entity-name (mm2lisp (mex:%id entity) :symbol-p nil)))
	(pprint `(defentity-class ,entity-name ,schema-name 
		  ,(loop for attr in (mex:%attributes entity) 
			 for redecl = (find attr (mex:%redeclarations entity) :key #'mex:%original-attribute)
			 with single-entity = (mex:%declares entity)
			 when (or (eql single-entity (mex:%of-entity attr)) redecl)
			 collect (mm2lisp attr :redecl redecl)))
		stream)
	(when-bind (subtype (mex:%subtype-of entity))
	  (format stream "~%")
	  (pprint `(setf (subtype-of (find-class ',(mm2lisp (mex:%id entity)))) ; PODsampson was find-eu-class
		    ',(mapcar #'(lambda (x) (mm2lisp (mex:%id x))) subtype))
		  stream))
	(when (eql :true (mex:%is-abstract entity))
	  (pprint `(setf (mofi:abstract-p (find-class ',(mm2lisp (mex:%id entity)))) t) stream))
	(when-bind (rules (mex:%domain-rules entity))
	  (format stream "~%")
	  (pprint `(defdomain-rules ,entity-name
		    ,@(mapcar #'(lambda (r)
				  `(,(mex:%local-name (mex:%id r))
				    ,(mm2lisp (mex:%asserts r))))
				  rules))
		  stream)))))

(defmethod mm2lisp ((entity mex:|SingleEntityType|) &key)
  (mm2lisp (mex:%id entity)))

(defmethod mm2lisp ((attr mex:|ExplicitAttribute|) &key)
  `(,@(call-next-method) ; |Attribute| is next method
     :optional ,(mm2lisp (mex:%is-optional attr))))

(defmethod mm2lisp ((gtype mex:|GenericType|) &key)
  t)

(defmethod mm2lisp ((attr mex:|DerivedAttribute|) &key)
  `(,@(call-next-method) ; |Attribute| is next method
     :derived ,(mm2lisp (mex:%derivation attr))))

;;; POD 2009-08-31 Earlier this was using resolved attributes, now unresolved-inverse.
(defmethod mm2lisp ((attr mex:|InverseAttribute|) &key)
  (setf *zippy* attr)
  (let ((unres (mex:%explicit attr)))
    `(,@(call-next-method) ; |Attribute| is next method
	:inverse (,(mm2lisp (mex:%id (mex:%where-found unres)) :ref-only-p t)
		  ,(mm2lisp (mex:%attribute-name unres) :prefix-p nil)))))

(defmethod mm2lisp ((attr mex:|Attribute|) &key redecl)
  "Create the slot declaration. Three choices if redecl: renamed, derived, redefined type."
  (let ((renamed-as 
	 (when (and redecl (mex:%alias redecl))
	   (mm2lisp (mex:%alias redecl) :prefix-p nil)))
	(derived-as ; When it is a redefinition and derived, an ExplicitAttr is created.
	 (when (and redecl (not (mex:%alias redecl)) (mex:%derivation redecl))
	   (mm2lisp (mex:%derivation redecl))))
	(redefined-from
	 (when (and redecl (not (mex:%alias redecl)) (not (mex:%derivation redecl)))
	   (list 
	    (mm2lisp (mex:%of-entity (mex:%original-attribute redecl)))
	    (mex:%local-name (mex:%id (mex:%original-attribute redecl)))))))
    (append
     (append
      (append
       (list
	(mm2lisp (mex:%id attr) :symbol-p nil :upcase-p nil :prefix-p nil)
	:range (if redecl
		   (mm2lisp (mex:%restricted-type redecl) :ref-only-p t)
		   (mm2lisp (mex:%attribute-type attr) :ref-only-p t))
	:source	(intern (string-upcase (mex:%local-name (mex:%id (mex:%of-entity attr))))))
       (when renamed-as `(:renamed-as ,renamed-as)))
      (when derived-as `(:derived ,derived-as)))
     (when redefined-from `(:redefinition-of ,redefined-from)))))

;;; -------  GlobalRule, DomainRule
(defmethod mm2lisp ((rule mex:|GlobalRule|) &key stream)
  (unless stream (error "Specify stream here."))
  (let ((name (mm2lisp (mex:%id rule)))) 
    (pprint `(defglobal-rule ,name 
	      ,(mapcar #'mm2lisp (mex:%constrained-extents rule))
	      ,@(mapcar #'mm2lisp (mex:%contains-rules rule)))
	    stream)))

(defmethod mm2lisp ((rule mex:|DomainRule|) &key stream)
  (unless stream (error "Specify stream here."))
  (mm2lisp (mex:%asserts rule) :stream stream))

(defmethod mm2lisp ((rule mex:|NamedRule|) &key)
  (let ((name (if-bind (id (mex:%id rule)) (mex:%local-name id) "unnamed")))
    `(,name ,(mm2lisp (mex:%asserts-expression rule)))))

(defmethod mm2lisp ((ref mex:|ExtentRef|) &key)
  "Only GlobalRules can reference extents, I think."
  (mm2lisp (mex:%id ref) :ref-only-p t))

;;;=========================
;;; -------  Function
;;;=========================
(defmethod mm2lisp ((fun mex:|Function|) &key stream)
  (unless stream (error "Specify stream here."))
  (with-slots (mex:|id| mex:|formal-parameters| mex:|variables| mex::|body|) fun
    (let* ((param-ids (mapcar #'(lambda (p) (mm2lisp (mex:%id p))) mex:|formal-parameters|))
	   (param-asserts 
	    (mapcar #'(lambda (p id) 
			`(express-assert       
			  ,(mm2lisp (mex:%formal-parameter-type p) :ref-only-p t)
			  ,id))
		   mex:|formal-parameters| param-ids))
	   (name (mm2lisp mex:|id|))
	   (local-vars (loop for v in mex:|variables|
			     when (typep v 'mex:|Variable|) ; there are Parameters in there too!
			     collect `(,(mm2lisp (mex:%id v))
				       (make-one 
					,(mm2lisp (mex:%variable-type v) :ref-only-p t)
					,(when-bind (val (mex:%initial-value v)) (mm2lisp val)))))))
    (pprint `(defun ,name ,param-ids
	      (block ,(intern "THIS-FUNCTION")
		,@param-asserts
		(when (or ,@(mapcar #'(lambda (p) `(expo::indeterminate-p ,p)) param-ids))
		  (return-from ,name :?))
		(let ,local-vars
		  ,@(mapcar #'mm2lisp mex::|body|))))
	      stream))))

;;;=======================
;;; -------  Expression
;;;=======================
(defmethod mm2lisp ((exp mex:|Expression|) &key) 
  (format t "~% This Expression object NYI:  ~A " exp) "")

(defmethod mm2lisp ((exp mex:|SELFRef|) &key) 
  (intern "INSTANCE"))

; PODsampson commenting out
;(defmethod mm2lisp ((exp |Literal|) &key) 
;  (%id exp))

(defmethod mm2lisp ((exp mex:|Literal|) &key) 
  (cond ((equal "?" (mex:%refers-to exp)) :?)
	(t (if-bind (val (mex:%refers-to exp))
		    val 
		    (progn (setf *zippy* exp) (break "here"))))))

(defmethod mm2lisp ((exp mex:|AttributeRef|) &key &aux entity-expr)
  (typecase (setf entity-expr (mex:%entity-instance exp))
    (mex:|SingleEntityType|
     `(,(mm2lisp (mex:%id exp) :attr-p t) 
       instance 
       ',(mm2lisp (mex:%id entity-expr))))
    (mex:|EntityType|     
     `(,(mm2lisp (mex:%id exp) :attr-p t) 
	(intern "INSTANCE")  
       ',(mm2lisp (mex:%id (mex:%of-entity (mex:%refers-to exp))))))
    (mex:|GroupRef|
     `(,(mm2lisp (mex:%id exp) :attr-p t) 
       ,(mm2lisp entity-expr)
       ',(mm2lisp (mex:%id (mex:%of-entity (mex:%refers-to exp))))))
    ((or mex:|VariableRef| mex:|ParameterRef| mex:|ConstantRef| mex:|AggregateIndex| mex:unresolved-attribute-ref) ; POD!
     `(,(mm2lisp (mex:%id exp) :attr-p t) 
       ,(mm2lisp entity-expr)
       nil)) ; pod (giving up).
    (otherwise 
     (setf *zippy* exp)
     (error "mm2lisp AttributeRef"))))

(defmethod mm2lisp ((exp mex:unresolved-attribute-ref) &key)
  `(,(intern (format nil "%~A" (string-upcase (mex:%local-name exp))))
    ,(mm2lisp (mex:%entity-instance exp)) ; an Expression
    nil))

(defmethod mm2lisp ((exp mex:|AggregateIndex|) &key)
  `(express-aref ,(mm2lisp (mex:%base-value exp)) ,@(mapcar #'mm2lisp (mex:%index-value exp))))

; hmmm
;(defmethod mm2lisp ((exp |GroupRef|) &key)
;  (when-bind (ent (%refers-to exp))
;    (mm2lisp (%id ent))))

(defmethod mm2lisp ((exp mex:|GroupRef|) &key)
  (mm2lisp (mex:%entity-instance exp)))

(defmethod mm2lisp ((exp mex:|UnaryOperation|) &key)
  `(,(mm2lisp (mex:%operator exp)) ,(mm2lisp (mex:%unary-operand exp))))

(defmethod mm2lisp ((exp mex:|BinaryOperation|) &key)
  `(,(mm2lisp (mex:%operator exp)) ,(mm2lisp (mex:%left-operand exp)) ,(mm2lisp (mex:%right-operand exp))))

(defmethod mm2lisp ((exp mex:|QueryExpression|) &key)
  `(exp::query 
    ,(mm2lisp (mex:%aggregate-operand exp))
    #'(lambda (,(mm2lisp (car (mex:%query-variable exp))))
	,(mm2lisp (mex:%select-condition exp)))))

(defmethod mm2lisp ((exp mex:|FunctionCall|) &key)
  (let ((func (mex:%invokes-function exp)))
    `(,(if (or (typep func 'mex:|UnaryOperator|)
	       (typep func 'mex:|BinaryOperator|))
	   (mm2lisp func)
	   (mex:%local-name (mex:%id func)))
      ,@(mapcar #'mm2lisp (mex:%actual-parameters exp)))))

(defmethod mm2lisp ((p mex:|ActualParameter|) &key)
  (mm2lisp (mex:%actual-value p)))

(defmethod mm2lisp ((x mex:|VariableRef|) &key)
  (mm2lisp (mex:%id x) :prefix-p nil))

(defmethod mm2lisp ((x mex:|Variable|) &key)
  (mm2lisp (mex:%id x) :prefix-p nil))

(defmethod mm2lisp ((x mex:|ParameterRef|) &key)
  (mm2lisp (mex:%id x) :prefix-p nil))

(defmethod mm2lisp ((x mex:|Parameter|) &key)
  (mm2lisp (mex:%id x) :prefix-p nil))

;;; POD This is a big mess (in parser2 also).
(defmethod mm2lisp ((x mex:|ConstantRef|) &key)
  (cond ((and (typep (mex:%refers-to x) 'mex:|Constant|)
	      (typep (mex:%data-type x) 'mex:|EntityType|))
	 (intern "INSTANCE"))
	((string-equal "?" (mex:%local-name (mex:%id x))) :?)
	((string-equal "PI" (mex:%local-name (mex:%id x))) pi)
	((string-equal "SELF" (mex:%local-name (mex:%id (mex:%refers-to x))))
	 (intern "INSTANCE"))
	((typep (mex:%refers-to x) 'mex:|ScopedId|)
	 (mm2lisp (mex:%id (mex:%refers-to x)) :prefix-p nil))
	(t (error "in mm2lisp constantref"))))

(defmethod mm2lisp ((x mex:|EnumItemRef|) &key)
  (kintern (mex:%local-name (mex:%id x))))

(defmethod mm2lisp ((agg-def mex:|AggregateInitializer|) &key)
  (let ((-typ (mex:%data-type agg-def))
	(vals (mapcar #'mm2lisp (mex:%bindings agg-def))))
    (if -typ
	`(make-one ,(mm2lisp -typ) (list ,@vals))
	`(make-instance 'exp:express-bag 
	  :value (list ,@vals)
	  :type-descriptor 
	  (make-instance 'exp:bag-typ
	   :l-bound 0 :u-bound :? :base-type t)))))

(defmethod mm2lisp ((elem mex:|MemberBinding|) &key)
  (mm2lisp (mex:%member-value elem)))

;;;  ("EXP2:BinaryLength" "EXP2:EXP" 
;;;   "EXP2:Exists"  "EXP2:LOG" "EXP2:LOG10" "EXP2:LOG2" 
;;;   "EXP2:ODD" "EXP2:VALUE" "EXP2:VALUE_UNIQUE"))
(defmethod mm2lisp ((operator mex:|UnaryOperator|) &key)
  (ecase (kintern (string-upcase (mex:%local-name (mex:%id operator)))) ; e.g. "EXP2:Equal"
    (:not 'exp:express-not)
    (:sizeof 'exp:bi-sizeof)
    (:rolesof 'exp:bi-rolesof)
    (:typeof 'exp:bi-typeof)
    (:lobound 'exp:bi-lobound) (:hibound 'exp:bi-hibound)
    (:loindex 'exp:bi-loindex) (:hiindex 'exp:bi-hiindex)
    (:negate 'exp:express-unary-minus)
    (:usedin 'exp:bi-usedin) ; not sure this makes sense here (but the MM makes a UOp for it...)
    (:exists 'exp:bi-exists)
    (:nvl 'expo:bi-nvl)
    (:sqrt 'exp:bi-sqrt) (:abs 'exp:bi-abs) (:identity 'identity)
    (:acos 'exp:bi-acos) (:asin 'exp:bi-asin) (:atan 'exp:bi-atan) 
    (:cos 'exp:bi-cos) (:sin 'exp:bi-sin) (:tan 'exp:bi-tan)))

;;;   "EXP2:EntityValueEqual" "EXP2:EntityValueIN" "EXP2:EntityValueUnequal" 
;;;   "EXP2:ListAddFirst" "EXP2:ListAddLast" "EXP2:NVL" "EXP2:Substitute" 
;;; PODsampson this may be part of Injector, and may reflect an out-of-date MEXICO.
(defmethod mm2lisp ((op mex:|BinaryOperator|) &key)
  (let ((key (kintern (string-upcase (mex:%local-name (mex:%id op))))))
    (operator-aux key)))


(defmethod mm2lisp ((op mex:unresolved-operator) &key)
  (let ((key (kintern (string-upcase (mex:%enum-symbol op)))))
    (operator-aux key)))

(defun operator-aux (key)
  "Called to resolve an operator to the symbol naming the corresponding lisp function."
    (ecase key 
      (:and 'exp:express-and)   
      (:or 'exp:express-or)
      ((:+ :add :bagadd :setadd :listappend :setunion :bagunion :stringappend 
	     :binaryappend :unresolved-plus) 'exp:express-plus)
      ((:- :subtract :bagdifference :bagremove :subset :unresolved-minus) 'exp:express-minus)
      ((:= :equal :arrayequal :bagequal :binaryequal :entityvalueequal 
	       :enumequal :listequal :logicalequal :unresolved-value-equal) 'exp:express-equal)
      ((:* :multiply :intersection :unresolved-star) 'exp:express-mult)
      (:div 'exp:express-div)
      ((:/ :realdivide :unresolved-divide) 'exp:express-divide)
      ((:<> :unequal :arrayunequal :bagunequal :binaryunequal :entityvalueunequal 
		 :enumunequal :listunequal :logicalunequal :unresolved-value-unequal
		 :unresolved-unequal) 'exp:express-not-equal)
      ((:|:=:| :entityinstanceequal :arrayinstanceequal :baginstanceunequal :listinstanceequal
			     :stringequal :unresolved-instance-equal) 'exp:express-instance-equal)
      ((:|:<>:| :entityinstanceunequal :arrayinstanceequal :listinstanceequal 
			       :unresolved-instance-unequal) 'exp:express-instance-not-equal)
      ((:< :less :logicalless :stringless :enumless :binaryless :unresolved-less) 'exp:express-<)
      ((:> :greater :logicalgreater :stringgreater :enumgreater :binarygreater :unresolved-greater) 'exp:express->)
      ((:<= :lessequal :logicallessequal :stringlessequal :enumlessequal :binarylessequal
		   :unresolved-less-equal) 'exp:express-<=)
      ((:>= :greaterequal :logicalgreaterequal :stringgreaterequal :enumgreaterequal :binarygreaterequal
		      :unresolved-greater-equal) 'exp:express->=)
      (:mod 'exp:express-mod)
      (:like 'exp:express-like)
      (:xor 'exp:express-xor)
      (:\|\| :entityconstructor :express-complex-entity-construction)
      (:in 'exp:in)
      (:** :exponent 'exp:express-expt)))
  
;;;=======================
;;; -------  |Statement|
;;;=======================
(defmethod mm2lisp ((stmt mex:|Assignment|) &key)
  `(setf ,(mm2lisp (mex:%place-reference stmt)) ,(mm2lisp (mex:%assigned-value stmt))))

(defmethod mm2lisp ((obj mex:|ReturnStatement|) &key)
  `(return-from ,(intern "THIS-FUNCTION") ,(mm2lisp (mex:%return-value obj))))

;;; POD Needs work?
(defmethod mm2lisp ((obj mex:|SkipStatement|) &key)
  '(go :loop-end))

(defmethod mm2lisp ((obj mex:|EscapeStatement|) &key)
  '(return nil))

(defmethod mm2lisp ((obj mex:|ProcedureCall|) &key)
  `(,(mex:%invokes obj) ,@(mex:%actual-parameters obj)))

(defmethod mm2lisp ((stmt mex:|CaseStatement|) &key)
  (with-slots (mex:|selection-expression| mex:|cases|) stmt
    (let ((selector (intern (gensym "CASE-SELECTOR"))))
      `(let ((,selector ,(mm2lisp mex:|selection-expression|)))
	(cond ,(loop for c in mex:|cases|
		     for labels = (mapcar #'mm2lisp (mex:%label-value c))
		     collect `((find ,selector ,labels :test #'express-equal)
			       ,(mm2lisp (mex:%action c)))))))))

(defmethod mm2lisp ((obj mex:|StatementBlock|) &key)
  `(progn
    ,@(mapcar #'mm2lisp (mex:%body obj))))

;;; POD does UNTIL need to go to the bottom?
(defmethod mm2lisp ((obj mex:|RepeatStatement|) &key)
  (with-slots (mex::|body| mex:|controls|) obj
    `(loop ,@(mapcar #'mm2lisp mex:|controls|)
      do ,@(mapcar #'mm2lisp mex::|body|))))

(defmethod mm2lisp ((obj mex:|RepeatIncrementControl|) &key)
  (with-slots (mex:|variable| mex:|lbound| mex:|ubound| mex:|increment|) obj
    (append
     `(for ,(mm2lisp mex:|variable|) 
       from ,(mm2lisp mex:|lbound|) 
       to ,(mm2lisp mex:|ubound|))
     (when mex:|increment|`(by ,(mm2lisp mex:|increment|))))))

(defmethod mm2lisp ((obj mex:|RepeatWhileControl|) &key)
  `(while ,(mex:%condition obj)))

(defmethod mm2lisp ((obj mex:|RepeatUntilControl|) &key)
  `(until ,(mex:%condition obj)))

(defmethod mm2lisp ((stmt mex:|IfStatement|) &key)
  (with-slots (mex:|if-condition| mex:|then-actions| mex:|else-actions|) stmt
  `(if ,(mm2lisp mex:|if-condition|)
    (progn ,@(mapcar #'mm2lisp mex:|then-actions|))
    (progn ,@(mapcar #'mm2lisp mex:|else-actions|)))))

;;; -------  methods used all over
(defmethod mm2lisp ((type mex:|NumericType|) &key) '(make-instance 'number-typ))
(defmethod mm2lisp ((type mex:|StringType|) &key) '(make-instance 'string-typ))
(defmethod mm2lisp ((type mex:|RealType|) &key) '(make-instance 'real-typ))
(defmethod mm2lisp ((type mex:|IntegerType|) &key) '(make-instance 'integer-typ))
(defmethod mm2lisp ((type mex:|BooleanType|) &key) '(make-instance 'boolean-typ))
(defmethod mm2lisp ((type mex:|LogicType|) &key) '(make-instance 'logical-typ))
(defmethod mm2lisp ((type mex:|BinaryType|) &key) '(make-instance 'binary-typ))

(defmethod mm2lisp ((val mex:|LogicalValue|) &key)
  (case (mex:%name val)
    ('true t)
    ('false nil)
    ('unknown :unknown)))

(defmethod mm2lisp ((val mex:|SimpleValue|) &key)
  (mex:%name val))

;;; -------  2009-05-19 new...
#| WTF (defmethod mm2lisp ((type ocl:-typ) &key) `(make-instance ',(clos:class-name (class-of type)))) |#

;;; PODsampson. I'm removing (mm2lisp from all the :unique values, but maybe these should
;;; have come in as :true and :false???

(defmethod mm2lisp ((type mex:|LISTType|) &key)
  `(make-instance 'list-typ 
    ,@(call-next-method type)
    :unique ,(mm2lisp (mex:%is-unique type))))

(defmethod mm2lisp ((type mex:|GeneralLISTType|) &key)
  `(make-instance 'list-typ 
    ,@(call-next-method type)
    :unique ,(mm2lisp (mex:%is-unique type))))

(defmethod mm2lisp ((type mex:|SETType|) &key)
  `(make-instance 'set-typ ,@(call-next-method type)))

(defmethod mm2lisp ((type mex:|GeneralSETType|) &key)
  `(make-instance 'set-typ ,@(call-next-method type)))

(defmethod mm2lisp ((type mex:|BAGType|) &key)
  `(make-instance 'bag-typ ,@(call-next-method)))

(defmethod mm2lisp ((type mex:|GeneralBAGType|) &key)
  `(make-instance 'bag-typ ,@(call-next-method)))

(defmethod mm2lisp ((type mex:|ARRAYType|) &key)
  `(make-instance 'array-typ 
    ,@(call-next-method)
    :unique ,(mm2lisp (mex:%is-unique type))))

(defmethod mm2lisp ((type mex:|GeneralARRAYType|) &key)
  `(make-instance 'array-typ 
    ,@(call-next-method)
    :unique ,(mm2lisp (mex:%is-unique type))))

;;; POD :optional ???
(defmethod mm2lisp ((agg mex:|AggregationType|) &key)
  `(:l-bound ,(if (mex:%lower-bound agg) (mm2lisp (mex:%lower-bound agg)) 0)
    :u-bound ,(if (mex:%upper-bound agg)  (mm2lisp (mex:%upper-bound agg)) :?)
    :base-type ,(let ((result (mm2lisp (mex:%member-type agg) :ref-only-p t)))
		     (if (symbolp result) `',result result))))
		     
(defmethod mm2lisp ((agg mex:|GeneralAggregationType|) &key)
  `(:l-bound ,(if (mex:%lower-bound agg) (mm2lisp (mex:%lower-bound agg)) 0)
    :u-bound ,(if (mex:%upper-bound agg)  (mm2lisp (mex:%upper-bound agg)) :?)
    :base-type ,(let ((result (mm2lisp (mex:%member-type agg) :ref-only-p t)))
		     (if (symbolp result) `',result result))))

(defmethod mm2lisp ((size mex:|SizeConstraint|) &key)
  (with-slots (mex:|bound| mex:|asserts|) size
    (mm2lisp (or mex:|bound| mex:|asserts| :?))))

(defmethod mm2lisp ((bool (eql :false)) &key) nil)
(defmethod mm2lisp ((bool (eql :true)) &key) t)
(defmethod mm2lisp ((? (eql :?)) &key) :?)

(defmethod mm2lisp ((id mex:|ScopedId|) &key (prefix-p nil) (symbol-p t) (upcase-p t) (attr-p nil))
  (let ((name (mex:%local-name id)))
    (if attr-p 
	name
	(progn
	  (when upcase-p (setf name (string-upcase name)))
	  (when prefix-p (setf name (format nil "~A.~A" 
					    (schema2short-name (p11p::schema-scope (mex:%defining-scope id)))
					    name)))
	  (when symbol-p (setf name (intern name)))))
    name))

(defvar *zip-no-method* nil)
(defmethod mm2lisp ((obj T) &rest ignore &key)
  (declare (ignore ignore))
  (setf *zip-no-method* obj)
  (error "No mm2lisp method for ~A" obj))

;;;==========================================
;;; Utilities
;;;==========================================
(defmethod mm2lisp ((obj (eql :prologue)) &key schema source-path stream package)
  (unless stream (error "Specify stream here."))
  (let ((id (mex:%name schema)))
    (format stream ";;; -*- Mode: Lisp; -*-~2%")
    (format stream ";;; File created by ~A~%" (ee-version))
    (format stream ";;; Date created: ~A~%" (now))
    (format stream ";;; Compilation of ~A~2%" source-path)
    (format stream "(in-package ~S)~%" (kintern package))
    (pprint
     `(setf (expo::schema expo::*expresso*)
	    (ensure-schema 'expo::express-schema
			   :name ,(string-downcase id)
			   :lisp-package ,(kintern package)
			   :interned-name ',(intern id)
			   :schema-pathname ,source-path)) stream)
    (pprint `(expo::clear-schema (expo::find-schema ,(string-downcase id))) stream)
    (pprint 
     `(mapcar #'shadow-for-model 
	      ',(loop for elem in (mex:%schema-elements schema)
		   for id = (string-upcase (mex:%local-name (mex:%id elem)))
		   unless (eql *package* (symbol-package (intern id *package*))) collect id))
     stream)))

#|  (flet ((all-of-type (type)  PODsampson... this was in :prologue.
	    (loop for obj in (%schema-elements schema)
		  when (typep obj type)
		  collect (mm2lisp (%id obj) :prefix-p nil)))
	 (all-enums ()
	    (loop for obj in (%schema-elements schema)
		  when (and (typep obj '|SpecializedType|)
			    (typep (%underlying-type obj) '|EnumerationType|))
		  append (mapcar #'(lambda (x) (mm2lisp (%id x) :prefix-p nil))
				 (%values (underlying-type obj))))))
|#



#|
      (pprint `(expo::schema-load-namespace 
		'((:entities ,@(all-of-type '|EntityType|))
		  (:types ,@(all-of-type '|SpecializedType|))
		  (:functions ,@(all-of-type '|Function|))
		  (:constants ,@(all-of-type '|Constant|))
		  (:rules ,@(all-of-type '|GlobalRule|))
		  (:enumerations ,@(all-enums))
		  (:procedures ,@(all-of-type '|Procedure|))
		  (:schemas ,(string-upcase id))))
	      stream))))
|#

(defmethod schema2alias ((schema expo::abstract-schema))
  "Return the alias (interned symbol) for the argument |Schema| (used in e-x lisp-gen)."
  (when-bind (alias (find schema (expo::schema-aliases *expresso*) :key #'expo::for-schema))
    (intern (expo::name alias))))

(defmethod schema2alias ((schema mex:|Schema|))
  "Return the alias (interned symbol) for the argument |Schema| (used in e-x lisp-gen)."
  (when-bind (expo-schema (find schema (expo::schemas *expresso*) :key #'schema-mm))
    (schema2alias expo-schema)))

(defmethod schema2short-name ((schema expo::abstract-schema))
  "Return the alias (a string) for the argument expo::SCHEMA."
    (intern (expo::short-name schema)))

(defmethod schema2short-name ((schema mex:|Schema|))
  "Return the 'short name' (a string) for the argument |Schema| (used in lisp)."
  (when-bind (expo-schema (find schema (expo::schemas *expresso*) :key #'schema-mm))
    (schema2short-name expo-schema)))

(defun alias2schema (alias)
  "Return the |Schema| object corresponding to ALIAS, a string."
  (when-bind (obj (find-alias alias :key #'expo::name :test #'string-equal))
    (expo:schema-mm (expo::for-schema obj))))


