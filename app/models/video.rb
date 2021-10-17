# frozen_string_literal: true

# Class for embedded videos.
class Video < ApplicationRecord
  # Concerns
  include Deletable

  include PgSearch::Model
  multisearchable against: [:name], unless: :deleted_or_category_deleted?

  # Validations
  validates :name, :embed_url, presence: true

  # Relationships
  belongs_to :category

  # Methods

  def deleted_or_category_deleted?
    deleted? || category.deleted?
  end
end
