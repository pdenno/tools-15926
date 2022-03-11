
(in-package :cl-user)


; don't let :injector use MOF. Will have problems with |name| |NamedElement| |Operation| %name in MEXICO
;;; EXPRESS meta-model code package
(defpackage :injector
  (:use :cl :pod :expo :tr) 
  (:shadow tr:write-db ocl:value) ; PODTT
  (:shadowing-import-from 
   :pod-utils "%%NAME" "%%TYPE" "%%PARENT" "%%CHILDREN" "%%IDS" "%%SCOPE")
  (:import-from :expo 
   pp-scoped-ids pp-group-refs pp-enum-item-refs pp-select-types pp-binary-operations 
   clear-pp-record expo-parse-error scope-error pprocess-error *expresso*)
  (:export 
   #:*bad-objs* 
   #:*def* 
   #:*mm-warnings*
   #:*unresolved-attribute-refs*
   #:cleanup-scoped-ids
   #:clear-pp-record
   #:express-warning
   #:map-lisp
   #:map-pretty
   #:map-xmi
   #:mexico-expresso
   #:mk-instance
   #:mm2lisp
   #:pp-record
   #:pp-schema
   #:pp-validate-schema
   #:resolve-attrs))





	   






  
