(defun tryv ()
  (with-slots (m:vampire-path m:vampire-tmp-file m:vampire-stream) (m:app-globals)
    (let ((cmd (format nil "~A ~A" m:vampire-path m:vampire-tmp-file)))
      (format t "~% cmd = ~S" cmd)
      (sys:open-pipe cmd :direction :io))))

;"e:/pdenno/projects/miv/tmp/vamp.out"
;"\"C:/Program Files/MIV/tmp/vamp.out\""
;"e:/pdenno/projects/miv/tmp/vamp.out"
;"\"c:\\Documents and Settings\\Peter Denno\\temp\\vamp.out\""

(defun tryme2 (cmd &aux result)
  (let ((pipe (sys:open-pipe cmd :direction :io)))
    (format pipe "<query>(or False)</query>~%")
    (unwind-protect 
;      (loop for c = (read-char pipe nil :eof) 
;            do (if (eql c :eof) (return-from tryme2) (write-char c)))
    (let ((context (make-instance 'vampire-response-context)))
      (catch 'vampire-responds
        (setf result (xml-utils:xml-document-parser pipe :construction-context context))))
    (format pipe "")
    (format pipe "")
    (format pipe "n")
    (close pipe)
    result)))

(defun tryme3 (cmd &aux result)
  (let ((pipe (sys:open-pipe cmd :direction :io)))
    (format pipe "<query>(or False)</query>~%")
    (force-output pipe)
    (unwind-protect 
      (loop for c = (read-char pipe nil :eof) 
            do (if (eql c :eof) (return-from tryme3) (write-char c)))
;    (let ((context (make-instance 'vampire-response-context)))
;      (catch 'vampire-responds
;        (setf result (xml-utils:xml-document-parser "pipe" :construction-context context))))
    (format pipe "")
    (format pipe "")
    (format pipe "n")
    (close pipe)
    result)))


;;; This works: (tryme "\"c:/Program Files/7-zip/7z.exe\"")
;;; It does NOT work if it doesn't have the quotes around it. 
(defun tryme (cmd)
  (let ((pipe (sys:open-pipe cmd :direction :io)))
    (unwind-protect
      (loop for c = (read-char pipe nil :eof) 
            do (if (eql c :eof) (return-from tryme) (write-char c))))
    (close pipe)))


#|
(defun miv-installdir ()
  #+win32
  (let ((gtk-path (find "GTK\\2.0\\bin" 
			(pod:split (lw:environment-variable "PATH") #\;)
			:test #'search)))
    (unless gtk-path (error "Could not find MIV on PATH environment variable."))
    (subseq gtk-path 0 (search "GTK" gtk-path)))
  #+linux (namestring (truename #P"justv:")))
|#
