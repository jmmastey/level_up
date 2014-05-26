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

  def enroll!(student)
    student.add_role(:enrolled, self)
  end

  def students
    self.class.with_role(:enrolled, self)
  end

  def self.for_student(student)
    published | enrolled_courses(student) | admin_courses(student)
  end

  protected

  def self.enrolled_courses(student)
    with_role(:enrolled, student)
  end

  def self.admin_courses(user)
    user.admin? ? all : none
  end

end
