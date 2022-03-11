
(in-package :qvt)

(define-condition qvt-error (error) ())

;;; ==================
;;; QVT Parse Errors
;;; ==================
(define-condition qvt-parse-error (qvt-error)
  ((tags :initarg :tags :initform nil)
   (expected :initarg :expected)
   (actual :initarg :actual))
  (:report 
   (lambda (err stream)
     (with-slots (tags expected actual) err
       (format stream "Line ~A: In ~A : expected ~A, got '~A'"
	       *line-number*
	       (car tags)
	       (if (stringp expected) expected (format nil "'~A'" expected))
	       actual)
       (format stream "<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" tags)))))

(define-condition qvt-premature-eof (qvt-error)
  ((tags :initarg :tags :initform nil))
  (:report 
   (lambda (err stream)
     (with-slots (tags) err
       (format stream "Premature end of file.~%Parse Stack:~{~%~A~}" tags)))))

(define-condition qvt-unbalanced-error (qvt-error)
  ((tags :initarg :tags :initform nil)
   (token :initarg :token :initform nil)
   (line-start :initarg :line-start :initform nil))
  (:report 
   (lambda (err stream)
     (with-slots (tags token line-start) err
       (format stream "Unbalanced syntax delimiter ~A starting at line ~A.~%Parse Stack:~{~%~A~}" 
	       token line-start tags)))))


