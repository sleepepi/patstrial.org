class AddDescriptionToViewers < ActiveRecord::Migration[4.2]
  def change
    add_column :viewers, :description, :text
  end
end
