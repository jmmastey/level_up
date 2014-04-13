class UserMailer < ActionMailer::Base
  default from: ENV["ADMIN_EMAIL"]

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(to: user.email, subject: "You've been enrolled!")
  end
end
