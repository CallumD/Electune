# The location for the embedded playlist media play audio source
Electune::Application.config.icecast_public_url = ENV['ICECAST_PUBLIC_URL'] ||
  'http://192.168.99.100:8000/stream'
