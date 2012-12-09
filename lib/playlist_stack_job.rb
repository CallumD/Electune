class PlaylistStackJob < Struct.new(:playlist)
  def perform
    playlist.pop unless playlist.empty?

    unless playlist.empty?
      playlist.start_time = Time.now
      Delayed::Job.enqueue PlaylistStackJob.new(playlist), Time.now + playlist.first.song.length
    end
  end
end
