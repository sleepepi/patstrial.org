# frozen_string_literal: true

# Allows uploaded documents to be grouped together and organized in dashboard
# menu.
class Category < ApplicationRecord
  # Uploaders
  mount_uploader :zipped_folder, ZipUploader

  # Concerns
  include Deletable
  include Sluggable

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

  def generate_zipped_folder!
    zip_name = "folder.zip"
    temp_zip_file = Tempfile.new(zip_name)
    begin
      # Initialize temp zip file.
      Zip::OutputStream.open(temp_zip_file) { |zos| }
      # Write to temp zip file.
      Zip::File.open(temp_zip_file, Zip::File::CREATE) do |zip|
        documents.each do |document|
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zip.add(document.document_identifier, document.document.path) if File.exist?(document.document.path) && File.size(document.document.path).positive?
        end
      end
      temp_zip_file.define_singleton_method(:original_filename) do
        zip_name
      end
      update zipped_folder: temp_zip_file
      # update file_size: zipped_folder.size # Cache after attaching to model.
    ensure
      # Close and delete the temp file
      temp_zip_file.close
      temp_zip_file.unlink
    end
  end
end
