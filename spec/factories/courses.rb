# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    sequence(:handle) { |n| "course_#{n}" }
  end

  factory :published_course, class: Course do
    sequence(:name) { |n| "Published Course #{n}" }
    sequence(:handle) { |n| "published_course_#{n}" }
    status :published
  end
end
