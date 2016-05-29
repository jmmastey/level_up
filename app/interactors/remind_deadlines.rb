class RemindDeadlines < ServiceObject
  def setup
    default :now, Time.now
    default :user_mailer, UserMailer
    default :deadlines, Deadline.active.nearly_expired
  end

  def run
    context.deadlines.each do |deadline|
      remind(deadline)
    end
  end

  private

  def remind(deadline)
    return if deadline.user.email_opt_out?

    mailer = context.user_mailer
    mailer.deadline_reminder(deadline).deliver_now

    deadline.update_attributes!(reminder_sent_at: context.now)
  end
end
