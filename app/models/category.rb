class Category < ActiveRecord::Base
  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  has_many :skills

  # so... wtf arel? this is more readable? in what fucking universe...
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

    result = connection.execute(query.to_sql)
    self.map_summary(result)
  end

  protected

  def self.map_summary(summary)
    summary.inject({}) do |h,result|
      h[result['handle']] = {
        id:               result['id'].to_i,
        name:             result['name'],
        total_skills:     result['total_skills'].to_i,
        total_completed:  result['total_completed'].to_i,
        total_verified:   result['total_verified'].to_i,
      }
      h
    end
  end
end
