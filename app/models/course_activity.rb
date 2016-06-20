class CourseActivity
  attr_reader :user, :course, :skills

  def initialize(user, course, skills: course.skills)
    @course = course
    @user = user
    @skills = skills
  end

  def user_is_stuck?
    enroll_date && stopped_moving? && unfinished?
  end

  private

  def stopped_moving?
    last_activity_date < 7.days.ago
  end

  def unfinished?
    skills.count > completions.count
  end

  def completions
    @completions ||= Completion.for_category(user, course.categories)
  end

  def last_activity_date
    completions.first.try(:created_at) || enroll_date
  end

  def enroll_date
    @enroll_date ||= Enrollment.enrollment_date(user, course)
  end
end
