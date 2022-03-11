
(in-package :expo)

;;; Copyright (c) 2005 Peter Denno
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

#+LispWorks
(defmethod read-schema (filename (enc (eql :exp2)) &key)
  "Called by the GUI or parse-arguments and execute. Filename is a pathname object"
  (let ((type (pathname-type filename))
	(target (schema-file-name)))
    ;; clrhash before compile, not before load, since compile
    ;; sets the values properly.
    (cond ((and type (member type (list *bin-file-type* *lisp-file-type*) :test #'string=))
           (with-done-message ("Loading Pre-Parsed Schema file ~A" filename)
             (load-schema filename)))
	  (t
	   (with-done-message ("Parsing Schema file ~A" filename)
              (setf *line-number* 1)
	      (p11p:parse-p11 filename :out-path target)
	      (case (trans-parse-trans-load-opt *expresso*)
		(:parse-translate-load
		 (load-schema target))))))
    (schema *expresso*)))

