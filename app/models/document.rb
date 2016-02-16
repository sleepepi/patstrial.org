# frozen_string_literal: true

# Class for uploaded documents
class Document < ActiveRecord::Base
  # Uploaders
  mount_uploader :document, DocumentUploader

  # Concerns

  # Model Validation
  validates :category_id, :document, presence: true

  # Model Relationships
  belongs_to :category

  # Model Methods
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
