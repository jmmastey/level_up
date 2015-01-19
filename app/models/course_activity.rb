class CourseActivity
  attr_reader :user, :course

  def initialize(user, course)
    @course = course
    @user = user
  end

  def user_is_stuck?
    enroll_date && stopped_moving? && unfinished?
  end

  private

  def stopped_moving?
    last_activity_date < 7.days.ago
  end

  def unfinished?
    course.skills.count > completions.count
  end

  def completions
    @completions ||= Completion.joins(:skill)
      .where(user: user)
      .where(skills: { category_id: course.categories })
      .by_id
  end

  def last_activity_date
    completions.first.try(:created_at) || enroll_date
  end

  def enroll_date
    @enroll_date ||= user.enrollments.where(course: course).pluck(:created_at).first
  end
end
