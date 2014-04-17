# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    handle "MyString"
    name "MyString"
    sample_solution "MyText"

    association :category
  end
end
