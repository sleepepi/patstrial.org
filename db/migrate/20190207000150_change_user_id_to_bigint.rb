class ChangeUserIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :id, :bigint
  end

  def down
    change_column :users, :id, :integer
  end
end
