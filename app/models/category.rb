class Category < ActiveRecord::Base

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle
end
