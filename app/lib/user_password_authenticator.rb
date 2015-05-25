class UserPasswordAuthenticator
  class << self
    def verify(nickname, password)
      return false unless nickname.present? && password.present?
      user = User.find_by_nickname(nickname)
      user && user.authenticate(password)
    end
  end
end
