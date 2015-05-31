titles = %w(最近流行りの 地震がきたぞ ニコ生速報)

titles.each do |title|
  Board.create(title: title)
end

comments = %w(まじか まじでか 確かに わろたwwww 草 それは違う すげえ)

Board.all.each do |board|
  20.times do
    board.responses.create(name: User.pluck(:nickname).sample, comment: comments.sample)
  end
end
