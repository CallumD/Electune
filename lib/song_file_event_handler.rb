require 'mp3info'

class SongFileEventHandler
  def added(files)
    files.each do |filename|
      ActiveRecord::Base.transaction do
        Mp3Info.open(filename) do |mp3|
          album = create_album(mp3.tag['album'], mp3.tag['year'])
          artists = create_artists(mp3.tag['artist'])
          create_song(filename, album, artists, mp3.length, mp3.tag['title'])
        end
      end
    end
  end

  def removed(files)
    ActiveRecord::Base.transaction do
      files.each do |filename|
        Song.where(link: filename).destroy_all
      end
    end
  end

  def create_artists(artists)
    artists.split(',').map { |artist| Artist.where(name: artist).first_or_create }
  end

  def create_song(link, album, artists, length, name)
    song = Song.where(
      name: name,
      album: album
    ).first_or_create

    song.length = length
    song.link = link
    song.artists = artists
    song.save!
  end

  def create_album(album, year)
    Album.where(name: album, release_date: Time.utc(year, 1, 1)).first_or_create
  end
end
