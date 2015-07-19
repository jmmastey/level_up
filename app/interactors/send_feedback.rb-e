class SendFeedback < ServiceObject
  def setup
    [:user, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def run
    feedback_message.deliver_now!
  rescue => e
    fail!(message: "unable to send email: #{e.message}")
  end

  private

  def feedback_message
    AdminMailer.send_feedback(context.user, context.page, context.message)
  end

  def fail_unless_var_present(var)
    fail!(message: "provide a valid #{var}") unless context.send(var)
  end
end
