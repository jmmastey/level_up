class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :verifier

  validates_uniqueness_of :user_id, scope: :skill_id, message: "cannot complete the same skill twice"

  scope :for_user, -> (user) { where(user_id: user.id) }
  scope :recent, -> (duration) { where("created_at > :created_at", created_at: duration) }
  scope :by_creation_date, -> { order("created_at desc") }

  def self.feed_for(user, date = 5.days.ago)
    recent(date).for_user(user).by_creation_date
  end

end
