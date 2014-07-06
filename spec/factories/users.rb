FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "jmmastey+factory_#{n}@gmail.com" }

    name 'Test User'
    password 'changeme'
    password_confirmation 'changeme'

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :enrolled do
      after(:create) do |instance|
        course = create(:course, :with_skills)
        Enrollment.create(course: course, user: instance)
      end
    end
  end
end
