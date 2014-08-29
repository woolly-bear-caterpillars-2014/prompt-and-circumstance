class User < ActiveRecord::Base
  has_many :prompts
end
