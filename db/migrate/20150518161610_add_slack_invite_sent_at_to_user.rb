class AddSlackInviteSentAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :slack_invite_sent_at, :datetime
  end
end
