
(in-package :cl-user)

;;; POD FIX THIS! Must re-evaluate ~/projects/moss/source/utils/project-utils.lisp
;;; after reloading this file!

(unless (find-package :pod-utils)
 (defpackage :pod-utils
  (:nicknames :pod)
  (:use :cl :cl-who)
  (:shadowing-import-from :cl-who #:str)
  (:export 
   ;; from utils.lisp
   #:*null-stream* 
   #:aand
   #:aif
   #:app-redirect
   #:awhen
   #:awhile
   #:base-namespace
   #:basic-ascii-string
   #:basic-ascii-string-file
   #:before 
   #:breadth-first-search 
   #:break-line-at 
   #:c-name2lisp 
   #:chop 
   #:clear-memoize 
   #:combinations 
;   #:copy-file 
   #:date-to-utime
   #:dash-to-camel
   #:dbind 
   #:debug-memo 
   #:declare-ignore 
   #:decode-time-interval 
   #:define-constant 
   #:definition
   #:defmemo 
   #:defmemo!
   #:defmemo-equal
   #:defp
   #:defpackage*
   #:defun-memoize 
   #:depth-first-search 
   #:depth-search-tracking
   #:duplicate 
   #:elip
   #:equiv-classes
   #:fail 
   #:file-size 
   #:find-non-ascii
   #:find2 
   #:flatten 
   #:format-to-size
   #:found-at-pos
   #:gather-duplicates
   #:gethash-inv
   #:group 
   #:ht2list
   #:ht2dotted-list 
   #:if-bind 
   #:intersect-predicates 
   #:it
   #:kintern 
   #:last1 
   #:lisp-name2c 
   #:load-ht 
   #:longer 
   #:lpath
   #:*lpath-ht*
   #:lpath-init
   #:mac 
   #:mac2 
   #:macroexpand-all 
   #:map-in 
   #:mapappend 
   #:mapnconc 
   #:memo 
   #:memoize 
   #:mklist 
   #:mvb 
   #:mvs 
   #:name2initials 
   #:new-reslist 
   #:new-uuid
   #:now 
   #:ordinal
   #:pairs 
   #:pprint-symbols 
   #:pprint-without-strings 
   #:prepend 
   #:prune 
   #:pushnew-last
   #:push-last
   #:read-string-to-list 
   #:reinit-singleton 
   #:remove-extra-spaces 
   #:reslist-arr 
   #:reslist-fillptr 
   #:reslist-pop 
   #:reslist-push 
   #:reuse-cons 
   #:session-vo-class
   #:setx 
   #:set-p
   #:set-search-path
   #:shadow-for-model
   #:sidebox-menu
   #:single-p 
   #:singleton 
   #:sintern 
   #:split 
   #:split-if 
   #:strcat 
   #:strcat* 
   #:strcat+
   #:string-integer-p 
   #:substitute-string 
   #:substring 
   #:system-add-memoized-fn 
   #:system-clear-memoized-fns 
   #:system-forget-memoized-fns 
   #:system-list-memoized-fns 
   #:the-instance
   #:tree-search 
   #:tree-search-path 
   #:uappend
   #:ulist
   #:unique
   #:update 
   #:usr-bin-diff
   #:usr-bin-file 
   #:usr-bin-xmllint
   #:utils-parse-error
   #:utime-to-date
   #:vars 
   #:vector-count-if 
   #:when-bind 
   #:when-bind* 
   #:with-gensyms 
   #:with-package-renamed
   #:with-stack-size
   ;; from debugging.lisp
   #:*debugging* 
   #:*dbg-tags* 
   #:*debug-stream* 
   #:clear-debugging 
   #:dbg-funcall 
   #:dbg-message dbg-pprint
   #:full-debugging 
   #:get-debugging 
   #:if-debugging 
   #:show-debugging 
   #:set-debugging
   #:when-debugging 
   #:with-debugging
   ;; from parsing/parsing.lisp
   #:%%children
   #:%%ids
   #:%%name
   #:%%parent
   #:%%scope
   #:%%type
   #:%%package
   #:*bcounter-ends*
   #:*bcounter-starts*
   #:*line-number*
   #:*scope*
   #:*tags-trace*
   #:token
   #:*token-stream*
   #:token-stream-stream
   #:add-type
   #:assert-token
   #:assert-token-str
   #:char-buffered
   #:check-bcounters
   #:check-token
   #:def-parse-error
   #:describe-scopes
   #:find-child-scope
   #:init-bcounters
   #:make-string-const
   #:parse
   #:parse-data
   #:parse-error-with-token
   #:parse-token-error
   #:parse1-data
   #:parse2-data
   #:peek-token
   #:pipe
   #:print-parse-stack
   #:processing-results
   #:read-char-buffered
   #:read-fn
   #:read-token
   #:recent-token-positions
   #:simple-token-stream 
   #:string-const
   #:string-const-p
   #:string-const--value
   #:switched-out-p
   #:token-balance-error
   #:token-is
   #:token-position 
   #:token-scope 
   #:token-stream 
   #:toplevel-scope
   #:unread-char-buffered
   #:unread-token
   #:utils-parse-error
   #:with-other-reader
   ;; from html/html-utils.lisp
   #:app-page-wrapper
   #:app-name
   #:app-title
   #:app-url-key-fn
   #:app-url-prefix
   #:basic-page-wrapper
   #:div-header
   #:div-disclaimers
   #:find-http-app
   #:http-app
   #:http-apps
   #:hvars
   #:mk-mnode 
   #:mut
   #:nist-exit-url 
   #:safe-app-name
   #:session-models
   #:session-vo
   #:session-vo-class
   #:*spare-session-vo*
   #:safe-get-parameter
   #:safe-leaf
   #:safe-post-parameter
   #:sidebox-menu 
   #:view-objects
   #:with-html 
   #:with-vo)))

(unless (find-package :xml-utils)
 (defpackage :xml-utils
  (:nicknames :xmlu)
  (:use :cl :pod-utils)
  ;; from xml/xml-utils.lisp
  (:export 
   #:def-parse 
   #:dtd-find-child 
   #:dself
   #:xml-namespaces
   #:string-squeeze
   #:squeeze-xml
   #:with-xml-attrs 
   #:xml-add-attr
   #:xml-add-elem
   #:xml-attributes
   #:xml-children
   #:xml-collect-elem
   #:xml-create-elem
   #:xml-document-parser
   #:xml-find-attrs
   #:xml-find-cdata-child 
   #:xml-find-child 
   #:xml-find-children 
   #:xml-find-string-child
   #:xml-follow-back
   #:xml-get-attr 
   #:xml-get-attr-value
   #:xml-get-logical
   #:xml-indent
   #:xml-line-num
   #:xml-parent
   #:xml-prefix2uri
   #:xml-root
   #:xml-set-content
   #:xml-set-parents
   #:xml-siblings 
   #:xml-squeeze
   #:xml-typep
   #:xml-typep-2
   #:xml-typep-3
   #:xml-value
   #:xml-write-node)))

;;; Because this file is used by many applications, it is not possible to use 
;;; #:+iface-http (a compile time thing) to specify the package use-list
(when (find :iface-http *features*)
  (use-package :cl-who :pod-utils))

