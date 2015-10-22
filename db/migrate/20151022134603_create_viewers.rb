class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|
      t.string :username
      t.string :password_plain
      t.string :password_digest

      t.timestamps null: false
    end

    add_index :viewers, :username, unique: true
  end
end
