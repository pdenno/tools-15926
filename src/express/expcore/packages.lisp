

;;; This will get blown away after mexico is loaded.
(defpackage "MEXICO" 
  (:use :cl :pod :mofi)
  (:shadow ocl:value) ; PODTT
  (:nicknames :mex)
  (:shadowing-import-from ; pod7 probably temporary while pod7
   :pod-utils "%%NAME" "%%TYPE" "%%PARENT" "%%CHILDREN" "%%IDS" "%%SCOPE")
  (:export
   #:|ScopedId|
   #:repeat
   #:extent
   #:query
   #:schema 
   #:const_e
   #:lobound
   #:loindex
;   #:value
   #:in))
#|
  (:export 
   #:unresolved-attribute
   #:|Operation|
   #:|name|))
|#   