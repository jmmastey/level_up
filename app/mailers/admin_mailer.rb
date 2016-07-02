class AdminMailer < ActionMailer::Base
  default_email = ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  default from: default_email, to: default_email

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(subject: "LevelUp: User enrollment for #{course.handle}")
  end

  def send_feedback(user, page, message)
    @user = user
    @name = user.name
    @page = page
    @message = message
    mail(from: user.email, reply_to: user.email,
         subject: "LevelUp: Feedback from #{@name}")
  end
end
