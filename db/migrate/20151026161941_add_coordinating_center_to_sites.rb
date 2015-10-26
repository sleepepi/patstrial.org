class AddCoordinatingCenterToSites < ActiveRecord::Migration
  def change
    add_column :sites, :coordinating_center, :boolean, null: false, default: false
    add_index :sites, :coordinating_center
  end
end
