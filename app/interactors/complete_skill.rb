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
    CompleteDeadline.call(user: context.user, category: context.skill.category)
  rescue
    fail! "unable to complete skill"
  end

  private

  def new_completion(user, skill)
    Completion.new(user: user, skill: skill)
  end

  def check_user
    fail!("provide a valid user") unless context.user
  end

  def check_skill
    fail!("provide a valid skill") unless context.skill
  end

  def check_recompletion
    comp = Completion.for(context.user, context.skill)
    fail!("cannot re-complete a skill") if comp
  end

  def check_organization
    raise context.inspect unless context.skill.present?
    org = context.skill.category.course.organization
    return if !org || org == context.user.organization

    fail!("provide a valid skill")
  end
end
