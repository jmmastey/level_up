class DeadlinesController < ApplicationController
  before_action :authenticate_user!

  # POST deadlines/toggle
  def toggle
    current_user.update_attributes!(mode_params)
    notice = "Account details updated successfully. We'll remember that."
    redirect_back(fallback_location: edit_user_registration_path, notice: notice)
  end

  # POST deadlines
  def create
    Deadline.create!(deadline_params.merge(user: current_user))
    notice = "Locked and loaded: this lesson is going down by " \
             "#{deadline_params[:target_completed_on]}. You'll receive a reminder for " \
             "this deadline as it comes closer."

    redirect_back(fallback_location: edit_user_registration_path, notice: notice)
  end

  # DELETE destroy
  def destroy
    deadline = Deadline.find(params[:id])
    deadline.destroy

    redirect_back(fallback_location: edit_user_registration_path, notice: "Deadline removed. :'(")
  end

  private

  def mode_params
    params.permit(:deadline_mode)
  end

  def deadline_params
    params.require(:deadline).permit(:category_id, :target_completed_on)
  end
end
