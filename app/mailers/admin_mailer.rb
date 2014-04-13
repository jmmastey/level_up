class AdminMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"], to: ENV["ADMIN_EMAIL"]

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(subject: "User enrollment for #{course.handle}")
  end
end
