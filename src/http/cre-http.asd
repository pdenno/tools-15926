;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :cre-http
    :serial t
    :depends-on (:drakma 
		 :cl-json
		 :md5
		 :xml-utils
;2012-03-03	 :xpath     
		 :trie
		 :ocl
		 :mof-browser)
    :components
    ((:file "dispatch")
     (:file "homepage")
     (:file "http-utils")
     (:file "object-inventory")
     (:file "demo")
     (:file "uo")
     (:file "validate-templates")))














