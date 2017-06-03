class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user_from_token
  before_action :miniprofiler
  before_action :redirect_to_real_domain
  after_action :set_csp

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  private

  ASSET_SOURCES = [ 'leveluprails.com', 'localhost:5000', 'cdnjs.cloudflare.com',
                    'netdna.bootstrapcdn.com', 'fonts.googleapis.com', 'fonts.gstatic.com',
                    'gravatar.com', '*.google.com', '*.googleapis.com' ]

  def script_nonce
    @nonces ||= []
    SecureRandom.uuid.tap { |nonce| @nonces << nonce }
  end
  helper_method :script_nonce

  def csp_sources
    ["'self'"] + ASSET_SOURCES + (@nonces || []).map { |n| "'nonce-#{n}'" }
  end

  def set_csp
    response.headers['Content-Security-Policy'] = "default-src #{csp_sources.join(' ')}"
  end

  def authenticate_user_from_token
    return unless params[:auth_email].presence && params[:auth_token].presence

    user = User.from_token_auth(token_auth_params)
    sign_in(user, store: false) if user
  end

  def token_auth_params
    params.permit(:auth_email, :auth_token).to_h
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
