class CourseActivity
  attr_reader :enrollment

  def initialize(enrollment)
    @enrollment = enrollment
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
