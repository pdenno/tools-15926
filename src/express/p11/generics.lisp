;;; -*- Mode: LISP; -*-

(in-package :P11P)

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


(defgeneric expo:abort? (expresso &key condition text &allow-other-keys))

(defgeneric stream-filename (stream)
  (:method ((stream file-stream))
    (truename stream)))

(defgeneric base-name (object)
  (:method ((obj cl:symbol)) obj)
  (:method ((obj cl:null)) obj)
  (:method ((obj cl:number)) obj))

(defmethod short-name (schema)
  (break "POD NYI")
  (let* ((name (cl:string "")) ; pod(id schema)
	 (nlen (cl:length name))
	 (pos 0))
    (coerce
     (append (cl:list (char name pos))
	     (loop for npos = (position #\_ name :start pos)
		   while npos
		   do (setf pos (1+ npos))
		   when (< pos nlen)
		   collect (char name pos)))
     'cl:string)))

(defmethod short-name ((schema expo::express-schema))
  (expo::short-name schema))

(defgeneric shell-REPL (mode &key &allow-other-keys))