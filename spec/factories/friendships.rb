# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship do
    user { create(:user) }
    friend { create(:user) }
  end
end
