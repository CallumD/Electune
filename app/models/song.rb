class Song
  include Mongoid::Document
  field :name, type: String
  field :length, type: BigDecimal
  field :spotify_link, type: String
  belongs_to :album
  has_many :performers

  attr_accessible :length, :name, :spotify_link

  validates_format_of :name, :with => /(\w)+/i
  validates_uniqueness_of :spotify_link
  
  def artists
    performers.map(&:artist)
  end

  def artists=(artists)
    artists.each do |artist|
      performers.create(artist: artist)
    end
  end
end
