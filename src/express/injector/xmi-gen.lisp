;;; Copyright (c) 2006 Peter Denno
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

;;;=============================================================
;;; Object Registry
;;;=============================================================
(defvar *obj2xmi-id* (make-hash-table))
(defvar *xmi-id2obj* (make-hash-table))
(defvar *obj-mapped-p* (make-hash-table))
(defvar *next-obj-id* 1)
;(defvar *ns* nil "the EXP namespace, http://www.nist.gov/msid/mexico")

(defun xmi-clear-registry ()
  (clrhash *obj2xmi-id*)
  (clrhash *xmi-id2obj*)
  (clrhash *obj-mapped-p*)
  (setf *next-obj-id* 0))

(defun xmi-register-obj (obj)
  (unless (gethash obj *obj2xmi-id*)
    (incf *next-obj-id*)
    (setf (gethash obj *obj2xmi-id*) *next-obj-id*)
    (setf (gethash *next-obj-id* *xmi-id2obj*) obj)))

(defun xmi21-register-obj (obj)
  "Registers only named objects."
  (when-bind (id (xmi21-name obj))
     (setf (gethash obj *obj2xmi-id*) id) ; pod or use xmi-name ?
     (setf (gethash id  *xmi-id2obj*) obj)))

(defun xmi-id2obj (id)
  (gethash id *xmi-id2obj*))

(defun obj2xmi-id (obj)
  (gethash obj *obj2xmi-id*))

(defun xmi-mapped-p (obj)
  (gethash obj *obj-mapped-p*))

(defun (setf xmi-mapped-p) (val obj)
  (setf (gethash obj *obj-mapped-p*) val))

;;; This is so that in lw delivery can specify :keep-package-manipulation nil
(eval-when (:compile-toplevel :load-toplevel :execute)
  (flet ((make-package* (p) (unless (find-package p) (make-package p))))
    (make-package* "http://www.omg.org/MEXICO/Errors")
    (make-package* "http://www.omg.org/spec/EXPRESS/1.0") ; 2012 was http://www.omg.org/MEXICO/EXPRESS_v2
    (make-package* "http://www.omg.org/XMI")))

(defmemo uml-package2namespace (name)
  (if (eql name '|Errors|)
      (xqdm:find-namespace "http://www.omg.org/MEXICO/Errors")
    (xqdm:find-namespace "http://www.omg.org/spec/EXPRESS/1.0")))
#| The old way (see xmi-template-old.xml)
  (ecase name
    (|Core| (xqdm:find-namespace "http://www.omg.org/MEXICO/Core"))
    (|Expressions| (xqdm:find-namespace "http://www.omg.org/MEXICO/Expressions"))
    (|Rules| (xqdm:find-namespace "http://www.omg.org/MEXICO/Rules"))
    (|Algorithms| (xqdm:find-namespace "http://www.omg.org/MEXICO/Algorithms"))
    (|Instances| (xqdm:find-namespace "http://www.omg.org/MEXICO/Instances"))
    (|Errors| (xqdm:find-namespace "http://www.omg.org/MEXICO/Errors"))))
|#

;;;===================
;;; XMI 2.1
;;;===================
(defmethod map-xmi ((version (eql :two-one)) &key (pathname (lpath :tmp "mexico/xmi-pre-reflow.xmi")) indent-p)
  (xmi-clear-registry)
  (let* ((doc (xmlp::parse-document (lpath :cre "express/injector/xmi-template.xmi")))
	 (root (xqdm:root doc))
	 (content root)
	 (schema-obj (p11p::schema-scope *scope*)) ; pod7 added *scope* argument
	 schema)
    ;(setf *ns* (xqdm:find-namespace "http://www.omg.org/MEXICO"))
    (map-prologue doc root)
    ;; Map the single top-level object -- XMI uses that term 'top-level' but doesn't define it. 
    (setf (xqdm:children content) ;; Schema is the ONLY "top-level object" 
	  (list (setf schema (map-element :two-one root doc (xmi-class-name schema-obj) schema-obj 
					  #| 2012 :recurse nil|#))))
    ;; But in rule 2a it partitions things into "top-level objects" and 
    ;; "objects that are the value of an attribute or reference"
    ;; The example use of 2a is ownedMember of Package in MOF...can't find it.
    ;; Perhaps 'top-level' doesn't means anything you can't reach through navigation. 
    (setf (xqdm:children schema) ; here "top-level" refers to my mexico notion.
	  (loop for obj in (%schema-elements (p11p::schema-scope *scope*)) 
		collect (string #\Newline)
		collect (xml-make-node doc root nil (format nil "~A" (xmi-name obj)) :type 'xqdm:comment-node)
		collect (map-element :two-one root doc "defined-in" obj)))
    ;(when indent-p (big-stack (:name "Indenting") (xml-indent root)))
    (with-open-file (s pathname :direction :output :if-exists :supersede)
      (let ((*print-pretty* indent-p))
	(xml-parser:write-node doc s)))
      (usr-bin-xmllint :infile  pathname
		       :outfile (pod:lpath :tmp "mexico/mexico-xmi.xmi"))))


;;; Everything mapped with this is "the value of an attribute or reference." 
;;; Hence the tag is named by the name of the attribute or reference (rule 2a).
(defmethod map-element ((version (eql :two-one)) root doc tag-name obj &key)
  (VARS obj) (setf *zippy* obj) (break "here")
  (when (xmi-string-p obj) (return-from map-element (format nil "~A" obj))) ; content is a string
  (xmi21-register-obj obj)
  (setf (xmi-mapped-p obj) t)
  (let ((node (xml-make-node doc root tag-name nil :type 'xqdm:elem-node)))
    (setf (xqdm:attributes node) 
	  (append
	   (list (xml-make-node doc root "xmi:type" (xmi-class-name obj))
		 (xml-make-node doc root "xmi:id" (obj2xmi-id obj)))
	   (loop for slot in (reverse (closer-mop:class-slots (class-of obj))) 
		 for slot-val = (slot-value obj (closer-mop:slot-definition-name slot)) 
		 when (and slot-val 
			   (progn (VARS slot) (break "slot") t)
			   (not (mofi:slot-definition-xmi-hidden slot))
			   (not (xmi21-requires-elem-p slot-val)))
		 append
		 (loop for c in (mklist slot-val) when c
;		       do (VARS c)
		       collect (xml-make-node doc root (slot2attr-name slot) (xmi21-name c))))))
    (setf (xqdm:children node)
	   (loop for slot in (reverse (closer-mop:class-slots (class-of obj)))
		 for slot-val = (slot-value obj (closer-mop:slot-definition-name slot))
		 when (and slot-val
			   (not (mofi:slot-definition-xmi-hidden slot))
			   (xmi21-requires-elem-p slot-val))
		 append
		 (loop for c in (mklist slot-val) when c
		       collect (map-element :two-one root doc (slot2elem-name slot) c))))
    node))

(defun xmi21-requires-elem-p (obj)
  (not 
   (or (xmi-string-p obj)
       (xmi-mapped-p obj))))
;       (member obj (%schema-elements (p11p::schema-scope *scope*))))))


(defun map-prologue (doc root)
  (flet ((mk-comment (text)
	    (xml-make-node doc root nil text :type 'xqdm:comment-node))
	 (mk-newline (&optional (n 1))
            (loop for i from 1 to n collect (string #\Newline))))
    (setf (xqdm:children root)
	  (append
	   (flatten
	    (list 
	     (mk-newline) (mk-comment (format nil " Created on ~A" (now)))
	     (mk-newline) (mk-comment (format nil" ~A" (expo:ee-version)))
	     (mk-newline 2)))
	   (xqdm:children root)))))

;;;========================================================
;;; Utilities ...
;;;========================================================

(defun xmi-toplevel ()
  (%schema-elements (p11p::schema-scope *scope*)))

(defmethod xmi-class-name ((obj mofi:mm-root-supertype))
  (let ((c (class-of obj)))
    (intern (string (class-name c)) (uml-package2namespace (mofi:model-package c)))))

(defmethod xmi-class-name ((obj number)) obj)
(defmethod xmi-class-name ((obj string)) obj)
(defmethod xmi-class-name ((obj symbol)) 
  (if (keywordp obj) obj :error))
(defmethod xmi-class-name ((obj t)) (break "Obj = ~A" obj))

(defun uml-qualified-name (symbol)
  (intern symbol (uml-package2namespace (mofi:model-package (find-class (intern symbol))))))

(defun xmi-string-p (obj)
  (or (typep obj 'string)
      (typep obj 'number)
      (typep obj 'keyword)))

(defun slot2elem-name (slot &key name-only)
  "Evaluates to the name of a slot, or source.name."
  (let* ((source (mofi:slot-definition-source slot))
	 (package (uml-package2namespace (mofi:model-package source))))
    (intern
     (if name-only
	 (format nil "~A" (mofi:slot-definition-source slot))
       (format nil "~A.~A" 
	       (class-name (mofi:slot-definition-source slot))
	       (closer-mop:slot-definition-name slot)))
     package)))


(defmethod xmi-name ((obj |Schema|))
  (%name obj))

;;; POD will have to check for uniqueness...
(defmethod xmi-name ((obj |NamedElement|))
  (when-bind (id (%id obj))
   (%local-name id)))

(defmethod xmi-name ((obj T))
  nil)

;;;================================
;;; xmi21-name - a much bigger deal
(defmethod xmi21-name ((obj |Schema|))
  (%name obj))

;;; POD will have to check for uniqueness...
(defmethod xmi21-name ((obj |NamedElement|))
  (when-bind (id (%id obj))
   (%local-name id)))

(defmethod xmi21-name ((obj |Attribute|))
  (setf *zippy* obj)
  ;2012 (format nil "ATTR-~A.~A" (xmi-name (%derived-from (%of-entity obj))) (xmi-name obj))
  (format nil "ATTR-~A.~A" (xmi-name (%of-entity obj)) (xmi-name obj))) ; 2012 added

(defmethod xmi21-name ((obj |ScopedId|))
  "NYI")

(defmethod xmi21-name ((obj |SingleEntityType|))
  "NYI")

(defmethod xmi21-name ((obj |DataType|))
  "NYI")

(defmethod xmi21-name ((obj |Scope|))
  "NYI")

(defmethod xmi21-name ((obj |Expression|))
  "NYI")

(defmethod xmi21-name ((obj T))
  "NYI-default=~A" (format nil "~A" obj))

;;; POD this could be done more elegantly with handler-bind around warning. 
(defun mm-warn (message &rest args)
  (let ((msg (apply #'format  nil message args)))
    (unless (member msg *mm-warnings* :test #'equal) (push msg *mm-warnings*))
    (etypecase *expresso*
      (expo:mexico-expresso
       (format *error-output* "~A" (format nil "~%<br/><strong>Warning:</strong> ~A" msg)))
      #+iface-cgtk
      (gui:cgtk-expresso
       (format *message-stream* "~A" (format nil "~%Warning: ~A" msg)))
      (expo:expresso (warn msg))))
  (values))


;;; pod 7 I inserted this from metaobjects.lisp

;;;===========================================================================================
;;; Setf :after methods that will be pprinted to emm.lisp -- any place where a ref can appear,
;;; these are defined on slots of the the emm.lisp metaobjects, and push the values in instances
;;; of those slots into *unresolved-attribute-refs*. 
;;;===========================================================================================
(defun mm-subtypes-of (in-class-name &key self)
  (append (when self (list in-class-name))
      (remove-duplicates
       (loop for class across (mofi:types (mofi:find-model :mexico))
	     with the-superclass = (find-class in-class-name)
	     when (and (member the-superclass (closer-mop:class-precedence-list class))
		       (not (eql in-class-name (class-name class))))
	     collect (class-name class)))))


(defun make-setf-after-method (class slot)
  `(defmethod (setf ,(intern (strcat "%" (string-upcase (symbol-name slot)))
			     (find-package :mexico)))
     :after (val (obj ,class))
     (when (typep val 'unresolved-attr-ref)
       (vector-push-extend (cons obj ',slot) *unresolved-attribute-refs*))))

(defun pprint-setf-after-methods (stream)
  (loop for (class . slot) in (identify-slots-for-attr-setf-tracking) do
	(pprint (make-setf-after-method class slot) stream)
	(terpri stream)))
