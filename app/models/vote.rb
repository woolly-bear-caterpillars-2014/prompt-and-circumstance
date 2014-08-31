class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :polarity, :presence => true, :inclusion => { :in => -1..1}
  validates :votable_type, :presence => true
  validates :votable_id, :presence => true
  validates :user_id, :presence => { message: "must be logged in to vote" }

  validate :check_against_duplicates

  def check_against_duplicates
    duplicates = Vote.where(
      user: user_id,
      votable_id: votable_id,
      votable_type: votable_type
    ).reject { |vote| vote == self }

    if duplicates.present?
      errors.add(:error!, "What are you trying to do you dirty vote scammer??")
    end
  end
end
