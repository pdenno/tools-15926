;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :vamp
  :serial t
  :depends-on (:pod-utils :xml-utils :trie :kif :cl-ppcre)
  :components
  ((:file "packages")
   ;2022 todo (:file "pipe")
   (:file "vampire")
   ))





