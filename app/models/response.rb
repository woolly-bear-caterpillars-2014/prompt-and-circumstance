class Response < ActiveRecord::Base
  belongs_to :prompt

  validates :body, presence: true
end
