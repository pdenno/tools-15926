;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :essential-models
  :depends-on (:pod-utils :mof :ocl)
  :serial t
  :components
  ((:file "essential-load")))










