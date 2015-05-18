class InviteToSlack
  include Interactor

  def call
    context.users.each { |user| invite_to_slack(user) }
  end

  private

  def invite_to_slack(user)
    update(user) && remind(user)
  end

  def update(user)
    !user.slack_invite_sent_at &&
      !user.email_opt_out &&
      user.update_attributes!(slack_invite_sent_at: Time.now)
  end

  def remind(user)
    UserMailer.slack_reminder(user).deliver_now
  end
end
