class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.bigint :project_id
      t.string :name
      t.string :slug
      t.string :header_label
      t.jsonb :header
      t.datetime :last_cached_at
      t.boolean :archived, null: false, default: false
      t.timestamps

      t.index :project_id
      t.index :slug, unique: true
      t.index :archived
    end
  end
end
