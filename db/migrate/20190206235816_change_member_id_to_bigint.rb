class ChangeMemberIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :members, :id, :bigint

    change_column :committee_members, :member_id, :bigint
  end

  def down
    change_column :members, :id, :integer

    change_column :committee_members, :member_id, :integer
  end
end
