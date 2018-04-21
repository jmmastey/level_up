class AddSlackInviteSentAtToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :slack_invite_sent_at, :datetime
  end
end
