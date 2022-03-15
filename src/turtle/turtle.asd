;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :turtle ; 2022 This was called :turtle-old (probably owing to turtle in pod-utils/w3c-utils).
    :serial t
    :depends-on (:cre-essential-models
		 :cre-http)
    :components
    ((:file "packages")
     (:file "conditions")
     (:file "turtle-token")
     (:file "turtle-parser")))














