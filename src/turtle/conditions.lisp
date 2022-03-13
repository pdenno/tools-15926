
(in-package :turtle)

;;; 2022 I add this from readers/conditions.lisp
(defmacro defcondition (name superclasses slots &rest options)
  `(progn
     (define-condition ,name ,superclasses ,slots
       (:documentation ,(cadr (assoc :documentation options)))
       (:report ,(cadr (assoc :report options))))
     (setf (get :title ',name) ,(cadr (assoc :title options)))
     (setf (get :id-num ',name) ,(or (cadr (assoc :id-num options)) 1000))
     (setf (get :explanation ',name) ,(cadr (assoc :explanation options)))
     (export ',name)))

;;;==== Lexer ====

(defcondition t-lex-error (error)
  ((in     :initarg :in :initform "")
   (expect :initarg :expect)
   (got    :initarg :got))
  (:report (lambda (c stream)
	     (with-slots (in expect got) c
	       (if (stringp got)
		   (format stream "While lexing ~A, expected: ~A read: ~A." in expect got)
		   (format stream "While lexing ~A, expected: ~A read: ~S." in expect got))))))

(defcondition t-lex-eof (error)
  ((in     :initarg :in :initform ""))
  (:report (lambda (c stream)
	     (with-slots (in) c
	       (format stream "End of file (EOF) while lexing ~A." in)))))

;;;==== Parser ====

(define-condition turtle-error (error) ())

(define-condition turtle-parse-error (turtle-error) ())

(define-condition turtle-parse-token-error (turtle-parse-error)
  ((expect :initarg :expect)
   (got :initarg :got))
  (:report (lambda (err stream)
	     (with-slots (expect got) err
	       (format stream "Syntax Error: expected ~A  got '~A' %<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>"
			  (if (stringp expect) expect (format nil "'~A'" expect))
			  got
			  *tags-trace*)))))

;;; 2022 not investigated
#+nil(define-condition turtle-parse-incomplete (tlogic-parse-error)
  ((actual :initarg :actual))
  (:report 
    (lambda (err stream)
      (with-slots (actual) err
	(format stream "Syntax Error: Parse ended with input remaining. Current token: ~A" actual)))))

