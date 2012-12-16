require 'rubygems'
require 'daemons'

Daemons.run(File.expand_path('../auto_shift_playlist.rb', __FILE__))
