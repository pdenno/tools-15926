
;;; Purpose: Define asdf classes and methods for loading mof-models

(in-package :user-system)


(defclass mof-source-file (source-file)
  ())

(defmethod source-file-type ((c mof-source-file) (s module)) "mof")

(defmethod output-files ((compile-op compile-op) (c mof-source-file))
  "Compilation produces these file."
  (flet ((lisp2fasl (file)
	   (when file 
	     (list 
	      (make-pathname :host (pathname-host file)
			     :directory (pathname-directory file)
			     :name (pathname-name file)
			     :type (pathname-type (compile-file-pathname "foo.lisp")))))))
    (with-slots (classes-path constraints-path preload-path postload-path) mof:*model*
      (append (lisp2fasl classes-path)
	      (lisp2fasl constraints-path)
	      (lisp2fasl preload-path)
	      (lisp2fasl postload-path)))))


(defmethod output-files ((load-op load-op) (c mof-source-file))
  "Loading outputs nothing."
  nil)

(defmethod input-files ((compile-op compile-op) (c mof-source-file))
  "The input files to any compilation are all the input files of the model."
  (with-slots (classes-path constraints-path preload-path postload-path) mof:*model*
    (append (list classes-path)
	    (list constraints-path)
	    (list preload-path)
	    (list postload-path))))
      
(defmethod operation-done-p ((op compile-op) (c mof-source-file))
  "Returns true if output files are newer than input files."
  (let ((answer (call-next-method)))
    answer))

(defmethod perform ((op compile-op) (c mof-source-file))
  ;(VARS op c) (break "perform/compile-op")
  (unless (operation-done-p op c)
    (mof:load-model c))
  (output-files op c))

(defmethod perform ((op load-op) (c mof-source-file))
  ;(VARS op c) (break "perform/load-op")
  (output-files op c))

