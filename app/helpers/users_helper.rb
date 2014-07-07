module UsersHelper

  FEED_LENGTH = 10

  def category_progress_for(user)
    summary = CategorySummary.summarize_user(user)
    categories = user.courses.map { |c| Category.visible_categories_for(c) }.flatten

    categories.map do |category|
      summary[category.handle].merge(handle: category.handle)
    end
  end

  FEEDABLE_OBJECTS = [ Completion, Enrollment ]

  def feed_items_for(user)
    objects = FEEDABLE_OBJECTS.map { |klass| klass.decorated_feed_for(user) }
    objects.flatten.take(FEED_LENGTH)
  end

end
