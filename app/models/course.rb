class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :skills

  validates_presence_of :title, :handle
end
