;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :turtle-essential-models
  :depends-on (:pod-utils :ocl :essential-models) 
  :serial t
  :components
  ((:file "turtle-essential-load")))










