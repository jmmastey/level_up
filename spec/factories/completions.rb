# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :completion do
    association :user
    association :skill
    association :verifier
  end
end
