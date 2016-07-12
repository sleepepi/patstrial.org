class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :top_level
      t.string :slug
      t.integer :position, null: false, default: 0
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :categories, :archived
    add_index :categories, :deleted
  end
end
