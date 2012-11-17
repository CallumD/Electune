class Album
  require 'hash_initializer'
  include HashInitializer

  attr_accessor :name, :release_date, :spotify_link
end
