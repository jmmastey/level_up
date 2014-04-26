# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    sequence(:name)   { |n| "Skill #{n}" }
    sequence(:handle) { |n| "skill_#{n}" }

    association :category
  end
end
