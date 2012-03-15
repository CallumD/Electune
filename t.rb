require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc =  Nokogiri::HTML(open('http://ws.audioscrobbler.com/2.0/?method=track.search&api_key=b25b959554ed76058ac220b7b2e0a026&track=Stef'))

doc.css('track').each do |track|
  p track.at_css('name').content  
  p track.at_css('artist').content
end
