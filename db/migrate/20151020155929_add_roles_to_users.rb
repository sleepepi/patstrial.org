class AddRolesToUsers < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :system_admin, :admin
    add_column :users, :editor, :boolean, null: false, default: false
    add_column :users, :approved, :boolean
  end
end
