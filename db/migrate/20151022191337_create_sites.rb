class CreateSites < ActiveRecord::Migration[4.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :slug
      t.string :address
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :sites, :deleted
  end
end
