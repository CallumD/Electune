class PlaylistsController < ApplicationController
  before_action :signed_in_user, only: :show

  def index
    @playlists = Playlist.all
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end

  def current
    @playlist = Playlist.find params[:id]
    @playlist.shift unless @playlist.first_play
    @playlist.update_attributes(first_play: false)
  end

  def show
    @playlist = Playlist.find params[:id]
    @playlist_item = PlaylistItem.new
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @playlist }
    end
  end
end
