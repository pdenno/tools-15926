;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :qvt
  :depends-on (:pod-utils 
	       :html-utils
	       :uml-utils 
	       :parsing-utils 
	       :mof-post
	       :essential-models 
	       #+sei :validate
	       #+sei :mof-browser)
  :serial t
  :components
  ((:file "package")
   (:file "utils")
   (:file "reader")
   (:file "conditions")  
   (:file "parser")
   (:file "0parser")
   (:file "generate")
   (:file "engine")
   (:file "qvt-html")))












