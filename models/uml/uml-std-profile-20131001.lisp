;;; Automatically created by pop-gen at 2013-12-17 16:17:39.
;;; Source file is StandardProfile-10131001.xmi

(in-package :UML-PROFILE-20131001)



;;; =========================================================
;;; ====================== Auxiliary
;;; =========================================================
(def-meta-stereotype |Auxiliary| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "Auxiliary")
 ""
  ((|base_Class| :xmi-id "Auxiliary-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Auxiliary"      
  :name |Class_Auxiliary|      
  :metatype :extension      
  :member-ends (("Class_Auxiliary-extension_Auxiliary" "extension_Auxiliary")
                (|Auxiliary| "base_Class"))      
  :owned-ends  (("Class_Auxiliary-extension_Auxiliary" "extension_Auxiliary")))

(def-meta-assoc-end "Class_Auxiliary-extension_Auxiliary" 
    :type |Auxiliary| 
    :multiplicity (1 1) 
    :association "Class_Auxiliary" 
    :name "extension_Auxiliary" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== BuildComponent
;;; =========================================================
(def-meta-stereotype |BuildComponent| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "BuildComponent")
 ""
  ((|base_Component| :xmi-id "BuildComponent-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_BuildComponent"      
  :name |Component_BuildComponent|      
  :metatype :extension      
  :member-ends (("Component_BuildComponent-extension_BuildComponent" "extension_BuildComponent")
                (|BuildComponent| "base_Component"))      
  :owned-ends  (("Component_BuildComponent-extension_BuildComponent" "extension_BuildComponent")))

(def-meta-assoc-end "Component_BuildComponent-extension_BuildComponent" 
    :type |BuildComponent| 
    :multiplicity (1 1) 
    :association "Component_BuildComponent" 
    :name "extension_BuildComponent" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Call
;;; =========================================================
(def-meta-stereotype |Call| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Usage|)
 :packages (|StandardProfile|) 
 :xmi-id "Call")
 ""
  ((|base_Usage| :xmi-id "Call-base_Usage" :range UML25:|Usage| :multiplicity (1 1))))

(def-meta-assoc "Usage_Call"      
  :name |Usage_Call|      
  :metatype :extension      
  :member-ends (("Usage_Call-extension_Call" "extension_Call")
                (|Call| "base_Usage"))      
  :owned-ends  (("Usage_Call-extension_Call" "extension_Call")))

(def-meta-assoc-end "Usage_Call-extension_Call" 
    :type |Call| 
    :multiplicity (1 1) 
    :association "Usage_Call" 
    :name "extension_Call" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Create
;;; =========================================================
(def-meta-stereotype |Create| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|BehavioralFeature| UML25:|Usage|)
 :packages (|StandardProfile|) 
 :xmi-id "Create")
 ""
  ((|base_BehavioralFeature| :xmi-id "Create-base_BehavioralFeature" :range UML25:|BehavioralFeature| :multiplicity (1 1))
   (|base_Usage| :xmi-id "Create-base_Usage" :range UML25:|Usage| :multiplicity (1 1))))

(def-meta-assoc "BehavioralFeature_Create"      
  :name |BehavioralFeature_Create|      
  :metatype :extension      
  :member-ends (("BehavioralFeature_Create-extension_Create" "extension_Create")
                (|Create| "base_BehavioralFeature"))      
  :owned-ends  (("BehavioralFeature_Create-extension_Create" "extension_Create")))

(def-meta-assoc-end "BehavioralFeature_Create-extension_Create" 
    :type |Create| 
    :multiplicity (1 1) 
    :association "BehavioralFeature_Create" 
    :name "extension_Create" 
    :aggregation :COMPOSITE)

(def-meta-assoc "Usage_Create"      
  :name |Usage_Create|      
  :metatype :extension      
  :member-ends (("Usage_Create-extension_Create" "extension_Create")
                (|Create| "base_Usage"))      
  :owned-ends  (("Usage_Create-extension_Create" "extension_Create")))

(def-meta-assoc-end "Usage_Create-extension_Create" 
    :type |Create| 
    :multiplicity (1 1) 
    :association "Usage_Create" 
    :name "extension_Create" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Derive
;;; =========================================================
(def-meta-stereotype |Derive| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Abstraction|)
 :packages (|StandardProfile|) 
 :xmi-id "Derive")
 ""
  ((|base_Abstraction| :xmi-id "Derive-base_Abstraction" :range UML25:|Abstraction| :multiplicity (1 1))))

(def-meta-assoc "Abstraction_Derive"      
  :name |Abstraction_Derive|      
  :metatype :extension      
  :member-ends (("Abstraction_Derive-extension_Derive" "extension_Derive")
                (|Derive| "base_Abstraction"))      
  :owned-ends  (("Abstraction_Derive-extension_Derive" "extension_Derive")))

(def-meta-assoc-end "Abstraction_Derive-extension_Derive" 
    :type |Derive| 
    :multiplicity (1 1) 
    :association "Abstraction_Derive" 
    :name "extension_Derive" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Destroy
;;; =========================================================
(def-meta-stereotype |Destroy| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|BehavioralFeature|)
 :packages (|StandardProfile|) 
 :xmi-id "Destroy")
 ""
  ((|base_BehavioralFeature| :xmi-id "Destroy-base_BehavioralFeature" :range UML25:|BehavioralFeature| :multiplicity (1 1))))

(def-meta-assoc "BehavioralFeature_Destroy"      
  :name |BehavioralFeature_Destroy|      
  :metatype :extension      
  :member-ends (("BehavioralFeature_Destroy-extension_Destroy" "extension_Destroy")
                (|Destroy| "base_BehavioralFeature"))      
  :owned-ends  (("BehavioralFeature_Destroy-extension_Destroy" "extension_Destroy")))

(def-meta-assoc-end "BehavioralFeature_Destroy-extension_Destroy" 
    :type |Destroy| 
    :multiplicity (1 1) 
    :association "BehavioralFeature_Destroy" 
    :name "extension_Destroy" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Document
;;; =========================================================
(def-meta-stereotype |Document| 
   (:model :UML-PROFILE-20131001 :superclasses (|File|) :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "Document")
 ""
  ((|base_Artifact| :xmi-id "Document-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_Document"      
  :name |Artifact_Document|      
  :metatype :extension      
  :member-ends (("Artifact_Document-extension_Document" "extension_Document")
                (|Document| "base_Artifact"))      
  :owned-ends  (("Artifact_Document-extension_Document" "extension_Document")))

(def-meta-assoc-end "Artifact_Document-extension_Document" 
    :type |Document| 
    :multiplicity (1 1) 
    :association "Artifact_Document" 
    :name "extension_Document" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Entity
;;; =========================================================
(def-meta-stereotype |Entity| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "Entity")
 ""
  ((|base_Component| :xmi-id "Entity-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_Entity"      
  :name |Component_Entity|      
  :metatype :extension      
  :member-ends (("Component_Entity-extension_Entity" "extension_Entity")
                (|Entity| "base_Component"))      
  :owned-ends  (("Component_Entity-extension_Entity" "extension_Entity")))

(def-meta-assoc-end "Component_Entity-extension_Entity" 
    :type |Entity| 
    :multiplicity (1 1) 
    :association "Component_Entity" 
    :name "extension_Entity" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Executable
;;; =========================================================
(def-meta-stereotype |Executable| 
   (:model :UML-PROFILE-20131001 :superclasses (|File|) :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "Executable")
 ""
  ((|base_Artifact| :xmi-id "Executable-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_Executable"      
  :name |Artifact_Executable|      
  :metatype :extension      
  :member-ends (("Artifact_Executable-extension_Executable" "extension_Executable")
                (|Executable| "base_Artifact"))      
  :owned-ends  (("Artifact_Executable-extension_Executable" "extension_Executable")))

(def-meta-assoc-end "Artifact_Executable-extension_Executable" 
    :type |Executable| 
    :multiplicity (1 1) 
    :association "Artifact_Executable" 
    :name "extension_Executable" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== File
;;; =========================================================
(def-meta-stereotype |File| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "File")
 ""
  ((|base_Artifact| :xmi-id "File-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_File"      
  :name |Artifact_File|      
  :metatype :extension      
  :member-ends (("Artifact_File-extension_File" "extension_File")
                (|File| "base_Artifact"))      
  :owned-ends  (("Artifact_File-extension_File" "extension_File")))

(def-meta-assoc-end "Artifact_File-extension_File" 
    :type |File| 
    :multiplicity (1 1) 
    :association "Artifact_File" 
    :name "extension_File" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Focus
;;; =========================================================
(def-meta-stereotype |Focus| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "Focus")
 ""
  ((|base_Class| :xmi-id "Focus-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Focus"      
  :name |Class_Focus|      
  :metatype :extension      
  :member-ends (("Class_Focus-extension_Focus" "extension_Focus")
                (|Focus| "base_Class"))      
  :owned-ends  (("Class_Focus-extension_Focus" "extension_Focus")))

(def-meta-assoc-end "Class_Focus-extension_Focus" 
    :type |Focus| 
    :multiplicity (1 1) 
    :association "Class_Focus" 
    :name "extension_Focus" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Framework
;;; =========================================================
(def-meta-stereotype |Framework| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Package|)
 :packages (|StandardProfile|) 
 :xmi-id "Framework")
 ""
  ((|base_Package| :xmi-id "Framework-base_Package" :range UML25:|Package| :multiplicity (1 1))))

(def-meta-assoc "Package_Framework"      
  :name |Package_Framework|      
  :metatype :extension      
  :member-ends (("Package_Framework-extension_Framework" "extension_Framework")
                (|Framework| "base_Package"))      
  :owned-ends  (("Package_Framework-extension_Framework" "extension_Framework")))

(def-meta-assoc-end "Package_Framework-extension_Framework" 
    :type |Framework| 
    :multiplicity (1 1) 
    :association "Package_Framework" 
    :name "extension_Framework" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Implement
;;; =========================================================
(def-meta-stereotype |Implement| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "Implement")
 ""
  ((|base_Component| :xmi-id "Implement-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_Implement"      
  :name |Component_Implement|      
  :metatype :extension      
  :member-ends (("Component_Implement-extension_Implement" "extension_Implement")
                (|Implement| "base_Component"))      
  :owned-ends  (("Component_Implement-extension_Implement" "extension_Implement")))

(def-meta-assoc-end "Component_Implement-extension_Implement" 
    :type |Implement| 
    :multiplicity (1 1) 
    :association "Component_Implement" 
    :name "extension_Implement" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ImplementationClass
;;; =========================================================
(def-meta-stereotype |ImplementationClass| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "ImplementationClass")
 ""
  ((|base_Class| :xmi-id "ImplementationClass-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_ImplementationClass"      
  :name |Class_ImplementationClass|      
  :metatype :extension      
  :member-ends (("Class_ImplementationClass-extension_ImplementationClass" "extension_ImplementationClass")
                (|ImplementationClass| "base_Class"))      
  :owned-ends  (("Class_ImplementationClass-extension_ImplementationClass" "extension_ImplementationClass")))

(def-meta-assoc-end "Class_ImplementationClass-extension_ImplementationClass" 
    :type |ImplementationClass| 
    :multiplicity (1 1) 
    :association "Class_ImplementationClass" 
    :name "extension_ImplementationClass" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Instantiate
;;; =========================================================
(def-meta-stereotype |Instantiate| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Usage|)
 :packages (|StandardProfile|) 
 :xmi-id "Instantiate")
 ""
  ((|base_Usage| :xmi-id "Instantiate-base_Usage" :range UML25:|Usage| :multiplicity (1 1))))

(def-meta-assoc "Usage_Instantiate"      
  :name |Usage_Instantiate|      
  :metatype :extension      
  :member-ends (("Usage_Instantiate-extension_Instantiate" "extension_Instantiate")
                (|Instantiate| "base_Usage"))      
  :owned-ends  (("Usage_Instantiate-extension_Instantiate" "extension_Instantiate")))

(def-meta-assoc-end "Usage_Instantiate-extension_Instantiate" 
    :type |Instantiate| 
    :multiplicity (1 1) 
    :association "Usage_Instantiate" 
    :name "extension_Instantiate" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Library
;;; =========================================================
(def-meta-stereotype |Library| 
   (:model :UML-PROFILE-20131001 :superclasses (|File|) :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "Library")
 ""
  ((|base_Artifact| :xmi-id "Library-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_Library"      
  :name |Artifact_Library|      
  :metatype :extension      
  :member-ends (("Artifact_Library-extension_Library" "extension_Library")
                (|Library| "base_Artifact"))      
  :owned-ends  (("Artifact_Library-extension_Library" "extension_Library")))

(def-meta-assoc-end "Artifact_Library-extension_Library" 
    :type |Library| 
    :multiplicity (1 1) 
    :association "Artifact_Library" 
    :name "extension_Library" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Metaclass
;;; =========================================================
(def-meta-stereotype |Metaclass| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "Metaclass")
 ""
  ((|base_Class| :xmi-id "Metaclass-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Metaclass"      
  :name |Class_Metaclass|      
  :metatype :extension      
  :member-ends (("Class_Metaclass-extension_Metaclass" "extension_Metaclass")
                (|Metaclass| "base_Class"))      
  :owned-ends  (("Class_Metaclass-extension_Metaclass" "extension_Metaclass")))

(def-meta-assoc-end "Class_Metaclass-extension_Metaclass" 
    :type |Metaclass| 
    :multiplicity (1 1) 
    :association "Class_Metaclass" 
    :name "extension_Metaclass" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Metamodel
;;; =========================================================
(def-meta-stereotype |Metamodel| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Model|)
 :packages (|StandardProfile|) 
 :xmi-id "Metamodel")
 ""
  ((|base_Model| :xmi-id "Metamodel-base_Model" :range UML25:|Model| :multiplicity (1 1))))

(def-meta-assoc "Model_Metamodel"      
  :name |Model_Metamodel|      
  :metatype :extension      
  :member-ends (("Model_Metamodel-extension_Metamodel" "extension_Metamodel")
                (|Metamodel| "base_Model"))      
  :owned-ends  (("Model_Metamodel-extension_Metamodel" "extension_Metamodel")))

(def-meta-assoc-end "Model_Metamodel-extension_Metamodel" 
    :type |Metamodel| 
    :multiplicity (1 1) 
    :association "Model_Metamodel" 
    :name "extension_Metamodel" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== ModelLibrary
;;; =========================================================
(def-meta-stereotype |ModelLibrary| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Package|)
 :packages (|StandardProfile|) 
 :xmi-id "ModelLibrary")
 ""
  ((|base_Package| :xmi-id "ModelLibrary-base_Package" :range UML25:|Package| :multiplicity (1 1))))

(def-meta-assoc "Package_ModelLibrary"      
  :name |Package_ModelLibrary|      
  :metatype :extension      
  :member-ends (("Package_ModelLibrary-extension_ModelLibrary" "extension_ModelLibrary")
                (|ModelLibrary| "base_Package"))      
  :owned-ends  (("Package_ModelLibrary-extension_ModelLibrary" "extension_ModelLibrary")))

(def-meta-assoc-end "Package_ModelLibrary-extension_ModelLibrary" 
    :type |ModelLibrary| 
    :multiplicity (1 1) 
    :association "Package_ModelLibrary" 
    :name "extension_ModelLibrary" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Process
;;; =========================================================
(def-meta-stereotype |Process| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "Process")
 ""
  ((|base_Component| :xmi-id "Process-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_Process"      
  :name |Component_Process|      
  :metatype :extension      
  :member-ends (("Component_Process-extension_Process" "extension_Process")
                (|Process| "base_Component"))      
  :owned-ends  (("Component_Process-extension_Process" "extension_Process")))

(def-meta-assoc-end "Component_Process-extension_Process" 
    :type |Process| 
    :multiplicity (1 1) 
    :association "Component_Process" 
    :name "extension_Process" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Realization
;;; =========================================================
(def-meta-stereotype |Realization| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Classifier|)
 :packages (|StandardProfile|) 
 :xmi-id "Realization")
 ""
  ((|base_Classifier| :xmi-id "Realization-base_Classifier" :range UML25:|Classifier| :multiplicity (1 1))))

(def-meta-assoc "Classifier_Realization"      
  :name |Classifier_Realization|      
  :metatype :extension      
  :member-ends (("Classifier_Realization-extension_Realization" "extension_Realization")
                (|Realization| "base_Classifier"))      
  :owned-ends  (("Classifier_Realization-extension_Realization" "extension_Realization")))

(def-meta-assoc-end "Classifier_Realization-extension_Realization" 
    :type |Realization| 
    :multiplicity (1 1) 
    :association "Classifier_Realization" 
    :name "extension_Realization" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Refine
;;; =========================================================
(def-meta-stereotype |Refine| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Abstraction|)
 :packages (|StandardProfile|) 
 :xmi-id "Refine")
 ""
  ((|base_Abstraction| :xmi-id "Refine-base_Abstraction" :range UML25:|Abstraction| :multiplicity (1 1))))

(def-meta-assoc "Abstraction_Refine"      
  :name |Abstraction_Refine|      
  :metatype :extension      
  :member-ends (("Abstraction_Refine-extension_Refine" "extension_Refine")
                (|Refine| "base_Abstraction"))      
  :owned-ends  (("Abstraction_Refine-extension_Refine" "extension_Refine")))

(def-meta-assoc-end "Abstraction_Refine-extension_Refine" 
    :type |Refine| 
    :multiplicity (1 1) 
    :association "Abstraction_Refine" 
    :name "extension_Refine" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Responsibility
;;; =========================================================
(def-meta-stereotype |Responsibility| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Usage|)
 :packages (|StandardProfile|) 
 :xmi-id "Responsibility")
 ""
  ((|base_Usage| :xmi-id "Responsibility-base_Usage" :range UML25:|Usage| :multiplicity (1 1))))

(def-meta-assoc "Usage_Responsibility"      
  :name |Usage_Responsibility|      
  :metatype :extension      
  :member-ends (("Usage_Responsibility-extension_Responsibility" "extension_Responsibility")
                (|Responsibility| "base_Usage"))      
  :owned-ends  (("Usage_Responsibility-extension_Responsibility" "extension_Responsibility")))

(def-meta-assoc-end "Usage_Responsibility-extension_Responsibility" 
    :type |Responsibility| 
    :multiplicity (1 1) 
    :association "Usage_Responsibility" 
    :name "extension_Responsibility" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Script
;;; =========================================================
(def-meta-stereotype |Script| 
   (:model :UML-PROFILE-20131001 :superclasses (|File|) :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "Script")
 ""
  ((|base_Artifact| :xmi-id "Script-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_Script"      
  :name |Artifact_Script|      
  :metatype :extension      
  :member-ends (("Artifact_Script-extension_Script" "extension_Script")
                (|Script| "base_Artifact"))      
  :owned-ends  (("Artifact_Script-extension_Script" "extension_Script")))

(def-meta-assoc-end "Artifact_Script-extension_Script" 
    :type |Script| 
    :multiplicity (1 1) 
    :association "Artifact_Script" 
    :name "extension_Script" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Send
;;; =========================================================
(def-meta-stereotype |Send| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Usage|)
 :packages (|StandardProfile|) 
 :xmi-id "Send")
 ""
  ((|base_Usage| :xmi-id "Send-base_Usage" :range UML25:|Usage| :multiplicity (1 1))))

(def-meta-assoc "Usage_Send"      
  :name |Usage_Send|      
  :metatype :extension      
  :member-ends (("Usage_Send-extension_Send" "extension_Send")
                (|Send| "base_Usage"))      
  :owned-ends  (("Usage_Send-extension_Send" "extension_Send")))

(def-meta-assoc-end "Usage_Send-extension_Send" 
    :type |Send| 
    :multiplicity (1 1) 
    :association "Usage_Send" 
    :name "extension_Send" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Service
;;; =========================================================
(def-meta-stereotype |Service| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "Service")
 ""
  ((|base_Component| :xmi-id "Service-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_Service"      
  :name |Component_Service|      
  :metatype :extension      
  :member-ends (("Component_Service-extension_Service" "extension_Service")
                (|Service| "base_Component"))      
  :owned-ends  (("Component_Service-extension_Service" "extension_Service")))

(def-meta-assoc-end "Component_Service-extension_Service" 
    :type |Service| 
    :multiplicity (1 1) 
    :association "Component_Service" 
    :name "extension_Service" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Source
;;; =========================================================
(def-meta-stereotype |Source| 
   (:model :UML-PROFILE-20131001 :superclasses (|File|) :extends (UML25:|Artifact|)
 :packages (|StandardProfile|) 
 :xmi-id "Source")
 ""
  ((|base_Artifact| :xmi-id "Source-base_Artifact" :range UML25:|Artifact| :multiplicity (1 1))))

(def-meta-assoc "Artifact_Source"      
  :name |Artifact_Source|      
  :metatype :extension      
  :member-ends (("Artifact_Source-extension_Source" "extension_Source")
                (|Source| "base_Artifact"))      
  :owned-ends  (("Artifact_Source-extension_Source" "extension_Source")))

(def-meta-assoc-end "Artifact_Source-extension_Source" 
    :type |Source| 
    :multiplicity (1 1) 
    :association "Artifact_Source" 
    :name "extension_Source" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Specification
;;; =========================================================
(def-meta-stereotype |Specification| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Classifier|)
 :packages (|StandardProfile|) 
 :xmi-id "Specification")
 ""
  ((|base_Classifier| :xmi-id "Specification-base_Classifier" :range UML25:|Classifier| :multiplicity (1 1))))

(def-meta-assoc "Classifier_Specification"      
  :name |Classifier_Specification|      
  :metatype :extension      
  :member-ends (("Classifier_Specification-extension_Specification" "extension_Specification")
                (|Specification| "base_Classifier"))      
  :owned-ends  (("Classifier_Specification-extension_Specification" "extension_Specification")))

(def-meta-assoc-end "Classifier_Specification-extension_Specification" 
    :type |Specification| 
    :multiplicity (1 1) 
    :association "Classifier_Specification" 
    :name "extension_Specification" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Subsystem
;;; =========================================================
(def-meta-stereotype |Subsystem| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Component|)
 :packages (|StandardProfile|) 
 :xmi-id "Subsystem")
 ""
  ((|base_Component| :xmi-id "Subsystem-base_Component" :range UML25:|Component| :multiplicity (1 1))))

(def-meta-assoc "Component_Subsystem"      
  :name |Component_Subsystem|      
  :metatype :extension      
  :member-ends (("Component_Subsystem-extension_Subsystem" "extension_Subsystem")
                (|Subsystem| "base_Component"))      
  :owned-ends  (("Component_Subsystem-extension_Subsystem" "extension_Subsystem")))

(def-meta-assoc-end "Component_Subsystem-extension_Subsystem" 
    :type |Subsystem| 
    :multiplicity (1 1) 
    :association "Component_Subsystem" 
    :name "extension_Subsystem" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== SystemModel
;;; =========================================================
(def-meta-stereotype |SystemModel| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Model|)
 :packages (|StandardProfile|) 
 :xmi-id "SystemModel")
 ""
  ((|base_Model| :xmi-id "SystemModel-base_Model" :range UML25:|Model| :multiplicity (1 1))))

(def-meta-assoc "Model_SystemModel"      
  :name |Model_SystemModel|      
  :metatype :extension      
  :member-ends (("Model_SystemModel-extension_SystemModel" "extension_SystemModel")
                (|SystemModel| "base_Model"))      
  :owned-ends  (("Model_SystemModel-extension_SystemModel" "extension_SystemModel")))

(def-meta-assoc-end "Model_SystemModel-extension_SystemModel" 
    :type |SystemModel| 
    :multiplicity (1 1) 
    :association "Model_SystemModel" 
    :name "extension_SystemModel" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Trace
;;; =========================================================
(def-meta-stereotype |Trace| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Abstraction|)
 :packages (|StandardProfile|) 
 :xmi-id "Trace")
 ""
  ((|base_Abstraction| :xmi-id "Trace-base_Abstraction" :range UML25:|Abstraction| :multiplicity (1 1))))

(def-meta-assoc "Abstraction_Trace"      
  :name |Abstraction_Trace|      
  :metatype :extension      
  :member-ends (("Abstraction_Trace-extension_Trace" "extension_Trace")
                (|Trace| "base_Abstraction"))      
  :owned-ends  (("Abstraction_Trace-extension_Trace" "extension_Trace")))

(def-meta-assoc-end "Abstraction_Trace-extension_Trace" 
    :type |Trace| 
    :multiplicity (1 1) 
    :association "Abstraction_Trace" 
    :name "extension_Trace" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-meta-stereotype |Type| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "Type")
 ""
  ((|base_Class| :xmi-id "Type-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Type"      
  :name |Class_Type|      
  :metatype :extension      
  :member-ends (("Class_Type-extension_Type" "extension_Type")
                (|Type| "base_Class"))      
  :owned-ends  (("Class_Type-extension_Type" "extension_Type")))

(def-meta-assoc-end "Class_Type-extension_Type" 
    :type |Type| 
    :multiplicity (1 1) 
    :association "Class_Type" 
    :name "extension_Type" 
    :aggregation :COMPOSITE)

;;; =========================================================
;;; ====================== Utility
;;; =========================================================
(def-meta-stereotype |Utility| 
   (:model :UML-PROFILE-20131001 :superclasses NIL :extends (UML25:|Class|)
 :packages (|StandardProfile|) 
 :xmi-id "Utility")
 ""
  ((|base_Class| :xmi-id "Utility-base_Class" :range UML25:|Class| :multiplicity (1 1))))

(def-meta-assoc "Class_Utility"      
  :name |Class_Utility|      
  :metatype :extension      
  :member-ends (("Class_Utility-extension_Utility" "extension_Utility")
                (|Utility| "base_Class"))      
  :owned-ends  (("Class_Utility-extension_Utility" "extension_Utility")))

(def-meta-assoc-end "Class_Utility-extension_Utility" 
    :type |Utility| 
    :multiplicity (1 1) 
    :association "Class_Utility" 
    :name "extension_Utility" 
    :aggregation :COMPOSITE)

(def-meta-package |StandardProfile| NIL :UML-PROFILE-20131001 
   (|Auxiliary|
    |Call|
    |Create|
    |Derive|
    |Destroy|
    |Document|
    |Entity|
    |Executable|
    |File|
    |Focus|
    |Framework|
    |Implement|
    |ImplementationClass|
    |Instantiate|
    |Library|
    |Metaclass|
    |ModelLibrary|
    |Process|
    |Realization|
    |Refine|
    |Responsibility|
    |Script|
    |Send|
    |Service|
    |Source|
    |Specification|
    |Subsystem|
    |Trace|
    |Type|
    |Utility|
    |BuildComponent|
    |Metamodel|
    |SystemModel|) :xmi-id "+The-Model+")

(def-meta-package UML\ 2.5 NIL :UML-PROFILE-20131001 
   () :xmi-id NIL)

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '())
     (setf mofi:ns-uri NIL)
     (setf mofi:ns-prefix "StandardProfile"))
