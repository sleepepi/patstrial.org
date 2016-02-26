class AddDsmbOnlyToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :dsmb_only, :boolean, null: false, default: false
    add_index :categories, :dsmb_only
  end
end
