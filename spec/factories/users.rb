FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "jmmastey+factory_#{n}@gmail.com" }

    name 'Test User'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
