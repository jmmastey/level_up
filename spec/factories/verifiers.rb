FactoryGirl.define do

  # sucks that this isn't just user...
  factory :verifier do
    name 'Test User'
    sequence(:email) { |n| "jmmastey+vfactory_#{n}@gmail.com" }
    password 'changeme'
    password_confirmation 'changeme'
  end
end
