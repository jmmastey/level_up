FactoryGirl.define do
  factory :category do
    sequence(:name)   { |n| "Category #{n}" }
    sequence(:handle) { |n| "category_#{n}" }

    difficulty { rand(1..10) }

    sequence(:sort_order)
    hidden(false)
    association :course

    trait(:skilled) do
      after(:create) do |category|
        create_list(:skill, 4, category: category)
      end
    end
  end
end
