class CourseActivity
  attr_reader :user, :category

  def initialize(user, category)
    @category = category
    @user = user
  end

  def user_is_stuck?
    enrollment && !(user_is_moving? || user_is_finished?)
  end

  private

  def user_is_moving?
    last_activity_date >= 7.days.ago
  end

  def user_is_finished?
    total    = category.skills.count
    cat_in   = "skill_id in (select skill_id from skills where category_id = ?)"
    complete = Completion.where(user: user).where(cat_in, category.id).count
    complete >= total
  end

  def enrollment
    @enrollment ||= user.enrollments.find_by(course: category.course)
  end

  def completions
    Completion.for_course(enrollment.user, enrollment.course)
  end

  def last_completion
    completions.by_id.first
  end

  def last_activity_date
    last_completion.try(:created_at) || enrollment.created_at
  end
end
