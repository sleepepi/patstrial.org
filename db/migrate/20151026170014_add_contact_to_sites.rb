class AddContactToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :contact, :string
  end
end
