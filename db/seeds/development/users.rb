nicknames = %w(taro hanako hiroyuki takahumi kazuma takashi)
nicknames.each do |nickname|
  user = User.new(nickname: nickname, password: 'password')
  user.setting_password = true
  user.save!

  icons_length = Dir.glob(Rails.root.join('public/images/user_icons/user*')).size
  user.icon_number = rand(icons_length.to_i)
  user.save!
end
