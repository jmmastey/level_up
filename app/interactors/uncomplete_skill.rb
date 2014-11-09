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
    set_completion(context.user, context.skill)
    context.completion.destroy!
  rescue error
    context.fail! message: "unable to uncomplete skill: #{target.errors}"
  end

  private

  def set_completion(user, skill)
    context.completion = Completion.find_by!(user: user, skill: skill)
  end
end
