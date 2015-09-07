class UncompleteSkill < ServiceObject
  def setup
    check_user
    check_skill
    check_completion
  end

  def run
    set_completion(context.user, context.skill)
    context.completion.destroy!
  rescue => error
    fail! "unable to uncomplete skill: #{error.message}"
  end

  private

  def set_completion(user, skill)
    context.completion = Completion.find_by!(user: user, skill: skill)
  end

  def check_user
    fail!("provide a valid user") unless context.user
  end

  def check_skill
    fail!("provide a valid skill") unless context.skill
  end

  def check_completion
    Completion.for!(context.user, context.skill)
  rescue
    fail!("can only uncomplete a previously completed skill")
  end
end
