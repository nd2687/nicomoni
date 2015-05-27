nicknames = %w(taro hanako hiroyuki takahumi kazuma takashi)
nicknames.each do |nickname|
  user = User.new(nickname: nickname, password: 'password')
  user.setting_password = true
  user.save!
end
