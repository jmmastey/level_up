module CoursesHelper
  def user_summary
    @user_summary ||= Summaries.for_user(current_user)
  end

  def category_completion(category)
    if current_user.courses.empty?
      return { total_completed: 0, total_skills: 0 }
    end

    user_summary[category.handle]
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
