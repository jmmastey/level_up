class EnrollUser
  include Interactor

  def setup
    context.fail! unless context[:user].present? && context[:course].present?
  end

  def perform
    add_user_enrollment
    send_welcome_email
  end

  private

  def add_user_enrollment
    context[:user].add_role :enrolled, context[:course]
  end

  def send_welcome_email
    AdminMailer.confirm_enrollment(user: context[:user], course: context[:course]).deliver
    UserMailer.confirm_enrollment(user: context[:user], course: context[:course]).deliver
  end

end
