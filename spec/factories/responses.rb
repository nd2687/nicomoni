# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :response do
    board
    sequence(:name) { |n| "resname#{n}" }
    sequence(:comment) { |n| "comment#{n}" }
  end
end
