
(in-package :QVT)


(defparameter *weird-readtable* (copy-readtable))

(defun weird-exception (stream char)
  (declare (ignore char))
  (case (read-char stream t nil t)
    (#\b (if (eql #\q (read-char stream t nil t)) #\` (error "Should be $bq")))
    (#\c (if (eql #\m (read-char stream t nil t)) #\, (error "Should be $cm")))
    (t (error "Must be either $bq or $cm."))))

;; Modify the characters
(let ((*readtable* *weird-readtable*))
  (set-macro-character #\$ #'weird-exception))

(defun weird-read (&rest args)
  (let ((*readtable* *weird-readtable*))
     (apply #'read args)))
  
(defun weird-read-from-string (string &rest args)
  (let ((*readtable* *weird-readtable*))
    (apply #'read-from-string string args)))



