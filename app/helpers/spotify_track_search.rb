module SpotifyTrackSearch

require 'open-uri'
require 'json'
require_relative '../../app/models/track'
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
    service_result[TRACKS].map { |service_track| build_track_from_hash service_track }
  end

  private
    def self.build_track_from_hash data
      track = Track.new(name: data[NAME], length: Time.at(data[LENGTH]).utc.strftime(TIME_FORMAT),
      spotify_link: data[HREF])
      track.album = Album.new(name: data[ALBUM][NAME], release_date: data[ALBUM][RELEASED],
      spotify_link: data[ALBUM][HREF])
      track.artists = data[ARTISTS].map { |artist| build_artist_from_hash artist }
      track
    end


    def self.build_artist_from_hash artist
      Artist.new(name: artist[NAME],
          spotify_link: artist[HREF])
    end

    def self.get_service_response search_term
      JSON.parse(open(SEARCH_URL + %q{search_term}).read)
    end
end
