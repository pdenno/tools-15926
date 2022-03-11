;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: PORT; Base: 10 -*-

;;; Shell Access
;;;
;;; Copyright (C) 1999-2003 by Sam Steingold
;;; This is open-source software.
;;; GNU Lesser General Public License (LGPL) is applicable:
;;; No warranty; you may copy/modify/redistribute under the same
;;; conditions with the source code.
;;; See <URL:http://www.gnu.org/copyleft/lesser.html>
;;; for details and the precise copyright document.
;;;
;;; $Id: port.lisp,v 1.1.1.1 2012/01/03 17:40:04 pdenno Exp $
;;; $Source: /proj/meta/repo2/cre/express/projectcore/port.lisp,v $

;;; Stuff mostly borrowed from CLOCC port

(in-package :port)

(defun default-directory ()
  "The default directory."
  #+allegro (excl:current-directory)
  #+clisp (#+lisp=cl ext:default-directory #-lisp=cl lisp:default-directory)
  #+cmu (ext:default-directory)
  #+cormanlisp (ccl:get-current-directory)
  #+lispworks (hcl:get-working-directory)
  #+lucid (lcl:working-directory)
  #-(or allegro clisp cmu cormanlisp lispworks lucid) (truename "."))

(defun chdir (dir)
  #+allegro (excl:chdir dir)
  #+clisp (#+lisp=cl ext:cd #-lisp=cl lisp:cd dir)
  #+cmu (setf (ext:default-directory) dir)
  #+cormanlisp (ccl:set-current-directory dir)
  #+gcl (si:chdir dir)
  #+lispworks (hcl:change-directory dir)
  #+lucid (lcl:working-directory dir)
  #-(or allegro clisp cmu cormanlisp gcl lispworks lucid)
  (error 'not-implemented :proc (list 'chdir dir)))

(defun close-pipe (stream)
  "Close the pipe stream."
  (declare (stream stream))
  (close stream)
  #+allegro (sys:reap-os-subprocess))

(defmacro with-open-pipe ((pipe open) &body body)
  "Open the pipe, do something, then close it."
  `(let ((,pipe ,open))
    (declare (stream ,pipe))
    (unwind-protect (progn ,@body)
      (close-pipe ,pipe))))

(defun pipe-output (prog &rest args)
  "Return an output stream which will go to the command."
  #+allegro (excl:run-shell-command (format nil "~a~{ ~a~}" prog args)
                                    :input :stream :wait nil)
  #+clisp (#+lisp=cl ext:make-pipe-output-stream
           #-lisp=cl lisp:make-pipe-output-stream
                     (format nil "~a~{ ~a~}" prog args))
  #+cmu (ext:process-input (ext:run-program prog args :input :stream
                                            :output t :wait nil))
  #+gcl (si::fp-input-stream (apply #'si:run-process prog args))
  #+lispworks (sys::open-pipe (format nil "~a~{ ~a~}" prog args)
                              :direction :output)
  #+lucid (lcl:run-program prog :arguments args :wait nil :output :stream)
  #+sbcl (sb-ext:process-input (sb-ext:run-program prog args :input :stream
                                                   :output t :wait nil))
  #-(or allegro clisp cmu gcl lispworks lucid sbcl)
  (error 'not-implemented :proc (list 'pipe-output prog args)))

(defun pipe-input (prog &rest args)
  "Return an input stream from which the command output will be read."
  #+allegro (excl:run-shell-command (format nil "~a~{ ~a~}" prog args)
                                    :output :stream :wait nil)
  #+clisp (#+lisp=cl ext:make-pipe-input-stream
           #-lisp=cl lisp:make-pipe-input-stream
                     (format nil "~a~{ ~a~}" prog args))
  #+cmu (ext:process-output (ext:run-program prog args :output :stream
                                             :error t :input t :wait nil))
  #+gcl (si::fp-output-stream (apply #'si:run-process prog args))
  #+lispworks (sys::open-pipe (format nil "~a~{ ~a~}" prog args)
                              :direction :input)
  #+lucid (lcl:run-program prog :arguments args :wait nil :input :stream)
  #+sbcl (sb-ext:process-output (sb-ext:run-program prog args :output :stream
                                                    :error t :input t :wait nil))
  #-(or allegro clisp cmu gcl lispworks lucid sbcl)
  (error 'not-implemented :proc (list 'pipe-input prog args)))

