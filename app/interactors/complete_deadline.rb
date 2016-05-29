class CompleteDeadline < ServiceObject
  def setup
    validate_key :category, :user
    default :deadline, user_deadline
  end

  # return but don't fail if there's no deadline
  def run
    return unless context.deadline
    return unless all_skills_completed?

    context.deadline.update_attributes!(completed_on: Date.today)
  end

  private

  def all_skills_completed?
    skills    = context.category.skills
    skill_ids = skills.pluck(:id)
    completions  = Completion.where(user: context.user, skill: skill_ids)

    skill_ids.length == completions.count
  end

  def user_deadline
    Deadline.find_by(user: context.user, category: context.category)
  end
end
