class CreateDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :documents do |t|
      t.integer :category_id
      t.string :document
      t.boolean :archived, null: false, default: false

      t.timestamps null: false
    end

    add_index :documents, :category_id
    add_index :documents, :archived
  end
end
