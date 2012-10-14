class PlaylistController < ApplicationController
  # GET /playlist
  # GET /playlist.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

end
