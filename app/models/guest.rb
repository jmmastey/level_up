class Guest
  def courses
    Course.none
  end

  def skills
    Skill.none
  end

  def name
    "Guest"
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
