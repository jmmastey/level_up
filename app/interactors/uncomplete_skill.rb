class UncompleteSkill
  include Interactor

  def setup
    context.fail!(message: "provide a valid user") unless context[:user].present?
    context.fail!(message: "provide a valid skill") unless context[:skill].present?

    if !failure? && !context[:user].has_completed?(context[:skill])
      context.fail!(message: "can only uncomplete a previously completed skill")
    end
  end

  def perform
    return if failure? # why is this not working?

    completion = Completion.find_by!(user: context[:user], skill: context[:skill])
    if completion.destroy
      context[:completion] = completion
    else
      fail! message: "unable to uncomplete skill: #{completion.errors}"
    end
  end
end
