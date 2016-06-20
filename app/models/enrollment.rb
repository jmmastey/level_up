class Enrollment < ActiveRecord::Base
  include Feedable

  belongs_to :user, touch: true
  belongs_to :course

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates_uniqueness_of :user_id, scope: :course_id,
                          message: "cannot register for the same course twice"

  def self.decorate_feed_item(item)
    {
      label: "Enrolled in '#{item.course.name}'",
      tags: [:course, :enrolled, item.course.handle],
      item: item,
    }
  end

  def self.enrollment_date(user, course)
    where(course: course, user: user)
      .pluck(:created_at).first
  end
end
