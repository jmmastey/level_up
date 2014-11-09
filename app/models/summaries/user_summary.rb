module Summaries
  class UserSummary
    def self.summarize(user)
      summary_data(user).each_with_object({}) do |category, hash|
        hash[category['handle']] = typecast_results_for(category)
      end
    end

    private

    def self.summary_data(user)
      connection.execute(query(user.id))
    end

    def self.query(id)
      "select e.course_id, c.id, c.name, c.handle, count(*) total_skills,
        count(cp.created_at) total_completed,
        count(cp.verified_on) total_verified
        from enrollments e
          join courses_skills cs on cs.course_id = e.course_id
          join skills s on s.id = cs.skill_id
          join categories c on c.id = s.category_id
          left join completions cp on cp.skill_id = s.id and cp.user_id = #{id}
        where e.user_id = #{id}
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
end
