class CoursesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, only: :enroll
  before_filter :set_course, only: [:enroll, :show]
  before_filter :summarize_user, only: [:show]

  # GET /
  def index
    @courses = Course.available_to(current_user)
  end

  # POST enroll
  def enroll
    interactor = EnrollUser.call(user: current_user, course: @course)

    if interactor.failure?
      flash[:error] = interactor.message
      redirect_back
    else
      respond_with @course
    end
  end

  private

  def set_course # yarr
    @course = Course.published.find(params[:id])
  end

  def summarize_user
    @progress = UserSummary.new(current_user).for_user
  end
end
