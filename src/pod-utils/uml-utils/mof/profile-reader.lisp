
;;; PURPOSE: Read an XMI 2.1 Profile into tries. (Essentially, read a hierarchical 
;;;   model and generate a relational one.)
;;;   Then use the relational model to pprint a CLOS-based model specialized by 
;;;   MOP to have UML profile characteristics.

;;; 2010-09-01 : Compiler directive #+sysmlp comments out stuff that worked fine today
;;;              creating the sysml profile, but isn't helpful in generating the UML L2 profile.
;;; 2008-02-18 : This was updated to the new architecture.
;;; 2008-03-14 : I now print the extended metaclasses (the base_ things) 
;;;              separate from the generalization (a reference to another stereotype, if any).

(in-package :mofi)

(defgeneric parse-profile (elem-type dself &key model &allow-other-keys))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-parse-profile (&rest args)
    `(pod:def-parse parse-profile package ,@args)))

;;; (process-pro :profile-name :sysml 
;;;              :in-file (lpath :data "ysml12/sysml1-2-ptc20100301-v5/sysml-profile.xmi")
;;;              :out-file (lpath :models "sysml/sysml-profile-new.lisp")) 
;;; (process-pro :profile-name :uml-profile-l2 
;;;              :in-file  (lpath :data "std-uml-profiles;10-08-22-uml-l2-profile.xmi")
;;;              :out-file (lpath :models "uml/uml-std-profile-l2.lisp"))
(defun process-pro (&key profile-name in-file out-file uml-xml)
  "Toplevel function to produce the SYSML meta-model file."
  (let* ((doc (or uml-xml (xml-document-parser in-file)))
	 (profile (xml-find-child "Profile" (xml-children doc))))
    (setf *mmm* doc)
    (ensure-trie-db :profile-db) ; clears it too.
    (with-trie-db (:profile-db)
      (tr:clear-tries) ; POD might need to fix reslist function for multi-DB
      (parse-profile :profile profile)
      (when out-file (pprint-mm :profile :pname profile-name :file out-file :in-doc in-file)))))

(defun strip-url (url)
  "Example for http://schema.omg.org/spec/UML/2.1/StandardProfileL2.xmi#Trace return |Trace|"
  (second (split (string url) #\#)))

(def-parse-profile (:profile)
  ("packagedElement"))

(def-parse-profile (:packaged-element "type")
  (:self (parse-profile type dself))) ; Specializes on an attribute!

(defparameter *found* nil)

(def-parse-profile ('|uml:Stereotype| "id" "name")
  (:self (trie-add `(stereotype ,name))) ; tc3-profile (was id, everywhere)
  ("ownedAttribute" :stereo-id name)
  ("ownedRule" :stereo-id name)
  ("generalization" :stereo-id name))

;;; Added for tc3-profile.xmi
(def-parse-profile ('|uml:Association|)
    (:self nil))

;;; All ownedAttributes are type="uml:Property". 
;;; This "profile" is pure shit! There is no pattern to how information is encoded.
;;;  - If the oA has an "association" assume it is one by that name
(def-parse-profile (:owned-attribute "isDerived" "name" "association" &key stereo-id)
  (:self 
   ;; attr-name not here if have an association. 
   (unless association (trie-add `(stereotype.attribute ,stereo-id ,name)))
   (when is-derived (trie-add `(stereotype.attribute-is-derived ,stereo-id ,name)))
   (when-bind (type (other-type-attr dself))
	      (trie-add `(stereotype.attribute.type ,stereo-id ,name ,type))))
  ("type" :stereo-id stereo-id :attribute-id name :base association)
  ("lowerValue" :stereo-id stereo-id :attribute name)
  ("upperValue" :stereo-id stereo-id :attribute name))

(def-parse-profile (:type "href" &key stereo-id attribute-id base)
  (:self 
   (if base
       (trie-add `(stereotype.base-class ,stereo-id ,(strip-url href))) ;L2 doing this
     (trie-add `(stereotype.attribute.type ,stereo-id ,attribute-id ,(strip-url href))))))

;;; Some of these also have a value="*" attribute. But is in perfect
;;; correspondence to type="umlLiteralUnlimitedNatural" ?
(def-parse-profile (:upper-value "value" &key stereo-id attribute)
  (:self 
   (when (eql value '*) (setf value -1))
   (when value
     (trie-add `(stereotype.attribute.multiplicity-upper.value ,stereo-id ,attribute ,value)))))

(def-parse-profile (:lower-value "value" &key stereo-id attribute)
  (:self 
   (when value ; never happens...but
     (trie-add `(stereotype.attribute.multiplicity-lower.value ,stereo-id ,attribute ,value)))))

;;; Note that the superclass could be in either an attr or child elem!
(def-parse-profile (:generalization "general" &key stereo-id)
  (:self 
   (when general
     (trie-add `(stereotype.generalization ,stereo-id ,general))))
  ("general" :stereo-id stereo-id))

(def-parse-profile (:general "href" &key stereo-id)
  (:self (trie-add `(stereotype.generalization ,stereo-id ,(strip-url href)))))


(def-parse-profile (:owned-rule "id"  "name" &key stereo-id)
  (:self 
   (when name (trie-add `(rule.name ,stereo-id ,id ,name)))
   (trie-add `(stereotype.rule ,stereo-id ,id)))
  ("specification" :rule-id id) 
  ("ownedComment" :id id))

(def-parse-profile (:specification &key rule-id)
  ("language" :rule-id rule-id)
  ("body" :rule-id rule-id))

(def-parse-profile (:language &key rule-id)
  (:self
   (unless (equal "OCL" (string-trim '(#\Space) (car (xml-children dself))))
     (warn "Language is not OCL: ~A" rule-id))))

(def-parse-profile (:body &key comment-id rule-id)
  (:self
   (if comment-id
       (trie-add ; Swap #\' for #\" for easier printing later
	`(comment ,comment-id ,(substitute #\' #\" (car (xml-children dself)))))
     (trie-add
      `(rule.body ,rule-id ,(car (xml-children dself)))))))

(def-parse-profile (:owned-comment &key id)
  ("body" :comment-id id))

(def-parse-profile ('|uml:Enumeration| "name")
  (:self (trie-add `(enumeration ,name)))
  ("ownedLiteral" :enum-id name))

(def-parse-profile (:owned-literal "id" "name" &key enum-id)
  (:self (trie-add `(enumeration.literal ,enum-id ,id ,name))) ; need catkey to match comment
  ("ownedComment" :id id))

(def-parse-profile ('|uml:Extension|)
  (:self nil))

;;;================================================
;;; Pretty Printing
;;;================================================
(defmethod pprint-mm ((type (eql :profile)) &key file pname in-doc)
  (with-open-file (s file :direction :output :if-exists :supersede)
    (pprint-mm :profile-prologue :stream s :pname pname :in-doc in-doc)
    (pprint-mm :profile-enums :stream s :pname pname)
    (pprint-mm :profile-classes :stream s :pname pname)
    (pprint-mm :profile-epilogue :stream s :pname pname)))

(defmethod pprint-mm ((type (eql :profile-prologue)) &key stream pname in-doc)
  (format stream ";;; Automatically generated from the profile-reader on ~A" (now))
  (format stream "~%;;; From XMI file ~A" (truename in-doc))
  (format stream "~%;;; Do not edit.")
  (format stream "~%(in-package ~S)" pname))

(defmethod pprint-mm ((type (eql :profile-epilogue)) &key stream)
  (format stream "~2%;;; End of Output"))

(defmethod pprint-mm ((type (eql :profile-enums)) &key stream pname)
  (loop for enum-id in (mapcar #'second (trie-query-all `(enumeration ?id))) do
	(if-bind (comment (third (trie-query `(comment ,enum-id ?comment))))
	 (format stream "~%~{~%;;; ~A~}" 
		 (mapappend #'(lambda (l) (split l #\Space :min-size 70))
			    (split comment #\Newline)))
	 (terpri stream))
	(format stream "~%(def-mm-enum ~S~% ~S () (" enum-id pname)
	(loop for val in 
	      (sort (mapcar #'fourth (trie-query-all `(enumeration.literal ,enum-id ?lit-id ?val)))
		    #'string<)
	      for i from 1 
	      when (zerop (mod i 5)) do (format stream "~%   ")
	      do (format stream "~S " val))
	(format stream "))")))

(defmethod pprint-mm ((type (eql :profile-classes)) &key stream pname)
  "Print the def-stereotype s-expressions."
  (let ((sorted (sort (mapcar #'second (trie-query-all '(stereotype ?id))) #'string<)))
    (loop for class-id in sorted do 
	  (format stream "~3%(def-mm-stereotype ~S ~S ~S ~A" 
		  class-id pname
		  (mapcar #'third (trie-query-all `(stereotype.generalization ,class-id ?super)))
		  (format nil "(~{uml23:|~A| ~})"
			  (mapcar #'third (trie-query-all `(stereotype.base-class ,class-id ?super)))))
	  (if-bind (comment (third (trie-query `(comment ,class-id ?comment))))
		   (format stream "~% \"~{~A~^~%  ~}\"" 
			   (mapappend #'(lambda (l) (split l #\Space :min-size 70))
				      (split comment #\Newline)))
		   (format stream "~% \"\""))
	  (pr-slots :profile stream class-id)
	  (format stream ")")
	  (pprint-mm :constraint :stream stream :id class-id)
	  (pprint-mm :operation :stream stream :id class-id))))

(defmethod pr-slots ((type (eql :profile)) s class-id)
  "Print the slot s-expressions for def-mm-class."
  (format s "~% (")
  (loop for slot in ; sort slots alphabetically
	(sort (mapcar #'third (trie-query-all `(stereotype.attribute ,class-id ?attr-id))) #'string<) do
        (format s "~%  (~S :range |~A| :multiplicity (~A ~A)~%   :documentation~%   \"~{~A~^~%    ~}\")"
		slot
		(fourth (trie-query `(stereotype.attribute.type ,class-id ,slot ?type))) ;range
		0 ;mult-l
		(or (fourth (trie-query `(stereotype.attribute.multiplicity-upper.value ,class-id ,slot ?val))) 1) ;mult-u
		(split (comment-of slot) #\Space :min-size 70)))
  (format s ")"))

(defun comment-of (slot-id)
  "Return the comment on class CLASS, slot SLOT. Slot is an attribute, not association."
  (or (third (trie-query `(comment ,slot-id ?comment))) ""))

(defun other-type-attr (elem)
  "Find an attribute of ELEM named 'type' in the package whose name is a null string.
   (All this extra work because there is also an xmi:type attribute.)"
   (when-bind (type-attr (find-if #'(lambda (x) 
				      (and (typep x 'xmlu:string-attr-node)
					   (when-bind (name (slot-value x 'xml-name))
					     (and (equal (string name) "type")
						  (eql (find-package "") (symbol-package name))))))
				  (xml-attributes elem)))
     (car (xml-children type-attr))))

#|
(defvar *profile-constraints/operations* (make-hash-table) 
  "indexed by class name, value is a list of uml-constraint objs.")

(defmethod pprint-mm ((type (eql :profile-ocl2lisp)) &key (file #P"expo:uml;sysml;profile-constraints-new.lisp"))
  "Used to generate the lisp-based ocl. Load the profile to set the global variables it uses."
  (pprint-mm :ocl2lisp 
	     :file file
	     :classes *profile-classes*
	     :constraints *profile-constraints/operations*))
|#








