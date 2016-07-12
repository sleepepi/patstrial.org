class AddArchivedToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :archived, :boolean, null: false, default: false
    add_index :members, :archived
  end
end
