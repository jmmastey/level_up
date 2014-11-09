module CoursesHelper
  def course_summary_for(course, user = current_user)
    UserSummary.new(user).for_course(course)
  end

  def completion_percent_for(course, user = current_user)
    summary = course_summary_for(course, user)
    return 0 unless summary[:total] > 0

    ((summary[:completed] / summary[:total].to_f) * 100).ceil
  end
end
