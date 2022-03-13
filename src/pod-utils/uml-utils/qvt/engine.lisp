(in-package :qvt)

;;; Purpose: Component necessary to run translated QVT transformations.


;;; 2013-04-18: "A Set of QVT Relations to Assure the Correctness of Data Warehouses"
;;; (Mazon, Trujilo, Lechtenborger) considers The WHEN clause a precondition and the
;;; WHERE clause a post condition.

;;; 2022 Added eval-when. No help!
#+nil(eval-when (:compile-toplevel :load-toplevel :execute)
  (when (boundp '+qvt-unbound+)
    (unintern '+qvt-unbound+)))
;;; 2022 (defconstant +qvt-unbound+ (make-qvt-unbound))
(defvar +qvt-unbound+ (make-qvt-unbound))

(declaim (inline qvt-boundp qvt-unboundp))
(defun qvt-boundp (val) (not (eql val +qvt-unbound+)))
(defun qvt-unboundp (val) (eql val +qvt-unbound+))

(defun instance2tries (inst)
  "Map an instance to tries. *package* should be population.model-n+1.lisp-package."
  (let* ((class (class-of inst))
	 (class-list (closer-mop:class-precedence-list class)))
    (loop for c in (subseq class-list
			   0
			   (position 'mm-root-supertype class-list :key #'class-name)) do
	 (trie-add `(,(class-name c) ,inst))
	 (dbg-message :qvt 6 "~%Adding ~A" `(,(class-name c) ,inst))
	 (loop for slot in (mofi:mapped-slots class)
	    for slot-name = (closer-mop:slot-definition-name slot)
	    for slot-source = (class-name (mofi:slot-definition-source slot))
	    for val = (slot-value inst slot-name)
	    for predicate = (intern (format nil "~A.~A" slot-source slot-name)) do
	      (when val
		(typecase val
		  (ocl:|Collection|
		       (let ((val (ocl:value val)))
			 (when (mofi:slot-definition-is-ordered-p slot)
			   (let ((predicate-ordered (intern (format nil "~A.ordered" predicate) :qvt))) ; 2014 :qvt Really?
			     (trie-add `(ordered-collection-p ,predicate))
			     (loop for v in val for i from 1 do
				  (trie-add `(,predicate-ordered ,inst ,i ,v))
				  (dbg-message :qvt 6 "~%Adding ~A" `(,predicate-ordered ,inst ,i ,v)))))
			 (loop for v in val do (trie-add `(,predicate ,inst ,v))))
		       (trie-add `(,(intern (format nil "~A.~A.collection" slot-source slot-name)) ,inst ,val)))
		  (t
		   (trie-add `(,predicate ,inst ,val)))))))))

(defun preds2collections (db) ; 2014 This was once called flush-model, a misnomer recognized as such long ago.
  "Iterate through all the two-place predicates in DB, a symbol, setting values."
    ;; POD! It may be the case that the target and the source are the same models, in which
    ;; case I'm arbitrarily choosing the first nickname here.
  (with-trie-db (db)
    (loop for pred being the hash-key of (db-predicates)
       when (trie-query `(,pred ?x ?y)) do ; then it is two-place
	 (dbind (cname sname) (split (string pred) #\.)
	   (setf cname (intern cname (symbol-package pred)))
	   (setf sname (intern sname (symbol-package pred)))
	   (let ((-typ (mofi::slot-typ (list cname sname))))
	     ;; POD This needs to make collections, and where necessary add to them...
	     (loop for f = (trie-query `(,pred ?x ?y)) then (trie-query-next)
		while f do
		  (dbind (ignore obj val) f
		    (declare (ignore ignore))
		    (if -typ ; it should be a collection.
			(let ((col? (slot-value obj sname)))
			  (if (typep col? 'ocl:|Collection|)
			      ;; POD clearly just pushing (not new) results in many duplicates.
			      ;; Is making preds2collections (what's the word?) too blunt an approach?
			      (setf (ocl:value col?) (pushnew val (ocl:value col?) :test #'equal))
			      (setf (slot-value obj sname)
				    (make-instance (ocl:appropriate-collection-type -typ)
						   :value (list val)))))
			(setf (slot-value obj sname) val)))))))))

(defmethod qvt-go :around (trans)
  "Do initialization."
  (clrhash *proxy-obj-ht*) ; POD!!! This should not be done if you want to preservee an existing enforce population.
  (call-next-method))

(defmethod relation-check :around (rel-name domain binds)
  (dbg-message :qvt 5 "~%   => Checkonly domain ~A.~A called with bindings set: ~%   ~S" rel-name domain binds)
  (let ((result (call-next-method)))
    (dbg-message :qvt 5 "~%   => Checkonly domain ~A.~A returning sets:" rel-name domain)
    (dbg-message :qvt 5 "~%~{     Set: ~S ~%~}" result)
    result))

(defmethod relation-enforce :around (rel-name domain binds)
  "This one does more than diagnosics! It also flushes objects."
  (dbg-message :qvt 5 "~%   => Enforce domain ~A.~A called with bindings ~S" rel-name domain binds)
  (let ((result (call-next-method)))
    (dbg-message :qvt 5 "~%   <= Enforce domain ~A.~A is returning." rel-name domain)
    (preds2collections (domain-nick (target-meta *map-info*) :interned t))
    result))

(defmethod key-completer :around (rel-name binds)
  (dbg-message :qvt 5 "~%   => Key completer of ~A called with bindings:" rel-name)
  (dbg-message :qvt 5 "~%    (~{~S~^~%     ~}) "  binds)
  (let ((result (call-next-method)))
    (dbg-message :qvt 5 "~%   <= Key completer of ~A returning ~S" rel-name result)
    result))

(defmethod relation-executor :around (rel-name binds)
  (dbg-message :qvt 5 "~%=> Relation executor ~A called with bindings ~S" rel-name binds)
  (let ((result (call-next-method)))
    (dbg-message :qvt 5 "~%<= Relation executor ~A returning sets:" rel-name)
    (dbg-message :qvt 5 "~%~{     Set: ~S ~%~}" result)
    result))

(defmethod when-where :around (rel-name  binds)
  (dbg-message :qvt 5 "~%   => When-where ~A called with binding set:~%     Set: ~S" rel-name binds)
  (let ((result (call-next-method)))
    (dbg-message :qvt 5 "~%   <= When-where ~A returning ~S" rel-name result)
    result))

(defun binds2keyargs (binding-set)
  "Return a list of (:var1 val1 ...:varN valN) suitable for apply.
   Argument BINDING-SET is a of the form ((<varname1> . val1) ...(<varrnameN> . valN))
   such as returned from qvt-query-aux."
  (loop for (var . val) in binding-set
	collect (kintern var)
	collect val))

(defun bound-args (&rest args)
  "ARGS are of the form :key1 val1..keyN valN. Return
   a similarly structured list, eliminating those whose
   values are +qvt-unbound+"
  (loop while args
	for key = (pop args)
	for val = (pop args)
	unless (eql +qvt-unbound+ val)
	append (list key val)))

(defun keyargs2binds (key-args)
  "Given a set of arguments (:var1 val1 ...:varN valN),
   return the set ((?var1 . val1) ...(?varN . valN))."
  (loop while key-args collect (cons (varname (pop key-args)) (pop key-args))))

;;; POD the testing here may be for something that cannot occur. Needs thought.
(defun append-args (args1 args2)
  "ARG1 and ARG2 are lists of form (:key1 val1 ...:keyn valn). Append them
   but make sure that the same key isn't specified twice."
  (setf args1 (loop while args1 for key = (pop args1) for val = (pop args1)
		    unless (eql val +qvt-unbound+) collect key and collect val))
  (setf args2 (loop while args2 for key = (pop args2) for val = (pop args2)
		    unless (eql val +qvt-unbound+) collect key and collect val))
  (let ((key1 (loop for val in args1 for i from 0 when (evenp i) collect val))
	(key2 (loop for val in args2 for i from 0 when (evenp i) collect val)))
    (when-bind (multi-defs (intersection key1 key2))
      (loop for m in multi-defs
	    unless (equal (second (member m args1))
			  (second (member m args2)))
	    do (error "Variables specified multiply with differing values: ~S" m)))
    (append args1 args2)))

(defun append-binds-aux (bind-set1 &optional bind-set2 &key keep-set)
  "Merge two bindings sets, checking for consistent bindings (if duplicate keys).
   If KEEP-SET is specified, only those bindings are returned."
  (setf bind-set1 (remove-if #'qvt-unboundp bind-set1 :key #'cdr))
  (setf bind-set2 (remove-if #'qvt-unboundp bind-set2 :key #'cdr))
  (if (null bind-set2)
      bind-set1
      (progn
	(loop for b1 in bind-set1
	      for b2 = (find (car b1) bind-set2 :key #'car)
	      when (and b2
			(eql (car b2) (car b1))
			(not (equal (cdr b2) (cdr b1))))
	      do (error "Two values for binding: ~A ~A." b1 b2))
	(let ((result (remove-duplicates (append bind-set1 bind-set2) :key #'car)))
	  (if keep-set
	      (remove-if-not #'(lambda (x) (member x keep-set)) result :key #'car)
	      result)))))

(defun append-binds (&rest bind-sets)
  "Merge the argument bindings sets, checking for consistent bindings (if duplicate keys).
   You can call it with just one binding set, in which case it will clear out +qvt-unbound+"
  (setf (car bind-sets) (remove-if #'qvt-unboundp (car bind-sets) :key #'cdr))
  (reduce #'append-binds-aux bind-sets))

(defun binds-keep-only (binding-set keep-vars)
  "Return a binding with all bindings except those of variables
   in KEEP-VARS (a list of variable symbols) removed."
  (remove-if-not #'(lambda (b) (member (car b) keep-vars)) binding-set))

(defparameter *proxy-obj-ht* (make-hash-table :test #'equal))

(defun ensure-proxy-obj (&key class properties values)
  "Create and return or just return a proxy-object for the CLASS
   key PROPERTIES and key VALUES."
  (unless (= (length properties) (length values))
    (error "Malformed args to ensure-proxy-obj"))
  (let ((key (cons class (append properties values))))
    (if-bind (result (gethash key *proxy-obj-ht*))
	     (progn
	       (dbg-message :qvt 5 "~2%  *****Retrieving target object ~S" result)
	       result)
	     (let ((result
		    (setf (gethash key *proxy-obj-ht*)
			  (apply #'make-instance class
				 (mapappend #'(lambda (k v) (list (kintern (c-name2lisp k)) v))
					    properties values)))))
	       (dbg-message :qvt 5 "~2%  *****Creating target object ~S with keys ~A ~A"
			    result properties values)
	       result))))

(defun find-proxy-obj (&key class properties values (error-p t))
  "Like ensure-proxy-object but gets an error if ERROR-P T and does
   not already exist."
  (or (gethash (cons class (append properties values)) *proxy-obj-ht*)
      (and error-p (error "No such proxy-obj: Class ~S, Properties ~S, Values ~S."
			  class properties values))))


(defun qvt-query (bindings &rest formulas)
  "qvt-query-aux returns nil on failure of one formula and :fail on failure
   resulting from unify. It returns something with (T . T) in it when 'unifying'
   ground facts. It needs to return :fail on failure, (nil) on ground facts
   (means 'yes, but no bindings') and bindings otherwise."
  (let ((result (apply #'qvt-query-aux formulas)))
    (cond ((null result) :fail)
	  ((eql result :fail) nil)
	  (t
	   (loop for bset in result
		 collect
		 (append-binds
		  bindings
		  (remove-if #'(lambda (e) (eql (car e) (cdr e))) bset)))))))

(defun qvt-query-aux (&rest formulas)
  "FORMULAS is a conjunctive list of formulas. This was built from lt-query-aux, it remains
   trie-specific, still used to to unify, just doesn't need the variable binding syntax and AND,
   and it removes (T . T) bindings -- which signify match object-to-object."
   (flet ((unify* (&rest args)
	   (let ((result (apply #'tr::unify-equal args)))
	     (if (eql result :fail) (return-from qvt-query-aux :fail) result))))
     (loop for s-query in formulas
	   for new-binds = (loop for result in (trie-query-all s-query)
				 collect (unify* s-query result)) then
				 (loop for bset in new-binds
				       for query = s-query do
				       (loop for b in bset do (setf query (subst (cdr b) (car b) query)))
				       append (loop for new-bset in (loop for result in (trie-query-all query)
									  collect (unify* query result))
						    collect (append new-bset bset)))
				 finally (return new-binds))))


(defmacro with-bindings (((&rest vars) execute-form &key exception) &body body)
  "Wrap BODY in a let where VARS are bound bindings from EXECUTE-FORM, but
   if no binding exists, do the EXCEPTION (:error :symbol :unbound)."
  (with-gensyms (result)
    `(let* ((,result ,execute-form)
	    ,@(mapcar #'(lambda (v) `(,v (find-binding ',v ,result :action ,exception))) vars))
      ,@body)))

(defun find-binding (var bindings &key (action :error))
  (let ((val (cdr (assoc var bindings))))
    (or
     val
     (case action
       (:symbol var)
       (:unbound +qvt-unbound+)
       (:throw (throw :when-failed nil))
       (:error (error "Binding not found for ~S.~%Perhaps one of the following is the cause: ~%   (1) The variable is an enforce domain variable and you didn't set the keys.~%   (2) You are missing a key declaration.~%   (3) There isn't an enforce domain that can make an instance of the type associated with the variable. ~%   (4) You introduced a variable that isn't being used." var))
       (:nil nil)))))

(defun bind-or-unbound (var bindings)
  (or (cdr (assoc var bindings))
      +qvt-unbound+))

#+nil
(defun merge-identicals (&rest binding-sets)
  "For ((?x . 1) (?y . 2))  ((?x . 1) (?y . 3)) return ((?y . 2) (?y . 3))."
  (reduce #'merge-identicals-aux binding-sets))

#+nil
(defun merge-identicals-aux (bset1 bset2)
  (if (null bset2)
      bset1
      (loop for b1 in bset1
	    for (var . val) = b1
	    for b2 = (assoc var bset2)
	    unless (and b2 (equal val (cdr b2))) collect b1 and collect b2)))

(defun bs-dup-p (bset1 bset2)
  "Return T if the two binding sets are identical."
  (when (= (length bset1) (length bset2))
    (loop for b1 in bset1
	  for (var . val) = b1
	  for b2 = (assoc var bset2)
	  unless (and b2 (equal val (cdr b2))) return nil
	  finally (return t)))) ; 2022 Screwed around here with return. Okay?

(defmacro qvt-setq-when ((&rest vars) form-returning-dotted)
  "Macro to setf binding of variables VARS lexically bound outside of BODY.
   Only to be used with calls to RelationCallExp, since it throws."
  (with-gensyms (result new-value)
    `(let ((,result (remove-duplicates ,form-returning-dotted :test #'bs-dup-p)))
      (when (cdr ,result)
	(error "Evaluation of a RelationCallExp (in WHEN) resulted in multiple binding sets."))
      ,@(mapcar #'(lambda (v)
		    `(let ((,new-value (find-binding ',(second v) (car ,result) :action :throw)))
		      (unless (eql ,new-value +qvt-unbound+)
			(setf ,(first v)  ,new-value))))
		    vars))))


(defmacro qvt-setq-where ((&rest vars) form-returning-dotted)
  "Macro to setf binding of variables VARS lexically bound outside of BODY.
   Only to be used with calls to RelationCallExp, since it throws."
  (with-gensyms (result new-value)
    `(let ((,result (remove-duplicates ,form-returning-dotted :test #'bs-dup-p)))
      (when (cdr ,result)
	(error "Evaluation of a RelationCallExp (in WHERE) resulted in multiple binding sets."))
      ,@(mapcar #'(lambda (v)
		    `(let ((,new-value (find-binding ',(second v) (car ,result) :action :unbound)))
		      (unless (eql ,new-value +qvt-unbound+)
			(setf ,(first v)  ,new-value))))
		    vars))))

(defmacro qvt-setq ((bindings (&rest vars)) &body body)
  "Macro to setf binding of variables VARS lexically bound outside of BODY.
   Only to be used with calls to RelationCallExp, since it throws."
  (with-gensyms (binding-form some-var)
    `(let ((,binding-form ,bindings))
      ,@(mapcar #'(lambda (v)
		    `(when-bind (,some-var (find-binding ',v ,binding-form :action :nil))
		      (setf ,v ,some-var)))
		vars)
      ,@body)))


(defmacro with-when  ((rel-name) &body body)
  "Does nothing but provide visual structuring and hide debugging."
  `(progn
    (dbg-message :qvt 5 ,(format nil "~~% ---- Entering WHEN of ~A  ----" rel-name))
    ,@body
    (dbg-message :qvt 5 ,(format nil "~~% ---- Exiting WHEN of ~A  ----" rel-name))))

(defmacro with-where ((rel-name) &body body)
  "Does nothing but provide visual structuring and hide debugging."
  `(progn
    (dbg-message :qvt 5 ,(format nil "~~% ---- Entering WHERE of ~A  ----" rel-name))
    ,@body
    (dbg-message :qvt 5 ,(format nil "~~% ---- Exiting WHERE of ~A  ----" rel-name))))

(defun qvt-trie-add-upgrading (rel)
  "Check that the object named in the (unary) relation is indeed of the type
   specified in the predicate. If it is not, then it should be a specialization
   of that type (error otherwise). When it is a specialize, change-class the
   object to that type."
  (tr:trie-add rel) ; do this regardless
  (dbind (pred obj) rel
    (unless (typep obj pred)
      (if-bind (up-class (find-class pred nil))
	 (let ((cpl (class-precedence-list up-class))
	       (current (class-of obj)))
	   (unless (member current cpl)
	     (error "Cannot specialize a ~A to class ~A. ~%Perhaps object keys are not unique." obj pred))
	   (unless (eql current (car cpl))
	     (change-class obj up-class)))
	 (error "While attempting to specialize, ~A is not a class." pred)))))
