class ExerciseBlock
  attr_accessor :category, :skill, :questions

  def initialize(category, skill)
    @category = category
    @skill = category.skills.find { |s| s.handle == skill }
    @questions = []

    yield self if block_given?
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

  def to_s
    @questions
  end
end
