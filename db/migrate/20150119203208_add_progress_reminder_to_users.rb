class AddProgressReminderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progress_reminder_sent_at, :datetime
  end
end
