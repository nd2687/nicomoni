# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  nickname        :string(255)      not null
#  password_digest :string(255)      not null
#  room_url_token  :string(255)
#  icon_number     :integer          default(1), not null
#  lastlogin       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :comments
  has_many :room_users
  has_many :rooms, :through => :room_users
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :followerships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :followers, :through => :followerships, :source => :user

  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

  validates :nickname, presence: true
  validates :password, confirmation: true, presence: true, on: :create

  before_save do
    if setting_password?
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def authenticate(raw_password)
    if password_digest && BCrypt::Password.new(password_digest) == raw_password
      self
    else
      false
    end
  end

  def active_room?
    self.rooms.where(deletable: false).count > 0 ? true : false
  end

  def active_room
    self.rooms.where(deletable: false).first
  end

  def owner?(room)
    room.owner == self ? true : false
  end

  def friend?(user)
    if friends.include?(user)
      true
    else
      false
    end
  end

  def follower?(user)
    if followers.include?(user)
      true
    else
      false
    end
  end
end
