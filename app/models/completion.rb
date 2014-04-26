class Completion < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :verifier

  validates_uniqueness_of :user_id, scope: :skill_id, message: "cannot complete the same skill twice"
end
