class PlaylistStackJob < Struct.new(:playlist)
  def perform
    puts "Perform called at #{Time.now}"
    puts "playlist empty? #{playlist.playlist_items.empty?}"
    playlist.playlist_items.first.delete unless playlist.playlist_items.empty?
    puts "playlist empty? #{playlist.playlist_items.empty?}"
    unless playlist.playlist_items.empty?
      puts "setting playlist time to #{Time.now}"
      playlist.start_time = Time.now
      puts "schedulting perform to be called at #{Time.now + playlist.playlist_items.first.song.length.seconds}"
      Delayed::Job.enqueue PlaylistStackJob.new(playlist), run_at: Time.now + (playlist.playlist_items.first.song.length-3).seconds
      playlist.save
    end
  end
end
