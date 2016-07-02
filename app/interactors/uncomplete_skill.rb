class UncompleteSkill < ServiceObject
  def setup
    validate_key :user, :skill

    uncomplete_message = "can only uncomplete a previously completed skill"
    validate(uncomplete_message) { |c| user_completed?(c.user, c.skill) }
  end

  def run
    set_completion
    destroy_completion!
  rescue => error
    fail! "unable to uncomplete skill: #{error.message}"
  end

  private

  def set_completion
    completion = Completion.find_by!(user: context.user, skill: context.skill)
    context.completion = completion
  end

  def destroy_completion!
    context.completion.destroy!
  end

  def user_completed?(user, skill)
    Completion.for!(user, skill)
  rescue
    false
  end
end
