;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :application-expresso-core
  :serial t
  :depends-on (:pod-utils 
	       :parsing-utils 
	       :xml-utils 
	       #:cl-ppcre 
	       :closer-mop 
	       #+injector :projectcore) 
  :components 
  ((:file "globals")
   (:file "generics")
   (:file "macros")
   (:file "express-utils")
   (:file "expresso")
#+injector (:file "messaging")
   (:file "project")
   (:file "schemas")
   (:file "express-metaobjects")
   (:file "root-supertype")
   (:file "datasets")
#-cre (:file "x-metaobjects")
   (:file "types")
   (:file "aggregates")
#+injector (:file "conditions")
   (:file "validation")
#+injector (:file "builtin-fns")
   (:file "top-level")
#+injector (:file "token-stream")
#+injector (:file "exp-essential-load")
   ))










