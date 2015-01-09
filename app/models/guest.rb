class Guest
  attr_writer :name

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
end
