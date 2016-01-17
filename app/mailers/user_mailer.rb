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
    title = "LevelUpRails: Stuck working on #{@course.name}? Here comes help!"
    mail(to: @user.email, subject: title)
  end

  def deadline_reminder(deadline)
    @user = deadline.user
    @category = deadline.category
    @deadline = deadline
    mail(to: @user.email, subject: "LevelUpRails: Your deadline for #{@category.name} is coming up.")
  end
end
