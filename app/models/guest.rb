class Guest
  def courses
    Course.none
  end

  def skills
    Skill.none
  end

  def name
    # NOOP
  end

  def signed_in?
    false
  end

  def admin?
    false
  end

  def roles
    Role.none
  end

  def has_completed?(_skill)
    false
  end
end
