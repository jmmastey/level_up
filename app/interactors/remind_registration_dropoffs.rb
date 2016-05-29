class RemindRegistrationDropoffs < ServiceObject
  def setup
    default :user_mailer, UserMailer
  end

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
    mailer = context.user_mailer
    mailer.reg_reminder(user).deliver_now
  end
end
