module UsersHelper

  def category_progress
    summary = CategorySummary.summarize_user(user)
    categories = enrolled_courses.map { |c| Category.visible_categories_for(c) }.flatten

    categories.map do |category|
      summary[category.handle].merge(handle: category.handle)
    end
  end

  FEEDABLE_OBJECTS = [ Completion, Enrollment ]

  def user_feed_items
    FEEDABLE_OBJECTS.map { |klass| klass.decorated_feed_for(user) }.flatten
  end

  private

  def enrolled_courses
    @enrolled ||= current_user.courses
  end

end
