class CategorySummary

  def self.user_summary(user)
    mapped_summary(user_summary_query(user))
  end

  def self.course_summary(course, user)
    summary = { total: 0, completed: 0, verified: 0 }
    user_summary(user).each do |category, stats|
      next unless category_in_course?(course, category)

      summary[:total]     += stats[:total_skills]
      summary[:completed] += stats[:total_completed]
      summary[:verified]  += stats[:total_verified]
    end

    summary
  end

  def self.category_summary(user)
    summary     = user_summary(user)
    categories  = Category.by_courses(user.courses).sorted

    categories.map do |category|
      summary[category.handle].merge(handle: category.handle)
    end
  end

  protected

  def self.category_in_course?(course, category)
    course.categories.where(handle: category).any?
  end

  def self.user_summary_query(user)
    categories  = Category.summarize
    skills      = Skill.summarize(categories)
    completions = Completion.summarize(skills, user)

    connection.execute(completions.to_sql)
  end

  def self.mapped_summary(summary)
    summary = summary.map do |cat|
      [cat['handle'], category_map(cat)]
    end
    Hash[summary]
  end

  def self.category_map(result)
    {
      id:               result['id'].to_i,
      name:             result['name'],
      total_skills:     result['total_skills'].to_i,
      total_completed:  result['total_completed'].to_i,
      total_verified:   result['total_verified'].to_i,
    }
  end

  def self.connection
    ActiveRecord::Base.connection
  end

end
