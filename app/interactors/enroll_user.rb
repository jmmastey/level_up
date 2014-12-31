class EnrollUser
  include Interactor
  before :setup

  def setup
    context.fail! unless context.user.present? && context.course.present?
  end

  def call
    context.fail!(message: "Couldn't add enrollment") unless add_user_enrollment
    context.fail!(message: "Couldn't send email") unless send_welcome_email
  end

  private

  def add_user_enrollment
    Enrollment.create(course: context.course, user: context.user)
  end

  def send_welcome_email
    AdminMailer.confirm_enrollment(context.user, context.course).deliver_now &&
    UserMailer.confirm_enrollment(context.user, context.course).deliver_now
  end
end
