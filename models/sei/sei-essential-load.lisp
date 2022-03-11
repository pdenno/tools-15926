
(in-package :mofi)


;;;=========== Get URLs from the front page of spec ====
#|
The standard URI used in all the UML 2.4.1 XMI files is: http://www.omg.org/spec/UML/20110701

However, on the Web site, the physical XMI files are spread across three directories: 
 - http://www.omg.org/spec/UML/20110701 for Infrastructure,
 - http://www.omg.org/spec/UML/20110702 for Superstructure, and 
 - http://www.omg.org/spec/UML/20110703 for non-normative files. 

In particular, the files PrimitiveTypes.xmi and UML.xmi, which were created specifically 
to allow standard XMI references to UML elements, are in http://www.omg.org/spec/UML/20110702. 
I believe this means that, technically, the standard URL for, say, the UML primitive type 
Integer would need to be:

href=”http://www.omg.org/spec/UML/20110702/PrimitiveTypes.xmi#Integer”

This is sure to cause confusion, because everyone expects the reference use the UML URI, that is, to be:

href=”http://www.omg.org/spec/UML/20110701/PrimitiveTypes.xmi#Integer”
but this URL will not dereference to anything right now. It was already confusing that the UML 2.4 
URLs had different dates than the URI, and now we still have a similar problem with the UML 2.4.1 URLs.
|#

(ensure-model 
 :uml-profile-l2-20090901 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("StandardProfileL2-20090901" 
	      "http://www.omg.org/spec/UML/20090901/StandardProfileL2"      ; Use this one for xmlns
	      "http://www.omg.org/spec/UML/20090901/StandardProfileL2.xmi") ; Use this one for hrefs
 :documentation "Generated from ptc/10-08-22.xmi for UML 2.4"
 :model-class 'mofi::profile
 :model-n+1 :uml23
 :classes-path (pod:lpath :models "uml/uml-std-profile-l2-20090901.lisp")
 :ns-uri "http://www.omg.org/spec/UML/20090901/StandardProfileL2"      ; Use this one for xmlns
 :href-uri "http://www.omg.org/spec/UML/20090901/StandardProfileL2.xmi"
 :ns-prefix "StandardProfileL2")

(ensure-model 
 :uml-profile-l2-20110701 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("StandardProfileL2-20110701"
	      "http://www.omg.org/spec/UML/20110701/StandardProfileL2"      ; Use this one for xmlns
	      "http://www.omg.org/spec/UML/20110701/StandardProfileL2.xmi") ; Use this one for hrefs
 :documentation "Generated from http://www.omg.org/spec/UML/20110701/StandardProfileL2.xmi on 2012-08-31"
 :href-uri "http://www.omg.org/spec/UML/20110701/StandardProfileL2.xmi"
 :model-class 'mofi::profile
 :model-n+1 :uml241
 :classes-path (pod:lpath :models "uml/uml-std-profile-l2-20110701.lisp")
 :href-uri "http://www.omg.org/spec/UML/20110701/StandardProfileL2.xmi"
 :ns-uri "http://www.omg.org/spec/UML/20110701/StandardProfileL2"      ; Use this one for xmlns
 :ns-prefix "StandardProfileL2")

(mofi:ensure-model 
 :uml25 :force t  :verbose t
 :nicknames '("UML 2.5" 
      	      "http://www.omg.org/spec/UML/20131001"  ; 2019 "http://www.omg.org/spec/UML/2.5" 
	      "http://www.omg.org/spec/UML/2.5/UML.xmi"
	      "http://www.omg.org/spec/UML/20131001"
	      "http://www.omg.org/spec/UML/20131001/UML.xmi")
 :features '(:miwg)
 :depends-on-models '(:ocl #|:uml-profile-20131001|#)
 :documentation "Compiled from UML/20131001  on 2013-12-12. "
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :models "uml/uml25.lisp")
 :postload-path (pod:lpath :models "uml/uml25-postload.lisp")
 :ns-uri     "http://www.omg.org/spec/UML/2.5"   
 :href-uri   "http://www.omg.org/spec/UML/2.5/UML.xmi"
 :ns-prefix "uml")


(ensure-model 
 :uml-profile-20131001 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("StandardProfile-20131001"
	      "http://www.omg.org/spec/UML/20131001/StandardProfile"      ; Use this one for xmlns
	      "http://www.omg.org/spec/UML/20131001/StandardProfile.xmi") ; Use this one for hrefs
 :documentation "Generated from http://www.omg.org/spec/UML/20131001/StandardProfile.xmi on 2012-08-31"
 :href-uri "http://www.omg.org/spec/UML/20131001/StandardProfile.xmi"
 :model-class 'mofi::profile
 :model-n+1 :uml25
 :classes-path (pod:lpath :models "uml/uml-std-profile-20131001.lisp")
 :href-uri "http://www.omg.org/spec/UML/20131001/StandardProfile.xmi"
 :ns-uri "http://www.omg.org/spec/UML/20131001/StandardProfile"      ; Use this one for xmlns
 :ns-prefix "StandardProfile")


#+nil
(mofi:ensure-model 
 :fuml :force t  :verbose t
 :nicknames '("FUML 1.0"
	      "http://www.omg.org/spec/FUML/20100301"
	      "http://www.omg.org/spec/FUML/20100301/UML.xmi")
 :features '(:miwg)
 :depends-on-models '(:ocl)
 :documentation "Created from 10-03-15-fuml-cleanup.cmof"
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :models "fuml/fuml.lisp")
 :postload-path (pod:lpath :models "fuml/fuml-postload.lisp")
 :ns-uri  "http://www.omg.org/spec/FUML/20100301"
 :ns-prefix "fuml")

#+nil ;; Retired 2014-04-26
(mofi:ensure-model 
 :uml22 :force t  :verbose t
 :nicknames '("UML 2.2" 
	      "http://schema.omg.org/spec/UML/2.2" 
	      "http://schema.omg.org/spec/UML/2.2/uml.xml")
 :features '(:miwg)
 :depends-on-models '(:ocl)
 :documentation "http://www.omg.org/cgi-bin/doc?ptc/08-05-12
Document -- ptc/08-05-12 (UML 2.2 machine readable file - Superstructure XMI)
Contact: Mr. Kenneth Hussey
The document is available in the following formats:
XMI_file 	(1510529 bytes) 	alternate"
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :models "uml/uml22.lisp")
 :postload-path (pod:lpath :models "uml/uml22-postload.lisp")
 :ns-uri "http://schema.omg.org/spec/UML/2.2" 
 :href-uri "http://schema.omg.org/spec/UML/2.2/uml.xml"
 :ns-prefix "uml")

#+nil
(ensure-model 
 :qudv :force t  :verbose t
 :features '(:miwg)
 :nicknames '("qudv"
	      "http://schema.omg.org/spec/QUDV") 
 :documentation "Created from magicdraw library si-definitions/QUDV.mdxml 2011-04-26."
 :model-class 'mofi:essential-compiled-model
 :depends-on-models '(:ocl :uml-profile-l2-20090901 :uml23)
 :classes-path (pod:lpath :models "qudv/qudv.lisp"))

(ensure-model 
 :sysml14 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("SysML1.4" ; I changed these 2013-04-09. See note from Ed S. 2013-03-28. 
	      "http://www.omg.org/spec/SysML/20131001/SysML"      ; <---- Use for xmlns.  Based on SPEC, not XMI!
	      "http://www.omg.org/spec/SysML/20131001/SysML.xmi") ; <---- Use for hrefs.
;;; Next two are typically set in popgen-erated .lisp
 :documentation "Created from http://www.omg.org/spec/SysML/20131001/SysML.xmi."
 :model-class 'mofi::profile
 :model-n+1 :uml25
 :depends-on-models '(:ocl :uml-profile-20131001 :uml25)
 :classes-path (pod:lpath :models "sysml/sysml-profile-14.lisp")
 :href-uri "http://www.omg.org/spec/SysML/20131001/SysML.xmi"
 :ns-uri "http://www.omg.org/spec/SysML/20131001/SysML"
 :ns-prefix "sysml")


;;; Nicolas:
;;; For SysML 1.3, nsPrefix="SysML" and the Package URI="http://www.omg.org/spec/SysML/20110919/SysML"
;;; Yes, the nsPrefix for an OMG normative profile follows the conventions specified in UML 2.4.1, 
;;; section 18.3.7 where the nsPrefix for the Profile is the name of the Profile itself.
;;; Therefore, the nsPrefix for the SysML Profile in 1.3 is SysML because SysML 1.3 is based on UML 2.4.1.

(ensure-model 
 :sysml13 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("SysML1.3" ; I changed these 2013-04-09. See note from Ed S. 2013-03-28. 
	      "http://www.omg.org/spec/SysML/20120322/SysML"      ; <---- Use for xmlns.  Based on SPEC, not XMI!
	      "http://www.omg.org/spec/SysML/20120401/SysML.xmi") ; <---- Use for hrefs.
;;; Next two are typically set in popgen-erated .lisp
 :documentation "Created from http://www.omg.org/spec/SysML/20110801/SysML.xmi."
 :model-class 'mofi::profile
 :model-n+1 :uml241
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml241 #|:qudv|#)
 :classes-path (pod:lpath :models "sysml/sysml-profile-13.lisp")
 :href-uri "http://www.omg.org/spec/SysML/20120401/SysML.xmi"
 :ns-uri "http://www.omg.org/spec/SysML/20120322/SysML"
 :ns-prefix "sysml")

;;; 2013-12-30: I used this to create sysml-profile-12.lisp Then I changed its n+1 to UML23
#+nil
(mofi:ensure-model 
 :uml4sysml12 :force t  :verbose t
 :nicknames '("UML4SysML" 
	      "http://www.omg.org/spec/SysML/20100301/UML4SysML" ; <---- Use for xmlns. 
	      "UML4SysML-metamodel.uml")                         ; <---- Use this one for hrefs
 :features '(:miwg)
 :depends-on-models '(:ocl)
 :documentation "Produced from sysml1-2-ptc20100301-v5/UML4SysML-metamodel.uml"
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :models "uml/uml4sysml12.lisp")
 :postload-path (pod:lpath :models "uml/um4sysml12-postload.lisp")
 :ns-uri "http://www.omg.org/spec/SysML/20100301/UML4SysML"
 :href-uri "UML4SysML-metamodel.uml"
 :ns-prefix "UML4SysML")


(ensure-model 
 :sysml12 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("SysML"
	      "http://www.omg.org/spec/SysML/20100301/SysML-profile"      ; <---- Use for xmlns.
              "http://www.omg.org/spec/SysML/20100301/SysML-profile.uml") ; <---- Use for hrefs.
;;; Next two are typically set in popgen-erated .lisp
;;; :ns-prefix "sysml"
;;; :ns-uri "http://www.omg.org/spec/SysML/20100301/SysML-profile"
 :documentation "Created from sysml1-2-ptc20100301-v5/sysml-profile.xmi." ; 20100301 is SysML 1.2.
 :model-class 'mofi::profile
 :model-n+1 :uml23
 :depends-on-models '(:ocl :uml-profile-l2-20090901 :uml23 #|:qudv|#)
 :classes-path (pod:lpath :models "sysml/sysml-profile-12.lisp")
 :href-uri "http://www.omg.org/spec/SysML/20100301/SysML-profile.uml"
 :ns-uri "http://www.omg.org/spec/SysML/20100301/SysML-profile"
 :ns-prefix "sysml")

(ensure-model 
 :soaml :force t  :verbose t
 :features '(:miwg)
 :nicknames '("SoaML"
	      "http://www.omg.org/spec/SoaML/20120501"                   ; <---- Use for xmlns/Based on SPEC, not XMI!
	      "http://www.omg.org/spec/SoaML/20120501/SoaMLProfile.xmi") ; <---- Use for hrefs.
;;; Next two are typically set in popgen-erated .lisp
 :documentation "Created 2012-04-23 from http://www.omg.org/spec/SoaML/20120201/SoaMLProfile.xmi." 
 :model-class 'mofi::profile
 :model-n+1 :uml23
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml23)
 :classes-path (pod:lpath :models "soaml/soaml-profile.lisp")
 :ns-uri "http://www.omg.org/spec/SoaML/20120501"
 :href-uri "http://www.omg.org/spec/SoaML/20120501/SoaMLProfile.xmi"
 :ns-prefix "SoaMLProfile")

#+nil
(ensure-model 
 :niem :force t  :verbose t
 :features '(:miwg)
 :nicknames '("NIEM"
	      "http://www.omg.org/spec/NIEM/20110810/NIEM-profile"     ; <---- Use for xmlns.
	      "http://www.omg.org/spec/NIEM/20110810/NIEM-profile.uml")     ; <---- Use for hrefs.
 :documentation "Created from Pete Rivett's file dated 2011-08-08."
 :model-class 'mofi::profile
 :depends-on-models '(:ocl :uml-profile-l2-20090901 :uml23 )
 :classes-path (pod:lpath :models "niem/niem.lisp")
 :ns-prefix "NIEM")

(ensure-model 
 :updm :force t  :verbose t
 :features '(:miwg)
 :nicknames '("UPDM2.0.1" ; 2013-04-08 was UPDM2.0. Pete says 2.0 was 'inherently wrong' or something like that.
	      "http://www.omg.org/spec/UPDM/20120301"
	      "http://www.omg.org/spec/UPDM/20120301/UPDM-Profile.xmi"
	      "http://www.omg.org/spec/UPDM/20120301/UPDM-Profile.xmi#UPDM") ; added 2013-12-30
 :documentation "Compiled 2013-04-11 using dtc/2012-09-10 XMI with hrefs to SoaML updated."
 :model-class 'mofi::profile
 :model-n+1 :uml23
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml23)
 :classes-path (pod:lpath :models "updm/updm.lisp")
 :ns-uri "http://www.omg.org/spec/UPDM/20120301"
 :href-uri "http://www.omg.org/spec/UPDM/20120301/UPDM-Profile.xmi"
 :ns-prefix "updm")

;;;==============================================================================
;;; ODM Stuff
;;;==============================================================================

(ensure-model 
 :rdf-profile :force t  :verbose t
 :features '(:miwg)
 :nicknames '("rdf-profile" 
	      "http://www.omg.org/spec/ODM/20131101/RDFProfile.xmi")
 :documentation "Compiled 2016-01-08 from ptc/13-08-05 RDFProfile"
 :model-class 'mofi::profile
 :model-n+1 :uml241
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml241)
 :classes-path (pod:lpath :models "odm/13-11-01/rdf-profile.lisp")
 :ns-uri "http://www.omg.org/spec/ODM/20131101/RDFProfile.xmi"
 :href-uri "http://www.omg.org/spec/ODM/20131101/RDFProfile.xmi"
 :ns-prefix "RDFProfile")

(ensure-model 
 :owl-profile :force t  :verbose t
 :features '(:miwg)
 :nicknames '("owl-profile" 
	      "http://www.omg.org/spec/ODM/20131101/OWLProfile.xmi")
 :documentation "Compiled 2016-01-08 from ptc/13-08-05 OWLProfile"
 :model-class 'mofi::profile
 :model-n+1 :uml241
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml241)
 :classes-path (pod:lpath :models "odm/13-11-01/owl-profile.lisp")
 :ns-uri "http://www.omg.org/spec/ODM/20131101/OWLProfile.xmi"
 :href-uri "http://www.omg.org/spec/ODM/20131101/OWLProfile.xmi"
 :ns-prefix "OWLProfile")


(ensure-model 
 :ODM :force t  :verbose t
 :features '(:miwg)
 :nicknames '("ODM1.1" 
	      "http://www.omg.org/spec/ODM/20131101/ODM-metamodels.xmi") 
 :documentation "Compiled 2016-01-06 using ptc/13-08-04 sans Example_1, Example_2 (not investigated)."
 :model-class 'mofi:essential-compiled-model
 :model-n+1 :uml241
 :depends-on-models '(:ocl :uml241)
 :classes-path (pod:lpath :models "odm/13-11-01/odm-13-11-01.lisp")
 :postload-path (pod:lpath :models "odm/13-11-01/odm-13-11-01-postload.lisp")
 :ns-uri "http://www.omg.org/spec/ODM/20131101/ODM-metamodels.xmi"
 :href-uri "http://www.omg.org/spec/ODM/20131101/ODM-metamodels.xmi"
 :ns-prefix "odm")

(ensure-model 
 :updm21 :force t  :verbose t
 :features '(:miwg)
 :nicknames '("UPDM2.1"
	      "http://www.omg.org/spec/UPDM/20121004"
	      "http://www.omg.org/spec/UPDM/20121004/UPDM-Profile.xmi")
 :documentation "Compiled from not-yet-AB-reviewed 20121004 document."
 :model-class 'mofi::profile
 :model-n+1 :uml23
 :depends-on-models '(:ocl :uml-profile-l2-20110701 :uml23)
 :classes-path (pod:lpath :models "updm/updm-my-2012-11-09.lisp")
 :ns-uri "http://www.omg.org/spec/UPDM/20121004"
 :href-uri "http://www.omg.org/spec/UPDM/20121004/UPDM-Profile.xmi"
 :ns-prefix "updm")

(ensure-model 
 :upr :force t :verbose t
 :features '(:miwg)
 :nicknames '("UPR"
	      "http://www.omg.org/spec/ROSETTA/20170805"               ; <---- Use for xmlns/Based on SPEC, not XMI!
	      "http://www.omg.org/spec/ROSETTA/20170805/Profile.xmi")  ; <---- Use for hrefs.
 :documentation "Compiled from 'December XMI'."
 :model-class 'mofi::profile
 :model-n+1 :uml25
 :depends-on-models '(:ocl :uml-profile-20131001 :uml25)
 :classes-path (pod:lpath :models "upr/upr-december.lisp")
 :ns-uri   "http://www.omg.org/spec/ROSETTA/20170805"
 :href-uri "http://www.omg.org/spec/ROSETTA/20170805/Profile.xmi"
 :ns-prefix "upr")

(ensure-model 
 :upra :force t :verbose t
 :features '(:miwg)
 :nicknames '("UPRA"
	      "http://www.omg.org/spec/MARS/20170805/ROSETTA"               ; <---- Use for xmlns/Based on SPEC, not XMI!
	      "http://www.omg.org/spec/MARS/20170805/ROSETTA/Profile.xmi")  ; <---- Use for hrefs.
 :documentation "Compiled from 'August XMI'."
 :model-class 'mofi::profile
 :model-n+1 :uml25
 :depends-on-models '(:ocl :uml-profile-20131001 :uml25)
 :classes-path (pod:lpath :models "upr/upr-august.lisp")
 :ns-uri   "http://www.omg.org/spec/MARS/20170805/ROSETTA"
 :href-uri "http://www.omg.org/spec/MARS/20170805/ROSETTA/Profile.xmi"
 :ns-prefix "upr")



;;; This one is used with Conrad's work
#+nil
(ensure-model 
 :bpmn :force t  :verbose t
 :features '(:miwg)
 :nicknames '("BPMN"
	      "http://www.omg.org/spec/BPMN/20100524/"
	      "http://www.omg.org/spec/BPMN/20100524/MODEL-XMI")
 :documentation "Created from data/bpmn/2010-05-04/XMI/bpmn20.cmof 2012-01-18."
 :model-class 'mofi:essential-compiled-model
 :href-uri "http://www.omg.org/spec/BPMN/20100524/MODEL-XMI"
 :depends-on-models '(:ocl :uml23)
 :classes-path (pod:lpath :models "bpmn/bpmn.lisp"))


;;; Commented out 2012-11-02 (I assume it is no longer used.)
;;; This one is used with Conrad's work
#+nil
(ensure-model 
 :bpmnpro :force t  :verbose t
 :features '(:miwg)
 :nicknames '("BPMNPRO"
	      "http://schema.nist.gov/validator/bpmnpro/")
 :documentation "Created from Conrad's 10i MD file 2012-01-27."
 :model-class 'mofi::profile
 :depends-on-models '(:ocl :uml23)
 :classes-path (pod:lpath :models "bpmn/bpmn-profile/bpmnpro.lisp")
 :ns-uri "http://schema.nist.gov/validator/bpmnpro/"
 :ns-prefix "bpmnpro")


;;; Commented 2012-11-02. I think I used this in supply chain simulation
;;; ;http://www.magicdraw.com/schemas/BPMN2_Profile.xmi
#+nil
(ensure-model 
 :bpmn-p :force t  :verbose t
 :features '(:miwg) ; TEMPORARAY
 :nicknames '("bpmn"
	      "BPMN"
	      "http://www.magicdraw.com/schemas/BPMN2_Profile.xmi"
	      "http://www.magicdraw.com/schemas/Choreography.xmi" ; xmlns:Choreography
              "http://www.magicdraw.com/schemas/Common.xmi"       ; xmlns:Common
	      "http://www.magicdraw.com/schemas/Data.xmi"         ; xmlns:Data
              "http://www.magicdraw.com/schemas/Process.xmi"      ; xmlns:Process
              "http://www.magicdraw.com/schemas/Events.xmi"       ; xmlns:Events
              "http://www.magicdraw.com/schemas/Activities.xmi"   ; xmlns:Activities
              "http://www.magicdraw.com/schemas/Gateways.xmi"     ; xmlns:Gateways
;	      "BPMN2 Profile.mdzip#_16_0_8740266_1237636384672_499078_365"
;	      "BPMN2 Customization.mdzip#_16_6beta_932808f3_1253625256628_88373_432"
;	      "BPMN2 Constraints.mdzip#_16_8beta_8740266_1261484630687_217688_1428"
	      )
 :documentation "Created from a Magicdraw file that was run through cleaner.lisp
                 (see that directory) to produce ~/projects/cre/source/models/bpmn2/bpmn2-profile-clean.xmi
                 which was the file used by pop-gen. I then changed all UML23
                 references to UML241 (not investigated). Note that there are lots of
                 unnamed soft-opposite slots."
 :model-class 'mofi::profile
 :depends-on-models '(:ocl :uml241)
 :classes-path (pod:lpath :models "bpmn/bpmn-profile.lisp"))
