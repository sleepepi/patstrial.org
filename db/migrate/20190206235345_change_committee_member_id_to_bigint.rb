class ChangeCommitteeMemberIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :committee_members, :id, :bigint
  end

  def down
    change_column :committee_members, :id, :integer
  end
end
