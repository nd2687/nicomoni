class Room < ActiveRecord::Base
  has_many :room_users
  has_many :users, :through => :room_users
  has_many :comments

  validates :name, presence: true
  validates :number, presence: true

  scope :published, -> { where(deletable: false, private: false) }

  after_initialize :set_url_token

  def enter
    if active_number < number
      increment! :active_number
      self.update(full: true) if self.active_number == self.number
    end
  end

  def exit
    if active_number <= number
      decrement! :active_number
      self.update(full: false) unless self.active_number == self.number
    end
  end

  def owner
    User.find(owner_id)
  end

  def owner_name
    owner.nickname
  end

  private

  def set_url_token
    self.url_token = self.url_token.blank? ? generate_url_token : self.url_token
  end

  def generate_url_token
    token = SecureRandom.urlsafe_base64(40)
    self.class.where(url_token: token).blank? ? token : generate_url_token
  end
end
