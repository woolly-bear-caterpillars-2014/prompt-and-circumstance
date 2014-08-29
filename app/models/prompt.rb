class Prompt < ActiveRecord::Base
  has_many :responses

  validates :title, presence: true
  validates :description, presence: true

end
