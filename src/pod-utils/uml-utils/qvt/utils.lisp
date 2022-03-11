
;;; Purpose: Utilities for the QVT code.

(in-package :qvt)

(defstruct qvt-unbound) 
(defstruct comma)
(defmethod print-object ((obj comma) stream) (format stream ","))
(defstruct backquote)
(defmethod print-object ((obj backquote) stream) (format stream "`"))
(defparameter +cm+ (make-comma) "Used in printing to get commas into output lisp expressions.")
(defparameter +bq+ (make-backquote) "Used in printing to get backquotes into output lisp expressions.")
(defvar *zippy* nil "diagnostic")
(defvar *map-info* nil "The current QVT map-info object")

;;; A population of instances of QVT classes, from compiling QVT. Unlike typical populations,
;;; this one defines its own lisp package. 
(defclass qvt-population (mofi:population mofi::interning-model-mixin %%scope)
  ((mofi:operator-strings :initarg :operator-strings :accessor mofi:operator-strings :initform nil)
   (source-model :reader source-model :initarg :source-model :initform nil)
   (target-model :reader target-model :initarg :target-model :initform nil)
   ;; A list of mm-package-mo that organize the types into packages. 
   (mofi:packages :initform nil :reader mofi:packages)))


(defmethod initialize-instance :around ((obj qvt-population) &key)
  (call-next-method)
  (with-slots (mofi:lisp-package) obj
   ;(use-package :closer-mop mofi:lisp-package) ; POD weirdness.
   (use-package :qvt mofi:lisp-package)))

;;; I think in the stuff I did for Anantha/Conrad in 2012-2013 timeframe, I extended my qvt implementation
;;; to handle multiple checkonly and enforce (source and target) domains. But maybe not.
;;; Anyway, this is used when just one. (Used by modelegator/uml2owl). 
(defclass qvt-map-info ()
  ;; A list of compiled metamodels "model types" called out in the transformation language element.
  (;(model-types :initform nil :initarg :model-types) ; 2014 Not used???
   ;; The compiled model generated from parsing the QVT-r file.
   (qvt-map-model :initform nil :reader qvt-map-model) ; The qvt-population (see above)
   ;; A population corresponding to the "source model type" (In this usage there is exactly one of these).
   (source-pop :initform nil :initarg :source-pop :reader source-pop)
   ;; A population corresponding to the "source model type" (currently exactly one of these).
   (target-pop :initform nil :initarg :target-pop :reader target-pop)
   ;; An alist of (nickname . model)
   (qvt-nicknames :initform nil :accessor qvt-nicknames :initarg :qvt-nicknames)
   ;; model-n+1 for source-pop
   (source-meta :initarg :source-meta :initform nil :reader source-meta)
   ;; model-n+1 for target-pop
   (target-meta :initarg :target-meta :initform nil :reader target-meta)))

(defun qvt-file2model (&key source-file)
  "Translate, a QVT source file, and load-model (which translates it to lisp).
   Returning the qvt-population object."
  (setf *line-number* 1)
  (setf *tags-trace* nil)
  (setf oclp:*in-scope-models* 
	(list
	 (mofi:find-model :ocl)
	 (mofi:find-model :qvt)
	 (mofi:find-model :ptypes)))
  (let ((strm (open source-file :direction :input)))
    (unwind-protect
	 (progn
	   (setf *token-stream* (make-instance 'qvt-stream :stream strm))
	   (with-debugging (:parser 1) 
	     (with-debugging (:lexer 0) ; 0parse sets mofi:*model* and mofi:*population* AND *map-info*.qvt-map-model!
	       (parse-data *token-stream* '|topLevel0|)))
	   (format t "~%=-=-=-=-=-=-=-=-=-=-=- Pass 2 population = ~S." mofi:*population*)
	   (close strm)
	   (setf strm (open source-file :direction :input))
	   (when mofi:*population* 
	     (mofi::with-vo (mofi::mut) (setf mofi::mut mofi:*population*)) ; For debugging only!!!
	     (push mofi:*population* oclp:*in-scope-models*)
	     (setf *line-number* 1)
	     (with-slots (pod::stream pod::hold-stream) *token-stream*
	       (setf pod::stream strm pod::hold-stream strm))
	     (with-debugging (:parser 1)
	       (with-debugging (:lexer 0)
		 (parse-data *token-stream* '|topLevel|)))))
      (close strm))
    ;; Loading the model does qvt2lisp, lisp compile, and lisp load.
    (mofi:load-model (qvt-map-model *map-info*))))

;;; This is an :around method so that none of the other mofi:load-model methods run.
(defmethod mofi:load-model :around ((model qvt-population) &key)
  "Generate the lisp source corresponding to the QVTToplevel object OBJ."
  ;;(mofi:validate-mof) ; Make connections that were not made in parsing.... later!
  (with-slots (mofi:members) model
    (if-bind (top-level (loop for i across mofi:members when (typep i '|QVTToplevel|) return i))
	     (progn
	       (with-open-file (s (lpath :tmp "hunchentoot/anon-uploaded-qvt.lisp")
				  :direction :output :if-exists :supersede)
		 (qvt2lisp top-level :stream s))
	       #+sei.exe(load (lpath :tmp "hunchentoot/anon-uploaded-qvt.lisp"))
	       #-sei.exe(load (compile-file (lpath :tmp "hunchentoot/anon-uploaded-qvt.lisp"))))
    (error "Could not find QVTToplevel object in model."))
    model))

(defun set-accessor-pkg (id)
  "Look for template scopes below the current scope that define the variable ID.
   Set the oclp:*accessor-pkg* accordingly."
  (loop for scope in (cons *scope* ; for functions
			   (remove-if-not #'(lambda (x) (eql (%%type x) :template)) (%%children *scope*))) ; for relations
        do (when-bind (found (gethash id (%%ids scope)))
	    (when (member :variable (flatten found))
	      (when-bind (pkg (%%package scope)) ; actually it is a mofi:model...
		(setf oclp:*accessor-pkg* (mofi:lisp-package pkg)))))))

