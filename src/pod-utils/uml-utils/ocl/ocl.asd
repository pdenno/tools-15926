;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :ocl
  :depends-on (:pod-utils :mof)
  :serial t
  :components
  ((:file "package")
   (:file "ocl-load")
   (:file "utils")
   (:file "conditions")
   (:file "reader")
   (:file "ptypes")
   (:file "types")
   (:file "parser")))










