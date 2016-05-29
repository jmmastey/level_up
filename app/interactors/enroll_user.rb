class EnrollUser < ServiceObject
  def setup
    validate_key :user, :course
    validate("provide a valid course") { |c| user_has_correct_org?(c.course, c.user) }

    default :user_mailer, UserMailer
    default :admin_mailer, AdminMailer
  end

  def run
    add_user_enrollment || fail!("Couldn't add enrollment")
    send_welcome_emails || fail!("Couldn't send email")
  end

  private

  def user_has_correct_org?(course, user)
    course.organization.in? [nil, user.organization]
  end

  def add_user_enrollment
    Enrollment.create(course: context.course, user: context.user)
  end

  def send_welcome_emails
    mail_user && mail_admin
  end

  def mail_admin
    mailer = context.admin_mailer
    mail = mailer.confirm_enrollment(context.user, context.course)
    mail.deliver_now
  end

  def mail_user
    mailer = context.user_mailer
    mail = mailer.confirm_enrollment(context.user, context.course)
    mail.deliver_now
  end
end
