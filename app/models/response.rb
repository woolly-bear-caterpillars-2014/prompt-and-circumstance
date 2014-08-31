class Response < ActiveRecord::Base
  belongs_to :prompt
  belongs_to :user
  has_many :votes, :as => :votable

  validates :body, presence: true

  def upvote(vote)
  	increment(:score, vote.polarity)
 	save
  end

  def set_score
  	self.score ||= 0
  end
  
end
