class SendFeedback < ServiceObject
  def setup
    validate_key :user, :page, :message
    default :admin_mailer, AdminMailer
  end

  def run
    feedback_message.deliver_now!
  rescue => e
    fail!("unable to send email: #{e.message}")
  end

  private

  def feedback_message
    mailer = context.admin_mailer
    mailer.send_feedback(context.user, context.page, context.message)
  end
end
