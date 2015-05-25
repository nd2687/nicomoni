class Room < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :name, presence: true
  validates :number, presence: true

  after_initialize :set_url_token

  private

  def set_url_token
    self.url_token = self.url_token.blank? ? generate_url_token : self.url_token
  end

  def generate_url_token
    token = SecureRandom.urlsafe_base64(64)
    self.class.where(url_token: token).blank? ? token : generate_url_token
  end
end
