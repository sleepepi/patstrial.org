class ChangeCategoryIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :categories, :id, :bigint

    change_column :documents, :category_id, :bigint
    change_column :videos, :category_id, :bigint
  end

  def down
    change_column :categories, :id, :integer

    change_column :documents, :category_id, :integer
    change_column :videos, :category_id, :integer
  end
end
