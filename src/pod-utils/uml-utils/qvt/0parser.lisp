
(in-package :qvt)

;;; Purpose: Parse to scan for and catalog relation and function names.

;;; <topLevel> ::= ('import' <unit> ';' )* <transformation>*
;;; Returns *scope* object (a qvt-population).
(defparse |topLevel0| ()
    (loop while (eql (peek-token stream) '|import|)
	  do (read-token stream)
	  (parse |unit0|)
	  do (assert-token #\; stream))
    (let ((result (parse |transformation0|))
	  (tkn (read-token stream)))
      (unless (eql :eof tkn)
	(error "Line ~A: Tokens remaining after completion of parse: ~A."
	       *line-number* tkn))
      result))

;;; <unit> ::= <identifier> ('.' <identifier>)*
(defparse |unit0| ()
  (loop until (eql #\; (peek-token stream))
	do (add-type (read-token stream) *scope* :import-unit)
	when (eql #\. (peek-token stream))
	do (read-token stream)
        when (eql (peek-token stream) :eof) 
        do (error 'qvt-premature-eof :tags *tags-trace*)))

;;; <transformation> ::= 'transformation' <identifier>
;;;                      '(' <modelDecl> (',' <modelDecl>)* ')'
;;;                       ['extends' <identifier>]
;;;                      '{' <keyDecl>* ( <relation> | <query> )* '}'
(defparse |transformation0| ()
  (assert-token '|transformation| stream)
  (let ((model-name (read-token stream)))
    (setf *scope* (mofi:ensure-model model-name :force t
				:model-class 'qvt-population
				:package-use-list '(:cl :pod :ocl :mofi :tr :qvt)  
				:model-n+1 (mofi:find-model :qvt)
				:processing-results (make-instance 'mofi:processing-results)
				:suppress-load t
				:%%name model-name :%%type :transformation))
    (with-slots (qvt-map-model) *map-info*
      (setf qvt-map-model *scope*)))
  (setf mofi:*model* *scope*)
  (setf mofi:*population* *scope*)
  (assert-token #\( stream)
  (loop until (eql #\) (peek-token stream))
	do (parse |modelDecl0|)
	when (eql #\, (peek-token stream)) do (read-token stream)
        when (eql (peek-token stream) :eof) do (error 'qvt-premature-eof :tags *tags-trace*))
  (read-token stream)
  (when (eql '|extends| (peek-token stream))
    (read-token stream)
    (read-token stream))
  (assert-token #\{ stream)
  (loop while (eql '|key| (peek-token stream))
	do (parse |keyDecl0|))
  (loop until (eql #\} (peek-token stream))
	for peek = (peek-token stream) 
	if (or (eql '|top| peek) (eql '|relation| peek)) do (parse |relation0|)
	else if (eql '|query| peek)  do (parse |queryDecl0|)
        else if (eql :eof peek) do (return-from parse-data *scope*)
	else do (error 'qvt-parse-error 
		       :tags *tags-trace*
		       :expected "'top' 'relation' 'query' or '}'"
		       :actual peek))
  (read-token stream)
  *scope*)

;;; Example: transformation umlToRdbms (uml:SimpleUML, rdbms:SimpleRDBMS)
;;; Note that uml and rdbms are identifiers introduce here.
;;; <modelDecl> ::= <modelId> ':' ( <metaModelId> | '{' <metaModelId> (',' <metaModelId>)* '}' )
(defparse |modelDecl0| ()
  (let ((|name| (parse |modelId|)) ; not zero, ok
	|usedPackage|)
    (add-type |name| *scope* :model)
    (assert-token #\: stream)
    (if (eql #\{ (peek-token stream)) ; POD Not sure about this interpretation.
	(progn
	  (error "Line ~A: POD doesn't know how to interpret <modelId> : { ..." *line-number*)
	  (read-token stream)
	  (loop until (eql #\} (peek-token stream))
		do (parse |metaModelId|) ; not zero
		when (eql #\, (peek-token stream)) do (read-token stream)
                when (eql (peek-token stream) :eof) do (error 'qvt-premature-eof :tags *tags-trace*))
	  (read-token stream))
	(setf |usedPackage| (parse |metaModelId|)))
    ;; POD additional metaModelID not implemented (Undocumented in spec?). 
    ;; Probably means packages nested in first metaModelId.
    (if-bind (model (mofi:find-model |usedPackage| :error-p nil))
	     (progn (push (cons |name| model) (qvt-nicknames *map-info*))
		    (pushnew model oclp:*in-scope-models*))
	     (error "Line ~A: No model with name ~A, while parsing in modelDecl0." 
		    *line-number* |name|))))

;;; POD Bugs in QVT Grammar: Is it '{' as grammar shows, or '(' like example shows. I like '('.
;;; <keyDecl> ::= 'key' <classId> '{' <propertyId> (, <propertyId>)* '}' ';'
(defparse |keyDecl0| ()
  (assert-token '|key| stream)
  (read-token stream)
  (assert-token #\( stream)
  (loop until (eql #\) (peek-token stream))
		do (parse |propertyId|) ; pod, may wish to ensure this is a model property.
		when (eql #\, (peek-token stream))
		do (read-token stream)
                when (eql (peek-token stream) :eof) 
                do (error 'qvt-premature-eof :tags *tags-trace*))
  (read-token stream)
  (assert-token #\; stream))

;;; POD 2012 Added! I don't know why needed now!
(defparse |propertyId| () (read-token stream))

;;; <relation> ::= ['top'] 'relation' <identifier> 
;;;                ['overrides' <identifier>]
;;;                '{' <varDeclaration>* 
;;;                    (<domain> | <primitiveTypeDomain>)+
;;;                    [<when>] 
;;;                    [<where>] '}'
(defparse |relation0| ()
  (when (eql (peek-token stream) '|top|) (read-token stream))
  (assert-token '|relation| stream)
  (let ((|name| (read-token stream)))
    (add-type |name| *scope* :relation)
    (push (string |name|) (mofi:operator-strings *scope*))
    (let ((*scope* (make-instance '%%scope :%%name |name| :%%parent *scope* :%%type :relation)))
      (when (eql (peek-token stream) '|overrides|)
	(read-token stream)
	(read-token stream))
      (assert-token #\{ stream)
      (loop for peek = (peek-token stream)
	 until (member peek '(|primitive| |checkonly| |enforce| |domain|))
	 do (parse |varDeclaration0|)
	 when (eql peek :eof)
	 do (error 'qvt-premature-eof :tags *tags-trace*))
      (catch :done
	(loop for peek = (peek-token stream) do
	     (cond ((member peek '(|when| |where| #\})) (throw :done nil)) ; continue
		   ((member peek '(|checkonly| |enforce| |domain|)) (parse |domain0|))
		   ((eql peek '|primitive|) (parse |primitiveTypeDomain0|))
		   (t (error 'qvt-parse-error 
			     :expected "'when', 'where', 'checkonly', 'enforce', 'domain', or 'primitive'." 
			     :actual peek :tags *tags-trace*)))))
      (when (eql '|when|  (peek-token stream)) (parse |when0|))
      (when (eql '|where| (peek-token stream)) (parse |where0|))
      (assert-token #\} stream))))

;;; <varDeclaration> ::= <identifier> (, <identifier>)* ':' <TypeCS> ';'
(defparse |varDeclaration0| ()
  (loop until (eql #\: (peek-token stream))
	do (add-type (read-token stream) *scope* :variable)
	when (eql #\, (peek-token stream)) do (read-token stream)
        when (eql (peek-token stream):eof) do (error 'qvt-premature-eof :tags *tags-trace*))
  (read-token stream)
  (with-ocl-reader (parse oclp::|Type|)) 
  (assert-token #\; stream))

;;; New for 2012
(defun nick2model-type (nick &key line)
  "Return the model-type (a mofi model) corresponding to the string NICK."
  (with-vo ((map-info qvt-map-info))
    (or (cdr (assoc nick (qvt-nicknames map-info) :test #'string=))
	(if line
	    (error "Line ~A: ~% ~A does not name a modelID." line nick)
	    (error "~% ~A does not name a modelID." nick)))))

;;; <domain> ::= [<checkEnforceQualifier>] 'domain' <modelId> <template>
;;;              ['implementedby' <OperationCallExpCS>]
;;;              ['default_values' '{' (<assignmentExp>)+ '}'] ';'
(defparse |domain0| ()
  (let* ((check/enforce (parse |checkEnforceQualifier0|))
	 (model-id (progn (assert-token '|domain| stream) (parse |modelId|))))
       ;; POD I think it is a limitation of my tool that enforce/checkonly is at 
       ;; the granularity of the transformation. 
       (with-slots (source-model target-model) (%%parent *scope*) ; the mofi:model
	 (case check/enforce
	   (:checkonly (setf source-model (nick2model-type model-id :line *line-number*)))
	   (:enforce (setf target-model (nick2model-type model-id  :line *line-number*)))))
    (let ((*scope* (make-instance '%%scope 
				  :%%name model-id  ; "uml" , "owl" won't be unique, of course.
				  :%%parent *scope* 
				  :%%type :template
				  :%%package (nick2model-type model-id))))
      (parse |template0|)
      (when (eql '|implementedby| (peek-token stream))
	(read-token stream)
	(parse |OperationCallExpCS|)) ; POD This isn't defined in my OCL!
      (when (eql '|default_values| (peek-token stream))
	(read-token stream)
	(assert-token #\{ stream)
	(loop until (eql #\} (peek-token stream))
	      do (parse |assignmentExp0|)
              when (eql (peek-token stream) :eof) 
              do (error 'qvt-premature-eof :tags *tags-trace*))
	(assert-token #\} stream))
      (assert-token #\; stream))))

;;; <primitiveTypeDomain> ::= 'primitive' 'domain' <identifier> ':' <TypeCS> ';'
(defparse |primitiveTypeDomain0| ()
  (assert-token '|primitive| stream)
  (assert-token '|domain| stream)
  (add-type (read-token stream) *scope* :variable)
  (assert-token #\: stream)
  (with-ocl-reader (parse oclp::|Type|))
  (assert-token #\; stream))

;;; <checkEnforceQualifier> ::= 'checkonly' | 'enforce'
(defparse |checkEnforceQualifier0| ()
  (let ((peek (peek-token stream)))
    (cond ((eql peek '|checkonly|) (read-token stream) :checkonly)
	  ((eql peek '|enforce|)   (read-token stream) :enforce)
	  (t :checkonly))))

;;;  <template> ::= ( <objectTemplate> | <collectionTemplate> ) ['{' <OclExpressionCS> '}']
(defparse |template0| ()
  (let ((peek2 (peek-token stream 2))
	(peek3 (peek-token stream 3)))
    ;; Identifier in collectionTemplate is optional thus:
    (if (or (member peek3 '("Collection" "Bag" "OrderedSet" "Sequence" "Set") :test #'string=)
	    (member peek2 '("Collection" "Bag" "OrderedSet" "Sequence" "Set") :test #'string=))
	(parse |collectionTemplate0|)
	(parse |objectTemplate0|))
    (when (eql #\{ (peek-token stream))
      (read-token stream)
      (loop for tkn = (read-token stream) with count = 1
	 when (eql tkn #\}) do (decf count)
	 when (eql tkn #\{) do (incf count)
         when (eql tkn :eof) do (error 'qvt-premature-eof :tags *tags-trace*)
	 when (zerop count) return nil))))

(defun propagate-to-relation (name scope type)
  "add-type of NAME to SCOPE and every scope upward."
  (with-slots (%%parent %%type) scope
    (when (null %%parent) (error "Line ~A: No relation within scope." *line-number*))
    (unless (token-is name type scope) ; 2014
      (add-type name scope :variable)
      (unless (eql :relation %%type)
	(propagate-to-relation name %%parent type)))))

;;;  <objectTemplate>     ::= [ <variable> ] ':' <PathNameCS> '{' [ <propertyTemplateList> ] '}'  <--- SPEC
;;;  <objectTemplate>     ::= [ <variable> ] ':' <PathNameCS> [ <propertyTemplateList> ]          <----ME
(defparse |objectTemplate0| ()
  (when (eql #\: (peek-token stream 2))
    (propagate-to-relation (read-token stream) *scope* :variable))
  (assert-token #\: stream) ; always have the colon -- to disambiguate from OCL.
  (with-ocl-reader (parse oclp::|PathName|))
  (when (eql #\{ (peek-token stream))
    (parse |propertyTemplateList0|)))

;;;  <propertyTemplateList> ::= <propertyTemplate> (',' <propertyTemplate>)*              <--- SPEC
;;;  <propertyTemplateList> ::= '{' [ <propertyTemplate> ] (',' <propertyTemplate>)* '}'  <--- ME
(defparse |propertyTemplateList0| ()
  (assert-token #\{ stream)
  (unless (eql #\} (peek-token stream))
    (parse |propertyTemplate0|)
    (loop for peek = (peek-token stream)
       while (eql #\, peek)
       do (read-token stream)
	 (parse |propertyTemplate0|)))
  (assert-token #\} stream))

;;; <propertyTemplate> ::= <identifier>  '=' ( <template> | <OclExpression> )
;;;            | 'opposite' '(' <classId> . <identifier> ')'
;;;                    '=' ( <template> | <OclExpression> )
(defparse |propertyTemplate0| ()
  (let ((peek (peek-token stream)))
    (cond ((eql '|opposite| peek)
	   (parse |opposite0|) 
	   (assert-token #\= stream)
	   (let ((peek1 (peek-token stream))
		 (peek2 (peek-token stream 2)))
	     (if (or (eql #\: peek1) (eql #\: peek2)) ; Is this sufficient to know that it isn't an...
		 (parse |template0|)                  ; ...OCL expression? Probably not!
		 (with-ocl-reader (parse oclp::|OclExpression|)))))
	  (t
	   (add-type (read-token stream) *scope* :attribute) 
	   (assert-token #\= stream)
	   (let ((peek1 (peek-token stream))
		 (peek2 (peek-token stream 2)))
	     (if (or (eql #\: peek1) (eql #\: peek2)) ; peek2 because collectionTemplate (' var Set :' etc.)
		 (parse |template0|)
		 (progn (add-type (peek-token stream) *scope* :variable)  ;2014                  
			(add-type (peek-token stream) (%%parent *scope*) :variable)  ;2014                  
			(with-ocl-reader (parse oclp::|OclExpression|)))))))))

;;; POD added this one for convenience
;;; <opposite> =  'opposite '(' <classId> . <identifier> ') 
(defparse |opposite0| ()
  (assert-token '|opposite| stream) 
  (assert-token #\( stream)
  (read-token stream)
  (assert-token #\. stream)
  (read-token stream)
  (assert-token #\) stream))

;;; <collectionTemplate> ::= [<identifier>] ':' <CollectionTypeIdentifierCS> 
;;;                         '(' <TypeCS> ')' '{' [<memberSelection>] '}'
(defparse |collectionTemplate0| ()
  (when (eql #\: (peek-token stream 2))
    (propagate-to-relation (read-token stream) *scope* :variable))
  (assert-token #\: stream) ; always have the colon -- to disambiguate from OCL.
  (with-ocl-reader
    (parse oclp::|CollectionTypeIdentifier|))
  (assert-token #\( stream)
  (with-ocl-reader
    (parse oclp::|Type|))
  (assert-token #\) stream)
  (assert-token #\{ stream)
  (unless (eql #\} (peek-token stream))
     (parse |memberSelection0|))
  (assert-token #\} stream))

;;; POD I'm making the ++ part optional. 
;;; <memberSelection> ::= (<identifier> | <template> | '_') 
;;;                       (',' (<identifier> | <template> | '_'))* '++' (<identifier> | '_')
(defparse |memberSelection0| ()
  (let (tkn)
    (loop for tkn1 = (peek-token stream)
	  for tkn2 = (peek-token stream 2)
	  until (member tkn1 '(:plus-plus #\}))
	  do (cond ((or (eql tkn1 #\:) (eql tkn2 #\:)) (parse |template0|))
			((eql tkn1 #\_) :wildcard)
			(t (read-token stream))) ; identifier
	  (setf tkn (peek-token stream))
	  unless (member tkn '(:plus-plus #\, #\}))
	  do (error 'qvt-parse-error :expected "'++' '}' or ','" :actual tkn :tags *tags-trace*)
	  when (eql tkn #\,) do (read-token stream))
  (when (eql tkn :plus-plus)
    (read-token stream) ; ++
    (read-token stream))))

;;; <assignmentExp> ::= <identifier> '=' <OclExpressionCS> ';'
(defparse |assignmentExp0| ()
  (read-token stream)
  (assert-token #\= stream)
    (with-ocl-reader
      (parse oclp::|OclExpression|)))

;;; POD They need to get real! This is a either a 'RelationCalll'
;;; or a OCLExpression. These RelationCall things aren't OCL.
;;; <when> ::= 'when' '{' (<OclExpressionCS> ';')* '}'
(defparse |when0| ()
  (assert-token '|when| stream)
  (assert-token #\{ stream)
  (loop for tkn = (read-token stream) with count = 1
	when (eql tkn #\}) do (decf count)
	when (eql tkn #\{) do (incf count)
	when (zerop count) return nil
        when (eql tkn :eof) do (error 'qvt-premature-eof :tags *tags-trace*)))

;;; <where> ::= 'where' '{' (<OclExpressionCS> ';')* '}'
(defparse |where0| ()
  (assert-token '|where| stream)
  (assert-token #\{ stream)
  (let ((save-line *line-number*))
    (loop for tkn = (read-token stream) with count = 1
       when (eql tkn #\}) do (decf count)
       when (eql tkn #\{) do (incf count)
       when (zerop count) return nil
       when (eql tkn :eof) 
       do (error 'qvt-unbalanced-error 
		 :tags *tags-trace*
		 :token #\{
		 :line-start save-line))))

;;; Example: query PrimitiveTypeToSqlType(primitiveType:String) : String;
;;; POD Request that the following be added to the spec?
;;; <queryDecl>  ::= 'query' <identifier> 
;;;                     '(' [ <identifier> ':' <OCLTypeCS> (',' <identifier> ':' <OCLTypeCS>)* ] ')' 
;;;                     ':' <oclTypeCS> '{'  <OCLExpression> '}'
;;; 2015-03-13 This was called functionDecl.
(defparse |queryDecl0| ()
  (assert-token 'qvt::|query| stream)
  (let ((fname (string (read-token stream))))
    (push fname (mofi:operator-strings *scope*))
    (add-type fname *scope* :qvt-function)  ; added 2014 
    (let ((*scope* (make-instance '%%scope :%%name fname :%%parent *scope* :%%type :function))) ; added 2013
      (assert-token #\( stream)
      (loop for tkn = (peek-token stream) 
	 until (eql tkn #\))
	 do (parse |formalParam0|)
	 when (eql tkn #\,) do (read-token stream)
	 when (eql tkn :eof) do (error 'qvt-premature-eof :tags *tags-trace*))
      (read-token stream) 
      (assert-token #\: stream)
      (read-token stream) ; type, might not be sufficient?
      (assert-token #\{ stream)
      (loop for tkn = (read-token stream) with count = 1
	 when (eql tkn #\{) do (incf count)
	 when (eql tkn #\}) do (decf count)
	 when (zerop count) return nil
	 when (eql tkn :eof) do (error 'qvt-premature-eof :tags *tags-trace*)))))

;;; 2014 I made this up (including the syntax!)
;;; formalParam --> <var> : oclp:|PathName|
(defparse |formalParam0| ()
  (let (var path pkg)
    (setf var (read-token stream))
    (assert-token #\: stream) ; PathName will return something like 'uml241:|Package|
    (with-ocl-reader (setf path (parse oclp::|PathName| :symbol-only-p t)))
    (cond ((setf pkg (find (symbol-package path) 
			   (list (source-meta *map-info*)
				 (target-meta *map-info*))
			   :key #'mofi:lisp-package))
	   (add-type var *scope* :variable :package pkg))
	  ((and (symbolp path)
		(find path (mofi:types (mofi:find-model :ptypes)) :test #'string= :key #'class-name))
	   (add-type var *scope* :variable :package (mofi:find-model :ptypes)))
	  (t (error 'qvt-parse-error :expected "a PathName" :actual path :tags *tags-trace*)))))






		
	    
	    
