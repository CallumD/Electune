class SongsController < ApplicationController
  def create
    song = Song.new params["song"]
    song.playlist = Playlist.find_by_name "Default"
    song.save
    redirect_to root_path, flash: { error:      song.errors.full_messages.join("\n")
}
  end
  
    def upvote        
      song = Song.find params[:id]
      playlist = Playlist.find_by_name "Default" 
      playlist.upvote song
      redirect_to root_path
    end
    
    def vito        
      song = Song.find params[:id]
      playlist = Playlist.find_by_name "Default" 
      playlist.vito song
      redirect_to root_path
    end
end
