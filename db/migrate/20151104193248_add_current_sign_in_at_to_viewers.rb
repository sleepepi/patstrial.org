class AddCurrentSignInAtToViewers < ActiveRecord::Migration[4.2]
  def change
    add_column :viewers, :current_sign_in_at, :datetime
  end
end
