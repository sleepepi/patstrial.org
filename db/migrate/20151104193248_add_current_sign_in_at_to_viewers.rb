class AddCurrentSignInAtToViewers < ActiveRecord::Migration
  def change
    add_column :viewers, :current_sign_in_at, :datetime
  end
end
