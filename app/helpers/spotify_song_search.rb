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
	  @albums = []
    @artists = []
    @songs = []
    service_result = get_service_response search_term
    service_result[TRACKS].map { |service_song| build_song_from_hash service_song }

    @albums.uniq!{|album| album.spotify_link}
    @artists.uniq!{|artist| artist.spotify_link}
    @songs.uniq!{|song| song.spotify_link}

    Album.transaction do
			@albums.each do |album|
				album.save if album.new_record?
			end
		end

		Artist.transaction do
			@artists.each do |artist|
				artist.save if artist.new_record?
			end
		end

		Song.transaction do
			@songs.each do |song|
				song.save if song.new_record?
			end
		end
		@songs
  end

  private
    def self.build_song_from_hash data
      song = Song.find_or_initialize_by_spotify_link(name: data[NAME], length: Time.at(data[LENGTH]).utc.strftime(TIME_FORMAT), spotify_link: data[HREF])
      song.album = Album.find_or_initialize_by_spotify_link(name: data[ALBUM][NAME], release_date: data[ALBUM][RELEASED],
      spotify_link: data[ALBUM][HREF])
      @albums << song.album
      song.artists = data[ARTISTS].map { |artist| build_artist_from_hash artist }
      @artists << song.artists
      @songs << song
    end


    def self.build_artist_from_hash artist
      Artist.find_or_initialize_by_spotify_link(name: artist[NAME],
          spotify_link: artist[HREF])
    end

    def self.get_service_response search_term
      Rails.logger.info('Running search: ' + SEARCH_URL + %Q{'#{search_term}'})
      JSON.parse(open(URI::escape(SEARCH_URL + %Q{'#{search_term}'})).read)
    end
end
