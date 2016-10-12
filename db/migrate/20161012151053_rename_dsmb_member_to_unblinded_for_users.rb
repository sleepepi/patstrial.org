class RenameDsmbMemberToUnblindedForUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :dsmb_member, :unblinded
  end
end
