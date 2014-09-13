module Summaries
  class Base
    def initialize(*_args)
      @data = {}
    end

    def to_h
      @data || {}
    end

    private

    def connection
      ActiveRecord::Base.connection
    end

    def user_summary(user)
      UserSummary.new(user).to_h
    end
  end
end
