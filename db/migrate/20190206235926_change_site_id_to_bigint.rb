class ChangeSiteIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :sites, :id, :bigint

    change_column :members, :site_id, :bigint
  end

  def down
    change_column :sites, :id, :integer

    change_column :members, :site_id, :integer
  end
end
