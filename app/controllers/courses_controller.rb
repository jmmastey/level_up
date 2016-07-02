class CoursesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!, only: :enroll
  before_action :set_course, only: [:enroll, :show]

  # GET /
  def index
    @courses = Course.available_to(current_user)
  end

  # GET /show
  def show
    redirect_to courses_path, notice: "Couldn't find that course, sorry." unless @course
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
    @course = Course.published
                    .where(organization: [current_user.organization, nil])
                    .where(id: params[:id]).first
  end
end
