module Summaries
  def self.for_user(user)
    return unless user.signed_in?

    summary_data(user).each_with_object({}) do |category, hash|
      hash[category['handle']] = typecast_results_for(category)
    end
  end

  def self.for_course(course, user)
    data = for_user(user).values
    data.each_with_object(completed: 0, total: 0, verified: 0) do |cat, hash|
      next unless course.id == cat[:course_id]

      hash[:completed]  += cat[:total_completed]
      hash[:total]      += cat[:total_skills]
      hash[:verified]   += cat[:total_verified]
    end
  end

  private

  def self.summary_data(user)
    connection.execute(summary_query(user.id))
  end

  def self.summary_query(user_id)
    "select e.course_id, c.id, c.name, c.handle, count(*) total_skills,
      count(cp.created_at) total_completed,
      count(cp.verified_on) total_verified
      from enrollments e
        join courses_skills cs on cs.course_id = e.course_id
        join skills s on s.id = cs.skill_id
        join categories c on c.id = s.category_id
        left join completions cp on cp.skill_id = s.id and
          cp.user_id = #{user_id}
      where e.user_id = #{user_id}
      group by e.course_id, c.id, c.handle, sort_order
      order by sort_order"
  end

  def self.typecast_results_for(category)
    { id:               category['id'].to_i,
      name:             category['name'],
      handle:           category['handle'],
      course_id:        category['course_id'].to_i,
      total_skills:     category['total_skills'].to_i,
      total_completed:  category['total_completed'].to_i,
      total_verified:   category['total_verified'].to_i,
    }
  end

  def self.connection
    ActiveRecord::Base.connection
  end
end
