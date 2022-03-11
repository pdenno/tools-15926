(in-package :P21P)

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

(defclass p21-stream (token-stream)
  ((read-fn :initform #'p21-reader)))

(defvar *def* "Bound to current object definition.")

(defun make-p21-stream (stream)
  (make-instance 'p21-stream :stream stream))

;; unread-token defined by token-stream
;; peek-token defined by token-stream

(defmethod parse-data-pod7 ((path pathname) pass (tag (eql :p21)) &rest args)
  (with-open-file (char-stream path :direction :input)
    (with-open-stream (stream (make-p21-stream char-stream))
      (apply #'parse-data-pod7 stream pass :file args))))


(defmacro defparse-p21 (dtag (stream &rest dkeys) &body body)
  `(progn
     ;; bookkeeping forms
     (defmethod parse-data-pod7 ((,stream p21-stream) (pass (eql :pass))
			    (tag (eql ',dtag)) &key ,@dkeys)
       (macrolet ((parse (tag &key keys)
		    `(parse-data-pod7 ,',stream pass ,tag ,@keys))
		  (assert-token (token)
		    (let ((tkn (make-symbol "TKN")))
		      `(let ((,tkn (read-token ,',stream)))
			 (unless (eql ,tkn ,token)  
                           (error 'expo::p21-parse-error  :tag tag :expected ,token :actual ,tkn)))))
		  (with-instance ((type &key keys) &body body)
		    `(let ((*def* (make-instance ,type ,@keys)))
		       ,@body
		       *def*)))
	 ,@body))))

(defun p21-read (&rest args)
  (let ((*package* *p21p-pkg*)
	(*readtable* *p21-readtable*))
    (apply #'read args)))

(defmethod peek-token ((stream p21-stream) &optional (ahead 1))
  (with-slots (expo::tokens) stream
    (cl:or (nth (1- ahead) expo::tokens)
	   (loop for i from (cl:length expo::tokens) to (1- ahead)
		 for tkn = (read-token stream :pop-ok nil) do
		 (setf expo::tokens (append expo::tokens (cl:list tkn)))
		 finally (cl:return tkn)))))

#| PODsampson interferring with parser-utils???
(defun check-token (token stream &optional disposition)
  ;; if disposition is :peek, token is left in the stream
  (when (eql (peek-token stream) token)
    (unless (eql disposition :peek)
      (read-token stream))
    t))
|#

(defmethod parse-data-pod7 :before ((stream p21-stream) (pass (eql :pass)) tag &key)
  (dbg-message :parser 5 "~&Entering ~A [~S]...~%" tag (peek-token stream)))

(defmethod parse-data-pod7 :after ((stream p21-stream) (pass (eql :pass)) tag &key)
  (dbg-message :parser 5 "~&Exiting ~A [~S]...~%" tag (peek-token stream)))

;; call the top-level grammar rule
(defmethod parse-data-pod7 ((stream p21-stream) (pass (eql :pass)) (tag (eql :file)) &rest opts)
  (apply #'parse-data-pod7 stream pass 'exchange_file opts))

;; from iso-10303-21:1994

;; grammar

; data_section = 'DATA' ';' entity_instance_list 'ENDSEC' ';' .
(defparse-p21 data_section (stream)
  (let (datasec)
    (assert-token 'data)
    (assert-token #\;)
    (setf datasec (parse 'entity_instance_list))
    (assert-token 'endsec)
    (assert-token #\;)
    datasec))

; entity_instance = entity_instance_name '=' [ scope ] ( simple_record | subsuper_record ) ';' .
; simple_record   = keyword '(' [ parameter_list ] ')' .
; subsuper_record = '(' simple_record_list ')' .
(defparse-p21 entity_instance (stream no-convert)
  (with-instance ('p21-instance)
    (setf (name *def*) (parse 'entity_instance_name))
    (assert-token #\=)
    (when (check-token #\& stream :peek)
      (setf (scope *def*) (parse 'scope)))
    (cl:case (peek-token stream)
      (#\( (setf (records *def*) (parse 'subsuper_record)))
      (t   (push (parse 'simple_record) (records *def*))))
    (assert-token #\;)
    (unless no-convert
      (expo:convert-data *def* *dataset*))))

; entity_instance_list = entity_instance { entity_instance } .
(defparse-p21 entity_instance_list (stream)
  (let (ents)
    (push (parse 'entity_instance) ents)
    (loop while (check-token #\# stream :peek)
	  do (push (parse 'entity_instance) ents))
    (nreverse ents)))

; entity_instance_name = '#' digit { digit } .
;; just return the "digit { digit }" portion
(defparse-p21 entity_instance_name (stream)
  (assert-token #\#)
  (read-token stream))

; enumeration = '.' upper { upper | digit } '.' .
(defparse-p21 enumeration (stream)
  (pod:kintern (string-trim "." (read-token stream))))

; exchange_file = 'ISO-10303-21' ';' header_section data_section 'END-ISO-10303-21' ';' .
(defparse-p21 exchange_file (stream)
  (with-instance ('p21-data)
    (assert-token 'iso-10303-21)
    (assert-token #\;)
    (setf (header *def*)  (parse 'header_section))
    ;; add known header entities to *dataset*
    (loop for ent in (header *def*)
	  for rec = (first (records ent))
	  do (cl:case (entity rec)
	       (file_description
		(setf (expo::file-description *dataset*)
		      (first (first (parameters rec)))))
	       (file_name
		(setf (expo::filename *dataset*)
		      (first (parameters rec))))
	       (file_schema
		(let* ((schema-name (first (first (parameters rec))))
		       (schema (expo:find-schema schema-name)))
		  (unless schema
		    (expo:expo-parse-error
		      :text
		       "The Part 21 file references a FILE_SCHEMA~%'~A',~%but no such schema is loaded." 
		       schema-name))
		  (setf (expo::schema expo::*expresso*) schema)
		  (setf (expo::file-schema *dataset*) schema-name)))
	       ;; ignore all others
	       (t (dbg-message :parser 2 "~&P21 header entity ~A not recognized"
				    (entity rec)))
	       ))
    (setf (datasec *def*) (parse 'data_section))
    (assert-token 'end-iso-10303-21)
    (assert-token #\;)))

; export_list = '/' entity_instance_name { ',' entity_instance_name } '/' .
(defparse-p21 export_list (stream)
  (let (names)
    (assert-token #\/)
    (push (with-instance ('p21-entity-ref)
	    (setf (entity-name *def*) (parse 'entity_instance_name)))
	  names)
    (loop while (check-token #\, stream)
	  do (push (with-instance ('p21-entity-ref)
		     (setf (entity-name *def*) (parse 'entity_instance_name)))
		   names))
    (assert-token #\/)
    (nreverse names)))

; header_entity = keyword '(' [ parameter_list ] ')' ';' .
(defparse-p21 header_entity (stream)
  (with-instance ('p21-instance)
    (setf (records *def*)
	  (cl:list (with-instance ('p21-record)
		     (setf (entity *def*) (read-token stream))
		     (assert-token #\()
		     (unless (check-token #\) stream :peek)
		       (setf (parameters *def*) (parse 'parameter_list)))
		     (assert-token #\)))))
    (assert-token #\;)))

; header_entity_list = { header_entity } .
(defparse-p21 header_entity_list (stream)
  (loop until (check-token 'endsec stream :peek)
	collect (parse 'header_entity)))

; header_section = 'HEADER' ';' header_entity header_entity header_entity header_entity_list 'ENDSEC' ';' .
(defparse-p21 header_section (stream)
  (let (ents)
    (assert-token 'header)
    (assert-token #\;)
    (push (parse 'header_entity) ents)
    (push (parse 'header_entity) ents)
    (push (parse 'header_entity) ents)
    (loop for ent in (parse 'header_entity_list)
	  do (push ent ents))
    (assert-token 'endsec)
    (assert-token #\;)
    (nreverse ents)))

; list = '(' [ parameter_list ] ')' .
(defparse-p21 list (stream)
  (let (list)
    (assert-token #\()
    (unless (check-token #\) stream :peek)
      (setf list (parse 'parameter_list)))
    (assert-token #\))
    list))

; parameter = typed_parameter | untyped_parameter | omitted_parameter .
;  typed_p = keyword '(' parameter ')'
;  untyped_p = '$' | integer | real | string | entity_i_name | enum | binary | '(' [ param_list ] ')'
;  omitted_p = '*'
(defparse-p21 parameter (stream)
  (typecase (peek-token stream)
    (character 
     (ecase (peek-token stream)
       (#\*
	(read-token stream)		;eat '*' and return :* instead
	:*)
       (#\$ (parse 'untyped_parameter))
       (#\# (parse 'untyped_parameter))
       (#\( (parse 'untyped_parameter))))
    (cl:number (parse 'untyped_parameter))
    (cl:string (parse 'untyped_parameter))
    (t (cl:if (char= (char (cl:string (peek-token stream)) 0) #\.)
	      (parse 'enumeration)
	      (parse 'typed_parameter)))))

; parameter_list = parameter { ',' parameter } .
(defparse-p21 parameter_list (stream)
  (let (params)
    (push (parse 'parameter) params)
    (loop while (check-token #\, stream)
	  do (push (parse 'parameter) params))
    (nreverse params)))

; scope = '&' 'SCOPE'  entity_instance_list 'ENDSCOPE' [ export_list ] .
(defparse-p21 scope (stream)
  (with-instance ('p21-scope)
    (assert-token #\&)
    (assert-token 'scope)
    (setf (instances *def*) (parse 'entity_instance_list))
    (assert-token 'endscope)
    (when (check-token #\/ stream :peek)
      (setf (exports *def*) (parse 'export_list)))))

; simple_record = keyword '(' [ parameter_list ] ')' .
(defparse-p21 simple_record (stream)
  (with-instance ('p21-record)
    (setf (entity *def*) (read-token stream))	;keyword
    (assert-token #\()
    (unless (check-token #\) stream :peek)
      (setf (parameters *def*) (parse 'parameter_list)))
    (assert-token #\))))

; simple_record_list = simple_record { simple_record } .
(defparse-p21 simple_record_list (stream)
  (let (recs)
    (push (parse 'simple_record) recs)
    (loop until (check-token #\) stream :peek)
	  do (push (parse 'simple_record) recs))
    (nreverse recs)))

; subsuper_record = '(' simple_record_list ')' .
(defparse-p21 subsuper_record (stream)
  (let (records)
    (assert-token #\()
    (setf records (parse 'simple_record_list))
    (assert-token #\))
    records))

; typed_parameter = keyword '(' parameter ')' .
(defparse-p21 typed_parameter (stream)
  (with-instance ('p21-typed-parameter)
    (setf (param-type *def*) (read-token stream))	;keyword
    (assert-token #\()
    (setf (param-value *def*) (parse 'parameter))
    (assert-token #\))))

; untyped_parameter = '$' | integer | real | string | entity_instance_name | enumeration | binary | list .
;; '$'
;; entity_instance_name ( '#' digit { digit })
;; list                 ( '(' [ parameter_list ] ')' )
;; integer              ( [ sign ] digit { digit } )
;; real                 ( [ sign ] digit { digit } '.' { digit } [ 'E' [ sign ] digit { digit } ] )
;; string               ( '''' <stuff> '''' )
;; enumeration          ( '.' upper { upper | digit } '.' )
;; binary               ( '"' ( '0' | '1' | '2' | '3' ) { hex } '"' )
(defparse-p21 untyped_parameter (stream)
  (typecase (peek-token stream)
    (character (ecase (peek-token stream)
		 (#\$
		  (read-token stream)	;eat '$' and return :? instead
		  :?)
		 (#\# (with-instance ('p21-entity-ref)
			(setf (entity-name *def*) (parse 'entity_instance_name))))
		 (#\( (parse 'list))))
    (cl:number (read-token stream))
    (cl:string (read-token stream))
    (t (cond ((char= (char (string (peek-token stream)) 0) #\.)
	      (parse 'enumeration))
	     (t (expo:expo-parse-error :text "The token '~S' was not handled" (peek-token stream)))))))
