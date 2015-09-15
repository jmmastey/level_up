class EnrollUser < ServiceObject
  def setup
    fail! unless context.user.present? && context.course.present?
    fail! unless user_has_correct_org
  end

  def run
    fail!("Couldn't add enrollment") unless add_user_enrollment
    fail!("Couldn't send email") unless send_welcome_email
  end

  private

  def user_has_correct_org
    return true if !context.course.organization.present?

    context.course.organization == context.user.organization
  end

  def add_user_enrollment
    Enrollment.create(course: context.course, user: context.user)
  end

  def send_welcome_email
    admin_mailer.confirm_enrollment(context.user, context.course).deliver_now &&
      user_mailer.confirm_enrollment(context.user, context.course).deliver_now
  end

  def admin_mailer
    context.admin_mailer || AdminMailer
  end

  def user_mailer
    context.user_mailer || UserMailer
  end
end
