class Category < ActiveRecord::Base
  has_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  def self.visible_categories_for(course)
    course.categories.reject(&:hidden?).sort_by(&:sort_order)
  end
end
