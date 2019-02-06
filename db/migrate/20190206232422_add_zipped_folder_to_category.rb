class AddZippedFolderToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :zipped_folder, :string
  end
end
