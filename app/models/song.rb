class Song
  require 'hash_initializer'
  include HashInitializer

  attr_accessor :name, :length, :spotify_link, :album, :artists
end
