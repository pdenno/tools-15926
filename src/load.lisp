;;; -*- Mode: Lisp; -*-
;;;
;;; Author: Peter Denno, National Institute of Standards and Technology
;;;         peter.denno@nist.gov
;;;
;;; Peter Denno
;;;  Date: 2011-12-23
;;;  Updated! 2022-03-10 borrowing from xmi-validator.

(pushnew :cre                *features*)
(pushnew :injector           *features*)
(pushnew :qvt                *features*)
(pushnew :iface-http         *features*)
(pushnew :hunchentoot-no-ssl *features*)

(load "~/quicklisp/setup.lisp")
(require :asdf)
(require :quicklisp)
(asdf:initialize-source-registry)

(ql:quickload "cl-who")
(ql:quickload "cl-ppcre")
(ql:quickload "closer-mop")
(ql:quickload "hunchentoot")
(ql:quickload "inferior-shell") ; new for 2022
(ql:quickload "rfc2388")        ; new for 2022
(ql:quickload "puri")           ; new for 2022
(ql:quickload "cl-json")        ; new for 2022
(ql:quickload "drakma")         ; new for 2022
(ql:quickload "cxml")           ; new for 2022 from xmi-validator, used by xml-utils
(ql:quickload "html-template")  ; new for 2022 used by mof-browser.asd

(handler-bind ((style-warning #'muffle-warning))
  (load "./pod-utils/packages.lisp")
  (load "./pod-utils/utils.lisp"))

;;; Bootstrap logical pathnames.
(defvar pod:*lpath-ht* (make-hash-table))

;;; Adapted from xmi-validator
(loop for (key . val) in `((:src     . ,(truename "."))
			   (:expo    . ,(truename "."))
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

(defparameter *load-source-pathname-types* '("lisp" nil))
(defparameter *load-binary-pathname-types*
  #+ANSI-CL `(,(pathname-type (compile-file-pathname "foo.lisp")))
  #-(or ANSI-CL)
  (error "Can't find binary file type for ~A" (lisp-implementation-type)))

;;;==================================================
;;; Load package files
;;;==================================================
(load (lpath :lisplib "trie/package.lisp"))
(load (lpath :lisplib "kif/packages.lisp"))
(load (lpath :lisplib "uml-utils/ocl/package.lisp"))
(load (lpath :lisplib "uml-utils/mof/package.lisp"))
(load (lpath :lisplib "uml-utils/browser/packages.lisp"))
;(load (lpath :models "cre/essential-models.asd"))     ; new for 2022 Why aren't these just found?
;(load (lpath :models "cre/cre-essential-models.asd")) ; new for 2022

#+express(load (lpath :src "express/p11/package.lisp"))
#+express(load (lpath :src "express/p21/package.lisp"))
#+express(load (lpath :src "express/injector/package.lisp"))

(load (lpath :src "http/packages.lisp"))
(load (lpath :src "express/expcore/packages.lisp"))
(load (lpath :src "express/projectcore/packages.lisp"))
(load (lpath :src "express/injector/package.lisp"))
(load (lpath :src "express/p11/package.lisp"))
;;; Don't load it if you don't need it; screws up ocl debugging.
#+qvt(load (lpath :lisplib "uml-utils/qvt/package.lisp"))
(load (lpath :src "readers/packages.lisp"))

;(ql:quickload :cre)

(handler-bind ((style-warning #'muffle-warning))
  (asdf:oos 'asdf:load-op :cre))
;;;  (asdf:oos 'asdf:load-op :injector)))

;(asdf:oos 'asdf:load-op :application-expresso-core)

(in-package :mofi)
(defvar *cmpkg* nil "Package for #. compiler directive -- determines whether processing
   UML or CMOF into lisp. Set to either :CMOF of a UML (e.g. :UML23).")

(let ((po.lisp (lpath :lisplib "uml-utils/mof/pop-generate.lisp")))
  (setf *cmpkg* :cmof)
  (load (compile-file po.lisp))
  (setf *cmpkg* :uml241)
  (load (compile-file po.lisp)))

(unless (member :cre.exe *features*)
  (project-http:cre-start))
