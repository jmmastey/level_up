FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "jmmastey+factory_#{n}@gmail.com" }

    sequence(:name) { |n| "Test User#{n}" }
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

    trait :skilled do
      after(:create) do |instance|
        create_list(:completion, 2, user: instance)
      end
    end
  end
end
