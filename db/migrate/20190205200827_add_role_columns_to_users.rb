class AddRoleColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :role, :string
    add_column :users, :phone, :string
    add_column :users, :keywords, :string
    add_column :users, :profile_picture, :string
  end
end
