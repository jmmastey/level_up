class CompleteSkill
  include Interactor
  before :setup

  def setup
    context.fail!(message: "provide a valid user") unless context.user
    context.fail!(message: "provide a valid skill") unless context.skill

    raise if Completion.for(context.user, context.skill)
  rescue
    context.fail!(message: "cannot re-complete a skill")
  end

  def call
    context.completion = new_completion(context.user, context.skill)
    context.completion.save!
  rescue
    context.fail! message: "unable to complete skill"
  end

  private

  def new_completion(user, skill)
    Completion.new(user: user, skill: skill)
  end
end
