;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :injector
  :depends-on (:application-expresso-core :p11 :p21 :cre-essential-models)
  :serial t
  :components
  ((:file "package")
;2012 use validate/express-cannon-from-model.lisp   (:file "xmi-gen")
   (:file "post-process")
   (:file "pretty")))

;   (:file "xmm")           ; forget it for now.
;   (:file "temp-adds")     ; forget it for now.








