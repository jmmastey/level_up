class HomeController < ApplicationController
  helper :courses
  before_action :find_module, only: :show

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
    params.permit(:name, :page, :message).to_h.merge(user: current_user)
  end

  def find_module
    @module = Category.by_handle(params[:module])
  end
end
