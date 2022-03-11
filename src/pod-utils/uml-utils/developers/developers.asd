;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :developers
    :serial t
    :depends-on (:md5 
		 :hunchentoot
		 :cl-who 
		 :html-template 
		 :pod-utils
		 :html-utils
		 :xml-utils
		 :trie
		 :mof-browser)
    :components
    ((:file "package")
     (:file "developers")))






