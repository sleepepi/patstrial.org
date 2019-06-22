class AddExpressionToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :filter_expression, :text
    add_column :reports, :group_expression, :text
  end
end
