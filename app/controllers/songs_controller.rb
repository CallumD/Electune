class SongsController < ApplicationController
  def create
  	playlist = Playlist.find params["playlist_id"]
  	song = playlist.songs.create(params["song"])
    redirect_to root_path
  end

  def update
    render json: Song.update(params[:id], params.slice(:name, :votes))
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
