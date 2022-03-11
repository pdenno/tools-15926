
(in-package :mofi)

#| Commented out for 2012
(ensure-model 
 :ap233 :force t :verbose t
 :documentation "compiled-from ap233-arm-lf-20090502v1.exp .lisp copied 
                 from sei:lib;ap233-testbed."
 :features '(:ap233-validator :mexico)
 :package-use-list '(:cl :pod :expo)
 :model-class 'expo::express-2-schema
 :classes-path #P"sei:lib;ap233-testbed;ap233.lisp"
 :model-n+1 (find-model :mexico))
|#

#| This will be very different than what is below. Basically, I'll run 
   (expo:load-project #P"sei:lib;ap233-testbed;ap233-testbed.pra") whenever MEXICO or AP233 changes,
   and from that I'll generate a XMI2.1 file. Then this will load that. 
(ensure-model 
 :ap233-mexico-population :force t :verbose t
 :documentation "Generated from (expo:load-project #P"sei:lib;ap233-testbed;ap233-testbed.pra")
                 and then saving that population."
 :features '(:ap233-validator :mexico)
 :package-use-list '(:cl :pod :expo)
 :model-class 'mofi:population
 :source-file #P"lisplib:pod-utils;uml-utils;models;ap233-mexico-pop.xmi"
 :model-n+1 (find-model :mexico))
|#