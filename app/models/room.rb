class Room < ActiveRecord::Base
  has_many :room_users
  has_many :users, :through => :room_users
  has_many :comments
  belongs_to :owner, :class_name => "User"
  has_many :broadcasts

  validates :name, presence: true
  validates :number, presence: true,
    numericality: {
      only_integer: true, greater_than_or_equal_to: 2
    }

  scope :published, -> { where(deletable: false, private: false) }

  after_initialize :set_url_token

  after_save do
    self.room_users.destroy_all if deletable == true
  end

  def enter
    if active_number < number
      increment! :active_number
      if self.active_number == self.number && self.number == self.room_users.count
        self.update(full: true)
      end
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
