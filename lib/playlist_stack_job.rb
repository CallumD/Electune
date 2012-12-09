class PlaylistStackJob < Struct.new(:playlist)
  def perform
    puts "test"
    playlist.playlist_items.first.delete unless playlist.playlist_items.empty?

    unless playlist.playlist_items.empty?
      playlist.start_time = Time.now
      Delayed::Job.enqueue PlaylistStackJob.new(playlist), run_at: Time.now + playlist.playlist_items.first.song.length.seconds
      playlist.save
    end
  end
end
