module SpotifySongSearch

require 'open-uri'
require 'json'
require_relative '../../app/models/song'
require_relative '../../app/models/album'
require_relative '../../app/models/artist'

SEARCH_URL='http://ws.spotify.com/search/1/track.json?q='
TRACKS='tracks'
NAME='name'
LENGTH='length'
TIME_FORMAT='%m:%S'
ALBUM='album'
HREF='href'
ARTISTS='artists'
RELEASED='released'

  def self.perform_search search_term
    service_result = get_service_response search_term
    service_result[TRACKS].map { |service_song| build_song_from_hash service_song }
  end

  private
    def self.build_song_from_hash data
      @song = Song.find_by_spotify_link(data[HREF]) || Song.create!(name: data[NAME], length: Time.at(data[LENGTH]).utc.strftime(TIME_FORMAT), spotify_link: data[HREF])
      @song.album = Album.find_by_spotify_link(data[ALBUM][HREF]) || Album.create!(name: data[ALBUM][NAME], release_date: data[ALBUM][RELEASED],
      spotify_link: data[ALBUM][HREF])
      data[ARTISTS].map { |artist| build_artist_from_hash artist, @song }
      @song
    end


    def self.build_artist_from_hash artist, song
      artist = Artist.find_by_spotify_link(artist[HREF]) || Artist.create!(name: artist[NAME],
          spotify_link: artist[HREF])
      song.artists << artist unless song.artists.include? artist
      song.save
    end

    def self.get_service_response search_term
      Rails.logger.info('Running search: ' + SEARCH_URL + %Q{'#{search_term}'})
      JSON.parse(open(URI::escape(SEARCH_URL + %Q{'#{search_term}'})).read)
    end
end
