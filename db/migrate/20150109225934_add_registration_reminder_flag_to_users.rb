class AddRegistrationReminderFlagToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :enrollment_reminder_sent, :boolean, default: false
  end
end
