class ChangeCommitteeIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :committees, :id, :bigint

    change_column :committee_members, :committee_id, :bigint
  end

  def down
    change_column :committees, :id, :integer

    change_column :committee_members, :committee_id, :integer
  end
end
