class PlaylistItemsController < ApplicationController

  before_filter :signed_in_user

  def index
    @playlist = Playlist.find(params[:playlist_id])
    @playlist_items = SpotifySongSearch.perform_search(params[:search]).slice(0,20) unless params[:search].nil?
  end

  def create
    @playlist = Playlist.find params["playlist_id"]
    @playlist_item = @playlist.playlist_items.create(song: Song.find(params[:id]), user: User.find(session[:user_id]))
    @playlist.update_attributes(start_time: Time.now) if @playlist.playlist_items.count == 1
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
