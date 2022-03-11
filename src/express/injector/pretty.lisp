
;;; Copyright (c) 2008 Peter Denno
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
(in-package :injector)

(defun map-pretty (schema source &key pathname)
  "Pretty print and express schema SCHEMA, to PATHNAME."
  (declare (ignore pathname)) ; POD temporary
  (setf *zippy* schema)
  (let ((stream ;(if pathname 
		;    (open pathname :direction :output :if-exists :supersede)
		    *standard-output*));)
    (format stream "~2%(* 'Pretty print' of EXPRESS schema ~A generated ~A. *)" 
	    (namestring (truename (expo::path source)))
	    (now))
    (ppexp schema stream)))

(declaim (inline obj-name))
(defun obj-name (obj) 
  "The name string of something named by as ScopedId."
  (mex:%local-name (mex:%id obj)))

(defmethod ppexp ((schema mex:|Schema|) s)
  "Pretty print EXPRESS to stream S for the argument OBJ."
  (let ((elems (sort (remove "GENERIC_ENTITY"
			     (remove "GENERIC" (mex:%schema-elements schema) :test #'string= :key #'obj-name)
			     :test #'string= :key #'obj-name)
		     #'ppexp<)))
    (format s "~%SCHEMA ~a;" (mex:%name schema))
    (format s "~%END_SCHEMA;")
    (loop for e in elems do
	  (format s "~2%")
	  (ppexp e s))
    (format s "~2%(* End of file *)")))

(defmethod ppexp ((obj T) s)
  (format s "~% -- POD: PPrint NYI for object of type ~A!" (class-of obj)))

;;; Order: - Constant, DefinedType, EntityType, GlobalRule, Function,  Procedure
(defgeneric ppexp< (x y)
  (:method ((x mex:|Constant|)    (y mex:|Constant|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|Constant|)    (y T)) t)
  (:method ((x mex:|DefinedType|) (y mex:|DefinedType|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|DefinedType|) (y T)) (typecase y (|Constant| nil) (t t)))
  (:method ((x mex:|EntityType|)  (y mex:|EntityType|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|EntityType|)  (y T)) (typecase y ((or mex:|Constant| mex:|DefinedType|) nil) (t t)))
  (:method ((x mex:|GlobalRule|)  (y mex:|GlobalRule|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|GlobalRule|)  (y T)) (typecase y ((or mex:|Constant| mex:|DefinedType| mex:|EntityType|) nil) (t t)))
  (:method ((x mex:|Function|)    (y mex:|Function|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|Function|)    (y T)) (typecase y (|Procedure| y) (t nil)))
  (:method ((x mex:|Procedure|)   (y mex:|Procedure|)) (string< (obj-name x) (obj-name y)))
  (:method ((x mex:|Procedure|)   (y T)) nil))

(defmethod ppexp ((obj mex:|EntityType|) s)
  (format s "~%ENTITY ~A;" (obj-name obj))
  (format s "~%END_ENTITY;"))







		   


    

  
