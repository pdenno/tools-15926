;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :turtle ; 2022 This was called :turtle-old 
    :serial t
    :depends-on (:cre-essential-models
		 :cre-http)
    :components
    ((:file "packages")
     (:file "conditions")
     (:file "turtle-token")
     ;; 2022 commented out (need a few models, for their namespaces, at least.)
     #+nil(:file "turtle-parser")))














