class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :polarity, :presence => true
  validates :votable_type, :presence => true
  validates :votable_id, :presence => true
end
