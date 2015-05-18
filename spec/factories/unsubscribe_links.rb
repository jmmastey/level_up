FactoryGirl.define do
  factory :unsubscribe_link do
    token { SecureRandom.uuid }

    association :user
  end
end
