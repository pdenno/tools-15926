
(in-package :emm)

;;; Date: 2007-01-17 
;;; Purpose: Continuation of mm/lisp-gen.lisp for Express-X objects.

(defvar *mapping-schema-name* nil "the interned name of the schema")

;;; (map-lisp sss :source-path "/home/pdenno/repo/dodaf/mechatronics/whatever.exx" :out-path "~/junk.lisp")
(defmethod map-lisp ((schema |MappingSchema|) &key source-path out-path)
  "Toplevel routine to output lisp for an instance of the express metamodel. 
   SCHEMA is an |Schema| MM instance. PATHNAME names the file that will be produced."
  (with-open-file (stream out-path :direction :output :if-exists :supersede)
    (mm2lisp schema :stream stream :source-path source-path)))

(defmethod mm2lisp ((schema |MappingSchema|) &key stream source-path)
  (let ((*package* (find-package (mofi:lisp-package (schema *expresso*)))))
    (mm2lisp :x-prologue :stream stream :source-path source-path)
    (loop for iface in (%interfaced-elements schema) do
	  (pprint iface stream)
	  (terpri stream))
    (loop for type in '(|MapSpec| |Function|)
	  with schema-name = (%name schema) do
	  (setf *mapping-schema-name* schema-name)
	  (format stream "~3%;;;=================" type)
	  (format stream "~%;;; ~As" type)
	  (format stream "~%;;;=================")
	  (loop for e in (%schema-elements schema)
		when (typep e type) do 
		;(VARS e) (setf *zippy* e)
		(mm2lisp e :stream stream :schema-name schema-name)
		(terpri stream)))
    (format stream "~2%;;; END OF OUTPUT")))

(defmethod mm2lisp ((obj (eql :x-prologue)) &key source-path stream)
  (format stream ";;; -*- Mode: Lisp; -*-~2%")
  (format stream ";;; File created by ~A~%" (ee-version))
  (format stream ";;; Date  created: ~A~%" (now))
  (format stream ";;; Compilation of ~A~2%" source-path)
  (format stream "(in-package :expresso-user)~%")
  (pprint ; POD when |Schema| and expo:schema are merged, this stuff can be stored in |Schema|
   `(setf (expo::schema expo::*expresso*)
     (ensure-schema 'expo::map-schema
      :name ,(string-upcase (string p14p:*this-schema*))
      :interned-name ',(intern p14p:*this-schema* (mofi:lisp-package (schema *expresso*)))
      :schema-pathname ,source-path)) stream)
  (terpri stream)
  (pprint
   '(with-slots (expo::views expo::view-infos expo::maps expo::map-infos) 
     (expo:schema expo::*expresso*)
     (setf expo::views nil)
     (setf expo::view-infos nil)
     (clrhash expo::maps)
     (clrhash expo::map-infos)) stream))

(defmethod mm2lisp ((obj |MapSpec|) &key stream ref-only-p 
		    (schema-name *mapping-schema-name*))
  (unless (or stream ref-only-p) (error "Specify stream here."))
  (with-slots (|id| |dependent-p| |subtypeOf| |targets| |partitions|) obj
    (let ((n2i (name2initials schema-name)))
      (if ref-only-p
	  (intern (format nil "~A.~A" n2i (%local-name |id|))
		  (mofi:lisp-package (schema *expresso*)))
	  (pprint
	   `(defmap ,(intern (format nil "~A.~A" n2i (%local-name |id|))
			     (mofi:lisp-package (schema *expresso*)))
	     ,|dependent-p|
	     ,(when |subtypeOf| (intern (format nil "~A.~A" n2i (%local-name (%id |subtypeOf|)))
					(mofi:lisp-package (schema *expresso*)))			
	     ,(mapcar #'mm2lisp |targets|)
	     ,@(mapcar #'mm2lisp |partitions|))
	   stream)))))

; (funcall-map 'ap2i.reqmnt_view_def_map nil 'ap2i.rvd x-eval (%relating_view ap2i.srcr nil))
(defmethod mm2lisp ((obj |MapCall|) &key)
  (with-slots (|invokes-function| |partition| |access-parameter| |actual-parameters|) obj
    `(expo:funcall-map ',(mm2lisp |invokes-function| :ref-only-p t)
      ,|partition| 
      ',(mm2lisp |access-parameter|) eu::x-eval ,@(mapcar #'mm2lisp |actual-parameters|))))

; nyi Should it be?
;(defmethod mm2lisp ((obj |TargetReference|) &key)
;  (euintern (%name obj)))

(defmethod mm2lisp ((obj |TargetVariable|) &key)
  (with-slots (|id| |variable-type|) obj
    `(,(list (intern (format nil "~A.~A" ; don't use mm2lisp ScopedId here, prefix will be nil.
			     (schema2short-name (schema-scope (%defining-scope |id|)))
			     (%local-name |id|))
		     (mofi:lisp-package (schema *expresso*)))
      ,(intern (schema2alias p14p:*target-schema*) (mofi:lisp-package (schema *expresso*)))
      :scalar ; pod :vector/:scalar
      ,(list (intern (%local-name (%id |variable-type|))
		     (mofi:lisp-package (schema *expresso*))))))))

(defmethod mm2lisp ((obj |SourceParameter|) &key)
  (with-slots (|id| |formal-parameter-type|) obj
    `(,(mm2lisp |id| :prefix-map t) 
      ,(unless 
	(and (symbolp |formal-parameter-type|)
	     (member |formal-parameter-type| 
		     '("number" "real" "integer" "string" "boolean" "logical")
		     :test #'string-equal))
	(schema2alias p14p:*source-schema*))
      ,(if (symbolp |formal-parameter-type|) ; symbols if STRING etc. (depmap).
	   |formal-parameter-type|
	   (intern (%local-name (%id |formal-parameter-type|))
		   (mofi:lisp-package (schema *expresso*))))))) ; pod ???

(defmethod mm2lisp ((obj |Partition|) &key)
  (with-slots (|id| |sources| |localVars| |ordering| |alternateId| |predicate| |blocks|) obj
    `(,(if |id| |id| 'eu::default-partition)
      :sources ,(mapcar #'mm2lisp |sources|) ; of type |SourceParameter|
      :local ,|localVars|
      :predicate ,(if |predicate| 
		      `(and ,@(mapcar #'(lambda (d) (mm2lisp (%asserts d))) |predicate|))
		      t)
      :identified-by ,|alternateId|
      :ordered-by ,|ordering|
      :project ,(mapappend #'mm2lisp |blocks|)))) ; of type |SelectBlock|

(defmethod mm2lisp ((obj |SelectBlock|) &key)
  (mapcar #'mm2lisp (%statements obj)))


(defmethod mm2lisp ((obj |MappingAssignmentStatement|) &key)
 `(setf ,(mm2lisp (%place-reference obj)) 
   ,(let ((exp (%expression obj)))
	 (if (listp exp) exp (mm2lisp exp)))))

;;; POD Is this really used? Should it be in p11/lisp-gen.lisp
(defmethod mm2lisp ((obj |Identifier|) &key prefix-map)
  (let ((name (%local-name obj)))
    (cond (prefix-map 
	   (setf name (intern (format nil "~a.~a" p14p::*this-schema-abbrev* name)
			      (mofi:lisp-package (schema *expresso*)))))
	  (t name))))

(defmethod mm2lisp ((obj |ForEachExpression|) &key)
  (with-slots (|variable| |aggregate-operand| |select-condition| |return-expression|) obj
      `(make-instance 'expo:express-bag
	:type-descriptor 
	(make-instance 'expo:bag-typ :l-bound 0 :u-bound :? :base-type t)
	:value (loop eu::for ,(mm2lisp |variable|)
		eu::in (expo::express-agg2lisp-list ,(mm2lisp |aggregate-operand|))
		eu::when ,(cl:if (null |select-condition|) t `(and ,@(mm2lisp |select-condition|)))
		eu::collect ,(mm2lisp |return-expression|)))))


