
;;; Purpose: Makes Express-X Package etc.

(in-package :CL-USER)

(defpackage p14p
  (:nicknames p14-parser)
  (:use :cl :pod :p11p :p11u :mexico closer-mop)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:import-from :expo
   *expresso* find-schema find-schema-internal schema-mm
   ;; parsing stuff
   *schema* 
   parse1-data parse2-data p1114-stream)
  (:shadowing-import-from :expo  expo-parse-error)
  (:export p14-stream parse-p14 parse1-p14 *this-schema* *target-schema* *source-schema*))


