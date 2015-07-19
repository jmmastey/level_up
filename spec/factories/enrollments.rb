FactoryGirl.define do
  factory :enrollment do
    association :user
    association :course

    created_at { Date.today - rand(1..20) }
  end
end
