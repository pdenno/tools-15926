;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EXPRESSO; Base: 10 -*-

;;; Copyright (c) 2001 Logicon, Inc.
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
;;; Configuration file parsing code
;;;

(in-package :EXPRESSO)


;; Supported config options:
;;
;; everything after a '#' character is considered a comment
;;
;; **** ExpressoRoot
;; Specifies the mapping for "expo:user;".  This is used as the base
;; directory for storing logs.
;; Defaults:
;;     Win32 - c:\Program Files\NIST Expresso\
;;     Unix  - ~/expresso/
;;
;; **** DataPath
;; Specifies the list of directories that should be searched when
;; looking for data files (p21 or p28).
;; Defaults:
;;     Win32 - c:\Program Files\NIST Expresso\data\
;;     Unix  - ~/expresso/data/;/usr/share/expresso/data/
;;
;; **** ExpressPath
;; Specifies the list of directories that should be searched when
;; looking for Express schema files.
;; Defaults:
;;     Win32 - c:\Program Files\NIST Expresso\exp\
;;     Unix  - ~/expresso/exp/;/usr/share/expresso/exp/
;;
;; **** ExpressXPath
;; Specifies the list of directories that should be searched when
;; looking for Express-X schema files.
;; Defaults:
;;     Win32 - c:\Program Files\NIST Expresso\expx\
;;     Unix  - ~/expresso/expx/;/usr/share/expresso/expx/
;;
;; **** PreloadSchema
;; Specifies the list of schemas that should be loaded when Expresso
;; is started.
;; Defaults:
;;     Win32 - none
;;     Unix  - none

(defun cfg-read-file ()
  (when (probe-file "expo:user;expresso.conf")
    (with-open-file (stream "expo:user;expresso.conf" :direction :input)
      (loop for line = (read-line stream nil nil)
	while line
	when (find #\# line)
	  do (setf line (subseq line 0 (position #\# line)))
	do (setf line (string-trim " " line))
	(when (plusp (length line))
	  (let ((*package* (find-package :keyword))
		key value)
	    (setf key (read-from-string line))
	    (setf value (subseq line (position-if
				      #'(lambda (char) (member char '(#\Space #\Tab) :test #'char=))
				      line)))
	    (setf value (string-trim '(#\Space #\Tab) value))

	    (cfg-process-opt key value)))))))

(defun cfg-process-opt (opt value)
  (case opt
    (:ExpressoRoot
     (let ((path (pathname value))
	   (otrans (logical-pathname-translations "expo"))
	   npath ntrans)
       (when (pathname-name path)
	 (setq path (make-pathname
		     :host (pathname-host path)
		     :device (pathname-device path)
		     :directory (append (copy-list (pathname-directory path))
					(list (pathname-name path))))))
       (setq npath (merge-pathnames
		    (make-pathname :directory '(:relative :wild-inferiors)
				   :name :wild :type :wild)
		    path))
       (setf ntrans (loop for pair in otrans
		      when (string= "user" (first pair) :end2 4)
		      collect (list (first pair) (namestring npath))
		      else
		      collect pair))
       (setf (logical-pathname-translations "expo") (copy-tree ntrans))
       )
     )
;    (:DataPath )
;    (:ExpressPath )
;    (:ExpressXPath )
;    (:PreloadSchema )
    (t
     )))
