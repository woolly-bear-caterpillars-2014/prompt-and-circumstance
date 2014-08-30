require 'rails_helper'

describe VotesController do

  let(:prompt) { FactoryGirl.create(:prompt) }
  let(:user) { FactoryGirl.create(:user) }

  context 'votes on prompt' do
    it 'creates new vote on specified prompt with supplied session id' do
      user
      prompt
      session[:user_id] = user.id
      expect{
        post :createPromptVote,
          :vote => {
          :polarity => 1,
          :votable_id => prompt.id
        }
      }.to change{ Vote.all.count }.by(1)
    end

  end

end


