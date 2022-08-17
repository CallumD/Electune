source 'https://rubygems.org'
gem 'webrick', '~> 1.7'
gem 'daemons'
gem 'json'
gem 'rails', '~> 7'
gem 'rails-observers'
gem 'coffee-script'
gem 'jquery-rails'
gem 'bcrypt'
gem "sassc-rails"
gem "bootstrap"
gem 'humane-rails'
gem 'ruby-mp3info'
gem 'sqlite3'

# Monitoring for music files
gem 'listen', '~> 3.0'

group :production do
  gem 'passenger'
end

group :test do
  gem 'launchy'
  gem 'pg'
  gem 'rails-controller-testing'
end

group :development do
  gem 'rubocop'
  gem 'pry'
end

group :development, :test do
  gem 'capybara', '2.10.1'
  gem 'spork', :github => 'sporkrb/spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

gem "importmap-rails", "~> 1.1"
