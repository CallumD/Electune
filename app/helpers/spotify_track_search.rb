class SpotifyTrackSearch

require 'open-uri'
require 'json'

  def self.perform_search search_term
    service_result = JSON.parse(open("http://ws.spotify.com/search/1/track.json?q=#{search_term}").read)
    tracks = service_result["tracks"].map do |service_track|
      track = build_track_from_track_data service_track
      track.album = build_album_from_track_data service_track
      track.artists = build_artists_from_track_data service_track
      track
    end
  end

  private
    def self.build_track_from_track_data data
      track = Track.new
      track.name = data["name"]
      track.length = Time.at(data["length"]).utc.strftime("%m:%S")
      track.spotify_link = data["href"]
      track
    end

    def self.build_album_from_track_data data
      album_data = data["album"]
      album = Album.new
      album.name = album_data["name"]
      album.release_date = album_data["released"]
      album.spotify_link = album_data["href"]
    end

    def self.build_artists_from_track_data data
      artists = data["artists"]
      track_artists = artists.map do |artist|
          track_artist = Artist.new
          track_artist.name = artist["name"]
          track_artist.spotify_link = artist["href"]
          track_artist
      end
    end
end
