class ServiceObject
  attr_reader :context

  # setup

  def initialize(params = {})
    @context = OpenStruct.new
    params.each do |k, v|
      @context.send("#{k}=", v)
    end
    setup if respond_to?(:setup)
  end

  # error handling

  def errors
    @errors ||= []
  end

  def message
    errors.join("\n")
  end

  def fail!(message = '')
    errors << message
  end

  def failure?
    errors.any?
  end

  def success?
    !failure?
  end

  # execution

  def run
    raise NotImplementedError, "Please implement 'run' to perform the work."
  end

  def call
    run unless failure?
    self
  end

  def self.call(context = {})
    new(context).call
  end

  # validations

  def validate(message)
    fail! message unless yield(context)
  end

  def validate_key(*keys)
    keys.each do |key|
      validate("provide a valid #{key}") { |c| c.send(key).present? }
    end
  end

  def default(key, value)
    context.send("#{key}=", value) unless context.send(key).present?
  end
end
