
(in-package :cl-user)

(defpackage :turtle
  (:use :cl :pod :closer-mop :mofi)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:parse-turtle))


