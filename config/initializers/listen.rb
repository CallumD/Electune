class SongFileEventHandler
  def modified(files)
  end

  def added(files)
  end

  def removed(files)
  end
end

listener = Listen.to('music', only: /\.mp3$/i) do |modified, added, removed|
  handler = SongFileEventHandler.new
  handler.modified(modified)
  handler.added(added)
  handler.removed(removed)
end

listener.start
