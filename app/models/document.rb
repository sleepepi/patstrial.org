# frozen_string_literal: true

# Class for uploaded documents
class Document < ApplicationRecord
  # Uploaders
  mount_uploader :document, DocumentUploader

  # Concerns
  include PgSearch
  multisearchable against: [:document], unless: :category_deleted? # TODO: [:filename, :content_type]

  # Validations
  validates :document, presence: true

  # Scopes
  scope :latest_files, -> do
    joins(:category).merge(Category.current.where(archived: false)).reorder(created_at: :desc).limit(10)
  end

  scope :latest_files_blinded, -> do
    joins(:category).merge(Category.current.where(archived: false, unblinded_only: false)).reorder(created_at: :desc).limit(10)
  end

  # Relationships
  belongs_to :category

  # Methods
  def name
    document_identifier
  end

  def pdf?
    extension == "pdf"
  end

  def extension
    document.file.extension.to_s.downcase
  end

  def category_deleted?
    category.deleted?
  end

  def content_type
    MIME::Types.type_for(document.path).first.content_type
  end

  def self.content_type(filename)
    MIME::Types.type_for(filename).first.content_type
  end

  def byte_size
    File.exist?(document.path) ? File.size(document.path) : 0
  end
end
