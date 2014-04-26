class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  rolify

  def courses
    Course.with_role(:enrolled, self)
  end

  def skills(category = nil)
    skills = Skill.completed_by(self)
    skills = skills.for_category(category) if category.present?
    skills
  end

  def has_completed?(skill)
    Completion.exists? user: self, skill: skill
  end

end
