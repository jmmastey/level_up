class Completion < ActiveRecord::Base
  include Feedable

  belongs_to :user, touch: true
  belongs_to :skill

  validates_uniqueness_of :user_id, scope: :skill_id, message: "cannot complete the same skill twice"

  def self.decorate_feed_item(item)
    {
      label: "Completed '#{item.skill.name}'",
      tags: [:skill, :completed, item.skill.handle],
      item: item,
    }
  end

  def self.summarize(skills, user)
    table = self.arel_table
    skill_table = Skill.arel_table

    completion = table[:skill_id].eq(skill_table[:id]).and(table[:user_id].eq user.id)
    skills.join(table, Arel::Nodes::OuterJoin).on(completion)
      .project(table[:verified_on].count.as("total_verified"))
      .project(table[:id].count.as("total_completed"))
  end

end
