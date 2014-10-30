module ModulesHelper
  def exercise_block_for(category, handle)
    skill     = skill_object_from(handle)
    ex_block  = ExerciseBlock.new(category, skill, [])

    yield ex_block
    register_exercise_for(skill)

    render_block(ex_block)
  end

  def skill_object_from(handle)
    @module.skills.find { |s| s.handle == handle }
  end

  def exercise_link(exercise_name)
    link_to(exercise_name.titleize, exercise_url(exercise_name))
  end

  def current_skills
    @skills ||= []
  end

  private

  def exercise_url(exercise)
    "http://github.com/jmmastey/level_up_exercises/tree/master/#{exercise}"
  end

  def register_exercise_for(skill)
    current_skills << skill
  end

  def render_block(ex_block)
    render partial: 'exercise/block', object: ex_block
  end

  def render_questions(questions)
    if questions.many?
      render partial: "exercise/questions", object: questions
    else
      render partial: "exercise/question", object: questions.first
    end
  end

  def completion_classes(ex_block)
    if current_user.has_completed?(ex_block.skill)
      "btn btn-default completed"
    else
      "btn btn-default"
    end
  end

  ExerciseBlock = Struct.new(:category, :skill, :questions) do
    def question(text)
      questions << text
      nil
    end
  end
end
