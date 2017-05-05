# frozen_string_literal: true

# Class for embedded videos.
class Video < ApplicationRecord
  # Concerns
  include Deletable

  # Validations
  validates :category_id, :name, :embed_url, presence: true

  # Relationships
  belongs_to :category

  # Methods
end
