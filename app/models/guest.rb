class Guest

  def courses
    Course.published
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

end
