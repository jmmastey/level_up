class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :update]
  before_action :find_active_users, only: [:index]

  def update
    if current_user.update_attributes(user_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  private

  def find_active_users
    @users = User.with_recent_activity
                 .by_org(current_user.organization)
                 .page(params[:page])
  end

  def find_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.permit(:user)
  end
end
