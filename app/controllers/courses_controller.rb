class CoursesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, only: :enroll
  before_filter :set_course, only: [:enroll, :show]

  # GET /
  def index
    @courses = Course.available_to(current_user)
  end

  # POST enroll
  def enroll
    interactor = EnrollUser.perform(user: current_user, course: @course)

    if interactor.failure?
      flash[:error] = interactor.message
      redirect_back and return
    end

    respond_with @course
  end

  private

  def set_course # yarr
    @course = Course.published.find(params[:id])
  end

end
