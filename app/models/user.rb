class User
  include Mongoid::Document
  include ActiveModel::SecurePassword 

  field :email, type: String
  field :password_digest, type: String

  has_secure_password
  attr_accessible :email, :password, :password_confirmation

  has_many :upvotements
  has_many :vetoments

  before_save { self.email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def vetoed_playlist_items
    Vetoment.where(vetoer_id: self._id).map(&:playlist_item)
  end

  def upvoted_playlist_items
    Upvotement.where(upvoter_id: self._id).map(&:playlist_item)
  end

  def self.find_by_email(email)
    where(:email => email).first
  end
end
