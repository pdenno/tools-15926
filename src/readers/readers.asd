;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :readers
    :serial t
    :depends-on (:md5
		 :xml-utils
;2012-03-03	 :xpath     
		 :trie
		 :cre-essential-models
		 :cre-http)
    :components
    ((:file "packages")
     (:file "conditions")
;     (:file "express-axioms")
     (:file "emerson")
;     (:file "initial-set")
     (:file "tlogic-utils")
     (:file "template-classes")
     (:file "owl-template")
     (:file "tlogic-token")
     (:file "tlogic-parser")
     (:file "check-axiom")
     (:file "rds-lookup")
     (:file "template-pop-gen")
     (:file "cre-late-essential")))
	    














