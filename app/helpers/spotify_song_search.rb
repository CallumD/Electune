module SpotifySongSearch
  require 'open-uri'
  require 'json'
  require_relative '../../app/models/song'
  require_relative '../../app/models/album'
  require_relative '../../app/models/artist'

  TRACK_SEARCH_URL = 'http://ws.spotify.com/search/1/track.json?q='
  ARTIST_SEARCH_URL = 'http://ws.spotify.com/search/1/artist.json?q='
  TRACKS = 'tracks'
  ALBUMS = 'albums'
  ARTISTS = 'artists'
  NAME = 'name'
  LENGTH = 'length'
  ALBUM = 'album'
  ARTIST = 'artist'
  HREF = 'href'
  RELEASED = 'released'

  def self.perform_search(search_term)
    build_songs_from_results(get_service_response(search_term, TRACK_SEARCH_URL))
  end

  def self.perform_search_by_artist(search_term)
    build_artists_from_results(get_service_response(search_term, ARTIST_SEARCH_URL))
  end

  def self.perform_lookup_by_artist(artist_link)
    build_albums_from_lookup(get_url_response(build_artist_lookup_url(artist_link)))
  end

  def self.perform_lookup_by_album(album_link)
    build_songs_from_lookup(get_url_response(build_album_lookup_url(album_link)))
  end

  def self.build_songs_from_results(service_result)
    Song.transaction do
      service_result[TRACKS].reject! do |track|
        true unless track['album']['availability']['territories'].include? 'GB'
      end
      @songs = service_result[TRACKS].map { |service_song| build_song_from_hash service_song }
    end
    @songs
  end

  def self.build_songs_from_lookup(service_result)
    Song.transaction do
      @songs = []
      @songs = service_result[ALBUM][TRACKS].map { |service_song| build_song_only_from_hash service_song, service_result[ALBUM] } if service_result[ALBUM]['availability']['territories'].include? 'GB'
    end
    @songs
  end

  def self.build_artists_from_results(service_result)
    Artist.transaction do
      @artists = service_result[ARTISTS].map { |service_artist| build_artist_from_hash service_artist }
    end
    @artists
  end

  def self.build_albums_from_lookup(service_result)
    Album.transaction do
      service_result[ARTIST][ALBUMS].reject! do |album|
        true unless album[ALBUM]['availability']['territories'].include? 'GB'
      end
      @albums = service_result[ARTIST][ALBUMS].map { |service_album| build_album_from_hash service_album[ALBUM] }
    end
    @albums
  end

  def self.build_song_only_from_hash(data, album_data)
    song = Song.find_or_create_by(name: data[NAME], length: data[LENGTH], link: data[HREF])
    song.album = build_album_from_hash album_data
    song.artists = data[ARTISTS].map { |artist| build_artist_from_hash artist }
    song.save
    song
  end

  def self.build_song_from_hash(data)
    song = Song.find_or_create_by(name: data[NAME], length: data[LENGTH], link: data[HREF])
    song.album = build_album_from_hash data[ALBUM]
    song.artists = data[ARTISTS].map { |artist| build_artist_from_hash artist }
    song.save
    song
  end

  def self.build_album_from_hash(album)
    Album.find_or_create_by(name: album[NAME], release_date: album[RELEASED], link: album[HREF])
  end

  def self.build_artist_from_hash(artist)
    Artist.find_or_create_by(name: artist[NAME],
                             link: artist[HREF])
  end

  def self.get_service_response(search_term, search_url)
    JSON.parse(open(URI.escape(search_url + %('#{search_term}'))).read)
  end

  def self.get_url_response(url)
    JSON.parse(open(URI.escape(url)).read)
  end

  def self.build_artist_lookup_url(link)
    "http://ws.spotify.com/lookup/1/.json?uri=#{link}&extras=albumdetail"
  end

  def self.build_album_lookup_url(link)
    "http://ws.spotify.com/lookup/1/.json?uri=#{link}&extras=trackdetail"
  end
end
