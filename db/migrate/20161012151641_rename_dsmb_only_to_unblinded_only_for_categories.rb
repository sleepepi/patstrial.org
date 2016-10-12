class RenameDsmbOnlyToUnblindedOnlyForCategories < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :dsmb_only, :unblinded_only
  end
end
