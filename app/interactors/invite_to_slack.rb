class InviteToSlack < ServiceObject
  def run
    context.users.each { |user| invite_to_slack(user) }
  end

  private

  def invite_to_slack(user)
    User.transaction do
      update(user) && remind(user)
    end
  end

  def update(user)
    !user.slack_invite_sent_at &&
      !user.email_opt_out &&
      user.update_attributes!(slack_invite_sent_at: Time.now)
  end

  def remind(user)
    user_mailer.slack_reminder(user).deliver_now
  end

  def user_mailer
    context.user_mailer || UserMailer
  end
end
