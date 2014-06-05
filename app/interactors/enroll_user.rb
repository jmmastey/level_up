class EnrollUser
  include Interactor

  def setup
    context.fail! unless context[:user].present? && context[:course].present?
  end

  def perform
    fail!(message: "Couldn't add enrollment") unless add_user_enrollment
    fail!(message: "Couldn't send email") unless send_welcome_email
  end

  private

  def add_user_enrollment
    context[:course].enroll context[:user]
  end

  def send_welcome_email
    AdminMailer.confirm_enrollment(context[:user], context[:course]).deliver &&
    UserMailer.confirm_enrollment(context[:user], context[:course]).deliver
  end

end
