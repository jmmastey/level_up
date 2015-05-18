class UserMailer < ActionMailer::Base
  default_email = ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  default from: default_email

  def confirm_enrollment(user, course)
    @user = user
    @course = course
    mail(to: user.email, subject: "You've been enrolled!")
  end

  def reg_reminder(user)
    @user = user
    mail(to: user.email, subject: "We miss you. Come on back.")
  end

  def activity_reminder(enrollment)
    @user = enrollment.user
    @course = enrollment.course
    title = "LevelUp: Stuck working on #{@course.name}? Here comes help!"
    mail(to: @user.email, subject: title)
  end

  def slack_reminder(user)
    @user = user
    mail(to: user.email, subject: "Get LevelUp help (and give it) on Slack.")
  end
end
