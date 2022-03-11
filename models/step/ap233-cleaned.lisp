
;;; Automatically generated from file /local/lisp/pod-utils/uml-utils/data/price/ap233-arm-lf-cleanedselects.mdxml 
;;; by UML Testbed tools on 2009-04-07 11:43:20
;;; Load this file with ensure-model and load-model, not load.
;;; Before editing, consider whether edits belong in the generator rather than here.

(in-package :AP233)

(def-mm-enum |offset_orientation|
 (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") () (|ahead| |behind| |exact| )
    "")



(def-mm-datatype |Boolean| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-datatype |Double| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-datatype |Integer| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-datatype |String| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-class |Abs_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Acos_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Activity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |project_item| |documented_element_select| |defined_methods| |activity_item| |product_based_location_representation| |security_classification_item| |position_group_item| |justification_support_item| |condition_parameter_item| |state_definition_of_item| |contract_item| |issue_reference_item| |approval_item| |time_interval_item| |observed_context| |groupable_item| |string_select| |risk_perception_source_item| |affected_item_select| |position_type_item| |required_resource_item| |type_of_person_item_select| |organization_or_person_in_organization_item| |event_item| |analysed_item| |justification_item| |location_assignment_select| |state_of_item| |condition_item| |activity_method_item| |identification_item| |position_item| |condition_evaluation_parameter_item| |effectivity_item| |characterized_activity_definition| |property_assignment_select| |classified_attribute_select| |date_or_date_time_item| |certification_item| |work_item| |classification_item|)
   ""
  ((|chosen_method| :range |Activity_method| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Activity_actual| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|resource_as_realized_item| |verification_evidence_item| |Activity| |defined_activities|)
   ""
  ())


(def-mm-class |Activity_happening| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_relationship|)
   ""
  ((|/actual| :range |Activity_actual| :multiplicity (1 1 ))
   (|/predicted| :range |Activity| :multiplicity (1 1 ))))


(def-mm-class |Activity_method| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|information_usage_right_item| |description_item| |state_of_item| |activity_realization_select| |analysed_item| |type_of_person_item_select| |product_based_location_representation| |condition_parameter_item| |activity_item| |condition_item| |position_type_item| |classification_item| |resource_as_realized_item| |event_item| |observed_context| |documented_element_select| |position_item| |defined_methods| |required_resource_item| |position_group_item| |issue_reference_item| |identification_item| |in_zone_item| |risk_perception_source_item| |behaviour_model| |risk_impact_item| |affected_item_select| |date_or_date_time_item| |characterized_activity_definition| |groupable_item| |work_output_item| |project_item| |approval_item| |work_item| |string_select| |activity_method_item| |certification_item| |verification_evidence_item| |justification_support_item| |property_assignment_select| |resource_assignment_item| |justification_item| |state_definition_of_item| |security_classification_item| |requirement_source_item| |condition_evaluation_item| |organization_or_person_in_organization_item| |requirement_assignment_item| |effectivity_item| |classified_attribute_select| |contract_item|)
   ""
  ((|consequence| :range |String| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|purpose| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Activity_method_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|security_classification_item| |justification_support_item| |issue_reference_item| |approval_item| |time_interval_item| |string_select| |type_of_person_item_select| |organization_or_person_in_organization_item| |justification_item| |verification_evidence_item| |location_assignment_select| |effectivity_item| |classified_attribute_select| |date_or_date_time_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|assigned_method| :range |Activity_method| :multiplicity (1 1 ))
   (|associated_request| :range |Work_request| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Activity_method_realization| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |condition_item| |resource_as_realized_item| |project_item| |contract_item| |documented_element_select| |identification_item| |issue_reference_item| |classification_item| |security_classification_item|)
   ""
  ((|activity_method| :range |Activity_method| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|realized_by| :range |activity_realization_select| :multiplicity (1 1 ))))


(def-mm-class |Activity_method_realization_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |string_select| |analysed_item| |condition_item| |project_item| |contract_item| |documented_element_select| |identification_item| |issue_reference_item| |classification_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Activity_method_realization| :multiplicity (1 1 ))
   (|relating| :range |Activity_method_realization| :multiplicity (1 1 ))))


(def-mm-class |Activity_method_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |condition_item| |analysed_item| |resource_as_realized_item| |project_item| |contract_item| |characterized_activity_definition| |identification_item| |issue_reference_item| |documented_element_select| |verification_evidence_item| |classification_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related_method| :range |Activity_method| :multiplicity (1 1 ))
   (|relating_method| :range |Activity_method| :multiplicity (1 1 ))))


(def-mm-class |Activity_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |activity_item| |approval_item| |string_select| |condition_parameter_item| |condition_item| |analysed_item| |affected_item_select| |condition_evaluation_parameter_item| |requirement_assignment_item| |condition_evaluation_item| |information_usage_right_item| |documented_element_select| |issue_reference_item| |identification_item| |classified_attribute_select| |observed_context| |classification_item| |security_classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|described_element| :range |characterized_activity_definition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Activity_property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |condition_parameter_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|property| :range |Activity_property| :multiplicity (1 1 ))
   (|rep| :range |Representation| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Activity_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |string_select| |analysed_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related_activity| :range |Activity| :multiplicity (1 1 ))
   (|relating_activity| :range |Activity| :multiplicity (1 1 ))))


(def-mm-class |Activity_status| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |verification_evidence_item| |issue_reference_item|)
   ""
  ((|assigned_activity| :range |Activity| :multiplicity (1 1 ))
   (|status| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Address| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |issue_reference_item| |identification_item| |classification_item| |property_assignment_select|)
   ""
  ((|country| :range |String| :multiplicity (0 1 ))
   (|electronic_mail_address| :range |String| :multiplicity (0 1 ))
   (|facsimile_number| :range |String| :multiplicity (0 1 ))
   (|internal_location| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (0 1 ))
   (|postal_box| :range |String| :multiplicity (0 1 ))
   (|postal_code| :range |String| :multiplicity (0 1 ))
   (|region| :range |String| :multiplicity (0 1 ))
   (|street| :range |String| :multiplicity (0 1 ))
   (|street_number| :range |String| :multiplicity (0 1 ))
   (|telephone_number| :range |String| :multiplicity (0 1 ))
   (|telex_number| :range |String| :multiplicity (0 1 ))
   (|town| :range |String| :multiplicity (0 1 ))
   (|url| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Address_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |classification_item|)
   ""
  ((|address_type| :range |String| :multiplicity (0 1 ))
   (|assigned_address| :range |Address| :multiplicity (1 1 ))
   (|located_person_organizations| :range |organization_or_person_in_organization_select| :multiplicity (1 -1 ))))


(def-mm-class |Address_based_location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Location_representation|)
   ""
  ((|postal_address| :range |Address| :multiplicity (1 1 ))))


(def-mm-class |Affected_items_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|security_classification_item| |issue_reference_item| |approval_item| |time_interval_item| |organization_or_person_in_organization_item| |justification_item| |verification_evidence_item| |identification_item| |classified_attribute_select| |date_or_date_time_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|assigned_work_request| :range |Work_request| :multiplicity (1 1 ))
   (|items| :range |affected_item_select| :multiplicity (1 -1 ))))


(def-mm-class |Alias_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Identification_assignment|)
   ""
  ())


(def-mm-class |Alternate_part_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Alternate_product_relationship| |string_select|)
   ""
  ())


(def-mm-class |Alternate_product_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|information_usage_right_item| |state_of_item| |analysed_item| |product_based_location_representation| |classification_item| |event_item| |observed_context| |documented_element_select| |issue_reference_item| |risk_perception_source_item| |risk_impact_item| |date_or_date_time_item| |project_item| |approval_item| |certification_item| |verification_evidence_item| |property_assignment_select| |state_definition_of_item| |security_classification_item| |requirement_source_item| |organization_or_person_in_organization_item| |requirement_assignment_item| |effectivity_item| |classified_attribute_select|)
   ""
  ((|alternate_product| :range |Product| :multiplicity (1 1 ))
   (|base_product| :range |Product| :multiplicity (1 1 ))
   (|criteria| :range |String| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Amount_of_substance_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Analysis| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product|)
   ""
  ())


(def-mm-class |Analysis_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |effectivity_item| |property_assignment_select| |date_or_date_time_item| |condition_item| |resource_as_realized_item| |affected_item_select| |required_resource_item| |state_of_item| |work_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |condition_evaluation_item| |defined_methods| |issue_reference_item| |information_usage_right_item| |observed_context| |type_of_person_item_select| |verification_evidence_item| |resource_assignment_item| |justification_support_item|)
   ""
  ((|analysis| :range |Analysis_version| :multiplicity (1 1 ))
   (|applied_to| :range |analysed_item| :multiplicity (1 1 ))))


(def-mm-class |Analysis_design_version_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Analysis_assignment|)
   ""
  ())


(def-mm-class |Analysis_discipline_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ())


(def-mm-class |Analysis_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation|)
   ""
  ())


(def-mm-class |Analysis_representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_context|)
   ""
  ())


(def-mm-class |Analysis_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ())


(def-mm-class |Analysis_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Analysis_version_sequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version_relationship|)
   ""
  ((|/predecessor| :range |Analysis_version| :multiplicity (1 1 ))
   (|/successor| :range |Analysis_version| :multiplicity (1 1 ))))


(def-mm-class |And_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_boolean_expression|)
   ""
  ())


(def-mm-class |And_state_cause_effect_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_cause_effect_definition|)
   ""
  ())


(def-mm-class |Applied_activity_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |activity_item| |string_select| |condition_item| |resource_as_realized_item| |project_item| |contract_item| |required_resource_item| |state_of_item| |work_item| |location_assignment_select| |state_definition_of_item| |documented_element_select| |classified_attribute_select| |issue_reference_item| |identification_item| |verification_evidence_item| |observed_context| |classification_item| |security_classification_item| |justification_support_item|)
   ""
  ((|assigned_activity| :range |Activity| :multiplicity (1 1 ))
   (|items| :range |activity_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Applied_activity_method_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|description_item| |condition_parameter_item| |condition_item| |location_assignment_select| |classification_item| |resource_as_realized_item| |event_item| |observed_context| |documented_element_select| |issue_reference_item| |identification_item| |in_zone_item| |date_or_date_time_item| |project_item| |approval_item| |work_item| |string_select| |certification_item| |verification_evidence_item| |justification_support_item| |property_assignment_select| |justification_item| |state_definition_of_item| |security_classification_item| |requirement_source_item| |organization_or_person_in_organization_item| |requirement_assignment_item| |effectivity_item| |contract_item|)
   ""
  ((|assigned_activity_method| :range |Activity_method| :multiplicity (1 1 ))
   (|items| :range |activity_method_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Applied_independent_activity_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_property|)
   ""
  ((|base_element_property| :range |Independent_property| :multiplicity (1 1 ))))


(def-mm-class |Applied_independent_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assigned_property|)
   ""
  ((|base_independent_property| :range |Independent_property| :multiplicity (1 1 ))))


(def-mm-class |Applied_independent_resource_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Resource_property|)
   ""
  ((|base_element_property| :range |Independent_property| :multiplicity (1 1 ))))


(def-mm-class |Applied_information_usage_right| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |approval_item| |date_or_date_time_item| |information_usage_right_item| |issue_reference_item| |documented_element_select| |verification_evidence_item| |classification_item|)
   ""
  ((|item| :range |information_usage_right_item| :multiplicity (1 -1 ))
   (|right_applied| :range |Information_usage_right| :multiplicity (1 1 ))))


(def-mm-class |Applied_state_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |effectivity_item| |approval_item| |activity_item| |state_or_state_definition_select| |requirement_source_item| |requirement_assignment_item| |issue_reference_item| |verification_evidence_item| |observed_context| |classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|assigned_to| :range |state_of_item| :multiplicity (1 1 ))
   (|described_state| :range |State| :multiplicity (1 1 ))
   (|role| :range |State_role| :multiplicity (1 1 ))))


(def-mm-class |Applied_state_definition_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |approval_item| |activity_item| |state_or_state_definition_select| |state_of_item| |requirement_source_item| |requirement_assignment_item| |issue_reference_item| |identification_item| |observed_context| |classification_item| |justification_support_item|)
   ""
  ((|assigned_to| :range |state_definition_of_item| :multiplicity (1 1 ))
   (|described_state_definition| :range |State_definition| :multiplicity (1 1 ))
   (|role| :range |State_definition_role| :multiplicity (1 1 ))))


(def-mm-class |Approval| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|state_of_item| |condition_parameter_item| |activity_item| |condition_item| |classification_item| |event_item| |observed_context| |documented_element_select| |issue_reference_item| |identification_item| |risk_perception_source_item| |risk_impact_item| |date_or_date_time_item| |groupable_item| |string_select| |justification_support_item| |justification_item| |condition_evaluation_parameter_item| |condition_evaluation_item| |organization_or_person_in_organization_item| |classified_attribute_select|)
   ""
  ((|actual_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|planned_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|purpose| :range |String| :multiplicity (1 1 ))
   (|status| :range |Approval_status| :multiplicity (1 1 ))))


(def-mm-class |Approval_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_parameter_item| |condition_item| |classification_item| |observed_context| |documented_element_select| |issue_reference_item| |affected_item_select| |activity_method_item| |verification_evidence_item| |justification_item| |condition_evaluation_parameter_item| |requirement_source_item| |condition_evaluation_item| |effectivity_item| |classified_attribute_select|)
   ""
  ((|assigned_approval| :range |Approval| :multiplicity (1 1 ))
   (|items| :range |approval_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Approval_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classified_attribute_select| |string_select| |classification_item| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_approval| :range |Approval| :multiplicity (1 1 ))
   (|relating_approval| :range |Approval| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Approval_status| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|identification_item| |string_select| |classified_attribute_select| |issue_reference_item| |organization_or_person_in_organization_item| |classification_item|)
   ""
  ((|status_name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Approving_person_organization| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|certification_item| |date_or_date_time_item| |position_group_item| |position_item| |requirement_source_item| |issue_reference_item| |classified_attribute_select| |position_type_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|approval_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|authorized_approval| :range |Approval| :multiplicity (1 1 ))
   (|person_organization| :range |organization_or_person_in_organization_select| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Asin_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Assembly_component_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |Product_occurrence_definition_relationship|)
   ""
  ((|location_indicator| :range |String| :multiplicity (0 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Assembly_relationship_substitution| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|information_usage_right_item| |state_of_item| |analysed_item| |product_based_location_representation| |classification_item| |event_item| |observed_context| |documented_element_select| |issue_reference_item| |identification_item| |risk_perception_source_item| |risk_impact_item| |date_or_date_time_item| |project_item| |approval_item| |string_select| |certification_item| |verification_evidence_item| |justification_item| |state_definition_of_item| |security_classification_item| |organization_or_person_in_organization_item| |requirement_assignment_item| |effectivity_item|)
   ""
  ((|base_relationship| :range |Assembly_component_relationship| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (0 1 ))
   (|substitute_relationship| :range |Assembly_component_relationship| :multiplicity (1 1 ))))


(def-mm-class |Assigned_document_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assigned_property|)
   ""
  ())


(def-mm-class |Assigned_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |represented_definition| |organization_or_person_in_organization_item| |effectivity_item| |certification_item| |property_assignment_select| |approval_item| |activity_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |condition_item| |description_item| |analysed_item| |affected_item_select| |condition_evaluation_parameter_item| |condition_evaluation_item| |documented_element_select| |issue_reference_item| |information_usage_right_item| |classified_attribute_select| |identification_item| |verification_evidence_item| |observed_context| |classification_item| |risk_treatment_select| |risk_perception_source_item| |security_classification_item| |justification_support_item| |risk_communication_select| |risk_estimation_select|)
   ""
  ((|described_element| :range |property_assignment_select| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Atan_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_function_call|)
   ""
  ())


(def-mm-class |Attribute_classification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|allowed_value| :range |Class| :multiplicity (1 1 ))
   (|attribute_name| :range |String| :multiplicity (1 1 ))
   (|classified_entity| :range |classified_attribute_select| :multiplicity (1 -1 ))))


(def-mm-class |Attribute_translation_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |classification_item| |effectivity_item|)
   ""
  ((|considered_attribute| :range |String| :multiplicity (1 1 ))
   (|considered_instance| :range |string_select| :multiplicity (1 1 ))
   (|translation_language| :range |Language| :multiplicity (1 1 ))
   (|translation_text| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Axis_placement| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|/dim| :range |Integer| :multiplicity (1 1 ))
   (|origin| :range |Cartesian_point| :multiplicity (1 1 ))
   (|x_axis| :range |Direction| :multiplicity (1 1 ))
   (|y_axis| :range |Direction| :multiplicity (1 1 ))))


(def-mm-class |Axis_placement_2d| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Axis_placement|)
   ""
  ())


(def-mm-class |Axis_placement_3d| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Axis_placement|)
   ""
  ())


(def-mm-class |Axis_placement_mapping| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|source| :range |Axis_placement| :multiplicity (1 1 ))
   (|target| :range |Axis_placement| :multiplicity (1 1 ))))


(def-mm-class |Behaviour| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product|)
   ""
  ())


(def-mm-class |Behaviour_description_association| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |activity_item| |analysed_item| |resource_as_realized_item| |affected_item_select| |state_of_item| |work_output_item| |state_definition_of_item| |defined_activities| |condition_evaluation_item| |issue_reference_item| |observed_context| |type_of_person_item_select| |verification_evidence_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|representation| :range |behaviour_model| :multiplicity (1 1 ))
   (|represented_item| :range |behaviour_item| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Behaviour_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Behaviour_version_sequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version_relationship|)
   ""
  ((|/predecessor| :range |Behaviour_version| :multiplicity (1 1 ))
   (|/successor| :range |Behaviour_version| :multiplicity (1 1 ))))


(def-mm-class |Behaviour_view_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|behaviour_item| |Product_view_definition|)
   ""
  ())


(def-mm-class |Binary_boolean_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_generic_expression| |Boolean_expression|)
   ""
  ())


(def-mm-class |Binary_function_call| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Binary_generic_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_expression|)
   ""
  ((|operands| :range |Generic_expression| :multiplicity (2 2 )
  :is-ordered-p t )))


(def-mm-class |Binary_numeric_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_expression| |Binary_generic_expression|)
   ""
  ())


(def-mm-class |Boolean_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Boolean_expression| |Defined_function|)
   ""
  ())


(def-mm-class |Boolean_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Expression|)
   ""
  ())


(def-mm-class |Boolean_literal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_literal| |Simple_boolean_expression|)
   ""
  ((|the_value| :range |Boolean| :multiplicity (1 1 ))))


(def-mm-class |Boolean_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_boolean_expression| |Variable|)
   ""
  ())


(def-mm-class |Breakdown| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item| |selected_item_context_items| |date_or_date_time_item| |Product|)
   ""
  ())


(def-mm-class |Breakdown_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |documented_element_select| |classification_item| |issue_reference_item| |classified_attribute_select| |risk_perception_source_item|)
   ""
  ((|breakdown| :range |Breakdown_version| :multiplicity (1 1 ))
   (|breakdown_element| :range |Breakdown_element_definition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Breakdown_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |Product| |contract_item|)
   ""
  ())


(def-mm-class |Breakdown_element_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|breakdown_item| |Product_view_definition|)
   ""
  ())


(def-mm-class |Breakdown_element_realization| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |Product_definition_element_relationship|)
   ""
  ())


(def-mm-class |Breakdown_element_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |View_definition_usage| |breakdown_item| |security_classification_item|)
   ""
  ((|/child_element| :range |Breakdown_element_definition| :multiplicity (1 1 ))
   (|/parent_element| :range |Breakdown_element_definition| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Breakdown_element_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Breakdown_of| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |effectivity_item| |groupable_item| |product_based_location_representation| |issue_reference_item| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|breakdown| :range |Breakdown_version| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|of_view| :range |Product_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Breakdown_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Calendar_date| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_evaluation_parameter_item| |date_or_event| |issue_reference_item| |condition_parameter_item| |date_or_date_time_select| |classification_item|)
   ""
  ((|day_component| :range |day_in_month_number| :multiplicity (1 1 ))
   (|month_component| :range |month_in_year_number| :multiplicity (1 1 ))
   (|year_component| :range |year_number| :multiplicity (1 1 ))))


(def-mm-class |Cartesian_point| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|coordinates| :range |length_measure| :multiplicity (1 3 )
  :is-ordered-p t )))


(def-mm-class |Cartesian_transformation_2d| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|cartesian_transformation| |Detailed_geometric_model_element|)
   ""
  ((|multiplication_matrix| :range |Direction| :multiplicity (1 2 )
  :is-ordered-p t )
   (|translation| :range |Cartesian_point| :multiplicity (1 1 ))))


(def-mm-class |Cartesian_transformation_3d| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|cartesian_transformation| |Detailed_geometric_model_element|)
   ""
  ((|multiplication_matrix| :range |Direction| :multiplicity (1 3 )
  :is-ordered-p t )
   (|translation| :range |Cartesian_point| :multiplicity (1 1 ))))


(def-mm-class |Certification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |activity_method_item| |organization_or_person_in_organization_item| |activity_item| |date_or_date_time_item| |approval_item| |string_select| |groupable_item| |resource_as_realized_item| |state_of_item| |state_definition_of_item| |information_usage_right_item| |identification_item| |issue_reference_item| |classified_attribute_select| |documented_element_select| |classification_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|kind| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Certification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |approval_item| |date_or_date_time_item| |condition_parameter_item| |condition_item| |resource_as_realized_item| |affected_item_select| |required_resource_item| |condition_evaluation_parameter_item| |requirement_source_item| |documented_element_select| |issue_reference_item| |information_usage_right_item| |classified_attribute_select| |verification_evidence_item| |observed_context| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_certification| :range |Certification| :multiplicity (1 1 ))
   (|items| :range |certification_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Characterizable_object| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|requirement_source_item| |classification_item| |information_usage_right_item| |shapeable_item| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Class| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|documented_element_select| |issue_reference_item| |organization_or_person_in_organization_item| |classification_item| |description_item| |identification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Class_by_extension| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Class|)
   ""
  ())


(def-mm-class |Class_by_intension| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Class|)
   ""
  ())


(def-mm-class |Classification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |condition_parameter_item| |condition_evaluation_parameter_item| |documented_element_select| |issue_reference_item| |verification_evidence_item|)
   ""
  ((|assigned_class| :range |Class| :multiplicity (1 1 ))
   (|items| :range |classification_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Comparison_equal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Comparison_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Boolean_expression| |Binary_generic_expression|)
   ""
  ())


(def-mm-class |Comparison_greater| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Comparison_greater_equal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Comparison_less| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Comparison_less_equal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Comparison_not_equal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Component_upper_level_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assembly_component_relationship|)
   ""
  ((|sub_assembly_relationship| :range |Next_assembly_usage| :multiplicity (1 1 ))
   (|upper_assembly_relationship| :range |Assembly_component_relationship| :multiplicity (1 1 ))))


(def-mm-class |Composition_of_state| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_relationship|)
   ""
  ((|/part| :range |State| :multiplicity (1 -1 ))
   (|/whole| :range |State| :multiplicity (1 -1 ))))


(def-mm-class |Composition_of_state_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/part| :range |State_definition| :multiplicity (1 -1 ))
   (|/whole| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |Concat_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|String_expression| |Multiple_arity_generic_expression|)
   ""
  ())


(def-mm-class |Concurrent_elements| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Structured_task_element|)
   ""
  ((|elements| :range |Task_element| :multiplicity (2 -1 ))))


(def-mm-class |Condition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |groupable_item| |analysed_item| |description_item| |expression_assignment_item| |characterized_activity_definition| |classified_attribute_select| |issue_reference_item| |documented_element_select| |identification_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Condition_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |issue_reference_item| |documented_element_select| |observed_context| |verification_evidence_item| |classification_item|)
   ""
  ((|assigned_condition| :range |Condition| :multiplicity (1 1 ))
   (|item| :range |condition_item| :multiplicity (1 1 ))))


(def-mm-class |Condition_evaluation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |string_select| |characterized_activity_definition| |classified_attribute_select| |issue_reference_item| |documented_element_select| |identification_item| |classification_item|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|result| :range |logical| :multiplicity (1 1 ))))


(def-mm-class |Condition_evaluation_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |resource_as_realized_item| |required_resource_item| |issue_reference_item| |verification_evidence_item| |observed_context| |classification_item|)
   ""
  ((|assigned_condition_evaluation| :range |Condition_evaluation| :multiplicity (1 1 ))
   (|item| :range |condition_evaluation_item| :multiplicity (1 1 ))))


(def-mm-class |Condition_evaluation_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |property_assignment_select| |string_select| |product_based_location_representation| |issue_reference_item| |classified_attribute_select| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|condition_evaluation| :range |Condition_evaluation| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|evaluation_parameter| :range |condition_evaluation_parameter_item| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Condition_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|documented_element_select| |issue_reference_item| |string_select| |description_item| |property_assignment_select| |classified_attribute_select| |classification_item|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|parameter| :range |condition_parameter_item| :multiplicity (0 1 ))))


(def-mm-class |Condition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |condition_parameter_item| |string_select| |analysed_item| |characterized_activity_definition| |classified_attribute_select| |issue_reference_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related_condition| :range |Condition| :multiplicity (1 1 ))
   (|relating_condition| :range |Condition| :multiplicity (1 1 ))))


(def-mm-class |Constrained_general_parameter_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Independent_property_relationship| |product_based_location_representation| |effectivity_item|)
   ""
  ((|required_class| :range |Class| :multiplicity (1 1 ))))


(def-mm-class |Contained_acceptance| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_analysis| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_communication| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_estimation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_evaluation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Contained_treatments| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Context_dependent_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Contextual_item_shape| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Item_shape|)
   ""
  ((|/shaped_product| :range |Product_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Contextual_shape_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|/context_representation| :range |Geometric_model| :multiplicity (1 1 ))
   (|/positioned_representation| :range |Geometric_model| :multiplicity (1 1 ))
   (|contextual_shape| :range |Contextual_item_shape| :multiplicity (1 1 ))
   (|representing_relationship| :range |Geometric_model_relationship| :multiplicity (1 1 ))))


(def-mm-class |Contract| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |activity_method_item| |organization_or_person_in_organization_item| |activity_item| |approval_item| |date_or_date_time_item| |string_select| |groupable_item| |resource_as_realized_item| |affected_item_select| |state_of_item| |work_output_item| |state_definition_of_item| |documented_element_select| |classified_attribute_select| |issue_reference_item| |identification_item| |information_usage_right_item| |resource_assignment_item| |classification_item| |risk_perception_source_item| |justification_support_item| |selected_item_context_items|)
   ""
  ((|id| :range |String| :multiplicity (1 1 ))
   (|kind| :range |String| :multiplicity (1 1 ))
   (|purpose| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Contract_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |condition_parameter_item| |condition_item| |resource_as_realized_item| |required_resource_item| |condition_evaluation_parameter_item| |requirement_source_item| |issue_reference_item| |documented_element_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_contract| :range |Contract| :multiplicity (1 1 ))
   (|items| :range |contract_item| :multiplicity (1 -1 ))))


(def-mm-class |Conversion_based_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ((|conversion_factor| :range |Value_with_unit| :multiplicity (1 1 ))))


(def-mm-class |Cos_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Curve| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ())


(def-mm-class |Date_or_date_time_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |string_select| |condition_parameter_item| |condition_item| |condition_evaluation_parameter_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |verification_evidence_item| |classification_item|)
   ""
  ((|assigned_date| :range |date_or_date_time_select| :multiplicity (1 1 ))
   (|items| :range |date_or_date_time_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Date_time| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_evaluation_parameter_item| |date_or_date_time_select| |classification_item| |condition_parameter_item| |issue_reference_item| |date_or_event|)
   ""
  ((|date_component| :range |Calendar_date| :multiplicity (1 1 ))
   (|time_component| :range |Local_time| :multiplicity (1 1 ))))


(def-mm-class |Dated_effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Effectivity|)
   ""
  ((|end_bound| :range |date_or_event| :multiplicity (0 1 ))
   (|start_bound| :range |date_or_event| :multiplicity (1 1 ))))


(def-mm-class |Decision_path| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))
   (|defined_in| :range |Multiple_decision_point| :multiplicity (1 1 ))
   (|path_element| :range |Task_element| :multiplicity (1 1 ))))


(def-mm-class |Decision_point| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Structured_task_element|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))
   (|false_case_element| :range |Task_element| :multiplicity (0 1 ))
   (|true_case_element| :range |Task_element| :multiplicity (0 1 ))
   (|unknown_case_element| :range |Task_element| :multiplicity (0 1 ))))


(def-mm-class |Decreasing_resource_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Resource_event|)
   ""
  ())


(def-mm-class |Defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |Defined_state_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_perception_source_item| |verification_evidence_item| |risk_impact_item| |classification_item| |issue_reference_item|)
   ""
  ((|defined_state| :range |State_assessment| :multiplicity (1 1 ))
   (|definitive_state| :range |State_assertion| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Definitional_representation_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_relationship|)
   ""
  ())


(def-mm-class |Derived_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ((|elements| :range |Derived_unit_element| :multiplicity (1 -1 ))))


(def-mm-class |Derived_unit_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|base_unit| :range |Unit| :multiplicity (1 1 ))
   (|exponent| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Description_text| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |classification_item| |classified_attribute_select| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Description_text_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |identification_item| |issue_reference_item| |verification_evidence_item|)
   ""
  ((|description| :range |Description_text| :multiplicity (1 1 ))
   (|items| :range |description_item| :multiplicity (1 -1 ))))


(def-mm-class |Descriptive_document_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |justification_support_item| |String_representation_item| |activity_item| |descriptive_or_numerical|)
   ""
  ())


(def-mm-class |Detailed_geometric_model_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ())


(def-mm-class |Detailed_geometric_model_element_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|item_1| :range |Detailed_geometric_model_element| :multiplicity (1 1 ))
   (|item_2| :range |Detailed_geometric_model_element| :multiplicity (1 1 ))))


(def-mm-class |Digital_document_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Document_definition|)
   ""
  ((|files| :range |Digital_file| :multiplicity (0 -1 ))))


(def-mm-class |Digital_file| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |date_or_date_time_item| |File| |documented_element_select| |classified_attribute_select| |information_usage_right_item| |security_classification_item|)
   ""
  ())


(def-mm-class |Directed_activity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|verification_evidence_item| |Activity| |requirement_source_item| |resource_as_realized_item|)
   ""
  ((|directive| :range |Work_order| :multiplicity (1 1 ))))


(def-mm-class |Direction| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|coordinates| :range |length_measure| :multiplicity (2 3 )
  :is-ordered-p t )))


(def-mm-class |Disposition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Approval|)
   ""
  ((|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Distribution_by_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability_distribution|)
   ""
  ((|defined_function| :range |Value_function| :multiplicity (1 1 ))
   (|distribution_function| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Div_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Document| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |Product| |contract_item| |assigned_document_select|)
   ""
  ())


(def-mm-class |Document_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |condition_item| |affected_item_select| |condition_evaluation_parameter_item| |condition_evaluation_item| |identification_item| |classified_attribute_select| |issue_reference_item| |documented_element_select| |observed_context| |type_of_person_item_select| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|assigned_document| :range |assigned_document_select| :multiplicity (1 1 ))
   (|is_assigned_to| :range |documented_element_select| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Document_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition| |assigned_document_select|)
   ""
  ((|/associated_document_version| :range |Document_version| :multiplicity (1 1 ))
   (|/description| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Document_definition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |documented_element_select| |issue_reference_item| |classified_attribute_select| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_document_definition| :range |Document_definition| :multiplicity (1 1 ))
   (|relating_document_definition| :range |Document_definition| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Document_location_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|External_source_identification|)
   ""
  ())


(def-mm-class |Document_property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation|)
   ""
  ())


(def-mm-class |Document_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|assigned_document_select| |Product_version|)
   ""
  ())


(def-mm-class |Duration| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Value_with_unit|)
   ""
  ())


(def-mm-class |Effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |activity_item| |groupable_item| |condition_item| |documented_element_select| |identification_item| |issue_reference_item| |classified_attribute_select| |classification_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Effectivity_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_effectivity| :range |Effectivity| :multiplicity (1 1 ))
   (|items| :range |effectivity_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Effectivity_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_effectivity| :range |Effectivity| :multiplicity (1 1 ))
   (|relating_effectivity| :range |Effectivity| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Electric_current_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Element_constraint| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element_relationship|)
   ""
  ((|applies_in| :range |constraint_context| :multiplicity (0 1 ))))


(def-mm-class |End_task| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ())


(def-mm-class |Environment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|semantics| :range |Variable_semantics| :multiplicity (1 1 ))
   (|syntactic_representation| :range |Generic_variable| :multiplicity (1 1 ))))


(def-mm-class |Equals_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_boolean_expression|)
   ""
  ())


(def-mm-class |Event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_event| |activity_item| |assigned_name_select| |approval_item| |string_select| |groupable_item| |description_item| |resource_as_realized_item| |position_group_item| |required_resource_item| |product_based_location_representation| |position_item| |state_of_item| |work_item| |location_assignment_select| |state_definition_of_item| |defined_methods| |issue_reference_item| |identification_item| |position_type_item| |classification_item| |resource_assignment_item| |security_classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|actual_start_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|planned_start_date| :range |date_or_date_time_select| :multiplicity (0 1 ))))


(def-mm-class |Event_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |activity_item| |condition_item| |resource_as_realized_item| |affected_item_select| |defined_activities| |classified_attribute_select| |issue_reference_item| |documented_element_select| |verification_evidence_item| |observed_context| |classification_item| |risk_perception_source_item| |risk_communication_select| |risk_estimation_select|)
   ""
  ((|assigned_event| :range |Event| :multiplicity (1 1 ))
   (|items| :range |event_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Event_probability| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assigned_property|)
   ""
  ())


(def-mm-class |Event_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |risk_perception_source_item| |risk_impact_item| |classified_attribute_select| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_event| :range |Event| :multiplicity (1 1 ))
   (|relating_event| :range |Event| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Exit_loop| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ())


(def-mm-class |Exp_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Expanded_uncertainty| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Standard_uncertainty|)
   ""
  ((|coverage_factor| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Experience_gained| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |type_of_person_item_select| |classification_item| |issue_reference_item| |approval_item| |risk_perception_source_item|)
   ""
  ((|experience_of| :range |Experience_instance| :multiplicity (1 1 ))
   (|gained_by| :range |person_or_organization_or_person_in_organization_select| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Experience_instance| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select| |date_or_date_time_item| |issue_reference_item| |documented_element_select| |identification_item| |type_of_person_item_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|consists_of| :range |defined_activities| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|is_defined_by| :range |Experience_type| :multiplicity (1 1 ))))


(def-mm-class |Experience_type| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|approval_item| |string_select| |groupable_item| |issue_reference_item| |identification_item| |documented_element_select| |type_of_person_item_select| |classification_item| |defined_attributes|)
   ""
  ((|consists_of| :range |defined_methods| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Experience_type_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|component_experience| :range |Experience_type| :multiplicity (1 1 ))
   (|compound_experience| :range |Experience_type| :multiplicity (1 1 ))))


(def-mm-class |Expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|description_item| |condition_parameter_item| |Generic_expression| |classification_item|)
   ""
  ())


(def-mm-class |Expression_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_item| |classification_item| |risk_perception_source_item| |issue_reference_item| |verification_evidence_item|)
   ""
  ((|expression| :range |Expression| :multiplicity (1 1 ))
   (|items| :range |expression_assignment_item| :multiplicity (1 -1 ))))


(def-mm-class |External_analysis_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Analysis_model|)
   ""
  ((|external_file| :range |Digital_file| :multiplicity (1 1 ))))


(def-mm-class |External_class| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item| |Class|)
   ""
  ((|external_source| :range |External_class_library| :multiplicity (1 1 ))))


(def-mm-class |External_class_library| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|assigned_name_select| |contract_item| |issue_reference_item| |identification_item| |External_source| |classification_item|)
   ""
  ())


(def-mm-class |External_functional_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Function_based_behaviour_model|)
   ""
  ((|external_file| :range |Digital_file| :multiplicity (1 1 ))))


(def-mm-class |External_geometric_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_model|)
   ""
  ((|external_file| :range |Digital_file| :multiplicity (1 1 ))))


(def-mm-class |External_item_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|information_usage_right_item| |External_source_identification| |documented_element_select|)
   ""
  ((|external_id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |External_source| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|description_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |External_source_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |classified_attribute_select| |issue_reference_item| |string_select| |identification_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|item| :range |external_identification_item| :multiplicity (1 1 ))
   (|source_id| :range |String| :multiplicity (1 1 ))
   (|source_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |External_state_based_behaviour_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_based_behaviour_model|)
   ""
  ((|external_file| :range |Digital_file| :multiplicity (1 1 ))))


(def-mm-class |File| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |effectivity_item| |property_assignment_select| |activity_item| |groupable_item| |description_item| |affected_item_select| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |identification_item| |issue_reference_item| |assigned_document_select| |classification_item| |resource_item_select| |risk_perception_source_item| |external_identification_item|)
   ""
  ((|contained_data_type| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|version| :range |String| :multiplicity (0 1 ))))


(def-mm-class |File_location_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|state_definition_of_item| |state_of_item| |External_item_identification|)
   ""
  ())


(def-mm-class |File_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |string_select| |classified_attribute_select| |issue_reference_item| |classification_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_document_file| :range |File| :multiplicity (1 1 ))
   (|relating_document_file| :range |File| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Format_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_generic_expression| |String_expression|)
   ""
  ((|/format_string| :range |Generic_expression| :multiplicity (1 1 ))
   (|/value_to_format| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Function_based_behaviour_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|behaviour_model| |Representation|)
   ""
  ())


(def-mm-class |Function_based_behaviour_representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_context|)
   ""
  ())


(def-mm-class |Function_based_behaviour_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ((|item| :range |Task_element| :multiplicity (1 1 ))))


(def-mm-class |Function_parameter_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_generic_expression| |Numeric_expression|)
   ""
  ())


(def-mm-class |Function_value_pair| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|function_value| :range |Probability_function_value| :multiplicity (1 1 ))
   (|variable_value| :range |Random_variable| :multiplicity (1 1 ))))


(def-mm-class |Functional_breakdown| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown|)
   ""
  ())


(def-mm-class |Functional_breakdown_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_context|)
   ""
  ())


(def-mm-class |Functional_breakdown_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_version|)
   ""
  ())


(def-mm-class |Functional_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element|)
   ""
  ())


(def-mm-class |Functional_element_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_definition|)
   ""
  ())


(def-mm-class |Functional_element_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_usage|)
   ""
  ())


(def-mm-class |Functional_element_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_version|)
   ""
  ())


(def-mm-class |General_model_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Independent_property| |description_item|)
   ""
  ())


(def-mm-class |Generic_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select| |parameter_value_select| |risk_perception_source_item| |issue_reference_item|)
   ""
  ())


(def-mm-class |Generic_literal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_generic_expression|)
   ""
  ())


(def-mm-class |Generic_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_generic_expression|)
   ""
  ())


(def-mm-class |Geometric_composition_with_operator_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Definitional_representation_relationship| |Geometric_relationship_with_operator_transformation|)
   ""
  ())


(def-mm-class |Geometric_composition_with_placement_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Definitional_representation_relationship| |Geometric_relationship_with_placement_transformation|)
   ""
  ())


(def-mm-class |Geometric_coordinate_space| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_representation_context|)
   ""
  ((|dimension_count| :range |Integer| :multiplicity (1 1 ))))


(def-mm-class |Geometric_item_specific_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|definition| :range |geometric_item_specific_usage_select| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|identified_item| :range |Detailed_geometric_model_element| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|used_model| :range |shape_model| :multiplicity (1 1 ))))


(def-mm-class |Geometric_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|template_definition_select| |shape_model| |Representation|)
   ""
  ((|model_extent| :range |length_measure| :multiplicity (0 1 ))
   (|version_id| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Geometric_model_element_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element| |Detailed_geometric_model_element_relationship|)
   ""
  ())


(def-mm-class |Geometric_model_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_relationship|)
   ""
  ())


(def-mm-class |Geometric_model_relationship_with_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_model_relationship|)
   ""
  ())


(def-mm-class |Geometric_operator_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_placement_operation|)
   ""
  ((|target| :range |cartesian_transformation| :multiplicity (1 1 ))))


(def-mm-class |Geometric_placement| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_placement_operation|)
   ""
  ((|target| :range |Axis_placement| :multiplicity (1 1 ))))


(def-mm-class |Geometric_placement_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_model|)
   ""
  ())


(def-mm-class |Geometric_placement_operation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|source| :range |Axis_placement| :multiplicity (1 1 ))
   (|template_definition| :range |template_definition_select| :multiplicity (1 1 ))))


(def-mm-class |Geometric_relationship_with_operator_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_model_relationship_with_transformation|)
   ""
  ((|transformation| :range |cartesian_transformation| :multiplicity (1 1 ))))


(def-mm-class |Geometric_relationship_with_placement_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Geometric_model_relationship_with_transformation|)
   ""
  ((|transformation| :range |Axis_placement_mapping| :multiplicity (1 1 ))))


(def-mm-class |Global_location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Location_representation|)
   ""
  ((|altitude| :range |Value_with_unit| :multiplicity (0 1 ))
   (|geographical_area| :range |String| :multiplicity (0 1 ))
   (|latitude| :range |Value_with_unit| :multiplicity (1 1 ))
   (|longitude| :range |Value_with_unit| :multiplicity (1 1 ))))


(def-mm-class |Group| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |assigned_name_select| |approval_item| |groupable_item| |affected_item_select| |identification_item| |information_usage_right_item| |documented_element_select| |classified_attribute_select| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|elements| :range |groupable_item| :multiplicity (0 -1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|membership_meaning| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Group_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|assigned_name_select| |approval_item| |groupable_item| |information_usage_right_item| |identification_item| |classified_attribute_select| |documented_element_select| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_group| :range |Group| :multiplicity (1 1 ))
   (|relating_group| :range |Group| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Hardcopy| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |date_or_date_time_item| |File| |classified_attribute_select| |documented_element_select| |information_usage_right_item| |security_classification_item|)
   ""
  ())


(def-mm-class |Hierarchical_interface_connection| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Interface_connection|)
   ""
  ())


(def-mm-class |Identification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |condition_parameter_item| |condition_evaluation_parameter_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|identifier| :range |String| :multiplicity (1 1 ))
   (|items| :range |identification_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |In_zone| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |property_assignment_select| |approval_item| |requirement_source_item| |requirement_assignment_item| |information_usage_right_item| |issue_reference_item| |classification_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|located_item| :range |in_zone_item| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|zone| :range |Zone_element_definition| :multiplicity (1 1 ))))


(def-mm-class |Included_text_based_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item| |text_based_item_select|)
   ""
  ((|source| :range |Text_based_representation| :multiplicity (1 1 ))))


(def-mm-class |Incomplete_reference_marking| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Classification_assignment|)
   ""
  ())


(def-mm-class |Increasing_resource_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Resource_event|)
   ""
  ())


(def-mm-class |Independent_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |represented_definition| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |activity_item| |approval_item| |string_select| |condition_parameter_item| |project_item| |documented_element_select| |issue_reference_item| |identification_item| |classified_attribute_select| |classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|property_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Independent_property_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |string_select| |documented_element_select| |issue_reference_item| |identification_item| |classified_attribute_select| |classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related| :range |Independent_property| :multiplicity (1 1 ))
   (|relating| :range |Independent_property| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Independent_property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |condition_parameter_item| |condition_evaluation_parameter_item| |documented_element_select| |classified_attribute_select| |classification_item| |Property_definition_representation|)
   ""
  ((|/property| :range |Independent_property| :multiplicity (1 1 ))))


(def-mm-class |Index_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_generic_expression| |String_expression|)
   ""
  ((|/index| :range |Generic_expression| :multiplicity (1 1 ))
   (|/operand| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Information_right| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |issue_reference_item| |classified_attribute_select| |information_usage_right_item| |documented_element_select| |identification_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|restriction| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Information_usage_right| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |string_select| |affected_item_select| |contract_item| |state_of_item| |classified_attribute_select| |identification_item| |issue_reference_item| |information_usage_right_item| |documented_element_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|comment| :range |String| :multiplicity (0 1 ))
   (|grants_right| :range |Information_right| :multiplicity (1 -1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Information_usage_right_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|information_usage_right_item| |classification_item| |identification_item| |issue_reference_item| |classified_attribute_select| |documented_element_select|)
   ""
  ((|related| :range |Information_usage_right| :multiplicity (1 1 ))
   (|relating| :range |Information_usage_right| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Int_literal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Literal_number|)
   ""
  ())


(def-mm-class |Int_numeric_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_variable|)
   ""
  ())


(def-mm-class |Int_value_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Function_parameter_value|)
   ""
  ())


(def-mm-class |Integer_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_defined_function|)
   ""
  ())


(def-mm-class |Interface_connection| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |effectivity_item| |certification_item| |property_assignment_select| |activity_item| |date_or_date_time_item| |approval_item| |condition_parameter_item| |string_select| |groupable_item| |analysed_item| |description_item| |condition_item| |resource_as_realized_item| |project_item| |affected_item_select| |required_resource_item| |product_based_location_representation| |state_of_item| |condition_evaluation_parameter_item| |location_assignment_select| |in_zone_item| |state_definition_of_item| |condition_evaluation_item| |documented_element_select| |identification_item| |classified_attribute_select| |information_usage_right_item| |issue_reference_item| |observed_context| |classification_item| |risk_perception_source_item| |security_classification_item| |justification_support_item| |selected_item_select|)
   ""
  ((|connected| :range |connection_items| :multiplicity (1 1 ))
   (|connecting| :range |connection_items| :multiplicity (1 1 ))
   (|connection_type| :range |String| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Interface_connector| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product|)
   ""
  ())


(def-mm-class |Interface_connector_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ((|connector_on| :range |Product_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Interface_connector_occurrence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|in_zone_item| |risk_impact_item| |documented_element_select| |activity_item| |product_based_location_representation| |security_classification_item| |justification_support_item| |requirement_assignment_item| |condition_parameter_item| |state_definition_of_item| |issue_reference_item| |connection_items| |approval_item| |resource_assignment_item| |interface_definition_item| |observed_context| |string_select| |risk_perception_source_item| |affected_item_select| |required_resource_item| |organization_or_person_in_organization_item| |analysed_item| |justification_item| |location_assignment_select| |state_of_item| |activity_method_item| |information_usage_right_item| |requirement_source_item| |identification_item| |condition_evaluation_parameter_item| |description_item| |effectivity_item| |selected_item_select| |property_assignment_select| |date_or_date_time_item| |product_item| |classification_item|)
   ""
  ((|connector_on| :range |connector_on_item| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|occurrence_of| :range |Interface_connector_definition| :multiplicity (1 1 ))))


(def-mm-class |Interface_connector_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Interface_definition_connection| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|in_zone_item| |risk_impact_item| |project_item| |documented_element_select| |activity_item| |product_based_location_representation| |security_classification_item| |justification_support_item| |position_group_item| |condition_parameter_item| |state_definition_of_item| |issue_reference_item| |approval_item| |condition_evaluation_item| |observed_context| |string_select| |risk_perception_source_item| |affected_item_select| |position_type_item| |required_resource_item| |type_of_person_item_select| |organization_or_person_in_organization_item| |analysed_item| |justification_item| |verification_evidence_item| |location_assignment_select| |condition_item| |state_of_item| |information_usage_right_item| |activity_method_item| |identification_item| |description_item| |condition_evaluation_parameter_item| |position_item| |selected_item_select| |classified_attribute_select| |property_assignment_select| |date_or_date_time_item| |certification_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|connected| :range |connection_definition_items| :multiplicity (1 1 ))
   (|connecting| :range |connection_definition_items| :multiplicity (1 1 ))
   (|connection_type| :range |String| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Interface_definition_for| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |groupable_item| |analysed_item| |description_item| |resource_as_realized_item| |required_resource_item| |requirement_source_item| |requirement_assignment_item| |information_usage_right_item| |issue_reference_item| |identification_item| |observed_context| |verification_evidence_item| |type_of_person_item_select| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|interface| :range |Interface_specification_definition| :multiplicity (1 1 ))
   (|interface_component| :range |interface_definition_item| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Interface_specification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product|)
   ""
  ())


(def-mm-class |Interface_specification_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ())


(def-mm-class |Interface_specification_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Interval_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Boolean_expression| |Multiple_arity_generic_expression|)
   ""
  ((|/interval_high| :range |Generic_expression| :multiplicity (1 1 ))
   (|/interval_item| :range |Generic_expression| :multiplicity (1 1 ))
   (|/interval_low| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Issue| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |effectivity_item| |activity_item| |condition_item| |affected_item_select| |contract_item| |required_resource_item| |Observation| |defined_activities| |defined_methods| |information_usage_right_item| |classified_attribute_select| |observed_context|)
   ""
  ())


(def-mm-class |Issue_consequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |effectivity_item| |position_group_item| |position_item| |Observation_consequence| |information_usage_right_item| |position_type_item|)
   ""
  ())


(def-mm-class |Issue_reference| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Observation_item| |state_definition_of_item|)
   ""
  ((|item| :range |issue_reference_item| :multiplicity (0 -1 ))))


(def-mm-class |Item_design_association| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |classification_item|)
   ""
  ((|configuration| :range |Product_configuration| :multiplicity (1 1 ))
   (|design| :range |version_or_definition| :multiplicity (1 1 ))))


(def-mm-class |Item_shape| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|shape_dependent_select| |issue_reference_item| |identification_item| |shape_select| |classification_item|)
   ""
  ((|described_element| :range |shapeable_item| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Item_usage_effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |approval_item| |activity_item| |classification_item|)
   ""
  ((|effectivity_domain| :range |Effectivity| :multiplicity (1 1 ))
   (|item_usage_relationship| :range |View_definition_usage| :multiplicity (1 1 ))
   (|resolved_configuration| :range |Item_design_association| :multiplicity (1 1 ))))


(def-mm-class |Justification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |certification_item| |activity_item| |date_or_date_time_item| |approval_item| |string_select| |groupable_item| |contract_item| |required_resource_item| |product_based_location_representation| |state_of_item| |condition_evaluation_item| |information_usage_right_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |identification_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|context_description| :range |String| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (1 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Justification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |string_select| |condition_item| |affected_item_select| |issue_reference_item| |classified_attribute_select| |identification_item| |documented_element_select| |verification_evidence_item| |observed_context| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|item| :range |justification_item| :multiplicity (1 1 ))
   (|justification| :range |Justification| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Justification_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |documented_element_select| |issue_reference_item| |identification_item| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related_justification| :range |Justification| :multiplicity (1 1 ))
   (|relating_justification| :range |Justification| :multiplicity (1 1 ))))


(def-mm-class |Justification_support_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |classified_attribute_select| |documented_element_select| |issue_reference_item| |identification_item| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|justification| :range |Justification| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))
   (|support_item| :range |justification_support_item| :multiplicity (1 1 ))))


(def-mm-class |LIST-1-n-Textual_expression_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |Language| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |issue_reference_item| |classified_attribute_select|)
   ""
  ((|country_code| :range |String| :multiplicity (0 1 ))
   (|language_code| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Language_indication| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |classification_item| |product_based_location_representation|)
   ""
  ((|considered_attribute| :range |String| :multiplicity (1 1 ))
   (|considered_instance| :range |string_select| :multiplicity (1 1 ))
   (|used_language| :range |Language| :multiplicity (1 1 ))))


(def-mm-class |Length_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_generic_expression| |Numeric_expression|)
   ""
  ())


(def-mm-class |Length_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Lessons_learned| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|description_item| |analysed_item| |resource_as_realized_item| |project_item| |product_based_location_representation| |Document_assignment| |defined_activities| |requirement_source_item| |defined_methods| |verification_evidence_item| |risk_communication_select|)
   ""
  ())


(def-mm-class |Like_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Comparison_expression|)
   ""
  ())


(def-mm-class |Line| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Curve|)
   ""
  ())


(def-mm-class |Literal_number| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_literal| |Simple_numeric_expression|)
   ""
  ((|the_value| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Local_time| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |issue_reference_item|)
   ""
  ((|hour_component| :range |hour_in_day| :multiplicity (1 1 ))
   (|minute_component| :range |minute_in_hour| :multiplicity (0 1 ))
   (|second_component| :range |second_in_minute| :multiplicity (0 1 ))
   (|zone| :range |Time_offset| :multiplicity (1 1 ))))


(def-mm-class |Location| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|state_of_item| |activity_item| |position_type_item| |classification_item| |documented_element_select| |position_item| |position_group_item| |issue_reference_item| |identification_item| |groupable_item| |work_output_item| |string_select| |activity_method_item| |resource_item_select| |justification_support_item| |resource_assignment_item| |state_definition_of_item| |classified_attribute_select|)
   ""
  ((|alternative_location_representations| :range |Location_representation| :multiplicity (0 -1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Location_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_item| |classification_item| |documented_element_select| |issue_reference_item| |date_or_date_time_item| |string_select| |verification_evidence_item| |justification_support_item| |property_assignment_select| |justification_item| |organization_or_person_in_organization_item| |effectivity_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|entity_for_location| :range |location_assignment_select| :multiplicity (1 1 ))
   (|location_for_assignment| :range |Location| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Location_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |documented_element_select| |classification_item| |string_select| |classified_attribute_select|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Location| :multiplicity (1 1 ))
   (|relating| :range |Location| :multiplicity (1 1 ))))


(def-mm-class |Location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |issue_reference_item| |classification_item| |identification_item| |documented_element_select| |activity_item|)
   ""
  ())


(def-mm-class |Log10_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Log2_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Log_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Looping_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Structured_task_element|)
   ""
  ((|repeated_element| :range |Task_element| :multiplicity (1 1 ))))


(def-mm-class |Lot_effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Effectivity|)
   ""
  ((|lot_id| :range |String| :multiplicity (1 1 ))
   (|lot_size| :range |Value_with_unit| :multiplicity (1 1 ))))


(def-mm-class |Luminous_intensity_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Make_from_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|View_definition_usage|)
   ""
  ((|priority| :range |Integer| :multiplicity (0 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Managed_resource| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |activity_item| |date_or_date_time_item| |approval_item| |string_select| |condition_parameter_item| |groupable_item| |condition_item| |description_item| |characterized_resource_select| |required_resource_item| |contract_item| |product_based_location_representation| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |documented_element_select| |identification_item| |information_usage_right_item| |issue_reference_item| |classified_attribute_select| |observed_context| |classification_item| |resource_assignment_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|item| :range |Resource_item| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Managed_resource_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |condition_item| |analysed_item| |issue_reference_item| |classified_attribute_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Managed_resource| :multiplicity (1 1 ))
   (|relating| :range |Managed_resource| :multiplicity (1 1 ))))


(def-mm-class |Market| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |product_based_location_representation| |identification_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|market_segment_type| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Mass_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Maximum_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_function_call|)
   ""
  ())


(def-mm-class |Measure_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ())


(def-mm-class |Measure_item_with_precision| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|significant_digits| :range |Integer| :multiplicity (1 1 ))))


(def-mm-class |Measure_qualification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|qualified_measure| :range |Value_with_unit| :multiplicity (1 1 ))
   (|qualifiers| :range |value_qualifier| :multiplicity (1 -1 ))))


(def-mm-class |Minimum_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_function_call|)
   ""
  ())


(def-mm-class |Minus_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Minus_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Mod_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Monitor| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_activity_structure|)
   ""
  ())


(def-mm-class |Mult_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_numeric_expression|)
   ""
  ())


(def-mm-class |Multiple_arity_boolean_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_generic_expression| |Boolean_expression|)
   ""
  ())


(def-mm-class |Multiple_arity_function_call| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_numeric_expression|)
   ""
  ())


(def-mm-class |Multiple_arity_generic_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_expression|)
   ""
  ((|operands| :range |Generic_expression| :multiplicity (2 -1 )
  :is-ordered-p t )))


(def-mm-class |Multiple_arity_numeric_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_generic_expression| |Numeric_expression|)
   ""
  ())


(def-mm-class |Multiple_decision_point| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Structured_task_element|)
   ""
  ())


(def-mm-class |Name_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|items| :range |assigned_name_select| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Named_variable_semantics| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Variable_semantics|)
   ""
  ((|name| :range |String| :multiplicity (1 1 ))
   (|variable_context| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Next_assembly_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assembly_component_relationship|)
   ""
  ())


(def-mm-class |Not_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_boolean_expression|)
   ""
  ())


(def-mm-class |Numeric_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Defined_function| |Numeric_expression|)
   ""
  ())


(def-mm-class |Numeric_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Expression|)
   ""
  ((|/is_int| :range |Boolean| :multiplicity (1 1 ))
   (|/sql_mappable| :range |Boolean| :multiplicity (1 1 ))))


(def-mm-class |Numeric_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_numeric_expression| |Variable|)
   ""
  ())


(def-mm-class |Numerical_document_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|descriptive_or_numerical| |activity_item| |Numerical_item_with_unit| |justification_support_item| |justification_item|)
   ""
  ())


(def-mm-class |Numerical_item_with_global_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|value_component| :range |measure_value| :multiplicity (1 1 ))))


(def-mm-class |Numerical_item_with_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item| |Value_with_unit|)
   ""
  ())


(def-mm-class |Numerical_representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_context|)
   ""
  ((|accuracies| :range |Uncertainty_with_unit| :multiplicity (0 -1 ))
   (|units| :range |Unit| :multiplicity (0 -1 ))))


(def-mm-class |Observation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |assigned_name_select| |date_or_date_time_item| |approval_item| |condition_parameter_item| |string_select| |groupable_item| |analysed_item| |description_item| |resource_as_realized_item| |product_based_location_representation| |state_of_item| |time_interval_item| |requirement_source_item| |issue_reference_item| |identification_item| |documented_element_select| |verification_evidence_item| |classification_item| |risk_perception_source_item| |justification_support_item| |security_classification_item|)
   ""
  ((|applies_to| :range |Observation_item| :multiplicity (0 -1 ))
   (|description| :range |String| :multiplicity (1 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|in_context| :range |observed_context| :multiplicity (0 -1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|observed_by| :range |observation_recorder| :multiplicity (0 -1 ))
   (|observed_during| :range |Activity_actual| :multiplicity (0 1 ))
   (|related_records| :range |Observation_item| :multiplicity (0 -1 ))))


(def-mm-class |Observation_consequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |property_assignment_select| |activity_item| |string_select| |analysed_item| |resource_as_realized_item| |state_of_item| |state_definition_of_item| |defined_activities| |defined_methods| |identification_item| |documented_element_select| |issue_reference_item| |observed_context| |verification_evidence_item| |type_of_person_item_select| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|id| :range |String| :multiplicity (1 1 ))
   (|infered_from| :range |Observation| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|requests| :range |Work_request| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Observation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|security_classification_item| |analysed_item| |classification_item| |resource_as_realized_item|)
   ""
  ((|access_comment| :range |String| :multiplicity (1 1 ))
   (|item_identifier| :range |String| :multiplicity (1 1 ))
   (|item_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Observation_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |analysed_item| |issue_reference_item| |verification_evidence_item| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|related| :range |Observation| :multiplicity (1 1 ))
   (|relating| :range |Observation| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Odd_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_boolean_expression|)
   ""
  ())


(def-mm-class |Or_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_boolean_expression|)
   ""
  ())


(def-mm-class |Or_state_cause_effect_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_cause_effect_definition|)
   ""
  ())


(def-mm-class |Organization| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|qualifications_select| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |activity_item| |condition_parameter_item| |analysed_item| |affected_item_select| |project_item| |position_context_item| |person_or_organization_or_person_in_organization_select| |contract_item| |required_resource_item| |product_based_location_representation| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |requirement_source_item| |organization_or_person_in_organization_select| |information_usage_right_item| |documented_element_select| |issue_reference_item| |identification_item| |position_person_or_organization_or_person_in_organization_select| |classification_item| |resource_item_select| |defined_attributes| |risk_perception_source_item| |external_identification_item|)
   ""
  ((|id| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Organization_based_location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Location_representation|)
   ""
  ((|location_identifications| :range |Organizational_location_identification| :multiplicity (0 -1 )
  :is-ordered-p t )
   (|organization_for_location| :range |Organization| :multiplicity (1 1 ))))


(def-mm-class |Organization_or_person_in_organization_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |condition_parameter_item| |affected_item_select| |person_or_organization_or_person_in_organization_select| |position_group_item| |position_item| |condition_evaluation_parameter_item| |requirement_source_item| |documented_element_select| |classified_attribute_select| |issue_reference_item| |identification_item| |verification_evidence_item| |position_type_item| |classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|assigned_entity| :range |organization_or_person_in_organization_select| :multiplicity (1 1 ))
   (|items| :range |organization_or_person_in_organization_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Organization_organization_type_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |date_or_date_time_item| |approval_item|)
   ""
  ((|organization| :range |Organization| :multiplicity (1 1 ))
   (|organization_type| :range |Organization_type| :multiplicity (1 1 ))))


(def-mm-class |Organization_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |approval_item| |date_or_date_time_item| |string_select| |analysed_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_organization| :range |Organization| :multiplicity (1 1 ))
   (|relating_organization| :range |Organization| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Organization_type| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |string_select| |condition_parameter_item| |product_based_location_representation| |location_assignment_select| |work_output_item| |identification_item| |documented_element_select| |issue_reference_item| |resource_item_select| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Organizational_location_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |documented_element_select| |identification_item| |classified_attribute_select| |issue_reference_item| |classification_item|)
   ""
  ((|identification_type| :range |String| :multiplicity (1 1 ))
   (|location_value| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Parameter_value_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ((|parameter_value| :range |parameter_value_select| :multiplicity (1 1 ))))


(def-mm-class |Parameterized_distribution| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability_distribution|)
   ""
  ((|has_parameters| :range |Probability_distribution_parameter| :multiplicity (1 -1 )
  :is-ordered-p t )
   (|parameterization_name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Part| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |selected_item_context_items| |Product| |contract_item|)
   ""
  ())


(def-mm-class |Part_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|selected_item_context_items| |Product_version|)
   ""
  ())


(def-mm-class |Part_view_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ())


(def-mm-class |Partial_document_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Document_assignment|)
   ""
  ((|document_portion| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Person| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|qualifications_select| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |date_or_date_time_item| |affected_item_select| |person_or_organization_or_person_in_organization_select| |location_assignment_select| |work_output_item| |documented_element_select| |identification_item| |position_person_or_organization_or_person_in_organization_select| |issue_reference_item| |observation_recorder| |verification_evidence_item| |type_of_person_item_select| |classification_item| |resource_item_select| |risk_perception_source_item|)
   ""
  ((|first_name| :range |String| :multiplicity (0 1 ))
   (|last_name| :range |String| :multiplicity (1 1 ))
   (|middle_names| :range |String| :multiplicity (0 -1 ))
   (|prefix_titles| :range |String| :multiplicity (0 -1 ))
   (|suffix_titles| :range |String| :multiplicity (0 -1 ))))


(def-mm-class |Person_in_organization| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|qualifications_select| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |effectivity_item| |property_assignment_select| |date_or_date_time_item| |activity_item| |approval_item| |string_select| |project_item| |affected_item_select| |person_or_organization_or_person_in_organization_select| |contract_item| |required_resource_item| |product_based_location_representation| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |requirement_source_item| |organization_or_person_in_organization_select| |information_usage_right_item| |classified_attribute_select| |position_person_or_organization_or_person_in_organization_select| |observation_recorder| |identification_item| |documented_element_select| |issue_reference_item| |type_of_person_item_select| |verification_evidence_item| |resource_item_select| |resource_assignment_item| |classification_item| |risk_perception_source_item| |external_identification_item| |defined_attributes|)
   ""
  ((|concerned_person| :range |Person| :multiplicity (1 1 ))
   (|containing_organization| :range |Organization| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Person_or_organization_or_person_in_organization_in_position| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|approval_item| |date_or_date_time_item| |person_or_organization_or_person_in_organization_select| |issue_reference_item| |documented_element_select| |identification_item| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|person_or_organization| :range |position_person_or_organization_or_person_in_organization_select| :multiplicity (1 1 ))
   (|position| :range |Position| :multiplicity (1 1 ))))


(def-mm-class |Person_or_organization_or_person_in_organization_in_position_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |date_or_date_time_item| |approval_item| |person_or_organization_or_person_in_organization_select| |identification_item| |documented_element_select| |issue_reference_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Person_or_organization_or_person_in_organization_in_position| :multiplicity (1 1 ))
   (|relating| :range |Person_or_organization_or_person_in_organization_in_position| :multiplicity (1 1 ))))


(def-mm-class |Physical_breakdown| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown|)
   ""
  ())


(def-mm-class |Physical_breakdown_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_context|)
   ""
  ())


(def-mm-class |Physical_breakdown_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_version|)
   ""
  ())


(def-mm-class |Physical_document_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Document_definition|)
   ""
  ((|components| :range |Hardcopy| :multiplicity (0 -1 ))))


(def-mm-class |Physical_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element|)
   ""
  ())


(def-mm-class |Physical_element_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_definition|)
   ""
  ())


(def-mm-class |Physical_element_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_usage|)
   ""
  ())


(def-mm-class |Physical_element_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_version|)
   ""
  ())


(def-mm-class |Plane| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Surface|)
   ""
  ())


(def-mm-class |Plane_angle_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Plus_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_numeric_expression|)
   ""
  ())


(def-mm-class |Point_on_curve| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|supporting_curve| :range |Curve| :multiplicity (1 1 ))))


(def-mm-class |Point_on_surface| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|supporting_surface| :range |Surface| :multiplicity (1 1 ))))


(def-mm-class |Position| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |activity_item| |approval_item| |string_select| |required_resource_item| |location_assignment_select| |work_output_item| |documented_element_select| |identification_item| |issue_reference_item| |type_of_person_item_select| |resource_item_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|address| :range |Address| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|position_context| :range |position_context_item| :multiplicity (1 1 ))))


(def-mm-class |Position_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |approval_item| |issue_reference_item| |identification_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|items| :range |position_item| :multiplicity (1 -1 ))
   (|position| :range |Position| :multiplicity (1 1 ))
   (|role| :range |Position_role| :multiplicity (1 1 ))))


(def-mm-class |Position_group| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |activity_item| |string_select| |position_context_item| |issue_reference_item| |identification_item| |documented_element_select| |type_of_person_item_select| |classification_item| |defined_attributes| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Position_group_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |issue_reference_item| |resource_assignment_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|items| :range |position_group_item| :multiplicity (1 -1 ))
   (|position_group| :range |Position_group| :multiplicity (1 1 ))
   (|role| :range |Position_group_role| :multiplicity (1 1 ))))


(def-mm-class |Position_group_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |issue_reference_item| |risk_perception_source_item|)
   ""
  ((|group| :range |Position_group| :multiplicity (1 1 ))
   (|position| :range |Position| :multiplicity (1 1 ))))


(def-mm-class |Position_group_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |defined_attributes|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Position_position_type_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |issue_reference_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_position_type| :range |Position_type| :multiplicity (1 1 ))
   (|assigned_to| :range |Position| :multiplicity (1 1 ))))


(def-mm-class |Position_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |risk_perception_source_item| |issue_reference_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related_position| :range |Position| :multiplicity (1 1 ))
   (|relating_position| :range |Position| :multiplicity (1 1 ))))


(def-mm-class |Position_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|defined_attributes| |identification_item| |risk_perception_source_item| |string_select| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Position_type| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |organization_or_person_in_organization_item| |approval_item| |string_select| |required_resource_item| |location_assignment_select| |work_output_item| |issue_reference_item| |documented_element_select| |type_of_person_item_select| |classification_item| |resource_item_select| |risk_perception_source_item|)
   ""
  ((|defined_by| :range |Type_of_person| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Position_type_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |issue_reference_item| |documented_element_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|items| :range |position_type_item| :multiplicity (1 -1 ))
   (|position_type| :range |Position_type| :multiplicity (1 1 ))
   (|role| :range |Position_type_role| :multiplicity (1 1 ))))


(def-mm-class |Position_type_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |defined_attributes| |risk_perception_source_item| |documented_element_select|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Power_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Pre_defined_type_qualifier| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Type_qualifier|)
   ""
  ())


(def-mm-class |Precision_qualifier| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|value_qualifier|)
   ""
  ((|precision_value| :range |Integer| :multiplicity (1 1 ))))


(def-mm-class |Probability| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation|)
   ""
  ())


(def-mm-class |Probability_by_name| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability|)
   ""
  ((|/has_value| :range |Probability_named_value| :multiplicity (1 1 ))))


(def-mm-class |Probability_derivation_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_item_with_global_unit|)
   ""
  ())


(def-mm-class |Probability_derived| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability_numeric|)
   ""
  ((|derives_from| :range |Probability_generator| :multiplicity (1 1 ))
   (|has_parameter| :range |Probability_derivation_parameter| :multiplicity (1 -1 )
  :is-ordered-p t )))


(def-mm-class |Probability_distribution| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability_generator|)
   ""
  ((|distribution_name| :range |String| :multiplicity (0 1 ))
   (|is_continuous| :range |String| :multiplicity (1 1 ))
   (|mean| :range |Double| :multiplicity (1 1 ))
   (|variance| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Probability_distribution_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_item_with_global_unit|)
   ""
  ())


(def-mm-class |Probability_function_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_item_with_global_unit|)
   ""
  ())


(def-mm-class |Probability_generator| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation|)
   ""
  ())


(def-mm-class |Probability_named_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ())


(def-mm-class |Probability_numeric| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Probability|)
   ""
  ((|/has_value| :range |Probability_numeric_value| :multiplicity (1 1 ))))


(def-mm-class |Probability_numeric_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_item_with_global_unit|)
   ""
  ())


(def-mm-class |Probability_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Property_representation|)
   ""
  ())


(def-mm-class |Product| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |project_item| |documented_element_select| |defined_methods| |activity_item| |security_classification_item| |product_based_location_representation| |position_group_item| |justification_support_item| |requirement_assignment_item| |condition_parameter_item| |product_select| |external_identification_item| |state_definition_of_item| |issue_reference_item| |approval_item| |resource_assignment_item| |observed_context| |groupable_item| |work_output_item| |string_select| |defined_activities| |risk_perception_source_item| |position_type_item| |affected_item_select| |required_resource_item| |organization_or_person_in_organization_item| |type_of_person_item_select| |analysed_item| |event_item| |justification_item| |location_assignment_select| |verification_evidence_item| |state_of_item| |information_usage_right_item| |activity_method_item| |requirement_source_item| |identification_item| |description_item| |position_item| |condition_evaluation_parameter_item| |assigned_name_select| |effectivity_item| |selected_item_select| |classified_attribute_select| |property_assignment_select| |resource_item_select| |certification_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Product_as_individual| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item| |Product| |selected_item_context_items|)
   ""
  ())


(def-mm-class |Product_as_individual_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|selected_item_context_items| |Product_version|)
   ""
  ())


(def-mm-class |Product_as_individual_view| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ())


(def-mm-class |Product_as_planned| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_as_individual_version|)
   ""
  ())


(def-mm-class |Product_as_realized| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|observation_recorder| |Product_as_individual_version|)
   ""
  ())


(def-mm-class |Product_based_location_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Location_representation|)
   ""
  ((|location_identification| :range |String| :multiplicity (1 1 ))
   (|location_name| :range |String| :multiplicity (0 1 ))
   (|referenced_product| :range |product_based_location_representation| :multiplicity (1 1 ))))


(def-mm-class |Product_category| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |string_select| |description_item| |position_group_item| |position_item| |state_definition_of_item| |issue_reference_item| |identification_item| |documented_element_select| |information_usage_right_item| |classified_attribute_select| |position_type_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Product_category_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |condition_parameter_item| |condition_evaluation_parameter_item| |issue_reference_item| |documented_element_select|)
   ""
  ((|category| :range |Product_category| :multiplicity (1 1 ))
   (|products| :range |Product| :multiplicity (1 -1 ))))


(def-mm-class |Product_category_hierarchy| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|sub_category| :range |Product_category| :multiplicity (1 1 ))
   (|super_category| :range |Product_category| :multiplicity (1 1 ))))


(def-mm-class |Product_concept| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|product_select| |activity_method_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |activity_item| |condition_parameter_item| |analysed_item| |project_item| |position_group_item| |product_based_location_representation| |position_item| |state_of_item| |condition_evaluation_parameter_item| |state_definition_of_item| |requirement_source_item| |identification_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |observed_context| |position_type_item| |classification_item| |risk_perception_source_item| |selected_item_context_items|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|target_market| :range |Market| :multiplicity (0 1 ))))


(def-mm-class |Product_configuration| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |organization_or_person_in_organization_item| |effectivity_item| |property_assignment_select| |certification_item| |activity_item| |date_or_date_time_item| |approval_item| |condition_parameter_item| |string_select| |affected_item_select| |project_item| |position_group_item| |contract_item| |position_item| |state_of_item| |state_definition_of_item| |requirement_assignment_item| |information_usage_right_item| |documented_element_select| |identification_item| |issue_reference_item| |observed_context| |position_type_item| |classification_item| |security_classification_item| |selected_item_context_items|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|item_context| :range |Product_concept| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Product_definition_element_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_evaluation_item| |condition_evaluation_parameter_item| |condition_parameter_item| |approval_item| |condition_item| |issue_reference_item|)
   ""
  ((|breakdown| :range |breakdown_item| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|product| :range |product_item| :multiplicity (1 1 ))))


(def-mm-class |Product_design_to_individual| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |date_or_date_time_item| |approval_item| |analysed_item| |documented_element_select| |issue_reference_item| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|individual_product| :range |Product_as_individual| :multiplicity (1 1 ))
   (|product_design| :range |Product| :multiplicity (1 1 ))))


(def-mm-class |Product_design_version_to_individual| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |approval_item| |date_or_date_time_item| |analysed_item| |documented_element_select| |issue_reference_item| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|individual_product| :range |Product_as_individual_version| :multiplicity (1 1 ))
   (|product_design_version| :range |Product_version| :multiplicity (1 1 ))))


(def-mm-class |Product_group| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|product_select| |activity_method_item| |organization_or_person_in_organization_item| |effectivity_item| |certification_item| |property_assignment_select| |product_item| |approval_item| |date_or_date_time_item| |activity_item| |string_select| |condition_item| |project_item| |affected_item_select| |position_group_item| |contract_item| |position_item| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |defined_methods| |identification_item| |issue_reference_item| |documented_element_select| |observed_context| |position_type_item| |resource_item_select| |resource_assignment_item| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|membership_rule| :range |String| :multiplicity (0 1 ))
   (|product_group_context| :range |String| :multiplicity (0 1 ))
   (|purpose| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Product_group_membership| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |condition_item| |project_item| |issue_reference_item| |documented_element_select| |identification_item| |security_classification_item|)
   ""
  ((|member| :range |product_select| :multiplicity (1 1 ))
   (|of_group| :range |Product_group| :multiplicity (1 1 ))))


(def-mm-class |Product_group_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |certification_item| |date_or_date_time_item| |approval_item| |string_select| |analysed_item| |condition_item| |project_item| |contract_item| |identification_item| |documented_element_select| |issue_reference_item| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related| :range |Product_group| :multiplicity (1 1 ))
   (|relating| :range |Product_group| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Product_occurrence_definition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|described_element_select| |shapeable_item|)
   ""
  ((|related_view| :range |Product_view_definition| :multiplicity (1 1 ))
   (|relating_view| :range |Product_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Product_planned_to_realized| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |approval_item| |date_or_date_time_item| |analysed_item| |documented_element_select| |issue_reference_item| |observed_context| |classification_item| |risk_perception_source_item|)
   ""
  ((|planned_product| :range |Product_as_planned| :multiplicity (1 1 ))
   (|realized_product| :range |Product_as_realized| :multiplicity (1 1 ))))


(def-mm-class |Product_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |string_select| |analysed_item| |documented_element_select| |identification_item| |issue_reference_item| |classified_attribute_select| |classification_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_product| :range |Product| :multiplicity (1 1 ))
   (|relating_product| :range |Product| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Product_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |project_item| |documented_element_select| |activity_item| |version_or_definition| |product_based_location_representation| |security_classification_item| |justification_support_item| |position_group_item| |requirement_assignment_item| |condition_parameter_item| |product_select| |state_definition_of_item| |contract_item| |issue_reference_item| |approval_item| |resource_assignment_item| |observed_context| |work_output_item| |string_select| |risk_perception_source_item| |affected_item_select| |position_type_item| |required_resource_item| |organization_or_person_in_organization_item| |type_of_person_item_select| |analysed_item| |event_item| |justification_item| |verification_evidence_item| |location_assignment_select| |state_of_item| |information_usage_right_item| |activity_method_item| |requirement_source_item| |identification_item| |position_item| |description_item| |condition_evaluation_parameter_item| |effectivity_item| |selected_item_select| |property_assignment_select| |classified_attribute_select| |date_or_date_time_item| |resource_item_select| |certification_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|of_product| :range |Product| :multiplicity (1 1 ))))


(def-mm-class |Product_version_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |risk_impact_item| |effectivity_item| |certification_item| |property_assignment_select| |activity_item| |date_or_date_time_item| |approval_item| |analysed_item| |resource_as_realized_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_version| :range |Product_version| :multiplicity (1 1 ))
   (|relating_version| :range |Product_version| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Product_view_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|in_zone_item| |risk_impact_item| |project_item| |documented_element_select| |activity_item| |version_or_definition| |security_classification_item| |shapeable_item| |position_group_item| |justification_support_item| |condition_parameter_item| |requirement_assignment_item| |state_definition_of_item| |issue_reference_item| |approval_item| |resource_assignment_item| |parameter_value_select| |interface_definition_item| |observed_context| |work_output_item| |string_select| |risk_perception_source_item| |affected_item_select| |position_type_item| |required_resource_item| |organization_or_person_in_organization_item| |analysed_item| |event_item| |justification_item| |location_assignment_select| |verification_evidence_item| |information_usage_right_item| |activity_method_item| |connection_definition_items| |requirement_source_item| |identification_item| |position_item| |description_item| |condition_evaluation_parameter_item| |effectivity_item| |assigned_name_select| |classified_attribute_select| |property_assignment_select| |date_or_date_time_item| |connector_on_item| |resource_item_select| |product_item| |resource_as_realized_item| |classification_item|)
   ""
  ((|additional_characterization| :range |String| :multiplicity (0 1 ))
   (|additional_contexts| :range |View_definition_context| :multiplicity (0 -1 ))
   (|defined_version| :range |Product_version| :multiplicity (1 1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|initial_context| :range |View_definition_context| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Project| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |certification_item| |activity_item| |date_or_date_time_item| |approval_item| |string_select| |groupable_item| |resource_as_realized_item| |position_context_item| |position_group_item| |contract_item| |required_resource_item| |product_based_location_representation| |position_item| |state_of_item| |work_item| |location_assignment_select| |state_definition_of_item| |defined_activities| |requirement_assignment_item| |documented_element_select| |issue_reference_item| |identification_item| |information_usage_right_item| |type_of_person_item_select| |position_type_item| |observed_context| |classification_item| |resource_assignment_item| |justification_support_item| |risk_perception_source_item| |external_identification_item| |selected_item_context_items|)
   ""
  ((|actual_end_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|actual_start_date| :range |date_or_date_time_select| :multiplicity (0 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|planned_end_date| :range |date_or_event| :multiplicity (0 1 ))
   (|planned_start_date| :range |date_or_event| :multiplicity (0 1 ))
   (|responsible_organizations| :range |Organization| :multiplicity (0 -1 ))))


(def-mm-class |Project_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |risk_impact_item| |effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |condition_item| |resource_as_realized_item| |affected_item_select| |work_output_item| |requirement_source_item| |documented_element_select| |classified_attribute_select| |issue_reference_item| |type_of_person_item_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_project| :range |Project| :multiplicity (1 1 ))
   (|items| :range |project_item| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Project_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |analysed_item| |classified_attribute_select| |issue_reference_item| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related_project| :range |Project| :multiplicity (1 1 ))
   (|relating_project| :range |Project| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Promissory_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assembly_component_relationship|)
   ""
  ())


(def-mm-class |Property_definition_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |description_item| |property_assignment_select|)
   ""
  ((|definition| :range |represented_definition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|rep| :range |Representation| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |date_or_date_time_item| |condition_parameter_item| |condition_evaluation_parameter_item| |classified_attribute_select| |documented_element_select| |observed_context| |classification_item| |Property_definition_representation|)
   ""
  ((|/property| :range |Assigned_property| :multiplicity (1 1 ))))


(def-mm-class |Property_value_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |Representation|)
   ""
  ())


(def-mm-class |Qualification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |certification_item| |date_or_date_time_item| |approval_item| |condition_item| |issue_reference_item| |documented_element_select| |identification_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_qualification_type| :range |Qualification_type| :multiplicity (1 1 ))
   (|received_by| :range |qualifications_select| :multiplicity (1 1 ))))


(def-mm-class |Qualification_type| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |approval_item| |string_select| |documented_element_select| |issue_reference_item| |identification_item| |classification_item| |defined_attributes| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Qualification_type_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Qualification_type| :multiplicity (1 1 ))
   (|relating| :range |Qualification_type| :multiplicity (1 1 ))))


(def-mm-class |Qualified_numerical_item_with_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Qualified_representation_item| |Numerical_item_with_unit|)
   ""
  ())


(def-mm-class |Qualified_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ((|qualifiers| :range |value_qualifier| :multiplicity (1 -1 ))))


(def-mm-class |Qualitative_uncertainty| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Uncertainty_qualifier|)
   ""
  ((|uncertainty_value| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Random_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numerical_item_with_global_unit|)
   ""
  ())


(def-mm-class |Ratio_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Real_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_defined_function|)
   ""
  ())


(def-mm-class |Real_literal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Literal_number|)
   ""
  ())


(def-mm-class |Real_numeric_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_variable|)
   ""
  ())


(def-mm-class |Regional_coordinate| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |classification_item| |string_select| |classified_attribute_select|)
   ""
  ((|coordinate_value| :range |Value_with_unit| :multiplicity (1 1 ))
   (|grid_system| :range |Regional_grid_location_representation| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Regional_grid_location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Location_representation|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Related_condition_parameter| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select| |string_select| |classification_item| |observed_context| |classified_attribute_select| |issue_reference_item|)
   ""
  ((|condition_parameter| :range |Condition_parameter| :multiplicity (1 1 ))
   (|conditon_evaluation_parameter| :range |Condition_evaluation_parameter| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Related_consequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|View_definition_relationship|)
   ""
  ())


(def-mm-class |Relative_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Event|)
   ""
  ((|base_event| :range |Event| :multiplicity (1 1 ))
   (|offset| :range |Duration| :multiplicity (1 1 ))))


(def-mm-class |Repeat_count| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Looping_element|)
   ""
  ((|count| :range |Integer| :multiplicity (1 1 ))))


(def-mm-class |Repeat_until| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Looping_element|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))))


(def-mm-class |Repeat_while| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Looping_element|)
   ""
  ((|condition| :range |Condition| :multiplicity (1 1 ))))


(def-mm-class |Representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |parameter_value_select| |date_or_date_time_item| |condition_parameter_item| |description_item| |resource_as_realized_item| |project_item| |product_based_location_representation| |condition_evaluation_parameter_item| |classified_attribute_select| |identification_item| |issue_reference_item| |documented_element_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|context_of_items| :range |Representation_context| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|items| :range |Representation_item| :multiplicity (1 -1 ))
   (|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select| |verification_evidence_item| |issue_reference_item| |classification_item| |classified_attribute_select|)
   ""
  ((|id| :range |String| :multiplicity (1 1 ))
   (|kind| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |documented_element_select| |issue_reference_item| |parameter_value_select| |observed_context| |string_select| |risk_perception_source_item| |event_item| |verification_evidence_item| |information_usage_right_item| |identification_item| |description_item| |classified_attribute_select| |property_assignment_select| |resource_as_realized_item| |classification_item|)
   ""
  ((|name| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Representation_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|relation_type| :range |String| :multiplicity (0 1 ))
   (|rep_1| :range |Representation| :multiplicity (1 1 ))
   (|rep_2| :range |Representation| :multiplicity (1 1 ))))


(def-mm-class |Required_resource| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |resource_as_realized_relationship_select| |justification_item| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |approval_item| |date_or_date_time_item| |condition_parameter_item| |string_select| |groupable_item| |condition_item| |characterized_resource_select| |position_group_item| |product_based_location_representation| |position_item| |location_assignment_select| |work_output_item| |defined_methods| |condition_evaluation_item| |identification_item| |documented_element_select| |information_usage_right_item| |classified_attribute_select| |issue_reference_item| |position_type_item| |observed_context| |classification_item| |risk_perception_source_item| |external_identification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|required_quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Required_resource_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |date_or_date_time_item| |approval_item| |condition_parameter_item| |condition_item| |characterized_activity_definition| |location_assignment_select| |documented_element_select| |issue_reference_item| |observed_context| |type_of_person_item_select| |verification_evidence_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_resource| :range |Required_resource| :multiplicity (1 1 ))
   (|item| :range |required_resource_item| :multiplicity (1 1 ))))


(def-mm-class |Required_resource_by_resource_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Required_resource|)
   ""
  ((|resource_item| :range |Resource_item| :multiplicity (1 1 ))))


(def-mm-class |Required_resource_by_specification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|requirement_assignment_item| |Required_resource|)
   ""
  ())


(def-mm-class |Required_resource_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |effectivity_item| |approval_item| |string_select| |condition_parameter_item| |condition_item| |documented_element_select| |classified_attribute_select| |issue_reference_item| |identification_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Required_resource| :multiplicity (1 1 ))
   (|relating| :range |Required_resource| :multiplicity (1 1 ))))


(def-mm-class |Requirement| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item| |Product| |date_or_date_time_item|)
   ""
  ())


(def-mm-class |Requirement_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |activity_method_item| |organization_or_person_in_organization_item| |effectivity_item| |activity_item| |date_or_date_time_item| |approval_item| |string_select| |analysed_item| |condition_item| |resource_as_realized_item| |contract_item| |documented_element_select| |information_usage_right_item| |identification_item| |issue_reference_item| |observed_context| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|assigned_requirement| :range |Requirement_view_definition| :multiplicity (1 1 ))
   (|assigned_to| :range |requirement_assignment_item| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Requirement_collection_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item| |security_classification_item| |View_definition_relationship| |date_or_date_time_item|)
   ""
  ((|/collection| :range |Requirement_view_definition| :multiplicity (1 1 ))
   (|/member| :range |Requirement_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Requirement_source| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |organization_or_person_in_organization_item| |effectivity_item| |property_assignment_select| |activity_item| |approval_item| |date_or_date_time_item| |string_select| |contract_item| |condition_evaluation_parameter_item| |identification_item| |issue_reference_item| |documented_element_select| |classification_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|source| :range |requirement_source_item| :multiplicity (1 1 ))
   (|sourced_requirement| :range |Requirement_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Requirement_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |Requirement_version_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version_relationship|)
   ""
  ((|/predecessor| :range |Requirement_version| :multiplicity (1 1 ))
   (|/successor| :range |Requirement_version| :multiplicity (1 1 ))))


(def-mm-class |Requirement_view_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition| |contract_item|)
   ""
  ())


(def-mm-class |Resource_as_realized| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |activity_item| |condition_parameter_item| |string_select| |characterized_resource_select| |state_of_item| |work_output_item| |state_definition_of_item| |defined_activities| |identification_item| |classified_attribute_select| |issue_reference_item| |documented_element_select| |observed_context| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Resource_as_realized_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |characterized_activity_definition| |state_of_item| |state_definition_of_item| |issue_reference_item| |observed_context| |verification_evidence_item| |classification_item|)
   ""
  ((|assigned_resource| :range |Resource_as_realized| :multiplicity (1 1 ))
   (|item| :range |resource_as_realized_item| :multiplicity (1 1 ))))


(def-mm-class |Resource_as_realized_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_parameter_item| |string_select| |state_of_item| |state_definition_of_item| |classified_attribute_select| |issue_reference_item| |verification_evidence_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |resource_as_realized_relationship_select| :multiplicity (1 1 ))
   (|relating| :range |Resource_as_realized| :multiplicity (1 1 ))))


(def-mm-class |Resource_as_realized_resource_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Resource_as_realized|)
   ""
  ((|resource_item| :range |Resource_item| :multiplicity (1 1 ))))


(def-mm-class |Resource_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|resource_as_realized_relationship_select| |event_item| |justification_item| |risk_impact_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |activity_item| |approval_item| |condition_parameter_item| |string_select| |condition_item| |resource_as_realized_item| |position_group_item| |contract_item| |product_based_location_representation| |position_item| |characterized_activity_definition| |state_of_item| |state_definition_of_item| |requirement_source_item| |condition_evaluation_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |identification_item| |observed_context| |position_type_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))
   (|resource| :range |Managed_resource| :multiplicity (1 1 ))))


(def-mm-class |Resource_event_correspondence_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |resource_as_realized_item| |state_of_item| |state_definition_of_item| |classified_attribute_select| |issue_reference_item| |verification_evidence_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Required_resource| :multiplicity (1 1 ))
   (|relating| :range |Resource_event| :multiplicity (1 1 ))))


(def-mm-class |Resource_event_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|string_select| |analysed_item| |condition_item| |resource_as_realized_item| |state_of_item| |state_definition_of_item| |issue_reference_item| |classified_attribute_select| |verification_evidence_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Resource_event| :multiplicity (1 1 ))
   (|relating| :range |Resource_event| :multiplicity (1 1 ))))


(def-mm-class |Resource_group_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Resource_item_relationship|)
   ""
  ((|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Resource_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |activity_method_item| |organization_or_person_in_organization_item| |certification_item| |date_or_date_time_item| |activity_item| |approval_item| |condition_parameter_item| |string_select| |groupable_item| |characterized_resource_select| |condition_item| |affected_item_select| |contract_item| |product_based_location_representation| |state_of_item| |location_assignment_select| |work_output_item| |state_definition_of_item| |identification_item| |issue_reference_item| |information_usage_right_item| |documented_element_select| |classified_attribute_select| |observed_context| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|resource_items| :range |resource_item_select| :multiplicity (0 -1 ))))


(def-mm-class |Resource_item_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |condition_item| |characterized_activity_definition| |state_of_item| |location_assignment_select| |state_definition_of_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |verification_evidence_item| |type_of_person_item_select| |observed_context| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_resource| :range |Resource_item| :multiplicity (1 1 ))
   (|item| :range |resource_assignment_item| :multiplicity (1 1 ))))


(def-mm-class |Resource_item_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |risk_impact_item| |effectivity_item| |approval_item| |condition_parameter_item| |string_select| |characterized_resource_select| |condition_item| |analysed_item| |state_of_item| |state_definition_of_item| |classified_attribute_select| |documented_element_select| |issue_reference_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Resource_item| :multiplicity (1 1 ))
   (|relating| :range |Resource_item| :multiplicity (1 1 ))))


(def-mm-class |Resource_property| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |risk_impact_item| |activity_method_item| |organization_or_person_in_organization_item| |effectivity_item| |property_assignment_select| |activity_item| |approval_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |condition_item| |analysed_item| |affected_item_select| |product_based_location_representation| |identification_item| |issue_reference_item| |classified_attribute_select| |documented_element_select| |observed_context| |classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|described_element| :range |characterized_resource_select| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Resource_property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |condition_parameter_item| |documented_element_select| |issue_reference_item| |classified_attribute_select| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|property| :range |Resource_property| :multiplicity (1 1 ))
   (|rep| :range |Representation| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Risk| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_communication_select| |condition_item| |date_or_date_time_item| |Product|)
   ""
  ())


(def-mm-class |Risk_acceptance| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_activity| |resource_assignment_item| |Activity|)
   ""
  ())


(def-mm-class |Risk_activity_structure| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_relationship|)
   ""
  ((|/child| :range |risk_activity| :multiplicity (1 1 ))
   (|/parent| :range |risk_activity| :multiplicity (1 1 ))))


(def-mm-class |Risk_analysis| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_activity| |parameter_value_select| |description_item| |resource_as_realized_item| |work_output_item| |defined_activities| |requirement_source_item| |condition_evaluation_item| |verification_evidence_item| |resource_assignment_item| |Activity|)
   ""
  ())


(def-mm-class |Risk_assessment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_communication_select| |resource_assignment_item| |resource_as_realized_item| |work_output_item| |Activity| |risk_activity|)
   ""
  ())


(def-mm-class |Risk_attitude| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|state_of_item| |Property_representation| |state_definition_of_item| |product_based_location_representation|)
   ""
  ((|/criticality_factor| :range |Property_value_representation| :multiplicity (1 1 ))))


(def-mm-class |Risk_communicated_items| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_communication| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|resource_assignment_item| |Activity| |risk_activity| |resource_as_realized_item| |verification_evidence_item|)
   ""
  ())


(def-mm-class |Risk_consequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_estimation_select| |risk_communication_select| |risk_treatment_select| |Product_view_definition|)
   ""
  ())


(def-mm-class |Risk_control| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|resource_assignment_item| |risk_activity| |resource_as_realized_item| |Activity| |risk_communication_select|)
   ""
  ())


(def-mm-class |Risk_estimation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_communication_select| |risk_activity| |resource_as_realized_item| |resource_assignment_item| |Activity| |verification_evidence_item|)
   ""
  ())


(def-mm-class |Risk_estimation_inputs| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_estimation_outputs| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_evaluation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_activity| |resource_as_realized_item| |work_output_item| |verification_evidence_item| |resource_assignment_item| |Activity| |risk_communication_select|)
   ""
  ())


(def-mm-class |Risk_evaluation_criteria| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_evaluation_inputs| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Event_assignment|)
   ""
  ((|associated_risk| :range |Risk_perception| :multiplicity (1 1 ))))


(def-mm-class |Risk_identification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_communication_select| |Activity| |risk_activity| |resource_assignment_item|)
   ""
  ())


(def-mm-class |Risk_identification_inputs| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_impact| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Risk_consequence|)
   ""
  ((|causal_consequence| :range |Risk_consequence| :multiplicity (0 1 ))))


(def-mm-class |Risk_impact_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |date_or_date_time_item| |condition_item| |resource_as_realized_item| |project_item| |position_group_item| |position_item| |state_of_item| |state_definition_of_item| |condition_evaluation_item| |issue_reference_item| |documented_element_select| |identification_item| |type_of_person_item_select| |verification_evidence_item| |position_type_item| |observed_context| |classification_item| |risk_communication_select| |risk_estimation_select|)
   ""
  ((|assigned_risk_impact| :range |Risk_impact| :multiplicity (1 1 ))
   (|items| :range |risk_impact_item| :multiplicity (1 -1 ))))


(def-mm-class |Risk_level| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Assigned_property|)
   ""
  ())


(def-mm-class |Risk_measure| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method|)
   ""
  ())


(def-mm-class |Risk_perception| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition| |risk_treatment_select| |risk_communication_select|)
   ""
  ((|/risk_perception_context| :range |Risk_perception_context| :multiplicity (1 1 ))))


(def-mm-class |Risk_perception_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select| |activity_item| |View_definition_context| |resource_as_realized_item| |project_item| |state_definition_of_item| |observed_context| |risk_communication_select|)
   ""
  ())


(def-mm-class |Risk_perception_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |View_definition_relationship| |risk_treatment_select| |risk_communication_select|)
   ""
  ((|/related_risk_perception| :range |Risk_perception| :multiplicity (1 1 ))
   (|/relating_risk_perception| :range |Risk_perception| :multiplicity (1 1 ))))


(def-mm-class |Risk_perception_source_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |date_or_date_time_item| |affected_item_select| |project_item| |position_group_item| |contract_item| |position_item| |issue_reference_item| |identification_item| |documented_element_select| |observed_context| |verification_evidence_item| |position_type_item| |resource_assignment_item| |risk_communication_select|)
   ""
  ((|assigned_risk| :range |Risk_perception| :multiplicity (1 1 ))
   (|items| :range |risk_perception_source_item| :multiplicity (1 -1 ))))


(def-mm-class |Risk_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_treatment_select| |Product_relationship|)
   ""
  ((|/related_risk| :range |Risk| :multiplicity (1 1 ))
   (|/relating_risk| :range |Risk| :multiplicity (1 1 ))))


(def-mm-class |Risk_treatment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_activity| |description_item| |resource_as_realized_item| |work_output_item| |requirement_source_item| |information_usage_right_item| |verification_evidence_item| |resource_assignment_item| |Activity| |risk_communication_select|)
   ""
  ())


(def-mm-class |Risk_treatment_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_assignment|)
   ""
  ())


(def-mm-class |Risk_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ((|/of_risk| :range |Risk| :multiplicity (1 1 ))))


(def-mm-class |SET-1-n-Textual_expression_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |Scheme| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method|)
   ""
  ())


(def-mm-class |Scheme_entry| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method|)
   ""
  ((|scheme| :range |Scheme_version| :multiplicity (1 1 ))))


(def-mm-class |Scheme_entry_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_method_assignment| |activity_item|)
   ""
  ((|/assigned_entry| :range |Scheme_entry| :multiplicity (1 1 ))))


(def-mm-class |Scheme_entry_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ((|/related_entry| :range |Scheme_entry| :multiplicity (1 1 ))
   (|/relating_entry| :range |Scheme_entry| :multiplicity (1 1 ))))


(def-mm-class |Scheme_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ((|/related_scheme| :range |Scheme| :multiplicity (1 1 ))
   (|/relating_scheme| :range |Scheme| :multiplicity (1 1 ))))


(def-mm-class |Scheme_subject_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_method_assignment|)
   ""
  ((|/assigned_scheme| :range |Scheme| :multiplicity (1 1 ))))


(def-mm-class |Scheme_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method|)
   ""
  ((|of_scheme| :range |Scheme| :multiplicity (1 1 ))))


(def-mm-class |Scheme_version_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_method_assignment|)
   ""
  ((|/assigned_scheme_version| :range |Scheme_version| :multiplicity (1 1 ))))


(def-mm-class |Scheme_version_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ((|/related_scheme_version| :range |Scheme_version| :multiplicity (1 1 ))
   (|/relating_scheme_version| :range |Scheme_version| :multiplicity (1 1 ))))


(def-mm-class |Security_classification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |contract_item| |state_of_item| |state_definition_of_item| |issue_reference_item| |documented_element_select| |classified_attribute_select| |identification_item| |information_usage_right_item| |classification_item|)
   ""
  ((|classification_level| :range |String| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Security_classification_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |condition_item| |resource_as_realized_item| |identification_item| |documented_element_select| |information_usage_right_item| |issue_reference_item| |verification_evidence_item| |observed_context| |classification_item|)
   ""
  ((|classification| :range |Security_classification| :multiplicity (1 1 ))
   (|items| :range |security_classification_item| :multiplicity (1 -1 ))))


(def-mm-class |Selected_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Class| |date_or_date_time_item| |risk_perception_source_item|)
   ""
  ())


(def-mm-class |Selected_item_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|effectivity_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |issue_reference_item| |classification_item| |risk_perception_source_item|)
   ""
  ((|assigned_class| :range |Selected_item| :multiplicity (1 1 ))
   (|item| :range |selected_item_select| :multiplicity (1 1 ))
   (|item_context| :range |selected_item_context_items| :multiplicity (1 -1 ))))


(def-mm-class |Sequence_of_state| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_relationship|)
   ""
  ((|/predecessor| :range |State| :multiplicity (1 -1 ))
   (|/successor| :range |State| :multiplicity (1 -1 ))))


(def-mm-class |Sequence_of_state_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/predecessor| :range |State_definition| :multiplicity (1 -1 ))
   (|/successor| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |Sequencing_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Scheme_entry_relationship|)
   ""
  ((|sequencing_type| :range |String| :multiplicity (1 1 ))
   (|time_lag| :range |Time_interval| :multiplicity (0 1 ))))


(def-mm-class |Serial_effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Effectivity|)
   ""
  ((|end_id| :range |String| :multiplicity (0 1 ))
   (|start_id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Shape_dependent_property_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|characteristic_type| :range |String| :multiplicity (1 1 ))
   (|described_element| :range |shape_dependent_select| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|property_representation| :range |Representation| :multiplicity (1 1 ))))


(def-mm-class |Shape_description_association| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|representation| :range |shape_model| :multiplicity (1 1 ))
   (|represented_characteristic| :range |shape_select| :multiplicity (1 1 ))
   (|role| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Shape_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|documented_element_select| |geometric_item_specific_usage_select| |shape_select| |shape_dependent_select| |requirement_source_item|)
   ""
  ((|containing_shape| :range |Item_shape| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|element_name| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Shape_element_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|shape_select| |documented_element_select| |geometric_item_specific_usage_select| |issue_reference_item| |organization_or_person_in_organization_item| |identification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|related| :range |Shape_element| :multiplicity (1 1 ))
   (|relating| :range |Shape_element| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (0 1 ))))


(def-mm-class |Shape_placement_association| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Shape_description_association|)
   ""
  ())


(def-mm-class |Simple_boolean_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Boolean_expression| |Simple_generic_expression|)
   ""
  ())


(def-mm-class |Simple_generic_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_expression|)
   ""
  ())


(def-mm-class |Simple_numeric_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_generic_expression| |Numeric_expression|)
   ""
  ())


(def-mm-class |Simple_string_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_generic_expression| |String_expression|)
   ""
  ())


(def-mm-class |Simultaneous_elements| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Concurrent_elements|)
   ""
  ())


(def-mm-class |Sin_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Slash_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_numeric_expression|)
   ""
  ())


(def-mm-class |Solid_angle_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Sql_mappable_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Defined_function|)
   ""
  ())


(def-mm-class |Square_root_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Standard_uncertainty| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Uncertainty_qualifier|)
   ""
  ((|uncertainty_value| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Start_task| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ())


(def-mm-class |State| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|state_of_item| |analysed_item| |product_based_location_representation| |condition_parameter_item| |activity_item| |position_type_item| |classification_item| |resource_as_realized_item| |event_item| |observed_context| |documented_element_select| |position_item| |position_group_item| |issue_reference_item| |risk_perception_source_item| |risk_impact_item| |affected_item_select| |state_or_state_definition_select| |verification_evidence_item| |justification_support_item| |state_definition_of_item| |condition_evaluation_parameter_item| |requirement_source_item| |requirement_assignment_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_assertion| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_impact_item| |verification_evidence_item| |classification_item| |documented_element_select| |observed_context| |property_assignment_select| |justification_item| |issue_reference_item| |risk_perception_source_item|)
   ""
  ((|asserted_state| :range |State| :multiplicity (1 1 ))
   (|conformance_state| :range |State_definition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_assessment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|verification_evidence_item| |justification_item| |analysed_item| |classification_item| |resource_as_realized_item| |observed_context| |issue_reference_item| |approval_item| |property_assignment_select| |state_of_item| |condition_parameter_item| |documented_element_select| |risk_perception_source_item| |risk_impact_item|)
   ""
  ((|assessed_state| :range |State| :multiplicity (1 1 ))
   (|comparable_state| :range |State_definition| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_based_behaviour_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|behaviour_model| |Representation|)
   ""
  ())


(def-mm-class |State_based_behaviour_representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_context|)
   ""
  ())


(def-mm-class |State_based_behaviour_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ((|item| :range |state_based_behaviour_element| :multiplicity (1 1 ))))


(def-mm-class |State_cause_effect| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_relationship|)
   ""
  ((|/cause| :range |State| :multiplicity (1 -1 ))
   (|/effect| :range |State| :multiplicity (1 -1 ))))


(def-mm-class |State_cause_effect_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/cause| :range |State_definition| :multiplicity (1 -1 ))
   (|/effect| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_complement_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/set_1| :range |State_definition| :multiplicity (1 -1 ))
   (|/universe| :range |State_definition| :multiplicity (1 -1 ))
   (|set_2| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |activity_method_item| |certification_item| |parameter_value_select| |state_based_behaviour_element| |approval_item| |condition_parameter_item| |description_item| |condition_item| |analysed_item| |resource_as_realized_item| |affected_item_select| |behaviour_item| |required_resource_item| |behaviour_model| |product_based_location_representation| |state_or_state_definition_select| |state_of_item| |condition_evaluation_parameter_item| |work_output_item| |requirement_source_item| |requirement_assignment_item| |condition_evaluation_item| |identification_item| |issue_reference_item| |documented_element_select| |observed_context| |classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_definition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |effectivity_item| |state_based_behaviour_element| |approval_item| |condition_item| |description_item| |resource_as_realized_item| |state_of_item| |identification_item| |issue_reference_item| |observed_context| |classification_item| |justification_support_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |State_definition| :multiplicity (1 -1 ))
   (|relating| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_definition_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_observed| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State|)
   ""
  ())


(def-mm-class |State_predicted| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State|)
   ""
  ())


(def-mm-class |State_predicted_to_observed| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_relationship|)
   ""
  ((|/observed_state| :range |State_observed| :multiplicity (1 -1 ))
   (|/predicted_state| :range |State_predicted| :multiplicity (1 -1 ))))


(def-mm-class |State_proper_subset_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/proper_subset| :range |State_definition| :multiplicity (1 -1 ))
   (|/proper_superset| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|verification_evidence_item| |justification_support_item| |activity_item| |classification_item| |resource_as_realized_item| |observed_context| |issue_reference_item| |approval_item| |activity_method_item| |parameter_value_select| |state_of_item| |product_based_location_representation| |event_item| |risk_perception_source_item| |risk_impact_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |State| :multiplicity (1 -1 ))
   (|relating| :range |State| :multiplicity (1 -1 ))))


(def-mm-class |State_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|resource_as_realized_item| |analysed_item| |observed_context| |issue_reference_item| |state_of_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |State_subset_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/subset| :range |State_definition| :multiplicity (1 -1 ))
   (|/superset| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_symptom_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/symptom_cause| :range |State_definition| :multiplicity (1 -1 ))
   (|/symptom_effect| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |State_transition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_relationship|)
   ""
  ((|/end_state| :range |State| :multiplicity (1 -1 ))
   (|/start_state| :range |State| :multiplicity (1 -1 ))))


(def-mm-class |State_transition_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_definition_relationship|)
   ""
  ((|/end_state| :range |State_definition| :multiplicity (1 -1 ))
   (|/start_state| :range |State_definition| :multiplicity (1 -1 ))))


(def-mm-class |String_defined_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Defined_function| |String_expression|)
   ""
  ())


(def-mm-class |String_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Expression|)
   ""
  ())


(def-mm-class |String_literal| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_string_expression| |Generic_literal|)
   ""
  ((|the_value| :range |String| :multiplicity (1 1 ))))


(def-mm-class |String_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_item|)
   ""
  ((|string_value| :range |String| :multiplicity (1 1 ))))


(def-mm-class |String_variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Simple_string_expression| |Variable|)
   ""
  ())


(def-mm-class |Structured_task_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ())


(def-mm-class |Substring_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Multiple_arity_generic_expression| |String_expression|)
   ""
  ((|/index1| :range |Generic_expression| :multiplicity (1 1 ))
   (|/index2| :range |Generic_expression| :multiplicity (1 1 ))
   (|/operand| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Supplied_part_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version_relationship|)
   ""
  ())


(def-mm-class |Surface| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ())


(def-mm-class |System| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product|)
   ""
  ())


(def-mm-class |System_breakdown| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown|)
   ""
  ())


(def-mm-class |System_breakdown_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_context|)
   ""
  ())


(def-mm-class |System_breakdown_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_version|)
   ""
  ())


(def-mm-class |System_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element|)
   ""
  ())


(def-mm-class |System_element_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_definition|)
   ""
  ())


(def-mm-class |System_element_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_usage|)
   ""
  ())


(def-mm-class |System_element_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_version|)
   ""
  ())


(def-mm-class |System_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version|)
   ""
  ())


(def-mm-class |System_version_sequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_version_relationship|)
   ""
  ((|/predecessor| :range |System_version| :multiplicity (1 1 ))
   (|/successor| :range |System_version| :multiplicity (1 1 ))))


(def-mm-class |System_view_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Product_view_definition|)
   ""
  ())


(def-mm-class |Tan_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_function_call|)
   ""
  ())


(def-mm-class |Task_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method| |constraint_context|)
   ""
  ())


(def-mm-class |Task_element_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_method_assignment|)
   ""
  ((|/assigned_task_element| :range |Task_element| :multiplicity (1 1 ))))


(def-mm-class |Task_element_levels| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ((|alternatives| :range |Task_element| :multiplicity (2 -1 ))))


(def-mm-class |Task_element_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ())


(def-mm-class |Task_element_sequence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Structured_task_element|)
   ""
  ((|elements| :range |Task_element| :multiplicity (2 -1 )
  :is-ordered-p t )))


(def-mm-class |Task_element_state_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |issue_reference_item| |documented_element_select| |identification_item| |classification_item| |security_classification_item|)
   ""
  ((|state| :range |state_or_state_definition_select| :multiplicity (1 1 ))
   (|task_element| :range |Task_element| :multiplicity (1 1 ))))


(def-mm-class |Task_invocation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ((|task_method| :range |method_or_method_version| :multiplicity (1 1 ))))


(def-mm-class |Task_io| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |groupable_item| |analysed_item| |product_based_location_representation| |condition_evaluation_parameter_item| |work_output_item| |Task_element_assignment| |condition_evaluation_item|)
   ""
  ())


(def-mm-class |Task_io_hierarchy| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |activity_method_item| |property_assignment_select| |activity_item| |resource_as_realized_item| |state_definition_of_item| |issue_reference_item| |verification_evidence_item|)
   ""
  ((|child| :range |Task_io| :multiplicity (1 1 ))
   (|parent| :range |Task_io| :multiplicity (1 1 ))))


(def-mm-class |Task_method| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|method_or_method_version| |Activity_method|)
   ""
  ((|objective| :range |Task_objective| :multiplicity (0 -1 ))))


(def-mm-class |Task_method_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Applied_activity_method_assignment| |required_resource_item|)
   ""
  ())


(def-mm-class |Task_method_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ())


(def-mm-class |Task_method_state_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |identification_item| |issue_reference_item| |documented_element_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|state| :range |state_or_state_definition_select| :multiplicity (1 1 ))
   (|task_method| :range |Task_method_version| :multiplicity (1 1 ))))


(def-mm-class |Task_method_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method| |method_or_method_version| |constraint_context|)
   ""
  ((|content| :range |Task_element| :multiplicity (0 1 ))
   (|of_task_method| :range |Task_method| :multiplicity (1 1 ))))


(def-mm-class |Task_method_version_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|required_resource_item| |Applied_activity_method_assignment|)
   ""
  ((|/assigned_task_method| :range |Task_method_version| :multiplicity (1 1 ))))


(def-mm-class |Task_method_version_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Activity_method_relationship|)
   ""
  ((|/related_task_method| :range |Task_method_version| :multiplicity (1 1 ))
   (|/relating_task_method| :range |Task_method_version| :multiplicity (1 1 ))))


(def-mm-class |Task_objective| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |activity_method_item| |risk_impact_item| |organization_or_person_in_organization_item| |certification_item| |property_assignment_select| |date_or_date_time_item| |approval_item| |string_select| |resource_as_realized_item| |project_item| |contract_item| |characterized_activity_definition| |state_of_item| |issue_reference_item| |identification_item| |information_usage_right_item| |documented_element_select| |observed_context| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Task_objective_state_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |risk_impact_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |issue_reference_item| |identification_item| |documented_element_select| |verification_evidence_item| |classification_item| |security_classification_item| |risk_perception_source_item|)
   ""
  ((|state| :range |state_or_state_definition_select| :multiplicity (1 1 ))
   (|task_objective| :range |Task_objective| :multiplicity (1 1 ))))


(def-mm-class |Task_step| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element|)
   ""
  ((|/step_text| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Task_step_hierarchy| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Task_element_relationship|)
   ""
  ((|/child| :range |Task_step| :multiplicity (1 1 ))
   (|/parent| :range |Task_step| :multiplicity (1 1 ))))


(def-mm-class |Text_based_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation|)
   ""
  ())


(def-mm-class |Text_based_representation_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Representation_context|)
   ""
  ())


(def-mm-class |Textual_expression_composition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|text_based_item_select| |Representation_item|)
   ""
  ((|content| :range |list_or_set_of_text_based_item| :multiplicity (1 1 ))))


(def-mm-class |Textual_expression_representation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|text_based_item_select| |String_representation_item|)
   ""
  ())


(def-mm-class |Thermodynamic_temperature_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Time_interval| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Time_interval_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |verification_evidence_item|)
   ""
  ((|assigned_time_interval| :range |Time_interval| :multiplicity (1 1 ))
   (|items| :range |time_interval_item| :multiplicity (1 -1 ))
   (|role| :range |Time_interval_role| :multiplicity (1 1 ))))


(def-mm-class |Time_interval_effectivity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Effectivity|)
   ""
  ((|effectivity_period| :range |Time_interval| :multiplicity (1 1 ))))


(def-mm-class |Time_interval_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classified_attribute_select| |issue_reference_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|related_time_interval| :range |Time_interval| :multiplicity (1 1 ))
   (|relating_time_interval| :range |Time_interval| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Time_interval_role| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Time_interval_with_bounds| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Time_interval|)
   ""
  ((|duration_from_primary_bound| :range |Duration| :multiplicity (0 1 ))
   (|primary_bound| :range |date_or_event| :multiplicity (0 1 ))
   (|secondary_bound| :range |date_or_event| :multiplicity (0 1 ))))


(def-mm-class |Time_offset| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item|)
   ""
  ((|/actual_minute_offset| :range |Integer| :multiplicity (1 1 ))
   (|hour_offset| :range |Integer| :multiplicity (1 1 ))
   (|minute_offset| :range |Integer| :multiplicity (0 1 ))
   (|sense| :range |offset_orientation| :multiplicity (1 1 ))))


(def-mm-class |Time_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unit|)
   ""
  ())


(def-mm-class |Tracing_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|date_or_date_time_item| |View_definition_relationship| |security_classification_item| |contract_item|)
   ""
  ((|/traces_from| :range |Requirement_view_definition| :multiplicity (1 1 ))
   (|/traces_to| :range |Requirement_view_definition| :multiplicity (1 1 ))))


(def-mm-class |Type_of_person| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |approval_item| |string_select| |person_or_organization_or_person_in_organization_select| |required_resource_item| |state_of_item| |location_assignment_select| |work_output_item| |issue_reference_item| |documented_element_select| |identification_item| |classification_item| |resource_item_select| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|has| :range |Type_of_person_definition| :multiplicity (0 -1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Type_of_person_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |effectivity_item| |date_or_date_time_item| |approval_item| |string_select| |issue_reference_item| |observation_recorder| |verification_evidence_item| |classification_item| |risk_perception_source_item| |defined_attributes|)
   ""
  ((|assigned_type_of_person| :range |Type_of_person| :multiplicity (1 1 ))
   (|items| :range |type_of_person_item_select| :multiplicity (1 -1 ))
   (|role| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Type_of_person_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item| |property_assignment_select| |string_select| |issue_reference_item| |documented_element_select| |classification_item| |risk_perception_source_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Type_of_person_definition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_perception_source_item| |effectivity_item| |classification_item| |person_or_organization_or_person_in_organization_select| |issue_reference_item| |string_select|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Type_of_person_definition| :multiplicity (1 1 ))
   (|relating| :range |Type_of_person_definition| :multiplicity (1 1 ))))


(def-mm-class |Type_of_person_definition_required_attributes_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|risk_perception_source_item| |classification_item| |issue_reference_item|)
   ""
  ((|assigned_required_attributes| :range |Type_of_person_definition| :multiplicity (1 1 ))
   (|required_attributes| :range |defined_attributes| :multiplicity (0 -1 ))))


(def-mm-class |Type_qualifier| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|value_qualifier|)
   ""
  ((|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Unary_boolean_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Boolean_expression| |Unary_generic_expression|)
   ""
  ())


(def-mm-class |Unary_function_call| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Unary_numeric_expression|)
   ""
  ())


(def-mm-class |Unary_generic_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_expression|)
   ""
  ((|operand| :range |Generic_expression| :multiplicity (1 1 ))))


(def-mm-class |Unary_numeric_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Numeric_expression| |Unary_generic_expression|)
   ""
  ())


(def-mm-class |Uncertainty_qualifier| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|value_qualifier|)
   ""
  ((|description| :range |String| :multiplicity (1 1 ))
   (|measure_name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Uncertainty_with_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Value_with_unit|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|issue_reference_item| |classified_attribute_select| |classification_item| |description_item|)
   ""
  ((|name| :range |String| :multiplicity (1 1 ))
   (|si_unit| :range |Boolean| :multiplicity (1 1 ))))


(def-mm-class |Value_function| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ((|function_element| :range |Function_value_pair| :multiplicity (1 -1 )
  :is-ordered-p t )))


(def-mm-class |Value_limit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Qualified_representation_item| |Numerical_item_with_unit|)
   ""
  ())


(def-mm-class |Value_list| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|values| :range |Measure_item| :multiplicity (1 -1 )
  :is-ordered-p t )))


(def-mm-class |Value_range| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|lower_limit| :range |Numerical_item_with_unit| :multiplicity (1 1 ))
   (|upper_limit| :range |Numerical_item_with_unit| :multiplicity (1 1 ))))


(def-mm-class |Value_range_with_global_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|lower_limit| :range |Numerical_item_with_global_unit| :multiplicity (1 1 ))
   (|upper_limit| :range |Numerical_item_with_global_unit| :multiplicity (1 1 ))))


(def-mm-class |Value_set| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|values| :range |Measure_item| :multiplicity (1 -1 ))))


(def-mm-class |Value_with_tolerances| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Measure_item|)
   ""
  ((|item_value| :range |Numerical_item_with_unit| :multiplicity (1 1 ))
   (|lower_limit| :range |Double| :multiplicity (1 1 ))
   (|upper_limit| :range |Double| :multiplicity (1 1 ))))


(def-mm-class |Value_with_unit| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classified_attribute_select| |issue_reference_item| |classification_item| |description_item| |parameter_value_select|)
   ""
  ((|unit| :range |Unit| :multiplicity (1 1 ))
   (|value_component| :range |measure_value| :multiplicity (1 1 ))))


(def-mm-class |Variable| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Generic_variable|)
   ""
  ())


(def-mm-class |Variable_semantics| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |Vector| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Detailed_geometric_model_element|)
   ""
  ((|magnitude| :range |length_measure| :multiplicity (1 1 ))
   (|orientation| :range |Direction| :multiplicity (1 1 ))))


(def-mm-class |Verification| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |approval_item| |date_or_date_time_item| |activity_item| |string_select| |groupable_item| |analysed_item| |resource_as_realized_item| |affected_item_select| |position_group_item| |required_resource_item| |contract_item| |product_based_location_representation| |position_item| |state_of_item| |work_item| |state_definition_of_item| |requirement_source_item| |requirement_assignment_item| |condition_evaluation_item| |documented_element_select| |identification_item| |issue_reference_item| |position_type_item| |observed_context| |type_of_person_item_select| |classification_item| |justification_support_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|verifies| :range |Requirement_assignment| :multiplicity (1 1 ))))


(def-mm-class |Verification_evidence| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |risk_impact_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |certification_item| |approval_item| |date_or_date_time_item| |string_select| |analysed_item| |condition_item| |resource_as_realized_item| |position_group_item| |product_based_location_representation| |position_item| |state_of_item| |work_output_item| |issue_reference_item| |identification_item| |information_usage_right_item| |documented_element_select| |position_type_item| |observed_context| |type_of_person_item_select| |classification_item| |resource_assignment_item| |security_classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|for_verification| :range |Verification| :multiplicity (1 1 ))
   (|items| :range |verification_evidence_item| :multiplicity (1 -1 ))))


(def-mm-class |Verification_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |risk_impact_item| |property_assignment_select| |approval_item| |analysed_item| |issue_reference_item| |risk_perception_source_item|)
   ""
  ((|related| :range |Verification| :multiplicity (1 1 ))
   (|relating| :range |Verification| :multiplicity (1 1 ))))


(def-mm-class |View_definition_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|organization_or_person_in_organization_item| |approval_item| |date_or_date_time_item| |analysed_item| |issue_reference_item| |identification_item| |classified_attribute_select| |verification_evidence_item| |classification_item| |justification_support_item|)
   ""
  ((|application_domain| :range |String| :multiplicity (1 1 ))
   (|description| :range |String| :multiplicity (0 1 ))
   (|life_cycle_stage| :range |String| :multiplicity (1 1 ))))


(def-mm-class |View_definition_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |event_item| |risk_impact_item| |activity_method_item| |effectivity_item| |organization_or_person_in_organization_item| |property_assignment_select| |certification_item| |activity_item| |approval_item| |string_select| |condition_parameter_item| |analysed_item| |condition_item| |project_item| |affected_item_select| |product_based_location_representation| |state_of_item| |condition_evaluation_parameter_item| |connection_items| |state_definition_of_item| |connector_on_item| |requirement_source_item| |requirement_assignment_item| |condition_evaluation_item| |classified_attribute_select| |information_usage_right_item| |issue_reference_item| |identification_item| |documented_element_select| |type_of_person_item_select| |observed_context| |verification_evidence_item| |classification_item| |risk_perception_source_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|id| :range |String| :multiplicity (0 1 ))
   (|related_view| :range |Product_view_definition| :multiplicity (1 1 ))
   (|relating_view| :range |Product_view_definition| :multiplicity (1 1 ))
   (|relation_type| :range |String| :multiplicity (0 1 ))))


(def-mm-class |View_definition_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|View_definition_relationship| |shapeable_item| |described_element_select| |product_item|)
   ""
  ())


(def-mm-class |Work_order| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|justification_item| |organization_or_person_in_organization_item| |effectivity_item| |property_assignment_select| |activity_item| |approval_item| |date_or_date_time_item| |string_select| |groupable_item| |condition_item| |position_group_item| |required_resource_item| |contract_item| |position_item| |state_of_item| |time_interval_item| |state_definition_of_item| |issue_reference_item| |documented_element_select| |identification_item| |classified_attribute_select| |information_usage_right_item| |verification_evidence_item| |type_of_person_item_select| |observed_context| |position_type_item| |classification_item| |resource_item_select| |resource_assignment_item| |justification_support_item| |risk_perception_source_item| |security_classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|in_response_to| :range |Work_request| :multiplicity (0 -1 ))
   (|name| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Work_output| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|documented_element_select| |activity_item| |product_based_location_representation| |security_classification_item| |justification_support_item| |condition_parameter_item| |requirement_assignment_item| |external_identification_item| |contract_item| |issue_reference_item| |approval_item| |time_interval_item| |observed_context| |groupable_item| |string_select| |defined_activities| |risk_perception_source_item| |organization_or_person_in_organization_item| |activity_method_item| |information_usage_right_item| |identification_item| |condition_evaluation_parameter_item| |characterized_activity_definition| |classified_attribute_select| |date_or_date_time_item| |certification_item| |classification_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|output_item| :range |work_output_item| :multiplicity (0 1 ))
   (|quantity| :range |Value_with_unit| :multiplicity (0 1 ))))


(def-mm-class |Work_output_assignment| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|type_of_person_item_select| |analysed_item| |defined_attributes| |approval_item| |position_type_item| |resource_as_realized_item| |activity_method_item| |verification_evidence_item| |classification_item| |position_item| |defined_methods| |justification_item| |position_group_item| |issue_reference_item| |security_classification_item| |risk_perception_source_item| |effectivity_item|)
   ""
  ((|assigned_output| :range |Work_output| :multiplicity (1 1 ))
   (|item| :range |work_item| :multiplicity (1 1 ))))


(def-mm-class |Work_output_relationship| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|analysed_item| |classification_item| |issue_reference_item| |string_select| |security_classification_item| |effectivity_item| |classified_attribute_select|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|name| :range |String| :multiplicity (1 1 ))
   (|related| :range |Work_output| :multiplicity (1 1 ))
   (|relating| :range |Work_output| :multiplicity (1 1 ))))


(def-mm-class |Work_request| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|event_item| |justification_item| |organization_or_person_in_organization_item| |property_assignment_select| |activity_item| |approval_item| |date_or_date_time_item| |string_select| |condition_parameter_item| |groupable_item| |condition_item| |affected_item_select| |position_group_item| |product_based_location_representation| |position_item| |state_of_item| |time_interval_item| |state_definition_of_item| |classified_attribute_select| |documented_element_select| |issue_reference_item| |identification_item| |verification_evidence_item| |position_type_item| |type_of_person_item_select| |observed_context| |classification_item| |security_classification_item| |justification_support_item|)
   ""
  ((|description| :range |String| :multiplicity (0 1 ))
   (|purpose| :range |String| :multiplicity (1 1 ))
   (|request_id| :range |String| :multiplicity (1 1 ))
   (|version_id| :range |String| :multiplicity (1 1 ))))


(def-mm-class |Work_request_status| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|classification_item| |classified_attribute_select| |issue_reference_item| |security_classification_item|)
   ""
  ((|status| :range |String| :multiplicity (1 1 ))
   (|work_request| :range |Work_request| :multiplicity (1 1 ))))


(def-mm-class |Xor_expression| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Binary_boolean_expression|)
   ""
  ())


(def-mm-class |Xor_state_cause_effect_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|State_cause_effect_definition|)
   ""
  ())


(def-mm-class |Zone_breakdown| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown|)
   ""
  ())


(def-mm-class |Zone_breakdown_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_context|)
   ""
  ())


(def-mm-class |Zone_breakdown_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_version|)
   ""
  ())


(def-mm-class |Zone_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element|)
   ""
  ())


(def-mm-class |Zone_element_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_definition|)
   ""
  ())


(def-mm-class |Zone_element_usage| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_usage|)
   ""
  ())


(def-mm-class |Zone_element_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Breakdown_element_version|)
   ""
  ())


(def-mm-class |activity_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |activity_method_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |activity_realization_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |affected_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |alias_identification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|identification_item|)
   ""
  ())


(def-mm-class |analysed_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|description_item|)
   ""
  ())


(def-mm-class |any_number_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Double| |measure_value|)
   ""
  ())


(def-mm-class |any_string_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|String| |measure_value|)
   ""
  ())


(def-mm-class |approval_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |assigned_document_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |assigned_name_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |behaviour_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|analysed_item|)
   ""
  ())


(def-mm-class |behaviour_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|type_of_person_item_select| |certification_item| |description_item| |analysed_item| |verification_evidence_item| |defined_methods|)
   ""
  ())


(def-mm-class |binary| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-class |breakdown_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |cartesian_transformation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |certification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |characterized_activity_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |characterized_resource_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |classification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |classified_attribute_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |condition_evaluation_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |condition_evaluation_parameter_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |condition_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |condition_parameter_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |connection_definition_items| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|connection_items|)
   ""
  ())


(def-mm-class |connection_items| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |connector_on_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |constraint_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |contract_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |date_or_date_time_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |date_or_date_time_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |date_or_event| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |day_in_month_number| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Integer|)
   ""
  ())


(def-mm-class |defined_activities| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |defined_attributes| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |defined_methods| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |described_element_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |description_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |descriptive_or_numerical| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |document_property_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|property_assignment_select|)
   ""
  ())


(def-mm-class |documented_element_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |effectivity_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |event_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |expression_assignment_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |external_identification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |geometric_item_specific_usage_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |groupable_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |hour_in_day| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Integer|)
   ""
  ())


(def-mm-class |identification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |in_zone_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |information_usage_right_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |interface_definition_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |issue_reference_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |justification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |justification_support_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |length_measure| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Double| |measure_value|)
   ""
  ())


(def-mm-class |lessons_learned_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|documented_element_select|)
   ""
  ())


(def-mm-class |list_of_text_based_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|list_or_set_of_text_based_item|)
   ""
  ())


(def-mm-class |list_or_set_of_text_based_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |location_assignment_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |logical| (:AP233 "Data specification view") NIL
   ""
  ())


(def-mm-class |measure_value| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |method_or_method_version| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |minute_in_hour| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Integer|)
   ""
  ())


(def-mm-class |month_in_year_number| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Integer|)
   ""
  ())


(def-mm-class |observation_recorder| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |observed_context| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |organization_or_person_in_organization_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|contract_item|)
   ""
  ())


(def-mm-class |organization_or_person_in_organization_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |parameter_value_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|condition_parameter_item|)
   ""
  ())


(def-mm-class |person_or_organization_or_person_in_organization_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |plane_angle_measure| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Double| |measure_value|)
   ""
  ())


(def-mm-class |position_context_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |position_group_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |position_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |position_person_or_organization_or_person_in_organization_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |position_type_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |product_based_location_representation| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |product_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |product_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |project_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |property_assignment_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |qualifications_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |represented_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |required_resource_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |requirement_assignment_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |requirement_source_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |resource_as_realized_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |resource_as_realized_relationship_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |resource_assignment_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |resource_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |risk_activity| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |risk_communication_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |risk_criteria_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_item|)
   ""
  ())


(def-mm-class |risk_estimation_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |risk_impact_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |risk_perception_source_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_item|)
   ""
  ())


(def-mm-class |risk_treatment_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |scheme_entry_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item|)
   ""
  ())


(def-mm-class |scheme_subject_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item|)
   ""
  ())


(def-mm-class |scheme_version_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item|)
   ""
  ())


(def-mm-class |second_in_minute| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Double|)
   ""
  ())


(def-mm-class |security_classification_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |selected_item_context_items| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |selected_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |set_of_text_based_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|list_or_set_of_text_based_item|)
   ""
  ())


(def-mm-class |shape_dependent_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |shape_model| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |shape_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |shapeable_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |state_based_behaviour_element| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |state_definition_of_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |state_of_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |state_or_state_definition_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |string_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |task_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|activity_method_item|)
   ""
  ())


(def-mm-class |template_definition_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |text_based_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |time_interval_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |type_of_person_item_select| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |value_qualifier| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |verification_evidence_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |version_or_definition| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |work_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |work_output_item| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") NIL
   ""
  ())


(def-mm-class |year_number| (:AP233 "Data specification view" "Ap233_systems_engineering_arm_LF") (|Integer|)
   ""
  ())

(with-slots (mofi::abstract-classes) *model*
    (setf mofi::abstract-classes '(|Simple_boolean_expression| |Analysis_representation_item| |activity_realization_select| |information_usage_right_item| |second_in_minute| |Probability_distribution| |risk_impact_item| |product_select| |product_based_location_representation| |organization_or_person_in_organization_select| |Boolean_expression| |characterized_activity_definition| |affected_item_select| |description_item| |set_of_text_based_item| |work_output_item| |behaviour_item| |contract_item| |Detailed_geometric_model_element| |Resource_event| |qualifications_select| |Unary_function_call| |external_identification_item| |Binary_function_call| |Measure_item| |type_of_person_item_select| |File| |risk_estimation_select| |Boolean_defined_function| |scheme_version_select| |Multiple_arity_generic_expression| |Multiple_arity_numeric_expression| |Binary_generic_expression| |location_assignment_select| |condition_parameter_item| |work_item| |project_item| |list_of_text_based_item| |groupable_item| |date_or_date_time_item| |analysed_item| |interface_definition_item| |resource_as_realized_relationship_select| |Representation_item| |risk_communication_select| |descriptive_or_numerical| |defined_attributes| |scheme_subject_select| |Binary_numeric_expression| |state_or_state_definition_select| |string_select| |product_item| |Generic_variable| |Multiple_arity_function_call| |shapeable_item| |condition_item| |activity_item| |plane_angle_measure| |approval_item| |Type_qualifier| |String_expression| |connector_on_item| |position_type_item| |Geometric_placement_operation| |risk_activity| |date_or_event| |Required_resource| |resource_as_realized_item| |scheme_entry_item_select| |certification_item| |Product_as_individual_version| |breakdown_item| |Binary_boolean_expression| |Unary_numeric_expression| |shape_select| |text_based_item_select| |measure_value| |Generic_literal| |activity_method_item| |Product_occurrence_definition_relationship| |method_or_method_version| |length_measure| |String_defined_function| |Multiple_arity_boolean_expression| |connection_items| |Location_representation| |Expression| |position_person_or_organization_or_person_in_organization_select| |resource_item_select| |event_item| |verification_evidence_item| |Probability| |date_or_date_time_select| |person_or_organization_or_person_in_organization_select| |task_item| |shape_model| |classification_item| |Generic_expression| |list_or_set_of_text_based_item| |Unary_boolean_expression| |any_string_value| |represented_definition| |Comparison_expression| |constraint_context| |Variable_semantics| |connection_definition_items| |Sql_mappable_defined_function| |month_in_year_number| |Task_element| |Real_defined_function| |documented_element_select| |Risk_activity_structure| |resource_assignment_item| |Integer_defined_function| |document_property_item| |shape_dependent_select| |justification_support_item| |observed_context| |property_assignment_select| |any_number_value| |condition_evaluation_parameter_item| |characterized_resource_select| |Variable| |position_item| |Structured_task_element| |state_definition_of_item| |minute_in_hour| |defined_methods| |assigned_document_select| |Probability_generator| |selected_item_select| |risk_criteria_select| |geometric_item_specific_usage_select| |observation_recorder| |value_qualifier| |justification_item| |parameter_value_select| |position_group_item| |hour_in_day| |Defined_function| |required_resource_item| |Numeric_defined_function| |defined_activities| |Simple_string_expression| |condition_evaluation_item| |requirement_source_item| |risk_treatment_select| |selected_item_context_items| |lessons_learned_select| |issue_reference_item| |cartesian_transformation| |security_classification_item| |assigned_name_select| |Unary_generic_expression| |described_element_select| |day_in_month_number| |position_context_item| |in_zone_item| |expression_assignment_item| |Assembly_component_relationship| |Property_definition_representation| |Simple_numeric_expression| |classified_attribute_select| |requirement_assignment_item| |risk_perception_source_item| |Qualified_representation_item| |year_number| |Literal_number| |effectivity_item| |identification_item| |state_of_item| |state_based_behaviour_element| |organization_or_person_in_organization_item| |Simple_generic_expression| |Numeric_expression| |alias_identification_item| |template_definition_select| |version_or_definition| |time_interval_item| |behaviour_model| |Geometric_model_relationship_with_transformation|))) 

;;; End of Output