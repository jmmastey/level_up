class HomeController < ApplicationController
  helper :courses
  before_action :find_module, only: :show

  def index
    @courses = current_user.courses
    @summary = Summaries.for_user(current_user)
  end

  def show
    render "modules/#{@module.handle}"
  end

  # POST /send_feedback
  def send_feedback
    interactor = SendFeedback.call(user: current_user, page: request.referrer,
                                   message: params['referrer'])

    if interactor.failure?
      render json: { success: false, error: interactor.message },
             status: :unprocessable_entity
    else
      render json: { success: true, complete: false }
    end
  end

  private

  def find_module
    @module = Category.find_by!(handle: params[:module])
  end
end
