#|
 Expresso

 Copyright (c) 2007 by Peter Denno <peter.denno@nist.gov>

 You have the right to distribute and use this software as governed by 
 the terms of the Lisp Lesser GNU Public License (LLGPL):

    (http://opensource.franz.com/preamble.html)
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 Lisp Lesser GNU Public License for more details.
|#

;;; Purpose: read-schema, load-schema, load-patches methods.

;;; Idea here is to define a read-schema interface that can be used for 
;;; P11 and P14, using the model-file in method selection.

(in-package :expo)

(defmacro before/after ((tag level string) &body body)
  (with-gensyms (result)
  `(let (,result)
    (dbg-message ,tag ,level ,(format nil "~%Before ~A" string))
    (setf ,result (progn ,@body))
    (dbg-message ,tag ,level ,(format nil "~%After ~A" string))
    ,result)))

;;;==========================================
;;; read-schema
;;;==========================================
#+injector 
(defmethod read-schema :around ((source express-file) &key)
  "Calls for compilation, maps to .lisp or XMI."
;2012  (handler-bind
;2012      ((error #'(lambda (err) (abort? *expresso* #| 2012 :model-file source |# :condition err))))
    (with-slots (path out-path target-type target-package) source
      (let ((mofi:*population* 
	     (mofi:ensure-model (pathname-name (path source)) :force t
				:model-class 'mofi:population ;'mofi:privileged-population
				:source-file (path source)
				:model-n+1 (mofi:find-model :mexico))))
	(declare (special mofi:*model*))
	(setf mofi:*mm-debug-id* 0)
	(let ((schema (call-next-method))) ; vanilla around
	  (before/after (:parser 1 "lisp/xmi/pretty gen")
	    (case target-type
	      ;;2012(:xmi  (injector:map-xmi :one-two :pathname out-path :indent-p t))
	      (:nothing t)
	      (:xmi (mofi::express-canonical-from-model expo:*scope*))
	      (:lisp (injector:map-lisp schema :source-path path :out-path out-path :package target-package))
	      (:pretty-express (injector:map-pretty schema source :pathname out-path))))
	  (status-message "Done.")
	  (setf (pbar-fraction *expresso*) 0.0)
	  schema))));)

#+injector
(defmethod read-schema :around ((source express-x-file) &key)
  "Calls for compilation, maps to .lisp."
;2012  (handler-bind
;2012      ((error #'(lambda (err) (abort? *expresso* :model-file source :condition err))))
    (with-slots (path out-path) source
      (set-special express-x t)
      (set-special suppress-new-namespace t)
      (set-special express-x-file path)
     (unwind-protect
	  (before/after (:parser 1 "Compile e-x")
	    (let ((schema (call-next-method))) ; vanilla around, parse, post-process
	      (injector:map-lisp schema :source-path path :out-path out-path)
	      (setf (schema-object source) schema)
	      (setf (slot-value *expresso* 'expo::express-x) schema)
	      (setf (pbar-fraction *expresso*) 0.0)))
       (set-special express-x nil)
       (set-special suppress-new-namespace nil))
     (status-message "Done.")
     (schema *expresso*)));)

#+injector
(defmethod read-schema :around ((source model-file) &key lisp-gen)
  "Vanilla around: call for parsing and do post-processing."
  (setf injector:*bad-objs* nil)
  (setf injector:*mm-warnings* nil)
  (setf (fill-pointer injector:*unresolved-attribute-refs*) 0)
  (let ((schema (call-next-method))) ; primary, where parsing occurs.
    (p11p::cleanup-scoped-ids)
    (if schema 
	(before/after (:parser 1 "post processing") 
	  (injector:pp-schema schema :lisp-gen lisp-gen))
	(error "Schema processing halted."))
    ;(info-message "~% ~D Errors. " (cl:length injector:*bad-objs*))
    ;(info-message "~% ~D Warnings. " (cl:length injector:*mm-warnings*))
    schema))

#+injector
(defmacro with-parse-errors-handled ((model-file &key pass (debugging 0)) &body body) 
  `(handler-bind
    (
;2012     (error #'(lambda (err)
;2012		(print-parse-stack err "Express" ,pass)
;2012		(if-debugging (:parser 1) 
;2012			      (error err)
;2012			      (abort? *expresso* :condition err :model-file ,model-file))))
     )
    (setf *line-number* 1)
    (set-debugging :parser ,debugging)
    (status-message "~%Parsing ~A, pass ~A~%" (path ,model-file) ,pass)
    ,@body))

#+injector
(defmethod read-schema ((source express-file) &key)
  "Run both passes of the parser, set schema-object, 
   and return the schema object."
  (clrhash p11p::*scoped-ids*)
  (let (schema)
    (with-parse-errors-handled (source :pass 1 :debugging 1)
      (clear-pp-record (pp-record *expresso*))
      (before/after (:parser 1 "pass 1") 
	(p11p::parse1-data (path source) :p11-file)))
    (with-parse-errors-handled (source :pass 2 :debugging 1)
      (before/after (:parser 1 "pass 2") 
	(with-debugging (:parser 1)
	  (setf schema (p11p::parse2-data (path source) :p11-file)))))
    (setf (schema-object source) schema)
    schema))


#|pod7
(defmethod read-schema ((source express-x-file) &key)
  "Run both passes of the parser, set schema-object,
   and return the schema object."
  (let (schema)
    (with-parse-errors-handled (source :pass 1 :debugging 0)
      (before/after (:parser 1 "pass 1") 
	(p14p::parse1-data (path source) :p14-file)))
    (with-parse-errors-handled (source :pass 2 :debugging 0)
      (before/after (:parser 1 "pass 2") 
	(setf schema (p14p::parse2-data (path source) :p14-file))))
    (setf (schema-object source) schema)
    schema))
|#

;;;==========================================
;;; load-schema
;;;==========================================
(defgeneric load-schema (model-file))


(defmethod load-schema :before (model-file)
  "Clean out old schema, clear memoization, methods etc."
  (declare (ignore model-file))
  (clear-memoize 'selects-using)
  (clear-memoize 'type-compatible-p)
  (clear-memoize 'select-slot))

(defmethod load-schema ((model-file lisp-compiled-express-file))
  "The function for loading translated express."
  (setf *schema-loading* t)
  (handler-bind ((error #'(lambda (err) (abort? *expresso* :condition err))))
    (before/after (:parser 1 "schema load")
      (unwind-protect
          (load (namestring (path model-file)))
	(setf *schema-loading* nil)))
    (step-b)
    (setf (resulting-object model-file) (schema *expresso*))
    (schema *expresso*)))

#| pod7
(defmethod load-schema ((model-file lisp-compiled-express-x-file))
  (handler-bind ((error #'(lambda (err) (abort? *expresso* :condition err))))
    (before/after (:parser 1 "schema load")
      (load (namestring (path model-file)))
      (setf (resulting-object model-file) (schema *expresso*))
      (compile-maps (schema *expresso*))
      (schema *expresso*))))
|#

(defmethod load-schema :after ((model-file lisp-compiled-express-file))
  "Things done directly after freshly loading a schema."
  (declare (ignore model-file))
  (let ((schema (resulting-object model-file)))
    #+LispWorks (lispworks-fix-forward-methods schema)
    (with-slots (entity-type-names entity-types) schema
      (setf entity-type-names
            (sort (loop for entity being the hash-value of entity-types
                        collect (class-name entity))
                  #'string< :key #'symbol-name)))
    (evaluate-td-forward-ref model-file)
    ;; Here are a few things that significantly speed up execution.
    (let ((bag-to-set-fn (intern "BAG_TO_SET" (lisp-package (schema *expresso*))))
          (using-rep-fn (intern "USING_REPRESENTATIONS" (lisp-package (schema *expresso*)))))
      (when (fboundp bag-to-set-fn)
        (setf (symbol-function bag-to-set-fn) 
              (symbol-function 'builtin-bag_to_set)))
      (update-schema-aliases)
      (when (fboundp using-rep-fn)
        (memoize using-rep-fn)))))

;;; Used in incremental too.
(defmethod evaluate-td-forward-ref ((file lisp-compiled-express-file))
 "The deftype-class macro sets each type-descriptor to a function that can
  be evaluated only once all express definitions are made. (Done here.)"
 (let ((schema (resulting-object file)))
   (loop for type being the hash-value of (defined-types schema)
	 for td = (slot-value type 'type-descriptor)
	 when (typep td 'function)
	 do (setf (slot-value type 'type-descriptor) (funcall td)))))

#+LispWorks
(defmethod lispworks-fix-forward-methods ((schema express-schema))
  "If a specializer of an accessor methods created by the MM code is a
   forward-reference-class, replace it with the actual class. Run after load."
  (loop for (reader-gf setf-gf) being the hash-value of (accessors schema) do
        (loop for meth in (generic-function-methods reader-gf)
              for specializers = (slot-value meth 'clos::specializers)
              when (typep (first specializers) 'forward-referenced-class)
              do 
              (setf (first specializers)
                    (find-class ; PODsampson find-eu-class
                     (class-name (first specializers)))))
        (loop for meth in (generic-function-methods setf-gf)
              for specializers = (slot-value meth 'clos::specializers)
              when (typep (second specializers) 'forward-referenced-class)
              do 
              (setf (second specializers)
                    (find-class ; PODsampson find-eu-class
                     (class-name (second specializers)))))))

#+LispWorks
(defmethod lispworks-fix-forward-methods ((schema map-schema)) ())

#+injector
(defmethod compile-schema (filename)
  "Really only useful for Lispworks, where the *schema-loading* must be set."
  (alert-message "First you must evaluate and load schema-initializer.")
  (let ((*schema-loading* t))
    #+LispWorks
    (hcl:toggle-source-debugging nil)
    (compile-file filename)))

#+injector
(defvar *loaded-patches* nil)

#+injector
(defun load-expresso-patches (&key (report nil))
  (if report
      (copy-list *loaded-patches*)
    (let (files)
      ;; These loops are nested in such a way that patches in the user's
      ;; patch directory take precedence over patches by the same name
      ;; in system directory.  Binary patches take precedence over
      ;; source patches.
      (loop for pattern in `(,(format nil "expo:user;patches;~A;*" (ee-patch-dir))
			     ,(format nil "expo:patches;~A;*" (ee-patch-dir)))
	    do (loop for kind in (list *bin-file-type* *lisp-file-type*)
		     do (loop for path in (directory (make-pathname :type kind :defaults pattern))
			      do (pushnew path files :test #'string= :key #'pathname-name))))
      ;; now sort them so that they load in the correct order
      (setf files (sort files #'string< :key #'pathname-name))
      (let ((bin-path (make-pathname :type *bin-file-type*
				     :defaults "expo:user;patches;preferences"))
	    (lsp-path (make-pathname :type *lisp-file-type*
				     :defaults "expo:user;patches;preferences")))
	(cond ((probe-file bin-path)
	       (setf files (append files (list bin-path))))
	      ((probe-file lsp-path)
	       (setf files (append files (list lsp-path))))))
      (unless report
	(loop with paths = nil
	      for file in files
	      as path = (handler-case (load file :verbose nil) ; handler-case ok
			  (error () nil))
	      when path
	      do (push path paths)
	      finally (setf *loaded-patches* (nreverse paths)))
      files))))

#+injector
(defun save-schema-as (file)
  "Copies the thing written to temp to somewhere else."
  (let ((file-with-extension (make-pathname :type *lisp-file-type* :defaults file))
        (in-file (schema-file-name)))
    (when (probe-file in-file)
      (with-open-file (in in-file :direction :input)
        (with-open-file (out file-with-extension :direction :output
			     :if-exists #-SBCL :new-version #+SBCL :supersede
			     :if-does-not-exist :create)
          (loop for line = (read-line in nil :eof)
                when (eql :eof line) return nil
                do (write-line line out)))))))
  
;;;======================================
;;; Debug stuff
;;;======================================
#+injector
(defun runone (choose &key (flavor :mexico))
  "This one load a project, perhaps with the .exx commented out. Then tries to compile
   the .exx schema and run it. (Pretty much do everything, which is usually too much)."
  (let ((filename 
	 (ecase choose
	   (:15926 #P"/local/lisp/pod-utils/uml-utils/models/cre/15926.pra")
	   (:tas #P"/home/pdenno/projects/sei/projects/tas/tas.pra")
	   (:ap233 #P"/home/pdenno/projects/sei/projects/ap233/ap233.pra")
	   (:ap203 #P"/home/pdenno/projects/sei/projects/ap203/ap203.pra")
	   (:query #P"/home/pdenno/projects/sei/projects/query/query.pra")
	   (:where #P"/home/pdenno/projects/sei/projects/where/where.pra")
	   (:rules #P"/home/pdenno/projects/sei/projects/production-rules/production-rules.pra")
	   (:attr-group #P"/home/pdenno/projects/sei/projects/attr-group/attr-group.pra")
	   (:one-function #P"/home/pdenno/projects/sei/projects/one-function/one-function.pra")
	   (:reqs #P"/home/pdenno/projects/sei/projects/requirements-map/requirements-map.pra")
	   (:one-schema #P"/home/pdenno/projects/sei/projects/one-schema/one-schema.pra"))))
    (let ((*expresso* 
	   (make-instance 
	    (case flavor
	      (:expresso 'expresso)
	      (:mexico 'mexico-expresso)
	      (:cgtk (intern "CGTK-EXPRESSO" :gui))))))
      (setf *message-stream* *standard-output*)
      (setf *debug-stream* *standard-output*)
      (load-project filename :gui-p nil)
      (case choose
	(:ap233 (check-all (dataset *expresso*)))))))


#+nil
(defun injector::runit (choose)
  "This one load a project, perhaps with the .exx commented out. Then tries to compile
   the .exx schema and run it. (Pretty much do everything, which is usually too much)."
  (setf *expresso* (make-instance 'expresso))
  (setf *message-stream* *standard-output*)
  (setf *debug-stream* *standard-output*)
  (let ((filename 
	 (ecase choose
	   (:big-x "/home/pdenno/projects/expresso/projects/requirements-mapping/requirements-map.pra")
	   (:small-x "/home/pdenno/projects/expresso/projects/small-x/small-x.pra"))))
    (funcall (intern "LOAD-PROJECT" :gui) filename :gui-p nil)
    (let* (;(x-schema (expo:read-schema "/home/pdenno/repo/dodaf/mechatronics/train/reqs/ap233pbr-ap233reqs.exx" :exx))
	   (x-schema (slot-value *expresso* 'express-x))
	   (x-eval (expo:ensure-dataset 'expo:x-evaluation 
					:name "target dataset" 
					:x-schema x-schema
					:source-datasets (list (expo::dataset *expresso*)))))
      (write-db *standard-output* :p21 :comments nil :raw-data t 
		:dataset (expo::push-evaluate-maps x-eval)))))


#+nil
(defun runone-part2 ()
  "Used for :reqs, the express-x example."
  (let* ((x-schema (slot-value *expresso* 'express-x))
	 (x-eval (expo:ensure-dataset 'expo:x-evaluation 
				      :name "target dataset" 
				      :x-schema x-schema
				      :source-datasets (list (expo::dataset *expresso*)))))
    (write-db *standard-output* :p21 :comments nil :raw-data t 
	      :dataset (expo::push-evaluate-maps x-eval))))

#+nil
(defun compileit ()
  (set-debugging :exx 5)
  (let ((x-schema (schema *expresso*)))
    (compile-views x-schema)
    (compile-maps x-schema)))

#+nil
(defun tryme2 ()
  "This one loads an existing lisp-translated schema and runs it."
  (info-message "~%;;;;;  Loading schema ;;;;;")
  ;;(load target) ; loading the schema makes it the current-schema.
  (load #P"/home/pdenno/projects/expresso/goal-x.lisp")
  (let* ((x-schema (schema *expresso*)) 
	 (x-eval (expo:ensure-dataset 'expo:x-evaluation 
				      :name "target dataset" 
				      :x-schema x-schema
				      :source-datasets (list (expo::dataset *expresso*)))))
    (info-message "~%Compiling...")
    (compile-views x-schema)
    (compile-maps x-schema)
    (write-db *standard-output* :p21 :comments nil :raw-data t 
	      :dataset (expo::push-evaluate-maps x-eval))))


#+nil
(defun reset-logical-host ()
  (setf (logical-pathname-translations "expo")
	`(("user;**;*.*.*"
	   ,(merge-pathnames
	     (make-pathname :directory '(:relative "expresso" :wild-inferiors)
			    :name :wild :type :wild :version :wild)
	     (user-homedir-pathname)))
	  ("binary;**;*.*.*" ,(translate-logical-pathname "expo:binary;**;*.*.*"))
	  ("tmp;**;*.*.*"    ,(translate-logical-pathname "expo:tmp;**;*.*.*"))
	  ("root;*.*.*"      ,(translate-logical-pathname "expo:root;*.*.*"))
	  ("**;*.*.*"        ,(translate-logical-pathname "expo:**;*.*.*")))))

#+nil
(defun ensure-expo-directories ()
  ;; make sure that all expo:user;**;*.* directories exist.
  (ensure-directories-exist "expo:tmp;")
  (ensure-directories-exist "expo:patches;")
  (ensure-directories-exist (format nil "expo:patches;~A;" (ee-patch-dir)))
  (ensure-directories-exist "expo:user;logs;")
  (ensure-directories-exist "expo:user;patches;")
  (unless (probe-file (translate-logical-pathname "expo:user;patches;preferences.lsp"))
    (when (probe-file (translate-logical-pathname "expo:init;preferences.lsp"))
      (cp-file "expo:init;preferences.lsp"
	       "expo:user;patches;preferences.lsp")))
  (ensure-directories-exist (format nil "expo:user;patches;~A;" (ee-patch-dir)))
  )

