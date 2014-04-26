class SkillsController < ApplicationController
  before_action :authenticate_user!

  def complete
    unless skill
      render json: { success: false, error: 'provide a valid skill' }, status: :unprocessable_entity
      return
    end

    interactor = CompleteSkill.perform(user: current_user, skill: skill)
    if interactor.success?
      render json: { success: true }
    else
      render json: { success: false, error: interactor.message }, status: :unprocessable_entity
    end
  end

  private

  def skill
    @skill ||= params[:skill_id].present? && Skill.find_by_id(params[:skill_id])
  end

end
