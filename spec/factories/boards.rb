# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:title) { |n| "boardtitle#{n}" }

  factory :board do
    title
  end
end
