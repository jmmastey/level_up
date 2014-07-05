class CategorySummary < Category

  # so... wtf arel? this is more readable? in what fucking universe...
  # also, coupling so hard to user / skill / completion is not great.
  def self.summarize_user(user)
    c   = Arel::Table.new(:categories)
    s   = Arel::Table.new(:skills)
    cp  = Arel::Table.new(:completions)

    query = c.project(c[:id], c[:name], c[:handle])
      .project(s[:id].count.as("total_skills"))
      .project(cp[:id].count.as("total_completed"))
      .project(cp[:verified_on].count.as("total_verified"))
      .join(s).on(s[:category_id].eq c[:id])
      .join(cp, Arel::Nodes::OuterJoin).on(cp[:skill_id].eq s[:id])
      .where(cp[:user_id].eq(user.id).or(cp[:user_id].eq nil))
      .group(c[:id], c[:name], c[:handle])
      .order(c[:sort_order])

    result = connection.execute(query.to_sql)
    self.map_summary(result)
  end

  def self.summarize_course(course, user_summary)
    categories = course.categories.map(&:handle)
    summary = { total: 0, completed: 0, verified: 0 }
    user_summary.map do |handle, stats|
      next unless categories.include? handle

      summary[:total] += stats[:total_skills]
      summary[:completed] += stats[:total_completed]
      summary[:verified] += stats[:total_verified]
    end

    summary
  end

  protected

  def self.map_summary(summary)
    summary.inject({}) do |h,result|
      h.update(result['handle'] =>  map_row(result))
    end
  end

  def self.map_row(result)
    {
      id:               result['id'].to_i,
      name:             result['name'],
      total_skills:     result['total_skills'].to_i,
      total_completed:  result['total_completed'].to_i,
      total_verified:   result['total_verified'].to_i,
    }
  end

end
