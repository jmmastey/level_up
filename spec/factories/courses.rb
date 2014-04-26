# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:name)   { |n| "Course #{n}" }
    sequence(:handle) { |n| "course_#{n}" }

    trait(:published) { status :published }
    trait(:created)   { status :created }
  end
end
