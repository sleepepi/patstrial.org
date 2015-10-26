class AddContactToSites < ActiveRecord::Migration
  def change
    add_column :sites, :contact, :string
  end
end
