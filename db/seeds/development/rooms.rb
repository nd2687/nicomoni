User.all.each do |user|
  room = user.rooms.new(name: "#{user.nickname}のRoom", number: rand(10))
  room.owner_id = user.id
  room.save!
end
