class Guest
  attr_writer :name

  def summary
    @summary ||= FakeUserSummary.new
  end

  def courses
    Course.none
  end

  def skills
    Skill.none
  end

  def enrollments
    Enrollment.none
  end

  def name
    @name || "Guest"
  end

  def email
    "test@test.com"
  end

  def signed_in?
    false
  end

  def admin?
    false
  end

  def organization
    nil
  end

  def deadline_mode
    nil
  end
end

class FakeUserSummary
  def for_course(course)
    { completed: 0,
      total: course.skills.count }
  end

  def for_category(category)
    { total_completed: 0,
      total_skills: category.skills.count }
  end
end
