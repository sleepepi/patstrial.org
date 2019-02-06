class AddApprovalSentAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :approval_sent_at, :datetime
  end
end
