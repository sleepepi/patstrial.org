# frozen_string_literal: true

namespace :drugs do
  desc "Populate drugs from spreadsheet to database."
  task populate: :environment do
    csv_file = Rails.root.join("lib", "data", "drugs", "product.csv")
    puts "Drugs: #{Drug.count}"
    ActiveRecord::Base.connection.execute("TRUNCATE drugs RESTART IDENTITY")
    CSV.parse(File.open(csv_file, "r:iso-8859-1:utf-8") { |f| f.read }, headers: true) do |line|
      row = line.to_hash.with_indifferent_access
      Drug.create(
        productid: row["PRODUCTID"],
        product_ndc: row["PRODUCTNDC"],
        product_type_name: row["PRODUCTTYPENAME"],
        proprietary_name: row["PROPRIETARYNAME"],
        proprietary_name_suffix: row["PROPRIETARYNAMESUFFIX"],
        non_proprietary_name: row["NONPROPRIETARYNAME"],
        dosage_form_name: row["DOSAGEFORMNAME"],
        route_name: row["ROUTENAME"],
        start_marketing_date: row["STARTMARKETINGDATE"],
        end_marketing_date: row["ENDMARKETINGDATE"],
        marketing_category_name: row["MARKETINGCATEGORYNAME"],
        application_number: row["APPLICATIONNUMBER"],
        labeler_name: row["LABELERNAME"],
        substance_name: row["SUBSTANCENAME"],
        active_numerator_strength: row["ACTIVE_NUMERATOR_STRENGTH"],
        active_ingred_unit: row["ACTIVE_INGRED_UNIT"],
        pharm_classes: row["PHARM_CLASSES"],
        dea_schedule: row["DEASCHEDULE"]
      )
    end
    puts "Drugs: #{Drug.count}"
  end
end
