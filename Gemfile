source 'https://rubygems.org'

gem 'daemons'
gem 'rails', '4.2.7'
gem 'rails-observers'
gem 'coffee-rails', '~> 4.2.1'
gem 'jquery-rails'
gem 'bcrypt'
gem 'bootstrap-sass', '~> 2.2.2.0'
gem 'humane-rails', '~> 5.1.0'
gem 'sprockets-rails', '~> 3.2.0'
gem 'ruby-mp3info'
gem 'thin'
gem 'mysql2'

# Monitoring for music files
gem 'listen', '~> 3.0'

group :assets do
  gem 'sass-rails', '5.0.6'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'passenger'
end

group :test do
  gem 'launchy'
  gem 'pg'
end

group :development do
  # gem 'rb-inotify', '~> 0.9.7' if RUBY_PLATFORM.downcase.include?('linux')
  gem 'rubocop'
  gem 'pry'
end

group :development, :test do
  gem 'capybara', '2.10.1'
  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'sqlite3'
end
