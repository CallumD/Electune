class User < ActiveRecord::Base
  extend ActiveRandom

  has_secure_password

  has_many :upvotements, foreign_key: 'upvoter_id', dependent: :destroy
  has_many :upvoted_playlist_items, through: :upvotements, source: :playlist_item
  has_many :vetoments, foreign_key: 'vetoer_id', dependent: :destroy
  has_many :vetoed_playlist_items, through: :vetoments, source: :playlist_item

  before_save { email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
