class CompleteSkill < ServiceObject
  def setup
    check_user
    check_skill
    check_recompletion
    check_organization
  end

  def run
    create_completion(context.user, context.skill)
    complete_deadline
  rescue
    fail! "unable to complete skill"
  end

  private

  def complete_deadline
    CompleteDeadline.call(user: context.user, category: context.skill.category)
  end

  def create_completion(user, skill)
    completion = Completion.new(user: user, skill: skill).tap(&:save!)
    context.completion = completion
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
    return if failure?

    fail!("provide a valid skill") unless skill_org.in? [nil, context.user.organization]
  end

  def skill_org
    context.skill.category.course.organization
  end
end
