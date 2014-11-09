class ExerciseBlock

  attr_accessor :category, :skill, :questions

  def initialize(category, skill)
    @category = Category.find_by(handle: category)
    @skill = @category.skills.find_by(handle: skill)
    @questions = []
  end


  def question(text)
    @questions << text
    nil
  end

  def to_partial_path
    "exercise/block"
  end


  def questions
    QuestionBlock.new(@questions)
  end
end

class QuestionBlock
  def initialize(questions)
    @questions = questions
    @questions = @questions.first unless @questions.many?
  end


  def to_partial_path
    if @questions.respond_to? :each
      "exercise/questions"
    else
      "exercise/question"
    end
  end

  def each(&block)
    @questions.each(&block)
  end
end
