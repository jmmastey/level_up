class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :miniprofiler
  before_filter :redirect_to_real_domain

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def current_user
    super || Guest.new
  end
  helper_method :current_user

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user.admin?
  end

  def redirect_to_real_domain
    return unless request.host =~ /herokuapp./
    redirect_to request.url.gsub(/herokuapp./, '')
  end
end
