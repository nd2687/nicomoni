source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '4.2.1'
gem 'mysql2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bcrypt', "~> 3.1.7"

gem 'react-rails', '~> 1.0'

gem 'niconico', :github => 'totoman/niconico', :branch => 'external'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'capistrano', '~> 3.2.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano3-unicorn', '~> 0.2.1', require: false
end

group :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'capybara', '~> 2.4.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'launchy'
end

group :production do
  gem 'unicorn', '~> 4.8.3'
end
