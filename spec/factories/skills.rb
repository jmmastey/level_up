FactoryGirl.define do
  factory :skill do
    sequence(:name)   { |n| "Skill #{n}" }
    sequence(:handle) { |n| "skill_#{n}" }

    association :category
  end
end
