;;; -*- Mode: Lisp; -*-
;;;
;;; Author: Peter Denno, National Institute of Standards and Technology
;;;         peter.denno@nist.gov
;;;
;;; Peter Denno
;;;  Date: 2011-12-23
;;;  Updated! 2022-03-10 borrowing from xmi-validator.

(pushnew :cre                *features*)
;;;(pushnew :injector          *features*) ; 2022 Do I really want this?
(pushnew :qvt                *features*)
(pushnew :iface-http         *features*)
(pushnew :hunchentoot-no-ssl *features*)

(load "~/quicklisp/setup.lisp")
(asdf:clear-configuration)
(asdf:initialize-source-registry)

(ql:quickload "cl-who")
(ql:quickload "cl-ppcre")
(ql:quickload "closer-mop")
(ql:quickload "hunchentoot")
(ql:quickload "inferior-shell")
(ql:quickload "rfc2388")
(ql:quickload "puri")
(ql:quickload "cl-json")
(ql:quickload "drakma")
(ql:quickload "cxml")
(ql:quickload "html-template")

(handler-bind ((style-warning #'muffle-warning))
  (load "./pod-utils/packages.lisp")
  (load "./pod-utils/utils.lisp"))

;;; Bootstrap logical pathnames.
(defvar pod:*lpath-ht* (make-hash-table))

(loop for (key . val)
	in `((:src     . ,(truename "."))
	     (:readers . ,(truename "./readers"))
	     (:iface   . ,(truename "./http"))
	     (:expo    . ,(truename "./express"))
	     (:lisplib . ,(truename "./pod-utils"))
	     (:testlib . ,(truename "./pod-utils"))
	     (:mylib   . ,(truename "./pod-utils"))
	     (:vampire . ,(truename ".")) ; 2022 ToDo
	     (:tmp     . "/usr/local/tmp/")
	     (:data    . ,(truename "../data/"))
	     (:models  . ,(truename "../models/")))
      do (setf (gethash key pod:*lpath-ht*) val))

(defpackage :user-system
  (:use :cl :asdf :pod-utils))
(in-package :user-system)

#+SBCL
(progn
  (setf *compile-verbose* nil)
  (setf *compile-print* nil))

;;;==================================================
;;; Load package files
;;;==================================================
(load (lpath :lisplib "trie/package.lisp"))
(load (lpath :lisplib "kif/packages.lisp"))
(load (lpath :lisplib "uml-utils/ocl/package.lisp"))
(load (lpath :lisplib "uml-utils/mof/package.lisp"))
(load (lpath :iface   "packages.lisp"))
(load (lpath :expo    "expcore/packages.lisp"))
(load (lpath :expo    "projectcore/packages.lisp"))
(load (lpath :readers "packages.lisp"))
(load (lpath :lisplib "uml-utils/qvt/package.lisp"))
(load (lpath :lisplib "uml-utils/mof/package.lisp"))
(load (lpath :lisplib "uml-utils/browser/packages.lisp"))

;;; I make a core by loading save-lisp.lisp from sbcl running in a shell (not Slime).
;;; Currently the core has cre-essential models in it. Not the full thing for :cre.
(handler-bind ((style-warning #'muffle-warning))
  (asdf:oos 'asdf:load-op :cre)
  (pushnew :cre-ready *features*))

(in-package :mofi)
(defvar *cmpkg* nil "Package for #. compiler directive -- determines whether processing
   UML or CMOF into lisp. Set to either :CMOF of a UML (e.g. :UML23).")
(let ((po.lisp (lpath :lisplib "uml-utils/mof/pop-generate.lisp")))
      (setf *cmpkg* :cmof)
      (load (compile-file po.lisp))
      (setf *cmpkg* :uml241)
      (load (compile-file po.lisp)))
