class Deadline < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  scope :active, -> { where(completed_on: nil, reminder_sent_at: nil) }
  scope :nearly_expired, -> { where("target_completed_on < ?", 2.days.from_now) }

  def self.estimate(material, starting = Date.today)
    starting + (material.difficulty * 2)
  end
end
