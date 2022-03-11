
;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :sei-essential-models
  :depends-on (:pod-utils :ocl :essential-models)
  :serial t
  :components
  ((:file "sei-essential-load")))
