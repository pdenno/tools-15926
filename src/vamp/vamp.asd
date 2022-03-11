;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :vamp
  :serial t
  :depends-on (:pod-utils :xml-utils :trie :kif :cl-ppcre)
  :components
  ((:file "packages")
   (:file "pipe")
   (:file "vampire")))





