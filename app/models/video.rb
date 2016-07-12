# frozen_string_literal: true

# Class for embedded videos
class Video < ApplicationRecord
  # Concerns
  include Deletable

  # Model Validation
  validates :category_id, :name, :embed_url, presence: true

  # Model Relationships
  belongs_to :category

  # Model Methods
end
