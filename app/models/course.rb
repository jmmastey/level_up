class Course < ActiveRecord::Base
  has_many :categories
  has_many :skills, through: :categories
  has_many :enrollments
  has_many :users, through: :enrollments

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :published, -> { where(status: :published) }
  scope :by_date, -> { order("created_at desc") }
  scope :in_org, ->(org) { where(organization: [nil, org]) }

  state_machine :status, initial: :created do
    event(:approve)  { transition created: :approved }
    event(:publish)  { transition [:created, :approved, :hidden] => :published }
    event(:hide)     { transition published: :hidden }
    event(:deprecate) { transition published: :deprecated }
  end

  def self.available_to(student)
    courses = if student.admin?
      all
    else
      published.in_org(student.organization) | student.courses
    end

    courses.sort_by(&:sort_order)
  end

  def self.published_course(id)
    all.published.find(id)
  end

  def for_org?(org)
    !organization || organization == org
  end
end
