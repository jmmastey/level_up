module Summaries
  def self.for_user(user)
    Summaries::UserSummary.summarize(user)
  end

  def self.for_course(course, user)
    Summaries::CourseSummary.summarize(course, user)
  end
end
