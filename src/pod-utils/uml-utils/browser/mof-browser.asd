
;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :mof-browser
  :depends-on (:pod-utils 
	       :html-utils 
	       :hunchentoot 
	       :cl-who 
	       :html-template
	       :mof-post 
	       :ocl)
  :serial t
  :components
  ((:file "packages")
   (:file "mof-browser")))










