;;; Author: Peter Denno
;;; Date: 2007-12-15
;;;
;;; Purpose: Package for EXPRESS parsing. 

(in-package :CL-USER)

(defpackage p11u
  (:nicknames p11-user))

(defpackage p11p
  (:nicknames p11-parser)
  (:use :cl :pod-utils :p11u :mexico closer-mop)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:shadowing-import-from 
   :pod-utils "%%NAME" "%%TYPE" "%%PARENT" "%%CHILDREN" "%%IDS" "%%SCOPE")
  (:shadow declaration)
;  (:shadowing-import-from :mexico "%LOCAL-NAME" "%%SCOPE" "%NAME" "%%PARENT" "%%CHILDREN"
;			  "%%IDS" "UNRESOLVED-ATTRIBUTE" "NamedElement" "Operation" "name"
;			  "%%SCOPE")
  (:import-from :expo
   *expresso* 
   find-schema find-schema-internal entity-type-names constant-names function-names 
   type-names ensure-schema expo-parse-error parse-token-error 
   ;; parsing stuff
   *schema* 
   defparse1-p1114 parse1-data p1114-stream 
   defparse2-p1114 parse2-data 

   parse-invalid-base-type parse-invalid-bi-constant
   parse-invalid-bi-function parse-invalid-bi-procedure parse-invalid-decl
   parse-bad-call parse-redefine-enumeration-id parse-cmd-bad-call pprocess-error)
  (:export
   ;; globals
   *definition* *schema* *shell-dataset* *p11-reserved-words*
   ;; GF's
   short-name stream-filename 
   ;; classes
   p11-stream p11-shell-stream
   ;; parser1/2
   p11-read p11-read-from-string p11-shell-read p11-shell-read-from-string
   make-token-stream make-p11-stream make-p11-shell-stream parse-p11 ))

