(in-package :tlogic)

;;; Purpose: (pop-gen for 15926): Generate mofi classes for a population of template definitions.
;;;
;;; TO Do: Currently, this is analogous to sei/pop-gen where the template objects
;;;        play the role of CMOF objects. Is this what is wanted? Why not create an
;;;        object that is both an instance of mm-type-mo and also contains the template
;;;        logic text etc. Would be nice to preserve the file generated however.

;;; 2022 commented out
#+nil(defclass xml-xsd:|DateTime| ()
  ((val :initarg :val :reader xml-xsd:date-time-val))
  (:metaclass xsd-standard-class))

;;; 2022 commented out
#+nil(defmethod validate-superclass ((class xml-xsd:|DateTime|)
				(superclass xsd-standard-class))
  t)

(defvar *undefined-slot-cnt* 0 "Name suffix for undefined slot")

;;; (write-template-classes :mmtc (mut *spare-session-model*))
(defun write-template-classes (tpkg model)
  "Toplevel function to generate mofi classes for templates."
  (with-open-file (out (lpath :src "tryme.lisp") :direction :output :if-exists :supersede)
    (with-slots (mofi:source-file) model
      (format out ";;; Created ~A from file ~A." (now) mofi:source-file)
      (format out "~2%(in-package ~S)" tpkg)
      (let ((*package* (find-package tpkg)))
	#-sbcl(declare (special *package*))
	(gen-tclasses tpkg model  :stream out))
      (lpath :src "tryme.lisp"))))

(defun gen-tclasses (tpkg model &key (stream *standard-output*))
  "Generate def-mm-class forms for template definitions."
  (loop for tmpl in (mofi:templates model) do
       (with-slots (name parent-template comment roles) tmpl
	 (format stream "~2%(mofi:def-mm-class |~A| ~S ~S~%   ~S~%   ("
		 name tpkg parent-template (or comment ""))
	 (loop for r in roles do
	      (with-slots (name type cardinality) r
		(when (null name)
		  (setf name (format nil "POD-UNDEFINED-~A" (incf *undefined-slot-cnt*))))
		(format stream "(|~A| :range ~S :multiplicity ~A)~%   "
			name
			(recover-type-names type)
			(cond ((null cardinality) '(1 1))
			      ((= 1 cardinality) '(1 1))
			      (t '(1 -1)))))))
	 (format stream "))")))

(defun recover-type-names (typ)
  "Return the supporting supertypes (a list of class name symbols) of the argument
  instantiable-express-entity-type."
  (cond ((keywordp typ)
	 (case typ
	   (:string 'ptypes:|String|)
	   (:integer 'ptypes:|Integer|)
	   (:float 'ptypes:|Real|)
	   (:datetime 'xml-xsd:|DateTime|)))
	((eql typ (find-class 'p2::thing)) 'p2::thing) ; special case
	((typep typ 'expo::instantiable-express-entity-type-mo)
	 (let ((result
		(expo::relative-leaves
		 (loop for c in (cdr (class-precedence-list typ))
		    with root = (find-class 'expo:entity-root-supertype)
		    until (eql c root)
		    collect (class-name c)))))
	   (if (cdr result)
	       (cons 'and result) ; POD thus far (looking at MMT), not occurring!
	       (car result))))
	(t (warn "recover-type-names: I don't know what to do with type ~A" typ))))
