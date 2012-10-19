class SongsController < ApplicationController
  def create
  	playlist = Playlist.find params["playlist_id"]
  	playlist.songs.create(params["song"])  	
    redirect_to root_path
  end
  
    def upvote        
      song = Song.find params[:id]      
      song.upvote
      redirect_to root_path
    end
    
    def vito        
      song = Song.find params[:id]      
      song.vito
      redirect_to root_path
    end
end
