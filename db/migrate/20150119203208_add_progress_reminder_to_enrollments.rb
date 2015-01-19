class AddProgressReminderToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :progress_reminder_sent_at, :datetime
  end
end
