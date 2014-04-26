class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  rolify

  has_many :completions
  has_many :skills, through: :completions

  def courses
    Course.for_user(self)
  end

  def categories
    courses.map(&:categories).flatten.uniq
  end

  def has_completed?(skill)
    skills.include? skill
  end

  def admin?
    self.has_role?(:admin)
  end

end
