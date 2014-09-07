class UncompleteSkill
  include Interactor

  def setup
    context.fail!(message: "provide a valid user") unless context[:user]
    context.fail!(message: "provide a valid skill") unless context[:skill]

    return if failure? || context[:user].has_completed?(context[:skill])
    context.fail!(message: "can only uncomplete a previously completed skill")
  end

  def perform
    return if failure? # why is this not working?

    target = Completion.find_by!(user: context[:user], skill: context[:skill])
    if target.destroy
      context[:completion] = target
    else
      fail! message: "unable to uncomplete skill: #{target.errors}"
    end
  end
end
