class RemindDeadlines < ServiceObject
  def run
    targets.each { |deadline| remind(deadline) }
  end

  private

  def targets
    context.deadlines ||= Deadline.active.nearly_expired
  end

  def remind(deadline)
    return unless deadline.user.email_opt_out.nil?

    user_mailer.deadline_reminder(deadline).deliver_now
    deadline.update_attributes!(reminder_sent_at: now)
  end

  def now
    @now ||= (context.now || Time.now)
  end

  def user_mailer
    context.user_mailer || UserMailer
  end
end
