class Prompt < ActiveRecord::Base
  has_many :responses
  has_many :votes, :as => :votable
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  before_create :set_score


  def update_score(vote)
    increment(:score, vote.polarity)
    save
  end

  def short_description
    description.length < 100 ? description : description[0..100] + "..."
  end

  private

  def set_score
    self.score ||= 0
  end

end
