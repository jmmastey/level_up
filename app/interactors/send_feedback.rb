class SendFeedback
  include Interactor
  before :setup

  def setup
    [:user, :name, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def call
    c = context
    message = AdminMailer.send_feedback(c.user, c.name, c.page, c.message)
    unless message.deliver
      context.fail!(message: "unable to send email: #{context.inspect}")
    end
  rescue => e
    context.fail!(message: e.message)
  end

  private

  def fail_unless_var_present(var)
    context.fail!(message: "provide a valid #{var}") unless context.send(var)
  end
end
