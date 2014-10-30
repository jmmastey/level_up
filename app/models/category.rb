class Category < ActiveRecord::Base
  include ArelHelpers::ArelTable

  has_many :skills
  has_many :courses, -> { uniq }, through: :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  default_scope -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :sorted, -> { order(:sort_order) }
  scope :by_courses, ->(c) { includes(:courses).where("courses.id" => c).uniq }
end
