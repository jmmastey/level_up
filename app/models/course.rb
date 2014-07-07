class Course < ActiveRecord::Base
  has_and_belongs_to_many :skills
  has_many :enrollments
  has_many :categories, -> { uniq }, through: :skills
  has_many :users, through: :enrollments

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

  def self.available_to(student)
    admin_courses = student.admin? ? all : none
    (published | student.courses | admin_courses).sort_by(&:id)
  end

end
