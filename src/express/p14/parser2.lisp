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

(in-package :p14p)

(defvar *source-schema* nil "Source schema expo object.")
(defvar *target-schema* nil "Target schema expo object.")
(defvar *this-schema* nil "Name for the mapping schema.")
(defvar *this-schema-abbrev* nil "String produced by name2initials naming the mapping schema.")

(defun x-qualified-name (id)
  (euintern (strcat *this-schema-abbrev* "." (cl:string id))))

;;; token-stream.lisp has a token-is method, it is for use with the current schema,
;;; which has a |Scope| object bound to *scope* The method here is for lookup of
;;; identifiers in the source or target schema, which are of type express-schema
;;; (the thing created by ensure-schema). This is especially useful for loading
;;; files translated earlier.
(defmethod emm:token-is (name type (schema expo:express-schema) &key)
  (ecase type
    (:entity (member name (expo:entity-type-names schema)))
    (:function (member name (expo:function-names schema)))
    (:constant (member name (expo:constant-names schema)))))
  
(defun schema-p (name &optional (schema *scope*))
  (cl:or (token-is name :schema-alias schema)
	 (token-is name :schema-ref schema)
	 (token-is name :schema-map schema)
	 (token-is name :schema-view schema)))

(defun constant-p (name &optional (schema *scope*))
  (cl:or (member name '(const_e pi self #\?))
	 (token-is name :constant schema)))

(defun variable-p (name &optional (schema *scope*))
  (token-is name :variable schema))

(defun entity-p (name &optional (schema *scope*))
  (token-is name :entity schema))

(defun type-p (name &optional (schema *scope*))
   (token-is name :type schema))

(defun enum-val-p (name &optional (schema *scope*))
  (token-is name :enum-val schema))

(defun function-p (name &optional (schema *scope*))
  (cl:or (token-is name :function schema)
	 (member name '(abs acos asin atan blength cos exists extent
			exp format hibound hiindex length lobound loindex log
			log2 log10 nvl odd rolesof sin sizeof sqrt tan
			typeof usedin value value_in value_unique))))

(defun procedure-p (name &optional (schema *scope*))
  (token-is name :procedure schema))

(defun map-p (name &optional (schema *scope*))
  (token-is name :map schema))

(defun dependent-map-p (name &optional (schema *scope*))
  (token-is name :dep-map schema))

(defun view-p (name &optional (schema *scope*))
  (token-is name :view schema))

(defun target-parameter-p (name &optional (schema *scope*))
  (token-is name :target-parameter schema))

(defun source-parameter-p (name &optional (schema *scope*))
  (token-is name :source-parameter schema))

(defun partition-p (name &optional (schema *scope*))
  (token-is name :partition schema))

;;;======================================================================
;;; Parsing...
;;;======================================================================
(defmethod parse2-data ((path pathname) (tag (eql :p14-file)) &key)
  (with-open-file (char-stream path :direction :input)
    (with-open-stream (stream (setf expo:*token-stream* (make-p14-stream char-stream)))
      (parse2-data stream :stream))))

(defmacro defparse2-p14 (tag (&rest keys) &body body)
  `(defmethod parse2-data ((stream p14-stream) (tag (eql ,tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys)
		       `(parse2-data stream ,tag ,@keys)))
       ,@body)))

;; The top-level grammar rule
(defparse2-p14 :stream ()
  (setf expo:*tags-trace* nil)
  (parse :syntax_x))

;; N178 2002-03-22

; 20 digit = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' .
; 21 letter = 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'
;           | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' .

; 22 simple_id = letter { letter | digit | '_' } . p1114
;    enumeration_ref  .   p1114

; 23 partition_ref = partition_id .
(defparse2-p14 :partition_ref ()
  (parse :partition_id))

; 24 map_ref = map_id
(defparse2-p14 :map_ref ()
  (make-scoped-id (read-token stream)))

; 25 schema_map_ref = schema_map_id .
(defparse2-p14 :schema_map_ref ()
  (parse :schema_map_id))

; 26 schema_view_ref = schema_view_id .
(defparse2-p14 :schema_view_ref ()
  (parse :schema_view_id))

; 27 source_parameter_ref = source_parameter_id .
(defparse2-p14 :source_parameter_ref ()
  (parse :parameter_ref)) ; p1114, makes a |ParameterRef|

; 28 source_schema_ref = schema_ref .
(defparse2-p14 :source_schema_ref ()
  (parse :schema_ref))

; 29 target_parameter_ref = target_parameter_id .
(defparse2-p14 :target_parameter_ref ()
  (parse :variable_ref)) ; goes to p1114

; 30 target_schema_ref = schema_ref .
(defparse2-p14 :target_schema_ref ()
  (parse :schema_ref))

; 31 view_attribute_ref = view_attribute_id .
(defparse2-p14 :view_attribute_ref ()
  (parse :view_attribute_id))

; 32 view_ref = view_id .
(defparse2-p14 :view_ref ()
  (parse :view_if))

; 30 abstract_supertype_declaration = ABSTRACT SUPERTYPE [ subtype_constraint ] .  p1114
; 31 actual_parameter_list = '(' parameter { ',' parameter } ')' .  p1114
; 32 add_like_op = '+' | '-' | 'or' | 'xor' .  p1114
; 33 aggregate_initializer = '[' [ element { ',' element } ] ']' . p1114
; 34 aggregate_source = simple_expression .  p1114
; 35 aggregate_type = 'aggregate' [ ':' type_label ] 'of' parameter_type . p1114
; 36 aggregation_types = array_type | bag_type | list_type | set_type . p1114
; 37 algorithm_head = { declaration } [ constant_decl ] [ local_decl ] . p1114
; 38 array_type = 'array' bound_spec 'of' [ 'optional' ] [ 'unique' ] base_type . p1114
; 39 assignment_stmt = general_ref { qualifier } ':=' expression ';' . p1114

; 40 backward_path_qualifier = '<-' [ attribute_ref ] path_condition .
(defparse2-p14 :backward_path_qualifier ()
  (assert-token :less-dash stream)
  (cl:if (check-token #\{ stream)
    (cl:list  (read-token stream) (parse :path_condition))
    (cl:list  nil (parse :path_condition))))

; 41 bag_type = 'bag' [ bound_spec ] 'of' base_type . p1114

; 42 base_type = aggregation_types | simple_types | named_types .
(defparse2-p14 :base_type ()
  (let ((tkn (peek-token stream)))
    (cond ((member tkn '(array bag list set))
	   (parse :aggregation_types))
	  ((member tkn '(binary boolean integer logical number real string))
	   (parse :simple_types))
	  ((cl:or (entity-p tkn) (type-p tkn) (view-p tkn))
	   ;; named_types = entity_reference | type_reference | view_reference
	   (parse :named_types))
	  (t (expo-parse-error parse-invalid-base-type :token tkn)))))

; 43 binary_type = 'binary' [ width_spec ] . p1114

; 44 binding_header = [ 'partition' partition_id ';' ] [ from_clause ] [ local_decl ]
;    [ where_clause ] [ identified_by_clause ] [ ordered_by_clause ] .
(defparse2-p14 :binding_header ()
  (when (check-token 'partition stream)
    (read-token stream)
    (setf (%id *def*) (parse :partition_id))
    (assert-token #\; stream))
  (when (check-token 'from stream)
    (setf (%sources *def*) (parse :from_clause)))
  (when (check-token 'local stream)
    (setf (%local-vars *def*) (parse :local_decl)))
  (when (check-token 'where stream)
    (setf (%predicate *def*) (parse :where_clause)))
  (when (check-token 'identified_by stream)
    (setf (%alternate-id *def*) (parse :identified_by_clause)))
  (when (check-token 'ordered_by stream)
    (setf (%ordering *def*) (parse :ordered_by_clause))))
    
; 45 boolean_type = 'boolean' . p1114
; 46 bound_1 = numeric_expression . p1114
; 47 bound_2 = numeric_expression . p1114
; 48 bound_spec = '[' bound_1 ':' bound_2 ']' . p1114
; 49 built_in_constant = 'const_e' | 'pi' | 'self' | '?' . p1114

; 50 built_in_function = 'abs' | 'acos' | 'asin' | 'atan' | 'blength' | 'cos' | 'exists'
;    | 'extent' | 'exp' | 'format' | 'hibound' | 'hiindex' | 'length' | 'lobound'
;    | 'loindex' | 'log' | 'log2' | 'log10' | 'nvl' | 'odd' | 'rolesof' | 'sin' | 'sizeof'
;    | 'sqrt' | 'tan' | 'typeof' | 'usedin' | 'value' | 'value_in' | 'value_unique' .  p1114

; 51 built_in_procedure = 'insert' | 'remove' . p1114
; 52 case_action = case_label { ',' case_label } ':' stmt . p1114

; 53 case_expr = 'case' selector 'of' { case_expr_action } [ 'otherwise' ':' expression ] 'end_case' .
(defparse2-p14 :case_expr ()
  (parse :case_stmt))

; 54 case_expr_action = case_label { ',' case_label } ':' expression ';' .
(defparse2-p14 :case_expr_action ()
  (parse :case_action))

; 55 case_label = expression . p1114
; 56 case_stmt = 'case' selector 'of' { case_action } [ 'otherwise' ':' stmt ] 'end_case' ';' . p1114
; 57 compound_stmt = 'begin' stmt { stmt } 'end' ';' . p1114

; 58 constant_body = constant_id ':' base_type ':=' expression ';' .
(defparse2-p14 :constant_body ()
  (let (id expr)
    (setf id (parse :constant_id))
    (dbg-message :parser 2 "~&Constant ~A~%" id)
    (assert-token #\: stream)
    (parse :base_type) ; pod type not used
    (assert-token :colon-equal stream)
    (setf expr (parse :expression))
    (assert-token #\; stream)
    `(def-express-constant ,id ,expr)))

; 59 constant_decl = 'constant' constant_body { constant_body } 'end_constant' ';' . p1114
; 60 constant_factor = built_in_constant | constant_ref . p1114
; 61 constant_id = simple_id . p1114

; 62 declaration = function_decl | procedure_decl .
(defparse2-p14 :declaration ()
  (ecase (peek-token stream)
    (function  (parse :function_decl))
    (procedure (parse :procedure_decl))))

; 63 dependent_map_decl = 'dependent_map' map_id 'as' target_parameter ';' { target_parameter ';' }
;    [ map_subtype_of_clause ] dep_map_partition { dep_map_partition } 'end_dependent_map' ';' .
(defparse2-p14 :dependent_map_decl ()
  (assert-token 'dependent_map stream)
  (let ((map-id (parse :map_id)))
    (expo:expo-dot *expresso* :stream stream :char "M" :pass 2)
    (with-instance (|MapSpec| :find-id map-id)
      (let ((*scope* *def*))
	(setf |id| map-id)
	(setf |dependent-p| t)
	(assert-token 'as stream)
	(setf |targets|
	      (cons (prog1 (parse :target_parameter) (assert-token #\; stream))
		    (loop until (member (peek-token stream) '(subtype partition from end_dependent_map))
			  collect (parse :target_parameter)
			  do (assert-token #\; stream))))
	(when (check-token 'subtype stream)
	  (setf |subtypeOf| (parse :map_subtype_of_clause))
	  ;; Set the parent scope to the supermap.
	  (setf (%%parent *scope*)
		(find-child-scope :name (%local-name |subtypeOf|) :scope (schema-scope *scope*))))
	(setf |partitions|
	      (loop until (check-token 'end_dependent_map stream)
		    collect (parse :dep_map_partition)))
	(assert-token 'end_dependent_map stream)
	(assert-token #\; stream)))))

; 64 dep_binding_decl = dep_from_clause [ local_decl ] [ where_clause ] [ ordered_by_clause ] .
(defparse2-p14 :dep_binding_decl ()
  (setf (%sources *def*) (parse :dep_from_clause)) ; *def* is a |Partition|
  (when (check-token 'local stream)
    (setf (%local-vars *def*) (parse :local_decl)))
  (when (check-token 'where stream)
    (setf (%predicate *def*) (parse :where_clause)))
  (when (check-token 'ordered_by stream)
    (setf (%ordering *def*) (parse :ordered_by_clause))))

; 65 dep_from_clause = 'from' dep_source_parameter ';' { dep_source_parameter ';' } .
(defparse2-p14 :dep_from_clause ()
  (assert-token 'from stream)
  (loop until (member (peek-token stream) '(local where ordered_by select))
	collect (parse :dep_source_parameter)
	do (assert-token #\; stream)))

; 66 dep_map_decl_body = dep_binding_decl map_project_clause .
(defparse2-p14 :dep_map_decl_body ()
  (parse :dep_binding_decl) ; *def* is still |Partition|
  (with-instance (|SelectBlock|)
    (setf |statements| (parse :map_project_clause))))

; 67 dep_map_partition = [ PARTITION partition_id ':' ] dep_map_decl_body .
(defparse2-p14 :dep_map_partition ()
  (with-instance (|Partition|)
    (when (check-token 'partition stream)
      (setf |id| (parse :partition_id))
      (add-type |id| *scope* :partition)
      (assert-token #\: stream))
    (setf |blocks| (let ((blocks (parse :dep_map_decl_body))) ;;  (:project ...)
		     (cl:if (consp blocks) blocks (cl:list blocks))))))

; POD 2007.02.01 I'm not going to allow multiple source_parameter_id.
; 68 dep_source_parameter = source_parameter_id { ',' source_parameter_id }
;    ':' ( simple_types | type_reference ) .
(defparse2-p14 :dep_source_parameter ()
  (let* ((id (make-scoped-id (read-token stream)))
	 (source-param (find id (%variables *scope*) :key #'%id)))
    (unless source-param 
      (expo-parse-error :text  "Could not find source parameter ~A" id))
    (assert-token #\: stream)
    (let ((*scope* (schema-mm *source-schema*)))
      (setf (%formal-parameter-type source-param) (parse :type_reference)))
    source-param))

; 69 domain_rule = [ label ':' ] logical_expression . p1114
; 70 element = expression [ ':' repetition ] . p1114
; 71 entity_constructor = entity_reference '(' [ expression { ',' expression } ] ')' . p1114
; 72 entity_id = simple_id . p1114

; 73 entity_instantiation_loop = 'for' instantiation_loop_control ';' map_project_clause .
(defparse2-p14 :entity_instantiation_loop ()
  (break "entity_instantiation_loop need work"))  ;; POD !!!

;;; This rule is a key difference in P14! Can also be used in P14-defined functions???
;;; See also :named_type (which does this kind of thing).
; 74 entity_reference = [ ( source_schema_ref | target_schema_ref | schema_ref ) '.' ] entity_ref .
(defparse2-p14 :entity_reference ()
  (cl:if (eql #\. (peek-token stream 2))
    (let ((*scope* (emm::alias2schema (cl:string (read-token stream)))))
      (assert-token #\. stream)
      (parse :entity_ref))
    (parse :entity_ref)))

; 75 enumeration_reference = [ type_reference '.' ] enumeration_ref . p1114
; 76 escape_stmt = 'escape' ';' . p1114
; 77 expression = simple_expression [ rel_op_extended simple_expression ] . p1114

;;; POD Should be called actual_parameter_or_wild !
; 78 expression_or_wild = expression | '_' . 
(defparse2-p14 :expression_or_wild ()
  (cl:if (check-token #\_ stream)
	 :wild
	 (parse :parameter)))

; 79 extent_reference = source_entity_reference | view_reference .
(defparse2-p14 :extent_reference ()
  (let ((id (peek-token stream)))
    (cl:if (entity-p (euintern id) *source-schema*)
	   (parse :source_entity_reference)
	   (parse :view_reference))))

; 80 factor = simple_factor [ '**' simple_factor ] .

; 81 foreach_expr = 'each' variable_id 'in' expression [ where_clause ] 'return' expression .
(defparse2-p14 :foreach_expr ()
  (assert-token 'each stream)
  (let ((tkn (read-token stream))) ; do it here to  get token-pos correct.
    (with-instance (|ForEachExpression| 
		    :find-contains 
		    (cl:list '|ForEachExpression| tkn (expo:token-position stream)))
      (let ((*scope* *def*))
	(setf |variable| (parse :variable_id :token tkn))
	(assert-token 'in stream)
	(setf |aggregate-operand| (parse :expression))
	(when (check-token 'where stream)
	  (setf |select-condition| (parse :where_clause)))
	(assert-token 'return stream)
	(setf |return-expression| (parse :expression))))))

; 82 forloop_expr = repeat_control 'return' expression .  pod: CTL's version NYI?
(defparse2-p14 :forloop_expr ()
  (let (expr)
    (dbind (for-ctl while-ctl until-ctl) 
	   (parse :repeat_control)
     (assert-token 'return stream)
     (setf expr (parse :expression))
     `(make-instance 'expo:express-bag
		     :type-descriptor 
		     (make-instance 'expo:bag-typ :l-bound 0 :u-bound :? :base-type t)
		     :value (loop ,@for-ctl ,@while-ctl ,@until-ctl collect ,expr
				  eu::collect ,expr)))))

; 83 formal_parameter = parameter_id { ',' parameter_id } ':' parameter_type .

; 84 forward_path_qualifier = '::' attribute_ref [ path_condition ] .  POD: CTL's version NYI?
(defparse2-p14 :forward_path_qualifier ()
  (assert-token :colon-colon stream)
  (cl:if (check-token #\{ stream)
      (cl:list  (read-token stream) (parse :path_condition))
    (cl:list nil (parse :path_condition))))

; 85 for_expr = 'for' ( foreach_expr | forloop_expr ) .
(defparse2-p14 :for_expr ()
  (assert-token 'for stream)
  (cl:if (check-token 'each stream)
	 (parse :foreach_expr)
	 (parse :forloop_expr)))

; 86 from_clause = 'from' source_parameter ';' { source_parameter ';' } .
(defparse2-p14 :from_clause ()
  (assert-token 'from stream)
  (cons (prog1 (parse :source_parameter) (assert-token #\; stream))
	(loop until (member (peek-token stream) '(local where identified_by ordered_by for select return))
	      collect (parse :source_parameter)
	      do (assert-token #\; stream))))

; 87 function_call = ( built_in_function | function_ref ) [ actual_parameter_list ] . p1114
; 88 function_decl = function_head algorithm_head stmt { stmt } END_FUNCTION ';' . p1114
; 89 function_head = 'function' function_id [ '(' formal_parameter { ';' formal_parameter } ')' ]
;    ':' parameter_type ';' .  p1114
; 90 function_id = simple_id . p1114
; 91 generalized_types = aggregate_type | general_aggregation_types | generic_type . p1114
; 92 general_aggregation_types = general_array_type | general_bag_type | general_list_type
;    | general_set_type . p1114
; 93 general_array_type = 'array' [ bound_spec ] 'of' [ 'optional' ] [ 'unique' ] parameter_type . p1114

; 94 general_attribute_qualifier = '.' ( attribute_ref | view_attribute_ref ) .
(defparse2-p14 :general_attribute_qualifier ()
    (assert-token #\. stream)
    (parse :attribute_ref))

; 95 general_bag_type = 'bag' [ bound_spec ] 'of' parameter_type . p1114
; 96 general_list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] parameter_type . p1114

; 97 general_or_map_call = general_ref [ '@' map_call ] .
(defparse2-p14 :general_or_map_call ()
  (let (access-param)
    (cond ((eql #\@ (peek-token stream 2))
	   (let* ((*scope* (find-child-scope :name (cl:string (peek-token stream 3))
					     :scope (emm:schema-scope *scope*))))
	     (setf access-param (parse :parameter_ref))) ; pod this isn't really a parameter!
	   ;; Pop out (end let) of scope of access-param (the map named by map_call).
	   (read-token stream)
	   (parse :map_call :access-param access-param))
	  (t (parse :general_ref)))))

; 98 general_ref = parameter_ref | variable_ref . p1114

; 99 general_schema_alias_id = schema_id | schema_map_id | schema_view_id .
(defparse2-p14 :general_alias_id ()
  (read-token stream))

;100 general_schema_ref = schema_ref | schema_map_ref | schema_view_ref .
(defparse2-p14 :general_schema_ref ()
  (read-token stream))

;101 general_set_type = 'set' [ bound_spec ] 'of' parameter_type . p1114
;102 generic_type = 'generic' [ ':' type_label ] . p1114
;103 group_qualifier = '\' entity_ref . p1114

;104 identified_by_clause = 'identified_by' id_parameter ';' { id_parameter ';' } .
(defparse2-p14 :identified_by_clause ()
  (let (id-param)
    (assert-token 'identified_by stream)
    (setf id-param (parse :id_parameter))
    (setf id-param
	  (cons id-param
		(loop until (member (peek-token stream) '(ordered_by for select return))
		      collect (parse :id_parameter))))))

;105 id_parameter = [ id_parameter_id ':' ] expression .
(defparse2-p14 :id_parameter ()
  (with-instance (|Variable|)
    (setf |id| (make-scoped-id (read-token stream))) ; just a |ScopedID|
    (assert-token #\: stream)
    (let ((*scope* (schema-mm *source-schema*)))
      (setf |initial-value| (parse :expression)))))

;106 id_parameter_id = parameter_id . ; see directly above.

;107 if_expr = 'if' logical_expression 'then' expression { ELSIF logical_expression expression }
;    [ ELSE expression ] END_IF .
(defparse2-p14 :if_expr ()
  (let (test then elsif else)
    (assert-token 'if stream)
    (setf test (parse :logical_expression))
    (assert-token 'then stream)
    (setf then (parse :expression))
    (when (check-token 'elsif stream)
      (setf elsif
	    (loop until (member (peek-token stream) '(else end_if))
		  collect (cl:list (parse :logical_expression)
				   (parse :expression)))))
    (when (check-token 'else stream)
      (read-token stream)
      (setf else (parse :expression)))
    (assert-token 'end_if stream)
    (cl:if elsif
      (cl:if else
	     `(cl:if ,test (progn ,@then) ,@elsif (progn ,@else))
	     `(cl:if ,test ,@then ,@elsif))
      (cl:if else
	     `(cl:if ,test (progn ,@then) (progn ,@else))
	     `(when ,test ,@then)))))

;108 if_stmt = 'if' logical_expression 'then' stmt { stmt } [ 'else' stmt { stmt } ] 'end_if' ';' . p1114
;109 increment = numeric_expression . p1114
;110 increment_control = variable_id ':=' bound_1 'to' bound_2 [ 'by' increment ] . p1114
;111 index = numeric_expression . p1114
;112 index_1 = index . p1114
;113 index_2 = index . p1114
;114 index_qualifier = '[' index_1 [ ':' index_2 ] ']' . p1114

;115 instantiation_foreach_control = 'each' variable_id 'in' source_attribute_reference
;    'indexing' variable_id .
(defparse2-p14 :instantiation_foreach_control ()
  (break "instantiation_foreach_control NYI")) ; POD did CTL remove from defview.lisp?

;116 instantiation_loop_control = instantiation_foreach_control | repeat_control .
(defparse2-p14 :instantiation_loop_control ()
  (break "instantiation_loop_control NYI")) ; POD did CTL remove from defview.lisp?

;117 integer_type = 'integer' . p1114
;118 interval = '{' interval_low interval_op interval_item interval_op interval_high '}' . p1114
;119 interval_high = simple_expression . p1114
;120 interval_item = simple_expression . p1114
;121 interval_low = simple_expression . p1114
;122 interval_op = '<' | '<=' . p1114
;123 label = simple_id . POD Not used???
;124 list_type = 'list' [ bound_spec ] 'of' [ 'unique' ] base_type . p1114
;125 literal = binary_literal | integer_literal | logical_literal | real_literal | string_literal . p1114
;126 local_decl = 'local' local_variable { local_variable } 'end_local' ';' . p1114
;127 local_variable = variable_id { ',' variable_id } ':' parameter_type [ ':=' expression ] ';' . p1114
;128 logical_expression = expression . p1114
;129 logical_literal = 'false' | 'true' | 'unknown' . p1114
;130 logical_type = 'logical' . p1114

; (setf (%id ap2i.pc nil) (%id ap2i.spc nil))
;131 map_attribute_declaration = [ target_parameter_ref [ index_qualifier ] [ group_qualifier ] '.' ]
;    attribute_ref [ index_qualifier ] ':=' expression ';' .
(defparse2-p14 :map_attribute_declaration ()
  (with-instance (|MappingAssignmentStatement|)
    (let ((p11p::*p14-force-scope* (schema-mm *target-schema*)))
      (setf |place-reference| (parse :expression)))
    (assert-token :colon-equal stream)
    (let ((p11p::*p14-force-scope* (schema-mm *source-schema*)))
      (setf |expression| (parse :expression)))
    (assert-token #\; stream)))

(defparameter *walk-slots* nil)

;;; POD I'm not so sure that this is useful!
(defun p14-walk-expression (exp)
 "Run DO-FUNC on every slot of EXP that is an Expression (because that's what *walk-slots* lists)
  Update the slot with the (updating the slot). Calls itself recursively on those slots. 
  Returns EXP."
 (when (null *walk-slots*) 
   (setf *walk-slots* (cons
		       '(unresolved-attribute-ref . emm::|entity-instance|)
		       (emm::identify-slots-for-attr-setf-tracking))))
 (loop for (class . slot) in *walk-slots* with sub-expr = nil do
       (when (typep exp class)
	 (when (typep (setf sub-expr (slot-value exp slot)) 'unresolved-attribute-ref)
	   (setf (%%scope sub-expr) (emm::mu-type-ref (%entity-instance sub-expr))))
	 (p14-walk-expression sub-expr)))
 exp)


;132 map_call = map_ref [ partition_qualification ] '(' expression_or_wild { ',' expression_or_wild } ')' .
(defparse2-p14 :map_call (access-param)
  (with-instance (|MapCall|)
    (setf |access-parameter| access-param)
    (setf |invokes-function| (parse :map_ref))
    (when (check-token #\\ stream) 
      (setf |partition| (parse :partition_qualification)))
    (assert-token #\( stream)
    (setf |actual-parameters|
	  (cons (parse :expression_or_wild)
		(loop while (check-token #\, stream)
		      do (read-token stream)
		      collect (parse :expression_or_wild))))
    (assert-token #\) stream)))

;133 map_decl = 'map' map_id 'as' target_parameter ';' { target_parameter ';' }
;    map_sub_partition | ( map_partition { map_partition } ) 'end_map' ';' .
(defparse2-p14 :map_decl ()
  (assert-token 'map stream)
  (let ((map-id (parse :map_id)))
    (with-instance (|MapSpec| :find-id map-id)
      (let ((*scope* *def*))
	(setf |id| map-id)
	(expo:expo-dot *expresso* :stream stream :char "M" :pass 2)
	(dbg-message :parser 1 "~&Map ~A~%" map-id)
	(assert-token 'as stream)
	(setf |dependent-p| nil) ; was ':false' !
	(setf |targets|
	      (cons (prog1 (parse :target_parameter) (assert-token #\; stream))
		    (loop until (member (peek-token stream) 
					'(subtype partition from local where
					  identified_by ordered_by for select return))
			  collect (parse :target_parameter)
			  do (assert-token #\; stream))))
	(cl:if (check-token 'subtype stream)
	    (setf |partitions| (cl:list (parse :map_sub_partition)))
	    (setf |partitions|
		  (cons (parse :map_partition)
			(loop until (check-token 'end_map stream)
			      collect (parse :map_partition)))))
	(assert-token 'end_map stream)
	(assert-token #\; stream)))))

; map_sub_partition = map_subtype_of_clause subtype_binding_header map_decl_body .
(defparse2-p14 :map_sub_partition ()
  (setf (%subtype-of *def*) (parse :map_subtype_of_clause))
  (with-instance (|Partition|)
    (dbind (partition-id predicate) (parse :subtype_binding_header)
      (setf |id| partition-id)
      (setf |predicate| predicate))
    (setf |blocks| (let ((blocks (parse :map_decl_body))) ;;  (:project ...)
		     (cl:if (consp blocks) blocks (cl:list blocks))))))

; map_partition = binding_header map_decl_body .
(defparse2-p14 :map_partition ()
  (with-instance (|Partition|)
    (parse :binding_header)   ;;  (<parti-id> :sources ... :predicate ...)
    (setf |blocks| (let ((blocks (parse :map_decl_body))) ;;  (:project ...)
		     (cl:if (consp blocks) blocks (cl:list blocks))))))

;134 map_decl_body = ( entity_instantiation_loop { entity_instantiation_loop } )
;    | map_project_clause | ( 'return' expression ';' ) .
(defparse2-p14 :map_decl_body ()
  (with-instance (|SelectBlock|)
    (ecase (peek-token stream)
      (for
       (setf |statements| ; pod might be more to do here.
	     (cons (parse :entity_instantiation_loop)
		   (loop until (member (peek-token stream) '(partition for end_dependent_map end_map))
			 collect (parse :entity_instantiation_loop)))))
      (select (setf |statements| (parse :map_project_clause)))
      (return 
	(assert-token 'return stream)
	(setf |statements| (p14-walk-expression (parse :expression)))
	(assert-token #\; stream)))))

;135 map_id = simple_id .
(defparse2-p14 :map_id ()
  (make-scoped-id (read-token stream)))

; map_local_assignment = variable_ref { ( '.' attribute_ref ) | group_qualifier | index_qualifier } ':=' expression ';' .
(defparse2-p14 :map_local_assignment ()
  (let ((primary (read-token stream)) expr)
    (loop for tkn = (peek-token stream)
	  while (member tkn '(#\. #\[ #\\))
	  do (ecase tkn
	       (#\. (setf primary `(,(parse :general_attribute_qualifier) ,primary nil)))
	       (#\\ (setf (third primary) (parse :group_qualifier)))
	       (#\[ (setf primary `(aref primary ,(car (parse :index_qualifier))))))) ; POD again, no sequence
    (assert-token :colon-equal stream)
    (setf expr (p14-walk-expression (parse :expression)))
    (assert-token #\; stream)
    `(setf ,primary ,expr)))

;136 map_project_clause = SELECT map_select_item { map_select_item } .
(defparse2-p14 :map_project_clause ()
  (assert-token 'select stream)
  (cons (parse :map_select_item)
	(loop  until (member (peek-token stream) 
			     '(partition for end_dependent_map end_map))
	       collect (parse :map_select_item))))

;137 map_ref = map_id .
(defparse2-p14 :map_ref ()
  (let ((id (make-scoped-id (read-token stream))))
    (emm::lookup-referenceable id)))

;138 map_reference = [ schema_map_ref '.' ] map_ref .
(defparse2-p14 :map_reference ()
  (when (eql #\. (peek-token stream 2))
    (read-token stream)
    (read-token stream))
  (parse :map_ref))

;  (make-scoped-id (read-token stream) :scope (schema-scope *scope*)))

;;; POD! There was a mistake in the spec here. The example in 9.7 shows this,
;;; but the syntax doesn't support it. It should! (thus no number on map_select_it)
; map_select_item = map_attribute_declaration | map_local_assignment .
(defparse2-p14 :map_select_item ()
  (let ((tkn (peek-token stream)))
    (cond ((target-parameter-p tkn) ; variable-p should be declared in a LOCAL
	   (parse :map_attribute_declaration))
	  ((variable-p tkn)
	   (parse :map_local_assignment))
	  (t (expo-parse-error :text "Expected target parameter or variable. Got ~A" tkn)))))

;139 map_subtype_of_clause = 'subtype' 'of' '(' map_reference ')' ';' .
(defparse2-p14 :map_subtype_of_clause ()
  (let (supermap)
    (assert-token 'subtype stream)
    (assert-token 'of stream)
    (assert-token #\( stream)
    (setf supermap (parse :map_reference))
    ;; Adjust the parent scope, it is the supermap, not the schema.
    (setf (%%parent *scope*)
	  (find-child-scope :name (%local-name (%id supermap)) :scope (schema-scope *scope*)))
    (assert-token #\) stream)
    (assert-token #\; stream)
    supermap))

;140 multiplication_like_op = '*' | '/' | 'div' | 'mod' | 'and' | '||' . p1114

;141 named_types = entity_reference | type_reference | view_reference 
;; each of these is of the form: [ schema_ref '.' ] object_ref 
(defparse2-p14 :named_types ()
  (cl:if (schema-p (peek-token stream))
     (let ((*scope* (emm::alias2schema (read-token stream))))
       (assert-token #\. stream)
       (call-next-method))
     (call-next-method)))

;142 null_stmt = ';' . p1114
;143 number_type = 'number' . p1114
;144 numeric_expression = simple_expression . p1114
;145 one_of = 'oneof' '(' supertype_expression { ',' supertype_expression } ')' . p1114

;146 ordered_by_clause = 'ordered_by' expression { ',' expression } ';' .
(defparse2-p14 :ordered_by_clause ()
  (cons (parse :expression)
	(loop while (check-token #\, stream)
	      collect (p14-walk-expression (parse :expression)))))

;147 parameter = expression . p1114
;148 parameter_id = simple_id . p1114
;149 parameter_type = generalized_types | named_types | simple_types . p1114

;150 partition_id = simple_id .
(defparse2-p14 :partition_id ()
  (let ((pname (read-token stream)))
    ;(add-type pname *scope* :partition) ; 2007
    (euintern pname)))

;151 partition_qualification = '\' partition_ref .
(defparse2-p14 :partition_qualification ()
  (assert-token #\\ stream)
  (euintern (parse :partition_ref)))

;152 path_condition = '{' extent_reference [ '|' logical_expression ] '}' .
(defparse2-p14 :path_condition ()
  (let (extent expr)
    (assert-token #\{ stream)
    (setf extent (parse :extent_reference))
    (when (check-token #\| stream) (read-token stream) (setf expr (parse :logical_expression)))
    (cl:list extent expr)))

;153 path_qualifier = forward_path_qualifier | backward_path_qualifier .
(defparse2-p14 :path_qualifier ()
  (ecase (peek-token stream)
    (:less-dash   (parse :backward_path_qualifier))
    (:colon-colon (parse :forward_path_qualifier))))

;154 population = entity_reference . p1114
;155 precision_spec = numeric_expression . p1114
;156 primary = literal | ( qualifiable_factor { qualifier } ) . p1114
;157 procedure_call_stmt = ( built_in_procedure | procedure_ref ) [ actual_parameter_list ] ';' . p1114

;158 procedure_decl = procedure_head algorithm_head { stmt } 'end_procedure' ';' . dont-care
;159 procedure_head = 'procedure' procedure_id [ '(' [ 'var' ] formal_parameter { ';' [ 'var' ]
;    formal_parameter } ')' ] ';' . dont-care

;160 procedure_id = simple_id . p1114

;;; THIS ONE IS WRONG!
;161 qualifiable_factor = attribute_ref | constant_factor | function_call | general_or_map_call
;    | population | view_attribute_ref | view_call .  

;;; THE SPEC HAS THIS:
; 163 qualifiable_factor = attribute_ref | constant_factor | function_call | general_ref | map_cal
;     population | target_parameter_ref | view_attribute_ref | view_call
;; THE SPEC SHOULD HAVE INCLUDED source_parameter_ref

;; function_call       = fun-name [ '(' ...
;; constant_factor     = built_in_const | constant_ref
;; population          = [ schema_ref '.' ] entity_ref
;; view_call           = [ schema_ref '.' ] view_ref [ part_qual ] '(' ...

;; attribute_ref       = simple_id
;; view_attribute_ref  = simple_id
;; general_or_map_call = simple_id [ '@' map_call ]

(defparse2-p14 :qualifiable_factor ()
  (let ((tkn (peek-token stream)))
    (cond ((function-p tkn) (parse :function_call))
	  ((constant-p tkn) (parse :constant_factor))
	  ((schema-p tkn)
	   (let ((sch (peek-token stream))
		 (item (peek-token stream 3)))
	     (cond ((entity-p item sch)
		    (parse :population))
		   (t (parse :view_call)))))
	  ((eql #\@ (peek-token stream 2)) (parse :general_or_map_call))
	  ((target-parameter-p tkn) (parse :target_parameter_ref))
	  ((source-parameter-p tkn) (parse :source_parameter_ref))
	  ((variable-p tkn) (parse :variable_ref))
	  ;((view-p tkn) (parse :view_call))
	  (t 
	   (expo-parse-error :text "Expected a qualifiable factor, got ~A" tkn)))))

;162 qualifier = general_attribute_qualifier | group_qualifier | index_qualifier | path_qualifier .
(defparse2-p14 :qualifier ()
  (ecase (peek-token stream)
    (#\. (cl:list :attr (parse :general_attribute_qualifier)))
    (#\\ 
     (let ((emm:*allow-inheritance-from-other-schema* t))
       (cl:list :group (parse :group_qualifier))))
    (#\[ (cl:list :index (parse :index_qualifier)))
    (:colon-colon 
     (let ((emm:*allow-inheritance-from-other-schema* t))
       (append '(:f-path) (parse :path_qualifier))))  ; looks like (:fp attr/nil path_condition) 
    (:less-dash   
     (let ((emm:*allow-inheritance-from-other-schema* t))
       (append '(:b-path) (parse :path_qualifier))))))   ; looks like (:bp attr/nil path_condition) 

;163 query_expression = 'query' '(' variable_id '<*' aggregate_source '|' logical_expression ')' . p1114
;164 real_type = 'real' [ '(' precision_spec ')' ] . p1114


;165 reference_clause = REFERENCE FROM schema_ref_or_rename
;    [ '(' resource_or_rename { ',' resource_or_rename } ')' ] [ AS ( SOURCE | TARGET ) ] ';' .
(defparse2-p14 :reference_clause ()
  (assert-token 'reference stream)
  (assert-token 'from stream)
  (let (defs)
    (dbind (short-name long-name) 
	(parse :schema_ref_or_rename)
      (when (check-token 'as stream)
	(read-token stream)
	(cl:case (peek-token stream) ;POD 'AS SOURCE'/'AS TARGET' should not be optional!
	  (source (if-bind (schema (find-schema (cl:string long-name)))
			   (progn 
			     (setf *source-schema* schema)
			     (add-type short-name *scope* :schema-alias)
			     (add-type short-name *scope* :source-schema-alias)
			     (loop for obj in (%schema-elements (schema-mm *source-schema*))
				   when (typep obj '|NamedType|) 
				   do (push obj (%%inherited-objects *scope*))))
			   (expo-parse-error :text "No such schema loaded: ~A" (cl:string long-name)))
		  (expo:ensure-schema-alias
		   :name (string-downcase (cl:string short-name))
		   :schema-name (cl:string long-name)
		   :direction :source)
		  (push `(expo:ensure-schema-alias
			  :name ,(string-downcase (cl:string short-name))
			  :schema-name ,(cl:string long-name)
			  :direction :source) defs)
		  (push `(setf (expo::source-schema-name (expo::schema expo::*expresso*))
			  ,(cl:string long-name)) defs))
	  (target (if-bind (schema (find-schema (cl:string long-name)))
			   (progn
			     (setf *target-schema* schema)
			     (add-type short-name *scope* :schema-alias)
			     (add-type short-name *scope* :target-schema-alias)
			     (loop for obj in (%schema-elements (schema-mm *target-schema*))
				   when (typep obj '|NamedType|) 
				   do (push obj (%%inherited-objects *scope*))))
			   (expo-parse-error :text "No such schema loaded: ~A" (cl:string long-name)))
		  (expo:ensure-schema-alias
		   :name (string-downcase (cl:string short-name))
		   :schema-name (cl:string long-name)
		   :direction :target)
		  (push `(expo:ensure-schema-alias
			  :name ,(string-downcase (cl:string short-name))
			  :schema-name ,(cl:string long-name)
			  :direction :target) defs)
		  (push `(setf (expo::target-schema-name (expo::schema expo::*expresso*))
			  ,(cl:string long-name)) defs))))
      (read-token stream)
      (assert-token #\; stream))
    defs))
  
;166 rel_op = '<' | '>' | '<=' | '>=' | '<>' | '=' | ':<>:' | ':=:' . p1114
;167 rel_op_extended = rel_op | 'in' | 'like' . p1114
;168 rename_id = constant_id | entity_id | function_id | procedure_id | type_id . p1114
;169 repeat_control = [ increment_control ] [ while_control ] [ until_control ] . p1114
;170 repeat_stmt = 'repeat' repeat_control ';' stmt { stmt } 'end_repeat' ';' . p1114
;171 repetition = numeric_expression . p1114
;172 resource_or_rename = resource_ref [ 'as' rename_id ] . p1114

;173 resource_ref = constant_ref | entity_ref | function_ref | procedure_ref
;    | type_ref | view_ref | map_ref .
(defparse2-p14 :resource_ref ()
  ;; all of these would return a single token so...
  (read-token stream))

;174 return_stmt = 'return' [ '(' expression ')' ] ';' . p1114
;175 rule_decl = rule_head [ algorithm_head ] { stmt } where_clause 'end_rule' ';' . p1114
;176 rule_head = 'rule' rule_id 'for' '(' entity_ref { ',' entity_ref } ')' ';' . p1114
;177 rule_id = simple_id . p1114
;178 schema_id = simple_id . p1114

;179 schema_map_body_element = function_decl | procedure_decl | view_decl | map_decl
;    | dependent_map_decl | rule_decl .
(defparse2-p14 :schema_map_body_element ()
  (ecase (peek-token stream)
    (function      (parse :function_decl))
    (procedure     (parse :procedure_decl))
    (view          (parse :view_decl))
    (map           (parse :map_decl))
    (dependent_map (parse :dependent_map_decl))
    (rule          (parse :rule_decl))))

;180 schema_map_body_element_list = schema_map_body_element { schema_map_body_element } .
(defparse2-p14 :schema_map_body_element_list ()
  (cons (parse :schema_map_body_element)
	(loop until (check-token 'end_schema_map stream)
	      collect (parse :schema_map_body_element))))

;181 schema_map_decl = 'schema_map' schema_map_id ';' reference_clause { reference_clause }
;    [ constant_decl ] schema_map_body_element_list 'end_schema_map' ';' .
(defparse2-p14 :schema_map_decl ()
  (assert-token 'schema_map stream)
  (with-instance (|MappingSchema| :find-force *scope*)
    (setf |name| (parse :schema_map_id))
    (let ((expo-schema (expo:ensure-schema 'expo::map-schema :name (string-upcase (cl:string |name|)))))
      (setf (expo::schema-mm expo-schema) *def*))
    (setf *this-schema* |name|)
    (setf *this-schema-abbrev* (expo::name2initials (cl:string |name|)))
    (assert-token #\; stream)
    (setf |interfaced-elements| ; pod needs works
	  (append (parse :reference_clause)
		  (loop while (check-token 'reference stream) append (parse :reference_clause))))
    (setf |interfaces| (when (check-token 'constant stream) (parse :constant_decl))) ; pod misuse
    ;; Inherit NamedType objects from source and target schema
    (setf |schema-elements| (parse :schema_map_body_element_list))
    (assert-token 'end_schema_map stream)
    (assert-token #\; stream)))

;182 schema_map_id = simple_id .
(defparse2-p14 :schema_map_id ()
  (cl:string (read-token stream))) ; This one isn't a ScopedId.

;183 schema_ref_or_rename = [ general_schema_alias_id ':' ] general_schema_ref .
(defparse2-p14 :schema_ref_or_rename ()
  (let (alias name)
  (cl:if (eql #\: (peek-token stream 2)) 
      (progn (setf alias (read-token stream))
	     (read-token stream)
	     (setf name (read-token stream)))
    (setf name (read-token stream)))
  (cl:if alias 
	 (cl:list alias name)
	 (cl:list name name))))

;184 schema_view_body_element = function_decl | procedure_decl | view_decl | rule_decl .
(defparse2-p14 :schema_view_body_element ()
  (ecase (peek-token stream)
    (function  (parse :function_decl))
    (procedure (parse :procedure_decl))
    (view      (parse :view_decl))
    (rule      (parse :rule_decl))))

;185 schema_view_body_element_list = schema_view_body_element { schema_view_body_element } .
(defparse2-p14 :schema_view_body_element_list ()
  (cons (parse :schema_view_body_element) 
	(loop until (check-token 'end_schema_view stream)
	      collect (parse :schema_view_body_element))))

;186 schema_view_decl = 'schema_view' schema_view_id ';' { reference_clause } [ constant_decl ]
;    schema_view_body_element_list 'end_schema_view' ';' .
(defparse2-p14 :schema_view_decl ()
      (assert-token 'schema_view stream)
      (with-instance (|MappingSchema| :find-force *scope*)
	(setf |name| (parse :schema_view_id))
	(assert-token #\; stream)
	(loop while (check-token 'reference stream)
	      do (parse :reference_clause))
	(when (check-token 'constant stream) (parse :constant_decl))
	(parse :schema_view_body_element_list)
	(assert-token 'end_schema_view stream)
	(assert-token #\; stream)))

;187 schema_view_id = simple_id .
(defparse2-p14 :schema_view_id ()
  (cl:string (read-token stream))) ; This one isn't a ScopedId.

;188 selector = expression . p1114
;189 set_type = 'set' [ bound_spec ] 'of' base_type . p1114
;190 simple_expression = term { add_like_op term } . p1114

;191 simple_factor = aggregate_initializer | entity_constructor | enumeration_reference | interval
;    | query_expression | ( [ unary_op ] ( '(' expression ')' | primary ) ) | case_expr | for_expr
;    | if_expr .

;; ent_cont = [ schema_ref '.' ] entity_ref '(' ... ')'
;; enum_ref = [ [ schema_ref '.' ] type_ref '.' ] enumeration_ref
;; primary  = literal
;;          = qualifiable_factor { qualifier }
;; qual_fact = 
;; primary = attribute_ref       = simple_id
;; primary = view_attribute_ref  = simple_id
;; primary = general_or_map_call = simple_id [ '@' map_call ]
;; primary = constant_factor     = built_in_const | constant_ref
;; primary = function_call       = fun-name [ '(' ...
;; primary = population          = [ schema_ref '.' ] entity_ref
;; primary = view_call           = [ schema_ref '.' ] view_ref [ part_qual ] '(' ...
(defparse2-p14 :simple_factor ()
  (let (val pmn)
    (cl:case (peek-token stream)
      (#\[   (setf val (parse :aggregate_initializer)))
      (#\{   (setf val (parse :interval)))
      (query (setf val (parse :query_expression)))
      (case  (setf val (parse :case_expr)))
      (for   (setf val (parse :for_expr)))
      (if    (setf val (parse :if_expr)))
      (#\(   (assert-token #\( stream)
	     (setf val (parse :expression))
	     (assert-token #\) stream))
      ((#\+ #\- not)
       (setf pmn (parse :unary_op))
       (cl:if (check-token #\( stream)
	      (progn (read-token stream)
		     (setf val (parse :expression))
		     (assert-token #\) stream))
	      (setf val `(,pmn (parse :primary)))))
      (t (let ((schema? (peek-token stream)))
	   (cond ((schema-p schema?) ; POD what is going on here?
		  (let ((item (peek-token stream))
			(extra (peek-token stream 3)))
		  (cond ((cl:and (entity-p item) (eql #\( extra)) ; 2007 was (schema-scope)
			 (setf val (parse :entity_constructor)))
			((type-p item) ; 2007 was (schema-scope)
			 (setf val (parse :enumeration_reference)))
			(t (setf val (parse :primary))))))
		 (t (setf val (parse :primary)))))))
    val))

;192 simple_types = binary_type | boolean_type | integer_type | logical_type | number_type
;    | real_type | string_type . p1114
;193 skip_stmt = 'skip' ';' . p1114

; 2007 POD not used?
;194 source_attribute_reference = parameter_ref '.' ( attribute_ref | view_attribute_ref ) .

;195 source_entity_reference = entity_reference .
(defparse2-p14 :source_entity_reference ()
  (parse :entity_reference))

;196 source_parameter = source_parameter_id ':' extent_reference .
(defparse2-p14 :source_parameter ()
  (let* ((id (make-scoped-id (read-token stream)))
	 (source-param (find id (%variables *scope*) :key #'%id)))
    (unless source-param (expo-parse-error :text "Could not find source parameter ~A" id))
    (assert-token #\: stream)
    (let ((*scope* (schema-mm *source-schema*)))
      (setf (%formal-parameter-type source-param) (parse :extent_reference)))
    source-param))

;;; Don't implement this, since parameter_id creates a |Parameter| and we
;;; create the a subclass of that above. 
;199 source_parameter_id = parameter_id .


;198 stmt = assignment_stmt | case_stmt | compound_stmt | escape_stmt | if_stmt | null_stmt
;    | procedure_call_stmt | repeat_stmt | return_stmt | skip_stmt .  p1114
;199 string_type = STRING [ width_spec ] . p1114
;200 string_type = 'string' [ width_spec ] . p1114
;201 subsuper = [ supertype_constraint ] [ subtype_declaration ] . p1114

;;; This one doesn't have a FROM (it's in the supertype). 
;202 subtype_binding_header = [ PARTITION partition_id ';' ] where_clause .
(defparse2-p14 :subtype_binding_header ()
  (let (partition-id predicate)
    (when (check-token 'partition stream)
      (read-token stream)
      (setf partition-id (parse :partition_id))
      (assert-token #\; stream))
    (setf predicate (parse :where_clause))
    (cl:list partition-id predicate)))

;203 subtype_constraint = 'of' '(' supertype_expression ')' . p1114

;204 subtype_declaration = 'subtype' 'of' '(' view_ref { ',' view_ref } ')' .
(defparse2-p14 :subtype_declaration ()
  (let (views)
    (assert-token 'subtype stream)
    (assert-token 'of stream)
    (assert-token #\( stream)
    (setf views
	  (cons (parse :view_ref) 
		(loop while (check-token #\, stream)
		      collect (parse :view_ref))))
    (assert-token #\) stream)
    views))

;205 supertype_constraint = abstract_supertype_declaration | supertype_rule .
(defparse2-p14 :supertype_constraint ()
  (ecase (peek-token stream)
    (abstract  (parse :abstract_supertype_declaration))
    (supertype (parse :supertype_rule))))

;206 supertype_expression = supertype_factor { 'andor' supertype_factor } . p1114
;207 supertype_factor = supertype_term { 'and' supertype_term } . p1114
;208 supertype_rule = SUPERTYPE [ subtype_constraint ] . p1114
;209 supertype_term = view_ref | one_of | '(' supertype_expression ')' . p1114

;210 syntax_x = schema_map_decl | schema_view_decl .
(defparse2-p14 :syntax_x ()
  (ecase (peek-token stream)
    (schema_map  (parse :schema_map_decl))
    (schema_view (parse :schema_view_decl))))

;211 target_entity_reference = entity_reference { '&' entity_reference } .
(defparse2-p14 :target_entity_reference ()
  (cons (parse :entity_reference)
	(loop while (check-token #\& stream)
	      collect (parse :entity_reference))))

;;; See :source_parameter, similar
;212 target_parameter = target_parameter_id { ',' target_parameter_id }
;    ':' [ 'aggregate' [ bound_spec ] 'of' ] target_entity_reference .
(defparse2-p14 :target_parameter ()
  (let* ((id (make-scoped-id (read-token stream)))
	 (target-var (find id (%variables *scope*) :key #'%id)))
    (unless target-var (expo-parse-error :text "Could not find target variable ~A" id))
    (assert-token #\: stream)
    (let ((*scope* (schema-mm *target-schema*)))
      (setf (%variable-type target-var) (parse :parameter_type :local-p t)))
    (when (typep (%variable-type target-var) '|ScopedId|) (break "huh2?"))
    target-var))

;;; You don't want to (parse :parameter_id) or :variable_id that makes a |Parameter|, etc.
;215 target_parameter_id = simple_id ';'  


;215 term = factor { multiplication_like_op factor } . p1114
;216 type_id = simple_id . p1114
;217 type_label = type_label_id | type_label_ref . p1114
;218 type_label_id = simple_id . p1114

;219 type_reference = [ schema_ref '.' ] type_ref .
(defparse2-p14 :type_reference ()
  (when (eql #\. (peek-token stream 2))
    (read-token stream)
    (read-token stream))
  (parse :type_ref))

;220 unary_op = '+' | '-' | 'not' . p1114
;221 until_control = 'until' logical_expression . p1114
;222 variable_id = simple_id . p1114

#|

;223 view_attribute_decl = view_attribute_id ':' [ 'optional' ] [ source_schema_ref '.' ]
;    base_type ':=' expression ';' .
(defparse2-p14 :view_attribute_decl ()
  (with-instance ('view-attribute)
    (setf (id *def*) (parse :view_attribute_id))
    (assert-token #\: stream)
    (when (check-token 'optional stream)
      (setf (optional-p *def*) t))
    (let ((schema (read-token stream)))
      (cl:if (check-token #\. stream)
	     (setf (type-schema *def*) schema)
	     (unread-token schema stream)))
    (setf (base-type *def*) (parse :base_type))
    (assert-token :colon-equal stream)
    (setf (expression *def*) (parse :expression))
    (assert-token #\; stream)))

;224 view_attribute_id = simple_id .
(defparse2-p14 :view_attribute_id ()
  (parse :simple_id))

;225 view_attr_decl_stmt_list = view_attribute_decl { view_attribute_decl } .
(defparse2-p14 :view_attr_decl_stmt_list ()
  (slot-insert (parse :view_attribute_decl) *def* 'view-attrs)
  (loop until (member (peek-token stream) '(partition end_view))
	do (slot-insert (parse :view_attribute_decl) *def* 'view-attrs)))

;226 view_call = view_reference [ partition_qualification ] '(' [ expression_or_wild
;    { ',' expression_or_wild } ] ')' .
(defparse2-p14 :view_call ()
  (with-instance ('view-call)
    (setf (view *def*) (parse :view_reference))
    (when (check-token #\\ stream)
      (parse :partition_qualification))
    (assert-token #\( stream)
    (unless (check-token #\) stream)
      (slot-insert (parse :expression_or_wild) *def* 'args)
      (loop while (check-token #\, stream)
	    do (slot-insert (parse :expression_or_wild) *def* 'args)))
    (assert-token #\) stream)))

;227 view_decl = 'view' view_id [ ':' base_type ] subsuper ';'
;    ( view_sub_partition { view_sub_partition } )
;  | ( view_partition { view_partition } ) 'end_view' ';' .
(defparse2-p14 :view_decl ()
  (with-instance ('view :%%parent *scope* :%%schema (schema-scope))
    (let ((*definition* *def*))
      (assert-token 'view stream)
      (setf (id *def*) (parse :view_id))
      (dbg-message :parser nil "V")
      (dbg-message :parser  0  "~&View ~A~%" (id *def*))
      (when (check-token #\: stream)
	(setf (base-type *def*) (parse :base_type)))
      (let ((subp (parse :subsuper)))
	(assert-token #\; stream)
	(cl:if (eql subp :sub)
	       (loop initially (slot-insert (parse :view_sub_partition) *def* 'partitions)
		     until (member (peek-token stream) '(partition end_view))
		     do (slot-insert (parse :view_sub_partition) *def* 'partitions))
	       (loop initially (slot-insert (parse :view_partition) *def* 'partitions)
		     until (member (peek-token stream) '(partition end_view))
		     do (slot-insert (parse :view_partition) *def* 'partitions))))
      (assert-token 'end_view stream)
      (assert-token #\; stream))))

; view_sub_partition = subtype_binding_header view_project_clause .
(defparse2-p14 :view_sub_partition ()
  (with-instance ('sub-view-partition)
    (setf (%%container *def*) *definition*)
    (parse :subtype_binding_header)
    (setf (body *def*) (parse :view_project_clause))))

; view_partition = binding_header view_project_clause .
(defparse2-p14 :view_partition ()
  (with-instance ('view-partition)
    (setf (%%container *def*) *definition*)
    (parse :binding_header)
    (setf (body *def*) (parse :view_project_clause))))

;228 view_id = simple_id .
(defparse2-p14 :view_id ()
  (parse :simple_id))

;229 view_project_clause = ( 'select' view_attr_decl_stmt_list ) | ( 'return' expression ) .
(defparse2-p14 :view_project_clause ()
  (ecase (read-token stream)
    (select
     (with-instance ('view-select)
       (parse :view_attr_decl_stmt_list)))
    (return
     (with-instance ('view-return)
       (setf (expression *def*) (parse :expression))))))

;230 view_reference = [ ( schema_map_ref | schema_view_ref ) '.' ] view_ref .
(defparse2-p14 :view_reference ()
  (with-instance ('view-reference)
    (setf (object *def*) (read-token stream))
    (when (check-token #\. stream)
      (setf (schema *def*) (object *def*))
      (setf (object *def*) (read-token stream)))))
|#

;231 where_clause = 'where' domain_rule ';' { domain_rule ';' } . p1114
(defparse2-p14 :where_clause ()
  (assert-token 'where stream)
    (let ((p11p::*p14-force-scope* (schema-mm *source-schema*)))
      (cons (prog1 (parse :domain_rule) (assert-token #\; stream))
	    (loop until (check-token 'select stream)
		  collect (second (parse :domain_rule))
		  do (assert-token #\; stream)))))

;232 while_control = 'while' logical_expression . p1114
;233 width = numeric_expression . p1114
;234 width_spec = '(' width ')' [ 'fixed' ] . p1114
