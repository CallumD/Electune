source 'https://rubygems.org'

gem "daemons"
gem 'delayed_job_active_record'
gem 'rails', '3.2.11'
gem 'coffee-rails', '~> 3.2.1'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'bootstrap-sass'
gem "humane-rails"
gem 'libv8', '3.11.8.4'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'therubyracer', '0.11.0', :platform => :ruby
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
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-inotify', '~> 0.8.8'
  gem 'capistrano'
  gem 'debugger'
  gem 'rb-inotify', '~> 0.8.8'
end

group :development, :test do
  gem 'capybara', '1.1.2'
  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'sqlite3'
end
