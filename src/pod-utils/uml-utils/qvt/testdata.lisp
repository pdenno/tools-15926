
(in-package :qvt)

#|
;;; Purpose: Hand-generated source schema population for demonstration.

The way I have things now, instances will get pushed on to the object-extents HT 
of the users VO. The model made must be of a type that knows that this is where
it gets its instances and that it is 'all about instances' -- not classes. 


Target Schema:

 (process-uml "SimpleRDBMS" #P"moss:qvt;examples;uml2rdbms;simplerdbms.mdxml" 
               :classes-path #P"moss:qvt;schemas;simpledbms.lisp"
               :instance-install-fn 'qvt::qvt-install-instance)

Source Schema: 

 (process-uml "SimpleUML" #P"moss:qvt;examples;uml2rdbms;simpleuml.mdxml" 
               :classes-path #P"moss:qvt;schemas;simpleuml.lisp"
               :instance-install-fn 'qvt::qvt-install-instance)

 (process-uml "MOSScm" "/home/pdenno/moss/source/ontology/moss.mdxml"
               :classes-path #P"moss:qvt;schemas;moss-cm.lisp"
               :instance-install-fn 'qvt::qvt-install-instance)


(qvt-load)
(makeit)

(qvt-go '|umlToRdbms|::|umlToRdbms|)

|#

(defun make-demo-data ()
  "Make test data for the umlToRdbms demo"
  (let ((population (mofi:ensure-model "SimpleUMLdata" :force t
				       :model-class 'mofi:population
					;:instance-install-fn 'qvt::qvt-install-instance
				       :model-n+1 (mofi:find-model "SimpleUML"))))
    ;; Create instances. Bind *population* so that the initialize-instance on mm-root-supertype
    ;; knows which instance-install-fn to use. You can bind to *ANY* model that has 
    ;; Model.instance-install-fn = 'qvt::qvt-install-instance. 
    (let ((mofi:*population* population))
      (let* ((p     (make-instance '|SimpleUML|::|Package| :name "P1" :kind "Persistent"))
	     (int   (make-instance '|SimpleUML|::|PrimitiveDataType| :name "STRING"))
	     (bool  (make-instance '|SimpleUML|::|PrimitiveDataType| :name "BOOLEAN"))
	     (c1-a1 (make-instance '|SimpleUML|::|Attribute| :name "C1-A1" :kind "Persistent" :type int))
	     (c1-a2 (make-instance '|SimpleUML|::|Attribute| :name "C1-A2" :kind "Persistent" :type bool))
	     (c1-a3 (make-instance '|SimpleUML|::|Attribute| :name "C1-A3" :kind "Persistent" :type int))
	     (c2-a1 (make-instance '|SimpleUML|::|Attribute| :name "C2-A1" :kind "Persistent" :type bool))
	     (c3-a1 (make-instance '|SimpleUML|::|Attribute| :name "C3-A1" :kind "Persistent" :type int))
	     (c1 (make-instance '|SimpleUML|::|Class| :name "C1" :kind "Persistent"
				:attribute (make-instance 'ocl:|Set| :value (list c1-a1 c1-a2 c1-a3))
				:namespace p))
	     (c2 (make-instance '|SimpleUML|::|Class| :name "C2" :kind "Persistent" 
				:attribute (make-instance 'ocl:|Set| :value (list c2-a1))
				:general (make-instance 'ocl:|Set| :value (list c1))
				:namespace p))
	     (c3 (make-instance '|SimpleUML|::|Class| :name "C3" :kind "Persistent"
				:attribute (make-instance 'ocl:|Set| :value (list c3-a1))
				:namespace p))
	     (c1.c2 (make-instance '|SimpleUML|::|Association| :name "C1.C2" :kind "Persistent"
				   :source c1 :destination c2
				   :namespace p)))
	(declare (ignore c1.c2 c3))
	population))))

(defun 2uml ()
  "Throw-away for debugging"
  (setf tr::*trie-db* (find "uml" tr::*the-databases* :key #'tr::name :test #'string-equal)))

(defun 2rdbms ()
  "Throw-away for debugging"
  (setf tr::*trie-db* (find "rdbms" tr::*the-databases* :key #'tr::name :test #'string-equal)))




    
