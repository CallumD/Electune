class PlaylistItemsController < ApplicationController

  require File.expand_path('../../../lib/playlist_stack_job', __FILE__)

  before_filter :signed_in_user

  def index
    @playlist = Playlist.find(params[:playlist_id])
    @playlist_items = SpotifySongSearch.perform_search(params[:search]).slice(0,20) unless params[:search].nil?
  end

  def create
     playlist = Playlist.find params["playlist_id"]
     @playlist_item = playlist.playlist_items.build()
     @playlist_item.song = Song.find(params[:id])
     @playlist_item.user = User.find session[:user_id]
     @playlist_item.save

    if playlist.count == 1
      playlist.start_time = Time.now
      Delayed::Job.enqueue PlaylistStackJob.new(playlist), Time.now + @playlist_item.song.length
    end
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
