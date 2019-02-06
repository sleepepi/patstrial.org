class ChangeDrugIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :drugs, :id, :bigint
  end

  def down
    change_column :drugs, :id, :integer
  end
end
