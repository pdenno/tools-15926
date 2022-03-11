
(in-package :P11P)

;;; Copyright (c) 2002 Logicon, Inc.
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

;;; Purpose: Create a scope tree and store information about IDs in those scopes.
;;;          Create ScopedIds (make-scoped-id) for 'referenceables' only 
;;;          (NamedTypes, Functions)

;(defmethod print-object ((obj |SingleEntityType|) stream)
;  (call-next-method)
;  (format stream "SingleEntityType hack"))

(defun tryme ()
  (with-debugging (:parser 0)
    (parse1-data 
     #P"/home/pdenno/projects/expresso/source/lib/ap233-testbed/ap233.exp"
     :p11-file)))

(defclass p11-stream (expo:p1114-stream)
  ())

(defun make-p11-stream (stream)
  (make-instance 'p11-stream :stream stream :buffer-string nil))

;(p11p:parse-p11 "/home/pdenno/express-schema/production-rule-lf.exp" :out-path "~/junk.lisp")
;(p11p:parse-p11 "/home/pdenno/repo/dodaf/mechatronics/ap233-reqs.exp" :out-path "~/junk.lisp")
;(p11p:parse-p11 "/home/pdenno/Desktop/SC4/AP233EX/ap233-pbr.exp" :out-path "~/junk.lisp")
;(p11p:parse-p11 "/home/pdenno/Desktop/SC4/AP233EX/ap233-interim1.exp" :out-path "~/junk.lisp")
;(gui::load-project "/home/pdenno/projects/expresso/projects/reqs.pra")
;(expo:read-schema "/home/pdenno/Desktop/SC4/AP233EX/ap233.exx" :exx)

;;;======================================================================
;;; Parsing...
;;;======================================================================
(defmethod parse1-data ((path pathname) (tag (eql :p11-file)) &key)
  (with-open-file (char-stream path :direction :input)
    (with-open-stream (stream (setf *token-stream* (make-p11-stream char-stream)))
      (parse1-data stream :stream))))

(defmacro defparse1-p11 (tag (&rest keys) &body body)
  `(defmethod parse1-data ((stream p11-stream) (tag (eql ,tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys) ; the mystery solved: pass2 needs to call parse too.
		       `(parse1-data stream ,tag ,@keys)))
       ,@body)))

;; call the top-level grammar rule
(defparse1-p11 :stream ()
  (init-bcounters)
  (setf *line-number* 1)
  (system-clear-memoized-fns :suppress-warning t)
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

;; from iso-10303-11:1994

;; pass 1 grammar

;;; e-2
;164 abstract_entity_declaration
(defparse1-p11 :abstract_entity_declaration ()
  (assert-token 'abstract stream))

; 165 abstract_supertype = ABSTRACT SUPERTYPE ’;’ .
(defparse1-p11 :abstract_supertype ()
  (assert-token 'abstract stream)
  (assert-token 'supertype stream)
  (assert-token #\; stream))

;166 abstract_supertype_declaration = 'abstract' 'supertype' [ subtype_constraint ] .
(defparse1-p1114 :abstract_supertype_declaration ()
  (assert-token 'abstract stream)
  (assert-token 'supertype stream)
  (when (check-token 'of stream)
    (parse :subtype_constraint)))

;167 actual_parameter_list = '(' parameter { ',' parameter } ')' .
(defparse1-p1114 :actual_parameter_list ()
  (assert-token #\( stream)
  (parse :parameter)
  (loop while (check-token #\, stream) do
	(read-token stream) 
	(parse :parameter))
  (assert-token #\) stream))

;168 add_like_op = '+' | '-' | 'or' | 'xor' .
(defparse1-p1114 :add_like_op ()
  (when (member (peek-token stream) '(#\+ #\- or xor))
    (read-token stream)))

;169 aggregate_initializer = '[' [ element { ',' element } ] ']' .
(defparse1-p1114 :aggregate_initializer ()
  (assert-token #\[ stream)
  (unless (check-token #\] stream)
    (parse :element)
    (loop while (check-token #\, stream) do 
	  (read-token stream) (parse :element)))
  (assert-token #\] stream))

;170 aggregate_source = simple_expression .
(defparse1-p1114 :aggregate_source ()
  (parse :simple_expression))

;171 aggregate_type = 'aggregate' [ ':' simple_id ] 'of' parameter_type .
(defparse1-p1114 :aggregate_type ()
  (assert-token 'aggregate stream)
  (when (check-token #\: stream)
    (read-token stream)
    (add-type (read-token stream) *scope* :type-label))
  (assert-token 'of stream)
  (parse :parameter_type))

;172 aggregation_types = array_type | bag_type | list_type | set_type .
(defparse1-p1114 :aggregation_types ()
  (case (peek-token stream)
    (array (parse :array_type))
    (bag   (parse :bag_type))
    (list  (parse :list_type))
    (set   (parse :set_type))))

;173 algorithm_head = { declaration } [ constant_decl ] [ local_decl ] .
(defparse1-p1114 :algorithm_head ()
  (loop while (member (peek-token stream) '(entity function procedure type))
	do (parse :declaration))
  (when (check-token 'constant stream)
    (parse :constant_decl))
  (when (check-token 'local stream)
    (parse :local_decl)))

;174 alias_stmt = 'alias' simple_id 'for' simple_id { qualifier } ';' stmt { stmt } 'end_alias' ';' .
(defparse1-p11 :alias_stmt ()
  (assert-token 'alias stream)
    (let ((id (read-token stream)))
      (assert-token 'for stream)
      (let ((*scope* (make-instance '|AliasStatement| :%parent *scope*)))
	(add-type id *scope* :variable)
	(loop while (member (peek-token stream) '(#\. #\\ #\[))
	      do (parse :qualifier))
	(assert-token #\; stream)
	(parse :stmt)
	(loop until (check-token 'end_alias stream)
	      do (parse :stmt))
	(assert-token 'end_alias stream)
	(assert-token #\; stream))))

;175 array_type = 'array' bound_spec 'of' [ 'optional' ] [ 'unique' ] instantiable_type .
(defparse1-p1114 :array_type ()
  (assert-token 'array stream)
  (parse :bound_spec)
  (assert-token 'of stream)
  (when (check-token 'optional stream)
    (read-token stream))
  (when (check-token 'unique stream)
    (read-token stream))
  (parse :instantiable_type))

;176 assignment_stmt = simple_id { qualifier } ':=' expression ';' .
(defparse1-p1114 :assignment_stmt ()
  (read-token stream)
  (loop while (member (peek-token stream) '(#\. #\\ #\[))
	do (parse :qualifier))
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream))

;; e-2
;177 attribute_decl = simple_id | redeclared_attribute .
(defparse1-p11 :attribute_decl ()
  (case (peek-token stream)
    (self (parse :redeclared_attribute))
    (t (add-type (read-token stream) *scope* :attribute))))

;178 attribute_id = simple_id .

;179 attribute_qualifier = '.' simple_id .
(defparse1-p11 :attribute_qualifier ()
  (assert-token #\. stream)
  (read-token stream))

;180 bag_type = 'bag' [ bound_spec ] 'of' instantiable_type .
(defparse1-p1114 :bag_type ()
  (assert-token 'bag stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (parse :instantiable_type)
  t)

;181 binary_type = 'binary' [ width_spec ] .
(defparse1-p1114 :binary_type ()
  (assert-token 'binary stream)
  (when (check-token #\( stream)
    (parse :width_spec))
  t)

;182 boolean_type = 'boolean' .
(defparse1-p1114 :boolean_type ()
  (assert-token 'boolean stream)
  t)

;183 bound_1 = numeric_expression .
(defparse1-p1114 :bound_1 ()
  (parse :numeric_expression))

;184 bound_2 = numeric_expression .
(defparse1-p1114 :bound_2 ()
  (parse :numeric_expression))

;185 bound_spec = '[' bound_1 ':' bound_2 ']' .
(defparse1-p1114 :bound_spec ()
  (assert-token #\[ stream)
  (parse :bound_1)
  (assert-token #\: stream)
  (parse :bound_2)
  (assert-token #\] stream))

;186 built_in_constant = 'const_e' | 'pi' | 'self' | '?' .
(defparse1-p1114 :built_in_constant ()
  (when (member (peek-token stream) '(const_e pi self #\?))
    (read-token stream)))

;187 built_in_function = 'abs' | 'acos' | 'asin' | 'atan' | 'blength' | 'cos' | 'exists'
;    | 'exp' | 'format' | 'hibound' | 'hiindex' | 'length' | 'lobound' | 'loindex' | 'log'
;    | 'log2' | 'log10' | 'nvl' | 'odd' | 'rolesof' | 'sin' | 'sizeof' | 'sqrt' | 'tan'
;    | 'typeof' | 'usedin' | 'value' | 'value_in' | 'value_unique'
;    | 'print' .
;; 'print' is an EE specific extension
(defparse1-p1114 :built_in_function ()
  (when (member (peek-token stream)
		'(abs acos asin atan blength cos exists exp format hibound hiindex length
		  lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
		  usedin value value_in value_unique
		  ;; EE extensions
		  print
		  ;; EXX Extension
		  extent))
    (read-token stream)))

;188 built_in_procedure = 'insert' | 'remove' .
(defparse1-p11 :built_in_procedure ()
  (when (member (peek-token stream) '(insert remove))
    (read-token stream)))

;189 case_action = case_label { ',' case_label } ':' stmt .
(defparse1-p11 :case_action ()
  (parse :case_label)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(parse :case_label))
  (assert-token #\: stream)
  (parse :stmt))

;190 case_label = expression .
(defparse1-p1114 :case_label ()
  (parse :expression))

;191 case_stmt ='case' selector 'of' { case_action } [ 'otherwise' ':' stmt ] 'end_case' ';' .
(defparse1-p1114 :case_stmt ()
  (assert-token 'case stream)
  (parse :selector)
  (assert-token 'of stream)
  (loop until (member (peek-token stream) '(otherwise end_case))
	do (parse :case_action))
  (when (check-token 'otherwise stream)
    (read-token stream)
    (assert-token #\: stream)
    (parse :stmt))
  (assert-token 'end_case stream)
  (assert-token #\; stream))

;192 compound_stmt = 'begin' stmt { stmt } 'end' ';' .
(defparse1-p1114 :compound_stmt ()
  (assert-token 'begin stream)
  (parse :stmt)
  (loop until (check-token 'end stream) do
	(parse :stmt))
  (read-token stream)
  (assert-token #\; stream))

; pod e2 new
; 193 concrete_types = aggregation_types | simple_types | type_ref .
(defparse1-p1114 :concrete_types ()
  (let ((tkn (peek-token stream)))
    (cond ((member tkn '(array bag list set))
	   (parse :aggregation_types))
	  ((member tkn '(binary boolean integer logical number real string))
	   (parse :simple_types))
	  (t (parse :type_ref)))))

;194 constant_body = simple_id ':' instantiable_type ':=' expression ';' .
(defparse1-p11 :constant_body ()
  (parse :constant_id)
  (assert-token #\: stream)
  (parse :instantiable_type)
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream))

;195 constant_decl = 'constant' constant_body { constant_body } 'end_constant' ';' .
(defparse1-p1114 :constant_decl ()
  (assert-token 'constant stream)
  (parse :constant_body)
  (loop until (check-token 'end_constant stream)
	do (parse :constant_body))
  (read-token stream)
  (assert-token #\; stream)
  t)

;196 constant_factor = built_in_constant | simple_id .
(defparse1-p1114 :constant_factor ()
  (case (peek-token stream)
    ((const_e pi self #\?) (parse :built_in_constant))
    (t (read-token stream))))

;197 constant_id = simple_id .
(defparse1-p11 :constant_id ()
  (add-type (read-token stream) *scope* :constant))

;198 constructed_types = enumeration_type | select_type .
(defparse1-p11 :constructed_types ()
  (let ((tkn (if (eql (peek-token stream) 'extensible) 
		 (peek-token stream 2)
	       (peek-token stream))))
    (ecase tkn
      (enumeration (parse :enumeration_type))
      ((generic_entity select) (parse :select_type)))))

;199 declaration = entity_decl | function_decl | procedure_decl | type_decl .
(defparse1-p11 :declaration ()
  (case (peek-token stream)
    (entity    (parse :entity_decl))
    (function  (parse :function_decl))
    (procedure (parse :procedure_decl))
    (subtype_constraint (parse :subtype_constraint_decl))
    (type      (parse :type_decl))))

;200 derived_attr = attribute_decl ':' parameter_type ':=' expression ';' .
(defparse1-p11 :derived_attr ()
  (parse :attribute_decl)
  (assert-token #\: stream)
  (parse :parameter_type)
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream))

;201 derive_clause = 'derive' derived_attr { derived_attr } .
(defparse1-p11 :derive_clause ()
  (assert-token 'derive stream)
  (parse :derived_attr)
  (loop until (member (peek-token stream) '(inverse unique where end_entity))
	do (parse :derived_attr)))

;202 domain_rule = [ simple_id ':' ] logical_expression .
(defparse1-p1114 :domain_rule ()
  (when (eql #\: (peek-token stream 2))
    (add-type (read-token stream) *scope* :rule-label)
    (read-token stream))
  (parse :logical_expression))

;203 element = expression [ ':' repetition ] .
(defparse1-p1114 :element ()
  (parse :expression)
  (when (check-token #\: stream)
    (read-token stream)
    (parse :repetition)))

;204 entity_body = { explicit_attr } [ derive_clause ] [ inverse_clause ] [ unique_clause ]
;                  [ where_clause ] .
(defparse1-p11 :entity_body ()
  (loop until (member (peek-token stream) '(derive inverse unique where end_entity))
	do (parse :explicit_attr))
  (when (check-token 'derive stream)
    (parse :derive_clause))
  (when (check-token 'inverse stream)
    (parse :inverse_clause))
  (when (check-token 'unique stream)
    (parse :unique_clause))
  (when (check-token 'where stream)
    (parse :where_clause)))

;205 entity_constructor = simple_id '(' [ expression { ',' expression } ] ')' .
(defparse1-p1114 :entity_constructor ()
  (read-token stream)
  (assert-token #\( stream)
  (unless (check-token #\) stream)
    (parse :expression)
    (loop while (check-token #\, stream) do
	  (read-token stream)
	  (parse :expression)))
  (assert-token #\) stream))

;206 entity_decl = entity_head entity_body 'end_entity' ';' .
(defparse1-p11 :entity_decl ()
  (let* ((entity-id (parse :entity_head))
	 (*scope* (make-instance '|EntityType| :%parent *scope*)))
    (setf (%id *scope*) (make-scoped-id entity-id))
    (add-type 'p11u::self *scope* :constant)
    (parse :entity_body)
    (assert-token 'end_entity stream)
    (assert-token #\; stream)
    t))

;207 entity_head = 'entity' simple_id subsuper ';' .
(defparse1-p11 :entity_head ()
  (assert-token 'entity stream)
  (let ((name (read-token stream)))
    (add-type name *scope* :entity)
    (expo:expo-dot *expresso* :stream stream :pass 1 :char "E")
    (dbg-message :parser 1 "~&Entity ~A~%" name)
    (parse :subsuper)
    (assert-token #\; stream)
    name))

;208 entity_id = simple_id .

; pod e2 change
;209 enumeration_extension = BASED_ON type_ref [ WITH enumeration_items ] .
(defparse1-p11 :enumeration_extension ()
  (assert-token 'based_on stream)
  (read-token stream) ; simple_id
  (when (check-token 'with stream)
    (read-token stream)
    (parse :enumeration_items)))

;210 enumeration_id = simple_id . 

;211 enumeration_items = '(' enumeration_id { ',' enumeration_id } ')' .
(defparse1-p11 :enumeration_items ()
  (let (item)
    (assert-token #\( stream)
    (add-type (setf item (read-token stream)) *scope* :enum-val)
    (add-type item (%%parent *scope*) :enum-val) ; visible in schema too.
    (loop while (check-token #\, stream) do
	  (read-token stream)
	  (add-type (setf item (read-token stream)) *scope* :enum-val)
	  (add-type item (%%parent *scope*) :enum-val))
    (assert-token #\) stream)))

;212 enumeration_reference = [ simple_id '.' ] simple_id .
(defparse1-p11 :enumeration_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)
    (read-token stream)))

;213 enumeration_type = [ EXTENSIBLE ] ENUMERATION [ ( OF enumeration_items ) | enumeration_extension ] .
(defparse1-p11 :enumeration_type ()
  (when (check-token 'extensible stream) (read-token stream))
  (assert-token 'enumeration stream)
  (cond ((check-token 'of stream)
	 (read-token stream)
	 (parse :enumeration_items))
	(t (parse :enumeration_extension))))

;214 escape_stmt = 'escape' ';' .
(defparse1-p1114 :escape_stmt ()
  (assert-token 'escape stream)
  (assert-token #\; stream))

;215 explicit_attr = attribute_decl { ',' attribute_decl } ':' [ 'optional' ] parameter_type ';' .
(defparse1-p11 :explicit_attr ()
  (parse :attribute_decl)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(parse :attribute_decl))
  (assert-token #\: stream)
  (when (check-token 'optional stream) (read-token stream))
  (parse :parameter_type)
  (assert-token #\; stream))

;216 expression = simple_expression [ rel_op_extended simple_expression ] .
(defparse1-p1114 :expression ()
  (parse :simple_expression)
  (when (parse :rel_op_extended)
    (parse :simple_expression)))

;217 factor = simple_factor [ '**' simple_factor ] .
(defparse1-p1114 :factor ()
  (parse :simple_factor)
  (when (check-token :star-star stream)
    (read-token stream)
    (parse :simple_factor)))

;218 formal_parameter = simple_id { ',' simple_id } ':' parameter_type .
(defparse1-p1114 :formal_parameter ()
  (let (tkn)
    (add-type (setf tkn (read-token stream)) *scope* :variable) ; pod was :parameter
    (add-type tkn *scope* :parameter) ; only parse-mm needs this.
    (loop while (check-token #\, stream) do
	  (read-token stream)
	  (add-type (setf tkn (read-token stream)) *scope* :variable) 
	  (add-type tkn *scope* :parameter)) ; ditto
    (assert-token #\: stream)
    (parse :parameter_type)))

;219 function_call = ( built_in_function | simple_id ) [ actual_parameter_list ] .
(defparse1-p1114 :function_call ()
  (case (peek-token stream)
    ((abs acos asin atan blength cos exists exp format hibound hiindex length
      lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
      usedin value value_in value_unique
      ;; EE extension
      print)
     (parse :built_in_function))
    (t (read-token stream)))
  (when (check-token #\( stream)
    (parse :actual_parameter_list)))

;219 function_decl = function_head algorithm_head stmt { stmt } 'end_function' ';' .
(defparse1-p1114 :function_decl ()
  (let ((*scope* *scope*))
    (parse :function_head)
    (parse :algorithm_head)
    (parse :stmt)
    (loop until (eql (peek-token stream) 'end_function) do
	  (parse :stmt))
    (assert-token 'end_function stream) 
    (assert-token #\; stream)))

;221 function_head = 'function' function_id [ '(' formal_parameter { ';' formal_parameter } ')' ] ':' parameter_type ';' .
(defparse1-p1114 :function_head ()
  (assert-token 'function stream)
  (let ((func-id (parse :function_id)))
    (add-type func-id *scope* :function)
    (setf *scope* (make-instance '|Function| :%parent *scope*))
    (setf (%id *scope*) (make-scoped-id func-id))
    (expo:expo-dot *expresso* :stream stream :char "F" :pass 1)
    (when (check-token #\( stream)
      (read-token stream)
      (parse :formal_parameter)
      (loop while (check-token #\; stream) do
	    (read-token stream)
	    (parse :formal_parameter))
      (assert-token #\) stream))
    (assert-token #\: stream)
    (parse :parameter_type)
    (assert-token #\; stream)))

;222 function_id = simple_id .
(defparse1-p1114 :function_id ()
  (read-token stream))

;223 generalized_types = aggregate_type | general_aggregation_types | generic_type .
(defparse1-p1114 :generalized_types ()
  (case (peek-token stream)
    (aggregate (parse :aggregate_type))
    ((array bag list set) (parse :general_aggregation_types))
    (generic (parse :generic_type))
    (generic_entity (parse :generic_entity_type))))

;224 general_aggregation_types = general_array_type | general_bag_type | general_list_type | general_set_type .
(defparse1-p1114 :general_aggregation_types ()
  (case (peek-token stream)
    (array (parse :general_array_type))
    (bag   (parse :general_bag_type))
    (list  (parse :general_list_type))
    (set   (parse :general_set_type))))

;225 general_array_type = 'array' [ bound_spec ] 'of' [ 'optional' ] [ 'unique' ] parameter_type .
(defparse1-p1114 :general_array_type ()
  (assert-token 'array stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (when (check-token 'optional stream) (read-token stream))
  (when (check-token 'unique stream) (read-token stream))
  (parse :parameter_type))

;226 general_bag_type = 'bag' [ bound_spec ] 'of' parameter_type .
(defparse1-p1114 :general_bag_type ()
  (assert-token 'bag stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (parse :parameter_type))

;227 general_list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] parameter_type .
(defparse1-p1114 :general_list_type ()
  (assert-token 'list stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (when (check-token 'unique stream) (read-token stream))
  (parse :parameter_type))

;228 general_ref = parameter_ref | variable_ref .
(defparse1-p11 :general_ref ()
  (read-token stream))

;229 general_set_type = 'set' [ bound_spec ] 'of' parameter_type .
(defparse1-p1114 :general_set_type ()
  (assert-token 'set stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (parse :parameter_type))

; 230 generic_entity_type = GENERIC_ENTITY [ ':' type_label ] .
(defparse1-p11 :generic_entity_type ()
  (assert-token 'generic_entity stream)
  (when (check-token #\: stream)
    (read-token stream) 
    (add-type (read-token stream) *scope* :type-label)))

;231 generic_type = GENERIC [ ':' simple_id ] .
(defparse1-p1114 :generic_type ()
  (assert-token 'generic stream)
  (when (check-token #\: stream)
    (read-token stream)
    (add-type (read-token stream) *scope* :type-label)))

;232 group_qualifier = '\' simple_id .
(defparse1-p1114 :group_qualifier ()
  (assert-token #\\ stream)
  (read-token stream))

;233 if_stmt = 'if' logical_expression 'then' stmt { stmt } [ 'else' stmt { stmt } ] 'end_if' ';' .
(defparse1-p1114 :if_stmt ()
  (assert-token 'if stream)
  (parse :logical_expression)
  (assert-token 'then stream)
  (parse :stmt)
  (loop until (member (peek-token stream) '(else end_if))
	do (parse :stmt))
  (when (check-token 'else stream)
    (read-token stream)
    (parse :stmt)
    (loop until (check-token 'end_if stream)
	  do (parse :stmt)))
  (assert-token 'end_if stream)
  (assert-token #\; stream))

;234 increment = numeric_expression .
(defparse1-p1114 :increment ()
  (parse :numeric_expression))

;235 increment_control = simple_id ':=' bound_1 'to' bound_2 [ 'by' increment ] .
(defparse1-p1114 :increment_control ()
  (add-type (read-token stream) *scope* :variable) ; scope is repeat-statement
  (assert-token :colon-equal stream)
  (parse :bound_1)
  (assert-token 'to stream)
  (parse :bound_2)
  (when (check-token 'by stream)
    (read-token stream)
    (parse :increment)))

;236 index = numeric_expression .
(defparse1-p1114 :index ()
  (parse :numeric_expression))

;237 index_1 = index .
(defparse1-p1114 :index_1 ()
  (parse :index))

;238 index_2 = index .
(defparse1-p1114 :index_2 ()
  (parse :index))

;239 index_qualifier = '[' index [ ':' index ] ']' .
(defparse1-p1114 :index_qualifier ()
  (assert-token #\[ stream)
  (parse :index)
  (when (check-token #\: stream)
    (read-token stream)
    (parse :index))
  (assert-token #\] stream))

; 240 instantiable_type = concrete_types | entity_ref .
(defparse1-p11 :instantiable_type ()
  (cond ((member (peek-token stream) 
		 '(array bag list set binary boolean integer logical number real string))
	 (parse :concrete_types))
	(t (read-token stream))))

;241 integer_type = 'integer' .
(defparse1-p1114 :integer_type ()
  (assert-token 'integer stream))

;242 interface_specification = reference_clause | use_clause .
(defparse1-p11 :interface_specification ()
  (case (peek-token stream)
    (reference (parse :reference_clause))
    (use       (parse :use_clause))))

;243 interval = '{' interval_low interval_op interval_item interval_op interval_high '}' .
(defparse1-p1114 :interval ()
  (assert-token #\{ stream)
  (parse :interval_low)
  (parse :interval_op)
  (parse :interval_item)
  (parse :interval_op)
  (parse :interval_high)
  (assert-token #\} stream))

;244 interval_high = simple_expression .
(defparse1-p1114 :interval_high ()
  (parse :simple_expression))

;245 interval_item = simple_expression .
(defparse1-p1114 :interval_item ()
  (parse :simple_expression))

;246 interval_low = simple_expression .
(defparse1-p1114 :interval_low ()
  (parse :simple_expression))

;247 interval_op = '<' | '<=' .
(defparse1-p1114 :interval_op ()
  (when (member (peek-token stream) '(#\< :less-equal))
    (read-token stream)))

;248 inverse_attr = attribute_decl ':' [ ( 'set' | 'bag' ) [ bound_spec ] 'of' ] simple_id 'for'
;    simple_id ';' .
(defparse1-p11 :inverse_attr ()
  (parse :attribute_decl)
  (assert-token #\: stream)
  (when (member (peek-token stream) '(set bag))
    (read-token stream)			;eat 'set' or 'bag'
    (when (check-token #\[ stream)
      (parse :bound_spec))
    (assert-token 'of stream))
  (add-type (read-token stream) (%%parent *scope*) :entity)
  ;(read-token stream) ; 2007 attr should be declared elsewhere
  (assert-token 'for stream)
  (read-token stream)
  (assert-token #\; stream))

;249 inverse_clause = 'inverse' inverse_attr { inverse_attr } .
(defparse1-p11 :inverse_clause ()
  (assert-token 'inverse stream)
  (parse :inverse_attr)
  (loop until (member (peek-token stream) '(unique where end_entity))
	do (parse :inverse_attr)))

;250 list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] instantiable_type .
(defparse1-p1114 :list_type ()
  (assert-token 'list stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (when (check-token 'unique stream) (read-token stream))
  (parse :instantiable_type))

;251 literal = binary_literal | integer_literal | logical_literal | real_literal | string_literal .
(defparse1-p1114 :literal ()
  ;; handled by reader
  (read-token stream))

;252 local_decl = 'local' local_variable { local_variable } 'end_local' ';' .
(defparse1-p1114 :local_decl ()
  (assert-token 'local stream)
  (parse :local_variable)
  (loop until (check-token 'end_local stream)
	do (parse :local_variable))
  (assert-token 'end_local stream)
  (assert-token #\; stream))

;253 local_variable = simple_id { ',' simple_id } ':' parameter_type [ ':=' expression ] ';' .
(defparse1-p1114 :local_variable ()
  (add-type (read-token stream) *scope* :variable)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(add-type (read-token stream) *scope* :variable))
  (assert-token #\: stream)
  (parse :parameter_type)
  (when (check-token :colon-equal stream)
    (read-token stream)
    (parse :expression))
  (assert-token #\; stream))

;254 logical_expression = expression .
(defparse1-p1114 :logical_expression ()
  (parse :expression))

;255 logical_literal = 'false' | 'true' | 'unknown' .
(defparse1-p1114 :logical_literal ()
  (when (member (peek-token stream) '(false true unknown))
    (read-token stream)))

;256 logical_type = 'logical' .
(defparse1-p1114 :logical_type ()
  (assert-token 'logical stream))

;257 multiplication_like_op = '*' | '/' | 'div' | 'mod' | 'and' | '||' .
(defparse1-p1114 :multiplication_like_op ()
  (when (member (peek-token stream) '(#\* #\/ div mod and :vbar-vbar))
    (read-token stream)))

;258 named_types = entity_ref | type_ref .
(defparse1-p11 :named_types ()
  (read-token stream))

;259 named_type_or_rename = simple_id [ 'as' ( simple_id ) ] .
(defparse1-p11 :named_type_or_rename ()
  (read-token stream)
  (when (check-token 'as stream)
    (read-token stream)
    (read-token stream)))

;260 null_stmt = ';' .
(defparse1-p1114 :null_stmt ()
  (assert-token #\; stream))

;261 number_type = 'number' .
(defparse1-p1114 :number_type ()
  (assert-token 'number stream))

;262 numeric_expression = simple_expression .
(defparse1-p1114 :numeric_expression ()
  (parse :simple_expression))

;263 one_of = 'oneof' '(' supertype_expression { ',' supertype_expression } ')' .
(defparse1-p1114 :one_of ()
  (assert-token 'oneof stream)
  (assert-token #\( stream)
  (parse :supertype_expression)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(parse :supertype_expression))
  (assert-token #\) stream))

;264 parameter = expression .
(defparse1-p1114 :parameter ()
  (parse :expression))

;265 parameter_id = simple_id .

;266 parameter_type = generalized_types | simple_id | simple_types .
(defparse1-p11 :parameter_type ()
  (case (peek-token stream)
    ((aggregate array bag list set generic generic_entity) (parse :generalized_types))
    ((binary boolean integer logical number real string) (parse :simple_types))
    (t (read-token stream))))

;267 population = entity_ref .
(defparse1-p1114 :population ()
  (read-token stream))

;268 precision_spec = numeric_expression .
(defparse1-p1114 :precision_spec ()
  (parse :numeric_expression))

;269 primary = literal | ( qualifiable_factor { qualifier } ) .
(defparse1-p1114 :primary ()
  (let  ((tkn (peek-token stream)))
    (cond ((or (typep tkn '(or number bit-vector))
	       (string-const-p tkn))
	   (parse :literal))
	  (t (parse :qualifiable_factor)
	   (loop while (member (peek-token stream) '(#\. #\\ #\[))
		 do (parse :qualifier))))))

;270 procedure_call_stmt = ( built_in_procedure | simple_id ) [ actual_parameter_list ] ';' .
(defparse1-p1114 :procedure_call_stmt ()
  (or (parse :built_in_procedure)
	 (read-token stream))
  (when (check-token #\( stream)
    (parse :actual_parameter_list)))

;271 procedure_decl = procedure_head algorithm_head { stmt } 'end_procedure' ';' .
(defparse1-p1114 :procedure_decl ()
  (parse :procedure_head)
  (parse :algorithm_head)
  (loop until (check-token 'end_procedure stream) do
	(read-token stream)
	(parse :stmt))
  (assert-token 'end_procedure stream)
  (assert-token #\; stream))

;272 procedure_head = 'procedure' simple_id [ '(' [ 'var' ] formal_parameter { ';' [ 'var' ] formal_parameter } ')' ] ';' .
(defparse1-p1114 :procedure_head ()
  (let (name)
    (assert-token 'procedure stream)
    (setf name (read-token stream))
    (let ((*scope* (make-instance '|Procedure| :id name :%parent *scope*)))
      (setf (%id *scope*) (make-scoped-id name))
      (add-type name *scope* :procedure)
      (expo:expo-dot *expresso*  :stream stream :char "P" :pass 1)
      (dbg-message :parser 1  "~&Procedure ~A~%" name)
      (when (check-token #\( stream)
	(read-token stream)
	(check-token 'var stream)
	(parse :formal_parameter)
	(loop while (check-token #\; stream) do 
	      (read-token stream)
	      (check-token 'var stream)
	      (parse :formal_parameter))
	(assert-token #\) stream))
      (assert-token #\; stream))))

;273 procedure_id = simple_id .

;274 qualifiable_factor = attribute_ref | constant_factor | function_call | general_ref | population .
(defparse1-p11 :qualifiable_factor ()
  (case (peek-token stream)
    ((const_e pi self #\?) (parse :constant_factor))
    ((abs acos asin atan blength cos exists exp format hibound hiindex length
      lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
      usedin value value_in value_unique
      ;; EE extension
      print)
     (parse :function_call))
    (t (if (eql #\( (peek-token stream 2))
	 (parse :function_call)
	 (read-token stream)))))

;275 qualified_attribute = 'self' group_qualifier attribute_qualifier .
(defparse1-p11 :qualified_attribute ()
  (assert-token 'self stream)
  (parse :group_qualifier)
  (parse :attribute_qualifier))

;276 qualifier = attribute_qualifier | group_qualifier | index_qualifier .
(defparse1-p11 :qualifier ()
  (case (peek-token stream)
    (#\. (parse :attribute_qualifier))
    (#\\ (parse :group_qualifier))
    (#\[ (parse :index_qualifier))))

;277 query_expression = 'query' '(' simple_id '<*' aggregate_source '|' logical_expression ')' .
(defparse1-p1114 :query_expression ()
  (assert-token 'query stream)
  (let ((*scope* (make-instance '|QueryExpression| :%parent *scope*)))
    (assert-token #\( stream)
    (add-type (read-token stream) *scope* :variable)
    (assert-token :less-star stream)
    (parse :aggregate_source)
    (assert-token #\| stream)
    (parse :logical_expression)
    (assert-token #\) stream)))

;278 real_type = 'real' [ '(' precision_spec ')' ] .
(defparse1-p1114 :real_type ()
  (assert-token 'real stream)
  (when (check-token #\( stream)
    (read-token stream)
    (parse :precision_spec)
    (assert-token #\) stream)))

;279 redeclared_attribute = qualified_attribute [ RENAMED attribute_id ] .
(defparse1-p11 :redeclared_attribute ()
  (parse :qualified_attribute)
  (when (check-token 'renamed stream)
    (read-token stream)
    (add-type (read-token stream) *scope* :attribute)))

;280 referenced_attribute = simple_id | qualified_attribute .
(defparse1-p11 :referenced_attribute ()
  (case (peek-token stream)
    (self (parse :qualified_attribute))
    (t    (read-token stream))))

;281 reference_clause = 'reference' 'from' simple_id [ '(' resource_or_rename { ',' resource_or_rename } ')' ] ';' .
(defparse1-p11 :reference_clause ()
  (assert-token 'reference stream)
  (assert-token 'from stream)
  (read-token stream)
  (when (check-token #\( stream)
    (read-token stream)
    (parse :resource_or_rename)
    (loop while (check-token #\, stream) do 
	  (read-token stream)
	  (parse :resource_or_rename))
    (assert-token #\) stream))
  (assert-token #\; stream))

;282 rel_op = '<' | '>' | '<=' | '>=' | '<>' | '=' | ':<>:' | ':=:' .
(defparse1-p1114 :rel_op ()
  (when (member (peek-token stream) '(#\< #\> :less-equal :great-equal :less-great #\=
				      :colon-less-great-colon :colon-equal-colon))
    (read-token stream)))

;283 rel_op_extended = rel_op | 'in' | 'like' .
(defparse1-p1114 :rel_op_extended ()
  (or (parse :rel_op)
	 (when (member (peek-token stream) '(in like))
	   (read-token stream))))

;284 rename_id = constant_id | entity_id | function_id | procedure_id | type_id .
(defparse1-p11 :rename_id ()
  (read-token stream))

;285 repeat_control = [ increment_control ] [ while_control ] [ until_control ] .
(defparse1-p1114 :repeat_control ()
  (when (eql :colon-equal (peek-token stream 2))
    (parse :increment_control))
  (when (check-token 'while stream)
    (parse :while_control))
  (when (check-token 'until stream)
    (parse :until_control)))
	    
;286 repeat_stmt = 'repeat' repeat_control ';' stmt { stmt } 'end_repeat' ';' .
(defparse1-p1114 :repeat_stmt ()
  (assert-token 'repeat stream)
  (let ((*scope* (make-instance '|RepeatStatement| :%parent *scope*)))
    (add-type "ANONYMOUS-REPEAT" *scope* :variable)
    (parse :repeat_control)
    (assert-token #\; stream)
    (parse :stmt)
    (loop until (check-token 'end_repeat stream)
	  do (parse :stmt))
    (assert-token 'end_repeat stream)
    (assert-token #\; stream)))

;287 repetition = numeric_expression .
(defparse1-p1114 :repetition ()
  (parse :numeric_expression))

;288 resource_or_rename = simple_id [ 'as' simple_id ] .
(defparse1-p1114 :resource_or_rename ()
  (read-token stream)
  (when (check-token 'as stream)
    (read-token stream)
    (read-token stream)))

;289 resource_ref = constant_ref | entity_ref | function_ref | procedure_ref | type_ref .
(defparse1-p11 :resource_ref ()
  (read-token stream))

;290 return_stmt = 'return' [ '(' expression ')' ] ';' .
(defparse1-p1114 :return_stmt ()
  (assert-token 'return stream)
  (when (check-token #\( stream)
    (read-token stream)
    (parse :expression)
    (assert-token #\) stream))
  (assert-token #\; stream))

;291 rule_decl = rule_head [ algorithm_head ] { stmt } where_clause 'end_rule' ';' .
(defparse1-p1114 :rule_decl ()
  (let* ((*scope* (make-instance '|GlobalRule| :%parent *scope*)))
    (parse :rule_head)
    (parse :algorithm_head)
    (loop until (check-token 'where stream)
	  do (parse :stmt))
    (parse :where_clause)
    (assert-token 'end_rule stream)
    (assert-token #\; stream)))

;292 rule_head = 'rule' simple_id 'for' '(' simple_id { ',' simple_id } ')' ';' .
(defparse1-p1114 :rule_head ()
  (assert-token 'rule stream)
  (let ((name (read-token stream)))
    (setf (%id *scope*) name)
    (add-type name (%%parent *scope*) :rule)
    (dbg-message :parser 1 "~&Rule ~A~%" name))
  (assert-token 'for stream)
  (assert-token #\( stream)
  (read-token stream)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(add-type (read-token stream) *scope* :parameter))
  (assert-token #\) stream)
  (assert-token #\; stream))

;293 rule_id = simple_id .
;294 rule_label_id = simple_id .

;295 schema_body = { interface_specification } [ constant_decl ] { declaration | rule_decl } .
(defparse1-p11 :schema_body ()
  (loop while (member (peek-token stream) '(reference use))
	do (parse :interface_specification))
  (when (check-token 'constant stream)
    (parse :constant_decl))
  (loop while (member (peek-token stream) '(entity function procedure subtype_constraint type rule))
	if (check-token 'rule stream)
	  do (parse :rule_decl)
	else do (parse :declaration)))


;296 schema_decl = 'schema' simple_id [ schema_version_id ] ';' schema_body 'end_schema' ';' .
(defparse1-p11 :schema_decl ()
  (assert-token 'schema stream)
  (let ((name (read-token stream)) vers)
    (setf *scope* (make-instance '|Schema| :name name))
    (unless (eql (peek-token stream) #\;)
      (setf vers (parse :schema_version_id)))
    (dbg-message :parser 0 "~&Schema ~A~@[ ~A~]~%" name vers))
  (assert-token #\; stream)
  (parse :schema_body)
  (assert-token 'end_schema stream)
  (assert-token #\; stream))

;297 schema_id = simple_id .

;298: schema_version_id = string_literal .
(defparse1-p11 :schema_version_id ()
  (read-token stream))

;299 selector = expression .
(defparse1-p1114 :selector ()
  (parse :expression))

; 300 select_extension = BASED_ON type_ref [ WITH select_list ] .
(defparse1-p11 :select_extension ()
  (assert-token 'based_on stream)
  (read-token stream)
  (when (check-token 'with stream)
    (read-token stream)
    (parse :select_list)))

; 301 select_list = '(' named_types { ',' named_types } ')' .
(defparse1-p11 :select_list ()
  (assert-token #\( stream)
  (loop until (check-token #\) stream)
	do (parse :named_types)
	when (check-token #\, stream) do (read-token stream))
    (read-token stream))

; 302 select_type = [ EXTENSIBLE [ GENERIC_ENTITY ] ] SELECT [ select_list | select_extension ]
(defparse1-p11 :select_type ()
  (when (check-token 'extensible stream)
    (read-token stream)
    (when (check-token 'generic_entity stream)
      (read-token stream)))
  (assert-token 'select stream)
  (if (check-token #\( stream)
	 (parse :select_list))
  (when (check-token 'based_on stream)
    (parse :select_extension)))

;303 set_type = 'set' [ bound_spec ] 'of' instantiable_type .
(defparse1-p1114 :set_type ()
  (assert-token 'set stream)
  (when (check-token #\[ stream)
    (parse :bound_spec))
  (assert-token 'of stream)
  (parse :instantiable_type))

;304 sign = '+' | '-' .
(defparse1-p11 :sign ()
  (when (member (peek-token stream) '(#\+ #\-))
    (read-token stream)))

;305 simple_expression = term { add_like_op term } .
(defparse1-p1114 :simple_expression ()
  (parse :term)
  (loop while (member (peek-token stream) '(#\+ #\- or xor)) do
	(parse :add_like_op)
	(parse :term)))

;306 simple_factor = aggregate_initializer | entity_constructor | enumeration_reference
;		   | interval | query_expression | ( [ unary_op ] ( '(' expression ')' | primary ) ) .
(defparse1-p11 :simple_factor ()
  (case (peek-token stream)
    (#\[   (parse :aggregate_initializer))
    (#\{   (parse :interval))
    (query (parse :query_expression))
    (#\(   (assert-token #\( stream)
	   (parse :expression)
	   (assert-token #\) stream))
    ((#\+ #\- not)
     (parse :unary_op)
     (if (check-token #\( stream)
	    (progn 
	      (read-token stream)
	      (parse :expression)
	      (assert-token #\) stream))
	    (parse :primary)))
    ((const_e pi self #\?
      abs acos asin atan blength cos exists exp format hibound hiindex length
      lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
      usedin value value_in value_unique
      ;; EE extension
      print)
     (parse :primary))
    (t
     (read-token stream)		;simple_id
     (when (check-token #\( stream)
       (read-token stream)
       ;; function_id [ '(' expression { ',' expression } ')' ]
       ;; entity_id '(' [ expression { ',' expression } ] ')'
       (unless (check-token #\) stream)
	 (parse :expression)
	 (loop while (check-token #\, stream) do
	       (read-token stream)
	       (parse :expression)))
       (assert-token #\) stream))

     ;; simple_id { ( ( '.' | '\' ) simple_id ) | ( '[' index [ ':' index ] ']' ) }
     (loop while (member (peek-token stream) '(#\. #\\ #\[))
	   do (case (peek-token stream)
		((#\. #\\)
		 (read-token stream)
		 (read-token stream))
		(#\[
		 (read-token stream)
		 (parse :index)
		 (when (check-token #\: stream)
		   (read-token stream)
		   (parse :index))
		 (assert-token #\] stream)))))))

;307 simple_types = binary_type | boolean_type | integer_type | logical_type
;		  | number_type | real_type | string_type .
(defparse1-p1114 :simple_types ()
  (case (peek-token stream)
    (binary  (parse :binary_type))
    (boolean (parse :boolean_type))
    (integer (parse :integer_type))
    (logical (parse :logical_type))
    (number  (parse :number_type))
    (real    (parse :real_type))
    (string  (parse :string_type))))

;308 skip_stmt = 'skip' ';' .
(defparse1-p1114 :skip_stmt ()
  (assert-token 'skip stream)
  (assert-token #\; stream))

;309 stmt = alias_stmt | assignment_stmt | case_stmt | compound_stmt | escape_stmt
;         | if_stmt | null_stmt | procedure_call_stmt | repeat_stmt | return_stmt
;         | skip_stmt .
(defparse1-p1114 :stmt ()
  (case (peek-token stream)
    (alias  (parse :alias_stmt))
    (case   (parse :case_stmt))
    (begin  (parse :compound_stmt))
    (escape (parse :escape_stmt))
    (if     (parse :if_stmt))
    (#\;    (parse :null_stmt))
    (repeat (parse :repeat_stmt))
    (return (parse :return_stmt))
    (skip   (parse :skip_stmt))
    ((insert remove) (parse :procedure_call_stmt))
    (t 
     ;; assignment_stmt = simple_id { qualifier } ':=' expression ';'
     ;; procedure_call_stmt = simple_id [ '(' expression { ',' expression } ')' ]
     (if (member (peek-token stream 2) '(#\. #\\ #\[ :colon-equal))
	    (parse :assignment_stmt)
	    (parse :procedure_call_stmt)))))

;310 string_literal = simple_string_literal | encoded_string_literal .
(defparse1-p1114 :string_literal ()
  (read-token stream))

;311 string_type = 'string' [ width_spec ] .
(defparse1-p1114 :string_type ()
  (assert-token 'string stream)
  (when (check-token #\( stream)
    (parse :width_spec)))

;312 subsuper = [ supertype_constraint ] [ subtype_declaration ] .
(defparse1-p1114 :subsuper ()
  (when (member (peek-token stream) '(abstract supertype))
    (parse :supertype_constraint))
  (when (check-token 'subtype stream)
    (parse :subtype_declaration)))

;313 subtype_constraint = 'of' '(' supertype_expression ')' .
(defparse1-p1114 :subtype_constraint ()
  (assert-token 'of stream)
  (assert-token #\( stream)
  (parse :supertype_expression)
  (assert-token #\) stream))

;314 subtype_constraint_body = [ abstract_supertype ] [ total_over ] [ supertype_expression ';' ] .
(defparse1-p11 :subtype_constraint_body ()
    (when (check-token 'abstract stream) (parse :abstract_supertype))
    (when (check-token 'total_over stream) (parse :total_over))
    (let ((tkn (peek-token stream)))
      (unless (eql tkn 'end_subtype_constraint)
	(parse :supertype_expression)
	(assert-token #\; stream))))

;315 subtype_constraint_decl = subtype_constraint_head subtype_constraint_body END_SUBTYPE_CONSTRAINT ';' .
(defparse1-p11 :subtype_constraint_decl ()
;  (let ((*scope* ;; bind only for (parse :subtype_constraint_id)
;	 (make-instance '|SupertypeRule| :%parent *scope*)))
    (parse :subtype_constraint_head)
    (parse :subtype_constraint_body)
    (assert-token 'end_subtype_constraint stream)
    (assert-token #\; stream))

;;; These don't define scopes.
;316 subtype_constraint_head = SUBTYPE_CONSTRAINT subtype_constraint_id FOR entity_ref ';' .
(defparse1-p11 :subtype_constraint_head ()
  (assert-token 'subtype_constraint stream)
  (parse :subtype_constraint_id)
  (assert-token 'for stream)
  (read-token stream)
  (assert-token #\; stream))

;317 subtype_constraint_id = simple_id .
(defparse1-p11 :subtype_constraint_id ()
  (add-type (read-token stream) *scope* :subtype-constraint))

;318 subtype_declaration = 'subtype' 'of' '(' simple_id { ',' simple_id } ')' .
(defparse1-p1114 :subtype_declaration ()
  (assert-token 'subtype stream)
  (assert-token 'of stream)
  (assert-token #\( stream)
  (read-token stream)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(read-token stream))
  (assert-token #\) stream))

;;; e-2
;319 supertype_constraint = abstract_entity_declaration | abstract_supertype_declaration | supertype_rule .
(defparse1-p11 :supertype_constraint ()
  (case (peek-token stream)
    (abstract  
     (case (peek-token stream 2)
       (supertype (parse :abstract_supertype_declaration))
       (t (parse :abstract_entity_declaration))))
    (supertype (parse :supertype_rule))))

;320 supertype_expression = supertype_factor { 'andor' supertype_factor } .
(defparse1-p1114 :supertype_expression ()
  (parse :supertype_factor)
  (loop while (check-token 'andor stream) do
	(read-token stream)
	(parse :supertype_factor)))

;321 supertype_factor = supertype_term { 'and' supertype_term } .
(defparse1-p1114 :supertype_factor ()
  (parse :supertype_term)
  (loop while (check-token 'and stream) do
	(read-token stream)
	(parse :supertype_term)))

;322 supertype_rule = 'supertype' subtype_constraint .
(defparse1-p11 :supertype_rule ()
  (assert-token 'supertype stream)
  (parse :subtype_constraint)
  t)

;323 supertype_term = simple_id | one_of | '(' supertype_expression ')' .
(defparse1-p1114 :supertype_term ()
  (case (peek-token stream)
    (oneof (parse :one_of))
    (#\( (read-token stream)
	 (parse :supertype_expression)
	 (assert-token #\) stream))
    (t (read-token stream))))

;324 syntax = schema_decl { schema_decl } .
(defparse1-p11 :syntax ()
  (append (list (parse :schema_decl))
	  (loop while (check-token 'schema stream)
		collect (parse :schema_decl))))

;325 term = factor { multiplication_like_op factor } .
(defparse1-p1114 :term ()
  (parse :factor)
  (loop while (member (peek-token stream) '(#\* #\/ div mod and :vbar-vbar)) do
	(parse :multiplication_like_op)
	(parse :factor)))

; 326 total_over = TOTAL_OVER '(' entity_ref { ',' entity_ref } ')' ';' .
(defparse1-p11 :total_over ()
  (assert-token 'total_over stream)
  (assert-token #\( stream)
  (read-token stream)
  (loop until (check-token #\) stream)
	do (read-token stream)
	(assert-token #\, stream))
  (assert-token #\) stream)
  (assert-token #\; stream))

;327 type_decl = 'type' simple_id '=' underlying_type ';' [ where_clause ] 'end_type' ';' .
(defparse1-p11 :type_decl ()
  (assert-token 'type stream)
  (let ((name (read-token stream)))
    (when (search "upfrom" (string name) :test #'string-equal) (break "upfrom"))
    (add-type name *scope* :type)
    (dbg-message :parser 1 "~&Type ~A~%" name)
    (expo:expo-dot *expresso* :stream stream :char "T" :pass 1)
    (let ((*scope* (make-instance '|SpecializedType| :%parent *scope*)))
      (add-type 'p11u::self *scope* :constant)
      (setf (%id *scope*) (make-scoped-id name))
      (assert-token #\= stream)
      (parse :underlying_type)
      (assert-token #\; stream)
      (when (check-token 'where stream)
	(parse :where_clause))
      (assert-token 'end_type stream)
      (assert-token #\; stream)
      t)))

;328 type_id = simple_id .

;329 type_label = type_label_id | type_label_ref .

;330 type_label_id = simple_id .

;331 unary_op = '+' | '-' | 'not' .
(defparse1-p1114 :unary_op ()
  (if (member (peek-token stream) '(#\+ #\- not))
      (read-token stream)
      (error 'parse-token-error 
	     :tag (car *tags-trace*) :expected '("+" "-" "not") 
	     :actual (peek-token stream))))

;332 underlying_type = concrete_types | constructed_types .
(defparse1-p11 :underlying_type ()
  (case (peek-token stream)
    ((extensible enumeration select) (parse :constructed_types))
    ((array bag list set) (parse :concrete_types))
    ((binary boolean integer logical number real string) (parse :simple_types))
    (t (read-token stream))))

;333 unique_clause = 'unique' unique_rule ';' { unique_rule ';' } .
(defparse1-p11 :unique_clause ()
  (assert-token 'unique stream)
  (parse :unique_rule)
  (assert-token #\; stream)
  (loop until (member (peek-token stream) '(where end_entity))
	do (parse :unique_rule)
	   (assert-token #\; stream)))

 ;334 unique_rule = [ simple_id ':' ] referenced_attribute { ',' referenced_attribute } .
(defparse1-p11 :unique_rule ()
  (when (eq #\: (peek-token stream 2))
    (add-type (read-token stream) *scope* :rule-label)
    (read-token stream))
  (parse :referenced_attribute)
  (loop while (check-token #\, stream) do
	(read-token stream)
	(parse :referenced_attribute)))

;335 until_control = 'until' logical_expression .
(defparse1-p1114 :until_control ()
  (assert-token 'until stream)
  (parse :logical_expression))

;336 use_clause = 'use' 'from' simple_id [ '(' named_type_or_rename { ',' named_type_or_rename } ')' ] ';' .
(defparse1-p11 :use_clause ()
  (assert-token 'use stream)
  (assert-token 'from stream)
  (read-token stream)
  (when (check-token #\( stream)
    (read-token stream)
    (parse :named_type_or_rename)
    (loop while (check-token #\, stream) do
	  (read-token stream)
	  (parse :named_type_or_rename))
    (assert-token #\) stream))
  (assert-token #\; stream))

;337 variable_id = simple_id .

;338 where_clause = 'where' domain_rule ';' { domain_rule ';' } .
(defparse1-p1114 :where_clause ()
  (assert-token 'where stream)
  (parse :domain_rule)
  (assert-token #\; stream)
  (loop until (member (peek-token stream) '(end_entity end_rule end_type select)) ; p14-widened (select)
	do (parse :domain_rule)
	   (assert-token #\; stream)))

;339 while_control = 'while' logical_expression .
(defparse1-p1114 :while_control ()
  (assert-token 'while stream)
  (parse :logical_expression))

;340 width = numeric_expression .
(defparse1-p1114 :width ()
  (parse :numeric_expression))

;341 width_spec = '(' width ')' [ 'fixed' ] .
(defparse1-p11 :width_spec ()
  (assert-token #\( stream)
  (parse :width)   
  (assert-token #\) stream)
  (when (check-token 'fixed stream) (read-token stream)))
