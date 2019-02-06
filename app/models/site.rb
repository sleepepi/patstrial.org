# frozen_string_literal: true

# Members can belong to a single site. Sites are displayed publicly on website.
class Site < ApplicationRecord
  # Concerns
  include Deletable
  include Sluggable

  include PgSearch
  multisearchable against: [:name, :slug], unless: :deleted? # TODO: :center_type

  # Validations
  validates :name, :slug, :address, presence: true

  # Relationships
  has_many :members, -> { order(:last_name, :first_name) }

  # Methods
  def destroy
    update_column :slug, nil
    super
  end
end
