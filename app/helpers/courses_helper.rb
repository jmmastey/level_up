module CoursesHelper

  def user_summary
    @user_summary ||= Summaries.for_user(current_user)
  end

  def course_summary_for(course)
    Summaries.for_course(course, current_user)
  end

  def completion_percent_for(course)
    summary = course_summary_for(course)
    return 0 unless summary[:total] > 0

    ((summary[:completed] / summary[:total].to_f) * 100).ceil
  end

end
