class SongsController < ApplicationController
  def create
  	playlist = Playlist.find params["playlist_id"]
  	@song = playlist.songs.create(params["song"])  	   
  end
  
  def upvote        
    @song = Song.find params[:id]
    @song.upvote
  end
    
  def veto        
		@song = Song.find params[:id]      
		@song.veto
	end
end

