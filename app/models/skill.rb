class Skill < ActiveRecord::Base
  include ArelHelpers::ArelTable

  has_and_belongs_to_many :courses
  has_many :completions
  belongs_to :category

  validates_presence_of :name, :handle, :category
  validates_uniqueness_of :handle

  scope :for_category, ->(category) { where(category: category) }
end
