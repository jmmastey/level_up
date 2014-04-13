class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  rolify

  def courses
    Course.with_role(:enrolled, self)
  end

end
