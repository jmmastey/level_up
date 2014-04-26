class Guest

  def courses
    Course.published
  end

  def skills
    Skill.none
  end

  def name
  end

end
