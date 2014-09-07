module Summaries
  class Base
    attr_reader :data

    def initialize(*_args)
      @data = {}
    end

    private

    alias :to_h :data

    def connection
      ActiveRecord::Base.connection
    end

    def user_summary(user)
      UserSummary.new(user).to_h
    end
  end
end
