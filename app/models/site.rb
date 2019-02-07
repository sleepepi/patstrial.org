# frozen_string_literal: true

# Members can belong to a single site. Sites are displayed publicly on website.
class Site < ApplicationRecord
  # Constants
  ORDERS = {
    "address desc" => "sites.address desc",
    "address" => "sites.address",
    "number desc" => "sites.number desc",
    "number" => "sites.number",
    "name desc" => "sites.name desc",
    "name" => "sites.name"
  }
  DEFAULT_ORDER = "sites.number"

  # Concerns
  include Deletable
  include Sluggable

  include Searchable
  def self.searchable_attributes
    %w(name slug number address contact)
  end

  include PgSearch
  multisearchable against: [:name, :slug, :address], unless: :deleted? # TODO: :center_type

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
