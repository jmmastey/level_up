class RemindRegistrationDropoffs
  include Interactor

  def call
    context.users = stagnated_users.each do |user|
      user.update_attributes!(progress_reminder_sent: true)
      remind(user)
    end
  end

  private

  def stagnated_users
    User.older.with_enrollments.where(progress_reminder_sent_at: nil)
  end

  def remind(user)
  end
end
