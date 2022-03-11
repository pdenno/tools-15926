
;;; Copyright 2004, Peter Denno
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
;;; Peter Denno
;;;  Date: 12/2/95
;;;
;;; Generally applicable utilities. Some from Norvig's "Paradigms of
;;; Artificial Programming". Some from Kiczales et. al. "The Art of the
;;; Metaobject Protocol."
;;;
(in-package :pod)

;; deprecated.
(defun bag-difference (a b &key (test #'eql) (key #'identity))
  "Like set-difference but removes from from A as many Xi member of B
   as are in B or all of them if that is more than A has."
  (let ((a-copy (copy-seq a)))
    (loop for elem in b
	  do (setq a-copy
		   (delete elem a-copy :test test :key key :count 1)))
    a-copy))

(declaim (inline eintern))
(defun eintern (string &rest args)
  "Apply FORMAT to STRING and ARGS, upcase the resulting string and
 intern it into the EXPRESSO package."
  (intern (string-upcase (apply #'format nil (string string) args))
	  expo:+expo-pkg+))

(declaim (inline p11uintern))
(defun p11uintern (string &rest args)
  "Apply FORMAT to STRING and ARGS, upcase the resulting string and
 intern it into the P11-USER package."
  (intern (string-upcase (apply #'format nil (string string) args))
	  (find-package :p11u)))

(defmacro MS-VARS (&rest variables)
  `(format exp::*message-stream* "~A"
    (format nil
    ,(loop with result = "~&"
       for var in variables
       do
       (setf result
	     (if (and (consp var)
		      (eq (first var) 'quote))
		 (concatenate 'string result " ~S ")
	       (concatenate 'string result (string-downcase var) " = ~S ")))
       finally (return (concatenate 'string result "~%")))
    ,@variables)))


;;; deprecated! 
(defmacro swap (x y)
  (with-gensyms (hold)
     `(let ((,hold ,x))
        (setf ,x ,y ,y ,hold))))

(defun corba-name2lisp-symbol (corba-string)
  (let* ((len (length corba-string))
	 (result (make-array (* 2 len) :element-type 'character :fill-pointer 0)))
    (vector-push (char corba-string 0) result)
    (loop for i from 1 to (1- len)
	  for char = (char corba-string i) do		  
	  (when (upper-case-p char) (vector-push #\- result))
	  (vector-push char result))
    (sintern result)))

(defun line-in-file (line-number pathname)
  (with-open-file (stream pathname :direction :input)
    (loop repeat line-number
          for line = (read-line stream nil :eof)
          when (eql line :eof) return nil
          finally (return line))))

(defmacro big-stack ((&key (name (format nil "Big Stack ~A" (string (gensym))))) &body body)
  "Runs the body in a big stack process, waiting for completion."
  (with-gensyms (pname result)
    `(with-stack-size (256000) ; LW default is only 16000!
       (let ((,pname ,name)
             (,result nil))
         (mp:process-run-function 
          ,pname
	  ()
          (let ((sout *standard-output*)
                (eout *error-output*))
            #'(lambda () 
                (let ((*standard-output* sout)
                      (*error-output* eout))
                  (setf ,result (progn ,@body))))))
         (mp:process-wait
          (format nil "Waiting for ~A" ,pname)
          #'(lambda () (not (find ,pname (mp:list-all-processes) :key #'mp:process-name :test #'string=))))
         ,result))))

(export '(bag-difference eintern MS-VARS line-in-file p11uintern))