module UsersHelper

  FEEDABLE_OBJECTS = [ Skill ]

  def user_category_summary
    Category.summarize_user(user)
  end

  def user_feed_items
    FEEDABLE_OBJECTS.map { |klass| klass.feed_for(user) }.flatten
  end

  def render_feed_item(item)
    send "render_#{item_klass(item)}_feed_item", item
  end

  def feed_item_tags(item)
    send "#{item_klass(item)}_tags", item
  end

  def item_klass(item)
    item.class.to_s.downcase
  end

  protected

  def render_skill_feed_item(skill)
    "Completed #{skill.name}"
  end

  def skill_tags(skill)
    ["skill", "completed", skill.handle]
  end

end
