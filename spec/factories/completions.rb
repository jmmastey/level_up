FactoryGirl.define do
  factory :completion do
    association :skill
    association :user

    trait(:verified) {
      created_at  2.weeks.ago
      verified_on 1.week.ago
      association :verifier
    }
  end
end
