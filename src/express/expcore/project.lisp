
(in-package :expo)

;;; Purpose: Code to load a project file, and the files it references.
(defgeneric parse-project (elem-type self &key project &allow-other-keys))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-parse-project (&rest args)
    `(pod:def-parse parse-project project ,@args)))

(defclass project ()
  ((name :initarg :name :reader name :initform nil) ; will be used as package. 
   (documentation :initarg :documentation :initform nil)
   (project-pathname :initarg :project-pathname :reader project-pathname :initform nil)
   (project-xml :initarg :project-xml :initform nil :accessor project-xml)
   (model-files :initarg :model-files :accessor model-files :initform nil)))

(defmethod print-object ((app project) stream)
  (format stream "#<project ~A>" (name app)))

(defclass model-file ()
  ((of-project :initarg :of-project :reader of-project)
   (path :initarg :path :reader path) ; initialize instance makes sure it is a #P
   (file-size :initform 0 :initarg :file-size)
   (out-path :initarg :out-path :reader out-path :initform nil)
   (short-name :initarg :short-name :reader short-name :initform nil)
   (mapping-direction :initarg :mapping-direction :reader mapping-direction :initform nil)
   (notebook-page :initform nil :accessor notebook-page)))

(defclass processed-file ()
  ;; resulting-object is an expo:schema or expo:dataset
  ((resulting-object :initarg :resulting-object :accessor resulting-object :initform nil)
   (compiled-from :initarg :compiled-from :reader compiled-from))) ; a string, the short-name of another file.

(defclass xml-based-model-file  (model-file) ())
(defclass lisp-based-model-file (model-file) ())
(defclass text-based-model-file (model-file) 
  ((version :initarg :version :reader version :initform nil)
   (out-path :initform (schema-file-name))
   ;; schema-object is a |Schema| or |MappingSchema|, further processing produces the resulting-object.
   (schema-object :accessor schema-object :initform nil)
   ;; Package where content will be interned. Will be created, if necessary.
   (target-package :initarg :target-package)
   (force-recompile :initarg :force-recompile :initform nil)
   (target-type :initarg :target-type :initform nil :reader target-type))) ; either :xmi or :lisp (p11 only).

(defclass express-file (text-based-model-file) ())
(defclass express-x-file (text-based-model-file)
  ((target-type :initform :lisp)
   (version :initform 1)))

(defclass lisp-compiled-express-file (lisp-based-model-file processed-file) ())
(defclass xmi-compiled-express-file (lisp-based-model-file processed-file) ())
(defclass lisp-compiled-express-x-file (lisp-based-model-file processed-file) ())

;;; I don't split off 'compiled-versions.' Just set the resulting-object when processed.
(defclass data-file (model-file processed-file)
  ((mapping-direction :initarg :mapping-direction :reader mapping-direction :initform nil)
   (generated-p :initarg :generated-p :reader generated-p :initform nil)))

(defclass part21-file (data-file) ())
(defclass part28-file (data-file) ())

(defmethod initialize-instance :after ((f model-file) &key)
  "Put a pathname object in the path slot. Set the size, and short-name if necessary."
  (with-slots (path short-name file-size) f
    "Set the path to a pathname object, set file-size, set short-name,
    if it hasn't been provided."
    (when (probe-file path) (setf file-size (file-size path)))
    (when (stringp path)
      (setf path (string-trim '(#\Space) path))
      (let ((absolute-p (eql :absolute (car (pathname-directory path))))
            (filename (pathname-name path))
            (filetype (pathname-type path)))
        (setf path (make-pathname :directory (pathname-directory path)
                                  :host (when absolute-p (pathname-host path))
                                  :name filename 
                                  :type filetype))
        (unless short-name
          (setf short-name (format nil "~A.~A" filename filetype)))))))

(defmethod print-object ((f model-file) stream)
  (let ((filetype (class-name (class-of f))))
    (with-slots (path) f
      (if (probe-file (namestring path))
	  (format stream "#<~A ~A>" filetype 
		  (car (last (pod:split (namestring path) #\/))))
	  (format stream "#<~A FILE-DOES-NOT-EXIST!!>" filetype)))))

(defun read-pra-file (pathname)
  "Read a .pra file, returning a project object."
  (unless (probe-file pathname)
    ;(error 'conditions:non-existent-file-error :pathname pathname)
    (error "File does not exist: ~A" pathname))
  (let* ((doc (xmlp:document-parser (truename pathname)))
	 (name (xml-get-attr (xqdm:root doc) "name"))
	 (comments (xml-get-attr (xqdm:root doc) "documentation"))
	 (project (make-instance 'project 
				 :name name 
				 :documentation comments
				 :project-xml doc 
				 :project-pathname pathname)))
    ;; parse-project populates project.
    (parse-project :root (xqdm:root doc) :project project)
    project))

(defmethod load-project ((pathname pathname) &key (gui-p nil))
  "Load a .pra file."
;2012  (handler-bind
;2012      ((error #'(lambda (err) (abort? *expresso* :condition err))))
    (when pathname 
      (hcl:cd (make-pathname 
	       :host (pathname-host pathname)
	       :directory (pathname-directory pathname)))
      (when-bind (project (read-pra-file pathname))
	  (setf (current-app *expresso*) project) 
	  (load-project-files project :gui-p gui-p)
	  project)));)

(defmethod load-project ((p project) &key (gui-p t))
  "Load the files of a project (usually called with a 'default project' 
   when user is loading an EXPRESS file directly."
  (handler-bind
      ((error #'(lambda (err) (abort? *expresso* :condition err))))
    (setf (current-app *expresso*) p)
    (load-project-files p :gui-p gui-p)
    p))

(defgeneric load-project-files (project &key gui-p))
(defgeneric load-project-file (file &key gui-p &allow-other-keys))

(defmethod load-project-files :before (p &key gui-p)
  "Clean up before express stuff here (only once) because express-x may need it."
  (declare (ignore gui-p))
  (setf (datasets *expresso*) nil)
  (setf (schemas *expresso*) nil)
  (setf (schema *expresso*) nil)
  (setf (dataset *expresso*) nil))

;;; POD use asdf, like in minimal-vampire?
(defmethod load-project-files (p &key gui-p)
  "Load model-files of project P in the correct order. The lisp-x files are never 
   loaded here -- there should be a matching text file that will cause loading of 
   the corresponding .lisp."
  (with-slots (model-files) p
    (macrolet ((file-subset (type) `(remove-if (complement #'(lambda (x) (typep x ',type))) model-files)))
      (let ((express        (file-subset express-file))
	    (express-x      (file-subset express-x-file))
	    (p21            (file-subset part21-file))
	    (p28            (file-subset part28-file)))
	(let ((*error-output* *message-stream*))
	  (loop for file in express do (load-project-file file :gui-p gui-p))
	  (loop for file in p21 unless (generated-p file) do (load-project-file file))
	  (loop for file in p28 unless (generated-p file) do (load-project-file file))
	  (loop for file in express-x do (load-project-file file :gui-p gui-p)))))))

(defmethod corresponding-compiled ((file text-based-model-file))
  "Return the corresponding lisp-compiled-express-file for FILE or nil if none."
  (let ((compiled-type 
	 (typecase file
	   (express-file   'lisp-compiled-express-file)
	   (express-x-file 'lisp-compiled-express-x-file))))
    (find (short-name file) 
	  (remove-if (complement #'(lambda (f) (typep f compiled-type)))
		     (model-files (of-project file)))
	  :key #'compiled-from
	  :test #'string=)))

(defun new-model-file (model-file)
  "Return a compiled- version of the argument model-file."
  (with-slots (path out-path of-project short-name mapping-direction) model-file
    (make-instance (if (typep model-file 'express-file) 
		       'lisp-compiled-express-file 
		       'lisp-compiled-express-x-file)
		   :path (namestring out-path)
		   :short-name (format nil "~A.lisp" (pathname-name path))
		   :mapping-direction mapping-direction
		   :compiled-from short-name
		   :of-project of-project)))

(defun update-project (new-model-file out-path)
 "Copy the .lisp to project.project-directory, update path accordingly.
  If the project doesn't already have this lisp-compiled-express-file,
  push it onto project.model-files, and rewrite the .pra file. 
  OUT-PATH is the tmp directory where the .lsp was placed by read-schema.
  Returns the path to the NEW-MODEL-FILE."
 (with-slots (path (project of-project) short-name) new-model-file
   (when (project-pathname project) ; could be the default-project.
     (let* ((filename (car (split short-name #\.)))
	    (new-path (merge-pathnames 
		       (make-pathname :name filename :type "lisp")
		       (make-pathname 
			:host (pathname-host (project-pathname project))
			:directory (pathname-directory (project-pathname project))))))
       (rename-file out-path new-path)
       (setf path new-path)
       (with-slots (model-files) project
	 (unless (find new-model-file model-files
		       :test #'(lambda (x y)
				 (typep x (class-of new-model-file))
				 (typep y (class-of new-model-file))
				 (string= (short-name x) (short-name y))))
	   (push new-model-file model-files)
	   ;; Don't save .lisp if project includes express-x. Each run 
	   ;; currently needs to reproduce the p11 |Schema| objects for use in p14.
	   (unless (member-if #'(lambda (x) (typep x 'express-x-file)) (model-files project))
	     (save-project project))))
       new-path))))

(defmethod load-project-file :around (file &key)
  "Set status message, and possibly, debugging messages around the load."
  (flet ((pname (f) 
	   (typecase f
	     (express-file "EXPRESS file")
	     (lisp-compiled-express-file "compiled EXPRESS file")
	     (part21-file  "Part 21 file")
	     (part28-file "Part 28 file")
	     (express-x-file "Express-x file")
	     (lisp-compiled-express-x-file "Express-x file"))))
    (dbg-message :any 1 "~%Before load of ~A ~A" (pname file) (short-name file))
    (status-message "Loading ~A ~A" (pname file) (short-name file))
    (call-next-method)
    (status-message "Done.")
    (dbg-message :any 1 "~%After load of ~A ~A" (pname file) (short-name file))))
  
(defmethod load-project-file ((file text-based-model-file) &key gui-p (reload-page t))
  "Load FILE, an express-file or the corresponding .lisp if one exists and is newer.
   Produce a lisp/xmi-compiled-express-file and push it into the project model-files.
   Only do load-schema, if target-type is :lisp. If XMI, this just creates the |Schema|
   (placed in file.resulting-object). File is type express-file or express-x-file."
  (flet ((newer-p (f1 f2) (> (file-write-date (path f1)) 
			     (file-write-date (path f2)))))
    (let ((mofi:*model* (mofi:find-model :mexico)))
      (when (and gui-p reload-page)
	(funcall (intern "LOAD-NOTEBOOK-PAGE" :gui) file)
	(funcall (intern "DO-GUI-EVENTS" :gui)))
      (with-slots (target-type of-project force-recompile) file
	(ecase target-type
	  ((:xmi :pretty-express)  (read-schema file))
	  (:lisp
	   (let ((compiled? (corresponding-compiled file)))
	     ;; POD for now, if it is and express-x project, re-compile.
	     (if (and compiled?
		      (not force-recompile)
		      (newer-p compiled? file))
		 (load-project-file compiled?)
		 (let ((schema (read-schema file :lisp-gen t)) ; writes to out-path
		       (new-file (new-model-file file)))
		   (setf (schema-object file) schema)
		   ;; I move the file before laoding so that I don't have to search tmp 
		   ;; for the oddly named file, while debugging.
                   (when of-project (update-project new-file (out-path file)))
		   (load-project-file new-file))))))))) ; path is file.out-path
  (values))
  
(defmethod load-project-file ((file lisp-compiled-express-file) &key)
  (with-slots (resulting-object) file
    (let ((schema (load-schema file)))
      (setf resulting-object schema))))

(defmethod load-project-file ((file lisp-compiled-express-x-file) &key)
  "Load .lisp and compile-maps."
  (with-slots (resulting-object) file
    (let ((schema (load-schema file)))
      (mofi:load-model schema)
      (setf resulting-object schema))))

(defmethod load-project-file ((file part21-file) &key)
  "Reads part21, returns the argument file, with the resulting-object set."
  (let ((data (read-data file)))
    (with-vo (mut) 
      (setf mut data))
    (setf (resulting-object file) data)))

(defmethod load-project-file ((file part28-file) &key)
  "Reads part28, returns the argument file, with the resulting-object set."
  (let ((data (read-data file)))
    (with-vo (mut) (setf mut data))
    (setf (resulting-object file) data)))

(def-parse-project (:root)
  ("model-files"))

(def-parse-project (:model-files)
    ("express-file")
    ("lisp-compiled-express-file")
    ("express-x-file")
    ("lisp-compiled-express-x-file")
    ("part21-file")
    ("part28-file")
    ("part28-file"))

(def-parse-project (:express-file "path" "version" "mapping-direction" 
				  "target-type" "target-package" "force-recompile")
    (:self
     (push
      (make-instance 'express-file :path (string path) :version version
		     :of-project project
		     :target-package target-package
		     :target-type (if target-type (kintern target-type) :lisp)
		     :mapping-direction (when mapping-direction (kintern mapping-direction))
		     :force-recompile (kintern force-recompile)
		     :version version)
      (model-files project))))

(def-parse-project (:lisp-compiled-express-file "path" "compiled-from")
    (:self
     (push
      (make-instance 'lisp-compiled-express-file 
		     :of-project project
		     :path (string path) :compiled-from (string compiled-from))
      (model-files project))))

(def-parse-project (:lisp-compiled-express-x-file "path" "compiled-from")
    (:self
     (push
      (make-instance 'lisp-compiled-express-x-file 
		     :of-project project
		     :path (string path) :compiled-from (string compiled-from))
      (model-files project))))


(def-parse-project (:express-x-file "path")
    (:self
     (push
      (make-instance 'express-x-file :of-project project :path (string path))
      (model-files project))))

(def-parse-project (:part21-file "path" "mapping-direction")
    (:self
     (push
      (make-instance 'part21-file 
		     :of-project project
		     :path (string path)
		     :mapping-direction (when mapping-direction (kintern mapping-direction)))
      (model-files project))))

(def-parse-project (:part28-file "path" "mapping-direction")
    (:self
     (push
      (make-instance 'part28-file 
		     :of-project project
		     :path (string path)
		     :mapping-direction (when mapping-direction (kintern mapping-direction)))
      (model-files project))))

(defun save-project (project &key out-path)
  "Write a .pra file, either to OUT-PATH, or to project.project-pathname."
  (with-slots (name project-pathname model-files) project
    (setf out-path (or out-path project-pathname))
    (let* ((doc (xmlp::parse-document #P"expo:lib;project-template.xml"))
	   (root (xqdm:root doc))
	   (mfiles-node (xml-make-node doc root "model-files" nil :type 'xqdm:elem-node)))
      (when-bind (modification (xml-find-child "LastModificationDate" root))
	(setf (xqdm:children modification) (list (now))))
      (when-bind (expo-version (xml-find-child "ExpressoVersion" root))
	(setf (xqdm:children expo-version) (list (ee-version))))
      (setf (xqdm:attributes root) (list (xml-make-node doc root "name" name)))
      (setf (xqdm:children root) 
	    (append (xqdm:children root) (list mfiles-node)))
      (setf (xqdm:children mfiles-node) 
	    (loop for child in (mapcar #'(lambda (f) (model-file-node f doc mfiles-node)) model-files)
		  collect (format nil "~%") collect child collect (format nil "~%")))
      (when (equal project-pathname out-path)
	(rename-file project-pathname 
		     (merge-pathnames 
		      (make-pathname :name (pathname-name project-pathname) :type "old")
		      (make-pathname 
                       :host (pathname-host project-pathname)
		       :directory (pathname-directory project-pathname)))))
      (with-open-file (s out-path :direction :output :if-exists :supersede)
	  (xml-parser:write-node doc s)))))

(defgeneric model-file-node (file doc parent))

(defmethod model-file-node ((file text-based-model-file) doc parent)
   "express-file, express-x-file: Create an xml node for the argument model file FILE."
   (with-slots (path version mapping-direction target-type force-recompile) file
     (let ((path-attr (list (xml-make-node doc parent "path" (namestring path))))
	   (vers-attr (list (xml-make-node doc parent "version" (format nil "~A" version))))
	   (direction (when mapping-direction 
			(list (xml-make-node doc parent "mapping-direction" (string mapping-direction)))))
	   (recompile (when force-recompile 
			(list (xml-make-node doc parent "force-recompile" (string force-recompile)))))
	   (target (when target-type 
		     (list (xml-make-node doc parent "target-type" (string target-type)))))
	   (fnode (xml-make-node doc parent (string-downcase (string (class-name (class-of file))))
				 nil :type 'xqdm:elem-node)))
       (setf (xqdm:attributes fnode) (append path-attr vers-attr direction target recompile))
       fnode)))

(defmethod model-file-node ((file processed-file) doc parent)
   "lisp-compiled-express-file, lisp-compiled-express-x-file xmi-compiled-express-file:
    Create an xml node for the argument model file FILE."
   (with-slots (path compiled-from) file
     (let ((path-attr (xml-make-node doc parent "path" (namestring path)))
	   (comp-attr (xml-make-node doc parent "compiled-from" 
				     (format nil "~A" compiled-from)))
	   (fnode (xml-make-node doc parent (string-downcase (string (class-name (class-of file))))
				 nil :type 'xqdm:elem-node)))
       (setf (xqdm:attributes fnode) (list path-attr comp-attr))
       fnode)))

(defmethod model-file-node ((file data-file) doc parent)
   "Part21-file, Part23-file: Create an xml node for the argument model file FILE."
   (with-slots (path  mapping-direction) file
     (let ((path-attr (list (xml-make-node doc parent "path" (namestring path))))
	   (direction (when mapping-direction 
			(list (xml-make-node doc parent "mapping-direction" (string mapping-direction)))))
	   (fnode (xml-make-node doc parent (string-downcase (string (class-name (class-of file))))
				 nil :type 'xqdm:elem-node)))
       (setf (xqdm:attributes fnode) (append path-attr direction))
       fnode)))

(export '(save-project current-app))

;;; End of file