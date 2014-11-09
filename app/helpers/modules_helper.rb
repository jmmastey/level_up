module ModulesHelper
  def exercise_block_for(category, handle)
    block  = ExerciseBlock.new(category, handle)

    yield block

    current_skills << block.skill
    render block
  end

  def exercise_link(exercise_name)
    link_to(exercise_name.titleize, exercise_url(exercise_name))
  end

  def current_skills
    @current_skills ||= []
  end

  def exercise_url(exercise)
    "http://github.com/jmmastey/level_up_exercises/tree/master/#{exercise}"
  end

  def completion_classes(ex_block)
    if Completion.for(current_user, ex_block.skill)
      "btn btn-default completed"
    else
      "btn btn-default"
    end
  end

  def completion_classes_small(user, skill)
    if Completion.for(user, skill)
      "fa-check-circle-o"
    else
      "fa-circle-o"
    end
  end
end
