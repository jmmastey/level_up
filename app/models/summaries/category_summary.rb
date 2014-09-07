module Summaries
  class CategorySummary < Summaries::Base
    def initialize(user)
      summary     = user_summary(user)
      categories  = Category.by_courses(user.courses).sorted

      @data = categories.map do |category|
        summary[category.handle].merge(handle: category.handle)
      end
    end
  end
end
