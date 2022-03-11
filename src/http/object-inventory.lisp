

;;; Written by Jonathan Burket
;;; Purpose : Implement an 'object inventory table' of SysML/UML Objects.
;;; 7/21/08
;;; POD This should be rewritten in lisp. 

(in-package :project-http)

(let ((+backcol+ "#e3ebe7"))
  (defun get-color (&key reset)
    "Switches the current backround color for the rows in the table"
    (if reset 
	(setf +backcol+ reset)
	(if (string= +backcol+ "white")
	    (setf +backcol+ "#e3ebe7")
	    (setf +backcol+ "white")))
    +backcol+)
) ; end closure

(defmacro enc (value)
  `(mof-browser:encode-for-url ,value))
(defmacro dec (value)
  `(mof-browser:decode-for-url ,value))

(defun object-inventory-page ()
  "Implement the object inventory page."
  (with-vo (mut)
    (let ((object-vector (mofi:members mut))
	  (sysml-vec (make-array (fill-pointer (mofi:members mut)) :fill-pointer 0))
	  (uml-vec (make-array (fill-pointer (mofi:members mut)) :fill-pointer 0))
	  (sort-type (write-to-string (safe-get-parameter "sort")))
	  (get-vals (make-array 64 :fill-pointer 0 :adjustable t)))
      (app-page-wrapper :cre (:view "Object Inventory" :menu-pos '(:root :demo))
	;;CSS for sorting links
	(:style :type "text/css"
		"a.sort { color: green; font-size: small;}")
	(:h1 "Object Inventory")
	(dolist (n (get-parameters tbnl:*request*)) ; POD is this a problem for OCIO? No safe-get-parameters.
	  (unless (string= (car n) "sort")	 
	    (vector-push-extend (list (dec (car n)) (cdr n)) get-vals)))
	;;Sort Through All of the Objects
	(let ((new-vector sysml-vec))
	  (dotimes (n (fill-pointer object-vector))	    
	    ;;Decide whether SysML or UML
	    (if (mofi:stereotyped-obj-p (aref object-vector n))
		(setf new-vector sysml-vec)
		(setf new-vector uml-vec))
	    ;;Loop through new-vector looking for arrays that contain an object of 
	    ;; the same class as the current object
	    (dotimes (s (+ (fill-pointer new-vector) 1))
	      (cond ((= s (fill-pointer new-vector))
		     (let ((new-array (make-array 32 :fill-pointer 0 :adjustable t)))
		       (vector-push new-array new-vector)
		       (vector-push (aref object-vector n) new-array)))
		    ((eql (class-of (aref object-vector n)) (class-of (aref (aref new-vector s) 0)))
		     (vector-push-extend (aref object-vector n) (aref new-vector s))
		     (return))))))
	;;Sort Arrays
	(flet ((alpha-sort (vector1 vector2)
		 (string< (format nil "~a" (class-of (aref vector1 0)))
			  (format nil "~a" (class-of (aref vector2 0)))))
	       (alpha-sort2 (vector1 vector2)
		 (string> (format nil "~a" (class-of (aref vector1 0))) 
			  (format nil "~a" (class-of (aref vector2 0)))))
	       (count-sort (vector1 vector2)
		 (< (fill-pointer vector1) (fill-pointer vector2)))
	       (count-sort2 (vector1 vector2)
		 (> (fill-pointer vector1) (fill-pointer vector2))))
	  (cond ((string= sort-type "'counta'")
		 (setf sysml-vec (sort sysml-vec #'count-sort))
		 (setf uml-vec (sort uml-vec #'count-sort)))
		((string= sort-type "'countd'")
		 (setf sysml-vec (sort sysml-vec #'count-sort2))
		 (setf uml-vec (sort uml-vec #'count-sort2)))
		((string= sort-type "'alphad'")
		 (setf sysml-vec (sort sysml-vec #'alpha-sort2))
		 (setf uml-vec (sort uml-vec #'alpha-sort2)))
		(t (setf sysml-vec (sort sysml-vec #'alpha-sort))
		   (setf uml-vec (sort uml-vec #'alpha-sort)))))
	;;Write the HTML Table
	(get-color :reset "white") ; POD not working?
	(:table :border 2 :rules "rows" :frame "box" :cellspacing 0 :cellpadding 5
		;;Stereotyped Objects First
		(:tr :bgcolor "#FDFDA2"
		     (:td :colspan 3 :align "center"
			  (:b) (:a :style "color: black;" :name "sysmltop" "Stereotyped Objects:")))
		(get-color :reset "white")
		(str (write-top-bar sort-type get-vals "sysmltop"))
		(str (print-objects sysml-vec get-vals "sysmltop"))
		;; UML Objects Second     
		(:tr :bgcolor "#FDFDA2"
		     (:td :colspan 3 :align "center"
			  (:b) (:a :style "color: black;" :name "umlltop" "UML Objects:")))
		(get-color :reset "white")    
		(str (write-top-bar sort-type get-vals "umltop"))
		(str (print-objects uml-vec get-vals "umltop")))))))

(defun print-objects (the-vector get-list jump-tag)
  "Adds new rows to the table for each class"
  (dotimes (n (fill-pointer the-vector))
    (format t "<tr bgcolor='~a'><td>~a</td><td align='center'>~a</td><td>~a</td></tr>" 
	    (get-color)  
	    (mof-browser::url-class-browser (class-of (aref (aref the-vector n) 0))) 	      
	    (fill-pointer (aref the-vector n))
	    (write-examples (aref the-vector n) get-list jump-tag))))

(defun write-top-bar (sort-type get-list jump-key)
  "Writes the HTML for the top bar of each section (SysML and UML)" 
  (macrolet ((make-link (sort-parameter link-text) 
	       `(format t "<a href='~a&sort=~a#~a' class='sort'> ~a</a>" 
			(reconstruct-url get-list nil) ,sort-parameter jump-key ,link-text)))
    (format t "<tr align='left' bgcolor='~a'><td><b>Class Name</b>" (get-color))	  	
    (cond ((string= sort-type "'alphad'")(make-link "alphaa" "[A]"))
	  ((string= sort-type "'alphaa'")(make-link "alphad" "[D]"))
	  (t (make-link "alphaa" "[S]")))		  
    (format t "</td><td align='center'><b>Count </b>")	  
    (cond ((string= sort-type "'countd'")(make-link "counta" "[A]"))
	  ((string= sort-type "'counta'")(make-link "countd" "[D]"))
	  (t (make-link "counta" "[S]")))
    (format t "</td><td align='center'><b>Examples</b></td></tr>")))


(defun write-examples (example-list get-list jump-tag)
  "Writes the HTML for the list of example objects (will make an expanding list if more than 2 example objects)"
  (let ((obj-count (fill-pointer example-list))
	(str-cur ""))
    (macrolet ((quick-url (link-string &optional (new-number `(length example-list)))
		 `(strcat* str-cur (format nil "<a href='~a#~a'>~a</a>" 
				(reconstruct-url-with-new-value get-list (class-of (aref example-list 0)) 
				 ,new-number) jump-tag ,link-string))))
      (cond ((= obj-count 1) ;If there is only one example
	     (strcat* str-cur (mofb:url-object-browser (aref example-list 0))))
	    ((>= obj-count 2)  ;2+ examples
	     (strcat* str-cur (mofb:url-object-browser (aref example-list 0))
		  "<br>"
		  (mofb:url-object-browser (aref example-list 1))
		  "<br>")
	     (when (> obj-count 2) ;3+ examples
	       (let ((get-param (get-param-by-class get-list (class-of (aref example-list 0)))))
		 ;;Write the appropriate # of examples if there is a get-parameter
		 (when get-param
		   (loop for i from 2 to (min (- (length example-list) 1) (- (parse-integer get-param) 1)) do
			(strcat* str-cur (mofb:url-object-browser (aref example-list i)) "<br>"))
		   (when (< (parse-integer get-param) (fill-pointer example-list))		
		     (quick-url "More" (* 2 (parse-integer get-param))) ;Number doubles with each 'More'
		     (strcat* str-cur "&nbsp|&nbsp")
		     (quick-url "All")))
		 ;;Add link for more if 3+ examples and no get-parameter
		 (unless get-param 
		   (quick-url "More" 4)
		   (strcat* str-cur "&nbsp|&nbsp")
		   (quick-url "All")))))))
    str-cur))

;;;--------------------------
;;; Functions to write new URLs based on current and new get-parameters
;;;--------------------------
(defun get-param-by-class (get-list a-class)
  "Returns the value of the get-parameter that corresponds to a certain class"
  (dotimes (n (length get-list))
    (when (eql a-class (car (aref get-list n)))
      (return (car (cdr (aref get-list n)))))))
  
(defun reconstruct-url-with-new-value (get-list class-type new-value)
  "Creates a new url based on the current get-parameters, with the value of the parameter for 'class-type'
  set to 'new-value'"
  (cond ((get-param-by-class get-list class-type)
	 (let ((new-url ""))
	   (when (safe-get-parameter "sort")
	     (strcat* new-url (format nil "&sort=~a" (safe-get-parameter "sort"))))
	   (loop for n across get-list do
	     (when (car n)
	       (cond ((eql class-type (car n))		   
		      (strcat* new-url (format nil "&~a=~a" (enc (car n)) new-value)))
		     (t (strcat* new-url (format nil "&~a=~a" (enc (car n)) (car (cdr n))))))))
	   (if (or (> (length get-list) 0) (safe-get-parameter "sort"))
	       (concatenate 'string "object-inventory" "?" (subseq new-url 1))
	       "?")))
	(t (format nil "~a&~a=~a" (reconstruct-url get-list) (enc class-type)  new-value))))

(defun reconstruct-url (get-list &optional (include-sort t))
  "Creates a new url based on the current get-parameters"
  (let ((new-url ""))
    (when (safe-get-parameter "sort") 
      (if include-sort
	  (strcat* new-url (format nil "&sort=~a" (safe-get-parameter "sort")))
	  (strcat* new-url " ")))
    (loop for n across get-list do
      (when (car n)
	(strcat* new-url (format nil "&~a=~a" (enc (car n)) (car (cdr n))))))
    (if (or (> (length get-list) 0) (safe-get-parameter "sort"))
	(concatenate 'string "object-inventory" "?" (subseq new-url 1))
	"?")))


