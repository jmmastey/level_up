class EnrollUser < ServiceObject
  def setup
    fail! unless user_present?
    fail! unless course_present?
    fail! unless user_has_correct_org?(context.course, context.user)
  end

  def run
    add_user_enrollment || fail!("Couldn't add enrollment")
    send_welcome_email || fail!("Couldn't send email")
  end

  private

  def user_present?
    context.user.present?
  end

  def course_present?
    context.course.present?
  end

  def user_has_correct_org?(course, user)
    course.organization.blank? || course.organization == user.organization
  end

  def add_user_enrollment
    Enrollment.create(course: context.course, user: context.user)
  end

  def send_welcome_email
    mail_user && mail_admin
  end

  def mail_admin
    mailer = context.admin_mailer || AdminMailer
    mailer.confirm_enrollment(context.user, context.course).deliver_now
  end

  def mail_user
    mailer = context.user_mailer || UserMailer
    mailer.confirm_enrollment(context.user, context.course).deliver_now
  end
end
