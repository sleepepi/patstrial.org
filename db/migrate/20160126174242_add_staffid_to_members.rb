class AddStaffidToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :staffid, :string
  end
end
