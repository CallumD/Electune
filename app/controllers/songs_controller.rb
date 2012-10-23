class SongsController < ApplicationController
  def create
  	playlist = Playlist.find params["playlist_id"]
    render json: playlist.songs.create(params.slice(:name, :votes))
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
