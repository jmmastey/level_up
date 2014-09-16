class SkillsController < ApplicationController
  before_action :authenticate_user!

  # POST skill/:skill_id/completion
  def complete
    return render_bad_response('provide a valid skill') unless skill
    interactor = CompleteSkill.call(user: current_user, skill: skill)
    return render_bad_response(interactor.message) if interactor.failure?

    render json: { success: true, complete: true }
  end

  # DELETE skill/:skill_id/completion
  def uncomplete
    return render_bad_response('provide a valid skill') unless skill
    interactor = UncompleteSkill.call(user: current_user, skill: skill)
    return render_bad_response(interactor.message) if interactor.failure?

    render json: { success: true, complete: false }
  end

  private

  def render_bad_response(message)
    render json: { success: false, error: message },
           status: :unprocessable_entity
  end

  def skill
    @skill ||= params[:skill_id].present? && Skill.find_by_id(params[:skill_id])
  end
end
