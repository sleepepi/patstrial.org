class AddDsmbMemberToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :dsmb_member, :boolean, null: false, default: false
    add_index :users, :dsmb_member
  end
end
