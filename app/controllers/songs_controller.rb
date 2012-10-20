class SongsController < ApplicationController
  def create
  	playlist = Playlist.find params["playlist_id"]
  	playlist.songs.create(params["song"])  	
    redirect_to root_path
  end
  
    def upvote        
      song = Song.find params[:id]      
      song.upvote
      respond_to do |format|
        format.json { render :json => song.votes }
      end
    end
    
    def veto        
     song = Song.find params[:id]      
     song.veto
     respond_to do |format|
        format.json { render :json => song.votes }
      end
    end
end
