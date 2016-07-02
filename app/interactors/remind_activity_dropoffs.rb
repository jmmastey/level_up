class RemindActivityDropoffs < ServiceObject
  def setup
    default :user_mailer, UserMailer
  end

  def run
    context.enrollments = targets.each do |enrollment|
      next unless still_stuck?(enrollment)
      next unless emailable?(enrollment.user)
      enrollment.update_attributes!(progress_reminder_sent_at: Time.now)
      remind(enrollment)
    end
  end

  private

  def emailable?(user)
    !user.email_opt_out?
  end

  def still_stuck?(enrollment)
    activity = CourseActivity.new(enrollment.user, enrollment.course)
    activity.user_is_stuck?
  end

  def targets
    Enrollment.includes(:course).includes(:user)
              .where(progress_reminder_sent_at: nil)
              .where("created_at < ?", 1.week.ago)
  end

  def remind(enrollment)
    mail = context.user_mailer.activity_reminder(enrollment)
    mail.deliver_now
  end
end
