# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name)   { |n| "Category #{n}" }
    sequence(:handle) { |n| "category_#{n}" }

    sequence(:sort_order)
    hidden(false)

    trait(:skilled) do
      after(:create) do |category|
        create_list(:skill, 4, category: category)
      end
    end
  end
end
