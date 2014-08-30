class Prompt < ActiveRecord::Base
  has_many :responses
  has_many :votes, :as => :votable
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  def short_description
    return description.length < 100 ? description : description[0..100] + "..."
  end
end
