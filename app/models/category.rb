# frozen_string_literal: true

# Allows uploaded documents to be grouped together and organized in dashboard
# menu
class Category < ApplicationRecord
  # Concerns
  include Deletable, Sluggable

  # Validations
  validates :name, :slug, :top_level, presence: true
  validates :top_level, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Relationships
  has_many :documents
  has_many :videos, -> { current }

  # Methods
  def destroy
    update_column :slug, nil
    super
  end
end
