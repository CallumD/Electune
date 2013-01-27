ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

loop do
  Playlist.all.each do |playlist|
    Rails.logger.info "playlist #{playlist.name} items empty? #{playlist.playlist_items.empty?}"
    result = "no work been done"
    result = playlist.tick unless playlist.playlist_items.empty?
    if playlist.playlist_items.empty?
      Rails.logger.info result
    else
      Rails.logger.info "#{result} of #{playlist.playlist_items.first.song.length}"
    end
  end
  sleep 10
end
