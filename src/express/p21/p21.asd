;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :p21
  :depends-on (:p11)
  :components
  ((:file "package")
   (:file "reader")
   (:file "classes")
; PODsampson removed due to check-token issue (:file "parser")
   (:file "top-level")
   (:file "p21-utils")
   (:file "gen-p21")))


