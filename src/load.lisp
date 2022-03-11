;;; -*- Mode: Lisp; -*-
;;;
;;; Author: Peter Denno, National Institute of Standards and Technology
;;;         peter.denno@nist.gov
;;;
;;; Peter Denno
;;;  Date: 2011-12-23
;;;  Updated! 2022-03-10 borrowing from xmi-validator. 

(load "~/quicklisp/setup.lisp")
(require :quicklisp)
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
(loop for (key . val) in `((:cre     . ,(truename "."))
			   (:expo    . ,(truename "."))
			   (:lisplib . ,(truename "./pod-utils"))
			   (:testlib . ,(truename "./pod-utils"))
			   (:mylib   . ,(truename "./pod-utils"))
			   (:tmp     . "/usr/local/tmp/")
			   (:data    . ,(truename "../data/"))
			   (:models  . ,(truename "../models/")))
   do (setf (gethash key pod:*lpath-ht*) val))

(defpackage :user-system
  (:use :cl :asdf :pod-utils))

(in-package :user-system)

(pushnew :cre *features*)
(pushnew :injector *features*)
(pushnew :qvt *features*)
(pushnew :iface-http *features*)
(push :hunchentoot-no-ssl *features*)

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
;;;ff #-:lispworks(lpath :lisplib "lw-compat/current/lw-compat-package.lisp")
#+:lispworks(load (lpath :lisplib "closer/current/closer-mop-packages.lisp"))

;;; Note some ediware .asd files define packages
;;; 2022   See ~/quicklisp/dists/quicklisp/installed/systems. Show consequences of all the quickloads above
;(load (lpath :lisplib "rfc2388/current/packages.lisp"))
;(load (lpath :lisplib "url-rewrite/current/packages.lisp"))
;(load (lpath :lisplib "cl-who/current/packages.lisp"))
;(load (lpath :lisplib "cl-fad/current/packages.lisp"))
;(load (lpath :lisplib "cl-ppcre/current/packages.lisp"))
;(load (lpath :lisplib "trivial-gray-streams/current/trivial-gray-streams.asd"))
;(load (lpath :lisplib "trivial-gray-streams/current/package.lisp"))
;(load (lpath :lisplib "flexi-streams/current/packages.lisp"))
;(load (lpath :lisplib "cl-fad/current/packages.lisp"))
;(load (lpath :lisplib "chunga/current/packages.lisp"))
;2022(load (lpath :lisplib "hunchentoot/current/hunchentoot.asd"))
;2022(load (lpath :lisplib "hunchentoot/current/packages.lisp"))


(load (lpath :lisplib "trie/package.lisp"))
(load (lpath :lisplib "kif/packages.lisp"))
;2012-03-03(load (lpath :lisplib "xpath/package.lisp"))
(load (lpath :lisplib "uml-utils/ocl/package.lisp"))
(load (lpath :lisplib "uml-utils/mof/package.lisp"))
;;;2022(load (lpath :lisplib "uml-utils/models/packages.lisp"))
(load (lpath :lisplib "uml-utils/browser/packages.lisp"))
(load (lpath :models "sei/essential-models.asd"))     ; new for 2022
(load (lpath :models "cre/cre-essential-models.asd"))     ; new for 2022
(load (lpath :models "cre/cre-essential-load.lisp"))     ; new for 2022

;(load (lpath :models "sei/sei-essential-models.asd")) ; new for 2022


;;; Not sure why this is necessary
;;;2022(load (lpath :lisplib "puri/current/puri.asd"))
;;;2022(load (lpath :lisplib "cl-json/cl-json.asd"))

#+alf(load (lpath :lisplib "uml-utils/alf/packages.lisp"))


#+express(load (lpath :cre "express/p11/package.lisp"))
;pod7(load "cre:express;p14;package.lisp") ; needed, though it isn't used
#+express(load (lpath :cre "express/p21/package.lisp"))
#+express(load (lpath :cre "express/injector/package.lisp"))

(load (lpath :cre "http/packages.lisp"))
(load (lpath :cre "express/expcore/packages.lisp"))
(load (lpath :cre "express/projectcore/packages.lisp"))
(load (lpath :cre "express/injector/package.lisp"))
(load (lpath :cre "express/p11/package.lisp"))
;;; Don't load it if you don't need it; screws up ocl debugging.
#+qvt(load (lpath :lisplib "uml-utils/qvt/package.lisp"))
(load (lpath :cre "readers/packages.lisp"))


(handler-bind ((style-warning #'muffle-warning))
  (asdf:oos 'asdf:load-op :cre))
;  (asdf:oos 'asdf:load-op :injector)))

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
