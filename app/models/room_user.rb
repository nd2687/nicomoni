# == Schema Information
#
# Table name: room_users
#
#  id         :integer          not null, primary key
#  room_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoomUser < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  after_save do
    self.room.enter
  end
end
