class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :miniprofiler

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user.has_role? 'admin'
  end
end
