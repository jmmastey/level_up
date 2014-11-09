class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, only: [:show, :update]
  before_filter :summarize_user, only: [:show]

  def index
    @users = User.with_completions.by_activity_date.page(params[:page])
  end

  def update
    authorize! :update, user, message: 'Not authorized as an administrator.'
    if user.update_attributes(params[:user], as: :admin)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  private

  def find_user
    @user ||= User.find params[:id]
  end

  def summarize_user
    @progress = UserSummary.new(@user).for_user.values
  end
end
