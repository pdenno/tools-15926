(in-package :mofi)


(ensure-model 
 :odm :force t  :verbose t 
 :features '(:always)
 :depends-on-models '(:ocl)
 :documentation "From XMI 08-09-08-owl-rdf-cmof-clean.xmi 
                   (http://www.omg.org/cgi-bin/doc?ptc/2008-09-08). Created 2011-12-27.
                 2022: Might be newer, I see it was created in 2016."
 :model-class 'mofi:essential-compiled-model ; 2022 was just models/odm.lis models/odm-postload.lisp
 :classes-path  (pod:lpath :models "odm/2013-11-01/odm-2013-11-01.lisp")
 :postload-path (pod:lpath :models "odm/2013-11-01/odm-2013-11-01-postload.lisp"))

(ensure-model 
 :bpmn-p :force t  :verbose t
 :features '(:cre)
 :nicknames '("bpmn"
	      "BPMN"
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

(push-last "http://www.nomagic.com/magicdraw/UML/2.4.1" (nicknames (find-model :uml241)))

(ensure-model 
 :uml-profile-l2-20090901 :force t  :verbose t
 :features '(:cre)
 :nicknames '("StandardProfileL2-20090901" 
	      "http://www.omg.org/spec/UML/20090901/StandardProfileL2"      ; Use this one for xmlns
	      "http://www.omg.org/spec/UML/20090901/StandardProfileL2.xmi") ; Use this one for hrefs
 :documentation "Generated from ptc/10-08-22.xmi for UML 2.4"
 :ns-prefix "StandardProfileL2"
 :ns-uri "http://www.omg.org/spec/UML/20090901/StandardProfileL2"      ; Use this one for xmlns
 :href-uri "http://www.omg.org/spec/UML/20090901/StandardProfileL2.xmi"
 :model-class 'mofi::profile
 :classes-path (pod:lpath :models "uml/uml-std-profile-l2-20090901.lisp"))

;;; 2022 Really??? (I need SysML and BPMN?)
(ensure-model 
 :sysml12 :force t  :verbose t
 :features '(:cre)
 :nicknames '("SysML"
	      "http://www.omg.org/spec/SysML/20100301/SysML-profile"     ; <---- Use for xmlns.
	      "http://www.omg.org/spec/SysML/20100301/SysML-profile.uml") ; <---- Use for hrefs.
;;; Next two are typically set in popgen-erated .lisp
;;; :ns-prefix "sysml"
;;; :ns-uri "http://www.omg.org/spec/SysML/20100301/SysML-profile"
 :documentation "Created from sysml1-2-ptc20100301-v5/sysml-profile.xmi." ; 20100301 is SysML 1.2.
 :model-class 'mofi::profile
 :depends-on-models '(:ocl :uml-profile-l2-20090901 :uml23 #|:qudv|#)
 :classes-path (pod:lpath :models "sysml/sysml-profile-12.lisp"))

;;; 2022 Temporary, probably
#+nil(ensure-model 
  :MEXICO :force t
  :features '(:always)
  :nicknames '("exp"
	       "http://www.omg.org/spec/EXPRESS/1.0"             ;<---- Use this one for xmlns.
	       "http://www.omg.org/spec/EXPRESS/1.0/mexico.xmi") ;<---- Use this one for hrefs with 
  :ns-prefix "exp"
  :ns-uri    "http://www.omg.org/spec/EXPRESS/1.0"       
  :model-class 'mofi:essential-lexical-model
  :shadow-list '(ocl:|Variable|)
  :package-use-list '(:cl :pod :ocl :mofi)
  :shadowing-import-from '(:ocl "VALUE")
  :documentation "Possibly created from exp-rfc-mantis-08-02-03.xmi My comments in the file
                  show my .lisp as created 2008-03-21."
  :reserved-words '("ABSTRACT" "ANDOR" "AS" "BASED_ON" "BY" "CONTEXT" "DERIVE"
		    "END_CONTEXT" "END_LOCAL" "END_MODEL" "EXTENSIBLE" 
		    "ENUMERATION" "FIXED" "FOR" "FROM" "INVERSE" "LOCAL" "MODEL"
		    "NOT" "OF" "ONEOF" "OPTIONAL" "OTHERWISE" "QUERY" "REFERENCE" 
		    "RENAMED" "SELECT" "SUBTYPE" "SUPERTYPE" "THEN" "TO" "UNIQUE" 
		    "UNTIL" "USE" "VAR" "WHERE" "WHILE" "WITH" 
		    ;; declarations
		    "CONSTANT" "ENTITY" "FUNCTION" "PROCEDURE" "RULE" "SCHEMA" "TYPE"
		    "END_CONSTANT" "END_ENTITY" "END_FUNCTION" "END_PROCEDURE" "END_RULE"
		    "END_SCHEMA" "END_TYPE" "SUBTYPE_CONSTRAINT" "END_SUBTYPE_CONSTRAINT"
		    ;; statements
		    "ALIAS" "END_ALIAS" "CASE" "END_CASE" "BEGIN" "END" "ESCAPE" "IF" 
		    "ELSE" "END_IF" "REPEAT" "END_REPEAT" "RETURN" "SKIP"
		    ;; from Express-X
		    "EACH" "ELSIF" "IDENTIFIED_BY" "INDEXING" "ORDERED_BY" "PARTITION"
		    "SOURCE" "TARGET" "DEPENDENT_MAP" "MAP" "SCHEMA_MAP" "SCHEMA_VIEW" 
		    "VIEW" "EXTENT" "END_DEPENDENT_MAP" "END_MAP" "END_SCHEMA_MAP"
		    "END_SCHEMA_VIEW" "END_VIEW"
		    ;; constant strings
		    "CONST_E" "PI" "SELF" "FALSE" "TRUE" "UNKNOWN"
		    ;; operator strings
		    "ABS" "ACOS" "ASIN" "ATAN" "BLENGTH" "COS" "EXISTS" "EXP" "FORMAT" 
		    "HIBOUND" "HIINDEX" "LENGTH" "LOBOUND" "LOINDEX" "LOG" "LOG2" "LOG10" 
		    "NVL" "ODD" "ROLESOF" "SIN" "SIZEOF" "SQRT" "TAN" "TYPEOF" "USEDIN" 
		    "VALUE" "VALUE_IN" "VALUE_UNIQUE" "IN" "LIKE" "OR" "XOR" "DIV" "MOD" 
		    "AND" "INSERT" "REMOVE"
		    ;; type strings 
		    "AGGREGATE" "ARRAY" "BAG" "BINARY" "BOOLEAN" "GENERIC" "GENERIC_ENTITY" 
		    "INTEGER" "LIST" "LOGICAL" "NUMBER" "REAL" "SET" "STRING")
  :constant-strings '("CONST_E" "PI" "SELF" "FALSE" "TRUE" "UNKNOWN")
  :operator-strings '("ABS" "ACOS" "ASIN" "ATAN" "BLENGTH" "COS" "EXISTS" "EXP" "FORMAT" 
		      "HIBOUND" "HIINDEX" "LENGTH" "LOBOUND" "LOINDEX" "LOG" "LOG2" "LOG10" 
		      "NVL" "ODD" "ROLESOF" "SIN" "SIZEOF" "SQRT" "TAN" "TYPEOF" "USEDIN" 
		      "VALUE" "VALUE_IN" "VALUE_UNIQUE" "IN" "LIKE" "OR" "XOR" "DIV" "MOD" 
		      "AND" "INSERT" "REMOVE")
  :classes-path (pod:lpath :models "step/mexico.lisp"))



