class Course < ActiveRecord::Base
  resourcify

  has_and_belongs_to_many :skills
  has_many :categories, through: :skills, uniq: true

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :published, -> { where(status: :published) }

  state_machine :status, initial: :created do
    event :approve do
      transition :created => :approved
    end

    event :publish do
      transition [:created, :approved, :hidden] => :published
    end

    event :hide do
      transition :published => :hidden
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
    published | enrolled_courses_for(student) | admin_courses(student)
  end

  def has_enrolled?(student)
    student.has_role?(:enrolled, self)
  end

  def self.enrolled_courses_for(student)
    with_role(:enrolled, student)
  end

  protected

  def self.admin_courses(user)
    user.admin? ? all : none
  end

end
