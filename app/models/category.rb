class Category < ActiveRecord::Base
  has_many :skills
  has_many :courses, through: :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  default_scope -> { where(hidden: false) }
  scope :hidden, -> { where(hidden: true) }
  scope :sorted, -> { order(:sort_order) }
  scope :by_courses, -> (courses) { includes(:courses).where(id: courses.map(&:id)) }

  def self.summarize
    table = self.arel_table
    attributes = [table[:id], table[:name], table[:handle]]

    table.project(attributes).group(attributes).order(table[:sort_order])
         .where(table[:hidden].eq(false))
  end

end
