module CoursesHelper
  def completion_summary_for(course, user = current_user)
    summary = user.summary.for_course(course)
    "#{summary[:completed]} of #{summary[:total]} skills completed"
  end

  def completion_percent_for(course, user = current_user)
    summary = user.summary.for_course(course)
    summary.fetch(:completed_percent, 0).ceil
  end
end
