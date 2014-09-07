# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:name)   { |n| "Course #{n}" }
    sequence(:handle) { |n| "course_#{n}" }
    status :approved

    trait(:published) { status :published }
    trait(:created)   { status :created }

    trait(:with_skills) do
      skills { create_list(:skill, 5) }
    end
  end
end
