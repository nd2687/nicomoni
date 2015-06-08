# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :board do
    sequence(:title) { |n| "boardtitle#{n}" }
  end
end
