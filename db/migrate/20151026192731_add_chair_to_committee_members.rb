class AddChairToCommitteeMembers < ActiveRecord::Migration
  def change
    add_column :committee_members, :chair, :boolean, null: false, default: false
  end
end
