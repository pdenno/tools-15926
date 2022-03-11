
;;;  Purpose : A file that helps in the use of the given metamodel, in this case, UML.

(in-package :uml4sysml12)

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






