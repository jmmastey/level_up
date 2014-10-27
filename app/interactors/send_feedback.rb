class SendFeedback
  include Interactor
  before :setup

  def setup
    [:user, :name, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def call
    message = AdminMailer.send_feedback(context.user, context.name, context.page, context.message)
    unless message.deliver
      context.fail!(message: "unable to send email: #{context.inspect}")
    end
  rescue => e
    context.fail!(message: e.message)
  end

  private

  def fail_unless_var_present(var)
    unless context.send(var)
      context.fail!(message: "provide a valid #{var}")
    end
  end
end
