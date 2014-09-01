class Prompt < ActiveRecord::Base
  has_many :responses
  has_many :votes, :as => :votable
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  before_create :set_score
  before_save :calculate_hotness

  def update_score(vote)
    increment(:score, vote.polarity)
    save
  end

  def short_description
    description.length < 100 ? description : description[0..100] + "..."
  end

  def calculate_hotness
    set_score
    # Get order (logarithmic - first 10 votes are as important as next 100)
    order = Math.log(score.abs < 1 ? 1 : score.abs)
    sign = case
           when score < 0 then -1
           when score > 0 then 1
           else 0
           end
    seconds = created_at.to_i
    self.hotness = (sign * order + seconds / 45000).round(7)
  end

  private

  def set_score
    self.score ||= 0
  end

end
