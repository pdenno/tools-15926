
;;;  Purpose : A file that helps in the use of the given metamodel, in this case, UML.

(in-package :uml25)

(defmethod print-object ((obj |Element|) stream)
  (let ((model (mofi:of-model (class-of obj))))
    (format stream "<~A:~A, id=~A>" 
	    (or (package-name (mofi:lisp-package model))
		(mofi:model-name model))
	    (class-name (class-of obj))
	    (mofi:%debug-id obj))))

(defmethod print-object ((obj |NamedElement|) stream)
  (with-slots ((name |name|) (id mofi:|debug-id|)) obj
    (format stream "<~A:~A ~A, id=~A>" 
	    (package-name (lisp-package (of-model (class-of obj))))
	    (class-name (class-of obj))
	    (cond ((and (or (stringp name) (symbolp name)) (string= "" name)) "[unnamed]")
		  ((find #\Space name) (format nil "'~A'" name))
		  (name name)
		  (t "[unnamed]"))
	    id)))

;;; A UML2.5 operation, needed because {PTYPE Boolean} etc are not of type uml25::Type. 
;;; This one didn't 'catch.'
;;;(defmethod conforms-to ((type mofi:mm-root-supertype) (other t))
;;;  (if (eql type other) :true :false))

(defmethod conforms-to ((type t) (other t))
  (if (eql type other) :true :false))






