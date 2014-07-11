module CoursesHelper

  def category_summary
    @category_summary ||= CategorySummary.user_summary(current_user)
  end

  def course_summary_for(course)
    CategorySummary.course_summary(course, current_user)
  end

  def completion_percent_for(course)
    summary = course_summary_for(course)
    return 0 unless summary[:total] > 0

    ((summary[:completed] / summary[:total].to_f) * 100).ceil
  end

end
