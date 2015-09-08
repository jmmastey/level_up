class HomeController < ApplicationController
  helper :courses
  before_action :find_category, only: :show
  before_action :find_completed_skills, only: :show
  before_action :find_deadline, only: :show

  include CategoryRouter

  # GET /
  def index
    @courses = current_user.courses
  end

  # POST /send_feedback
  def send_feedback
    interactor = SendFeedback.call(feedback_params)

    if interactor.failure?
      render_bad_response(interactor.message)
    else
      render json: { success: true, complete: false }
    end
  end

  private

  def feedback_params
    current_user.name = params["name"]
    params.permit(:page, :message).to_h.merge(user: current_user)
  end

  def find_category
    @category = find_category!(params, current_user)
  rescue => e
    logger.error e.message
    raise AbstractController::ActionNotFound
  end

  def find_deadline
    @deadline = Deadline.where(category: @category, user: current_user).first ||
                Deadline.new(category: @category)
  end

  def find_completed_skills
    if current_user.signed_in?
      @skills = Completion.user_skills(current_user)
    else
      @skills = []
    end
  end
end
