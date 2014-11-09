module Summaries
  def self.for_user(user)
    Summaries::UserSummary.new(user).to_h
  end

  def self.for_course(course, user)
    Summaries::CourseSummary.new(course, user).to_h
  end
end
