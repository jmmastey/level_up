class SkillsController < ApplicationController
  before_action :authenticate_user!

  # POST skill/:skill_id/completion
  def complete
    interactor = CompleteSkill.call(user: current_user, skill: skill)

    if interactor.failure?
      render_bad_response(interactor.message)
    else
      render json: { success: true, complete: true }
    end
  end

  # DELETE skill/:skill_id/completion
  def uncomplete
    interactor = UncompleteSkill.call(user: current_user, skill: skill)

    if interactor.failure?
      render_bad_response(interactor.message)
    else
      render json: { success: true, complete: false }
    end
  end

  private

  def skill
    @skill ||= Skill.find(params[:skill_id])
  end
end
