class Skill < ActiveRecord::Base
  has_many :completions
  belongs_to :category

  validates_presence_of :name, :handle, :category
  validates_uniqueness_of :handle

  scope :for_category, ->(category) { where(category: category) }

  def self.find_by_id(id)
    find_by(id: id)
  end
end
