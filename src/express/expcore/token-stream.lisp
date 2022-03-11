(in-package :EXPO)

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
#+cmu
(defmethod close ((stream token-stream) &key abort)
  (declare (ignore abort))
  (close (slot-value stream 'stream)))

;;;======================================================================
;;; Parsing...
;;;======================================================================

;;; Supertype of p11-stream and p14-stream
(defclass p1114-stream (token-stream)
  ((read-fn :initform #'p11p::p11-read)
   (buffer-string :initform nil)))

(defmacro defparse1-p1114 (tag (&rest keys) &body body)
  `(defmethod parse1-data ((stream p1114-stream) (tag (eql ,tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys) 
		       `(parse1-data stream ,tag ,@keys)))
       ,@body)))

(defmacro defparse2-p1114 (tag (&rest keys) &body body)
  `(defmethod parse2-data ((stream p1114-stream) (tag (eql ,tag)) &key ,@keys)
     (macrolet ((parse (tag &rest keys) 
		       `(parse2-data stream ,tag ,@keys)))
       ,@body)))

(defmethod parse1-data :around ((stream p1114-stream) tag  &rest args)
  (when (eql :eof (peek-token stream))
    (error "Unexpected end of file while parsing a ~A." tag))
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S (~A) peek=~A~%" tag (or args "") 
		    (let ((tkn (peek-token stream)))
		      (if (symbolp tkn) (string tkn) tkn)))
  (let* ((*bcounter-starts* 
	  '("IF" "REPEAT" "CASE" "LOCAL" "ENTITY" "TYPE" "FUNCTION" "RULE" 
	    "SUBTYPE_CONSTRAINT" "PROCEDURE" "ALIAS" "MAP" "DEPENDENT_MAP VIEW"))
	 (*bcounter-ends*
	  '("END_ENTITY" "END_TYPE" "END_FUNCTION" "END_RULE" "END_SUBTYPE_CONSTRAINT"
	    "END_MAP" "END_DEPENDENT_MAP" "END_VIEW"
	    "END_PROCEDURE" "END_ALIAS" "END_SCHEMA"))
	 (result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S~%" tag)
    (pop *tags-trace*)
     result))

(defmethod parse2-data :around ((stream p1114-stream) tag  &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S (~A) peek=~A~%" tag (or args "") (peek-token stream))
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with ~%~A~%" tag result)
    (pop *tags-trace*)
     result))



   







