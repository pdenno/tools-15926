;;; Purpose: Read OWL-encoded template definitions into internal form.
;;;          Toplevel function, read-owl

;;; ToDo:
;;;        - Warn when the same slot is defined multiple (see mmt:DescriptionOfClass).
;;;        - Warn when slot name is nil.
;;;        - Store conditions on instances
;;;        - Create classes for template defs "on the fly."
;;; ABOVE TWO BEFORE FIATECH DEMO!
;;;        - Must allow non-standard namespaces for sources of templates.
;;;        - don't warn no axiom on prototemplates (or where you can find axiom)
;;;        - Report on what nspaces were used, and which should have been used.

(in-package :tlogic)

(defun type-symbol (obj)
  "Return a symbol representing the type (not like cl:type-of)."
  (cond ((symbolp obj) obj)
	((expo:ientity-mo-p obj)
	 (car (expo::relative-leaves (mapcar #'class-name (cdr (class-precedence-list obj))))))))

(declaim (inline rdf-resource rdf-datatype))
(defun rdf-resource (elem)
  "Get the rdf:resource attribute of xml element ELEM."
  (string-trim '(#\Space) (xml-utils:xml-get-attr-value elem 'rdf:|resource|)))

(defun rdf-datatype (elem)
  "Get the rdf:resource attribute of xml element ELEM."
  (values
   (xml-utils:xml-get-attr-value elem 'rdf:|datatype|)
   (car (xml-utils:xml-children elem))))

(defvar *owl-object-properties* nil)   ; POD collected but not used.
(defvar *owl-datatype-properties* nil) ; POD collected but not used.

(defvar *tmpl* nil "set to current template -- POD should be dynamically bound...def-parse problem.")
(defvar *inst* nil "set to current instance.")

(declaim (inline puri-string))
(defun puri-string (uri)
  "Return a string for the argument PURI uri."
  (with-output-to-string (str)
    (puri:render-uri uri str)))

(defvar *templates* (make-hash-table :test #'equal))
(defun ensure-template (id &key model)
  "Return an existing template or create a new one. NAME can be a complete
   URI or a fragement, but they are identified by the fragment."
  (let* ((uri (puri:parse-uri id))
	 (name (puri:uri-fragment uri)))
    (or
     (gethash name *templates*)
     (let ((new (make-instance 'template
			       :name name
			       :uri (and (puri:uri-host uri)
					 (puri-string uri))
			       :of-model model)))
       (setf (gethash name *templates*) new)
       (push new (mofi:templates model))
       new))))

(defmacro with-xml-attrs (roles elem &body body)
  (with-gensyms (children)
  `(let* ((,children (xml-utils:xml-children ,elem))
	  ,@(mapcar #'(lambda (r) `(,(car r) (xml-find-child ',(cadr r) ,children))) roles))
     ,@body)))

#+nil
(defmemo sym2rdf (sym)
 "(sym2rdf 'p7tm:|TemplateDescription|) -->
  'http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#TemplateDescription'"
  (strcat (package-name (symbol-package sym))
	  (symbol-name sym)))

(defmemo sym2rdf (sym)
 "(sym2rdf 'p7tm:|TemplateDescription|) -->
  'http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#TemplateDescription'"
  (strcat (first (package-nicknames (symbol-package sym)))
	  (symbol-name sym)))

(defgeneric rdf-typep (elem type))
;;; BTW, Anderson's XML code substitutes string for XML entity definitions.
(defmethod rdf-typep (elem (type symbol))
  "Return T if elem has an RDF:type with resource string= the (sym2rdf symbol)."
  (and
   (dom:element-p elem)
   (when-bind (type-elem (find-if #'(lambda (x) (xml-utils:xml-typep-3 x 'rdf:|type|)) (xml-utils:xml-children elem)))
     (when-bind (rdf-type (xml-utils:xml-get-attr-value type-elem 'rdf:|resource|))
       (string= rdf-type (sym2rdf type))))))

(defmacro def-parse! (method-name pass-downward (type &rest binds) &body body)
  (let* ((aux (cdr (member '&aux binds))) ; can't use dbind, not same idea.
	 (keys (cdr (member '&key binds)))
	 (keys (subseq keys 0 (position '&aux keys)))
	 (attrs (subseq binds 0 (position '&key binds))) action)
    (with-gensyms (chilun c sint?)
      `(defmethod ,method-name ((elem-type (eql ,type)) dself &key ,pass-downward ,@keys)
	 (declare (ignorable dself ,pass-downward))
	 (let* ((,sint? nil)
		(,chilun (xml-utils:xml-children dself))
		,@(loop for (vname aname) in attrs collect
			`(,vname (xml-utils:xml-get-attr-value dself ,aname)))
		,@aux)
	   (declare (ignorable ,chilun ,sint?))
	   ,@(loop for bod in body collect
		  (dbind (term &rest action/args) bod
		    (setf action 'do)
		    (cond ((eql :self term)
			   `(progn ,@action/args))
			  (t
			   (cond ((eql term :collect) (setq action 'collect))
				 ((eql term :append)  (setq action 'append))
				 ((symbolp term) (setf action term))
				 ((listp term) (first action/args) action/args (second action/args))
				 (t (error "Unknown def-parse action: ~A" term)))
			    `(loop for ,c in ,chilun
				   when (xml-utils:xml-typep-3 ,c ,term) ,action
				  (,method-name ,term ,c
						,(kintern pass-downward) ,pass-downward ,@action/args)))))))))))

(defgeneric parse-tmpl (elem-type dself &key model &allow-other-keys))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-parse-tmpl (&rest args)
    `(def-parse! parse-tmpl model ,@args)))

(defvar *zippy* nil "Diagnostic")
(defvar *mmm* nil "Diagnostic to skip model read.")

(defun read-owl (&key file model mmm)
  "Toplevel to processing a P8 OWL/XML file of P7 template definitions and instances."
    (let ((*error-output* *null-stream*))
      (setf mofi:*mm-debug-id* 0)
      (with-vo (mut) (setf mut model)
	(with-slots (mofi:general-errors mofi:source-file) model
	  (when file (setf mofi:source-file file))
	  (handler-bind (#+cre.exe
			 (error #'(lambda (c) (push c mofi:general-errors) (return-from read-owl model)))
			 (simple-warning #'(lambda (c)
					     (cond (*tmpl* (push c (conditions *tmpl*)))
						   (*inst* (push c (mofi:%conditions *inst*)))
						   (t (push c mofi:general-errors)))
					     (muffle-warning))))
	    (let ((doc (or mmm (xml-utils:xml-document-parser file))))
	      (with-slots (mofi:user-doc mofi:endpoints) model
		(setf mofi:user-doc doc)
		(setf mofi:endpoints (rdl-endpoints mut)))
	      (transform-owl-thing doc)
	      (setf *mmm* doc) ; POD temporary!
	      (clrhash *templates*) ; used by ensure-
	      (setf *owl-object-properties* nil)
	      (setf *owl-datatype-properties* nil)
	      #+nil(unless (find-namespace doc :p7tm)
		(warn 'template-missing-namespace :ns :p7tm)) ; 2022 Too slow!
	      (if (xml-utils:xml-typep-3 (xml-utils:xml-root doc) 'rdf::RDF)
		  (parse-tmpl 'rdf::RDF (xml-utils:xml-root doc) :model model)
		  (warn "Root of document is not an RDF:RDF element"))
	      (pp-owl-class model)
	      (with-slots (mofi:templates) model
		;; owl class thing??? (setf mofi:templates (remove-if-not #'template-metatype mofi:templates))
		(setf mofi:templates (sort mofi:templates #'string< :key #'name))
		(loop for tpl in mofi:templates
		   do (setf (roles tpl) (sort (roles tpl) #'(lambda (x y)
							      (and (numberp x)
								   (numberp y)
								   (< x y)))
					      :key #'index)))
		(mapc #'validate-template mofi:templates)))
	    (process-instances model)))))
    model)

(defun transform-owl-thing (doc)
  "Transform <owl:Thing <rdf:type rdf:resource='xyz'/> ...</owl:Thing> (Onno form) to  <xyz ..../>"
  (depth-first-search
   (xml-utils:xml-root doc)
   #'fail
   #'xml-utils:xml-children
   :do #'(lambda (x)
	   (when (and (dom:element-p x)
		      (xml-utils:xml-typep-3 x 'owl:|Thing|))
	     (when-bind (type (find-if #'(lambda (y) (xml-utils:xml-typep-3 y 'rdf:|type|)) (xml-utils:xml-children x)))
	       (cond ((rdf-typep x 'p7tm:|TemplateDescription|)
		      (setf (dom:local-name x) 'p7tm:|TemplateDescription|))
		     ((rdf-typep x 'p7tm:|TemplateRoleDescription|)
		      (setf (dom:local-name x) 'p7tm:|TemplateRoleDescription|)))
	       (setf (xml-utils:xml-children x) (remove type (xml-utils:xml-children x))))))))

;;; 2022 I'm not using this! Too slow!
(defun find-namespace (elem ns)
  "Return the namespace NS, a symbol naming a package."
  (let ((pname (package-name (find-package ns))))
    (breadth-first-search
     elem
     #'(lambda (x)
	 (setf *zippy* x)
	 (and
	  (dom:element-p x)
	  (find pname (mapcar #'first (xml-utils:xml-namespaces x))
		:test #'string=
		:key #'rune-dom::value)))
     #'xml-utils:xml-children
     :on-fail nil)))

;;; POD The use of def-parse macro-ology here isn't very effective.
;;; That approach is more useful when the XML structure is deep (like XMI).
(def-parse-tmpl ('rdf:RDF)
    ('owl:|Ontology|)
    ('owl:|ObjectProperty|)
    ('owl:|DataTypeProperty|)
    ('owl:|Class|)
    ('p7tm:|TemplateRoleDescription|)
    ('p7tm:|TemplateDescription|)
    ('p7tm:|TemplateSpecialization|))

(def-parse-tmpl ('owl:|Ontology|)
    (:self ; just set the documentation, if any...
     (when-bind (comment (find-if #'(lambda (x) (xml-utils:xml-typep-3 x 'rdfs:|comment|))
				  (xml-utils:xml-children dself)))
       (setf (slot-value model 'mofi::documentation)
	     (car (xml-utils:xml-children comment))))))

;;; These are stored for processing after template is made. See  "Post-process owl:Class"
(def-parse-tmpl ('owl:|Class|
		      (resource1 'rdf:|about|)
		      (resource2 'rdf:id))
    (:self
     (when-bind (id (or resource1 resource2))
       (when (gethash id (mofi:owl-classes model))
	 (warn "OWL class ~A encountered multiple." id))
       (setf (gethash id (mofi:owl-classes model)) dself))))

(def-parse-tmpl ('p7tm:|TemplateRoleDescription|)
    (:self
     (process-role dself :model model)))

(def-parse-tmpl ('p7tm:|TemplateDescription|)
    (:self
     (with-xml-attrs ((tmpl-elem p7tm:|hasTemplate|)) dself
       (when-bind (name (rdf-resource tmpl-elem))
	 (setf *tmpl* (ensure-template name :model model)))))
  ;('p7tpl:|valFOLCode| :tmpl *tmpl*) ; see mindmap P8,Spec,Fundamental concepts,namespaces
  ('p7tm:|valFOLCode| :tmpl *tmpl*) ; new 2013-04-16
  ('p7tm:|valNumberOfRoles| :tmpl *tmpl*))

(def-parse-tmpl ('p7tm:|valNumberOfRoles| &key tmpl)
    (:self
     (when-bind (str (car (xml-utils:xml-children dself)))
       (when (and (stringp str) (not (zerop (length str))))
	 (when-bind (n (read-from-string str))
	   (when (numberp n)
	     (with-slots (number-of-roles) tmpl
	       (setf number-of-roles n))))))))

; 2013-04-16
;(def-parse-tmpl ('p7tpl:|valFOLCode|
;			&key tmpl)
;    ('p7tpl:|script| :tmpl tmpl))

;(def-parse-tmpl ('p7tpl:|script|
;			&key tmpl)
(def-parse-tmpl ('p7tm:|valFOLCode| &key tmpl)
    (:self
     (when-bind (text (find-if #'(lambda (x) (and (stringp x) (cl-ppcre:scan "<->" x)))
			       (xml-utils:xml-children dself)))
       (setf text (string-trim '(#\Space #\Tab #\Linefeed #\Return) text))
       (with-slots (logic-text) tmpl
	 (setf logic-text text)))))


(def-parse-tmpl ('p7tm:|TemplateSpecialization|)
    (:self
     (setf *tmpl* nil)
     (with-xml-attrs ((sub-elem p7tm:|hasSubTemplate|)
		      (sup-elem p7tm:|hasSuperTemplate|)) dself
       (when-bind (sub-uri (rdf-resource sub-elem))
	 (when-bind (sup-uri (rdf-resource sup-elem))
	   (let ((sub (ensure-template sub-uri :model model))
		 (sup (ensure-template sup-uri :model model)))
	     (with-slots (parent-template) sub
	       (setf parent-template sup))))))))


(def-parse-tmpl ('owl:|ObjectProperty|
		       (about 'rdf:|about|))
    (:self
     (if about
	 (pushnew about *owl-object-properties* :test #'string=)
	 (warn "owl:ObjectProperty no reference."))))

(def-parse-tmpl ('owl:|DataTypeProperty|
		       (about 'rdf:|about|))
    (:self
     (if about
	 (pushnew about *owl-datatype-properties* :test #'string=)
	 (warn "owl:DataTypeProperty no reference."))))

(defun process-role (elem &key model)
  "Create a role object from the argument ELEM XML, a TemplateRoleDescription."
  (with-xml-attrs ((tmpl-elem p7tm:|hasTemplate|)) elem
    (when-bind (name (rdf-resource tmpl-elem))
      (let ((*tmpl* (ensure-template name :model model)))
	(declare (special *tmpl*))
	(with-xml-attrs ((role    p7tm:|hasRole|)
			 (index   p7tm:|valRoleIndex|)
			 (type    p7tm:|hasRoleFillerType|)
			 (comment rdfs:|label|)) elem
	  (when comment
	    (setf comment (string-trim '(#\Space) (car (xml-utils:xml-children comment))))
	    (mvb (success vec)
		(cl-ppcre:scan-to-strings "^\\(\\d+\\)\\s+\\w+\\s+(.*)$" comment)
	      (if success (setf comment (svref vec 0)) (setf comment ""))))
	  (let ((role-obj
		 (make-instance 'template-role
				:name (puri:uri-fragment (puri:parse-uri (rdf-resource role)))
				:uri (rdf-resource role)
				:index (when-bind (c (car (xml-utils:xml-children index)))
					 (read-from-string c))
				:type (or (translate-type (rdf-resource type) type) (find-class 'p2::thing))
				:comment comment
				:of-template *tmpl*)))
	    (push role-obj (roles *tmpl*))))))))

(defun translate-type (str xml)
  "Use the str to identify an EXPRESS entity type, or datatype (lisp symbol 'string, 'integer etc)."
  (if (null str)
      (find-class 'p2::thing)
      (let* ((uri (puri:parse-uri str))
	     (frag (puri:uri-fragment uri)))
	(cond ((and (puri:uri-host uri)  ; RDS...
		    (string= (puri:uri-host uri) "rds.posccaesar.org")
		    (string= (puri:uri-path uri) "/2008/06/OWL/RDL"))
	       uri)
	      ((and (puri:uri-host uri) ; DM....
		    (string= (puri:uri-host uri) "standards.iso.org")
		    (string= (puri:uri-path uri) "/iso/ts/15926/-8/ed-1/tech/reference-data/data-model"))
	       (translate-type-dm frag xml))
	      ((and (puri:uri-host uri) ; XSD Primitive...
		    (string= (puri:uri-host uri) "www.w3.org")
		    (string= (puri:uri-path uri) "/2001/XMLSchema"))
	       (if-bind (type-name (find (kintern (string-upcase frag))
					 '(:integer :string :float :datetime)))
			type-name
			(warn 'template-unknown-type :type-name str :xml xml)))
	      (t   (warn 'template-unresolved-class :class-name str :xml xml))))))


(defun translate-type-dm (frag xml)
  "Translate a type for DM entities. Frag can be 'type1ANDtype2'."
  (if (cl-ppcre:scan "AND" frag) ; POD only works for two.
      (mvb (success vec) (cl-ppcre:scan-to-strings "(.*)AND(.*)" frag)
	(declare (ignore success)) ; Buddhist...
	(let ((r1 (intern (p7name2p2name (svref vec 0)) :part2))
	      (r2 (intern (p7name2p2name (svref vec 1)) :part2)))
	  (or
	   (expo::find-programmatic-class (list r1 r2) :error-p nil)
	   (warn 'template-unknown-type :type-name frag :xml xml))))
      (or
       (expo::find-programmatic-class (list (intern (p7name2p2name frag) :part2)) :error-p nil)
       (warn 'template-unknown-type :type-name frag :xml xml))))


(defun translate-legacy-ns (in-path out-path)
  "Replace lines with old namespace string with the new namespace string."
  (macrolet ((from-to (from to)
	       `(setf line (cl-ppcre:regex-replace ,from line ,to))))
    (with-open-file (in in-path :direction :input)
      (with-open-file (out out-path :direction :output :if-exists :supersede)
	(loop for line = (read-line in nil nil)
	   while line do
	     ;; p7tm
	     (from-to
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template-model#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tm#")
	     (from-to
	      "http://standards.iso.org/iso/15926/tm#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tm#")
	     ;; p7tpl -- prototypes, etc.
	     (from-to
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/template#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tpl#")
	     (from-to
	      "http://standards.iso.org/iso/15926/tpl#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tpl#")
	     (from-to ; not so sure this is a good idea!
	      "http://15926.org/templates-test/templates#" ; script
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/p7tpl#")
	     ;; dm
	     (from-to
	      "http://standards.iso.org/iso/15926/dm#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/data-model#")
	     (from-to
	      "http://rds.posccaesar.org/2008/02/OWL/ISO-15926-2_2003#"
	      "http://standards.iso.org/iso/ts/15926/-8/ed-1/tech/reference-data/data-model#")
	   (write-line line out))))))


;;;=======================================================
;;; Post-process owl:Class objects for each template,
;;; Pick up cardinality of roles, check for no new roles.
;;;=======================================================
(defun pp-owl-class (model)
  "Add information about templates from their associated owl:Class objects."
  (with-slots (mofi:owl-classes mofi:templates) model
    (loop for key being the hash-key of mofi:owl-classes using (hash-value class)
	  for tmpl = (find key mofi:templates :test #'string= :key #'name) do
	 (if tmpl
	     (loop for sc in (remove-if-not #'(lambda (x) (xml-utils:xml-typep-3 x 'rdfs:|subClassOf|))
					    (xml-utils:xml-children class)) do
		  (setf *tmpl* tmpl)
		  (parse-tmpl 'rdfs:|subClassOf| sc :model model :tmpl tmpl))
	     (warn "No tmpl: ~A" key)))))

(def-parse-tmpl ('rdfs:|subClassOf|
		       (resource 'rdf:|resource|)
		       &key tmpl)
    (:self
     (if resource ; then it declaring metatype, not a property restriction...
       (let ((uri (puri:parse-uri resource)))
	 #+nil(unless (puri:uri-host uri) ; 2022 commented out what is dself here!
	   (setf uri (puri:parse-uri
		      (format nil "~A~A" ; not strcat
			      (pod:base-namespace (xml-utils:xml-document dself))
			      (puri:uri-fragment uri)))))
	 (let ((str (puri-string uri)))
	   (if (or
		(string= str (sym2rdf 'p7tm:|BaseTemplateStatement|))
		(string= str (sym2rdf 'p7tpl:|InitialSetTemplateStatement|))
		(string= str (sym2rdf 'p7tpl:|ProtoTemplateStatement|)))
	       (with-slots (template-metatype) tmpl
		 (setf template-metatype uri))
	       (warn 'tlogic-unknown-metatype :tmpl tmpl))))
       ;; ...it IS doing a property restriction...
       (when-bind (class (find-if #'(lambda (x) (xml-utils:xml-typep-3 x 'owl:|Class|))
				  (xml-utils:xml-children dself)))
	 (loop for insec in (remove-if-not #'(lambda (x) (xml-utils:xml-typep-3 x 'owl:|intersectionOf|))
					   (xml-utils:xml-children class))
	    do (parse-tmpl 'owl:|intersectionOf| insec :model model :tmpl tmpl))))))

(def-parse-tmpl ('owl:|intersectionOf| &key tmpl)
    (:self)
  ('owl:|Restriction| :tmpl tmpl))

(def-parse-tmpl ('owl:|Restriction| &key tmpl &aux role)
    (:self
     (when-bind (prop (xml-find-child 'owl:|onProperty| dself))
       (setf role (find (rdf-resource prop) (roles tmpl) :key #'name :test #'string=))
       (unless role (warn 'template-no-such-role :role-name (rdf-resource prop) :xml dself))))
  ('owl:|allValuesFrom| :role role :xml dself)
  ('owl:|qualifiedCardinality| :role role))

(def-parse-tmpl ('owl:|allValuesFrom| &key role xml)
    (:self
     (when role
       (when-bind (str (rdf-resource dself))
	 (with-slots (type) role
	   (let ((type-here (translate-type str xml)))
	     (unless (eql type-here type)
	       (unless (null type-here) ; this is warned earlier.
		 (warn 'template-type-mismatch
		       :from-owl (type-symbol type-here)
		       :from-role-spec (type-symbol type))))))))))

(def-parse-tmpl ('owl:|qualifiedCardinality| &key role)
    (:self
     (when role ; I'd use 'xsd:: here but James Anderson already defined the package.
       (let ((n? (read-from-string (car (xml-utils:xml-children dself)))))
	 (when (numberp n?)
	   (with-slots (cardinality) role
	     (setf cardinality n?)))))))

(def-parse-tmpl ('rdfs:|comment| &key tmpl)
    (:self
     (when-bind (c (car (xml-utils:xml-children dself)))
       (when (stringp c)
	 (with-slots (comment) tmpl
	   (setf comment (strcat comment c)))))))


; (setf *mmm* (xml-utils:xml-document-parser (lpath :tmp "transformed.xml")))
; (setf *mmm* (xml-utils:xml-document-parser (lpath :data "mmt-templates-owl-2013-04-15-1.xml")))
; (xml-utils:xml-document-parser "/home/pdenno/projects/cre/source/data/part8-tests/mmt-templates-owl-2013-02-11.xml")
; (xml-utils:xml-document-parser "/home/pdenno/projects/cre/source/data/part8-tests/heed-instance-formatted-ns.xml")
#-cre.exe
(defun tryme () ; not yet successful.
  (let ((model (make-instance 'mofi:user-template-population)))
    (let ((mofi:*model* model))
      (tlogic:read-owl :mmm *mmm* :model model)
      model)))

; (condition-file (lpath :data "mmt-templates-owl-2013-04-15-1.xml"))
#-cre.exe
(defun condition-file (file)
  "Diagnostic - translate nspaces, format, transform owl:thing"
  (translate-legacy-ns file (lpath :tmp "namespace-fixed.xml"))
  (usr-bin-xmllint :infile (lpath :tmp "namespace-fixed.xml") :outfile (lpath :tmp "ns-and-formatted.xml"))
  (let ((doc (xml-utils:xml-document-parser (lpath :tmp "ns-and-formatted.xml"))))
    (transform-owl-thing doc)
    (with-open-file (out (lpath :tmp "transformed.xml") :direction :output :if-exists :supersede)
      (xml-utils:xml-write-node doc out))))


#+nil
(defun fixheed ()
  (let ((doc (xml-utils:xml-document-parser (lpath :data "part8-tests/heed-rough.xml"))))
    (depth-first-search
     (xml-utils:xml-root doc)
     #'fail
     #'xml-utils:xml-children
     :do
     #'(lambda (x)
	 (when (dom:element-p x)
	   (setf (xml-utils:xml-children x)
		 (remove-if #'(lambda (y)
				(and (stringp y)
				     (cl-ppcre:scan "^\\s+$" y)))
			    (xml-utils:xml-children x))))))
    (xml-utils:xml-write-node doc (lpath :tmp "junk1.xml"))
    (usr-bin-xmllint :infile (lpath :tmp "junk1.xml") :outfile (lpath :tmp "junk2.xml"))))


;;;======================================================================
;;; Instance processing
;;;======================================================================

(defun process-instances (mut)
  "Instantiate instances (data model and template) from the document."
  (setf *tmpl* nil)
  (setf *inst* nil)
  (with-slots ((user-doc mofi:user-doc)) mut
    (when user-doc
      ;; Process DM content; instances are template role fillers.
      (loop for elem in (xml-utils:xml-children (xml-utils:xml-root user-doc))
	 for class = (dm-obj-p elem)
	 when class do (dm-parse-obj elem class mut))
      ;; Process template content
      (loop for elem in (xml-utils:xml-children (xml-utils:xml-root user-doc))
	 for tclass = (p7-tmpl-inst-p elem)
	 when tclass do (p7-parse-ti elem tclass mut))
      (pp-resolve-idrefs mut))))

;(declaim (inline dm-obj-ref-p non-local-ref-p))
(defun dm-obj-ref-p (slot)
  (typep (mofi:slot-definition-range slot) 'expo:express-entity-type-mo))

(defun non-local-ref-p (str)
  "Returns t (host name) when str is a uri."
  (and (stringp str)
       (puri:uri-host (puri:parse-uri (string-trim '(#\Space) str)))))

(defun pp-resolve-idrefs (mut)
  "For each instance in mut.instances, where the value of an object reference is a
   string, replace with the object. If no object exists with that ID, warn."
  (with-slots ((instances mofi:instances)) mut
    (loop for inst being the hash-value of instances
	  when (typep inst 'mofi:mm-root-supertype) do ; templates. (Entities are expo:entity-root-supertype.)
	 (let ((*inst* inst))
	   (loop for s in (mofi:mapped-slots (class-of inst))
		 for sname = (slot-definition-name s)
		 for ref = (slot-value inst sname)
		 when (dm-obj-ref-p s) do
		(cond ((non-local-ref-p ref)) ; NYI, but these can deref to P2 objects too.
		      ((typep ref 'expo:entity-root-supertype)) ; already processed. (Why?)
		      (t (if-bind (val (gethash ref instances))
				  (setf (slot-value inst sname) val)
				  (warn 'instance-local-deref-failure
					:ref ref :inst inst :tmpl (class-of inst) :role sname)))))))))

;;; ------------ Process Template Instance Content --------------
(declaim (inline add-frag))
(defun add-frag (id)
  "IDLIKETHIS -- #IDLIKETHIS"
  (if (char= #\# (char id 0)) id (strcat "#" id)))

(defun p7-parse-ti (elem class mut)
  "Create an template instance for the ELEM which is of TCLASS."
  (when-bind (id (xml-utils:xml-get-attr-value elem 'rdf:id))
    (let ((obj (make-instance class :obj-id id)))
      (setf *inst* obj)
      (setf (gethash (add-frag id) (mofi:instances mut)) obj)
      (loop for c in (xml-utils:xml-children elem)
	    do (p7-parse-attr c obj class))
      (setf *inst* nil))))

(defun class2tmpl-desc (class)
  "Return the template description from which the class CLASS was created."
  (find (class-name class)
	(mofi:templates (car (mofi:depends-on-models (mofi:of-model class))))
	:key #'tlog:name
	:test #'string=))

;;; Similar to dm-parse-attr, below
(defun p7-parse-attr (celem obj class)
  "Set values of attributes of OBJ as described by CELEM."
  (let ((name (dom:local-name celem)))
    (when (string= "p7tpl" (dom:prefix name))
      (let ((attr-name (dom:local-name name)))
	(cond ((cl-ppcre:scan "^has\\w+" attr-name) ; object ref
	       (if-bind (slot-name (p7-find-attr attr-name class))
			(if-bind (val (rdf-resource celem))
				 (setf (slot-value obj slot-name) val)
				 (break "Couldn't find object reference in ~A" celem))
			(warn 'instance-role-name-failure :tmpl (class2tmpl-desc class) :inst obj :role-name attr-name)))
	      ((cl-ppcre:scan "^ann\\w+" attr-name) ; annotation
	       (if-bind (slot-name (p7-find-attr attr-name class))
			(mvb (type val) (rdf-datatype celem)
			  (declare (ignore type)) ; for now
			  (if val
			      (setf (slot-value obj slot-name) val)
			      (break "Couldn't find annotation attribute ~A in ~A" attr-name class)))
			(unless (string= attr-name "annRecordCreated")
			(warn 'instance-role-name-failure :tmpl class :inst obj :role-name attr-name)))))))))


(defun p7-find-attr (attr-name class)
  "Return the slot-name (symbol) for the slot in CLASS, or nil if none."
  (when-bind (slot (find attr-name (class-slots class) :test #'string= :key #'slot-definition-name))
    (slot-definition-name slot)))

(defun p7-tmpl-inst-p (elem)
  "Returns the template class object if ELEM  represents a template."
  (setf *zippy* elem)
  (let ((name (dom:local-name elem)))
    (and (dom:element-p elem)
	 (string= "p7tpl" (dom:prefix elem)) ; 2022 ToDo: This assumes a lot!
	 ;; POD someday it won't be just mmt.
	 (if-bind (class (find-class (intern name :mmtc) nil))
		  class
		  (warn 'instance-unknown-type :type-name name :xml elem)))))

;;; POD compare with mofi:mm-find-instance !
;;; POD currently can't do expo:entity-root-supertype
(defun tlogic-find-instance (&key id (model (with-vo (mut) mut)))
  (cond (id
	 (loop for inst being the hash-value of (mofi:instances model)
	      when (and (typep inst 'mofi:mm-root-supertype)
			(= id (mofi:%debug-id inst)))
	    return inst))))


;;; ------------ Process DM Content --------------
(defun dm-parse-obj (elem class mut)
  "Instantiate CLASS using data from element. Register in mut.instances."
   (when-bind (id (xml-utils:xml-get-attr-value elem 'rdf:id))
    (let ((obj (make-instance class)))
      (setf (gethash (add-frag id) (mofi:instances mut)) obj)
      (loop for c in (xml-utils:xml-children elem)
	    do (dm-parse-attr c obj class)))))

(defun dm-parse-attr (celem obj class)
  "Parse a child element of an element describing a dm instance; if the
   elem represents an attribute, set the value of the attr in OBJ."
  (let ((name (dom:local-name celem)))
    (when (string= "p7tpl" (dom:prefix name))
      (let ((attr-name (dom:local-name name)))
	(cond ((cl-ppcre:scan "^has\\w+" attr-name) ; object ref
	       (if-bind (slot-name (dm-find-attr (subseq attr-name 3) class))
			(if-bind (val (rdf-resource celem))
				 (setf (slot-value obj slot-name) val)
				 (break "Couldn't find object reference in ~A" celem))
			(break "~A is not an attribute of class ~A" attr-name class)))
	      ((cl-ppcre:scan "^ann\\w+" attr-name) ; annotation
	       (if-bind (slot-name (dm-find-attr (subseq attr-name 3) class))
			(mvb (type val) (rdf-datatype celem)
			  (declare (ignore type)) ; for now
			  (if val
			      (setf (slot-value obj slot-name) val)
			      (break "Couldn't find annotation attribute ~A in ~A" attr-name class)))
			(break "~A is not an attribute of class ~A" attr-name class))))))))

(defun dm-find-attr (str iclass)
  "Return the slot-name of CLASS matching STR (transformed to express names) or nil if not a slot."
  (when-bind (slot (find (string-downcase (p7name2p2name str))
			 (mofi:mapped-slots iclass)
			 :test #'string=
			 :key #'(lambda (x) (string (slot-value x 'expo::simple-name)))))
    (slot-definition-name slot)))

(defun dm-obj-p (elem)
  "Returns the class (ieet-mo) represented if ELEM is a dom:element-p representing a Part2 object."
  (let ((p2 (mofi:find-model :part2))
	c)
    (setf *zippy* elem)
    (when (and (dom:element-p elem)
	       (string= "dm" (dom::prefix elem))
	       (setf c (find-iclass (p7name2p2name (dom:local-name elem))))
	       (eql p2 (mofi:of-model c)))
      c)))

;;; ------------
(defvar *zippy* nil)

;;; p7tpl:hasIdentificationType
;;; p7tpl:hasCardinalityOfPossessorType
;;; 2022 I'm really not sure what this is trying to do. It got stuck
;;;      on dom:local-name (a string, simple enough) but 
(defun rdl-endpoints (mut)
  "Return a list of the endpoints used."
  (let ((paths nil))
    (depth-first-search
     (xml-utils:xml-root (mofi:user-doc mut))
     #'fail
     #'xml-utils:xml-children
     :do #'(lambda (x)
	     (and (dom:element-p x)
		  (string-equal "p7tpl" (dom:local-name x))
		  (when-bind (re (rdf-resource x))
		    (when (or (cl-ppcre:scan "^http" re)
			      (cl-ppcre:scan  ".*\\.com/" re))
		      (let* ((uri (puri:parse-uri re))
			     (host (puri:uri-host uri))
			     (path (puri:uri-path uri))
			     (host+path (and host path (strcat host path))))
			(pushnew (or host+path host path) paths :test #'string=)))))))
    paths))

;;; 2022 Original (from a time I might have known what I was doing!) KEEP. 
#+nil(defun rdl-endpoints (mut)
  "Return a list of the endpoints used."
  (let ((p (find-package :p7tpl))
	(paths nil))
    (depth-first-search
     (xml-utils:xml-root (mofi:user-doc mut))
     #'fail
     #'xml-utils:xml-children
     :do #'(lambda (x)
	     (setf *zippy* x)
	     (and (dom:element-p x)
		  (eql p (symbol-package (dom:local-name x)))
		  (when-bind (re (rdf-resource x))
		    (when (or (cl-ppcre:scan "^http" re)
			      (cl-ppcre:scan  ".*\\.com/" re))
		      (let* ((uri (puri:parse-uri re))
			     (host (puri:uri-host uri))
			     (path (puri:uri-path uri))
			     (host+path (and host path (strcat host path))))
			(pushnew (or host+path host path) paths :test #'string=)))))))
    paths))

