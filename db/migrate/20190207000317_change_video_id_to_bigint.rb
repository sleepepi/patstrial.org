class ChangeVideoIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :videos, :id, :bigint
  end

  def down
    change_column :videos, :id, :integer
  end
end
