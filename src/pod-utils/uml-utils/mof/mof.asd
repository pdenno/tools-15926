;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :mof
  :depends-on (:pod-utils
	       :parsing-utils
	       :xml-utils
	       :html-utils
	       :trie
	       :closer-mop)
  :serial t
  :components
  ((:file "package")
   (:file "model")
   (:file "cre-model")
   (:file "mof")
   (:file "mof-types")))
