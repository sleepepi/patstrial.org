class AddRecruitingCenterToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :recruiting_center, :boolean, null: false, default: false
    add_index :sites, :recruiting_center
  end
end
