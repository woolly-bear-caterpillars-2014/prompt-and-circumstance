class Response < ActiveRecord::Base
  belongs_to :prompt
  belongs_to :user
  has_many :votes, :as => :votable

  validates :body, presence: true
  validates :user_id, presence: true
  validates :prompt_id, presence: true
end
