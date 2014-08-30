class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :polarity, :presence => true, :inclusion => { :in => -1..1}
  validates :votable_type, :presence => true
  validates :votable_id, :presence => true


  def self.check_against_duplicates(user, vote)
    counterfeit = Vote.where(user: user.id, votable_id: vote.votable_id, votable_type: vote.votable_type)
    if counterfeit.empty?
      vote.save
    else
      false
    end
  end


end
