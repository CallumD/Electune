ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

Playlist.transaction do
  Playlist.all.each do |p|
    p.update_attributes(first_play: true)
    p.playlist_items.delete_all
    p.insert_random_song
  end
end

sleep 2
path = ENV['PATH']
system({'PATH' => "#{path}:#{Rails.root}/icecast"}, "cd #{Rails.root}/icecast; ezstream -c #{Rails.root}/icecast/ezstream.xml")
