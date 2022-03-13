
(in-package :cl-user)

(defpackage :turtle
  (:use :cl :pod :closer-mop :mofi #+nil"ODM-RDFBase") ; 2022 I might have eliminated ODM-RDFBase
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:T-LEX-ERROR #:T-LEX-EOF
   #:parse-turtle))


