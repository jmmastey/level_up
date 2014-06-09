class CoursesController < ApplicationController

  before_filter :authenticate_user!, only: :enroll

  # GET /
  def index
    @courses = current_user.courses
  end

  # POST enroll
  def enroll
    course = Course.published.find params[:course_id]
    interactor = EnrollUser.perform user: current_user, course: course
    if interactor.success?
      render locals: { course: course, enrollment: interactor.enrollment }
    else
      flash[:error] = interactor.message
      redirect_back
    end
  end

  private

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  def signed_in?
    current_user.signed_in?
  end
  helper_method :signed_in?

end
