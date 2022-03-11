
;;; Copyright (c) 2001 Logicon, Inc.
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------


;;;
;;; Global variables, constants, and generic functions
;;;

(in-package :EXPRESSO)

;; this will be set to T in a delivered image
;; It can also be set to T to test delivered operation
(defvar *production* nil)

(defvar *prog-name* nil
  "Name used to start Expresso; parsed from the command line args")

(defvar *message-stream* *standard-output* "The stream object for message output")

(defvar *cmd-args* nil
  "Filled in by (define-cmd-arg ...) forms.")


;; from express-metaobjects.lsp
#+LispWorks
(defvar *current-class-name* nil 
  "Gets around a problem with ACLPC. Set in defentity-class macro.")


;; from express-utils.lsp
(defvar *inside-entity--print-ref* nil "When true print a ref, not the complete entity.")
(defvar *save-package*             nil "Used to save current package.")
(defvar *focus-partial-context*    nil "The entity scope(s) currently in effect.")


;; from p21-driver.lsp
(defvar *comment-depth* 0  " Counts embedding of /*")
(defvar *comment*       "" "Holds a comment prior to processing an entity instance.")


;; from p21-utils.lsp
(defvar *current-record* nil  "The record trying to be created.")
(defvar *recorded-type* nil   "The types collected from the tfs.")


;; from start-and-stop.lsp
(defvar *schema-loading* nil "True only during the load.")
(defvar *destination-directory-count* 1)


;; patch-file support
(defvar *ee-major* 4 "Major version for Express Engine")
(defvar *ee-minor* 0 "Minor version for Express Engine")
(defvar *ee-patch* 0 "Patch level for Express Engine")
(defvar *compile-date* (get-universal-time))

(defun ee-date (&optional (ut (get-universal-time)))
  (multiple-value-bind (sec min hr day mon yr)
      (decode-universal-time ut)
    (declare (ignore sec))
    (format nil "~4,'0D-~A-~2,'0D ~2,'0D:~2,'0D" yr
	    (nth (1- mon) '("Jan" "Feb" "Mar" "Apr" "May" "Jun"
			    "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"))
	    day hr min)))


(defun ee-patch-dir ()
  (format nil "ee-~D-~D" *ee-major* *ee-minor*))

(defun ee-version ()
  (format nil "Expresso ~D.~D.~D (compiled ~A)" *ee-major* *ee-minor*
	  *ee-patch* (ee-date *compile-date*)))

(defmacro patch-version (system major minor patch comment)
  (declare (ignore system comment))
  `(progn
     (unless (and (eql *ee-major* ,major) (eql *ee-minor* ,minor)
		  (eql *ee-patch* ,(1- patch)))
       (error ,(format nil "Patch ~D.~D.~D not valid for Expresso ~~D.~~D.~~D"
		       major minor patch)
	      *ee-major* *ee-minor* *ee-patch*))
     ;; might want to figure out some way to save the comment so that
     ;; it can be displayed for the user
     (setf *ee-patch* ,patch)
     (setf *compile-date* ,(get-universal-time))
     )
  )

(defmacro patch-section (package comment)
  (declare (ignore comment))
  `(progn
     (in-package ,(kintern package))
     ))


;; P21 support
(defvar *dataset* nil)

;; debugging and error reporting support
;; These are not yet used -- CTL
(defvar *schema* nil
  "Dynamically bound to the current schema while it is being used.")
(defvar *instance* nil
  "Dynamically bound to the current entity instance while the rules are being checked.")
(defvar *definition* nil
  "Dynamically bound to the current definition (either ENTITY or RULE) that is being run.")

;; from validation.lsp
(defvar *candidate*      nil "A cedt struct on which testing is occuring")
(defvar *expresso* nil "The expresso object (may be cgtk-expresso, mexico-expresso")

;; from x-metaobjects.lsp
(defvar *inside-vi--print-ref* nil "When t print only the #v<number>.")
