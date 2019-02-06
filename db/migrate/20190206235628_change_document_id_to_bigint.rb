class ChangeDocumentIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :documents, :id, :bigint
  end

  def down
    change_column :documents, :id, :integer
  end
end
