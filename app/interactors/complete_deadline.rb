class CompleteDeadline < ServiceObject
  def run
    return unless deadline.present?
    return unless all_skills_completed?

    deadline.update_attributes!(completed_on: Date.today)
  end

  private

  def all_skills_completed?
    skills    = context.category.skills
    skill_ids = skills.pluck(:id)
    completions  = Completion.where(user: context.user, skill: skill_ids)

    skill_ids.length == completions.count
  end

  def deadline
    context.deadline || user_deadline
  end

  def user_deadline
    Deadline.find_by(user: context.user, category: context.category)
  end
end
