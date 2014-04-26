class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  private

  def current_user
    super || Guest.new
  end

end
