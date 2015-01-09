class UncompleteSkill
  include Interactor
  before :setup

  def setup
    check_user
    check_skill
    check_completion
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

  def check_user
    context.fail!(message: "provide a valid user") unless context.user
  end

  def check_skill
    context.fail!(message: "provide a valid skill") unless context.skill
  end

  def check_completion
    Completion.for!(context.user, context.skill)
  rescue
    context.fail!(message: "can only uncomplete a previously completed skill")
  end
end
