class Category < ActiveRecord::Base
  include ArelHelpers::ArelTable

  has_many :skills
  has_many :courses, through: :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  default_scope -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :sorted, -> { order(:sort_order) }
  scope :by_courses, -> (courses) { includes(:courses).where(id: courses.map(&:id)) }
end
