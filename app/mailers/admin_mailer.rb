class AdminMailer < ActionMailer::Base
  default_email = ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  default from: default_email, to: default_email

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(subject: "User enrollment for #{course.handle}")
  end

  def send_feedback(user, name, page, message)
    @user, @name, @page, @message = user, name, page, message
    mail(from: user.email, subject: "Feedback from #{@name}")
  end
end
