# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enrollment do
    association :user
    association :course

    created_at { Date.today - rand(1..20) }
  end
end
