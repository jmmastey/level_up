class AddProgressReminderToEnrollments < ActiveRecord::Migration[4.2]
  def change
    add_column :enrollments, :progress_reminder_sent_at, :datetime
  end
end
