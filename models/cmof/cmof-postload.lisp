
;;;  Purpose : A file that helps in the use of the given model. In this case, UML.

(in-package :cmof)

(defmethod print-object ((obj |Element|) stream)
  (format stream "<~A:~A, id=~A>" 
	  (car (package-nicknames (lisp-package (of-model (class-of obj)))))
	  (class-name (class-of obj))
	  (mofi:%debug-id obj)))

(defmethod print-object ((obj |NamedElement|) stream)
  (with-slots ((name |name|) (id mofi:|debug-id|)) obj
    (format stream "<~A:~A ~A, id=~A>" 
	    (car (package-nicknames (lisp-package (of-model (class-of obj)))))
	    (class-name (class-of obj))
	    (cond ((string= "" name) "[unnamed]")
		  ((find #\Space name) (format nil "'~A'" name))
		  (name name)
		  (t "[unnamed]"))
	    id)))

;;; 2009-03-21 I'm just making this stuff up! Was needed in ElementImport.imported_element_is_public() constraint :
(defmethod %visibility ((obj mofi:mm-type-mo)) :public)






