
(in-package :turtle)

;;; ToDo: 
;;;   - This uses knowledge of line-numbers from parsed ttl. When the RDF is not from ttl (no 'defined-at')
;;;     there must be other provisions for formatting. 

(defvar *line-number* 1)
(defvar *written-ht* (make-hash-table) "Tracks whether it has been written")
(defvar *prefixes* nil  "an alist of known prefixes")
(defvar *stmts* nil "means to access statements without need for passing arguments.")
(defvar *in-subject* nil "lexically bound to current subject")
(defvar *zippy* nil "diagnostics")
(defvar *stmt-nesting* 0 "Counts how deeply nested statements are.")

(declaim (inline set-written written-p))
(defun set-written (obj)
  (setf (gethash obj *written-ht*) t))

(defun written-p (obj) (gethash obj *written-ht*))

(defun more-on-subject (subj)
  "Returns T if there are unwritten triples with subject SUBJ."
  (loop for trip in *stmts*
        when (and (typep trip 'odm:|Triple|)
		  (eql subj (odm:%r-d-fsubject trip))
		  (not (written-p trip)))
       collect trip))
       
(defun node-as-unwritten-object (node)
  "Return a statement which NODE (typically a blank node) is used as the subject
   of a triple, and that triple has not yet been written."
  (find-if #'(lambda (x) (and 
			  (typep x 'odm:|Triple|)
			  (eql (odm:%r-d-fobject x) node) 
			  (not (written-p x))))
	   *stmts*))

(defgeneric odm2ttl (obj stream &key &allow-other-keys))

(defmethod odm2ttl ((obj |TurtleDoc|) stream &key)
  (with-slots (|statements|) obj
    (clrhash *written-ht*)
    (setf *prefixes* '(("xsd" . "http://www.w3.org/2001/XMLSchema#")))
    (setf *stmts* |statements|)
    (loop for stmt in |statements| 
	 unless (written-p stmt) do
	 (odm2ttl stmt stream)
	   (format stream " x.x"))))

(defmethod odm2ttl ((obj |PrefixDecl|) stream &key)
  (with-slots (|prefix| IRI) obj
    (format stream "~%@prefix ~A <~A>" |prefix| IRI)
    (push (cons |prefix| IRI) *prefixes*)
    (set-written obj)))

(defun predicate-obj-list (subject)
  "Return Triples that have SUBJECT as their subject and have not yet been written."
  (loop for s in *stmts*
       when (and 
	     (typep s 'odm:|Triple|)
	     (eql subject (odm:%r-d-fsubject s))
	     (not (written-p s)))
       collect s))

;;; This is an attempt to print in abbeviated syntax!
(defmethod odm2ttl ((trip odm:|Triple|) stream &key pred-obj-only)
  (unless (written-p trip) 
    (with-slots (odm:|RDFsubject| odm:|RDFpredicate| odm:|RDFobject|) trip
      (let (obj-usage)
	(cond (pred-obj-only ; POD not good enough! Trip could be blank node (recurse).
	       (format nil "~A ~A" (odm2ttl odm:|RDFpredicate| nil) (odm2ttl odm:|RDFobject| nil)))
	      ;; If the subject is a BlankNode, and there is a statement that introduces
	      ;; that node as its object, write that statement first.
	      ((and (typep odm:|RDFsubject| 'odm:|BlankNode|)
		    (setf obj-usage (node-as-unwritten-object odm:|RDFsubject|))
		    (eql *in-subject* (odm:%r-d-fsubject obj-usage)))
	       (when-bind (pred-obj-list (predicate-obj-list odm:|RDFsubject|))
		 (set-written obj-usage)
		 (incf *stmt-nesting*)
		 (format stream "~%  ~A [~%~{   ~A~^ ;~%~} ~%  ]" ; for recursion might need to rewrite this with
			 (odm2ttl (odm:%r-d-fpredicate obj-usage) nil)  ; a real stream!
			 (loop for tr in pred-obj-list 
			    collect (odm2ttl tr nil :pred-obj-only t)))
		 (decf *stmt-nesting*)))
	      (t
	       (setf *in-subject* odm:|RDFsubject|)
	       (set-written trip)
	       (format stream "~2%~A ~A ~A " ; POD break it up, if necessary
		       (odm2ttl odm:|RDFsubject| nil)
		       (odm2ttl odm:|RDFpredicate| nil)
		       (odm2ttl odm:|RDFobject| nil)))))
      (loop for trp in (more-on-subject odm:|RDFsubject|)
  	   do (odm2ttl trp stream :pred-obj-only t)))))

(defmethod odm2ttl :around ((trip odm:|Triple|) stream &key)
  "Write final statement period without interfering with recursion."
  (let ((result (call-next-method)))
;    (VARS *stmt-nesting*)
;    (unless (more-on-subject-p (odm:%r-d-fsubject trip))
;      (when (zerop *stmt-nesting*) (format stream " .")))
    result))

(defmethod odm2ttl ((obj odm:iri) stream &key)
  (with-slots (odm:|iriString|) obj
    (if-bind (found
	      (loop for (p . iri) in *prefixes* do
		   (mvb (success end) (cl-ppcre:scan (format nil "^~A" iri) odm:|iriString|)
		     (when success 
		       (return (format nil "~A:~A" p (subseq odm:|iriString| end)))))))
	     (format stream "~A" found)
	     (format stream "<~A>" odm:|iriString|))))

(defmethod odm2ttl ((obj string) stream &key)
  (format stream "\"~A\"" obj))



    




