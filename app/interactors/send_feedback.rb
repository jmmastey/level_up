class SendFeedback
  include Interactor
  before :setup

  def setup
    [:user, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def call
    feedback_message.deliver!
  rescue => e
    context.fail!(message: "unable to send email: #{e.message}")
  end

  private

  def feedback_message
    AdminMailer.send_feedback(context.user, context.page, context.message)
  end

  def fail_unless_var_present(var)
    context.fail!(message: "provide a valid #{var}") unless context.send(var)
  end
end
