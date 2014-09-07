module Summaries
  def self.for_user(user)
    return {} if user.courses.empty?
    output = user_map(user_summary_data(user))
    filter_by_enrollment(output, user)
  end

  def self.for_course(course, user)
    summary = { total: 0, completed: 0, verified: 0 }
    for_user(user).each do |category, stats|
      next unless category_in_course?(course, category)

      summary[:total]     += stats[:total_skills]
      summary[:completed] += stats[:total_completed]
      summary[:verified]  += stats[:total_verified]
    end

    summary
  end

  def self.for_category(user)
    summary     = for_user(user)
    categories  = Category.by_courses(user.courses).sorted

    categories.map do |category|
      summary[category.handle].merge(handle: category.handle)
    end
  end

  protected

  # in a long line of "forgive me" comments, fuck all of this.
  # i'm exhausted, and at least this is well factored enough
  # that I can pull it out later.
  def self.filter_by_enrollment(summary_data, user)
    categories = user.courses.map(&:categories).flatten.map(&:handle)
    summary_data.select { |key, _| categories.include? key }
  end

  def self.category_in_course?(course, category)
    course.categories.where(handle: category).any?
  end

  def self.user_summary_data(user)
    connection.execute(summary_join(user).to_sql)
  end

  def self.summary_join(user)
    Category
      .joins(:skills)
      .joins(ArelHelpers.join_association(Skill, :completions, Arel::OuterJoin))
        .project(summary_fields)
        .project(Completion[:verified_on].count.as("total_verified"))
        .project(Completion[:id].count.as("total_completed"))
        .project(Skill[:id].count.as("total_skills"))
      .where(Completion[:user_id].eq(nil).or(Completion[:user_id].eq(user.id)))
      .group(summary_fields)
      .order(:sort_order)
  end

  def self.summary_fields
    [Category[:id], Category[:name], Category[:handle]]
  end

  def self.user_map(summary)
    summary = summary.map do |cat|
      [cat['handle'], category_map(cat)]
    end
    Hash[summary]
  end

  def self.category_map(result)
    {
      id:               result['id'].to_i,
      name:             result['name'],
      handle:           result['handle'],
      total_skills:     result['total_skills'].to_i,
      total_completed:  result['total_completed'].to_i,
      total_verified:   result['total_verified'].to_i,
    }
  end

  def self.connection
    ActiveRecord::Base.connection
  end
end
