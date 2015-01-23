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
