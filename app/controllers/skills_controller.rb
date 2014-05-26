class SkillsController < ApplicationController
  before_action :authenticate_user!

  # POST skill/:skill_id/completion
  def complete
    unless skill
      render json: { success: false, error: 'provide a valid skill' }, status: :unprocessable_entity
      return
    end

    interactor = CompleteSkill.perform(user: current_user, skill: skill)
    if interactor.success?
      render json: { success: true, complete: true }
    else
      render json: { success: false, error: interactor.message }, status: :unprocessable_entity
    end
  end

  # DELETE skill/:skill_id/completion
  def uncomplete
    unless skill
      render json: { success: false, error: 'provide a valid skill' }, status: :unprocessable_entity
      return
    end

    interactor = UncompleteSkill.perform(user: current_user, skill: skill)
    if interactor.success?
      render json: { success: true, complete: false }
    else
      render json: { success: false, error: interactor.message }, status: :unprocessable_entity
    end
  end

  private

  def skill
    @skill ||= params[:skill_id].present? && Skill.find_by_id(params[:skill_id])
  end

end
