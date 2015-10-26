class AddDescriptionToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :description, :text
  end
end
