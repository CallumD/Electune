require 'rubygems'
require 'daemons'

namespace 'auto_shift' do
  desc 'run auto shift in the foreground'
  task :run do
    Daemons.run(File.expand_path('../../daemons/auto_shift_playlist.rb', __FILE__), ARGV: ['run'])
  end
  desc 'run auto shift daemonized in the background'
  task :start do
    puts 'started running shift daemonized'
    Daemons.run(File.expand_path('../../daemons/auto_shift_playlist.rb', __FILE__), ARGV: ['start'])
  end
  desc 'stop running auto shift daemonized in the background'
  task :stop do
    Daemons.run(File.expand_path('../../daemons/auto_shift_playlist.rb', __FILE__), ARGV: ['stop'])
  end
end
