# unless we're in a non-rack environment 
# (which is unlikely when testing status codes, nonetheless possible)
require 'rack/utils'

module StatusMatchers
  # We will use this simple class as our matcher engine
  class BeStatus
    def initialize(status)
      @status = status
    end

    def matches?(target)
      if defined?(target.status)
        @target = target.status
      else
        @target = target
      end

      if @status.is_a?(Range)
        return @status.include?(@target)
      else
        return @target == @status
      end
    end

    def failure_message_for_should
      "expected #{@target} to be Status #{@status}"
    end

    def failure_message_for_should_not
      "expected #{@target} not to be Status #{@status}"
    end
  end

  # We want to support all general status groups
  STATUS_CODE_RANGES = {
    informational: 100..199,
    success: 200..299,
    redirection: 300..399,
    client_error: 400..499,
    server_error: 500..599
  }

  # The Rack::Utils::SYMBOL_TO_STATUS_CODE contains all the
  # Rack::Utils::HTTP_STATUS_CODES already changed to symbols,
  # it's easier to use that
  SYMBOL_TO_STATUS_CODE =
    Rack::Utils::SYMBOL_TO_STATUS_CODE.merge(STATUS_CODE_RANGES)

  SYMBOL_TO_STATUS_CODE.each do |symbol, code|
    define_method("be_#{symbol}") { BeStatus.new(code) }
  end
end
