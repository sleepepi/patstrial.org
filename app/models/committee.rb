# frozen_string_literal: true

# Allows members to be placed into a committee for sorting in the directory
class Committee < ApplicationRecord
  # Concerns
  include Deletable
  include Sluggable

  # Validations
  validates :name, :slug, :position, presence: true

  # Relationships
  has_many :committee_members
  has_many :members, through: :committee_members

  # Methods
  def destroy
    update_column :slug, nil
    super
  end
end
