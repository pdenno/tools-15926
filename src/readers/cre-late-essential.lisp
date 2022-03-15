
(in-package :mofi)

(phttp::make-apps)

;;; ============================================
;;; Load 15926-2 schema
;;; ============================================

#+injector(setf injector:*unresolved-attribute-refs* (make-array 1000 :adjustable t :fill-pointer 0))

;;; 2022 commented out; something simple, I think.
#+nil(ensure-model 
 :part2-mexico :force t :verbose t
 :features '(:cre)
 :nicknames '(:part2-mexico)
 :model-class 'mexico-schema
 :documentation "Created from pristine ISO 15926-2 EXPRESS."
 :source-file (lpath :models "cre/15926-2.exp"))

(ensure-model
 :part2
 :force t :verbose t
 :features '(:cre)
 :nicknames '(:part2)
 :model-class 'expresso-lisp
 :documentation "Created from pristine ISO 15926-2 EXPRESS."
 :source-file (lpath :models "15926/part2/15926-2.lisp"))

;;; 2022 commented out; model-class not known.
#+nil(mofi:ensure-model 
 :mmt-templates :force t :verbose t
 :features '(:cre)
 :model-class 'mofi:privileged-template-population
 :documentation "Created by parsing templates retrieved from 
                 <a href='http://15926.org/15926_template_specs.php?mode=owl'>
                 http://15926.org/15926_template_specs.php?mode=owl</a> on 2013-07-25.
                 2022: See readers/owl-templates.lisp"
 :source-file (lpath :data "cre/templates-2022-03-14.ttl" ; <============================================== NOPE!
		     ;"data/mmt-templates-owl-2013-07-25.xml")) ; 2022 no such file
					;"data/mmt-templates-owl-2013-04-17.xml"))
		     ))

;;; 2022 commented out; cannot find the depends-on-model, mmt-templates. 
#+nil(mofi:ensure-model 
 :mmtc :force t :verbose t
 :features '(:cre)
 :nicknames '(:mmt-template-classes)
 :model-class 'mofi:essential-compiled-model
 :depends-on-models '(:mmt-templates)
 :documentation "Created from tlogic generator 2013-04-17 using templates retrieved that day." 
< :classes-path (lpath :data "mmt-template-classes.lisp"))

;;; 2022 commented out
#+nil(mofi:ensure-model
 :em-templates :force t :verbose t
 :features '(:cre)
 :model-class 'mofi:privileged-template-population
 :documentation "Created by parsing file 'Information Model Final-2012-04-17."
 :source-file #P"/home/pdenno/projects/cre/emerson/Information Model - Final-2012-04-17.xlsx")

;;; This is the 'pop-gen' of EXPRESS metamodels. Keep!
#|
(setf expo:*expresso* (make-instance 'expo:mexico-expresso))
(expo:read-schema
 (make-instance 'expo:express-file :version 2 :target-type :nothing 
		:path #P"/local/lisp/pod-utils/uml-utils/models/cre/15926-2.exp"))

;;; Load the lisp
  (expo:load-schema
   (make-instance 'expo::lisp-compiled-express-file 
		  :path #P"/local/lisp/pod-utils/uml-utils/models/cre/15926-2.lisp"))

|#



#| 
;;; This reads the faulty XMI. The alternative is to expo:load the .exp
(mofi:ensure-model 
 :ISO15926-2 :force t  :verbose t
 :nicknames '("Part-2" 
	      "http://syseng.nist.gov/part-2" ; I'm making this up
	      "http://syseng.nist.gov/part-2/part-2.xmi")
 :ns-prefix "exp"
 :ns-uri     "http://www.omg.org/spec/EXPRESS/1.0"
 :href-uri   "http://www.omg.org/spec/EXPRESS/1.0/mexico.xmi"
 :features '(:cre)
 :depends-on-models '(:mexico :ocl)
 :documentation "XMI Created by Express injector (expo:runone :15926) which created XMI which is (ahem) not
                 quite right. (It serializes large derived objects like EntityType.)"
 :model-class 'mofi:privileged-population
 :model-n+1 (mofi:find-model :mexico)
 :read-args '(:force t :sort-names nil :clone-p nil :linenums-p nil)
 :source-file (pod:lpath :lisplib "uml-utils/models/cre/15926-2.xmi"))
|#







