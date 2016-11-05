class PlaylistStackJob
  attr_accessor :playlist

  def initialize(playlist)
    self.playlist = playlist
  end

  def perform
    puts "Perform called at #{Time.current}"
    puts "playlist empty? #{playlist.playlist_items.empty?}"
    playlist.playlist_items.first.delete unless playlist.playlist_items.empty?
    puts "playlist empty? #{playlist.playlist_items.empty?}"
    unless playlist.playlist_items.empty?
      puts "setting playlist time to #{Time.current}"
      playlist.start_time = Time.current
      puts "schedulting perform to be called at #{Time.current + playlist.playlist_items.first.song.length.seconds}"
      Delayed::Job.enqueue PlaylistStackJob.new(playlist), run_at: Time.current + (playlist.playlist_items.first.song.length - 3).seconds
      playlist.save
    end
  end
end
