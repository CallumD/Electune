class PlaylistsController < ApplicationController
  before_filter :signed_in_user

  def index
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
