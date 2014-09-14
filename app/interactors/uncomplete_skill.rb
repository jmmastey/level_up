class UncompleteSkill
  include Interactor
  before :setup

  def setup
    context.fail!(message: "provide a valid user") unless context.user
    context.fail!(message: "provide a valid skill") unless context.skill

    return if context.user && context.user.has_completed?(context.skill)
    context.fail!(message: "can only uncomplete a previously completed skill")
  end

  def call
    target = Completion.find_by!(user: context.user, skill: context.skill)
    if target.destroy
      context.completion = target
    else
      context.fail! message: "unable to uncomplete skill: #{target.errors}"
    end
  end
end
