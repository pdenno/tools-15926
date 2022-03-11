;;; Automatically created by pop-gen at 2012-08-31 11:53:23.
;;; Source file is 11-07-01-uml-l2-profile.xmi

(in-package :UML-PROFILE-L2-20110701)



;;; =========================================================
;;; ====================== Auxiliary
;;; =========================================================
(def-meta-stereotype |Auxiliary| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Auxiliary")
 "A class that supports another more central or fundamental class, typically
  by implementing secondary logic or control flow. The class that the auxiliary
  supports may be defined explicitly using a Focus class or implicitly as
  the supplier of dependency relationship whose client is an auxiliary class.
  Auxiliary classes are typically used together with Focus classes, and are
  particularly useful for specifying the secondary business logic or control
  flow of components during design. See also:   Focus  ."
  ())


;;; =========================================================
;;; ====================== Call
;;; =========================================================
(def-meta-stereotype |Call| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Usage|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Call")
 "A usage dependency whose source is an operation and whose target is an
  operation. The relationship may also be subsumed to the class containing
  an operation, with the meaning that there exists an operation in the class
  to which the dependency applies. A call dependency specifies that the source
  operation or an operation in the source class invokes the target operation
  or an operation in the target class. A call dependency may connect a source
  operation to any target operation that is within scope including, but not
  limited to, operations of the enclosing classifier and operations of other
  visible classifiers."
  ())


;;; =========================================================
;;; ====================== Create
;;; =========================================================
(def-meta-stereotype |Create| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|BehavioralFeature| UML23:|Usage|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Create")
 "When applied to a usage dependency, it specifies that the client classifier
  creates instances of the supplier classifier. When applied to a BehavioralFeature,
  it specifies that the designated feature creates an instance of the classifier
  to which the feature is attached."
  ())


;;; =========================================================
;;; ====================== Derive
;;; =========================================================
(def-meta-stereotype |Derive| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Abstraction|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Derive")
 "Specifies a derivation relationship among model elements that are usually,
  but not necessarily, of the same type. A derived dependency specifies that
  the client may be computed from the supplier. The mapping specifies the
  computation. The client may be implemented for design reasons, such as
  efficiency, even though it is logically redundant."
  ((|computation| :range UML241:|ValueSpecification| :multiplicity (1 1) :is-composite-p T
    :documentation
     "The specification for computing the derived client element from the derivation
      supplier element.")))


;;; =========================================================
;;; ====================== Destroy
;;; =========================================================
(def-meta-stereotype |Destroy| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|BehavioralFeature|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Destroy")
 "Specifies that the designated feature destroys an instance of the classifier
  to which the feature is attached."
  ())


;;; =========================================================
;;; ====================== Document
;;; =========================================================
(def-meta-stereotype |Document| 
   (:model :UML-PROFILE-L2-20110701 :superclasses (|File|) :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Document")
 "A specific kind of file that is not an   Executable  ,   Library  ,   Script
    or   Source  . Subclass of   File  ."
  ())


;;; =========================================================
;;; ====================== Entity
;;; =========================================================
(def-meta-stereotype |Entity| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Component|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Entity")
 "A persistent information component representing a business concept."
  ())


;;; =========================================================
;;; ====================== Executable
;;; =========================================================
(def-meta-stereotype |Executable| 
   (:model :UML-PROFILE-L2-20110701 :superclasses (|File|) :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Executable")
 "A program file that can be executed on a computer system. Subclass of 
   File  ."
  ())


;;; =========================================================
;;; ====================== File
;;; =========================================================
(def-meta-stereotype |File| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "File")
 "A physical file in the context of the system developed."
  ())


;;; =========================================================
;;; ====================== Focus
;;; =========================================================
(def-meta-stereotype |Focus| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Focus")
 "A class that defines the core logic or control flow for one or more auxiliary
  classes that support it. Support classes may be defined explicitly using
  Auxiliary classes or implicitly as clients of dependency relationships
  whose supplier is a focus class. Focus classes are typically used together
  with one or more Auxiliary classes, and are particularly useful for specifying
  the core business logic or control flow of components during design. See
  also:   Auxiliary  ."
  ())


;;; =========================================================
;;; ====================== Framework
;;; =========================================================
(def-meta-stereotype |Framework| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Package|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Framework")
 "A package that contains model elements that specify a reusable architecture
  for all or part of a system. Frameworks typically include classes, patterns,
  or templates. When frameworks are specialized for an application domain
  they are sometimes referred to as application frameworks."
  ())


;;; =========================================================
;;; ====================== Implement
;;; =========================================================
(def-meta-stereotype |Implement| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Component|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Implement")
 "A component definition that is not intended to have a specification itself.
  Rather, it is an implementation for a separate   Specification   to which
  it has a Dependency."
  ())


;;; =========================================================
;;; ====================== ImplementationClass
;;; =========================================================
(def-meta-stereotype |ImplementationClass| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "ImplementationClass")
 "The implementation of a class in some programming language (e.g., C++,
  Smalltalk, Java) in which an instance may not have more than one class.
  This is in contrast to Class, for which an instance may have multiple classes
  at one time and may gain or lose classes over time, and an object (a child
  of instance) may dynamically have multiple classes. An Implementation class
  is said to realize a Classifier if it provides all of the operations defined
  for the Classifier with the same behavior as specified for the Classifier's
  operations. An Implementation Class may realize a number of different Types.
  Note that the physical attributes and associations of the Implementation
  class do not have to be the same as those of any Classifier it realizes
  and that the Implementation Class may provide methods for its operations
  in terms of its physical attributes and associations. See also:   Type
   ."
  ())


;;; =========================================================
;;; ====================== Instantiate
;;; =========================================================
(def-meta-stereotype |Instantiate| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Usage|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Instantiate")
 "A usage dependency among classifiers indicating that operations on the
  client create instances of the supplier."
  ())


;;; =========================================================
;;; ====================== Library
;;; =========================================================
(def-meta-stereotype |Library| 
   (:model :UML-PROFILE-L2-20110701 :superclasses (|File|) :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Library")
 "A static or dynamic library file. Subclass of   File  ."
  ())


;;; =========================================================
;;; ====================== Metaclass
;;; =========================================================
(def-meta-stereotype |Metaclass| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Metaclass")
 "A class whose instances are also classes."
  ())


;;; =========================================================
;;; ====================== ModelLibrary
;;; =========================================================
(def-meta-stereotype |ModelLibrary| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Package|)
 :packages (|StandardProfileL2|) 
 :xmi-id "ModelLibrary")
 "A package that contains model elements that are intended to be reused by
  other packages. Model libraries are frequently used in conjunction with
  applied profiles. This is expressed by defining a dependency between a
  profile and a model library package, or by defining a model library as
  contained in a profile package. The classes in a model library are not
  stereotypes and tagged definitions extending the metamodel. A model library
  is analogous to a class library in some programming languages. When a model
  library is defined as a part of a profile, it is imported or deleted with
  the application or removal of the profile. The profile is implicitly applied
  to its model library. In the other case, when the model library is defined
  as an external package imported by a profile, the profile requires that
  the model library be there in the model at the stage of the profile application.
  The application or the removal of the profile does not affect the presence
  of the model library elements."
  ())


;;; =========================================================
;;; ====================== Process
;;; =========================================================
(def-meta-stereotype |Process| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Component|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Process")
 "A transaction based component."
  ())


;;; =========================================================
;;; ====================== Realization
;;; =========================================================
(def-meta-stereotype |Realization| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Classifier|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Realization")
 "A classifier that specifies a domain of objects and that also defines the
  physical implementation of those objects. For example, a Component stereotyped
  by   realization   will only have realizing Classifiers that implement
  behavior specified by a separate   Specification   Component. See   specification
   . This differs from   ImplementationClass   because an   ImplementationClass
    is a realization of a Class that can have features such as attributes
  and methods that are useful to system designers."
  ())


;;; =========================================================
;;; ====================== Refine
;;; =========================================================
(def-meta-stereotype |Refine| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Abstraction|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Refine")
 "Specifies a refinement relationship between model elements at different
  semantic levels, such as analysis and design. The mapping specifies the
  relationship between the two elements or sets of elements. The mapping
  may or may not be computable, and it may be unidirectional or bidirectional.
  Refinement can be used to model transformations from analysis to design
  and other such changes."
  ())


;;; =========================================================
;;; ====================== Responsibility
;;; =========================================================
(def-meta-stereotype |Responsibility| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Usage|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Responsibility")
 "A contract or an obligation of an element in its relationship to other
  elements."
  ())


;;; =========================================================
;;; ====================== Script
;;; =========================================================
(def-meta-stereotype |Script| 
   (:model :UML-PROFILE-L2-20110701 :superclasses (|File|) :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Script")
 "A script file that can be interpreted by a computer system. Subclass of
    File  ."
  ())


;;; =========================================================
;;; ====================== Send
;;; =========================================================
(def-meta-stereotype |Send| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Usage|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Send")
 "A usage dependency whose client is an operation and whose supplier is a
  signal, specifying that the client sends the supplier signal."
  ())


;;; =========================================================
;;; ====================== Service
;;; =========================================================
(def-meta-stereotype |Service| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Component|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Service")
 "A stateless, functional component (computes a value)."
  ())


;;; =========================================================
;;; ====================== Source
;;; =========================================================
(def-meta-stereotype |Source| 
   (:model :UML-PROFILE-L2-20110701 :superclasses (|File|) :extends (UML23:|Artifact|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Source")
 "A source file that can be compiled into an executable file. Subclass of
    File  ."
  ())


;;; =========================================================
;;; ====================== Specification
;;; =========================================================
(def-meta-stereotype |Specification| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Classifier|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Specification")
 "A class that specifies a domain of objects together with the operations
  applicable to the objects, without defining the physical implementation
  of those objects. However, it may have attributes and associations. Behavioral
  specifications for type operations may be expressed using, for example,
  activity diagrams. An object may have at most one implementation class,
  however it may conform to multiple different types. See also:   ImplementationClass
   ."
  ())


;;; =========================================================
;;; ====================== Subsystem
;;; =========================================================
(def-meta-stereotype |Subsystem| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Component|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Subsystem")
 "A unit of hierarchical decomposition for large systems. A subsystem is
  commonly instantiated indirectly. Definitions of subsystems vary widely
  among domains and methods, and it is expected that domain and method profiles
  will specialize this construct. A subsystem may be defined to have specification
  and realization elements. See also:   Specification   and   Realization
   ."
  ())


;;; =========================================================
;;; ====================== Trace
;;; =========================================================
(def-meta-stereotype |Trace| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Abstraction|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Trace")
 "Specifies a trace relationship between model elements or sets of model
  elements that represent the same concept in different models. Traces are
  mainly used for tracking requirements and changes across models. Since
  model changes can occur in both directions, the directionality of the dependency
  can often be ignored. The mapping specifies the relationship between the
  two, but it is rarely computable and is usually informal."
  ())


;;; =========================================================
;;; ====================== Type
;;; =========================================================
(def-meta-stereotype |Type| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Type")
 "A class that specifies a domain of objects together with the operations
  applicable to the objects, without defining the physical implementation
  of those objects. However, it may have attributes and associations. Behavioral
  specifications for type operations may be expressed using, for example,
  activity diagrams. An object may have at most one implementation class,
  however it may conform to multiple different types. See also:   ImplementationClass
   ."
  ())


;;; =========================================================
;;; ====================== Utility
;;; =========================================================
(def-meta-stereotype |Utility| 
   (:model :UML-PROFILE-L2-20110701 :superclasses NIL :extends (UML23:|Class|)
 :packages (|StandardProfileL2|) 
 :xmi-id "Utility")
 "A class that has no instances, but rather denotes a named collection of
  static attributes and static operations, all of which are class-scoped."
  ())


(def-meta-package |StandardProfileL2| NIL :UML-PROFILE-L2-20110701 
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
    |Utility|) :xmi-id "+The-Model+")

(def-meta-package UML\ 2.4.1 NIL :UML-PROFILE-L2-20110701 
   () :xmi-id NIL)

(in-package :mofi)


(with-slots (mofi::abstract-classes mofi:ns-uri mofi:ns-prefix) mofi:*model*
     (setf mofi::abstract-classes 
        '(UML-PROFILE-L2-20110701::|File|))
     (setf mofi:ns-uri "http://www.omg.org/spec/UML/20110701/StandardProfileL2")
     (setf mofi:ns-prefix "StandardProfileL2"))