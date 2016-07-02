class Completion < ActiveRecord::Base
  include Feedable

  belongs_to :user, touch: true
  belongs_to :skill

  validates :skill_id, presence: true
  validates_uniqueness_of :user_id, scope: :skill_id,
                          message: "cannot complete the same skill twice"

  scope :by_id, -> { order("id desc") }

  def self.for_category(user, category)
    Completion.joins(:skill)
              .where(user: user)
              .where(skills: { category_id: category })
              .by_id
  end

  def self.for_course(user, course)
    Completion.where("user_id = ? and skill_id in
      (select s.id from skills s, categories c
      where s.category_id = c.id and c.course_id = ?)",
      user.id, course.id)
  end

  def self.for(user, skill)
    find_by(user: user, skill: skill)
  end

  def self.for!(user, skill)
    self.for(user, skill) || raise(ActiveRecord::RecordNotFound)
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
