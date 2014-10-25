module Summaries
  class UserSummary < Summaries::Base
    def initialize(user)
      return if user.courses.empty?

      @user   = user
      @data   = filter_by_enrollment(user_summary_data)
    end

    private

    def filter_by_enrollment(summary_data)
      summary_data.each_with_object({}) do |category, hash|
        next unless user_categories.include? category['handle']
        hash[category['handle']] = typecast_results_for(category)
      end
    end

    def user_categories
      @user_categories ||= @user.courses.map(&:categories).flatten.map(&:handle)
    end

    def user_summary_data
      connection.execute(selected_user_stats.to_sql)
    end

    # it's just like a big SQL query, but harder to read!
    def selected_user_stats
      joined_tables
        .project([Category[:id], Category[:name], Category[:handle]])
        .project(Completion[:verified_on].count.as("total_verified"))
        .project(Completion[:id].count.as("total_completed"))
        .project(Skill[:id].count.as("total_skills"))
      .group(Category[:id], Category[:name], Category[:handle])
      .order(:sort_order)
    end

    def joined_tables
      # adds a filter for user_id. impressive how hard this is.
      filter  = ->(_, cond) { cond.and(Completion[:user_id].eq(@user.id)) }
      outer   = Skill.join_association(:completions, Arel::OuterJoin, &filter)

      Category.joins(:skills).joins(outer)
    end

    def typecast_results_for(category)
      { id:               category['id'].to_i,
        name:             category['name'],
        handle:           category['handle'],
        total_skills:     category['total_skills'].to_i,
        total_completed:  category['total_completed'].to_i,
        total_verified:   category['total_verified'].to_i,
      }
    end
  end
end
