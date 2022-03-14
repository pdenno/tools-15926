;;; Purpose: Try to load some basic stuff; used for debugging.

(pushnew :cre               *features*)
(pushnew :qvt               *features*)
(pushnew :iface-http         *features*)
(pushnew :hunchentoot-no-ssl *features*)

(load "~/quicklisp/setup.lisp")
(asdf:clear-configuration)
(asdf:initialize-source-registry)
;;; These all because ./pod-utils/packages.lisp
(ql:quickload "cl-who")
(ql:quickload "cl-ppcre")
(ql:quickload "hunchentoot")
(ql:quickload "inferior-shell")
;;; This one for cre-essential-models
(ql:quickload "cxml")

#+SBCL
(progn
  (setf *compile-verbose* nil)
  (setf *compile-print* nil))

(handler-bind ((style-warning #'muffle-warning))
  (load "./pod-utils/packages.lisp")
  (load "./pod-utils/utils.lisp"))

(defvar pod:*lpath-ht* (make-hash-table))

;;; Adapted from xmi-validator
(loop for (key . val) in `((:src     . ,(truename "."))
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

(asdf:oos 'asdf:load-op :cre-essential-models)
(format t "~%========================================================================")
(format t "~%============== System cre-essential-models has loaded.  ================")
(format t "~%========================================================================"))

