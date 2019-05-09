class AddSitesEnabledToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :sites_enabled, :boolean, null: false, default: true
  end
end
