
;;; Author: Peter Denno
;;; Date: 1/20/97
;;;
;;; Purpose: Makes Express Package etc.

(in-package :cl-user)

(defpackage PORT
  (:use cl)
  (:export chdir default-directory with-open-pipe pipe-input close-pipe))

(defpackage PCORE
  (:nicknames project-core)
  (:use cl pod #+iface-http cl-who #+iface-http tbnl))

(defpackage EXPO
  (:nicknames expresso exp)
  (:use cl pod pcore  closer-mop) ; 2012 removed mofi
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:shadowing-import-from :mexico
   #:const_e 
   #:in
   #:lobound
   #:loindex
   #:query
   #:schema)
  #+LispWorks
  (:shadowing-import-from :conditions
   #:format-string 
   #:format-arguments)
  #+Lispworks
  (:shadowing-import-from :hcl   ;; POD This is a mistake! Just makes it harder to understand.
   #:class-prototype)           
  (:shadow pod:unique)
  (:export
   ;; from os-compat.lsp
   #:*bin-file-type* 
   #:*lisp-file-type* 
   #:*text-file-type*
   #:getenv 
   #:chdir 
   #:mkdir 
   #:cp-file 
   #:get-args 
   #:user-name
   ;; from globals.lsp
   #:+keyword-pkg+ 
   #:+expo-pkg+ 
   #:*prog-name* 
   #:*production*
   #:*recorded-type* 
   #:*expresso*
   #:with-partial-context 
   #:with-schema 
   #:domain-rules 
   #:*schema* 
   #:*scope* 
   #:*instance* 
   #:*definition* 
   #:write-entity 
   #:read-schema 
   #:read-data
   #:save-schema 
   #:save-data
   #:note-message 
   #:info-message 
   #:alert-message 
   #:status-message
   #:*dataset* 
   #:*line-number* 
   ;; macros
   #:with-done-message
   ;; patch support
   #:*ee-major* 
   #:*ee-minor* 
   #:*ee-patch* 
   #:*compile-date*
   #:ee-patch-dir 
   #:ee-version 
   #:ee-date
   #:patch-version 
   #:patch-section
   ;; from generics.lsp
   #:run-expresso
   #:read-schema 
   #:save-schema 
   #:read-data 
   #:save-data 
   #:option-get 
   #:option-set
   #:option-incf 
   #:option-decf
   #:add-dataset 
   #:remove-dataset 
   #:add-schema  
   #:remove-schema  
   #:alias-add   
   #:alias-remove  
   #:alias-find
   #:note-message 
   #:convert-data
   #:evaluate 
   #:binding 
   #:mapcall 
   #:clear-bindings ;Mapping Engine API

   ;; Top Level Function
   run-expresso expresso

   ;; from expresso.lisp
   pp-record pp-scoped-ids pp-group-refs pp-enum-item-refs pp-select-types pp-binary-operations
   clear-pp-record pbar-fraction mexico-expresso cgtk-expresso copy-object

   ;; from start-and-stop.lisp
   compile-schema load-schema load-express-x

   ;; from express-metaobjects.lisp
   entity-id entity-root-supertype express-class-list express-entity-type-mo
   express-defined-type-mo express-direct-slot-definition express-effective-slot-definition
   initialize-entity #|2012 find-programmatic-class |#
   select-value string-class-name slot-definition-optional slot-definition-simple-name
   slot-options subtype-of subtyping-constraints supertype-constraint supporting-supertypes
   type-descriptor instantiable-express-entity-type-mo value-maybe-defined current-app
   entity-mo-p ientity-mo-p 

   ;; from express-utils.lisp
   get-option  set-option  incf-option  decf-option
   get-special set-special install-dir
   expo-dot suppress-full-entity-print 
   datasets with-target-dataset 

   ;; from p21-utils.lisp
   process-p21-file 

   ;; from datasets.lisp
   get-instance find-dataset ensure-dataset write-db extent max-name file-schema user-id
   remove-dataset x-schema dataset

   ;; from defview.lisp
   target-dataset source-datasets evaluate-views x-evaluation source-network push-evaluate-maps

   ;; from conditions.lisp
   abstract-entity disjoint-types expresso-error no-loaded-schema no-loaded-data pprocess-error

   ;; from schemas.lisp
   entity-types defined-types current-schema evaluations schemas express-schema map-schema
   short-name function-names constant-names short-name entity-type-names type-names 
   ensure-schema version map-schema find-alias schema-mm

   ;; from start-and-stop.lisp
   compile-schema expresso load-schema

   ;; from types.lisp
   data-typ simple-typ named-typ aggregation-typ constructed-typ generalized-typ
   binary-typ boolean-typ integer-typ logical-typ number-typ real-typ string-typ
   defined-typ array-typ bag-typ list-typ set-typ generic-typ aggregate-typ
   generalized-array-typ generalized-bag-typ generalized-list-typ
   generalized-set-typ enum-typ select-typ p11-string strcat express-assert

   *focus-partial-context* *message-stream*
   <> assert-schema-alias bad-entity
   bi-abs bi-acos bi-asin bi-atan bi-blength bi-coerce-select-value
   bi-backward-path-op bi-forward-path-op bi-query
   bi-cos bi-exists bi-exp bi-format bi-hibound bi-hiindex bi-length
   bi-lobound bi-loindex bi-log bi-log2 bi-log10 bi-nvl bi-odd bi-oid
   bi-rolesof bi-sin bi-sizeof bi-sqrt bi-tan bi-typeof bi-usedin       
   bi-value bi-value_in bi-value_unique bi-extent bi-print boolean-typ bi-shell-extent
   current-namespace data-typ defcreate-target-instance defentity-class
   defglobal-rule defmap defdepmap deftype-class def-express-constant defview
   defdomain-rules delay-evaluation enum-typ ensure-schema def-subtype-constraint
   ensure-schema-alias ensure-view-class ensure-view-info es-and
   es-andor es-oneof express-< express-<= express-> express->=
   express-agg2lisp-list express-and express-aref express-array express-aggregate
   express-bag express-case express-complex-entity-construction 
   express-constant express-constant-value express-divide express-error
   express-exp express-increment-controlled-loop express-if
   express-unary-minus express-length express-less-than-or-equal
   express-mod 
   express-instance-equal express-instance-not-equal express-equal
   express-format express-list express-like express-minus express-mult express-div
   express-namespace--name express-not express-not-equal express-or
   express-plus express-population express-set 
   express-when express-xor find-direct-slot
   find-eu-class find-map find-schema find-schema-internal full-entity-name
   funcall-map get-special in integer-typ lobound loindex make-empty-copy
   make-entity-instance make-one named-typ number-typ query ;; remove this eventually
   query-internal real-typ register-entity register repeat
   safe-find-class safe-find-eu-class schema schema-load-namespaces
   schema-initializer select-typ set-all-slots 
   set-source-entry simple-typ slot-definition-express-type
   string-typ subtype-of supertype-expression-macro store-instance value
   uniqueness-macro express-assign express-expt
   with-partial-context with-schema where-rules where-rules-mac
   x-let-make-store x-eval check-in-vi

   ;; token-stream.lisp (parsing stuff)
   *schema* *scope* *definition* expo-parse-error
   token-all-types defparse1-p1114 p1114-stream defparse2-p1114 
   ;; condition handling
   abort? scope-error 
   parse-invalid-base-type parse-invalid-bi-constant
   parse-invalid-bi-function parse-invalid-bi-procedure parse-invalid-decl
   parse-bad-call parse-redefine-enumeration-id parse-cmd-bad-call pprocess-error
   ;; project.lisp
   load-project load-project-file load-project-files model-file express-file express-x-file part21-file notebook-page
   identified-by partitions project-is-scalar view-mo make-view-instance
   slot-types specializers view-info-partition x-coerce-type view-effective-slot-definition
   )
  )

(in-package :EXPRESSO)

(defconstant +expo-pkg+ (find-package :expresso))

