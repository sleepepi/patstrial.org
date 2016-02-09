class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :productid
      t.string :product_ndc
      t.string :product_type_name
      t.text :proprietary_name
      t.string :proprietary_name_suffix
      t.text :non_proprietary_name
      t.string :dosage_form_name
      t.string :route_name
      t.date :start_marketing_date
      t.date :end_marketing_date
      t.string :marketing_category_name
      t.string :application_number
      t.string :labeler_name
      t.text :substance_name
      t.text :active_numerator_strength
      t.text :active_ingred_unit
      t.text :pharm_classes
      t.string :dea_schedule
    end

    add_index :drugs, :product_ndc
    add_index :drugs, :proprietary_name
    add_index :drugs, :non_proprietary_name
  end
end
