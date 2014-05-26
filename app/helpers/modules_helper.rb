module ModulesHelper



  # exercise block helpers

  def exercise_block_for(category, skill)
    cat       = Category.find_by_handle category
    skill     = Skill.find_by_handle skill
    ex_block  = ExerciseBlock.new(category, skill, [])

    yield ex_block
    render_block(ex_block)
  end

  def render_block(ex_block)
    render partial: 'modules/exercise', locals: { block: ex_block }
  end

  def completion_classes(ex_block)
    if current_user.has_completed?(ex_block.skill)
      "btn btn-default completed"
    else
      "btn btn-default"
    end
  end

  ExerciseBlock = Struct.new(:category, :skill, :content) do
    def question(text)
      content << text
      nil
    end
  end

end
