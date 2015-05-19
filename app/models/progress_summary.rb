class ProgressSummary
  attr_reader :enrollments, :end_date, :start_date

  def initialize(enrollments, options = {})
    @enrollments = enrollments
    @end_date = as_date(options.fetch(:end_date, Date.today))
    @start_date = as_date(options.fetch(:start_date, first_enrollment))
  end

  def to_a
    @enrollments.map do |enrollment|
      summarize_progress_for_enrollment(enrollment)
    end
  end

  def first_enrollment
    enrollments.minimum(:created_at)
  end
  private :first_enrollment

  def summarize_progress_for_enrollment(enrollment)
    { course_name: enrollment.course.name,
      progress: progress_burndown(enrollment) }
  end
  private :summarize_progress_for_enrollment

  def as_date(val)
    return val if val.is_a? Date
    return val.to_date if val.respond_to? :to_date
    return Date.parse(val) if val.is_a? String
    fail ArgumentError
  end
  private :as_date

  def progress_burndown(enrollment)
    skills_left = enrollment.course.skills.count
    completions = completions(enrollment)

    start_date.upto(end_date).each_with_object({}) do |date, hash|
      skills_left -= completions[date].length if completions[date]
      hash[date] = skills_left
    end
  end
  private :progress_burndown

  def completions(enrollment)
    Completion.for_course(enrollment.user, enrollment.course)
      .pluck(:created_at, :id)
      .group_by { |c| as_date(c.first) }
  end

  #
  # [
  #   {
  #     course_name: '',
  #     progress: {
  #       '2015-01-01' : 50,
  #       '2015-01-02' : 48,
  #     }
  #   },
  #   ...
  # ]
  #
end
