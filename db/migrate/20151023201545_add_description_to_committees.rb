class AddDescriptionToCommittees < ActiveRecord::Migration[4.2]
  def change
    add_column :committees, :description, :text
  end
end
