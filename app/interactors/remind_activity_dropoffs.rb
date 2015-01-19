class RemindActivityDropoffs
  include Interactor

  def call
    context.enrollments = stuck_enrollments.each do |enrollment|
      next unless still_stuck?(enrollment)
      enrollment.update_attributes!(progress_reminder_sent_at: Time.now)
      remind(enrollment)
    end
  end

  private

  def still_stuck?(enrollment)
    CourseActivity.new(enrollment.user, enrollment.course).user_is_stuck?
  end

  def stuck_enrollments
    Enrollment.includes(:course).includes(:user)
      .where(progress_reminder_sent_at: nil)
      .where("created_at < ?", 1.week.ago)
  end

  def remind(enrollment)
    UserMailer.activity_reminder(enrollment, enrollment.user).deliver_now
  end
end
