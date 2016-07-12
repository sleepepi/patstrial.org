class AddSignInCountToViewers < ActiveRecord::Migration[4.2]
  def change
    add_column :viewers, :sign_in_count, :integer, null: false, default: 0
  end
end
