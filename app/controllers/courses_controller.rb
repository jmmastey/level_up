class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  private

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  def user_signed_in?
    current_user.signed_in?
  end
  helper_method :user_signed_in?

end
