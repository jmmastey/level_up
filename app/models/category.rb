class Category < ActiveRecord::Base
  has_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle
end
