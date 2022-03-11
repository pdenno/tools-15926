
;;; Copyright (c) 2005 Peter Denno
;;;
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

;;; Purpose: Instantiate Express MM instances from an EXPRESS schema. 
;;;          This is the 'second pass' parser that requires that the parser
;;;          p11/parser1 ohas been run.

#| Design notes:
    %%scope objects are made in :pass1. The %%obj of a %%scope is set in this pass to a |Scope| object.
    make-scoped-id looks up the %%scope tree (from whatever scope it was called in) for a %%scope 
    that defines that identifier. It uses that for the key. Thus this ensures that there is only 
    one |ScopedId| object for any identifier/scope pair. 
|#

;;; TODO: Write validator code (type, abstract-p, and cardinality).
(in-package :p11p)

(defvar *zippy* nil "diagnostics")

;;POD7 commented this out.
;;; This because :use emm and exporting from emm is not enough (compile-time issue?)
;(eval-when (:compile-toplevel :load-toplevel :execute)
;  (loop for class-name being the hash-key of emm:*mm-classes* do
;	(import class-name)
;	(loop for slot in (closer-mop:class-direct-slots (find-class class-name))
;	      for slot-name = (closer-mop:slot-definition-name slot) 
;	      with pkg = (find-package :emm) do
;	      (import slot-name)
;	      (import (intern (strcat "%" (c-name2lisp (string slot-name)))) pkg)))
;)

(defvar *def* nil "Dynamically bound to the current MM object")

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro with-instance ((type &rest init-args &key find-id find-contains find-force) &body body)
  "A macro that either creates or finds an object, and provides with-accessors for the slots of it."
  `(let ((*def* ,(cond ((or find-id find-contains)
			`(find-child-scope 
			  :name (if (typep ,find-id '|ScopedId|) 
				       (%local-name ,find-id)
				       ,find-id)
			  :contains ,find-contains))
		       (find-force find-force)
		       (t `(make-instance ',type ,@init-args)))))
    (when (or (null *def*) (eql *def* :fail))
      (error 'scope-error
	     :text (format nil "Could not find Scope object with specified find-id/contains conditions: ~A"
			  ,(or find-id find-contains))))
    (with-accessors 
	,(mapcar #'(lambda (slot)
		     (list (closer-mop:slot-definition-name slot)
			      (intern (strcat "%" 
					      (string-upcase 
					       (c-name2lisp 
						(symbol-name (closer-mop:slot-definition-name slot)))))
				      (find-package :mexico))))
		 (closer-mop:class-slots (find-class type))) *def*
		 (declare (ignorable ,@(mapcar #'closer-mop:slot-definition-name 
					       (closer-mop:class-slots (find-class type)))))
					;(setf (%token-position *def*) (expo:token-position *token-stream*))
		 ,@body
		 *def*))))

(defmacro mk-instance (type &rest initargs)
  "Like make-instance, but uses accessors to set values, so that setf methods will fire."
  (with-gensyms (def)
    `(let ((,def (make-instance ,type)))
      ,@(loop while initargs
	      for arg = (pop initargs)
	      collect `(setf (,(intern (string-upcase (format nil "%~A" arg)) :mexico)
			      ,def)
			,(pop initargs)))
      ,def)))


;;;======================================================================
;;; Parsing...
;;;======================================================================

(defmethod parse2-data ((path pathname) (tag (eql :p11-file)) &key)
  (unless (and *scope* (typep *scope* '|Scope|)) (error "*scope* object not set!"))
  (with-open-file (char-stream path :direction :input)
    (with-open-stream (stream (setf *token-stream* (make-p11-stream char-stream)))
      (parse2-data stream :stream)))
  *scope*)

(defmacro defparse2-p11 (tag (&rest keys) &body body)
  `(defmethod parse2-data ((stream p11-stream) (tag (eql ',tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys) 
		       `(parse2-data stream ',tag ,@keys)))
       ,@body)))

;; The top-level grammar rule:
(defparse2-p11 :stream ()
  (setf *tags-trace* nil)
  (parse :syntax))

;;; The following productions are handled by the reader code:
;;;   binary_literal = '%' bit { bit } .
;;;   integer_literal = [ sign ] digit { digits } .
;;;   real_literal = [ sign ] digit { digits } '.' { digits } [ 'E' [ sign ] digit { digits } ] .
;;;   encoded_string_literal = '"' encoded_character { encoded_character } '"' .
;;;   encoded_character = octet octet octet octet .
;;;   octet = hex hex .
;;;   hex = digit | 'a' | 'b' | 'c' | 'd' | 'e' | 'f' .
;;;   digit = bit | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' .
;;;   bit = '0' | '1' .
;;;   sign = '-' | '+' .
;;;   letter = 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'
;;;          | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' .
;;;   simple_id = letter { letter | digit | '_' } .
;;;   simple_string_literal = <you know what goes here> .

;;; ; For MM the _ref types should not use X_id. We want the name (symbol) not a |ScopedId| etc.
(defparse2-p1114 :simple_id ()
  (break "don't use this"))

(defvar *p14-force-scope* nil)

;145 attribute_ref = attribute_id .
(defparse2-p1114 :attribute_ref ()
   (mk-instance 'unresolved-attribute-ref 
		:local-name (string (read-token stream))
		:%scope (or *p14-force-scope* *scope*)))

;146 constant_ref = constant_id .
(defparse2-p11 :constant_ref ()
  (with-instance (|ConstantRef|)
    (setf |id| (name2scoped-id (read-token stream)))))

;147 entity_ref = entity_id .
(defparse2-p1114 :entity_ref ()
  (let ((id (make-scoped-id (read-token stream))))
    (lookup-referenceable id)))

;148 enumeration_ref = enumeration_id .
(defparse2-p1114 :enumeration_ref ()
  (make-scoped-id (read-token stream)))

;149 function_ref = function_id .
(defparse2-p1114 :function_ref ()
  (let ((id (make-scoped-id (read-token stream))))
    (lookup-referenceable id)))

;;; 2007 was just read-token, very similar to variable_ref
;;; Will need to find refers-to (a |Variable|) in PP
;150 parameter_ref = parameter_id .
(defparse2-p1114 :parameter_ref ()
  (with-instance (|ParameterRef|)
    (setf |id| (make-scoped-id (read-token stream)))
    (setf |refers-to| (find-var/param-refers-to mexico:|id|))
    (when |refers-to|
      (setf |data-type|
	    (etypecase |refers-to| ; test is only needed by e-x.
	      (|Parameter| (%formal-parameter-type |refers-to|))
	      (|Variable|  (%variable-type |refers-to|)))))))

;151 procedure_ref = procedure_id .
(defparse2-p11 :procedure_ref ()
  (make-scoped-id (read-token stream)))

;152 schema_ref = schema_id .
(defparse2-p11 :schema_ref ()
  (read-token stream))

;153 type_label_ref = type_label_id .
(defparse2-p11 :type_label_ref ()
  (read-token stream))

;154 type_ref = type_id .
(defparse2-p1114 :type_ref ()
  (let ((id (make-scoped-id (read-token stream))))
    (lookup-referenceable id)))

;155 variable_ref = variable_id .
(defparse2-p1114 :variable_ref ()
  (with-instance (|VariableRef|)
    (setf |id| (make-scoped-id (read-token stream)))
    (setf |refers-to| (find-var/param-refers-to |id|))
    (when |refers-to| 
      (setf |data-type| ; Yeah, I don't track whether VRef vs PRef, especially in e-x!
	    (etypecase |refers-to|
	      (|Variable| (%variable-type |refers-to|))
	      (|Parameter| (%formal-parameter-type |refers-to|)))))))
;;; This situation is probably because it is a type_label.
;;;   (when (typep |data-type| '|ScopedId|) (break "huh?"))))

(defun find-var/param-refers-to (id &optional (scope *scope*))
  (cond ((typep scope '|Schema|) (warn "Couldn't find referent of ~A" id)
	 (break "referent"))
	((find id 
	       (typecase scope
		 (|QueryExpression| (%query-variable scope))
		 (|RepeatStatement| (%control-variable scope))
		 (t (append (%variables scope) 
			    (and (typep scope '|Function|)
				 (%formal-parameters scope)))))
	       :key #'%id))
	(t (find-var/param-refers-to id (%%parent scope)))))

; 164 abstract_entity_declaration = ABSTRACT .
(defparse2-p11 :abstract_entity_declaration ()
  (assert-token 'abstract stream))

; 165 abstract_supertype = ABSTRACT SUPERTYPE ’;’ .
(defparse2-p11 :abstract_supertype ()
  (assert-token 'abstract stream)
  (assert-token 'supertype stream)
  (assert-token #\; stream)
  (make-instance '|ABSTRACTConstraint|))

; 166 abstract_supertype_declaration = ABSTRACT SUPERTYPE [ subtype_constraint ] .
(defparse2-p11 :abstract_supertype_declaration () 
  (assert-token 'abstract stream)
  (assert-token 'supertype stream)
  (when (check-token 'of stream)
     (parse :subtype_constraint)))

; 167 actual_parameter_list = '(' parameter { ',' parameter } ')' .
(defparse2-p1114 :actual_parameter_list ()
  (let (params)
    (assert-token #\( stream)
    (setf params
	  (cons
	   (parse :parameter) ; It holds an expression. (Should be called :actual_parameter)...
	   (loop while (check-token #\, stream)
		 do (read-token stream)
		 collect (parse :parameter))))
    (loop for p in params for i from 0 do (setf (%position p) i))
    (assert-token #\) stream)
    params))

;;; PODsampson some (-- this one) BinaryOperators in this file were like 
;;; (make-instance '|BinaryOperator| :id (make-scoped-id "OR" :scope (schema-scope *scope*)))
;;; Perhaps this referred to an old MEXICO. Anyway, I don't get the id of the schema scope at all.
;168 add_like_op = '+' | '-' | OR | XOR .
(defparse2-p1114 :add_like_op ()
  (ecase (read-token stream)
    (#\+ (make-instance 'unresolved-operator :enum-symbol "+"))
    (#\- (make-instance 'unresolved-operator :enum-symbol "-"))
    (or  (make-instance 'unresolved-operator :enum-symbol "or"))  ; -- this one
    (xor (make-instance 'unresolved-operator :enum-symbol "xor")))) ; -- this one


;169 aggregate_initializer = '[' [ element { ',' element } ] ']' .
(defparse2-p1114 :aggregate_initializer ()
  (with-instance (|AggregateInitializer|)
    (assert-token #\[ stream)
    (setf |bindings|
       (unless (check-token #\] stream)
	 (cons (parse :element) 
	       (loop while (check-token #\, stream) do
		     (read-token stream)
		     collect (parse :element)))))
    (loop for b in |bindings| for i from 0 do (setf (%position b) i))
    (assert-token #\] stream)))

;170 aggregate_source = simple_expression .
(defparse2-p1114 :aggregate_source ()
  (let ((result (parse :simple_expression)))
    (when (typep result '|ScopedId|) (VARS result))
    (typecase result
      (|ScopedId| (make-instance '|ExtentRef| :id result))
      (t result)))) ; expression 

; POD since the type_label is not passed, some later processing should
;        be done to resolve all of these that are constrained to be of the same type (use type_label!).
;        See |ActualTypeConstraint|.
;171 aggregate_type = AGGREGATE [ ':' type_label ] OF parameter_type .
(defparse2-p1114 :aggregate_type ()
  (with-instance (|AGGREGATEType|)
   (assert-token 'aggregate stream)
   (when (check-token #\: stream)
     (read-token stream)
     (parse :type_label)) ; pod create a slot and store this somewhere
   (assert-token 'of stream)
   (setf |member-type| (parse :parameter_type))))

;172 aggregation_types = array_type | bag_type | list_type | set_type .
(defparse2-p1114 :aggregation_types ()
  (ecase (peek-token stream)
    (array (parse :array_type))
    (bag   (parse :bag_type))
    (list  (parse :list_type))
    (set   (parse :set_type))))

;173 algorithm_head = { declaration } [ constant_decl ] [ local_decl ] .
(defparse2-p1114 :algorithm_head ()
  ;; let for debugging
  (let* ((decls (loop while (member (peek-token stream) '(entity function procedure type))
		     collect (parse :declaration))) ; pod no place for this in MM. 
	 (const (when (check-token 'constant stream) 
		  (parse :constant_decl))) ; pod no place for this in MM. 
	 (locals (when (check-token 'local stream)
		   (parse :local_decl)))) 
    (list decls const locals)))

;;; POD NYI
;174 alias_stmt = ALIAS variable_id FOR general_ref { qualifier } ';' stmt { stmt } END_ALIAS ';' .
(defparse2-p11 :alias_stmt ()
    (assert-token 'alias stream)
    (let ((variable (parse :alias_variable_id)))
      (with-instance (|AliasStatement| :find-id (%local-name variable))
	(setf |alias-variable| variable)
	(let* ((*scope* *def*)
	       (primary (parse :general_ref))
	       (qualifiers
		(loop while (member (peek-token stream) '(#\. #\\ #\[))
		      collect (parse :qualifier))))
	  (setf (%referent variable) (mm-qfactor-qifers primary qualifiers))
	  (assert-token #\; stream)
	  (setf |body|
		(loop until (check-token 'end_alias stream)
		      collect (parse :stmt)))
	  (read-token stream)
	  (assert-token #\; stream)))))

;175 array_type = ARRAY bound_spec OF [ OPTIONAL ] [ UNIQUE ] instantiable_type .
(defparse2-p1114 :array_type ()
  (with-instance (|ARRAYType|)
    (assert-token 'array stream)
    (setf |ordering| "indexed")
    (when (check-token #\[ stream)
	(dbind (lbound ubound) (parse :bound_spec)
	 (setf |lower-bound| lbound)
	 (setf |upper-bound| ubound)))
    (assert-token 'of stream)
    (setf |isOptional| :false)
    (when (check-token 'optional stream)
      (setf |isOptional| :true)
      (read-token stream))
    (setf |isUnique| :false) 
    (when (check-token 'unique stream)
      (setf |isUnique| :true) 
      (read-token stream))
    (setf |member-type| (parse :instantiable_type))))

;176 assignment_stmt = general_ref { qualifier } ':=' expression ';' .
(defparse2-p1114 :assignment_stmt ()
  (with-instance (|Assignment|)
    (let ((primary (parse :general_ref))
	  (qualifiers
	   (loop while (member (peek-token stream) '(#\. #\\ #\[))
		 collect (parse :qualifier))))
      ;; pod8mex - MEXICO doesn't try to address the Expression on the LHS.
      ;; My place-reference whill have to be post-processed into their VARExpression.
      (setf |place-reference| (mm-qfactor-qifers primary qualifiers))
      (assert-token :colon-equal stream)
      (setf |assigned-value| (parse :expression))
      (assert-token #\; stream))))

;177 attribute_decl = attribute_id | redeclared_attribute .
(defparse2-p11 :attribute_decl ()
  (if (check-token 'self stream)
	 (parse :redeclared_attribute)
	 (parse :attribute_id)))

;178 attribute_id = simple_id .
(defparse2-p11 :attribute_id () 
  (make-scoped-id (read-token stream)))

;179 attribute_qualifier = '.' attribute_ref .
(defparse2-p11 :attribute_qualifier ()
  (assert-token #\. stream)
  (parse :attribute_ref))

;180 bag_type = BAG [ bound_spec ] OF instantiable_type .
(defparse2-p1114 :bag_type ()
  (with-instance (|BAGType|)
    (assert-token 'bag stream)
    (setf |ordering| "unordered")
    (when (check-token #\[ stream)
	(dbind (lbound ubound) (parse :bound_spec)
	 (setf |lower-bound| lbound)
	 (setf |upper-bound| ubound)))
    (assert-token 'of stream)
    (setf |member-type| (parse :instantiable_type))))

(defmemo binary-type-memo (precision)
  (if (eql precision :unspecified)
	 (make-instance '|BinaryType| :id :binary)
     (make-instance '|BinaryType| :binary-length-constraint precision)))

;181 binary_type = BINARY [ width_spec ] .
(defparse2-p1114 :binary_type ()
  (assert-token 'binary stream)
  (if (check-token #\( stream)
    (let (precise)
      (read-token stream)
      (setf precise (parse :precision_spec))
      (assert-token #\) stream)
      (binary-type-memo precise))
    (binary-type-memo :unspecified)))

(defmemo boolean-type-memo ()
  (with-instance (|BooleanType|)
    (setf |id| :BOOLEAN))) ; pod part of issue with SimpleType

;182 boolean_type = BOOLEAN .
(defparse2-p1114 :boolean_type ()
  (assert-token 'boolean stream)
  (boolean-type-memo))

;183 bound_1 = numeric_expression .
(defparse2-p1114 :bound_1 ()
  (with-instance (|SizeConstraint|)
    (let ((expr (parse :numeric_expression)))
      (if (typep expr '|Literal|)
	  (setf |bound| expr)
	(setf |asserts| expr)))))

;184 bound_2 = numeric_expression .
(defparse2-p1114 :bound_2 ()
  (with-instance (|SizeConstraint|)
    (let ((expr (parse :numeric_expression)))
      (if (typep expr '|Literal|)
	(setf |bound| expr)
	(setf |asserts| expr)))))

;185 bound_spec = '[' bound_1 ':' bound_2 ']' .
(defparse2-p1114 :bound_spec ()
  (let (lbound ubound)
    (assert-token #\[ stream)
    (setf lbound (parse :bound_1))
    (assert-token #\: stream)
    (setf ubound (parse :bound_2))
    (assert-token #\] stream)
    (list lbound ubound)))

;186 built_in_constant = CONST_E | PI | SELF | '?' .
(defparse2-p1114 :built_in_constant ()
  (case (peek-token stream)
	(self (let ((id (name2scoped-id (string (read-token stream)))))
		(unless id (error 'utils-parse-error :text "Cannot find object referenced by 'SELF'."))
		(if (or (entity-p (%local-name id))
			      (type-p (%local-name id)))
		       (make-instance '|SELFRef| :data-type *scope*)
		       (error 'utils-parse-error :text
			      (format nil "Name '~A' refers to neither an entity nor type in scope ~A."
				      (%local-name id) *scope*)))))
	((const_e pi #\?)
	 (let ((tkn (read-token stream)))
	   (make-instance '|Literal| :refers-to (string tkn))))
	(otherwise
	 (error 'parse-invalid-bi-constant
	       :definition "a built-in constant"
	       :token (read-token stream)))))

; pod mm: "Identity" "NOT" "Negate" "StringLength" ?
; 187 built_in_function = ABS | ACOS | ASIN | ATAN | BLENGTH | COS | EXISTS | EXP |
; FORMAT | HIBOUND | HIINDEX | LENGTH | LOBOUND | LOINDEX |
; LOG | LOG2 | LOG10 | NVL | ODD | ROLESOF | SIN | SIZEOF |
; SQRT | TAN | TYPEOF | USEDIN | VALUE | VALUE_IN |
; VALUE_UNIQUE .
;; 'print' is an EE extension
(defparse2-p1114 :built_in_function ()
  (cond ((member (peek-token stream) '(abs acos asin atan cos exists
				       exp format hibound hiindex lobound loindex log
				       log2 log10 nvl odd rolesof sin sizeof sqrt tan
				       typeof usedin value value_in value_unique))
	 (make-instance '|UnaryOperator| 
			:id (make-scoped-id (string (read-token stream))
					    :scope (schema-scope *scope*))))
	 ((eql (peek-token stream) 'blength)
	  (read-token stream)
	  (make-instance '|UnaryOperator| :id (make-scoped-id "BinaryLength"
							      :scope (schema-scope *scope*))))
	 ((eql (peek-token stream) 'length)
	  (read-token stream)
	  (make-instance '|UnaryOperator| :id (make-scoped-id "StringLength"
							      :scope (schema-scope *scope*))))
	 (t (error 'parse-invalid-bi-function :definition "a built-in function"
		   :token (read-token stream)))))

;188 built_in_procedure = INSERT | REMOVE .
(defparse2-p1114 :built_in_procedure ()
  (if (member (peek-token stream) '(insert remove))
	 (read-token stream)
	 (error 'parse-invalid-bi-procedure
		:definition "a built-in procedure"
		:token (read-token stream))))

;189 case_action = case_label { ',' case_label } ':' stmt .
(defparse2-p1114 :case_action ()
  (with-instance (|CaseAction|)
    (setf |label-value|
	  (cons (parse :case_label)
		(loop while (check-token #\, stream) 
		      do (read-token stream)
		      collect (parse :case_label))))
    (assert-token #\: stream)
    (setf |action| (parse :stmt))))

;190 case_label = expression .
(defparse2-p1114 :case_label ()
  (parse :expression))

;191 case_stmt = CASE selector OF { case_action } [ OTHERWISE ':' stmt ] END_CASE ';' .
(defparse2-p1114 :case_stmt ()
  (assert-token 'case stream)
  (with-instance (|CaseStatement|)
    (setf |selection-expression| (parse :selector))
    (assert-token 'of stream)
    ;; POD this is the xmi-hidden slot, will need post-processing.
    (setf |cases| 
	  (loop until (check-token 'end_case stream)
		if (check-token 'otherwise stream)
		do (read-token stream) (assert-token #\: stream) 
		and collect (mk-instance '|CaseAction| :label-value '(:true) 
					 :is-default t :action (parse :stmt))
		else collect (parse :case_action)))
    ; pod8mex POD needed? The slot should be ordered.
    ; pod8mex (loop for ca in |conditional-actions| for pos from 0 do (setf (%position ca) pos))
    (assert-token 'end_case stream)
    (assert-token #\; stream)))


;192 compound_stmt = BEGIN stmt { stmt } END ';' .
(defparse2-p1114 :compound_stmt ()
  (with-instance (|StatementBlock|)
    (assert-token 'begin stream)
    (setf |body-statements|
	  (cons (parse :stmt)
		(loop until (check-token 'end stream)
		      collect (parse :stmt))))
    (read-token stream)
    (assert-token #\; stream)))

; 193 concrete_types = aggregation_types | simple_types | type_ref .
(defparse2-p11 :concrete_types ()
  (let ((tkn (peek-token stream)))
    (cond ((member tkn '(array bag list set))
	   (parse :aggregation_types))
	  ((member tkn '(binary boolean integer logical number real string))
	   (parse :simple_types))
	  (t (parse :type_ref)))))

;194 constant_body = constant_id ':' instantiable_type ':=' expression ';' .
(defparse2-p11 :constant_body ()
  (with-instance (|Constant|)
    (setf |id| (parse :constant_id))
    (assert-token #\: stream)
    (setf |data-type| (parse :instantiable_type))
    (assert-token :colon-equal stream)
    (setf |value-expression| (parse :expression))
    (assert-token #\; stream)))

;195 constant_decl = CONSTANT constant_body { constant_body } END_CONSTANT ';' .
(defparse2-p1114 :constant_decl ()
  (assert-token 'constant stream)
  (prog1 
      (loop until (check-token 'end_constant stream)
	    collect (parse :constant_body))
    (read-token stream)
    (assert-token #\; stream)))

;196 constant_factor = built_in_constant | constant_ref .
(defparse2-p1114 :constant_factor ()
  (case (peek-token stream)
    ((const_e pi self #\?) (parse :built_in_constant))
    (t (parse :constant_ref))))

;197 constant_id = simple_id .
(defparse2-p1114 :constant_id ()
  (make-scoped-id (read-token stream)))

;198 constructed_types = enumeration_type | select_type .
(defparse2-p11 :constructed_types ()
  (let ((tkn (if (eql (peek-token stream) 'extensible) 
		    (peek-token stream 2) 
		    (peek-token stream))))
    (ecase tkn
      (enumeration (parse :enumeration_type))
      ((generic_entity select) (parse :select_type)))))

;199 declaration = entity_decl | function_decl | procedure_decl | subtype_constraint_decl | type_decl .
(defparse2-p11 :declaration ()
  (case (peek-token stream)
    (entity    (parse :entity_decl))
    (function  (parse :function_decl))
    (procedure (parse :procedure_decl))
    (subtype_constraint (parse :subtype_constraint_decl))
    (type      (parse :type_decl))
    (t (error 'parse-invalid-decl
	      :definition *def*
	      :token (read-token stream)))))

#| POD 2007-10-02, AP203, why you can't jump to parent scope for parsing :parameter_type:
   control_points       : ARRAY [0:upper_index_on_control_points]
                                                         OF cartesian_point 
                                  := list_to_array(control_points_list,0,
                                             upper_index_on_control_points);
|#
;200 derived_attr = attribute_decl ':' parameter_type ':=' expression ';' .
(defparse2-p11 :derived_attr (entity-obj)
  (let* ((attr/redecl (parse :attribute_decl)) ; ScopedID or Redeclaration.
	 (ptype (progn (assert-token #\: stream) 
		       (let (#|(*scope* (%%parent *scope*))|#) (parse :parameter_type))))
	 (exp   (progn (assert-token :colon-equal stream) (parse :expression)))
	 (result nil))
    (assert-token #\; stream)
    (if (typep attr/redecl '|ScopedId|) ; it's an Attribute
	(setf result (with-instance (|DerivedAttribute|)
				    (setf |id| attr/redecl)
				    (setf |attribute-type| ptype)
				    (setf |derivation| exp)))
      (progn ; it's a Redeclaration
	(setf result attr/redecl)
	(setf (%derivation result) exp)
	(setf (%scope result) entity-obj)
	(setf (%restricted-type result) ptype)))
    result))

;201 derive_clause = DERIVE derived_attr { derived_attr } .
(defparse2-p11 :derive_clause (entity-obj)
  (assert-token 'derive stream)
  (cons (parse :derived_attr :entity-obj entity-obj)
	(loop until (member (peek-token stream) '(inverse unique where end_entity)) 
	      collect (parse :derived_attr :entity-obj entity-obj))))

;202 domain_rule = [ rule_label_id ':' ] expression .
(defparse2-p1114 :domain_rule (global-rule)
  (if global-rule
    ;; |NamedRule| is thing in RULE decl. Scope of label is |GlobalRule|.
    (with-instance (|NamedRule|) 
      (when (eql #\: (peek-token stream 2))
	(setf |id| (make-scoped-id (read-token stream)))
	(read-token stream))
      (setf |asserts-expression| (parse :expression)))
    ;; |DomainRule| is thing in ENTITY and TYPE decl. Scope of label is |NamedType|.
   (with-instance (|DomainRule|) 
     (when (eql #\: (peek-token stream 2))
       (setf |id| (make-scoped-id (read-token stream)))
       (read-token stream))
     (setf |asserts| (parse :expression)))))
    
;203 element = expression [ ':' repetition ] .
(defparse2-p1114 :element ()
  (with-instance (|MemberBinding|)
     (setf |member-value| (parse :expression))
    (when (check-token #\: stream)
      (read-token stream)
      (setf |repetition| (parse :repetition)))))

;204 entity_body = { explicit_attr } [ derive_clause ] [ inverse_clause ] [ unique_clause ]
;    [ where_clause ] .
(defparse2-p11 :entity_body ()
  (let (eattrs attrs redecls derive dattrs derive-redecls inverse set)
    (setf eattrs
	  (loop until (member (peek-token stream) '(derive inverse unique where end_entity))
		append (parse :explicit_attr)))
    (setf attrs   (remove-if-not  #'(lambda (x) (typep x '|ExplicitAttribute|)) eattrs))
    (setf redecls (remove-if-not  #'(lambda (x) (typep x '|Redeclaration|)) eattrs))
  (when (check-token 'derive stream)
    (setf derive (parse :derive_clause :entity-obj *def*)))
  (setf derive-redecls (remove-if-not  #'(lambda (x) (typep x '|Redeclaration|)) derive))
  (setf dattrs (remove-if-not  #'(lambda (x) (typep x '|DerivedAttribute|)) derive))
  (when (check-token 'inverse stream)
    (setf inverse (parse :inverse_clause :entity-obj *def*)))
  (setf (%declares *def*)
	(setf set (make-instance '|SingleEntityType| 
				 :id (%id *def*) :declared-in *def*
				 :declares (append attrs dattrs inverse))))
  (setf (%redeclarations *def*) (append redecls derive-redecls))
  (loop for attr in (append attrs dattrs inverse redecls derive-redecls)
	for i from 0
	do (setf (%position attr) i)
	unless (typep attr '|Redeclaration|) do (setf (%of-entity attr) set))
  (when (check-token 'unique stream)
    (setf (%unique-rules *def*) (parse :unique_clause))
    (loop for u in (%unique-rules *def*) for i from 0 do 
	  (setf (%position u) i)))  ; POD needs %domain like WHERE has (note to Edbark).
  (when (check-token 'where stream)
    (setf (%domain-rules *def*) (parse :where_clause)) ;; pod 2006-04-18  was value-constraints, 2006-04-18 constraints
    (loop for w in (%constraints *def*) for i from 0 do ;; is this overwriting subsuper constraints
	  (setf (%domain w) *def*)
	  (setf (%position w) i)))))

;205 entity_constructor = entity_ref '(' [ expression { ',' expression } ] ')' .
(defparse2-p1114 :entity_constructor ()
  (with-instance (|PartialEntityConstructor|)
  (let (set)
    (setf |attribute-group| 
	  (setf set (make-instance '|SingleEntityType| :id (parse :entity_ref))))
    (assert-token #\( stream)
    (setf |bindings| 
	  (loop until (check-token #\) stream) 
		for pos from 0 collect
		(with-instance (|AttributeBinding|)
			       (setf |position| pos)
			       (setf |to-value| (make-instance '|SingleEntityValue| :of-type set))
			       (setf |attribute-value| (parse :expression)))
		when (check-token #\, stream) do (read-token stream)))
    (assert-token #\) stream))))

;206 entity_decl = entity_head entity_body END_ENTITY ';' .
(defparse2-p11 :entity_decl ()
  (let* ((*scope* *scope*) ; will be set in :entity_head
	 (*def* (parse :entity_head))) ; sets |id|, |subtype|, |supertype| and |constraints|
    (parse :entity_body) ; sets |declares| |unique-rules| |constraints|
    (assert-token 'end_entity stream)
    (assert-token #\; stream)
    *def*))

;207 entity_head = ENTITY entity_id subsuper ';' .
(defparse2-p11 :entity_head ()
  (assert-token 'entity stream)
  (let ((id (parse :entity_id)))
    (setf *scope* (find-child-scope :name (%local-name id)))
    (let ((*def* *scope*))
      (setf (%id *def*) id)
      (make-scoped-id-alias "SELF" id)
      (expo:expo-dot *expresso* :stream stream :char "E" :pass 2)
      (dbg-message :parser 1 "~&Entity ~A~%" (%local-name (%id *def*)))
      (let ((*scope* (%%parent *scope*))) 
	(parse :subsuper)) ; IDs referenced are not scoped to this entity.
      (assert-token #\; stream)
      *def*)))

;208 entity_id = simple_id .
(defparse2-p11 :entity_id () 
  (make-scoped-id (read-token stream)))

;209 enumeration_extension = BASED_ON type_ref [ WITH enumeration_items ] .
(defparse2-p11 :enumeration_extension () 
  (assert-token 'based_on stream)
  (setf (%base *def*) (parse :type_ref))
  (when (check-token 'with stream)
    (read-token stream)
    (setf (%extension *def*) (parse :enumeration_items))))

;210 enumeration_id = simple_id .
(defparse2-p11 :enumeration_id ()
  (make-scoped-id (read-token stream)))

;211 enumeration_items = '(' enumeration_id { ',' enumeration_id } ')' .
(defparse2-p11 :enumeration_items ()
  (assert-token #\( stream)
  (loop for i from 0
	for item = (with-instance (|EnumerationItem|) (setf |position| i))
	until (check-token #\) stream) do
	(setf (%id item) (parse :enumeration_id))
	collect item
	when (check-token #\, stream) do (read-token stream)
	finally (read-token stream)))


;212 enumeration_reference = [ type_ref '.' ] enumeration_ref .
(defparse2-p1114 :enumeration_reference ()
  (let (type-ref enum-ref)
    (cond ((eql #\. (peek-token stream 2))
	   (setf type-ref (parse :type_ref))
	   (read-token stream)
	   (setf enum-ref (parse :enumeration_ref)))
	  (t
	   (setf enum-ref (parse :enumeration_ref))))
    (with-instance (|EnumItemRef|)
       (setf |id| enum-ref)
       (setf |data-type| type-ref))))

;213 enumeration_type = [ EXTENSIBLE ] ENUMERATION [ ( OF enumeration_items ) | enumeration_extension ] .
(defparse2-p11 :enumeration_type ()
  (with-instance (|EnumerationType|)
    (when (check-token 'extensible stream)
      (setf |isExtensible| :true)
      (read-token stream))
    (assert-token 'enumeration stream)
    (cond ((check-token 'of stream)
	   (read-token stream)
	   (setf |values| (parse :enumeration_items)))
	  (t (setf |extension| (parse :enumeration_extension))))))

;214 escape_stmt = ESCAPE ';' .
(defparse2-p1114 :escape_stmt ()
  (assert-token 'escape stream)
  (assert-token #\; stream)
  (values))

;215 explicit_attr = attribute_decl { ',' attribute_decl } ':' [ OPTIONAL ] parameter_type ';' .
(defparse2-p11 :explicit_attr ()
  (let (attr/redecl attr redecl opt-p type)
    (push (parse :attribute_decl) attr/redecl) 
    (loop while (check-token #\, stream)
	  do (read-token stream) (push (parse :attribute_decl) attr/redecl))
    (assert-token #\: stream)
    (when (check-token 'optional stream)
      (read-token stream)
      (setf opt-p t))
    (let ((*scope* (%%parent *scope*))) ;; example: unit : Unit; don't want it to see the attribute ID.
      (setf type (parse :parameter_type)))
    (assert-token #\; stream)
    (setf attr   (remove-if #'(lambda (x) (typep x '|Redeclaration|)) attr/redecl))
    (setf redecl (remove-if-not #'(lambda (x) (typep x '|Redeclaration|)) attr/redecl))
    (loop for r in redecl do
	  (setf (%scope r) *def*) ; *def* is an EntityType
	  (setf (%restricted-type r) type))
    (append
     redecl
     (loop for attr in (reverse attr)
	   with old-def = *def*
	   collect 
	   (with-instance (|ExplicitAttribute|)
			  (setf |id| attr)
			  (setf |isOptional| (if opt-p :true :false))
			  (setf |of-entity| old-def)
			  (setf |attribute-type| type))))))

;216 expression = simple_expression [ rel_op_extended simple_expression ] .
(defparse2-p1114 :expression () 
  (let (left-operand)
    (setf left-operand (parse :simple_expression))
    (if (not (member (peek-token stream) '(#\< #\> :less-equal :great-equal :less-great #\=
						 :colon-less-great-colon :colon-equal-colon in like)))
	   left-operand
	   (mk-instance '|BinaryOperation| 
			  :left-operand left-operand
			  :operator (parse :rel_op_extended)
			  :right-operand (parse :simple_expression)))))

;217 factor = simple_factor [ '**' simple_factor ] .
(defparse2-p1114 :factor ()
  (let ((sf1 (parse :simple_factor)))
    (if (not (check-token :star-star stream))
	   sf1
	   (with-instance (|BinaryOperation|)
	     (setf |operator| (make-instance 'unresolved-operator :enum-symbol "**")) ; -- this one
	     (setf |left-operand| sf1)
	     (setf |right-operand| (progn (read-token stream) 
					  (parse :simple_factor)))))))

;218 formal_parameter = parameter_id { ',' parameter_id } ':' parameter_type .
(defparse2-p1114 :formal_parameter ()
  (let (ids type)
    (setf ids (cons (parse :parameter_id)
		    (loop while (check-token #\, stream) 
			  do (read-token stream)
			  collect (parse :parameter_id)))) ; POD 2009-06-24 added collect
    (assert-token #\: stream)
    (setf type (parse :parameter_type :general-p t))
    (loop for p in ids do (setf (%formal-parameter-type p) type))
    ids))

;219 function_call = ( built_in_function | function_ref ) [ actual_parameter_list ] .
(defparse2-p1114 :function_call ()
  (with-instance (|FunctionCall|)
    (setf |invokes-function|
	  (case (peek-token stream)
		   ((abs acos asin atan blength cos exists exp format hibound
			 hiindex length lobound loindex log log2 log10 nvl odd rolesof
			 sin sizeof sqrt tan typeof usedin value value_in value_unique
			 ;; EE extension
			 print)
		    (parse :built_in_function))
		   (t (parse :function_ref))))
    (when (check-token #\( stream)
      (setf |actual-parameters| (parse :actual_parameter_list)))))

;220 function_decl = function_head  algorithm_head  stmt { stmt } END_FUNCTION ';' .
(defparse2-p1114 :function_decl ()
    (let ((*scope* *scope*))   ; because we will setf it in function_head.
      (dbind (*def* function-id params result) (parse :function_head)
	  (setf (%id *def*) function-id)
	  (setf (%formal-parameters *def*) params)
	  (setf (%result *def*) result)
	  (dbind (decls constants locals) (parse :algorithm_head) ; PODTT new.
	    (declare (ignore decls constants))
	    (setf (%variables *def*) locals))
	  (setf (%body *def*)
		(loop until (check-token 'end_function stream)
		      collect (parse :stmt)))
	  (read-token stream)
	  (assert-token #\; stream)
	  *def*)))

;221 function_head = FUNCTION function_id [ '(' formal_parameter { ';' formal_parameter } ')' ]
;    ':' parameter_type ';' .
(defparse2-p1114 :function_head ()
  (let (function-id params result)
    (assert-token 'function stream)
    (setf function-id (parse :function_id))
    (setf *scope* (find-child-scope :name (%local-name function-id))) ; Function (a Scope) made in first pass.
    (expo:expo-dot *expresso* :stream stream :char "F" :pass 2)
    (dbg-message :parser 1 "~&Function ~A~%" function-id)
    (when (check-token #\( stream)
      (read-token stream)
      (setf params 
	    (flatten
	     (cons (parse :formal_parameter)
		   (loop while (check-token #\; stream)
			do (read-token stream)
			collect (parse :formal_parameter)))))
      (loop for p in params for i from 0 do (setf (%position p) i))
      (assert-token #\) stream))
    (assert-token #\: stream)
    (let ((r (parse :parameter_type :general-p t)))
      (setf result (with-instance (|FunctionResult|) (setf |variable-type| r))))
    (assert-token #\; stream)
    (list *scope* function-id params result)))

;222 function_id = simple_id .
(defparse2-p1114 :function_id ()
  (make-scoped-id (read-token stream)))

;223 generalized_types = aggregate_type | general_aggregation_types | generic_type .
(defparse2-p1114 :generalized_types ()
  (ecase (peek-token stream)
    (aggregate (parse :aggregate_type))
    ((array bag list set) (parse :general_aggregation_types))
    (generic (parse :generic_type))
    (generic_entity (parse :generic_entity_type))))

;224 general_aggregation_types = general_array_type | general_bag_type | general_list_type
;    | general_set_type .
(defparse2-p1114 :general_aggregation_types ()
  (ecase (peek-token stream)
    (array (parse :general_array_type))
    (bag   (parse :general_bag_type))
    (list  (parse :general_list_type))
    (set   (parse :general_set_type))))

;225 general_array_type = ARRAY [ bound_spec ] OF [ OPTIONAL ] [ UNIQUE ] parameter_type .
(defparse2-p1114 :general_array_type ()
  (with-instance (|GeneralARRAYType|)
    (assert-token 'array stream)
    (setf |ordering| "indexed")
    (when (check-token #\[ stream)
      (dbind (l-bound u-bound) (parse :bound_spec)
	 (setf |lower-bound| l-bound)
	 (setf |upper-bound| u-bound)))
    (assert-token 'of stream)
    (setf |isOptional| :false)
    (when (check-token 'optional stream)
      (read-token stream)
      (setf |isOptional| :true))
    (setf |isUnique| :false)
    (when (check-token 'unique stream)
      (read-token stream)
      (setf |isUnique| :true))
    (setf |member-type| (parse :parameter_type :general-p t))))

;226 general_bag_type = BAG [ bound_spec ] OF parameter_type .
(defparse2-p1114 :general_bag_type ()
  (with-instance (|GeneralBAGType|)
    (assert-token 'bag stream)
    (setf |ordering| "unordered")
    (when (check-token #\[ stream)
      (dbind (l-bound u-bound) (parse :bound_spec)
	 (setf |lower-bound| l-bound)
	 (setf |upper-bound| u-bound)))
    (assert-token 'of stream)
    (setf |member-type| (parse :parameter_type :general-p t))))


;227 general_list_type = LIST [ bound_spec ] OF [ UNIQUE ] parameter_type .
(defparse2-p1114 :general_list_type ()
  (with-instance (|GeneralLISTType|)
    (assert-token 'list stream)
    (setf |ordering| "ordered")
    (when (check-token #\[ stream)
      (dbind (l-bound u-bound) (parse :bound_spec)
	 (setf |lower-bound| l-bound)
	 (setf |upper-bound| u-bound)))
    (assert-token 'of stream)
    (setf |isUnique| :false)
    (when (check-token 'unique stream)
      (read-token stream)
      (setf |isUnique| :true))
    (setf |member-type| (parse :parameter_type :general-p t))))

;;; POD Clean this up!
#+iface-http
;pod7(defun p14p::target-parameter-p (arg)
;pod7  (declare (ignore arg)) nil)

;228 general_ref = parameter_ref | variable_ref .
(defparse2-p1114 :general_ref ()
  (let ((tkn (string-upcase (peek-token stream)))) ; PODsampson string-upcase
    (cond ((or (variable-p tkn) 
	       #|pod7(p14p::target-parameter-p tkn)|#)
	   (parse :variable_ref))
	  ((parameter-p tkn)
	   (parse :parameter_ref))
	  (t (error 'utils-parse-error 
		    :text  (format nil "Failed to find identifier '~A' in scope ~A." tkn *scope*))))))

;229 general_set_type = SET [ bound_spec ] OF parameter_type .
(defparse2-p1114 :general_set_type ()
  (with-instance (|GeneralSETType|)
    (assert-token 'set stream)
    (setf |ordering| "unordered")
    (when (check-token #\[ stream)
	(dbind (lbound ubound) (parse :bound_spec)
	 (setf |lower-bound| lbound)
	 (setf |upper-bound| ubound)))
    (assert-token 'of stream)
    (setf |member-type| (parse :parameter_type :general-p t))))

; pod NYI
; 230 generic_entity_type = GENERIC_ENTITY [ ':' type_label ] .
(defparse2-p11 :generic_entity_type ()
  (assert-token 'generic_entity stream)
  (when (check-token #\: stream)
    (read-token stream)
    (parse :type_label)))

; pod NYI
;231 generic_type = GENERIC [ ':' type_label ] .
(defparse2-p1114 :generic_type ()
  (assert-token 'generic stream)
  (when (check-token #\: stream)
    (read-token stream)
    (parse :type_label))
  (make-instance '|GenericType|))
       ;PODTT	 :id (make-scoped-id "generic")


;232 group_qualifier = '\' entity_ref .
(defparse2-p1114 :group_qualifier ()
  (assert-token #\\ stream)
  (parse :entity_ref))

;233 if_stmt = IF logical_expression THEN stmt { stmt } [ ELSE stmt { stmt } ] END_IF ';' .
(defparse2-p1114 :if_stmt ()
  (with-instance (|IfStatement|)
    (assert-token 'if stream)
    (setf |if-condition| (parse :logical_expression))
    (assert-token 'then stream)
    (setf |then-actions|
	  (cons (parse :stmt)
		(loop until (member (peek-token stream) '(else end_if))
		      collect (parse :stmt))))
    (when (check-token 'else stream)
      (read-token stream)
      (setf |else-actions|
	    (cons (parse :stmt)
		  (loop until (check-token 'end_if stream)
			collect (parse :stmt)))))
    (assert-token 'end_if stream)
    (assert-token #\; stream)))

;234 increment = numeric_expression .
(defparse2-p1114 :increment ()
  (parse :numeric_expression))

;235 increment_control = variable_id ':=' bound_1 TO bound_2 [ BY increment ] .
(defparse2-p1114 :increment_control ()
  (with-instance (|RepeatIncrementControl|)
    (setf |variable| (parse :variable_id))
    (setf (%variable-type |variable|) 
	  (integer-type-memo))
	  ;(make-instance '|Integer|)) ; PODTT was commented out
	  ; PODTT (make-instance 'integer-typ)) 
    (assert-token :colon-equal stream)
    (setf |lbound| (parse :bound_1))
    (assert-token 'to stream)
    (setf |ubound| (parse :bound_2))
    (when (check-token 'by stream)
      (read-token stream)
      (setf |increment| (parse :increment)))))

;236 index = numeric_expression .
(defparse2-p1114 :index ()
  (parse :numeric_expression))

;237 index_1 = index .
(defparse2-p1114 :index_1 ()
  (parse :index))

;238 index_2 = index .
(defparse2-p1114 :index_2 ()
  (parse :index))

;239 index_qualifier = '[' index_1 [ ':' index_2 ] ']' .
(defparse2-p1114 :index_qualifier ()
  (let (ix1 ix2)
    (assert-token #\[ stream)
    (setf ix1 (parse :index_1))
    (when (check-token #\: stream)
      (read-token stream)
      (setf ix2 (parse :index_2)))
    (assert-token #\] stream)
    (if ix2
	(list ix1 ix2)
      (list ix1))))

; pod e2 change -- without looking into id bookeeping and scoping, 
; you can't tell here whether what is returned is an entity_ref or type_ref, since:
; concrete_types = aggregation_types | simple_types | type_ref . 
; aggregation_types = array_type | bag_type | list_type | set_type .

; 240 instantiable_type = concrete_types | entity_ref .
(defparse2-p11 :instantiable_type ()
  (let ((tkn (peek-token stream)))
    (cond ((member tkn '(array bag list set binary boolean integer logical number real string))
	   (parse :concrete_types))
	  (t (parse :entity_ref)))))

(defmemo integer-type-memo () (make-instance '|IntegerType|))
;  (with-instance (|Integer|)
;    (setf |id| :INTEGER))) ; pod part of issue with SimpleType ...2006-04-22 instance of xml id?

;241 integer_type = INTEGER .
(defparse2-p1114 :integer_type ()
  (assert-token 'integer stream)
  (integer-type-memo))

;242 interface_specification = reference_clause | use_clause .
(defparse2-p11 :interface_specification ()
  (ecase (peek-token stream)
    (reference (parse :reference_clause))
    (use       (parse :use_clause))))

;243 interval = '{' interval_low interval_op interval_item interval_op interval_high '}' .
(defparse2-p1114 :interval ()
  (let (item)
    (assert-token #\{ stream)
    (with-instance (|BinaryOperation|)
       (setf |operator| (make-instance 'unresolved-operator :enum-symbol "and")) ; -- this one 
       (setf |left-operand|
         (with-instance (|BinaryOperation|)
	    (setf |left-operand| (parse :interval_low))
	    (setf |operator| (parse :interval_op))
	    (setf |right-operand| (setf item (parse :interval_item)))))
       (setf |right-operand|
	 (with-instance (|BinaryOperation|)
	    (setf |left-operand| item) 
	    (setf |operator| (parse :interval_op))
	    (setf |right-operand| (parse :interval_high))))
       (assert-token #\} stream))))

;244 interval_high = simple_expression .
(defparse2-p1114 :interval_high ()
  (parse :simple_expression))

;245 interval_item = simple_expression .
(defparse2-p1114 :interval_item ()
  (parse :simple_expression))

;246 interval_low = simple_expression .
(defparse2-p1114 :interval_low ()
  (parse :simple_expression))

;247 interval_op = '<' | '<=' .
(defparse2-p1114 :interval_op ()
  (ecase (read-token stream)
    (#\<         (make-instance 'unresolved-operator :enum-symbol "<"))
    (:less-equal (make-instance 'unresolved-operator :enum-symbol "<="))))

;248 inverse_attr = attribute_decl ':' [ ( SET | BAG ) [ bound_spec ] OF ] entity_ref FOR attribute_ref ';' .
(defparse2-p11 :inverse_attr (entity-obj)
  (with-instance (|InverseAttribute|)
    (setf |id| (parse :attribute_decl))
    (setf |of-entity| entity-obj)
    (assert-token #\: stream)
    (let ((*scope* (%%parent *scope*))) ; the entity referenced is not in the current scope ????
      (setf |attribute-type|
	    (if (member (peek-token stream) '(set bag))
		   (parse :aggregation_types)
		   (parse :entity_ref))))
    (let (attr)
      (assert-token 'for stream)
      (setf attr (make-scoped-id (read-token stream) :scope (schema-scope *scope*)))
      (assert-token #\; stream)
      (setf |explicit| 
	    (make-instance 'unresolved-inverse
			   :where-found (if (typep |attribute-type| '|EntityType|)
					    |attribute-type|
					    (%member-type |attribute-type|))
			   :attribute-name attr)))))
;      (setf *zippy* *def*)
;      (VARS |id|) (break "here"))))

;249 inverse_clause = INVERSE inverse_attr { inverse_attr } .
(defparse2-p11 :inverse_clause (entity-obj)
  (assert-token 'inverse stream)
  (cons (parse :inverse_attr :entity-obj entity-obj)
	(loop until (member (peek-token stream) '(unique where end_entity))
	      collect (parse :inverse_attr :entity-obj entity-obj))))

;250 list_type = LIST [ bound_spec ] OF [ UNIQUE ] instantiable_type .
(defparse2-p1114 :list_type ()
  (with-instance (|LISTType|)
    (assert-token 'list stream)
    (setf |ordering| "ordered")
    (when (check-token #\[ stream)
	(dbind (lbound ubound) (parse :bound_spec)
	 (setf |lower-bound| lbound)
	 (setf |upper-bound| ubound)))
    (assert-token 'of stream)
    (setf |isUnique| :false) 
    (when (check-token 'unique stream)
      (setf |isUnique| :true) ; POD make-instance '|Boolean| ???
      (read-token stream))
    (setf |member-type| (parse :instantiable_type))))

#| 2009-05-20 PODsampson don't these need to capture the value?
(defmemo simple-value-memo (type)
  (case type
    (:logical (make-instance '|LogicalValue|)) ; :of-type (make-instance '|LogicType|)
    (:real (make-instance '|RealValue|))
    (:integer (make-instance '|IntegerValue|))
    (:string (make-instance '|StringValue|))))

(defmemo literal-memo (val)
  (make-instance '|Literal| 
		 ;PODTT :id val 
		 :refers-to 
		 (cond ((member val '(true false unknown)) (simple-value-memo :logical))
		       ((integerp val) (simple-value-memo :integer))
		       ((realp val) (simple-value-memo :real))
		       ((string-const-p val) (simple-value-memo :string))))) ;PODTT ?

;251 literal = binary_literal | integer_literal | logical_literal | real_literal | string_literal .
(defparse2-p1114 :literal ()
  (literal-memo (read-token stream)))
|#

(defparse2-p1114 :literal ()
  (let ((tkn (read-token stream)))
    (cond ((member tkn '(true false unknown)) (make-instance '|LogicalValue| :name tkn))
	  ((integerp tkn) (make-instance '|IntegerValue| :name tkn))
	  ((realp tkn) (make-instance '|RealValue| :name tkn))
	  ((string-const-p tkn) (make-instance '|StringValue| :name (string-const--value tkn)))
	  (t (error 'parse-token-error :expected "a literal" :actual tkn)))))

;252 local_decl = LOCAL local_variable { local_variable } END_LOCAL ';' .
(defparse2-p1114 :local_decl ()
  (assert-token 'local stream)
  (let (lvars)
    (setf lvars
	  (append (parse :local_variable)
		  (loop until (check-token 'end_local stream) 
			append (parse :local_variable))))
    (read-token stream)
    (assert-token #\; stream)
    lvars))

;253 local_variable = variable_id { ',' variable_id } ':' parameter_type [ ':=' expression ] ';' .
(defparse2-p1114 :local_variable ()
  (let ((vars
	 (cons 
	  (make-instance '|LocalVariable| :id (make-scoped-id (read-token stream)))
	  (loop while (check-token #\, stream)
		do (read-token stream) 
		collect (make-instance '|LocalVariable| :id (make-scoped-id (read-token stream)))))))
    (assert-token #\: stream)
    (loop for v in vars with type = (parse :parameter_type :local-p t)
	  do (setf (%variable-type v) type))
    (when (check-token :colon-equal stream)
      (read-token stream)
      (loop for v in vars with expr = (parse :expression)
	    do (setf (%initial-value v) expr)))
    (assert-token #\; stream)
    vars))

;254 logical_expression = expression .
(defparse2-p1114 :logical_expression ()
  (parse :expression))

;255 logical_literal = FALSE | TRUE | UNKNOWN .
(defparse2-p1114 :logical_literal ()
  (ecase (read-token stream) (false "FALSE") (true  "TRUE") (unknown "UNKNOWN"))
  (with-instance (|LogicalValue|)
		 (setf |of-type| (make-instance '|LogicType| :id :LOGICAL))))

(defmemo logical-type-memo ()
  (with-instance (|LogicType|)
    (setf |id| :LOGICAL)))

;256 logical_type = LOGICAL .
(defparse2-p1114 :logical_type ()
  (assert-token 'logical stream)
  (logical-type-memo))
  
;257 multiplication_like_op = '*' | '/' | DIV | MOD | AND | '||' .
(defparse2-p1114 :multiplication_like_op ()
  (ecase (read-token stream)
    (#\*	(make-instance 'unresolved-operator :enum-symbol "*"))
    (#\/	(make-instance 'unresolved-operator :enum-symbol "/"))
    (div	(make-instance 'unresolved-operator :enum-symbol "div"))
    (mod	(make-instance 'unresolved-operator :enum-symbol "mod"))        ; -- this one
    (and	(make-instance 'unresolved-operator :enum-symbol "and"))        ; -- this one
    (:vbar-vbar	(make-instance 'unresolved-operator :enum-symbol "||")))) ; -- this one

;258 named_types = entity_ref | type_ref .
(defparse2-p1114 :named_types () ; in p14 this is called by call-next-method.
  (let ((id (make-scoped-id (read-token stream))))
    (lookup-referenceable id)))

; Only used in schema interfacing, (USED FROM). Not implemented.
;259 named_type_or_rename = named_types [ AS ( entity_id | type_id ) ] .
(defparse2-p11 :named_type_or_rename ()
  (let (ntypes new-name)
    (setf ntypes (parse :named_types))
    (when (check-token 'as stream)
      (read-token stream)
      (setf new-name (read-token stream)))
    (list ntypes new-name)))

;260 null_stmt = ';' .
(defparse2-p1114 :null_stmt ()
  (assert-token #\; stream)
  (values))

(defmemo number-type-memo ()
  (with-instance (|NumericType|)
    (setf |id| :NUMBER)))

;261 number_type = NUMBER .
(defparse2-p1114 :number_type ()
  (assert-token 'number stream)
  (number-type-memo))

;262 numeric_expression = simple_expression .
(defparse2-p1114 :numeric_expression ()
  (parse :simple_expression))

;263 one_of = ONEOF '(' supertype_expression { ',' supertype_expression } ')' .
(defparse2-p1114 :one_of ()
  (format t "~% -------- one of ----------- peek is ~A" (peek-token stream))
  (with-instance (|ONEOFConstraint|)
    (assert-token 'oneof stream)
    (assert-token #\( stream)
    (setf |collection| 
	  (cons (parse :supertype_expression)
		(loop while (check-token #\, stream) do
		      (read-token stream)
		      collect (parse :supertype_expression))))
    (assert-token #\) stream)))

;264 parameter = expression .
(defparse2-p1114 :parameter ()
  (with-instance (|ActualParameter|)
    (setf |actual-value| (parse :expression))))

;265 parameter_id = simple_id .
(defparse2-p1114 :parameter_id () ; in p14, just used for functions.
  (with-instance (|Parameter|)
    (setf |id| (make-scoped-id (read-token stream)))
    (push *def* (%variables *scope*))))

;;; GeneralizedType can only be used as the data type of formal parameters, 
;;; and the data type of "abstract" attributes of ABSTRACT EntityType. 
;;; So here we need to go beyond the syntax to emit an InstantiableType 
;;; (a subtype of ParameterType) if not in one of these situations. 
;;; POD I'm still looking for a place where general-p = t !!! I'm guessing
;;; it would be any formal_parameter??? ...that doesn't specify size constraints??? 
;266 parameter_type = generalized_types | named_types | simple_types .
(defparse2-p1114 :parameter_type (general-p local-p)
  (let ((result
	 (case (peek-token stream)
	   ((aggregate generic generic_entity) (parse :generalized_types))
	   ((array bag list set)
	    (if (or general-p local-p)
		   (parse :generalized_types)
		   (parse :aggregation_types)))
	   ((binary boolean integer logical number real string) (parse :simple_types))
	   (t (parse :named_types)))))
    ;; It can return a type_label, which is a ScopedId, thus I comment out...
    ;;(when (typep result '|ScopedId|) 
    ;;  (error "(private) parameter_type returns ScopedId."))
    result))

;267 population = entity_ref .
(defparse2-p1114 :population ()
  (parse :entity_ref))

;268 precision_spec = numeric_expression .
(defparse2-p1114 :precision_spec ()
  (parse :numeric_expression))

;;; POD use of keywords is a vestige of parser2.lisp, probably not needed here.
(defun mm-qfactor-qifers (qfactor qualifiers)
  "Construct the MM form for a primary, or other things containing qualifiers."
  (when (typep qfactor 'unresolved-attribute-ref) ; POD This is a guess -- qfactor (first thing in) is scoped
    (when-bind (s (find-scope-upward *scope* ; to the surrounding entity/type if one exists.
				     #'(lambda (x) (or (typep x '|SingleEntityType|) ; pod just 
							  (typep x '|EntityType|)  ; one of these!
							  (typep x '|NamedType|)))))
      (when (null (%entity-instance qfactor))
	(setf (%entity-instance qfactor)
	      (make-instance '|SELFRef| :data-type s)))))
;  (setf *zippy* qfactor)
;  (VARS qfactor qualifiers)
;  (break "qfactor")
  (let ((primary qfactor))
    (loop while qualifiers 
	  for (qtype q) = (pop qualifiers) do 
;	  (VARS primary qtype q)
	  (case qtype ; for :group pop should be (:attr %attr-ref) ... er unresolved-attribute-ref
	    (:group  ;; q is a symbol, the 'partial' entity type name. `(,(cadr (pop qualifiers)) ,primary ',q)
	     (setf primary ; modification to primary, not new primary.
		   (mk-instance '|GroupRef| 
				  :refers-to q ; will have to be resolved (done).
				  :entity-instance primary)))
	    (:index 
	     (setf primary ;`(expo:express-aref ,primary ,@q), q is a list of indecies.
		   (mk-instance '|AggregateIndex|
				  :base-value primary
				  :index-value q)))
	    (:attr ; q is an unresolved-attribute-ref
	     (assert (typep q 'unresolved-attribute-ref))
	     (setf (%entity-instance q) primary) 
	     (setf primary q))))
    primary))

;269 primary = literal | ( qualifiable_factor { qualifier } ) .
(defparse2-p1114 :primary ()
  (let ((peek (peek-token stream)))
    (if (or (typep peek '(or number bit-vector))
	    (member (peek-token stream) '(true false unknown))
	    (string-const-p peek))
	(parse :literal)
	(let ((primary (parse :qualifiable_factor))
	      (qualifiers
	       (loop while (member (peek-token stream) '(#\. #\\ #\[))
		     collect (parse :qualifier))))
	  (mm-qfactor-qifers primary qualifiers)))))

;270 procedure_call_stmt = ( built_in_procedure | procedure_ref ) [ actual_parameter_list ] ';' .
(defparse2-p1114 :procedure_call_stmt ()
  (with-instance (|ProcedureCall|)
    (setf |invokes| 
	  (case (peek-token stream)
	    ((insert remove) (parse :built_in_procedure))
	    (t (parse :procedure_ref))))
    (setf |actual-parameters|
	  (when (check-token #\( stream)
	    (parse :actual_parameter_list)))))

;271 procedure_decl = procedure_head [ algorithm_head ] { stmt } END_PROCEDURE ';' .
; POD who cares, never saw one.
;272 procedure_head = PROCEDURE procedure_id [ '(' [ VAR ] formal_parameter { ';' [ VAR ]
;    formal_parameter } ')' ] ';' .
; POD who cares, never saw one.

;273 procedure_id = simple_id .
(defparse2-p1114 :procedure_id ()
  (make-scoped-id (read-token stream)))

;274 qualifiable_factor = attribute_ref | constant_factor | function_call | general_ref | population .
(defparse2-p11 :qualifiable_factor ()
  (let* ((tkn (string-upcase (peek-token stream))) ; PODsampson string-upcase
	 (ref 
	  (cond ((and (typep *scope* '|GlobalRule|) ; 2009-05-20 otherwise will choose :attribute_ref, if there is one.
		      (entity-p tkn)) (parse :population))
		((and (attribute-p tkn) ; 2006-04-28 I am trying to fix problem of small_3.exp
		      (not (variable-p tkn)))
		 (parse :attribute_ref))
		((constant-p tkn) (parse :constant_factor))
		((function-p tkn) (parse :function_call))
		((entity-p tkn)   (parse :population))
		;; handles parameters and variables
		(t (parse :general_ref)))))
    ref))

;275 qualified_attribute = SELF group_qualifier attribute_qualifier .
(defparse2-p11 :qualified_attribute () ; used in UNIQUE rule and :redeclared_attribute
  (assert-token 'self stream)
  (mk-instance 'unresolved-attribute
		 :where-found (parse :group_qualifier)
		 :attribute-name (%local-name (parse :attribute_qualifier))))

;276 qualifier = attribute_qualifier | group_qualifier | index_qualifier .
(defparse2-p11 :qualifier ()
  (ecase (peek-token stream)
    (#\. (list :attr (parse :attribute_qualifier)))
    (#\\ (list :group (parse :group_qualifier)))
    (#\[ (list :index (parse :index_qualifier)))))

;277 query_expression = QUERY '(' variable_id '<*' aggregate_source '|' logical_expression ')' .
(defparse2-p1114 :query_expression ()
  (assert-token 'query stream) 
  (assert-token #\( stream)
  (let ((tkn (read-token stream))) ; do it here to get token-pos correct.
    (with-instance (|QueryExpression| 
		    :find-contains 
		    (list '|QueryExpression| tkn (token-position tkn)))
      (let ((*scope* *def*))
	(setf |query-variable| (list (parse :variable_id :token tkn)))
	(assert-token :less-star stream)
	(let ((*scope* (%%parent *scope*)))
	  (setf |aggregate-operand| (parse :aggregate_source)))
	;; Then QUERY is in a GlobalRule, where the variable names a type. So I fix it.
	(when (typep |aggregate-operand| '|EntityType|)
	  (setf (%variable-type (car |query-variable|)) |aggregate-operand|)
	  (setf |aggregate-operand| (make-instance '|ExtentRef|
						   :id (%id |aggregate-operand|)
						   :refers-to |aggregate-operand|)))
	  
	(assert-token #\| stream)
	(setf |select-condition| (parse :logical_expression))
	(assert-token #\) stream)))))

(defmemo real-type-memo (precision)
  (if (eql precision :unspecified)
      (make-instance '|RealType| :id :NUMBER) ; pod part of issue with SimpleType
      (with-instance (|RealType|) (setf |precision| precision))))
		 
;278 real_type = REAL [ '(' precision_spec ')' ] .
(defparse2-p1114 :real_type ()
  (assert-token 'real stream)
  (if (check-token #\( stream)
    (let (precise)
      (read-token stream)
      (setf precise (parse :precision_spec))
      (assert-token #\) stream)
      (real-type-memo precise))
    (real-type-memo :unspecified)))

; note: attribute_decl = redeclared_attribute | attribute_id
;279 redeclared_attribute = qualified_attribute [ RENAMED attribute_id ] .
(defparse2-p11 :redeclared_attribute ()
  (with-instance (|Redeclaration|)
     (setf |original-attribute| (parse :qualified_attribute))
     (when (check-token 'renamed stream)
       (read-token stream)
       (setf |alias| (parse :attribute_id)))))

;280 referenced_attribute = attribute_ref | qualified_attribute .
(defparse2-p11 :referenced_attribute () 
  (case (peek-token stream)
	   (self (parse :qualified_attribute))
	   (t (parse :attribute_ref))))

;281 reference_clause = REFERENCE FROM schema_ref
;    [ '(' resource_or_rename { ',' resource_or_rename } ')' ] ';' .
(defparse2-p11 :reference_clause ()
  (let (schema resources)
    (assert-token 'reference stream)
    (assert-token 'from stream)
    (setf schema (parse :schema_ref))
    (when (check-token #\( stream)
      (read-token stream)
      (setf resources
	    (cons (parse :resource_or_rename)
		  (loop while (check-token #\, stream) do
			(read-token stream)
			collect (parse :resource_or_rename))))
      (assert-token #\) stream))
    (assert-token #\; stream)
    `(def-reference-from :schema ',schema :resources ',resources)))

;282 rel_op = '<' | '>' | '<=' | '>=' | '<>' | '=' | ':<>:' | ':=:' .
(defparse2-p1114 :rel_op ()
  (ecase (read-token stream)
    (#\<			(make-instance 'unresolved-operator :enum-symbol "<"))
    (#\>			(make-instance 'unresolved-operator :enum-symbol ">"))
    (:less-equal		(make-instance 'unresolved-operator :enum-symbol "<="))
    (:great-equal		(make-instance 'unresolved-operator :enum-symbol ">="))
    (:less-great		(make-instance 'unresolved-operator :enum-symbol "<>"))
    (#\=			(make-instance 'unresolved-operator :enum-symbol "="))
    (:colon-less-great-colon	(make-instance 'unresolved-operator :enum-symbol ":<>:")) ;entity or agg
    (:colon-equal-colon		(make-instance 'unresolved-operator :enum-symbol ":=:"))))

;283 rel_op_extended = rel_op | IN | LIKE .
(defparse2-p1114 :rel_op_extended ()
  (if (member (peek-token stream) '(#\< #\> :less-equal :great-equal :less-great
				       #\= :colon-less-great-colon :colon-equal-colon))
	 (parse :rel_op)
	 (ecase (read-token stream)
	   (in   (make-instance 'unresolved-operator :enum-symbol "in"))
	   (like (make-instance 'unresolved-operator :enum-symbol "like")))))

; nyi (schema interface)
;284 rename_id = constant_id | entity_id | function_id | procedure_id | type_id .
(defparse2-p1114 :rename_id ()
  ;; all of these eventually call simple_id
  (string (read-token stream)))

;285 repeat_control = [ increment_control ] [ while_control ] [ until_control ] .
(defparse2-p1114 :repeat_control ()
  (append
   (unless (member (peek-token stream) '(while until #\;))
     (list (parse :increment_control)))
   (when (check-token 'while stream)
     (list (parse :while_control)))
   (when (check-token 'until stream)
     (list (parse :until_control)))))

;;; This one is tough: The repeat statement is by implementation, a Scope, but
;;; it only has an identifying variable if it has an increment control. 
;;; Thus I use a 'p11u:anonymous-repeat with find-contains here. (see pass 1)
;;; pod8mex note that this needs post-processing to get into MEXICO form.
;286 repeat_stmt = REPEAT repeat_control ';' stmt { stmt } END_REPEAT ';' .
(defparse2-p1114 :repeat_stmt ()
  (assert-token 'repeat stream)
  (with-instance (|RepeatStatement|
		  :find-contains 
		  (list '|RepeatStatement| "ANONYMOUS-REPEAT" 
			(token-position "ANONYMOUS-REPEAT")))
    (let ((*scope* *def*))
      (setf |controls| (parse :repeat_control))
      (assert-token #\; stream)
      (setf |body|
	    (loop until (check-token 'end_repeat stream)
		  collect (parse :stmt)))
      (read-token stream)
      (assert-token #\; stream))))

;287 repetition = numeric_expression .
(defparse2-p1114 :repetition ()
  (parse :numeric_expression))

;288 resource_or_rename = resource_ref [ AS rename_id ] .
(defparse2-p1114 :resource_or_rename ()
  (let (resource new-name)
    (setf resource (parse :resource_ref))
    (when (check-token 'as stream)
      (read-token stream)
      (setf new-name (parse :rename_id)))
    (list resource new-name)))

;289 resource_ref = constant_ref | entity_ref | function_ref | procedure_ref | type_ref .
(defparse2-p11 :resource_ref ()
  (let ((tkn (string-upcase (peek-token stream)))) ; PODsampson string-upcase
    (cond ((entity-p tkn) (parse :entity_ref))
	  ((function-p tkn) (parse :function_ref))
	  ((type-p tkn) (parse :type_ref))
	  (t (make-scoped-id (read-token stream) :scope (schema-scope *scope*))))))

;290 return_stmt = RETURN [ '(' expression ')' ] ';' .
(defparse2-p1114 :return_stmt ()
  (with-instance (|ReturnStatement|)
    (assert-token 'return stream)
    (when (check-token #\( stream)
      (read-token stream)
      (setf |return-value| (parse :expression))
      (assert-token #\) stream))
    (assert-token #\; stream)))

;291 rule_decl = rule_head [ algorithm_head ] { stmt } where_clause END_RULE ';' .
(defparse2-p11 :rule_decl ()
  (dbind (rule-id entities) (parse :rule_head)
    (with-instance (|GlobalRule| :find-id (%local-name rule-id))
      (let ((*scope* *def*))
	(setf |id| rule-id)
	(setf |constrained-extents| entities)
	(dbind (decls constants locals) (parse :algorithm_head)
	  (declare (ignore decls constants))
	  (setf |variables| locals))
	(setf |supporting-body| ; POD FIXME
	      (loop until (member (peek-token stream) '(where end_rule))
		    collect (parse :stmt)))
	(setf |contains-rules| (parse :where_clause :global-rule t))
	(assert-token 'end_rule stream)
	(assert-token #\; stream)))))

;292 rule_head = RULE rule_id FOR '(' entity_ref { ',' entity_ref } ')' ';' .
(defparse2-p1114 :rule_head ()
  (assert-token 'rule stream)
  (let (rule-id entities)
    (setf rule-id (parse :rule_id))
    (dbg-message :parser 1 "~&Rule ~A~%" (%local-name rule-id))
    (assert-token 'for stream)
    (assert-token #\( stream)
    (setf entities
	  (cons (parse :entity_ref)
		(loop while (check-token #\, stream)
		      do (read-token stream) 
		      collect (parse :entity_ref))))
    (setf entities
      (loop for e in entities
	    collect (make-instance '|ExtentRef| :id (%id e) :refers-to e)))
    (assert-token #\) stream)
    (assert-token #\; stream)
    (list rule-id entities)))

;293 rule_id = simple_id .
(defparse2-p1114 :rule_id ()
  (make-scoped-id (read-token stream)))

; 294 rule_label_id = simple_id .
(defparse2-p11 :rule_label_id ()
  (make-scoped-id (read-token stream)))

;295 schema_body = { interface_specification } [ constant_decl ] { declaration | rule_decl } .
(defparse2-p11 :schema_body ()
  (let (defs)
    (loop while (member (peek-token stream) '(reference use))
	  do (setf defs (append defs (list (parse :interface_specification)))))
    (when (check-token 'constant stream)
      (setf defs (append (parse :constant_decl) defs))) ; :constant_decl = list of constants.
    (loop while (member (peek-token stream) '(entity function procedure subtype_constraint type rule))
	  do (if (check-token 'rule stream)
		    (setf defs (append defs (list (parse :rule_decl))))
		    (setf defs (append defs (list (parse :declaration))))))
    defs))

(defun make-generic-entity ()
  (unless (eql *scope* (schema-scope *scope*)) (error "Run this in |Schema|."))
  (let* ((id (make-scoped-id "GENERIC_ENTITY")) ; PODTT was p11uintern
	 (single (make-instance '|SingleEntityType| :id id))
	 (ent (make-instance '|EntityType| :id id :declares single)))
    (setf (%declared-in single) ent)
    ent))

(defun make-generic-type ()
  (unless (eql *scope* (schema-scope *scope*)) (error "Run this in |Schema|."))
  (let ((id (make-scoped-id "GENERIC"))) ; PODTT was p11uintern
     (make-instance '|SpecializedType| :id id)))

;296 schema_decl = SCHEMA schema_id [ schema_version_id ] ';' schema_body END_SCHEMA ';' .
(defparse2-p11 :schema_decl ()
  (assert-token 'schema stream)
  (let ((id (parse :schema_id)))
    (with-instance (|Schema| :find-force *scope*)
      (setf *scope* *def*)
      (setf |name| id)
      (unless (eql (peek-token stream) #\;)
	(setf |version| (parse :schema_version_id)))
      (assert-token #\; stream)
      (setf |schema-elements| 
	    (append (parse :schema_body)
		    (list (make-generic-entity) (make-generic-type))))
      (loop for elem in |schema-elements| do (setf (%defined-in elem) *def*))
      (assert-token 'end_schema stream)
      (assert-token #\; stream)
      ;; POD 2009-06-23 interesting that this isn't required (and (schema *expresso*) not set)
      ;; earlier than this. Fails Fred Perkins example. 
      (expo::clear-schema 
       (expo:ensure-schema 'expo::express-2-schema 
			   :name (%name *def*)
			   :lisp-package (kintern id)
			   :schema-mm *def*)))))

;297 schema_id = simple_id .
(defparse2-p1114 :schema_id ()
  (string (read-token stream))) ; This one isn't a ScopedId.

;298 schema_version_id = string_literal .
(defparse2-p11 :schema_version_id ()
  (read-token stream))

;299 selector = expression .
(defparse2-p1114 :selector ()
  (parse :expression))

; 300 select_extension = BASED_ON type_ref [ WITH select_list ] .
(defparse2-p11 :select_extension ()
  (let (based-on items)
    (assert-token 'based_on stream)
    (setf based-on (parse :type_ref))
    (when (check-token 'with stream)
      (read-token stream)
      (setf items (parse :select_list)))
    (list based-on items)))

; 301 select_list = '(' named_types { ',' named_types } ')' .
(defparse2-p11 :select_list ()
  (assert-token #\( stream)
  (prog1 
      (loop until (check-token #\) stream)
	    collect (parse :named_types)
	    when (check-token #\, stream) do (read-token stream))
    (read-token stream)))

; 302 select_type = [ EXTENSIBLE [ GENERIC_ENTITY ] ] SELECT [ select_list | select_extension ]
(defparse2-p11 :select_type ()
  (with-instance (|SelectType|)
    (when (check-token 'extensible stream)
      (setf |isExtensible| :true)
      (read-token stream)
      (when (check-token 'generic_entity stream)
	(setf |isEntity| :true)
	(read-token stream)))
    (assert-token 'select stream)
    (if (check-token #\( stream)
	   (setf |select-list| (parse :select_list))
	   (when (check-token 'based_on stream) 
	     (dbind (based-on select-list) (parse :select_extension)
              (setf |base| based-on |select-list| select-list))))))


;303 set_type = SET [ bound_spec ] OF instantiable_type .
(defparse2-p1114 :set_type ()
  (with-instance (|SETType|)
    (assert-token 'set stream)
    (setf |ordering| "unordered")
    (when (check-token #\[ stream)
	(dbind (lbound ubound) (parse :bound_spec)
	 (setf |lower-bound| lbound)
	 (setf |upper-bound| ubound)))
    (assert-token 'of stream)
    (setf |member-type| (parse :instantiable_type))))

; pod - addressed by lexer.
; 304 sign = '+' | '-' .
;(defparse2-p1114 :sign ()
;  (ecase (read-token stream)
;    (#\+ 'expo::express-plus)
;    (#\- 'expo::express-minus)))

;;; POD WRONG!
;305 simple_expression = term { add_like_op term } .
(defparse2-p1114 :simple_expression ()
  (let ((simple-expr (parse :term)))
    (loop while (member (peek-token stream) '(#\+ #\- or xor))
	  for bin-op = (make-instance '|BinaryOperation|) do
	  (setf (%left-operand bin-op) simple-expr)
	  (setf (%operator bin-op) (parse :add_like_op))
	  (setf (%right-operand bin-op) (parse :term))
	  (setf simple-expr bin-op))
    simple-expr))

;306 simple_factor = aggregate_initializer | entity_constructor | enumeration_reference | interval
;    | query_expression | ( [ unary_op ] ( '(' expression ')' | primary ) ) .
(defparse2-p11 :simple_factor ()
  (let (sfactor)
    (case (peek-token stream)
      (#\[   (setf sfactor (parse :aggregate_initializer)))
      (#\{   (setf sfactor (parse :interval)))
      (query (setf sfactor (parse :query_expression)))
      (#\(   
       (assert-token #\( stream)
       (setf sfactor (parse :expression))
       (assert-token #\) stream))
      ((#\+ #\- not)
       (let ((op (parse :unary_op)))
	 (setf sfactor
	       (with-instance (|UnaryOperation|)
			      (setf |operator| op)
			      (setf |unary-operand|
			      (if (check-token #\( stream)
				     (progn (read-token stream)
					    (prog1 (parse :expression)
					      (assert-token #\) stream)))
				     (parse :primary)))))))
      (t (let ((tkn1 (peek-token stream))   
	       (tkn2 (peek-token stream 2)) 
	       (tkn3 (peek-token stream 3))) 
	   ;pod5(dbg-message :parser 5 "~&simple_factor: tkn1=~A tkn2=~A~%" tkn1 tkn2)
	   (cond ((eql tkn2 #\()
		  (cond ((entity-p tkn1) (setf sfactor (parse :entity_constructor)))
			((function-p tkn1) (setf sfactor (parse :primary)))
			(t (error 'parse-bad-call :definition *def* :token tkn1))))
		 ((string-const-p tkn1) ;; POD 2006-03-10 Since enum-val-p/type-p p11uintern things, ; PODTT
		  (setf sfactor (parse :primary))) ;; need this to head off same-named string.
		 ((variable-p tkn1)
		  ;; variable-p and constant-p are checked in case a
		  ;; FUNCTION or PROCEDURE declared parameters or locals
		  ;; with the same name as a valid entity. -- CTL
		  
		  ;; this is a special case check because RULE's treat
		  ;; the entity names as variables - CTL
		  ;pod5(dbg-message :parser 5 "~&variable-p: tkn1=~A tkn2=~A~%" tkn1 tkn2)
		  (setf sfactor (parse :primary)))
		 ((constant-p tkn1)
		  ;; see note above
		  ;pod5(dbg-message :parser 5 "~&constant-p: tkn1=~A tkn2=~A~%" tkn1 tkn2)
		  (setf sfactor (parse :primary)))
		 ((or (and (enum-val-p tkn1) (not (equal #\. tkn2)))
			 (and (type-p tkn1) (enum-val-p tkn3)))
		  ;pod5(dbg-message :parser 5 "~&enum-val-p or type-p: tkn1=~A tkn2=~A~%" tkn1 tkn2)
		  (setf sfactor (parse :enumeration_reference)))
		 (t
		  ;pod5(dbg-message :parser 5 "~&default: tkn1=~A tkn2=~A~%" tkn1 tkn2)
		  (setf sfactor (parse :primary)))))))
    sfactor))

;307 simple_types = binary_type | boolean_type | integer_type | logical_type | number_type
;    | real_type | string_type .
(defparse2-p1114 :simple_types ()
  (ecase (peek-token stream)
    (binary  (parse :binary_type))
    (boolean (parse :boolean_type))
    (integer (parse :integer_type))
    (logical (parse :logical_type))
    (number  (parse :number_type))
    (real    (parse :real_type))
    (string  (parse :string_type))))

;308 skip_stmt = SKIP ';' .
(defparse2-p1114 :skip_stmt ()
  (with-instance (|SkipStatement|)
    (assert-token 'skip stream)
    (assert-token #\; stream)))

;309 stmt = alias_stmt | assignment_stmt | case_stmt | compound_stmt | escape_stmt | if_stmt
;    | null_stmt | procedure_call_stmt | repeat_stmt | return_stmt | skip_stmt .
(defparse2-p1114 :stmt ()
  (case (peek-token stream)
    (alias (parse :alias_stmt))
    (case (parse :case_stmt))
    (begin (parse :compound_stmt))
    (escape (parse :escape_stmt))
    (if (parse :if_stmt))
    (#\; (parse :null_stmt))
    (repeat (parse :repeat_stmt))
    (return (parse :return_stmt))
    (skip (parse :skip_stmt))
    (t (if (procedure-p (peek-token stream))
	      (parse :procedure_call_stmt)
	      (parse :assignment_stmt)))))

; 310 string_literal = simple_string_literal | encoded_string_literal .
(defparse2-p1114 :string_literal ()
  (string (read-token stream)))

(defmemo string-type-memo (len)
  (if (eql len :unspecified)
      (make-instance '|StringType|)
    (make-instance '|StringType| :string-length-constraint len)))

;311 string_type = STRING [ width_spec ] .
(defparse2-p1114 :string_type ()
  (assert-token 'string stream) 
  (if (check-token #\( stream)
      (string-type-memo (parse :width_spec))
      (string-type-memo :unspecified)))

;312 subsuper = [ supertype_constraint ] [ subtype_declaration ] .
(defparse2-p1114 :subsuper ()
  (when (member (peek-token stream) '(abstract supertype))
    (parse :supertype_constraint))
  (when (check-token 'subtype stream)
    (parse :subtype_declaration)))

;313 subtype_constraint = OF '(' supertype_expression ')' .
(defparse2-p1114 :subtype_constraint (supertype-rule)
  (assert-token 'of stream)
  (assert-token #\( stream)
  (with-instance (|SubtypeConstraint|)
       (setf |collection| supertype-rule)
       (setf |constrained-subtypes| (parse :supertype_expression)) ;; POD WRONG!
       (assert-token #\) stream)))
  
; 314 subtype_constraint_body = [ abstract_supertype ] [ total_over ] [ supertype_expression ';' ] .
(defparse2-p11 :subtype_constraint_body () ; *def* is SupertypeRule
  (let (constraints)
    (when (check-token 'abstract stream) 
      (setf constraints (list (parse :abstract_supertype))))
    (when (check-token 'total_over stream) 
      (setf constraints (append constraints (list (parse :total_over)))))
    (unless (eql (peek-token stream) 'end_subtype_constraint)
      (append (list (parse :supertype_expression)) constraints)
      (assert-token #\; stream))
    (mapcar #'(lambda (c) (setf (%collection c) *def*)) constraints)
    (setf (%constraints *def*) constraints)))

; 315 subtype_constraint_decl = subtype_constraint_head subtype_constraint_body END_SUBTYPE_CONSTRAINT ';' .
(defparse2-p11 :subtype_constraint_decl () 
  (with-instance (|SupertypeRule|)
     (parse :subtype_constraint_head)
     (parse :subtype_constraint_body)
     (assert-token 'end_subtype_constraint stream)
     (assert-token #\; stream)))

; 316 subtype_constraint_head = SUBTYPE_CONSTRAINT subtype_constraint_id FOR entity_ref ';' .
(defparse2-p11 :subtype_constraint_head () ; *def* is SupertypeRule
    (assert-token 'subtype_constraint stream)
    (setf (%id *def*) (parse :subtype_constraint_id))
    ;; SUBTYPE_CONSTRAINTs don't create scopes, but we created a *scope* object
    ;; for use in post-processing.
    (assert-token 'for stream)
    (setf (%named-supertype *def*) (parse :entity_ref))
    (assert-token #\; stream))

; 317 subtype_constraint_id = simple_id .
(defparse2-p11 :subtype_constraint_id ()
  (make-scoped-id (read-token stream)))

;318 subtype_declaration = SUBTYPE OF '(' entity_ref { ',' entity_ref } ')' .
(defparse2-p11 :subtype_declaration ()
  (assert-token 'subtype stream)
  (assert-token 'of stream)
  (assert-token #\( stream)
  (setf (%subtype-of *def*)
	(cons (parse :entity_ref)
	      (loop while (check-token #\, stream) do
		    (read-token stream)
		    collect (parse :entity_ref))))
  (assert-token #\) stream))

; 319 supertype_constraint = abstract_entity_declaration | abstract_supertype_declaration | supertype_rule .
(defparse2-p1114 :supertype_constraint () 
  (case (peek-token stream)
     (abstract  
      (setf (%is-abstract *def*) :true)
      (if (eql 'supertype (peek-token stream 2))
	     (parse :abstract_supertype_declaration) 
	     (parse :abstract_entity_declaration)))
     (supertype (parse :supertype_rule :entity-obj *def*))))

;320 supertype_expression = supertype_factor { ANDOR supertype_factor } .
(defparse2-p1114 :supertype_expression ()
  (with-instance (|ANDConstraint|) ; POD ANDORConstraint ???
     (setf |collection| ; POD |collection| should be a |SupertypeRule|
       (cons
	(parse :supertype_factor)
	(loop while (check-token 'andor stream)
	      do (read-token stream)
	      collect (parse :supertype_factor))))))

;321 supertype_factor = supertype_term { AND supertype_term } .
(defparse2-p1114 :supertype_factor ()
  (let ((sfactor (parse :supertype_term)))
    (loop while (check-token 'and stream)
	  do (read-token stream)
	  (setf sfactor `(and ,sfactor ,(parse :supertype_term)))) ; 2012
    sfactor))

;322 supertype_rule = SUPERTYPE subtype_constraint .
(defparse2-p1114 :supertype_rule (entity-obj)
  (with-instance (|SupertypeRule|)
  (assert-token 'supertype stream)
    (setf |constraints| (parse :subtype_constraint :supertype-rule *def*))
    (setf |named-supertype| entity-obj)))

;323 supertype_term = entity_ref | one_of | '(' supertype_expression ')' .
(defparse2-p1114 :supertype_term ()
  (case (peek-token stream)
    (oneof 
     (with-instance (|ONEOFConstraint|)
	 (setf |collection| (parse :one_of))))
    (#\(  
     (read-token stream)
     (prog1 (parse :supertype_expression)
       (assert-token #\) stream)))
    (t (parse :entity_ref))))

;324 syntax = schema_decl { schema_decl } .
(defparse2-p11 :syntax () 
  (parse :schema_decl))

;325 term = factor { multiplication_like_op factor } .
(defparse2-p1114 :term ()
  (let ((term (parse :factor)))
    (loop while (member (peek-token stream) '(#\* #\/ div mod and :vbar-vbar))
	  for mlo = (parse :multiplication_like_op) do
	  (setf term 
		   (with-instance (|BinaryOperation|)
				  (setf |operator| mlo)
				  (setf |left-operand| term)
				  (setf |right-operand| (parse :factor)))))
    term))

; 326 total_over = TOTAL_OVER '(' entity_ref { ',' entity_ref } ')' ';' .
(defparse2-p11 :total_over ()
  (let (entities)
    (assert-token 'total_over stream)
    (assert-token #\( stream)
    (setf entities
	  (cons (parse :entity_ref)
		(loop until (check-token #\) stream)
		      collect (parse :entity_ref)
		      do (assert-token #\, stream))))
    (assert-token #\) stream)
    (assert-token #\; stream)
    entities))

;327 type_decl = TYPE type_id '=' underlying_type ';' [ where_clause ] END_TYPE ';' .
(defparse2-p11 :type_decl ()
  (assert-token 'type stream)
  (let ((id (parse :type_id)))
    (with-instance (|SpecializedType| :find-id (%local-name id))
      (let ((*scope* *def*))
	(setf |id| id)
	(make-scoped-id-alias "SELF" |id|)
	(expo:expo-dot *expresso* :stream stream :char "T" :pass 2)
	(dbg-message :parser 1 "~&Type ~A~%" |id|)
	(assert-token #\= stream)
	(setf |underlying-type| (parse :underlying_type))
	(assert-token #\; stream)
	(when (check-token 'where stream)
	  (setf |domain-rules| (parse :where_clause))) ; pod 2006-04-18 was |constraints|
	(assert-token 'end_type stream)
	(assert-token #\; stream)))))

;328 type_id = simple_id .
(defparse2-p1114 :type_id ()
  (make-scoped-id (read-token stream)))

;329 type_label = type_label_id | type_label_ref .
(defparse2-p1114 :type_label ()
  (make-scoped-id (read-token stream)))

;330 type_label_id = simple_id .
(defparse2-p1114 :type_label_id ()
  (make-scoped-id (read-token stream)))

;331 unary_op = '+' | '-' | NOT .
(defparse2-p1114 :unary_op ()
  (ecase (read-token stream)
    (#\+ (make-instance '|UnaryOperator| :id (make-scoped-id "Identity" 
							     :scope (schema-scope *scope*))))
    (#\- (make-instance '|UnaryOperator| :id (make-scoped-id "Negate"  
							     :scope (schema-scope *scope*))))
    (not (make-instance '|UnaryOperator| :id (make-scoped-id "NOT" 
							     :scope (schema-scope *scope*))))))

;332 underlying_type = concrete_types | constructed_types .
(defparse2-p11 :underlying_type ()
  (case (peek-token stream)
    ((extensible enumeration select) (parse :constructed_types))
    ((array bag list set) (parse :concrete_types))
    ((binary boolean integer logical number real string)
     (parse :simple_types))
    (t (parse :type_ref))))

;333 unique_clause = UNIQUE unique_rule ';' { unique_rule ';' } .
(defparse2-p11 :unique_clause ()
    (assert-token 'unique stream)
    (cons (parse :unique_rule)
	  (progn (assert-token #\; stream)
		 (loop until (member (peek-token stream) '(where end_entity))
		       collect (parse :unique_rule)
		       do (assert-token #\; stream)))))

;334 unique_rule = [ rule_label_id ':' ] referenced_attribute { ',' referenced_attribute } .
(defparse2-p11 :unique_rule ()
  (with-instance (|UniqueRule|)
    (when (eql #\: (peek-token stream 2))
      (make-scoped-id (read-token stream))
      (read-token stream))
    (setf |key-component|
	  (cons (parse :referenced_attribute)
		(loop while (check-token #\, stream)
		      do (read-token stream)
		      collect (parse :referenced_attribute))))))

;335 until_control = UNTIL logical_expression .
(defparse2-p11 :until_control ()
  (with-instance (|RepeatUntilControl|)
    (assert-token 'until stream)
    (setf |condition| (parse :logical_expression))))

;336 use_clause = USE FROM schema_ref [ '(' named_type_or_rename { ',' named_type_or_rename } ')' ] ';' .
(defparse2-p11 :use_clause ()
  (let (schema resources)
    (assert-token 'use stream)
    (assert-token 'from stream)
    (setf schema (parse :schema_ref))
    (when (check-token #\( stream)
      (read-token stream)
      (setf resources
	    (cons (parse :named_type_or_rename)
		  (loop while (check-token #\, stream)
			do (read-token stream)
			collect (parse :named_type_or_rename))))
      (assert-token #\) stream))
    (assert-token #\; stream)
    `(def-reference-from :schema ',schema :resources ',resources)))

;337 variable_id = simple_id .
(defparse2-p1114 :variable_id (token) ; it can come in with the thing already read (&key TOKEN).
  (with-instance (|Variable|)
    (let ((tkn (or token (read-token stream))))
      (setf |id| (make-scoped-id tkn))
      (typecase *scope*
	(|QueryExpression|  (push *def* (%query-variable *scope*)))
	(|RepeatStatement|  (push *def* (%control-variable *scope*)))
	(t (push *def* (%variables *scope*)))))))

(defparse2-p11 :alias_variable_id (token) 
  (with-instance (|AliasVariable|)
    (let ((tkn (or token (read-token stream))))
      (setf |id| (make-scoped-id tkn))
      (push *def* (%variables *scope*)))))

;338 where_clause = WHERE domain_rule ';' { domain_rule ';' } .
(defparse2-p11 :where_clause (global-rule)
  (assert-token 'where stream)
  (cons
   (prog1 
       (parse :domain_rule :global-rule global-rule)
     (assert-token #\; stream))
   (loop until (member (peek-token stream) '(end_entity end_rule end_type))
	 collect (parse :domain_rule :global-rule global-rule)
	 do (assert-token #\; stream))))

;339 while_control = WHILE logical_expression .
(defparse2-p1114 :while_control ()
  (with-instance (|RepeatWhileControl|)
    (assert-token 'while stream)
    (setf |condition| (parse :logical_expression))))

;340 width = numeric_expression .
(defparse2-p1114 :width ()
  (parse :numeric_expression))

;341 width_spec = '(' width ')' [ FIXED ] .
(defparse2-p1114 :width_spec ()
  (with-instance (|LengthConstraint|)
    (assert-token #\( stream)
    (setf |maxLength| (parse :width))
    (assert-token #\) stream)
    (when (check-token 'fixed stream)
      (read-token stream)
      (setf |isFixed| :true))))




