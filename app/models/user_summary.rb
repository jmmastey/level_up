class UserSummary
  def initialize(user)
    @user = user
  end

  def for_user
    @for_user ||= summary_data.map { |category| typecast_results_for(category) }
  end

  def for_category(category)
    for_user.find { |data| category.handle == data[:handle] }
  end

  def for_course(course)
    for_user.each_with_object(completed: 0, total: 0, verified: 0) do |c, hash|
      next unless course.id == c[:course_id]

      hash[:completed]  += c[:total_completed]
      hash[:total]      += c[:total_skills]
      hash[:verified]   += c[:total_verified]
    end
  end

  private

  def summary_data
    connection.execute(summary_query)
  end

  def summary_query
    "select e.course_id, c.id, c.name, c.handle, count(*) total_skills,
      count(cp.created_at) total_completed,
      count(cp.verified_on) total_verified
      from enrollments e
        join categories c on c.course_id = e.course_id
        join skills s on s.category_id = c.id
        left join completions cp on cp.skill_id = s.id and
          cp.user_id = #{@user.id}
      where e.user_id = #{@user.id} and c.hidden = 'f'
      group by e.course_id, c.id, c.handle, sort_order
      order by sort_order"
  end

  def typecast_results_for(category)
    { id:               category['id'].to_i,
      name:             category['name'],
      handle:           category['handle'],
      course_id:        category['course_id'].to_i,
      total_skills:     category['total_skills'].to_i,
      total_completed:  category['total_completed'].to_i,
      total_verified:   category['total_verified'].to_i }
  end

  def connection
    ActiveRecord::Base.connection
  end
end
