class User < ActiveRecord::Base
  has_many :prompts
  has_many :responses
end
