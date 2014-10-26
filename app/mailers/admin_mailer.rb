class AdminMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"], to: ENV["ADMIN_EMAIL"]

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(subject: "User enrollment for #{course.handle}")
  end

  def send_feedback(user, page, message)
    @user, @page, @message = user, page, message
    mail(from: user.email, subject: "Feedback from #{user.name}")
  end
end
