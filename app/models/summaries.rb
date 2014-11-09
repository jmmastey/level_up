module Summaries
  def self.for_user(user)
    Summaries::UserSummary.summarize(user)
  end

  def self.for_course(course, user)
    data = for_user(user).values
    data.each_with_object(completed: 0, total: 0, verified: 0) do |cat, hash|
      next unless course.id == cat[:course_id]

      hash[:completed]  += cat[:total_completed]
      hash[:total]      += cat[:total_skills]
      hash[:verified]   += cat[:total_verified]
    end
  end
end
