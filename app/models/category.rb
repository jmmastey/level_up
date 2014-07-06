class Category < ActiveRecord::Base
  has_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle
  scope :ordered, -> { order('sort_order asc') }

  def to_s
    name
  end
end
