ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

loop do
  Playlist.all.each do |playlist|
    puts "playlist #{playlist.name} items empty? #{playlist.playlist_items.empty?}"
    result = "no work been done"
    result = CheckTimeAndShift.tick_on_playlist playlist.id unless playlist.playlist_items.empty?
    if playlist.playlist_items.empty?
      puts result
    else
      puts "#{result} of #{playlist.playlist_items.first.song.length}"
    end
  end
  sleep 10
end
