class Prompt < ActiveRecord::Base
  has_many :responses
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

end
