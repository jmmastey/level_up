FactoryGirl.define do

  factory :user do
    name 'Test User'
    sequence(:email) { |n| "jmmastey+factory_#{n}@gmail.com" }
    password 'changeme'
    password_confirmation 'changeme'
  end
end
