
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

(in-package :expo)

;;;
;;; OS interface compatibility stuff
;;;

;; Increase the default size of the stack on LispWorks
#+LispWorks
(setf sys:*sg-default-size* 128000)	;default is 16,000

(defparameter *lisp-file-type* "lisp")

(defparameter *bin-file-type*
  #+ANSI-CL (pathname-type (compile-file-pathname "foo.lsp"))
  #+Genera  si:*default-binary-file-type*
  #-(or ANSI-CL Genera)
  (error 'unknown-platform :string "Don't know how to get the binary file type."))

(defparameter *text-file-type*
  #+Genera "text"			; Genera uses canonical types
  #+Unix   "txt"			; could be "text"
  #+Win32  "txt"
  #-(or Genera Unix Win32)
  (error 'unknown-platform :string "Don't know how to get the text file type."))

;(declaim (inline os-exit))
(defun os-exit (code)
  #+Allegro   (excl:exit code)
  #+CLisp     (ext:quit code)
  #+CMU       (unix:unix-exit code)
  ;; Genera doesn't exit
  #+LispWorks (lw:quit :status code :confirm nil)
  #+SBCL      (sb-unix:unix-exit code)
  #-(or Allegro CLisp CMU #|Genera|# LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to exit this lisp."))

;(declaim (inline write-backtrace))
(defun write-backtrace (stream)
  #+Allegro
  (let ((*standard-output* stream))
    ;; :pretty :all :moderate
    (tpl::zoom-command :verbose t))
;  #+CLisp (error "Needs to be filled in")
  #+CMU   (debug:backtrace most-positive-fixnum stream)
  ;;Genera
  #+LispWorks (dbg::output-backtrace :bug-form stream)
  #+SBCL      (sb-debug:backtrace most-positive-fixnum stream)
  #-(or Allegro CMU #|Genera|# LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to dump a backtrace."))

;(declaim (inline chdir))
(defun chdir (directory)
  #+Allegro   (excl:chdir directory)
  #+CLisp     (ext:cd directory)
  #+CMU       (unix:unix-chdir directory)
  #+LispWorks (hcl:change-directory directory)
  #+SBCL      (setf *default-pathname-defaults*
		    (merge-pathnames directory *default-pathname-defaults*))
  #-(or Allegro CLisp CMU LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to change the current directory."))

;(declaim (inline mkdir))
(defun mkdir (directory)
  (setf directory (namestring (translate-logical-pathname directory)))
  #+Allegro   (excl:make-directory directory)
  #+CLisp     (ext:make-dir directory)
  #+CMU       (unix:unix-mkdir directory #o755)
  ;; Genera
  #+LispWorks (sys:make-directory directory)
  #+SBCL      (sb-unix:unix-mkdir directory #o755)
  #-(or Allegro CLisp CMU #|Genera|# LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to make a directory."))

;(declaim (inline cp-file))
(defun cp-file (from to)
  #+Allegro   (sys:copy-file from to)
;  #+CLisp     (error "Not found yet")
  #+CMU       (ext:run-program "/bin/cp" (list from to))
  ;; Genera
  #+LispWorks (sys::copy-file from to)
  #+SBCL      (sb-ext:run-program "/bin/cp" (list from to))
  #-(or Allegro #|CLisp|# CMU #|Genera|# LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to copy a file"))

(declaim (inline getenv))
(defun getenv (var)
  #+Allegro   (sys:getenv var)
  #+CLisp     (ext:getenv var)
  #+CMU       (cdr (assoc var ext:*environment-list*))
  ;; Genera doesn't have environment variables
  #+LispWorks (lw:environment-variable var)
  #+SBCL      (sb-ext:posix-getenv (string var))
  #-(or Allegro CLisp #|CMU|# LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to get environment variables.")
  )

;(declaim (inline get-args))
(defun get-args ()
  #+Allegro   (sys:command-line-arguments)
  #+CLisp     ext:*args*
  #+CMU       ext:*command-line-strings*
  ;; Genera doesn't get started from a command line
  #+LispWorks sys:*line-arguments-list*
  #+SBCL      sb-ext:*posix-argv*
  #-(or Allegro CLisp CMU LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to get the command line arguments.")
  )

#+Win32
(defun reg-key-value (hkey key-path key &key type)
  "Returns the value of HKEY\KEY-PATH\KEY from the Windows registry.
Optionally, it returns the value as type TYPE."
  (error 'not-yet-implemented :string "Coming soon to an Express Engine near you...")
  )

;; Notes for User related Registry stuff:
;;
;; HKLM\System\CurrentControlSet\Control\
;;     CurrentUser = "UserName"
;; HKLM\Network\Logon\
;;     username = "UserName"
;; HKLM\Software\Microsoft\Windows\CurrentVersion\ProfileList\UserName\
;;     ProfileImagePath = "C:\WINDOWS\Profiles\UserName"
;; HKCU\Software\Microsoft\Windows\CurrentVersion\ProfileReconciliation\
;;     ProfileDirectory = "C:\WINDOWS\Profiles\UserName"

;(declaim (inline user-name))
(defun user-name ()
  #+Allegro   (sys:user-name)
  #+CLisp     (posix:user-data-login-id (posix:user-data))
  #+CMU       (getenv :user)
  #+Genera    si:user-id
  #+LispWorks (sys::get-user-name)
  #+SBCL      (sb-unix:uid-username (sb-unix:unix-getuid))
  #-(or Allegro CLisp CMU Genera LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to get the user's name.")
  )

;(declaim (inline get-pid))
(defun get-pid ()
  #+Allegro (excl::getpid)
  #+CLisp   (sys::program-id)
  #+CMU     (unix:unix-getpid)
;  #+Genera nil ;; Genera names processes, it doesn't use numeric ID's
  #+(and LispWorks (not Win32)) (sys::getpid)
  #+(and LispWorks Win32) (win32:get-current-process-id)
  #+SBCL    (sb-unix:unix-getpid)
  #-(or Allegro CLisp CMU LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to get the process ID."))

#| ; PODsampson, let closer-mop do this. 
(defun generic-function-name (generic-function)
  #+Allegro   (excl::generic-function-name generic-function)
  #+CLisp     (error "generic-function-name is not supported")
  #+CMU       (pcl:generic-function-name generic-function)
  #+LispWorks (hcl:generic-function-name generic-function)
  #+SBCL      (sb-pcl:generic-function-name generic-function)
  #-(or Allegro CLisp CMU Lispworks)
  (error 'not-yet-implemented :string "Coming soon to an Expresso near you..."))

; PODsampson, let closer-mop do this. 
(defun finalize (lambda)
  ;; This function expects LAMBDA to be a lambda-list definition
  ;; [i.e. (lambda (x) (+ x 42))] which it then compiles in
  ;; implementations that support it.
  #+(or CLisp CMU LispWorks SBCL)
  (declare (special *debugging*))
  #+(or CLisp CMU LispWorks SBCL)
  (if (getf *debugging* :any) ; if-debugging macro not defined yet.
      (eval `(function ,lambda))
    (compile nil lambda))

  ;; If all else fails just make it an interpreted function
  #-(or CLisp CMU LispWorks SBCL)
  (eval `(function ,lambda)))
|#

(defun process-run-function (name keywords function &rest args)
  #+(or Allegro CMU SBCL)
  (declare (ignore keywords))
  #+(or CMU SBCL) (declare (ignore name))
  #+Allegro   (apply #'mp:process-run-function name function args)
  ;;#+CLisp nil
  #+CMU       (apply function args)
  ;;#+Genera nil
  #+LispWorks (apply #'mp:process-run-function name keywords function args)
  #+SBCL      (apply function args)
  #-(or Allegro CMU LispWorks SBCL)
  (error 'unknown-platform :string "Don't know how to start a process."))

(defun function-args (fn)
  #+Lispworks (lw:function-lambda-list fn)
  #+Allegro (excl:arglist fn)
  #+SBCL (sb-kernel:%simple-fun-arglist fn)
#|
  #+CMU ; untested
  (let* ((function (symbol-function name))
         (stype (system:%primitive get-vector-subtype function)))
    (when (eql stype system:%function-entry-subtype)
      (cadr (system:%primitive header-ref function
                               system:%function-entry-type-slot))))
|#
)

#| PODsampson
;;; POD FIXME - Note sent to sbcl-help...
#+SBCL (in-package :sb-pcl)
#+SBCL
(#-sb-package-locks progn
 #+sb-package-locks sb-ext:without-package-locks
(defun (setf find-class) (new-value name &optional errorp environment)
  (declare (ignore errorp environment))
  (if (legal-class-name-p name)
      (let ((cell (find-class-cell name)))
	(setf (find-class-cell-class cell) new-value)
	(when (and (eq *boot-state* 'complete) (null new-value))
	  (setf (find-classoid name) nil))
	(when (or (eq *boot-state* 'complete)
		  (eq *boot-state* 'braid))
;	  (when (and new-value (class-wrapper new-value))
;	    (setf (find-class-cell-predicate cell)
;		  (fdefinition (class-predicate-name new-value))))
	  (update-ctors 'setf-find-class :class new-value :name name))
	new-value)
      (error "~S is not a legal class name." name)))
)

#+Ignore
(defun (setf find-class) (new-value name &optional errorp environment)
  (declare (ignore errorp environment))
  (if (sb-pcl::legal-class-name-p name)
      (let ((cell (sb-pcl::find-class-cell name)))
	(setf (sb-pcl::find-class-cell-class cell) new-value)
	(when (and (eq sb-pcl::*boot-state* 'complete) (null new-value))
	  (setf (sb-kernel:find-classoid name) nil))
	(when (or (eq sb-pcl::*boot-state* 'complete)
		  (eq sb-pcl::*boot-state* 'braid))
;	  (when (and new-value (class-wrapper new-value))
;	    (setf (find-class-cell-predicate cell)
;		  (fdefinition (class-predicate-name new-value))))
	  (sb-pcl::update-ctors 'setf-find-class :class new-value :name name))
	new-value)
      (error "~S is not a legal class name." name)))
|#

