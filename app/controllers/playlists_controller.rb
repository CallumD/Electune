class PlaylistsController < ApplicationController
  before_filter :signed_in_user, only: :show

  def index
  @playlists = Playlist.all
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end

  def current
    @playlist = Playlist.find(params[:id])
    @current_time = @playlist.playlist_items.empty? ? 0 : seconds_to_mins(@playlist.tick)
  end

  def show
    @playlist = params[:id].present? ? Playlist.find(params[:id]) : Playlist.all.first
    @playlist_item = PlaylistItem.new
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @playlist }
    end
  end
end
