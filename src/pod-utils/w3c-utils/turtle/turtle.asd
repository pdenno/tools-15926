;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :turtle
    :serial t
    :depends-on (:mod-essential-models) ; Modelegator usage (pick up correct ODM). 
    :components
    ((:file "packages")
     (:file "utils")
     (:file "conditions")
     (:file "turtle-token")
     (:file "turtle-parser")
     (:file "odmrdf2ttl")))














