class User < ActiveRecord::Base
  has_many :comments
  has_many :rooms

  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

  validates :nickname, presence: true
  validates :password, :password_confirmation, presence: true

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
end
