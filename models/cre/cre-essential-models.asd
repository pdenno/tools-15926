;;; -*- Mode: Lisp; -*-

(in-package :user-system)

;;; https://asdf.common-lisp.dev/asdf.html#A-more-involved-example
(defsystem :cre-essential-models
  :depends-on (:pod-utils :ocl :application-expresso-core :essential-models)
  :components
  ((:file "cre-essential-load")))










