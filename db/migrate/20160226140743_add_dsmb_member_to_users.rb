class AddDsmbMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dsmb_member, :boolean, null: false, default: false
    add_index :users, :dsmb_member
  end
end
