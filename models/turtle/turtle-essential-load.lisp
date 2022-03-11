(in-package :mofi)


(ensure-model 
 :odm :force t  :verbose t 
 :features '(:always)
 :depends-on-models '(:ocl)
 :documentation "From XMI 08-09-08-owl-rdf-cmof-clean.xmi 
                   (http://www.omg.org/cgi-bin/doc?ptc/2008-09-08). Created 2011-12-27."
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :lisplib "pod-utils/uml-utils/models/odm/odm-2009-owl-rdf-only.lisp")
 :postload-path (pod:lpath :lisplib "pod-utils/uml-utils/models/odm/odm-2009-owl-rdf-only-postload.lisp"))

;
; :postload-path (pod:lpath :lisplib "pod-utils/uml-utils/models/odm-postload.lisp")



