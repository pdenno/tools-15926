(in-package :qvt)

;;; Purpose : Parse QVT to meta-object instances. 
;;; Date : 2007-10-10

;;; To do: RelationCallExp is presumably referenced in OCL. I'll need to work it in. 

(defmacro defparse (tag (&rest keys) &body body)
   "Defines a parse-data eql method on TAG. The method macrolets parse."
   `(defmethod parse-data ((stream qvt-stream) (tag (eql ',tag)) &key ,@keys)
      (macrolet ((parse (tag &rest keys) ; the mystery solved: pass2 needs to call parse too.
			`(parse-data stream ',tag ,@keys)))
	,@body)))

(defmacro with-ocl-reader (&body body)
  `(with-other-reader (stream oclp::ocl-read) ,@body))

(defclass qvt-stream (oclp::ocl-stream) ; because it has to read ocl ??? Proabably not necessary
  ((read-fn :initform 'qvt-read)))

(defvar *zippy* nil "diagnostics")
      
(defmethod parse-data :around ((stream qvt-stream) tag &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S line=~A~%" tag args (peek-token stream) *line-number*)
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with value ~S line=~A~%" tag result *line-number*)
    (pop *tags-trace*) 
    (force-output *debug-stream*)
    result))

(defvar *def* nil "Dynamically bound to the current MM object during parsing (when with-instance is used).")

;;; This IS NOT a candidate for pod-utils. Each impementation differs (See the EXPRESS one.)
(defmacro with-instance ((type &rest init-args) &body body)
  "A macro that creates an object and provides with-slots to use it." 
  (let ((slot-names (mapcar #'clos:slot-definition-name (clos:class-slots (find-class type)))))
    ;; mofi:*population* will be bound, causing this to be pushed into *population*.members
    `(let* ((*def* (make-instance ',type ,@init-args)))
      (with-slots ,slot-names *def*
	(declare (ignorable ,@slot-names))
	(setf mofi:|token-position| (token-position *token-stream*))
	,@body
	*def*))))

;;;===================================================================
;;; T H E    Q V T   RELATIONAL  G R A M M A R   (some fixes too)
;;;===================================================================
;;; <topLevel> ::= ('import' <unit> ';' )* <transformation>*
(defparse |topLevel| ()
  (with-instance (|QVTToplevel|)
    (setf |importUnit|
	  (loop while (eql (peek-token stream) '|import|)
		do (read-token stream) 
		collect (parse |unit|)
		do (assert-token #\; stream)))
    (setf |transformation| (parse |transformation| :owner *def*))))

;;; <unit> ::= <identifier> ('.' <identifier>)*
(defparse |unit| () 
  (with-instance (|ImportUnit|)
    (setf |referencer|
	  (loop until (eql #\; (peek-token stream))
		collect (read-token stream)
		when (eql #\. (peek-token stream)) 
		do (read-token stream)))))

;;; <transformation> ::= 'transformation' <identifier>
;;;                      '(' <modelDecl> (',' <modelDecl>)* ')'
;;;                       ['extends' <identifier>]
;;;                      '{' <keyDecl>* ( <relation> | <query> )* '}'
(defparse |transformation| (owner)
  (with-instance (|RelationalTransformation|)
    (setf |owner| owner)
    (assert-token '|transformation| stream)
    (setf |name| (read-token stream))
    (assert-token #\( stream)
    (setf |modelParameter|
	  (loop until (eql #\) (peek-token stream))
		collect (parse |modelDecl| :owner *def*)
		when (eql #\, (peek-token stream)) do (read-token stream)))
    (read-token stream)
    (when (eql '|extends| (peek-token stream))
      (read-token stream)
      (setf |extends| (read-token stream)))
    (assert-token #\{ stream)
    (setf |ownedKey|
	  (loop while (eql '|key| (peek-token stream))
		collect (parse |keyDecl| :owner *def*)))
    (loop for peek = (peek-token stream)
          until (or (eql #\} peek) (eql :eof peek))
	  if (or (eql '|top| peek) (eql '|relation| peek)) 
	  collect (parse |relation| :owner *def*) into rule
	  else if (eql '|query| peek) 
	  collect (parse |queryDecl| :owner *def*) into function
	  finally do (setf |rule| rule) (setf |function| function))
    (read-token stream)))

;;; Example: transformation umlToRdbms (uml:SimpleUML, rdbms:SimpleRDBMS)
;;; Note that uml and rdbms are identifiers introduce here.
;;; <modelDecl> ::= <modelId> ':' ( <metaModelId> | '{' <metaModelId> (',' <metaModelId>)* '}' )
(defparse |modelDecl| (owner)
  (with-instance (|TypedModel|)
    (setf |owner| owner)
    (setf |name| (parse |modelId|)) 
    (assert-token #\: stream)
    (if (eql #\{ (peek-token stream)) ; POD Not sure about this interpretation.
	(progn
	  (read-token stream)
	  (setf |dependsOn|
		(loop until (eql #\} (peek-token stream))
		      collect (parse |metaModelId|)
		      when (eql #\, (peek-token stream)) do (read-token stream)))
	  (read-token stream))
	(setf |usedPackage| (parse |metaModelId|)))))

;;; These are names introduced.
;;; <modelId> ::= <identifier>
(defparse |modelId| () (read-token stream))

;;; These are names from an external source.
;;; <metaModelId> ::= <identifier>
(defparse |metaModelId| () (read-token stream))

;;; POD Bugs in QVT Grammar: Is it '{' as grammar shows, or '(' like example shows. I like '('.
;;; <keyDecl> ::= 'key' <classId> '{' <keyProperty> (, <keyProperty>)* '}' ';'
(defparse |keyDecl| (owner)
  (with-instance (|Key|)
    (setf |owner| owner)
    (assert-token '|key| stream)
    (setf |identifies| (parse |classId| :model (target-model (toplevel-scope))))
    (assert-token #\( stream)
    (setf |part|
	  (loop until (eql #\) (peek-token stream))
		collect (parse |keyProperty|)
		when (eql #\, (peek-token stream)) 
		do (read-token stream)))
    (read-token stream)
    (assert-token #\; stream)))

;;; <classId> ::= <PathNameCS>
(defparse |classId| (model) 
  (let ((class (read-token stream)))
    ;(when model (find-class (intern (string class) (mofi:lisp-package model))))
    ;; 2014: ODM has packages within. Use a different method
    (when model 
      (unless (find class (mofi:types (mofi:find-model :odm)) :test #'string= :key #'class-name)
	(error "Cannot find class ~A in 'target' model." class)))
    class))

;;; <keyProperty> ::= <identifier> | 'opposite' '(' <classId> '.' <identifier> ')'
(defparse |keyProperty| () (read-token stream))

;;; <relation> ::= ['top'] 'relation' <identifier> 
;;;                ['overrides' <identifier>]
;;;                '{' <varDeclaration>* 
;;;                    (<domain> | <primitiveTypeDomain>)+
;;;                    [<when>] 
;;;                    [<where>] '}'
(defparse |relation| (owner)
  (with-instance (|Relation|)
    (setf |owner| owner)
    (when (eql (peek-token stream) '|top|)
      (read-token stream)
      (setf |isTopLevel| :true))
    (assert-token '|relation| stream)
    (setf |name| (read-token stream))
    (let ((*scope* (find-child-scope |name|)))
      (when (eql (peek-token stream) '|overrides|)
	(read-token stream)
	(setf |overrides| (read-token stream)))
      (assert-token #\{ stream)
      (setf |variable|
	    (loop until (member (peek-token stream) '(|primitive| |checkonly| |enforce| |domain|))
		  append (parse |varDeclaration|)))
      (setf |domain|
	    (loop for peek = (peek-token stream)
		  until (member peek '(|when| |where| #\}))
		  when (member peek '(|checkonly| |enforce| |domain|))
		  collect (parse |domain| :owner *def*)
		  when (eql peek '|primitive|)
		  collect (parse |primitiveTypeDomain| :owner *def*)))
      (when (eql '|when|  (peek-token stream)) (setf |when| (parse |when| :owner *def*)))
      (when (eql '|where| (peek-token stream)) (setf |where| (parse |where| :owner *def*)))
      (assert-token #\} stream))))

;;; <varDeclaration> ::= <identifier> (, <identifier>)* ':' <TypeCS> ';'
(defparse |varDeclaration| ()
  (let* ((vars
	  (loop until (eql #\: (peek-token stream)) ; POD not quite
		collect (mk-logic-var (read-token stream))
		when (eql #\, (peek-token stream)) do (read-token stream)))
	 type)
    (read-token stream)
    (with-ocl-reader (setf type (parse oclp::|Type| :no-find-class t)))
    (assert-token #\; stream)
    (loop for var in vars
	  collect (oclp::make-var-decl :-name var :-type type))))

;;; <domain> ::= [<checkEnforceQualifier>] 'domain' <modelId> <template>
;;;              ['implementedby' <OperationCallExpCS>]
;;;              ['default_values' '{' (<assignmentExp>)+ '}'] ';'
(defparse |domain| (owner)
  (with-instance (|RelationDomain|)
    (setf |owner| owner)
    (parse |checkEnforceQualifier|)
    (assert-token '|domain| stream)
    (let* ((model-id (parse |modelId|))
	   (*scope* (find-child-scope model-id))
	   (model (with-vo ((info qvt-map-info))
		    (cdr (assoc model-id (qvt-nicknames info) :test #'string=)))))
      (if model
	  (setf |typedModel| model)
	  (error "Line ~A: There is no known model '~A'." *line-number* (string model-id)))
      (setf |pattern| (parse |template| :owner *def*)) ; pod changed. was 'owner', why?
      (setf |rootVariable| (%binds-to |pattern|))
      (when (eql '|implementedby| (peek-token stream))
	(read-token stream)
	(with-ocl-reader ; POD This isn't defined in my OCL!
	  (setf |operationalImplementation| (parse |OperationCallExpCS|))))
      (when (eql '|default_values| (peek-token stream))
	(read-token stream)
	(assert-token #\{ stream)
	(setf |defaultAssignment| 
	      (loop until (eql #\} (peek-token stream))
		 collect (parse |assignmentExp|)))
	(assert-token #\} stream))
      (assert-token #\; stream))))

;;; <primitiveTypeDomain> ::= 'primitive' 'domain' <identifier> ':' <TypeCS> ';'
(defparse |primitiveTypeDomain| (owner)
  (with-instance (|PrimitiveTypeDomain|)
    (setf |owner| owner)
    (setf |typedModel| (mofi:find-model :ocl))
    (assert-token '|primitive| stream)
    (assert-token '|domain| stream)
    (setf |variable| (read-token stream))
    (assert-token #\: stream)
    (with-ocl-reader 
      (setf |typ| (parse oclp::|Type| :no-find-class t)))
    (assert-token #\; stream)))

;;; <checkEnforceQualifier> ::= 'checkonly' | 'enforce'
(defparse |checkEnforceQualifier| ()
    (let ((peek (peek-token stream)))
      (with-slots (|isCheckable| |isEnforceable|) *def*
	(cond ((eql peek '|checkonly|) (read-token stream) (setf |isCheckable| :true))
	      ((eql peek '|enforce|)   (read-token stream) (setf |isEnforceable| :true))
	      (t nil)))))

;;; POD Bugs in QVT Grammar:
;;;
;;;    (1) propertyTemplate should recurse through <template> 
;;;        (Related Problem: The grammar has no provision to allow collection template inside an object template.)
;;;    (2) propertyTemplateList can be an empty string.
;;;
;;;  <template>             ::= ( <objectTemplate> | <collectionTemplate> ) ['{' <OclExpressionCS> '}'] -- No change
;;;  <objectTemplate>       ::= [ <variable> ] ':' <PathNameCS> '{' [ <propertyTemplateList> ] '}' -- Change, optional propertyTemplateList
;;;  <propertyTemplateList> ::= <propertyTemplate> (',' <propertyTemplate>)* 
;;;  <propertyTemplate> ::= <propertyName> '=' ( <template> | <oclExpression> )  -- Changed
;;;  <collectionTemplate>   ::= [ <variable> ] ':' <CollectionTypeIdentifierCS> '(' <TypeCS> ')' '{' [<memberSelection>] '}' -- No change
;;;                           

;;; N.B. I use <variable> and <propertyName> rather than <identifier> to hint at the origin of these identifiers. 
;;;
;;; N.B. They may have intended for <metaModelId> in objectTemplate to be a path (e.g Table.key.name) but
;;;      this can be achieved as t:Table { key= Key{ name= whatever } } -- POD But OCL PathName isn't like Table.key.name !
;;;
;;; N.B I'm keeping their [ <variable> ] ':' syntax rather than [ <variable> ':' ] because the former helps disambiguate WRT OCL


;;; Example:
;;;	enforce domain rdbms t:Table {schema=s:Schema {}, 
;;;                                   name=cn,
;;;                                   column=cl:Column {name=cn+'_tid', type='NUMBER'},
;;;                                   key=k:Key {name=cn+'_pk', column=cl}};

;;; POD I think a better way is to look for Set, Sequence OrderedSet!!!
;;; POD In collection templates '(' occurs before '{' I use that to determine object/collection.
;;;  <template> ::= ( <objectTemplate> | <collectionTemplate> ) ['{' <OclExpressionCS> '}']
(defparse |template| (owner)
  (let ((def
	    (if
	     (or (member (peek-token stream 2) 
			 '("Collection" "Bag" "OrderedSet" "Sequence" "Set")
			 :test #'string=)
		 (member (peek-token stream 3) 
			 '("Collection" "Bag" "OrderedSet" "Sequence" "Set")
			 :test #'string=))
		(parse |collectionTemplate| :owner owner)
		(parse |objectTemplate| :owner owner))))
    (when (eql #\{ (peek-token stream))
      (with-slots (|when|) def
	(with-ocl-reader
	  (setf |when| (parse oclp::|OclExpression|))))) 
      def))

;;;  <objectTemplate>     ::= [ <variable> ] ':' <PathNameCS> '{' [ <propertyTemplateList> ] '}'  <--- SPEC
;;;  <objectTemplate>     ::= [ <variable> ] ':' <PathNameCS> [ <propertyTemplateList> ]          <----ME
(defparse |objectTemplate| (owner)
  (with-instance (|ObjectTemplateExp|)
    (setf |owner| owner)
    (with-ocl-reader 
      (if (eql #\: (peek-token stream 2))
	  (setf |bindsTo| (parse oclp::|VariableId|))
          (setf |bindsTo| (parse oclp::|VariableId| :token (string (gensym "VAR")))))
      (assert-token #\: stream) ; always have the colon -- to disambiguate from OCL.
      (setf |referredClass| (parse oclp::|PathName| :symbol-only-p t)))
    (when (eql #\{ (peek-token stream))
      (setf |part| (parse |propertyTemplateList| :owner *def*)))))

;;;  <propertyTemplateList> ::= <propertyTemplate> (',' <propertyTemplate>)*         <--- SPEC
;;;  <propertyTemplateList> ::= '{' [ <propertyTemplate> ] (',' <propertyTemplate>)* '}'  <--- ME
(defparse |propertyTemplateList| (owner)
  (let (result)
    (assert-token #\{ stream)
    (unless (eql #\} (peek-token stream))
      (setf result
	    (append (list (parse |propertyTemplate| :owner owner))
		    (loop for peek = (peek-token stream)
		       while (eql #\, peek)
		       do (read-token stream)
		       collect (parse |propertyTemplate| :owner owner)))))
    (assert-token #\} stream)
    result))

;;;   <propertyTemplate> ::= <identifier> '=' ( <template> | <OclExpression> )
;;;                        | 'opposite '(' <classId> . <identifier> ') = <OclExpressionCS>
(defparse |propertyTemplate| (owner)
  (let ((peek (peek-token stream)))
    (with-instance (|PropertyTemplate|)
      (setf |owner| owner)
      (cond ((eql '|opposite| peek)
	     (setf |referredProperty| (parse |opposite|))
	     (assert-token #\= stream)
	     (with-ocl-reader (setf |value| (parse oclp::|OclExpression|))))
	    (t
	     (setf |referredProperty| (read-token stream))
	     (assert-token #\= stream)
	     (let ((peek1 (peek-token stream))
		   (peek2 (peek-token stream 2)))
	       (if (or (eql #\: peek1) (eql #\: peek2))
		   (setf |value| (parse |template| :owner *def*))
		   (with-ocl-reader
		     (setf |value| (parse oclp::|OclExpression|))))))))))


;;; POD added this one for convenience. Returns an identifier.
;;; <opposite> =  'opposite '(' <classId> . <identifier> ') 
(defparse |opposite| ()
  (let (class attr)
    (assert-token '|opposite| stream) 
    (assert-token #\( stream)
    (setf class (read-token stream))
    (assert-token #\. stream)
    (setf attr (read-token stream))
    (assert-token #\) stream)))

;;; <collectionTemplate> ::= [<identifier>] ':' <CollectionTypeIdentifierCS> 
;;;                         '(' <TypeCS> ')' '{' [<memberSelection>] '}'
(defparse |collectionTemplate| (owner)
  (with-instance (|CollectionTemplateExp|)
    (setf |owner| owner)
    (with-ocl-reader
      (when (eql #\: (peek-token stream 2))
	  (setf |bindsTo| (parse oclp::|VariableId|)))
      ;; No variable => not binding the (typically unnecessary) 'collection variable'
      ;;(setf |bindsTo| (parse oclp::|VariableId| :token (string (gensym "VAR")))))
      (assert-token #\: stream) ; always have the colon -- to disambiguate from OCL.
      (setf |referredCollectionType| ; Set Bag Sequence Collection OrderedSet
	    (parse oclp::|CollectionTypeIdentifier|)))
    (assert-token #\( stream)
    (with-ocl-reader
      (setf |elementType| 
	    (parse oclp::|Type| :no-find-class t)))
    (assert-token #\) stream)
    (assert-token #\{ stream)
    (unless (eql #\} (peek-token stream))
      (dbind (member rest) (parse |memberSelection| :owner *def*)
	(setf |member| member)
	(setf |rest| rest)))
    (assert-token #\} stream)))

;;; POD I'm making the ++ part optional.  	
;;; XXX <memberSelection> ::= (<identifier> | <template> | '_') 
;;; XXX                      (',' (<identifier> | <template> | '_'))* '++' (<identifier> | '_')
;;; POD Can the member really be another CollectionTemplateExp, or must it be a ObjectTemplateExp?
;;;     I guess that depends on whether OCL allows nesting of collections.
(defparse |memberSelection| (owner)
  (let (member rest tkn)
    (setf member
	  (loop for tkn1 = (peek-token stream)
		for tkn2 = (peek-token stream 2)
		until (member tkn1 '(:plus-plus #\}))
		collect (cond ((or (eql tkn1 #\:) (eql tkn2 #\:)) (parse |template| :owner owner))
			      ((eql tkn1 #\_) :wildcard)
			      (t (read-token stream)))
		do (setf tkn (peek-token stream))
		unless (member tkn '(:plus-plus #\, #\}))
		do (error 'qvt-parse-error :expected "'++' '}' or ','" :actual tkn :tags *tags-trace*)
		when (eql tkn #\,) do (read-token stream)))
    (when (eql tkn :plus-plus)
      (read-token stream) ; ++
      (let ((tkn (read-token stream))) ; POD silly design!
	(setf rest (if (eql tkn #\_) :wildcard tkn))))
    (list member rest)))

;;; <assignmentExp> ::= <identifier> '=' <OclExpressionCS> ';'
(defparse |assignmentExp| (owner) ; 2014 I don't think I ever used this production.
  (with-instance (|RelationDomainAssignment|)
    (break "I didn't think this was used.")
    (setf |owner| owner)
    (setf |variable| (mk-logic-var (read-token stream)))
    (assert-token #\= stream)
    (with-ocl-reader
      (setf |valueExp| (parse oclp::|OclExpression|)))))

;;; POD They need to get real! This is a either a 'RelationCallExp'
;;; or a OCLExpression. These RelationCall things aren't OCL. 
;;; N.B. This is where the first pass parser becomes necessary -- identifying
;;;      which of the two is being parsed here. 
;;; <when> ::= 'when' '{' (<OclExpressionCS> ';')* '}'
(defparse |when| (owner)
  (with-instance (|WhenExpression|)
    (setf |owner| owner)
    (assert-token '|when| stream)
    (assert-token #\{ stream)
    (setf |condition|
	  (loop until (eql #\} (peek-token stream))
		collect (parse |condition/action| :owner *def*)))
    (read-token stream)))

(defparse |condition/action| (owner)
  (let ((peek1 (peek-token stream))
	(peek2 (peek-token stream 2))
	(peek3 (peek-token stream 3))
	result exp)
    (cond ((and (eql #\= peek2)    ; 'var = <relation call>'
		(or (typep owner '|WhereExpression|)
		    (token-is (string peek3) :relation *scope*))) ; used to be (or token-is... 
	   (let ((var (mk-logic-var (read-token stream))) exp)
	     (read-token stream)
	     (with-ocl-reader (setf exp (parse oclp::|OclExpression|)))
	     (setf result (make-instance '|RelationDomainAssignment|
					 :owner owner
					 :variable var 
					 :value-exp exp))))
	  ((token-is (string peek1) :relation *scope*) ; '<relation call>'
	   (setf result (make-instance '|RelationCallExp|
				       :owner owner
				       :referred-relation (read-token stream)
				       :argument (parse |callArgs|))))
	  ;; 'var' = <ordinary ocl>
	  (t  
	   (with-ocl-reader (setf exp (parse oclp::|OclExpression|)))
	      (setf  result (make-instance '|RelationDomainAssignment|
					   :owner owner 
					   :variable :ordinary-ocl ; <========
					   :value-exp exp))))
    (assert-token #\; stream)
    result))

;;; POD Added this one. A question unanswered by the spec (I think. Check this.): 
;;; Can these be RelationCallExp, and if so, what does a RelationCallExp return (Boolean, right?)
;;; <relationCallArgs> ::= '(' [ <OclExpressionCS> (',' <OclExpressionCS>)* ] ')
(defparse |callArgs| ()
  (assert-token #\( stream)
  (let (exps)
    (with-ocl-reader
      (loop until (eql #\) (peek-token stream)) do
	    (push-last (parse oclp::|OclExpression|) exps)
	    when (eql #\, (peek-token stream)) do (read-token stream)))
    (read-token stream)
    exps))

;;; <where> ::= 'where' '{' (<OclExpressionCS> ';')* '}'
(defparse |where| (owner)
  (with-instance (|WhereExpression|)
    (setf |owner| owner)
    (assert-token '|where| stream)
    (assert-token #\{ stream)
    (setf |action|
	  (loop until (eql #\} (peek-token stream))
	     collect (parse |condition/action| :owner *def*)))
    (read-token stream)))

;;; POD The following are not used in the metamodel, but it looks a lot like the function syntax
;;; <query> ::= 'query' <identifier> '(' [<paramDeclaration> (',' <paramDeclaration>)*] ')' ':' <TypeCS>
;;;              (';' | '{' <OclExpressionCS> '}')
;;; <paramDeclaration> ::= <identifier> ':' <TypeCS>


;;; Example function PrimitiveTypeToSqlType(primitiveType:String) : String;
;;; POD Request that the following be added to the spec?
;;; <queryDecl>  ::= 'query' <identifier> 
;;;                     '(' [ <identifier> ':' <OCLTypeCS> (',' <identifier> ':' <OCLTypeCS>)* ] ')' 
;;;                     ':' <oclTypeCS> '{'  <OclExpressionCS> '}'
(defparse |queryDecl| (owner)
  (with-instance (|Function|)
    (setf |owner| owner)
    (assert-token 'qvt::|query| stream) 
    (setf |name| (read-token stream))
    (let ((*scope* (find-child-scope |name|)))
      (setf |ownedParameter| (parse |queryDeclParams|))
      (assert-token #\: stream)
      (with-ocl-reader (setf |type| (parse oclp::|Type| :no-find-class t)))
      (assert-token #\{ stream)
      (with-ocl-reader (setf |queryExpression| (parse oclp::|OclExpression|)))
      (assert-token #\} stream))))

(defparse |queryDeclParams| ()
  (assert-token #\( stream)
  (let (exps)
    (with-ocl-reader
      (loop until (eql #\) (peek-token stream)) do
	    (push-last (parse oclp::|VariableDeclaration|) exps)
	    when (eql #\, (peek-token stream)) do (read-token stream)))
    (read-token stream)
    exps))

;;; POD new for 2008 -- though I'm starting to regret it. As I guessed, for the purpose of
;;; making recursive template syntax, they have glossed over the fact that this 'all-purpose' thing
;;; cannot be appropriately used in some situation: e.g. RelationCallArgs
;;; <OclExpressionCS> ::= <PropertyCallExpCS> | <VariableExpCS> | <LiteralExpCS> | <LetExpCS> |
;;;                       <IfExpCS> | '(' <OclExpressionCS> ')' | <template>
;;; Note that LiteralExpCS ::= <EnumLiteralExp> | <PrimitiveLiteralExp> | <NullLiteralExp> | <InvalidLiteralExp>

#| This is from the 2008-04 discussion with Ed Willink. I'm not going with it, however.
(defparse |OclExpressionCS| ()
  (let ((tkn (peek-token stream))
	(tkn2 (peek-token stream 2))
	(result nil))
    (cond ((eql #\( tkn) ; '(' <OclExpressionCS> ')'
	   (read-token stream)
	   (setf result (parse |OclExpressionCS|))
	   (assert-token #\) stream))
	  ((eql :colon-colon tkn2) (with-ocl-reader (parse oclp::|EnumLiteralExp|)))
	  ((keywordp tkn) (read-token stream)) ; the 'other' EnumLiteralExp, the one used in UML L3. Not legal OCL!!!
	  ;; More from ConstantRef/LiteralExp (but look at OCK string-const-p!!!)
	  ((or (stringp tkn) (numberp tkn) (string= tkn "true") (string= tkn "false"))
	   (read-token stream))  ; more of <LiteralExpCS> from OCL 8.3.5
	  ((eql tkn '|if|)  (with-ocl-reader (setf result (parse oclp::|IfExp|))))
	  ((eql tkn '|let|) (with-ocl-reader (setf result (parse oclp::|LetExp|))))
	  ;; From ocl ConstantRef (parts of LiteralExpCS).
	  ((eql tkn '|null|) (read-token stream))  ; <NullLiteralExp> -- result = nil
	  ((eql tkn '|invalid|) (read-token stream) 
	   (setf result '(make-instance 'ocl::|OclInvalid|)))  ; <InvalidLiteralExp>
	  ;; That concludes <LiteralExpCS> Now <PropertyCallExpCS> 
	  ((or (and (oclp::attribute-p tkn) (not (eql #\( tkn2)))
	       (oclp::collection-operator-p tkn)
	       (oclp::operator-p tkn))
	   (with-ocl-reader (setf result (parse oclp::|ModelPropertyCallExp|))))
	  ;; <VariableExpCS>
	  ((oclp::variable-p tkn) (with-ocl-reader (setf result (parse oclp::|VariableRef|))))
	  ((or (eql #\: tkn) (eql #\: tkn2))
	   (setf result (parse |template|)))
	  (t (error 
	      'qvt-parse-error 
	      :tags *tags-trace*
	      :expected "PropertyCallExp VariableRef, Literal, LetExp, IfExp, ( '(' OclExpression ')' ) or Template"
	      :actual tkn)))
    result))
|#
