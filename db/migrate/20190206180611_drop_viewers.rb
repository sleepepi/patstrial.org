class DropViewers < ActiveRecord::Migration[6.0]
  def change
    drop_table :viewers do |t|
      t.string :username
      t.string :password_plain
      t.string :password_digest
      t.integer :sign_in_count, default: 0, null: false
      t.text :description
      t.datetime :current_sign_in_at
      t.timestamps null: false
      t.index :username, unique: true
    end
  end
end
