class Skill < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_many :completions
  belongs_to :category

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :for_category, -> (category) { where(category: category) }
  scope :completed_by, -> (user) { joins(:completions).where(completions: { user: user }) }
end
