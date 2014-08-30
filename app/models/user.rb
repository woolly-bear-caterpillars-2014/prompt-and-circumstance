class User < ActiveRecord::Base
  has_many :prompts
  has_many :responses
  has_many :votes
  has_secure_password

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false  }
  validates :password, length: { minimum: 6 }
  validates :name, presence: true

end
