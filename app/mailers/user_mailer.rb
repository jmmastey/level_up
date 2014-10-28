class UserMailer < ActionMailer::Base
  default_email = ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  default from: default_email

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(to: user.email, subject: "You've been enrolled!")
  end
end
