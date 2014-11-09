class SendFeedback
  include Interactor
  before :setup

  def setup
    [:user, :name, :page, :message].each do |var|
      fail_unless_var_present(var)
    end
  end

  def call
    message = AdminMailer.send_feedback(context.user, context.name,
                                        context.page, context.message)
    message.deliver!
  rescue => e
    context.fail!(message: "unable to send email: #{e.message}")
  end

  private

  def fail_unless_var_present(var)
    context.fail!(message: "provide a valid #{var}") unless context.send(var)
  end
end
