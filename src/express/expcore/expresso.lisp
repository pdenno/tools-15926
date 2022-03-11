
;;; Copyright (c) 2004 Peter Denno
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


;;;
;;; Peter Denno
;;; Date: 2/14/97
;;;
;;; The Expresso object and related methods.
;;;
(in-package :EXPRESSO)

;;; This is a thing used in post-process.lisp to adjust values in specific slots
;;; of MM instances of particular types. initialize-instance :after methods push the 
;;; instance onto the corresponding pp- vector. 
(defclass pp-record ()
  ((pp-scoped-ids :initform (make-array 100 :adjustable t :fill-pointer 0) :reader pp-scoped-ids)
   (pp-group-refs :initform (make-array 100 :adjustable t :fill-pointer 0) :reader pp-group-refs)
   (pp-enum-item-refs :initform (make-array 100 :adjustable t :fill-pointer 0) :reader pp-enum-item-refs)
   (pp-select-types :initform (make-array 100 :adjustable t :fill-pointer 0) :reader pp-select-types)
   (pp-binary-operations :initform (make-array 100 :adjustable t :fill-pointer 0) :reader pp-binary-operations)))

(defun clear-pp-record (obj)
  (with-slots (pp-scoped-ids pp-group-refs pp-enum-item-refs 
	       pp-select-types pp-binary-operations) obj
   (setf (fill-pointer pp-scoped-ids) 0)
   (setf (fill-pointer pp-group-refs) 0)
   (setf (fill-pointer pp-enum-item-refs) 0)
   (setf (fill-pointer pp-select-types) 0)
   (setf (fill-pointer pp-binary-operations) 0)
   (setf (fill-pointer pp-binary-operations) 0)
  obj))


;;; Class with all of the options to Expresso
(defclass expresso ()
  ((ignore-unique	:initform nil)
   (ignore-optional	:initform nil)
   (temp-directory)
   (system-directory)
   (install-directory)
   (pref-equality-slop-opt	:initform 0.0)
   (pref-p21-author-opt		:initform "Default author")
   (pref-p21-address-opt	:initform "Default address")
   (pref-p21-organization-opt	:initform "('Default organization')")
   (pref-p21-authorization-opt	:initform "Default not authorized")
   (p21-author			:initform "Default author")
   (p21-organization		:initform "('Default organization')")
   (p21-authorization		:initform "Default not authorized")
   (current-app                 :initform nil :accessor current-app)
   (equality-slop		:initform 0)
   (p21-file			:initform nil)
   (schema-file			:initform "" :accessor schema-file)
   (express-x-file		:initform "")
   (output-file			:initform "")
   (unique-rule-errors		:initform 0)
   (where-rule-errors		:initform 0)
   (global-rule-errors		:initform 0)
   (inverse-relationship-errors :initform 0)
   (unexpected-errors		:initform 0)
   (errors-at-creation		:initform 0)
   (attribute-type-errors	:initform 0)
   (where-used-ht)
   (p21-comments-ht)
   (debug-query			:initform nil :accessor debug-query)
   (query-indent		:initform 0)
   (suppress-new-namespace	:initform nil)
   (incremental-recompile	:initform nil)
   (express-x			:initform nil)
   (debug-express-x		:initform nil)
   (instance-dataset-ht         :initform (make-hash-table) :accessor instance-dataset-ht)
   (source-datasets		:initform nil :accessor source-datasets)
   (last-p21-loaded-dataset	:initform nil :accessor last-p21-loaded-dataset)
   (target-dataset		:initform nil :accessor target-dataset)
   (dataset  :reader dataset :initarg :dataset :initform nil) ; These might be overriden if 
   (schema   :reader schema  :initarg :schema  :initform nil) ; expresso is a ds-modal
   (x-schema                    :initform nil :accessor x-schema)
   (datasets			:initform nil :accessor datasets)
   (schemas			:initform nil :accessor schemas)
   (schema-aliases		:initform nil :accessor schema-aliases)
   (namespaces			:initform nil)
   (evaluations                 :initform nil)
   (validation-where-rules-opt			:initform  t)
   (validation-global-rules-opt			:initform  t)
   (validation-unique-opt			:initform  t)
   (validation-inverse-opt			:initform  t)
   (validation-type-in-attr-opt			:initform  t)
   (validation-complex-type-check-opt		:initform nil)
   (validation-allow-over-and-under-aggs-opt	:initform nil)
   (validation-report-first-occur-opt		:initform nil)
   (validation-report-?-unknown-opt		:initform nil)
   (rw-ignore-optional-opt	:initform t)
   (rw-write-p21-comments-opt	:initform t)
   (rw-write-p21-header-opt	:initform :t)
   (in-entity-decl		:initform nil)
   (pp-record :initform (make-instance 'pp-record) :accessor pp-record)))


;;; Initialize Expresso options
(defmethod initialize-instance :after ((obj Expresso) &key)
  (with-slots (system-directory temp-directory where-used-ht
	       p21-comments-ht install-directory) obj
    (setf install-directory     (pathname (install-dir)))
    (setf system-directory	(pathname "expo:root;"))
    (setf temp-directory	(pathname (strcat (install-dir) "tmp/")))
    (setf where-used-ht		(make-hash-table))
    (setf p21-comments-ht	(make-hash-table))))


;; Option methods
(defmethod option-get ((frame Expresso) slot)
  (slot-value frame slot))

(defmethod option-set ((frame Expresso) slot value)
  (setf (slot-value frame slot) value))

(defmethod option-incf ((frame Expresso) slot &optional (n 1))
  (incf (slot-value frame slot) n))

(defmethod option-decf ((frame Expresso) slot &optional (n 1))
  (decf (slot-value frame slot) n))

(defmethod (setf schema) (s (frame Expresso))
  (setf (slot-value frame 'schema) s))

(defmethod (setf dataset) (d (frame Expresso))
  (setf (slot-value frame 'dataset) d))

(defmethod abort? ((expresso expo:expresso) &key condition text)
  "In cgtk: this throws to the gtk event loop."
  (cond (condition (error condition))
	(text (error text))
	(t (error "in abort?"))))

(defmethod expo-dot ((expo expresso) &key char)
    (incf *dot-count*)
    (when (zerop (mod *dot-count* 10))
      (info-message char)))

(defmethod (setf pbar-fraction) (val (iface expresso)) nil)

;;;================================
;;; Mexico expresso
;;;================================
(defclass mexico-expresso (expresso)
  ((wid :initform nil :accessor wid)))

(defmethod copy-object ((obj expresso))
  "This is used for multi-threading, such as in the http-based validator."
  (let ((new (make-instance 'mexico-expresso)))
    (loop for slot in (closer-mop:class-slots (class-of obj))
	  for slot-name = (closer-mop:slot-definition-name slot)
	  do (setf (slot-value new slot-name)
		   (slot-value obj slot-name)))
    new))

;;; Will be redefined in iface/cgtk/main.lisp
(defclass cgtk-expresso (expresso)
  ())


;;; End of File



