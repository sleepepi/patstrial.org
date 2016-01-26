class AddStaffidToMembers < ActiveRecord::Migration
  def change
    add_column :members, :staffid, :string
  end
end
