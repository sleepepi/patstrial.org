# frozen_string_literal: true

# Members can belong to a single site. Sites are displayed publicly on website.
class Site < ApplicationRecord
  # Concerns
  include Deletable, Sluggable

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
