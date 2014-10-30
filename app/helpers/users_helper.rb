module UsersHelper
  FEED_LENGTH = 50
  FEEDABLE_OBJECTS = [Completion, Enrollment]

  def feed_items_for(user)
    objects = FEEDABLE_OBJECTS.map { |klass| klass.decorated_feed_for(user) }
    objects.flatten.take(FEED_LENGTH)
  end

  def category_progress_for(user)
    Summaries.for_user(user).values
  end
end
