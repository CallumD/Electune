class PlaylistsController < ApplicationController
  before_filter :signed_in_user, only: :show

  def index
  @playlists = Playlist.all
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end

  def current
    @playlist = Playlist.find params[:id]
    if Time.now > playlist.start_time + playlist.playlist_items.first.song.length
     #playlist.start_time = playlist.start_time + playlist.playlist_items.first.song.length
     #playlist.pop
    end
     #time = Time.now - playlist.start_time (in a nice format)
  end

  def show
    @playlist = Playlist.find params[:id]
    @playlist_item = PlaylistItem.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlist }
    end
  end
end
