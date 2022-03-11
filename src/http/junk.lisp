(defmethod pod:div-header ((app (eql :cre)))
  "Emit html for the banner. "
  (with-html-output (*standard-output*)
    (:div :id "header"
       (:table :width 903 :height 108 :border 0 :cellpadding 0 :cellspacing 0
	 (:tr
	  (:td 
	   (:a :href "redir.aspx" ; POD Fix this.
	       (:img :src "/cre/image/EL.gif" 
		     :alt "Engineering Laboratory" :height 27 :width 554 :border 0)))
	  (:td :rowspan 2
	    (:a :href "redir.aspx" ; POD Fix this.
		(:img :src "/cre/image/NIST_Home.gif"
		      :alt "NIST Home" :height 71 :width 349 :border 0))))
	 (:tr
	  (:a :href "UrlBlockedError.aspx" ; POD Fix this.
	      (:img :src "/cre/image/NIST_ISO_159268_Validator.gif"
		    :height 44 :width 554 :border 0)))
	 (:tr
	  (:td :colspan 2 :bgcolor "#FFFFFF"
	       (:img :height 37 :width "903")))))))
