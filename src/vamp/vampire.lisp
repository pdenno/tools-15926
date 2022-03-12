
(in-package :V)

(defconstant +relation-symbols+ '(ku:|equal| ku:|lessThan| ku:|greaterThan| ku:|lessThanOrEqualTo| 
				  ku:|greaterThanOrEqualTo|))
(defconstant +inequality-symbols+ '(ku:|lessThan| ku:|greaterThan| ku:|lessThanOrEqualTo| 
				    ku:|greaterThanOrEqualTo|))
(defconstant +logical-symbols+ '(ku:|and| ku:|or| ku:|not| ku:|exists| ku:|forall| ku:=> ku:<=>))
(defconstant +arithmetic-symbols+ '(ku:|AdditionFn| ku:|SubtractionFn| ku:|MultiplicationFn| ku:|DivisionFn|))

(defvar *proof-stream* *standard-output*)

;;;========= Stuff from miv/project ================
;;; It looks like vampire-tmp-file was a file with one form in it. See ~/projects/miv/tmp/vamp.out
(defclass cre-global ()
  ((gui :accessor gui :initform nil)
   (patches :initform nil)
   (vampire-path :reader vampire-path :initform  (pod:lpath :vampire "vampire.exe"))
   (vampire-stream :reader vampire-stream :initform nil)
   (vampire-tmp-file :reader vampire-tmp-file :initform (pod:lpath :tmp "vamp.out"))))
;  (:metaclass pod:singleton)) not worth the effort!

(let (app)
  (defun set-app-globals () (setf app (make-instance 'cre-global)))
  (defun app-globals () app)
  (defun clear-app-globals () 
    (setf (slot-value (find-class 'justv-global) 'pod:the-instance) nil))
)

(defclass null-construction-context ()
  ())
;;;========= End stuff from miv/project ==============

(defvar *zippy* nil)

;;; This became necessary in LW 5.0???
(defmacro pf-format (control-string &rest args)
  `(format *proof-stream* "~A" (format nil ,control-string ,@args)))

;;; parse-vampire is used to parse the what is returned from vampire, to get bindings. 
(defgeneric parse-vampire (elem-type dself &key response &allow-other-keys))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-parse-vampire (&rest args)
    `(def-parse parse-vampire response ,@args))
  (defmacro def-parse-proof (&rest args)
    `(def-parse parse-proof response ,@args))
  (defmacro def-preprocess (&rest args)
    `(def-parse parse-proof-preprocess response ,@args))
)

(declaim (inline poslit-p neglit-p))
(defun poslit-p (literal) (not (not-p literal)))
(defun neglit-p (literal) (not-p literal))
(defun unit-clause-p (clause) (not (second clause)))
  
(declaim (inline predicate))
(defun predicate (relation) (first relation))
  
(defun literal-mvb (literal)
  "Returns values (the literal's predicate,  T if it is positive)."
  (if (neglit-p literal) (values (caadr literal) nil)
    (values (car literal) t)))

(defmacro with-literal ((pred pol) lit &body body)
  "Macro for getting the predicate and polarity of a literal"
  (with-gensyms (litval) 
    `(let ((,litval ,lit))            
       (multiple-value-bind (,pred ,pol) 
           (progn (if (neglit-p ,litval)
                      (values (caadr ,litval) nil)
                    (values (car ,litval) t)))
     ,@body))))

;;; The * ones are for thing not read by this reader (which does set-variable-property
;;; and sets the property 'variable). Forms typed in to the listener, during debugging,
;;; will not have this property set. Hence use of #+debug.
(declaim (inline pred-p not-p not-p*))
(defun pred-p (form) (consp form))
(defun not-p  (form) (cl:and (consp form) (eql 'ku:|not| (car form))))
(defun not-p* (form) (eql 'ku:|not| (car form)))

;;; Yes, this clausifies, which isn't necessary, except to get a list of the predicates used.
;;; The predicates are used to find relations whose domain is a Formula, so that we know
;;; what to backquote.
(defun vampire-compile-ontology (&key in-file)
  (let ((kif-forms (make-instance 'k:kif-forms)))
    (setf *zippy* kif-forms)
    (flet ((lo-aux () ;this does trie stuff to find Formula domains, used by output-for-vampire
	     (setf (fill-pointer k:*clause-container*) 0) ; 2007
             (k:kif-forms-clausify kif-forms)
             (loop for clause across k:*clause-container* do
                  (loop for lit in (kif::clause-val clause) do
                       (with-literal (pred poslit) lit
                         (let ((term (if poslit lit (second lit))))
                           (unless (k:kvar-p pred)
                             (tr:trie-add term (k:clause-index clause)))))))
             (with-slots (vampire-tmp-file) (app-globals)
               (output-for-vampire kif-forms :file vampire-tmp-file))))
      (handler-bind
	  ((error 
	    #'(lambda (err) 
		(pf-format "Error: Problem reading file at line ~A:~%~A"
				 kif::*kif-line* err)
		(with-slots (vampire-stream) (app-globals)
		  (setf vampire-stream nil))
		(return-from vampire-compile-ontology nil))))
	(k:kif-readfile in-file kif-forms)
	(lo-aux)
	(k:kif-export-safe-symbols)
	kif-forms))))

(defvar *vampire-pnum* 0)
(defvar *vampire-responses* (make-hash-table) "Indexed by 'p-number'")

(defun vampire-stop ()
  (with-slots (vampire-stream) (app-globals)
    (when (streamp vampire-stream)
      (close vampire-stream :abort t))))

(defmacro with-error-reporting (&body body)
  `(handler-bind 
    ((error 
      #'(lambda (err) 
	  (pf-format "Error: ~A~%" (format nil "~A" err)))))
    ,@body))

(defun write-kb-components ()
  "Write the components (axioms) to a temporary file, clausify it and write to out-file.
   The components used are:
       -  base.kif
       -  axioms from Part 2
       - initial set"
  (let ((merged-file (pod:lpath :tmp "merged.kb")))
    (with-open-file (s merged-file :direction :output :if-exists :supersede)
      (with-open-file (in (pod:lpath :models "cre/base.kif") :direction :input)
	(loop for line = (read-line in nil nil)
	   while line do (format s "~%~A" line)))
      (loop for template in p7:*initial-set* do 
	   (format s "~% ~A" (p7:template-formal template)))
      (with-open-file (in (pod:lpath :models "cre/kb/part2.kb") :direction :input) ; 2022 as shown above 'axioms from Part 2'
	(loop for line = (read-line in nil nil)
	   while line do (format s "~%~A" line))))
    ;; This will create a file, vampire-tmp-file (/local/tmp/vamp.out).
    (vampire-compile-ontology :in-file merged-file)))

(defun vampire-start ()
  (set-app-globals)
  (vampire-stop)
  (with-slots (vampire-stream vampire-path vampire-tmp-file) (app-globals)
    (setf *vampire-pnum* 0)
    (clrhash *vampire-responses*)
    (write-kb-components)
    (let ((cmd #+win32 (format nil "\"~A\"  \"~A\"" vampire-path vampire-tmp-file)
               #-win32(format nil "~A ~A" vampire-path vampire-tmp-file)))
      (with-error-reporting
	  (if (probe-file vampire-tmp-file)
	    (setf vampire-stream (sys:open-pipe cmd :direction :io))
	    (error "Could not find input."))
	  (sleep 2) ; 2012
	  (unless (and vampire-stream (vampire-ok-p))
	    (error "Vampire failed to start."))))))

;;; POD I'm guessing, based on what is in /local/lisp/cl-xml/cl-xml/code/base/utils.lisp
(defmethod xml-utils::stream-position ((stream system::pty-stream) &optional new)
  (if new
    (file-position stream new)
    (file-position stream)))

(defvar *zippy-response* nil)

#+nil
(defun xml-ok-p ()
  (let ((stream (make-string-input-stream  
"<queryResponse>
  <answer result='no'>
  </answer>
  <summary proofs='0'/>
</queryResponse>
")))
     (handler-bind
	 ((error #'(lambda (err) (declare (ignore err)) nil)))
       (let* ((context (make-instance 'vampire-response-context))
              (response 
	       (setq *zippy-response* 
		     (catch 'vampire-responds
		       (xml-utils:xml-document-parser stream :construction-context context)))))
         (dom:element-p response)))))


(defun vampire-ok-p ()
  "Returns non-nil if the running vampire can answer a query. MIGHT HANG!"
  (with-slots (vampire-stream) (app-globals)
   (when (open-stream-p vampire-stream)
     (loop while (read-char-no-hang vampire-stream nil)) ; discard junk. 
     (format vampire-stream "<query>(or False)</query>~%")
     (finish-output vampire-stream)
     (handler-bind
	 ((error #'(lambda (err) (declare (ignore err)) nil)))
       (let* ((context (make-instance 'vampire-response-context))
              (response 
	       (catch 'vampire-responds
		 (xml-utils:xml-document-parser vampire-stream :construction-context context))))
         (dom:element-p response))))))

#+diag
(defun tryme (cmd)
  (let ((pipe (sys:open-pipe cmd :direction :io)))
    (loop for c = (read-char pipe nil :eof) 
          do (if (eql c :eof) (return-from tryme) (write-char c)))
    (close pipe)))

(defun vampire-ok-p-2 ()
  "Returns non-nil if the running vampire can answer a query."
  (with-slots (vampire-stream) (app-globals)
   (when (open-stream-p vampire-stream)
     (loop while (read-char-no-hang vampire-stream nil)) ; discard junk. 
     (format t "~% after read-no-hang")
     (format vampire-stream "<query>(or False)</query>~%")
     (finish-output vampire-stream)
     (sleep 2)
     (format t "~% after send...~%")
     (loop for c = (read-char-no-hang vampire-stream nil)
           when c do (format t "~A" c)))))


(defun vampire-kill-processes ()
  "Clean up old processes, if any."
  (loop for p in (mp:list-all-processes)
	when (or (search "Vampire IO" (mp:process-name p))
		 (search "XML Cleaner" (mp:process-name p)))
	do (mp:process-kill p)))

;;; Motivation is that when you get a close tag, you throw
(defclass null-construction-context ()
  ())

;;; mystery , from ccts
(defun null-document-parser (source &rest args)
  (apply #'xml-utils:xml-document-parser source
         :construction-context (make-instance 'null-construction-context)
         args))

;;; mystery , from ccts ---  POD what is this?
(defmethod construct-construction-context
           ((context null-construction-context)
            (component t))
  context)

(defclass vampire-response-context (null-construction-context)
  ())

;;; Parse an elment. If it is the top node, throw.
;;; 2022 commented out
#+nil(defmethod xmlp-ignore:|Element-Constructor| ((context vampire-response-context) (content* t) (etag t) (stag t))
  (let ((elem (call-next-method)))
    (if (or (xml-typep elem "queryResponse")
            (xml-typep elem "assertionResponse"))
	(throw 'vampire-responds elem)
      elem)))

(defun vampire-qvar-it (k)
  "Like tr:qvar-it but doesn't care whether or not it is also a kif:variable."
  (cond ((and k (symbolp k))
          (when (char= #\? (char (symbol-name k) 0))
            (setf (get k 'qvar) t))
          (when
              (and (some #'lower-case-p (symbol-name k))
                   (not (equal (find-package :ku) (symbol-package k))))
            (warn "Symbol ~A is not in the KIF Internal package." k)))
        ((consp k)
          (vampire-qvar-it (car k)) (vampire-qvar-it (cdr k))))
  k)

(defun vampire-oos ()
  "Compile ontology and restart if an ontology file changed."
    (asdf:operate 'asdf:load-op :kb))

(defun vampire-tell (orig-form &key (blocking t))
  (vampire-oos)
  (pf-format "~%~A" orig-form)
  (let ((form (kif2vampire (vampire-qvar-it orig-form))))
    (let ((pnum (vampire-send (format nil "<assertion>~A</assertion>" form))))
      (unless blocking (return-from vampire-tell pnum))
      (mp:process-wait "Waiting for Vampire response" #'(lambda () (gethash pnum *vampire-responses*)))
      (let ((response (gethash pnum *vampire-responses*))) 
        (if (xml-typep response "assertionResponse")
          (parse-vampire :assertion-response response)
	  (pf-format "~%Invalid response from vampire-tell: ~A" response))
      pnum))))

(defun vampire-ask (form &key (timeout 30) (bindings-limit 1) (debug-p nil))
  "Toplevel function to send a query to vampire.exe. Called from the GUI editor, for example.
   FORM is a lisp form. Writes results to *proof-stream*
   debug-p = NIL ==> returns VOID.
   debug-p = T ==> no re-loading KIF, no writing to *proof-stream*, return values:
   Returns VOID or values (BINDINGS PNUM) if debugging.
      - BINDINGS is a keyword status or a list of variable bindings.
      - PNUM is a pointer into *vampire-responses*"
  ;(unless debug-p (vampire-oos))
  (vampire-qvar-it form)
  (let ((holds-form (kif2vampire form)))
    (multiple-value-bind (bindings pnum)
	 (vampire-ask-internal holds-form :timeout timeout :bindings-limit bindings-limit)
      (unless debug-p
	(case bindings
	  ((:true :false)
	   (pf-format "Answer: ~A" bindings))
	  ((:timeout :syntax-error)
	     (pf-format "~A~%" bindings))
	  (t ;; show the proof
	   (pf-format "~%Bindings:")
	   (loop for bset in bindings do
		(pf-format "~%(~{~A = ~A~^, ~})"
			   (loop for binding in bset collect (car binding) collect (cdr binding))))
	   (pf-format "~2%Proof:")
	   ;; POD Not yet investigated: Why can't you pprint to *proof-stream* 
	   ;; (write-proof does pprinting. Thus I'm using a string stream here.
	   (with-output-to-string (s)
	      (write-proof (gethash pnum *vampire-responses*) :stream s)
	      (pf-format "~A" (get-output-stream-string s))))))
      (vampire-kill-processes)
      (if debug-p (values bindings pnum) (values)))))
    

(defun vampire-ask-internal (form &key timeout bindings-limit)
  "Call vampire-send with XML <query/>. Wait for response at pnum. Parse result."
  (let ((pnum (vampire-send (format nil "<query timeLimit='~A' bindingsLimit='~A'> ~A </query>" 
                                    timeout bindings-limit form) :timeout timeout)))
    ;(VARS pnum) ; pod keep
    (mp:process-wait "Waiting for Vampire response" #'(lambda () 
							(gethash pnum *vampire-responses*)))
    (let* ((response (gethash pnum *vampire-responses*))
           (bindings (cond ((xml-typep response "queryResponse")
                             (parse-vampire :query-response response))
                           ((xml-typep response "assertionResponse") '(:syntax-error))
                           ((eql response :timeout) '(:timeout))
                           (t response))))
      (values ; POD Clean up this mess!
       (case (car bindings)
         (:true :true)
         (:false :false)
         (:timeout :timeout)
         (:syntax-error :syntax-error)
         (t bindings))
       pnum))))

;;; POD 2012 this stuff (memoizing scanners) not useful.
(defvar *regexp-scanners* (make-hash-table :test 'equal))
(defun wf-scanner (string)
  "Create or return a scanner -- a memoizer, really"
  (or (gethash string *regexp-scanners*)
      (setf (gethash string *regexp-scanners*)
	    (cl-ppcre:create-scanner string))))

(declaim (inline wf-scan))
(defun wf-scan (regexp string)
  (cl-ppcre:scan (wf-scanner regexp) string))

(declaim (inline wf-scan-to-strings))
(defun wf-scan-to-strings (regexp string)
  (mvb (success regs) (cl-ppcre:scan-to-strings (wf-scanner regexp) string)
       (when success regs)))

(defmacro when-scan (regexp &body body)
  `((setf result (wf-scan-to-strings ,regexp (subseq vec iptr)))
    ,@body
    (setf (fill-pointer vec) 0 iptr 0)))

(defun vampire-clean-xml (vstream pipe)
  "The win32 .exe of vampire puts #\> and #\< in CDATA. This replaces them with &GT;, &LT;.
   Empty elements embedded in CDATA not handled. Read from VSTREAM. Write to PIPE."
  (let ((vec (make-array 10024 :adjustable t :fill-pointer 0 :element-type 'character))
	(iptr 0) result)
    (flet ((write-cdata (v)
	    (when v
	      (loop for ch across v do
		    (cond ((char= ch #\<) (princ "*LT;" pipe)) ; POD!!! win32 cl-xml problem????
			  ((char= ch #\>) (princ "*GT;" pipe))
			  (t (write-char ch pipe)))))))
      (macrolet ((scan-for (regexp) 
		 `(setf result (wf-scan-to-strings ,regexp (subseq vec iptr)))))
	(loop for c = (read-char vstream) do  
	      (vector-push c vec)
	      (cond ((scan-for "(<=>)")
                     (write-cdata (aref result 0))
                     (setf (fill-pointer vec) 0 iptr 0))
                    ((scan-for "^(.*)(<.+[^/]>)")  ; CDATA stag -- pod [^/>]+ wrong! was "^(.*)(<[^/>]+>)"
		     (write-cdata (aref result 0))
		     (write-sequence (aref result 1) pipe)
		     (setf (fill-pointer vec) 0 iptr 0))
		    ((scan-for "^(.*)(</[^>]+>)")  ; CDATA etag
		     (write-cdata (aref result 0))
		     (write-sequence (aref result 1) pipe)
		     (setf (fill-pointer vec) 0 iptr 0))
		    ((scan-for "^(.*)(<.+/>)")  ; CDATA empty element
		     (write-cdata (aref result 0))
		     (write-sequence (aref result 1) pipe)
		     (setf (fill-pointer vec) 0 iptr 0))
		    ((scan-for "^(.*\\n)") ; CDATA newline
		     (write-cdata (aref result 0))
		     (setf (fill-pointer vec) 0 iptr 0))
		    ((wf-scan "^\\n" (subseq vec iptr))
		     (terpri pipe)
		     (incf iptr))))))))

(defun vampire-io-not-running-p ()
  (not (find "Vampire IO" (mp:list-all-processes) :test #'search :key #'mp:process-name)))

(defun vampire-send (string &key (timeout 10))
  "Run two processes: One reads the response from vampire and write to a string stream.
   The other xml reads (xml-utils:xml-document-parser) from the string stream."
  (when-bind (vstream (vampire-stream (app-globals)))
    (when (open-stream-p vstream)
      (let* ((pnum (incf *vampire-pnum*))
             (pname (format nil "Vampire IO ~A" pnum))
             (cname (format nil "XML Cleaner ~A" pnum))
	     (pipe (make-instance 'pod:pipe)))
	(loop while (read-char-no-hang vstream nil)) ; discard junk. 
        (mp:process-wait "Wait for other V/IO" #'vampire-io-not-running-p)
	(start-reaper-process pnum timeout)
	; 2012: Is this one needed for Linux copy. I could compile that one???
	(mp:process-run-function 
	 cname nil ;; This one cleans the xml (because we can't fix vampire.exe, no VC++).
	 #'(lambda () 
	     (handler-bind
		 ((error 
		   #'(lambda (err)
			 (format 
			  *proof-stream* 
			  "~%Error in XML correction code:~%~A" err)))))
	       (vampire-clean-xml vstream pipe)))
        (mp:process-run-function
         pname nil ;; This one reads the clean stream as XML.
         #'(lambda ()
	     (handler-bind
		 ((error #'(lambda (err)
			     (format 
			      *proof-stream* 
			      "~%Error parsing XML response from Vampire:")
			     (pf-format "~A" err))))
	       (let ((context (make-instance 'vampire-response-context)))
		 (format vstream "~A~%" string)
		 (finish-output vstream)
		 ;;(loop for line = (read-line pipe nil :eof)
		 ;;      when (eql line :eof) do (return-from vampire-send)
		 ;;      do (format t "~%~A" line))
		 (let ((response 
			(catch 'vampire-responds
			  (xml-utils:xml-document-parser pipe :construction-context context))))
		   (setf (gethash pnum *vampire-responses*) response))))))
	pnum))))

(defun start-reaper-process (pnum timeout)
  (mp:process-run-function  ; Name with subseq so not seen as a V/IO itself
   (format nil "Reaper of process P-~A" pnum) nil
   #'(lambda ()
       (mp:process-wait-with-timeout "Waiting to kill" timeout)
       (flet ((kill-it (name)
	       (when-bind (p (find name (mp:list-all-processes) 
				   :test #'string= :key #'mp:process-name))
			  (mp:process-kill p))))
	 ;; You need to kill these eventually. So kill them, even if there
	 ;; was a response. 
	 (kill-it (format nil "Vampire IO ~A" pnum))
	 (kill-it (format nil "XML Cleaner ~A" pnum))
	 (unless (gethash pnum *vampire-responses*)
	   (setf (gethash pnum *vampire-responses*) :timeout))))))

;;; --------------------- Parse Response -------------------------------------------
(defun clean-text-children (elem)
  (loop for c in (xml-utils:xml-children elem)
        with result = ""
        do (setf result (strcat result (string-trim '(#\Space #\Newline) c)))
     finally (return result)))

(def-parse-vampire (:assertion-response)
    (:self (pf-format "  --  ~A" (clean-text-children dself))))

;;; ---------
            
(def-parse-vampire (:query-response)
;    (:self 
;     (let ((child (car (children dself))))
;       (when (and (stringp child)
;                  (search "Syntax error detected" child))
;         (return-from parse-vampire '(:syntax-error)))))
    (:append "answer"))

(def-parse-vampire (:answer "result")
    (:self (cond ((xml-find-child "bindingSet" dself)
                   (loop for c in (xml-utils:xml-children dself)
                      when (xml-typep c "bindingSet") append 
                        (parse-vampire :binding-set c :response response)))
                 (t (cond ((string= result "yes") (list :true))
                          ((string= result "no") (list :false))
                          (t (list :unexpected-response)))))))

(def-parse-vampire (:binding-set)
  (:collect "binding"))

(def-parse-vampire (:binding)
  (:collect "var"))

(def-parse-vampire (:var "name" "value")
  (:self (let ((var (intern (string-upcase (string name))))
               (val (k:kif-read-from-string (string value)))) ; 2012 was kif-readstring
           (setf (get var 'tr::qvar) t)
           (cons var val))))

(defun write-proof (arg &key (stream *standard-output*) query-form)
  "Write the proof to STREAM."
  (let ((steps (proof-preprocess arg))
        (negated-query `(ku:|not| ,query-form)))
    (pprint-symbols 
      (loop for step in steps do
           (with-slots (step-num premises conclusion) step
	       (format stream "~%~a [~{~A~^,~}]" 
		       step-num
		       (loop for i from 1 to (1- step-num)
			     for upstep in steps
			     if (member (conclusion upstep) premises :test #'equal)
			     collect i into result
			     else if (equal conclusion negated-query) return '("Negated Query")
			     finally (return (or result '(KB)))))
	       (pprint conclusion stream))))))

(def-preprocess (:premises) (:append "premise"))
(def-preprocess (:premise) (:self (clause-formula-internal dself)))
(def-preprocess (:conclusion) (:self (clause-formula-internal dself)))
(def-preprocess (:clause)  (:self (preprocess-internal dself)))
(def-preprocess (:formula) (:self (preprocess-internal dself)))
(defun preprocess-internal (elem)
  (when-bind (text (xml-find-string-child elem))
    (remove-holds-everywhere
     (k:kif-read-from-string ; 2012 was kif-readstring
      (substitute-string 
       ">" "*GT;" 
       (substitute-string
        "<" "*LT;" text))) t)))
(defun clause-formula-internal (elem)
  (loop for c in (xml-utils:xml-children elem) ; only one of these... or FALSE
     when (xml-typep c "clause") collect (parse-proof-preprocess :clause c)
     when (xml-typep c "formula") collect (parse-proof-preprocess :formula c)))

(defclass proof-step ()
  ((step-num :initarg :step-num)
   (premises :initarg :premises :reader premises)
   (conclusion :initarg :conclusion :reader conclusion)))

(defun proof-preprocess (qresponse &aux (step 0))
  "Remove steps that only identify clauses identical to an atomic formula, and 
   number remaining clauses."
  (loop for pstep in (xml-find-children 
		      "proofStep" 
		      (xml-find-child "proof" (xml-find-child "answer" qresponse)))
	for premises =  (parse-proof-preprocess :premises (xml-find-child "premises" pstep))
	for conclusion = (car (parse-proof-preprocess :conclusion (xml-find-child "conclusion" pstep)))
	unless (and premises (not (cdr premises)) (equal (car premises) conclusion))
	collect (make-instance 'proof-step :step-num (incf step)
			       :premises premises :conclusion conclusion)))

;;;====================================================================================
;;; Diagnostics
;;;====================================================================================
;;; Example: (vampire-proof (kif:kif-readstring "(parent peter ?x)")) when loaded tclosure.kif
(defun vampire-proof (form &key (timeout 20))
  "A command-line diagnostic function to ask FORM, print result to *standard-output*."
  (mvb (bindings pnum) (vampire-ask form :timeout timeout :debug-p t)
      (let ((response (gethash pnum *vampire-responses*)))
	(VARS response pnum)
        (if (xml-typep response "queryResponse")
          (write-proof response :query-form form)
          bindings))))

;;;====================================================================================
;;; Stuff to output to Vampire tmp/vamp.out
;;;====================================================================================
;;; (domain |confersNorm| 2 |Formula|)  --> 2
(defvar *domain-is-formula* -1) ; -1 so if not set, error.

(defun kif2vampire (form)
  (setf form (bq-formula form t))
  (setf form (stick-holds-everywhere form t))
  (vampire-translate-relations form t))

(defmemo kif-subrelations (relation-name)
  "Returns a list of the recursive subrelations of the argument."
  (labels ((sr-aux (name &optional accum)
             (let ((stypes (mapcar #'second (tr:trie-query-all `(ku::|subrelation| ?x ,name)))))
		(cond ((null stypes) nil)
		      (t 
		       (append accum
			       stypes
			       (mapappend #'sr-aux stypes)))))))
    (if (or (k:kvar-p relation-name) (consp relation-name) (typep relation-name 'k::skolem-fn))
      nil
      (remove-duplicates (sr-aux relation-name)))))

(defmemo bq-positions (pred)
  (let (positions)
    (loop for domain in *domain-is-formula* 
          when (eql pred (second domain)) do (push (third domain) positions))
    (unless positions
      (loop for domain in *domain-is-formula* do
           (loop for subrel in (kif-subrelations (second domain))
                 when (eql subrel pred) do (push (third domain) positions))))
    positions))
                  
;;; (bq-formula '(=> (p ?x ?y) (|confersNorm| ?x (something ?y))) t)   -- one backquote
;;; (bq-formula '(=> (p ?x ?y) (|entails| ?x (something ?y))) t)       -- two backquotes
(defun bq-formula (form pred-p)
 "Backquote formula arguments to relations."
 (flet ((bq-pos (form pos)
          (if (pred-p (car (subseq form pos)))
            (append (subseq form 0 pos) (list (list 'quote (nth pos form))) (subseq form (1+ pos)))
            form)))
   (let (positions)
     (cond ((atom form) form)
           ((and pred-p 
                 (setf positions (bq-positions (car form))))
             (loop for pos in positions 
                   for newform = (bq-pos form pos) then (bq-pos newform pos)
                   finally (return newform)))
           (t 
             (reuse-cons (bq-formula (car form) t)
                         (bq-formula (cdr form) (pred-p (second form)))
                         form))))))

;;; (stick-holds-everywhere '(=> (a ?x y) (|and| (b ?x) (quote (c ?y)))) t)
;;;                         '(=> (holds a ?x y) (and (holds b ?x) (quote (c ?y))))
;;; (stick-holds-everywhere '(=> (|exists| (?x ?y) (|and| (b ?x) (quote (c ?y)))) (d ?x)) t)
;;;                          (=> (|exists| (?X ?Y) (|and| (|holds| B ?X) (QUOTE (C ?Y)))) (|holds| D ?X))
;;; (stick-holds-everywhere '(|lessThan| 3 4) t)
(defun stick-holds-everywhere (form pred-p) ; <============================== !!!
  "Distinguish predicates from functions by wrapping the predicates in 'holds'."
  (if (atom form)
    form
    (let ((pred (car form)))
      (cond ((eql pred 'quote) form)
            ((and pred-p
                  (or (eql pred '|exists|)
                      (eql pred '|forall|)))
              (list pred (second form)
                    (stick-holds-everywhere (third form) t)))
            ((and pred-p
                  (atom pred)
                  (not (member pred +logical-symbols+))
                  (not (member pred +relation-symbols+))
                  (not (member pred +arithmetic-symbols+))
                  (not (member pred '(< > <= >=)))
                  (not (eql pred 'ku::|holds|)))
              (cons 'ku::|holds| form))
            (t
              (reuse-cons (stick-holds-everywhere (car form) pred-p)
                          (stick-holds-everywhere (cdr form) (pred-p (second form)))
                          form))))))

(defun remove-holds-everywhere (form pred-p)
  "Tries to undo what stick-holds-everywhere does"
  (cond ((atom form) form)
        ((and pred-p (eql (car form) 'ku::|holds|)) (cdr form))
        (t
          (reuse-cons (remove-holds-everywhere (car form) pred-p)
                      (remove-holds-everywhere (cdr form) (pred-p (second form)))
                      form))))
  
(defun vampire-translate-relations (form pred-p)
  "Translate a relation symbol if it is in the predicate symbol position (car)."
    (cond ((null form) nil)
	  ((atom form) (if-bind (val (and pred-p (numeric-rel-p form))) val form))
	  (t (reuse-cons
	      (vampire-translate-relations (car form) pred-p)
	      (vampire-translate-relations (cdr form) (pred-p (second form)))
	      form))))

(defun numeric-rel-p (val) 
  "If it is |lessThan| return the symbol <, etc."
  (when-bind (which (find val +inequality-symbols+))
    (case (position which +inequality-symbols+)
      (0 '<) (1 '>) (2 '<=) (3 '>=))))

;;(=>
;;   (and
;;      (disjointRelation @ROW)
;;      (inList ?REL (ListFn @ROW)))
;;   (instance ?REL Relation))
;;; When there is more than one row variable in the formula, I only generate
;;; formula with equal numbers of the corresponding variables. 
(defun expand-rows (form)
  (if-bind (rows (k:kif-collect-rowvars form))
    (let* ((urows (k:relative-unique-vars (length rows) :name "?ROW~A-"))
           (replmts (mapcar #'(lambda (u) (k:var-versions u 4)) urows)))
      (loop for i from 1 to 4
         for newform = (copy-tree form) collect
           (loop for row in rows
              for replmt in replmts
              do (setf newform (replace-row newform row (subseq replmt 0 i)))
              finally (return newform))))
    (list form)))

(defun replace-row (form row replmt)
  (flet ((rr-internal (f)
           (if (atom f)
             f
             (loop for elem in f
                if (eql row elem) append replmt
                else append (list elem)))))
    (cond ((atom form) form)
          (t (cons ; reuse-cons makes it worse. ???
              (replace-row (rr-internal (car form)) row replmt)
              (replace-row (rr-internal (cdr form)) row replmt))))))

(defmacro pprint-with-strings (&body body)
  `(unwind-protect 
       (progn 
         (set-pprint-dispatch 'string #'(lambda (s x) (let ((*print-pretty* nil)) (format s "~S" x))))
         ,@body)
    (set-pprint-dispatch 'string nil)))

(defmethod output-for-vampire ((forms k:kif-forms) &key file)
  (VARS file)
  (mapcar #'clear-memoize '(bq-position kif-superrelations kif-subrelations kif-superclasses))
  (setf *domain-is-formula*
          (remove-if #'(lambda (x) (member (second x) +logical-symbols+))
                     (tr:trie-query-all `(ku::|domain| ?x ?y ku::|Formula|))))
  (let ((*print-pretty* t))
    (with-slots (k:forms-ht k:lines-read) forms
      (with-open-file (stream file :direction :output :if-exists :supersede)
        (pprint-with-strings 
          (loop for i from 1 to k:lines-read
             for axiom = (gethash i k:forms-ht)
             when (and axiom (not (eql 'ku::|documentation| (car axiom)))) do
               (loop for row-axiom in (expand-rows axiom) do
                    (let ((str (substitute #\` #\' (format nil "~A" (kif2vampire row-axiom)))))
                      (let ((*print-pretty* nil))
                        (format stream "~2%~A" str))))))))))

;;;==========================================================
;;; SBCL Stuff
;;;==========================================================
#+sbcl(defparameter *buf* (make-array 120 :element-type 'character :fill-pointer t))

#+sbcl
(defun tryme ()
  (setf (fill-pointer *buf*) 0)
  (with-output-to-string (out *buf*)
    (with-input-from-string (in *buf*)
      (let ((two (make-two-way-stream in out)))
        (format two "<query timeLimit='30' bindingsLimit='1'> (holds instance ?X Relation) </query>~%")
        (sb-ext:run-program *reasoner-path* *reasoner-args* :pty two :wait t)
        (break "here")
        (loop for line = (read-line two nil :eof)
             until (eql line :eof) do
             (format t "~% ~A" line))))))

#+sbcl(defvar *buffer-lock* (make-mutex :name "reasoner buffer lock"))
#+sbcl(defvar *buffer-queue* (make-waitqueue))

#+sbcl
(import '(sb-gray:fundamental-character-input-stream 
          sb-gray:fundamental-character-output-stream
          sb-gray:stream-listen))

#+sbcl
(defclass reasoner-stream (fundamental-character-input-stream
                           fundamental-character-output-stream)
  ((cbuf :reader cbuf :initform (make-array 1024 :element-type 'character :adjustable t))
   (read-ptr :accessor read-ptr :initform 0)
   (write-ptr :accessor write-ptr :initform 0)))

#+sbcl
(defmethod sb-gray:stream-read-char ((s reasoner-stream))
  (with-slots (read-ptr write-ptr) s
    (with-mutex (*buffer-lock*)
      (when (= read-ptr write-ptr) (return))
      (with-slots (cbuf) s
        (princ ; debuggin
         (prog1 (char cbuf read-ptr)
           (if (= read-ptr 1023) (setf read-ptr 0) (incf read-ptr))))))))

#+sbcl(defmethod sb-gray:stream-write-char ((s reasoner-stream) (c character)))

#+sbcl
(defmethod sb-gray:stream-write-string ((s reasoner-stream) str &optional start end)
  (declare (ignore start end)) ; pod nyi 
  (loop for i from 0 to (1- (length str))
     do (sb-gray:stream-write-char s (char str i))))

#+sbcl
(defmethod stream-listen ((s reasoner-stream))
  (with-slots (read-ptr write-ptr) s
    (with-mutex (*buffer-lock*)
      (not (= read-ptr write-ptr)))))



;;; 2012 Here is what the call to ASK looks like in MIV:
#+nil
(defun tryme-ask (form-text)
  (handler-bind
      ((error 
	#'(lambda (err) 
	    (declare (ignore err))
	    (v:with-hilites (v:*proof-stream*)
	      (v:pf-format "<color background='red'>Syntax Error:</color> ~A~%" form-text))
	    (return-from asking))))
    (setf form (kif:kif-readstring form-text)))
  (v:with-hilites (v:*proof-stream*)
    (v:pf-format "<color foreground='blue'>~%Ask: ~A~%</color>" form))
  (loop for p in (mp:list-all-processes) 
     when (string= (mp:process-name p) "Vampire ask") 
     do (mp:process-kill p))
  ;; POD Without the prf, the previous line of output appears late.
  (mp:process-run-function 
   "Vampire ask" nil  
   #'(lambda ()
       (v:vampire-ask form :timeout (md-value (unique-widget :timeout))
		      :bindings-limit (md-value (unique-widget :bindings-limit))))))
