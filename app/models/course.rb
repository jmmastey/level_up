class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle
end
