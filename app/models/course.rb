class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :skills
  has_many :categories, through: :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :published, -> { where(status: :published) }

  state_machine :status, initial: :created do
    event :approve do
      transition :created => :approved
    end

    event :publish do
      transition [:created, :approved] => :published
    end

    event :deprecate do
      transition :published => :deprecated
    end
  end

  def enroll!(user)
    user.add_role(:enrolled, self)
  end

  def users
    self.class.with_role(:enrolled, self)
  end

  def self.for_user(user)
    self.published | enrolled_courses(user) | admin_courses(user)
  end

  protected

  def self.enrolled_courses(user)
    self.with_role(:enrolled, user)
  end

  def self.admin_courses(user)
    user.admin? ? self.all : self.none
  end

end
