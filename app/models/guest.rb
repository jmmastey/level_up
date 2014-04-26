class Guest

  def courses
    Course.public
  end

  def skills
    Skill.none
  end

  def name
  end

end
