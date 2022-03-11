
;;;
;;; Purpose: Implements "post-canonical era" model diff capability. 
;;;          Reports using the bookkeeping approach from xml diffing. 
;;; Date: 2011-06-19 (not a particularly good time, BTW!)

#|
    Does a tiered (through owned-element) children-to-children match recursively, 
    resulting in (M x N) scores based on name matching, type matching, etc. 
    Done from both directions (u picks a partner in v, v picks a partner in u). 
    If partners agree and scores are high (see *score-model*), then pair is placed 
    in perfect-ht. May throw to re-align tiers here if the tier's matches on the 
    whole are not good. [Implementation of throwing has been removed. Will be debugged later.]

    Score all remaining ('remaining' means not yet in perfect-ht) type pairs 
    (currently model-wide) by deep-inspect of properties. This uses another 
    scoring model, but also reuses the *score-model* described earlier for
    unordered sets (which is what children-to-children above is). Here however
    it uses only the aggregate score for the set (not for matching children)
    and can use perfect-ht. See entail-remaining-matches. 

    Anything remaining un-paired here is reported. 

    Finally walk through non-derived properties of each pair in perfect-ht, 
    reporting differences.
|#

(in-package :mofi)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *diffpkg* :uml23 "UML package for the following 3 'compiler directives'")
  (defmacro usym (string) `(intern ,string *diffpkg*))
  (defmacro ufuncall (string &rest args) `(funcall (symbol-function ',(usym (string-upcase string))) ,@args))
  (defmacro ufun (string) `(symbol-function ',(usym string)))
)

(defvar *valid-tcs* nil "alist of valid, typically set at program load.")

;;; Stuff used in deep-inspect
(defvar *score* '(0 . 0) "Records score (point . possible-points) as analyzing an object.")
(defvar *score-hits* (make-hash-table :test #'equal) "A memoizer for scores, indexed by (u . v).")
(defvar *inspect-stack* nil "Track (u . v) to break recursion.")
(defvar *zippy* nil)

(declaim (inline key2model))
(defun key2mut (tc)
  "TC is :TC1, :TC2, etc, return the valid model."
  (cdr (assoc tc *valid-tcs*)))

(declaim (inline gethash-inv-obj))
(defun gethash-inv-obj (val ht)
  "Inverse lookup can be one-to-many. The elem we want (out of one of the xml2model-ht typically)
   is the one representing the object, not a xmi:idref etc. to it."
  (gethash-inv val  ht :test  #'(lambda (x) (and (dom:element-p x)
						 (xml-get-attr x "type" :prefix "xmi")))))

(defclass tc-matches ()
   ;; These are 'permanent' commitments to a mapping, indexed by u
  ((perfect-ht :initform (make-hash-table) :reader perfect-ht)
   ;; These are u for which no v picked it as a match
   (u-no-v-list  :initform nil)
   ;; These are v for which no u picked it as a match. 
   (v-no-u-list  :initform nil)
   ;; Things that have ambiguous match scores after deep inspect.
   (contradictions :initform nil)))

(defmacro with-matches ((&rest slots) &body body)
  (with-gensyms (obj)
    `(with-vo (mut)
       (with-slots ((,obj tc-matches)) (processing-results mut)
	 (with-slots (,@slots) ,obj
	   ,@body)))))

(defun install-perfect (u v)
  "Error checking, place a value in perfect-ht"
  (when (and (typep u (usym "Element")) (typep v (usym "Element")))
    (with-matches (contradictions)
      (let ((flat (flatten contradictions))) ; POD tired
	(if (or (member u flat) (member v flat))
	    (warn "~A/~A already known as a contraditions." (mofi:%debug-id u) (mofi:%debug-id v))
	    (with-matches (perfect-ht)
	      (loop for key being the hash-key of perfect-ht using (hash-value val) 
		 when (eql key u) 
		 do (unless (eql val v) 
		      (warn "Perfect match contradiction! (user) ~A/~A" 
			    (mofi:%debug-id u)
			    (mofi:%debug-id key))
		      (pushnew (list (cons u v) (cons key val)) contradictions :test #'equal)
		      (setf (gethash u perfect-ht) nil))
		 when (eql val v) 
		 do (unless (eql key u) 
		      (warn "Perfect match contradiction! (valid) ~A/~A"
			    (mofi:%debug-id v)
			    (mofi:%debug-id val))
		      (pushnew (list (cons u v) (cons key val)) contradictions :test #'equal)
		      (setf (gethash u perfect-ht) nil)))
	      (memo-score u v 100) ; 2011-10-13
	      (setf (gethash u perfect-ht) v)))))))

(defun reload-valid-testcases (&key (files (mofi:canonical-files)))
  "Store models for all testcases on *valid-tcs*." 
  (flet ((run-validator (fname)
	   "Run xmi2model-instance, return MUT."
	   (setf *spare-session-vo* (make-instance 'phttp:sei-session-vo :models *essential-models*))
	   (handler-bind ((simple-warning #'(lambda (c) (declare (ignore c)) (muffle-warning))))
	     (with-debugging (:readers 0) 
	       (xmi2model-instance :file fname :clone-p nil)))))
    (setf *valid-tcs*
	  (loop 
	     for tc in files
	     for mut = (run-validator (find-tc-canonical tc))
	     do (change-class mut 'tc-population)
	     collect (cons (kintern tc) mut)))))

(defun simple-run-validator (fname)
  "Run xmi2model-instance."
  (setf *spare-session-vo* (make-instance 'phttp:sei-session-vo :models *essential-models*))
  (handler-bind ((simple-warning #'(lambda (c) (declare (ignore c)) (muffle-warning))))
    (with-debugging (:readers 0) 
      (xmi2model-instance :file fname :clone-p nil))))

#-moss.exe
(defun test-model-diff (tc)
    (handler-bind
	((simple-warning #'(lambda (c) 
			     (with-slots (mofi::conditions) mofi:*results*
			       (vector-push-extend c mofi::conditions))
			     (muffle-warning))))
      (model-diff tc)))

(defun model-diff (tc)
  "Toplevel. Run model diff of MUT against testcase TC, a string 'TC1', 'TC2' etc."
  (with-vo (mut phttp:show-diff-p)
    (setf (slot-value (processing-results mut) 'tc-matches) (make-instance 'tc-matches))
    (setf tc (kintern tc))
    (setf phttp:show-diff-p tc) ;need this if calling while debugging.
    (clrhash *score-hits*)
    (let* ((valid-mut (key2mut tc))
	   (u-model (find-if #'(lambda (x) (or (typep x (usym "Model")) (typep x (usym "Profile"))))
			     (members mut)))
	   (v-model (find-if #'(lambda (x) (or (typep x (usym "Model")) (typep x (usym "Profile"))))
			     (members valid-mut))))
      (install-perfect u-model v-model)
      (let ((perfect-u (list u-model))
	    (perfect-v (list v-model)) uc-no-v vc-no-u perfect)
	(loop 
	   for u = (pop perfect-u)
	   for v = (pop perfect-v) while u 
	   for ht = (score-children u v) ; U and V match! Starting with the two models....
	   when ht do
	     (mvs (perfect uc-no-v vc-no-u)
		 (choose-best-matches u v ht)) ; can throw
	     (with-matches (u-no-v-list v-no-u-list)
	       (loop for (u . v) in perfect do 
		    (install-perfect u v)
		    (push-last u perfect-u)
		    (push-last v perfect-v))
	       (setf u-no-v-list (append u-no-v-list uc-no-v))
	       (setf v-no-u-list (append v-no-u-list vc-no-u)))
	     (clrhash *score-hits*)
	     (when-debugging (:match 1) 
	       (report-matches u v ht perfect uc-no-v vc-no-u))))
	(entail-remaining-matches tc)
	(post-match-reporting tc))))

(defun perfect-enough-p (u v perfect ht)
  "Return T if the number of children from u is roughly that of v, and
   the average score is pretty good. U and V are uml23:Element."
  (declare (ignore u v perfect ht))
#|
  (let ((len-p (length perfect))
	(len-u (length (ocl:value (ufuncall "%owned-element" u))))
	(len-v (length (ocl:value (ufuncall "%owned-element" v)))))
    (and (plusp len-p)
	 (> (/ (loop for match in perfect sum (gethash match ht)) len-p) .50) ; avg score
	 (or (< (abs (- len-u len-v)) 4)
	     (< 2/3 (/ len-u len-v) 4/3)))))
|#
  t)

(defparameter *debug-cycle* (make-hash-table :test #'equal))

(defun choose-best-matches (u v ht &key ignore-test-p)
  "Return values: (1) perfect matches (vertical and horizontal agree).  Form: ((u1 . v1)...)
                  NO -- (2) u with multiple v Form: ((u (v1 v2...))...)
                  NO -- (3) v with multiple u Form: ((v (u1 u2...))...)
                  (2) u with no v    Form: (u1 u2...)
                  (3) v with no u    Form: (v1 v2...) 
  ....or throw if not perfect-enough-p."
;  (when (gethash (cons u v) *debug-cycle*) (error "cycle: u=~A v=~A" u v))
;  (setf (gethash (cons u v) *debug-cycle*) t)
  (when (and u v)
    (let* ((uc (remove-duplicates (loop for k being the hash-key of ht collect (car k))))
	   (vc (remove-duplicates (loop for k being the hash-key of ht collect (cdr k))))
	   (u-matches (loop for u in uc with val = nil with objs = nil
			 do (mvs (val objs) (best-matches u ht))
			 unless (zerop val) collect (list u objs))) ; POD unless zerop -- not good?
	   (v-matches (loop for v in vc with val = nil with objs = nil
			 do (mvs (val objs) (best-matches v ht :reverse t))
			 unless (zerop val) collect (list v objs))) ; POD unless zerop -- not good?
	   ;;---------------- Return arguments
	   (uc-no-v ; you are nobody's favorite U
	    (loop for (u matches) in u-matches
	       when (and (single-p matches) (not (member u (second (assoc (car matches) v-matches)))))
	       collect u))
	   (vc-no-u ; you are nobody's favorite V
	    (loop for (v matches) in v-matches
	       when (and (single-p matches) (not (member v (second (assoc (car matches) u-matches)))))
	       collect v))
	   (perfect
	    (loop for (u matches) in u-matches
	       for v-cands = (set-difference 
			      (loop for vm in v-matches when (member u (second vm)) collect (car vm))
			      vc-no-u)
	       when (and (single-p matches) 
			 (single-p v-cands)
			 (not (member (car v-cands) vc-no-u))
			 (not (member u uc-no-v)))
	       collect (cons u (car v-cands)))))
      (if (or ignore-test-p (perfect-enough-p u v perfect ht))
	  (values perfect uc-no-v vc-no-u)
	  (throw 'not-perfect-enough :not-perfect-enough))))) ; <==== Need a new perfect
  
(defun high-u-score (u ht &key reverse)
  "Return the highest score on a match with u (could be multiple at that score)."
  (loop 
     for k being the hash-key of ht using (hash-value v)
     with high = 0
     when (and (eql u (if reverse (cdr k) (car k))) (> v high))
     do (setf high v)
     finally (return high)))

#-sei.exe
(defun report-matches (u v ht perfect u-no-v v-no-u)
  "Report on how a match went."
  (format t "~3%****Matching ~A to ~A" u v)
  (format t "~% Perfect matches:")
  (loop for p in perfect do (format t "~%  ~5A ~A" (gethash p ht) p))
;  (break "here")  <====================MD TC9 use
  (format t "~% In User only:")
  (loop for u in u-no-v do (format t "~%  ~5A ~A" (high-u-score u ht) u))
  (format t "~% In Valid only:")
  (loop for v in v-no-u do (format t "~%  ~5A ~A" (high-u-score v ht :reverse t) v))
  (when-debugging (:match 5)
    (let* ((uc (remove-duplicates (loop for k being the hash-key of ht collect (car k))))
	   (vc (remove-duplicates (loop for k being the hash-key of ht collect (cdr k))))
	   (u-matches (loop for u in uc with val = nil with objs = nil
			 do (mvs (val objs) (best-matches u ht))
			 unless (zerop val) collect (list u objs))) ; POD unless zerop -- not good?
	   (v-matches (loop for v in vc with val = nil with objs = nil
			 do (mvs (val objs) (best-matches v ht :reverse t))
			 unless (zerop val) collect (list v objs))) ; POD unless zerop -- not good?
	   (uc-multi-v (loop for u-match in u-matches 
			  unless (single-p (second u-match)) collect u-match))
	   (vc-multi-u (loop for v-match in v-matches 
			  unless (single-p (second v-match)) collect v-match)))
      (format t "~% Ambiguous from U:")
      (loop for u in uc-multi-v do 
	   (format t "~%  ~4A ~A" (high-u-score u ht) (car u))
	   (format t "~{~%            ~A~}" (second u)))
      (format t "~% Ambiguous from V:")
      (loop for v in vc-multi-u do 
	   (format t "~%  ~4A ~A" (high-u-score v ht :reverse t) (car v))
	   (format t "~{~%            ~A~}" (second v))))))

(defclass criterion ()
  ((name :initarg :name)
   (weight :initarg :weight)
   (tests :initarg :tests)))

(defmethod print-object ((obj criterion) stream)
  (with-slots (name) obj
    (format stream "#<criterion ~A>" name)))

;;; POD Could also have a "child recursion" test, would score by average score of child fit, though
;;; this would require a lot more testing. 
;;;
;;; Tests is a list of sublists of form (test-name . worth); 
;;; If worth is nil, the test returns a number [0,1], no other calculations
;;; If worth is plusp then first such (plusp) to return T, value is the worth.
;;; If worth is minusp then it is a penalty, all pentalty worths are summed and subtracted from plusp worths.
(defparameter *score-model*
  (list
   (make-instance 'criterion 
		  :name "Name" 
		  :weight 31.0 ; 2011-08-02 was 30; so won't get a tie when properties are swapped.
		  :tests '((:name-perfect       .  1.0) 
			   (:name-soft-equal    .  0.7)
			   (:name-2-null        .  0.6)
			   (:name-1-null        .  0.2)))
   (make-instance 'criterion
		  :name "Type"
		  :weight 29.0 ; 2011-08-02 was 30; so won't get a tie when properties are swapped.
		  :tests '((:type-perfect       .   1.0)
			   (:type-supertype     .   0.6)
			   (:type-stereo-fault  .  -0.2))) 
   (make-instance 'criterion
		  :name "Child number" 
		  :weight 15.0
		  :tests '((:child-number       .   nil)))
   (make-instance 'criterion
		  :name "Child type"
		  :weight 15.0
		  :tests '((:child-type         .   nil)))
   (make-instance 'criterion
		  :name "Attr vals"
		  :weight 10.0
		  :tests '((:attr-vals          .   nil)))))


(defun score-children (uobj vobj)
  "Return scores for child pairs as ht indexed by (uobj . vobj)."
  (when (and (typep uobj (usym "Element")) (typep vobj (usym "Element")))
    (let ((ht (make-hash-table :test #'equal)))
      (when-bind (oe (ufuncall "%owned-element" uobj)) ; added 2013-11-15.
	(loop for u in (ocl:value oe) do
	     (loop for v in (ocl:value (ufuncall "%owned-element" vobj))
		do (setf (gethash (cons u v) ht) (round (score u v)))))
	ht))))

(defun best-matches (u/v ht &key reverse)
  "If reverse=nil return the object and score of the best match to object U in table HT.
   If reverse=t   return the object and score of the best match to object V in table HT."
  (loop 
     for k being the hash-key of ht using (hash-value val) with best-val = 0.0 with best-objs = nil
     when (and (eql (if reverse (cdr k) (car k)) u/v) 
	       (>= val best-val))
       do (if (= val best-val)
	      (push (if reverse (car k) (cdr k)) best-objs)
	      (progn (setf best-objs (list (if reverse (car k) (cdr k))))
		     (setf best-val val)))
     finally (return (values best-val best-objs))))

(defun score (u v)
  "Return a score for resemblance of u to v."
  (with-matches (perfect-ht)
   (if (eql v (gethash u perfect-ht))  
	100 ; POD Maybe it would be better to have scores here too? 
	(loop for crit in *score-model* sum (compute-crit crit u v)))) )

(defgeneric crit-test (test u v))

(defun compute-crit (criterion u v)
  "Return the weighted value from running CRITERION on U and V."
  (with-slots (weight tests) criterion
    (let ((pass-tests (loop for test in tests 
			 when (and (numberp (cdr test)) (plusp (cdr test))) collect test))
	  (penalty-tests (loop for test in tests 
			    when (and (numberp (cdr test)) (minusp (cdr test))) collect test))
	  (measure-test (loop for test in tests 
			   when (null (cdr test)) return test)))
      (if measure-test 
	  (* weight (crit-test (car measure-test) u v))
	  (* weight 
	     (+ (loop ; Assign worth of one it passes, or zero
		   for (test-name . worth) in pass-tests
		   for result = (crit-test test-name u v) 
		   when result return worth
		   finally (return 0.0))
		(loop ; Deduct worth for each one it passes
		   for (test-name . worth) in penalty-tests
		   for result = (crit-test test-name u v)
		   when result sum worth)))))))

;;; ============= Name ================
(defmethod crit-test ((test (eql :name-perfect)) u v)
  "T if U and V are named elements and string=."
  (and 
   (typep u (usym "NamedElement"))
   (typep v (usym "NamedElement"))
   (when-bind (u-name (ufuncall "%name" u))
     (when-bind (v-name (ufuncall "%name" v))
       (and (stringp u-name)
	    (stringp v-name)
	    (string= u-name v-name))))))

(defmethod crit-test ((test (eql :name-soft-equal)) u v)
  "T if U and V are named elements roughly similar names."
  (and 
   (typep u (usym "NamedElement"))
   (typep v (usym "NamedElement"))
   (when-bind (u-name (ufuncall "%name" u))
     (when-bind (v-name (ufuncall "%name" v))
       (and (stringp u-name)
	    (stringp v-name)
	    (string-equal (remove-extra-spaces u-name)
			  (remove-extra-spaces v-name)))))))

(defmethod crit-test ((test (eql :name-2-null)) u v) 
  "T if either both are not NamedElements, or both are and don't have names."
  (or
   (and 
    (typep u (usym "NamedElement"))
    (typep v (usym "NamedElement"))
    (null (ufuncall "%name" u))
    (null (ufuncall "%name" v)))
   (and 
    (not (typep u (usym "NamedElement")))
    (not (typep v (usym "NamedElement"))))))

(defmethod crit-test ((test (eql :name-1-null)) u v) 
  "T if both NamedElements and exactly one is null." 
  (and 
   (typep u (usym "NamedElement"))
   (typep v (usym "NamedElement"))
   (or (and (null (ufuncall "%name" u)) (ufuncall "%name" v))
       (and (null (ufuncall "%name" v)) (ufuncall "%name" u)))))

;;; ============= Type ================
(defmethod crit-test ((test (eql :type-perfect)) u v)
  "T if U and V are of the same type."
  (eq (type-of u) (type-of v)))


(defmethod crit-test ((test (eql :type-supertype)) u v)
  "T if U and V share a 'significant' supertype."
  (or
   (and (numberp u) (numberp v))
   (and (typep u (usym "Element"))
	(typep v (usym "Element"))
	(let* ((cpl-u (class-precedence-list (class-of u)))
	       (cpl-v (class-precedence-list (class-of v)))
	       (longer (if (longer cpl-u cpl-v) cpl-u cpl-v)))
	  (> (/ (length (intersection cpl-u cpl-v)) (length longer)) 2/3)))))

(defmethod crit-test ((test (eql :type-stereo-fault)) u v)
  "T if U and V don't match on stereotype applications."
   (and (typep u (usym "Element"))
	(typep v (usym "Element"))
	(not
	 (equal
	  (remove-if-not #'stereotype-p (class-precedence-list (class-of u)))
	  (remove-if-not #'stereotype-p (class-precedence-list (class-of v)))))))

;;; ============= Child Number -- a measure test ================
(defmethod crit-test ((test (eql :child-number)) u v)
  "Return [0,1] percent that U and V have the same number of children."
  (cond ((and (not (typep u (usym "Element"))) (not (typep v (usym "Element")))) 1.0)
	((and (not (typep u (usym "Element"))) (typep v (usym "Element"))) 0.0)
	((and (not (typep v (usym "Element"))) (typep u (usym "Element"))) 0.0)
	(t
	 (let* ((owned-u (ufuncall "%owned-element" u))
		(owned-v (ufuncall "%owned-element" v))
		(len-u (if owned-u (length (ocl:value owned-u)) 0))
		(len-v (if owned-v (length (ocl:value owned-v)) 0)))
	   (if (and (zerop len-u) (zerop len-v)) 
	       1.0
	       (- 1.0 (/ (abs (- len-u len-v))
			 (max len-u len-v))))))))

;;; ============= Child Type -- a measure test ================
(defmethod crit-test ((test (eql :child-type)) u v)
  "Return [0,1] percent match on child types."
  (if (or (not (typep u (usym "Element")))
	  (not (typep v (usym "Element"))))
	 1.0
	 (if (and (typep u (usym "Element"))
		  (typep v (usym "Element"))
		  (= 1.0 (crit-test :child-number u v)))
	     (let* ((owned-u (ufuncall "%owned-element" u))
		    (owned-v (ufuncall "%owned-element" v))
		    (types-u (mapcar #'class-of (and owned-u (ocl:value owned-u))))
		    (types-v (mapcar #'class-of (and owned-v (ocl:value owned-v)))))
	       (if (and (zerop (length types-u)) (zerop (length types-v)))
		   1.0
		   (- 1.0
		      (/ 
		       (/ 
			(+ (length (set-difference types-u types-v))
			   (length (set-difference types-v types-u)))
			2.0)
		       (length types-u)))))
	     0.0)))

(defmemo prim-slots (class)
  "A list of slot-definitions whose range is primitive or enum."
  (loop for s in (mapped-slots class)
     for range = (slot-definition-range s)
     when (or (enum-p range) (primitive-type-p range))
     collect s))

(defmethod crit-test ((test (eql :attr-vals)) u v)
  "Return [0,1] on shallow check of non-object attribute values."
  (let ((uclass (class-of u))
	(vclass (class-of v)))
    (cond ((not (eql uclass vclass)) 0.0)
	  ((not (and (typep u (usym "Element")) (typep u (usym "Element"))))
	   (if (or (typep u (usym "Element")) (typep u (usym "Element"))) 0.0 1.0))
	  (t (if-bind (pslots (prim-slots uclass))
	       (coerce 
		(/ (loop for s in pslots
		      for sname = (slot-definition-name s)
		      for sreader = (car (slot-definition-readers 
					  (find sname 
						(class-direct-slots (slot-definition-source s))
						:key #'slot-definition-name)))
		      for u-val = (funcall sreader u)
		      for v-val = (funcall sreader v)
		      when (or (eql u-val v-val)
			       (and (stringp u-val) (stringp v-val) (string= u-val v-val))
			       (and (numberp u-val) (numberp v-val) (= u-val v-val)))
		      count it)
		   (length pslots))
		'float)
	       1.0)))))
      
(defun entail-remaining-matches (tc)
  "Complete perfect-ht (objects not found through navigating owned-element) 
   by testing pairs having same type. 
   TC is a keyword identifying a test case model."
  (with-vo (mut)
    (let ((u-members (members mut))
	  (v-members (members (key2mut tc))))
      (with-matches (perfect-ht u-no-v-list v-no-u-list)
	(loop 
	   for u across u-members
	   for utype = (type-of u)
	   unless (or (gethash u perfect-ht) 
		      (member u u-no-v-list) ; <---- POD QUICK FIX NEEDS REVIEW!
		      (typep u (usym "ValueSpecification"))) do
	     ;; POD Might want to consider ownership/tiering here. 
	     (let ((v-cands (loop for v across v-members 
			       when (and (eql (type-of v) utype)
					 (not (gethash-inv v perfect-ht)) ; ht is 1-1.
					 (not (member v v-no-u-list))) ; <---- POD QUICK FIX NEEDS REVIEW!
			       collect v)))
	       (when-debugging (:match 3)
		 (format t "~2%Still to match:")
		 (format t "~% ~A: ~{~%     ~A~}" u v-cands))
	       (deep-inspect (list u v-cands))))))))

;;;=================================================================
;;; Deep Inspect -- Score an object against its ambig-list. 
;;; No point in re-running crit-tests, all the ambigs scored equal. 
;;;=================================================================
(defun deep-inspect (u-ambig-v)
  "U-AMBIG-V is of form (<u-object> (<v-object1>,<v-object2>...)), V-AMBIG-U likewise.
   Find the best match for u-object among the v-objects. Update tc-matches and return (u . v)."
  (setf *score* '(0 . 0))
  (clrhash *score-hits*)
  (setf *inspect-stack* nil)
  (let ((scores (loop 
		   for v in (second u-ambig-v) 
		   with u = (car u-ambig-v)
		   do (diff-prop u v)
		   collect (list *score* (cons u v)) 
		   do (setf *score* '(0 . 0))
		      (setf *inspect-stack* nil))))
    (when-debugging (:match 3)
      (format t "~2%Scores (~A):" (car u-ambig-v))
      (loop for s in scores do
	   (format t "~%    ~9,6F ~A" (coerce (/ (caar s) (cdar s)) 'float) (cdadr s))))
    (let ((best (loop 
		   for s in scores with bests = nil with best-score = .5
		   for score = (coerce (/ (caar s) (cdar s)) 'float)
		   when (>= score best-score) do
		     (if (= score best-score)
			 (push (second s) bests)
			 (progn (setf best-score score) (setf bests (list (second s)))))
		   finally (return bests))))
      (cond ((single-p best)
	     (install-perfect (caar best) (cdar best)))
	    ((null best) (when-debugging (:match 2) (warn "No match")))
	    (t (when-debugging (:match 2) 
		 (warn "Multiple bests: ~A" 
		       (mapcar #'(lambda (x) (mofi:%debug-id (cdr x))) best))))))
    (values)))

(declaim (inline score-hit-p incf-score memo-score))
(defun score-hit-p (u v) (gethash (cons u v) *score-hits*))
(defun memo-score (u v score) (setf (gethash (cons u v) *score-hits*) score))
(defun incf-score (increment &key reason)
  (when-debugging (:match 5)
    (format t "~%Increment: ~A, Now: ~A, Reason: ~A"
	    increment 	
	    (cons (+ (car *score*) (car increment))
		  (+ (cdr *score*) (cdr increment)))
	    reason))
  (setf *score* 
	(cons (+ (car *score*) (car increment))
	      (+ (cdr *score*) (cdr increment)))))

(defmacro score-wrapper (&body body)
  "Manage scoring using bindings, cut off endless recursion."
  (with-gensyms (score carry-score)
    `(cond ((member (cons u v) *inspect-stack* :test #'equal) 
	    (score-hit-p u v)) ; might be returning nil. OK?
	   (t
	    (push (cons u v) *inspect-stack*)
	    (if-bind (,score (score-hit-p u v))
		     (incf-score ,score :reason :adding)
		     (let (,carry-score)
		       (let ((*score* '(0 . 0)))
			 (declare (special *score*))
			 ,@body
			 (memo-score u v *score*)
			 (setf ,carry-score *score*)) ; carry out of lexical scope
		       (incf-score ,carry-score :reason :carry)))))))

(defgeneric diff-prop (x y))

(defmethod diff-prop ((u #.(usym "Element")) (v #.(usym "Element")))
  "Increment running score for slot-by-slot comparison of two Elements."
  (when-debugging (:match 5) (format t "~2% DIFF-PROP ~A ~A" u v))
  (score-wrapper
    (with-matches (perfect-ht)
      (if (gethash (cons u v) perfect-ht)
	  (incf-score '(20 . 20) :reason :perfect)
	  (if (not (eql (type-of u) (type-of v))) 
	      (incf-score '(0 . 20) :reason :imperfect)
	      (loop for slot in (mapped-slots (class-of u)) do (diff-slot slot u v)))))))

(defmethod diff-prop ((u ocl:|Collection|) (v ocl:|Collection|))
  "Either check pairs of like position (ordered) or try to pair elements and check."
  ;; AFAICS, it is not possible that the collections have differing -typ.
  (score-wrapper
    (if (ocl:ordered-p (ocl:typ-d u))
	(diff-ordered (ocl:value u) (ocl:value v))
	(diff-unordered (ocl:value u) (ocl:value v)))))

(defmethod diff-prop (u v)
  "diff-prop on primitive types."
  (if (equal u v)
      (incf-score '(3 . 3) :reason :prim-type)
      (incf-score '(0 . 3) :reason :not-prim-type)))

(defun diff-slot (slot u v)
  "Filter out derived-union slots and derived slots for which there
   is no derivation. For all other, call diff-prop on value."
  (unless (or (slot-definition-is-derived-union-p slot)
	      (member (slot-direct-slot slot)
		      (derived-slots-no-fn (model-n+1 (%of-model v)))))
    (diff-prop (funcall (mm-accessor-fn-name slot) u)
	       (funcall (mm-accessor-fn-name slot) v))))

(defun diff-ordered (u v)
  "Compare two collections whose content is ordered."
  (score-wrapper
    (if (not (= (length u) (length v)))
	(incf-score '(0 . 10) :reason :not-ordered)
	(loop for ue in u
	   for ve in v do
	     (diff-prop ue ve)))))

;;; Now comes the hard part!
(defun diff-unordered (u v)
  "Apply one matching strategy after another, until one works."
  (score-wrapper
    (let ((u-len (length u))
	  (v-len (length v)))
      (cond ((not (= u-len v-len))             (incf-score '(0 . 5) :reason :len-mismatch))
	    ((and (zerop u-len) (zerop v-len)) (incf-score '(3 . 3) :reason :len-zero))
	    ((= 1 u-len v-len)                 (diff-prop (car u) (car v)))
	    (t 
	     (let ((ht (score-unordered u v)))
	       (mvb (perfect u-multi-v v-multi-u u-no-v v-no-u)
		   (choose-best-matches nil nil ht :ignore-test-p t)
		 (let ((len-perfect (length perfect))
		       (len-multi-u (length (second u-multi-v)))
		       (len-multi-v (length (second v-multi-u)))
		       (len-u-no-v  (length u-no-v))
		       (len-v-no-u  (length v-no-u)))
		   ;; POD I'm not using the scores. Should I?
		   (incf-score (cons len-perfect u-len) :reason :len-perfect)
		   (incf-score (cons 0 (+ len-multi-u len-multi-v len-u-no-v len-v-no-u))
			       :reason :len-mimatch2)))))))))

(defun score-unordered (u-lis v-lis)
  "Like score-children, Return scores for child pairs as ht indexed by (uobj . vobj)."
  (let ((ht (make-hash-table :test #'equal)))
    (loop for u in u-lis do
	 (loop for v in v-lis do
	      (setf (gethash (cons u v) ht) (round (score u v)))))
    ht))

(defun pristine-up (ue)
  "UE is an xml elem in user xmi (messed up by canoncialized).
   Return the corresponding object in the pristine doc."
  (with-results (xml-pristine2user-ht)
    (loop for elem = ue then (xml-parent elem) while elem
       for pristine = (gethash-inv elem xml-pristine2user-ht) ; ht is 1-1?
       when pristine return pristine)))

;;;===========================================================================
;;; Post-matching reporting: report-missing, diff-perfect, report-odd-perfect
;;;===========================================================================
(defun post-match-reporting (tc)
  (report-odd-perfect tc)
  (diff-perfect)
  (report-missing tc))

(defun report-missing (tc)
  "Report the stuff that couldn't be matched."
  (flet ((ue2uo (elem-node)
	   "Navigating up through xml elements, return the first related uml object found."
	   (with-results (xml2model-ht)
	     (loop for e = elem-node then (and e (xml-parent e)) while e 
		   for obj = (gethash e xml2model-ht)
		   when (typep obj 'mm-root-supertype) return obj))))
    (with-matches (u-no-v-list v-no-u-list)
      (with-results (xml2model-ht elem2line-ht :mut (key2mut tc))
        (loop for v in v-no-u-list do
	     (if-bind (ve (gethash-inv-obj v xml2model-ht))
		(warn 'xmi-diff-user-missing 
		      :vline (gethash ve elem2line-ht) 
		      :velem ve
		      :vobj v)
		(warn "Couldn't find ve in xmi-diff-user-missing"))))
      (with-results (xml2model-ht  elem2line-ht xml-pristine2user-ht) 
	(loop for u in u-no-v-list do
	     (if-bind (ue (gethash-inv-obj u xml2model-ht))
		(if-bind (pristine-ue (pristine-up ue)) ; sometimes it doesn't work
		    (warn 'xmi-diff-valid-missing 
			  :uline (gethash pristine-ue elem2line-ht) 
			  :uelem pristine-ue
			  :uobj (ue2uo ue))
		    (warn "Couldn't find pristine element in xmi-diff-valid-missing ~A" ue))
		(warn "Couldn't find ue in xmi-diff-valid-missing")))))))

;;;----------------------------------
(defun report-odd-perfect (tc)
  "Report those perfect matches which don't look so perfect"
  (with-matches (perfect-ht)
    (loop for u being the hash-key of perfect-ht using (hash-value v)
	  unless (eql (type-of u) (type-of v)) do
	 (with-results (xml2model-ht elem2line-ht)
	   (let* ((ue (gethash-inv-obj u xml2model-ht))
		  (pristine-ue (pristine-up ue))
		  (uline (gethash pristine-ue elem2line-ht)))
	     (with-results (xml2model-ht elem2line-ht :mut (key2mut tc))
	       (let* ((ve (gethash-inv-obj v xml2model-ht))
		      (vline (gethash ve elem2line-ht)))
		 (warn 'xmi-odd-match 
		       :uobj u  
		       :uelem ue
		       :uline uline
		       :vobj v
		       :velem ve
		       :vline vline))))))))

;;;----------------------------------
(defparameter *diff-perfect-hit-ht* (make-hash-table :test #'equal))

;;; 2012-10-03 POD not sure why I need to have use a macro and include the body!
(defmacro perfect-hit-wrapper (&body body)
  `(unless (gethash (cons u v) *diff-perfect-hit-ht*)
     (setf (gethash (cons u v) *diff-perfect-hit-ht*) t)
     ,@body))

(defun diff-perfect ()
  "Perform uml:Element by Element diff, creating conditions where problems found."
  (clrhash *diff-perfect-hit-ht*)
  (with-vo (mut)
    (with-matches (perfect-ht u-no-v-list v-no-u-list)
      ;; First clean up the lists. POD Why is this necessary (it is).  
      (setf u-no-v-list (remove-if #'(lambda (x) (gethash x perfect-ht)) u-no-v-list))
      (setf v-no-u-list (remove-if #'(lambda (x) (gethash-inv x perfect-ht)) v-no-u-list))
      (loop
	 for u across (members mut)
	 for v = (gethash u perfect-ht)
	 when v do (diff-perfect-prop u v nil nil)))))

(declaim (inline diff-perfect-slot))
(defun diff-perfect-slot (slot u v)
  "Filter out derived slots (includes derived unions),
   for all others, call diff-perfect-prop on value."
  (unless (slot-definition-is-derived-p slot)
    (let ((sname (slot-definition-name slot)))
      (when (and (slot-exists-p u sname)
		 (slot-exists-p v sname))
	(let ((accessor (mm-accessor-fn-name slot)))
	  (diff-perfect-prop (funcall accessor u) 
			     (funcall accessor v)
			     u
			     slot))))))

(defgeneric diff-perfect-prop (u v owner slot))

(defmethod diff-perfect-prop ((u #.(usym "Element")) (v #.(usym "Element")) owner slot)
  (declare (ignore slot))
  (perfect-hit-wrapper
    (with-results (tc-matches)
      (when (eql v (gethash u (perfect-ht tc-matches)))
	(loop 
	   for mslot in (mapped-slots (class-of u)) 
	   do (diff-perfect-slot mslot u v))))))

(defmethod diff-perfect-prop ((u ocl:|Collection|) (v ocl:|Collection|) owner slot)
  "Either check pairs of like position (ordered) or try to pair elements and check."
  (perfect-hit-wrapper
    (if (ocl:ordered-p (ocl:typ-d u))
	(diff-perfect-ordered (ocl:value u) (ocl:value v) owner slot)
	(diff-perfect-unordered (ocl:value u) (ocl:value v) owner slot))))

(defmethod diff-perfect-prop (u v owner slot)
  "Report errors for user not specifying a value, or a differing value from valid."
  (perfect-hit-wrapper
    (when (typep u (usym "LiteralSpecification")) (setf u (ufuncall "%value" u)))
    (when (typep v (usym "LiteralSpecification")) (setf v (ufuncall "%value" v)))
    ;; 2012-10-03 don't check 'pure-supertypes (they aren't uml:|Element|; the specific method above is not used.
    (unless (or (equal u v) (typep u 'mm-root-supertype) (typep v 'mm-root-supertype))
      (with-results (tc-matches xml2model-ht elem2line-ht)
	(let* ((valid-object (gethash owner (perfect-ht tc-matches)))
	       (user-elem (pristine-up (gethash-inv-obj owner xml2model-ht)))
	       (user-line-num (gethash user-elem elem2line-ht)))
	  (with-vo (phttp:show-diff-p)
	    (with-results (xml2model-ht elem2line-ht :mut (key2mut phttp:show-diff-p))
	      (let* ((valid-elem (gethash-inv-obj valid-object xml2model-ht))
		     (valid-line-num (gethash valid-elem elem2line-ht)))
		;; 2013-12-30 Filter out temporary objects.
		(unless (or (and (typep owner 'mm-root-supertype) (minusp (%debug-id owner)))
			    (and (typep user-elem 'mm-root-supertype) (minusp (%debug-id user-elem)))
			    (and (typep valid-elem 'mm-root-supertype) (minusp (%debug-id valid-elem))))
		  (warn 
		   (if (and (= 0 (car (slot-definition-multiplicity slot))) (null u))
		       'xmi-diff-property-not-specified
		       'xmi-diff-property-values-differ)
		   :prop-name (string (slot-definition-name slot))
		   :class (slot-definition-source slot)
		   :slot slot
		   :uobj owner
		   :vobj valid-object
		   :uval u 
		   :vval v
		   :uelem user-elem
		   :velem valid-elem
		   :uline user-line-num
		   :vline valid-line-num))))))))))

(defun diff-perfect-ordered (u v owner slot)
  "Compare two collections whose content is ordered."
  ;; On ordered lists (only) we don't bother to check element counts differ.
  (when (= (length u) (length v))
    (loop for ue in u
       for ve in v
       do (diff-perfect-prop ue ve owner slot))))

(defun diff-perfect-unordered (u v owner slot)
  "Compare two unordered collections."
  (let ((u-len (length u))
	(v-len (length v)))
    (when (= u-len v-len)
      (cond ((and (zerop u-len) (zerop v-len)) t)
	    ((= 1 u-len v-len) (diff-perfect-prop (car u) (car v) owner slot))
	    (t 
	     (with-results (tc-matches)
	       (loop 
		  for ue in u 
		  for ve = (gethash ue (perfect-ht tc-matches))
		  when ve unless (member ve v :test #'equal)
		  do (warn "Element in unorderded collects differ: ~A ~A"
			   owner (string (slot-definition-name slot))))))))))
		       
	       

	 





	 
      
  






