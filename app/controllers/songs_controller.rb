class SongsController < ApplicationController
  def create
    playlist_to_assign = Playlist.find params["song"]["playlist"]
    song_name = params["song"]["name"]
    song = Song.new name: song_name, playlist: playlist_to_assign
    song.save
    redirect_to root_path, flash: { error:           song.errors.full_messages.join("\n")
}
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
