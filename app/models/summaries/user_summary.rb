module Summaries
  class UserSummary < Summaries::Base
    def initialize(user)
      super

      return if user.courses.empty?
      output  = user_map(user_summary_data(user))
      @data   = filter_by_enrollment(output, user)
    end

    private

    def user_map(summary)
      Hash[summary.map { |cat| [cat['handle'], category_map(cat)] }]
    end

    # in a long line of "forgive me" comments, fuck all of this.
    # i'm exhausted, and at least this is well factored enough
    # that I can pull it out later.
    def filter_by_enrollment(summary_data, user)
      categories = user.courses.map(&:categories).flatten.map(&:handle)
      summary_data.select { |key, _| categories.include? key }
    end

    def user_summary_data(user)
      connection.execute(summary_join(user).to_sql)
    end

    def summary_join(user)
      summary_tables(user).project(summary_fields)
        .project(Completion[:verified_on].count.as("total_verified"))
        .project(Completion[:id].count.as("total_completed"))
        .project(Skill[:id].count.as("total_skills"))
      .group(summary_fields).order(:sort_order)
    end

    def summary_tables(user)
      outer = ArelHelpers.join_association(Skill, :completions, Arel::OuterJoin)
      Category
        .joins(:skills)
        .joins(outer) { |_, cond| cond.and(Completion[:user_id].eq(user.id)) }
    end

    def summary_fields
      [Category[:id], Category[:name], Category[:handle]]
    end

    def category_map(result)
      { id:               result['id'].to_i,
        name:             result['name'],
        handle:           result['handle'],
        total_skills:     result['total_skills'].to_i,
        total_completed:  result['total_completed'].to_i,
        total_verified:   result['total_verified'].to_i,
      }
    end
  end
end
