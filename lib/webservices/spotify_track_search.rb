require 'open-uri'
require 'json'

search_term="thriller"

service_result = JSON.parse(open("http://ws.spotify.com/search/1/track.json?q=#{search_term}").read)

tracks = []

service_result["tracks"].each do |track|

album = track["album"]
album_name = album["name"]
album_release_date = album["released"]
album_spotify_link = album["href"]

track_name = track["name"]
track_length = Time.at(track["length"]).utc.strftime("%M:%S")
track_spotify_link = track["href"]

artists = track["artists"]

track_artists = []
artists.each do |artist|
  track_artist = TrackArtist.new
  track_artist.artist_name = artist["name"]
  track_artist.artist_spotify_link = artist["href"]
  track_artists << track_artist
end

end
