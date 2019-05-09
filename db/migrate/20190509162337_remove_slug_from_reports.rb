class RemoveSlugFromReports < ActiveRecord::Migration[6.0]
  def up
    remove_index :reports, :slug
    remove_column :reports, :slug, :string
  end

  def down
    add_column :reports, :slug, :string
    add_index :reports, :slug, unique: true
  end
end
