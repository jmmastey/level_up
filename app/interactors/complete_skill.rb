class CompleteSkill
  include Interactor
  before :setup

  def setup
    check_user
    check_skill
    check_recompletion
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

  def check_user
    context.fail!(message: "provide a valid user") unless context.user
  end

  def check_skill
    context.fail!(message: "provide a valid skill") unless context.skill
  end

  def check_recompletion
    comp = Completion.for(context.user, context.skill)
    context.fail!(message: "cannot re-complete a skill") if comp
  end
end
