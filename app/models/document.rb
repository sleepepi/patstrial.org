# frozen_string_literal: true

# Class for uploaded documents
class Document < ApplicationRecord
  # Uploaders
  mount_uploader :document, DocumentUploader

  # Concerns

  # Validations
  validates :category_id, :document, presence: true

  # Relationships
  belongs_to :category

  # Methods
  def name
    document_identifier
  end

  def pdf?
    extension == 'pdf'
  end

  def extension
    document.file.extension.to_s.downcase
  end
end
