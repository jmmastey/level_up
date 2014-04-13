class Course < ActiveRecord::Base
  has_and_belongs_to_many :skills
end
