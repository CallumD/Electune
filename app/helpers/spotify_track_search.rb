class SpotifyTrackSearch

require 'open-uri'
require 'json'

SEARCH_URL='http://ws.spotify.com/search/1/track.json?q=#{search_term}'
TRACKS='tracks'
NAME='name'
LENGTH='length'
TIME_FORMAT='%m:%S'
ALBUM='album'
HREF='href'
ARTISTS='artists'
RELEASED='released'

  def self.perform_search search_term
    service_result = get_service_response
    tracks = service_result[TRACKS].map do |service_track|
      track = Track.new(name: data[NAME], length: Time.at(data[LENGTH]).utc.strftime(TIME_FORMAT),
      spotify_link: data[HREF])

      track.album = Album.new(name: data[ALBUM][NAME], release_date: data[ALBUM][RELEASED],
      spotify_link: data[ALBUM][HREF])

      track.artists = data[ARTISTS].map do |artist|
          Artist.new(track_artist.name = artist[NAME],
          track_artist.spotify_link = artist[HREF])
      end
      track
    end
  end

  private
    def get_service_responce
      JSON.parse(open(SEARCH_URL).read)
    end
end
