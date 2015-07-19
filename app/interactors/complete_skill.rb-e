class CompleteSkill < ServiceObject
  def setup
    check_user
    check_skill
    check_recompletion
    check_organization
  end

  def run
    context.completion = new_completion(context.user, context.skill)
    context.completion.save!
  rescue
    fail! message: "unable to complete skill"
  end

  private

  def new_completion(user, skill)
    Completion.new(user: user, skill: skill)
  end

  def check_user
    fail!(message: "provide a valid user") unless context.user
  end

  def check_skill
    fail!(message: "provide a valid skill") unless context.skill
  end

  def check_recompletion
    comp = Completion.for(context.user, context.skill)
    fail!(message: "cannot re-complete a skill") if comp
  end

  def check_organization
    org = context.skill.category.course.organization
    return if !org || org == context.user.organization

    fail!(message: "provide a valid skill")
  end
end
