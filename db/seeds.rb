table_names = %w(users rooms)
table_names.each do |table_name|
  path = "#{Rails.root}/db/seeds/#{Rails.env}/#{table_name}.rb"
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require(path)
  end
end
