module Summaries
  class CourseSummary < Summaries::Base
    def initialize(course, user)
      @data = { total: 0, completed: 0, verified: 0 }
      summarize_for(course, user)
    end

    private

    def summarize_for(course, user)
      Summaries.for_user(user).each do |category, stats|
        next unless category_in_course?(course, category)

        @data[:total]     += stats[:total_skills]
        @data[:completed] += stats[:total_completed]
        @data[:verified]  += stats[:total_verified]
      end
    end

    def category_in_course?(course, category)
      course.categories.where(handle: category).any?
    end
  end
end
