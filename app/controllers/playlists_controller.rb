class PlaylistsController < ApplicationController
  # GET /playlist
  # GET /playlist.json
  def index 
  
  end
  
  def show
    @playlist = Playlist.find params[:id]
    @song = Song.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlist }
    end
  end
end
