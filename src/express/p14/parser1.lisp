(in-package :P14P)

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

(defclass p14-stream (expo:p1114-stream)
  ())

(defun make-p14-stream (stream)
  (make-instance 'p14-stream :stream stream))

;;;======================================================================
;;; Parsing...
;;;======================================================================
(defmethod parse1-data ((path pathname) (tag (eql :p14-file)) &key)
  (with-open-file (char-stream path :direction :input)
    (with-open-stream (stream (setf expo:*token-stream* (make-p14-stream char-stream)))
      (parse1-data stream :stream))))

(defmacro defparse1-p14 (tag (&rest keys) &body body)
  `(defmethod parse1-data ((stream p14-stream) (tag (eql ,tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys) 
		       `(parse1-data stream ,tag ,@keys)))
       ,@body)))

;; The top-level grammar rule:
(defparse1-p14 :stream ()
  (init-bcounters)
  (setf expo:*tags-trace* nil)
  (parse :syntax_x))

;;; digit = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' .
;;; letter = 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'
;;;        | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' .
;;; simple_id = letter { letter | digit | '_' } .

;; from iso-10303-14 N178

;; pass 1 grammar

; 30 abstract_supertype_declaration = 'abstract' 'supertype' [ subtype_constraint ] . p1114
; 31 actual_parameter_list = '(' parameter { ',' parameter } ')' . p1114
; 32 add_like_op = '+' | '-' | 'or' | 'xor' . p1114
; 33 aggregate_initializer = '[' [ element { ',' element } ] ']' . p1114
; 34 aggregate_source = simple_expression . p1114
; 35 aggregate_type = 'aggregate' [ ':' simple_id ] 'of' parameter_type . p1114
; 36 aggregation_types = array_type | bag_type | list_type | set_type . p1114
; 37 algorithm_head = { declaration } [ constant_decl ] [ local_decl ] . p1114
; 38 array_type = 'array' bound_spec 'of' [ 'optional' ] [ 'unique' ] base_type . p1114
; 39 assignment_stmt = simple_id { qualifier } ':=' expression ';' . p1114

; 40 backward_path_qualifier = '<-' [ simple_id ] path_condition .
(defparse1-p14 :backward_path_qualifier ()
  (assert-token :less-dash stream)
  (unless (check-token #\{ stream)
    (read-token stream))
  (parse :path_condition))

; 41 bag_type = 'bag' [ bound_spec ] 'of' base_type . p1114

; 42 base_type = aggregation_types | simple_types | named_types .
(defparse1-p14 :base_type ()
  (cl:case (peek-token stream)
    ((array bag list set) (parse :aggregation_types))
    ((binary boolean integer logical number real string) (parse :simple_types))
    (t (parse :named_types))))

; 43 binary_type = 'binary' [ width_spec ] . p1114

; 44 binding_header = [ 'partition' simple_id ';' ] [ from_clause ] [ local_decl ] [ where_clause ]
;    [ identified_by_clause ] [ ordered_by_clause ] .
(defparse1-p14 :binding_header ()
  (when (check-token 'partition stream)
    (read-token stream)
    (add-type (cl:string (read-token stream)) *scope* :partition)
    (assert-token #\; stream))
  (when (check-token 'from stream)
    (parse :from_clause))
  (when (check-token 'local stream)
    (parse :local_decl))
  (when (check-token 'where stream)
    (parse :where_clause))
  (when (check-token 'identified_by stream)
    (parse :identified_by_clause))
  (when (check-token 'ordered_by stream)
    (parse :ordered_by_clause))
  t)

; 45 boolean_type = 'boolean' . p1114
; 46 bound_1 = numeric_expression . p1114
; 47 bound_2 = numeric_expression . p1114
; 48 bound_spec = '[' bound_1 ':' bound_2 ']' . p1114
; 49 built_in_constant = 'const_e' | 'pi' | 'self' | '?' . p1114
; 50 built_in_function = 'abs' | 'acos' | 'asin' | 'atan' | 'blength' | 'cos' | 'exists' | 'extent'
;    | 'exp' | 'format' | 'hibound' | 'hiindex' | 'length' | 'lobound' | 'loindex' | 'log' | 'log2'
;    | 'log10' | 'nvl' | 'odd' | 'rolesof' | 'sin' | 'sizeof' | 'sqrt' | 'tan' | 'typeof' | 'usedin'
;    | 'value' | 'value_in' | 'value_unique' . p1114
; 51 built_in_procedure = 'insert' | 'remove' . p1114
; 52 case_action = case_label { ',' case_label } ':' stmt . p1114

; 53 case_expr = 'case' selector 'of' { case_expr_action } [ 'otherwise' ':' expression ] 'end_case' .
(defparse1-p14 :case_expr ()
  (assert-token 'case stream)
  (parse :selector)
  (assert-token 'of stream)
  (loop until (member (peek-token stream) '(otherwise end_case))
	do (parse :case_expr_action))
  (when (check-token 'otherwise stream)
    (assert-token #\: stream)
    (parse :expression))
  (assert-token 'end_case stream)
  t)

; 54 case_expr_action = case_label { ',' case_label } ':' expression ';' .
(defparse1-p14 :case_expr_action ()
  (parse :case_label)
  (loop while (check-token #\, stream)
	do (parse :case_label))
  (assert-token #\: stream)
  (parse :expression)
  (assert-token #\; stream)
  t)

; 55 case_label = expression . p1114
; 56 case_stmt = 'case' selector 'of' { case_action } [ 'otherwise' ':' stmt ] 'end_case' ';' . p1114
; 57 compound_stmt = 'begin' stmt { stmt } 'end' ';' . p1114

; 58 constant_body = simple_id ':' base_type ':=' expression ';' .
(defparse1-p14 :constant_body ()
  (let ((name (read-token stream)))
    (add-type (cl:string name) *scope* :constant)
    (assert-token #\: stream)
    (parse :base_type)
    (assert-token :colon-equal stream)
    (parse :expression)
    (assert-token #\; stream))
  t)

; 59 constant_decl = 'constant' constant_body { constant_body } 'end_constant' ';' . p1114
; 60 constant_factor = built_in_constant | simple_id . p1114

; 62 declaration = function_decl | procedure_decl .
(defparse1-p14 :declaration ()
  (cl:case (peek-token stream)
    (function  (parse :function_decl))
    (procedure (parse :procedure_decl))))

; 63 dependent_map_decl = 'dependent_map' simple_id 'as' target_parameter ';' { target_parameter ';' }
;    [ map_subtype_of_clause ] dep_map_partition { dep_map_partition } 'end_dependent_map' ';' .
(defparse1-p14 :dependent_map_decl ()
  (assert-token 'dependent_map stream)
  (let ((name (read-token stream)))
    (add-type (cl:string name) *scope* :map)
    (let ((*scope* (make-instance '|MapSpec| :%parent *scope*)))
      (setf (%id *scope*) (make-scoped-id name))
      (setf (%dependent-p *scope*) t)
      (expo:expo-dot *expresso* :stream stream :char "M" :pass 1)
      (dbg-message :parser  1  "~&Dependent_Map ~A~%" name)
      (assert-token 'as stream)
      (parse :target_parameter)
      (assert-token #\; stream)
      (loop until (member (peek-token stream) '(subtype partition from end_dependent_map))
	    do (parse :target_parameter)
	    (assert-token #\; stream))
      (when (check-token 'subtype stream)
	(parse :map_subtype_of_clause))
      (parse :dep_map_partition)
      (loop until (check-token 'end_dependent_map stream)
	    do (parse :dep_map_partition))
      (read-token stream)
      (assert-token #\; stream))
    t))

; 64 dep_binding_decl = dep_from_clause [ local_decl ] [ where_clause ] [ ordered_by_clause ] .
(defparse1-p14 :dep_binding_decl ()
  (parse :dep_from_clause)
  (when (check-token 'local stream)
    (parse :local_decl))
  (when (check-token 'where stream)
    (parse :where_clause))
  (when (check-token 'ordered_by stream)
    (parse :ordered_by_clause)))

; 65 dep_from_clause = FROM dep_source_parameter ';' { dep_source_parameter ';' } .
(defparse1-p14 :dep_from_clause ()
  (assert-token 'from stream)
  (parse :dep_source_parameter)
  (assert-token #\; stream)
  (loop until (member (peek-token stream) '(local where ordered_by select))
	do (parse :dep_source_parameter)
	   (assert-token #\; stream)))

; 66 dep_map_decl_body = dep_binding_decl map_project_clause .
(defparse1-p14 :dep_map_decl_body ()
  (parse :dep_binding_decl)
  (parse :map_project_clause))

; 67 dep_map_partition = [ 'partition' simple_id ':' ] dep_map_decl_body .
(defparse1-p14 :dep_map_partition ()
  (when (check-token 'partition stream)
    (read-token stream)
    (assert-token #\: stream))
  (parse :dep_map_decl_body))

; 68 dep_source_parameter = simple_id { ',' simple_id } ':' ( simple_types | type_reference ) .
(defparse1-p14 :dep_source_parameter ()
  (let ((tkn (read-token stream)))
    (add-type tkn *scope* :source-parameter)
    (with-instance (|SourceParameter|)
       (setf |id| (make-scoped-id tkn))
       (push *def* (%variables *scope*))))
  (assert-token #\: stream)
  (cl:if (member (peek-token stream) '(binary boolean integer logical number real string))
	 (parse :simple_types)
	 (parse :type_reference)))

; 69 domain_rule = [ simple_id ':' ] logical_expression . p1114
; 70 element = expression [ ':' repetition ] . p1114
; 71 entity_constructor = entity_reference '(' [ expression { ',' expression } ] ')' . p1114

; 73 entity_instantiation_loop = 'for' instantiation_loop_control ';' map_project_clause .
(defparse1-p14 :entity_instantiation_loop ()
  (assert-token 'for stream)
  (parse :instantiation_loop_control)
  (assert-token #\; stream)
  (parse :map_project-clause))

; 74 entity_reference = [ simple_id '.' ] simple_id .
(defparse1-p14 :entity_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)
    (read-token stream)))

#|
(defparse1-p14 :entity_reference ()
  (let (entity)
    (setf entity (read-token stream))
    (when (check-token #\. stream)
      (read-token stream)
      (setf entity (read-token stream))))
    (add-type (cl:string entity) *scope* :entity))
|#

; 75 enumeration_reference = [ type_reference '.' ] simple_id .
;; may yeild a pattern of [ [ simple_id '.' ] simple_id '.' ] simple_id
(defparse1-p14 :enumeration_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)
    (when (check-token #\. stream)
      (read-token stream)))
  t)

; 76 escape_stmt = 'escape' ';' . p1114
; 77 expression = simple_expression [ rel_op_extended simple_expression ] . p1114

; 78 expression_or_wild = expression | '_' .
(defparse1-p14 :expression_or_wild ()
  (cl:if (check-token #\_ stream)
	 (read-token stream)
	 (parse :expression)))

; 79 extent_reference = source_entity_reference | view_reference .
;; both resolve to [ simple_id '.' ] simple_id
(defparse1-p14 :extent_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)
    (read-token stream)))

#| pod 1007
(defparse1-p14 :extent_reference ()
  (let (entity)
    (setf entity (read-token stream))
    (when (check-token #\. stream)
      (read-token stream)
      (setf entity (read-token stream)))
    (add-type (cl:string entity) *scope* :entity)))|#

; 80 factor = simple_factor [ '**' simple_factor ] . p1114

;;; POD Ought foreach expr to be a scope? Yes.
; 81 foreach_expr = 'each' simple_id 'in' expression [ where_clause ] 'return' expression .
(defparse1-p14 :foreach_expr ()
  (assert-token 'each stream)
  (let ((*scope* (make-instance '|ForEachExpression| :%parent *scope*)))
    (add-type (read-token stream) *scope* :variable)
    (assert-token 'in stream)
    (parse :expression)
    (when (check-token 'where stream)
      (parse :where_clause))
    (assert-token 'return stream)
    (parse :expression)))

; 82 forloop_expr = repeat_control 'return' expression .
(defparse1-p14 :forloop_expr ()
  (parse :repeat_control)
  (assert-token 'return stream)
  (parse :expression))

; 83 formal_parameter = simple_id { ',' simple_id } ':' parameter_type . p1114

; 84 forward_path_qualifier = '::' simple_id [ path_condition ] .
(defparse1-p14 :forward_path_qualifier ()
  (assert-token :colon-colon stream)
  (read-token stream)
  (when (check-token #\{ stream)
    (parse :path_condition))
  t)

; 85 for_expr = 'for' ( foreach_expr | forloop_expr ) .
(defparse1-p14 :for_expr ()
  (assert-token 'for stream)
  (cl:case (peek-token stream)
    (each (parse :foreach_expr))
    (t (parse :forloop_expr)))
  t)

; 86 from_clause = 'from' source_parameter ';' { source_parameter ';' } .
(defparse1-p14 :from_clause ()
  (assert-token 'from stream)
  (parse :source_parameter)
  (assert-token #\; stream)
  (loop until (member (peek-token stream) '(local where identified_by ordered_by for
					    select return end_map end_view))
	do (parse :source_parameter)
	   (assert-token #\; stream))
  t)

; 87 function_call = ( built_in_function | simple_id ) [ actual_parameter_list ] . p1114

; 88 function_decl = function_head algorithm_head stmt { stmt } 'end_function' ';' . p1114
; 89 function_head = 'function' simple_id [ '(' formal_parameter { ';' formal_parameter } ')' ] 
;    ':' parameter_type ';' . p1114
; 91 generalized_types = aggregate_type | general_aggregation_types | generic_type . p1114
; 92 general_aggregation_types = general_array_type | general_bag_type | general_list_type | general_set_type . p1114
; 93 general_array_type = 'array' [ bound_spec ] 'of' [ 'optional' ] [ 'unique' ] parameter_type . p1114

; 94 general_attribute_qualifier = '.' simple_id .
(defparse1-p14 :general_attribute_qualifier ()
  (assert-token #\. stream)
  (read-token stream))

; 95 general_bag_type = 'bag' [ bound_spec ] 'of' parameter_type . p1114
; 96 general_list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] parameter_type . p1114

; 97 general_or_map_call = simple_id [ '@' map_call ] .
(defparse1-p14 :general_or_map_call ()
  (read-token stream)
  (when (check-token #\@ stream)
    (parse :map_call))
  t)

;101 general_set_type = 'set' [ bound_spec ] 'of' parameter_type . p1114

;102 generic_type = 'generic' [ ':' simple_id ] .  p1114
;103 group_qualifier = '\' simple_id . p1114

;104 identified_by_clause = 'identified_by' id_parameter ';' { id_parameter ';' } .
(defparse1-p14 :identified_by_clause ()
  (assert-token 'identified_by stream)
  (parse :id_parameter)
  (assert-token #\; stream)
  (loop until (member (peek-token stream) '(ordered_by for select return end_map end_view))
	do (parse :id_parameter)
	   (assert-token #\; stream))
  t)

;105 id_parameter = [ simple_id ':' ] expression .
(defparse1-p14 :id_parameter ()
    (when (eql #\: (peek-token stream 2))
      (read-token stream) 
      (read-token stream))
    (parse :expression))

;107 if_expr = 'if' logical_expression 'then' expression { 'elsif' logical_expression expression }
;    [ 'else' expression ] 'end_if' .
(defparse1-p14 :if_expr ()
  (assert-token 'if stream)
  (parse :logical_expression)
  (assert-token 'then stream)
  (parse :expression)
  (loop while (check-token 'elsif stream)
	do (parse :logical_expression)
	   (parse :expression))
  (when (check-token 'else stream)
    (parse :expression))
  (assert-token 'end_if stream)
  t)

;108 if_stmt = 'if' logical_expression 'then' stmt { stmt } [ 'else' stmt { stmt } ] 'end_if' ';' . p1114
;109 increment = numeric_expression . p1114
;110 increment_control = simple_id ':=' bound_1 'to' bound_2 [ 'by' increment ] . p1114
;111 index = numeric_expression . p1114
;112 index_1 = index . p1114
;113 index_2 = index . p1114
;114 index_qualifier = '[' index_1 [ ':' index_2 ] ']' . p1114

;115 instantiation_foreach_control = 'each' simple_id 'in' source_attribute_reference 'indexing' simple_id .
(defparse1-p14 :instantiation_foreach_control ()
  (assert-token 'each stream)
  (read-token stream)
  (assert-token 'in stream)
  (parse :source_attribute_reference)
  (assert-token 'indexing stream)
  (read-token stream))

;116 instantiation_loop_control = instantiation_foreach_control | repeat_control .
(defparse1-p14 :instantiation_loop_control ()
  (cl:case (peek-token stream)
    (each (parse :instantiation_foreach_control))
    (t (parse :repeat_control))))

;117 integer_type = 'integer' . p1114
;118 interval = '{' interval_low interval_op interval_item interval_op interval_high '}' . p1114
;119 interval_high = simple_expression . p1114
;120 interval_item = simple_expression . p1114
;121 interval_low = simple_expression . p1114
;122 interval_op = '<' | '<=' . p1114
;124 list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] base_type . p1114
;125 literal = binary_literal | integer_literal | logical_literal | real_literal | string_literal . p1114
;126 local_decl = 'local' local_variable { local_variable } 'end_local' ';' . p1114
;127 local_variable = simple_id { ',' simple_id } ':' parameter_type [ ':=' expression ] ';' . p1114
;128 logical_expression = expression . p1114
;129 logical_literal = 'false' | 'true' | 'unknown' . p1114
;130 logical_type = 'logical' . p1114
(defparse1-p14 :logical_type ()
  (assert-token 'logical stream)
  t)

;131 map_attribute_declaration = [ simple_id [ index_qualifier ] [ group_qualifier ] '.' ]
;    simple_id [ index_qualifier ] ':=' expression ';' .
(defparse1-p14 :map_attribute_declaration ()
  (read-token stream)
  (when (check-token #\[ stream)
    (parse :index_qualifier))
  (when (member (peek-token stream) '(#\\ #\.))
    (when (check-token #\\ stream)
      (parse :group_qualifier))
    (assert-token #\. stream)
    (read-token stream)
    (when (check-token #\[ stream)
      (parse :index_qualifier)))
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream)
  t)

;132 map_call = simple_id [ partition_qualification ] '(' expression_or_wild { ',' expression_or_wild } ')' .
(defparse1-p14 :map_call ()
  (read-token stream)
  (when (check-token #\\ stream)
    (parse :partition_qualification))
  (assert-token #\( stream)
  (parse :expression_or_wild)
  (loop while (check-token #\, stream)
	do (read-token stream)
	(parse :expression_or_wild))
  (assert-token #\) stream)
  t)

;133 map_decl = 'map' simple_id 'as' target_parameter ';' { target_parameter ';' }
;    map_sub_partition | ( map_partition { map_partition } ) 'end_map' ';' .
(defparse1-p14 :map_decl ()
  (assert-token 'map stream)
  (let ((name (read-token stream)))
    (add-type (cl:string name) *scope* :map)
    (let ((*scope* (make-instance '|MapSpec| :%parent *scope*)))
      (setf (%id *scope*) (make-scoped-id name))
      (dbg-message :parser  1  "~&Map ~A~%" name)
      (expo:expo-dot *expresso* :stream stream :char "M" :pass 1)
      (assert-token 'as stream)
      (parse :target_parameter)
      (assert-token #\; stream)
      (loop until (member (peek-token stream) '(subtype partition from local where identified_by for ordered_by))
	    do (parse :target_parameter)
	    (assert-token #\; stream))
      (cl:if (check-token 'subtype stream)
	     (parse :map_sub_partition)
	     (loop initially (parse :map_partition)
		   until (member (peek-token stream) '(end_map))
		   do (parse :map_partition)))
      (assert-token 'end_map stream)
      (assert-token #\; stream))))

; map_sub_partition = map_subtype_of_clause subtype_binding_header map_decl_body .
(defparse1-p14 :map_sub_partition ()
  (parse :map_subtype_of_clause)
  (parse :subtype_binding_header)
  (parse :map_decl_body))

; map_partition = binding_header map_decl_body .
(defparse1-p14 :map_partition ()
  (parse :binding_header)
  (parse :map_decl_body))

;134 map_decl_body = ( entity_instantiation_loop { entity_instantiation_loop } ) | map_project_clause
;    | ( 'return' expression ';' ) .
(defparse1-p14 :map_decl_body ()
  (cl:case (peek-token stream)
    (select (parse :map_project_clause))
    (return (read-token stream)
	    (parse :expression)
	    (assert-token #\; stream))
    (t (parse :entity_instantiation_loop)
       (loop until (member (peek-token stream) '(partition for end_map))
	     do (parse :entity_instantiation_loop)))))


; map_local_assignment = variable_ref { ( '.' attribute_ref ) | group_qualifier | index_qualifier } ':=' expression ';'.
(defparse1-p14 :map_local_assignment ()
  (read-token stream)
  (loop for tkn = (peek-token stream)
	while (member tkn '(#\. #\\ #\[))
	do (ecase tkn
	     (#\. (read-token stream)	;eat '.'
		  (read-token stream))	;eat attribute_ref
	     (#\\ (parse :group_qualifier))
	     (#\[ (parse :index_qualifier))))
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream))

;136 map_project_clause = 'select' map_select_item { map_select_item } .
(defparse1-p14 :map_project_clause ()
  (assert-token 'select stream)
  (loop initially (parse :map_select_item)
	until (member (peek-token stream) '(partition for end_dependent_map end_map))
	do (parse :map_select_item)))

;138 map_reference = [ simple_id '.' ] simple_id .
(defparse1-p14 :map_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)))

; map_select_item = map_attribute_declaration | map_local_assignment .
; for pass1 both of these are the same. 2007 NO! but use map_attribute
(defparse1-p14 :map_select_item ()
  (parse :map_attribute_declaration))

;139 map_subtype_of_clause = 'subtype' 'of' '(' map_reference ')' ';' .
(defparse1-p14 :map_subtype_of_clause ()
  (assert-token 'subtype stream)
  (assert-token 'of stream)
  (assert-token #\( stream)
  (parse :map_reference)
  (assert-token #\) stream)
  (assert-token #\; stream))

;140 multiplication_like_op = '*' | '/' | 'div' | 'mod' | 'and' | '||' . p1114

;141 named_types = entity_reference | type_reference | view_reference .
;; all resolve to [ simple_id '.' ] simple_id
(defparse1-p14 :named_types ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)))

;142 null_stmt = ';' . p1114
;143 number_type = 'number' . p1114
;144 numeric_expression = simple_expression . p1114

;145 one_of = 'oneof' '(' supertype_expression { ',' supertype_expression } ')' . p1114

;146 ordered_by_clause = 'ordered_by' expression { ',' expression } ';' .
(defparse1-p14 :ordered_by_clause ()
  (assert-token 'ordered_by stream)
  (parse :expression)
  (loop while (check-token #\, stream)
	do (parse :expression))
  (assert-token #\; stream))

;147 parameter = expression . p1114

;149 parameter_type = generalized_types | named_types | simple_types .
;266 parameter_type = generalized_types | simple_id | simple_types .
(defparse1-p14 :parameter_type ()
  (cl:case (peek-token stream)
    ((aggregate array bag list set generic generic_entity) (parse :generalized_types))
    ((binary boolean integer logical number real string) (parse :simple_types))
    (t (read-token stream)
     (when (eql #\. (peek-token stream)) ; schema '.' named_tpe
      (read-token stream) (read-token stream)))))

;151 partition_qualification = '\' simple_id .
(defparse1-p14 :partition_qualification ()
  (assert-token #\\ stream)
  (read-token stream))

;152 path_condition = '{' extent_reference [ '|' logical_expression ] '}' .
(defparse1-p14 :path_condition ()
  (assert-token #\{ stream)
  (parse :extent_reference)
  (when (check-token #\| stream)
    (parse :logical_expression))
  (assert-token #\} stream))

;153 path_qualifier = forward_path_qualifier | backward_path_qualifier .
(defparse1-p14 :path_qualifier ()
  (ecase (peek-token stream)
    (:colon-colon (parse :forward_path_qualifier))
    (:less-dash (parse :backward_path_qualifier))))

;154 population = entity_reference . p1114
;155 precision_spec = numeric_expression . p1114
;156 primary = literal | ( qualifiable_factor { qualifier } ) .
;157 procedure_call_stmt = ( built_in_procedure | simple_id ) [ actual_parameter_list ] ';' . p1114
;158 procedure_decl = procedure_head algorithm_head { stmt } 'end_procedure' ';' . p1114
;159 procedure_head = 'procedure' simple_id [ '(' [ 'var' ] formal_parameter { ';' [ 'var' ] formal_parameter } ')' ] ';' . p1114

;161 qualifiable_factor = constant_factor | function_call | general_or_map_call
;    | population | simple_id | view_call .
(defparse1-p14 :qualifiable_factor ()
  (cl:case (peek-token stream)
    ((const_e pi self #\?) (parse :constant_factor))
    ((abs acos asin atan blength cos exists extent exp format hibound hiindex length
      lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
      usedin value value_in value_unique)
     (parse :function_call))
    ;;function_call       -- simple_id [ '(' expr { ',' expr } ') ]
    ;;general_or_map_call -- simple_id [ '@' map_call ]
    ;;population          -- simple_id [ '.' simple_id ]
    ;;view_call           -- simple_id [ '.' simple_id ] [ '\' simple_id ] '(' [ expr_or_wild { ',' expr_or_wild } ] ')'
    (t (read-token stream)
       (cl:case (peek-token stream)
	 (#\( (read-token stream)	;eat '('
	      (parse :expression_or_wild)
	      (loop while (check-token #\, stream)
		    do (parse :expression_or_wild))
	      (assert-token #\) stream))
	 (#\@ (read-token stream)
	      (parse :map_call))
	 (#\. (read-token stream)	;eat '.'
	      (read-token stream)	;eat simple_id
	      (when (check-token #\\ stream)
		(read-token stream))	;eat simple_id
	      (when (check-token #\( stream)
		(unless (check-token #\) stream)
		  (parse :expression_or_wild)
		  (loop while (check-token #\, stream)
			do (parse :expression_or_wild)))
		(assert-token #\) stream)))
	 (#\\ (read-token stream)	;eat '\'
	      (read-token stream)	;eat simple_id
	      (assert-token #\( stream)
	      (unless (check-token #\) stream)
		(parse :expression_or_wild)
		(loop while (check-token #\, stream)
		      do (parse :expression_or_wild)))
	      (assert-token #\) stream))
	 ))))

;162 qualifier = general_attribute_qualifier | group_qualifier | index_qualifier | path_qualifier .
(defparse1-p14 :qualifier ()
  (cl:case (peek-token stream)
    (#\. (parse :general_attribute_qualifier))
    (#\\ (parse :group_qualifier))
    (#\[ (parse :index_qualifier))
    ((:less-dash :colon-colon) (parse :path_qualifier))))

;163 query_expression = 'query' '(' simple_id '<*' aggregate_source '|' logical_expression ')' . p1114
;164 real_type = 'real' [ '(' precision_spec ')' ] . p1114

;165 reference_clause = 'reference' 'from' schema_ref_or_rename
;    [ '(' resource_or_rename { ',' resource_or_rename } ')' ] [ 'as' ( 'source' | 'target' ) ] ';' .
(defparse1-p14 :reference_clause ()
  (assert-token 'reference stream)
  (assert-token 'from stream)
  (parse :schema_ref_or_rename)
  (when (check-token #\( stream)
    (read-token stream) ; don't do p11 :resource_or_rename, handle AS here.
    (loop while (check-token #\, stream)
	  do (read-token stream))
    (assert-token #\) stream))
  (when (check-token 'as stream)
    (assert-token 'as stream)
    (let ((tkn (read-token stream)))
      (unless (member tkn '(source target))
	(expo:expo-parse-error :text "Expected either 'source' or 'target', got '~S'" tkn))))
  (assert-token #\; stream))

;166 rel_op = '<' | '>' | '<=' | '>=' | '<>' | '=' | ':<>:' | ':=:' . p1114
;167 rel_op_extended = rel_op | 'in' | 'like' . p1114
;169 repeat_control = [ increment_control ] [ while_control ] [ until_control ] . p1114
;170 repeat_stmt = 'repeat' repeat_control ';' stmt { stmt } 'end_repeat' ';' . p1114
;171 repetition = numeric_expression . p1114
;172 resource_or_rename = simple_id [ 'as' simple_id ] . p1114
;174 return_stmt = 'return' [ '(' expression ')' ] ';' . p1114
;175 rule_decl = rule_head algorithm_head { stmt } where_clause 'end_rule' ';' . p1114
;176 rule_head = 'rule' simple_id 'for' '(' simple_id { ',' simple_id } ')' ';' . p1114

;179 schema_map_body_element = function_decl | procedure_decl | view_decl | map_decl
;    | dependent_map_decl | rule_decl .
(defparse1-p14 :schema_map_body_element ()
  (ecase (peek-token stream)
    (function (parse :function_decl))
    (procedure (parse :procedure_decl))
    (view (parse :view_decl))
    (map (parse :map_decl))
    (dependent_map (parse :dependent_map_decl))
    (rule (parse :rule_decl))))

;180 schema_map_body_element_list = schema_map_body_element { schema_map_body_element } .
(defparse1-p14 :schema_map_body_element_list ()
  (parse :schema_map_body_element)
  (loop until (check-token 'end_schema_map stream)
	do (parse :schema_map_body_element)))

;181 schema_map_decl = 'schema_map' simple_id ';' reference_clause { reference_clause }
;    [ constant_decl ] schema_map_body_element_list 'end_schema_map' ';' .
(defparse1-p14 :schema_map_decl ()
  (assert-token 'schema_map stream)
  (let ((name (read-token stream)))
    (setf *scope* (make-instance '|MappingSchema| :name name))
    (add-type (cl:string name) *scope* :schema-map)
    (dbg-message :parser 1  "~&Schema_Map ~A~%" name)
    (assert-token #\; stream)
    (parse :reference_clause)
    (loop while (check-token 'reference stream)
	  do (parse :reference_clause))
    (when (check-token 'constant stream)
      (parse :constant_decl))
    (parse :schema_map_body_element_list)
    (assert-token 'end_schema_map stream)
    (assert-token #\; stream)))

;183 schema_ref_or_rename = [ simple_id ':' ] simple_id .
(defparse1-p14 :schema_ref_or_rename ()
  (let ((id  (read-token stream)))
    (cl:if (check-token #\: stream)
	   (progn 
	     (add-type (cl:string id) *scope* :schema-alias)
	     (read-token stream)
	     (add-type (cl:string (read-token stream)) *scope* :schema-ref))
	   (add-type (cl:string (read-token stream)) *scope* :schema-ref))))

;184 schema_view_body_element = function_decl | procedure_decl | view_decl | rule_decl .
(defparse1-p14 :schema_view_body_element ()
  (ecase (peek-token stream)
    (function (parse :function_decl))
    (procedure (parse :procedure_decl))
    (view (parse :view_decl))
    (rule (parse :rule_decl))))

;185 schema_view_body_element_list = schema_view_body_element { schema_view_body_element } .
(defparse1-p14 :schema_view_body_element_list ()
  (parse :schema_view_body_element)
  (loop until (check-token 'end_schema_view stream)
	do (parse :schema_view_body_element)))

;186 schema_view_decl = 'schema_view' simple_id ';' { reference_clause } [ constant_decl ]
;    schema_view_body_element_list 'end_schema_view' ';' .
(defparse1-p14 :schema_view_decl ()
  (assert-token 'schema_view stream)
  (let ((name (read-token stream)))
    (add-type (cl:string name) *scope* :schema-view)
    (dbg-message :parser  0  "~&Schema_View ~A~%" name)
    (assert-token #\; stream)
    (loop while (check-token 'reference stream)
	  do (parse :reference_clause))
    (when (check-token 'constant stream)
      (parse :constant_decl))
    (parse :schema_view_body_element_list)
    (assert-token 'end_schema_view stream)
    (assert-token #\; stream)))

;188 selector = expression . p1114
;189 set_type = 'set' [ bound_spec ] 'of' base_type . p1114
;190 simple_expression = term { add_like_op term } . p1114

;191 simple_factor = aggregate_initializer | entity_constructor | enumeration_reference | interval
;    | query_expression | ( [ unary_op ] ( '(' expression ')' | primary ) ) | case_expr | for_expr
;    | if_expr .
(defparse1-p14 :simple_factor ()
  (cl:case (peek-token stream)
    (#\[   (parse :aggregate_initializer))
    (#\{   (parse :interval))
    (query (parse :query_expression))
    (case  (parse :case_expr))
    (for   (parse :for_expr))
    (if    (parse :if_expr))
    (#\(   (assert-token #\( stream)
	   (parse :expression)
	   (assert-token #\) stream))
    ((#\+ #\- not)
     (parse :unary_op)
     (cl:if (check-token #\( stream)
	    (prog1 (parse :expression)
		   (assert-token #\) stream))
	    (parse :primary)))
    ((const_e pi self #\?
      abs acos asin atan blength cos exists extent exp format hibound hiindex length
      lobound loindex log log2 log10 nvl odd rolesof sin sizeof sqrt tan typeof
      usedin value value_in value_unique)
     (parse :primary))
    ;; qualifier -- ( '.' simple_id ) | ( '\' simple_id ) | ( '[' ... ']' )

    ;; simple_id [ '(' [ expr_or_wild { ',' expr_or_wild } ] ')' ] { qualifier }
    ;; simple_id [ '@' map_call ] { qualifier }
    ;; simple_id [ '.' simple_id ] { qualifier }
    ;; simple_id [ '.' simple_id ] [ '\' simple_id ] '(' expr_or_wild { ',' expr_or_wild } ')' { qualifier }
    (t
     (read-token stream)		;simple_id or literal
     (loop while (member (peek-token stream) '(#\( #\[ #\@ #\. #\\ :colon-colon :less-dash))
	   do (ecase (peek-token stream)
		(#\( (read-token stream)
		     (parse :expression_or_wild)
		     (loop while (check-token #\, stream)
			   do (parse :expression_or_wild))
		     (assert-token #\) stream))
		(#\[ (parse :index_qualifier))
		(#\@ (read-token stream)
		     (parse :map_call))
		(#\. (read-token stream) (read-token stream))
		(#\\ (read-token stream) (read-token stream))
		(:colon-colon (parse :forward_path_qualifier))
		(:less-dash   (parse :backward_path_qualifier))
		)))))

;192 simple_types = binary_type | boolean_type | integer_type | logical_type | number_type
;    | real_type | string_type . p1114
;193 skip_stmt = 'skip' ';' . p1114

;194 source_attribute_reference = simple_id '.' simple_id .
(defparse1-p14 :source_attribute_reference ()
  (read-token stream)
  (assert-token #\. stream)
  (read-token stream))

;195 source_entity_reference = entity_reference .
(defparse1-p14 :source_entity_reference ()
  (parse :entity_reference))

;196 source_parameter = simple_id ':' extent_reference .
(defparse1-p14 :source_parameter ()
  (let ((tkn (read-token stream)))
    (add-type tkn *scope* :source-parameter)
    (with-instance (|SourceParameter|)
       (setf |id| (make-scoped-id tkn))
       (push *def* (%variables *scope*))))
  (assert-token #\: stream)
  (parse :extent_reference))

;198 stmt = assignment_stmt | case_stmt | compound_stmt | escape_stmt | if_stmt | null_stmt
;    | procedure_call_stmt | repeat_stmt | return_stmt | skip_stmt .   p1114

;199 string_literal = simple_string_literal | encoded_string_literal . p1114
;200 string_type = 'string' [ width_spec ] . p1114
;201 subsuper = [ supertype_constraint ] [ subtype_declaration ] . p1114

;202 subtype_binding_header = [ 'partition' simple_id ';' ] where_clause .
(defparse1-p14 :subtype_binding_header ()
  (when (check-token 'partition stream)
    (read-token stream)
    (assert-token #\; stream))
  (parse :where_clause)
  t)

;203 subtype_constraint = 'of' '(' supertype_expression ')' . p1114
;204 subtype_declaration = 'subtype' 'of' '(' simple_id { ',' simple_id } ')' . p1114

;205 supertype_constraint = abstract_supertype_declaration | supertype_rule .
(defparse1-p14 :supertype_constraint ()
  (cl:case (peek-token stream)
    (abstract  (parse :abstract_supertype_declaration))
    (supertype (parse :supertype_rule))))

;206 supertype_expression = supertype_factor { 'andor' supertype_factor } . p1114
;207 supertype_factor = supertype_term { 'and' supertype_term } . p1114

;208 supertype_rule = 'supertype' [ subtype_constraint ] .
(defparse1-p14 :supertype_rule ()
  (assert-token 'supertype stream)
  (when (check-token 'of stream)
    (parse :subtype_constraint)))

;209 supertype_term = simple_id | one_of | '(' supertype_expression ')' . p1114

;210 syntax_x = schema_map_decl | schema_view_decl .
(defparse1-p14 :syntax_x ()
  (ecase (peek-token stream)
    (schema_map (parse :schema_map_decl))
    (schema_view (parse :schema_view_decl))))

;211 target_entity_reference = entity_reference { '&' entity_reference } .
(defparse1-p14 :target_entity_reference ()
  (parse :entity_reference)
  (loop while (check-token #\& stream)
	do (parse :entity_reference)))

;212 target_parameter = simple_id { ',' simple_id } ':'
;    [ 'aggregate' [ bound_spec ] 'of' ] target_entity_reference .
(defparse1-p14 :target_parameter ()
  (let ((tkn (read-token stream)))
    (add-type tkn *scope* :target-parameter)
    (with-instance (|TargetVariable|)
      (setf |id| (make-scoped-id tkn))
      (push *def* (%variables *scope*))))
  (assert-token #\: stream)
  (when (check-token 'aggregate stream)
    (when (check-token #\[ stream)
      (parse :bound_spec))
    (assert-token 'of stream))
  (parse :target_entity_reference))

;215 term = factor { multiplication_like_op factor } . p1114

;219 type_reference = [ simple_id '.' ] simple_id .
(defparse1-p14 :type_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)
    (read-token stream)))

;220 unary_op = + | - | NOT . p1114
;221 until_control = UNTIL logical_expression . p1114

;223 view_attribute_decl = simple_id ':' [ OPTIONAL ] [ simple_id '.' ]
;    base_type ':=' expression ';' .
(defparse1-p14 :view_attribute_decl ()
  (read-token stream)
  (assert-token #\: stream)
  (when (check-token 'optional stream) (read-token stream))
  (when (eql #\. (peek-token stream 2))
    (read-token stream)
    (read-token stream))
  (parse :base_type)
  (assert-token :colon-equal stream)
  (parse :expression)
  (assert-token #\; stream))

;225 view_attr_decl_stmt_list = view_attribute_decl { view_attribute_decl } .
(defparse1-p14 :view_attr_decl_stmt_list ()
  (parse :view_attribute_decl)
  (loop until (member (peek-token stream) '(partition end_view))
	do (parse :view_attribute_decl)))

;226 view_call = view_reference [ partition_qualification ]
;    '(' [ expression_or_wild { ',' expression_or_wild } ] ')' .
(defparse1-p14 :view_call ()
  (parse :view_reference)
  (when (check-token #\\ stream)
    (parse :partition_qualification))
  (assert-token #\( stream)
  (unless (check-token #\) stream)
    (parse :expression_or_wild)
    (loop while (check-token #\, stream)
	  do (parse :expression_or_wild)))
  (assert-token #\) stream))

;227 view_decl = 'view' simple_id [ ':' base_type ] subsuper ';'
;    ( subtype_binding_header view_project_clause { subtype_binding_header view_project_clause } )
;  | ( binding_header view_project_clause { binding_header view_project_clause } ) 'end_view' ';' .
(defparse1-p14 :view_decl ()
  (assert-token 'view stream)
  (let ((name (read-token stream)))
    (add-type (cl:string name) *scope* :view)
    (dbg-message :parser  0  "~&View ~A~%" name)
    (when (check-token #\: stream)
      (parse :base_type))
    (let ((subp (parse :subsuper)))
      (assert-token #\; stream)
      (cl:if (eql subp :sub)
	     (loop initially (parse :view_sub_partition)
		   until (member (peek-token stream) '(partition end_view))
		   do (parse :view_sub_partition))
	     (loop initially (parse :view_partition)
		   until (member (peek-token stream) '(partition end_view))
		   do (parse :view_partition))))
    (assert-token 'end_view stream)
    (assert-token #\; stream)))

; view_sub_partition = sutype_binding_header view_project_clause .
(defparse1-p14 :view_sub_partition ()
  (parse :subtype_binding_header)
  (parse :view_project_clause))

; view_partition = binding_header view_project_clause .
(defparse1-p14 :view_partition ()
  (parse :binding_header)
  (parse :view_project_clause))

;229 view_project_clause = ( 'select' view_attr_decl_stmt_list ) | ( 'return' expression ) .
(defparse1-p14 :view_project_clause ()
  (ecase (read-token stream)
    (select (parse :view_attr_decl_stmt_list))
    (return (parse :expression))))

;230 view_reference = [ simple_id '.' ] simple_id .
(defparse1-p14 :view_reference ()
  (read-token stream)
  (when (check-token #\. stream)
    (read-token stream)))

;231 where_clause = 'where' domain_rule ';' { domain_rule ';' } . p1114
;232 while_control = 'while' logical_expression . p1114
;233 width = numeric_expression . p1114
;234 width_spec = '(' width ')' [ 'fixed' ] . p1114
