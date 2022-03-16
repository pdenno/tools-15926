
(in-package :cl-user)

(pod::defpackage* :mofi
  (:use :cl :pod :xmlu :tr :closer-mop)
  (:nicknames :mof-implementation)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:shadowing-import-from :ptypes "Boolean" "String" "Integer" "UnlimitedNatural" "Real")
  (:shadowing-import-from :ocl "-TYP" "VALUE")
  (:export #:abstract-model
           #:abstract-p
	   #:abstract-profile
	   #:all-umls
	   #:all-xmis
	   #:assocs
	   #:assoc-ends
	   #:canonical-files
	   #:class-finalize-slots
	   #:class-p
	   #:compiled-model
	   #:condition-details
	   #:conditions
	   #:constant-strings
	   #:constraint-gf
	   #:constraint-hit-ht
	   #:datatype-p
	   #:decode-for-url
	   #:defcondition
	   #:def-combine-errors
	   #:def-meta-assoc
	   #:def-meta-assoc-end
	   #:def-meta-class
	   #:def-meta-constraint
	   #:def-meta-datatype
	   #:def-meta-enum
	   #:def-meta-operation
	   #:def-meta-package
	   #:def-meta-primitive
	   #:def-meta-stereotype
	   #:def-mm-class
	   #:def-mm-constraint
	   #:def-mm-datatype
	   #:def-mm-enum
	   #:def-mm-operation
	   #:def-mm-package
	   #:def-mm-primitive
	   #:def-mm-stereotype
	   #:def-unique-errors
	   #:depends-on-models
	   #:derived-slots-no-fn
	   #:diffs
	   #:diff-models
	   #:diff-xml
	   #:editor-note
	   #:encode-for-url
	   #:endpoints
	   #:enum-p
	   #:enum-values
	   #:ensure-model
	   #:essential-compiled-model
	   #:essential-compiled-select-model
	   #:essential-lexical-model
	   #:*essential-models*
	   #:*essential-pops*
	   #:expresso-lisp
	   #:extended-metaclasses
	   #:find-class-by-symbol
	   #:find-class-in-model
	   #:find-mm-package
	   #:find-model
	   #:find-programmatic-class
	   #:find-tc-canonical
	   #:general-errors
	   #:href-uri
	   #:inherited-types
	   #:*inside-derivation-p*
	   #:instance-install-fn
	   #:instances
	   #:json-print
	   #:key2mut
	   #:lexical-model-mixin
	   #:lisp-package
	   #:load-model
	   #:mapped-slots
	   #:members
#+cre	   #:mexico-schema
	   #:*mm-debug-id*
	   #:mm-accessor-fn-name
	   #:mm-class-mo
	   #:mm-effective-slot-definition
	   #:mm-find-instance
       	   #:mm-package-mo
	   #:model-diff
	   #:model-name
	   #:model-n+1
	   #:model-package
	   #:model-types
	   #:model-xmi
;	   #:models
	   #:*models*
	   #:*model*
	   #:mm-root-supertype
	   #:mm-type-mo
	   #:modern-uml
	   #:mof-error
	   #:mof-type-proxy
	   #:mof-diff-warning
	   #:mof-warning
	   #:name
	   #:nicknames
	   #:ns-prefix
	   #:ns-uri
	   #:of-class
           #:of-model
	   #:object-extents
	   #:object-vector
	   #:ocl-constraint
	   #:ocl-execution-error
	   #:ocl-type-error-report
	   #:ocl-parameter
	   #:ocl-operations
	   #:ocl-type-proxy
	   #:ocl-violation
	   #:operation-name
	   #:operation-class
	   #:operation-comment
	   #:operation-body
	   #:operation-lisp
	   #:operation-parameters
	   #:operation-status
	   #:operator-strings
	   #:original-body
	   #:owl-classes
	   #:owner
;	   #:*owner*
	   #:packages
	   #:parameter-name
	   #:parameter-type
	   #:parameter-return-p
	   #:perfect-ht
	   #:population
	   #:*population*
	   #:pop-gen
	   #:pp-propagate-derived-unions
	   #:pp-propagate-opposites
	   #:primitive-type-p
	   #:pretty-xmi
	   #:pristine-doc
	   #:privileged-population
#+cre	   #:privileged-template-population
	   #:process-cmof
	   #:process-uml
	   #:processing-results
	   #:profiles-used
	   #:relevant-xmi
	   #:reload-valid-testcases
	   #:reserved-words
	   #:*results*
	   #:results-handler-bind
	   #:set-slot-derived-op
	   #:session-models
	   #:shadow-and-warn
	   #:slot-definition-range
	   #:slot-definition-multiplicity
	   #:slot-definition-source
	   #:slot-definition-effective-source
	   #:slot-definition-is-derived-union-p
	   #:slot-definition-is-readonly-p
	   #:slot-definition-is-composite-p
	   #:slot-definition-is-ordered-p
	   #:slot-definition-is-derived-p
	   #:slot-definition-subsetted-properties
	   #:slot-definition-redefined-property
	   #:slot-definition-specializes
	   #:slot-definition-default
	   #:slot-definition-opposite
	   #:slot-definition-soft-opposite
	   #:slot-definition-xmi-hidden
	   #:slot-definition-xmi-id
	   #:slot-direct-slot
	   #:slot-typ
	   #:soft-opposite-slots
	   #:source-file
	   #:stereotype-p
	   #:stereotyped-obj-p
	   #:substitute-ocl-range
#+cre	   #:templates
	   #:types
	   #:type-constraints
	   #:type-operations
	   #:unintern-model
	   #:unique-errors
	   #:user-doc
	   #:user-profile
#+cre	   #:user-template-population
	   #:url-relevant-xmi
	   #:valid-doc
	   #:validate
	   #:validation-details
	   #:warn-
	   #:with-instance
	   #:with-model
	   #:with-results
	   #:with-matches
	   #:xmi-diff-user-missing
	   #:xmi-diff-valid-missing
	   #:xmi-diff-char-content-differs
	   #:xmi-direct-transform
	   #:xmi-hidden
	   #:xmi-namespace-unknown
	   #:xmi-write-model-canonical
	   #:xmi2model-instance
	   #:xmiid2obj-ht
	   #:xml-record-positions
	   ;; Stuff that was in a ill-conceived package called MOF
	   #:%conditions
	   #:|conditions|
	   #:%debug-id  
	   #:|debug-id|
	   #:%defined-at
	   #:|defined-at|
	   #:|includes-remarks| ; 2022
	   #:%includes-remarks  ; 2022	   
	   #:|local-name|       ; 2022
	   #:%local-name        ; 2022
	   #:|named-elements|       ; 2022
	   #:%named-elements        ; 2022	   
	   #:%mapped-slots
	   #:|mapped-slots|
	   #:%obj-id
	   #:|obj-id| 
	   #:%of-model
	   #:|of-model| 
	   #:%sort-name
	   #:|sort-name| 
	   #:%source-elem
	   #:|source-elem| 
	   #:%tmpl-desc
	   #:|tmpl-desc|
	   #:%token-position
	   #:|token-position|))









	   


