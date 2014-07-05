class CoursesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, only: :enroll
  before_filter :set_course, only: [:enroll, :show]

  # GET /
  def index
    @courses = current_user.courses
  end

  # POST enroll
  def enroll
    interactor = EnrollUser.perform user: current_user, course: @course
    if interactor.success?
      respond_with @course
    else
      flash[:error] = interactor.message
      redirect_back
    end
  end

  private

  def set_course # yarr
    @course = Course.published.find params[:id]
  end

  def signed_in?
    current_user.signed_in?
  end
  helper_method :signed_in?

end
