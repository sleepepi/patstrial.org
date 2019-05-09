class AddMutedToReportRows < ActiveRecord::Migration[6.0]
  def change
    add_column :report_rows, :muted, :boolean, null: false, default: false
  end
end
