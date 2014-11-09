module Summaries
  class CourseSummary
    def self.summarize(course, user)
      data = summary_data(course, user)
      data.each_with_object({}) do |(key, value), hash|
        hash[key.to_sym] = value.to_i
      end
    end

    private

    def self.summary_data(course, user)
      query = query(course, user)
      connection.execute(query).first
    end

    def self.query(course, user)
      "select count(c.updated_at) completed, count(*) total,
          count(c.verified_on) verified
        from courses_skills cs
        join skills s on s.id = cs.skill_id
        left join completions c on c.user_id = #{user.id}
          and c.skill_id = cs.skill_id
        where cs.course_id = #{course.id}"
    end

    def self.connection
      ActiveRecord::Base.connection
    end
  end
end
