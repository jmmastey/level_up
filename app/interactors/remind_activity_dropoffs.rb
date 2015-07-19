class RemindActivityDropoffs < ServiceObject
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
    user.email_opt_out.nil?
  end

  def still_stuck?(enrollment)
    CourseActivity.new(enrollment.user, enrollment.course).user_is_stuck?
  end

  def targets
    Enrollment.includes(:course).includes(:user)
      .where(progress_reminder_sent_at: nil)
      .where("created_at < ?", 1.week.ago)
  end

  def remind(enrollment)
    UserMailer.activity_reminder(enrollment).deliver_now
  end
end
