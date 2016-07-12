class AddSiteIdToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :site_id, :integer
    add_index :members, :site_id
  end
end
