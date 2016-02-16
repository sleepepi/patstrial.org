# frozen_string_literal: true

# Defines format and storage of uploaded documents
class DocumentUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    File.join(model.class.to_s.underscore.pluralize, model.id.to_s, mounted_as.to_s)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(doc docx rtf pdf xls xlsx csv)
  end
end
