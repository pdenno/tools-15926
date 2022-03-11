;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :projectcore
  :name "Expresso Utilities"
  :depends-on (:pod-utils 
	       :xml-utils 
	       :trie 
	       :mof
	       #+iface-http :html-utils
	       #+iface-http :hunchentoot
	       #+iface-http :cl-who)
  :serial t
  :components (#+injector(:file "packages")
               (:file "os-compat")
	       #+injector(:file "utils")
	       #+injector(:file "port")))













