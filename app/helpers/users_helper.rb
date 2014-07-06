module UsersHelper

  FEEDABLE_OBJECTS = [ Completion ]

  def category_progress
    summary = CategorySummary.summarize_user(user)
    categories = enrolled_courses.map { |c| Category.visible_categories_for(c) }.flatten

    categories.map do |category|
      summary[category.handle].merge(handle: category.handle)
    end
  end

  def user_feed_items
    FEEDABLE_OBJECTS.map { |klass| klass.feed_for(user) }.flatten
  end

  private

  def render_feed_item(item)
    send "render_#{item_klass(item)}_feed_item", item
  end

  def feed_item_tags(item)
    send "#{item_klass(item)}_tags", item
  end

  def item_klass(item)
    item.class.to_s.downcase
  end

  def enrolled_courses
    @enrolled ||= current_user.courses
  end

  def render_completion_feed_item(completion)
    "Completed '#{completion.skill.name}'"
  end

  def completion_tags(completion)
    ["skill", "completed", completion.skill.handle]
  end

end
