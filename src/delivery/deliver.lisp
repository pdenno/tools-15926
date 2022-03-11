
(in-package :cl-user)
#-LispWorks(error "This file is only valid in LispWorks")

;;; To use this file:
;;;  1. cd to source directory
;;;  2. execute: 
;;;       /local/lib/LispWorks/tty-xml-2012-03-07 -init delivery/deliver
;;;  3. scp cre.exe syseng:/home/pdenno/projects/cre/source

;;; On syseng
;;;  5. /etc/rc.d/cre stop
;;;  6. cd ~/projects/cre/source ; mv cre.exe cre-2009-mm-dd.exe
;;;; 7  (on local): scp cre.exe syseng:/home/pdenno/projects/cre/source/
;;;  6. cd /local/lisp/pod-utils ; cvs update -Pd .
;;;  7. cd ~/projects/cre/source ; cvs update -Pd .
;;;  8. /etc/rc.d/cre start


;;; --- NOTE THAT NONE OF THESE ARE LOADED AT START TIME (they are in the image) THUS NOT REALLY NECESSARY

(load-all-patches)
(cd "~/projects/cre/source/")

(push :cre.exe *features*) ; but don't rely on it at compile time....
(load "load")	

#+mexico(defclass bnfp::vdl-prolog () ())  ; should have been defined in cl-xml

(deliver 'phttp:cre-start
         "cre.exe"
	  1 
	 :interface		      nil 
	 :multiprocessing	      t
	 :keep-lisp-reader            t     ;; I get msg about reading some motif thing!
	 :keep-pretty-printer         t     ;; POD: not checked whether necessary.
	 :keep-eval		      t     ;; bunch of stuff uses it. (not mine)
	 :shake-shake-shake           t     ;; 30MB --> 21MB 
	 :keep-package-manipulation   t     ;; Beijing ... but doesn't add 6MB, but something added 2.5MB
	 :shake-externals             t
	 :console                     :input
	 :compact                     t
	 :keep-debug-mode             :all  ;; Despite the name, seem to need this.
	 :keep-clos :full-dynamic-definition ;; needed now that using programmatic classes. Ugh! 26MB image!
	 :keep-clos-object-printing   t
	 :generic-function-collapse   nil
	 :structure-packages-to-keep '(:tbnl :mofi) 
	 :classes-to-keep-effective-slots '(tbnl::request)
	 :keep-documentation t
	 :never-shake-packages '(:tbnl :mofi :tr) 
	 :keep-conditions       :all) ;; So that conditions:stack-overflow can be caught. 

(quit)


