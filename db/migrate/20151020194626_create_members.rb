class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :role
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :members, :deleted
  end
end
