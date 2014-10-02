class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    do_sign_in || do_register
  end

  private

  def do_sign_in
    return unless @user.persisted?

    if is_navigational_format?
      set_flash_message(:notice, :success, kind: "Github")
    end
    sign_in_and_redirect @user, event: :authentication
  end

  def do_register
    session["devise.github_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end
