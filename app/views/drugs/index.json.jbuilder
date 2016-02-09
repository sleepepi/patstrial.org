json.array!(@drugs) do |drug|
  json.extract! drug, :id, :productid, :product_ndc, :product_type_name, :proprietary_name, :proprietary_name_suffix, :non_proprietary_name, :dosage_form_name, :route_name, :start_marketing_date, :end_marketing_date, :marketing_category_name, :application_number, :labeler_name, :substance_name, :active_numerator_strength, :active_ingred_unit, :pharm_classes, :dea_schedule
  json.url drug_url(drug, format: :json)
end
