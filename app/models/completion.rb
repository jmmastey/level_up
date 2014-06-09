class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :verifier

  validates_uniqueness_of :user_id, scope: :skill_id, message: "cannot complete the same skill twice"

  scope :for_user, -> (user) { where(user_id: user.id) }

  def self.feed_for(user, duration = 5.days.ago)
    for_user(user).where("created_at > :created_at", created_at: duration)
  end
end
