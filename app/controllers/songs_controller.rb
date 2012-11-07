class SongsController < ApplicationController

  before_filter :signed_in_user

  def create
  	playlist = Playlist.find params["playlist_id"]
  	@song = playlist.songs.create(params["song"])
  end

  def upvote
    @song = Song.find params[:id]
    @song.upvote session[:user_id]
  end

  def veto
		@song = Song.find params[:id]
		@song.veto session[:user_id]
	end
end
