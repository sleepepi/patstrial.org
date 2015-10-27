class AddDescriptionToViewers < ActiveRecord::Migration
  def change
    add_column :viewers, :description, :text
  end
end
