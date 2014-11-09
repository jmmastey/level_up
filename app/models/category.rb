class Category < ActiveRecord::Base
  has_many :skills
  has_many :courses, -> { uniq }, through: :skills

  validates :name, presence: true
  validates :handle, presence: true, uniqueness: true
  validates :difficulty, allow_nil: true, inclusion: { in: 1..10 }

  default_scope -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :sorted, -> { order(:sort_order) }
  scope :by_courses, ->(c) { includes(:courses).where("courses.id" => c).uniq }

  def self.by_handle(handle)
    find_by!(handle: handle)
  end
end
