
;;; Purpose: Load valid-canonical files for diffing with user input. 

(in-package :mofi)

(defparameter 
    *essential-pops*
  (list
   (cons :tc3  (pod:lpath :models "miwg/canonical/tc3.xmi"))))

    
