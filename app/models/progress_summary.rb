class ProgressSummary

  attr_reader :enrollments, :end_date, :start_date

  def initialize(enrollments, options = {})
    @enrollments  = enrollments
    @end_date     = options.fetch(:end_date, Date.today)
    @start_date   = options.fetch(:start_date, enrollments.minimum(:created_at))
  end

  def to_a
    @enrollments.map do |enrollment|
      summarize_progress_for_enrollment(enrollment)
    end
  end

  def summarize_progress_for_enrollment(enrollment)
    { course_name: "sucka!", progress: {} }
  end
  private :summarize_progress_for_enrollment

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
