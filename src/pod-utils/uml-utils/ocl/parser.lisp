
;;; Purpose: An OCL parser. 
;;;
;;;          As development proceeded, it became apparent that the analysis of the
;;;          metamodel XMI (e.g. L3) provided information similar to a first pass parser, making
;;;          a separate first pass unnecessary. This parser (this file) does the conventional 
;;;          first pass stuff of building a scoping tree, but it is used immediately, 
;;;          rather than in a subsequent pass.

(in-package :oclp)

(defun compiling-qvt-p ()
  (when-bind (n+1 (mofi:model-n+1 mofi:*model*))
    (member "QVT" (mofi:model-types n+1) :test #'string=)))

(defmacro defparse (tag (&rest keys) &body body)
   "Defines a parse-data eql method on TAG. The method macrolets parse."
   `(defmethod parse-data ((stream ocl-stream) (tag (eql ',tag)) &key ,@keys)
      (macrolet ((parse (tag &rest keys) ; the mystery solved: pass2 needs to call parse too.
			`(parse-data stream ',tag ,@keys)))
	,@body)))

(defclass ocl-stream (token-stream)
  ((read-fn :initform 'ocl-read)))

(defgeneric ocl2lisp (str &key class-context debug-p scope &allow-other-keys))

(defmethod ocl2lisp ((str string) &key class-context debug-p scope)
  "Create a string-intput-stream and call ocl2lisp with it."
  (when debug-p (format t "~%Testcase: ~S~%" str))
  (let ((string-stream (make-string-input-stream (strcat str " ")))
	(*package* (find-package :oclp)))
    (with-open-stream (stream (setf *token-stream* 
				    (make-instance 'ocl-stream :stream string-stream)))
      (let ((result 
	     (ocl2lisp 
	      stream 
	      :class-context class-context 
	      ;; Otherwise problem below with supplied-p
	      :scope (or scope 
			 (make-instance '%%scope 
					:%%name "Global Scope" 
					:%%type :global)))))
        (if (eql :eof (peek-token stream))
	    result
	  (error 'ocl-parse-incomplete :actual (peek-token stream)))))))

(defun uml-ocl2lisp (code &key class-context (debug-level 5))
  "Convenience function to run ocl2lisp in the context of UML."
  (let ((*in-scope-models* (list (mofi:of-model (find-class class-context))
				 (mofi:find-model :ptypes)
				 (mofi:find-model :ocl)))
	(mofi:*model* (mofi:of-model (find-class class-context))))
    (declare (special *in-scope-models* mofi:*model*))
    (with-debugging (:parser debug-level)
      (ocl2lisp code :class-context class-context))))

(defvar *class-context* nil "Set to the name of an UMLClass that is the context of the parse.")

;;; 2012-02-25 -- It looks to me like this expects *in-scope-models* to be set
(defmethod ocl2lisp ((stream stream) &key class-context scope)
  "Top-level call. Returns a translated ocl expression. SCOPE is used when coming in from QVT."
  (init-bcounters) ; done on every form
  (setf *class-context* class-context)
  (setf *tags-trace* nil)
  (subst 'self 'inject-self (parse-data stream '|ExpressionInOcl| :scope scope)))

;;; POD 2010-05-30 Previously, I only had this one:

#+qvt
(defmethod parse-data :around ((stream ocl-stream) tag &rest args)
  (let ((qvt-p (and (find-package :qvt) ; There is an :around on qvt too and qvt-stream is a subtype.
	       (find-class (intern "QVT-STREAM" :qvt) nil)
	       (typep stream (intern "QVT-STREAM" :qvt)))))
    (unless qvt-p
      (push tag *tags-trace*)
      (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S~%" tag args (peek-token stream)))
    (let ((result (call-next-method)))
      (unless qvt-p
	(dbg-message :parser 5 "~%Exiting ~S with value ~S ~%" tag result)
	(force-output *debug-stream*)
	(pop *tags-trace*)) ; added 2013-01-17 without testing. 2014-08-26 put it inside (unless qvt-p ....)
    result)))

#-qvt
(defmethod parse-data :around ((stream ocl-stream) tag &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S~%" tag args (peek-token stream))
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with value ~S ~%" tag result)
    (force-output *debug-stream*)
    result))


;;;======================== The Grammar ==============================
;;; LogicalOp = 'and' | 'or' | 'xor'
;;; EqOp := '=' | '<>'
;;; RelOp :=  '<' | '>' | '<=' | '>='
;;; AddLikeOp := '+' | '-'
;;; MultLikeOp := '*' | '/' 
;;; UnaryOp := 'not' | '-'

;;; ExpressionInOcl ::= OclExpression
(defparse |ExpressionInOcl| 
    ;; Scopes can come in through QVT.
    ((scope (make-instance '%%scope :%%name "Global Scope" :%%type :global) supplied-p))
  (unless supplied-p 
    (setf *line-number* 1) ; If supplied-p then in the middle of parsing something else (like QVT). 
    (setf *scope* scope))  ; For easier debugging, keep top scope around.
  (let ((*scope* scope))
    (case (peek-token stream)
      ('|def|  (parse |OclDef|))
      ('|context| (parse |OclContextualizedExp|))
      (otherwise (parse |OclExpression|)))))

(defvar *declared-class-context* nil "Used to communicate context declared through 'context' syntax")
;;; 2011-05-08 I'm adding this.
;;; OclContextualizedExp| := 'context' PathName 'inv' ':' OclExpression
(defparse |OclContextualizedExp| ()
  (assert-token '|context| stream)
  (setf *declared-class-context* (cadadr (parse |PathName|)))
  (assert-token '|inv| stream)
  (assert-token #\: stream)
  (parse |OclExpression|))

;;; OclExpression := LogicalTerm { 'implies' LogicalTerm }
(defparse |OclExpression| ()
  (loop with term = (parse |LogicalTerm|)
	while (eql '|implies| (peek-token stream)) do
	(read-token stream)
	(setf term `(ocl-implies ,term ,(parse |LogicalTerm|)))
	finally (return term)))

;;; LogicalTerm := EqTerm { LogicalOp EqTerm }
(defparse |LogicalTerm| ()
  (loop with term = (parse |EqTerm|)
	while (member (peek-token stream) '(|and| |or| |xor|)) do
	(setf term `(,(parse |LogicalOp|) ,term ,(parse |EqTerm|)))
	finally (return term)))

;;; LogicalOp := 'and' | 'or' | 'xor'
(defparse |LogicalOp| ()
  (ecase (read-token stream)
    (|and| 'ocl-and)
    (|or| 'ocl-or)
    (|xor| 'ocl-xor)))

;;; EqTerm :=  RelTerm { EqOp RelTerm }
(defparse |EqTerm| ()
  (loop with term = (parse |RelTerm|)
	while (member (peek-token stream) '(#\= :less-great)) do
	(setf term `(,(parse |EqOp|) ,term ,(parse |EqTerm|)))
	finally (return term)))

;;; EqOp := '=' | '<>' 
(defparse |EqOp| ()
  (ecase (read-token stream)
    (#\= 'ocl-=)
    (:less-great 'ocl-<>)))

;;; RelTerm :=  SimpleExpression { RelOp SimpleExpression }
(defparse |RelTerm| ()
  (loop with exp = (parse |SimpleExpression|)
	while (member (peek-token stream) '(#\< #\> :less-equal :great-equal)) do
	(setf exp `(,(parse |RelOp|) ,exp ,(parse |SimpleExpression|)))
	finally (return exp)))

;;; RelOp :=  '<' | '>' | '<=' | '>='
(defparse |RelOp| ()
  (ecase (read-token stream)
    (#\< 'ocl-<)
    (#\> 'ocl->)
    (:less-equal 'ocl-<=)
    (:great-equal 'ocl->=)))

;;; SimpleExpression := Term { AddLikeOp Term}
(defparse |SimpleExpression| ()
  (loop with exp = (parse |Term|)
	while (member (peek-token stream) '(#\+ #\-)) do
	(setf exp `(,(parse |AddLikeOp|) ,exp ,(parse |Term|)))
	finally (return exp)))

;;; AddLikeOp := '+' | '-'
(defparse |AddLikeOp| ()
  (ecase (read-token stream)
    (#\+ 'ocl-+)
    (#\- 'ocl--)))

;;; Term := Factor { MultLikeOp Factor }
(defparse |Term| ()
  (loop with term = (parse |Factor|)
	while (member (peek-token stream) '(#\* #\/)) do
	(setf term `(,(parse |MultLikeOp|) ,term ,(parse |Factor|)))
	finally (return term)))

;;; MultLikeOp := '*' | '/'   
(defparse |MultLikeOp| ()
  (ecase (read-token stream)
    (#\* 'ocl-*)
    (#\/ 'ocl-/)))

;;; Factor :=  LetExp | OclMessageExp | IfExp | UnaryOp? Primary 
(defparse |Factor| () ; POD OclMessageExp NYI.
  (let ((tkn (peek-token stream))
	un-op exp)
   (case tkn
     (|let| (parse |LetExp|))
     (|if|  (parse |IfExp|))
     (otherwise
      (when (member tkn '(#\- |not|)) (setf un-op (parse |UnaryOp|)))
      (setf exp (parse |Primary|))
      (if un-op `(,un-op ,exp) exp)))))

(defparse |UnaryOp| ()
  (ecase (read-token stream)
    (#\- '-)
    (|not| 'ocl-not)))

;;; BTW Section 7.5.3: "A property of the collection itself is accessed by using an arrow ‘->’ 
;;; followed by the name of the property."
;;; Primary :=  PrimitiveLiteralExp | EnumLiteralExp | ( QualifiableFactor { Qualifier } )
(defparse |Primary| ()
  (let ((tkn (peek-token stream)))
   (cond ((and (or (string-const-p tkn) 
		   (and (stringp tkn)
			(or (string= tkn "true")
			    (string= tkn "false")))
		   (numberp tkn)) ; not added 2012-02-24 probably need more in member bag.
	       (not (member (peek-token stream 2) '(#\. :point-right)))) ; 'hello'.concat(...)
	  (parse |PrimitiveLiteralExp|))
	 ((eql :colon-colon (peek-token stream 2))
	  (parse |EnumLiteralExp|))
	 (t  
	  (loop with primary = (parse |QualifiableFactor|) with nav-type = nil
		while (member (peek-token stream) '(#\. :point-right)) do
	       (setf nav-type (read-token stream))
	     ;; 2016-10-25
	     ;; Below is sloppy because (oclp:uml-ocl2lisp "generalization.general.asSet()" :class-context 'uml25:|Classifier|)
	     ;; will wrap an ocl-nav/collect even over the asSet, resulting in a bag! asSet is NOT a collectionOperator
	       (setf primary 
		      (case  nav-type  ; 2012-03-16 added nav/collect
			(#\.
			 (if (avoid-nav/collect-p (string (peek-token stream))) ; don't nav/collect for isEmpty, etc.
			     (parse |Qualifier| :operand primary)
			     `(ocl-nav/collect ,(parse |Qualifier| :operand :pod-none) ,primary)))
			(:point-right (parse |Qualifier| :operand `(ocl-ensure-collection ,primary)))))
		finally (return primary))))))

;;; QualifiableFactor := ConstantRef | VariableRef | AttributeRef | OperatorRef OperatorArgs
;;;                      CollectionLiteralExp | TupleLiteralExp |  '(' OclExpression ')'
(defparse |QualifiableFactor| ()
  (let ((tkn  (peek-token stream))
	(tkn2 (peek-token stream 2)))
    (cond ((member tkn '(|Set| |Bag| |Sequence| |Collection| |OrderedSet|)) ; pod7 moved from after operator-p
	   (parse |CollectionLiteralExp|))
	  ((eql tkn '|Tuple|) ; pod7 moved from after operator-p
	   (parse |TupleLiteralExp|))
	  ((eql tkn #\*)
	   (parse |UnlimitedNaturalLiteralExp|))
	  ((eql tkn '|null|)
	   (parse |NullLiteralExp|))
	  ((and (constant-p tkn)) ; pod7 not type-p new
	   (parse |ConstantRef|))
	  ((type-p tkn) ; pod7 type-p new
	   (parse |PathName|))
	  ((and (attribute-p tkn) (operator-p tkn) (eql #\( tkn2))
	   `(,(parse |OperatorRef|) inject-self ,@(parse |OperatorArgs|)))
	  ;; 2006-10-13 I moved this (VariableRef) above attribute.
	  ((variable-p tkn) ; e.g. ->collect(in | in.allIncludedUseCases()))
	   (parse |VariableRef|))
	  ((and (attribute-p tkn) (not (eql #\( tkn2))) ; implicit self -- not #\( added 2012-02-24
	   `(,(parse |AttributeRef|) inject-self))
	  ((and (not (compiling-qvt-p))
		 (operator-p tkn)) ; implicit self
	   `(,(parse |OperatorRef|) inject-self ,@(parse |OperatorArgs|)))
	  ((and (compiling-qvt-p) (operator-p tkn)) ; implicit self 
	   (if (token-is tkn :qvt-function *scope*) ; 2014 added IF. Original is now in the else.
	       `(,(parse |OperatorRef|) ,@(parse |OperatorArgs|))
	       `(,(parse |OperatorRef|) nil ,@(parse |OperatorArgs|))))
	  ((string-const-p tkn) ;; added 2012-02-24
	   (parse |PrimitiveLiteralExp|))
	  ((eql tkn #\()
	   (read-token stream)
	   (prog1 
	       (parse |OclExpression|)       ;; This is what allows (7)->any() to pass.
	     ;;(parse |QualifiableFactor|)  ;; Problem is: (association.memberEnd - self)->any()
	     (assert-token #\) stream)))
	  (t (error 'ocl-parse-error 
		    :expected (strcat "ConstantRef, VariableRef, CollectionLiteral, TupleLiteral, NullLiteral"
				      " '(' or (with implicit self) AttributeRef or OperationCall")
		    :actual tkn)))))

;;; POD 2008 -- This was based on EXPRESS, presumably.
;;; Look at 8.3.5. 
;;; 
;;; ConstantRef := 'self' | 'null' | 'invalid' 
(defparse |ConstantRef| ()
  (let ((tkn (read-token stream)))
   (case tkn
     (|self| 'self)
     (|null| nil)
     (|invalid| '(make-instance '|OclInvalid|))
     (otherwise
      (cond ((keywordp tkn) tkn) 
	    ((constant-p tkn) ; 2012-02-25 cond is new, was just `',tkn
	     (cond ((eql tkn '|true|) :true)
		   ((eql tkn '|false|) :false)
		   (t `',tkn))) 
	    (t (error 'ocl-parse-error :expected "literal" :actual tkn)))))))

(defparse |AttributeRef| ()
  (let ((attr (read-token stream)))
    (if (attribute-p attr)
	(intern (strcat "%" (string-upcase (c-name2lisp (string attr)))) 
		(accessor-pkg)) ; <=====
      (error 'ocl-parse-error 
	     :expected "an identifier naming an attribute"
	     :actual attr))))

(defparse |VariableRef| ()
  (let ((id (read-token stream)))
    (if (variable-p id) 
	(if (not (compiling-qvt-p))
	    (intern (strcat "?" (string id)) (mofi:lisp-package mofi:*model*))
	    (progn ; Set things up for subsequent parsing of accessors. (See previous production!)
	      (qvt:set-accessor-pkg id) 
	      (qvt:mk-logic-var id)))
	(error 'ocl-parse-error 
	       :expected "an identifier naming an variable within scope"
	       :actual id))))

(defparse |VariableId| (token)
  (let ((id (or token (read-token stream))))
    (add-type id *scope* :variable) ; #+qvt #-qvt pretty much the same ???
    (if (not (compiling-qvt-p))
	(intern (strcat "?" (string id)) (mofi:lisp-package mofi:*model*))
	(qvt:mk-logic-var id))))

;;; Qualifier := ModelPropertyCallExp
(defparse |Qualifier| (operand)
  (parse |ModelPropertyCallExp| :operand operand))

;;; POD the grammar is a bit hosed here. iterate and forAll are different. 
;;; This needs to be fixed before publishing the grammar.
;;; ModelPropertyCall := AttributeRef 
;;; ModelPropertyCall := CollectionOperator CollectionOpBody
;;; ModelPropertyCall := Operator OperatorArgs
(defparse |ModelPropertyCallExp| (operand)
  (let ((tkn (peek-token stream))
	(tkn2 (peek-token stream 2)))
    (cond ((and (attribute-p tkn) (not (eql #\( tkn2))) ; wary of operators
	   (if (eql operand :pod-none)
	       `(function ,(parse |AttributeRef|))
	       `(,(parse |AttributeRef|) ,operand))) ; 2012-03-16 added this for nav/collect
	  ((collection-operator-p tkn)
	   (parse |CollectionCall| :operand operand))
	  ((operator-p tkn)
	   (if (eql operand :pod-none) ; 2012-03-16 added this for nav/collect
	       (let* ((op    (parse |OperatorRef|))
		      (args (parse |OperatorArgs|)))
		 (if args
		     (let ((var (make-var)))
		       `#'(lambda (,var) (,op ,var ,@args)))
		     `(function ,op)))
	       `(,(parse |OperatorRef|) ,operand ,@(parse |OperatorArgs|))))
	  (t (error 'ocl-parse-error 
		    :expected "AttributeRef or OperatorRef"
		    :actual tkn)))))

;;; ModelPropertyCall := IterateExp | ForAllExp | OtherCollectionExp
(defparse |CollectionCall| (operand)
  (let ((tkn (peek-token stream)))
    (case tkn
      (|iterate| (parse |IterateExp| :operand operand))
      (|forAll|  (parse |ForAllExp| :operand operand))
      (otherwise (parse |OtherCollectionExp| :operand operand)))))

;;; POD I really think the iter-var has to be defined (and initialized).
;;; First var is like typical collection op. Second var is accumulator).
;;; IterateExp ::= 'iterate' '(' VariableDeclaration ';' VariableDeclaration '|' OclExpression ')'
(defparse |IterateExp| (operand)
  (let ((*scope* (make-instance '%%scope :%%parent *scope* :%%type :collection))
	iter-var accum-var expr)
    (assert-token '|iterate| stream)
    (assert-token #\( stream)
    (setf iter-var (parse |VariableDeclaration|))
    (assert-token #\; stream)
    (setf accum-var (parse |VariableDeclaration|))
    (assert-token #\| stream)
    (setf expr (parse |OclExpression|))
    (assert-token #\) stream)
    ;; (defmacro ocl-iterate (s iter-var accum-var accum-init expression)...)
    `(ocl-iterate ,operand 
		  ,(var-decl--name iter-var)
		  ,(var-decl--name accum-var)
		  ,(var-decl--init accum-var)
		  ,expr)))

;;; POD It is not clear from the spec whether multiple or just two are allowed. I'm going with multiple.
;;; ForAllExp := 'forAll' '('  ( VariableId { ',' VariableId } '|' )? OclExpression ')'
;;; POD 2008-03-08 I'm adding the syntax forALL (p : TYPE | ...
(defparse |ForAllExp| (operand)
  (assert-token '|forAll| stream)
  (assert-token #\( stream)
  (let ((bar-pos (found-at-pos #'(lambda (x) (eql x #\|)) stream))
	(close-pos (found-at-pos #'(lambda (x) (eql x #\))) stream))
	vars apply-fn)
    (let ((*scope* (make-instance '%%scope :%%parent *scope* :%%type :collection))
	  (tkn2 (peek-token stream 2)))
      (when (and bar-pos close-pos (< bar-pos close-pos) ; variant with variables declared
		 (or (member tkn2 '(#\, #\| #\:))))      ; 2012-02-24 This check that next really is a variable.
	(setf vars (cons (parse |VariableId|)
			 (loop while (eql #\, (peek-token stream))
			       do (read-token stream)
			       collect (parse |VariableId|))))
	;; 2008-03-08 add
	(when (eql #\: (peek-token stream))
	  (read-token stream)
	  (let ((tkn (read-token stream)))
	    (unless (type-p tkn)
	      (error 'ocl-parse-error :expected "a type" :actual tkn))))
	(assert-token #\| stream))
      (setf apply-fn (parse |OclExpression|))
      (assert-token #\) stream))
    (cond ((null vars)
	   (let ((var (make-var))) ; tricky, need to replace self here!
	     `(ocl-for-all ,operand #'(lambda (,var) ,(subst var 'inject-self apply-fn)))))
	  ((null (cdr vars))
	   `(ocl-for-all ,operand #'(lambda (,@vars) ,apply-fn)))
	  (t ; multiple vars, Cartesian product. POD Leave order 'backwards'?
	   (loop for v in (cdr vars) 
		 with result = `(ocl-for-all ,operand #'(lambda (,(car vars)) ,apply-fn))
		 do (setf result `(ocl-for-all ,operand #'(lambda (,v) ,result)))
		 finally (return result))))))

;;; OtherCollectionExp := OtherCollectionOperator OtherCollectionOpBody
(defparse |OtherCollectionExp| (operand)
  (let ((operator (parse |OtherCollectionOperator|))) ; pod could also be &key args NYI
    (dbind (&key var apply-fn) (when (member (peek-token stream) '(#\( #\[)) 
				 (parse |OtherCollectionOpBody|))
     (if var
	 `(,operator ,operand #'(lambda (,(var-decl--name var)) ,apply-fn))
       (let ((var (make-var))) ; tricky, need to replace self here! 2012-03-15 PROBLEM!
	 `(,operator ,operand #'(lambda (,var) ,(subst var 'inject-self apply-fn))))))))

;;; OtherCollectionOperator := ...(not forAll, not iterate)
(defparse |OtherCollectionOperator| ()
  (ecase (read-token stream)
    (|exists| 'ocl-exists)
    (|isUnique| 'ocl-is-unique)
    (|any| 'ocl-any)
    (|one| 'ocl-one)
    (|collect| 'ocl-collect)
    (|closure| 'ocl-closure)
    (|select| 'ocl-select)
    (|reject| 'ocl-reject)
    (|sortedBy| 'ocl-sorted-by)
    (|collectNested| 'ocl-collect-nested))) ; POD not defined in spec, not in L3.

;;; (a) OtherCollectionOpBody ::= '(' (VariableDeclaration '|' )? OclExpression ')'
;;; (b) OtherCollectionOpBody ::= '('  arguments? ')'
;;; (c) OtherCollectionOpBody ::=  ('[' arguments ']')?   ; POD NYI, is it for real?
(defparse |OtherCollectionOpBody| ()
  (assert-token #\( stream)
  (let ((bar-pos (found-at-pos #'(lambda (x) (eql x #\|)) stream))
	(close-pos (found-at-pos #'(lambda (x) (eql x #\))) stream))
	result)
    (cond ((and bar-pos close-pos (< bar-pos close-pos)) ; (a)-variant with |
	   (let ((*scope* (make-instance '%%scope :%%parent *scope* :%%type :collection)))
	     (setf result (list :var (prog1 (parse |VariableDeclaration|) (assert-token #\| stream))
				:apply-fn (parse |OclExpression|)))))
	  ((eql #\) (peek-token stream)) ; (b)-variant without args, like ->any()
	   (setf result (list :var nil :apply-fn 'inject-self)))
	  (t ; (a)-variant without |
	   (setf result (list :var nil :apply-fn (parse |OclExpression|)))))
    (assert-token #\) stream)
    result))

;;; Used for def: 
(defparse |OperatorId| ()
  (let* ((tkn (read-token stream))
	 (pkg (mofi:lisp-package (operator-p tkn)))) 
    (mofi:shadow-and-warn 
     (string-upcase (c-name2lisp (string tkn)))
     pkg
     :export-p nil)))

(defparse |OperatorRef| ()
  (let* ((tkn (read-token stream))
	 (pkg (mofi:lisp-package (operator-p tkn))))
    (if-bind (lisp-fn (in-ocl-stdlib-p tkn))
       lisp-fn     
       (mofi:shadow-and-warn
	(string-upcase (c-name2lisp (string tkn)))
	pkg
	:export-p nil))))
		

;;; OperatorArgs := '(' arguments? ')'
(defparse |OperatorArgs| ()
  (let (args)
    (assert-token #\( stream)
    (unless (eql #\) (peek-token stream))
      (setf args (parse |arguments|)))
    (assert-token #\) stream)
    args))

;;; simpleName ::= <String>
#|
(defparse |simpleName| ()
  (let ((tkn (read-token stream)))
    (if-bind (lisp-fn (in-ocl-stdlib-p tkn))
       lisp-fn     
      (intern (c-name2lisp (string tkn))
	      (mofi:lisp-package mofi:*model*)))))
|#
(defvar *zippy* nil)

;;; Looking at 7.5.7, syntax is really:
;;; xx  PathName ::= simpleName ('::' pathName )?
;;;     PathName (packageName ::)* typeName  <==== 2012 I'm using this one.
;;; Returns an appropriate (find-class ...) form 
(defparse |PathName| (symbol-only-p)
  ;(handler-bind ((ocl-parse-error #'(lambda (c) (declare (ignore c)) (setf *zippy* c) (break "hee"))))
  (let ((type-name nil)
	(package-names
	 (loop for tkn2 = (peek-token stream 2)
	       while (eql tkn2 :colon-colon)
               for p = (read-token stream) 
	       collect p do
	       (unless (package-p p) (error 'ocl-parse-error :expected "a package name" :actual p))
	       (read-token stream)))) ; ::
    (setf type-name (read-token stream))
    ;; Make sure there is a path all the way from the top down to the type name. 
    ;; If no packages, look for typeName in an *in-scope-model*.types.
    ;; POD currently not requiring the starting package to be a model-level one!
    (let ((all-packs (mapappend #'mofi:packages 
				(remove-if #'(lambda (x) (typep x 'mofi:population))
							   *in-scope-models*))))
      (if package-names
	  (if-bind (p (find (car package-names) all-packs :key #'mofi:name :test #'string-equal)) ; 2014 was string=, for qvt.
	   (let ((owning-pack ;; They must be children...
		  (loop for pn in (cdr package-names)
		     for childp = (find pn (mofi::owned-element p) :key #'mofi:name :test #'string=)
		     if childp do (setf p childp)
		     else do (error 'ocl-parse-error :expected "a package name(1)" :actual pn)
		     finally (return p))))
	     (if-bind (class (find type-name (remove-if #'(lambda (x) (typep x 'mofi::mm-package-mo))
							(mofi::owned-element owning-pack))
				   :key #'class-name :test #'string=))
		      (if symbol-only-p (class-name class) `(find-class ',(class-name class)))
	       (error 'ocl-parse-error :expected "a type name" :actual type-name)))
	   (error 'ocl-parse-error :expected "a package name(2)" :actual (car package-names)))
	  ;; Here if PathName was just a type-name
	  (if-bind (class (find type-name (remove-if #'(lambda (x) (typep x 'mofi::mm-package-mo))
						     (mapappend #'mofi::owned-element all-packs))
				:key #'class-name :test #'string=))
		   (if symbol-only-p (class-name class) `(find-class ',(class-name class)))
		   (error 'ocl-parse-error :expected "a type name" :actual type-name))))))

(defun owned-classes (p)
  "Collect the classes owned by package P."
  (cond ((typep p 'mofi::mm-type-mo) (list p))
	((typep p 'mofi::mm-package-mo)
	 (mapappend #'owned-classes (mofi::owned-element p)))))

;;; POD Enums in L3 are #something.
;;; XX EnumLiteralExp ::= PathName '::' enum-value
;;;    EnumLiteralExp ::= (packageName ::)* TypeName '::' enum-value
;;; Problem with XX is that it will try to consume enum-value as a type.
(defparse |EnumLiteralExp| ()
  (let (type-name package)
    (loop while (package-p (peek-token stream)) do
	  (read-token stream)
	  (assert-token :colon-colon stream))
    (setf type-name (read-token stream))
    (unless (setf package (type-p type-name))
      (error 'ocl-parse-error :expected "a type name" :actual type-name))
    (assert-token :colon-colon stream)
    (let ((enum-class (find-class (intern type-name (mofi:lisp-package package))))
	  ;; 2010-06-24 added upcase
	  (enum-value (intern (string-upcase (read-token stream)) :keyword)))
      (unless (member enum-value (mofi:enum-values enum-class))
	(error 'ocl-parse-error 
	       :expected (format nil "a enumeration value of type ~A" type-name)
	       :actual enum-value))
      enum-value)))
#|	
(defparse |EnumLiteralExp| ()
  (let* ((type-name (parse |PathName| :no-find-class t))
	 (enum-class (find-class type-name)))
    (unless (mofi:enum-p enum-class)
  (assert-token :colon-colon stream)
  (intern (string (read-token stream)) :keyword))
|#

;;; CollectionLiteralExp ::= CollectionTypeIdentifier ‘{‘ CollectionLiteralParts? ‘}'
(defparse |CollectionLiteralExp| ()
  (let (class val)
    (setf class (parse |CollectionTypeIdentifier|))
    (assert-token #\{ stream)
    (if (eql #\} (peek-token stream))
	(read-token stream)
      (progn 
	(setf val (parse |CollectionLiteralParts|))
	(assert-token #\} stream)))
    `(make-instance ',class :value ,val)))

;;; CollectionTypeIdentifier ::= 'Set'
;;; CollectionTypeIdentifier ::= 'Bag'
;;; CollectionTypeIdentifier ::= 'Sequence'
;;; CollectionTypeIdentifier ::= 'Collection'
;;; CollectionTypeIdentifier ::= 'OrderedSet'
(defparse |CollectionTypeIdentifier| ()
  (let ((tkn (read-token stream)))
    (if-bind (class (car (member tkn '(|Set| |Bag| |Sequence| |Collection| |OrderedSet|))))
       class
       (error 'ocl-parse-error 
	      :expected "one of Set, Bag, Sequence, Collection, OrderedSet"
	      :actual tkn))))

;;; 2012-02-22 Rewrite / 2012-03-03 append -> mapappend:
;;; CollectionLiteralParts ::= CollectionLiteralPart { ',' CollectionLiteralParts }
(defparse |CollectionLiteralParts| ()
  `(mapappend ; example where you get a collection : OrderedSet{ownedEnd}
    #'(lambda (x) (if (typep x 'ocl:|Collection|) (ocl:value x) x))
    ,@(list
       (parse |CollectionLiteralPart|)
       (loop while (eql #\, (peek-token stream))
	  do (read-token stream)
	  collect (parse |CollectionLiteralPart|)))))

;;;Pre 2012-02-22
;(defparse |CollectionLiteralParts| ()
;  `(list 
;    ,@(cons
;       (parse |CollectionLiteralPart|)
;       (loop while (eql #\, (peek-token stream))
;	     do (read-token stream)
;	     collect (parse |CollectionLiteralPart|)))))

;;; OCL is apparently an arbitrary look-ahead grammar!
#| Start using one in pod-utils
(defun found-at-pos (predicate stream)
 " Return the position (only useful for relative comparison) in the 
   token stream where PREDICATE (function of one arg) returns true. Pred is applied to 
   tokens read sequentially from the stream. If hit :eof, returns nil."
  (loop for pos from 1
	for tkn = (peek-token stream pos)
	when (eql tkn :eof) return nil
	when (funcall predicate tkn) return pos))
|#

;;; CollectionLiteralPart ::= CollectionRange
;;; CollectionLiteralPart ::= OclExpression
;;; Holy $&%#! What a grammar!  
(defparse |CollectionLiteralPart| ()
  (if (found-at-pos #'(lambda (x) (eql :dot-dot x)) stream) ; POD seems wrong 2007-10-16
      (parse |CollectionRange|)
    (parse |OclExpression|)))

;;; 2012-02-22 (previously was returning (list lower upper)
;;; POD CollectionRange not used in L3 (no :dot-dot)
;;;CollectionRange ::= OclExpression '..' OclExpression
(defparse |CollectionRange| ()
  (let (lower upper)
    (setf lower (parse |OclExpression|))
    (assert-token :dot-dot stream)
    (setf upper (parse |OclExpression|))
    (let ((val (intern (string (gensym "?X")))))
      `(loop for ,val from ,lower to ,upper collect ,val))))

;;; PrimitiveLiteralExp ::= IntegerLiteralExp
;;; PrimitiveLiteralExp ::= RealLiteralExp
;;; PrimitiveLiteralExp ::= StringLiteralExp
;;; PrimitiveLiteralExp ::= BooleanLiteralExp
;;; IntegerLiteralExp ::= <String>
;;; RealLiteralExp ::= <String>
;;; StringLiteralExp ::= ''' <String> '''
;;; BooleanLiteralExp ::= 'true'
;;; BooleanLiteralExp ::= 'false'
(defparse |PrimitiveLiteralExp| ()
  (let ((tkn (read-token stream)))
    (cond ((numberp tkn) tkn)
	  ((string-const-p tkn) (string-const--value tkn))
	  ((string= tkn "true") :true)
	  ((string= tkn "false") :false)
	  (t 
	   (error 'ocl-parse-error 
		  :expected "a primitve literal" :actual tkn)))))

;;; TupleLiteralExp ::= 'Tuple' '{' VariableDeclarationList '}'
(defparse |TupleLiteralExp| ()
   (assert-token '|Tuple| stream)
   (assert-token #\{ stream)
   (parse |VariableDeclarationList|)
   (assert-token #\} stream))

;;; Added 2012-02-13
;;; NullLiteralExp ::= 'null' 
(defparse |NullLiteralExp| ()
   (assert-token '|null| stream)
   nil)

;;; POD 2012-02-24 Not sure why I can't use '*, but 
;;; (oclp::uml-ocl2lisp "def: compatibleWith (other : MultiplicityElement) 
;;;                       (other.lowerBound() <= self.lowerBound()) and ((other.upperBound() = *) or 
;;;                       (self.upperBound() <= other.upperBound()))" :class-context 
;;;                   'uml25:|MultiplicityElement|)
;;; ... will result in * not '*. 
(defparse |UnlimitedNaturalLiteralExp| ()
   (assert-token #\* stream)
   :*)

;;; POD These productions are suspect.
;;; Type ::= Pathname
;;; Type ::= CollectionType
;;; Type ::= Tupletype
(defparse |Type| (no-find-class)
  (case (peek-token stream)
    (|Tuple| (parse |TupleType|))
    ((|Set| |Bag| |Sequence| |Collection| |OrderedSet|) (parse |CollectionType|))
    (otherwise (parse |PathName| :symbol-only-p no-find-class)))) ; 2014-09-06 there was a bug here :no-find-class !!!

;;; POD added the optional , also NYI
;;; CollectionType ::= collectionTypeIdentifier ( '(' type ')' )?
(defparse |CollectionType| ()
  (prog1
    (parse |CollectionTypeIdentifier|)
    (when (eql #\( (peek-token stream))
      (read-token stream)
      (parse |Type|)
      (assert-token #\) stream))))

;;; TupleType ::= 'Tuple' '(' VariableDeclarationList? ')'
(defparse |TupleType| ()
  (assert-token '|Tuple| stream)
  (assert-token #\( stream)
  (unless (eql #\) (peek-token stream))
    (parse |VariableDeclarationList|))
  (assert-token #\) stream))

;;; VariableDeclarationList = VariableDeclaration { ',' VariableDeclaration }
(defparse |VariableDeclarationList| ()
  (cons 
   (parse |VariableDeclaration|)
   (loop while (eql #\, (peek-token stream))
	 do (read-token stream)
	 collect (parse |VariableDeclaration|))))


;;; VariableDeclaration ::= VariableId (':' Type)? ( '=' OclExpression )?
(defparse |VariableDeclaration| ()
  (let (var type val)
    (setf var (parse |VariableId|))
    (when (eql #\: (peek-token stream))
      (read-token stream)
      (setf type (parse |Type|)))
    (when (eql #\= (peek-token stream))
      (read-token stream)
      (setf val (parse |OclExpression|)))
    ;; Want type symbol and not find-class for use in ocl-assert, at least.
    ;; pod7 or should I change ocl-asert?
    (when (and (consp type) (eql (car type) 'find-class))
      (setf type (second (cadr type))))
    (make-var-decl :-name var :-type type :-init val)))

;;; isMarkedPre ::= '@' 'pre'
(defparse |isMarkedPre| ()
  (assert-token #\@ stream)
  (assert-token '|pre| stream))

;;; arguments ::= OclExpression { ',' OclExpression }
(defparse |arguments| ()
  (cons
   (parse |OclExpression|)
   (loop while (eql #\, (peek-token stream))
	 do (read-token stream)
	 collect (parse |OclExpression|))))

;;; LetExp ::= 'let' VariableDeclaration { , VariableDeclaration } 'in' OclExpression
(defparse |LetExp| ()
  (let ((*scope* (make-instance '%%scope :%%parent *scope* :%%type :let))
	vars exp)
    (assert-token '|let| stream)
    (setf vars
	  (cons (parse |VariableDeclaration|)
		(loop while (eql #\, (peek-token stream))
		      do (read-token stream)
		      collect (parse |VariableDeclaration|))))
    (assert-token '|in| stream)
    ;(loop for v in vars do (add-type (var-decl--name v) *scope* :variable))
    (setf exp (parse |OclExpression|))
    `(let* ,(mapcar #'(lambda (v) (list (var-decl--name v) (var-decl--init v))) vars)
       ,@(loop for v in vars
	       when (var-decl--type v)
	       collect `(ocl-assert (,(var-decl--type v) ,(var-decl--name v))))
       ,exp)))

#| ^ is not found in L3, so.... 
(But when you do implement, knock off the initial OclExpression and call from |Qualifier|
;;; OclMessageExp ::= OclExpression '^^' simpleName '(' OclMessageArguments? ')'
;;; OclMessageExp ::= OclExpression '^' simpleName '(' OclMessageArguments? ')'

;;; OclMessageArguments ::= OclMessageArg ( ',' OclMessageArguments )?

;;; OclMessageArg ::= '?' (':' type)?
;;; OclMessageArg ::= OclExpression
|#

;;; IfExp ::= 'if' OclExpression 'then' OclExpression 'else' OclExpression 'endif'            
(defparse |IfExp| ()
  (let (test then else)
    (assert-token '|if| stream)
    (setf test (parse |OclExpression|))
    (assert-token '|then| stream)
    (setf then (parse |OclExpression|))
    (assert-token '|else| stream)
    (setf else (parse |OclExpression|))
    (assert-token '|endif| stream)
    `(ocl-if ,test ,then ,else)))

;;; OclDef := 'def' ':' OperatorId '(' VariableDeclaration { ',' VariableDeclaration } ')' OclExpression  
(defparse |OclDef| ()
  (let ((*scope* (make-instance '%%scope :%%parent *scope* :%%type :def)) vars)
    (assert-token '|def| stream)
    (assert-token #\: stream)
    (parse |OperatorId|)
    (assert-token #\( stream)
    (setf vars (loop while (eql #\: (peek-token stream 2)) ; pod ugh!
		     collect (parse |VariableDeclaration|) ; pod another misuse.
		     when (eql #\, (peek-token stream)) do (read-token stream)))
    (assert-token #\) stream)
    (mapcar #'(lambda (v) (add-type (var-decl--name v) *scope* :variable)) vars)
    `(progn
      ,@(mapcar #'(lambda (v) `(ocl-assert (,(var-decl--type v) ,(var-decl--name v)))) vars)
      ,(parse |OclExpression|))))


;    `(defmethod ,fname ((self ,*class-context*) ,@(mapcar #'var-decl--name vars))
;       ,@(mapcar #'(lambda (v) `(ocl-assert (,(var-decl--type v) ,(var-decl--name v)))) vars)
;       ,(parse |OclExpression|))))

  
  
