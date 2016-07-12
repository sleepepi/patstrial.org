class CreateCommittees < ActiveRecord::Migration[4.2]
  def change
    create_table :committees do |t|
      t.string :name
      t.string :slug
      t.integer :position, null: false, default: 0
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :committees, :deleted
  end
end
