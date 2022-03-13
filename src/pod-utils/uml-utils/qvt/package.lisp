#+sbcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (setf sb-ext:*on-package-variance* '(:warn t)))

(defpackage qvt
;;;(:use cl closer-mop pod #|mofi ptypes ocl|# trie) ; 2011-09-12 :mofi, ptypes, ocl: a mistake to use these!
  (:use cl closer-mop pod  mofi  ptypes ocl   trie) ; 2022 I put them back for CRE
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:shadowing-import-from :mofi #:owner #:%of-model #:%defined-at #:%token-position #:%source-elem #:%debug-id
			  ;; Some of these last ones are from the qvt model file?
			  #:source-file #:with-instance #:model-package #:mm-root-supertype #:model-name #:name)
  (:shadowing-import-from :ptypes #:|Boolean| #:|String| #:|Integer| #:|UnlimitedNatural| #:|Real|)
  (:shadowing-import-from :ocl #:-typ #:self)
  (:nicknames "qvt-r")
  (:export
   #:append-binds
   #:bind-vars
   #:bind-vars-to
   #:binds-keep-only
   #:domain-nick
   #:ensure-proxy-obj
   #:find-binding
   #:get-key-info
   #:home-pkg
   #:instance2tries
   #:key-completer
   #:*map-info*
   #:mk-logic-var
   #:qvt-boundp
   #:qvt-go
   #:qvt-file2model
   #:qvt-map-info
   #:qvt-map-model
   #:qvt-parse-error
   #:qvt-population
   #:qvt-target-population-install-fn
   #:qvt-query
   #:qvt-setq
   #:qvt-setq-when
   #:qvt-setq-where
   #:qvt-stream
   #:qvt-trie-add-upgrading
   #:+qvt-unbound+
   #:qvt-unboundp
   #:relation-check
   #:relation-enforce
   #:relation-executor
   #:set-accessor-pkg
   #:source-meta
   #:source-pop
   #:target-meta
   #:target-pop
   #:when-where
   #:with-bindings
   #:with-when
   #:with-where
   ;; A bunch of stuff to make the generated lisp more readable. POD is this an OK idea?
   #:result
   #:rel
   #:dom
   #:bindings
   #:checkset
   #:whenbinds
   #:key-completer
   #:combined
   #:for
   #:in
   #:collect
   #:trans
   #:object-set
   #:key-completed
   #:keys

   ;; From SBCL: QVT also exports the following symbols:
   #:|member| #:%BINDS-TO #:|predicate| #:%IN-DIRECTION-OF
   #:%REFERRED-CLASS #:|Class| #:%VARIABLE #:|Pattern| #:|Package|
   #:|part| #:%OWNED-KEY #:%TYPE #:|enforce| #:|overrides|
   #:%DEPENDS-ON #:|TemplateExp| #:%REFERRED-COLLECTION-TYPE
   #:|implementedby| #:|referredCollectionType| #:|ownedKey| #:|Key|
   #:|name| #:%FUNCTION #:|referredRelation| #:|rule| #:|Rule|
   #:|RelationDomain| #:|ownedElement| #:|value| #:|PropertyTemplate|
   #:|PrimitiveTypeDomain| #:|usedPackage| #:|checkonly| #:|opposite|
   #:|Relation| #:%PART #:%OPERATIONAL-IMPLEMENTATION
   #:|templateExpression| #:|operationalImplementation| #:|importUnit|
   #:|key| #:%WHERE #:|action| #:|conditionExpression|
   #:%REFERRED-PROPERTY #:|pattern| #:|isEnforceable| #:%OWNER
   #:|Transformation| #:|defaultAssignment| #:|where| #:%IS-TOP-LEVEL
   #:|rest| #:|ImportUnit| #:|transformation| #:|RelationCallExp|
   #:|Domain| #:|modelParameter| #:|extends| #:|isTopLevel| #:%DOMAIN
   #:|typ| #:|RelationImplementation| #:%OWNED-PARAMETER
   #:%QUERY-EXPRESSION #:%IMPORT-UNIT #:|Operation|
   #:%DEFAULT-ASSIGNMENT #:%OVERRIDES #:|elementType| #:|condition|
   #:%MEMBER #:%ARGUMENT #:%TRANSFORMATION #:|owner|
   #:|inDirectionOf| #:|top| #:%EXTENDS #:|query| #:|domain|
   #:%REST #:|queryExpression| #:%USED-PACKAGE #:|NamedElement|
   #:|relation| #:%VALUE-EXP #:|argument| #:|dependsOn|
   #:%TYPED-MODEL #:%RULE #:|isCheckable| #:%REFERENCER
   #:%IS-ENFORCEABLE #:|type| #:|valueExp| #:|typedModel| #:|when|
   #:%IMPL #:|Predicate| #:%PREDICATE #:%IDENTIFIES
   #:%REFERRED-RELATION #:|identifies| #:|import| #:|Property|
   #:|WhereExpression| #:%PATTERN #:|rootVariable| #:|impl|
   #:|ObjectTemplateExp| #:%CONDITION-EXPRESSION #:%TEMPLATE-EXPRESSION
   #:|function| #:%WHEN #:|DomainPattern| #:%OWNED-ELEMENT #:%NAME
   #:|referredProperty| #:%MODEL-PARAMETER #:%TYP #:%CONDITION
   #:|bindsTo| #:|WhenExpression| #:%ACTION #:|primitive|
   #:|referencer| #:|RelationDomainAssignment| #:%ELEMENT-TYPE
   #:|RelationalTransformation| #:|ownedParameter| #:%IS-CHECKABLE
   #:|CollectionTemplateExp| #:|Element| #:|QVTToplevel| #:|TypedModel|
   #:|variable| #:%ROOT-VARIABLE #:%VALUE #:|referredClass|
   #:|Function|))

(defpackage qvt-html
  (:nicknames :qvth)
  (:use cl closer-mop pod ocl trie tbnl cl-who #-moss phttp)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:qvt-dsp
   #:qvt-load-metamodels-dsp
   #:qvt-compile-maps-dsp
   #:qvt-load-models-dsp
   #:qvt-execute-map-dsp
   #:qvt-parse-errors-dsp
   #:qvt-remove-model-dsp
   #:qvt-restore-defaults-dsp))
