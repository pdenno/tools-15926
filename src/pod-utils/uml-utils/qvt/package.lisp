
#+sbcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (setf sb-ext:*on-package-variance* '(:warn t)))

(defpackage qvt                                       
  (:use cl closer-mop pod #|mofi ptypes ocl|# trie) ; 2011-09-12 :mofi, ptypes, ocl: a mistake to use these!
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:shadowing-import-from :mofi #:owner #:%of-model #:%defined-at #:%token-position #:%source-elem #:%debug-id
			  ;; Some of these last ones are from the qvt model file? 
			  #:source-file #:with-instance #:model-package #:mm-root-supertype #:model-name #:name)
  (:shadowing-import-from :ptypes #:|Boolean| #:|String| #:|Integer| #:|UnlimitedNatural| #:|Real|)
  (:shadowing-import-from :ocl #:-typ #:self)
  (:nicknames "qvt-r")
  (:export
   #:append-binds
   #:bind-vars
   #:bind-vars-to
   #:binds-keep-only
   #:domain-nick
   #:ensure-proxy-obj
   #:find-binding
   #:get-key-info
   #:home-pkg
   #:instance2tries
   #:key-completer
   #:*map-info*
   #:mk-logic-var
   #:qvt-boundp
   #:qvt-go
   #:qvt-file2model
   #:qvt-map-info
   #:qvt-map-model
   #:qvt-parse-error
   #:qvt-population
   #:qvt-target-population-install-fn
   #:qvt-query
   #:qvt-setq
   #:qvt-setq-when
   #:qvt-setq-where
   #:qvt-stream
   #:qvt-trie-add-upgrading
   #:+qvt-unbound+
   #:qvt-unboundp
   #:relation-check
   #:relation-enforce
   #:relation-executor
   #:set-accessor-pkg
   #:source-meta
   #:source-pop
   #:target-meta
   #:target-pop
   #:when-where
   #:with-bindings
   #:with-when
   #:with-where
   ;; A bunch of stuff to make the generated lisp more readable. POD is this an OK idea?
   #:result
   #:rel
   #:dom
   #:bindings
   #:checkset
   #:whenbinds
   #:key-completer
   #:combined
   #:for
   #:in
   #:collect
   #:trans
   #:object-set
   #:key-completed
   #:keys))

   

(defpackage qvt-html
  (:nicknames :qvth)
  (:use cl closer-mop pod ocl trie tbnl cl-who #-moss phttp) 
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod)
  (:export
   #:qvt-dsp
   #:qvt-load-metamodels-dsp
   #:qvt-compile-maps-dsp
   #:qvt-load-models-dsp
   #:qvt-execute-map-dsp
   #:qvt-parse-errors-dsp
   #:qvt-remove-model-dsp
   #:qvt-restore-defaults-dsp))





	




