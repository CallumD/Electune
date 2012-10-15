class PlaylistController < ApplicationController
  # GET /playlist
  # GET /playlist.json
  def index
    @playlist = Playlist.find_by_name "Default"
    @song = Song.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlist }
    end
  end
end
