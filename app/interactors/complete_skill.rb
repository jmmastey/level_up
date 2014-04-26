class CompleteSkill
  include Interactor

  def setup
    context.fail!(message: "provide a valid user") unless context[:user].present?
    context.fail!(message: "provide a valid skill") unless context[:skill].present?

    if !failure? && context[:user].has_completed?(context[:skill])
      context.fail!(message: "cannot re-complete a skill")
    end
  end

  def perform
    completion = Completion.new(user: context[:user], skill: context[:skill])
    if completion.save
      context[:completion] = completion
    else
      fail! message: "unable to complete skill: #{completion.errors}"
    end
  end
end
