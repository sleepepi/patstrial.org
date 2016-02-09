class Drug < ActiveRecord::Base
  # Concerns
  include Searchable

  def name_and_code
    "#{proprietary_name} - #{product_ndc}"
  end

  def self.searchable_attributes
    %w(product_ndc proprietary_name non_proprietary_name)
  end
end
