# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:name)   { |n| "Course #{n}" }
    sequence(:handle) { |n| "course_#{n}" }
    status :approved

    trait(:published) { status :published }
    trait(:created)   { status :created }

    trait(:with_related_category) do
      categories { [create(:category, :skilled, name: name, handle: handle)] }
    end

    trait(:with_skills) do
      categories { create_list(:category, 2, :skilled) }
    end
  end
end
