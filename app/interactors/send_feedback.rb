class SendFeedback
  include Interactor
  before :setup

  def setup
    [:user, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def call
    if AdminMailer.send_feedback(context.user, context.page, context.message)
      context.fail!(message: "unable to send email: #{context.inspect}")
    end
  end

  private

  def fail_unless_var_present(var)
    unless context.send(var)
      context.fail!(message: "provide a valid #{var}")
    end
  end
end
