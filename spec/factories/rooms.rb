FactoryGirl.define do
  sequence(:name) { |n| "room-name-#{n}" }

  factory :room do
    name
    number 5
    owner { FactoryGirl.create :user }

    after(:create) do |room|
      create(:room_user, room: room, user: create(:user))
    end
  end
end
