;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :mof-post
  :depends-on (:mof
	       :essential-models
	       #+sei  :sei-essential-models
	       #+moss :moss-essential-models
	       #+scm  :scm-essential-models
	       #+cre  :cre-essential-models)
  :serial t
  :components
  ((:file "instance-reader")))



















