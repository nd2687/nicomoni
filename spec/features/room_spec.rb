require 'rails_helper'

feature 'check process of Room' do
  include FeaturesSpecHelper
  let!(:owner) { create(:user) }
  let!(:user) { create(:user) }
  let!(:room1) { create(:room) }
  let!(:room2) { create(:room, owner: owner) }
  let!(:room_user) { create(:room_user, user: owner, room: room2)}


  scenario '入室=>インクリメント、RoomUser作成 : 退室=>デクリメント、削除' do
    login(user)
    visit rooms_path
    room_user_count = RoomUser.count
    first(:link, "このRoomへ行く").click
    expect(incremented = room_user_count + 1).to eq(RoomUser.count)
    expect(RoomUser.last.user).to eq(user)

    room_count = Room.count
    click_on '退室'
    expect(incremented - 1).to eq(RoomUser.count)
    expect(Room.count).to eq(room_count)
  end

  scenario 'ownerがRoomを削除=>RoomUser全て削除' do
    login(owner)
    visit rooms_path
    room_user_count = RoomUser.count
    click_link "Roomへ戻る"
    expect(RoomUser.count).to eq(room_user_count)
    click_on "Roomを削除する"
    expect(owner.room_users.count).to eq(0)
  end
end
