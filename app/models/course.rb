class Course < ActiveRecord::Base
  has_many :categories
  has_many :skills, through: :categories
  has_many :enrollments
  has_many :users, through: :enrollments

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :published, -> { where(status: :published) }
  scope :by_date, -> { order("created_at desc") }

  state_machine :status, initial: :created do
    event(:approve)  { transition created: :approved }
    event(:publish)  { transition [:created, :approved, :hidden] => :published }
    event(:hide)     { transition published: :hidden }
    event(:deprecate) { transition published: :deprecated }
  end

  def self.available_to(student)
    return all.sort_by(&:sort_order) if student.admin?

    (published | student.courses).reject do |course|
      course.organization && student.organization != course.organization
    end.sort_by(&:sort_order)
  end

  def self.published_course(id)
    published.find(id)
  end
end
