class Skill < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_many :completions
  belongs_to :category

  validates_presence_of :name, :handle, :category
  validates_uniqueness_of :handle

  scope :for_category, -> (category) { where(category: category) }

  def self.summarize(categories)
    table = self.arel_table
    cat_table = Category.arel_table

    categories.join(table).on(table[:category_id].eq cat_table[:id])
      .project(table[:id].count.as("total_skills"))
  end

end
