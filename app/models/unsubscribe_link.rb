class UnsubscribeLink < ActiveRecord::Base
  belongs_to :user

  def self.for_user(user)
    where(user: user).first_or_create do |link|
      link.token = SecureRandom.uuid
    end
  end
end
