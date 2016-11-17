listener = Listen.to("#{Rails.root}/music", only: /\.mp3$/i) do |modified, added, removed|
  handler = SongFileEventHandler.new
  handler.added(added)
  handler.removed(removed)
end

listener.start
