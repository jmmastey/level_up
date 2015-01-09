class Category < ActiveRecord::Base
  has_many :skills
  belongs_to :course

  validates :name, presence: true
  validates :handle, presence: true, uniqueness: true
  validates :difficulty, allow_nil: true, inclusion: { in: 1..10 }
  validates :course_id, presence: true

  default_scope -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :sorted, -> { order(:sort_order) }

  def self.by_handle(handle)
    find_by!(handle: handle)
  end
end
