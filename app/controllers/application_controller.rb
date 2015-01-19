class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user_from_token
  before_filter :miniprofiler
  before_filter :redirect_to_real_domain

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  private

  def authenticate_user_from_token
    return unless params[:auth_email].presence && params[:auth_token].presence

    user = User.from_token_auth(token_auth_params)
    sign_in(user, store: false) if user
  end

  def token_auth_params
    params.permit(:auth_email, :auth_token)
  end

  def miniprofiler
    # Rack::MiniProfiler.authorize_request if current_user.admin?
  end

  def redirect_to_real_domain
    return unless request.host =~ /herokuapp./
    redirect_to request.url.gsub(/herokuapp./, '')
  end

  def render_bad_response(message)
    render json: { success: false, error: message },
           status: :unprocessable_entity
  end
end
