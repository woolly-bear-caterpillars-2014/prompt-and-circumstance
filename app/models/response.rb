class Response < ActiveRecord::Base
  belongs_to :prompt
  belongs_to :user
  has_many :votes, :as => :votable

  validates :body, presence: true
end
