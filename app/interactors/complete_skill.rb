class CompleteSkill
  include Interactor
  before :setup

  def setup
    context.fail!(message: "provide a valid user") unless context.user
    context.fail!(message: "provide a valid skill") unless context.skill

    return unless context.user && context.user.has_completed?(context.skill)
    context.fail!(message: "cannot re-complete a skill")
  end

  def call
    completion = Completion.new(user: context.user, skill: context.skill)
    if completion.save
      context.completion = completion
    else
      context.fail! message: "unable to complete skill: #{completion.errors}"
    end
  end
end
