class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?

  SIGN_UP_KEYS = [:name, :email, :password, :password_confirmation].freeze
  UPDATE_KEYS =  (SIGN_UP_KEYS + [:current_password]).freeze

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up, keys: SIGN_UP_KEYS)
    devise_parameter_sanitizer.permit(:account_update, keys: UPDATE_KEYS)
  end
end
