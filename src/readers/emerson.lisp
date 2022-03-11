
;;; Purpose: Read Emerson templates for validation, etc. 
;;; Date: 2012-08-08

(in-package :emerson) 

(defvar *emerson-base-templates* nil "Used to resolve name of parent of specialized templates.")

(defun toplevel-read-emerson (&key model)
  "Toplevel function to create a template population from the emerson spreadsheet."
  (read-base-templates model)
  (read-specialized-individual-templates model)
  (with-slots (mofi:templates) model
    (setf mofi:templates (sort mofi:templates #'string< :key #'name))
    (loop for tt in mofi:templates do ; resolve parent names to parent templates.
	 (with-slots (parent-template) tt
	   (when-bind (pp (find parent-template mofi:templates :key #'name))
	     (setf parent-template pp)))))
  (values))


(defun mig-normalize (str) 
  "Interprete raw string."
  (let ((trimmed (string-trim '(#\Space) str)))
    (cond ((equal trimmed "") nil)
	  ((cl-ppcre:scan "^\\d+$" trimmed) (read-from-string trimmed))
	  (t (string-trim '#(#\Space #\") trimmed)))))

(defun read-base-templates (model)
  "Read emerson base templates in tlogic template objects. Pushes onto model.template slot. Returns (values)."
  (flet ((c2l (str) (intern (cl-ppcre:regex-replace-all " " (string-trim '(#\Space) str) "-"))))
    (setf *emerson-base-templates* nil)
    (with-open-file (csv (lpath :cre "data/emerson-csv/base-template.csv") :direction :input)
      (read-line csv nil :eof)
      (loop for line = (read-line csv nil :eof)
	 until (eql line :eof)
	 for line-data = (split line #\|) do 
	   (dbind (a note1 c d e f note2 template-id name note3 k 
		     r1-uri r1-name r1-desc r1-type r1-val
		     r2-uri r2-name r2-desc r2-type r2-val &optional
		     r3-uri r3-name r3-desc r3-type r3-val
		     r4-uri r4-name r4-desc r4-type r4-val
		     r5-uri r5-name r5-desc r5-type r5-val
		     r6-uri r6-name r6-desc r6-type r6-val
		     r7-uri r7-name r7-desc r7-type r7-val &rest ignore)
		 (mapcar #'mig-normalize line-data)
	     (declare (ignore ignore a c d e f k))
	     (let (conditions)
	       (handler-bind ((simple-warning #'(lambda (c) (push c conditions) (muffle-warning))))
		 (let* ((r1 (when r1-uri (mk-template-role 1 r1-uri r1-name r1-desc r1-type r1-val)))
			(r2 (when r2-uri (mk-template-role 2 r2-uri r2-name r2-desc r2-type r2-val)))
			(r3 (when r3-uri (mk-template-role 3 r3-uri r3-name r3-desc r3-type r3-val)))
			(r4 (when r4-uri (mk-template-role 4 r4-uri r4-name r4-desc r4-type r4-val)))
			(r5 (when r5-uri (mk-template-role 5 r5-uri r5-name r5-desc r5-type r5-val)))
			(r6 (when r6-uri (mk-template-role 6 r6-uri r6-name r6-desc r6-type r6-val)))
			(r7 (when r7-uri (mk-template-role 7 r7-uri r7-name r7-desc r7-type r7-val)))
			(temp (make-instance 
			       'tlogic:template
			       :name name
			       :of-model model
			       :conditions conditions
			       :uri template-id
			       :roles (remove-if #'null (list r1 r2 r3 r4 r5 r6 r7))
			       :comment (strcat (or note1 "") " --- " (or note2 "") " --- " (or note3 "")))))
		   (push temp (mofi:templates model))
		   (push temp *emerson-base-templates*))))))))
  (values))


(defun mk-template-role (index uri name desc type val)
  (when val (format t "BTR: Value is used: ~A" val)) 
  (make-instance 'tlogic:template-role 
		 :name name 
		 :index index
		 :type (bt-translate-type type)
		 :uri uri
		 :comment (or desc "")))

(defclass rdl-ref ()
  ;; an identifier unique in the context of the RDS. 
  ((designation :initarg designation)
   ;; URL for a page at the RDL describing the object. 
   (url :initarg url)))

(defclass posccaesar-rdl-ref ()
  ())

(defun bt-translate-type (str)
  "Translate a type string STR to URI reference to type. If unresolvable, just return STR."
  (let (success vec)
    success
    (flet ((p2-url (str)
	     (if-bind (class (find-class (intern str :p2) nil))
	       (mofb:url-class-browser class :force-text (tlog:p2name2p7name (class-name class)))
	       (progn (warn 'tlog:template-unresolved-class :class-name str) str))))
      (cond ((null str) (find-class (intern "THING" :p2)))
	    ((stringp str)
	     (cond ((cl-ppcre:scan "^INTEGER$" str)
		    (p2-url "EXPRESS_INTEGER"))
		   ((cl-ppcre:scan "^BOOLEAN$" str)
		    (p2-url "EXPRESS_BOOLEAN"))
		   ((cl-ppcre:scan "(?i)^STRING$" str)
		    (p2-url "EXPRESS_STRING"))
		   ((or (cl-ppcre:scan "^DOUBLE" str) 
			(cl-ppcre:scan "^REAL" str) 
			(cl-ppcre:scan "^DECIMAL" str))
		    (p2-url "EXPRESS_REAL"))
		   ((mvs (success vec) (cl-ppcre:scan-to-strings "^ISO 15926-4 (\.+)$" str))
		    (p2-url (substitute #\_ #\Space (svref vec 0))))
		   ((mvs (success vec) (cl-ppcre:scan-to-strings "^ISO-IS 15926-2 (\.+)$" str))
		    (p2-url (substitute #\_ #\Space (svref vec 0))))
;		   ((p2-url (substitute #\_ #\Space str)))
		   (t
		    (if-bind (pca-id (tlogic:rds-lookup-desig2pca-id str))
			     (phttp:url-rds-lookup-class pca-id str)
			     (p2-url str)))))))))


(defun read-specialized-individual-templates (model)
  "Read information from the 'specialized individual template' tab and create templates.
   This should be performed after read-base-templates, because those are referenced here."
  (flet ((c2l (str) (intern (cl-ppcre:regex-replace-all " " (string-trim '(#\Space) str) "-"))))
    (with-open-file (csv (lpath :cre "data/emerson-csv/specialized-individual-template.csv") :direction :input)
      (read-line csv nil :eof)
      (loop for line = (read-line csv nil :eof) with line-num = 2
	 until (eql line :eof)
	 for line-data = (split line #\|) do 
	   (incf line-num)
	   (dbind (a b class-label property rel-to rel-type rel-card template-id
		   tname tdesc &optional parent
		     r1-uri r1-name r1-desc r1-type r1-val
		     r2-uri r2-name r2-desc r2-type r2-val 
		     r3-uri r3-name r3-desc r3-type r3-val
		     r4-uri r4-name r4-desc r4-type r4-val
		     r5-uri r5-name r5-desc r5-type r5-val
		     r6-uri r6-name r6-desc r6-type r6-val
		     r7-uri r7-name r7-desc r7-type r7-val &rest ignore)
		 (mapcar #'mig-normalize line-data)
	     (declare (ignore ignore a b))
	     (let (conditions)
	       (handler-bind ((simple-warning #'(lambda (c) (push c conditions) (muffle-warning))))
		 (let ((r1 (when r1-name (mk-template-role 1 r1-uri r1-name r1-desc r1-type r1-val)))
		       (r2 (when r2-name (mk-template-role 2 r2-uri r2-name r2-desc r2-type r2-val)))
		       (r3 (when r3-name (mk-template-role 3 r3-uri r3-name r3-desc r3-type r3-val)))
		       (r4 (when r4-name (mk-template-role 4 r4-uri r4-name r4-desc r4-type r4-val)))
		       (r5 (when r5-name (mk-template-role 5 r5-uri r5-name r5-desc r5-type r5-val)))
		       (r6 (when r6-name (mk-template-role 6 r6-uri r6-name r6-desc r6-type r6-val)))
		       (r7 (when r7-name (mk-template-role 7 r7-uri r7-name r7-desc r7-type r7-val)))
		       (ptemp (or (find parent *emerson-base-templates* :key #'name :test #'string=)
				  (warn 'tlogic:template-cannot-resolve-base-template :base-name  tname))))
		   (if tname
		       (push
			(make-instance 'tlogic:template
				       :name (dash-to-camel tname :separator #\Space)
				       :of-model model
				       :parent-template ptemp
				       :conditions conditions
				       :uri template-id
				       :roles (remove-if #'null (list r1 r2 r3 r4 r5 r6 r7))
				       :comment (sit-format-comment class-label property rel-to rel-type
								    rel-card tdesc))
			(mofi:templates model))
		       (format t "~%No template for ~A." line-data))))))))))

(defun sit-format-comment (class-label property rel-to rel-type rel-card tdesc)
  "Return a string that will be the complete comment of the template."
  (strcat 
   (if property
       (format nil "<strong>Property ~A.~A</strong><br/>" 
	       (string-capitalize class-label) (string-downcase property))
       (format nil "<br/>Relation ~A.~A (~A ~A from ~A to ~A)" 
	       (string-capitalize class-label) (string-downcase rel-to)
	       rel-card rel-type (string-capitalize class-label) (string-capitalize rel-to)))
   (format nil "<br/><strong>Description:</strong> ~A" tdesc)))

#+nil
(defun read-class-template-instance (&key pathname msg-type start-column)
  "Read the class template instance tab."
  (flet ((c2l (str) (intern (cl-ppcre:regex-replace-all " " (string-trim '(#\Space) str) "-"))))
    (with-open-file (csv (lpath :cre "data/emerson-csv/class-template-instance.csv") :direction :input)
      (ensure-trie-db :emerson)
      (with-trie-db (:emerson)
	(loop for line = (read-line csv nil :eof) with unique-ht = (make-hash-table)
	   until (eql line :eof)
	   for line-data = (split line #\|) do 
	     (dbind (a b c d e f g tname &optional i j k r1-name m n r1-val p r2-name r s r2-val u r3-name 
                     w x r3-val 
		     z r4-name ab r4-type ad ae r5-name ag r5-type r5-val aj r6-name al r6-type r6-val ao
		     r7-name aq r7-type r7-val &rest ignore)
		 (mapcar #'mig-normalize line-data)
	       (declare (ignore ignore a b c d e f g i j k mn r s u w x z ab ad ae ag aj al ao aq))
	       (when (string= tname "AssemblyRelation")
		 (let ((rel-name (c2l r3-val)))
		   (trie-add `(instance ,rel-name |AssemblyRelation|))
		   (trie-add `(domain ,rel-name 1 ,(c2l r2-val)))
		   (trie-add `(domain ,rel-name 2 ,(c2l r1-val)))))))
	(show-db)))))


