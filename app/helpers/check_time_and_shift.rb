module CheckTimeAndShift
  def self.tick_on_playlist id
    playlist = Playlist.find id
    if Time.now > playlist.start_time + playlist.playlist_items.first.song.length.to_f
     playlist.update_attributes(start_time: (playlist.start_time + playlist.playlist_items.first.song.length))
     playlist.shift
    end
    Time.now - playlist.start_time
  end
end
