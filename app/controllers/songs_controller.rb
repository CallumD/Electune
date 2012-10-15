class SongsController < ApplicationController
  def create
    song = Song.new params["song"]
    song.playlist = Playlist.find_by_name "Default"
    song.save
    redirect_to root_path, flash: { error:      song.errors.full_messages.join("\n")
}
  end
  
    def upvote        
      song = Song.find params[:song]
      song.upvote
      song.save
    redirect_to "nowhere"
    end
end
