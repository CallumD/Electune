class PlaylistController < ApplicationController
  # GET /playlist
  # GET /playlist.json
  def index
    @playlists = Playlist.all

    @playlist = Playlist.new 
    @playlist.name = "hello world playlist"
    @playlist.songs = Array.new
    
    song = Song.new 

    @playlist.songs << song
    @playlist.songs << song

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlist }
    end
  end

end
