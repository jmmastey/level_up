class CompleteSkill < ServiceObject

  def setup
    validate_key :skill, :user
    validate("cannot re-complete a skill") { |c| !Completion.for(c.user, c.skill) }
    validate("provide a valid skill") { org_matches? }
  end

  def run
    create_completion(context.user, context.skill)
    complete_deadline
  rescue
    fail! "unable to complete skill"
  end

  def org_matches?
    success? && skill_org.in?([nil, context.user.organization])
  end

  private

  def complete_deadline
    CompleteDeadline.call(user: context.user, category: context.skill.category)
  end

  def create_completion(user, skill)
    completion = Completion.new(user: user, skill: skill).tap(&:save!)
    context.completion = completion
  end

  def skill_org
    context.skill.category.course.organization
  end
end
