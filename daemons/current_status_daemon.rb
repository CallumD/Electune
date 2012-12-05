require ENV["RAILS_ENV_PATH"]
require 'current_status'

loop {
  Playlist.all.each do |playlist|
    puts playlist.playlist_items.first.to_yaml unless playlist.playlist_items.empty?
  end

  sleep 5
}
