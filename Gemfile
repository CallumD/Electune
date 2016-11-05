source 'https://rubygems.org'

gem 'daemons'
gem 'delayed_job_active_record'
gem 'rails', '3.2.11'
gem 'coffee-rails', '~> 3.2.1'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'bootstrap-sass', '~> 2.2.2.0'
gem 'humane-rails', '~> 3.0.5.0.1.5'
gem 'sprockets-rails', '~> 0'

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'mysql2'
  gem 'passenger'
end

group :test do
  gem 'launchy'
end

group :development do
  gem 'capistrano'
  gem 'rb-inotify', '~> 0.8.8' if RUBY_PLATFORM.downcase.include?('linux')
  gem 'rubocop'
end

group :development, :test do
  gem 'capybara', '1.1.2'
  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'sqlite3'
end
