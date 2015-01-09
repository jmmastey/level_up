class AddRegistrationReminderFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :enrollment_reminder_sent, :boolean, default: false
  end
end
