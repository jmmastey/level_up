module Feedable
  extend ActiveSupport::Concern

  included do
    scope :for_user, ->(user) { where(user_id: user.id) }
    scope :recent, -> { where("created_at > :at", at: 2.weeks.ago) }
    scope :by_creation_date, -> { order("created_at desc") }
  end

  module ClassMethods
    def feed_for(user)
      recent.for_user(user).by_creation_date
    end

    def decorated_feed_for(user)
      feed_for(user).map { |item| decorate_feed_item(item) }
    end

    def decorate_feed_item(item)
      {
        label: "Not implemented label.",
        tags: [:not_implemented],
        item: item,
      }
    end
  end
end
