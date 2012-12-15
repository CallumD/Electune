ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

loop do
  puts Playlist.first.name
  puts "hello world!"
  sleep 10
end
