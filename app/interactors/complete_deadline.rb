class CompleteDeadline < ServiceObject
  def run
    return unless deadline.present?
    return unless all_skills_completed?

    deadline.update_attributes!(completed_on: Date.today)
  end

  private

  def all_skills_completed?
    all       = context.category.skills.pluck(:id)
    complete  = Completion.where(user: context.user, skill: all).count

    all.length == complete
  end

  def deadline
    context.deadline ||
      Deadline.where(user: context.user, category: context.category).first
  end
end
