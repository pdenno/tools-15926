
(in-package :cl-user)

(defpackage V
  (:nicknames :vamp)
  (:use "KU" "CL" "POD-UTILS" "XML-PARSER" "XML-QUERY-DATA-MODEL")
  (:export 
   ;; vampire.lisp
   #:*domain-is-formula* 
   #:*proof-stream*
   #:output-for-vampire 
   #:pf-format
   #:vampire-ask 
   #:vampire-compile-ontology 
   #:vampire-start 
   #:vampire-stop 
   #:vampire-tell
   #:with-hilites))

(defvar v:*proof-stream* nil "Stream for writing proof output")


