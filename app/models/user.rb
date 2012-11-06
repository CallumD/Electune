class User < ActiveRecord::Base

  has_secure_password
  attr_accessible :email, :password, :password_confirmation

  has_many :upvotements, foreign_key: "upvoter_id", dependent: :destroy
  has_many :upvoted_songs, through: :upvotements, source: :song

  before_save { self.email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end
