module CoursesHelper
  def completion_percent_for(summary)
    return 0 unless summary[:total] > 0
    ((summary[:completed] / summary[:total].to_f) * 100).ceil
  end
end
