class CreatePgSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :pg_search_documents do |t|
      t.text :content
      t.belongs_to :searchable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
