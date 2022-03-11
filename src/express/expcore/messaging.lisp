;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EXPRESSO; Base: 10 -*-

;;; Copyright (c) 2002 Logicon, Inc.
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------


;;;
;;; Craig Lanning
;;; Date: 7/25/2002
;;;
;;; Functions for displaying messages
;;; 
;;;
(in-package :expresso)

;;; Idea of info/alert/status/<etc>-message is to hide specialization 
;;; by *expresso* object and eql-specializer. 
(defun info-message (string &rest args)
  (apply #'note-message *expresso* :info string args))

(defun alert-message (string &rest args)
  (apply #'note-message *expresso* :alert string args))

(defun status-message (string &rest args)
    (apply #'note-message *expresso* :status string args))

;;;-----info-------------
(defmethod note-message ((obj expresso) (type (eql :info)) string &rest args)
  (format *message-stream* "~A" (apply #'format nil string args))
  (finish-output *message-stream*))

(defmethod note-message ((obj mexico-expresso) (type (eql :info)) string &rest args)
    (let ((in (make-string-input-stream (apply #'format nil string args)))
	  (out (make-string-output-stream)))
      (loop for line = (read-line in nil :eof) until (eql :eof line) do
	    (format out "~A<br/>" line)
	    finally (write-string (get-output-stream-string out) *message-stream*))))

(defmethod note-message ((obj cgtk-expresso) (type (eql :info)) string &rest args)
  (write-string (apply #'format nil string args) *message-stream*))

;;;------status------------
(defmethod note-message ((obj expresso) (type (eql :status)) string &rest args)
  "These go to the cgtk 'status bar' Ignore them."
  (declare (ignore obj type string args)))

#+iface-cgtk
(defmethod note-message ((obj cgtk-expresso) (type (eql :status)) string &rest args)
  (setf (gui::message-area) (apply #'format nil string args))
  (gui::do-gui-events))

;;;----alert--------------
(defmethod note-message ((obj expresso) (type (eql :alert)) string &rest args)
  (apply #'format *message-stream* string args)
  (finish-output *message-stream*))

(defmethod note-message ((obj mexico-expresso) (type (eql :alert)) string &rest args)
  (format *message-stream* "<br/><strong>Warning:</strong> ~A" (apply #'format nil string args)))

(defmethod note-message ((obj cgtk-expresso) (type (eql :alert)) string &rest args)
  (write-string 
   (format nil "~%Warning: ~A" (apply #'format nil string args))  
   *message-stream*))

;;;---------debug---------
(defmethod note-message ((obj expresso) (type (eql :debug)) string &rest args)
  (apply #'format *message-stream* string args)
  (finish-output *message-stream*))

(defmethod note-message ((obj cgtk-expresso) (type (eql :debug)) string &rest args)
  (write-string (apply #'format nil string args) *message-stream*))


;;;======================== ABORT? ============================================================
(defun sanitize-string (str)
  "Remove anything that looks like a pathname from the string."
  (loop for i from 1 to 10
	while (expo-scan  "/[a-z,A-Z,0-9,\\.\\_\\,]+/" str)
	do (setf str (cl-ppcre:regex-replace "/[a-z,A-Z,0-9,\\.\\_\\,]+/" str "*path*")))
  str)

(defvar *expo-scanners* (make-hash-table :test 'equal))
(defun expo-scanner (string)
  "Create or return a scanner -- a memoizer, really"
  (or (gethash string *expo-scanners*)
      (setf (gethash string *expo-scanners*)
	    (cl-ppcre:create-scanner string))))

(declaim (inline expo-scan-to-strings))
(defun expo-scan-to-strings (regexp string)
  (mvb (success regs) (cl-ppcre:scan-to-strings (expo-scanner regexp) string)
       (when success regs)))

(declaim (inline expo-scan))
(defun expo-scan (regexp string)
  (cl-ppcre:scan (expo-scanner regexp) string))

#+iface-http
(defmethod abort? ((expresso mexico-expresso) &key model-file condition text)
  (declare (ignore model-file)) ; reminder that it can be used
  (break "2012 abort?")
   (alert-message 
    (cl-who:escape-string 
     (cond (condition (sanitize-string (format nil "~A" condition)))
	   (text (sanitize-string text))))))

;;;=========================================================================================
(defgeneric expo-dot (iface-type &key char stream pass &allow-other-keys))

(defvar *dot-count* 0)

(defmethod expo-dot ((expo mexico-expresso) &key)
  (declare (ignore expo)))


;;; End of File