class PlaylistItemsController < ApplicationController
  before_action :signed_in_user

  def index
    @playlist = Playlist.find(params[:playlist_id])
    if params[:search].present?
      begin
        @playlist_items = Song.where('name like ?', "%#{params[:search]}%")
      rescue OpenURI::HTTPError => e
        render action: 'service_error'
      end
    elsif params[:artist].present?
      begin
        @artists = SpotifySongSearch.perform_search_by_artist(params[:artist])
        render action: 'artist'
      rescue OpenURI::HTTPError => e
        render action: 'service_error'
      end
    end
  end

  def artist_lookup
    @playlist = Playlist.find(params[:playlist_id])
    begin
      @albums = SpotifySongSearch.perform_lookup_by_artist(params[:link])
    rescue OpenURI::HTTPError => e
      render action: 'service_error'
    end
  end

  def album_lookup
    @playlist = Playlist.find(params[:playlist_id])
    begin
      @playlist_items = SpotifySongSearch.perform_lookup_by_album(params[:link])
      render action: 'index'
    rescue OpenURI::HTTPError => e
      render action: 'service_error'
    end
  end

  def create
    @playlist = Playlist.find params['playlist_id']
    @playlist_item = @playlist.playlist_items.create(song: Song.find(params[:id]), user: User.find(session[:user_id]))
    @playlist.update_attributes(start_time: Time.current) if @playlist.playlist_items.count == 1
  end

  def upvote
    @playlist_item = PlaylistItem.find params[:id]
    @playlist_item.upvote session[:user_id]
  end

  def veto
    @playlist_item = PlaylistItem.find params[:id]
    @playlist_item.veto session[:user_id]
  end
end
