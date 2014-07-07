class Enrollment < ActiveRecord::Base
  include Feedable

  belongs_to :user, touch: true
  belongs_to :course

  validates_uniqueness_of :user_id, scope: :course_id, message: "cannot register for the same course twice"

  def self.decorate_feed_item(item)
    {
      label: "Enrolled in '#{item.course.name}'",
      tags: [:course, :enrolled, item.course.handle],
      item: item,
    }
  end

end
