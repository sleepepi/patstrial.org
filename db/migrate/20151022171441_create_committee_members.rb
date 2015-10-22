class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.integer :committee_id
      t.integer :member_id

      t.timestamps null: false
    end

    add_index :committee_members, :committee_id
    add_index :committee_members, :member_id

    add_index :committee_members, [:committee_id, :member_id], unique: true
  end
end
