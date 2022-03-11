;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :cre-essential-models
  :depends-on (:pod-utils :ocl :essential-models :application-expresso-core)
  :serial t
  :components
  ((:file "cre-essential-load")))










