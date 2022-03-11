
;;;  Purpose : A file that helps in the use of the given metamodel, in this case, UML.

(in-package :uml23)

(defmethod print-object ((obj |Element|) stream)
  (format stream "<~A:~A, id=~A>" 
	  (if (find :sei.exe *features*)
	      (mofi:ns-prefix (of-model (class-of obj)))
	      (car (mofi:nicknames (of-model (class-of obj)))))
	  (class-name (class-of obj))
	  (mofi:%debug-id obj)))

(defmethod print-object ((obj |NamedElement|) stream)
  (with-slots ((name |name|) (id mofi:|debug-id|)) obj
    (format stream "<~A:~A ~A, id=~A>" 
	  (if (find :sei.exe *features*)
	      (mofi:ns-prefix (of-model (class-of obj)))
	      (car (mofi:nicknames (of-model (class-of obj)))))
	    (class-name (class-of obj))
	    (cond ((and (or (stringp name) (symbolp name)) (string= "" name)) "[unnamed]")
		  ((find #\Space name) (format nil "'~A'" name))
		  (name name)
		  (t "[unnamed]"))
	    id)))

#|
;;; Problem is, this leaves *owner* hanging with a value at times that it might
;;; not be appropriate (e.g. when running OCL). 2011-11-21 Now I'm clearing it
;;; in instance-reader.lisp. But I'm not certain that that will be sufficient. 
(defmethod initialize-instance :after ((obj |Element|) &rest initargs)
  "Update *owner* for cases where mofi-make-instance is making a property owned by OBJ."
  (unless mofi::*mofi-make-instance-p* (setf mofi:*owner* obj)))

;;; This is used where the :default value  is a LiteralSpecification
;;; See 2011-10-13 comments in uml23.lisp
(defmethod initialize-instance :after ((obj |LiteralSpecification|) &rest initargs)
  "Check whether mofi-make-instance made the call, and if so, set the owner."
  ;(unless (typep *owner* 'uml23:|LiteralSpecification|) ; POD why necessary???
  (when mofi::*mofi-make-instance-p*
    (format t "~% Making a ~A for object ~A" obj *owner*)
    (with-slots (uml23:|owner|) obj 
      (setf uml23:|owner| mofi:*owner*))))
|#





