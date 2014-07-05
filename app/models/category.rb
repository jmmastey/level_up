class Category < ActiveRecord::Base
  default_scope -> { order('sort_order asc') }

  has_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle
end
