class AddChairToCommitteeMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :committee_members, :chair, :boolean, null: false, default: false
  end
end
