FactoryGirl.define do
  sequence(:nickname) { |n| "testname#{n}" }

  factory :user do
    nickname
    password 'password'
    setting_password true
  end
end
