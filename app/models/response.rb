class Response < ActiveRecord::Base
  belongs_to :prompt
  belongs_to :user
  has_many :votes, :as => :votable

  validates :body, presence: true
  validates :user_id, presence: true
  validates :prompt_id, presence: true


  before_create :set_score


  def upvote(vote)
  	increment(:score, vote.polarity)
 		save
  end

  def set_score
  	self.score ||= 0
  end


