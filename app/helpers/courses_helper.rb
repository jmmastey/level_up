module CoursesHelper
  def completion_summary_for(course, user = current_user)
    summary = user.summary.for_course(course)
    "#{summary[:completed]} of #{summary[:total]} skills completed"
  end

  def completion_percent_for(course, user = current_user)
    summary = user.summary.for_course(course)

    return 0 unless summary[:total] > 0
    ((summary[:completed] / summary[:total].to_f) * 100).ceil
  end
end
