class Completion < ActiveRecord::Base
  include ArelHelpers::ArelTable
  include Feedable

  belongs_to :user, touch: true
  belongs_to :skill

  validates_uniqueness_of :user_id, scope: :skill_id,
                          message: "cannot complete the same skill twice"

  def self.for(user, skill)
    find_by(user: user, skill: skill)
  end

  def self.for!(user, skill)
    self.for(user, skill) || fail(RecordNotFoundError)
  end

  def self.user_skills(user)
    where(user: user).pluck(:skill_id)
  end

  def self.decorate_feed_item(item)
    {
      label: "Completed '#{item.skill.name}'",
      tags: [:skill, :completed, "skill-#{item.skill.handle}"],
      item: item,
    }
  end
end
