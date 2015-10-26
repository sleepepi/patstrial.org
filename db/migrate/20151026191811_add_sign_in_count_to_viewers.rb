class AddSignInCountToViewers < ActiveRecord::Migration
  def change
    add_column :viewers, :sign_in_count, :integer, null: false, default: 0
  end
end
