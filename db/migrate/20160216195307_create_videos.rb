class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :category_id
      t.string :name
      t.text :embed_url
      t.boolean :archived
      t.boolean :deleted

      t.timestamps null: false
    end

    add_index :videos, :category_id
    add_index :videos, :archived
    add_index :videos, :deleted
  end
end
