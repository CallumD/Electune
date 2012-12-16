ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

loop do
  Playlist.all.each do |playlist|
    CheckTimeAndShift.tick_on_playlist playlist.id unless playlist.playlist_items.empty?
  end
  sleep 10
end
