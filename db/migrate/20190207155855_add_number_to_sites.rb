class AddNumberToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :number, :integer
    add_index :sites, :number
  end
end
