FactoryGirl.define do

  # sucks that this isn't just user...
  factory :verifier do
    sequence(:email) { |n| "jmmastey+vfactory_#{n}@gmail.com" }

    name 'Test User'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
