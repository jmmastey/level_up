module Summaries
  class CourseSummary < Summaries::Base
    def initialize(course, user)
      @data = { total: 0, completed: 0, verified: 0 }
      @course = course
      summarize_for(user)
    end

    private

    def summarize_for(user)
      user_summary(user).each do |category, stats|
        next unless category_in_course?(category)

        @data[:total]     += stats[:total_skills]
        @data[:completed] += stats[:total_completed]
        @data[:verified]  += stats[:total_verified]
      end
    end

    def category_in_course?(category)
      course_categories.include? category
    end

    def course_categories
      @course_categories ||= @course.categories.map(&:handle)
    end
  end
end
