# frozen_string_literal: true

# Allows uploaded documents to be grouped together and organized in dashboard
# menu
class Category < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :name, :slug, :top_level, presence: true
  validates :slug, uniqueness: { scope: :deleted }
  validates :slug, :top_level, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  has_many :documents
  has_many :videos, -> { current }

  # Model Methods
end
