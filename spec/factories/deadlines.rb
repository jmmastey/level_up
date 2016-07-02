FactoryGirl.define do
  factory :deadline do
    target_completed_on { 4.days.ago }

    association :user
    association :category
  end
end
