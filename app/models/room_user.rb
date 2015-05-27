class RoomUser < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

  after_save do
    self.room.enter
  end
end
