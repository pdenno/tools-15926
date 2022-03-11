;;; -*- Mode: Lisp; -*-

;;; Purpose: Includes stuff specific for MIWG. 

(in-package :user-system)

(defsystem :validate ; was mof-post
  :depends-on (:pod-utils 
	       :parsing-utils
	       :xml-utils
	       :html-utils
	       :trie
	       :cl-who
	       :hunchentoot
	       #:closer-mop
	       #+cre :cre-essential-models
	       #+sei :essential-models
	       #+moss :moss-essential-models
	       #+scm :scm-essential-models
	       :mof)
  :serial t
  :components
  ((:file "conditions")
   (:file "validate")          
   #+sei(:file "model-diff")  
   #+(or sei mod)(:file "canon-xmi-gen")
   #+cre(:file "express-canon-from-model")))









