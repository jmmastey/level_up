class Completion < ActiveRecord::Base
  include Feedable

  belongs_to :user, touch: true
  belongs_to :skill
  belongs_to :verifier

  validates_uniqueness_of :user_id, scope: :skill_id, message: "cannot complete the same skill twice"

  def self.decorate_feed_item(item)
    {
      label: "Completed '#{item.skill.name}'",
      tags: [:skill, :completed, item.skill.handle],
      item: item,
    }
  end

end
