
;;;  Purpose : A file that helps in the use of the given model. In this case, UML.

(in-package :uml211)

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
	    (cond ((and (stringp name) (string= "" name)) "[unnamed]")
		  ((find #\Space (string name)) (format nil "'~A'" name))
		  (name name)
		  (t "[unnamed]"))
	    id)))

(defmethod print-object ((obj |LiteralString|) stream)
  (with-slots ((val |value|) (id mofi:|debug-id|)) obj
    (format stream "<uml211:LiteralString ~A, id=~A>" (or val "OclVoid") id)))

(defmethod print-object ((obj |LiteralInteger|) stream)
  (with-slots ((val |value|) (id mofi:|debug-id|)) obj 
    (format stream "<uml211:LiteralInteger ~A, id=~A>" (or val "OclVoid") id)))

(defmethod print-object ((obj |LiteralBoolean|) stream)
  (with-slots ((val |value|) (id mofi:|debug-id|)) obj
    (format stream "<uml211:LiteralBoolean ~A, id=~A>" (or val "OclVoid") id)))

(defmethod print-object ((obj |LiteralUnlimitedNatural|) stream)
  (with-slots ((val |value|) (id mofi:|debug-id|)) obj
    (format stream "<uml211:LiteralUnlimitedNatural ~A, id=~A>" (or val "OclVoid") id)))

;;; 2009-03-21 I'm just making this stuff up! Was needed in ElementImport.imported_element_is_public() constraint :
(defmethod %visibility ((obj mofi:mm-type-mo)) :public)

      





