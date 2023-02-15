;;;  Author: Peter Denno
;;;  Date: 2014-05-16
;;;  Purpose: Utilities for reading the various XML model files. Relies on cxml.

;;; Compatibility functions to replace Anderson's cl-xml with cxml (Closure XML)
;;; https://common-lisp.net/project/cxml
;;; Here are some things to work into my code (most of these have a -ns or -node version too):
;;;  dom:get-named-item
;;;  dom:set-named-item
;;;  dom:remove-named-item
;;;  dom:item
;;;  dom:has-attribute
;;;  dom:get-attribute-node
;;;  dom:set-attribute
;;;  dom:remove-attribute
;;;  dom:remove-named-item
;;;  dom:clone-node
;;;
;;;  Here are some things that get used often:
;;;    dom:node-name  - returns a string e.g. "rdf:RDF"
;;;    dom:local-name - returns a string e.g. "RDF"
;;;    dom:prefix     - returns a string e.g. "rdf"


;;; =================================== XMLP =================================
(in-package :xml-utils)

(defclass line-cnt-dom-builder (rune-dom::dom-builder)
  ())

(defclass line-cnt-attribute-node-map (rune-dom::attribute-node-map)
  ((line-num :initform nil)))

(defun xml-vanilla-document-parser (file)
  (cxml:parse-file file (cxml-dom:make-dom-builder)))

(defmethod xml-document-parser ((file t))
  (squeeze-xml
   (cxml:parse-file
    file
     (make-instance 'line-cnt-dom-builder)
    :validate nil)))

;;; See cxml dom/dom-builder.lisp (Is this okay? Lots of unexported symbols!)
(defmethod sax:start-element :around ((handler line-cnt-dom-builder) namespace-uri local-name qname attributes)
  (let* ((stack (call-next-method))
	 (elem  (pop stack))
	 (amap  (change-class (slot-value elem 'rune-dom::attributes) 'line-cnt-attribute-node-map)))
    (setf (slot-value amap 'line-num) (sax:line-number handler))
    (setf (slot-value elem 'rune-dom::attributes) amap)
    (push elem stack)
    stack))

(defun xml-line-num (elem)
  "Return the line number where the elem starts. This is possible if parsed with line-cnt-dom-builder."
  (when (dom:element-p elem)
    (when-bind (amap (dom:attributes elem))
	(when (and (slot-exists-p amap 'line-num)
		   (slot-boundp amap 'line-num))
	  (slot-value amap 'line-num)))))

;;; https://common-lisp.net/project/cxml/sax.html#serialization
(defmethod xml-write-node ((node t) (stream stream))
  (dom:map-document (cxml:make-character-stream-sink stream) node))

(defmethod xml-write-node ((node t) (path pathname))
  (with-open-file (stream path :direction :output :if-exists :supersede)
    (dom:map-document (cxml:make-character-stream-sink stream) node)))


;;; =================================== XQDM ==========================================
;;; ToDo: Look through cxml-20181018-git/dom/dom-impl.lisp much of this might be goofy.
;;; =================================== XQDM ==========================================
(defpackage |xmlns|)

(defvar *xml-clone2old* nil)

(defun xml-children (elem) (coerce (dom:child-nodes elem) 'list))

(defun (setf xml-children) (val node)
  (setf (slot-value node 'rune-dom::children)
	(coerce val 'vector)))

(defun clone-node (node) node) ; POD NYI

(defun (setf parent) (val node)
  (setf (slot-value node 'rune-dom::parent) val))

;;; Pretty much has to be this, though the dom doesn't seem to have this concept...
(defmethod xml-root ((elem dom:document))
  (first (xml-children elem)))

;;; ...though everything element has the document as owner.
(defmethod xml-root ((elem dom:element))
  (xml-root (slot-value elem 'rune-dom::owner)))

(defmethod (setf xml-root) (val (elem dom:document))
  (setf (xml-children elem) (list val)))

(defun xml-parent (elem)
  (dom:parent-node elem))

(defun xml-document (node)
  (slot-value node 'rune-dom::owner))

(defmethod xml-value ((attr rune-dom::attribute)) ; really this class!
  (xml-value (first (xml-children attr)))) ; a rune-dom::text

(defmethod xml-value ((text dom:text))
  (slot-value text 'rune-dom::value))

(defmethod (setf xml-value) ((val string) (attr rune-dom::attribute))
  (let* ((doc (xml-document attr))
	 (text (make-rune-text val attr doc)))
    (setf (xml-children attr) (list text))
    attr))

;;;The object is a STANDARD-OBJECT of type RUNE-DOM::TEXT.
;;;0. PARENT: #<RUNE-DOM::ATTRIBUTE xmlns:uml="http://www.omg.org/spec/UML/20090901" {1002716753}>
;;;1. CHILDREN: #()
;;;2. OWNER: #<RUNE-DOM::DOCUMENT {10025AEFF3}>
;;;3. READ-ONLY-P: NIL
;;;4. MAP: NIL
;;;5. VALUE: "http://www.omg.org/spec/UML/20090901"
(defun make-rune-text (val attr doc)
  (let ((obj (make-instance 'rune-dom::text :children #() :owner doc)))
    (setf (slot-value obj 'rune-dom::value) val)
    (setf (slot-value obj 'rune-dom::parent) attr)
    obj))

(defun xml-attributes (elem)
  (when-bind (attrs (dom:attributes elem))
      (dom:items attrs)))


(defun (setf xml-attributes) (val elem)
  (let ((nmap (make-instance 'line-cnt-attribute-node-map
			     :items val
			     :owner (dom:owner-document elem)
			     :element-type :attribute
			     :element elem)))
    (setf (slot-value elem 'rune-dom::attributes) nmap)))

(defun squeeze-xml (elem)
  "Recursively remove empty string content when element has both string and element content children."
  (let ((scanner (cl-ppcre:create-scanner "^\\s+$" :multi-line-mode t)))
    (pod-utils:depth-first-search
     elem
     #'(lambda (x) (declare (ignore x)) nil) ; fail
     #'xml-children
     :do #'(lambda (x) ; This part is OK to use sequences
	     (let ((cs (dom:child-nodes x)))
	       (when (and (some #'dom:text-node-p cs)
			  (some #'dom:element-p cs))
		 (setf (xml-children x)
		       (delete-if #'(lambda (y) ; turns it into an svec?
				      (and (dom:text-node-p y)
					   (cl-ppcre:scan scanner (dom:data y))))
				  cs)))))))
  elem)

;;;The object is a STANDARD-OBJECT of type RUNE-DOM::ATTRIBUTE.
;;;0. PARENT: NIL
;;;1. CHILDREN: #(#<RUNE-DOM::TEXT {1002975333}>)
;;;2. OWNER: #<RUNE-DOM::DOCUMENT {10025AEFF3}>
;;;3. READ-ONLY-P: NIL
;;;4. MAP: #<XML-UTILS::LINE-CNT-ATTRIBUTE-NODE-MAP {1002816A63}>
;;;5. PREFIX: "xmlns"
;;;6. LOCAL-NAME: "uml"
;;;7. NAMESPACE-URI: "http://www.w3.org/2000/xmlns/"
;;;8. NAME: "xmlns:uml"
;;;9. OWNER-ELEMENT: #<RUNE-DOM::ELEMENT uml:Model {10025AEF73}>
;;;10. SPECIFIED-P: T


;;; The next three were once in canon-xmi-gen.lisp
(defun xml-add-attr (owner prefix name value)
  "Add an attribute named PREFIX:NAME with value VALUE to OWNER, a rune-dom:element. Return the elem."
  (let* ((doc     (xml-document owner))
	 (ns      (dom:namespace-uri owner))
	 ;; nmap (which is in every attribute, yet lists all attributs) is automatically updated
	 ;; see cxml/dom-impl.lisp dom:create-attribute
	 (attr    (make-instance 'rune-dom::attribute
				 :name (strcat prefix ":" name)
				 :local-name name
				 :prefix prefix
				 :namespace-uri nil
				 :owner-element owner
				 :owner doc)))
    (setf (xml-value attr) value)
    (setf (slot-value attr 'rune-dom::namespace-uri) ns)
    (setf (slot-value attr 'rune-dom::specified-p) t)
    (setf (slot-value attr 'rune-dom::map) (dom:attributes owner))
    (setf (xml-attributes owner) (append (xml-attributes owner) (list attr)))
    owner))

;;; New for 2022
(defun xml-make-string-attr-node (prefix local-name value owner)
  "Replaces xqdm-ignore:make-string-attr-node"
  (let ((attr (make-instance 'rune-dom::attribute
			     :name (strcat prefix ":" local-name)
			     :local-name local-name
			     :prefix prefix
			     :namespace-uri nil
			     :owner-element owner
			     :owner (xml-document owner))))
    (setf (xml-value attr) value)))

;;; This is re-factored out of xml-create-elem, which was in canon-xmi-gen.lisp.
(defun xml-add-elem (owner elem)
  (setf (slot-value owner 'rune-dom::children)
	(coerce (append (coerce (slot-value owner 'rune-dom::children) 'list)
			(list elem))
		'vector))
  owner)

;;; Was in canon-xmi-gen.lisp (was xml-add-elem)
;;; See cxml/dom-impl.lisp dom:create-element
(defun xml-create-elem (doc prefix name)
  "Add an element named PREFIX:NAME to OWNER."
  (let ((result (make-instance 'rune-dom::element
			       :tag-name (strcat prefix ":" name)
			       :prefix prefix    ; dom:c-e has it nil
			       :local-name name  ; dom:c-e has it nil (???)
			       :owner doc
			       :namespace-uri (dom:namespace-uri doc))))
    (setf (slot-value result 'rune-dom::attributes)
	  (make-instance 'line-cnt-attribute-node-map ; maybe doesn't matter
			 :element-type :attribute
			 :owner doc
			 :element result))
    ;(rune-dom::add-default-attributes result) ; Need a DTD for this.
    result))

;;; For 2022
(defun xml-create-elem2 (doc name)
  (let ((local-name (foo name))
	(prefix (bar name)))
    (xml-create-elem doc prefix local-name)))

;;; Was in canon-xmi-gen.lisp
#+nil(defun xml-set-content (elem value)
  "Set text/number content of PARENT to VALUE."
  (when value
    (unless (or (stringp value) (numberp value)) (error "set-content args"))
    (setf (xml-children elem) (list (if (stringp value) value (format nil "~A" value))))
    elem))

(defmethod xml-find-child ((type symbol) (children list) &key (error-p nil))
  "Return first dom:element from list CHILDREN whose tag is TYPE, a symbol."
  (if-bind (child (find-if #'(lambda (x) (xml-typep-3 x type)) children)) ; 2013-03-06 I make thes typep-3 OK?
	   child
	   (when error-p (error "No child element ~A" type))))

(defmethod xml-find-child ((type string) (children list) &key (error-p nil))
  "Return first dom:element from list CHILDREN whose tag dom:local-name is TYPE, a string."
  (if-bind (child (find type children :key #'(lambda (x) (dom:local-name x)) :test #'string-equal))
	   child
	   (when error-p (error "No child element ~A" type))))

(defmethod xml-find-child (type (elem dom:element) &key (error-p nil))
  "Return first child of element TYPE whose tag is TYPE."
  (xml-find-child type (xml-children elem) :error-p error-p))

(defmethod xml-find-child (type  (elem dom:document) &key (error-p nil))
  "Return first child of the document node's root whose tag is TYPE."
  (xml-find-child type (xml-root elem) :error-p error-p))

(defmethod xml-find-children ((type string) (elem dom:element))
  "Return a list of children of type TYPE. Second elem is a element."
  (xml-find-children type (xml-children elem)))

(defmethod xml-find-children ((type string) (children list))
  "Return a list of children of type TYPE a string matching the local-name of the tag.
   Second elem is a list of elements."
  (loop for child in children
	when (string-equal (dom:local-name child) type)
	collect child))

(defmethod xml-find-children ((type symbol) (children list))
  "Return a list of children of type TYPE type. Second elem is a list of elements."
  (loop for child in children
	when (xml-typep child type) collect child))

(defmethod xml-find-children ((type symbol) (elem dom:element))
  "Return a list of children of type TYPE type. Second elem is a list of elements."
  (loop for child in (xml-children elem)
	when (xml-typep child type) collect child))

(defun xml-find-cdata-child (elem)
  (when elem
    (when-bind (str (loop for child in (xml-children elem)
		       when (stringp child) return child))
      (loop for pos from 0 to (1- (length str))
	 when (alphanumericp (char str pos)) return str))))

;;; Deprecated!
(declaim (inline xml-find-string-child))
(defun xml-find-string-child (elem)
  (xml-find-cdata-child elem))

(defun fail (ignore)
  (declare (ignore ignore))
  nil)

(defun xml-siblings (node)
  (xml-children (xml-parent node)))

;;; ToDo: This can be really slow!
(defun xml-namespaces (elem)
  "Return an alist of the namespace-URIs of the namespaces found in elem and its descendants."
  (let ((attrs '()))
    (breadth-first-search
     elem
     #'fail
     #'(lambda (x) (xml-children x))
     :do #'(lambda (x)
	     (when-bind (more (xml-find-attrs x #'(lambda (y) (string= (dom:prefix y) "xmlns"))))
		 (setf attrs (append attrs more)))))
    (mapcar #'(lambda (x) (cons (dom:local-name x) (dom:value x))) attrs)))

(defun xml-prefix2uri (prefix namespaces)
  "Return the URI string associated with PREFIX. NAMESPACES is an alist such as produced by xml-namespaces."
  (when-bind (found (find prefix namespaces :key #'car :test #'equal))
      (cdr found)))

(defun xml-get-attr (elem attr-name-string &key prefix)
  "Get the attribute named ATTR-NAME, a string. If :prefix (a string) is supplied, test it
   against the attr's prefix. (Thus it doesn't get confused by versioned XMI packages.)"
  (flet ((easy-test (attr)      (equal attr-name-string (dom:local-name attr)))
	 (hard-test (attr) (and (equal attr-name-string (dom:local-name attr))
				(equal prefix           (dom:prefix attr)))))
    (let ((test (if prefix #'hard-test #'easy-test)))
       (find-if test (xml-attributes elem)))))

#+nil(declaim (inline xml-get-attr-value))
;;; 2022 The following gets an error  on get-named-item when there is no attribute "name"
#+nil(defun xml-get-attr-value (elem name)
  "Return the value of the attribute of elem identified by local-name.
   Return nil if no attribute found."
  (when-bind (attr (dom:get-named-item (dom:attributes elem) name))
    (dom:value attr)))

(defmethod xml-get-attr-value (elem (name string))
  "Return the value of the attribute of elem identified by local-name.
   Return nil if no attribute found."
  (let ((attrs (dom:attributes elem)))
    (when-bind (attr (find-if #'(lambda (x) (string= name (dom:name x)))
			      (dom:items attrs)))
      (dom:value attr))))

(defmethod xml-get-attr-value (elem (name symbol))
  "Return the value of the attribute of elem identified by local-name.
   Return nil if no attribute found."
  (let ((attrs (dom:attributes elem))
	(sname (symbol-name name))
	(spkg  (symbol-package name)))
    (when-bind (attr (find-if #'(lambda (x) (and (string= sname (dom:local-name x))
						 (find-package spkg))) ; ToDo: not quite!
			      (dom:items attrs)))
      (dom:value attr))))

(defun xml-find-attrs (elem test)
  "Return a list of attributes of ELEM that pass TEST."
  (loop for attr in (xml-attributes elem)
       when (funcall test attr)
     collect attr))

(defun xml-get-logical (name elem &key (error-p t))
  "Get the value of attribute or CHILD string content content named NAME from ELEM."
  (let ((result
	 (or (xml-get-attr elem name)
	     (when-bind (c (xml-find-child name elem))
	       (let ((val (car (xml-children c))))
		 (when (stringp val) val))))))
    (or result (when error-p (error "Elem does not contain child/attr '~A'." name)))))

;;; POD This and the next probably ought to use dom:node-name and ns-qualified string.
(defmethod xml-typep (elem (type string))
  "Like typep, except TYPE is a string tested against ELEM.local-name."
  (and (dom:element-p elem)
       (string-equal type (dom:local-name elem))))

(defmethod xml-typep (elem (type symbol))
  "Like typep, except TYPE is a string tested against ELEM.local-name."
  (and (dom:element-p elem)
       (string-equal type (dom:local-name elem))))

(proclaim '(inline xml-typep-2))
(defun xml-typep-2 (elem ns type)
  (and (string-equal type (dom:local-name elem))
       (string-equal ns (dom:prefix elem))))

(defun xml-typep-3 (elem type)
  (and (dom:element-p elem)
       (when-bind (pkg (find-package (dom:prefix elem)))
	 (let ((sym (intern (dom:local-name elem) pkg)))
	   (eql sym type)))))

;;; Inspired by Vasilis M.'s cells-gtk/widgets.lisp (in the sense that it has 'subtypes').
(defmacro def-parse (method-name pass-downward (type &rest binds) &body body)
  (let* ((aux (cdr (member '&aux binds))) ; can't use dbind, not same idea.
	 (keys (cdr (member '&key binds)))
	 (keys (subseq keys 0 (position '&aux keys)))
	 (attrs (subseq binds 0 (position '&key binds))) action)
    (with-gensyms (chilun c sint?)
      `(defmethod ,method-name ((elem-type (eql ,type)) dself &key ,pass-downward ,@keys)
	 (declare (ignorable dself ,pass-downward))
	 (let* ((,sint? nil)
		(,chilun (xml-children dself))
		,@(loop #:for attr #:in attrs #:collect
			`(,(intern (string-upcase (c-name2lisp attr)))
			  (or (string-integer-p (setq ,sint? (xml-get-attr dself ,attr)))
			      (and ,sint? (intern ,sint?)))))
		,@aux)
	   (declare (ignorable ,chilun ,sint?))
	   ,@(loop for bod in body collect
		  (dbind (term &rest action/args) bod
		    (setf action '#:do)
		    (cond ((eql :self term)
			    `(progn ,@action/args))
			  (t
			    (unless (stringp term) ; then adjust the args...
			      (case term
				(:collect (setq action 'collect))
				(:append  (setq action 'append))
				(t (error "Unknown def-parse action: ~A" term)))
			      (setf term (first action/args) action/args (second action/args)))
			    `(loop #:for ,c #:in ,chilun
				   #:when (xml-typep ,c ,term) ,action
				  (,method-name ,(kintern (c-name2lisp term)) ,c
						,(kintern pass-downward) ,pass-downward ,@action/args)))))))))))

(defmacro with-xml-attrs (attrs elem &body body)
  (with-gensyms (e)
  `(let* ((,e ,elem)
	  ,@(mapcar #'(lambda (x) (list (intern (string-upcase (c-name2lisp x)))
					`(xml-get-attr ,e ,x)))
		    attrs))
     ,@body)))

(defmemo spaces (n)
  (if (<= n 0) ""
    (format nil "~%~A" (loop for i from 1 to n with result = ""
			     do (setf result (strcat result "  "))
			     finally (return result)))))

(defun xml-follow-back (node path-back &optional accum)
  "Follow the xml-parent link from node back through the types (strings)
   of the list PATH-BACK. Return the object at the end of the list or nil
   if at some navigation the correct elem isn't found."
  (cond ((null path-back) (nreverse accum))
	(t (let ((parent (xml-parent node)))
	     (when (xml-typep parent (car path-back))
	       (xml-follow-back parent (cdr path-back) (push parent accum)))))))

;;; This doesn't balance the etag (they trail like in well-written lisp ;^)
;;; This is useless??? Use *print-pretty* with cl-xml or usr-bin-xmllint, below
(defun xml-indent (elem)
  (depth-first-search
   elem #'fail #'xml-children :tracking t
   :do
   #'(lambda (node)
       (when (dom:element-p node)
	 (let* ((depth (length (tree-search-path)))
		(spaces (spaces depth)))
	   (setf (xml-children node)
		 (loop for c in (xml-children node)
		       when (dom:element-p c) collect spaces
		       collect c)))))))

(defun xml-collect-elem (predicate xml)
  "Navigate the XML structure, XML collecting elements that match
   PREDICATE, a function of one argument."
  (let (accum)
    (labels ((collect-aux (x)
	       (when (dom:element-p x)
		 (when (funcall predicate x) (push x accum))
		 (loop for e in (xml-children x) do (collect-aux e)))))
      (collect-aux (if (typep xml 'dom:document) (xml-root xml) xml))
      accum)))

#+(and Linux (or Lispworks sbcl))
(defun usr-bin-xmllint(&key infile instring outfile)
  "Read INFILE a file of xml, and output OUTFILE, if specified, xml formatted by /usr/bin/xmllint.
   If INSTRING is specified, write output to a tmp file before running /usr/bin/xmllint (Useful for debugging).
   If OUTFILE is not specified, write to *standard-output*"
  (when instring
    (with-open-file (s (lpath :tmp "xmllint-tmp.xml") :direction :output :if-exists :supersede)
      (write-string instring s))
    (setf infile (lpath :tmp "xmllint-tmp.xml")))
  (let* ((cmd (format nil "/usr/bin/xmllint --format ~A" (namestring (truename infile))))
	 (lint-stream  #+Lispworks(sys:open-pipe cmd :direction :input)
		       #+sbcl (make-string-input-stream (inferior-shell:run/s cmd)))
	 (outstream (if outfile (open outfile :direction :output :if-exists :supersede) *standard-output*)))
    (loop for line = (read-line lint-stream nil nil)
       while line do (write-line line outstream))
    (when outfile (close outstream))))

#+(and Linux (or Lispworks sbcl))
(defun usr-bin-diff (&key file1 file2 outfile (args " "))
  "Create a diff file with html escaping."
  (let* ((cmd (format nil "/usr/bin/diff ~A ~A ~A"
		      args
		      (namestring (truename file1))
		      (namestring (truename file2))))
	 (diff-stream  #+Lispworks(sys:open-pipe cmd :direction :input)
		       #+sbcl(make-string-input-stream (inferior-shell:run/s cmd))))
    (with-open-file (outstream outfile :direction :output :if-exists :supersede)
      (loop for line = (read-line diff-stream nil nil)
	 while line do (write-line line outstream)))))

#+nil(defun xml-set-parents (elem)
  "The xml-parent is not always set (In Anderson XML)!"
  (cond ((null elem) nil)
	((stringp elem) nil)
	((typep elem 'dom:node)
	 (loop for c in (xml-children elem) do
	    (when (dom:element-p c)
	      (when (null (xml-parent c)) (setf (xml-parent c) elem))
	      (xml-set-parents c)))))
  elem)

(defun xml-remove-xmi-extensions (doc)
  "Return the document with xmi:extension elements removed."
  (let ((esym (intern "Extension" (find-package :xmi))))
    (depth-first-search (xml-root doc)
			#'fail
			#'xml-children
			:do #'(lambda (n)
				(when (dom:element-p n)
				  (setf (xml-children n)
					(remove-if #'(lambda (x) (xml-typep x esym))
						   (xml-children n))))))))



(defun base-namespace (doc)
  "Return the base namespace (string) of a xml:document DOC."
  (declare (ignore doc))
  (error "NYI"))
#|  (let (base-ns)
    (breadth-first-search
     (xml-root doc)
     #'(lambda (x)
	 (and (dom:element-p x)
	      (setf base-ns (find '|xmlns|:|| (xml:namespaces x) :key #'dom:node-name))))
     #'xml-children)
    (when base-ns (xml-value base-ns))))
|#
