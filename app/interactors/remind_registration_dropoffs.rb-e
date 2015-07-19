class RemindRegistrationDropoffs < ServiceObject
  def run
    context.users = lazy_users.each do |user|
      user.update_attributes!(enrollment_reminder_sent: true)
      remind(user)
    end
  end

  private

  def lazy_users
    User.older.emailable
      .without_enrollments
      .where(enrollment_reminder_sent: false)
  end

  def remind(user)
    UserMailer.reg_reminder(user).deliver_now
  end
end
