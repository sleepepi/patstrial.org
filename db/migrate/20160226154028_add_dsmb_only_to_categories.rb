class AddDsmbOnlyToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :dsmb_only, :boolean, null: false, default: false
    add_index :categories, :dsmb_only
  end
end
